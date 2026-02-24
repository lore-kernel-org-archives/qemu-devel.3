Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271BF4BB89
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzaA-00071I-PS; Tue, 24 Feb 2026 16:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuzZz-0006yr-JQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:04:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuzZx-0000KG-QZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:04:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so4242558f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771967064; x=1772571864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qMjodyQtp5g8JHK2ewcX49VHNUjOI0u5d9G0g6iXWpI=;
 b=D3UHhoWvgK0GV9bq5QeZZ2WDvsL+mtwDfhUw5CgDvkUCu070NAFfx22LWvCzd3rVvG
 r8845Z2DkhhEdih80q1T//Z5fD0l5TIcHUv2X9r31Q2XdO8Sr2+h4lN06PSKlKOHYmie
 K20h1rg+ziDSYXaWIkxilJlTJ1s45nDf2m9dIAXkrrtrGIdTwFvWDtaHuwmgNubq5PEx
 eVLCOXQKdyMVZnA35ReI5dHvMu1zp7hMYMsavCp4yJ5TWT22nQXlkMkx9EgB5e8KiPs9
 mmJvjl5+0oN5aTPib5/wiyJGURE+jJyYq5AjMTcyPOZf0KDCrKsiRmzz1Kcv+iZkW9Hm
 wmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771967064; x=1772571864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMjodyQtp5g8JHK2ewcX49VHNUjOI0u5d9G0g6iXWpI=;
 b=M+5fPi4VafAhNSfQcX8AaIxwimpSDoHoHAH7nUfQjWkjWszIDT/437vbeIZ1fOVvAW
 /yyddWgUfo6dlEADbWeaMelWdCdwt2KROYb7th70H4BVV6RAJhMrlK0mYFuJaug2GWPx
 8zgr/0SOfQEVQsLIJjhYWor+maInEIClMN1X6dR3Ojm9XGjA8H3QmKGZcjVkd8AXglsp
 D7fZqko0cjK2DWdw6yMPn59C2N4XtpVKcYRELJA6fjhByQt4a5HojscImT3GTXrrtrTw
 3oznkkLRJGVdir+3Ukuu74BDBZ21yz8luvpf5fIoJC65nly3+sTf7xBHQRm6lEO5C+qC
 SKhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8BBqXuxb1O/Gou+BCE04TnGlLHpjjkSNHoQJew9VPPI1/0u/epe6tfhJN1W0xMyiWOemRZPimlLHe@nongnu.org
X-Gm-Message-State: AOJu0YzpDyHYLNWhOmozhSFFm+cjRmw8YdG206g207JVQCv3m8NG0oij
 oCDLYOhyyI7j3royaOqkw8Iozo2Bw9L0TVU/4b2k/iogeNzBNYs8gpmkvQO9R8TEFgU=
X-Gm-Gg: ATEYQzwMdTZslXH4vz42PjF869VPHVFsf1Pcob6JekjwrE5B0Iw9oNkCTuXRzmvFXwt
 atc8QRHBohIuaamrSdhREEGzXFhZHL7YN0Nk2mxNf5xd600r9PaZkfsEHacoKTJFQmBVsx7MsNI
 M+0LQUy0AtPZZNkwpbRSoGGbkqY4SyNzl/6biEfocWgMI1GyMIhs7Chc7rbYr9LnpDxPjrAcbq8
 LvXLvfXL9C+CQw1/je7ltuIZVHwuRWOCJBfaBFPUykIC0Zt4rjeMI5WiBc5H4IrYfAdDieQLSyc
 mxtfeIof2Vc+6jZE61EhV+rVVVJPvwdy2G5fcL81ikuEFgj6kBFWiUyfjPrci/zLvOscCuRW97M
 spSy6+gdbh3pNe+cBWTTAT1il5OZeTbi/0H2MnQ7UMRaincIJ4a9wozDU63nDpVZoWAuKzmPBN6
 wJ3Qsbda4EpmpfcjsrJhC3SCzwkX54tuY9sCU9sRcyTsbVPtULMLk6ZwZd3x/+eGWMOw==
X-Received: by 2002:a05:6000:18a3:b0:437:673f:e069 with SMTP id
 ffacd0b85a97d-4396f18fb68mr25410492f8f.59.1771967064124; 
 Tue, 24 Feb 2026 13:04:24 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm30001838f8f.17.2026.02.24.13.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 13:04:23 -0800 (PST)
Message-ID: <f94a10c0-0f90-4f5b-9d00-2f235e21d69c@linaro.org>
Date: Tue, 24 Feb 2026 22:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/50] target/ppc: Fix CPUClass::gdb_num_core_regs value
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-8-philmd@linaro.org>
 <3956e2b7-de0b-4eb9-9f89-85ff8b54e55a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3956e2b7-de0b-4eb9-9f89-85ff8b54e55a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/2/26 22:06, Pierrick Bouvier wrote:
> On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
>> Only 70 registers are exposed from GDB XML file (for either
>> 32 / 64-bit variants).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   gdbstub/gdbstub.c     | 2 ++
>>   target/ppc/cpu_init.c | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
> 
> Did you check the assert is not triggered for all other architectures?

Yes.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

