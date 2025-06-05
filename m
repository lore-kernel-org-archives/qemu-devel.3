Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9E6C5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDHC-00052E-Hz; Thu, 05 Jun 2025 12:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNDH9-00051j-6o
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:17:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNDH7-000566-0A
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:17:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso1114314f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140220; x=1749745020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFC3uJI4mogqZ9GT5cRUgBdAMh2qIRhTxz605GYfzAI=;
 b=WytDOrEo357rSPRUWiG0H7gO8WJ/VwTR/16XnhMzXz+zg1W+VAl3Cnqy7NvDEtvyi1
 oz73lT75RlT4yGHl6fASy0sBVUw7RBB9safmeGnyfrtnux+61i4yKI4Y6Ya2HKr4OzvD
 fJP3wgWOO3GdgvBj9SyulBN8VH/SfMDfn6tZuAooMfaL0LNFj3AWOvop0QyBuaCKBgFP
 dV5/MwRIyhKG+FGesoVxuTS7SBd2SVyBJjiaZK6Pqfa6/AeBKNU1zwB/HL/ZxkhlvU4R
 nJ6RKV0x9KlYAOZiNr2FAPoei/SfhwJu8wOTSmkn0arY04apxALZ4W050NpFyYd7A4lR
 2K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140220; x=1749745020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFC3uJI4mogqZ9GT5cRUgBdAMh2qIRhTxz605GYfzAI=;
 b=qoEE35vNJ4+TPLJBmJicxhqFh5d7EKHw5RFQakWm2I6CKN3De8lVqiVMLndHg93Oge
 yvNVnc+uwzG7K4+PfxMF4BreuJAnJIuNFXZkvXxz/3jSoUsGU6jsiL038jjVMKXlr/MZ
 YO8sBpP+eSgowuq6oGgJgoYw002MRwai1KMgSBwC9qwUFWw/27TaXXNJjlcYp2C41z+0
 611Pojdkwq3LWYYBgeyDPDcBk968jGLqrXPr8XLludgo61h1HCt7lAOIL9qZesVJGRSY
 avUUIufRSG+9a/nmd+1+/x4CSEPDlzcg8OfupcGCYjxsUPdxsCco7m6tbiYS2g9ckYOZ
 g0Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuRZDVxAT2L3RgrB6ZN5XcCue9umZPvW9zkLatNOM/x/neEtmxjkY86xuXoWaXStqj5F9ddadEPlsw@nongnu.org
X-Gm-Message-State: AOJu0Yxim8anA5YOIAHpiNoEcLtpMCkVp8MeDVxLihJ7VH+wEsZ/lws2
 XZzUMt2jbaEGOAAehYwyezwLYvTZ8AEAgpfHYsL1GDsc4RipZgLYeYCXx6qOpLLYhvo=
X-Gm-Gg: ASbGncsC0BW9fXp66/L9tT/kqgO4hNnxf7FQ+HOudtnJF4S+VF4x4JKPOiXK2cjzYxU
 ZpHhUXZZtWF1MtdAIC7wNfVZscb7EdbarwyY+FcLEKZwr3KjERm+oYZYjtEG8bSrDt0pkkPABL/
 ek54by88BmbdGDmlSqjfhRylu/DMzXO/g4cstwkPuGmrB42TD0he1/PHLZSEqrSXG56BRFq+TXb
 rYoEIZq7Kqk6Pq1nc+biuq6WS/h5Zc2jNu8i35Q1tEY5ZxA/kUy9y8omEFb6avLAqommTb41xYA
 vfhDbc8ikH37ddXOS2Ppar+diP8Us30iHQ6nJmDgrv4HspZ1JB2ycPMSGhPBj+CZudmyrWx2oBA
 LNz5iD79gIJGRXRV0bfk=
X-Google-Smtp-Source: AGHT+IExa3oBUTJfjImb5NrWE4bSLtiZOXzbcLQ8rQm9gyDRuSYu23NsdssUH4GILhUtZRy/05XZ/w==
X-Received: by 2002:a05:6000:18a3:b0:3a4:ef33:e60 with SMTP id
 ffacd0b85a97d-3a51d96a070mr7332163f8f.40.1749140219884; 
 Thu, 05 Jun 2025 09:16:59 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe758besm25154005f8f.51.2025.06.05.09.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 09:16:59 -0700 (PDT)
