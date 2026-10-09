Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9C9CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9iX-00046Y-Ai; Fri, 09 Oct 2026 08:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xF9iU-000469-QS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xF9iO-0005oT-N9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791548923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IlRFPulEvv4gxw8qLeuvVC9/42MWZHjH5BDoaOQOxlg=;
 b=isnSV+rXr6RSiHKSCrAaYSE6iGcBXlJRapeH+jxFLc8ybCum/uJ1z+3te9wPSWwH2aKZDJ
 sTJ1TZ6HrUiHAoijoqKhL8v3VkjX+1eT1O/YJpls2GMhHpdFayMPoxcitDHNSegimVlcnt
 x6junipEZrVX17l4LQeKFsc6xdVAHtU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-DhM4d-GvNe28ZFAfvaSfcQ-1; Fri, 9 Oct 2026 12:28:39 +0000
X-MC-Unique: DhM4d-GvNe28ZFAfvaSfcQ-1
X-Mimecast-MFC-AGG-ID: DhM4d-GvNe28ZFAfvaSfcQ_1791548918
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17ec7a49cso22512885e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791548918; x=1792153718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IlRFPulEvv4gxw8qLeuvVC9/42MWZHjH5BDoaOQOxlg=;
 b=MMzVCdp+FwKHH9SzfPW3ijyOVMGoIgmJ6VztXY+9FwDSHKAU0F2VPRDOzp2xfZWi4h
 PJ45KUPeUYB51sV3Kd+0bS6ENKAjSXdBEYjg8PHrCS+sPALDcP4Yt09EAoYKRN48bXL6
 3RgLPqvfmMcX0JX9sJRxuD9b9IH0RGTMEM+oKdSlTltwXQsYgI+sQ64W15Nw2+VWThT8
 sxKnsNK2d7K/e16KeJcO/ZBPhA2Dc7vmZNRg7NuNzhgi37WZyn2DeV88Mg1V8KmEiz2n
 rWfa6p7XAJrTti5L+9Cdx4IamU/L11xQGosCjl3pY27dDvtEW/43jPAv6RLG5hRY+ql/
 PPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548918; x=1792153718;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IlRFPulEvv4gxw8qLeuvVC9/42MWZHjH5BDoaOQOxlg=;
 b=w8Cnt81gvTuJq7cOvt8cXx+V9/zL1o9NPKHiXcfsKYvBeuson7k5J1H78khlA8i3Jc
 7vbli6DlBbuyPEbMsF/hFx33vw0nIskTl6P7mE08hakh0B9ri1nxiEBGZKVUzU8xtEUc
 3+EeDrNrnjk7LomW9CrrHxLY4eiju1pX8jBkmsTMH00eqqPsSjhJ1cYRiKZGurelppRM
 vIfygP1MArnxVpiG7CSWdeC1EuYfLXVUdj3qWDIrmeETrgaTYtr9WlgqUVQtOf+L9tNi
 7Ogy1sGRnabgZzmKB+BaNGu7DCOXqCu5WIgFtAfo0Hlw6HVY3E36JVocjqKs2OlsMw1X
 qfRQ==
X-Gm-Message-State: AFuF++mo6pvp4ef2VQiHDHNaMqWixBPrNSDu971YXS8sd4HECmI3WsOx
 7jxdBGjFh/pfr1eN0kc3icks4SfOV1vjMz/M8LTU6HkrMCBUj7Matzjv2103Ze6h+dT6UA6j+DI
 4ugtHrZEnpEcgOjxIRF36I9JoVgLRybP/Mz0mlqraaSt4cjHe9Zkccf5YBTb5NrAVfRyyK6w9Me
 SusNSs0EkH9x1wH/sewFCIXLP2sWz32mx7BK1uzQu2
X-Gm-Gg: AYBFou2y8rTVa2tSqvVbtaqmSbZlc//EYQC/OgMtPr2+B1FBpKkmY/k2ajBzMctW5pG
 bkCVmVD+58PnyLthkGcKGFXbyep/NthS5/DvBPbn/9QwpNnVViPZou6guUA6xPJPFcGRW0Gz3r6
 d/b+UkNE0Ao1mUWIpou7r2thcqBeSFnEt1fIIwhsI4e0qhmCUqLiubPPagQECFeLKPkfIS2ScXq
 RMlT11b13sH/aoFvKVuycnsuIJb3bXMa5nt/Ryq6jN7QwmlGUlRcyDY1Gun0CzKlIFQazqs3WHh
 dUoHjV5eE1m5qJa65ytlK2PYLEKBbdf3dmaobRXmh+DOYOaeKDihih4dcmcbyxm4Buiq/hz+lk0
 JbtWy8uiJenT+J8a7E8tiq4Hl6g8Xv6Vf/Lrz9atGEfHzxT9XtWYTfBY2pK+0C613SLT9uUsgnZ
 ozKtv1
X-Received: by 2002:a05:600c:6208:b0:4a1:698d:3042 with SMTP id
 5b1f17b1804b1-4a18e493143mr30749115e9.6.1791548916871; 
 Fri, 09 Oct 2026 05:28:36 -0700 (PDT)
X-Received: by 2002:a05:600c:6208:b0:4a1:698d:3042 with SMTP id
 5b1f17b1804b1-4a18e493143mr30747555e9.6.1791548915396; 
 Fri, 09 Oct 2026 05:28:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm81825805e9.4.2026.10.09.05.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:28:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>,
 Yuxuan Li <liyuxuan.darfux@bytedance.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Simon Scherer <scherer.simon89@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Andrey Polivoda <apolivodaa433@gmail.com>,
 Jordy Zomer <jordyzomer@google.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 00/32] target/i386 and misc changes for 2026-09-28
Date: Fri,  9 Oct 2026 14:28:32 +0200
Message-ID: <20261009122832.348427-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
j
  Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:

  agents: Add a skill for finding your way around QEMU (2026-10-02 11:11:37 +0200)

v1->v2: move validate_vex() before all operand decoding (patches 6-8)

----------------------------------------------------------------
* target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
* target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
* target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
* target/i386/tcg: implement APX
* target/i386: Migrate error code only with an exception
* agents: Add a skill for finding your way around QEMU
* tdx: fix buffer overflow in tdx_parse_panic_message
* accel/kvm: fixes

----------------------------------------------------------------

Artemii Mashanov (1):
      target/i386: fix EFLAGS reads in TCG plugin callbacks

Jakub Lipový (1):
      target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL

Maxim Levitsky (3):
      system: fix buffer overflow in tdx_parse_panic_message
      accel/kvm: protect kvm_resample_fd_list with a mutex
      accel/kvm: coalesced mmio: check lenght of the MMIO write entry

Paolo Bonzini (25):
      target/i386/tcg: compute C of CC_OP_ADOX without going through helper
      target/i386/tcg: extract validate_cr0_exceptions()
      target/i386/tcg: move validate_vex() before all operand decoding
      target/i386/tcg: clarify return value of decode_insn
      target/i386/tcg: ignore VEX.L for unary scalar instructions
      target/i386/tcg: JO/JNO can use flags directly if it is in CC_SRC
      target/i386/tcg: generalize zero- and sign-extension
      target/i386/tcg: use standard operand order for BSF and BSR
      target/i386/tcg: use zextT1 for CMPXCHG
      target/i386/tcg: unify MOVBE and BSWAP generators
      target/i386/tcg: add APX support to XSAVE/XRSTOR
      target/i386/tcg: add definition for REX2 prefix
      target/i386/tcg: mark XSAVE* as not allowing REX2
      target/i386/tcg: treat 0x0F as a prefix
      target/i386/tcg: decode REX2 prefix
      target/i386/tcg: implement JMPABS instruction
      target/i386/tcg: extend VEX.vvvv parsing for APX
      target/i386/tcg: decode EVEX prefix
      target/i386/tcg: add decode functionality for APX
      target/i386/tcg: implement CCMP/CTEST
      target/i386/tcg: decode APX instructions
      target/i386/tcg: optimize CCMP
      target/i386: extract computation of no-autoenable features
      target/i386/tcg: mark APX as supported
      agents: Add a skill for finding your way around QEMU

Simon Scherer (1):
      target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP

Yanfei Xu (1):
      target/i386: Migrate error code only with an exception

 configs/targets/x86_64-bsd-user.mak      |   2 +-
 configs/targets/x86_64-linux-user.mak    |   2 +-
 target/i386/cpu.h                        |  10 +-
 target/i386/helper.h                     |   1 +
 target/i386/tcg/decode-new.h             |  38 +-
 target/i386/tcg/tcg-cpu.h                |  18 +-
 target/i386/tcg/cc_helper_template.h.inc |  11 +
 accel/kvm/kvm-all.c                      |  26 +-
 hw/i386/pc.c                             |   1 -
 hw/intc/ioapic.c                         |   6 +-
 system/runstate.c                        |  36 +-
 target/i386/cpu.c                        |  46 +-
 target/i386/gdbstub.c                    |   3 +
 target/i386/helper.c                     |  11 +
 target/i386/machine.c                    |   2 +-
 target/i386/tcg/cc_helper.c              |  14 +
 target/i386/tcg/excp_helper.c            |   5 +
 target/i386/tcg/fpu_helper.c             |  63 ++-
 target/i386/tcg/seg_helper.c             |   4 +-
 target/i386/tcg/tcg-cpu.c                |   7 +-
 target/i386/tcg/translate.c              | 120 ++++-
 target/i386/tcg/decode-new.c.inc         | 898 +++++++++++++++++++++++++------
 target/i386/tcg/emit.c.inc               | 303 ++++++++++-
 .agents/skills/qemu-codebase/SKILL.md    |  59 ++
 .claude/skills                           |   1 +
 .gemini/skills                           |   1 +
 26 files changed, 1421 insertions(+), 267 deletions(-)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills
-- 
2.55.0

From 8d496d8f9fcea2199f6dc32f700d13b1d9ed3358 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jakub=20Lipov=C3=BD?= <lipovyjakub@tillia.cz>
Date: Tue, 18 Aug 2026 18:39:58 +0200
Subject: [PULL 01/32] target/i386/tcg: raise #GP(0) on null SS load with RPL
 != CPL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In 64-bit mode, loading a null selector into SS raises #GP(0) if CPL = 3,
or if CPL < 3 and CPL != RPL.  helper_load_seg() only implemented the
first case: the null-selector path never examined the selector's RPL, so
a null selector with non-zero RPL (such as 0x0003) loaded successfully at
CPL < 3.

This was caught by test_sreg() in kvm-unit-tests x86/emulator64.c, which
additionally fails its subsequent non-null check because the wrongly
succeeded load leaves 3 in SS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4204
Cc: qemu-stable@nongnu.org
Signed-off-by: Jakub Lipový <lipovyjakub@tillia.cz>
Link: https://lore.kernel.org/r/20260818164414.245189-1-lipovyjakub@tillia.cz
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 6d424349a58..cad19f9ca6b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1411,11 +1411,12 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
 
     selector &= 0xffff;
     cpl = env->hflags & HF_CPL_MASK;
