Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B597FC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVP8-0004Fc-4L; Wed, 22 Jul 2026 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBi-00053c-4Z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:58 -0400
Received: from [140.205.0.212] (helo=out0-212.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBe-0001zT-C5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alibaba-inc.com; s=default;
 t=1784685291; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=uJFJTtrWslrw8h3cTu6pY6Z0UeLZ1jTx+Iymux4A9ok=;
 b=xvYloEu5KNUVK9mfeftwGDlHjU+UlK++npFnE7/E8H16NcWgB+mn3yllobcS0uqAmNK8yDEqsNe9QV1Gh9JAJSOGgwH+hkFWWIH7zVAvSoiLI8QbOpL2VLgIP7wQCarlaCq7yEaiSgcPLNDY+2ZL0PtFZPeVLE4Je+zmKVAdbjw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045220102;
 MF=zhengrong.lzr@alibaba-inc.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---.iRHeHsC_1784684976; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong.lzr@alibaba-inc.com
 fp:SMTPD_---.iRHeHsC_1784684976 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 22 Jul 2026 09:49:41 +0800
From: "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
To: qemu-devel@nongnu.org
Cc: <pbonzini@redhat.com>, <viktor.prutyanov@phystech.edu>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <zhao1.liu@intel.com>,
 "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
Subject: [PATCH 3/3] elf2dmp: fill ContextBuffer with faulting CPU context
Date: Wed, 22 Jul 2026 09:48:39 +0800
Message-ID: <20260722014840.36671-3-zhengrong.lzr@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
References: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 140.205.0.212 (deferred)
Received-SPF: pass client-ip=140.205.0.212;
 envelope-from=zhengrong.lzr@alibaba-inc.com; helo=out0-212.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When is_crash_occurred_cpu is set in QEMUCPUState (version > 1),
copy that CPU's context into WinDumpHeader64 ContextBuffer so
WinDbg opens on the faulting CPU instead of CPU 0.

Also extract KiBugCheckData from the guest kernel to populate
BugcheckCode and BugcheckParameters in the dump header.

Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
---
 contrib/elf2dmp/kdbg.h |  9 +++++++++
 contrib/elf2dmp/main.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
index 002e3d0cd5..15e4fb1140 100644
--- a/contrib/elf2dmp/kdbg.h
+++ b/contrib/elf2dmp/kdbg.h
@@ -195,4 +195,13 @@ typedef struct KDDEBUGGER_DATA64 {
     uint16_t OffsetPrcbContext;
 } KDDEBUGGER_DATA64;
 
+typedef struct KIBUGCHECK_INFO {
+    uint32_t BugcheckCode;
+    uint32_t unused0;
+    uint64_t BugcheckParameter1;
+    uint64_t BugcheckParameter2;
+    uint64_t BugcheckParameter3;
+    uint64_t BugcheckParameter4;
+} KIBUGCHECK_INFO;
+
 #endif /* KDBG_H */
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index a62abadcc0..302601065b 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -338,7 +338,7 @@ static bool fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
  * A dump may still contain valuable information even if it lacks contexts of
  * some CPUs due to dump corruption or a failure before starting CPUs.
  */
-static void fill_context(KDDEBUGGER_DATA64 *kdbg,
+static void fill_context(WinDumpHeader64 *hdr, KDDEBUGGER_DATA64 *kdbg,
                          struct va_space *vs, QEMU_Elf *qe)
 {
     int i;
@@ -373,6 +373,10 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
             eprintf("Failed to fill CPU #%d context\n", i);
             continue;
         }
+
+        if (s->version > 1 && s->is_crash_occurred_cpu) {
+            memcpy(hdr->ContextBuffer, &ctx, sizeof(ctx));
+        }
     }
 }
 
@@ -512,6 +516,7 @@ int main(int argc, char *argv[])
     uint64_t KdVersionBlock;
     bool kernel_found = false;
     OMFSignatureRSDS rsds;
+    uint64_t KiBugCheckData;
 
     if (argc != 3) {
         eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
@@ -611,7 +616,30 @@ int main(int argc, char *argv[])
         goto out_kdbg;
     }
 
-    fill_context(kdbg, &vs, &qemu_elf);
+    if (!SYM_RESOLVE(KernBase, &pdb, KiBugCheckData)) {
+        eprintf("Failed to get KiBugCheckData.\n");
+    } else {
+        KIBUGCHECK_INFO data = { 0 };
+        if (va_space_rw(&vs, KiBugCheckData, &data, sizeof(data), 0)) {
+            header.BugcheckCode = data.BugcheckCode;
+            header.BugcheckParameter1 = data.BugcheckParameter1;
+            header.BugcheckParameter2 = data.BugcheckParameter2;
+            header.BugcheckParameter3 = data.BugcheckParameter3;
+            header.BugcheckParameter4 = data.BugcheckParameter4;
+
+            printf("KiBugCheckData: 0x%016" PRIx64
+                   ", BugcheckCode: 0x%08x, Args:"
+                   " 0x%016" PRIx64 " 0x%016" PRIx64
+                   " 0x%016" PRIx64 " 0x%016" PRIx64 "\n",
+                    KiBugCheckData, header.BugcheckCode,
+                    data.BugcheckParameter1, data.BugcheckParameter2,
+                    data.BugcheckParameter3, data.BugcheckParameter4);
+        } else {
+            eprintf("Failed to va_space_rw KiBugCheckData.\n");
+        }
+    }
+
+    fill_context(&header, kdbg, &vs, &qemu_elf);
 
     if (!write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
-- 
2.43.0


