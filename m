Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78E4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN63-0006x3-BJ; Sat, 30 Aug 2025 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtT8-0004V4-Ji
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:24:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtT1-0000m6-B3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:24:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3cf991e8bb8so261814f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756452248; x=1757057048; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wXmjW04Q5nWo4fwSqD9DR6HEZfNngIptCj90NYOKuis=;
 b=LFE6Ga2mgv9BCIFIBhQgJJGaspp5sNRbSk4um9QkURHUYQ9sW6xmYpb5LFUut7ZnyJ
 7V0moCDiZn2LLYqe9tudT4eZoUtKRuR8w/TQ2tSupi6sozV97MLlpzyHfqlXACzEL7Ym
 2gKuNKfr6SNQ4WfZ3HD6eJycWybLucawAc7gfNGZGTVZk0lkd3maLi6/q/NdG7rJEepU
 7BnoP7gQQrjigyt3OdgxKWZ8p2E9VJ4xlJ0PvTvNRxwXN1EbiosRRI16XaI6CqTbsE53
 waDcc5VGiqNJSVEi+yDPx4sPTILmSrUpcIuap9Ne+T4k4jjjCg9Rc1ZrVZRYNF0sm5X4
 6eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756452248; x=1757057048;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXmjW04Q5nWo4fwSqD9DR6HEZfNngIptCj90NYOKuis=;
 b=lsyCxc/OdTZBy1/Yki8dkJT4lQn8IKZM2wGnqcEH4/QKBON3571ZsboCA89zWo4Ft2
 5IYCyf70T0B5kmsH6RytNVxEdmfZ64sQYbm1FDe5QFMeLP0B+ITt9HwqgpeMfczxoCtU
 BmrCOimBwFOSmN8LXmq2kzX/SR1apKKSwgZ0r48wfSWx6SluQt+6UwL5rheAPqNJA5Io
 /G/Gw5cqysIftw2AYtBc5vfDkS5agxkugax3qM74GWcGAeNDAdAXbOjJSa1XmaboCGUW
 Wxbjsa/omsbrRhEyFVZmW7w83dqhztFt9JKIzet3exbk/fvKuY35t7iuHSUSK9q8/Sgz
 eocw==
X-Gm-Message-State: AOJu0Yy2PnqDqmMFtYlo1kCmn8OKN2SayNLB1t2zQa0odi0Og0+n3bit
 IaNQOXB2NPve3Rizy8YQ3ZLJdmKu6/D6+NTgcSd2TBP4K1Z5iov6WWTub8SVPeHicU1xYO9ZAUU
 amyNGlbA=
X-Gm-Gg: ASbGncvMPCpD0I0qVUjMhPwg/cu/u+LU3f7YR5OCq5qjMtqS1PV0MuS7XbaI1+y29EO
 09OKsLjM/PqnSdMGzbamEai3UCOGF4sow/ChZALOPkuZaMN+x0OzxsZuczep5L8p6Pbm9mxZxgj
 ZbpcWpGoArdQJGnW5jEpUHkTcvwzmRHmBh00EtfhTAsova+6JhrNtyT1jU4JxqhG/Ud3X5IpW02
 n++H5a3W1NWKk9zwoBFGNSulcTS9RNIj3+Zsl+yGs5z+gB3566B5o7Di5Z2MhHAqI232zQ+S9pd
 7FKyGWA3A+6jQeOYV3psFDWnYtZRHORkUTzdGzezlvKS8EyvPtKAMGa4Uf5c50MuKJgxV1tqb5Q
 Y11KkfhhKzmYOSaCBIoBEaqdWwpYTjLO+ANFkVijJ/s7/Whhbonp6yeIaqprrc5jnWzf3I3ZEeo
 OtzKGXIHk=
X-Google-Smtp-Source: AGHT+IEY3hyWhHuePou6SKqfpe1MsXXsHYpdHIbdfJs5KQmk84fkiWpReZ7DbXtQhBdiHh8KcpDv3g==
X-Received: by 2002:a05:6000:2081:b0:3b9:148b:e78 with SMTP id
 ffacd0b85a97d-3c5dcdfc385mr22658154f8f.53.1756452247904; 
 Fri, 29 Aug 2025 00:24:07 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf274dde69sm2244238f8f.14.2025.08.29.00.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:24:07 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:13:43 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 14/61] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-19-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-19-richard.henderson@linaro.org>
