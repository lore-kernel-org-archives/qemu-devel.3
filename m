Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D26C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6qT-0000wy-7D; Thu, 06 Feb 2025 13:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6qN-0000ui-CS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:43:19 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6qI-000691-Bc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:43:17 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dc962f1b9so6591f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738867392; x=1739472192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRu25FZTtQki2UM8OpruWCIN1mpgd90J2VsCiuXGr1k=;
 b=xk/UmOh5r6aFedx5jt4WL/oDjA1HA6iG82gbQQzxFOJypJS+GsTkU98Ost97wZGTWw
 CrglZ1xKmegQDpLzAvtHpSUdx30dyB7UjI9OECvXH7tRR0t6tbzjW/3D6R2Z+YRCOUry
 uLtG1X8Ns38eM5Oidx8l3lc3+YaZa2V/Qg2JZJ+96fXxmlP2jT0Z1sbp2I0IEC/rHbqH
 nySgvr9+XuSNi5u90EtkI3r6o0Z8VHTD0D8LTvMP/hwsM3zAUcnYn7sRzzYT88MvK3z0
 SZOqCuNq+c9Ye8gsfQymhaL5PoldPSMMr+LGRu9hhi7IJn8s14ea4IYae2XF2WUU17BP
 I5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738867392; x=1739472192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRu25FZTtQki2UM8OpruWCIN1mpgd90J2VsCiuXGr1k=;
 b=fibxEvJ9rVSWNB/izUm6j2G3GG07F4VJVX5lsAFf2elvdKMyomcYGXFhhm4uXXtuzY
 zfhAVcHDCfL7yWEJc2fNjkHvXkteTxLZ7/6IKCPzv9pxdneG9tWqqXw8zYMZNRB/fU/u
 Pp9/o6BRgAi2qpraaXVqkkJwfzzmKnclRQf4sgsbqGhMRgnqub4/HyJO0TIS0qeYw/xr
 B85t/KNFMJDxkDq7CVq770wdOt3vQxRCFPmUR3BJyQwWzQJFUuE6cqAUAAInutLbqKcX
 p658TGhrkI1V+xdN/s10+k7/n96MRWy6oE4qhW+SEbzuevMVcoghSUB57Pf/g2W651tw
 2ydA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8XxDW7CQf0hChogosIBnEWTlgSnRv2fWkulJN9s6Q7HrK6po/WzEluguDhdoslw0K39tnqyo2PNm3@nongnu.org
X-Gm-Message-State: AOJu0YwWVCzb6vQGZAQLYX0J0zwjqQqCNiEvgDqSEVWiEijguScpvHJj
 fuQMNo0h39Cpsn1i6T5X0egv+yXAfwyCQrefcIV4tOhlIvXNUvsBCZxAofVsCLc=
X-Gm-Gg: ASbGncuYPeFFSr/xsDq9Rx+XIl4hW88XrDrY78/ZLSRlvE3RegxO9h1/WkQHK9myH49
 9pz0bsIYS2xKmHMFHUNmWb6m55QMQo/dxziomI6QxOWZlT63ywPgciT9c/K9AHZxCX1G1iG9L8t
 DOGwA9UjW18+gLFHWU/kTyDYkC0H3J6WlVrElSwVN221G0FDIN1SUGF+3remHVQD9waDEg6dnFs
 hAsTKNtg6i80DzCyvz1CfdpYqr0SD/rrRaT+GryuGB2P3s1tCQ8JGO3mjM9RMlzL+9KtreoyD9H
 qVU2SL4GPTPIp1vPhXBqvIK9DhrxAuMT4eTx0aRxrv8CYiCo6L25OJqetYY=
X-Google-Smtp-Source: AGHT+IGlSe/OauHhGNHRq4VO1vZOyZ0i28VGTbFb7XtcApTPNi4+CyX8mGSbryfOsBp+IF42KZ6a9A==
X-Received: by 2002:a5d:5984:0:b0:38b:ef22:d8c3 with SMTP id
 ffacd0b85a97d-38dc934bcd9mr49083f8f.35.1738867391705; 
 Thu, 06 Feb 2025 10:43:11 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36967sm2421995f8f.37.2025.02.06.10.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 10:43:11 -0800 (PST)
