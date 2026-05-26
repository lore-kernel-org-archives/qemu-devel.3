Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7889CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRovt-000885-G3; Tue, 26 May 2026 06:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRovr-00087Y-PD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:22:43 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRovo-0004yU-7e
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:22:41 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65dbe04fc1bso10473820d50.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779790959; cv=none;
 d=google.com; s=arc-20240605;
 b=P1nhBi+07lWuhMICheirvOdfCKOrdtGnzNx+3fDvfHkwOPKiCDUWGVYa6mPxtF2x0S
 jVHXn56+wX2ukN/24I0AkbER7PhsYhV7k3vFpHjb3cGRHs6DC0Wl5AbN7nSgS4TFTWdL
 ZgdvEJgv+Szfnt58WEZUJZwY2ACh4rO6aiifcA0mVeSJ3AlFpm1dvhnW09V2iHEWojv8
 qjRiFhjYsOsu5sCVPMeF6Ox7ZD+xl2sQD6w0LYJ2tDfV1rxFp99rB4fj84nCM6keuxU4
 iVlCN/GQVk6rSz44f7+YtqTEZiggrFS9hkFpqlbl6qjqoGJyGHP7EOeXAd1cwRJSH1t/
 RPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KaVe5Ybwtsi/RKz9YyscUO/kLPV8SjjWIEwHlS9ZWnw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=HPMTGNm3BOpBS/I5eTqe/QIkNR398w+LsaOd3P4Ci5yO3Bby1OUUuIi8ViCOWI02Mf
 GYXz1Mi4crSUXSH+eO7XKDTWsdhQfC35xfAZNuw1CpJs3QRz7ovstPtkvj5rE9qKhR7z
 eH4URDFanI834vGZ3tvfeT9xoXy+uN/71t4IoWd/xJJg3fsLzeQRqqw3kPKMQ8N8EPMf
 mN/3AnnZCXcBQU46D5ItoDHskFynHmb2sA/VMX6L8AKBqofYSsfW3rUWsfLGLjXhA+LP
 1SpTDVLQKtxjWcNfXZf2dae28lLW/8O8+aw+EMvPKVRy0D8PEtCgTxKwKQVpI2cxCgRe
 7iyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779790959; x=1780395759; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KaVe5Ybwtsi/RKz9YyscUO/kLPV8SjjWIEwHlS9ZWnw=;
 b=N235Eag2MU6BbrdnHI7C367JNgnaJ0NIqTB6MMTDWNzHPqs/4ZfdTrQYXKF7+aLc9e
 3OmXUnLPXFsPseGuAS8CyFtvQPZPCk2J3LFgA+to5wARHT9c1Ui7HZAHtQIke+YwXDH6
 REKsrf66ZdYMw8q78+dY9Dh+tdGr9LDJTeuSWLyPlh/62C7Bx7VksXwa7XJHKWWUYX6o
 EcyFg+sToTF13TUK9xKGFF0Yyo5txJVq8cZCbHH96DAzfR7gJwsH3ufgw/81GtgzrxqO
 gdRPnHY83Mk3wpS/9dBxmRnWrr51wbwZA6gKtX/GOa6sshha2kmgZrqOJARrK97Sjhkl
 OTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790959; x=1780395759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaVe5Ybwtsi/RKz9YyscUO/kLPV8SjjWIEwHlS9ZWnw=;
 b=ShNcKfHjXWYA74yIC1zpEBHFx++xRv6P+5iqg+ehDrVf1Qt+qOmvDV1v3e7uVMnkaW
 +Y+xCjMAiVOtnDHpPnfjBuNQ14uzwHvOCPlAxvC+VPoe2Fop2C67uSIhMM2lbX4vQAkj
 nxnAjVHQwtUSMqU7g4BetT6GMBVsyRiJidUYTuuh624LrrMSBBsCBXiLF5D6yborGiIp
 c6wAFS9J4u5evhOxEv/Nel6wdlFH8nGHv0tu0ckQRwbuzYrwLwP1EHhozBLb9JZeeYdG
 qvgLZ5ZT9qQVZmZFvxroExXwc7nD3oQx9XLywEXA3dBbBK4LAOuT/cuNa2x510Ul2fKy
 5Vtg==
X-Gm-Message-State: AOJu0YyNWCyDWbznK0NQlIZ85NDq9xGmmjQnjEiqmPgvrdR+kK+m62MF
 gi3v2wg3Yxuhyk+puSWnvrs4vYJOr7ccoDm5TSCuSB1HfACBTaFZgVOrlL4QyR1eh2YaF327kgN
 Yd7u8qSvhskfwjZqGVaynEK3eTsgsygkHpY1jBTP72A==
X-Gm-Gg: Acq92OFPsCInfGX+MzRGvIUEkLrQuaY2LtcQ5qLgfyJ59EXRa7i+On2XuYvNXlLRugd
 ixVj7vaz4JqaIwrXIsCatIO/i3lSzRsnbpnofYycSi6GgjZ1PpK+DnRaxwxpDlsESn99tBF1I2f
 sZkCjyRm1LE5dRBxNgQCcnCWvCHjYv4VZXPvwKMlZhIEJw5ONqQW2xM0ZKh5DkKIjGKQdJuQ83N
 C+ThaS6rmA0JneX+Y0WaHqpdJVXJbkqHHqkWAGfe4svGdwl59D/zQM7rhRFdcQzq1DvE1fqMDi2
 V/VMa4NzNk3PuINuOaHnZF6jQbx2Xm10PrxArzmgHgC3Va0ulejVDsMIWLkSuPMw6Qcu5RBuQ2r
 CaA==
X-Received: by 2002:a05:690e:1183:b0:65c:5fdb:e981 with SMTP id
 956f58d0204a3-65ec95f013dmr16368654d50.11.1779790958603; Tue, 26 May 2026
 03:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220306.235200-1-richard.henderson@linaro.org>
 <20260522220306.235200-5-richard.henderson@linaro.org>
In-Reply-To: <20260522220306.235200-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:22:26 +0100
X-Gm-Features: AVHnY4J-VHupbhMWI8vSyiMMD8sLQCMpxBjQih7aaB7j_mUHOrDzFSU4eCzsu08
Message-ID: <CAFEAcA9BTe2B=Y=ghOLKXgiB4dHvit8g+LgwLgCZViytcQYYJw@mail.gmail.com>
Subject: Re: [PATCH v7 04/64] target/arm: Implement FEAT_FAMINMAX for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 22 May 2026 at 23:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -872,4 +872,11 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
>          return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
>      }
>
> +#define TRANS_FEAT_STREAMING_SME2(NAME, FEAT, FUNC, ...)          \
> +    static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
> +    {                                                             \
> +        s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);      \
> +        return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
> +    }

I think this could use a brief comment, e.g.:
/* For SVE insns which are only valid in Streaming SVE mode when SME2
is implemented */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

