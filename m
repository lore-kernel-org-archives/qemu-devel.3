Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC24E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVpiY-0007dE-U8; Thu, 09 Jan 2025 05:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVpiV-0007cW-90; Thu, 09 Jan 2025 05:24:44 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVpiT-0001xD-M4; Thu, 09 Jan 2025 05:24:43 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so1367590a12.2; 
 Thu, 09 Jan 2025 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736418278; x=1737023078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRoIMIi21M6vwwNhicE57OWAMwS939scuKW+CkLRrQU=;
 b=hi0ihbhG4NO19tFSlNu33FC/XEK89SNBU1ENu+Bh7LpAQleat/G6jh2i1EpXAH0Wz9
 FT9rkac//8Q3UOg/nKuFdVOiH+JZ0reeZosHQaeDEcbqJp/CH/kneNYvRyoBCVYuxgTA
 ikq8m0NsFTGSfw/evtjG2x3Az5d32Ymsf5fD4NzrK7qeVyj+8UeiYN6zc8zULq2TAb44
 njqsh3TLcqWxCQJjwCsJI1XEf3xRSglpzzOg4rPDHQYsnYmlKUheMznipXpesafb4wLW
 jTxuFtwSPjLoclmMhGCELAVG/+rlm7Ji1NdLSOZV6rtJHahEIM4JYksLbq0dUjx6qPPR
 wcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736418278; x=1737023078;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRoIMIi21M6vwwNhicE57OWAMwS939scuKW+CkLRrQU=;
 b=rKO2vfwZuVOvEXuhtdfp/LH5qX5X6iXCtC2yTGXbghahkn7bYlGlJTzSZN3JTUxUuB
 vy8VfCVjdC8wqUcEoD0KEd0XIM28LJ/N3CLoBGItm97CbIeVikmFmGEyrBDjvD1y0YM1
 G4dR1+l6W2y63xc5CESHvR/8yCAJjwxOHsVZgiVJndjK88u1ngrY9OuebhUJ6C2fTJ3y
 r9qDWuWCy3scpPOOOElPPQ9tcfHV6IVIexnXv099v6UcgMFAyPpfOxXl5I3v8tkJ0tre
 dED1CCnbOwX2iMM2r6MdLrYzMhxi1lNxYPRRXahNz2DcLBDCZ/80EdU23e71S9PXIl6U
 3FnA==
X-Gm-Message-State: AOJu0YxmVgtRuYgp2Cctu2qB2HEchZTwLgSSKQYdF7bFK3CdN6YKPtvK
 /CiK2xwDzQy512CYNFQwsoQSvz++UBIQUsdikCwzV44Aesc15A1cImD7xw==
X-Gm-Gg: ASbGncuU2jOKBEp2neXSv4ORjjG9ZY9AouX7jbWnUTu8ab/SumPAD8znTnNk+pINR4L
 Er+eSNwM0FWZspNbvVjZJdHfBnWHGShhru1HdofIhWubRwaSG8v6Lvh/iQkQr1c4Gy8TMOVwcqe
 5FHrh7l1SQlwWnPM6Lg1u+zntu6NqBzUgDRV8VKHesG2/G7D2o9gAXdeX1UhnRnK/TdpEg2m6Hh
 UmEellTMdTQYsEm9KSfN2ljO5poeHndCe8PflfDEmqDYU/QVW2sQNGuI9jXK0GehT1/AI9VXuX4
 +xkO9h1ro7xBC4H9GnOKFWkThDI=
X-Google-Smtp-Source: AGHT+IGvM+7zjK+tMjQ22rYH5fH10GqZ2E+FNoe2hw10reyOoVcXvzcNG558UZASvDHxl2ipxToCWA==
X-Received: by 2002:a17:906:fd87:b0:aab:cce0:f8b4 with SMTP id
 a640c23a62f3a-ab2abc9ed6cmr533032966b.52.1736418278097; 
 Thu, 09 Jan 2025 02:24:38 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d52edsm56810166b.42.2025.01.09.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 02:24:37 -0800 (PST)
Date: Thu, 09 Jan 2025 10:22:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
CC: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
In-Reply-To: <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
References: <20250108100240.960593-1-clg@redhat.com>
 <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
Message-ID: <B66657AC-BD7E-4F5B-ABC4-FF373279FEC3@gmail.com>
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



Am 8=2E Januar 2025 10:43:07 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>On 8/1/25 11:02, C=C3=A9dric Le Goater wrote:
>> Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
>> Remove omap2_mmc device")=2E
>
>https://lore=2Ekernel=2Eorg/qemu-devel/20240903200446=2E25921-2-philmd@li=
naro=2Eorg/
>;)

https://lore=2Ekernel=2Eorg/qemu-devel/20250108092538=2E11474-8-shentey@gm=
ail=2Ecom/ ;)

>
>>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat=2Ecom>
>> ---
>>   include/hw/sd/sdcard_legacy=2Eh | 1 -
>>   hw/sd/sd=2Ec                    | 8 --------
>>   2 files changed, 9 deletions(-)
>
>

