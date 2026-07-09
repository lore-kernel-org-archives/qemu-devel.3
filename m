Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E960C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmUb-0002Ta-Bi; Thu, 09 Jul 2026 07:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmUZ-0002SM-0M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:00:31 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmUW-000549-Vf
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:00:30 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664d7863920so1539177d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783594827; cv=none;
 d=google.com; s=arc-20260327;
 b=lzjXxcfJ3wRpu9/YdLTJFVFevhCreyNmwpfhNIZ0lML3O6/51uHZekwOei7iUVOugT
 d7q16uvdK0I+Wt55kGIrFXSRtLtOaoRBZHlbW0OdbnaAZ8m7VyzepWX7AxSLEoapPpdz
 3rS7hNmIDFH9zGcsn5gSpp1QtoOjuRdPuz9zB0bBQK0USJr+2hfzSb+7BvrrBmQLxRnr
 VKF81TQxDQ/1a3HGj55JEcoQDKoWQQz2eTTxPaNdeRynMMzMbz1rBI0S+8qx21fxy3R+
 tnv2BrJgVFCHDqeCO76tO9zxEkQ0RBVBQE8stJ2Cq6msYIwD8MgHJtVbafP1i0EjPg3o
 gPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UcrkeuriwESCkax1tc2sXwJiv1kMdNza6yhe/5MRVQI=;
 fh=a5XbW2ZDhOftS+BSnIdw+TrQdkIPebI/9LOGBd5AcSU=;
 b=fMvnIgMSEQHGfShs/KPECowEKvp2wMKIWvzutsI3I/lTtF5G1sFfCOVVZ4LstCZ65z
 kFTHtmIt+3j97iqItENe7DmLAQnWzQADOS8HPYbOTqa3gtN0ehJ1YGD90EUtWkkl9a6U
 h+LoLNH3H+hmluUhWbytNNcEF8Ti2pU+As7vSHfxJrcZieE8q0pdkjtgyqc6y9GgXFWW
 EYnvXtMaJhgHiTADynnBgYDEc4qcYCag+mnBLPycsx36TIk3/sv92hfrg3itz+ySdwo8
 w2aYL9rEBx82P62X349LE4mcPbutjvmK1runl798pWmvgEdhH/6w4HpWcpCW5rbsDHFR
 5bnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783594827; x=1784199627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UcrkeuriwESCkax1tc2sXwJiv1kMdNza6yhe/5MRVQI=;
 b=ZP2EkGDLmaQTUt6FyLK/vVQE1y61wogPKrI1FJevLDtOXxg8C/Tbt8LbaYD8UmjXdo
 T9X32s29OHN0m2xpO7iRYEZfD9xutXXFvBY5Ff5hoDygNSxxWSWj7fpBNXD+Z5ACjHbl
 CnLhF5/1tRrZF8o5YDWz1JgSK0MrZEIvG2sZd3rVVCxm+AbSKKrFIwdu6mv+Lq0RppQz
 jU5roKjBjfjh5hrA05uW5etmpdosPNGN89UUCBfmf+piHC/6JKn8Nx/UNm+0DHlmFfe6
 TdkHosF44EgpR03jNRtPKtO/A8qbF6ie9UsSu/i9sCEcTvI6XBdHxIUfI2PblUnfvHmx
 CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594827; x=1784199627;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UcrkeuriwESCkax1tc2sXwJiv1kMdNza6yhe/5MRVQI=;
 b=d5H6enO6JwTvxGd3TKTP46xhmaySq9yIJ1bsl3ymiB0U1qf0zoi/i8aW6LHDdGz6/N
 2zhNb4Q87M9oR+y8txHV0N7i/FP/TEaW2SKInlObYcZO89GQD4u15arJzEFIHLjMX/3C
 o3vV8kfNy/fx5tPaytfFDg5zZrczf3VOrz0maZRhAPlRspOGpF/zyCS4gxopa1BSbAhT
 LuEov+XObqt0drEsA6TR3/LSljKYx4HWHoMBlfqbCuEZtmyy/uYAegEwben+UOaCSPMX
 bdFxtFMwsI0sJmTB/tqcFBSgHCwM2I+3yY+SEwE+KvBVV13C3Wvh+MLiCqXj385XULFu
 oafw==
X-Gm-Message-State: AOJu0Yw2b5GAP9IS3bsvt1ZuQqynV0OwY6jDZzTdzRyQlQVOtmvDf1AZ
 LOWh+De3o+i7H8hBieHEunWcZQiABvQWj0Px6ICK/wIlix+v8btAKd0zhroG8pMtqC39L6aLdI5
 hc5TYsYpkzp2mZifhfSNhKbM2QvOvq2rThGaANrNa/A==
X-Gm-Gg: AfdE7cl1fe7FD9fRY5vCZFFwN+MiJc8JZuaF17OJylhI/nDR/KepV0yr4ZUlAJDctw2
 RlosT8clvykRAVlqGyUCM6UOgkez4iNu95Q38/1yHnBQVNOyH4+WbOzUxWdlX9iwpCAKYii5HFF
 xaj47cL9anxIsiz7sIHymDpFaoia+jyE3oW2hD61WHerSqD3k2J250MRC6ObbRLBSKKfcEq80+f
 CFktBfdPeOBFyeg4quJDMaU/CmXLZeoU3nGmRq3roCxh0v9iAymOGxC/OVr9vayGqk1x1koTk8E
 S7fuYTYsmNfSC0JoiBEjBEJq46Xv+HDHh8Cx7207Cnad/+9R4S4MT8gp
X-Received: by 2002:a53:cac1:0:b0:664:ae69:230b with SMTP id
 956f58d0204a3-6679f28b918mr3997311d50.72.1783594827380; Thu, 09 Jul 2026
 04:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260707145407.70287-1-corvin.koehne@gmail.com>
In-Reply-To: <20260707145407.70287-1-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:00:15 +0100
X-Gm-Features: AVVi8CeotFHBKi58-Vligna6L6HXiUYDiOmZw-JiRgR4ZqG0i9hwZQs9X7YDQYk
Message-ID: <CAFEAcA_nHT9qW7ofvay4M0Bo_LNXKDumEH5ntuYhXEcPYgzeTw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/zynq_slcr.c: drop duplicate reset value for
 DDRIOB_DCI_CTRL
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, YannickV <Y.Vossen@beckhoff.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 7 Jul 2026 at 15:54, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> When adding a reset value for DDRIOB_DCI_CTRL in c8ba862dbfdc, we haven't
> noticed that a reset value already exists. DDRIOB is a 32 bit register, s=
o
> incrementing it by 12 will access the DDRIOB_DCI_CTRL register. According=
 to
> the manual [1] the correct reset value is 0x00000020. Additionally,
> c8ba862dbfdc won't work with a reset value of 0x00000021 because it tries=
 to
> detect a toggle of the reset bit (bit 0). Therefore, we drop the old rese=
t
> value and keep the new one introduced in c8ba862dbfdc.
>
> [1] https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-DD=
RIOB_DCI_CTRL
>
> Fixes: c8ba862dbfdc ("hw/misc/zynq_slcr: Add logic for DCI configuration"=
)
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>



Applied to target-arm.next, thanks.

-- PMM

