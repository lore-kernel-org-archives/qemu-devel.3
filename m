Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD18C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 13:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTOp-0000ql-5K; Fri, 21 Feb 2025 08:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTOd-0000qX-9o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:48:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTOb-0006N8-MK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 08:48:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a331d981so18446255e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740145728; x=1740750528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0z5oWSKfVxhmSb03hWB8QgmUQtezws7qd7xC5KGR8iU=;
 b=fNyHKfXC23E7ukc9IAFe1lCGUWwOiNMIwZdK0ytOR/sz4O5euaYZcsTxugUJSBUAhS
 mRzxzFZYHf4G48HAnxw/ISjeuD+nWk5irvCn9MpB9tSnOoG6FKMc4hE8oBuLkzTC69bg
 yYlEyhIAEhgaJQI97Hw1tpeN/vKASAhABwbxCd6pO41h2mpzmbLr4JAsW70YEHpv2zYL
 3lXGe0aIr0WyD3EsH8TKt68jDr/Jw94LFPGvx5oE5LQ1VJTjxqx8KevIRSCjBv5OYxfx
 x9k9NgOE9u8XsQUFV0C5Ee2kortEBJr2kMSUFO+rJ+oroAk3c+JDZRv+46Ezr1JI8py4
 ZSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740145728; x=1740750528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0z5oWSKfVxhmSb03hWB8QgmUQtezws7qd7xC5KGR8iU=;
 b=akkFpPua+O4Pw0mLAUXQTzbTavhxROHqApqm4GVOcaGHOxzxxOgOJCXYliUdMAxywK
 Bbt3dPcI+GiwYakAvroUg7Lf+7OU4MJHE4aAz6OvQ7ChuPiieKxl5fwKroEYGtP+K28y
 cFipN9wGOJ/TXSnSEuAOSGcx+DKCozogdeOiNRO0w0YNpCJpvPei9DpLUlRMIrZi41vr
 EkhwLFIkc4qvflYh4J22j3DXn2LwqS3jOFC+z9gsJWPbTYlN0g+rBkp071EWaS+aQlAK
 iHUMQeQp9P7FbdmWOVyhGbK9QDeKmW7UpXHFlDXBSUv8YiAPv3xxHdxiysMpAruGG0mJ
 zLiw==
X-Gm-Message-State: AOJu0YyLTcUbeNqbvhZAWwcpKlVRTFhmZqXbNfuOfLturrtQ0v5eMI/N
 kxJPweHT8Y3Qu/Ao7Do76kGI81/dFBKZYilI6d3uX9i1H1wSTeLwM8zP+Tv3Wek=
X-Gm-Gg: ASbGncsgl+7zbDTHH99hicCKJsh4NTNjlsxBXCDvWEoHXx7bh7moRgvO3jDCyXxExcD
 3rHsgmZKnLDkiMLKwOuWLcY2wrDSGoa29cEtzKLXdzq0+yUwJxHi4LMCeqC6ocRGZX3h9rshR4b
 TdE+Pr9h9rS8QU+fWx2ScE5XcKSZDEXUINH1dvlSOXcAw91xORMsky4HpQtiLw88ueYKeJTBEGJ
 8OcD4iMyqj6qMfQpuEekhMI8wAZvpdvitoLk0q/XuiXcayddZaLWsg3G1J9mHWewVIvNuGShu6Y
 /DGfd8PQlpCXKGTfg7mFUQwJwMStwcSA9jd4J2e60IF6PcNoF+NCsKLilgEKK4xBHi9X3A==
X-Google-Smtp-Source: AGHT+IGwkjzvtFC70C8ou8VmpVvGcQX0mPdWR7Xrapwim1+rPQmkyf8AoCinaTVMv7Gy+fBCeQ/XbA==
X-Received: by 2002:a05:600d:5:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-439b04f9d29mr17475405e9.9.1740145728058; 
 Fri, 21 Feb 2025 05:48:48 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f3eaesm17976815e9.24.2025.02.21.05.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 05:48:47 -0800 (PST)
Message-ID: <fa519016-cb6e-424f-91e5-1c64acedc695@linaro.org>
Date: Fri, 21 Feb 2025 14:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <8215abb1-6427-4cf0-8047-4f025e1ac8d5@linaro.org>
 <CAFEAcA98ZTnDywOwOUrv+J2d7aKANPehNFRqAbED3x1USkOGMQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA98ZTnDywOwOUrv+J2d7aKANPehNFRqAbED3x1USkOGMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 21/2/25 14:28, Peter Maydell wrote:
> On Fri, 21 Feb 2025 at 13:05, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 17/2/25 13:50, Peter Maydell wrote:
>>
>>> (1) floatx80 behaviours
>>>
>>> Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
>>> use in the xsrqpxp round-to-80-bit-precision operation, and the
>>> Linux-user NWFPE emulation nominally supports it, but these are
>>> minor.) x86 and m68k disagree about some of the corner cases of
>>> floatx80 where the value has the explicit Integer bit wrongly set.  At
>>> the moment the fpu code defaults to "floatx80 behaves like x86", with
>>> TARGET_M68K ifdefs to get the other option.
>>>
>>> The first six patches in this series remove those ifdefs, replacing
>>> them with a floatx80_behaviour field in float_status which can have
>>> various flags set to select the individual behaviours. The default is
>>> "like x86", which allows us to set these only for m68k and not worry
>>> about the minor "technically makes some use of floatx80" cases.
>>
>>
>>> Peter Maydell (10):
>>>     fpu: Make targets specify floatx80 default Inf at runtime
>>>     target/m68k: Avoid using floatx80_infinity global const
>>>     target/i386: Avoid using floatx80_infinity global const
>>
>> Could you add a preparatory patch passing float_status argument
>> here? This eases the following patch review.
> 
> I could, and in retrospect I agree it would have been a better
> division of patches, but both you and RTH have already reviewed
> patches 4 and 5 in their current form, so is it worth doing now ?

If it isn't too much a burden, I'd prefer to have the extra patches
included. Not for today's review, but for our future readers learning
from the git history (as I'm custom to).

I understand you are waiting RTH's ack on patch #6 to update it and
don't plan to respin. If you agree to split, I suppose it isn't in
your principles to merge a series without posting the final result
on the list. I have the patches locally split so can post as v2 base
if that helps. Otherwise I won't insist, up to your workflow :)

Regards,

Phil.


