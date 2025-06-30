Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D843C83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWL1N-0004VE-7X; Mon, 30 Jun 2025 16:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uWL1G-0004Ue-Vy; Mon, 30 Jun 2025 16:22:27 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uWL1A-0002sZ-Og; Mon, 30 Jun 2025 16:22:26 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae0c4945c76so371287366b.3; 
 Mon, 30 Jun 2025 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751314938; x=1751919738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMwmpWEZqoiCNj7GYzzb6y85+B9zqDZXBHnEWVdHCp8=;
 b=Vhxu/2bjrj0vAR8pL/OpQRLE9SyEx5aOGF6JF4CDtwXixJNEyCwhl7MdN7A20i3j7d
 ENr7tYtIiu4RZayh1ys3B/72/17I9/+fc+8YE4QJc2LWC3My5TO9ygEOyPM/5NqPDL1K
 Ql7B2pJHF/Tp/J7OG7QCiLyJ88ouGwE9gL3G+5CvTP7fN7DgsJzsncuk9G0XUj3tNVqL
 3dkRFrY9bR6k3VyzjJvEEg9hp6IdM9UfkXCov9iVqpNxqyR4trQfCDYZ7WR1Zwqx6t6A
 1yCi0UNYlvPMyMA/FyRLchVgQERqP+QavQfMPK7JgFz//saFHeBNg90djZXLtZW6+9VA
 NUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751314938; x=1751919738;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMwmpWEZqoiCNj7GYzzb6y85+B9zqDZXBHnEWVdHCp8=;
 b=DfvSNOsCaXdkZCDKlt5TASSAEFqTWZbv3S123fdKJA+NjRPRpUOj9tSarkIXRbyIDC
 bk4sFdCptCXT3+NY4Pri7YSAYPzRxDiz/FDFGz98Owb0NQjyNiVYEfUlo1ZoNP4Ro8XX
 4fWAtnRqVhiMdX7UGBuS5c9UrHQ+JFQd3ahdmFUvp6EdiW6yAsrNOHdcAgzYW4DWEdOq
 kXZx5e+Gg7BX5nKOxhv5ajJyuLU6W9y/ic8e/yMFz75OY69q9f2zNnKvwvErve11TLNQ
 fWzwhBfhrovVVDxQVqgt92ZfAAfD9pYq5uRzJdbwd6wZZIZ8xIR5Qio+HriKg+QAj2IJ
 W3XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe32sgr4FaqSjQU3BUIlnMocEsF7PT5W2/VSJqx9tMdh/AIbNa/gWR3ld6iEZFC0V1UzZT6vUiSg==@nongnu.org
X-Gm-Message-State: AOJu0Yz7ebud+fbLJUke4+YGVDrfiN76bkKdcaSEs+5wTG8L9E6CpMGQ
 E3x84Na7iYWiRmRGUl0wmBaUCViArEDAa4AK589cKYEpOPi0OEgaZ3RO
X-Gm-Gg: ASbGncvDGCO+geoEvs7kzwlTu9cVqr9pwbHY6QikXrx7Rvib/Eili2oxWJkrHYO/z/w
 O8EVKnSltsTNXSSw9pOuiwJPyvc4udcZmcqLc4kBdymZ5KR6JskKtyU1lIQon+T0OyzT686TenA
 otnYQYulQJEzcnjWVRLorCegY+ZF+8v6egCMVyAkFXCHhbazKUagdVqPR4yC92+HmRldD6zVQx7
 PIFpZpo+4C4iA2m7aAvrCcl9r+c9UTupI8+/wIWnqNTuYcREMKY4DJSLlLboKEQGWdkcCKWj9qa
 sb8/O2pbrP+tQEzUJbuEyNAwsBi2GixId3Wj0kf0NXGJJJ65xletXA7hi77IB1jhxkOx9kukJB4
 zwxLegGAcX4PsxXc/zMd8/5fMUlLZw3QSlYoizM1CH7KsXaEflKWJE6/twL/GuOj62dm+4g==
X-Google-Smtp-Source: AGHT+IFBhDML4cXnwigreJZeMn/bntmGSlpmDLHmhz+NcU9mkHoMJdATRq7daTMkzbsjwC5/QvQdQA==
X-Received: by 2002:a17:907:3d92:b0:ae0:c7b4:b797 with SMTP id
 a640c23a62f3a-ae35011ff6fmr1407942666b.45.1751314938243; 
 Mon, 30 Jun 2025 13:22:18 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2c1e-5d00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:2c1e:5d00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c6bdcasm734494566b.137.2025.06.30.13.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 13:22:17 -0700 (PDT)
Date: Mon, 30 Jun 2025 20:22:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
Message-ID: <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 30=2E Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter=2Emaydell@lin=
aro=2Eorg>:
>On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> Allows the imx8mp-evk machine to be run with KVM acceleration as a gues=
t=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>>  hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++++----=
-
>>  hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>>  hw/arm/Kconfig                 |  3 ++-
>>  hw/arm/meson=2Ebuild             |  2 +-
>>  5 files changed, 49 insertions(+), 7 deletions(-)
>
>This puts a lot of IMX device models onto our security boundary,
>which makes me a bit nervous -- that's a lot of code which
>wasn't really written or reviewed carefully to ensure it
>can't be exploited by a malicious guest=2E

Hi Peter,

Does KVM increase the attack surface compared to TCG? Is there anything I =
could read to better understand the problem, both in technical and in polic=
y terms? Since the i=2EMX 8M Plus has pretty capable CPUs it would be reall=
y to have KVM acceleration=2E

Thanks,
Bernhard

>
>-- PMM

