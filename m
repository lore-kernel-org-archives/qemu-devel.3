Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F31EF5862
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuveb-00010v-U1; Tue, 24 Feb 2026 11:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvea-00010L-He
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:52:56 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuveY-0002wv-0t
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:52:56 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso7648d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951973; cv=none;
 d=google.com; s=arc-20240605;
 b=Lz7RowpTck/sVw3D47f3tlNuJInBce6qsIsFd6PkkylBg0piQyHQz+MNJZ2tZdxp4P
 +6JX3LoN3l/HfyoyfpIqYT87nnb0fFerfAba8T4Yz6+UcmROlBlJKOpzNFWTmNCjAMNn
 UZzXm0CXCbbzIkCrY/Sp4ynTbzwWipPV7ooL+Ax3cdgjtM9ZUV3bt4T5tZhKho5fP425
 1cMpw9pIlNX6+MqXKIXHZh6iBROG6UmiS1MmMJpDQibRuiRfA2FllnnvKjO8HSpu0PDa
 230fMb2i3i7jpto6Q7DzW+JPJfLAq06hzebCaF/G+2z2XmGCTcA44T/akFjmGTZ9dnYK
 z01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PsaKSKL3Vyo7u3RWSyHSRYQELZxA2qZeIsk8CpalaQA=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=gIb83vqpP29SLHjVryYhjfn4rL/ZEirkIuYSWQtvo3RAdgLZlMhD4/ruD3RkVpjdW2
 LzSzJ+8KS7j1PqVabnFGmezz1StPNW+roGo8oPUA8IJrec+/Apsw4xcXfXdtK9Djz/yF
 kxJfOgpGrucxUjLwd4TKvulkzqREDCaEUOaSWtYclXnOLz3/CJXxmyO2B/yFMf189EBG
 QGkdk6yebrXxkJRiHyHzcpUBAlzRhBETUj4jhN+dFt7Uf1ht5hC3tVIHOuRvYv5ozGer
 Fw+EN35Ph0OdsbVwxiB+Wpg2L3SfJIXP1TKn0QKvUm3W1sMsCo/WldEUN8QY5AHjDPIM
 Pv+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951973; x=1772556773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PsaKSKL3Vyo7u3RWSyHSRYQELZxA2qZeIsk8CpalaQA=;
 b=Fgfaq/y89tRGt8Zcum+tSwEnqFldDIEgnxJwUStdtHlbomVREt+y+uyWU5W7rQ0yVs
 u3O+UxzE/HIsLpmiS8MzKE9WgQt+GIWQkjXhm2XV8qWG70pQqLg7RYFzUXcuOEml3qat
 jiqrFBcEcXxRTtK0ZnPN3liy306WAQ9qRL9EmEOCWqFcNMOjB9RpMvo83W9xGHDmBiTw
 TScwV7o4z3+vuIjX3YU+mL9xSvmxl3+ima6E4rjGqLGZ7lnb/9Hmz2nykEwti4Qq10Ep
 hR87oCYa86+gnufKp7pBv7B0sniyTZ1CwGCLCOW0CNVOqgdyXfKAPlwyhupSD59wyY90
 GOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951973; x=1772556773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsaKSKL3Vyo7u3RWSyHSRYQELZxA2qZeIsk8CpalaQA=;
 b=Czxwmvs+7P2nhsxstiRcLgmvo1A3rkgN3+6SaeM7CLPCcVJP7OVvZfL0LnjozSe3ay
 nFqyU18f5LWtrif/HYTzSoKps2PSFg3tOsYcQhuSsdtPW7LjNL3Hm2TOtlP1AgEIeaIH
 KdvKVkwVhfk4seIXotALZZIxeJHUJnKggAcHWmEra6NInIX+0cVioDcKearjnkH32LFI
 PXsL7k9zkn8Of5f4gX1i2haIdFVTMvtF0PL2W6gLoaCRmLrEIwchaUt4LC0SbI0JETi3
 Yl+pZbWkEO4lsQnGXlx94pu8tC8Wam4j0c7p4otYw+O5XBDZVQMyjSbmMAs6X9hA6MaF
 alxw==
X-Gm-Message-State: AOJu0YzE6U+gXxxTD4g+CdISh0HryiqK5hNe28KOX8FPMGjIWdamapQx
 Ki6tFYaAdJunfxeHEGCRZGXkb4eUVfDG0eBgXuLouTVPLw1XH32fWxyHbTSreBWwavBje+njLJ1
 1WHaZxKijb3OMDlwfTTDFKUSc9WmyPCye5n9oFeE4jOo2yPMZ7yHF
X-Gm-Gg: ATEYQzxNTJzhZKU4OL6WYNJ/22mYpDtNHEQFZElJHJdh6j26tc100gDwogiu2jTr3vS
 y5LicetQkDnmSX092WfsSSOQSBUs9Kcbb6Sea6qqc5zVSPPUyu6CF0ms8wqbHDBVnFstCq8/DHU
 ZUwXc3Lj2NzBT4bibV4wkPOfbEyTytM3FF4PZ5I3N3C8hw5yFcyS9wqBO/Aaqlk/Rn8BFI5867X
 I+kB/vj5/kN2FqF0cQEQdbO8dT6g5lI5iTRhyDbiGitKrsm70Pi/y77KxwiV0pQggXj6zqbLuKe
 9O5GAxQoJpq6Iw8T3GHMlj/0Dmj0Df9zTX1hgjr3MmYslPPU/mDMVnIlc/oY0AcmI8o=
X-Received: by 2002:a05:690e:138a:b0:649:6644:7964 with SMTP id
 956f58d0204a3-64ca61a29f4mr492321d50.22.1771951972759; Tue, 24 Feb 2026
 08:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-11-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:52:40 +0000
X-Gm-Features: AaiRm51InR1Rhy_EEBPGLNlfgpsVRtOzWDkIz51aop8g5Z0-TRANtXEhCP4SI4w
Message-ID: <CAFEAcA_0ueuehtayiK5svZEDos_3FdjXwg58-vHef+ZTGpVW9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 10/13] target/arm: Add vq argument to kvm_arch_{get,
 put}_sve
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 16 Feb 2026 at 03:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)



> @@ -2139,8 +2138,7 @@ static int kvm_arch_put_sve(CPUState *cs)
>      }
>
>      for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
> -        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
> -                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));

What was going on with the double assignment to 'r' in the old code ??

> +        r = sve_bswap64(tmp, &env->vfp.pregs[n].p[0], DIV_ROUND_UP(vq * 2, 8));
>          ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
>          if (ret) {
>              return ret;

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