+    rpl = selector & 3;
     if ((selector & 0xfffc) == 0) {
         /* null selector case */
         if (seg_reg == R_SS
 #ifdef TARGET_X86_64
-            && (!(env->hflags & HF_CS64_MASK) || cpl == 3)
+            && (!(env->hflags & HF_CS64_MASK) || cpl == 3 || cpl != rpl)
 #endif
             ) {
             raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -1439,7 +1440,6 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
         if (!(e2 & DESC_S_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, selector & 0xfffc, GETPC());
         }
-        rpl = selector & 3;
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (seg_reg == R_SS) {
             /* must be writable segment */
-- 
2.55.0


From 2c855818f7c05d12be6e238046e01cd8e4d4a732 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Sep 2026 09:12:17 +0200
Subject: [PULL 02/32] target/i386/tcg: compute C of CC_OP_ADOX without going
 through helper

With the CC_OP_ADOX cc_op, the carry flag remains in CC_SRC just like
with CC_OP_EFLAGS.  Add CC_OP_ADOX to the same gen_prepare_eflags_c
fast path as CC_OP_EFLAGS, to avoid generating a helper call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 192cf43215e..2da9a5a0b04 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -924,6 +924,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_EFLAGS:
+    case CC_OP_ADOX:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
         return (CCPrepare) { .cond = TCG_COND_TSTNE,
-- 
2.55.0


From fb024800d6ddfbc1aea926fbbd43fed6b8676510 Mon Sep 17 00:00:00 2001
From: Yanfei Xu <yanfei.xu@bytedance.com>
Date: Mon, 14 Sep 2026 19:38:17 +0800
Subject: [PULL 03/32] target/i386: Migrate error code only with an exception

An exception that carries an error code must retain it across migration.
Otherwise the destination reinjects it with error_code 0, which can make
the guest panic. Do not suppress this required state for old machine
types; an incompatible destination should abort migration instead.

The chance of stopping a vCPU while an exception is pending or injected
is extremely low, so the cpu/error_code subsection should rarely be
needed.

It is currently emitted much more often because KVM does not clear
has_error_code and error_code after completing exception injection.
Require a valid exception_nr before sending the subsection. This filters
stale KVM state while preserving the error code for a real exception.

Fixes: 1b80f1009d ("target/i386: add compat for migrating error code")
Cc: qemu-stable@nongnu.org
Reported-by: Yuxuan Li <liyuxuan.darfux@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Message-Id: <20260914113817.2212058-1-yanfei.xu@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 -
 hw/i386/pc.c          | 1 -
 target/i386/cpu.c     | 1 -
 target/i386/machine.c | 2 +-
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd0..4b9df1d3329 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2389,7 +2389,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b649f184de9..820164c47e0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,7 +85,6 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
-    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3bc6911c10..05d94cb46c6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10820,7 +10820,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
-    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8d69d7e25ef..b5c6b127c9c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
+    return cpu->env.exception_nr != -1 && cpu->env.has_error_code != 0;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.55.0


From e7ae490e0cf8c712fad6e39984a57a14e9cc400f Mon Sep 17 00:00:00 2001
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Sun, 13 Sep 2026 20:38:01 +0300
Subject: [PULL 04/32] target/i386: fix EFLAGS reads in TCG plugin callbacks

The plugin register API reads env->eflags through the gdbstub.
During TCG execution, arithmetic flags are kept in the lazy CC state
and DF in env->df, so this can return incorrect EFLAGS values.

Add eflags_in_tcg, set on TCG entry and cleared on exit, to select
cpu_compute_eflags() while the flags are split. Also synchronize cc_op
with gen_update_cc_op() before instruction callbacks when plugins are
enabled, since the current value may still be in the translator context.

Outside TCG execution, keep reading env->eflags, which holds the
complete flags. Unconditional reconstruction can use stale lazy state
and break GDB readback: in testing, writing 0x0202 through GDB was
followed by a readback of 0x0203.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1047061.html
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260913173801.96942-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 1 +
 target/i386/gdbstub.c       | 3 +++
 target/i386/tcg/tcg-cpu.c   | 2 ++
 target/i386/tcg/translate.c | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4b9df1d3329..3f69b0a066a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2357,6 +2357,7 @@ struct ArchCPU {
     CPUState parent_obj;
 
     CPUX86State env;
+    bool eflags_in_tcg;
     VMChangeStateEntry *vmsentry;
 
     uint64_t ucode_rev;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 5c5fa727216..e636ca0f4ae 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -151,6 +151,9 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         case IDX_IP_REG:
             return gdb_get_reg(env, mem_buf, env->eip);
         case IDX_FLAGS_REG:
+            if (cpu->eflags_in_tcg) {
+                return gdb_get_reg32(mem_buf, cpu_compute_eflags(env));
+            }
             return gdb_get_reg32(mem_buf, env->eflags);
 
         case IDX_SEG_REGS:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..2402608fe90 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -38,6 +38,7 @@ static void x86_cpu_exec_enter(CPUState *cs)
     env->df = 1 - (2 * ((env->eflags >> 10) & 1));
     CC_OP = CC_OP_EFLAGS;
     env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+    cpu->eflags_in_tcg = true;
 }
 
 static void x86_cpu_exec_exit(CPUState *cs)
@@ -46,6 +47,7 @@ static void x86_cpu_exec_exit(CPUState *cs)
     CPUX86State *env = &cpu->env;
 
     env->eflags = cpu_compute_eflags(env);
+    cpu->eflags_in_tcg = false;
 }
 
 static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2da9a5a0b04..70b0bda6932 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3484,6 +3484,9 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    if (dcbase->plugin_enabled) {
+        gen_update_cc_op(dc);
+    }
     dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
-- 
2.55.0


From 6d5fb14d36a6d11e88f04878021b2d99ce6c07e9 Mon Sep 17 00:00:00 2001
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Fri, 11 Sep 2026 12:58:11 +0200
Subject: [PULL 05/32] target/i386: Don't clear C1 for
 FCOMI/FCOMIP/FUCOMI/FUCOMIP

Commit 6802a4b23919 ("target/i386: clear C1 for all x87 compare
instructions") added an unconditional C1 clear to helper_fcomi_ST0_FT0()
and helper_fucomi_ST0_FT0(), based on the SDM listing "C1 Set to 0" under
FPU Flags Affected for FCOMI/FCOMIP/FUCOMI/FUCOMIP.

Testing on real x86-64 Intel and AMD hardware shows these instructions leave
C1 unchanged, unlike FCOM/FUCOM/FICOM. The SDM text appears to have been
carried over from the FCOM/FUCOM description.

Revert that part of the commit. The FCOM/FUCOM/FICOM changes are kept.

Fixes: 6802a4b23919 ("target/i386: clear C1 for all x87 compare instructions")
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260911105811.16854-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 54ff4fe3131..56d093da8c9 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -565,8 +565,6 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -579,8 +577,6 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.55.0


From 7660e69fc50de750bf6929c1eaead662feb890bb Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Sep 2026 10:41:55 +0200
Subject: [PULL 06/32] target/i386/tcg: extract validate_cr0_exceptions()

The checks on CR0.TS and CR0.EM must be done after all #UD checks,
so extract them to their own functions.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e3..cc44be8f909 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2742,23 +2742,35 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
         goto illegal;
     }
-
-    if (s->flags & HF_TS_MASK) {
-        goto nm_exception;
-    }
-    if (s->flags & HF_EM_MASK) {
-        goto illegal;
-    }
     return true;
 
-nm_exception:
-    gen_NM_exception(s);
-    return false;
 illegal:
     gen_illegal_opcode(s);
     return false;
 }
 
+/* Called after decode_ops, so that #UD for invalid encodings has priority over #NM.  */
+static bool validate_cr0_exceptions(DisasContext *s, X86DecodedInsn *decode)
+{
+    switch (decode->e.vex_class) {
+    case 0:
+    case 13:
+        return true;
+    default:
+        break;
+    }
+
+    if (s->flags & HF_TS_MASK) {
+        gen_NM_exception(s);
+        return false;
+    }
+    if (s->flags & HF_EM_MASK) {
+        gen_illegal_opcode(s);
+        return false;
+    }
+    return true;
+}
+
 static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
 {
     if (qemu_loglevel_mask(LOG_UNIMP)) {
@@ -3037,6 +3049,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     if (!decode_ops(s, env, decode_func, &decode)) {
         goto illegal_op;
     }
+    if (!validate_cr0_exceptions(s, &decode)) {
+        return;
+    }
 
     switch (decode.e.special) {
     case X86_SPECIAL_None:
-- 
2.55.0


From 142f9950a7257b863a889a74340536e1de025855 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Sep 2026 10:43:13 +0200
Subject: [PULL 07/32] target/i386/tcg: move validate_vex() before all operand
 decoding

Operand sizes are computed in decode_insn(), because s->rip_offset has to
be known before decode_modrm() computes a RIP-relative address.  However,
validate_vex() runs later and, for X86_VEX_REPScalar instructions, it must
be able to turn e->s2 into X86_SIZE_ss or X86_SIZE_sd in presence of a
memory operand.  But right now decode_op_size() has already run, and
therefore decode->op[2].ot stays MO_128; the instruction therefore
accesses 16 bytes of memory instead of 4 or 8.

The only user of s->rip_offset is decode_modrm(), which is called from
decode_ops(), so the size computation can move there, after validate_vex().
Thanks to the previous patch, the CR0.TS and CR0.EM checks come after
decode_ops(), so #UD for an invalid VEX.L still has priority over #NM.

This way, when validate_vex() adjusts the X86OpEntry, decode_op_size()
picks up the result.  This behaves as intended by commit b7d4ec4832d
("target/i386/tcg: move VEX validation early", 2026-08-26), and fixes
REPScalar instructions that have a memory operand.

This also applies to unary operations, which need to ignore VEX.L.
While this could also be fixed by using "dq" for the operand size, it
is untidy that simply setting "s->vex_l = 0" does not do the right thing.

Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
Reported-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cc44be8f909..9e1e230a824 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2478,9 +2478,13 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         e->decode(s, env, e, &decode->b);
     }
 
-    if (!validate_sse_prefix(s, e)) {
-        return false;
-    }
+    return validate_sse_prefix(s, e);
+}
+
+static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
+                       X86DecodedInsn *decode)
+{
+    X86OpEntry *e = &decode->e;
 
     /* Compute size of operands here in order to initialize s->rip_offset.  */
     if (e->op0 != X86_TYPE_None) {
@@ -2515,13 +2519,6 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         assert(e->op3 == X86_TYPE_I && e->s3 == X86_SIZE_b);
         s->rip_offset += 1;
     }
-    return true;
-}
-
-static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
-                       X86DecodedInsn *decode)
-{
-    X86OpEntry *e = &decode->e;
 
     if (e->op0 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[0], e->op0, decode->b)) {
-- 
2.55.0


From d04795a4418174ef58c025ada083626d67e08a63 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Sep 2026 11:39:38 +0200
Subject: [PULL 08/32] target/i386/tcg: clarify return value of decode_insn

It is clearer if decode_insn() returns whether a generator exists;
if it does not, the entry is empty and all other checks such as
validate_sse_prefix() or has_cpuid_feature() are moot.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9e1e230a824..25fe1cf2313 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2478,7 +2478,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         e->decode(s, env, e, &decode->b);
     }
 
-    return validate_sse_prefix(s, e);
+    return !!e->gen;
 }
 
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
@@ -2980,12 +2980,11 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     decode.cc_op = -1;
     decode.b = b;
     if (!decode_insn(s, env, decode_func, &decode)) {
-        goto illegal_op;
-    }
-    if (!decode.e.gen) {
         goto unknown_op;
     }
-
+    if (!validate_sse_prefix(s, &decode.e)) {
+        goto illegal_op;
+    }
     if (!has_cpuid_feature(s, decode.e.cpuid)) {
         goto illegal_op;
     }
-- 
2.55.0


From a5b4837a253ed3944dd7d4419c52830079e221ec Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Sep 2026 15:45:27 +0200
Subject: [PULL 09/32] target/i386/tcg: ignore VEX.L for unary scalar
 instructions

According to both Volume 2 of Intel 64 and IA-32 Architectures Software
Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
VEX.L is a "don't care" bit for `VROUNDSS`, `VROUNDSD`, `VMOVSS`, `VMOVSD`.

Currently, QEMU handles VEX.L with these instructions differently:
- In the VMOVSS and VMOVSD case, VEX.L allows to select the register size
  (XMM or YMM), leading to differences between QEMU and the real hardware.
- In `gen_VROUNDSS()` and `gen_VROUNDSD()`, there is an assert which checks
  that `s->vex_l` is not set. When either instruction is encountered with VEX.L
  bit set, the QEMU process crashes with an assertion failure.

These behaviors deviate from real hardware, and in VROUNDSS/VROUNDSD case,
it also allows unprivileged guest userspace to crash the QEMU process itself.
Instead, always handle the instructions as if VEX.L=0.

Reported-by: Andrey Polivoda <apolivodaa433@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  6 ++++++
 target/i386/tcg/decode-new.c.inc | 17 +++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 92822969003..25f7d2215ee 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -263,6 +263,12 @@ typedef enum X86VEXSpecial {
      * operands, and thus handled by decode_op_size.
      */
     X86_VEX_AVX2_256,
+
+    /*
+     * Instructions that do not care about VEX.L; used for scalar operands, because
+     * they *should* be used only with VEX.L=0 but may accept VEX.L=1 on some machines.
+     */
+    X86_VEX_LIG,
 } X86VEXSpecial;
 
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 25fe1cf2313..f1f8aef500c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -260,6 +260,7 @@
 #define svm(a) .intercept = SVM_EXIT_##a, .has_intercept = true,
 
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
+#define vex_lig .vex_special = X86_VEX_LIG,
 
 #define P_00          1
 #define P_66          (1 << PREFIX_DATA)
@@ -996,8 +997,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
      * For other unary operations such as VSQRTSx this is hidden by the "REPScalar"
      * value of vex_special, because the table lists the operand types of VSQRTPx.
      */
-    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 cpuid(SSE41) p_66),
-    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 cpuid(SSE41) p_66),
+    [0x0a] = X86_OP_ENTRY4(VROUNDSS,   V,x,  H,x, W,ss, vex3 vex_lig cpuid(SSE41) p_66),
+    [0x0b] = X86_OP_ENTRY4(VROUNDSD,   V,x,  H,x, W,sd, vex3 vex_lig cpuid(SSE41) p_66),
     [0x0c] = X86_OP_ENTRY4(VBLENDPS,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0d] = X86_OP_ENTRY4(VBLENDPD,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) p_66),
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
@@ -1053,8 +1054,8 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F10_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x,  vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5),
-        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5),
+        X86_OP_ENTRY3(VMOVSS_ld,  V,x,  H,x,       M,ss, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVSD_ld,  V,x,  H,x,       M,sd, vex5 vex_lig),
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -1076,8 +1077,8 @@ static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F11_mem[4] = {
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5),
-        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5), /* MOVSD */
+        X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex5 vex_lig),
+        X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex5 vex_lig), /* MOVSD */
     };
 
     if ((get_modrm(s, env) >> 6) == 3) {
@@ -2650,6 +2651,10 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case X86_VEX_None:
         break;
 
+    case X86_VEX_LIG:
+        s->vex_l = 0;
+        break;
+
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
-- 
2.55.0


From bbaed8eb5204edf9f4efd8a646cfe4902235555c Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Sep 2026 19:20:20 +0200
Subject: [PULL 10/32] target/i386/tcg: JO/JNO can use flags directly if it is
 in CC_SRC

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 70b0bda6932..060649315a6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -988,6 +988,10 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
         gen_compute_eflags(s);
+        /* fallthrough */
+
+    case CC_OP_EFLAGS:
+    case CC_OP_ADCX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_O };
     }
-- 
2.55.0


From b7f51182c08123eda612db553e2cded6e536ff49 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Tue, 22 Sep 2026 20:45:53 -0400
Subject: [PULL 11/32] system: fix buffer overflow in tdx_parse_panic_message

tdx_parse_panic_message has code that detects if the guest supplied
message contains some unprintable characters and in this case prints a hex dump.

The code has a bug: it allocates 3 bytes for 'sprintf("%02x ")',
but sprintf in this case actually writes at least 4 bytes, because it adds the NULL
terminator, or even 9 bytes if the char type is signed and the MSB is set.

To fix this, just use qemu_hexdump_line instead.

Reported-by: Jordy Zomer <jordyzomer@google.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3905
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004553.100732-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/runstate.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b625..56bfc5b07da 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -50,6 +50,7 @@
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
 #include "qemu/thread.h"
+#include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "system/cpu-timers.h"
@@ -760,10 +761,9 @@ static void qemu_system_wakeup(void)
     }
 }
 
-static char *tdx_parse_panic_message(char *message)
+static GString *tdx_parse_panic_message(char *message)
 {
     bool printable = false;
-    char *buf = NULL;
     int len = 0, i;
 
     /*
@@ -784,32 +784,11 @@ static char *tdx_parse_panic_message(char *message)
         }
     }
 
-    if (len == 0) {
-        buf = g_malloc(1);
-        buf[0] = '\0';
+    if (printable) {
+        return g_string_new(message);
     } else {
-        if (!printable) {
-            /* 3 = length of "%02x " */
-            buf = g_malloc(len * 3);
-            for (i = 0; i < len; i++) {
-                if (message[i] == '\0') {
-                    break;
-                } else {
-                    sprintf(buf + 3 * i, "%02x ", message[i]);
-                }
-            }
-            if (i > 0) {
-                /* replace the last ' '(space) to NULL */
-                buf[i * 3 - 1] = '\0';
-            } else {
-                buf[0] = '\0';
-            }
-        } else {
-            buf = g_strdup(message);
-        }
+        return qemu_hexdump_line(NULL, message, len, 1, 0);
     }
-
-    return buf;
 }
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
@@ -854,12 +833,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
         } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
-            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            g_autoptr(GString) message = tdx_parse_panic_message(info->u.tdx.message);
             qemu_log_mask(LOG_GUEST_ERROR,
                           "\nTDX guest reports fatal error."
                           " error code: 0x%" PRIx32 " error message:\"%s\"\n",
-                          info->u.tdx.error_code, message);
-            g_free(message);
+                          info->u.tdx.error_code, message->str);
             if (info->u.tdx.has_gpa) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
                               "can be found at gpa page: 0x%" PRIx64 "\n",
-- 
2.55.0


From 0f98b46846eb04791f5f4c992d3441c8a8b48872 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Tue, 22 Sep 2026 20:46:51 -0400
Subject: [PULL 12/32] accel/kvm: protect kvm_resample_fd_list with a mutex

Legacy PCI INTx interrupts are level triggered and can, in theory, be shared.

Upon receiving such an interrupt, VFIO kernel driver masks it in a generic way,
using INTX_DISABLE bit in the PCI config space.

It then waits for the guest to signal completion (EOI) of the interrupt,
upon which VFIO re-enables the interrupt.

The completion is signaled with another eventfd.

For split irqchip mode, KVM doesn't have a notion of EOI on IOAPIC level.
Instead it signals EOI with a userspace VM exit, KVM_EXIT_IOAPIC_EOI.

Upon receiving this VM exit, Qemu manually signals the above-mentioned eventfd.

The problem that this patch resolves is that QEMU keeps these eventfds in
a linked list without any locking to prevent the list from being corrupted by
concurrent access.

Such use is possible and guest triggerable if the guest rapidly toggles
INTX mode of a VFIO device and at the same time signals EOI with an arbitrary
vector.

Fix this by protecting this list (kvm_resample_fd_list) with a mutex.

This patch was only compile tested.

Reported-by: "Vulnerability Report" <vr@darknavy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3942
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004651.101197-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 14 +++++++++++++-
 hw/intc/ioapic.c    |  6 +++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a84..da3afdc68d8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -146,6 +146,7 @@ typedef struct KVMResampleFd KVMResampleFd;
 static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
     QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
 
+static QemuMutex kvm_resample_fd_list_lock;
 static QemuMutex kml_slots_lock;
 
 #define kvm_slots_lock()    qemu_mutex_lock(&kml_slots_lock)
@@ -157,6 +158,8 @@ static inline void kvm_resample_fd_remove(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             QLIST_REMOVE(rfd, node);
@@ -164,6 +167,8 @@ static inline void kvm_resample_fd_remove(int gsi)
             break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
@@ -173,20 +178,26 @@ static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
     rfd->gsi = gsi;
     rfd->resample_event = event;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
     QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 void kvm_resample_fd_notify(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             event_notifier_set(rfd->resample_event);
             trace_kvm_resample_fd_notify(gsi);
-            return;
+            break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 /**
@@ -2910,6 +2921,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
+    qemu_mutex_init(&kvm_resample_fd_list_lock);
 
     /*
      * On systems where the kernel can support different base page
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1b3f1e824ac..1932b14642f 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -248,7 +248,6 @@ void ioapic_eoi_broadcast(int vector)
                 continue;
             }
 
-#ifdef CONFIG_KVM
             /*
              * When IOAPIC is in the userspace while APIC is still in
              * the kernel (i.e., split irqchip), we have a trick to
@@ -264,8 +263,9 @@ void ioapic_eoi_broadcast(int vector)
              * operations below because we don't know whether there're
              * emulated devices that are using/sharing the same IRQ.
              */
-            kvm_resample_fd_notify(n);
-#endif
+            if (kvm_enabled()) {
+                kvm_resample_fd_notify(n);
+            }
 
             if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
                 continue;
-- 
2.55.0


From 12916d64b78ec5dd0171e607ad2ffcc34537f3cf Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Tue, 22 Sep 2026 20:46:31 -0400
Subject: [PULL 13/32] accel/kvm: coalesced mmio: check lenght of the MMIO
 write entry

KVM's coalesced mmio ring buffer has entries that contain deffered MMIO
writes.

Each such entry contains the length, an 8 byte value and a guest address.

While the length value comes from the kernel, it is still possible for
an attacker to corrupt the length field using another exploit.

The attacker can then invoke kvm_flush_coalesced_mmio_buffer, which blindly
trusts the length and can be used to inflict further damage.

Add a sanity check on the length field to prevent this.

This patch was only compile tested.

Reported by: "Labs, STAR" <info@starlabs.sg>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3863
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004631.100997-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index da3afdc68d8..5433a223e36 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3185,9 +3185,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
             const AddressSpace *as;
 
             ent = &ring->coalesced_mmio[ring->first];
-            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
-            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
-                                ent->data, ent->len);
+            if (ent->len > sizeof(ent->data)) {
+                warn_report("coalesced MMIO entry has invalid len %u",
+                            ent->len);
+            } else {
+                as = ent->pio == 1 ? &address_space_io : &address_space_memory;
+                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                    ent->data, ent->len);
+            }
+
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.55.0


