Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012FDF327C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF6gM-0006Ii-Cu; Tue, 21 Apr 2026 04:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wF6gK-0006Hz-Gr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:42:08 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wF6gI-00038Y-O1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:42:08 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so3166562d50.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776760925; cv=none;
 d=google.com; s=arc-20240605;
 b=LzxgkbI9gjlIGUAnLlwMwnSW+hm7dTHh5VKwpoRmVkxSwDKNJl2YYWdzAW/ektBbVB
 zc/+bw4JNwpHbPdzSlDnhnL17j5NG3TZWvTwxkO/gomJoeXJvj4Biq/GWSzLWqaYH+Rr
 E3Km2WLIWeu5EOId06SAZ2Tq5nvXB4nd5A2CPhPtM1YOnkSXqkpVl3QWHlnJRxcc0b5O
 d13bol5EWG4INtA9OR8R5FFP3Tc2FwxrOP9XmpyL0wnuj00iZOIpHMuCAE+rcZr50uvG
 ZX9QlByhMK6ZZJgUw3kPu9iRHyVBWxWF9T2V+8VNbE9pCML10bhOic07g4BnVoa5tXfU
 RpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pkN1JBmanUEOKiq6af58ThegBRjT5yctGC3q3GS1kYU=;
 fh=EgP5TNajs02ZcZMtU/5Ht6otQ0qQU/YZQZO4GwaWWG4=;
 b=E8/vioc/Lyd1R+TBquD5pUgs3ulmKQ4nN5zprmvEEpoeVIQnVDP00Ezlg06kzsl2Q6
 YdbmkqQn/fsjyXEL/+8x1h/3mMTHpNMGsOPs0TJLUFiAkugJaralCd97e8VidFVh4Hf3
 TquzOJEoiz7G9w7NKgXR4c5N2dqKHJMEtqyPHm2wHXt/WHMxp0SdFAOtP/qftf5bXjPn
 OuwCH7WinKC158w5KNqlYGre7A+gCN+CIQNEPOnc2j+cPzC32OyITjmy9LlbEdfwbmSD
 miPyuNmqnnL22fqDlm/ZIh6wCHRTsid/Kx8gNOpifrkLRSTizobaWhc0OgIxXUoQ1FJW
 leMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776760925; x=1777365725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pkN1JBmanUEOKiq6af58ThegBRjT5yctGC3q3GS1kYU=;
 b=rLlgR/DP4+Dpsnb1k3AXajrWpRNTHSZWpFe/QhLsdZAPcIkkaYk9DswaasRcuBBMnK
 TZLmniPUNco0OBiPyOArPyXbs/576x8fA/SSQa/NuNeL2+rbAA3f0OwVbNVkbaN1A5ub
 fhnURtcEPV/ds1yS96Rn2gl/pWMTJywoNZzv/1onCNPASST1qXkuLVawab3DaTNPL9V9
 TolTH63QVXZ1Vkstj9q/ZAs+jtvX3C+Rhoob76q01wvxN2DvVBXpGzKFc2uw02c3Jk9m
 z4YFfEzRM0TRrrzUZdt7aF79Yj8RKQ3h2wJ3afUzI9Z32lS5EfYjj2AtmZ3mmigLcRl7
 2++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776760925; x=1777365725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkN1JBmanUEOKiq6af58ThegBRjT5yctGC3q3GS1kYU=;
 b=R8TpvDIxZkjwXj8fur5H9zKNZhUAKIVB1jVmGHJZVcHD/QbmZ73LGE4pFWQYrk+NLL
 IvsxI3uQqiBJUzNqgtiPSEm4NNmls4o5BvCdD2PxxpCzyyy1KYkUTJVBdjzhOLGHuOXC
 Su7AqvSnTS+Cw07lgy9dJ2OvnlNofHsp268Rmqhy4VfEZc9zc3Zsp6+s76TfVWzX+JxO
 xSqe+U8g4Ggp0+y5p49Ae4OAI18htmSS8PurNckh7EQGimXIOJLOMu/NKtfUi0twyNzF
 ELroWs9+PJ3O19gjv5zHEjkcczfo1YttbTGe1Y4k1X51phx80VjFRn82mButiHmszx8F
 RNyQ==
X-Gm-Message-State: AOJu0YzThmMzCTQmEhrbhWSW1Ii4rSNbpanVZuVeyvItN6ZI6QnJ5H0S
 jT0bqpCIWkHLzZd0ZN09ojXXiv8xO3YUJ3B+b+MJttmw+tyHQz6yz2zjXfd+ZqRAgIDu+oL8tlH
 GM6WCrEkK7nuX70XoRB89eDeFnMlUwt1Rfd6zon9b7Q==
X-Gm-Gg: AeBDiev8yYKjIi1Ee7F5yDZl99wnINIR4dxI/8l66k7FfrjAvdIqkeCsLeq1QENmlTn
 EkLPWwkvoPxYJmvw/aan0lo9Cp088vbQxt6i8TeJt1b7tWjsH10/0Nt+xwOhM73+WzhLWMKYylW
 XVnNYVLnoMGWZRVRRRxlTPoHB4U6olcfDpwpwa7mEhLlLITvYMAng0i7xWY/ofKWwJYv2az6z6S
 Pl6UDd+vvggenf8MY+pDGscli/OhbuthUpEjYGB8zjl2b2aPkgTzREtwusr9LebDhk8VfNwPJVK
 44Sm8BAKkVWSGgc8RQMFCmICGU9GQMoQIsZYJBfOE7KH0taDZC1LmMwWVUXm13OTkm5OhJ08EsC
 6zQ==
X-Received: by 2002:a05:690e:130e:b0:651:bc3b:75c7 with SMTP id
 956f58d0204a3-65310804a7bmr16086869d50.11.1776760925553; Tue, 21 Apr 2026
 01:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260421082935.85995-1-thuth@redhat.com>
In-Reply-To: <20260421082935.85995-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2026 09:41:54 +0100
X-Gm-Features: AQROBzBjzkjg82Uxm_550fvWhUsgz7_cl9OzZbdv5DNaq_GFpL9-x8n_64U9vOM
Message-ID: <CAFEAcA9Yx_kSc0KYbJW1aJcuCpnhQ=1v4-cebq-Y7XO_+Y+=Rw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Fix the valid access size to the avr-power device
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 21 Apr 2026 at 09:29, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Accessing the device with in non-single byte mode currently causes
> QEMU to abort:
>
>  $ echo "writew 0x800064 0x4142" | \
>    ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
>  [I 0.000000] OPENED
>  [R +0.001784] writew 0x800064 0x4142
>  qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58: avr_mask_write:
>   Assertion `offset == 0' failed.
>  Aborted                    (core dumped)
>
> Set the valid max access size to 1 to fix the problem.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/misc/avr_power.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
> index f42cf4fd906..42be2656911 100644
> --- a/hw/misc/avr_power.c
> +++ b/hw/misc/avr_power.c
> @@ -73,6 +73,9 @@ static const MemoryRegionOps avr_mask_ops = {
>      .impl = {
>          .max_access_size = 1,
>      },
> +    .valid = {
> +        .max_access_size = 1,
> +    },
>  };

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

