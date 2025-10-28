Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A622CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhnY-0000LD-FB; Tue, 28 Oct 2025 07:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhnU-0000KV-Uv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:23:28 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhnS-00037j-JK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:23:28 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e19642764so6008129d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650604; x=1762255404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsoW7yIBRI2K1yaRJR7zeK9skbEHmWgo+8BSB3Jazuw=;
 b=Fw6Gtym/ey7E7kfBGrMRNhXMsv+TLuQqERRWU/KPOTIfn5+xblN1LdC9WqohMHi54c
 d4SUAJc/FJ9JiRm2X9ZXHNvLW3mo4dvGf2u3ozSKnlIuiMGDePIujm9XmCx0hZ2/m/MV
 UHYhh6gzDAsU5KOLeswkLhONExDFiyRjR9xcuUOtHjvfq15PfeNtmOpKQy5v18wlBltE
 /uOzyrglE4Fu7KHUnK15z6u/dsMz3oqni6IW2KJn4WOxmSABC3DaJH25NxQ9/SpsWo+V
 qhZn3qAEeVo2JV8esl5QmkUE3N82pjLzMhJUCUH2W3y8dbcNSurhHWuqMNcoBkDqeUv2
 /DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650604; x=1762255404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsoW7yIBRI2K1yaRJR7zeK9skbEHmWgo+8BSB3Jazuw=;
 b=Tc8ATw5rs4F2qSFxgI2D8IvSdGGrS0pLGCbHT6WmriWzRjM+np6aroQg5Zut5F5GK3
 tn22hMPomNmSvZVFP8JC4H2+0G+RpH+AYeFCffyjf0hr8fiFfhn4fY0+6dszCn3t8vaw
 SUvFNxoga6MTSje8GxB7nIkYTndRfUj2q7rBPwOsw633+331SNYCXbPddLR4o6UWyf60
 sjml8jJ29VjNa5jYyNzNZB4eaReui9VGkjyTDHtb/bVWRG0cryxY3475dt239haRfeLY
 2DSjn+dB1bsqTWb/hxfD4wQFXYxNb3Yat3O5qaQTGMgzaQ81lnwEUmBGBV6KELS5cCYo
 i32w==
X-Gm-Message-State: AOJu0YzF5sRJtY3gbVUUj0iy0xy8q9pdTx5sAL8R2Xpdv5UQ3nqEU4vB
 5kC9Yzzoz71J9EvPsewl0FjKFqQc7MEM2wGgB0F5F+tlhL86ClSsSu9vf9M/xzVjcK+XfFaYGwl
 TsXP1v0Stsdx3ckPfYriBbg23NEHwlScvXbwb/sOBwA==
X-Gm-Gg: ASbGncvG2ZJFKlviV3zBODs0jqQ2aw9ky4KTBWPvXQkt/NWyoQjuXCD+41ne+P/OQvs
 26sSFAu2t9oMq78rinai3IH2JKyWehPRd5/IfBEVRXtLPKCwCgMTCQnopgTepW+WlaATR8vKGmG
 V6eES9Sg+zP5iCgvA+ri0l/ICFIsqa5sBUkVIYmz44G89GQdEJhUNJ9Kd5fDFUZwkMMtcRb9jHV
 l9bQsMChShYASdoZ6uHsM/jCq3H6retJ6zctpGfoys4DNN2sxFDLungvmBCsQ==
X-Google-Smtp-Source: AGHT+IF/ja2+1o9Vr2fKdoteQSFy39NxiXPKDPa/xGpYwtqttmIckPiXPNCEUyCjMJLKrHWX07Yy9y/2uVnE+mm2ku0=
X-Received: by 2002:a05:690e:4186:b0:635:4ecd:5fcf with SMTP id
 956f58d0204a3-63f6baace93mr2661531d50.44.1761650604408; Tue, 28 Oct 2025
 04:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-27-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-27-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:23:13 +0000
X-Gm-Features: AWmQ_bkLfdJgALNZfKqFAjmFUAGJBWH9PSXEvlhHllJ2Qrq5N31v7Ka3ziCP_GM
Message-ID: <CAFEAcA96PQJTth-+xDMFL0rsgdYTr1Y1C9+i_UVgr5na6BfXYw@mail.gmail.com>
Subject: Re: [PATCH v3 26/59] target/arm/hvf: Rename 'vgic' -> 'emu_reginfo'
 in trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 28 Oct 2025 at 06:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In order to extend the trace events to other registers,
> rename and pass the register group as argument.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

