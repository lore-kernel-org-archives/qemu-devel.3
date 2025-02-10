Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E2FC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thcZs-0008Sy-Gj; Mon, 10 Feb 2025 17:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thcZq-0008SS-3I; Mon, 10 Feb 2025 17:48:30 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thcZo-0008K0-Aw; Mon, 10 Feb 2025 17:48:29 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5de7519e5a7so2177356a12.2; 
 Mon, 10 Feb 2025 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739227706; x=1739832506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP5LifdYyCcwXnUpjlTi7Q1GyBwG1MhbcNFx3wTGDyA=;
 b=edJtWYVnVwZUxkcGfeiktmbk7wVnIRT0mcfdGfYlmcCum2mH2elqBGgBPH60+M0tTD
 Evu3uHLgsDmGS7oeGua58F+7RUM2rbRYHAvu3sBroMLmOfV1Ixp+d0CwZDkPkZqzqv/o
 cTca6bWkzXKcguOXM8s8s20GxQLzqiaq13Alz9VZx/Buru2pr0imAj7uYqKVAaLls8zs
 brSnILnfVo7AFFwo/93TWkt3811S0SjwI6NDZxNrn/Sj/hGB6pmuxAkADDuk4HZGPV7o
 PE10VzLujg0RYuAFQ1gvIaNLsG9biDVpspR6Gd6idEHnisn/H0xe8kbb8WASAxhjJzho
 r3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739227706; x=1739832506;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cP5LifdYyCcwXnUpjlTi7Q1GyBwG1MhbcNFx3wTGDyA=;
 b=vYYxNbgOPT0xq/8ZGXzDnzrR2nuuDkeOoqeWdhbmKn5pKkrOwyfaSNLZl3m15jHgau
 QhgvyY9TRAt9gU41jX5iJnYdQHM9D7w6U0cODXHsDA09elzitgNJM7fmHl8p5oNZon1o
 hIe1m30jhpf2QjGurl9g9R7AA4F/jMKOTh3ZsDaRjWaHmjRnzHRWhnb1yB7XKeOjf3j/
 X7DaND8uH8+jsEDXCMbm9Nl1dS2rPO5icLLlkNxh8M/LvilKDzqCzW1snZkYLpfGIFFj
 /HjsjrnyrOLCn1BfIRUfWc8WbYdRbyWG+5O/DUI0nONS16ZmykGLRplskZEJLSmvGH9t
 aoPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3DCf6i7ehVQ8Dm/JenHZS98nDU/6QL45Kx2bN3MFx8xzQa6HyiModCcA4od4gm30D4xueVjhImQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywwy15bhTLiW3Q+Ti6eQhoKx0IYa9pIF7lOWapjrKJq+hWXAwf7
 5OfnYt22q0rDJDG+HmLbgKmzQVP7c69wyAxVhsiTEyi8hEgt6/0C
X-Gm-Gg: ASbGncsx4U86nJweHEfraywbleC+uq/MHmMgxCeivf0OytI32zp4WAk4mtgsnyPAZrW
 yJd6uRKY1qp1yUSioL6i7qh1pkCEt3n/8B0d95B+/AcORkKJPomlbce2Ty8IhtWI/Lra9V7IiYN
 tmKLbOiPt1zN4LQBvZu9xyBZE8KrabxQw2vxOJzsMKNLLEQK/LMq8Y3pE6r9DuVmJb/qnzCHnOk
 rbqAG8X2lLlbx/DUlHJPA1FcGfBYKei2tYp1WtcrDdIZZrCFegKFnHKkyrpp9HPBi0Ow2b8myeH
 zvWk8VwUvtb2QCjOag+TdJjYORQGt/Vel81zWaV2pdUSg9TFjltM8LTZ4mtrI7aN
X-Google-Smtp-Source: AGHT+IGc0rE9ya9gHuk4FTO9Gv9tXh3+7DyrH3yEQ5deGKRtJBsj0Xd0dSh1kVn/8B25dV5HromT9w==
X-Received: by 2002:a05:6402:3907:b0:5d0:b925:a8a with SMTP id
 4fb4d7f45d1cf-5de45019b56mr15890173a12.16.1739227705723; 
 Mon, 10 Feb 2025 14:48:25 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-086-138.78.54.pool.telefonica.de.
 [78.54.86.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de44e4bc17sm7427469a12.70.2025.02.10.14.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:48:25 -0800 (PST)
Date: Mon, 10 Feb 2025 22:48:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
In-Reply-To: <a8855d03-d207-4a0d-a16f-24e4436a3b66@linaro.org>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-19-shentey@gmail.com>
 <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
 <F8650CD9-AA03-4462-A74E-7A068820F1A2@gmail.com>
 <a8855d03-d207-4a0d-a16f-24e4436a3b66@linaro.org>
Message-ID: <6E5A0BEB-F0AC-4791-8CB6-B9AF74CBF307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 10=2E Februar 2025 14:26:00 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 6/2/25 22:58, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 6=2E Februar 2025 17:32:31 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>>> On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>>>>=20
>>>> The implementation just allows Linux to determine date and time=2E
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>>   MAINTAINERS         |   1 +
>>>>   hw/rtc/rs5c372=2Ec    | 227 +++++++++++++++++++++++++++++++++++++++=
+++++
>>>>   hw/rtc/Kconfig      |   5 +
>>>>   hw/rtc/meson=2Ebuild  |   1 +
>>>>   hw/rtc/trace-events |   4 +
>>>>   5 files changed, 238 insertions(+)
>>>>   create mode 100644 hw/rtc/rs5c372=2Ec
>>>=20
>>> Should there be a patch after this one that adds this device
>>> to your board ?
>>=20
>> As per Kconfig the board selects I2C_DEVICES and this device is "defaul=
t y if I2C_DEVICES"=2E I've deliberately not hardcoded this device to the b=
oard to make it emulate a plain i=2EMX 8M Plus SoC (see also board document=
ation)=2E
>
>Then maybe add a test to be sure it is not bitroting?

Good idea=2E I haven't written a test in QEMU yet but I could certainly dr=
aw some inspiration from ds1338-test=2Ec=2E This may take an iteration long=
er but won't be forgotten=2E

Best regards,
Bernhard

