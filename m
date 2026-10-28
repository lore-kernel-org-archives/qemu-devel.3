Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17201606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Wg-0006Jk-4k; Wed, 28 Oct 2026 15:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1xM9Wa-0006JK-PT; Wed, 28 Oct 2026 15:41:28 -0400
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1xM9WW-0007LE-NJ; Wed, 28 Oct 2026 15:41:28 -0400
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id C7B72C9296; Thu, 29 Oct 2026 04:41:20 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Thu, 29 Oct 2026 03:45:40 +0900
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, zakinko@snowrabbit.org
Subject: [PATCH] hw/ppc/spapr: Match the CAS PVR list terminator as PAPR
 requires
Message-Id: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
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
X-Archived-By: <archiver.kernel.org>

cas_check_pvr() stops at the first entry whose value has bits outside
its mask, before comparing that entry with the processor's PVR.  PAPR
has the PVR list processed "until either a List-entry allows the
process to continue, or the Terminator-list-entry has been processed",
and both of its "List-entry values of special interest", 0x00000000
0xFFFFFFFF ("matches any PVR value") and 0xFF000000 0x0FFFFFFF, are
terminators (B.6.2.3 in PAPR v10.60; the same text is in B.5.2.3 of
LoPAR 2.9 and B.6.2.3 of LoPAPR 1.1).  The terminator takes part in
the match like any other entry.

The check came after the comparison until commit 152ef803ceb1
("pseries: Rewrite CAS PVR compatibility logic") moved it in front.
That commit describes a change in how the compatibility mode is
chosen, not this one.

A client whose only entry for the processor is the terminator gets
"Couldn't negotiate a suitable PVR during CAS" today.  NetBSD's
ofwboot ends its list with 0xffff0000 0x0080ffff to cover Power10, and
fails on -cpu power10 this way.

Compare the entry first, and only then stop at a terminator.

Linux ends its list with a logical PVR that doubles as the terminator:
0xfffffffe 0x0f000001 (2.04 and earlier) in v6.1, and 0xfffffffd
0x0f000002 (2.05) now.  That entry now counts towards best_compat too.
Linux lists higher levels before it, so the result does not change:
with a Debian 6.1 kernel, explicit_match and best_compat came out the
same before and after on POWER8, POWER9 and Power10.

Fixes: 152ef803ceb1 ("pseries: Rewrite CAS PVR compatibility logic")
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 hw/ppc/spapr_hcall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 708902934c..29b726b474 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1151,10 +1151,6 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
         pvr = ldl_be_phys(&address_space_memory, *addr + 4);
         *addr += 8;
 
-        if (~pvr_mask & pvr) {
-            break; /* Terminator record */
-        }
-
         if ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask)) {
             explicit_match = true;
         } else {
@@ -1162,6 +1158,10 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
                 best_compat = pvr;
             }
         }
+
+        if (~pvr_mask & pvr) {
+            break; /* Terminator record */
+        }
     }
 
     if (explicit_match && kvm_enabled()) {
-- 
2.54.0 (Apple Git-157)


