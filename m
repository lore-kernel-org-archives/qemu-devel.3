Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E4FC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGph-00014F-9n; Thu, 02 Jul 2026 08:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfGpf-00013w-QM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:47:55 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfGpd-000594-RR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:47:55 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 80E3220B7167;
 Thu,  2 Jul 2026 05:47:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80E3220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782996470;
 bh=0kddJLDEX4DjKhg9Fx4xTOZSnvmi575AEC5qk6HMGsQ=;
 h=From:To:Cc:Subject:Date:From;
 b=UfsXAk02L8E5d4IJ8hfQ3tvsXTf5aks3iOcrDZrVTy9JNP06ILr/zsqdWt0IIBSBZ
 jzJ8MxLDvTrWJMC+UH5mnpfKzspWrdVGltOIJHA4oJYUsuXkQjZTpfA69eb21fgaRi
 N9N9JRdktUhpnGG6OZoCwKlV/SsmAgj3ZLqsbp1I=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] target/i386: Skip supervisor in xsave decompaction
Date: Thu,  2 Jul 2026 14:47:46 +0200
Message-Id: <20260702124746.450228-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Supervisor state should be skipped b/c there is no slot in standard
format XSAVE buffer for it. CET State is being migrated via MSRs and
other supervisor state isn't currently migrated.

Fixes: 8612deb3f4
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/cpu.h          |  2 ++
 target/i386/xsave_helper.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..fff701c6c4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -655,9 +655,11 @@ typedef enum X86Seg {
 
 #define XSTATE_DYNAMIC_MASK             (XSTATE_XTILE_DATA_MASK)
 
+#define ESA_FEATURE_XSS_BIT             0
 #define ESA_FEATURE_ALIGN64_BIT         1
 #define ESA_FEATURE_XFD_BIT             2
 
+#define ESA_FEATURE_XSS_MASK            (1U << ESA_FEATURE_XSS_BIT)
 #define ESA_FEATURE_ALIGN64_MASK        (1U << ESA_FEATURE_ALIGN64_BIT)
 #define ESA_FEATURE_XFD_MASK            (1U << ESA_FEATURE_XFD_BIT)
 
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 625bae103a..1fa3133b1a 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -332,7 +332,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
     size_t i;
     uint32_t eax, ebx, ecx, edx;
     uint32_t size, dst_off;
-    bool align64;
+    bool align64, supervisor;
     uint64_t guest_xcr0, *xstate_bv;
 
     compacted_xstate_bv = *(uint64_t *)(buf + XSAVE_XSTATE_BV_OFFSET);
@@ -383,6 +383,7 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
         size = eax;
         dst_off = ebx;
         align64 = (ecx & (1u << 1)) != 0;
+        supervisor = (ecx & ESA_FEATURE_XSS_MASK) != 0;
 
         /* Component is in the layout but unknown to the guest CPUID model */
         if (size == 0) {
@@ -433,8 +434,14 @@ int decompact_xsave_area(const void *buf, size_t buflen, CPUX86State *env)
             return -E2BIG;
         }
 
-        /* Copy components marked present in XSTATE_BV to guest model */
-        if (((compacted_xstate_bv >> i) & 1) != 0) {
+        /*
+         * Copy components marked present in XSTATE_BV to guest model.
+         *
+         * NB: Supervisor state is skipped b/c there is no slot in the
+         * standard format XSAVE buffer (CET state is migrated via MSRs,
+         * others supervisor state isn't migrated).
+         */
+        if (((compacted_xstate_bv >> i) & 1) != 0 && !supervisor) {
             memcpy(env->xsave_buf + dst_off, buf + xsave_offset, size);
         }
 
-- 
2.34.1


