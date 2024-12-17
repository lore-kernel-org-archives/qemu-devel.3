Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0971E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 07:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNSCH-0000Uh-Fu; Tue, 17 Dec 2024 02:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNSCE-0000U5-3S
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:40:47 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNSC9-0004dm-4X
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:40:44 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso9107765a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 23:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734421239; x=1735026039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDl/XqDOdT7cEpuWvOyHd1F81KG2ObsI+n0RVGMaZhk=;
 b=y0ggzFtfEwxPJOuanf46DDSUuD+wJ6Fy1uW/mxNChM09PjzT+WuPNL9phZNP2rmDka
 sTQseJKsCYeOthPfyHnzE8zwZWsCzYF4kkB2HR5yxMsW+D5irtsUEC2eMCQdTR6/M6FX
 XA0JbNw2ZDIlA7KDbRfzdj825TbDYdZF+wqGmoET9vN50US/oPc/SARcbO9A4dF6alj4
 jHTMvUFdwQnwjmCaRSEGauS7SpOiPd+HjMG3YapEIjtdye/Zhp7HtrY1oQ7rNBI5o8s6
 mQ5iyu6lOSaK0b1Hw15wz9bzvzeB/AHpkG7SoIojeeOpSVmWMl2vMG6/fW1g58KkAPok
 6n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734421239; x=1735026039;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fDl/XqDOdT7cEpuWvOyHd1F81KG2ObsI+n0RVGMaZhk=;
 b=ClnsL4sjLKW1B2OnXStc4BdCrJQ51rv14c98pe+IDCx0yGXN6c5QWxj6MPJ4ZjmtZ9
 bhW6YV1YajRdOCiIOKsiu1vbyaVsdLNTK4JJkvEeqTYQZJU/io47/FPKHdL3hVIG/NoB
 kt8nK+neC2KZeMImwxS2NH+gmGHQ5Vo+7KecJjPHq7NXiIZ1e0vrd6DtMdpDJLaHfdUw
 P4g87f61L48SWgEAnBIOan79xQ75k+5iyzVktZbrhi78E8heVKtW+xFbtIXzS695KRA/
 gAbMQlszKdAzjjmeo94wZOuzH664mtFoWCtnxByh4QafnFhD6Jj9BIlfKDtXbx7z3+2n
 Dz3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5WXZtudfhMGHorc+y2tcVCQKVxBnTiSw9GmXa9JwB/ICAKEJndYeVkIg4Wv3pc1ProuIg9N45buhP@nongnu.org
X-Gm-Message-State: AOJu0YxIS/UbtHs+yxsf40TWvgJG2JDCfdSX4xwzQjvoU8YaWHih+qw4
 nRZRmZrZAkjXuPNf4A72b1aNTssuSQW0tLbJXvPoSWk9vaAwKLvEcMnVncdblfw=
X-Gm-Gg: ASbGncvvaBsYsQ14TumWB26u8EHDZiYHpDWRL2ZXAH27ybMR66gZfO8fuealyHm+rLI
 QqaaclVQ4+thjLDBwiZJePSzM9S2Iyd9uc9JpDewrWmfUjoUVcCuA504qDpHvIXP7fuzCDZRntL
 QQV9c5HT+v937aeSRVvEDCm09Eo9v9ur7yr1V+wMPHR6i+c18nNPBs7CUJRJKGRL0HBd3mFlQ4r
 2VnCLYYGT9azKYkzqRKEOsXgD4KQ3R9ycZ+JZeKpfkaY9nFHkpTI9c=
X-Google-Smtp-Source: AGHT+IHJWPDXz4NWLBrj6ZV0El9QWA4ONTn5ruLlFqLxWIVXenyMN3+Aabcl4ifzZJyqo4p3/fQ5TA==
X-Received: by 2002:a17:906:31d2:b0:aa6:a501:7c2f with SMTP id
 a640c23a62f3a-aab779bff6dmr1577877266b.27.1734421239115; 
 Mon, 16 Dec 2024 23:40:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab960062a4sm415565866b.32.2024.12.16.23.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 23:40:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94A2D5F891;
 Tue, 17 Dec 2024 07:40:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
In-Reply-To: <19df9957-6653-4086-aa1f-07263efcddde@linaro.org> (Pierrick
 Bouvier's message of "Mon, 16 Dec 2024 17:37:17 -0800")
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 17 Dec 2024 07:40:37 +0000
Message-ID: <87pllq69l6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 12/16/24 11:50, Richard Henderson wrote:
>> On 12/16/24 13:26, Pierrick Bouvier wrote:
>>> On 12/16/24 11:10, Richard Henderson wrote:
>>>> On 12/4/24 15:12, Pierrick Bouvier wrote:
>>>>> qemu-system-aarch64 default pointer authentication (QARMA5) is expens=
ive, we
>>>>> spent up to 50% of the emulation time running it (when using TCG).
>>>>>
>>>>> Switching to pauth-impdef=3Don is often given as a solution to speed =
up execution.
>>>>> Thus we talked about making it the new default.
>>>>>
>>>>> The first patch introduce a new property (pauth-qarma5) to allow to s=
elect
>>>>> current default algorithm.
>>>>> The second one change the default.
>>>>>
>>>>> Pierrick Bouvier (2):
>>>>>  =C2=A0=C2=A0=C2=A0 target/arm: add new property to select pauth-qarm=
a5
>>>>>  =C2=A0=C2=A0=C2=A0 target/arm: change default pauth algorithm to imp=
def
>>>>>
>>>>>  =C2=A0=C2=A0 docs/system/arm/cpu-features.rst |=C2=A0 7 +++++--
>>>>>  =C2=A0=C2=A0 docs/system/introduction.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
>>>>>  =C2=A0=C2=A0 target/arm/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>>  =C2=A0=C2=A0 target/arm/arm-qmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>  =C2=A0=C2=A0 target/arm/cpu64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++++++++++++++++++--=
---------
>>>>>  =C2=A0=C2=A0 tests/qtest/arm-cpu-features.c=C2=A0=C2=A0 | 15 +++++++=
++++----
>>>>>  =C2=A0=C2=A0 6 files changed, 38 insertions(+), 19 deletions(-)
>>>>>
>>>>
>>>> I understand the motivation, but as-is this will break migration.
>>>>
>>>> I think this will need to be versioned somehow, but the only thing tha=
t really gets
>>>> versioned are the boards, and I'm not sure how to link that to the ins=
tantiated cpu.
>>>>
>>>
>>>   From what I understood, and I may be wrong, the use case to migrate (=
tcg) vm with cpu max
>>> between QEMU versions is *not* supported, as we can't guarantee which f=
eatures are present
>>> or not.
>> This doesn't affect only -cpu max, but anything using aarch64_add_pauth_=
properties():
>> neoverse-n1, neoverse-n2, cortex-a710.
>>=20
>
> I think this is still a change worth to do, because people can get a
> 100% speedup with this simple change, and it's a better default than
> the previous value.
> In more, in case of this migration scenario, QEMU will immediately
> abort upon accessing memory through a pointer.
>
> I'm not sure about what would be the best way to make this change as
> smooth as possible for QEMU users.

Surely we can only honour and apply the new default to -cpu max?

>
> Peter, Alex, do you have any suggestion on this topic?
>
> Thanks,
> Pierrick
>
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

