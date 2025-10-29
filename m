Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3493CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE7Fc-000231-8U; Wed, 29 Oct 2025 10:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE7FY-00022b-EC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:34:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE7FF-0000sQ-MJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:34:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475e01db75aso33284785e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761748425; x=1762353225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4P4RFdLWn7OSvy3yHrhLcnspeuf0oqHmgGpCZpxEaHI=;
 b=MWP7xtqPxLYYnqUDzUZxfs4QM+okrOeYuV7hfnw07sLy5GVtokqdj+wgGACJpHf0+K
 N7AQYRKq0YkkSNIQNqJcUPQnxXS7Xjg4RvJekPMrHYjla1+7Xc1z0Z8jZWvGf7B2Hu+E
 9K5dx6BMusCInz9x4d5p0vX8exjr/pqMuCJk4ejQugDf5bPUb0KKLNTKJGNhpwc9fNDR
 4HM58W+WMmiTZNuZyajons6hz71plwGNoUJlt2fHMLJaEOduzra3MzvwwgN5zclJaTRf
 Kha/Baw5SKjmuslnB/YVCFt7cVW+sKfHITmpTo5Lg/Qv0sIKc+lYNEnWfgRnZBERe9aQ
 LkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761748425; x=1762353225;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4P4RFdLWn7OSvy3yHrhLcnspeuf0oqHmgGpCZpxEaHI=;
 b=eC8OlTQY+EI9Wmz7viQDh3fW8fTlYgetA/uoe7IP55IbNSOuU2JD2yCs+B5Ct1urdP
 gcUMMOzAclVfEbcGDr7sMU+k2SiDPw5cDCeTFqCpRBKFDMyOgRdUSloz16a16oNcO+2r
 kApbm81+2GkY2C3B961v4ZNUtGHOzzKlPpWfgN8CZOhbICozofpkMA51CU3ftolQtCOC
 meynprvB6+wH/m7te7DZNB5yl57CGbuFas4QjajkTW7JjNGiBVHyZfIrWvO/NnQaJjbY
 plpTHFpi/z6GK5qcudVzmQ9zVPMKOn8Oh0WuT3Vc7OJ5+YshTKlwCrl68bIZLhpuQ5U8
 rPHQ==
X-Gm-Message-State: AOJu0YxJGyDD6s+xOgMAsptLze1KIOFuyC2T+B7ABq0pBfCtE7/Gvlrz
 1Dbh3acQESu70LPDJcAJshEPfPwfKiPuGKfIsIToOK3TaBqUEhPC1hvw
X-Gm-Gg: ASbGncv9wi8tpt0KLNWxljivynJpMem4EbNTAdMeNlPe0lcU7oZkZmlhtczLMY1roFz
 iZqDY5kDTElx/umf0SSGkVq8nEtOg5elPuEiDOZEst+fo0zcSRXT6l1nFwqD6gyqZ6YpClwblHC
 vhGF/UJ6YZMvdRx0pyFC7cGMyVpYRNF3/zMULdprJROobY59DxRa1vRtGI7nJXWQAyQoVcbeX2Y
 O+Nzw5zX3h83AZUBOL+HYzQDFEUtbbFDKrnkC6sCe46/R02sFFBrOq3trodv7TctEVaJahz66l4
 u1XguX1Fbpp5Q3Vj8T9IQLJampDCuVG8tll/ah0TAxE4nVJMp9dfFDsWlv/3noMqYEMmFlhS6PD
 DlUYl1GBr3CN/liDyrpWU8OONCsBV7wdvQv7jgnnz2h2VxIIaYij4Z2rXFCcfO9hr5LKrJgl/Ww
 ctIl0L1cXHxDI6rpgS/3118H+XXaN0bmwIHi4yoHy5dSWgxOPMPFvYS4stNV/6OrC6GnhOOUfw
