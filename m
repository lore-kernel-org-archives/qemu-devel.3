Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087DAC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNwx-0002gA-2O; Mon, 31 Mar 2025 18:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNww-0002fn-4e
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:49:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNwu-0003WY-5h
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:49:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso22420475e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743461382; x=1744066182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIgofOQ16FfHrqCR+n2/TXJ8ZAXHvNpoy3xWYKJ8Uns=;
 b=htahq61ZL0zMXNQ+GO5q6NClgw4EOpC22v+IT+QOtkRvbx1YB09r0ie5zpN2HST81J
 QNOWtuJypyXNLcbRFi9719xf8CXqr3RYOQzQl1CeYIvdNg1dtA2Zn27isPw1RecjpT+9
 5PrKTrXa//Yj2yaUZA21c2BKs4z+b3MQOmkcEESwD0Py5YX1hpQ3VNWxfBLdng97BQA5
 YceW8nZ/Pu1B4gMitSjH8cyLKJY4Fw/tVT2LNLcQ1rypohBwZpaqdibmoR0xtkGZKxlh
 TKY6Q3i8/Lfp4+x1dm+HcCQXuzDkJk3qu0QVUFyIgIPUdGSQuUKjv8cLZqrdN3lS5/s6
 hxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743461382; x=1744066182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dIgofOQ16FfHrqCR+n2/TXJ8ZAXHvNpoy3xWYKJ8Uns=;
 b=d4GpWBByfLr+bcJ+f0Np4RY6SkchUbPqxY1NHltFcJftgmKCebpvr/HNori91dSsNk
 RbTCk7OfWEbwMEeg5iCZsl+3SwN95qGNQB6ZpStUqdEkza0lznbGGnBNeG53siYC+6Br
 IHgQGemF9RXV8WTYe/XLo4dSnSdm4JicoV+EXZip3h+uhbJyQ2QIeNRkNHl09s3iNPH1
 a8vbWMyZdH/TwyUF6kJcBWplSX2xdXmJjtv67Jfio3Uah/77krp//lzupEyGsrk4xarz
 rmXF/Rp5wdxSha9gQfMyVULSkAiZQKsUG8ji6uTsVCG3HwxEEQL3Gx5gAhFyeAKer8Cn
 z9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWad7WA+adpDPPbGqipJCxS7rd1K+5rPcLmNyikBR0AJfDMA6babX33LgU/XwowX4JzQbyGxgIYAyaK@nongnu.org
X-Gm-Message-State: AOJu0YxoF0RRbQ9XiLFkSbuiDuTPe4tlOy4AgOEYM1qItOInpfgdLO5S
 FoK3qzkEsR48k2YkY4b2kx1pLHpzKpUWG64adMvK5k9Qu8ud2pOoZanW7NgiknI=
X-Gm-Gg: ASbGncuCONik1IKW32axISH+a8a7ShWG4w3OOTL6jqF8AsK/7+i9lt4lJk3fhn8M07S
 +Wq9wXnngciIg+aRo909D1TmeHitHMr+a793aWaGTxdgw5c1bTHikBD60v0SiQlE+KHoO5vGs5W
 o+9TAApLie1osZASEnWH5pbWj/zCMbJOkgQSVrsmR+GYMY12OKU9lORjb0h5fZaOnKXMA/IETTI
 1nRHz0d5f6t4CyRb+MZo8Sv39HhJmD34j/SQnzDIgqjRZ/J4XBPRSfQeP6P2wTJjxUpcVoX+Gaw
 d/W6JXjOJutIix27eK1/c8LbWTlTga0j9ukIRtw4taA0kYwzQsxm6NQKKt3mZ2YM3cEkSgmia3n
 WQh7DzBgxQOkTUWVxSJCwfCY=
X-Google-Smtp-Source: AGHT+IENDPrhSDfLKqzeRw9DXXqKY8mot5Mqinpy0x8EmBrUPBYtm34RbJAcXX7gNePYesocMEOY2g==
X-Received: by 2002:a05:600c:468c:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-43db61b52e5mr111621165e9.2.1743461381918; 
 Mon, 31 Mar 2025 15:49:41 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4239sm12614094f8f.94.2025.03.31.15.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:49:41 -0700 (PDT)
