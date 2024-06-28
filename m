Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B24C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWo-0002kO-Gc; Fri, 28 Jun 2024 10:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWW-0002al-Fa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWC-0004VZ-25
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42565697036so11179555e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584635; x=1720189435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+eh+yGRfL9FJjfMdrxTEBsyJCPJ6c76a74QdscnKzw=;
 b=LSnra88GVpyA9smemR43nDSbSh5iiRLlet16FYlIJd6Qm9ToOPm6iX9OLkx+hcefCF
 wYfrMDk/Aj9anRivpXPG6Ttnom4szNNSRoiSjQUsfL28zTj3/DN0y94wOONtaM/4SGn0
 0HWW9Ww0QRF/kb194ypaejoJG88AirsFz1SFkEyj90dP5PK9EL+WIrjI/f1qwUD4utve
 36te+UBGhVXeBqMLTEKVBYxGmp82YXAnBfVHew4H8ma9DHj/6nBVX6Zj3Jr1M3iGKXx1
 5ZQmMQitmpfFpAGnqwliZgr9IhwTkWiq7wyeNEvtz+V4QBPtTDGs2QcxbBVCcwQV8hae
 BX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584635; x=1720189435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+eh+yGRfL9FJjfMdrxTEBsyJCPJ6c76a74QdscnKzw=;
 b=QNJAHusS4o+E8AfSLbDV6bK+3yuEFWcJBAFgykLkCLFQ00s+GPdHLqrEZLUjJlEVBw
 ymMKyeEtxxDtML1aqfIjs/MtVwpFsMIAZGr240tJv2K3P1KYCwMBwCVCfyfCY7EBdVx1
 K038mDfdGJRdCrq+Mj1AqhisX7kqcTEjymYMom6r8P0PxBNxEUvMtFNsCpm/tjpqRZLc
 3FH21KB71lwCPiAV7dtDOzZ9Osr+rBHPY3rGtJunbThkaR29ApyalguFPweu2Qwk4qRj
 nNcTYJi7FvH+Rtfjrv4fCA5PsKkoAkZZbPASTY03duP5WA/3umz/Nq3IOu/Kt/YhS1IV
 fcYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfSRqituvJ9XqtcmrYkuxUmmZWu+KGbf8lwMgldeBe6f+JJV6jyO+g2mEfSzVntZ/Od/imZTsBM7K6xBTmJHRtla8fHbM=
X-Gm-Message-State: AOJu0YzTEtqaPenxT/Mm7g6tVV3s+RntuPNhPzKUt/WWF/ujLuFk3ffp
 i7O5YVqR3Ck95H8Ob7V7kloeyL5QFhq9WfX84NWzwlp3Gu1iSIICm2ONRYMqn7g=
X-Google-Smtp-Source: AGHT+IE9YvNrVQ1Sp6/0F2w9paLrRfVPb5F6PuXHupLpEKrCn+fzXEpyr++rWttZn+pPOpjhl7sAGA==
X-Received: by 2002:a05:6000:154e:b0:367:42ce:f004 with SMTP id
 ffacd0b85a97d-36760aa2ec0mr1998473f8f.23.1719584634821; 
 Fri, 28 Jun 2024 07:23:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/9] target/arm: Support migration when FPSR/FPCR won't fit in
 the FPSCR
Date: Fri, 28 Jun 2024 15:23:42 +0100
Message-Id: <20240628142347.1283015-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To support FPSR and FPCR bits that don't exist in the AArch32 FPSCR
view of floating point control and status (such as the FEAT_AFP ones),
we need to make sure those bits can be migrated. This commit allows
that, whilst maintaining backwards and forwards migration compatibility
for CPUs where there are no such bits:

On sending:
 * If either the FPCR or the FPSR include set bits that are not
   visible in the AArch32 FPSCR view of floating point control/status
   then we send the FPCR and FPSR as two separate fields in a new
   cpu/vfp/fpcr_fpsr subsection, and we send a 0 for the old
   FPSCR field in cpu/vfp
 * Otherwise, we don't send the fpcr_fpsr subsection, and we send
   an FPSCR-format value in cpu/vfp as we did previously

On receiving:
 * if we see a non-zero FPSCR field, that is the right information
 * if we see a fpcr_fpsr subsection then that has the information
 * if we see neither, then FPSCR/FPCR/FPSR are all zero on the source;
   cpu_pre_load() ensures the CPU state defaults to that
 * if we see both, then the migration source is buggy or malicious;
   either the fpcr_fpsr or the FPSCR will "win" depending which
   is first in the migration stream; we don't care which that is

We make the new FPCR and FPSR on-the-wire data be 64 bits, because
architecturally these registers are that wide, and this avoids the
need to engage in further migration-compatibility contortions in
future if some new architecture revision defines bits in the high
half of either register.

