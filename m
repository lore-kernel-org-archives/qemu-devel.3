Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF62ACCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMNm-0007zR-DW; Mon, 27 Oct 2025 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNW-0007s7-4r; Mon, 27 Oct 2025 08:31:14 -0400
Received: from forward102d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.zhebryakov@yandex.ru>)
 id 1vDMNQ-0005GY-C2; Mon, 27 Oct 2025 08:31:12 -0400
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2dcb:0:640:715b:0])
 by forward102d.mail.yandex.net (Yandex) with ESMTPS id 0224AC01BD;
 Mon, 27 Oct 2025 15:30:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id nUbd1g4LwiE0-U3VZqJ7u; 
 Mon, 27 Oct 2025 15:30:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1761568254; bh=bPMnPeeBFpFY4Xe9n7lPZLYeTj8HS2ZblZJQfScrpLo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Wg7Fy25BxHqeQvVV3WhbVTrNtQzcYFKRY0jSe9jMlRG+ULrx82rhuz56np/8wc+zT
 nlkygqS9Zn5MFzZqRWSJGAJUzgwL79F71UZHCwuRmjTIrwJBGfE2wY58iXr2fTe3gQ
 J5saJwedh0H/tUHx7Mdde6p6pDidjtOlC8PtRuwU=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Danila Zhebryakov <d.zhebryakov@yandex.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Chinmay Rath <rathc@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Danila Zhebryakov <d.zhebryakov@yandex.ru>
Subject: [PATCH v4 4/4] target/ppc: fix GDB stub to work correctly with LE
 pages
Date: Mon, 27 Oct 2025 15:30:48 +0300
Message-ID: <20251027123049.32038-5-d.zhebryakov@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
References: <20251027123049.32038-1-d.zhebryakov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d102;
 envelope-from=d.zhebryakov@yandex.ru; helo=forward102d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

GDB is expected to be set to the endianness of the currently running code, which may be in LE page. Bswap the registers accordingly.

Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
---
 target/ppc/gdbstub.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c..89c783894c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -19,6 +19,8 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "accel/tcg/probe.h"
+#include "exec/tlb-flags.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "internal.h"
@@ -84,7 +86,20 @@ static int ppc_gdb_register_len(int n)
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
-    if (!FIELD_EX64(env->msr, MSR, LE)) {
+    bool le_page = false;
+
+    if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        CPUTLBEntryFull *full;
+        void *host;
+        int mmu_idx = ppc_env_mmu_index(env, true);
+
+        probe_access_full_mmu(env, env->nip, 0, MMU_INST_FETCH, mmu_idx,
+                              &host, &full);
+
+        le_page = full->tlb_fill_flags & TLB_BSWAP;
+    }
+
+    if (!le_page && !FIELD_EX64(env->msr, MSR, LE)) {
         /* do nothing */
     } else if (len == 4) {
         bswap32s((uint32_t *)mem_buf);
-- 
2.47.3


