Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2398CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8c-0002S2-Jc; Sat, 30 Aug 2025 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtic-0000Bx-4U
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:40:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtiY-0004bB-Hf
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:40:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3d118d8fa91so9273f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756453211; x=1757058011; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vneba+jHxulAXbnulQmkNF8jDWmbZWM/iro9XrV3cMw=;
 b=pb9qzCQvQwiN8mrW0sP+n8CHdQFxW6EUWszkY7o2Fj9/RBfKzfKQU8mANKxw23UsLt
 GOo0v7fsoTdPhf8rO/HPNzSOjZ1yk2kxS2286fUrqYz7JZqspU+AMabxSdGlq8mf9Vr/
 o1wpLFZIdwGmJQTnzbk5YaKSF2YfcHC+OXa69ChM10swADKgqMPsOiKbH7nQaBi9Ij82
 ZQxF0A/1oi40jLNwHYQZXFRogvL6PApsikyOwZ0xWryNbHzT54bo+zasL7Y28J5uu8mV
 3Zas3VbQM3yfzoB7+RCMpaqGldmpZ7utKlaehpfBIOBaqHih6WvbGU6ZQmgNyLPy//t1
 /awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453211; x=1757058011;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vneba+jHxulAXbnulQmkNF8jDWmbZWM/iro9XrV3cMw=;
 b=bo00HK28B2Uckx4/bQOepeBJ/clbMxeZP6G8BcXD5CO7BXP8ioiRfQt1oxNgtHvRMv
 ssqP3YbK52ehMDEFtwHbjIycd614TRMN9B+0z9jhhioH/JS/v18NWDNIsMjhYqejlNq9
 5C8X8GkgB2XA99M0MuEzbEEce6Lw2W3vQX7scDshwuPkUoNesTUVKXzqihmOpVc7Glby
 iyWlGZJnGSgnXeY+zkvhdNx3WekHiDQQKlk4e46B+H1BSdPTigSB7I65mI2qGJpSvhP4
 tmvtRXc6zXe1hrXFDlMp0jf/KrxU7Sx6aJqUIVau3MN26apJxXpM2S0WmVsPpJpwu61L
 adaQ==
X-Gm-Message-State: AOJu0YxBPtEA1PNCW4QVR/JHBVTkJC/C5yRgwCl537ZHBFcIi7Dp4jJP
 /ZpbaVem2at+o1bQay1G886GJ+Zgs4PeJ6n9q1oAH+2TQa/HGY4UblzO6OAX7np7j8BqQg3dvK5
 sumcdgyM=
X-Gm-Gg: ASbGncsEQ+rMZUsiNyeF4hqc1bhavwwRGBac+u2c+FomggV6kPv/LWpKYqvS05U1LLA
 IJg+LUrhQnMZjW3g4aNuO9bWiDmh+7Sf5pLXbFiILo2JcbtqngEHb1YFmCs+4nuBGoZkLz2O7b6
 JfQTeOVL9j+3Uzqr3NyyjoE0UfYWOLwAnpjGyEgvNsq1IYwYK2nlc0fGq8Rx+0Go7bMW4zz7xxy
 5QrJx/2yTsrfULYD7uCF0vKYLb80fyBx4nRR+4kBP6XDQgzuk3G//t96edCOi/zmQrPr4aHsVSN
 a1Cgz8c01ZzRb+hbWPiyoPNSk/ACNc9WdEyLe3vPS1lSu492O0ZvwdJ1jfbS0eBA0hstBSEHVmL
 I4H9nYIFhRhvqpSpdh6pQ+D+Zfcgp6HUYcEHERQouzXRMKTVlCpcaLtnDhBvwWANWmjZ+mNGl
