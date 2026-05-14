Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B11CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 15:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXwS-0003Fq-5Z; Thu, 14 May 2026 11:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNXwP-0003Eu-1q
 for qemu-devel@nongnu.org; Thu, 14 May 2026 11:25:37 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNXwN-00022B-DT
 for qemu-devel@nongnu.org; Thu, 14 May 2026 11:25:36 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65318dafbcbso9987900d50.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 08:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778772334; cv=none;
 d=google.com; s=arc-20240605;
 b=cX+1SdfeMVbFHIHsPLmRylXMLK3pPWtbHrt6ATlqYftmYXE4XIf0dLTJ9OnS1YIUIi
 +kxH9Fz1lkSLqSkE/e8eVsjbVOZhX7nxpd7BPWTHZLFODdsX7dvGrAPA3bFOcYnsxqDQ
 KCrPoHYd1nqC2Ss/Ga4AkCEEYbt/znxhzsqq184c3G4EmVBkQ1jXqYFbGc7GdBzWb7zX
 XK2vNUDGrcrVFJ0uMPj07yC2INtzfkkFLag4rCgQGKJ1S9va88Wo654HsxRIjdr1D23B
 95krl8I0TxSEu05xN00NAWyEFFdsOndaQV+yQnPu5AjBjNuSl4J4UjL2ZeE57ETZKgrH
 myyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1fQE5GLYggpE8y4MRNom750CprjO5UapcY4825ccJ6s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=d4QylZ+DUFULYFFoMC6JOjEkBOBtKL/UsQCm3SE9CUdPvkF0bD2uyEcqABDhEfWbGW
 ifrSfDaChOYPS/OJPMrzf3hZEPj+UezyizKiUB5b6Lb0IcjUk0cM0clMlaYwXz0OQw+5
 hSvgaSX7vJCUmGHwOriLZ1+yqNU8/S2aVi6D1rmWammFD4R8OLnZDIPVLINARR4AGcQQ
 mXGzs14xkL1gfz0CWGqlPA/YQlH9oZo1HZKf+QMmWVirmWJcVx5nGDg97ExZrrJKHx2u
 vuTFLS6IyaR8OyBsFPtpR4iwhPzCxcHH7iYLBaAp5FmU9MUJSKIpPo4Abj5o2Chtvf0C
 VrYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778772334; x=1779377134; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fQE5GLYggpE8y4MRNom750CprjO5UapcY4825ccJ6s=;
 b=Le/NpPMtpkQRv8IXNTZdyCcE4ZcNkOPp2UJr3oc3RDqhwRBrFvlzKkUgDcg0CZzNY8
 3edayy5Xv9cxDokOZl/J/hrAJo6Z209wI20jWp8N9ti12T0JdE6H7e2Pz2dLU8ZNgDYq
 4j3FePd9lOR/XitSSTDkWjAzIwra5C0KYv8x6bTiuGRcoTOktQo9wXg7ARgZb2pnAfyG
 QXKrF2B4yViH6Shs24YXskhdvfMmlqZQcFj5q65ckeMrKqpTad725O6GcUR5xk04HJz1
 bva+hYE6CCiiDgjnnofB7NJiK+lryX2KlElhajX/orHP8Gxdqd8Fcc60LcpGcswAt4EF
 B6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778772334; x=1779377134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fQE5GLYggpE8y4MRNom750CprjO5UapcY4825ccJ6s=;
 b=lM4EqVLKZSlzpZBdh72KDv5M1+8R4tqBKLmcKSaxFQxT81N/l+Y6Mc9xgbIOQVYH5E
 jE3cxU/rX+8ZTRlhlDLqEGYlW1TsFF1tT3VDIZbLnMQkLzSVLiDU8qpkh+XdqheJz3XP
 sjrwRwoKeyqbRsRGCHJMPgJ71gLSHx3Gy9ZntsJjBSesXPLsvF9XN4l/U2L5hvU/vPQY
 +vNWzeZazkTRc9VAg9bhOWA36LEkYzm+OvVEbp4vy7v6eIW+9e8KeSDLqDU0wp1J913a
 +EGvai2aBL1F/2XXX1K2g7ZKIt2zfdProk0spg73NJFhGEYKBmFaaZ3jooUQ7AYjpebF
 DEzA==
X-Gm-Message-State: AOJu0Yz0VTV1E9J7xU/zWu0eH8r+m394hQGaor1Dt1s4XbBO81MNc0Wy
 zCeZt6deMcMJvKOW7Eytz9y4DeW4DipoRqutHy177aU5A672dh4j7ALj7BTnE8F8V6g3PyBQgUX
 1y6I6pl8JgP1MJN5kN11VDwK0vSjW22+LB4WhQR70955g5fJp9563ZhQ=