(We won't ever send the new migration subsection until we add support
for a CPU feature which enables setting overlapping FPCR bits, like
FEAT_AFP.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 134 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0a722ca7e75..8c820955d95 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -18,6 +18,34 @@ static bool vfp_needed(void *opaque)
             : cpu_isar_feature(aa32_vfp_simd, cpu));
 }
 
+static bool vfp_fpcr_fpsr_needed(void *opaque)
+{
+    /*
+     * If either the FPCR or the FPSR include set bits that are not
+     * visible in the AArch32 FPSCR view of floating point control/status
+     * then we must send the FPCR and FPSR as two separate fields in the
+     * cpu/vfp/fpcr_fpsr subsection, and we will send a 0 for the old
+     * FPSCR field in cpu/vfp.
+     *
+     * If all the set bits are representable in an AArch32 FPSCR then we
+     * send that value as the cpu/vfp FPSCR field, and don't send the
+     * cpu/vfp/fpcr_fpsr subsection.
+     *
+     * On incoming migration, if the cpu/vfp FPSCR field is non-zero we
+     * use it, and if the fpcr_fpsr subsection is present we use that.
+     * (The subsection will never be present with a non-zero FPSCR field,
+     * and if FPSCR is zero and the subsection is not present that means
+     * that FPSCR/FPSR/FPCR are zero.)
+     *
+     * This preserves migration compatibility with older QEMU versions,
+     * in both directions.
+     */
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return (vfp_get_fpcr(env) & ~FPCR_MASK) || (vfp_get_fpsr(env) & ~FPSR_MASK);
+}
+
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
                      const VMStateField *field)
 {
@@ -25,7 +53,10 @@ static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
     CPUARMState *env = &cpu->env;
     uint32_t val = qemu_get_be32(f);
 
-    vfp_set_fpscr(env, val);
+    if (val) {
+        /* 0 means we might have the data in the fpcr_fpsr subsection */
+        vfp_set_fpscr(env, val);
+    }
     return 0;
 }
 
@@ -34,8 +65,9 @@ static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
+    uint32_t fpscr = vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(env);
 
-    qemu_put_be32(f, vfp_get_fpscr(env));
+    qemu_put_be32(f, fpscr);
     return 0;
 }
 
@@ -45,6 +77,86 @@ static const VMStateInfo vmstate_fpscr = {
     .put = put_fpscr,
 };
 
+static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val = qemu_get_be64(f);
+
+    vfp_set_fpcr(env, val);
+    return 0;
+}
+
+static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, JSONWriter *vmdesc)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    qemu_put_be64(f, vfp_get_fpcr(env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_fpcr = {
+    .name = "fpcr",
+    .get = get_fpcr,
+    .put = put_fpcr,
+};
+
+static int get_fpsr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+    uint64_t val = qemu_get_be64(f);
+
+    vfp_set_fpsr(env, val);
+    return 0;
+}
+
+static int put_fpsr(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, JSONWriter *vmdesc)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    qemu_put_be64(f, vfp_get_fpsr(env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_fpsr = {
+    .name = "fpsr",
+    .get = get_fpsr,
+    .put = put_fpsr,
+};
+
+static const VMStateDescription vmstate_vfp_fpcr_fpsr = {
+    .name = "cpu/vfp/fpcr_fpsr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vfp_fpcr_fpsr_needed,
+    .fields = (const VMStateField[]) {
+        {
+            .name = "fpcr",
+            .version_id = 0,
+            .size = sizeof(uint64_t),
+            .info = &vmstate_fpcr,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
+        {
+            .name = "fpsr",
+            .version_id = 0,
+            .size = sizeof(uint64_t),
+            .info = &vmstate_fpsr,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_vfp = {
     .name = "cpu/vfp",
     .version_id = 3,
@@ -100,6 +212,10 @@ static const VMStateDescription vmstate_vfp = {
             .offset = 0,
         },
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_vfp_fpcr_fpsr,
+        NULL
     }
 };
 
@@ -784,6 +900,20 @@ static int cpu_pre_load(void *opaque)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
+    /*
+     * In an inbound migration where on the source FPSCR/FPSR/FPCR are 0,
+     * there will be no fpcr_fpsr subsection so we won't call vfp_set_fpcr()
+     * and vfp_set_fpsr() from get_fpcr() and get_fpsr(); also the get_fpscr()
+     * function will not call vfp_set_fpscr() because it will see a 0 in the
+     * inbound data. Ensure that in this case we have a correctly set up
+     * zero FPSCR/FPCR/FPSR.
+     *
+     * This is not strictly needed because FPSCR is zero out of reset, but
+     * it avoids the possibility of future confusing migration bugs if some
+     * future architecture change makes the reset value non-zero.
+     */
+    vfp_set_fpscr(env, 0);
+
     /*
      * Pre-initialize irq_line_state to a value that's never valid as
      * real data, so cpu_post_load() can tell whether we've seen the
-- 
2.34.1


