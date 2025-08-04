Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32878C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4JG-0000Gz-0z; Mon, 04 Aug 2025 19:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj4J5-0000C4-37
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:09:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj4J1-0003iJ-PS
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:09:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so3777503f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348960; x=1754953760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c1K9iBMZXP91PY5sU1sBfP7w4ptpPSKPD1a8qDLuAHI=;
 b=a1+hdM2zXwNhc/6UwtYu2aPxPXqZDMwfgTlLB3RPQKzjX/+ht5Z2fYDxxGR+zeo3Vd
 fPbUrDBJdVlxgCmCKrwdacUZfVA6HUU8d4qMjWzjEgnq+HEC6J1dCeT3FmTIaZDhZr4I
 N3Si4kCIIJkAvGS+VfftLQ0MbszJwdXl0Fe22vAu/JjBS49jCG8VVgcWVeUcqyxXSYPn
 zWHbHm4I78opDz12nB8GxXAXd9uGgNLQewbCjeFsuSj7M+BtgtYXF9wwQtjvsetU/Zn5
 aCy2t8xlgStbN6ZmYqeCH96omKyIYkNhfw5DzWSooUjB+bWcq8IfhbofnI0aIakdSxW6
 ApjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348960; x=1754953760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c1K9iBMZXP91PY5sU1sBfP7w4ptpPSKPD1a8qDLuAHI=;
 b=QUuszU6U7Aik1LURAYextJhWR8DshhaZOgKWOvMkQc1rcrsZhvD29GZj+beNXHdQjr
 vS52DlpAibPc5aEuAgwbmfrp4JTwRRvmVlSMlu3u/vNlFA14ANzDER23yBF9xARv2T6M
 9rKs5McvwOJKTRxwWnumu5aPPlIj2AmQGSG2mcAl5lkpMhdPjP4pSi28frPo/9ABJ1kb
 PrRt7TO7Haulz3yO3aLyvnkF3T7hrNSvFUQDOSzk3P185rIUwu2x0CZ1QKtWJGYkGzV8
 djTJlGdgAnyfkSMROY64bYoJYevkBbmPKvJH+u//dyQaTH67aJ/UN9bE8fGTr+rapk7d
 ADkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwznwfyAQIh9KhRWVBOdY1ykee9FMmFKzViBA2iznraXjcxiRrjkBCc0v9zOKrHFh++5gPeCHYTHEA@nongnu.org
X-Gm-Message-State: AOJu0Yz79jVvPyAMzscc3SY3R2BtC3jthn4ltyR39oVHbASAeSEKBXgq
 mp6K/JawWQhpXfSBL2fBGiS9YyRDOuTiWI/nbrKRm2JYKRbSRCHTGGzs3RzG6tppOWb/GtfKTZX
 hArYA
X-Gm-Gg: ASbGncu6g7N1SpNGoi3n6ZycUckuwm2sGbh4jHB5IdvBkI4uHTVRaCw10bZwz6p55OP
 m+WEK19XIi0UcDPJa2zY9CVXInlLig5lCJWCPWcavp6q7KzobEDGClkqdlD0GqSTL0eNNAjERgM
 jqbB4QyX7tdH8c4FUxSkMpOMA531UphqWXbU8jd2O/p6ZHjwv6k3JQvXCF930pYTC/+fGkirFIh
 bc1rtH2Xe3AZRNfmhaMVvAGhYAq0Mdq3FFzXdcy+pR8GbwVnZoYwB3BvMIVDgu0dergV04hI6Op
 e1a5CMNPjG/v6Ef3aY3994MD0Ht/Xa3d5/HAMLA7PF0ZNLkVDJe/hN2cpHwoi9T+UxIa65fQAP/
 zCE55OVxqBqbfI/RojlTQ3TZIzc48ZdnLghBFY0ho937ONoMeINm0o7UhXWIoDIVy9A==
X-Google-Smtp-Source: AGHT+IHp7DsdaveunOjZvPatbWu2W7r+BipeKe192COg14up+tLeaIxh5NuqPvkWLdA9orGvu9Bw0Q==
X-Received: by 2002:a5d:64ec:0:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b8d94bbb3amr8113027f8f.31.1754348960473; 
 Mon, 04 Aug 2025 16:09:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfeaesm239661785e9.16.2025.08.04.16.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 16:09:20 -0700 (PDT)
Message-ID: <aca6e886-88a1-44f3-b6b0-b42f2d0029bc@linaro.org>
Date: Tue, 5 Aug 2025 01:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250804133406.17456-1-philmd@linaro.org>
 <0a546b9c-7c87-4502-a0ca-ba79eb988093@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0a546b9c-7c87-4502-a0ca-ba79eb988093@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/8/25 01:03, Richard Henderson wrote:
> On 8/4/25 23:33, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (11):
>>    hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata()
>>    hw/sd/sdcard: Factor sd_response_size() out
>>    hw/sd/sdbus: Provide buffer size to sdbus_do_command()
>>    hw/sd/sdcard: Fill SPI response bits in card code
>>    hw/sd/sdcard: Implement SPI R2 return value
>>    hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode
>>    hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states
>>    hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
>>    hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID
>>    hw/sd/sdcard: RemoveSDState::mode field
>>    tests/functional: Test SD cards in SPI mode (using sifive_u machine)
> 
> I've reached the limit of what I can review simply by looking at the 
> code, rather than absorb the specs.  The rest looks plausible, and 
> doesn't twig the Spidey sense that something icky is going on, so
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

Thanks a lot!

