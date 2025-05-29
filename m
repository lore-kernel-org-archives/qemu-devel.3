Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B265C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 09:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZiw-0006VS-S6; Thu, 29 May 2025 05:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uKZit-0006TF-QF
 for qemu-devel@nongnu.org; Thu, 29 May 2025 05:38:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uKZir-0003r8-PE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 05:38:51 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73972a54919so537851b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748511528; x=1749116328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfaelcgIVhuAZYME0fmvQjSKG7E6k1vdLTLsh7xtbcY=;
 b=RmDhwbFqLEYLEP5JtgKbXY8KZmKJIzZ2fjNitNYsfWdiXoTMg37tNgivvSpEx0AZQ0
 eI7Pnj73L0JOkmnLw+beIn0dov4Nrc03kWKq5Z+/9WjKGnpCefOKpeWwHYcfjCsJ+Gp7
 kwFQnfbyzn4SP1vxKh+Uyq9T+RfIysZ2JgM7wlvR3PtKrwuSOynIWEF5UbkTpZXfN2xz
 I35Y62AnEklec2DylTuD3QyIDdQPcZ9LnQrKvFfvvSJe39Six6u0gQ0fBFLVq5//7JCC
 OoXry2XsY6S4kENAQyLXk65zv8v9tNqMb3RJtoeU77GsVqITnGs8v4UJyhM2Hf7zKtU/
 h2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748511528; x=1749116328;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IfaelcgIVhuAZYME0fmvQjSKG7E6k1vdLTLsh7xtbcY=;
 b=NwjRVohaX43e3NxIUGLxWYX2HNkYrFPhJ+4aZslhogLSSPC/8bawnHFb1hM8L4lvxD
 zqKvU0R2r+dyVFLilllhOpzE9JZ6j1Ghfl59vjwb+XWquJT0383W9fWm0mClhZafDUCH
 dFMykIFSk3pbZplPQ+6TMIxk3jBdlULjXMqwlpQwD0v+aWCEcGpDl6qdzWBYsP9L9MM5
 7NLdJTJRuyl3f1TG5xDn7TqD9pV4/OL79XTmlctDLvV39Byl3gsOng/qbJhdyKlgVb67
 lz2eUNVzlAdNbSU/6YErBdtkSPE28+CNmig1VgiMAxkX77UCLDYZk5adHaxV3EXP2kMm
 poYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcjBA8U2uEf4e5tBDKYIvQWzUiNnnIWWzfkxX6xKD52tES+dMteyq5fgHtFjGA4xGrpERvwRdhe5Gb@nongnu.org
X-Gm-Message-State: AOJu0YzCq0USzjwkX64ydjjo7NIe6ejq9rnotQFrNnHhtEmfIU79mm8Z
 /ORr+VmBnQ7u0Uc3uvAGLbOyEPQSmRYOMsGpt+hYVXQNAPeNS6wim8o3
X-Gm-Gg: ASbGncsafNzNV9BZKrYg+X/oDbmn0677YRk26h3JaBFtpYsvvjp1R/pCGOpxcCP+c1Z
 snoKA47GSK6sx2jEZmJp+crDP1p8yWpOTcnIZ+CLsNMyuszEQOmLuiiHtEL+v5kJrfuP06SSyG9
 vyKCSffSsGREcHJvIkTpsGeP17mAMsKLjZVAGOnPsoMw2FO4ltOnD+OkQwJFcXzKNav1hLxVw7n
 bjukTFfHY5ogUOttb5Rzg23IRlF6PO2K30PvUqQRz3jqe2UzMLBZNMEwR48Ys9Qdsm+PuBvrtXx
 WSL1bV/SBwaaZ2NmiXFm83jgllNGU6toBy9KpFs1jYRGJxqhvOMF2FEpLoV8y1BtGvFDAiuvSmC
 4IpKSdjH7pgVHYQQ/3XkWG8g=
X-Google-Smtp-Source: AGHT+IE+pa2EtfGwA/xnHXrCpcDtei8Jwx3w8PaqKiFkuMv79/AKEmWoKyGpcA+Lc4zZkcjyTtf7Kw==
X-Received: by 2002:a05:6a21:3305:b0:1f5:87a0:60ed with SMTP id
 adf61e73a8af0-2188c289ab9mr29404816637.19.1748511527869; 
 Thu, 29 May 2025 02:38:47 -0700 (PDT)