X-Google-Smtp-Source: AGHT+IHIZ8iOInjlv0lPfmqS1VVt2E/SJEWfrZbljStqXredFswBxYMSY6vT8h3UHkeRjxevcgR83g==
X-Received: by 2002:a05:600d:8389:b0:475:da13:256b with SMTP id
 5b1f17b1804b1-4771e3cb77cmr15763455e9.38.1761748424376; 
 Wed, 29 Oct 2025 07:33:44 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400c439911fd9f45c3c.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:c439:911f:d9f4:5c3c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da645sm25428038f8f.30.2025.10.29.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 07:33:43 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:33:40 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Phil_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <CAFEAcA9RBxs3C068BRgzKCqFxQh2K5rmXwyiph4_imOiy7JxLg@mail.gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA9Rvvymu7oS0pPx00v9SdXzwr27vy1VmnZmwQ7ayZK+yQ@mail.gmail.com>
 <2F14E49B-D152-470C-A87C-525853EB8ED5@gmail.com>
 <CAFEAcA9RBxs3C068BRgzKCqFxQh2K5rmXwyiph4_imOiy7JxLg@mail.gmail.com>
Message-ID: <D242944E-FB0E-4BD4-859E-998CC5D607EC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 28=2E Oktober 2025 16:09:50 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 28 Oct 2025 at 14:41, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 28=2E Oktober 2025 12:46:34 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail=2Ecom> w=
rote:
>> >>
>> >> Allows the imx8mp-evk machine to be run with KVM acceleration as a g=
uest=2E
>> >>
>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> ---
>> >>  docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>> >>  hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++++-=
----
>> >>  hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>> >>  hw/arm/Kconfig                 |  3 ++-
>> >>  hw/arm/meson=2Ebuild             |  2 +-
>> >>  5 files changed, 49 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/docs/system/arm/imx8mp-evk=2Erst b/docs/system/arm/imx8=
mp-evk=2Erst
>> >> index b2f7d29ade=2E=2E1399820163 100644
>> >> --- a/docs/system/arm/imx8mp-evk=2Erst
>> >> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> >> @@ -60,3 +60,10 @@ Now that everything is prepared the machine can b=
e started as follows:
>> >>        -dtb imx8mp-evk=2Edtb \
>> >>        -append "root=3D/dev/mmcblk2p2" \
>> >>        -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3D=
mmcblk2
>> >> +
>> >> +
>> >> +KVM Virtualization
>> >> +------------------
>> >> +
>> >> +To enable hardware-assisted acceleration via KVM, append
>> >> +``-accel kvm -cpu host`` to the command line=2E
>> >
>> >Coming back to this now we've resolved the "does this put
>> >things inside our security-promises that we don't want"
>> >question=2E=2E=2E
>> >
>> >I think we should be a bit clearer in the documentation
>> >about what tradeoffs the user is making here when they select
>> >KVM=2E Specifically:
>> >
>> > * we should note that this is intended only to improve
>> >   performance, and is not covered by QEMU's security policy
>>
>> Sure, I'll add it=2E
>>
>> > * we should say that you will not get a Cortex-A53, so any
>> >   guest code with tight dependencies on the host CPU type
>> >   might not work correctly
>>
>> Ack=2E I'd also hardcode the CPU type to host since asking for a Cortex=
-A53 always failed on me with KVM=2E
>
>Yes, this is the right thing (at least until some distant
>day when we add support for having KVM give the guest a vcpu
>that looks like a particular cpu type)=2E The 'cortex-a53'
>cpu type with KVM will only work if the host happens to be
>that, which isn't very useful for most people=2E
>
>> > * we should say that the guest will only be able to run
>> >   at EL1, and (unlike TCG) there is no EL2 or EL3
>>
>> Real U-Boot calls back into the on-chip ROM which isn't implemented yet=
=2E Furthermore, there are some unimplemented USDHC extensions which preven=
t complete loading of binaries into RAM by U-Boot (similar limitation exist=
s for e500 boards)=2E Therefore the board documentation only advertises dir=
ect kernel boot=2E AFAIU EL2 and EL3 aren't usable there anyway=2E Correct?=
 Do we need to mention this limitation regardless?
>
>I think it's worth mentioning anyway -- not every EL3
>payload is necessarily u-boot=2E

Thanks for=2Ethe feedback! Version 2 is out=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

