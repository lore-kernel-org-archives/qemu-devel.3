Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A71CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 07:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqngB-0002Ss-L8; Tue, 26 Aug 2025 03:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uqnfo-0002NW-BN; Tue, 26 Aug 2025 03:00:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uqnfh-00011t-HL; Tue, 26 Aug 2025 03:00:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso45146025e9.3; 
 Tue, 26 Aug 2025 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756191635; x=1756796435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBWaeHjVcW9Fko9vgWrkD3gaxMxJDzk7C4A9jrfi6jc=;
 b=mKhzAyLNisWIWM5kKAMLOE3Jm968rp+RZvqOVvRiQY5HbY3lc/0X6FNhOfdF299QrJ
 9x5j2KxNjFR4HcqZcAmQFVU0+umDAyieuDz5rPzPmvqL7wcROdR3pN6+z9k8G/IECjQy
 uL5bKnO5i72ICsPDu10aztPDxA+yGj07PrCBWFBMR0kdMB5jqQFeVytVScDmRa/etb4P
 TTR9xGfyURJYOapv/+OXECmAaAGa7BtjqfQdzVEGi/qQYD8DvQfacYY0zD59Ui6Nijuk
 vOQFyijDnmpgWHhB+i33n4hKAcvK8oNFLsEEBNA9fZbpireOdJpaWPo5ZENZ572coqP2
 qRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756191635; x=1756796435;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBWaeHjVcW9Fko9vgWrkD3gaxMxJDzk7C4A9jrfi6jc=;
 b=bBqSJFYNJwsKqChjtspeqXJBul9W2jrcBpxbjDcnnml6ZORuMfrtmZeJBmXkBhPvKj
 STpX/8i6HdF3tUfDR5JhmhcvWsoumEnfKncAFM2K/GrShOSFZpjRGmPpDNiQsUAQPR7X
 jZge/kLyGocZvMJstu9C57FYzZEZRh4mQc1ugh+6xfAhvt2ZpBGiQVx3APz7oJIsjqIS
 rdYRsE9eeWeG19SVCRMGBybpV0svID7QcQWmvC3mE4IYa2bl5LhtDYVoNLaevG8NN4sV
 YrxXLoHGaLFE7SitFlbeHpRHrdplMUhq5ocJ2+h3QzHOqZsfE0GiiZy5uRuTDu/mpfI9
 KpKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgoBphxeX5DX5qIPI8otXwWARMnlDcOhCyC6QhwoZoRKkOKqhWuANShvZVpsx4oJA5fefYzKRjEQ==@nongnu.org
X-Gm-Message-State: AOJu0YwwcSY+Zm30yibSyHPPSC40JhB7F1+nIxHk6rnv0QdgojKz+06P
 9lmEAYuL6lHsFzIeqOgYIbv/UrBo3xxWCP1ZADcko397asLApixvcbSB
X-Gm-Gg: ASbGnctp/ONKWQqSO8Gk/rX5fxF4Dm3BQJrWWYeSGvSVx4ZXeXuCyp4JefRNDLk6bLG
 qn5e4+LWC/7YjOnZhvJ3T5hT5HhE7ODQNRnzMG2nevCm/hCKZQ/+tsP+yB9wPGgOZJCaHMC5bre
 7+FLZHbXBm12L4VRJ2hikY8E+4lxhSZm+J/OvOFKFmxDVO59jf7NNXAHdcZEJ+vhwThtrhe4CIY
 WPbhrSHjr/CCJlfnHd2U7RUYBgertLOdRso6K0apwwmp19yeN3KDHgAX1DLhM6g0mMfNct/91IP
 Xsw7i7hmP52nGonolANjTeqqnrQFSkNSsiOyrgwQFN0WLiMI8tjwjf5U1z9AwNQsDlTQyj/A8Vz
 gJ8iSChCQoiptPFEULnQdZduucBsZHC9dfa52HEgoGNd+cNFkbCNtmVXRCj3XP+Obeu7XvNDhv7
 uer1e//Dspsh2e9b1c4Dl/DQRSnIkLOw==
X-Google-Smtp-Source: AGHT+IGfSnHpfcB1ujebQ1sLIsG1QfCFGeMzoFNGXILF0Xx1Pho5sVsX5RmZg8EmgZqWjH6nGJwCnA==
X-Received: by 2002:a05:600c:3b94:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45b6456ee5amr28714805e9.2.1756191634906; 
 Tue, 26 Aug 2025 00:00:34 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf05a00031cf8e3dd82746ae.dip0.t-ipconnect.de.
 [2003:fa:af05:a000:31cf:8e3d:d827:46ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211bd7sm15052976f8f.38.2025.08.26.00.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 00:00:34 -0700 (PDT)
Date: Tue, 26 Aug 2025 05:50:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <57BBA45B-76EB-4922-8611-9596C9B37CCE@gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
 <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
 <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
 <3DA254A8-76AC-4214-8C65-D3B3FFF55FF9@gmail.com>
 <57BBA45B-76EB-4922-8611-9596C9B37CCE@gmail.com>
Message-ID: <B075C670-C5A1-482D-8E78-A2C81FBEFE11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E August 2025 11:01:53 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 8=2E Juli 2025 16:36:03 UTC schrieb Bernhard Beschow <shentey@gmail=2E=
com>:
>>
>>
>>Am 30=2E Juni 2025 21:03:06 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>>>On Mon, 30 Jun 2025 at 21:22, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>>>>
>>>>
>>>>
>>>> Am 30=2E Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>>>> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail=2Ecom>=
 wrote:
>>>> >>
>>>> >> Allows the imx8mp-evk machine to be run with KVM acceleration as a=
 guest=2E
>>>> >>
>>>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> >> ---
>>>> >>  docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>>>> >>  hw/arm/fsl-imx8mp=2Ec            | 33 +++++++++++++++++++++++++++=
+-----
>>>> >>  hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>>>> >>  hw/arm/Kconfig                 |  3 ++-
>>>> >>  hw/arm/meson=2Ebuild             |  2 +-
>>>> >>  5 files changed, 49 insertions(+), 7 deletions(-)
>>>> >
>>>> >This puts a lot of IMX device models onto our security boundary,
>>>> >which makes me a bit nervous -- that's a lot of code which
>>>> >wasn't really written or reviewed carefully to ensure it
>>>> >can't be exploited by a malicious guest=2E
>>>>
>>>> Hi Peter,
>>>>
>>>> Does KVM increase the attack surface compared to TCG?
>>>
>>>Yes, because our security policy says that TCG is not considered
>>>a security boundary, whereas KVM is:
>>>
>>>https://qemu-project=2Egitlab=2Eio/qemu/system/security=2Ehtml
>>>
>>>(It would move from "non-virtualization use case" to
>>>"virtualization use case"=2E)
>>
>>Thanks, that document nails my question=2E
>>
>>If KVM requires the imx devices to be inside the security boundary, what=
 needs to be done to lift them there?
>
>Ping

Ping^2

>
>>
>>Best regards,
>>Bernhard
>>
>>>
>>>thanks
>>>-- PMM

