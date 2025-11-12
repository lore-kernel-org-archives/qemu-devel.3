Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF98CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ6A6-0006JV-85; Wed, 12 Nov 2025 03:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ69w-0006Gl-Nd
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:25:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ69t-0008KG-Gg
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:24:55 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-42b3108f41fso285782f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762935890; x=1763540690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6U11kUQm8sRxz8OTQpA8Y/1j4PrHW/PDkE7RFJB2dg=;
 b=dUoe66Ib6XxOGIhYiFQN3g5TZYZsSAIVvFU1/M2oVbdVkbOqkgz/aHdCi6Mc7SqEiy
 +kpTFS9rVSHhA9Dljvpm21aZyHjtME7jpWf3H2Q4yl7r2JaJRldrl2QEg0OtPoCYZ28w
 Zynhh3MMwpFEN63Ix/YTyipSIJc/jgXiY2Cx2NOddvAkIySpHWlBj1shm0i1CMTId6AV
 vs3aqRrDxH3C1dyrioDGf/RHV8lmy69BhXVQa8GUM5v16CIKQupNqhbmuOBazZ6o8Irt
 eALd2saFDb8UjSS/yeB9PBqOLMXCZLRondibbMI3FUu5AjXM0zK5NfstsVSxcVhp9exz
 5Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762935890; x=1763540690;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6U11kUQm8sRxz8OTQpA8Y/1j4PrHW/PDkE7RFJB2dg=;
 b=Eivn6Qyl6aObwo9Bl0EcwWk97P8WSZXjmYmkgC1SSl/gg1cy3pgBZYyw9p9L5ChgQU
 /u/BKACAMp6UJr8WbW8JJUPID+a3iNUtGoD5kEjd+hsk6DXCCJ2qbYoKEAIUsgoWxSfj
 Tdfag1wJI4ZqqP+GUe/Bno3TFe7pQPnXqbtjEE+c0LLJatNu82UEHeb8qqlGtMA3iGgh
 T9LiflNkRfXRdiIV3GFUg9yOrrpNPbcjEw5iWCS/DFahNObgbRexJGu7yceqNkSQV+/4
 mqGrvwNNq9a7GjWCofbDgsFy2xxqhPy5PJCM3En8U59NgS9crGvjVX9zjaFXhJgzMJKb
 QFlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdzpHKcBGmClQfe3PUW+gSWMMzp035fmbHn7G6QvEdOEYrwxOjIzsDf1QrdhsEky9ZB5+vVrhbzvf5@nongnu.org
X-Gm-Message-State: AOJu0YzbgU0ZUKcVwl/OhWL+cZ02q6cW3R4BrbD0DwBnVYUouHcWIYqk
 hcShZsDuFomllGtePQPOxstXuUj/v6qgYQYqBKNVFmnvsQsGCX0s8AyqmXrmaNN+zdA=
X-Gm-Gg: ASbGnctjVuBw1mz4TCb7E5sNVdhBd4eEL4PlLpVO9nxJSltRGi4PpNpYYNj/Uk+DsO8
 /GAo22Bo0ZJy5lthBHXQ+pTKNy/LrdTrvcvySvxZ96eRJW4yU+USbH7T4m3FbQHIQm9kfpsKkbs
 cZmp1Nxl6MAOkZ5nwEKLh9YhK12NGyTZKLyd8V7tjL/Oo6alZvrCXsROJHhl1C+eG5/SaTmQh1q
 SPJ+FEhnW1KZpDOnrYH+EpICcrrHF6e7w/d01thcrcyFdkxzg85ft88MdxOt4Hp1U+3tQkrmAs0
 a0IWnEtvx5j9X4a5AWy4470h2t5/bSa1Z4fKRI/Jd2MvTatdEqR/o4GBzTf/G8LYI9BG/ezGz5p
 OxHoebXycOVtPr183g7SHUkMi30/HQ4wp7Eu5qHw9Gh1+JqVM1cTe8cP/V55RVch92FAu/jd6Z2
 esGbr46JXMS4SpYi5SOm2nsn/yJbbfVw7FmHTOZZE+JPI=
X-Google-Smtp-Source: AGHT+IHvO304gwk9Pwq6dgu9OdZUKjEe+AOr2E3BSge9KjpFaUBRRy+CmuhzH3NM2EStpEpvzoxJOQ==
X-Received: by 2002:a05:6000:4308:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42b4bdd5872mr1559314f8f.58.1762935890319; 
 Wed, 12 Nov 2025 00:24:50 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm32856622f8f.20.2025.11.12.00.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 00:24:49 -0800 (PST)
Message-ID: <29895ba8-0b4c-4bdc-a984-1e5052e426e5@linaro.org>
Date: Wed, 12 Nov 2025 09:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Accelerators & CPU patches for 2025-11-02
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251102181406.51160-1-philmd@linaro.org>
 <6aabcdbb-acdd-4b3a-8652-b9c1cf3ce435@linaro.org>
 <4e836608-dc06-41ea-8be0-eb34232b8b60@linaro.org>
 <041080b6-28b7-4a3e-868a-a25459470e3d@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <041080b6-28b7-4a3e-868a-a25459470e3d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 4/11/25 10:54, Vladimir Sementsov-Ogievskiy wrote:
> On 03.11.25 16:19, Philippe Mathieu-Daudé wrote:
>> On 3/11/25 10:20, Richard Henderson wrote:
>>> On 11/2/25 19:14, Philippe Mathieu-Daudé wrote:
>>>> Vladimir Sementsov-Ogievskiy (2):
>>>>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>>>>    tests/unit: add unit test for qemu_hexdump()
>>>
>>> This doesn't build:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/11947161300
>>> https://gitlab.com/qemu-project/qemu/-/jobs/11947161195
>>>
>>> and 10 other variations.
>>
>> Nice. Apologies for missing that.
> 
> Oops, my fault.
> 
>>
>> Vladimir, please repost (only) the test:
>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- 
>> philmd@linaro.org/
> 
> 
> Hmmm. But how to correctly fix it?
> 
> As I understand, the problem is that
> 
>    util_ss.add(files('hexdump.c'))
> 
> comes inside
> 
>    if have_block
> 
> block, so it miss targets without block subsystem?

Likely: we can build QEMU user emulation without system / block.

> Would it be more correct, to just move `util_ss.add(files('hexdump.c'))`
> out of the block, so it compile always, like many other "utils"?
> Actually, qemu_hexdump() itself is unrelated to block..
I concur, this should be the correct fix.

Thanks,

Phil.

