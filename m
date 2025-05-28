Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1067C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 05:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9hz-000153-3U; Wed, 28 May 2025 01:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uK9hw-00014N-Cc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:52:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uK9hu-00075o-Ja
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:52:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso484858b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 22:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748411524; x=1749016324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKnYbYjlcHTGbH5BiY/ODXHsRg4VDMa+90rlfnMsFFE=;
 b=IOXVI+qDEGjhSalTLbpm9mnK7u4zDKOYCDB8CCGBiXaEoRhf9t+z09NwyrVoPi6vPc
 SQvd/XFednvgYWHennWgcCAsW/aHvfKVZqJyLn9TCtWWtqSs0jxZwwwzTznnzxl45zAb
 sFEa9pbnHf/fMYLoQTsDnaPobeZ3t1fm3f6fteyJey0ftkqrniHyHwQ+dAqPNlneP1tQ
 99NSCB+SyhUgX4mY11M7ZydqdSlWZaFtSq+A+eQcW0TMk7+JfmdP4nCJbivG4E0w/ux3
 kWFC+6ZF0vEV7Kbu8KQVKc2+VOk38MKMzU/f97o9uMjJ1Est+F56m5Hg9/QIVbqPYkYt
 Sfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748411524; x=1749016324;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VKnYbYjlcHTGbH5BiY/ODXHsRg4VDMa+90rlfnMsFFE=;
 b=XHNcngaNGgAGGDGpIGKfP52iSpV+SbAbTvLR7c5vf+vmEQnI1aah/Cc6CKpIeW2HGF
 vgVYLalmVFOfj7/k05Oor7+6+r/pk+U+endGcgZbbn2ld+oKQbMk3mNVQowucvyPtP1H
 fonLUAKAhvFMFCZNkTXLaUCeZ951H3JKQVB+Xa3x7sGLcJu3Gt6MQtDHgq5DbwAG0wqw
 QEIVFtkEAEqOSPlwRW52trlBFhMhONGuJ3LHKPrwbzeidaNU5OeN7+gf+K+1vuR8Qyl7
 1q7L5l0JY1MyMTplryitiC+R/et3OYPT5mWl8PxpM/ILsQavD48ORRUoPiS/HRlm4oAG
 XQPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMRSZ7dkx0kuTvIAwD/nznzwWexOqpWcTkDoyNaJe2Aumi+Wk4xwvDzqTB7DpFKnCD7e+s7T4/mY/l@nongnu.org
X-Gm-Message-State: AOJu0YyJ1FL+u9xmmy3wQBnrHCg1DlPo0L9N71xeJjl302ZooMbCxgrk
 WVz4SMVKL3M0prX0vjphIjwgLGOmrOrRwAfZeYnb2FNdpWtpFz4n+NhW
X-Gm-Gg: ASbGncsuQG2HmiHlc5ARyDSaw6aWQd1ftlQ69ZD1T5Djf1YJRtu5N2YLYbbwfcIEmW2
 E8KY0ZVGpoBZfWh2WlT0tarL/J3YyiqE/W5Rom+SQ+gsOyruB7OYsFLX6Bnim2y8vnuScYR9WDS
 orUvazk3vMxuC8jxj7JxTHxcT9GZfWzTpQsgbHbOzZsThfob+LoF5Nr9+9V/6BKqEft90TIXPez
 NavIw5l9MzZQtV+JjFRI72vMVtgkfMy01TFgGwT9Hrw5SrRLT2pXcicJqqv76gsJpPO6IRlZxeQ
 RLUiM/JYW9r2H3DDDeHgfj7Ze7xW9Y2I8rBfGnwKsmBOQQa6E0iL4lLLNOHNLVOc0Y4=
X-Google-Smtp-Source: AGHT+IH6PErQ2HR2fK2O3/VhOYna/H5KBKEycTWLCjrZ4bZ67YcbQt1nbT+IXHT9G6gaV1wIgE1Bpg==
X-Received: by 2002:a05:6a21:118e:b0:215:d1dd:df4c with SMTP id
 adf61e73a8af0-218cc9a4b1amr5782738637.6.1748411524497; 
 Tue, 27 May 2025 22:52:04 -0700 (PDT)
