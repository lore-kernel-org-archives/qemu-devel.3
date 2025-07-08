Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5B2C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGpB-0006bo-Uc; Tue, 08 Jul 2025 18:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZGoy-0006Ii-Al; Tue, 08 Jul 2025 18:29:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZGow-0002yz-8o; Tue, 08 Jul 2025 18:29:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so8822841a12.2; 
 Tue, 08 Jul 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752013787; x=1752618587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0385rxh4A4bhncIOA31K9h3EFgQvYvoodbJ30+ciqY=;
 b=m3D3Dajm9GBd2csQ42e1ihLS7rGJZgSlYNMwVI0F4Nr3vofFM6lKkoNr71bgMJ9pIZ
 TrbFV31hWox09kHTvgaZk9Cha+xu0VA2VAu6TdcwxZw5HNoWUMfa3bXCSBm4Zv3dKV8U
 yq7Pe14q4lHl4eLa9pNGR6jDvwHrDu0r1ZxZXKuNHbLn0EkN1CKZ8BtLz3eWG0Ep5fFH
 D9W0a/Z/tde7qxY0X1YjFXvE9ndimRU/wbw3Mw6gedvokj9jCUqoTDNercfWF6lV3RBG
 f7K6yF1Nd86fNw/BDY/Mqt0aaqdkxM5Sjvc/VeSMA8K1njZZ2w4EPtM/UF149Bl6+xG1
 ITTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752013787; x=1752618587;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0385rxh4A4bhncIOA31K9h3EFgQvYvoodbJ30+ciqY=;
 b=vDieZi07NJ4SEp2JQKaFaIS8i+spSJf8xehz2+6HVns7oGGiEWA87hYF8lnY0bsIxx
 ociw+DjVlEzCj/i1K1N02K+6D33SfX1NER7q721/O05jbvbSOuOiDvHmmx1WQhijibd2
 cDBrRCO/O6UAg8Y987ffKeimFGz0MLWUipalOGtbm0TWDE52jyjYhj+ecAWgV10k3fv8
 EH0GgASshQi1b7+pJWcLy9jnGoeItkMUOFIe7NtVUI5+lL6APnfAWoLkfWBYwraEmypY
 Qtpqi01I/jH5g2gHNkziV7gfwimNEghUsnwKzNtBatQcqpZDKX1axIsDOKSbVRv+id8k
 QVvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUNfKCOt1Iiooc8nnIAtpxns2UqlBEDSezeFXPmI9y6FWXXAch+Hkgi4Rq9n/bCnTlM+6pZok1IZMh@nongnu.org
X-Gm-Message-State: AOJu0YxkkUV8JR/q46aG+VRNFYb2ST9PG0vK7x1aPRWKp13Rsx8l0Gq8
 bn4qjjLCUbHuyvEoyOC+8Gl/zLsfXh4uHEVzh45cwDzLJzDuOF1u3kHE
X-Gm-Gg: ASbGnctQh9QbSbfU6sr4suYVv3PuEcrcR8nRU23gfKcSAuKT9F026/i3+LowEd1eAzT
 oxmC9NvdhIxwBMNjAjZ5BlP1mw9xIK990gGXseymEKaYZpDTPAn0FzTQ7WTzaxb/VPaJZ2zx9jW
 B4pVjhdRsxpaC4luZAWeIItx5JUyOJRCkavsXACImFT1LoXPF2lpiMV6DOBOj4ldHFMhAtsnWMo
 3mkXG/ORG9N960OXF8qK7TSytO79/cgYaqAzedNs3zKx205ci/NAszCA2dNjCAR3Q/DucvjhYba
 fW5xUcYvTC83roYZiW1i6jqQ7xFwk65+FxIePRi8vcUJzB+wTyNUelQKQ5QxXq5tBihup8K7TcQ
 yt2jzII3LMSXWKLP2Bq70H5BgqTjc1tbmGfOzP97dkTXe3P1qEVy04wBR0btmTQ0V5vLMVQ==
X-Google-Smtp-Source: AGHT+IHfcBtWI+vCtqNz+9Vgx1rMk1onAkTKHkHqPfsb+m3eVvhyW34zVyniKjOc2t5T/qiBPj/v+w==
X-Received: by 2002:a17:907:25c6:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-ae6cfbeb38emr22567966b.36.1752013787178; 
 Tue, 08 Jul 2025 15:29:47 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-18f0-be00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b6a5f0sm961284966b.169.2025.07.08.15.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 15:29:46 -0700 (PDT)
Date: Tue, 08 Jul 2025 22:29:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
In-Reply-To: <4c966437-91b4-4c07-a07e-1a54f51329fe@linaro.org>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-2-shentey@gmail.com>
 <4c966437-91b4-4c07-a07e-1a54f51329fe@linaro.org>
Message-ID: <770CC742-A924-45CC-ADEC-1300910B2AA6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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



Am 30=2E Juni 2025 08:59:22 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>On 29/6/25 22:48, Bernhard Beschow wrote:
>> Allows to run KVM guests inside the imx8mp-evk machine=2E
>>=20
>> Fixes: a4eefc69b237 ("hw/arm: Add i=2EMX 8M Plus EVK board")
>> CC: qemu-stable
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/arm/fsl-imx8mp=2Ec | 4 ++++
>>   1 file changed, 4 insertions(+)
>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Ping

This patch doesn't shift the security boundary and is already reviewed=2E

Best regards,
Bernhard


