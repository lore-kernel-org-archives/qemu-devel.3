Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B94CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2MS-00008d-KF; Mon, 01 Sep 2025 07:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2ML-000083-Cb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:06:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2MJ-0002lg-AD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:06:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b87a13242so13848505e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756724755; x=1757329555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g7LfsmVoQpvJ0TsCDcTvSH/tR1rq1IEO/y3R4BdxsFA=;
 b=AQ/KybkvqaJihiQXlMxZ0zPMBXV7fLcJFn++aGgIts5oENnT/34xe61I1hp+8uSMUI
 lnx+Lt7pbtUnOcbEgqdfOFJqA3FOTO/p7efTlcz5wYu2mbq/Qi1wP3Du+KdxjuShbd2e
 uSvMi06NHXrlKgVy+lcdPEOlaBCwp2KLHsQncubWuU4nPIhbt2zrVqK89NBKM9gXhq/G
 N5rgjAtvZRgUA3HsMgoWlm+7mwdTQW8b8B90FLHxYLJHsCqZRya2NscJ+87gkS9J6d4C
 w85EfjaVYcz4zvOUSoSDMgivxnd7T3Z2uxc45/TA//kxGETx82CK7PmVT+Nu+YnljM0O
 kJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756724755; x=1757329555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g7LfsmVoQpvJ0TsCDcTvSH/tR1rq1IEO/y3R4BdxsFA=;
 b=pBKitHKT5vvLXXpMU0c3LHFF1j2z49/D+LMxMyXWie8eKLoa99h4qH8xinAXzos1zF
 i41YA8fSKdqjLuuV0pYUledq0x7DtGnUV6XWDmT93HrkWe+6Qo8B0WZ3Ui8BWnUjHFUg
 3TzPtNn3M0MKHw8uSJ1H2VIMRMAcJ2tWt4ROfBXI0Kzi+0k518xM3sMcsP9w0gryFDmT
 Ye84qPYhALOJrpL4TXL00GdK1BmHrD//zwAzhmSj1Mb1B1oho7S52q7ASyh/fcp6wiMA
 ELFmIByT8MegyRPbhCsSTOO3E3Y0q8qIA/p9f34JKchmQuG1BxWiZ6x7TbZwt43asLAL
 0F6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfv5vvR2W5IZ8+dUuYGbxfptlMK4kZ5udq1SKGK6ih3ca1x1h03KP+AdD3aUtOyWdPU9TeO34+K7f@nongnu.org
X-Gm-Message-State: AOJu0YxUrP8yRSEHonAllxSvjij2NN1jHzY4Sszn3/GwzZeocJD0OHUX
 7kHlvEYHqqSDWsMt6c2C7erujdzctShk5nXz15igRCWAKPSIaxi0vsSvQzj71TzorjE=
X-Gm-Gg: ASbGncuIwmL4SsCB7aQIxknQqPpe7yitDbNB4N9xBRb8VxrCXff17rZNAbUjvSDe+sq
 joKBXMkjFBDxgRmZhlZTrIoNnU4StIg4f7ib8WmMVVkrX7UlokI10Wkuzy99ZKhYmxgPV3Y/R1x
 v+HTVNjWTz0oQNsdjnO4NTnijuE9ALLlNLyZI6SbxGmFuT2P8lJCyBxdo95m6o0/bnP3sUk3oJY
 d0bwJv6CQigJJeN6VvQD2h2twuMTE3l6NpkZ9V9018FiT0A5X3IUu2dyoW83dIWpmjLpV6lc/cF
 r/Z2nShp0tRxyqAeMwc2019UWKfmKXFR3kpGqVgprhZm7QZaQAUzLG29IYjqzF8dEM0w5lcAcuf
 Ds0zS7OS0K7ud6AzKnVDwoqtRb5bM15G8YjBcLFTZyfqzddTVFZEqLfnZkTR582lmTw==
X-Google-Smtp-Source: AGHT+IF4D8hdX3lBSKH/Mx6rN2QmWaalI/tCjlcwyGM1+b+ZZeHaAdXhM1TSPOwp5lE3uVAW4o45pw==
X-Received: by 2002:a05:600c:3b84:b0:45b:89ef:65ae with SMTP id
 5b1f17b1804b1-45b89ef6623mr55082115e9.16.1756724755316; 
 Mon, 01 Sep 2025 04:05:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b87632365sm94069375e9.16.2025.09.01.04.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:05:54 -0700 (PDT)
Message-ID: <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
Date: Mon, 1 Sep 2025 13:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
 <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/9/25 10:17, Djordje Todorovic wrote:
> On 8. 8. 25. 17:52, Philippe Mathieu-Daudé wrote:
> 
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you recognize the sender
>> and know the content is safe.
>>
>>
>> On 17/7/25 11:38, Djordje Todorovic wrote:
>>> This is needed for riscv based CPUs by MIPS since those may have
>>> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
>>> range, and if a hart is missing, this causes NULL derefs.
>>>
>>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>> ---
>>>    hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
>>>    hw/intc/riscv_aplic.c  | 11 ++++++++---
>>>    2 files changed, 27 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
>>> index b0139f03f5..22ac4133d5 100644
>>> --- a/hw/intc/riscv_aclint.c
>>> +++ b/hw/intc/riscv_aclint.c
>>> @@ -292,7 +292,13 @@ static void
>>> riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>>>        s->timecmp = g_new0(uint64_t, s->num_harts);
>>>        /* Claim timer interrupt bits */
>>>        for (i = 0; i < s->num_harts; i++) {
>>> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
>>> +        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
>>> +        if (cpu_by_hartid == NULL) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid
>>> hartid: %u",
>>> +                          s->hartid_base + i);
>>
>> DeviceRealize() handlers are part of machine modelling, not guest uses.
>>
>> IOW, triggering this is a programming mistake, so we should just
>> abort() here.
> 
> Well, if we do it that way, our Boston board target for P8700 cannot run.

So the problem is elsewhere :)