X-Gm-Gg: Acq92OFFguPQ89HoilQX/ZzBbm129SAMRJXDNzZr5l+F68Y3xieGsN8IClWYqW/I8ff
 hS9SRvuWfnQiDJBujsFKUUybqGNIOANcZF1jtqfieXGxU9GcANBvR1JEaXM+vw8dbZFlLv4mt/Q
 6FPesIxM04HTa4RqXikvmwxv8f6AuzyY/K2dfJyOhgY99uaCUFz6LJGNbLACFBYk3UBsuVPV3yY
 wBJMbRXGGfYtrdfRRFKgNFSyEIo7/5fGGI//ZllLaap+LpKuVC6iF1JVjPtEIKMzgUAozePmrFh
 QX5MQwwYjxn0SB5BLnp9hZDwIgJPUKzgbBMB+HrXjlCwORCwkX157LkuSDnpoN0aWqrlTkvuRSs
 I1A==
X-Received: by 2002:a05:690e:1916:b0:651:b7e2:6835 with SMTP id
 956f58d0204a3-65df82acdb2mr7217535d50.35.1778772333721; Thu, 14 May 2026
 08:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260507234413.643512-1-richard.henderson@linaro.org>
 <20260507234413.643512-45-richard.henderson@linaro.org>
In-Reply-To: <20260507234413.643512-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 16:25:22 +0100
X-Gm-Features: AVHnY4JTnCXd03DeiNVQI3JuZzcm101C4dpViVwLPzUpCFOqbGQ87_XgyWov2j0
Message-ID: <CAFEAcA8U_h+L0XKPFVKF5-+pq0bpDhrh8ahhiec4NAEPwv2KVA@mail.gmail.com>
Subject: Re: [PATCH v4 44/60] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 8 May 2026 at 00:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static void fp8_finish_fpst(float_status *orig, float_status *tmp)
> +{
> +    int e = get_float_exception_flags(tmp);
> +    float_raise(e & ~float_flag_input_denormal_used, orig);
> +}
> +
>  static void fp8_finish(CPUARMState *env, FP8Context *c)
>  {
> -    int new_flags = get_float_exception_flags(&c->stat);
> -
> -    new_flags &= ~float_flag_input_denormal_used;
> -    float_raise(new_flags, &env->vfp.fp_status[c->fpst]);
> +    fp8_finish_fpst(&env->vfp.fp_status[c->fpst], &c->stat);
>  }

> +static void fp8_mul_finish(CPUARMState *env, FP8MulContext *c)
> +{
> +    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat);
> +}

The Arm ARM 1.5.5 says that FP8 convert insns and FP8 mul insns
have slightly different fp exception flag behaviour:
 * neither updates FPSR.IDC (input-denormal)
 * convert insns do update FPSR.{IOC, IXC, UFC} for Invalid,
   Inexact, Underflow
 * mul insns do not update IOC, IXC, UFC

Perhaps squash in something like this ?

--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -55,15 +55,18 @@ static FP8Context fp8_start(CPUARMState *env, uint32_t desc,
     return ret;
 }

-static void fp8_finish_fpst(float_status *orig, float_status *tmp)
+static void fp8_finish_fpst(float_status *orig, float_status *tmp,
+                            uint16_t squash_flags)
 {
     int e = get_float_exception_flags(tmp);
-    float_raise(e & ~float_flag_input_denormal_used, orig);
+    float_raise(e & ~squash_flags, orig);
 }

 static void fp8_finish(CPUARMState *env, FP8Context *c)
 {
-    fp8_finish_fpst(&env->vfp.fp_status[c->fpst], &c->stat);
+    /* FP8 convert insns don't update FPSR.IDC */
+    fp8_finish_fpst(&env->vfp.fp_status[c->fpst], &c->stat,
+                    float_flag_input_denormal_used);
 }

 static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int
scale_mask)
@@ -597,7 +600,13 @@ static FP8MulContext fp8_mul_start(CPUARMState
*env, int scale_mask)

 static void fp8_mul_finish(CPUARMState *env, FP8MulContext *c)
 {
-    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat);
+    /* FP8 multiplies don't update FPSR.{IDC,IOC,IXC,UFC} */
+    fp8_finish_fpst(&env->vfp.fp_status[FPST_A64], &c->stat,
+                    float_flag_input_denormal_used |
+                    float_flag_invalid |
+                    float_flag_inexact |
+                    float_flag_output_denormal_flushed |
+                    float_flag_underflow);
 }

 static FloatParts64 f8dot(uint64_t a, uint64_t b, int n, FP8MulContext *ctx)

thanks
-- PMM