Message-ID: <ff2a5d50-0908-4736-b664-523b2ed09f30@linaro.org>
Date: Thu, 5 Jun 2025 18:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: avoid cost of -ftrivial-auto-var-init in hot path
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250604191843.399309-1-stefanha@redhat.com>
 <aEFWeZUlqqRvHsJT@redhat.com>
 <42276df1-4267-4038-8685-c7a193259e67@linaro.org>
 <20250605125015.GB417071@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605125015.GB417071@fedora>
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

On 5/6/25 14:50, Stefan Hajnoczi wrote:
> On Thu, Jun 05, 2025 at 01:28:49PM +0200, Philippe Mathieu-Daudé wrote:
>> On 5/6/25 10:34, Daniel P. Berrangé wrote:
>>> On Wed, Jun 04, 2025 at 03:18:43PM -0400, Stefan Hajnoczi wrote:
>>>> Since commit 7ff9ff039380 ("meson: mitigate against use of uninitialize
>>>> stack for exploits") the -ftrivial-auto-var-init=zero compiler option is
>>>> used to zero local variables. While this reduces security risks
>>>> associated with uninitialized stack data, it introduced a measurable
>>>> bottleneck in the virtqueue_split_pop() and virtqueue_packed_pop()
>>>> functions.
>>>>
>>>> These virtqueue functions are in the hot path. They are called for each
>>>> element (request) that is popped from a VIRTIO device's virtqueue. Using
>>>> __attribute__((uninitialized)) on large stack variables in these
>>>> functions improves fio randread bs=4k iodepth=64 performance from 304k
>>>> to 332k IOPS (+9%).
>>>
>>> IIUC, the 'hwaddr addr' variable is 8k in size, and the 'struct iovec iov'
>>> array is 16k in size, so we have 24k on the stack that we're clearing and
>>> then later writing the real value. Makes sense that this would have a
>>> perf impact in a hotpath.
>>>
>>>> This issue was found using perf-top(1). virtqueue_split_pop() was one of
>>>> the top CPU consumers and the "annotate" feature showed that the memory
>>>> zeroing instructions at the beginning of the functions were hot.
>>>
>>> When you say you found it with 'perf-top' was that just discovered by
>>> accident, or was this usage of perf-top in response to users reporting
>>> a performance degradation vs earlier QEMU ?
>>
>> Would it make sense to move these to VirtQueue (since the structure
>> definition is local anyway)?
>>
>> -- >8 --
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce374..b96c6ec603c 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -153,6 +153,12 @@ struct VirtQueue
>>       EventNotifier host_notifier;
>>       bool host_notifier_enabled;
>>       QLIST_ENTRY(VirtQueue) node;
>> +
>> +    /* Only used by virtqueue_pop() */
>> +    struct {
>> +        hwaddr addr[VIRTQUEUE_MAX_SIZE];
>> +        struct iovec iov[VIRTQUEUE_MAX_SIZE];
>> +    } pop;
> 
> This is an alternative. Using g_alloca() is another alternative.

Not a lot of these:

$ git grep -w g_alloca
backends/tpm/tpm_emulator.c:136:        buf = g_alloca(n);
tests/unit/test-char.c:1012:        be = g_alloca(sizeof(CharBackend));

The tpm_emulator.c use could be replaced by g_autofree g_malloc.

> I chose __attribute__((uninitialized)) because it clearly documents the
> reason why these variables need special treatment. In your patch the
> "Only used by virtqueue_pop()" comment isn't enough to explain why these
> variables should be located here. Someone might accidentally move them
> back into virtqueue_pop() functions in the future if they are unaware of
> the reason.

The only safe-net is a better comment.

> I'm happy to change approaches based on the pros/cons. Why do you prefer
> moving the local variables into VirtQueue?

I don't have a particular preference, I'm just wondering why these
vars have to be handled differently than the rest, by introducing
QEMU_UNINITIALIZED.

Anyway, no objection to this patch :)

Regards,

Phil.

