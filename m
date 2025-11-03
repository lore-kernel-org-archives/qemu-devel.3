Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D6ACCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG0Lr-0004gT-ST; Mon, 03 Nov 2025 14:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vG0Lm-0004fa-OL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:36:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vG0Li-0007Q6-Ol
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:36:22 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429cf861327so1336395f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762198574; x=1762803374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0jWKt09ONf5CxjQo7sEz86pcFGVeF/Cx112wnRX1TE=;
 b=Y0QwzLKvjsQxCktegIpnuWDoRHt79xC3OynNzmncCYXp10SPuNYudKaL/eiTajRxb9
 JMpaabFkF9t8qQW9o66uZyXg6uBDqOeF9MtauSrpJd5uh88Y/FPUYvkQdPBK3W09Bobf
 SqWmesnkeR+6rfIJgfrluaTNPNke8uvZuEMgBitebPXQinvT3OF7Ou0d6B48JEXk42rX
 rdUfcA+WP+Pt6uvFjeLoPSC5uOID0VR8CCj8+FdfcxQfa8UdtOtin/CFsxhB4nbgvb8U
 8nSO5o9OPkPZrGpKE4OiW1ted0ZLzL6jeLmdE2f9RUEgLOvNyii3F4u2+ZecEGKGYpK1
 E5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762198574; x=1762803374;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0jWKt09ONf5CxjQo7sEz86pcFGVeF/Cx112wnRX1TE=;
 b=oz7HaeoqvlN1TznDy8pz7zMR5T+DAfgTNVGfWTfAMSWEN+Wue8V+f4jnvL0fSiFq6p
 9EVS9LfayNTHKM30JeIGCGzPfjjJq8bYxU3Jupalvv+2Z2aK3i5Py2ypeO2sogzrm1Tq
 IIlKZ46R5p32SB2d5L/YD6QUW16gTcSOhAEhcVmr8b9jcBEMkQ/4FOAElzSg3CEjczFp
 kdHQU4//zrF5FoOL81W7yXFcxqCWz5SgYeseK2QjjFjtzO6vnNdnMxAvDTSi7PTwQBZt
 BDSc65p55YJxntwlBHxjk9omaLK26s/1u0gy6SjTcDyd9czkZ24kfWsfI1P47WOeNGT/
 Tkdg==
X-Gm-Message-State: AOJu0YzkkZHKxegctnygcS50VXeg+jKr7Qjbl8Z/GTTZV0qMWNR1EAL0
 qbMupmyhxyHyy1wTihLFHnt7qyoJFsA+X5Sh/9da4up/uKWa96a2C+mX
X-Gm-Gg: ASbGncvO6k8o+t+IP8zJM6TL+y673crjba4z/ieYZBQN2NWMDhnC4hsa4CSW0u7TJTV
 SONAzn5r2XreR/ZQWMkgBrSfapdngzsRO3zvtbgx6jjZPYfDAxV3Xz5uARJ311+ON17zR6rRo39
 5fXZmbEuVC6A73Rz4nifxkpIOks2y9TNHhWck9Y6qegnxY2Z9mp1Nz8/2ZZBE/SXfbxioJ5TglT
 cDkmAltJKKJcPJl8TMAPJWYblYOlMLa5bNm9kwP/JZG2dbB3aSPJE4vbfwi0Rkz0ayZGGGtVRBL
 uEH/uS/kaLXxuo6gC9JfY75yU3W9kvTI9i4pNV9RRGkgaGRHcoke80SsjRBF0fBGwED/6WDo2cy
 75udqm/VqiBaN+rt7+LtVE86Un34/vTG7l/ng0+FONh2Mru59vTUX9OxNAD+HFzUIF3GW8a09/D
 WRo4ePO/w=
X-Google-Smtp-Source: AGHT+IFjpjeT8AaG4ScOFbPf4tV10SBYBCjh/t8pyOnLbdXzW+ltP8stlAq3/WEs0E/0DL/XSySyag==
X-Received: by 2002:a5d:64e7:0:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-429bd6a4bc8mr12175770f8f.33.1762198574089; 
 Mon, 03 Nov 2025 11:36:14 -0800 (PST)
Received: from ehlo.thunderbird.net ([185.238.219.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc18ef59sm450806f8f.2.2025.11.03.11.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 11:36:13 -0800 (PST)
Date: Mon, 03 Nov 2025 19:22:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/2] KVM Support for imx8mp-evk Machine
In-Reply-To: <CAFEAcA-7dMCjK2dnTP=82qtk48D4WHCP4sbyQtaxTcRsDb=t+w@mail.gmail.com>
References: <20251101120130.236721-1-shentey@gmail.com>
 <4D17B8A6-28E9-4E65-B0DD-15BE2AD4AB04@gmail.com>
 <CAFEAcA-7dMCjK2dnTP=82qtk48D4WHCP4sbyQtaxTcRsDb=t+w@mail.gmail.com>
Message-ID: <B6033E2A-24D4-4669-8012-DD12B5F5F3FC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 3=2E November 2025 15:47:29 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Mon, 3 Nov 2025 at 08:55, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>>
>>
>> Am 1=2E November 2025 12:01:28 UTC schrieb Bernhard Beschow <shentey@gm=
ail=2Ecom>:
>> >This series adds KVM support to the imx8mp-evk machine, allowing it to=
 run
>> >
>> >guests with KVM acceleration=2E Inspiration was taken from the virt ma=
chine=2E This
>> >
>> >required a device tree quirk for the guest clock to be kept in sync wi=
th the
>> >
>> >host=2E Without this quirk the guest's clock would advance with factor=
 <host
>> >
>> >system counter> / 8Mhz=2E
>> >
>> >
>> >
>> >Testing done:
>> >
>> >* Run `make check`
>> >
>> >* Run Buildroot image with TCG
>> >
>> >* Run `qemu-system-aarch64 -M imx8mp-evk -accel kvm -smp 4` under
>> >
>> >  `qemu-system-aarch64 -M virt,secure=3Don,virtualization=3Don,gic-ver=
sion=3D4 \
>> >
>> >  -cpu cortex-a72 -smp 4 -accel tcg` and `qemu-system-aarch64 -M imx8m=
p-evk \
>> >
>> >  -accel tcg -smp 4"=2E Observe that the `date` command reflects the h=
ost's date=2E
>> >
>> >
>> >
>> >v3:
>> >
>> >* Fix crash in qtest (Peter) by using cortex-a53 CPU when ms->cpu_type=
 =3D=3D NULL
>> >
>> >* Apply Peter's style fixes in board documentation
>> >
>> >* Apply Phil's R-b -- thanks!
>> >
>> >* Rebase onto master
>> >
>>
>> Is there still a chance to get this series into 10=2E2? Soft feature fr=
eeze is tomorrow=2E
>
>I've put this into the pullreq I've just sent out for softfreeze=2E

Thanks, Peter!

>
>thanks
>-- PMM

