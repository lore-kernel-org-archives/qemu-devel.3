Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A26C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5vE-0007nK-Au; Thu, 06 Feb 2025 12:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5vC-0007mx-W6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:44:15 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5vB-0004xd-2r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:44:14 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso7379675e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863851; x=1739468651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TEZyHg+bj35k2nBBFrqPgo/5xtqVGiO77l1MPPfSoNo=;
 b=n3IQGzUtEy3aaZL5ROnUrVhpPe8fNpTM9yWijt8jrCf1qjwXu+kkmMzA0XKUNEzRgD
 sb0/w0LhiAUpCDvQXVGxZunVxbeexlxuYX12IBM3QjMxlEVh4w4gOxFtlukCxpxiJfZg
 +D9TEhidIb9wLF/Eh3G5SNWHn61dGTgjJhoaK0droPTnAFGqAgP1cNmtRaQr6Vz4Jfq6
 0J7VSXjjsD9QiI/JU2gNXPs6BptKFftFTkmagdzj6lN4/T60Bf1LWibXiuei/QwBp/UD
 Y83ns+WDv+LFQ2TwPoyKOlpycISVN7dVWNkpmlmOkpvZyR7rGd1AIfV8uhf+erEN65VC
 gGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863851; x=1739468651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TEZyHg+bj35k2nBBFrqPgo/5xtqVGiO77l1MPPfSoNo=;
 b=T5+wlCCZqag5D71L7Bn3qRP3DJwNRzyBBLwcAiHE/b74RVffGjAVt/mJmrYr8rlxKa
 2gShd0Nl+26/eq66PzAWa+l97BeLiRIxKYN35RsOm56TgG0jeyI8gjzYqKgNB+CraY0P
 if4XCzN7MN3RtpR0QMS3EHMznZTDwZrrrmIJeXvbWrMlnL8xI6Wc7F++LcCsw3e82zgc
 WcBk8zsZK+pczcDEeTSRpNLmnLrp1SDO7wE2I+VCaHYFUSidbHf+wMtzzYM6MymqAewo
 rawqqGXwQha7LG8o/FDYTVO6Y8ApMYRc7L/u4vUES3LKKDPWNSl21Y3J1nRbD0JkAi7H
 pPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpF2fCEXgL0FZLjL0b+rRes0u91qQGirJyk+GrJ28Q4iw7UVtD6MRXYgJgRNAOdhNyjGJOucv9mjun@nongnu.org
X-Gm-Message-State: AOJu0YyBaoLWfyKYpTliA4d32YE3HoSdIXN4FYmqGzjcDHcxaG/c91Zd
 gsbsJ8oKcBthlrSlkLx4hC3kM5Awb9ewq+Ke0gFrq/AGCilZT+zWFlyDu1QpAMI=
X-Gm-Gg: ASbGnctm5Ko2SwwfGyAkKJBtpPgJNHzhy1/l23vVSariFhGmmRIMyqZ00ybvi571Mnd
 CxGID8kS4Ce7G5EQKNnVT61a6yEj4g9H9IZwciqMIKTmtLf8ih17QdeZCANWvR76tzl69inlOE4
 uXdaa2QJKiFJY6XUfSPKQqqiNjDEDwymPoJctCoZFRyrny7bX1oTM5CeSBx3okdo7gawdjmaOfR
 qkg0u33reulrKAksM9pSaDASqIIt+r+f3hfMqJF/CUefsNFIG6Ge4xQIRQdphWyPhT9jNK8Jeh7
 UG1XRoayZFqio/ziKBp9BLCUbx5ygIb2yPBhOSfzPPwxujcH2Hz1EiBK2uw=
X-Google-Smtp-Source: AGHT+IEmNawCWUy80Kgnx7DUllCsnn/fPm/Hj7cpmj76EavKTXA+5NfdwanjKohiX+yB4z7etOYXLQ==
X-Received: by 2002:a05:600c:3b11:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-43912d3f063mr30219515e9.12.1738863851260; 
 Thu, 06 Feb 2025 09:44:11 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf7dbcsm63160665e9.30.2025.02.06.09.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:44:10 -0800 (PST)
Message-ID: <60340d70-e307-44df-9f4f-fffdb6a440e6@linaro.org>
Date: Thu, 6 Feb 2025 18:44:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
 <CAMo8BfJrzj1rERAXXZ8dfVYjnD744mCdCcNUuB1qeqD45dTUAA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMo8BfJrzj1rERAXXZ8dfVYjnD744mCdCcNUuB1qeqD45dTUAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/2/25 18:34, Max Filippov wrote:
> On Thu, Feb 6, 2025 at 7:04 AM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>>> We would pick an arbitrary endianness of our choosing
>>> I guess. How does this work in physical machines ? Is
>>> the choice of endianess a firmware setting, or a choice
>>> by the vendor when manufacturing in some way ?
>>
>> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
>> (wired to a CPU pin which is sampled once at cold reset).
> 
> This is not exactly the case for xtensa. Each xtensa CPU is either
> big- or little-endian and it's a static property of the CPU
> configuration. On physical machines it's either fixed (e.g. if
> the CPU is a part of an ASIC), or it's a part of a bitstream that
> gets loaded into an FPGA and there may be a selector for one
> of the bitstreams in the onboard FLASH. In either case there's
> normally no board-level switch for the CPU endianness.

Yes, this is what we meant in QEMU terms, "static property".

> Also big- and little-endian instruction encodings are different on
> otherwise identical xtensa CPUs.

This is handled within the CPU decode logic, and doesn't have to
be exposed. IOW, we don't need 2 distinct TCG frontends to decode
the Xtensa ISA.