Message-ID: <0b6fc8e8-e3a8-42a7-a38e-1008bac0ab42@linaro.org>
Date: Tue, 1 Apr 2025 00:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/aspeed: Correct minimum access size for all models
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 BMC-SW@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241118021820.4928-1-joel@jms.id.au>
 <CAFEAcA9tPhbjnJ6XjMcZq6iWS4i1BdrTB+=391L5UgaVSMkCLQ@mail.gmail.com>
 <CACPK8XeFP+fmws+tcG-qgz1WXyKAtMicpfcgDG-pd_jp8PLXwQ@mail.gmail.com>
 <CAFEAcA_+YvS7zTuosAxK8zMgBTD01SRheAat7WbHsfLHCCFGcA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_+YvS7zTuosAxK8zMgBTD01SRheAat7WbHsfLHCCFGcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Joel,

On 19/11/24 11:29, Peter Maydell wrote:
> On Tue, 19 Nov 2024 at 02:53, Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Mon, 18 Nov 2024 at 20:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Have you reviewed all the device read/write function
>>> implementations for these devices to check whether
>>> (a) changing the .valid value does the right thing, or
>>
>> I read the implementation of the read/write memory ops and I believe
>> it does the right thing. We want devices to accept reads that are of
>> any size, instead of returning an error.
>>
>>> (b) whether there are cases where we should instead
>>> be updating the implementation and setting the .impl
>>> min access size ?
>>
>> Reading the documentation for impl vs valid, we definitely want to set
>> valid to 1. There should be no machine check when performing byte
>> reads.
>>
>> I don't think we want to change .impl.min from the default of 1.
>>
>> I'm not sure if I've missed something that you're trying to point out.
>> Are there gotchas about setting valid.min=1 that I should know about?
> 
> The "gotcha" is that the memory system's implementation of the
> size 1 and 2 reads when .impl.min is 4 and .valid.min is 1
> (as for instance with aspeed_apb2opb_ops after this patch)
> is "read 4 bytes, return the relevant portion"
> and the implementation of size 1 and 2 writes is "pad the
> small value with zeroes at either end appropriately so it is
> 4 bytes and write that". That is often the right thing for
> the required behaviour of the device registers, but it is
> also quite common that it is the wrong behaviour. For instance
> for some devices the write of a byte is supposed to only modify
> that byte, and leave the other bytes of a 4-byte register alone.
> Or if the device has bit-clears-on-read behaviour for a register
> then the default handling will incorrectly do that for bits
> that the guest didn't actually read.
> 
> Conversely if the device leaves the .impl.min at its default 1
> and moves .valid.min from 4 to 1 (as with eg ftgmac100_ops)
> the device will now be called for byte reads and writes at any
> address in its range. If a write to, say, byte 3 of a 32-bit
> register is supposed to update bits [31:24], that won't happen
> unless the write function is changed (usually if there's a switch
> on offset the write to something that's not at a multiple-of-4
> will end up in the default "log an error" code path).
> 
> What this adds up to is that it's a bit misleading to have
> a single patch which changes the minimum access size for lots
> of devices at once, because for each device you need to look
> at QEMU's implementation of the read and write functions
> together with the spec of the device, and confirm that the
> right way to implement "byte writes are supported" for this
> particular device is to change .valid.min, and that you don't
> also need to make changes to the read or write function code
> at the same time or adjust .impl.min. Putting them all in one
> patch with no discussion in the commit message of the device
> behaviour and implementation was just a bit of a yellow flag
> to me that maybe this complexity wasn't considered.
> 
> If we get this wrong for one of these devices, it's also likely
> to be rather easier to bisect the problem if bisection
> can track it down to "we made this change to aspeed_timer"
> rather than "we made this change to a dozen devices all at once".

Could you respin splitting 1 device per patch?

