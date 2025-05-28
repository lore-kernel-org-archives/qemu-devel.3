Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E270AC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 05:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9kT-0002Tp-26; Wed, 28 May 2025 01:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uK9kR-0002Ta-Oj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:54:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uK9kP-0007Jg-QZ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 01:54:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3109f106867so4133777a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748411680; x=1749016480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpM1neZjj6clKOY84wyLtWwXrmWhj6K3+6B2sjDbMtY=;
 b=ZBGpYDjf/JBol5IOkF5uPbaiEZwYQtMJplJKGBV0KsV/ZrKzn+Dy/MjX0ugRxXJiy2
 yZGbV5nHlSleR8UKRlqwQBr9Cp2BW6I34JY/u7i0y3PxiASupc6uta+e8havTdJpugNz
 m3/HpIYun5KKMzy0zP6RASDy0MoafZVAZyqiuG17EkYYbAgLrw45SRUvcGXX3LbCHhMQ
 gSGSgXMnfnFVqExM5z2AS98Rqy5Rmv/5mjqKqXUB/NWKpnl5SvrzlyQqGnqEET9mOiNT
 Iqr2Io5PtyGbjQ+jP9FiKm92DpM2IbPhCgNABgcCeerCDKfhkD9rUVYovclaRrB7HYhs
 fdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748411680; x=1749016480;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cpM1neZjj6clKOY84wyLtWwXrmWhj6K3+6B2sjDbMtY=;
 b=keTrGVnWkAL5iwmbNlv3Ys6gAdWxPbC017M4Nw57dv453fOfVMrc+LIHZh6Wa0yap+
 XrVbCLur/796HESgPMRhNaoExWTmIaixuadY9sWVgk6vEV+85/gKwXZvgs4YbdYZtcHz
 EM5t1jc4jddT1g1UqAletgJ+jXCfzNwIqcu5VxedutUcA2OT3VZAn9nLxPrw5ivcw6IT
 Mpn8ENoorSD7oESyYNFCHFDuCo+1wqJwZ5or/mRL5QtjvvGT6u2PJ7L2a6plcImyfeoT
 RdVLLByqxYd8NO4yu70o8s903Ro6S8qTy+TalhSxnlhtLKmIePeGHy3m16e1J9Svq6wP
 3PiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5q1yzA9ubT+mrHECGl6VPFytmydMiK7f+bWXYPO8xAmLkPk+Hd8U19kNNhYBejP3ENmSyB+389B/o@nongnu.org
X-Gm-Message-State: AOJu0YxxSDJuY2kqiHNxfzm5aLQFiTsM/iIPrprG/1xDicYXNnCNgByB
 SXWgrMNksUVOy22fQIgDguaOumRLF2+KTyYzEM3yVTHVClaQDvSlWevC
X-Gm-Gg: ASbGnctkFZU5v3XyjmoFgn/l7zciPUQRFVeOTkYFbiniGJWECF0Qe2s4YcsCxCQeDPI
 PgojhOlOSt/89BT4LPcsfjT2JlvHnl/TWsbOONUZ/8pSLPlb5fWSc38slAA65WlUkazmOIHbocl
 lHNl6JxKJXdrPtU2qZhCnJ32Rrf3H86vFB0L/FmKUpHSTSMNV9O54bYDqSwVOvCe706v4LgALGP
 Rf9b7V9EhldP0Ew1SufW10xgk2f1bXfPVlc6qF/JIeIR2uSq7r3MyEdiysjHKM/kG+gehP+7Wca
 6jdDBDlyy0PruSF1Zau78Fz4Y59ESLybALAlVmWo9tFia8GKDX6ydYzo4BphvwqP7xM=
X-Google-Smtp-Source: AGHT+IG07r9VmAgZRamQ8e3rwWzmbQJ/F3ibjGikqnkRKpcnHB0q21RC+zoON72b3bbfNHArx9ALQQ==
X-Received: by 2002:a17:90b:2318:b0:311:a314:c2c5 with SMTP id
 98e67ed59e1d1-311a314c39bmr8098996a91.16.1748411680047; 
 Tue, 27 May 2025 22:54:40 -0700 (PDT)
Received: from [10.3.2.14] ([221.216.117.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-311e3024459sm638131a91.0.2025.05.27.22.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 22:54:39 -0700 (PDT)
Message-ID: <7adc70a2-e99f-42c5-825c-901554e91d1b@gmail.com>
Date: Wed, 28 May 2025 13:54:36 +0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x102d.google.com
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


