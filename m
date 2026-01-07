Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FFFCF6BF4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOdz-0008Fw-Hj; Wed, 07 Jan 2026 03:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdOdk-0008CU-I7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:11:38 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdOdh-0007nM-GN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:11:35 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso19154895e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767773489; x=1768378289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8f392vwS03WeJU5JmkN14LC3R6jRzRSwQabUt8XIk8=;
 b=zLizrQ/MKQLweGfnthKWJ9JAsDZ5CcDOX/qxwgMrEL8N3BEABoLZN5NS+S0Eri0MCH
 4somI6ZwPkKMr9yUboFLAYMIv0X1i8DNOjjan80M2mqw4P24wXfyHWWW1pIkIK0iDgBN
 PgNP0/2EzCzgxehR8TDBkAkXrpIJSjeS0qhBeu76bPoSgQX2UDcrFqbmdHlbCgItq4AV
 nUUVHRwnDsnCMRbgLxDxtYVgkdUNvvtoaAL9QQrMQv1oDi/YaVmbDeZMVJ0cnY5UuiYm
 Pe721t8fNMNJV8QswKf0i8Mn7pAnExBvbSxz7VgtMGHIfUnMkE91PxYlenS/AB2RmvA3
 tAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767773489; x=1768378289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8f392vwS03WeJU5JmkN14LC3R6jRzRSwQabUt8XIk8=;
 b=vjiqsFHMsusXDpggXB+TnpXiHXiAbVDz9GITZnnfY16/I+WslB51QEY0RKPx0wqcal
 cxu292Tt4ssPxb7mbRiPIcPAEO91uJfxBvUt/4ij6ila4mCc52NVmT03q2rcyDpnPHFV
 QX7Mobh4YSKBoOyxWlnOX0w4qiNEkU5V3xkVGP0NlubfhywW9nThMMcI8/JocfmwPtTQ
 HPTs/MSCHpm2OfFFXkOZay1lQCs8vYMGD+81wUCQENCSIvk3zyAXBeQ8vlPLI0DuUu60
 gDQCdorRZz1M0zMnZtbuW//iGIOuceXshP0cz6vZm57p7MiVrl2srrssKIde1GGPQo+t
 9Kog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzs0gsrWkdWeGo8NxOsfZy4AakGRUV2SrWRSg6zHILLZz/Jm3Bbgh8tOdAm3y9nH31UI/R5uctseZW@nongnu.org
X-Gm-Message-State: AOJu0YxeR4vJaA6rRLYRC7Og7mqcDeE9Y216NPGl8wZLrLpWwJC/rA4y
 9/sVH++83cLX96pOedLZ/YuXXi7g3kf7nS+b+huiP+LXi06xZ7XIO8AkMUZ4uROYwkI=
X-Gm-Gg: AY/fxX7TbHDCY3cecWdyoTY0TYorgy0Pit2Bf6rSiZieU4r5jh1MjEaQf1BLyrC6Hhk
 /7gtnbfXUfToDA1ayCVyDDB1u1KR3ns0le/uJl1xjlO2ItOy5RNumWkDfQdImIumhLNq8u4+Evz
 0THHoyF8mMqC76yPgTZpSJtMv8oYS6McIsFgGmeh40u0obnTbyauU+xUWCl47QpGRRA9bbSvEzx
 FXYLxNG+ymejUeEvbOipQYCl2R+AFSBjPl2UDo1xR9oQ62twWLDxGyhnLxHxOSty7W4+3zgx6/Y
 MHPT/fJK3qxYoee4tMWB861kT2Gk6E2AQwY4/kF4SUTg4hQePzTg4Oh1Q0v78pKmtzoNa/wH/2a
 3XvAMkOi8z1P4nmQM6YJWPqE7+C2ctyhmCRZzlCp5aRPA+tWPgQrajEHNZedYVy7pJUhNSsewoT
 X6bsLQmdqDPwqeWstwf0tV2EfarODgnmLOjj7PY3UcaYbq+MQUi9RkkTex2QCfNI0G
X-Google-Smtp-Source: AGHT+IFmShdYIJ4doXbALkKuf/5ccE0uOwf/EnhK5mWcUM/9CTOWkEFNM7P4SnbXmzJ5OrZHYsYL8A==
X-Received: by 2002:a05:600c:4443:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-47d84b0aad1mr14704625e9.8.1767773488721; 
 Wed, 07 Jan 2026 00:11:28 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm90285085e9.6.2026.01.07.00.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 00:11:28 -0800 (PST)
Message-ID: <f9675c20-6f5b-4de7-ba2c-881e9e4b29ff@linaro.org>
Date: Wed, 7 Jan 2026 09:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] configs/targets: Forbid S390x to use legacy native
 endianness APIs
To: Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-9-philmd@linaro.org>
 <41ab3dd6807e59420117f200b390be3544735347.camel@linux.ibm.com>
 <8cd94520-8f57-4e03-be16-b2dbda276ba2@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8cd94520-8f57-4e03-be16-b2dbda276ba2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 7/1/26 06:11, Thomas Huth wrote:
> On 06/01/2026 21.29, Eric Farman wrote:
>> On Wed, 2025-12-24 at 17:20 +0100, Philippe Mathieu-Daudé wrote:
>>> All S390x-related binaries are buildable without a single use
>>> of the legacy "native endian" API. Unset the transitional
>>> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
>>> further uses of the legacy API.
>>
>> One nit is that this text confuses me, because the code below sets
>> TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API rather than unsetting 
>> TARGET_USE_LEGACY_NATIVE_ENDIAN_API.

Oops, I'll reword.

>> End goal seems the same though.
> By the way, both definitions seem to be completely unused in QEMU 
> currently, so this patch is currently for no real use yet? Unless some 
> more infrastructure gets merged that consumes this setting, I think we 
> should rather not merge this patch yet.

Oh. I usually add 'Based-on' in my cover letters when there are
dependencies between series. I did that in the previous version
(which was not covering s390x) but Pierrick told me this was not
practical to apply and test, and suggested to share a branch/tag
with all series; which is what I did (sharing a tag,
https://gitlab.com/philmd/qemu/-/tags/endian_s390x-v1), however
I failed to precise the other series. In particular, this is
based on:
https://lore.kernel.org/qemu-devel/20251224152210.87880-1-philmd@linaro.org/
See these patches:

system: Allow restricting the legacy ld/st_phys() 'native-endian' API
system: Allow restricting the legacy ld/st_he() 'native-endian' API
system: Allow restricting legacy address_space_ldst() native-endian API
system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
system: Allow restricting the legacy translator_ld() 'native-endian' API
system: Allow restricting the legacy tswap() 'native-endian' API
system: Allow restricting the legacy MO_TE* 'native-endian' definitions
system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition

> I'll queue patches 1-7 for my 
> next pull request.

Thanks!

