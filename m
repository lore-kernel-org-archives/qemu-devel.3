Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0DECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnaa-0001Pd-Mn; Fri, 15 May 2026 04:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnaX-0001OC-CL
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:08:06 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnaU-0002Mr-H0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:08:05 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6530287803cso11127641d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832481; cv=none;
 d=google.com; s=arc-20240605;
 b=OZReC7ELfh9JPlIB3zn1nzPyvZ79nRs1OJxGxhpMn/MZo13mDTgEEVai8I162Bio7k
 bQB9gode+uJw3qVm3IG0p0iTbKSZgX2AWll2oC5SbIZPJa9edTEIm7EGHzE9YEfQOALl
 mkmRGZ0UXcDYSbvCZkCrf2aKMzCpMw3+pLlWPvXNZTCQ2GguYcE1HuzJeniij/TcLQwC
 u/W0yLpsWQe94U29Yyr5hmY8PeGuAyRF7S4ME7WDKxhWY18sIr4bLuvBvu83a/MCJXq1
 KcWC+erlxrr3Uy47R8KfXJud0sOaZkAPwmZkpMBOfQCtMArXaFnKRMvEpVQoAUG/3eXY
 pZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M38U+qau2ZNRXxqkBse09esbSNx2agZ8RpJXMdZSfNM=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=Vgv8tNhGAiPqxvi88tYU2OV2W8RE25iqu9T6KrLAaKez/QSrlTU+QlhzWDVKpoBXZO
 d/VFM/AuGIRUQbytoS4WwHR/L/ydFlrG20aLFYMR6q/JCgxfDO63hmxlOVh7gntUGABP
 9A02pt6PfoA3EajR2EUGzm+/cf19vvoad/okoQHz+5JjQL2jKZr02GuP2CK1n9FGX76N
 sDyLQSQnh7EVK4wLCdTl/cXKgtI+S6kU+58zaFV3xC/y5VENpAd2xfW8sIDmXymdtjJH
 bs2XOQWc5jTLCRViOVQbDAd+PaqtjxqoWu9EQEFuB5hNWN7jtQYDkYXDwxNckqxMkBOJ
 DW4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832481; x=1779437281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M38U+qau2ZNRXxqkBse09esbSNx2agZ8RpJXMdZSfNM=;
 b=YxCt+A7EXWqpOD7Yz71spAQlQFkjkRx5IPjhcjWGY4QvDmInJx49UkqAuGgBSKomn5
 otbFz2Vuds3cB9R9K2t02MQ8p46nnFzhIdRyaeXn5bu+nqi2QgkejKIdOoAA1vJWfru/
 A1wHEUZScsYQZvX5SF3Y/fHib+yt/Z+PNC3NRUovRkLcxxRIOYcJ4X6KrSzjhOuAeEWj
 JSX0lniSAOZizCKIfOJ0GmvZg/Tr3Xwd2xM+lRq9Vn5rAyufnkuaWEgtV+T9AGP8oo27
 xl5dlEzyR3pP8Z/DlvZRB72WrO53VeipL9OfRocXnYEmd/luUTzZy5m+/ZPeHLL2uKtr
 Mn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832481; x=1779437281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M38U+qau2ZNRXxqkBse09esbSNx2agZ8RpJXMdZSfNM=;
 b=Esp+m2avVgfM3myId3t4dH68doHY4OTABMkXJ1jKdT35A1vhW8jd25EsBKdS5cG3eM
 6njf15+2AmHoJZ7fEzpuOiuDZCKYcx8gatHKJ7um7JkXfCLdTNNcJJiE/Rq/hXhc7X9A
 1AI14vcrtXnP1crg2YjUmWrLgZv4avT7JhhIIxd6FvKXAyFcUg/lzYP3yAQ2cFMjKuf7
 CbC42hVB41uM+CxDVNl2iZbX6oFyh6i2d2E/0XuuK2atrzlbSslpJMcFlWo3ETvTb6SY
 TF7MF2/dOVktLHDdI5/Fu6C0JhFb4fRMBr856HjeCeLNI2FNwEpga0iw3+GVhGjLQaqP
 wRLg==
X-Gm-Message-State: AOJu0Yzm2NnPS3wdzQhOfZrqcEcmyRWxsXV1beDr7Ge0Y5UF1cGgIU1o
 5w+WWS75VXVmHHPyrREAPhOdCojPWk4deAHpuhl7Ndjz+/nIB1fZCfMbWx2NN8i6PMU2RPjYrR6
 qBAAE/igfVN1loOk9MgKov5jgBH3ec8+F33vbkNovfQ==
X-Gm-Gg: Acq92OE6hGHSJX5DAd1JjqqUkSe8HMhwU3D0Zxamq1ntclZaibXi/gG7Iaf3DQ13OvU
 27m84EwVN2TzZ9tXLp2E4a9qJKhxrPutrii0N0UrZ2jtOEwLT6mh8JAFyVeJrtmBw7prDJ2h6Rq
 TwsmeCPo0GBpSheTJ3qgJn2wE5fEma4LH6vua37zSkX7LPVVkHyIOXUaed6K9Vrmfu+AOYVreE+
 WuuL6mx4sdLXeQ1gYwPC8r/fLxFV++ixLfV15OHRVp4GVi5hQt7rh8VCF74FMJbScIRCSDtif2f
 ntZ+6yQfO8d3JRADLlV6BNq7G83qu+Og+hoi5vYYqCXtdLEoBUdkldg+v8l2y8W2DSrjXr91x8z
 loQ==
X-Received: by 2002:a05:690e:4805:b0:651:b962:bc22 with SMTP id
 956f58d0204a3-65e2287ec6bmr2226820d50.63.1778832481213; Fri, 15 May 2026
 01:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-15-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-15-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:07:49 +0100
X-Gm-Features: AVHnY4LHAtvJmrOcDB073I3s7MbAb6OwCgvCs7qiYwGmBtJr-sH_Iri2D47nYFA
Message-ID: <CAFEAcA-_-peZnCUhXMT1HGvHmFa0Xje1wnH8gd1tkgVpxPLo0A@mail.gmail.com>
Subject: Re: [PATCH v6 14/15] hw/arm: Add new machine based on xilinx-zynq-a9
 for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Introduce a new machine type 'beckhoff-cx7200' that inherits from the
> xilinx-zynq-a9 machine. The CX7200 is an industrial PC based on the
> Xilinx Zynq-7000 SoC.
> The machine preserves all standard Zynq features (boot-mode selection,
> SPI, UART, Ethernet, etc.) while adding CX7200-specific hardware
> components.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

This also still has unaddressed code review issues from last
time around:

https://patchew.org/QEMU/20251204093502.50582-1-corvin.koehne@gmail.com/202=
51204093502.50582-15-corvin.koehne@gmail.com/

-- PMM

