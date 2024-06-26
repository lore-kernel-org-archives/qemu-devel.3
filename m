Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814FFC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVLi-0006vQ-FX; Wed, 26 Jun 2024 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVLg-0006v6-CD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:18:20 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVLP-0006Kg-RS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:18:20 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so79827601fa.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719418681; x=1720023481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DcB6IPPrpjOpTbKaDWEUmYeQ2UAfTwqRY22CEK/B2iA=;
 b=Y42Mkd8PKK76rfo72uBRcMSH/u52umKj4f4++Tc8eGwCD2vLvqHdmXo4l/qpnBp1Yx
 Rfrvji+xJNq0NcBgdnkxw0Rs6KAIGkVapbcaXC2STYZXSoVjoIq2Pjtt7Vovy+YvVrFH
 IVJ2j5QQ9C0b0ZVecaigBceJwasjEMLU7j8ceRKhej5DIvdT/ibfae2oi2aP5rZDU3De
 hLL04ygjig308eDG5twBWVwVr+5dwl1lKhIqshDw5jMlzhAEsC6fsrpIz5UyjT1vdXLk
 Jsalp2UG2gDdEDVlAf5c/f7U6Lj7qAe6oiBOtDwJgD+nrF7r7/HN0391td+EHsKiKz2j
 Mltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418681; x=1720023481;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcB6IPPrpjOpTbKaDWEUmYeQ2UAfTwqRY22CEK/B2iA=;
 b=LgpglWn0Y1ug3hFqTKEoyxaNer31UvloFkuZOk3DcwjYcQbEZSGhlJ36UxcLdY876f
 37fv7fH1rrCiiFBM+2H43WvZ25nyjjFEsXwYTFFiDS1wqP0H6/1G7PrNhdqJMkEUMohG
 jyATKTKVoJLKPe1tECT3Tw7QnANMq+lGpeWAG7zpGwrWnf46gr/yJyWCuktLoPGwsK22
 dpXr7ItoUjjZhvlPpweSz8J6hq6/aGebgqgAgNyP9at2ouIpFLNnYEFNoOaG2AQa8CyW
 5/4CJMOvXJaR9n8kUmH3TTKibxK1kC1aVOPaTn5mXa2YjSzUmQPXCZfu7omB2VREN9hf
 76Kw==
X-Gm-Message-State: AOJu0YzjEfmUHFaxYvkeBjKoeYK8iXrSmZVczQ7U15Ave80xwBQKZDJD
 4OE9QP7Bdfy3cDqDc9F22tLclOfYWcYJCi8fCOBf8rSXy3p1AWrCSypl4DZWtKbMYeMwF0wGhdQ
 3
X-Google-Smtp-Source: AGHT+IFfXwEtsh+T/sDn+2rc5XBZnHCaEiUAyswzSvtd5UKEMWXGnkc3/U4D8XcR5I/y5ovhWxbUow==
X-Received: by 2002:a05:651c:211d:b0:2ec:5dfc:a64e with SMTP id
 38308e7fff4ca-2ec5dfca6demr78654281fa.0.1719418681072; 
 Wed, 26 Jun 2024 09:18:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-581e920112dsm1974823a12.93.2024.06.26.09.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:18:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78D215F8AA;
 Wed, 26 Jun 2024 17:17:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  "open list:X86 KVM CPUs"
 <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] target/i386: restrict SEV to 64 bit host builds
In-Reply-To: <ZnwjtOxQy1iiRoFh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 26 Jun 2024 15:20:36 +0100")
References: <20240626140307.1026816-1-alex.bennee@linaro.org>
 <ZnwjtOxQy1iiRoFh@redhat.com>
Date: Wed, 26 Jun 2024 17:17:59 +0100
Message-ID: <87r0cjoeyw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 26, 2024 at 03:03:07PM +0100, Alex Benn=C3=A9e wrote:
>> Re-enabling the 32 bit host build on i686 showed the recently merged
>> SEV code doesn't take enough care over its types. While the format
>> strings could use more portable types there isn't much we can do about
>> casting uint64_t into a pointer. The easiest solution seems to be just
>> to disable SEV for a 32 bit build. It's highly unlikely anyone would
>> want this functionality anyway.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/i386/sev.h       | 2 +-
>>  target/i386/meson.build | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/target/i386/sev.h b/target/i386/sev.h
>> index 858005a119..b0cb9dd7ed 100644
>> --- a/target/i386/sev.h
>> +++ b/target/i386/sev.h
>> @@ -45,7 +45,7 @@ typedef struct SevKernelLoaderContext {
>>      size_t cmdline_size;
>>  } SevKernelLoaderContext;
>>=20=20
>> -#ifdef CONFIG_SEV
>> +#if defined(CONFIG_SEV) && defined(HOST_X86_64)
>>  bool sev_enabled(void);
>>  bool sev_es_enabled(void);
>>  bool sev_snp_enabled(void);
>> diff --git a/target/i386/meson.build b/target/i386/meson.build
>> index 075117989b..d2a008926c 100644
>> --- a/target/i386/meson.build
>> +++ b/target/i386/meson.build
>> @@ -6,7 +6,7 @@ i386_ss.add(files(
>>    'xsave_helper.c',
>>    'cpu-dump.c',
>>  ))
>> -i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confident=
ial-guest.c'))
>> +i386_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files('host-c=
pu.c', 'confidential-guest.c'))
>>=20=20
>>  # x86 cpu type
>>  i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
>> @@ -21,7 +21,7 @@ i386_system_ss.add(files(
>>    'cpu-apic.c',
>>    'cpu-sysemu.c',
>>  ))
>> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_fals=
e: files('sev-sysemu-stub.c'))
>> +i386_system_ss.add(when: ['CONFIG_SEV', 'HOST_X86_64'], if_true: files(=
'sev.c'), if_false: files('sev-sysemu-stub.c'))
>>=20=20
>>  i386_user_ss =3D ss.source_set()
>
> Instead of changing each usage of CONFIG_SEV, is it better to
> prevent it getting enabled in the first place ?
>
> eg. move
>
>   #CONFIG_SEV=3Dn
>
> From
>
>   configs/devices/i386-softmmu/default.mak
>
> to
>
>   configs/devices/x86_64-softmmu/default.mak
>
> And then also change
>
>   hw/i386/Kconfig
>
> to say
>
>   config SEV
>       bool
>       select X86_FW_OVMF
>       depends on KVM && X86_64

I was wondering if I could do it all with Kconfig. Will respin thanks.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

