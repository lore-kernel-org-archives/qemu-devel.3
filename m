Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3E8C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg60X-0001rp-9B; Thu, 06 Feb 2025 12:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg60V-0001r6-Bl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:49:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg60T-0006vg-Cr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:49:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd730so8589665e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738864180; x=1739468980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qbATPXaShk6uHSkyuikGuAhkTLp1PYYgNhbuymCQ74=;
 b=pgZXedWCe7kQcFZG3LVXg2dbyA+MbUowLiwacbITtprWBicobVpgbt5lIkiHSlvtX0
 X+uWhbxX7bq4gRQUpxlCv8HQf/w53Pi8SY9tvYtB854RBcsl9+vPefJZLF8y+FTbe2ct
 FuXBrxtIJfYugcAAktp0hVmhJWIlwYHD8Ar89XNCAs+VtqKx87rduvPnu0WgmHb/+CKj
 U6hi3AvReFQB9OXKLA79SZDaVeW5xv3L7a6bucA5HSif3ukF2VLntuz1lPYCy4RG+1ai
 M7m4PO+gWl6yvvGkJQoDr5DmBV1JIgLLlsMeb7vCySwkByJZ3bA+Yxf+6seViovoGc+X
 OEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738864180; x=1739468980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qbATPXaShk6uHSkyuikGuAhkTLp1PYYgNhbuymCQ74=;
 b=pHdtr7J0WHhSlYrX8WMi4QqpCL915bsgA9XiAATo3sfHx+EZFq0qUB7Ey0L2P1E2Em
 GwvDJDYa22ZACpOp4qghgBkN77yOc7t9tX38cS6jZPMiY0L8eIU6Tbml3ah2mVyOb5mZ
 s4E7wecCxZG8XImLL319gGwy6E47fkd3NenZPm6xOlUWV+pcZEo08GidWJdmB0e+tAKL
 FrrU1R10BSArLBq4bvkUtkBhxqM5h4HxDI4CD6aBHM9N1nNkzeaizcEdQF/CBt9N5mWi
 N1saUomcX0ue0ESKWHWXkTNzYVXxDF2H7pNQIOlGl0/1zq9WsW8QCPVu+4m6UUfDGyAu
 iUzg==
X-Gm-Message-State: AOJu0Yyi3QlQgVYVMn39OgviMSamhGFm/hLXi+ELkYOggY96wT3Zcq58
 FTTQXr14E/ROrOKAVNzBzNZ9CgGoMNthYXg4k+JJDzkYAOhdRqWuSQK6PKUQwaA=
X-Gm-Gg: ASbGncuyEVQYSSUSr3Yd/3BGahQJndS1NuSQ/Sj53A1YeC1oRNo6yHjDEWZmGFHVPEh
 hXPFtwRVPGt6gHBAuvFNZNkBBU9CucW3wOcjKX6SVu206H+7lvr4vMDuFszd3awZ3Jg4gnUwgq9
 WRI1uuEt8XbDYY86W/baTeA69ukYsVXte/lKsfLwLDvNCfHieojoCrHmJu+OtXtr7ztKJ/mvHkS
 aLxGllxSIPCgcL4MJ6xg3G+7KtmXvrNeIP5teHUmxvQ+QFr5UM6uR5xtXtF78jcyJYW/2O9IuIm
 CZQ4S7i++ksfdMdh0ltSzqFcCKLa3tluZm/jVBrHZmkbG8WTn8ybn/zRgYo=
X-Google-Smtp-Source: AGHT+IHGwiA08zihX48ND/VhtsouPRB1vY98R0v9pH2fOXaRNWTVoOUqMhvwPWkq8cNmhk8ESV7Szg==
X-Received: by 2002:a05:600c:218f:b0:436:fbe0:cebe with SMTP id
 5b1f17b1804b1-43924aca5c4mr2326755e9.30.1738864179625; 
 Thu, 06 Feb 2025 09:49:39 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1deebsm2253959f8f.86.2025.02.06.09.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:49:39 -0800 (PST)
Message-ID: <63f1130e-a30d-4416-ae74-374f1fd94dbe@linaro.org>
Date: Thu, 6 Feb 2025 18:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
 <Z6TtisO7JGAMGILH@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6TtisO7JGAMGILH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/2/25 18:12, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 04:04:20PM +0100, Philippe Mathieu-Daudé wrote:
>> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>>> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Hi Daniel,
>>>>
>>>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>> Introduce an abstract machine parent class which defines
>>>>>> the 'little_endian' property. Duplicate the current machine,
>>>>>> which endian is tied to the binary endianness, to one big
>>>>>> endian and a little endian machine; updating the machine
>>>>>> description. Keep the current default machine for each binary.
>>>>>>
>>>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>>>
>>>>> Does it makes sense to expose these as different machine types ?
>>>>>
>>>>> If all the HW is identical in both cases, it feels like the
>>>>> endianness could just be a bool property of the machine type,
>>>>> rather than a new machine type.
>>>>
>>>> Our test suites expect "qemu-system-foo -M bar" to work out of
>>>> the box, we can not have non-default properties.
>>>>
>>>> (This is related to the raspberry pi discussion in
>>>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).
>>>>
>>>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>>>> remove it we can merge both qemu-system-microblaze and
>>>> qemu-system-microblazeel into a single binary.
>>>>
>>>> If you don't want to add more machines, what should be the
>>>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>>>> with no particular endianness? Either we add for explicit
>>>> endianness (fixing test suites) or we add one machine for
>>>> each endianness; I fail to see other options not too
>>>> confusing for our users.
>>>
>>> We would pick an arbitrary endianness of our choosing
>>> I guess. How does this work in physical machines ? Is
>>> the choice of endianess a firmware setting, or a choice
>>> by the vendor when manufacturing in some way ?
>>
>> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
>> (wired to a CPU pin which is sampled once at cold reset).
> 
> That makes me thing even more it is just a machine type property.

I'm happy with a machine property, this was even my first approach
using OnOffAuto until I ran the test-suite and have qom-introspection
failing.

What should be the default?

Per the SH4 datasheet:

   Bit 31—Endian Flag (ENDIAN): Samples the value of the endian
   specification external pin (MD5) in a power-on reset by the
   RESET pin. The endian mode of all spaces is determined by this
   bit. ENDIAN is a read-only bit.

There is no default per the spec, and I believe using one is
a mistake.

> None the less, since you've already taken this pattern of
> dual machine types for BE & LE on  MIPS/SH4/XTensa, I think
> we should stick with your precedent. Consistent modelling
> of endian handling across all machine types is most important
> IMHO
> 
> 
> With regards,
> Daniel