X-Google-Smtp-Source: AGHT+IFEhDHkXrn2S0oNQUblclJy9i+OMa5vhGY6Ke+nqmZ925CLnM/OoD4OFtuH70IQityizHzgPg==
X-Received: by 2002:a05:6000:2082:b0:3ce:663a:c92f with SMTP id
 ffacd0b85a97d-3ce663af648mr3392624f8f.25.1756453211388; 
 Fri, 29 Aug 2025 00:40:11 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc0a8sm2287718f8f.7.2025.08.29.00.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:40:11 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:36:29 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 18/61] target/arm: Remove cp argument to ENCODE_AA64_CP_REG
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-23-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-23-richard.henderson@linaro.org>
Message-ID: <t1qvyy.1vq9bulelbzvf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>All invocations were required to pass the same value,
>CP_REG_ARM64_SYSREG_CP.  Bake that in to the result directly.
>Remove CP_REG_ARM64_SYSREG_CP as unused.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h            |  5 ++---
> target/arm/kvm-consts.h        |  3 ---
> target/arm/helper.c            | 11 +++++------
> target/arm/hvf/hvf.c           |  3 +--
> target/arm/tcg/translate-a64.c |  6 ++----
> 5 files changed, 10 insertions(+), 18 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 7ebe404163..95b0b9c78e 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -187,9 +187,8 @@ enum {
>      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
>      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
> 
>-#define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
>-    (CP_REG_AA64_MASK |                                 \
>-     ((cp) << CP_REG_ARM_COPROC_SHIFT) |                \
>+#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
>+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
>      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
>      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
>      ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
>diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
>index fdb305eea1..54ae5da7ce 100644
>--- a/target/arm/kvm-consts.h
>+++ b/target/arm/kvm-consts.h
>@@ -160,9 +160,6 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53);
> #define CP_REG_ARM64_SYSREG_OP2_MASK   0x0000000000000007
> #define CP_REG_ARM64_SYSREG_OP2_SHIFT  0
> 
>-/* No kernel define but it's useful to QEMU */
>-#define CP_REG_ARM64_SYSREG_CP (CP_REG_ARM64_SYSREG >> CP_REG_ARM_COPROC_SHIFT)
>-
> MISMATCH_CHECK(CP_REG_ARM64, KVM_REG_ARM64);
> MISMATCH_CHECK(CP_REG_ARM_COPROC_MASK, KVM_REG_ARM_COPROC_MASK);
> MISMATCH_CHECK(CP_REG_ARM_COPROC_SHIFT, KVM_REG_ARM_COPROC_SHIFT);
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 268cad905f..93cae888e2 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -4527,7 +4527,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
>     };
> 
> #define K(op0, op1, crn, crm, op2) \
>-    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
>+    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
> 
>     static const struct E2HAlias aliases[] = {
>         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
>@@ -7297,10 +7297,9 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>          * in their AArch64 view (the .cp value may be non-zero for the
>          * benefit of the AArch32 view).
>          */
>-        if (cp == 0 || r->state == ARM_CP_STATE_BOTH) {
>-            cp = CP_REG_ARM64_SYSREG_CP;
>-        }
>-        key = ENCODE_AA64_CP_REG(cp, r->crn, crm, r->opc0, opc1, opc2);
>+        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
>+        cp = 0;
>+        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
>         break;
>     default:
>         g_assert_not_reached();
>@@ -7525,7 +7524,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
>         }
>         break;
>     case ARM_CP_STATE_AA64:
>-        assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
>+        assert(r->cp == 0);
>         break;
>     default:
>         g_assert_not_reached();
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index 9dffa99ed1..af03fc7fc1 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -1124,8 +1124,7 @@ static bool is_id_sysreg(uint32_t reg)
> 
> static uint32_t hvf_reg2cp_reg(uint32_t reg)
> {
>-    return ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
>-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
>+    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
>                               (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
>                               (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
>                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
>diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>index dbf47595db..743c5a10e1 100644
>--- a/target/arm/tcg/translate-a64.c
>+++ b/target/arm/tcg/translate-a64.c
>@@ -2466,8 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
>                        unsigned int op0, unsigned int op1, unsigned int op2,
>                        unsigned int crn, unsigned int crm, unsigned int rt)
> {
>-    uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
>-                                      crn, crm, op0, op1, op2);
>+    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
>     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
>     bool need_exit_tb = false;
>     bool nv_trap_to_el2 = false;
>@@ -2603,8 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
>          * We don't use the EL1 register's access function, and
>          * fine-grained-traps on EL1 also do not apply here.
>          */
>-        key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
>-                                 crn, crm, op0, 0, op2);
>+        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
>         ri = get_arm_cp_reginfo(s->cp_regs, key);
>         assert(ri);
>         assert(cp_access_ok(s->current_el, ri, isread));
>-- 
>2.43.0
>
>

