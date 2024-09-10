Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09FBEDE99D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2pI-0003HR-4o; Tue, 10 Sep 2024 11:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2pA-0003DD-SU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:30:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2p6-0007UL-P4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:30:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bf01bdaff0so6350073a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725982230; x=1726587030; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZiT5sRB8qcuaI0eEbpZYCV2Z4lBgbiprzx0pudePSs=;
 b=MohHJ5rIPTVZNKYf35BGoGyrcR2C1P9VCAhpb807GKut1EO2kwGOVH+XPnSxiBg9Pb
 TszSFmMprziIqKQa0ZWtH1eFzYlt6rfeN89olaydUyrdpA+D6Y1nABcEGwEAP1/5H/et
 EWkMwI3hx9jGkwIluA4dAgx/DEs07TJ+xCs3zcb1kO/XspqyFYvCLQwfsmpWkmRhyV2O
 igC3nR/15H7gWSAYxmV54HZWYDSh1hN99zzeevYLbu4pokENHl9YePwK0GkXvFN69KT7
 pDb+6ywdq7K4V2GTz9eMhpYITD4+4f5+Ts7J0PyTvi41Ney6HkBHXSTlVPVVhgz5jj9k
 i9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725982230; x=1726587030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZiT5sRB8qcuaI0eEbpZYCV2Z4lBgbiprzx0pudePSs=;
 b=u0i0lMbU0kGGqg0Lkn+8Lc9Uirspx3m85AjVtKFJazCtw7E8a+VHbe/N9LJ1pIab7c
 we3q05IdqQCoLf92mL/0r891SVuLY+aAvCSQBlYkVGJ/g4573++rO06iRK8byBLRbFMp
 eGvm9BFSbA2x83SqZ0X39CiIKWuCq4JxCdAVF4Lui7vJ0z9/A2ep0cc5m6zF1oRZOzt/
 RmuDsl6i69oUrptjxWobJfvybkkMyT69cmSZzoRos+4tJSjUh0SKMVPfx26dzEg35pjH
 DzUuXy7G76xPVL1UV3Pet78rNa6uWS0smKAt8tlyv5i3dy2hCI5jZBuWak4bH/7qLg+G
 Av+g==
X-Gm-Message-State: AOJu0YyLqnL+G76/grQI/wngF/kXNu7Y/UzPeo1QkWj3YjwL3tDN6wOH
 ThMQcRL6IBZhree2JjYo5VsspQSqssbb76CdIWyppHluewtKgKAcaGluESKURYiqYJBcyniL9Uw
 KpH4HlrZQpnwGIX0Q202iQtm0jPhvI1kJ3zdugQ==
X-Google-Smtp-Source: AGHT+IEzhIM/ug7nV0K+F9AlPRchj2VVYQzTG0nmlBKd7uG+VuxFVLs+J8k02SxbylYY60CcOIAX+fV0HR4RqGQbQsc=
X-Received: by 2002:a05:6402:3888:b0:5c0:b793:df4e with SMTP id
 4fb4d7f45d1cf-5c3eac09aa3mr8230358a12.22.1725982230037; Tue, 10 Sep 2024
 08:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240909162240.647173-1-richard.henderson@linaro.org>
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 16:30:18 +0100
Message-ID: <CAFEAcA8hXTAwqhq29Xoo7kkHfdO1OTk7j2uVzDGcyMCdG6HdsA@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] target/arm: AdvSIMD decodetree conversion, part 4
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 9 Sept 2024 at 17:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> First post-9.1 queue flush.
>
> r~
>
> Richard Henderson (29):
>   target/arm: Replace tcg_gen_dupi_vec with constants in gengvec.c
>   target/arm: Replace tcg_gen_dupi_vec with constants in translate-sve.c
>   target/arm: Use cmpsel in gen_ushl_vec
>   target/arm: Use cmpsel in gen_sshl_vec
>   target/arm: Use tcg_gen_extract2_i64 for EXT
>   target/arm: Convert EXT to decodetree
>   target/arm: Convert TBL, TBX to decodetree
>   target/arm: Convert UZP, TRN, ZIP to decodetree
>   target/arm: Simplify do_reduction_op
>   target/arm: Convert ADDV, *ADDLV, *MAXV, *MINV to decodetree
>   target/arm: Convert FMAXNMV, FMINNMV, FMAXV, FMINV to decodetree
>   target/arm: Convert FMOVI (scalar, immediate) to decodetree
>   target/arm: Convert MOVI, FMOV, ORR, BIC (vector immediate) to
>     decodetree
>   target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
>   target/arm: Fix whitespace near gen_srshr64_i64
>   target/arm: Convert handle_vec_simd_shri to decodetree
>   target/arm: Convert handle_vec_simd_shli to decodetree
>   target/arm: Use {,s}extract in handle_vec_simd_wshli
>   target/arm: Convert SSHLL, USHLL to decodetree
>   target/arm: Push tcg_rnd into handle_shri_with_rndacc
>   target/arm: Split out subroutines of handle_shri_with_rndacc
>   target/arm: Convert SHRN, RSHRN to decodetree
>   target/arm: Convert handle_scalar_simd_shri to decodetree
>   target/arm: Convert handle_scalar_simd_shli to decodetree
>   target/arm: Convert VQSHL, VQSHLU to gvec
>   target/arm: Widen NeonGenNarrowEnvFn return to 64 bits
>   target/arm: Convert SQSHL, UQSHL, SQSHLU (immediate) to decodetree
>   target/arm: Convert vector [US]QSHRN, [US]QRSHRN, SQSHRUN to
>     decodetree
>   target/arm: Convert scalar [US]QSHRN, [US]QRSHRN, SQSHRUN to
>     decodetree

Other than my comments on the NeonGenNarrowEnvFn patch,
series
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