Message-ID: <t1qv86.8eeulsm1hy3p@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
>Prepare for 128-bit fields by using a better query api.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---
> target/arm/cpregs.h  | 10 ++++++----
> target/arm/gdbstub.c |  7 +++++--
> target/arm/helper.c  | 18 +++++++++++++-----
> 3 files changed, 24 insertions(+), 11 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 812fb1340a..b6c8eff0dd 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -22,6 +22,7 @@
> #define TARGET_ARM_CPREGS_H
> 
> #include "hw/registerfields.h"
>+#include "exec/memop.h"
> #include "target/arm/kvm-consts.h"
> #include "cpu.h"
> 
>@@ -1053,12 +1054,13 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
> void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
> 
> /*
>- * Return true if this reginfo struct's field in the cpu state struct
>- * is 64 bits wide.
>+ * Return MO_32 if the field in CPUARMState is uint32_t or
>+ * MO_64 if the field in CPUARMState is uint64_t.
>  */
>-static inline bool cpreg_field_is_64bit(const ARMCPRegInfo *ri)
>+static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)

Using MemOp is slightly confusing though I understand where you're 
coming from. Would introducing a BitWidth enum be a good idea?


diff --git a/include/exec/memop.h b/include/exec/memop.h
index cf7da3362e..9104c4f162 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -14,15 +14,26 @@
 
 #include "qemu/host-utils.h"
 
+typedef enum BitWidth {
+    BW_8     = 0,
+    BW_16    = 1,
+    BW_32    = 2,
+    BW_64    = 3,
+    BW_128   = 4,
+    BW_256   = 5,
+    BW_512   = 6,
+    BW_1024  = 7,
+}
+
 typedef enum MemOp {
-    MO_8     = 0,
-    MO_16    = 1,
-    MO_32    = 2,
-    MO_64    = 3,
-    MO_128   = 4,
-    MO_256   = 5,
-    MO_512   = 6,
-    MO_1024  = 7,
+    MO_8     = BW_8,
+    MO_16    = BW_16,
+    MO_32    = BW_32,
+    MO_64    = BW_64,
+    MO_128   = BW_128,
+    MO_256   = BW_256,
+    MO_512   = BW_512,
+    MO_1024  = BW_1024,
     MO_SIZE  = 0x07,   /* Mask for the above.  */

> {
>-    return (ri->state == ARM_CP_STATE_AA64) || (ri->type & ARM_CP_64BIT);
>+    return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
>+            ? MO_64 : MO_32);
> }
> 
> static inline bool cp_access_ok(int current_el,
>diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>index ce4497ad7c..e2fc389170 100644
>--- a/target/arm/gdbstub.c
>+++ b/target/arm/gdbstub.c
>@@ -247,10 +247,13 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
>     key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
>     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
>     if (ri) {
>-        if (cpreg_field_is_64bit(ri)) {
>+        switch (cpreg_field_type(ri)) {
>+        case MO_64:
>             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
>-        } else {
>+        case MO_32:
>             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
>+        default:
>+            g_assert_not_reached();
>         }
>     }
>     return 0;
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 3a9d8f0ddc..c4103d958a 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -63,20 +63,28 @@ int compare_u64(const void *a, const void *b)
> uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
> {
>     assert(ri->fieldoffset);
>-    if (cpreg_field_is_64bit(ri)) {
>+    switch (cpreg_field_type(ri)) {
>+    case MO_64:
>         return CPREG_FIELD64(env, ri);
>-    } else {
>+    case MO_32:
>         return CPREG_FIELD32(env, ri);
>+    default:
>+        g_assert_not_reached();
>     }
> }
> 
> void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
> {
>     assert(ri->fieldoffset);
>-    if (cpreg_field_is_64bit(ri)) {
>+    switch (cpreg_field_type(ri)) {
>+    case MO_64:
>         CPREG_FIELD64(env, ri) = value;
>-    } else {
>+        break;
>+    case MO_32:
>         CPREG_FIELD32(env, ri) = value;
>+        break;
>+    default:
>+        g_assert_not_reached();
>     }
> }
> 
>@@ -2748,7 +2756,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
> {
>     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>-    if (cpreg_field_is_64bit(ri) &&
>+    if (cpreg_field_type(ri) == MO_64 &&
>         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>         ARMCPU *cpu = env_archcpu(env);
>         tlb_flush(CPU(cpu));
>-- 
>2.43.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

