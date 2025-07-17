Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8854BC83F3B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQwc-000124-UI; Thu, 17 Jul 2025 11:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucP1Q-0006zl-NE
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:51:41 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucP1N-0007fN-Sb
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:51:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso1635915a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752760293; x=1753365093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EMWDuzWlXtljhatIpXTRoIa2BGGu3IyS38H4G8Azug=;
 b=dO/M4wGUQQk50uSUzEO0ENSaqikMmStlgAgBOZK95/0l5nChLb8eGVDRNeOxUlKVhv
 dFoOmQucIJk7pLjUDEaw+Vob/V+7bxI1ijTjICbnNYvcO/JdtcNHxAXq463iF8Ysagwp
 +lygtcLBj5nYL2Pg+uny427Sj8Fy7LTVHBtf++EJNxkC2hVChAExWSezlNI+zzrhcYa5
 qE75OWjM05Pila8/imFZgCZaz+uc153d2Sg2tc+FSp/MIMuHdyYx7m+Bmn8q5Y2pzgrO
 BvfIUrim9+uMWPg9lB6UK38UqrgL5+r/EKJIBg6D0QXcWqXu8ZK7BWo6NIjYKJYCGZqC
 AYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752760293; x=1753365093;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3EMWDuzWlXtljhatIpXTRoIa2BGGu3IyS38H4G8Azug=;
 b=B/6OfyYAyrw6qGJstkN+MaOokQSjh8nzp/uj6XaQTAtMgPvmhGw2uxTl2ksxa8eYSM
 xMw0dJsBsr0Z1db0ZpndAPUWAWXBPxTJ3yIyIlvdAPGg9A4NwZO1uuEQsO46VvH+m5x8
 DQT7GpXMBLZ8sIMkEVpMZfaOxNavZDL80YTdqdVlOnGoE3OvkNlJA02QooEWmzFnCCAo
 hQ/01izz6poVNAUijwnuoXRUNtot8m0OQBD2/mauCHaPMZe/xyh0UOdPJo4IlwZCWyFL
 rra/KV6BPsb/p4Xwvh2urL37KRrUEC7tsEejQNP+o21vmwzgXG2QmMmr5YoCLtte5LU7
 dY0g==
X-Gm-Message-State: AOJu0YxFhoHnrNC8apAXse0G9QQ9YZHXKEMIBDmCgyUN+b3VfuwzjzVb
 eIkJkTRJ/1LWsCvsbrjleblR/UJh5NgA4Un2QOjxwPUWfodWi/+TmU9C7J5ATbDcPxg=
X-Gm-Gg: ASbGncsQAwS7LAAQ+PjU/uczDTY5HResz2BtolvjRX/8cHdoe1KX6chssccZYY+OA8h
 VuyVTb2fCwZsAgxBU3F4nKc2H3XZPYlLgAyQK5thL6Im3CbvGFft/FB35VvFB3DUOh5Kfa5EQuj
 SihyDvCLxSzACiA8xsC9wE3n99gBk3fa7GMaw7blHp18+xU84KJcI5/5z7mrlR4NWzjiFiJjzxJ
 5l0pefBI6eR6qNUnMFet98whJvnEIEAp6ehyJyC3iFX0E9jypBaaLm2GgmXFKx93SiIUm4In2YA
 sYvZRVwQwDLfGpUH0s+5KD/DLpQ0N5YL1AjXz4gHS9akgT88kLEwawQ+TwHKXzd6AQRXPNdq26J
 KFe80/aNhl+UFG/veryxbN6w=
X-Google-Smtp-Source: AGHT+IHuC8NbmYKDRsM0D6W6C+xSQBM24FckbnKmODh4mmZxUkUlHTc456ARH6VrYkotwtN1hcXwFw==
X-Received: by 2002:a05:6402:42d3:b0:612:b9bf:2a56 with SMTP id
 4fb4d7f45d1cf-612b9bf2fb9mr815697a12.21.1752760293110; 
 Thu, 17 Jul 2025 06:51:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c973360bsm10317606a12.45.2025.07.17.06.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 06:51:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E2315F812;
 Thu, 17 Jul 2025 14:51:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 devel@lists.libvirt.org,  Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [RFC PATCH 0/6] Fix building of sparc/sparc32plus test cases
In-Reply-To: <89d04983-956e-4fa0-b607-951522b2a731@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 17 Jul 2025 13:32:31 +0100")
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
 <89d04983-956e-4fa0-b607-951522b2a731@ilande.co.uk>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 17 Jul 2025 14:51:31 +0100
Message-ID: <87tt3bvsbg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 16/07/2025 11:54, Alex Benn=C3=A9e wrote:
>
>> We didn't have any reliable way to build sparc test cases. I have
>> found someone who ships a compiler but the binaries still don't run
>> due to the need for CASA.
>> I'm posting mainly for those who actually care who might want to fix
>> up the remaining cases.
>> Alex.
>> Alex Benn=C3=A9e (6):
>>    tests/tcg: special case sparc test cases
>>    tests/tcg: special case sparc32plus test cases
>>    configure: update sparc and sparc32plus target compiler detection
>>    tests/docker: add sparc-leon-cross container image
>>    configure: enable the container fallbacks for sparc/sparc32plus
>>    docs/about: deprecate add sparc/sparc32plus-*-user
>>   docs/about/deprecated.rst                     |  8 ++++
>>   configure                                     | 11 ++++-
>>   .../dockerfiles/sparc-leon-cross.docker       | 40 +++++++++++++++++
>>   tests/tcg/Makefile.target                     |  9 ++--
>>   tests/tcg/sparc/Makefile.target               | 45 +++++++++++++++++++
>>   tests/tcg/sparc32plus                         |  1 +
>>   6 files changed, 108 insertions(+), 6 deletions(-)
>>   create mode 100644 tests/docker/dockerfiles/sparc-leon-cross.docker
>>   create mode 100644 tests/tcg/sparc/Makefile.target
>>   create mode 120000 tests/tcg/sparc32plus
>
> I think the basic Debian toolchain for 32-bit SPARC is working because
> it is currently used to build OpenBIOS, so I don't think we're quite
> at deprecation point yet.

If you can figure out the right runes to compile then we can just tweak
configure and also use the debian-all-test-cross image as a fallback.

>
> Let me have a look and see if I can figure out what is going on here.

Ack.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

