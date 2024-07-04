Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26926C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHkv-0004tQ-Ge; Thu, 04 Jul 2024 04:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sPHkt-0004sv-Oy; Thu, 04 Jul 2024 04:23:51 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sPHkr-0006PS-0K; Thu, 04 Jul 2024 04:23:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e93d1432fso455489e87.0; 
 Thu, 04 Jul 2024 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720081425; x=1720686225; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQnN8i7Q3Agv1GB7Ie85hPPlxoEZgQKu5DIkmyD4QLQ=;
 b=haVk8K257l+l0ItVtcY1mAhCTSy3SUcBlXuF0zuzHQhBsEFtzu0OmiRlasqxxGih1y
 534AyXQc2u/EuZiAEMWoGWaQfeLoKJyQVEmSVxt0/wS3deqSJOXhGDmv94ol3gmVq6JN
 kaglxGR2gZLCG6J5L9noHY9Jmyb5VK6mkG/LXItKyPfVuIs+aRkyqP//LYLG4m/9HTBi
 miwNPeJxL66a/2m6aSTsHIFjyl4VoHz9EKhkPsbJ4zI1ZnFdc5Sq4HDXIMx9PPETE8k/
 Yyq3U8FemnIW/vh5Fqf+t+SnePkSZwD9LZt37U1PQrgVS3IgEuShXZZGSUScJuFJHaCt
 jysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720081425; x=1720686225;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQnN8i7Q3Agv1GB7Ie85hPPlxoEZgQKu5DIkmyD4QLQ=;
 b=EUVYYkt1ofLI9is+xSFCwVrPQE7WAUJZI2cIM2YiJNSr/Cke+ZNKYfhRGB0YF9i1yO
 jHoi6xnjc5af0Gu5VwSFpVzRIYYZsnpBYj6A7t+t3TwAtue4wTix86c7BmFvf0UJHHr4
 4WXe/wa2KF1RQUU5PknYgWqcEndx2G3ACKhrYwRjSuBT9jOdCM+lFfqUzhJaqFRgi7Zg
 xs01f/evnk6LDKDTt+D6LjuDfocZY6ax6LygHO8pnZDymFYN86t/3UKZXUjYuhWvSKXk
 cgaccfyGdqWNgVsuPACVXQLtFnxY5Jl/eP98nZAvtxfPBL1V2SxNsJW7NeF7E/5B9xd6
 vV8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1KxF5Y19SCxpRgsUsmUa1CAq0sJHG+1TGrBcW5Sml3JzpGrMwWz4B0BJIp7TfsDA9HGXGnEmrbqKVcC0DUITLHnWaJTXSoX0b6g1KnTIzhqA6T19GdeEFL/OQrg==
X-Gm-Message-State: AOJu0Yxzw5rCDXIMZGsXSD0wNEACaK0/f2cmhS66BEpUHgwalHnuWijz
 VrfGe5GSD2ZyZQtO2r1e9TN8Z8SW0/yK4zRaQDs6nu0d8TrojIWu
X-Google-Smtp-Source: AGHT+IHOiqHi/vsWX2eEDfTW5dkCYFybBVQxYDkRtVlgARG17Sl409E0BT55s2x3oG3SeBAYWIi87g==
X-Received: by 2002:a19:5e52:0:b0:52c:e5ac:ecd2 with SMTP id
 2adb3069b0e04-52ea06bc9e8mr473042e87.51.1720081424417; 
 Thu, 04 Jul 2024 01:23:44 -0700 (PDT)
Received: from smtpclient.apple ([94.25.185.41])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ea1e76d13sm33959e87.123.2024.07.04.01.23.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2024 01:23:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
From: =?utf-8?B?0JzQuA==?= <krashmisha@gmail.com>
In-Reply-To: <20240704033637-mutt-send-email-mst@kernel.org>
Date: Thu, 4 Jul 2024 11:23:31 +0300
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B357E4DF-3873-4627-A322-C9744A905942@gmail.com>
References: <20240703145956.16193-1-krashmisha@gmail.com>
 <87le2ipigb.fsf@draig.linaro.org>
 <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
 <20240703160451-mutt-send-email-mst@kernel.org>
 <e0e1e2bd-a230-a460-79b2-dd9318e7c92e@gmail.com>
 <20240704033637-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=krashmisha@gmail.com; helo=mail-lf1-x129.google.com
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


> 4 =D0=B8=D1=8E=D0=BB=D1=8F 2024=E2=80=AF=D0=B3., =D0=B2 10:38, Michael =
S. Tsirkin <mst@redhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=
=B0):
>=20
> On Thu, Jul 04, 2024 at 10:25:53AM +0300, Mikhail Krasheninnikov =
wrote:
>>=20
>> On Wed, 3 Jul 2024, Michael S. Tsirkin wrote:
>>=20
>>> On Wed, Jul 03, 2024 at 10:55:17PM +0300, Mikhail Krasheninnikov =
wrote:
>>>>=20
>>>> Hello, Alex!
>>>>=20
>>>> No, there's no patch to the VirtIO specification yet. This is=20
>>>> proof-of-concept solution since I'm not sure that I did everything=20=

>>>> correct with the design (and as folks' reviews show, for a good =
reason).=20
>>>> As soon as most obvious issues would be out of the way, I think =
I'll=20
>>>> submit a patch.
>>>=20
>>>=20
>>> Mikhail, if you want people to review your patches but not merge
>>> them yet, pls use an RFC tag in the subject to avoid confusion.
>>>=20
>>> Thanks,
>>>=20
>>> --=20
>>> MST
>>>=20
>>>=20
>>=20
>> Hello, Michael!
>>=20
>> I was planning to submit three patches: to the kernel, emulator and =
Virtio=20
>> specification around the same time - as soon as the obvious bugs are=20=

>> fixed, I'll submit a patch to the specification. I thought it wasn't=20=

>> necessary to use the RFC tag in that case, but if you think it is,=20
>> I'll include it with the next version of the patch.
>=20
> RFC means "this is proof of concept". On the one hand some people
> won't bother reviewing then. On the other your patch will be
> judged less harshly. If your code still has debugging printks,
> it's clearly an RFC at best.
>=20
> --=20
> MST
>=20

I apologize for the debug printks in other patch, I=E2=80=99m not really =
sure
how I gazed over it.. If it makes my situation better, it=E2=80=99s my =
first series
of patches. I=E2=80=99ll make sure to triple-check next time. Thanks for =
the
feedback!=

