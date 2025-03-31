Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C1C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzODa-0000aw-Na; Mon, 31 Mar 2025 19:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzODY-0000a8-JI
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:06:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzODV-00063p-HC
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:06:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c14016868so1707243f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743462412; x=1744067212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x3LjxVsqmmczyUtTPuboJvEOPPwDsRbo9Bic3ke0D94=;
 b=UZj1BDQ6KypS/NDRjj09FaIqItv20bzw2OF9zECZI6375vbAKpH2tnRjHORiYW9BaT
 1GA2z6lF6H1r4r9jzJ4gsGOkqYQ9j+v5DZFwxad7V8SCEvBVcZh6sp6hdWVxF5ugTtNJ
 P+7mzdaHng7Bp2NNy8nEhzTSb+w19KA86ZcIGe9loSYBNb+jhrfGv70LQU2t2ufFFj7s
 vsAJL7Dn/u2Oy4RwsReQVlMs53ej2SdT8Mv+7UzmY5mj9UaRNC9uhPHDYk7hEaaxHZzs
 hhBQaaxAhsp6k29DQvFv65lhKHsq3thqinI+Mzm5LqzjE6pXYqbtWB599M0uebl88ddR
 GOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462412; x=1744067212;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3LjxVsqmmczyUtTPuboJvEOPPwDsRbo9Bic3ke0D94=;
 b=RNSPePQQPR5x69XIiaPL652V1hForb2EA3czs74QUrotg8C3Bvb92ldeJE2RRxqcY9
 ptit1EK8Y3pfXdq1a9Xr/G2r6rPhq/wugU7vVmQ6Odd0oADdNR+D1V4ufxmd7bhu9wB1
 kQ+IKj7QEOIivitjwpY9SZyMvpt2dr/PeKF4tKPkBUzmRiZrP2XLoceWXsqi1TMrmaDZ
 C3pPQE9MSy6GT/0pPhzRQDUZMEg2XqpWVC14A9IQYDFBrmxIlkoRH1Rd9vsK/ujKMiud
 /Jdr56jxZIITDeZbmYrDPbUrahGt2iPzWlCFxiZ9TTv2bkDC/khINRdrWeL3tAAxNpd3
 I3mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzAFjUjgaX3Jh+QFhLzqlXFNBxK+rnHtQ0bWJmB7IonJlrjL6Sj6Ou4MgxWBGMfLchFo/tsGCX7F9n@nongnu.org
X-Gm-Message-State: AOJu0YyKh0AYbDMe/frkjE37IZVtvlN+tIE8LUA5flaDjcoVd+OJGSav
 SCOvh2GRsujJhg5c76VheWZuYIr2JUx3Yq2DIu12rnLtzDbZv8DeIxR99P50FeM=
X-Gm-Gg: ASbGnct9fYvPbpgdBKH3SFAa8qYT005dfyNvYAk/v+TrcaVxoZc1EB4q3aEelLHddUC
 WPTiQxrbOLh6ExLea9HRdW3lwiorkN8rwMy7jI08IWU2kVYc3GxIi+zB6QDvo7MCLWrWrmsw1/V
 VesCytA2qGqBIO4hZi7inpzdRv633y1lCFTCEds0wR0rQzkZOjIncm4sKELlknR9JFEOtxVuN0C
 4H43g7TBHyKB94ikQW4czhStbTycp9jxTQo6orRWUTfS/jAodwDSO/QBJkHfXs7pYVMqSImyfqW
 QLdH5RPYP0GHwiPlmSk5vbwr4RUgJbEMPS4iLWCItO8JqtwCBMr6WFd7w+2EWA2dHHqPUk1wjSq
 9+847Ic/L3Hg+
X-Google-Smtp-Source: AGHT+IHO4HqN1VgdloqzQuVErg5Hl2pWDyfA88eb8br9ArjjCL0kszLH8EqiAIXMqV5E+iTAuq27OQ==
X-Received: by 2002:a5d:47af:0:b0:391:4bf2:6f0d with SMTP id
 ffacd0b85a97d-39c1211d462mr8426715f8f.52.1743462411895; 
 Mon, 31 Mar 2025 16:06:51 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41a9sm12764927f8f.90.2025.03.31.16.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 16:06:50 -0700 (PDT)
