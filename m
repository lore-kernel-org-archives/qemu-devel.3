Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78611C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFJi-0000Nk-VM; Tue, 08 Jul 2025 16:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZEYR-0004it-4S; Tue, 08 Jul 2025 16:04:44 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZEYO-000457-HM; Tue, 08 Jul 2025 16:04:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60c01b983b6so514741a12.0; 
 Tue, 08 Jul 2025 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752005074; x=1752609874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oMAwzPritipCfquVZUv8mhtNUDsAFJZW3Evu4z8wbk=;
 b=Qn/KtQwnROMonNQYFerIBEH88WdpJxQ2pNsCDpL1w3wBHySRU48Yd9qvM2v6tsTWTp
 SvV+WMwhkqzjtFtRmMQg2mnHoj5VRIM2H3dt0UZGtg7Xj/PgWuR+XTFBg21bQu6qmrJm
 6Qai1Mhslbdk7LuL5sABcIImJLV/nfXIG4sLg+XRjVMaoJ5W+fAJmvgQM1MStqmMfRc5
 55VkbG0wJAdx5gJbxb5syJw58SF4SmdTQYWS1fsWweQCiqsEWYhRJezZZrL0Ww3qsqvD
 4owpvCExkqq1Yw9mTK27GDubrg6mmMALGuy5rjM96od7GijELC5tDakNBWBnv3zmLhoK
 WBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005074; x=1752609874;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oMAwzPritipCfquVZUv8mhtNUDsAFJZW3Evu4z8wbk=;
 b=Nb8jl+F4N6mFFd9avo0cVH9lmrrCadJrSHTO0AthIRQdMrsrEJZcdNQcMbIZAzHKLY
 1myq0n5g86fREUacpsfYoX2BWkFr6B/mX00LlnrkGSDMZf5xyhDKRZvVLzES1ZJpJAjW
 d4SkVD3/Ezl3+12TdS1Q5HSFnJu4r0/AYqEdt2BjR8nZG+alpA9JB345opgQaoq3dQca
 sfNGXhxmgNX7YXzcFaWxTO9OCK1v8XXcYr/JbkBfVVfpsmpYEHJRdgdm5FRaznHhY1hp
 pn/m1HnQZ0gUhPVhvS+hGIlVfigcMi1TmYa7Ob+AyQxsTuun2pHkZ/gefjsHqQDSmKUI
 6w5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbClzKy+PW4EhdVpAMLKm7Cvxg5kbb/4IA1mUrs26LYaC/q2/yaYEb9ouYNeZ1GQZWRAXyRtdoWw==@nongnu.org
X-Gm-Message-State: AOJu0YxJEOTVCXHH/vLQQC7Vnx/U1aD3RrHOmv0MQ/U2bIy0bZO+op1F
 aCvqr9A4XQZUEaMqtcq6VnIvPJBNNorSuoBKCLG7z/BmA5xSzl4yBg+VHxgzqg==
X-Gm-Gg: ASbGncuke5rbIWBO4/4odGLrM4aeEBxdVqifU5tdfYXBtC2dcp0i2zwvj9eI4TvfIci
 gxxMlsW0+TRu0UE5UQTUdVQHmcFpqGFxClFrBDFGWwhlGIeCkcaIagt39BqWlXpRazFDHK0Uw51
 8rD/EaR8er+gTOId1RDFsIHzKa7rs8zUJ7Y8NIXuBc5pNnWtR2uTMD/Su1noea1IxhFk2cByV2s
 6cxd6mB/+Lx889sjEKe2k5DKNWj6PCg+dyuCzzwQSDYhU4+d/B5T58esFnzxfY689K3kVdCyj6D
 CFK6/A6X5autlQkzjlwlu7av/g2Ux0Gi1UnGmdNv6nWt7pFXji87F1jTCTzwXt0tTOiw9PP3vEe
 F5QdmkSsG44PWFT/tqOVE8NCt9DWfKqjW
X-Google-Smtp-Source: AGHT+IH3ncoZth9TazyDgOU8agP+ky1qsdX/m6cvNNb2WoSnvkyDLvv3qHtpXJOF0cToE+gxRpGaIQ==
X-Received: by 2002:a17:906:30d5:b0:ae3:a753:615b with SMTP id
 a640c23a62f3a-ae6b26f530bmr281665666b.19.1751992565518; 
 Tue, 08 Jul 2025 09:36:05 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d91cdsm907958166b.22.2025.07.08.09.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 09:36:05 -0700 (PDT)
Date: Tue, 08 Jul 2025 16:36:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
 <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
 <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
Message-ID: <3DA254A8-76AC-4214-8C65-D3B3FFF55FF9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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



Am 30=2E Juni 2025 21:03:06 UTC schrieb Peter Maydell <peter=2Emaydell@lin=
aro=2Eorg>:
>On Mon, 30 Jun 2025 at 21:22, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 30=2E Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
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
>> >
>> >This puts a lot of IMX device models onto our security boundary,
>> >which makes me a bit nervous -- that's a lot of code which
>> >wasn't really written or reviewed carefully to ensure it
>> >can't be exploited by a malicious guest=2E
>>
>> Hi Peter,
>>
>> Does KVM increase the attack surface compared to TCG?
>
>Yes, because our security policy says that TCG is not considered
>a security boundary, whereas KVM is:
>
>https://qemu-project=2Egitlab=2Eio/qemu/system/security=2Ehtml
>
>(It would move from "non-virtualization use case" to
>"virtualization use case"=2E)

Thanks, that document nails my question=2E

If KVM requires the imx devices to be inside the security boundary, what n=
eeds to be done to lift them there?

Best regards,
Bernhard

>
>thanks
>-- PMM