From 988aa0dcfb55f36288202cc4c13e3048f62e6e72 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Sep 2026 13:36:09 +0200
Subject: [PULL 14/32] target/i386/tcg: generalize zero- and sign-extension

Allow applying sign and zero extension to T1 load and T0 writeback.
T1 load is useful for some cases where the tables are hacked to
put the sign extended operand in T0; T0 writeback is used for APX ZU
instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 15 +++++++++++----
 target/i386/tcg/decode-new.c.inc | 21 +++++++++++----------
 target/i386/tcg/emit.c.inc       | 16 ++++++++++------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 25f7d2215ee..1b5a91b4f46 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -148,6 +148,12 @@ typedef enum X86OpUnit {
     X86_OP_MMX,     /* address in either s->ptrX or s->A0 depending on has_ea */
 } X86OpUnit;
 
+typedef enum X86OpExt {
+    X86_EXT_None,
+    X86_EXT_Signed,
+    X86_EXT_Unsigned,
+} X86OpExt;
+
 typedef enum X86InsnCheck {
     /* Illegal or exclusive to 64-bit mode */
     X86_CHECK_i64 = 1,
@@ -226,10 +232,6 @@ typedef enum X86InsnSpecial {
      */
     X86_SPECIAL_MMX,
 
-    /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
-    X86_SPECIAL_SExtT0,
-    X86_SPECIAL_ZExtT0,
-
     /* Memory operand size of MOV from segment register is MO_16 */
     X86_SPECIAL_Op0_Mw,
 } X86InsnSpecial;
@@ -300,6 +302,10 @@ struct X86OpEntry {
     X86OpSize    s3:8;
 
     X86InsnSpecial special:8;
+    X86OpExt     ext0:2;
+    X86OpExt     ext1:2;
+    X86OpExt     ext2:2;
+    unsigned     :2;
     X86CPUIDFeature cpuid:8;
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
@@ -314,6 +320,7 @@ typedef struct X86DecodedOp {
     int8_t n;
     MemOp ot;     /* For b/c/d/p/s/q/v/w/y/z */
     X86OpUnit unit;
+    X86OpExt ext;
     bool has_ea;
     int offset;   /* For MMX and SSE */
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f1f8aef500c..4f620e749e3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -233,8 +233,12 @@
 #define op0_Rd .special = X86_SPECIAL_Op0_Rd,
 #define op2_Ry .special = X86_SPECIAL_Op2_Ry,
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
-#define sextT0 .special = X86_SPECIAL_SExtT0,
-#define zextT0 .special = X86_SPECIAL_ZExtT0,
+#define sextwT0 .ext0 = X86_EXT_Signed,
+#define zextwT0 .ext0 = X86_EXT_Unsigned,
+#define sextT0  .ext1 = X86_EXT_Signed,
+#define zextT0  .ext1 = X86_EXT_Unsigned,
+#define sextT1  .ext2 = X86_EXT_Signed,
+#define zextT1  .ext2 = X86_EXT_Unsigned,
 #define op0_Mw .special = X86_SPECIAL_Op0_Mw,
 #define btEvGv .special = X86_SPECIAL_BitTest,
 
@@ -1614,9 +1618,9 @@ static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group2_gen[op];
     if (op == 7) {
-        entry->special = X86_SPECIAL_SExtT0;
+        entry->ext1 = X86_EXT_Signed;
     } else {
-        entry->special = X86_SPECIAL_ZExtT0;
+        entry->ext1 = X86_EXT_Unsigned;
     }
 }
 
@@ -2525,16 +2529,19 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_f
         !decode_op(s, env, decode, &decode->op[0], e->op0, decode->b)) {
         return false;
     }
+    decode->op[0].ext = e->ext0;
 
     if (e->op1 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[1], e->op1, decode->b)) {
         return false;
     }
+    decode->op[1].ext = e->ext1;
 
     if (e->op2 != X86_TYPE_None &&
         !decode_op(s, env, decode, &decode->op[2], e->op2, decode->b)) {
         return false;
     }
+    decode->op[2].ext = e->ext2;
 
     if (e->op3 != X86_TYPE_None) {
         decode->immediate = insn_get_signed(env, s, MO_8);
@@ -3090,12 +3097,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 
-    case X86_SPECIAL_SExtT0:
-    case X86_SPECIAL_ZExtT0:
-        /* Handled in gen_load.  */
-        assert(decode.op[1].unit == X86_OP_INT);
-        break;
-
     case X86_SPECIAL_Op0_Mw:
         assert(decode.op[0].unit == X86_OP_INT);
         if (decode.op[0].has_ea) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c83ab809408..54dc23ca624 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -266,23 +266,21 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
 #endif
     case X86_OP_INT:
         if (op->has_ea) {
-            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
+            if (op->ext == X86_EXT_Signed) {
                 gen_op_ld_v(s, op->ot | MO_SIGN, v, s->A0);
             } else {
                 gen_op_ld_v(s, op->ot, v, s->A0);
             }
 
-        } else if (op->ot < MO_TL && v == s->T0 &&
-                   (decode->e.special == X86_SPECIAL_SExtT0 ||
-                    decode->e.special == X86_SPECIAL_ZExtT0)) {
+        } else if (op->ot < MO_TL && op->ext != X86_EXT_None) {
             if (op->ot == MO_8 && byte_reg_is_xH(s, op->n)) {
-                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                if (op->ext == X86_EXT_Signed) {
                     tcg_gen_sextract_tl(v, cpu_regs[op->n - 4], 8, 8);
                 } else {
                     tcg_gen_extract_tl(v, cpu_regs[op->n - 4], 8, 8);
                 }
             } else {
-                if (decode->e.special == X86_SPECIAL_SExtT0) {
+                if (op->ext == X86_EXT_Signed) {
                     tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot | MO_SIGN);
                 } else {
                     tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot);
@@ -347,6 +345,12 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
     case X86_OP_INT:
         if (op->has_ea) {
             gen_op_st_v(s, op->ot, v, s->A0);
+        } else if (op->ot < MO_TL && op->ext != X86_EXT_None) {
+            if (op->ext == X86_EXT_Signed) {
+                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot | MO_SIGN);
+            } else {
+                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot);
+            }
         } else {
             gen_op_mov_reg_v(s, op->ot, op->n, v);
         }
-- 
2.55.0


From ecc64b9d95affdb7caa7b1cf66f8afc15cc6d735 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Sep 2026 13:45:26 +0200
Subject: [PULL 15/32] target/i386/tcg: use standard operand order for BSF and
 BSR

BSF and BSR currently pass their source as operand 0 and the old
destination as operand 2.  This nonstandard order was needed so that the
source could use zextT0.

Per-operand extensions now let operand 2 use zextT1, so that BSF and BSR
can use the normal X86_OP_ENTRY2.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 18 ++++++++----------
 target/i386/tcg/emit.c.inc       | 12 +++++-------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 4f620e749e3..3f46a0fa203 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -674,12 +674,11 @@ static void decode_0FB8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSF, pass 2op as the third operand so that we can use zextT0 */
     static const X86OpEntry opcodes_0FBC[4] = {
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(TZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1),
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0x66 */
+        X86_OP_ENTRYwr(TZCNT, G,v, E,v, zextT0), /* 0xf3 */
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0xf2 */
     };
     if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
         *entry = opcodes_0FBC[0];
@@ -690,12 +689,11 @@ static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSR, pass 2op as the third operand so that we can use zextT0 */
     static const X86OpEntry opcodes_0FBD[4] = {
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(LZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1),
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0x66 */
+        X86_OP_ENTRYwr(LZCNT, G,v, E,v, zextT0), /* 0xf3 */
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0xf2 */
     };
     if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
         *entry = opcodes_0FBD[0];
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 54dc23ca624..abf40123035 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1396,7 +1396,6 @@ static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
-/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
 static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1404,7 +1403,7 @@ static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
     /* Only the Z bit is defined and it is related to the input.  */
     decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_LOGICB + ot;
-    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T1);
 
     /*
      * The manual says that the output is undefined when the
@@ -1412,10 +1411,9 @@ static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
      * real programs appear to depend on that.  Accomplish this
      * by passing the output as the value to return upon zero.
      */
-    tcg_gen_ctz_tl(s->T0, s->T0, s->T1);
+    tcg_gen_ctz_tl(s->T0, s->T1, s->T0);
 }
 
-/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
 static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1423,7 +1421,7 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
     /* Only the Z bit is defined and it is related to the input.  */
     decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_LOGICB + ot;
-    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T1);
 
     /*
      * The manual says that the output is undefined when the
@@ -1432,8 +1430,8 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
      * by passing the output as the value to return upon zero.
      * Plus, return the bit index of the first 1 bit.
      */
-    tcg_gen_xori_tl(s->T1, s->T1, TARGET_LONG_BITS - 1);
-    tcg_gen_clz_tl(s->T0, s->T0, s->T1);
+    tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
+    tcg_gen_clz_tl(s->T0, s->T1, s->T0);
     tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
 }
 
-- 
2.55.0


From ad2202a9e774e83c1c2b7a94ee003b7359755d3e Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Sep 2026 14:33:32 +0200
Subject: [PULL 16/32] target/i386/tcg: use zextT1 for CMPXCHG

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 target/i386/tcg/emit.c.inc       | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 3f46a0fa203..1810664258e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1365,8 +1365,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
-    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
-    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
+    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock zextT1),
+    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock zextT1),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index abf40123035..e4700473c9f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1760,11 +1760,10 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[2].ot;
     TCGv cmpv = tcg_temp_new();
     TCGv oldv = tcg_temp_new();
-    TCGv newv = tcg_temp_new();
+    TCGv newv = s->T1;
     TCGv dest;
 
     tcg_gen_ext_tl(cmpv, cpu_regs[R_EAX], ot);
-    tcg_gen_ext_tl(newv, s->T1, ot);
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
                                   s->mem_index, ot | MO_LE);
@@ -1787,7 +1786,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
              * not zero-extending it on 64-bit processors.  So, precompute
              * the result of a successful writeback and perform the movcond
              * directly on cpu_regs.  In case rm is part of RAX, note that this
-             * movcond and the one below are mutually exclusive is executed.
+             * movcond and the one below are mutually exclusive.
              */
             dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, newv, newv);
             tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
-- 
2.55.0


From 6f60b72bb0d0bd85ea579de43769665da2ee98ac Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Sep 2026 13:32:56 +0200
Subject: [PULL 17/32] target/i386/tcg: unify MOVBE and BSWAP generators

APX allows register-to-register MOVBE, which is normally done by BSWAP
(except 16-bit is also allowed).  Modify gen_MOVBE to also handle
BSWAP.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e4700473c9f..5a880b9760e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1435,17 +1435,6 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
 }
 
-static void gen_BSWAP(DisasContext *s, X86DecodedInsn *decode)
-{
-#ifdef TARGET_X86_64
-    if (s->dflag == MO_64) {
-        tcg_gen_bswap64_i64(s->T0, s->T0);
-        return;
-    }
-#endif
-    tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
-}
-
 static TCGv gen_bt_mask(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
@@ -2519,10 +2508,19 @@ static void gen_MOVBE(DisasContext *s, X86DecodedInsn *decode)
     /* M operand type does not load/store */
     if (decode->e.op0 == X86_TYPE_M) {
         tcg_gen_qemu_st_tl(s->T0, s->A0, s->mem_index, ot | MO_BE);
-    } else {
+    } else if (decode->e.op1 == X86_TYPE_M) {
         tcg_gen_qemu_ld_tl(s->T0, s->A0, s->mem_index, ot | MO_BE);
+#ifdef TARGET_X86_64
+    } else if (ot == MO_64) {
+        tcg_gen_bswap64_tl(s->T0, s->T0);
+#endif
+    } else if (ot == MO_32) {
+        tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
+    } else {
+        tcg_gen_bswap16_tl(s->T0, s->T0, TCG_BSWAP_OZ);
     }
 }
+#define gen_BSWAP gen_MOVBE
 
 static void gen_MOVD_from(DisasContext *s, X86DecodedInsn *decode)
 {
-- 
2.55.0


From 088537988eed6fc208acf3cde8dc6b5febde1a7a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 10:26:49 +0100
Subject: [PULL 18/32] target/i386/tcg: add APX support to XSAVE/XRSTOR

With it, add a new hidden flag that will be used to enable the REX2 prefix
and EVEX map4.

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h            |  3 ++
 target/i386/tcg/tcg-cpu.h    | 18 ++++++++---
 target/i386/helper.c         | 11 +++++++
 target/i386/tcg/fpu_helper.c | 59 +++++++++++++++++++++++++++++++++---
 target/i386/tcg/tcg-cpu.c    |  5 +--
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3f69b0a066a..c8619666f07 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -191,6 +191,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_SHIFT     26 /* BND registers in-use */
 #define HF_UMIP_SHIFT       27 /* CR4.UMIP */
 #define HF_AVX_EN_SHIFT     28 /* AVX Enabled (CR4+XCR0) */
+#define HF_APX_EN_SHIFT     29 /* APX Enabled (CR4+XCR0) */
 
 #define HF_CPL_MASK          (3 << HF_CPL_SHIFT)
 #define HF_INHIBIT_IRQ_MASK  (1 << HF_INHIBIT_IRQ_SHIFT)
@@ -218,6 +219,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_MASK       (1 << HF_MPX_IU_SHIFT)
 #define HF_UMIP_MASK         (1 << HF_UMIP_SHIFT)
 #define HF_AVX_EN_MASK       (1 << HF_AVX_EN_SHIFT)
+#define HF_APX_EN_MASK       (1 << HF_APX_EN_SHIFT)
 
 /* hflags2 */
 
@@ -2771,6 +2773,7 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
+void cpu_sync_apx_hflag(CPUX86State *env);
 
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 85bcd61678f..919c2f3ee3b 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -32,6 +32,7 @@
 #define XSAVE_AVX_OFFSET        0x240
 #define XSAVE_BNDREG_OFFSET     0x3c0
 #define XSAVE_BNDCSR_OFFSET     0x400
+#define XSAVE_APX_OFFSET        XSAVE_BNDREG_OFFSET
 #define XSAVE_OPMASK_OFFSET     0x440
 #define XSAVE_ZMM_HI256_OFFSET  0x480
 #define XSAVE_HI16_ZMM_OFFSET   0x680
@@ -52,9 +53,15 @@ typedef struct X86XSaveArea {
                     - sizeof(X86XSaveHeader)
                     - sizeof(XSaveAVX)];
 
-    /* MPX State: */
-    XSaveBNDREG bndreg_state;
-    XSaveBNDCSR bndcsr_state;
+    /* Overlapping MPX and APX States: */
+    union {
+        struct {
+            XSaveBNDREG bndreg;
+            XSaveBNDCSR bndcsr;
+        } mpx_state;
+        XSaveAPX apx_state;
+    };
+
     /* AVX-512 State: */
     XSaveOpmask opmask_state;
     XSaveZMM_Hi256 zmm_hi256_state;
@@ -71,8 +78,9 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.mxcsr) != XSAVE_MXCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.fpregs) != XSAVE_ST_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.xmm_regs) != XSAVE_XMM_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, avx_state) != XSAVE_AVX_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndreg_state) != XSAVE_BNDREG_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndcsr_state) != XSAVE_BNDCSR_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, apx_state) != XSAVE_APX_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndreg) != XSAVE_BNDREG_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndcsr) != XSAVE_BNDCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, opmask_state) != XSAVE_OPMASK_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 4133b5f244c..cb25018ecbb 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -36,6 +36,16 @@
 #include "tcg/insn-start-words.h"
 #endif
 