Message-ID: <02a9f971-34fb-4922-8644-146a93df57f8@linaro.org>
Date: Tue, 1 Apr 2025 01:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/aspeed: Correct minimum access size for all models
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
 <0b6fc8e8-e3a8-42a7-a38e-1008bac0ab42@linaro.org>
Content-Language: en-US
In-Reply-To: <0b6fc8e8-e3a8-42a7-a38e-1008bac0ab42@linaro.org>
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

On 1/4/25 00:49, Philippe Mathieu-Daudé wrote:
> Hi Joel,
> 
> On 19/11/24 11:29, Peter Maydell wrote:
>> On Tue, 19 Nov 2024 at 02:53, Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> On Mon, 18 Nov 2024 at 20:40, Peter Maydell 
>>> <peter.maydell@linaro.org> wrote:
>>>> Have you reviewed all the device read/write function
>>>> implementations for these devices to check whether
>>>> (a) changing the .valid value does the right thing, or
>>>
>>> I read the implementation of the read/write memory ops and I believe
>>> it does the right thing. We want devices to accept reads that are of
>>> any size, instead of returning an error.
>>>
>>>> (b) whether there are cases where we should instead
>>>> be updating the implementation and setting the .impl
>>>> min access size ?
>>>
>>> Reading the documentation for impl vs valid, we definitely want to set
>>> valid to 1. There should be no machine check when performing byte
>>> reads.
>>>
>>> I don't think we want to change .impl.min from the default of 1.
>>>
>>> I'm not sure if I've missed something that you're trying to point out.
>>> Are there gotchas about setting valid.min=1 that I should know about?
>>
>> The "gotcha" is that the memory system's implementation of the
>> size 1 and 2 reads when .impl.min is 4 and .valid.min is 1
>> (as for instance with aspeed_apb2opb_ops after this patch)
>> is "read 4 bytes, return the relevant portion"
>> and the implementation of size 1 and 2 writes is "pad the
>> small value with zeroes at either end appropriately so it is
>> 4 bytes and write that". That is often the right thing for
>> the required behaviour of the device registers, but it is
>> also quite common that it is the wrong behaviour. For instance
>> for some devices the write of a byte is supposed to only modify
>> that byte, and leave the other bytes of a 4-byte register alone.
>> Or if the device has bit-clears-on-read behaviour for a register
>> then the default handling will incorrectly do that for bits
>> that the guest didn't actually read.
>>
>> Conversely if the device leaves the .impl.min at its default 1
>> and moves .valid.min from 4 to 1 (as with eg ftgmac100_ops)
>> the device will now be called for byte reads and writes at any
>> address in its range. If a write to, say, byte 3 of a 32-bit
>> register is supposed to update bits [31:24], that won't happen
>> unless the write function is changed (usually if there's a switch
>> on offset the write to something that's not at a multiple-of-4
>> will end up in the default "log an error" code path).
>>
>> What this adds up to is that it's a bit misleading to have
>> a single patch which changes the minimum access size for lots
>> of devices at once, because for each device you need to look
>> at QEMU's implementation of the read and write functions
>> together with the spec of the device, and confirm that the
>> right way to implement "byte writes are supported" for this
>> particular device is to change .valid.min, and that you don't
>> also need to make changes to the read or write function code
>> at the same time or adjust .impl.min. Putting them all in one
>> patch with no discussion in the commit message of the device
>> behaviour and implementation was just a bit of a yellow flag
>> to me that maybe this complexity wasn't considered.
>>
>> If we get this wrong for one of these devices, it's also likely
>> to be rather easier to bisect the problem if bisection
>> can track it down to "we made this change to aspeed_timer"
>> rather than "we made this change to a dozen devices all at once".
> 
> Could you respin splitting 1 device per patch?

I addressed Peter's concerns for the SCU only so we can get the
issue resolved for the next release:
https://lore.kernel.org/qemu-devel/20250331230444.88295-1-philmd@linaro.org/

