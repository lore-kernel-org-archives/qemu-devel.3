Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C8E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNOQ-0004h1-HT; Thu, 02 Jan 2025 10:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNOM-0004gZ-Nk
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:45:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNOJ-0003ld-Ue
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:45:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283d48so83551375e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735832742; x=1736437542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0iKHpbk6qBGova3yIEiu/n5yntrZm075ycMLgR7tJM=;
 b=T/ijbWFTSq0pmjuVWVWxosC/n52f/xnQIWw+DDtZSAm7MxXVxifKoTXL7hOSWFMJwo
 UUwBQUmiDfntwah3RXr7HQmWiu2+JCEXybJNZcefqav1LkPIDUOVMsFGgAeQGl+9OlR6
 +G3f6RhOhJEzOO1iZ499Na2vkGEy9lPsCKMxVcGTMlOuOEVzSt7ViHinfzu/5xTWwzk9
 5PLH4B0ebzyhzDC2BUja/JdO5zTsYARWCH9EnlHX1bW4Twh7ixc45uVxpI0vwAqNn1nQ
 G2abFMWLg8AiiGr269dUW1AjIxM1Kka+LYdoZ0l66IP9172AAp/dB1f2mrm77KDxhVdR
 cZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735832742; x=1736437542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0iKHpbk6qBGova3yIEiu/n5yntrZm075ycMLgR7tJM=;
 b=EcJ0mtCH5pfwbMjx17lGHaVdg+Q2CW6lnQ5Y0aX62/iqY6mrWe9I6OsT4pxfMOvpUm
 fFhGQeexk14VhorjfTX/tzDjcYHN6Q5PbHvV5mEiz1bLgLgPnCAojSrCmrfemdcy/vfJ
 bSEE81CVCgxbqeFl8ooGrKYbcPpigNpfUYtbZaaULEtcETmUpiuqkjat9SRix8/Syexr
 WwOFCuMyiWiVl7+S/rUlUiNA4SqR7jTb4ggjWtK2aqyWAEBZTK59vyUTgk8vq/x6PjqE
 7v2U3Gd2mxtQgtAyJj1y2utdlH0hmbPP8IxE/A+Tbmycf7nx2WmGpgBx3HKMQIJPZJZa
 2DpA==
X-Gm-Message-State: AOJu0YyR2uvuR3OkiyRsjdxF2s1JXKS1u5i78hDOF0mD+UGt/YyWVJP3
 pipAMRmCtNxdG6dJDgcCpUeWH+t08sQzu9wejNdHb/l4HG8srOr36rvcTEK93Kg=
X-Gm-Gg: ASbGncsXPZh6fNQLrDj/05/uA4psoo4tdVxk9oU8I/P4xLvvCuWZiHsRDe585fUagIT
 VyEWQnEOoHVWsRsSVBeVUQeukcsKZFXdqMqRRQSCOIBz0c9q3NeFIezrTHKDDa/I8T6PMfE04Sb
 55rYERZeOeKpfTXmu68MgbGj7+VnlIGV/7KfKx7LQBa9tr2tkfnJCwb8I/p8lFBclQH63bfHWWn
 l5cUkhc62x/9P5MAfy0H8jIcgIDidMpHtWp8pZXoaj7lRAId6ACAfZp5JAGSfRzgWCvAm5+u3DD
 mARjM/M01h+gVcZlDTq8Dr7d
X-Google-Smtp-Source: AGHT+IFSdiP0ZnvrN/R6WsQYtbw755StXi81jfxmL3mBMtibibjXfw6ENS4t4n6OOaFErEjOKKlWvw==
X-Received: by 2002:a05:600c:3ca1:b0:434:a350:207c with SMTP id
 5b1f17b1804b1-43668b5e22fmr353247235e9.23.1735832741599; 
 Thu, 02 Jan 2025 07:45:41 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea387sm460632015e9.6.2025.01.02.07.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:45:41 -0800 (PST)
Message-ID: <cbec584e-64bb-49c3-a4d2-27f321514e11@linaro.org>
Date: Thu, 2 Jan 2025 16:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] hw/char/pl011: Check if receiver is enabled
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-11-philmd@linaro.org>
 <CAFEAcA-ibEzUWFCxA3iQLUoHwZeGnD5kM6c4Ni3BbgaoAs1gKA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-ibEzUWFCxA3iQLUoHwZeGnD5kM6c4Ni3BbgaoAs1gKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Peter,

On 29/7/24 17:51, Peter Maydell wrote:
> On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Do not receive characters when UART or receiver are disabled.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/char/pl011.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>> index c76283dccf..0ce91c13d3 100644
>> --- a/hw/char/pl011.c
>> +++ b/hw/char/pl011.c
>> @@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
>>   #define CR_OUT1     (1 << 12)
>>   #define CR_RTS      (1 << 11)
>>   #define CR_DTR      (1 << 10)
>> +#define CR_RXE      (1 << 9)
>>   #define CR_TXE      (1 << 8)
>>   #define CR_LBE      (1 << 7)
>>   #define CR_UARTEN   (1 << 0)
>> @@ -481,9 +482,11 @@ static void pl011_write(void *opaque, hwaddr offset,
>>   static int pl011_can_receive(void *opaque)
>>   {
>>       PL011State *s = (PL011State *)opaque;
>> -    int r;
>> +    int r = 0;
>>
>> -    r = s->read_count < pl011_get_fifo_depth(s);
>> +    if ((s->cr & CR_UARTEN) && (s->cr & CR_RXE)) {
>> +        r = s->read_count < pl011_get_fifo_depth(s);
>> +    }
>>       trace_pl011_can_receive(s->lcr, s->read_count, r);
>>       return r;
> 
> I have a vague recollection of a previous conversation
> where we discussed whether tightening up the UART-enable
> checks would break existing only-tested-on-QEMU baremetal
> simple example code. But I can't find it in my email
> archive -- do you remember a discussion about this or
> am I misremembering?

The previous conversation is:
https://lore.kernel.org/qemu-devel/CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com/

I understood 'my first assembly "Hello, World" program' has to keep
working, which only uses the TX channel; and the boot-serial-qtest
is fixed in a previous patch. Now I get you were thinking of a wider
baremetal example code. I'll convert to GUEST_ERROR log level,
similar to the TX path, since it is still relevant for developers
who plan to run their guest code on real hardware.

Regards,

Phil.

