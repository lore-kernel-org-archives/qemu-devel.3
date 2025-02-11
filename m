Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF040C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 18:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thvOC-00023s-9n; Tue, 11 Feb 2025 13:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvO9-00023a-Ok
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:53:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thvO4-0006um-Kg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 13:53:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394820123dso14938215e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739300014; x=1739904814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+SIRFcyVeI9ut2zAnOAqY6WGITTdtoS+RIGx/Iwc3kQ=;
 b=Iz95mBYQz64/MNvTbnMXiQ46qHjmMAkk45zfoPnKFroqhMf/sx+S+y3pROLZB0nKZj
 Yb44uqHcLqG3P+64OAsnZT+wLGtJUPctE9dv28O32Hn82iM2k2K4WWad7Nsm7Tkxgist
 4ULngDbgDY3Ed7P6+lTNVgBZiG/LQyCs971jm6fNMXDC+q5pnJkxwbF7dWuBfzA843fh
 TVudIV4kL8dVkKl3w0DdymlyJFUL7fb9Dbk8bDXlgBHn0/2/sAoi5sjId3tnxQ1g2vug
 CY7PbYsOYSl/NRCBbwDGm/STdQ/G0arDy5qsWf/H1eiFfArcqcb7dIIQLCr9+MeJHsfP
 y5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739300014; x=1739904814;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+SIRFcyVeI9ut2zAnOAqY6WGITTdtoS+RIGx/Iwc3kQ=;
 b=pWTQmGFOuqA6a1uUA5aFvmObspqJ9LkLsA/fZPV/SbuBMjX/Yw2byvXQP6bKJI5en8
 367n13Y+etxNViBrPmR7ieXhWw54r3o3gkkGexS5EqBHvXQeZNvqII9tg/ui7DgrPMSu
 DZnckZoNVV1rS+CTPfd3ZQCzKUIDUuHD14jAs/Lxm2zPGTjn+bTQpBnijH4wKHSb6zSr
 JzKnzpAS0rbM2SEmcYnJCVV0GDckRQa0IyhE9vxJC6PKPMHfmf5+7r7SZzZBnJe0zJUs
 ghYV4VCEv4fVoQ2WF/lEzjc7uN1Ut2uE94z2giysgerlWDyVpN89dMeWRf6xo6y50zbR
 ZrxA==
X-Gm-Message-State: AOJu0Yz4/bnu7alP5abbZ+sXeDuTnYPMgVo0IzKDm5NmXstDUotvB3/V
 /C22IptEpWGtYUVnrgdBE7deFtk7xtG2AD0oEaiuYqjGQ0qXiXSGbGDsJUXGZf4=
X-Gm-Gg: ASbGncvRsZew0SGQkowcqQFAmeA61AhmaEmOQGHBbXHQQaOSz1gYbahaKooOdztOBMr
 GxigpECTuJVmf9KH3xcYTyQKs2rAzx8wAhuhVBSm7UfBeHG6kurR8igA00mtUKCoJvt+6iFXZ0g
 qA4Gplh1fiDKPHEtq6r7lXL//N1re3lfo+KOF3aVf/sdK/egHIlIoAqwHIteZntT5EUFal3jT+f
 2aX1RrKZbZQEUyYjdQApyqVL094mdAwhX3Jbs0oqNn03kwqPIxJGVdVRpxsC3TjnTkeGqInOc1O
 AcunTbw18jCi7i9jFaGziNNM6cRZMcBxWZwzFEzPvmFddjUhxSQkBJYPz9U=
X-Google-Smtp-Source: AGHT+IFO4IBXvhhh9fy4gT6r7/YM/E/wYhJKi5C0/bqkf3zpWkqG4U6/DFXB1qIBrZkkH03x5uO0ww==
X-Received: by 2002:adf:e3d1:0:b0:385:f7ef:a57f with SMTP id
 ffacd0b85a97d-38dea28628fmr83248f8f.27.1739300014123; 
 Tue, 11 Feb 2025 10:53:34 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dca34a8sm183398685e9.16.2025.02.11.10.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 10:53:33 -0800 (PST)
Message-ID: <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
Date: Tue, 11 Feb 2025 19:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
Content-Language: en-US
In-Reply-To: <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
> On 11/2/25 19:26, Stefan Hajnoczi wrote:
>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> The following changes since commit 
>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
>>>
>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
>>> armbru into staging (2025-02-10 10:47:31 -0500)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
>>>
>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
>>>
>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
>>> (2025-02-10 21:30:44 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Misc HW patches
>>>
>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>>> - Make various Xilinx devices endianness configurable (Philippe)
>>> - Remove magic number in APIC (Phil)
>>> - Disable thread-level cache topology (Zhao)
>>> - Xen QOM style cleanups (Bernhard)
>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>>> - Invert logic of machine no_sdcard flag (Philippe)
>>> - Housekeeping in MicroBlaze functional tests (Philippe)
>>
>> Please take a look at this CI failure:
>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
> 
> Hmm I can not reproduce locally this error:
> 
>    Exception: Asset cache is invalid and downloads disabled

OK, I could reproduce by blowing my cache away.

The problem seems in the "tests/functional: Have microblaze tests
inherit common parent class" patch, which does:

-class MicroblazeelMachine(QemuSystemTest):
+class MicroblazeLittleEndianMachine(MicroblazeMachine):

I presume, since MicroblazeLittleEndianMachine is no more a direct
child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
downloaded.

> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368/artifacts/ 
> external_file/build/tests/functional/microblazeel/ 
> test_microblazeel_s3adsp1800.MicroblazeLittleEndianMachine.test_microblaze_s3adsp1800_legacy_le/base.log content is:
> 
>    2025-02-11 16:24:55,525 - DEBUG: Extract /builds/qemu-project/qemu/ 
> functional-cache/download/ 
> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
> format=Nonesub_dir=None member=None
> 
> which is correct:
> 
> $ sha256sum day13.tar.gz
> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22 
> day13.tar.gz
> 
> Did you restart the job to see if it is a network issue?
> 
> Regards,
> 
> Phil.