+void cpu_sync_apx_hflag(CPUX86State *env)
+{
+    if ((env->cr[4] & CR4_OSXSAVE_MASK)
+        && (env->xcr0 & XSTATE_APX_MASK) == XSTATE_APX_MASK) {
+        env->hflags |= HF_APX_EN_MASK;
+    } else{
+        env->hflags &= ~HF_APX_EN_MASK;
+    }
+}
+
 void cpu_sync_avx_hflag(CPUX86State *env)
 {
     if ((env->cr[4] & CR4_OSXSAVE_MASK)
@@ -250,6 +260,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 56d093da8c9..fb473c28f7b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2709,6 +2709,19 @@ static void do_xsave_pkru(X86Access *ac, target_ulong ptr)
     access_stq(ac, ptr, ac->env->pkru);
 }
 
+#ifdef TARGET_X86_64
+static void do_xsave_apx(X86Access *ac, target_ulong ptr)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        access_stq(ac, ptr, env->regs[i]);
+        ptr += 8;
+    }
+}
+#endif
+
 static void do_fxsave(X86Access *ac, target_ulong ptr)
 {
     CPUX86State *env = ac->env;
@@ -2773,14 +2786,19 @@ static void do_xsave_access(X86Access *ac, target_ulong ptr, uint64_t rfbm,
         do_xsave_ymmh(ac, ptr + XO(avx_state));
     }
     if (opt & XSTATE_BNDREGS_MASK) {
-        do_xsave_bndregs(ac, ptr + XO(bndreg_state));
+        do_xsave_bndregs(ac, ptr + XO(mpx_state.bndreg));
     }
     if (opt & XSTATE_BNDCSR_MASK) {
-        do_xsave_bndcsr(ac, ptr + XO(bndcsr_state));
+        do_xsave_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
     }
     if (opt & XSTATE_PKRU_MASK) {
         do_xsave_pkru(ac, ptr + XO(pkru_state));
     }
+#ifdef TARGET_X86_64
+    if (opt & XSTATE_APX_MASK) {
+        do_xsave_apx(ac, ptr + XO(apx_state));
+    }
+#endif
 
     /* Update the XSTATE_BV field.  */
     old_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
@@ -2974,6 +2992,29 @@ static void do_fxrstor(X86Access *ac, target_ulong ptr)
     }
 }
 
+#ifdef TARGET_X86_64
+static void do_xrstor_apx(X86Access *ac, target_ulong ptr)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        env->regs[i] = access_ldq(ac, ptr);
+        ptr += 8;
+    }
+}
+
+static void do_clear_apx(X86Access *ac)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        env->regs[i] = 0;
+    }
+}
+#endif
+
 void helper_fxrstor(CPUX86State *env, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
@@ -3045,7 +3086,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(mpx_state.bndreg));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -3054,7 +3095,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -3072,6 +3113,15 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
             tlb_flush(cs);
         }
     }
+#ifdef TARGET_X86_64
+    if (rfbm & XSTATE_APX_MASK) {
+        if (xstate_bv & XSTATE_APX_MASK) {
+            do_xrstor_apx(ac, ptr + XO(apx_state));
+        } else {
+            do_clear_apx(ac);
+        }
+    }
+#endif
 }
 
 #undef XO
@@ -3253,6 +3303,7 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
     env->xcr0 = mask;
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
     return;
 
  do_gpf:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 2402608fe90..9db9795a3b2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -200,12 +200,13 @@ static void x86_tcg_cpu_xsave_init(void)
     XO(XSTATE_FP_BIT, legacy);
     XO(XSTATE_SSE_BIT, legacy);
     XO(XSTATE_YMM_BIT, avx_state);
-    XO(XSTATE_BNDREGS_BIT, bndreg_state);
-    XO(XSTATE_BNDCSR_BIT, bndcsr_state);
+    XO(XSTATE_BNDREGS_BIT, mpx_state.bndreg);
+    XO(XSTATE_BNDCSR_BIT, mpx_state.bndcsr);
     XO(XSTATE_OPMASK_BIT, opmask_state);
     XO(XSTATE_ZMM_Hi256_BIT, zmm_hi256_state);
     XO(XSTATE_Hi16_ZMM_BIT, hi16_zmm_state);
     XO(XSTATE_PKRU_BIT, pkru_state);
+    XO(XSTATE_APX_BIT, apx_state);
 
 #undef XO
 }
-- 
2.55.0


From 6c94eec2675ad31be4238e00df5a18e2d675048f Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 10:29:45 +0100
Subject: [PULL 19/32] target/i386/tcg: add definition for REX2 prefix

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 060649315a6..49ab2ae50e6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -50,6 +50,7 @@
 #define PREFIX_ADR    0x10
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
+#define PREFIX_REX2   0x80
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -208,7 +209,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.55.0


From e7ee83a52de801f132cda72e77d56f2a4d4b3edc Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Dec 2025 18:52:21 +0100
Subject: [PULL 20/32] target/i386/tcg: mark XSAVE* as not allowing REX2

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 1b5a91b4f46..bb686c9efd0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No REX2 prefix allowed */
+    X86_CHECK_no_rex2 = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1810664258e..523bbaf6042 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -486,9 +486,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
         [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
         [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00),
-        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00),
-        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00),
+        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00 chk(no_rex2)),
         [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
     };
 
