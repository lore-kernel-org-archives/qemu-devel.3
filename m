Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9uj-0005TF-64; Mon, 17 Feb 2025 17:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk9uh-0005Sb-4p; Mon, 17 Feb 2025 17:48:31 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk9uf-0007Kw-Aa; Mon, 17 Feb 2025 17:48:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e0516e7a77so2478067a12.1; 
 Mon, 17 Feb 2025 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739832507; x=1740437307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OFVkilwu+UsQuAT97bo8myhwJ+KIzz1njO0RURHPKI=;
 b=a5I5antCb/9UqEkUD0BXol0w34Wtu/x1Z7irSraUozeTnAvxhOeE7BaIantYhxTeav
 NfaBKrb9TUpBYyl+XuwFAZZPLzuWW6aIJ1Sgx9eSOTFoZoNJ/04tZrD4FBpEGHqPwxSh
 oMEEcKsLwF/wNobOWmeWlrhwEyJFrtH9abdFIVZerg/uxHSRX/VTCK5q8vuMYADSeV/d
 nx9xqQDOGnVY56St20HHkCXQ2/pkbKLPbVsXK8+eCl0hFc3btMrJRlv1KfNARi/KzOvQ
 tfBbaeaNDz4cdKpLIV5ZOzs0jIVGRq6I4n+OyBTGz7Ilgxxlt3yaTEJlkIdaB7o/puiR
 8MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739832507; x=1740437307;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OFVkilwu+UsQuAT97bo8myhwJ+KIzz1njO0RURHPKI=;
 b=MqS7JwbpGvYGgnA3jlDVcWFIPBz4rpdUZlFHYQjQF762C1UhsBNngogvfq7XC6xmpK
 LuQdWSB53cpEpmk2vZUUWzzeHjlvFTCHOsRa6qb4Xp2hUxpSy8cg2A++4uYvMagrjr0H
 JaSr1LhXuxSsCK6znz0H+bfuK2vYgLCeEHcZb+EaXPp604n+tnxpfmm5PnImCF22Wmua
 nVD7V0vHRhZ8JB/Fyyqu88BX4HTIcGYUdcwgL65Ysbb09iAl/mpB6S2brTCu5pQafMuK
 qtZJDaMbEeat3iqNfh69pl6qoYuflVq8bJ7LBPIJGB7ihEoRZkJnazzk/5JKLU0Kjv6e
 c3uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMOQqcLX+o9GZTwPEzctyaNHbEZrUKEALjOI6xvHUPo0mtyO6h9XIOru/Ai+x/i91lx/ZT3r4Stg==@nongnu.org
X-Gm-Message-State: AOJu0YySKNjWx3kMnM5ymLrl/rgQN/cQU+XCQ3ELj1M5jwlE0M28LlLA
 G8EuAGFW1/PHngxXDJOs1n8SYrTzJdOH2MNKxz+aGygZ0bon7VqC
X-Gm-Gg: ASbGncuOdg93US9IYm6L/MAEuHsXLdHb1hgDlBGyZbqxRzfaMNumyMXV84GXJjYGjdU
 q6sg297mMUhrv+CweUQkdAB0hpteQ0KAAOc8jdvf08Oupn11NcdxYRfKaFOK+w1fUo1z8/szuD7
 Fkq1L1SjdjwGUlAyisl8W6Y4nfeQnqubRXP6hJOYy2ygyKcuaGTwepkUGhvbHicUwZqw1dP3upZ
 GT4/3bbqQGw69H39cUtYT6MyD/hBGF3awDlVUsBoKuXemfVh0uIEqsVZSBVxSmE7WPoO+VW8Z4t
 OFbI8Lf0WbVfECC2ePkalBXlxftHF3HOmBe6tx7tYi6XHghq4d+50LozPOYFV0uzB68=
X-Google-Smtp-Source: AGHT+IE9oNZ+svGREYJSMgQWTvXyR+i1MaOKZmRlKStVam9F0XD0ol4IIwci/dwJw2It9cDdGhhUjg==
X-Received: by 2002:a17:907:9716:b0:ab9:5544:5eb3 with SMTP id
 a640c23a62f3a-abb70b354e7mr1059917366b.26.1739832506563; 
 Mon, 17 Feb 2025 14:48:26 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-175-027.77.191.pool.telefonica.de.
 [77.191.175.27]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbb78583fbsm31580766b.112.2025.02.17.14.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 14:48:25 -0800 (PST)
Date: Mon, 17 Feb 2025 22:48:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
In-Reply-To: <CAFEAcA_Kasz0jMTQO1F32bMwSh6tRoDTaS2DE0sSruLENdcu8g@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-17-shentey@gmail.com>
 <CAFEAcA_Kasz0jMTQO1F32bMwSh6tRoDTaS2DE0sSruLENdcu8g@mail.gmail.com>
Message-ID: <382AF9A2-4339-42F8-9C32-E7F6960CD4A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



Am 17=2E Februar 2025 13:28:42 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
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
>
>If it's all zeroes, we don't need to commit it to git as a binary,
>we can generate it at build time=2E (We should avoid having
>binaries in git as much as we can manage=2E)

I went with this solution since it trivially works on any build platform=
=2E Any idea how to generate the file in a portable way?

Thanks,
Bernhard

>
>thanks
>-- PMM

