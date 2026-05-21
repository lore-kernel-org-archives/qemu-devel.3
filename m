Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A0ACD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyj3-0002TA-AP; Thu, 21 May 2026 04:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPyj0-0002SP-UZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:25:50 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPyiz-0006Hc-8M
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:25:50 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65e39d1dd38so5321674d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779351948; cv=none;
 d=google.com; s=arc-20240605;
 b=F0BEht4+QqeNJyaXCGSXKNRZdwS3YuPrlA9GPj6CwuFpXAQPpZpwjcsEWFhH+8k+Qf
 sSB0VknWUBm5ZEMnTtzv1Jeg6PBwKcQm2saJiHz+BdooTnD74m3vV3JpGLuIRf7iRKwQ
 db//pmKeCOPMSDTwB/mlWJVsU5ejsRY/GgDWaJI2TDhia7IvCEPMmbm866vnYzqYUulj
 FqsGydCbORMlrXxfzfPAa1IKhJUgDTxj2QJS/8F8Zs5xWJ9LlOd8v4o3trv/+vxbWEng
 yjrDek5Onclbt04kqQqHMbERnKCqXNuVwrfb0a32WaXvn8lkIsDWTVIu43n6oLe3l972
 QB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zviA81fpa7mw+EtXADcpJMm+mlojLlGfZyaJMSq+5XY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=jNLnwUmJIpGa7KTE8yDG68A6YeUQCImZkLhTDEU0t/lwO6/HlAMeKOVred7VPr0ZOv
 XrOKs9xo62wzXrkl/Z4pw1DDN1qu8KueRGWc3WyizwgtTWFfSP6sbc6DqFb5kP8jK0M5
 2/7ACkHRpjyVltNs2noLXEj4E8R7tQ0048IvU6BeBfFPp2qSYaRas9A7icHAud1pmaBc
 YSVXBkGmyF170OHkvirWqV0V0VJNHxa4HYTZ8Ldtpd/NYr1MXmH6+lbIiErDGZS4OY5N
 0BnY5A6KzkkdRpw3kqaC+94gRdGY4Z8S/Q92tUc1JKedTFcY3BiM0gzTlSxcwsm5D1Mn
 /gxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779351948; x=1779956748; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zviA81fpa7mw+EtXADcpJMm+mlojLlGfZyaJMSq+5XY=;
 b=L4xUIrY8jWBmMcB3pei8HdTTKtLkl/sPWaRptPEXNqVO7br2c6r+FCfgxKguB0n7X1
 gbs78W+BrIsVnwU17AWpk47uLoB8ovrkw2SuccKpEB2/6BIl/FnLZAANSWVl/KtBl3Vc
 j1qPbe1vq48NhEduNSM3GiiBePmCZyCJh6xsKZcA0RM1pzHCXGW99eTLdB36VGqCwc4F
 awQ+0bFM0h4njLzM9Lu/J6EUz8n4aLLkDwpxotgq8rId49Aaxqf9x/IJ+7Bm88vHwUxy
 kfeKc8UJXWmYPrX6SbvFwtnclDJmjpvaxPJISyNzy79OtBlwMzp+oWkiYIPrhj0/k8TD
 AuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351948; x=1779956748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zviA81fpa7mw+EtXADcpJMm+mlojLlGfZyaJMSq+5XY=;
 b=ZzrnHP7ieMyPR+vYaCmB1F+JLKPOEmunmj/Ol2/nkHAJ5X7rKg7XGJqz72ii/kgFe8
 7EkAGg3NmnZCwhnRohYbG0t40gYLjAX5jNh0+R9DtjsByeJfu/LdmUai7PtBVSYB17BK
 Yk3Sb7UCNsKOLhYOdNaWZW1tXUIZBHcVZgDSYQnz2rUwJplYH0L7ZCLQeRu+7FIdZaGu
 Bzv4v7oblV5s6MSYUY571BpJzO4P6D39e6uC/OXnjw9N+4onnLa3FI0C9JKKtBcMBYLb
 VoIQkOmlFyx/WoRqk2oJTr+UenlvkCKTq+hvyHdqtAT1/aa1qYfeS4NY9ypYmderU8UB
 GRDQ==
X-Gm-Message-State: AOJu0YwAqzUJJfMPRO+UcgotQPaOqqEcrFe5Sun3ZMlJ4r/FO8Z8X5yo
 157LmSaPcHkzIc/Y8TgP+iQP7gsug9oknxQAk4CBDkz+NKoueDtPGSdbye8cQF293I1+o9noHt2
 r6vuFXDXdiEx99MaevvzwsaYOkUtBCbpY0Z1zZTymFmMFZLrK/extlbE=
X-Gm-Gg: Acq92OEsRMekdPXtiMGzqtWbI/5Y3IdPGBWtoJlSBpYn9SLcb3hGGTS+FYwqyEvcUCd
 P7Qk69lnSHxq/S2gki6NJZSmQDHCGZ1JoO5Odot3sZbPLUDGHpzYXxE8DCLSWVwh4OnAWGk3ELU
 obWJ3H8wbfQB9jzLL2TIDbRa/brNN04YwCj20AVI7wBasd8iQ2sjytatJcjW0Ef6ktMWX6rvRL9
 oYA5JH1Lye03amBc/+N3uEbbKvcXWdTCNHk/Zh/HY85D0+LWXzCwaCzLMD/F5gCNlc4YLSGfdsx
 qWKPkotV0BCvZo7V/cBPS7KrsCwqdWjnNbu1MrWEBivKNNNghoIZUL2P/q+teeLUw0M=
X-Received: by 2002:a05:690e:124a:b0:65c:ca50:e5 with SMTP id
 956f58d0204a3-65eadff6929mr1508008d50.27.1779351947922; Thu, 21 May 2026
 01:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-3-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 09:25:35 +0100
X-Gm-Features: AVHnY4IZkeR-CI4x3VhN5O0TS_DuJukHwWfS9frVZNicFa_xM0sbhaaxTnrBSdk
Message-ID: <CAFEAcA_F72LXF9kWVrU=mSt4=v19jRkDt9XkznpE+7DjVV94kw@mail.gmail.com>
Subject: Re: [PATCH v6 02/64] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 20 May 2026 at 19:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +/*
> + * Use float_minmax_ismag to get the absolute value min/max.
> + * Avoid float_minmax_is{num,number} so that we get normal NaN processing.
> + * If the result is not a nan, take the absolute value.
> + *
> + * Note this operation squashes FZ, FIZ, and AH to 0.
> + * Create a fresh status with default behaviour and propagate exceptions.
> + */
> +#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
> +{                                                                       \
> +    float_status local = {};                                            \
> +    arm_set_default_fp_behaviours(&local);                              \

This misses that we need to keep the default_nan_mode setting
from 's', otherwise we stop honouring FPCR.DN. This will fix it:

--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -155,6 +155,7 @@ TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status
*s)                     \
 {                                                                       \
     float_status local = {};                                            \
     arm_set_default_fp_behaviours(&local);                              \
+    set_default_nan_mode(get_default_nan_mode(s), &local);              \
     TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
     if (!TYPE##_is_any_nan(r)) {                                        \
         r = TYPE##_abs(r);                                              \

(or we could go back to copying 's' into 'local').

-- PMM