Received: from ?IPV6:2001:da8:201:1412:2122::74ec?
 ([2001:da8:201:1412:2122::74ec]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab7a6sm948107b3a.45.2025.05.29.02.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 02:38:47 -0700 (PDT)
Message-ID: <e6d1e6d6-b84f-42fa-8df7-67824e6f3e3d@gmail.com>
Date: Thu, 29 May 2025 17:38:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: Re: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
To: Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, peter.maydell@linaro.org
References: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
 <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
 <6dd914b1-2a2f-4a4c-bd2b-54e8302d1a75@ilande.co.uk>
 <7e4a9c92-b33f-4bc9-968d-e726c6151a9d@gmail.com> <87tt54994x.fsf@suse.de>
In-Reply-To: <87tt54994x.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=hz1624917200@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 2025/5/28 21:07, Fabiano Rosas wrote:
> Zheng Huang <hz1624917200@gmail.com> writes:
> 
>> On 2025/5/28 03:40, Mark Cave-Ayland wrote:
>>> On 27/05/2025 14:59, Philippe Mathieu-Daudé wrote:
>>>
>>>> Hi,
>>>>
>>>> Cc'ing maintainers:
>>>>
>>>> $ ./scripts/get_maintainer.pl -f hw/scsi/esp.c
>>>> Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI)
>>>> Fam Zheng <fam@euphon.net> (reviewer:SCSI)
>>>> $ ./scripts/get_maintainer.pl -f migration/
>>>> Peter Xu <peterx@redhat.com> (maintainer:Migration)
>>>> Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
>>>>
>>>> On 27/5/25 15:12, Zheng Huang wrote:
>>>>> This patch add validation checks on FIFO structures in esp_post_load() to
>>>>> avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_push(),
>>>>> which can occur if the inbound migration stream is malformed. By performing
>>>>> these checks during post-load, we can catch and handle such issues earlier,
>>>>> avoiding crashes due to corrupted state.
>>>>
>>>> How can that happen? Can you share a reproducer?
>>>>
>>>>>
>>>>> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
>>>>> ---
>>>>>   hw/scsi/esp.c | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>>>> index ac841dc32e..ba77017087 100644
>>>>> --- a/hw/scsi/esp.c
>>>>> +++ b/hw/scsi/esp.c
>>>>> @@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int version_id)
>>>>>           /* Migrate ti_buf to fifo */
>>>>>           len = s->mig_ti_wptr - s->mig_ti_rptr;
>>>>>           for (i = 0; i < len; i++) {
>>>>> +            if (&s->fifo.num >= &s->fifo.capacity) {
>>>>> +                return -1;
>>>>> +            }
>>>>>               fifo8_push(&s->fifo, s->mig_ti_buf[i]);
>>>>>           }
>>>>>           /* Migrate cmdbuf to cmdfifo */
>>>>>           for (i = 0; i < s->mig_cmdlen; i++) {
>>>>> +            if (&s->cmdfifo.num >= &s->cmdfifo.capacity) {
>>>>> +                return -1;
>>>>> +            }
>>>>>               fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
>>>>>           }
>>>>>       }
>>>
>>> This seems odd: this logic in esp_post_load() is for converting from pre-Fifo8 code to the current Fifo8 code, so why wouldn't we want to assert() for the case when the migration stream is intentionally malformed? Is there a case whereby the old code could generate an invalid migration stream like this?
>>>
>>>
>>> ATB,
>>>
>>> Mark.
>>>
>>
>> Hi Mark,
>>
>> The malformed migration stream in question originates from QEMU itself—either accidentally, due to 
>> a bug, or maliciously crafted. If we allow unchecked data through in esp_post_load(), an attacker
>> controlling the migration source could send crafted values that trigger undefined behavior.
>> The commit https://gitlab.com/qemu-project/qemu/-/commit/b88cfee90268cad376682da8f99ccf024d7aa304
>> also check the migration stream integrity in post_load handler, which is suggested by Peter Maydell in
>> https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg00099.html, 'to prevent the division-by-zero
>> in the "malicious inbound migration state" case'.
>>
>> Also, I would appreciate your opinion on how we should handle such "malformed migration stream" case
>> more generally, if there are more severe issues than assertion error, such as FPE, UAF, etc.? Should
>> QEMU adopt a more systematic “post_load” validation pattern—verifying all critical fields across every
>> migration handler—to harden the migration subsystem against any tampering of the migration image?
>>
> 
> From the migration perspective it does make sense to validate the values
> and return error. The migration stream should indeed be considered
> untrusted.
> 
> But I agree that it would be nice to have some sort of reproducer. I
> don't think it's practical to go around adding code to handle every
> single hypothetical scenario. That creates some churn in the codebase
> that might introduce bugs by itself.

Hi Fibiano,

I'm very appreciated for your advice. I also agree that there's no need
and inpractical to check all fields of each device. So I'm focusing on
security or critical issues such as buffer overflow, UAF, etc.. For
instance, unmatching between buffer size and item number field will
cause an arbitrary address write, which can be exploited to attack host
machine. CVE-2013-4536(https://nvd.nist.gov/vuln/detail/CVE-2013-4536)
describes this scenario.

I've developed a fuzzer aiming to discover security issues caused 
by malformed migration stream, which has reported some memory corruption
crashes. I'm wondering if you will be interested in such issues that 
are more severe than assertion error? I'll be glad to have some further
discussion.