Received: from [10.3.2.14] ([221.216.117.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746d60481c0sm457845b3a.48.2025.05.27.22.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 22:52:04 -0700 (PDT)
Message-ID: <7e4a9c92-b33f-4bc9-968d-e726c6151a9d@gmail.com>
Date: Wed, 28 May 2025 13:51:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: Re: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peter.maydell@linaro.org
References: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
 <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
 <6dd914b1-2a2f-4a4c-bd2b-54e8302d1a75@ilande.co.uk>
In-Reply-To: <6dd914b1-2a2f-4a4c-bd2b-54e8302d1a75@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=hz1624917200@gmail.com; helo=mail-pf1-x434.google.com
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

On 2025/5/28 03:40, Mark Cave-Ayland wrote:
> On 27/05/2025 14:59, Philippe Mathieu-Daudé wrote:
> 
>> Hi,
>>
>> Cc'ing maintainers:
>>
>> $ ./scripts/get_maintainer.pl -f hw/scsi/esp.c
>> Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI)
>> Fam Zheng <fam@euphon.net> (reviewer:SCSI)
>> $ ./scripts/get_maintainer.pl -f migration/
>> Peter Xu <peterx@redhat.com> (maintainer:Migration)
>> Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
>>
>> On 27/5/25 15:12, Zheng Huang wrote:
>>> This patch add validation checks on FIFO structures in esp_post_load() to
>>> avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_push(),
>>> which can occur if the inbound migration stream is malformed. By performing
>>> these checks during post-load, we can catch and handle such issues earlier,
>>> avoiding crashes due to corrupted state.
>>
>> How can that happen? Can you share a reproducer?
>>
>>>
>>> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
>>> ---
>>>   hw/scsi/esp.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>> index ac841dc32e..ba77017087 100644
>>> --- a/hw/scsi/esp.c
>>> +++ b/hw/scsi/esp.c
>>> @@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int version_id)
>>>           /* Migrate ti_buf to fifo */
>>>           len = s->mig_ti_wptr - s->mig_ti_rptr;
>>>           for (i = 0; i < len; i++) {
>>> +            if (&s->fifo.num >= &s->fifo.capacity) {
>>> +                return -1;
>>> +            }
>>>               fifo8_push(&s->fifo, s->mig_ti_buf[i]);
>>>           }
>>>           /* Migrate cmdbuf to cmdfifo */
>>>           for (i = 0; i < s->mig_cmdlen; i++) {
>>> +            if (&s->cmdfifo.num >= &s->cmdfifo.capacity) {
>>> +                return -1;
>>> +            }
>>>               fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
>>>           }
>>>       }
> 
> This seems odd: this logic in esp_post_load() is for converting from pre-Fifo8 code to the current Fifo8 code, so why wouldn't we want to assert() for the case when the migration stream is intentionally malformed? Is there a case whereby the old code could generate an invalid migration stream like this?
> 
> 
> ATB,
> 
> Mark.
> 

Hi Mark,

The malformed migration stream in question originates from QEMU itself—either accidentally, due to 
a bug, or maliciously crafted. If we allow unchecked data through in esp_post_load(), an attacker
controlling the migration source could send crafted values that trigger undefined behavior.
The commit https://gitlab.com/qemu-project/qemu/-/commit/b88cfee90268cad376682da8f99ccf024d7aa304
also check the migration stream integrity in post_load handler, which is suggested by Peter Maydell in
https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg00099.html, 'to prevent the division-by-zero
in the "malicious inbound migration state" case'.

Also, I would appreciate your opinion on how we should handle such "malformed migration stream" case
more generally, if there are more severe issues than assertion error, such as FPE, UAF, etc.? Should
QEMU adopt a more systematic “post_load” validation pattern—verifying all critical fields across every
migration handler—to harden the migration subsystem against any tampering of the migration image?


Best regards,

Zheng.


