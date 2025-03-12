Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A38C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsN4P-0005E0-ER; Wed, 12 Mar 2025 10:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsN4N-0005Dc-45
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:28:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsN4L-0003NJ-0z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:28:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso3704740f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789702; x=1742394502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGpycwrRAC/F46TLl7I48eG5kuRnckVPlcyYT3nYZvQ=;
 b=DRMLQ4WG+RLgSIR//J787Mhb6cndZBxo3rYA25y2MHcb73W2fNM6BOHu4wG7TU6Q0n
 fOQG2yDD/A0iShFwvRx0wAoKINlIFYl7gfecKUsROn3KOsIr9+RnC0oMkxgowcBLgYok
 DsnRPRswVaXMcKVXuO1eXeILXj/FT916Dfk93vHT2IckyCRUAK/UumqwnGcoL6LPFwDZ
 pmK9NFh8z4t8KdYlqJOy620kd0/b4eZawccWAT0D2IGLnUmH8crOet0LcqsIA7uDn4d8
 ILXZRcfdQ6V+OXKnxRVxqhUNizCylQOSRxlSU4Jdb5Ncg64mIoWSGDtaodPKjKpyHngA
 Golg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789702; x=1742394502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGpycwrRAC/F46TLl7I48eG5kuRnckVPlcyYT3nYZvQ=;
 b=BrZH7GmW53uSWyUNNYqz/QfdrKPK9J9Wo39cBwkjCwgx6BeqygdvzxrTpP19njIv1o
 xhQt5JGIED5+aUXSW0NB9+VvSa500Lj4ZaQTWGUbj/2RopiyoOUR9r5F+VPmt0IxBIQm
 0oqFCzUxKmUw2mrBoUeNXW0srDSktPqvy7Vgw9bP3r4ogo1uahJGFv9SFZFr0+Mpu5vQ
 XXXG7IwtgRusIwYg2oxEkYp8fwBQmdGNPr4l1TKOLg8sdz60Sb83EpgmdyzCAkjuwt1z
 gHEDV8TYGq3P+J8q8YK6/AseLjt4f5IAokPJ0dnjldvoLQFU8JKCX3isC2r+T3FYMDZ0
 ARrQ==
X-Gm-Message-State: AOJu0YzSXnxkFEV8pyeSdVypBNTMwim8PV02/es+zzDdBUrCNjIF6EZ4
 7YH3exfl85M+AyrprBP9i7n7YMCDtVJ2mUpO8G2F8vNTuQvd5Fs+6KxyFYpr/gw=
X-Gm-Gg: ASbGncuiGJCALm6FQ9bOD8OlyvDKTYkbusDvF0snYEO/H57Bktx0EUSuMjZc25ejLKM
 HfW+lvrty8bomWE4mzzuc+pl9piqcfxwP8MHJ4cz147HBIyGkH43oy4MCtbm0ET1j9fXyqGht/D
 G3o7c6zw/mC05LUdE8mHugGw6nXLIW+RGoMKoQj6MLvBqKIC/cCrRMtl3ZPnftmJ9uNk5bNaMv+
 YuRRY+Tn2z3RZOMsqxtN/TdAaYlUE7AEMMY31I9tIP05Ar5FaBpLUS1Or1+DNuYi/UF0VLJqkBd
 LWuOJIpIDMzSZjtFASYCx7DQ4UN1WYXIk4Wiv2yhi8rFvyYdJznt4bA0M9y7Hm976bC5gSv1iIK
 WKwB6KbrS
X-Google-Smtp-Source: AGHT+IFfM6R+tPDrr5xOj1XDq7WeyrPsdIsMgSPWrZh4P1nBtojMzTju/R/xiItDo7G/kNCoPiY2cw==
X-Received: by 2002:a5d:6d8a:0:b0:390:e655:f998 with SMTP id
 ffacd0b85a97d-39132d6f17bmr17511103f8f.26.1741789700882; 
 Wed, 12 Mar 2025 07:28:20 -0700 (PDT)
Received: from [10.223.46.213] (116.164.185.81.rev.sfr.net. [81.185.164.116])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm21029040f8f.26.2025.03.12.07.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 07:28:20 -0700 (PDT)
Message-ID: <4aa4c71d-fe82-423b-80a5-886a7446025d@linaro.org>
Date: Wed, 12 Mar 2025 15:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "hw/char/pl011: Warn when using disabled receiver"
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250311153717.206129-1-pbonzini@redhat.com>
 <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
 <CAFEAcA_+v5ntUx5ByXQP0hRo5AHiEbDUxkdUW2+FGNURZFsqNg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_+v5ntUx5ByXQP0hRo5AHiEbDUxkdUW2+FGNURZFsqNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 12/3/25 14:43, Peter Maydell wrote:
> On Wed, 12 Mar 2025 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 11 Mar 2025 at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> The guest does not control whether characters are sent on the UART.
>>> Sending them before the guest happens to boot will now result in a
>>> "guest error" log entry that is only because of timing, even if the
>>> guest _would_ later setup the receiver correctly.
>>>
>>> This reverts commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df, apart
>>> from adding the comment.
>>>
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   hw/char/pl011.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>>> index 23a9db8c57c..efca8baecd7 100644
>>> --- a/hw/char/pl011.c
>>> +++ b/hw/char/pl011.c
>>> @@ -85,7 +85,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
>>>   #define CR_OUT1     (1 << 12)
>>>   #define CR_RTS      (1 << 11)
>>>   #define CR_DTR      (1 << 10)
>>> -#define CR_RXE      (1 << 9)
>>>   #define CR_TXE      (1 << 8)
>>>   #define CR_LBE      (1 << 7)
>>>   #define CR_UARTEN   (1 << 0)
>>> @@ -490,16 +489,9 @@ static int pl011_can_receive(void *opaque)
>>>       unsigned fifo_depth = pl011_get_fifo_depth(s);
>>>       unsigned fifo_available = fifo_depth - s->read_count;
>>>
>>> -    if (!(s->cr & CR_UARTEN)) {
>>> -        qemu_log_mask(LOG_GUEST_ERROR,
>>> -                      "PL011 receiving data on disabled UART\n");
>>> -    }
>>> -    if (!(s->cr & CR_RXE)) {
>>> -        qemu_log_mask(LOG_GUEST_ERROR,
>>> -                      "PL011 receiving data on disabled RX UART\n");
>>> -    }
>>> +    /* Should check enable and return 0? */
>>
>> We decided deliberately not to check the enable and return 0
>> here, as described in the commit message of abf2b6a028670bd:
>> we think there's too likely to be existing works-on-QEMU code
>> out there that doesn't ever set the enable bits.
>>
>> Otherwise, yes, agreed with the revert.
> 
> Oh, and I just realized that the right place to diagnose
> "guest didn't enable the UART" would be when it reads/writes
> the data register while the enable bits are clear.

Doh, sorry. I wonder how I ended putting this code here... Since I
rebased this a lot, maybe something went wrong. Anyway, I'll post
a fix.

Regards,

Phil.

