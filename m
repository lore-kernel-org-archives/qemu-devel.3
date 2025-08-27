Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9992ACA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4hP-0000sW-QH; Tue, 26 Aug 2025 21:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hF-0000Uu-3i
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4h3-0008UX-R3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so2236940b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257069; x=1756861869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33SwRhUpnCZVmtsdmEpjLuwcIJnEcVUmVsI6FJrSej8=;
 b=DJGsbspYxumSlcZavs6lvJ7KXYeh6HZYlW5f/WqnxBMc4T8pwy2eIDHjxS4jZZv3I2
 fNGDQ5lHynBTYtDs/G3pgeKSiqgqWpPzpiIPkt3HV87quRgfRBTM17csk1rLG56Eb5Q2
 W0C3C/nyFOTsz/ewgZj1mtaE/gZ9J7NV//yGiaQznDKwCd7f+RWxdj/UBBD1I6Sb6qlb
 EBdbSh9PkhPrVqaz1Yk0nXKxu2gKBdOi26q7z5HCEDy076Uwhj84jQbXRU/60y/PJ0S7
 OnNDxFharnA5h5XOt5vtsxYr39fhQELfWISZtcHYaFd9TIPQbdfwhvW7MXoTA+gXHZyM
 3+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257069; x=1756861869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33SwRhUpnCZVmtsdmEpjLuwcIJnEcVUmVsI6FJrSej8=;
 b=tyoDfZHfQwqnyIraJZCxckrs6AHnu3aIoAOMAsLdhq19pslwmuEUq2StbragHpa1XX
 A6j2vDs4F4qMRpTgNzgzRxrA5dpo2oIk3b1Zw6yY9NOZC60ERTXcL3K5VyZYU6MBxw7A
 +a5SGHnwwXDsy1SIdigKEFknUkVKLc/+paY5+AmGYgbFsDETBk3t8dqpWeXY7vkEcmjr
 N6ki7ETXOyLKu+JIvpCbp1j4CrDMf8jlBH5SY+PXonrHExm2LqzR2+pHpspHftiyU1WR
 FSUqPFxQs6OuMqvw8GU1WYcABHxSW2jIWiOa0qo+lnNQL/yujHjGzTEXIEA1gWHRTDme
 Du8g==
X-Gm-Message-State: AOJu0YyIi4Vjgx3liQJDDG4OEmzVjA/BrNjVJxnIJH7xez+k+tUh/iQl
 IKiAHMEQrGOxjvPHQRea1NYjnUobsz2SuJedYMSxDkSObnL+vRIrs1lAwf01/JHt/7VUrtiQH9G
 /TibCu7w=
X-Gm-Gg: ASbGnctbukIG9xdoWH3bN/VEsGgDsC3nPDQ+UD48eebmjvUevR0Khn9OoEq5qhn30j6
 PB900yIIBGs1wxNtagd6qqVSfquRMqzmNpKbFtMsPf2iB7xPQhwDt2uj8Ex7pjBl63dfwIBnBU/
 B3g2bJgHAoljj3uM3bvVo0Z5bl0t9EKXmWgqH/ssALcEJLDebNtNpRcF1T6FhOMvQLmOzgY02qc
 pEjLhX/urpFKghgidPdpEO7NFdUJzAdBPqw7LDPLYGZG5XRSWP3C+IyQcR97moyV4Q7ODhHjNxq
 30KelPp43DPUx6KEpL+T7IdcQwRfdyZoSKntO6TrZ3FAj9O/k0nc+EZb0S7y9v0GMz9cedLU/aV
 EnR89FTmPeZOriq2JlgEurC2m+fp2GawhKTHb
X-Google-Smtp-Source: AGHT+IFe2qQByeCozQocG/gr5aueezml33ysF1lPbjUXkH7x9ShSr0vPBp6VxfjTye2S9Lfb64WdIw==
X-Received: by 2002:a05:6a20:918d:b0:243:78a:826b with SMTP id
 adf61e73a8af0-24340dca3b6mr28749875637.49.1756257069439; 
 Tue, 26 Aug 2025 18:11:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 39/61] target/arm: Update ARMCPRegInfo for 128-bit sysregs
Date: Wed, 27 Aug 2025 11:04:30 +1000
Message-ID: <20250827010453.4059782-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Add ARM_CP_128BIT for type and functions describing 128-bit access.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 9818be4429..90f14dbb18 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -136,6 +136,8 @@ enum {
      * identically to the normal one, other than FGT trapping handling.)
      */
     ARM_CP_ADD_TLBI_NXS          = 1 << 21,
+    /* Flag: For ARM_CP_STATE_AA64, sysreg is 128-bit. */
+    ARM_CP_128BIT                = 1 << 22,
 };
 
 /*
@@ -178,6 +180,10 @@ enum {
 #define CP_REG_AA32_NS_SHIFT     29
 #define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
 
+/* Distinguish 64-bit and 128-bit views of AArch64 system registers. */
+#define CP_REG_AA64_128BIT_SHIFT 30
+#define CP_REG_AA64_128BIT_MASK  (1 << CP_REG_AA64_128BIT_SHIFT)
+
 /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
 #define CP_REG_AA32_64BIT_SHIFT  15
 #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
@@ -849,6 +855,9 @@ typedef struct ARMCPRegInfo ARMCPRegInfo;
 typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *ri);
 typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value);
+typedef Int128 CPRead128Fn(CPUARMState *env, const ARMCPRegInfo *opaque);
+typedef void CPWrite128Fn(CPUARMState *env, const ARMCPRegInfo *opaque,
+                          Int128 value);
 /* Access permission check functions for coprocessor registers. */
 typedef CPAccessResult CPAccessFn(CPUARMState *env,
                                   const ARMCPRegInfo *ri,
@@ -992,6 +1001,13 @@ struct ARMCPRegInfo {
      * fieldoffset is 0 then no reset will be done.
      */
     CPResetFn *resetfn;
+
+    /* For ARM_CP_128BIT, when accessed via MRRS/MSRR. */
+    CPAccessFn *access128fn;
+    CPRead128Fn *read128fn;
+    CPWrite128Fn *write128fn;
+    CPRead128Fn *raw_read128fn;
+    CPWrite128Fn *raw_write128fn;
 };
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
@@ -1061,6 +1077,9 @@ void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
  */
 static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
 {
+    if (ri->type & ARM_CP_128BIT) {
+        return MO_128;
+    }
     return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
             ? MO_64 : MO_32);
 }
-- 
2.43.0


