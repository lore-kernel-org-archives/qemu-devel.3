Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC24CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqfv-0007Yo-Gm; Mon, 20 Oct 2025 10:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqfR-0007NG-6G
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:15:25 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqfH-0007rN-05
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:15:17 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e18577613so3495021d50.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760969706; x=1761574506; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2mWS9k5ZzDXSeaA6vdVT8QfX80JDGX6PHd4tnvVM/84=;
 b=ZRVD2wsGTUlxE4AVYHnfy77wl2+D/ru3owdfrmGZdreSGY+bpymSWn6iAp17SGOTtd
 Omi21kCouMfxuOZ9haZXN/6zo7gzXgw7NUqKLEsyTW+Dll27GyO40hdy63C2E5LEwjBR
 84Oqpn4t56/+z+9edhHss1eF+DvcmBlCRk/OcImp/cYw2F4GyNsx6a+SSAooMxTXHoTo
 vC09I8tJZ3rLZvy1c0IAMYs27rVgXtftsme2Kg05HFPYfNIUIIeIONo6dpTB1o8bNyjl
 iyPvIER3SVUKQRHcS9y38L5iyr1n/jRHlNnE3afc/HhKgkxWmZQcPJonVbnI7ufP3nJB
 KPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969706; x=1761574506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mWS9k5ZzDXSeaA6vdVT8QfX80JDGX6PHd4tnvVM/84=;
 b=S04lUZNr7o+Z0EaBikVWWoWh+9EII7jv5LZOW4tlMSVMCHZuFymJL4EjCC0ASqE35p
 e236TH5680wD/ed6FhyK8aq5tTYJA8GF3OweGLbIpUwgwaHI+q6mLT/UwjFUk4IQ8M6E
 eri8BXgzRbU7bmzoVyqr0+jxDVoPEsogZAER9dBnwXjIbnx443dGZaaz9mY6yP3Io206
 ytUa1bB2TGe9BULholsYxfNdUaZg0tGUMRHSOq0p8F0VVPTNt/LPwX+/Ni8TX0rpQSTK
 uGzDCudT3FUFcDTNZkjz+djWBD8uJa25qU23808xWvxsXjLbW4L1t8JvL2n0X/hY4Gza
 7WAw==
X-Gm-Message-State: AOJu0YxXyzM4wTy8v2arf7Qb2OrLnDrQLZLWUUFF3zox1g64xLa+b/qE
 cUoNEEvEUV6BU97PSPV97tIwTy7rP71YjrEjk/Xf4hWlLtxZUsKFixWQ32q1aAZiCAQIwj3k8F5
 qfPO3ifDoHUGhul5NT53+KYSOiQ8X0Dr2S5Pm68742umjYY8Gg0xg
X-Gm-Gg: ASbGncuXA3E30J6w5uEWnYWIqWTrI1ACAwUEcKy9Up8sQJuw2FTotOfh7/segt8rZxb
 QGVEYF2rvlL/L9E2I6prtNxN3IM/QnDxSdljwiI9kKIcT0j0Dpp7p8q1ZYUr4iZHLCmMxbLvbgP
 6DA4NAsaJrfRvUmIrBJcGXoWfR1O9hetUK39sCgNVXRsCvoyj0cNuDXZadivSJ5wi7KUNE/fcEV
 BmbB6QRlWWRDpKT8s0RNlw6SoodhsCKHpM8tlx8FW/STe3xK7rcoOWMz9IPIA==
X-Google-Smtp-Source: AGHT+IGYqixOJRzSn0Do6k6cpOxol9SZ+SrOneIJSAiXXAxA5he80qD4xhN8EjvKr4td36HhfoezuStrzGzfErVRpe0=
X-Received: by 2002:a05:690e:1209:b0:636:1a8d:9d43 with SMTP id
 956f58d0204a3-63e161c65f4mr9087918d50.40.1760969705726; Mon, 20 Oct 2025
 07:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-26-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:14:53 +0100
X-Gm-Features: AS18NWBg0vW-Drd44P4O3CVZHAFPREI7HJsC4-iKjXZDQouJF9OhnH2H-rWnz_Q
Message-ID: <CAFEAcA_FXddPSD_rHaW1zgB0MKpsJxcUoUe-jBE5ZZmwbg1j4Q@mail.gmail.com>
Subject: Re: [PATCH v2 25/37] target/arm: Extend TTBR system registers to
 128-bit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> So far, just extend the data type and check access; do not yet
> consume the 128-bit table format.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> @@ -6196,9 +6244,12 @@ static const ARMCPRegInfo contextidr_el2 = {
>  static const ARMCPRegInfo vhe_reginfo[] = {
>      { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
> -      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
> -      .raw_writefn = raw_write,
> -      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
> +      .type = ARM_CP_128BIT,
> +      .access = PL2_RW, .access128fn = access_d128,
> +      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
> +      .write128fn = vmsa_tcr_ttbr_el2_write128, .raw_write128fn = raw_write128,
> +      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]),
> +      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el_hi[2]) },

We set .fieldoffset twice -- one of these should be .fieldoffsethi.

>  #ifndef CONFIG_USER_ONLY
>      { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