@@ -3016,15 +3016,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
-        if (decode.e.check & X86_CHECK_prot_or_vm86) {
-            if (!PE(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_prot_or_vm86) && !PE(s)) {
+            goto illegal_op;
         }
-        if (decode.e.check & X86_CHECK_no_vm86) {
-            if (VM86(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
+            goto illegal_op;
         }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
-- 
2.55.0


From a9e08c8419e287241aa66c36c80a9a9d77252871 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 12:31:00 +0100
Subject: [PULL 21/32] target/i386/tcg: treat 0x0F as a prefix

Because 0x0F cannot come after REX2, pick the 0F opcode map
during prefix decoding instead of doing so via the root opcode map.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 523bbaf6042..24ea4fcb926 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1848,7 +1848,6 @@ static const X86OpEntry opcodes_root[256] = {
     [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
     [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
     [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
-    [0x0F] = X86_OP_GROUP0(0F),
 
     [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
     [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
@@ -2833,6 +2832,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Collect prefixes.  */
     switch (b) {
+    case 0x0f:
+        decode_func = decode_0F;
+        break;
     case 0xf3:
         s->prefix |= PREFIX_REPZ;
         s->prefix &= ~PREFIX_REPNZ;
-- 
2.55.0


From 75cd902e5029bfae507e09030db3039b3c77df86 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 12:31:00 +0100
Subject: [PULL 22/32] target/i386/tcg: decode REX2 prefix

The REX2 prefix has two main complications: it does not apply
to vector registers, and it disables or mutates some opcodes
(thus needing separate decoding functions instead of decode_root
and decode_0F).  Otherwise, all it does is extend s->rex_r,
s->rex_w and s->rex_b to two bits.

Since REX2 provides the ability to access r16...r31, extend
cpu_regs[] to CPU_NB_EREGS elements.

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  22 +++++-
 target/i386/tcg/decode-new.c.inc | 114 +++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 49ab2ae50e6..a3674132701 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -78,7 +78,7 @@
 static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
 static TCGv cpu_eip;
 static TCGv_i32 cpu_cc_op;
-static TCGv cpu_regs[CPU_NB_REGS];
+static TCGv cpu_regs[CPU_NB_EREGS];
 static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
@@ -3341,7 +3341,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
 void tcg_x86_init(void)
 {
-    static const char reg_names[CPU_NB_REGS][4] = {
+    static const char reg_names[CPU_NB_EREGS][4] = {
 #ifdef TARGET_X86_64
         [R_EAX] = "rax",
         [R_EBX] = "rbx",
@@ -3359,6 +3359,22 @@ void tcg_x86_init(void)
         [13] = "r13",
         [14] = "r14",
         [15] = "r15",
+        [16] = "r16",
+        [17] = "r17",
+        [18] = "r18",
+        [19] = "r19",
+        [20] = "r20",
+        [21] = "r21",
+        [22] = "r22",
+        [23] = "r23",
+        [24] = "r24",
+        [25] = "r25",
+        [26] = "r26",
+        [27] = "r27",
+        [28] = "r28",
+        [29] = "r29",
+        [30] = "r30",
+        [31] = "r31",
 #else
         [R_EAX] = "eax",
         [R_EBX] = "ebx",
@@ -3403,7 +3419,7 @@ void tcg_x86_init(void)
                                      "cc_src2");
     cpu_eip = tcg_global_mem_new(tcg_env, offsetof(CPUX86State, eip), eip_name);
 
-    for (i = 0; i < CPU_NB_REGS; ++i) {
+    for (i = 0; i < CPU_NB_EREGS; ++i) {
         cpu_regs[i] = tcg_global_mem_new(tcg_env,
                                          offsetof(CPUX86State, regs[i]),
                                          reg_names[i]);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 24ea4fcb926..1e8ff235172 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1991,6 +1991,65 @@ static const X86OpEntry opcodes_root[256] = {
     [0xFF] = X86_OP_GROUP1(group4_5, E,v),
 };
 
+#ifdef TARGET_X86_64
+static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+};
+
+static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
+                        const X86OpEntry **map)
+{
+    *b = x86_ldub_code(env, s);
+    const X86OpEntry *group = map[*b >> 4];
+    *entry = group ? group[*b & 15] : UNKNOWN_OPCODE;
+}
+
+static void decode_REX2_map0(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry *opcode_rex2_map0[16] = {
+        &opcodes_root[0x00],
+        &opcodes_root[0x10],
+        &opcodes_root[0x20],
+        &opcodes_root[0x30],
+        NULL,
+        &opcodes_root[0x50],
+        &opcodes_root[0x60],
+        NULL,
+        &opcodes_root[0x80],
+        &opcodes_root[0x90],
+        opcodes_rex2_map0_A0toAF,
+        &opcodes_root[0xB0],
+        &opcodes_root[0xC0],
+        &opcodes_root[0xD0],
+        NULL,
+        &opcodes_root[0xF0],
+    };
+    decode_REX2(s, env, entry, b, opcode_rex2_map0);
+}
+
+static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry *opcode_rex2_map1[16] = {
+        &opcodes_0F[0x00],
+        &opcodes_0F[0x10],
+        &opcodes_0F[0x20],
+        NULL,
+        &opcodes_0F[0x40],
+        &opcodes_0F[0x50],
+        &opcodes_0F[0x60],
+        &opcodes_0F[0x70],
+        NULL,
+        &opcodes_0F[0x90],
+        &opcodes_0F[0xA0],
+        &opcodes_0F[0xB0],
+        &opcodes_0F[0xC0],
+        &opcodes_0F[0xD0],
+        &opcodes_0F[0xE0],
+        &opcodes_0F[0xF0],
+    };
+    decode_REX2(s, env, entry, b, opcode_rex2_map1);
+}
+#endif
+
 #undef mmx
 #undef vex1
 #undef vex2
@@ -2010,6 +2069,20 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = opcodes_root[*b];
 }
 
+static int reg_nb_mask(DisasContext *s, int unit)
+{
+    switch (unit) {
+    case X86_OP_MMX:
+        return 7;
+    case X86_OP_SSE:
+        return 15;
+        break;
+    default:
+        return 31;
+        break;
+    }
+}
+
 /* Decode the MODRM and SIB bytes into a register or memory operand.  */
 static void decode_modrm(DisasContext *s, CPUX86State *env,
                          X86DecodedInsn *decode, X86DecodedOp *op)
@@ -2020,10 +2093,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int sib = -1;
 
     if (mod == 3) {
-        op->n = rm;
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
+        op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
 	return;
     }
 
@@ -2324,9 +2394,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
     get_reg:
         op->n = ((s->modrm >> 3) & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_R(s);
-        }
+        op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
@@ -2794,6 +2862,24 @@ static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
     }
 }
 
+/* MASK must have two bits set.  Bring the lowest just below the highest;
+ * for example if MASK == 0x11, bit 1 of value is moved to bit 3.  Clear
+ * every other bit in VALUE.
+ *
+ * Generally mask will be a constant, so that all of the first three
+ * lines disappear.  Likewise, if the bits in mask are already adjacent
+ * this becomes just "return value & mask".
+ */
+static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
+{
+    uint8_t high = mask & (mask - 1);
+    uint8_t low = mask & ~high;
+    uint8_t tweak = (high >> 1) - low;
+
+    value &= mask;
+    return (value + tweak) & (mask + tweak);
+}
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2889,6 +2975,20 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             goto next_byte_rex;
         }
         break;
+    case 0xd5: /* REX2 */
+        if (CODE64(s) && (s->flags & HF_APX_EN_MASK)) {
+            int rex2 = x86_ldub_code(env, s);
+            if (rex != -1) {
+                goto illegal_op;
+            }
+            s->prefix |= PREFIX_REX2;
+            s->rex_b = collapse_two_bits(rex2, 0x11);
+            s->rex_x = collapse_two_bits(rex2, 0x22) >> 1;
+            s->rex_r = collapse_two_bits(rex2, 0x44) >> 2;
+            s->vex_w = (rex2 >> 3) & 1;
+            decode_func = rex2 & 0x80 ? decode_REX2_map1 : decode_REX2_map0;
+        }
+        break;
 #endif
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
-- 
2.55.0


From 608f78550f9ab37cf7796bff26ad971d58ac2d25 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 23 Nov 2025 18:03:31 +0100
Subject: [PULL 23/32] target/i386/tcg: implement JMPABS instruction

This is the same as an indirect jump, just with immediate operand.
The requirement of W=0 and 0x67 are already available in the decoder.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index bb686c9efd0..eb692503680 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -190,6 +190,9 @@ typedef enum X86InsnCheck {
 
     /* No REX2 prefix allowed */
     X86_CHECK_no_rex2 = 8192,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 16384,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1e8ff235172..39ce3dec894 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1993,6 +1993,7 @@ static const X86OpEntry opcodes_root[256] = {
 
 #ifdef TARGET_X86_64
 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+    [1] = X86_OP_ENTRYr(JMP_m,   I,q, p_00 chk2(W0, no_adr)), /* JMPABS */
 };
 
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
@@ -3127,6 +3128,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
+            goto illegal_op;
+        }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
         }
-- 
2.55.0


From 15e3c13c59cebabc788c908b02c6bb0a8f7a77da Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Dec 2025 13:09:51 +0100
Subject: [PULL 24/32] target/i386/tcg: extend VEX.vvvv parsing for APX

BMI uses operand type B when VEX.vvvv provides one of the register indices
of three-operand instructions.  However, APX needs to use it even for
two-operand instructions, similar to how SSE and AVX share destination
but use the modrm operand when there is no VEX prefix.

To do this , operand type B can mostly reuse the code for operand type H
but there are two extra possibilities:

- instructions with VEX/EVEX prefix but no new data destination.  To handle
  this, use a new field s->vex_ndd to retrieve whether the B (or H) operand
  comes from VEX.vvvv or from modrm.  For now, this uses the same existing
  logic from validate_vex(), but later it will be extended to read EVEX.NDD.

- instructions with operands "m,r" that NDD extends to "r,m,r".
  In this case, in the non-NDD format "m,r" the B operand corresponds to
  a memory location; when this happens, it is incorrect to parse again
  op1 as a memory location, because that would read the displacement again
  from the instruction stream.  Instead, transform op1 into X86_TYPE_2op
  if VEX.vvvv is the destination operand.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  1 +
 target/i386/tcg/decode-new.c.inc | 38 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a3674132701..fe19915ba0f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -105,6 +105,7 @@ typedef struct DisasContext {
 #endif
     uint8_t vex_l;  /* vex vector length */
     uint8_t vex_v;  /* vex vvvv register, without 1's complement.  */
+    bool vex_ndd; /* is this a 3-operand instruction? */
     uint8_t popl_esp_hack; /* for correct popl with esp base handling */
     uint8_t rip_offset; /* only used in x86_64, but left for simplicity */
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 39ce3dec894..de09b13495f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2333,10 +2333,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_Y:  /* string destination */
         break;
 
-    case X86_TYPE_B:  /* VEX.vvvv selects a GPR */
+    case X86_TYPE_B:  /* VEX.vvvv selects a GPR, else use modrm */
         op->unit = X86_OP_INT;
-        op->n = s->vex_v;
-        break;
+        goto get_vex_v;
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
@@ -2466,18 +2465,25 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         };
         break;
 
-    case X86_TYPE_H:  /* For AVX, VEX.vvvv selects an XMM/YMM register */
-        if ((s->prefix & PREFIX_VEX)) {
-            op->unit = X86_OP_SSE;
+    case X86_TYPE_H:  /* VEX.vvvv selects an XMM/YMM register, else use modrm */
+        op->unit = X86_OP_SSE;
+    get_vex_v:
+        if (s->vex_ndd) {
+            assert(s->prefix & PREFIX_VEX);
             op->n = s->vex_v;
             break;
         }
+        /* Two-operand form: the other one of op0 and op1 is a modrm operand, use it. */
+        assert(decode->e.s1 == decode->e.s0);
         if (op == &decode->op[0]) {
-            /* shifts place the destination in VEX.vvvv, use modrm */
-            return decode_op(s, env, decode, op, decode->e.op1, b);
+            if (!decode_op(s, env, decode, op, decode->e.op1, b)) {
+                return false;
+            }
+            decode->e.op1 = X86_TYPE_2op;
         } else {
-            return decode_op(s, env, decode, op, decode->e.op0, b);
+            *op = decode->op[0];
         }
+        break;
 
     case X86_TYPE_I:  /* Immediate */
     case X86_TYPE_J:  /* Relative offset for a jump */
@@ -2720,6 +2726,14 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
+    if (s->prefix & PREFIX_VEX) {
+        if (e->op0 == X86_TYPE_H || e->op0 == X86_TYPE_B ||
+            e->op1 == X86_TYPE_H || e->op1 == X86_TYPE_B ||
+            e->op2 == X86_TYPE_H || e->op2 == X86_TYPE_B) {
+            s->vex_ndd = true;
+        }
+    }
+
     switch (e->vex_special) {
     case X86_VEX_None:
         break;
@@ -2811,10 +2825,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         return true;
     }
 
-    if (s->vex_v != 0 &&
-        e->op0 != X86_TYPE_H && e->op0 != X86_TYPE_B &&
-        e->op1 != X86_TYPE_H && e->op1 != X86_TYPE_B &&
-        e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
+    if (s->vex_v != 0 && !s->vex_ndd) {
         goto illegal;
     }
     return true;
@@ -2905,6 +2916,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_l = 0;
     s->vex_v = 0;
     s->vex_w = false;
+    s->vex_ndd = false;
     s->has_modrm = false;
     s->prefix = 0;
 
-- 
2.55.0


From f7c06ea3a170a8908bec3ef52f2a74ac235d054f Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Nov 2025 14:45:29 +0100
Subject: [PULL 25/32] target/i386/tcg: decode EVEX prefix

EVEX is really messy and the exact position of the fields is spread all
over the place.  For now store the three data bytes of the prefix in
DisasContext, later the EVEX instruction classes for APX will be added
to extract_evex_params and validate_vex.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  8 ++-
 target/i386/tcg/decode-new.c.inc | 89 +++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index fe19915ba0f..5cbb3b95ec0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -51,6 +51,7 @@
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
 #define PREFIX_REX2   0x80
+#define PREFIX_EVEX   0x100
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -93,8 +94,8 @@ typedef struct DisasContext {
     MemOp aflag;
     MemOp dflag;
 
+    uint16_t prefix;
     int8_t override; /* -1 if no override, else R_CS, R_DS, etc */
-    uint8_t prefix;
 
     bool has_modrm;
     uint8_t modrm;
@@ -114,6 +115,9 @@ typedef struct DisasContext {
     uint8_t rex_x;
     uint8_t rex_b;
 #endif
+    uint8_t evex2;
+    uint8_t evex3;
+    uint8_t evex4;
     bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
     bool cc_op_dirty;
@@ -210,7 +214,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX | PREFIX_EVEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index de09b13495f..7781c8c6d0f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2049,6 +2049,11 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     };
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
+
+static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    *entry = UNKNOWN_OPCODE;
+}
 #endif
 
 #undef mmx
@@ -2076,8 +2081,7 @@ static int reg_nb_mask(DisasContext *s, int unit)
     case X86_OP_MMX:
         return 7;
     case X86_OP_SSE:
-        return 15;
-        break;
+        return s->prefix & PREFIX_EVEX ? 31 : 15;
     default:
         return 31;
         break;
@@ -2469,7 +2473,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->unit = X86_OP_SSE;
     get_vex_v:
         if (s->vex_ndd) {
-            assert(s->prefix & PREFIX_VEX);
+            assert(s->prefix & (PREFIX_VEX | PREFIX_EVEX));
             op->n = s->vex_v;
             break;
         }
@@ -2558,6 +2562,15 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
     return !!e->gen;
 }
 
+static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
+{
+    /*
+     * Here, the position of RXB and (for AVX512) displacement multiplier
+     * should be known.
+     */
+    return false;
+}
+
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                        X86DecodedInsn *decode)
 {
@@ -2726,13 +2739,16 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
-    if (s->prefix & PREFIX_VEX) {
+    if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
         if (e->op0 == X86_TYPE_H || e->op0 == X86_TYPE_B ||
             e->op1 == X86_TYPE_H || e->op1 == X86_TYPE_B ||
             e->op2 == X86_TYPE_H || e->op2 == X86_TYPE_B) {
             s->vex_ndd = true;
         }
     }
+    if ((s->prefix & PREFIX_EVEX) && !extract_evex_params(s, decode)) {
+        goto illegal;
+    }
 
     switch (e->vex_special) {
     case X86_VEX_None:
@@ -2892,6 +2908,10 @@ static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
     return (value + tweak) & (mask + tweak);
 }
 
+static const int pp_prefix[4] = {
+    0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
+};
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2917,6 +2937,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_v = 0;
     s->vex_w = false;
     s->vex_ndd = false;
+    s->evex2 = 0;
+    s->evex3 = 0;
+    s->evex4 = 0;
     s->has_modrm = false;
     s->prefix = 0;
 
@@ -3003,6 +3026,59 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 #endif
+    case 0x62: /* EVEX */
+        if (CODE32(s) && !VM86(s)) {
+            int evex2 = x86_ldub_code(env, s);
+
+            if (!CODE64(s) && (evex2 & 0xc0) != 0xc0) {
+                s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
+                break;
+            }
+#ifdef TARGET_X86_64
+            if (rex != -1) {
+                goto illegal_op;
+            }
+#endif
+            if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ
+                             | PREFIX_LOCK | PREFIX_DATA)) {
+                goto illegal_op;
+            }
+            /*
+             * Store them because the exact correspondence between EVEX
+             * and RXB bits is only known later.  It's different for APX,
+             * AVX512 register operands, and AVX512 VSIB index operands.
+             */
+            s->evex2 = evex2;
+            s->evex3 = x86_ldub_code(env, s);
+            s->evex4 = x86_ldub_code(env, s);
+            s->vex_w = (s->evex3 >> 7) & 1;
+            s->vex_l = (s->evex4 >> 5) & 3;
+            s->prefix |= pp_prefix[s->evex3 & 3] | PREFIX_EVEX;
+            switch (evex2 & 7) {
+            case 0x01:
+                /*
+                 * Note: actually uses VEX map1, to which AVX512 adds extra
+                 * instructions encoded with VEX.L=1.  Of these, KMOV*
+                 * has an APX extension too.
+                 */
+                decode_func = decode_0F;
+                break;
+            case 0x02:
+                decode_func = decode_0F38;
+                break;
+            case 0x03:
+                decode_func = decode_0F3A;
+                break;
+#ifdef TARGET_X86_64
+            case 0x04:
+                decode_func = decode_EVEX_map4;
+                break;
+#endif
+            default:   /* Reserved for future use.  */
+                goto unknown_op;
+            }
+        }
+        break;
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
         /*
@@ -3010,9 +3086,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
          * Otherwise the instruction is LES or LDS.  Not allowed in real mode.
          */
         if (PE(s) && !VM86(s)) {
-            static const int pp_prefix[4] = {
-                0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
-            };
             int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
@@ -3160,7 +3233,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     if (decode.e.vex_class == 0) {
-        if (s->prefix & PREFIX_VEX) {
+        if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
             goto illegal_op;
         }
     } else {
-- 
2.55.0


From 8f5d46bf58dcb08c72096402467347f88253cfef Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Nov 2025 15:17:39 +0100
Subject: [PULL 26/32] target/i386/tcg: add decode functionality for APX

Handle the EVEX formats for APX (including the extension of BMI and CMPccXADD
instructions that already supported VEX) and add their validation to
validate_vex().  Exit disas_insn() early if the NF field is set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  10 ++
 target/i386/tcg/translate.c      |  11 +-
 target/i386/tcg/decode-new.c.inc | 171 ++++++++++++++++++++++++++++++-
 3 files changed, 184 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index eb692503680..140dd5fa1c8 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -193,6 +193,9 @@ typedef enum X86InsnCheck {
 
     /* No 0x67 prefix allowed */
     X86_CHECK_no_adr = 16384,
+
+    /* EVEX.NF bit not allowed */
+    X86_CHECK_nf0 = 32768,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
@@ -279,6 +282,13 @@ typedef enum X86VEXSpecial {
     X86_VEX_LIG,
 } X86VEXSpecial;
 
+typedef enum X86EVEXClass {
+    /* Non-vector instruction that can use APX EGPRs.  */
+    X86_EVEX_APX = 128,
+    X86_EVEX_APX_cmp = 129,
+    X86_EVEX_APX_pp2 = 130,
+    X86_EVEX_APX_zu = 131,
+} X86EVEXClass;
 
 typedef struct X86OpEntry  X86OpEntry;
 typedef struct X86DecodedInsn X86DecodedInsn;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cbb3b95ec0..765a9a44da1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -107,18 +107,17 @@ typedef struct DisasContext {
     uint8_t vex_l;  /* vex vector length */
     uint8_t vex_v;  /* vex vvvv register, without 1's complement.  */
     bool vex_ndd; /* is this a 3-operand instruction? */
+    bool vex_w; /* used by AVX even on 32-bit processors */
     uint8_t popl_esp_hack; /* for correct popl with esp base handling */
     uint8_t rip_offset; /* only used in x86_64, but left for simplicity */
 
-#ifdef TARGET_X86_64
-    uint8_t rex_r;
+    uint8_t rex_r; /* 0 for i386, but left for simplicity */
     uint8_t rex_x;
     uint8_t rex_b;
-#endif
+
     uint8_t evex2;
     uint8_t evex3;
     uint8_t evex4;
-    bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
     bool cc_op_dirty;
 
@@ -219,12 +218,16 @@ typedef struct DisasContext {
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
 #define REX_B(S)       ((S)->rex_b + 0)
+#define EVEX_APX_ND(S) (((S)->evex4 & 0x10) != 0)
+#define EVEX_APX_NF(S) (((S)->evex4 & 0x04) != 0)
 #else
 #define REX_PREFIX(S)  false
 #define REX_W(S)       false
 #define REX_R(S)       0
 #define REX_X(S)       0
 #define REX_B(S)       0
+#define EVEX_APX_ND(S) 0
+#define EVEX_APX_NF(S) 0
 #endif
 
 /*
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7781c8c6d0f..cef7481fb3e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -257,6 +257,10 @@
 #define vex11 .vex_class = 11,
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
+#define evex_apx .vex_class = X86_EVEX_APX,
+#define evex_apx_cmp .vex_class = X86_EVEX_APX_cmp,
+#define evex_apx_pp2 .vex_class = X86_EVEX_APX_pp2,
+#define evex_apx_zu .vex_class = X86_EVEX_APX_zu,
 
 #define chk(a) .check = X86_CHECK_##a,
 #define chk2(a, b) .check = X86_CHECK_##a | X86_CHECK_##b,
@@ -2531,9 +2535,23 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
 {
     uint16_t sse_prefixes;
 
-    if (!e->valid_prefix) {
-        return true;
+    switch (e->vex_class) {
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* For APX-extended instructions, only EVEX versions check the prefix.  */
+        if (!(s->prefix & PREFIX_EVEX)) {
+            return true;
+        }
+
+        /* fallthrough */
+    default:
+        if (!e->valid_prefix) {
+            return true;
+        }
     }
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
         /* In SSE instructions, 0xF3 and 0xF2 cancel 0x66.  */
         s->prefix &= ~PREFIX_DATA;
@@ -2568,9 +2586,38 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
      * Here, the position of RXB and (for AVX512) displacement multiplier
      * should be known.
      */
-    return false;
+    X86OpEntry *e = &decode->e;
+    uint8_t rex_r, rex_x, rex_b;
+
+    switch (e->vex_class) {
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* Only reached through EVEX map 4.  */
+        rex_r = (~s->evex2 & 0x10) | ((~s->evex2 >> 4) & 8);
+        rex_x = ((~s->evex3 << 2) & 0x10) | ((~s->evex2 >> 3) & 8);
+        rex_b = ((s->evex2 << 1) & 0x10) | ((~s->evex2 >> 2) & 8);
+        s->vex_v = ((~s->evex4 << 1) & 0x10) | ((~s->evex3 >> 3) & 15);
+        break;
+    default:
+        return false;
+    }
+
+#ifdef TARGET_X86_64
+    s->rex_r = rex_r;
+    s->rex_x = rex_x;
+    s->rex_b = rex_b;
+#else
+    (void)rex_r;
+    (void)rex_x;
+    (void)rex_b;
+#endif
+    return true;
 }
 
+
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                        X86DecodedInsn *decode)
 {
@@ -2735,6 +2782,87 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     g_assert_not_reached();
 }
 
+static bool validate_evex_apx(DisasContext *s, X86DecodedInsn *decode)
+{
+    X86OpEntry *e = &decode->e;
+    uint8_t evex4_mask = 0;
+
+    assert(s->has_modrm);
+    switch (e->vex_class) {
+    case 13:
+        /*
+         * APX-EVEX-BMI and APX-EVEX-CMPCCXADD do not define EVEX.ND.
+         * They only differ for checks on NF, which happen elsewhere.
+         */
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        evex4_mask = 0x0C;
+        break;
+
+    case X86_EVEX_APX:
+        /* APX-EVEX-INT.  Checks on NF happen elsewhere.  */
+        assert(e->op0 == X86_TYPE_None || e->s0 == e->s1);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (!EVEX_APX_ND(s)) {
+            s->vex_ndd = false;
+        } else if (!s->vex_ndd) {
+            goto illegal;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_zu:
+        /* APX-EVEX-INT, with ZU bit defined.  Checks on NF happen elsewhere.  */
+        assert(decode->e.ext0 == X86_EXT_None && !s->vex_ndd);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (s->vex_v != 0) {
+            goto illegal;
+        }
+        if (EVEX_APX_ND(s)) {
+            decode->e.ext0 = X86_EXT_Unsigned;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_pp2:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK) ||
+            !EVEX_APX_ND(s) ||
+            (e->op0 != X86_TYPE_None && s->vex_v == ((s->modrm & 7) | REX_B(s))) ||
+            ((s->modrm & 7) | REX_B(s)) == 4 ||
+            s->vex_v == 4) {
+            goto illegal;
+        }
+        evex4_mask = 0x18;
+        break;
+
+    case X86_EVEX_APX_cmp:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        evex4_mask = 0x0F;
+        break;
+    }
+
+    if (s->evex4 & ~evex4_mask) {
+        goto illegal;
+    }
+
+    /* r/m == 11b requires X4=0 (that is, EVEX.U is 1)  */
+    if ((s->modrm >> 6) == 3 && (s->rex_x & 16)) {
+        goto illegal;
+    }
+    return true;
+
+illegal:
+    gen_illegal_opcode(s);
+    return false;
+}
+
 static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
@@ -2831,14 +2959,30 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
         break;
     case 13:
-        if (!(s->prefix & PREFIX_VEX)) {
+        if (!(s->prefix & (PREFIX_VEX | PREFIX_EVEX))) {
             goto illegal;
         }
         if (s->vex_l) {
             goto illegal;
         }
+        if (s->prefix & PREFIX_EVEX && !validate_evex_apx(s, decode)) {
+            return false;
+        }
         /* All integer instructions use VEX.vvvv, so exit.  */
         return true;
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* Not reached through any VEX map.  */
+        assert(!(s->prefix & PREFIX_VEX));
+        if (s->vex_l) {
+            goto illegal;
+        }
+        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)) {
+            return false;
+        }
+        return true;
     }
 
     if (s->vex_v != 0 && !s->vex_ndd) {
@@ -2857,6 +3001,10 @@ static bool validate_cr0_exceptions(DisasContext *s, X86DecodedInsn *decode)
     switch (decode->e.vex_class) {
     case 0:
     case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
         return true;
     default:
         break;
@@ -3225,6 +3373,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
+            goto illegal_op;
+        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
@@ -3363,6 +3514,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
      * cause incorrect tracking of CC_OP for instructions that write to both memory
      * and flags.
      */
+    switch (decode.e.vex_class) {
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_zu:
+        if (EVEX_APX_NF(s)) {
+            return;
+        }
+        break;
+    default:
+        break;
+    }
+
     if (decode.cc_op != -1) {
         if (decode.cc_dst) {
             tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
-- 
2.55.0


From 444782ff22eba1b24098ab90790e06dda768e74a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Aug 2026 15:28:43 +0200
Subject: [PULL 27/32] target/i386/tcg: implement CCMP/CTEST

CCMP/CTEST are new instructions that will either perform a CMP/TEST
or set EFLAGS to a predetermined value.  To support this double
functionality without using CC_OP_DYNAMIC, introduce a new CCOp that
is inspired by x86_flags.h.

By shifting the carry computation part of compute_aco_sub* to TCG ops,
it provides enough flexibility that the result of a subtraction,
the result of an AND, and any value of EFLAGS can be encoded with a
single CCOp.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                        |   5 +
 target/i386/tcg/cc_helper_template.h.inc |  11 ++
 target/i386/tcg/cc_helper.c              |  14 +++
 target/i386/tcg/translate.c              |  69 ++++++++++++
 target/i386/tcg/decode-new.c.inc         |  30 ++---
 target/i386/tcg/emit.c.inc               | 138 ++++++++++++++++++++++-
 6 files changed, 251 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c8619666f07..e7a88074c07 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1606,6 +1606,11 @@ typedef enum {
     CC_OP_BLSIL,
     CC_OP_BLSIQ,
 
+    CC_OP_CCMPB, /* Z via CC_DST, P,S via CC_SRC2, carry-out in CC_SRC */
+    CC_OP_CCMPW,
+    CC_OP_CCMPL,
+    CC_OP_CCMPQ,
+
     /*
      * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
      * is used or implemented, because the translation needs
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index af58c2409f7..8ec449fd3ff 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -60,6 +60,17 @@ static uint32_t glue(compute_aco_cout, SUFFIX)(DATA_TYPE carries)
     return af_cf + of;
 }
 
+static uint32_t glue(compute_all_ccmp, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1, DATA_TYPE src2)
+{
+    uint32_t pf, zf, sf;
+
+    /* Compute all bits here because PF and SF do not come from DST.  */
+    zf = dst == 0 ? CC_Z : 0;
+    pf = compute_pf(src2);
+    sf = lshift(src2, 8 - DATA_BITS) & CC_S;
+    return pf + zf + sf + glue(compute_aco_cout, SUFFIX)(src1);
+}
+
 static uint32_t glue(compute_aco_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     DATA_TYPE src2 = dst - src1;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 6ddd64fcb07..b868ef2949f 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -111,6 +111,13 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_ADCOX:
         return compute_all_adcox(dst, src1, src2);
 
+    case CC_OP_CCMPB:
+        return compute_all_ccmpb(dst, src1, src2);
+    case CC_OP_CCMPW:
+        return compute_all_ccmpw(dst, src1, src2);
+    case CC_OP_CCMPL:
+        return compute_all_ccmpl(dst, src1, src2);
+
     case CC_OP_MULB:
         flags = compute_aco_mul(src1);
         goto psz_b;
@@ -232,6 +239,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         goto psz_l;
 
 #ifdef TARGET_X86_64
+    case CC_OP_CCMPQ:
+        return compute_all_ccmpq(dst, src1, src2);
+
     case CC_OP_MULQ:
         flags = compute_aco_mul(src1);
         goto psz_q;
@@ -365,10 +375,13 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
         return compute_c_sbbl(dst, src1, src2);
 
     case CC_OP_SHLB:
+    case CC_OP_CCMPB:
         return compute_c_shlb(dst, src1);
     case CC_OP_SHLW:
+    case CC_OP_CCMPW:
         return compute_c_shlw(dst, src1);
     case CC_OP_SHLL:
+    case CC_OP_CCMPL:
         return compute_c_shll(dst, src1);
 
     case CC_OP_BMILGB:
@@ -395,6 +408,7 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_SBBQ:
         return compute_c_sbbq(dst, src1, src2);
     case CC_OP_SHLQ:
+    case CC_OP_CCMPQ:
         return compute_c_shlq(dst, src1);
     case CC_OP_BMILGQ:
         return compute_c_bmilgq(dst, src1);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 765a9a44da1..dd417cb5341 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -286,6 +286,11 @@ enum {
     JCC_LE,
 };
 
+enum {
+    CCMP_T = JCC_P << 1,
+    CCMP_F,
+};
+
 enum {
     USES_CC_DST  = 1,
     USES_CC_SRC  = 2,
@@ -309,6 +314,7 @@ static const uint8_t cc_op_live_[] = {
     [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BLSIB ... CC_OP_BLSIQ] = USES_CC_DST | USES_CC_SRC,
+    [CC_OP_CCMPB ... CC_OP_CCMPQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
@@ -908,6 +914,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = cc_op_size(s->cc_op);
         return gen_prepare_sign_nz(cpu_cc_src, size);
@@ -976,6 +983,8 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
                              .imm = CC_S };
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        return gen_prepare_sign_nz(cpu_cc_src2, cc_op_size(s->cc_op));
     default:
         return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
@@ -995,6 +1004,20 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
+
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        if (!reg) {
+            reg = tcg_temp_new();
+        }
+        /*
+         * Sum the carry-out vector and the value of the bit below the MSB;
+         * the XOR of the top two carry bits ends up in the sign bit.
+         */
+        int size = cc_op_size(s->cc_op);
+        target_ulong adj = 1ull << ((8 << size) - 2);
+        tcg_gen_add_tl(reg, cpu_cc_src, tcg_constant_tl(adj));
+        return gen_prepare_sign_nz(reg, size);
+
     default:
         gen_compute_eflags(s);
         /* fallthrough */
@@ -1081,6 +1104,52 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         goto slow_jcc;
 
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        size = cc_op_size(s->cc_op);
+        switch (jcc_op) {
+            CCPrepare zf;
+
+        case JCC_L:
+        case JCC_LE:
+            if (!reg) {
+                reg = tcg_temp_new();
+            }
+            /*
+             * Sum the carry-out vector and the value of the bit below the MSB;
+             * the XOR of the top two carry bits ends up in the sign bit.
+             */
+            size = s->cc_op - CC_OP_CCMPB;
+            target_ulong adj = 1ull << ((8 << size) - 2);
+            tcg_gen_add_tl(reg, cpu_cc_src, tcg_constant_tl(adj));
+            /* Now XOR in SF too.  */
+            tcg_gen_xor_tl(reg, reg, cpu_cc_src2);
+            /* And possibly OR the zero flag...  */
+            if (jcc_op == JCC_LE) {
+                goto ccmp_or_zf;
+            }
+            cc = gen_prepare_sign_nz(reg, size);
+            break;
+
+        case JCC_BE:
+            if (!reg) {
+                reg = tcg_temp_new();
+            }
+            tcg_gen_mov_tl(reg, cpu_cc_src);
+        ccmp_or_zf:
+            /* OR ZF into CF: if CPU_CC_DST is zero, set reg to all ones.  */
+            zf = gen_prepare_val_nz(cpu_cc_dst, size, true);
+            if (zf.rhs_type != CC_PREPARE_REG) {
+                zf.reg2 = tcg_constant_tl(zf.imm);
+            }
+            tcg_gen_movcond_tl(zf.cond, reg, zf.reg, zf.reg2, tcg_constant_tl(-1), reg);
+            cc = gen_prepare_sign_nz(reg, size);
+            break;
+
+        default:
+            goto slow_jcc;
+        }
+        break;
+
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
         /* Mostly used for test+jump */
         size = s->cc_op - CC_OP_LOGICB;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index cef7481fb3e..8e043150d74 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1583,7 +1583,7 @@ static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86GenFunc group1_gen[8] = {
-        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_SUB,
+        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_CMP,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group1_gen[op];
@@ -1630,8 +1630,8 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
-        [0x01] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1640,8 +1640,8 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [0x07] = X86_OP_ENTRYr(IDIV, E,b),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
-        [0x09] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
@@ -1780,8 +1780,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
     [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
     [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
-    [0x84] = X86_OP_ENTRYrr(AND, E,b, G,b),
-    [0x85] = X86_OP_ENTRYrr(AND, E,v, G,v),
+    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
+    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
@@ -1871,12 +1871,12 @@ static const X86OpEntry opcodes_root[256] = {
     [0x2E] = {},
     [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
 
-    [0x38] = X86_OP_ENTRYrr(SUB, E,b, G,b),
-    [0x39] = X86_OP_ENTRYrr(SUB, E,v, G,v),
-    [0x3A] = X86_OP_ENTRYrr(SUB, G,b, E,b),
-    [0x3B] = X86_OP_ENTRYrr(SUB, G,v, E,v),
-    [0x3C] = X86_OP_ENTRYrr(SUB, 0,b, I,b),   /* AL, Ib */
-    [0x3D] = X86_OP_ENTRYrr(SUB, 0,v, I,z),   /* rAX, Iz */
+    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b),
+    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v),
+    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b),
+    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v),
+    [0x3C] = X86_OP_ENTRYrr(CMP, 0,b, I,b),   /* AL, Ib */
+    [0x3D] = X86_OP_ENTRYrr(CMP, 0,v, I,z),   /* rAX, Iz */
     [0x3E] = {},
     [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
 
@@ -1935,8 +1935,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0x9E] = X86_OP_ENTRY0(SAHF),
     [0x9F] = X86_OP_ENTRY0(LAHF),
 
-    [0xA8] = X86_OP_ENTRYrr(AND, 0,b, I,b),   /* AL, Ib */
-    [0xA9] = X86_OP_ENTRYrr(AND, 0,v, I,z),   /* rAX, Iz */
+    [0xA8] = X86_OP_ENTRYrr(TEST, 0,b, I,b),   /* AL, Ib */
+    [0xA9] = X86_OP_ENTRYrr(TEST, 0,v, I,z),   /* rAX, Iz */
     [0xAA] = X86_OP_ENTRYwr(STOS, Y,b, 0,b),
     [0xAB] = X86_OP_ENTRYwr(STOS, Y,v, 0,v),
     /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 5a880b9760e..ba347c4e6b7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1638,6 +1638,117 @@ static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
 }
 
+/* Convert the repurposed V bits of CCMP or CTEST instructions to
+ * an EFLAGS value.
+ */
+static inline uint32_t evex_to_eflags(DisasContext *s)
+{
+    uint16_t eflags = 0;
+    eflags |= (s->evex3 & 0x08 ? CC_C | CC_P : 0);
+    eflags |= (s->evex3 & 0x10 ? CC_Z : 0);
+    eflags |= (s->evex3 & 0x20 ? CC_S : 0);
+    eflags |= (s->evex3 & 0x40 ? CC_O : 0);
+    return eflags;
+}
+
+/* If the condition COND is false, fill CC_DST/SRC/SRC2 with values that
+ * produce the flag values in DFV for CC_OP_CCMP*.  If instead COND is true,
+ * set up the flag values from CC_DST and COUT.
+ *
+ * On input, CC_DST contains the result of the subtraction or AND, which
+ * ends up in CC_DST and CC_SRC2 as well.  COUT is non-NULL for CCMP, and will
+ * be used for the output CC_SRC if COND is true; it is NULL for CTEST and
+ * will result in CC_SRC==0 (resulting in CF=AF=OF=0) is COND is true.
+ */
+static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, uint32_t dfv,
+                            MemOp ot, TCGv cout)
+{
+    target_ulong dst, src, src2;
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+
+    /* ZF from dst */
+    dst = (dfv & CC_Z) ? 0 : -1;
+
+    /* CF is the high bit of SRC, OF the XOR of the high two bits */
+    src = deposit64(0, (8 << ot) - 2, 1, !!(dfv & CC_O));
+    src ^= (dfv & CC_C) ? -1 : 0;
+
+    /*
+     * SF is the high bit of SRC2, PF the parity of the low byte.  But also
+     * ensure the value is nonzero if dfv requests zf=0.  This triggers the
+     * optimization below in some extra cases (e.g. dfv == CC_P | CC_C).
+     *
+     * Note dst is either 0 or -1 so it has even parity.
+     */
+    src2 = dst & 3;
+    src2 ^= (dfv & CC_P) ? 0 : 1;
+    src2 ^= (dfv & CC_S) ? -1 : 0;
+
+    if (cout) {
+        decode->cc_src = cout;
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src, cc.reg, cc.reg2,
+                           decode->cc_src, tcg_constant_tl(src));
+    } else if (src) {
+        decode->cc_src = tcg_temp_new();
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src, cc.reg, cc.reg2,
+                           tcg_constant_tl(0), tcg_constant_tl(src));
+    } else {
+        decode->cc_src = tcg_constant_tl(0);
+    }
+
+    if (!!dst == !!src2) {
+        /*
+         * When an actual CMP or TEST result is stored, DST will be
+         * equal to SRC2, and when the default flag value is stored,
+         * only zero/nonzero matters for DST.  If DST and SRC2
+         * are equally zero/non-zero, use the same value for both.
+         */
+        decode->cc_src2 = decode->cc_dst;
+        dst = src2;
+    } else {
+        decode->cc_src2 = tcg_temp_new();
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src2, cc.reg, cc.reg2,
+                           decode->cc_dst, tcg_constant_tl(src2));
+    }
+    tcg_gen_movcond_tl(cc.cond, decode->cc_dst, cc.reg, cc.reg2,
+                       decode->cc_dst, tcg_constant_tl(dst));
+}
+
+static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
+static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
+{
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+    TCGv cout;
+
+    switch (cond) {
+    case CCMP_T:
+        gen_SUB(s, decode);
+        return;
+    case CCMP_F:
+        decode->cc_op = CC_OP_EFLAGS;
+        decode->cc_src = tcg_constant_tl(dfv);
+        return;
+    default:
+        break;
+    }
+
+    decode->cc_op = CC_OP_CCMPB + ot;
+    decode->cc_dst = tcg_temp_new();
+    cout = tcg_temp_new();
+    tcg_gen_sub_tl(decode->cc_dst, s->T0, s->T1);
+
+    /* Compute carry-out vector of subtraction.  */
+    tcg_gen_xor_tl(cout, s->T1, decode->cc_dst);
+    tcg_gen_xor_tl(s->T0, s->T0, s->T1);
+    tcg_gen_and_tl(cout, cout, s->T0);
+    tcg_gen_xor_tl(cout, cout, decode->cc_dst);
+
+    /* src2 == dst if cond is true.  */
+    gen_dfv_movcond(s, decode, cond, dfv, ot, cout);
+}
+
 static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -3854,7 +3965,6 @@ static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -4169,6 +4279,32 @@ static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_RECHECK_TF;
 }
 
+static void gen_TEST(DisasContext *s, X86DecodedInsn *decode)
+{
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+
+    switch (cond) {
+    case CCMP_T:
+        gen_AND(s, decode);
+        return;
+    case CCMP_F:
+        decode->cc_op = CC_OP_EFLAGS;
+        decode->cc_src = tcg_constant_tl(dfv);
+        return;
+    default:
+        break;
+    }
+
+    decode->cc_op = CC_OP_CCMPB + ot;
+    decode->cc_dst = tcg_temp_new();
+    tcg_gen_and_tl(decode->cc_dst, s->T0, s->T1);
+
+    /* src=0, src2 == dst if cond is true.  */
+    gen_dfv_movcond(s, decode, cond, dfv, ot, NULL);
+}
+
 static void gen_TZCNT(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-- 
2.55.0


From 8a54d6defce9ea14963e640f2174a3553c2e0509 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 17:55:29 +0100
Subject: [PULL 28/32] target/i386/tcg: decode APX instructions

The bulk of the APX implementation, comprising new map4-specific
encodings, extensions to legacy root and 0F tables, and the
implementation of new instructions CFCMOV, PUSH2 and POP2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h             |   1 +
 target/i386/tcg/decode-new.h     |   1 +
 target/i386/tcg/excp_helper.c    |   5 +
 target/i386/tcg/decode-new.c.inc | 332 +++++++++++++++++++++++++------
 target/i386/tcg/emit.c.inc       |  62 ++++++
 5 files changed, 344 insertions(+), 57 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3f67098f11f..99cbbacadfc 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -57,6 +57,7 @@ DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_1(pause, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(raise_gpf, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 140dd5fa1c8..d8cab8d92d0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -53,6 +53,7 @@ typedef enum X86OpType {
     X86_TYPE_nop, /* modrm operand decoded but not loaded into s->T{0,1} */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
+    X86_TYPE_ZERO, /* Constant zero, for CFCMOV */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */
     X86_TYPE_1,
     X86_TYPE_2,
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 1eaa602c91d..d6410d6fc11 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -37,6 +37,11 @@ G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
     raise_exception(env, exception_index);
 }
 
+G_NORETURN void helper_raise_gpf(CPUX86State *env)
+{
+    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+}
+
 /*
  * Check nested exceptions and change to double or triple fault if
  * needed. It should only be called, if this is not an interrupt.
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8e043150d74..d3352b17fdf 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -184,6 +184,8 @@
     X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUPwr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_GROUP3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
+#define X86_OP_GROUPrr(op, op0, s0, op1, s1, ...)                 \
+    X86_OP_GROUP3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -280,8 +282,10 @@
 #define p_f3          .valid_prefix = P_F3,
 #define p_f2          .valid_prefix = P_F2,
 #define p_00_66       .valid_prefix = P_00 | P_66,
+#define p_00_f2       .valid_prefix = P_00 | P_F2,
 #define p_00_f3       .valid_prefix = P_00 | P_F3,
 #define p_66_f2       .valid_prefix = P_66 | P_F2,
+#define p_66_f3       .valid_prefix = P_66 | P_F3,
 #define p_00_66_f3    .valid_prefix = P_00 | P_66 | P_F3,
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
@@ -869,28 +873,33 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
     /*
      * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
-     * in manual, assumed to be 13 from the VEX.L0 constraint.
+     * in manual, assumed to be 13 from the VEX.L0 constraint; EVEX-APX-BMI and
+     * EVEX-APX-CMPccXADD are also pretty much the same; the difference are
+     * reflected in chk(nf0) and in the M operand type.
      */
-    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 
-    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
-    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
+    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk2(nf0, o64) cpuid(CMPCCXADD) p_66),
 };
 
-/* four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override) */
+/*
+ * four rows for no prefix, 66, F3, F2 (including 66+F2 operand size override).
+ * all VEX13 instructions extend to APX, while MOVBE/CRC32 move to EVEX map4
+ */
 static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     /*
      * MOVBE and CRC32 are incorrectly listed as always doing 32-bit operation
@@ -923,20 +932,20 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][4] = {
     [5] = {
         X86_OP_ENTRY3(BZHI, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         {},
-        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
-        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
+        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
+        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 chk(nf0) cpuid(BMI2)),
     },
     [6] = {
         {},
         X86_OP_ENTRY2(ADCX, G,y, E,y, cpuid(ADX)),
         X86_OP_ENTRY2(ADOX, G,y, E,y, cpuid(ADX)),
-        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 cpuid(BMI2)),
+        X86_OP_ENTRY3(MULX, /* B,y, */ G,y, E,y, 2,y, vex13 chk(nf0) cpuid(BMI2)),
     },
     [7] = {
         X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
-        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 sextT0 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 chk(nf0) cpuid(BMI1)),
+        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 chk(nf0) sextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 chk(nf0) zextT0 cpuid(BMI1)),
     },
 };
 
@@ -1025,7 +1034,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
 
     [0xdf] = X86_OP_ENTRY3(VAESKEYGEN, V,dq, W,dq, I,b,  vex4 cpuid(AES) p_66),
 
-    [0xF0] = X86_OP_ENTRY3(RORX, G,y, E,y, I,b, vex13 cpuid(BMI2) p_f2),
+    [0xF0] = X86_OP_ENTRY3(RORX,       G,y, E,y, I,b,    vex13 chk(nf0) cpuid(BMI2) p_f2),
 };
 
 static void decode_0F3A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
@@ -1590,9 +1599,9 @@ static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
     if (op == 7) {
         /* prevent writeback for CMP */
-        entry->op1 = entry->op0;
         entry->op0 = X86_TYPE_None;
         entry->s0 = X86_SIZE_None;
+        entry->vex_class = X86_EVEX_APX_cmp;
     } else {
         entry->special = X86_SPECIAL_HasLock;
     }
@@ -1619,6 +1628,9 @@ static void decode_group2(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group2_gen[op];
+    if (op == 2 || op == 3) {
+        entry->check |= X86_CHECK_nf0;
+    }
     if (op == 7) {
         entry->ext1 = X86_EXT_Signed;
     } else {
@@ -1630,24 +1642,24 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
-        [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
-        [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
-        [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
-        [0x05] = X86_OP_ENTRYrr(IMUL,E,b, 0,b, sextT0),
-        [0x06] = X86_OP_ENTRYr(DIV,  E,b),
-        [0x07] = X86_OP_ENTRYr(IDIV, E,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
+        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b, evex_apx_cmp p_00),
+        [0x02] = X86_OP_ENTRYwr(NOT,  B,b, E,b, evex_apx p_00 chk(nf0) lock),
+        [0x03] = X86_OP_ENTRYwr(NEG,  B,b, E,b, evex_apx p_00 lock),
+        [0x04] = X86_OP_ENTRYrr(MUL,  E,b, 0,b, evex_apx p_00 zextT0),
+        [0x05] = X86_OP_ENTRYrr(IMUL, E,b, 0,b, evex_apx p_00 sextT0),
+        [0x06] = X86_OP_ENTRYr(DIV,   E,b,      evex_apx p_00),
+        [0x07] = X86_OP_ENTRYr(IDIV,  E,b,      evex_apx p_00),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
-        [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
-        [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
-        [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
-        [0x0d] = X86_OP_ENTRYrr(IMUL,E,v, 0,v, sextT0),
-        [0x0e] = X86_OP_ENTRYr(DIV,  E,v),
-        [0x0f] = X86_OP_ENTRYr(IDIV, E,v),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
+        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z, evex_apx_cmp p_00_66),
+        [0x0a] = X86_OP_ENTRYwr(NOT,  B,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+        [0x0b] = X86_OP_ENTRYwr(NEG,  B,v, E,v, evex_apx p_00_66 lock),
+        [0x0c] = X86_OP_ENTRYrr(MUL,  E,v, 0,v, evex_apx p_00_66 zextT0),
+        [0x0d] = X86_OP_ENTRYrr(IMUL, E,v, 0,v, evex_apx p_00_66 sextT0),
+        [0x0e] = X86_OP_ENTRYr(DIV,   E,v,      evex_apx p_00_66),
+        [0x0f] = X86_OP_ENTRYr(IDIV,  E,v,      evex_apx p_00_66),
     };
 
     int w = (*b & 1);
@@ -1660,12 +1672,12 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
 {
     static const X86OpEntry opcodes_grp4_5[16] = {
         /* 0xfe */
-        [0x00] = X86_OP_ENTRY1(INC,     E,b,                           lock),
-        [0x01] = X86_OP_ENTRY1(DEC,     E,b,                           lock),
+        [0x00] = X86_OP_ENTRYwr(INC,    B,b, E,b,                      evex_apx p_00 lock),
+        [0x01] = X86_OP_ENTRYwr(DEC,    B,b, E,b,                      evex_apx p_00 lock),
 
         /* 0xff */
-        [0x08] = X86_OP_ENTRY1(INC,     E,v,                           lock),
-        [0x09] = X86_OP_ENTRY1(DEC,     E,v,                           lock),
+        [0x08] = X86_OP_ENTRYwr(INC,    B,v, E,v,                      evex_apx p_00_66 lock),
+        [0x09] = X86_OP_ENTRYwr(DEC,    B,v, E,v,                      evex_apx p_00_66 lock),
         [0x0a] = X86_OP_ENTRYr(CALL_m,  E,f64,                         zextT0),
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
@@ -1776,10 +1788,11 @@ static const X86OpEntry opcodes_root[256] = {
     [0x76] = X86_OP_ENTRYr(Jcc, J,b),
     [0x77] = X86_OP_ENTRYr(Jcc, J,b),
 
-    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
-    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
-    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
-    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
+    /* decode_group1 is shared with EVEX map4.  */
+    [0x80] = X86_OP_GROUP3(group1, B,b, E,b, I,b),
+    [0x81] = X86_OP_GROUP3(group1, B,v, E,v, I,z),
+    [0x82] = X86_OP_GROUP3(group1, B,b, E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP3(group1, B,v, E,v, I,b),
     [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
     [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
@@ -1812,8 +1825,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
     [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
 
-    [0xC0] = X86_OP_GROUP2(group2, E,b, I,b),
-    [0xC1] = X86_OP_GROUP2(group2, E,v, I,b),
+    /* decode_group2 is shared with EVEX map4.  */
+    [0xC0] = X86_OP_GROUP3(group2, B,b, E,b, I,b),
+    [0xC1] = X86_OP_GROUP3(group2, B,v, E,v, I,b),
     [0xC2] = X86_OP_ENTRYr(RET, I,w),
     [0xC3] = X86_OP_ENTRY0(RET),
     [0xC4] = X86_OP_ENTRY3(LES, G,z, EM,p, None, None, chk(i64)),
@@ -1821,10 +1835,11 @@ static const X86OpEntry opcodes_root[256] = {
     [0xC6] = X86_OP_GROUP3(group11, E,b, I,b, None, None), /* reg=000b */
     [0xC7] = X86_OP_GROUP3(group11, E,v, I,z, None, None), /* reg=000b */
 
-    [0xD0] = X86_OP_GROUP1(group2, E,b),
-    [0xD1] = X86_OP_GROUP1(group2, E,v),
-    [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
-    [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
+    /* decode_group2 is shared with EVEX map4.  */
+    [0xD0] = X86_OP_GROUPwr(group2, B,b, E,b),
+    [0xD1] = X86_OP_GROUPwr(group2, B,v, E,v),
+    [0xD2] = X86_OP_GROUP3(group2, B,b, E,b, 1,b), /* CL */
+    [0xD3] = X86_OP_GROUP3(group2, B,v, E,v, 1,b), /* CL */
     [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
     [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
     [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
@@ -2054,9 +2069,203 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
 
+static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    uint8_t modrm = get_modrm(s, env);
+    int mod = (modrm >> 6) & 3;
+
+    static const X86OpEntry setcc =
+        X86_OP_ENTRYw(SETcc, E,b, evex_apx_zu chk(nf0) p_f2);
+
+    /*
+     * All EVEX-promoted register-destination conditional moves (all CFCMOV
+     * cases except "CFCMOV rm, r", and three-operand CMOV) have zero-upper
+     * Note that this is specific to CMOV/CFCMOV, and not ZU!
+     *
+     * For NDD=0, NF represents the direction.  For NDD=1, NF represents fault
+     * suppression.
+     */
+    static const X86OpEntry cfcmov_nd0[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  G,v, ZERO,v, M,v, p_00_66 evex_apx zextwT0),
+            X86_OP_ENTRY3(CMOVcc,       G,v, ZERO,v, E,v, p_00_66 evex_apx zextwT0),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRYwr(CFCMOVcc_st, M,v, G,v,         p_00_66 evex_apx),
+            X86_OP_ENTRY3(CMOVcc,       E,v, ZERO,v, G,v, p_00_66 evex_apx zextwT0),
+        },
+    };
+    static const X86OpEntry cfcmov_nd1[2][2] = {
+        { /* NF=0 */
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
+        },
+        { /* NF=1 */
+            X86_OP_ENTRY3(CFCMOVcc_ld,  B,v, G,v, M,v,    p_00_66 evex_apx zextwT0),
+            X86_OP_ENTRY3(CMOVcc,       B,v, G,v, E,v,    p_00_66 evex_apx zextwT0),
+        },
+    };
+
+    if (s->prefix & PREFIX_REPNZ) {
+        *entry = setcc;
+        if (EVEX_APX_ND(s)) {
+            entry->s1 = X86_SIZE_q; /* optimization for zu */
+        }
+    } else {
+        *entry = (EVEX_APX_ND(s) ? cfcmov_nd1 : cfcmov_nd0)[EVEX_APX_NF(s)][mod == 3];
+    }
+}
+
+static void decode_EVEX4_MOVBE(DisasContext *s, CPUX86State *env,
+                               X86OpEntry *entry, uint8_t *b)
+{
+    entry->gen = gen_MOVBE;
+    if ((get_modrm(s, env) >> 6) != 3) {
+        /* skip the load/store to be able to use MO_BE in code generation.  */
+        if (entry->op0 == X86_TYPE_E) {
+            entry->op0 = X86_TYPE_M;
+        } else {
+            entry->op1 = X86_TYPE_M;
+        }
+    }
+}
+
+static void decode_EVEX4_66(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    entry->gen = (s->prefix & PREFIX_DATA) ? gen_ADCX : gen_ADOX;
+}
+
+static void decode_EVEX4_8F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 0) {
+        entry->gen = gen_POP2;
+    } else {
+        *entry = UNKNOWN_OPCODE;
+    }
+}
+
+static void decode_EVEX4_FF(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry push2 =
+        X86_OP_ENTRYrr(PUSH2, B,d64, R,d64,     evex_apx_pp2 p_00);
+
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op == 6) {
+        *entry = push2;
+    } else {
+        decode_group4_5(s, env, entry, b);
+    }
+}
+
+/*
+ * Missing: ENQCMD, ENQCMDS, INVEPT, INVPCID, INVVPID,
+ * KMOVD, KMOVW, KMOVD, KMOVQ, MOVDIR64B, MOVDIRI, URDMSR,
+ * UWRMSR, WRSSD, WRSSQ, WRUSSD, WRUSSQ, LDTILECFG, STTILECFG,
+ * TILELOADD, TILELOADDDT1, TILESTORED.
+ */
+static const X86OpEntry opcodes_EVEX_map4[256] = {
+    [0x00] = X86_OP_ENTRY3(ADD, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x01] = X86_OP_ENTRY3(ADD, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x02] = X86_OP_ENTRY3(ADD, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x03] = X86_OP_ENTRY3(ADD, B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x08] = X86_OP_ENTRY3(OR, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x09] = X86_OP_ENTRY3(OR, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x0A] = X86_OP_ENTRY3(OR, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x0B] = X86_OP_ENTRY3(OR, B,v, G,v, E,v, evex_apx p_00_66 lock),
+
+    [0x10] = X86_OP_ENTRY3(ADC, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x11] = X86_OP_ENTRY3(ADC, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x12] = X86_OP_ENTRY3(ADC, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x13] = X86_OP_ENTRY3(ADC, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x18] = X86_OP_ENTRY3(SBB, B,b, E,b, G,b, evex_apx p_00 chk(nf0) lock),
+    [0x19] = X86_OP_ENTRY3(SBB, B,v, E,v, G,v, evex_apx p_00_66 chk(nf0) lock),
+    [0x1A] = X86_OP_ENTRY3(SBB, B,b, G,b, E,b, evex_apx p_00 chk(nf0) lock),
+    [0x1B] = X86_OP_ENTRY3(SBB, B,v, G,v, E,v, evex_apx p_00_66 chk(nf0) lock),
+
+    [0x20] = X86_OP_ENTRY3(AND,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x21] = X86_OP_ENTRY3(AND,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x22] = X86_OP_ENTRY3(AND,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x23] = X86_OP_ENTRY3(AND,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x24] = X86_OP_ENTRY4(SHLD, B,v, E,v, G,v, evex_apx p_00_66),
+    [0x28] = X86_OP_ENTRY3(SUB,  B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x29] = X86_OP_ENTRY3(SUB,  B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x2A] = X86_OP_ENTRY3(SUB,  B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x2B] = X86_OP_ENTRY3(SUB,  B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x2C] = X86_OP_ENTRY4(SHRD, B,v, E,v, G,v, evex_apx p_00_66),
+
+    [0x30] = X86_OP_ENTRY3(XOR, B,b, E,b, G,b, evex_apx p_00 lock),
+    [0x31] = X86_OP_ENTRY3(XOR, B,v, E,v, G,v, evex_apx p_00_66 lock),
+    [0x32] = X86_OP_ENTRY3(XOR, B,b, G,b, E,b, evex_apx p_00 lock),
+    [0x33] = X86_OP_ENTRY3(XOR, B,v, G,v, E,v, evex_apx p_00_66 lock),
+    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b, evex_apx_cmp p_00),
+    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v, evex_apx_cmp p_00_66),
+    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b, evex_apx_cmp p_00),
+    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v, evex_apx_cmp p_00_66),
+
+    [0x40] = X86_OP_GROUP0(EVEX4cc),
+    [0x41] = X86_OP_GROUP0(EVEX4cc),
+    [0x42] = X86_OP_GROUP0(EVEX4cc),
+    [0x43] = X86_OP_GROUP0(EVEX4cc),
+    [0x44] = X86_OP_GROUP0(EVEX4cc),
+    [0x45] = X86_OP_GROUP0(EVEX4cc),
+    [0x46] = X86_OP_GROUP0(EVEX4cc),
+    [0x47] = X86_OP_GROUP0(EVEX4cc),
+    [0x48] = X86_OP_GROUP0(EVEX4cc),
+    [0x49] = X86_OP_GROUP0(EVEX4cc),
+    [0x4A] = X86_OP_GROUP0(EVEX4cc),
+    [0x4B] = X86_OP_GROUP0(EVEX4cc),
+    [0x4C] = X86_OP_GROUP0(EVEX4cc),
+    [0x4D] = X86_OP_GROUP0(EVEX4cc),
+    [0x4E] = X86_OP_GROUP0(EVEX4cc),
+    [0x4F] = X86_OP_GROUP0(EVEX4cc),
+
+    [0x60] = X86_OP_GROUPwr(EVEX4_MOVBE,  G,v, E,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x61] = X86_OP_GROUPwr(EVEX4_MOVBE,  E,v, G,v,     evex_apx cpuid(MOVBE) chk(nf0) p_00_66),
+    [0x66] = X86_OP_GROUP3(EVEX4_66, B,y, G,y, E,y,     evex_apx cpuid(ADX) chk(nf0) p_66_f3),
+    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z,        evex_apx_zu sextT0 p_00_66),
+    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b,        evex_apx_zu sextT0 p_00_66),
+
+    [0x80] = X86_OP_GROUP3(group1,   B,b, E,b, I,b,     evex_apx p_00),
+    [0x81] = X86_OP_GROUP3(group1,   B,v, E,v, I,z,     evex_apx p_00_66),
+    [0x83] = X86_OP_GROUP3(group1,   B,v, E,v, I,b,     evex_apx p_00_66),
+    [0x84] = X86_OP_ENTRYrr(TEST,    E,b, G,b,          evex_apx_cmp p_00_66),
+    [0x85] = X86_OP_ENTRYrr(TEST,    E,v, G,v,          evex_apx_cmp p_00_66),
+    [0x88] = X86_OP_ENTRYwr(POPCNT,  G,v, E,v,          evex_apx cpuid(POPCNT) zextT0 p_00_66),
+    [0x8F] = X86_OP_GROUPw(EVEX4_8F, R,d64, /* B,d64 */ evex_apx_pp2 p_00),
+
+    [0xA4] = X86_OP_ENTRY4(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xA5] = X86_OP_ENTRY3(SHLD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xAC] = X86_OP_ENTRY4(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    [0xAD] = X86_OP_ENTRY3(SHRD,     B,v, E,v, G,v,     evex_apx p_00_66),
+    /*
+     * Note that unlike the non-APX version this cannot place the Ev
+     * operand in T0, because Bv rewrites op1 to OP_TYPE_2op if NDD=0.
+     */
+    [0xAF] = X86_OP_ENTRY3(IMUL3,    B,v, G,v, E,v,     evex_apx sextT0 p_00_66),
+
+    [0xC0] = X86_OP_GROUP3(group2,   B,b, E,b, I,b,     evex_apx p_00),
+    [0xC1] = X86_OP_GROUP3(group2,   B,v, E,v, I,b,     evex_apx p_00_66),
+
+    [0xD0] = X86_OP_GROUPwr(group2,  B,b, E,b,          evex_apx p_00),
+    [0xD1] = X86_OP_GROUPwr(group2,  B,v, E,v,          evex_apx p_00_66),
+    [0xD2] = X86_OP_GROUP3(group2,   B,b, E,b, 1,b,     evex_apx p_00), /* CL */
+    [0xD3] = X86_OP_GROUP3(group2,   B,v, E,v, 1,b,     evex_apx p_00_66), /* CL */
+
+    [0xF0] = X86_OP_ENTRY2(CRC32,    G,d, E,b,          evex_apx cpuid(SSE42) chk(nf0) p_00),
+    [0xF1] = X86_OP_ENTRY2(CRC32,    G,d, E,v,          evex_apx cpuid(SSE42) chk(nf0) p_00_66),
+    [0xF4] = X86_OP_ENTRYwr(TZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
+    [0xF5] = X86_OP_ENTRYwr(LZCNT,   G,v, E,v,          evex_apx zextT0 p_00_66),
+    [0xF6] = X86_OP_GROUP1(group3,   E,b),
+    [0xF7] = X86_OP_GROUP1(group3,   E,v),
+    [0xFE] = X86_OP_GROUP1(group4_5, E,b),
+    [0xFF] = X86_OP_GROUP1(EVEX4_FF, E,v),
+};
+
 static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    *entry = UNKNOWN_OPCODE;
+    *b = x86_ldub_code(env, s);
+    *entry = opcodes_EVEX_map4[*b];
 }
 #endif
 
@@ -2073,6 +2282,10 @@ static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entr
 #undef vex11
 #undef vex12
 #undef vex13
+#undef evex_apx
+#undef evex_apx_cmp
+#undef evex_apx_pp2
+#undef evex_apx_zu
 
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
@@ -2526,6 +2739,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->n = type - X86_TYPE_ES;
         op->unit = X86_OP_SEG;
         break;
+
+    case X86_TYPE_ZERO:
+        op->unit = X86_OP_IMM;
+        decode->immediate = op->imm = 0;
+        break;
     }
 
     return true;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ba347c4e6b7..c353d97ee74 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1633,6 +1633,30 @@ static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
 }
 
+#ifdef TARGET_X86_64
+static void gen_CFCMOVcc_ld(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[2].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_ld_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+
+static void gen_CFCMOVcc_st(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *label_false = gen_new_label();
+    int cond = decode->b & 0xf;
+    MemOp ot = decode->op[0].ot;
+
+    gen_jcc_noeob(s, cond ^ 1, label_false);
+    gen_op_st_v(s, ot, s->T0, s->A0);
+    gen_set_label(label_false);
+}
+#endif
+
 static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
@@ -3137,6 +3161,24 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_POP2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+
+    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
+    tcg_gen_qemu_ld_i128(t, s->A0, s->mem_index,
+                         MO_LE | MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR);
+    tcg_gen_extr_i128_i64(cpu_regs[s->vex_v], s->T0, t);
+    gen_pop_update(s, MO_128);
+}
+#endif
+
 static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
 {
     X86DecodedOp *op = &decode->op[0];
@@ -3334,6 +3376,26 @@ static void gen_PSLLDQ_i(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+#ifdef TARGET_X86_64
+static void gen_PUSH2(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGLabel *aligned = gen_new_label();
+    TCGv_i128 t = tcg_temp_new_i128();
+    TCGv new_esp = tcg_temp_new();
+
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ESP], 15, aligned);
+    gen_helper_raise_gpf(tcg_env);
+    gen_set_label(aligned);
+
+    tcg_gen_subi_tl(new_esp, cpu_regs[R_ESP], 16);
+    gen_lea_ss_ofs(s, s->A0, new_esp, 0);
+    tcg_gen_concat_i64_i128(t, s->T1, s->T0);
+    tcg_gen_qemu_st_i128(t, s->A0, s->mem_index,
+                         MO_LE | MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR);
+    gen_op_mov_reg_v(s, mo_stacksize(s), R_ESP, new_esp);
+}
+#endif
+
 static void gen_PUSH(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_push_v(s, s->T0);
-- 
2.55.0


From 573e36c9ca0fa28cbbcfd775b7311b1f1e2f11e9 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 23 Nov 2025 15:04:30 +0100
Subject: [PULL 29/32] target/i386/tcg: optimize CCMP

If possible, modify conditionally the input arguments to generate the
flags requested by dfv; this way CCMP can use CC_OP_SUB* instead of having
to compute the carry-out vector by hand.  This happens relatively often
for dfv=0, and also for dfv=sf for code produced by clang.

Of the combinations that cannot be optimized, both GCC and clang generate
dfv=zf.  GCC also generates OS and OSZ.

Do not bother doing this for CTEST; the savings are modest because it
does not need complex code to compute the carry-out vector (CC_SRC
is always 0).  In addition, trivially replacing the arguments to the AND
would only support dfv=0 (produced by -2 & 2) or dfv=S (produced by -2 &
-2), because TEST cannot produce any value where CF or OF are not zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 62 +++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c353d97ee74..531398d356b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1738,6 +1738,55 @@ static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, u
                        decode->cc_dst, tcg_constant_tl(dst));
 }
 
+static bool gen_ccmp_movcond(DisasContext *s, int cond, uint32_t dfv, MemOp ot)
+{
+    target_ulong op0, op1, max_int;
+
+    assert(cond != CCMP_F);
+    if (cond == CCMP_T) {
+        return true;
+    }
+
+    /*
+     * For some values of dfv, it's possible to overwrite operands
+     * instead of using CC_OP_CCMP.  The weird "16"s are to set AF==0.
+     */
+    max_int = MAKE_64BIT_MASK(0, (8 << ot) - 1);
+    switch(dfv) {
+    case 0:
+        op0 = 1, op1 = 0;
+        break;
+    case CC_P|CC_C:
+        op0 = 1, op1 = -16;
+        break;
+    case CC_S:
+        op0 = -3, op1 = 0;
+        break;
+    case CC_S|CC_P|CC_C:
+        op0 = 0, op1 = 16;
+        break;
+    case CC_O:
+        /*
+         * While for >8-bit results -max_int has 1 in the lower byte, for 8-bit
+         * results -max_int is 0x81, so it flips the parity flag.  Compensate
+         * in op1.
+         */
+        op0 = -max_int, op1 = 16 + (ot == MO_8);
+        break;
+    case CC_O|CC_S|CC_P|CC_C:
+        /* Same here. */
+        op0 = max_int, op1 = -1 - (ot == MO_8);
+        break;
+    default:
+        return false;
+    }
+
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2, s->T0, tcg_constant_tl(op0));
+    tcg_gen_movcond_tl(cc.cond, s->T1, cc.reg, cc.reg2, s->T1, tcg_constant_tl(op1));
+    return true;
+}
+
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -1746,16 +1795,15 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[1].ot;
     TCGv cout;
 
-    switch (cond) {
-    case CCMP_T:
-        gen_SUB(s, decode);
-        return;
-    case CCMP_F:
+    if (cond == CCMP_F) {
         decode->cc_op = CC_OP_EFLAGS;
         decode->cc_src = tcg_constant_tl(dfv);
         return;
-    default:
-        break;
+    }
+    if (gen_ccmp_movcond(s, cond, dfv, ot)) {
+        /* Including CCMP_T, aka "normal" CMP.  */
+        gen_SUB(s, decode);
+        return;
     }
 
     decode->cc_op = CC_OP_CCMPB + ot;
-- 
2.55.0


From 6946a79716ceb17e8933f5745c6cc5e170b45191 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 16:36:38 +0200
Subject: [PULL 30/32] target/i386: extract computation of no-autoenable
 features

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 05d94cb46c6..02bc804d197 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9723,13 +9723,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      */
     if (xcc->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
-            /* Override only features that weren't set explicitly
-             * by the user.
-             */
-            env->features[w] |=
-                x86_cpu_get_supported_feature_word(cpu, w) &
-                ~env->user_features[w] &
-                ~feature_word_info[w].no_autoenable_flags;
+            /* Override only features that weren't set explicitly by the user.  */
+            uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+
+            env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
 
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
-- 
2.55.0


From 58d39d4555326c8f4fc77d717ab4e1b0fa3d8052 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 23 Nov 2025 19:44:24 +0100
Subject: [PULL 31/32] target/i386/tcg: mark APX as supported

Finally allow TCG to set the CPUID bit for the APXF feature.  The effect
of APX is about 0.5% larger binaries and about 1% less TCG ops.
QEMU seems to produce about 1% *more* assembly instructions, because
the optimizer could already produce roughly the same ops as NDD or
NF instructions, and the new PUSH2/POP2 instructions include a stack
alignment check that isn't there in non-APX code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/x86_64-bsd-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 target/i386/cpu.c                     | 34 ++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d754186347f..26b7cfad4e2 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= i386-64bit.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 7f9527fd1de..cad68746bdb 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 02bc804d197..74eebeabd7a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1005,7 +1005,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
 #define TCG_7_1_ECX_FEATURES 0
-#define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
@@ -1017,7 +1017,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
-#define TCG_29_0_EBX_FEATURES 0
+#define TCG_29_0_EBX_FEATURES CPUID_29_0_EBX_APX_NCI_NDD_NF
 #define TCG_1E_1_EAX_FEATURES 0
 #define TCG_24_1_ECX_FEATURES 0
 
@@ -1554,7 +1554,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -9722,9 +9722,37 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * inside x86_cpu_parse_featurestr() too.
      */
     if (xcc->max_features) {
+        /*
+         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
+         * disable one---prefer APX if none was chosen explicitly.
+         */
+        uint64_t feat7_1_edx = env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+            ? env->features[FEAT_7_1_EDX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX);
+        uint64_t feat7_0_ebx = env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX
+            ? env->features[FEAT_7_0_EBX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_0_EBX);
+
+        bool apx = feat7_1_edx & CPUID_7_1_EDX_APXF;
+        bool mpx = feat7_0_ebx & CPUID_7_0_EBX_MPX;
+        if (apx && mpx) {
+            if (env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+                || !(env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX)) {
+                mpx = false;
+            } else {
+                apx = false;
+            }
+        }
+
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly by the user.  */
             uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+            if (w == FEAT_7_1_EDX && mpx) {
+                no_autoenable_flags |= CPUID_7_1_EDX_APXF;
+            }
+            if (w == FEAT_7_0_EBX && apx) {
+                no_autoenable_flags |= CPUID_7_0_EBX_MPX;
+            }
 
             env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
-- 
2.55.0


From 3e9fe057ae0b4828779a5dca3d435880ca2b2c68 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 31 Aug 2026 12:59:17 +0200
Subject: [PULL 32/32] agents: Add a skill for finding your way around QEMU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As a side effect, establish scaffolding for the .agents/.claude/.gemini
directories, as a base for future patches to build on.

Some parts of this skill are based on
https://lore.kernel.org/r/20260529101437.410181-4-alex.bennee@linaro.org/.

Co-authored-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .agents/skills/qemu-codebase/SKILL.md | 59 +++++++++++++++++++++++++++
 .claude/skills                        |  1 +
 .gemini/skills                        |  1 +
 3 files changed, 61 insertions(+)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills

diff --git a/.agents/skills/qemu-codebase/SKILL.md b/.agents/skills/qemu-codebase/SKILL.md
new file mode 100644
index 00000000000..559f0075976
--- /dev/null
+++ b/.agents/skills/qemu-codebase/SKILL.md
@@ -0,0 +1,59 @@
+---
+name: qemu-codebase
+description: >-
+  Route broad or unfamiliar QEMU tasks to relevant subsystem,
+  documentation, build, and test entry points. Do not use for work
+  where the files, subsystems and abstractions are already known.
+---
+
+# Finding your way around QEMU
+
+Use this skill for orientation, not as a general prerequisite for QEMU
+work. Start from the code and nearby tests when the request already
+identifies a file, function, subsystem, or commit.
+
+## Finding the subsystem
+
+For a broad request, use `grep`/`rg` and `MAINTAINERS` to locate
+likely code and subsystem boundaries. Use `scripts/get_maintainer.pl
+--nogit -f <path>` when the maintainance status matters.  Read
+`docs/devel/codebase.rst` only when the top-level directory or execution
+mode is unclear.
+
+## Focused documentation
+
+Read documentation only when the task involves the corresponding
+abstraction or its invariants:
+
+- QOM types, properties, composition, or lifecycle: `docs/devel/qom.rst`.
+- qdev realize/unrealize, buses, GPIO, or hotplug: `docs/devel/qdev-api.rst`.
+- Device or machine reset behavior: `docs/devel/reset.rst`.
+- MemoryRegion topology, transactions, mappings, or dirty tracking:
+  `docs/devel/memory.rst`.
+- TCG frontend/backend boundaries or IR: `docs/devel/tcg.rst`; for the TCG IR,
+  also read `docs/devel/tcg-ops.rst`.
+- RCU lifetime, grace periods, or atomic ordering: `docs/devel/rcu.rst` and
+  `docs/devel/atomics.rst`.
+- AioContext migration, iothreads, or block/device concurrency:
+  `docs/devel/multiple-iothreads.rst`.
+- BQL ownership or code running outside the BQL: `include/qemu/main-loop.h`
+  and nearby callers.
+
+Prefer source declarations and nearby callers when they answer the
+question more directly. A `kernel-doc::` directive points to comments
+in the source; inspect those comments without building the documentation.
+
+## Building and testing
+
+QEMU builds out of tree and a checkout may have several build
+directories. When building or testing, find the applicable configured
+tree from context (for example, directories containing `meson-info`)
+instead of assuming one. Use that build directory's `run` wrapper for
+`meson test` so its environment and Python paths are active.
+
+For C changes, run `scripts/checkpatch.pl` on the patch; for Rust changes,
+consider `make clippy` and `make rustfmt`.
+
+Choose the narrowest test that exercises the behavior. Use `make
+check-unit`, `make check-qtest`, `make check-functional`, or `make
+check-rust` only when a suite-level run is justified.
diff --git a/.claude/skills b/.claude/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.claude/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
diff --git a/.gemini/skills b/.gemini/skills
new file mode 120000
index 00000000000..a7540c24423
--- /dev/null
+++ b/.gemini/skills
@@ -0,0 +1 @@
+.agents/skills/
\ No newline at end of file
-- 
2.55.0


