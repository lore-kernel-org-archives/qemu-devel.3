Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BEC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0fX-0002wU-Sd; Tue, 25 Feb 2025 14:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tn0fO-0002v8-C7; Tue, 25 Feb 2025 14:32:34 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tn0fM-0007un-GK; Tue, 25 Feb 2025 14:32:29 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5dec996069aso9727651a12.2; 
 Tue, 25 Feb 2025 11:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740511946; x=1741116746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvE73Rg5rWKbwPbQYMIOUPC3ryk2kn7Ur9BRIhAoTLE=;
 b=PUGjtKEW++kskJ0q2+dZ7lW5VRJBxAg8Z4WD+qp9YGcqIGUjNjqzldTA9CPqJKPWN9
 STSjNfXYIvyUjHpPToUleALEfV5+MUBDpxiTcdVhza/fIyDoZk4MEe4ALCD6DpO1ykiv
 sjJgNMQkSLIJLfT1JShBkbvB6Ng1ayit539iDVXlXzSOG6vF9VN+2rjrZ6ETgsvQ9F3B
 6mgzvjEq8jm1YvI4YFB1Kh1J7fN5j1aPmbhq8Eg2LJmqJkmml+DlhaJN/l+5AIUFX6tR
 9qjOyR6inrs5pAR4/M4ksNJRdV0UTRKYAs/PaqwRpJJus+5B4hzjg2sHsmozHXKGgiU3
 EUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511946; x=1741116746;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvE73Rg5rWKbwPbQYMIOUPC3ryk2kn7Ur9BRIhAoTLE=;
 b=ZphiLipMnlzsbNTQAy8utR4i3WAwwsqvBB7wa2xeDHcV+1JqeDhxsQnYT4sgH9xTQv
 WiZy9bw3A/w+5x+N/96GEc0EdRGr87NQJ51pHiqsAUS1Vzc8JfwoCLRwSLgCBm5yg7bc
 uyR/1c0VKT9PKZ5begOKF9BZ7bbQA+08XBtCmX7HhkWXc3+Bx92eCp5dmlmVZnSaBofd
 DCvYBxlJJ2TAcnS+48NTEXIxhTwxtoMjXzy9Y0iaFj9isqiI08136/WcVDGpJBwj/C62
 WNhgjmEXYTY0/yL4y9NJfO2tnSwX/pTWnvNxKheF5z/S1WP6HJzV3adqgx6VOqOY/9Js
 j3fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH7zaVbr7acnMZdILS21kAdTkZgZoQVzQzn+hLz7WEmHK0QeMaL02iX/1ttfj7j5nxlbEAgFZ2wA==@nongnu.org
X-Gm-Message-State: AOJu0YxXt/a5dhff4erdwm5oqMhk1g/DIizETt3QAKrq2VSX60F5emew
 gSI1fiHtlJnRk5E6frUzsntYRlgeZXsFVWl3MawVeLzFq5VQ5qok
X-Gm-Gg: ASbGncsdaJun3lLf62T0bc3PUxQzcLZxOzcPyaUIY5pBb61rpwelN71DfN3Qwa/KLyF
 gTGfglZ2raWpBB0NVHX7XOFML3xozdokPmxD9AFRRIaCuTQyw6W8LYVyrp63CyHIJcW8xrjNYWx
 W52g0I7Jbhp9IRQ+fesjAsp7VLuWvaGKNaYzH6vs0Q80nWGol3ADNf+aScFfdG4ZnxpK7uPjEOW
 U80MtcKPBKdqT2Nn1GNX7OfJDD0mdF9yQr7DbpLqx21ar2FXTuEneAANehoJbZHeXzI+WKHbkv2
 RGXRg9X0D3UWnxgF/Y918nBDg+Y6P9hK7wqrhoLgALc12sKVlXmYxoVurcZ04jes+8GJLkJgagh
 3wI0=
X-Google-Smtp-Source: AGHT+IHhdLyhyIJ3UvEDFqj4yeLl5Mczn2TKFbR3Syf/cqx1TJ9klpzDFc2htfFObLMvQ5J2BLh22A==
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc8b9mr885142a12.25.1740511946057; 
 Tue, 25 Feb 2025 11:32:26 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-188-213-172.77.188.pool.telefonica.de.
 [77.188.213.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e45b80b87asm1629151a12.39.2025.02.25.11.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:32:25 -0800 (PST)
Date: Tue, 25 Feb 2025 18:48:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
In-Reply-To: <CAFEAcA8L6CFvuTC+UqG7r5R27Yohc9vSVtPBHttBKKj-s-L0oA@mail.gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-17-shentey@gmail.com>
 <CAFEAcA8L6CFvuTC+UqG7r5R27Yohc9vSVtPBHttBKKj-s-L0oA@mail.gmail.com>
Message-ID: <6DBA3ED8-1ED6-4657-992E-3B12FFF8332B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



Am 25=2E Februar 2025 14:29:15 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> On a real device, the boot ROM contains the very first instructions the=
 CPU
>> executes=2E Also, U-Boot calls into the ROM to determine the boot devic=
e=2E While
>> we're not actually implementing this here, let's create the infrastruct=
ure and
>> add a dummy ROM with all zeros=2E This allows for implementing a ROM la=
ter without
>> touching the source code and even allows for users to provide their own=
 ROMs=2E
>>
>> The imx8mp-boot=2Erom was created with
>> `dd if=3D/dev/zero of=3Dimx8mp-boot=2Erom bs=3D1 count=3D258048`=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Hi; I've thought about this a bit, and I think we should just
>postpone having code to load a rom blob until we have an
>actual rom blob that's not all zeroes=2E This makes this
>board the same as e=2Eg=2E imx7 which also doesn't try to load
>a ROM blob=2E You can create a memory region for the ROM,
>like imx7; just don't load anything into it, and that's
>exactly the same as if there was an all-zeroes file that
>got loaded=2E
>
>This doesn't prevent users from experimenting with providing
>their own ROM code, because they can do that with the
>generic loader (passing it either an ELF file set up to
>load to the ROM area or else a binary blob plus the
>start address of 0)=2E
>
>That way we aren't carrying code we aren't using and an
>awkward binary blob in git; we can add those when we need
>them=2E

Yes, makes sense=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