Message-ID: <e403f0be-1bd0-4b8c-a99d-bbb1abebfe55@linaro.org>
Date: Thu, 6 Feb 2025 19:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michal Simek <michal.simek@amd.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
 <Z6TtisO7JGAMGILH@redhat.com>
 <63f1130e-a30d-4416-ae74-374f1fd94dbe@linaro.org>
 <Z6T6CiL_F-LvLGel@redhat.com>
 <ce653340-1375-41b5-bebb-c7089d3ab2bb@linaro.org>
 <Z6T_hq21zjtU43bC@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6T_hq21zjtU43bC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 6/2/25 19:29, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 07:24:55PM +0100, Philippe Mathieu-Daudé wrote:
>> +Michal
>>
>> On 6/2/25 19:06, Daniel P. Berrangé wrote:
>>> On Thu, Feb 06, 2025 at 06:49:38PM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 6/2/25 18:12, Daniel P. Berrangé wrote:
>>>>> On Thu, Feb 06, 2025 at 04:04:20PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>>>>>>> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>>>> Hi Daniel,
>>>>>>>>
>>>>>>>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>>>>>>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>>>>>> Introduce an abstract machine parent class which defines
>>>>>>>>>> the 'little_endian' property. Duplicate the current machine,
>>>>>>>>>> which endian is tied to the binary endianness, to one big
>>>>>>>>>> endian and a little endian machine; updating the machine
>>>>>>>>>> description. Keep the current default machine for each binary.
>>>>>>>>>>
>>>>>>>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>>>>>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>>>>>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>>>>>>>
>>>>>>>>> Does it makes sense to expose these as different machine types ?
>>>>>>>>>
>>>>>>>>> If all the HW is identical in both cases, it feels like the
>>>>>>>>> endianness could just be a bool property of the machine type,
>>>>>>>>> rather than a new machine type.
>>>>>>>>
>>>>>>>> Our test suites expect "qemu-system-foo -M bar" to work out of
>>>>>>>> the box, we can not have non-default properties.
>>>>>>>>
>>>>>>>> (This is related to the raspberry pi discussion in
>>>>>>>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).
>>>>>>>>
>>>>>>>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>>>>>>>> remove it we can merge both qemu-system-microblaze and
>>>>>>>> qemu-system-microblazeel into a single binary.
>>>>>>>>
>>>>>>>> If you don't want to add more machines, what should be the
>>>>>>>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>>>>>>>> with no particular endianness? Either we add for explicit
>>>>>>>> endianness (fixing test suites) or we add one machine for
>>>>>>>> each endianness; I fail to see other options not too
>>>>>>>> confusing for our users.
>>>>>>>
>>>>>>> We would pick an arbitrary endianness of our choosing
>>>>>>> I guess. How does this work in physical machines ? Is
>>>>>>> the choice of endianess a firmware setting, or a choice
>>>>>>> by the vendor when manufacturing in some way ?
>>>>>>
>>>>>> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
>>>>>> (wired to a CPU pin which is sampled once at cold reset).
>>>>>
>>>>> That makes me thing even more it is just a machine type property.
>>>>
>>>> I'm happy with a machine property, this was even my first approach
>>>> using OnOffAuto until I ran the test-suite and have qom-introspection
>>>> failing.
>>>>
>>>> What should be the default?
>>>>
>>>> Per the SH4 datasheet:
>>>>
>>>>     Bit 31—Endian Flag (ENDIAN): Samples the value of the endian
>>>>     specification external pin (MD5) in a power-on reset by the
>>>>     RESET pin. The endian mode of all spaces is determined by this
>>>>     bit. ENDIAN is a read-only bit.
>>>>
>>>> There is no default per the spec, and I believe using one is
>>>> a mistake.
>>>
>>> If it is left as an unspecified choice in the spec, then I would
>>> presume HW vendors are picking an option based on what they
>>> expect "most" common usage to be amongst their customers. IOW,
>>> if we know of typically used guest OS prefer big or little, that
>>> could influence our choice.
>>
>> Please have a look at this thread:
>> https://lore.kernel.org/qemu-devel/d3346a55-584b-427b-8c87-32f7411a9290@amd.com/
> 
> That seems to give a pretty clear choice for qemu defaults
> 
>   "I am not aware about anybody configuring MB to big endian"
> 
> so in that particular case, defaulting to LE would be most sensible.

Or maybe I should stop trying to unify the current binaries, and add
the new data-drive machines in a new binary, as you already suggested:
https://lore.kernel.org/qemu-devel/ZEoyNt0UtSYRt9Go@redhat.com/

But then I'm worried about our users, on how to deprecate the current
microblaze{,el} binaries to have them use the new one seamlessly.

And more importantly, one of the goal is to maintain LESS binaries,
no more.

