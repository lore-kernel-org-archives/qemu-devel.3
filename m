Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BD7CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnXz-0008FF-8j; Fri, 15 May 2026 04:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnXy-0008Ey-Hm
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:05:26 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnXt-0001bj-Lj
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:05:26 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65db820588aso6563744d50.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832312; cv=none;
 d=google.com; s=arc-20240605;
 b=dEqTFaPNQwMrWiWMHP3EDck0kUGF9TzRa383ZybsIS67ISjG2nuTpd9duE4vFhHEEC
 FjzpYw0ADSDRGDQTl7d4c4JZQ8bYjJFTaY6Y0stS0ndwJXtJo33YRa4pT5to5HsowD7e
 MUQOuH6XG2TbzEdMKJ5QHszF4PoxjBD1wjLHgevPf2Zxrvj1Q4ws2sdLyicXAzML0BSR
 QcjVS9LmsOrQCdf7ZVuwjRKmv3Bo0P24OeOAG3Ek97UiRj7LrC0LMFTUDiElY4XpxJ44
 Xfqiqly1iIRR32hxzYWoaHb0iv2i4662vyXLywhEKO281tbsL609P8V6XRG0kopctSi4
 amHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HnYsEQVL9dMO2N/s53m3HWDVMwKyMQo5sK+LOR840cE=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=PosJXGy++a4HlblabGgHdGWvFdc4bkTtQe3TTFI4mOzQmva4kryK/3GSiHfE3yzMrW
 z10BtTHwV1z/VsqayFKXCCHORBy5OHsUYxwxWRXEcRcZkW5bYvZk4ccesiFPV50fGF45
 3SZCE7SuC/ieKqFc+aJDbou3OSvj/Ng5dnbVT1swY00a0KcH2VfUDZ/R4Tgu9W7P/Qrw
 t5z320TXJppgH5Z2iXU1eN4D1hgwL1rf39iEo7T1n4mE+uN8LP8diymFS6fSsi0jC5CI
 Fg62N0Sl5C0dqBFH9BbA4TNxwbHx0eU7VTpZrln+YJ/R7uRX/pNOKB9DIQtDZSReFMa8
 tzWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832312; x=1779437112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnYsEQVL9dMO2N/s53m3HWDVMwKyMQo5sK+LOR840cE=;
 b=g0161VOFJVhWls+VIQPFNSBQLopjUJ0hFVFbNPLD+RR7xklpx0NsgF0UYGFwr0BA1M
 iFd/tkcqgf9MUORxUygwZnWvVjDKsvLznlkTZJm3KS0iVjRMA/YmAvwfxy+qAiKUSDNi
 OSSHaHPGCUKVcZVqo3lwhMxSov3Sm7xY1sXhiLG9S90mjfR75mRU2s6hi35FwNWWZQbO
 XO+sNMxeEgBOJVdm4MVeGDdA2XvC5aVVTGOBTRW/x7yJpMuIg5CgfDYApauc4qycOLIP
 Ax1CBXa3XdP3hBdeGpt8i22wSje7lLh7drzy5iEOEbKJJMs11hRN3G8Zxf9ujeQDEEh7
 MaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832312; x=1779437112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HnYsEQVL9dMO2N/s53m3HWDVMwKyMQo5sK+LOR840cE=;
 b=RR7c18vpnbDzgcYW5w/e9L92GPDRNrzrRYpbFhZhaI2wHLY6S6Ru1ZQPWht7qTFlr2
 qOOwKQe6ixzmwea5T8vPmawYZtDmhR0/FCvMq+RdwguwMtgaGYGpGdJ23pPPQEZNehz6
 kw/B9fe74wETFNIG4qmdMKSYrFQpXfqsiSOk2hTnvPHqEK1/dCytY1g49/Z19ae587sa
 VzUdEv+tGBFv0/tB7aVe6q+5HdyFF3uHEYrJCwg+Lau0afQhc8OdjnUYoFyWsiMKPEJf
 VLY9MDxQHqGziqcwbEHHvYPt7HFKlfVofU3ZyUcYoSd7xnpRBB68opktTFA9yugazqPC
 4SHg==
X-Gm-Message-State: AOJu0YxLj+zhNJ/13e/JtieiSf1ikVby9ry9f39SKC+rcygM4xpmJMDa
 q9mY2aMmmCUp68vXzjgkGM+ImtkqNl+dFTBVg0zP5cuCjez2ukqXSNEyR3f8JxMHSGDyPQ8aN0V
 9nPzOyuBzUK7ifMhTl3a4huUD58QIjU52Y14sGeyIrQ==
X-Gm-Gg: Acq92OEUmdkl6Zuc1XeK4HPo9ELMCs5IWfo6CJ1bMwmyWCrTfGDa86wzp7Sdv/A/OT7
 /OhBN5YI4606p0JVSRdQun7DNHjgrMh9nyAEvSwtFHek62mLIe61xyVn9ElES2hCGAUu1pzK2WR
 sl7/OXheiCR30Llq2kXSbQw6ORlp9IUJkcTqrxmbMm+6kEr/hm1EWTkEANfdr0JzmmbOLn6GHpL
 IHJ0/287Q5uAx/GZ1KLHKcyNi/7U3egjd+RDOP9XDexl4Vg0K87hAisUhnQ0B14WprROmuuyaUe
 NcJ+2HoHaUftShSk8z/8XnrAlD/RtUbM0XfiTLlQRt9k3PGgLyfSSML1PCpvbf2NX/0=
X-Received: by 2002:a05:690e:2501:10b0:654:28b9:e50 with SMTP id
 956f58d0204a3-65e227f64f0mr2343975d50.40.1778832311545; Fri, 15 May 2026
 01:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-12-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-12-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:04:59 +0100
X-Gm-Features: AVHnY4LzgOjijIKoT1x5ObKE2BRtNh7QeM7Q1sXVSLElYpvF_8q4hMwxr_Jcw90
Message-ID: <CAFEAcA_QMfn6OvjuxfG0m90ZP54KpvkpnCjuVUakiCs5KEjUMw@mail.gmail.com>
Subject: Re: [PATCH v6 11/15] hw/block/m25p80: Add HAS_SR_TB flag for
 is25lp016d
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
> whether the upper or lower range should be protected. Therefore,
> we add the HAS_SR_TB flag to the is25lp016d flags.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

