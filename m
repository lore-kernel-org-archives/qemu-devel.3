Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F332606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmoV-00063R-Mo; Fri, 30 Oct 2026 09:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xMmoL-00060k-7J; Fri, 30 Oct 2026 09:38:26 -0400
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xMmoI-0007ak-JJ; Fri, 30 Oct 2026 09:38:24 -0400
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id 73B34C92D4; Fri, 30 Oct 2026 22:38:18 +0900 (JST)
Message-ID: <179336730662.79983.8981663569075755166.745-hid-v2@snowrabbit.org>
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH v2] target/ppc: Register the 745's HID0 and HID1 once
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org,
 Showta Ishizaki <zakinko@snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 30 Oct 2026 22:38:18 +0900 (JST)
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

init_proc_745(), which the 755 shares, calls register_7xx_sprs() and
then register_745_sprs().  Since HID0 and HID1 moved into
register_7xx_sprs(), both functions register them the same way, and
_spr_register() asserts that no SPR is registered twice, so the 745 and
the 755 cannot be created at all:

  $ qemu-system-ppc -M none -cpu 745
  Assertion failed: (spr->name == NULL), function _spr_register,
  file helper_regs.c, line 419.

Leave the two to register_7xx_sprs().

Fixes: 0301b39c78c8 ("target/ppc: cpu_init: Deduplicate 7xx SPR registration")
Cc: qemu-stable@nongnu.org
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
v2: Drop the comment saying where HID0 and HID1 are registered; keep
    the existing "Hardware implementation registers" line (BALATON Zoltan)

 target/ppc/cpu_init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7f3036d903e..b12ac630a6c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -87,16 +87,6 @@ static void register_745_sprs(CPUPPCState *env)
                  0x00000000);
 
     /* Hardware implementation registers */
-    spr_register(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_HID1, "HID1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
     spr_register(env, SPR_HID2, "HID2",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,

base-commit: 9703b6cf418d2ce72fae8d00e511135ce0bfda43

