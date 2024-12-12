Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F217BE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjlS-00059W-Tq; Thu, 12 Dec 2024 09:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjkF-0004tT-7e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:01:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjkC-0007g6-LS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:00:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso313051f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012042; x=1734616842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZx0V5VnnG/XUIXFEe2Mzfd/Ua9oCfavUlhdqUGfsg4=;
 b=m6t5qKqhrAHzpaMiE9ZKEN87h5AvanwSMHcesORbkluf6sOwMdQgblTVz2fRo2rud0
 Gu33kpSx0F0asCiM1vc5Sbodau6sapa4+CiuQJUmsmr2oPX3hc6DN5cxU2zRwAFxFWkW
 ckI0fpHlthbqpB95czSqog0C1dKKzGjLWv7fUMqypEzsRDBxsHPKqK7sTRLw9SpgbvWM
 KVv37h5E38yVCwNnp+iK8vjsl+veriVdr2yqtGymlXGy2AVW+96nm/BXkwqd+KlYfJxF
 Pm3Z531LBwP/VWNNktwWOZd+YZUgjxbbYmvvDtHDixNkzfcdX5k5NYDjH1zEkh1OsBab
 mhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012042; x=1734616842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZx0V5VnnG/XUIXFEe2Mzfd/Ua9oCfavUlhdqUGfsg4=;
 b=JXeBMXE6m7OLjb+KPXKbexzotmqotRPl7eCjGnrvk9ardcwFw0FUNaalqqRM4vD+YW
 6xlRwjG5vg6Q+L9FTbk0Hn5klMnY9DAqr5sQPrC9kRQcsdKZ2gAQb+o8Ji5l88RyZM1z
 V/ffoOnOiv3suz1455JmwEoY38HwYiXPcaDwk7uWxDKJDILoKoWroCZ/oTLWOnS3trta
 nW0c8jlwXyGSKqTnktM5fH6eEOsHYWMccFVDAPGygzgNRWkcEyreIa/PMDtZ3RZfITlz
 CUVAB7/pxSveLrZULQK7pFgppX29smIxGEQLtgPmuTfF/FuC9GrRq76SA5JVPAQYWfx6
 68bA==
X-Gm-Message-State: AOJu0YzCiLIoByuZNXmJF0o2FY8RrOGUW/GpFJrCL4R9/t5JyLFHeJxn
 8CjMKFhzaSIKTQB9oC9gXxh/ZIsK86P4O+HSbeXbvcdHJEr7or/NddEjZQc9//0=
X-Gm-Gg: ASbGncvbVkBD89yV9AwK+UM1FfQcWR3HLDCVl3AObgGAYG/5Kd6imN+b3gSDUnD57Pf
 F1Oy3HFmzh2HSU9gl3iHKUlQLLU9PGG6oEKUc1K+fAOco+9yB+Pl9ENnaNZt2xHugNeE8RYI4Qo
 rGHOFtfboV+8la0lVuukZnEEdCpE24+mCvKLA7DxxuO02Ij/KHYob6O4eFxczbCjsxgL9CSX/w+
 kx001JKJpq+eK0UxG+tRX63w0gWI9IWl6Tyy4laHtqLAYnpQadcxtDEXg2U/lw/lDgptus1SeHP
 IfsuwAJrCVAK7O0ztSZfks+5
X-Google-Smtp-Source: AGHT+IGHxx1oT5HejcUdG9XlAloszzK5GLnsoSPC4iLd2T653/vHyT06TqJJZjQeKf5n+5X8srFCYA==
X-Received: by 2002:a5d:6c6a:0:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-3864ce97153mr5213559f8f.21.1734012038435; 
 Thu, 12 Dec 2024 06:00:38 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f533sm4175939f8f.3.2024.12.12.06.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:00:37 -0800 (PST)
Message-ID: <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
Date: Thu, 12 Dec 2024 15:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-3-philmd@linaro.org>
 <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 12/12/24 14:11, BALATON Zoltan wrote:
> On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
>> Only physmem.c includes libpmem and libdaxctl headers.
>> No need to pass them to all system_ss[] files.
> 
> I think doing this patch first would leave the other one unnecessary so 

This one is about libpmem / libdaxctl in physmem.c,
the previous one is about libsdl in vl.c. I'm missing
what inverting the order would change.

Besides in 2 patches it is simpler to check what CPPFLAGS are applied.

Anyhow if you insist, I can squash. I don't care much as long as
we reduce the flags applied to system_ss[].

> you could do both in one patch with less churn and maybe reduce this 
> series to a single patch.
> 
> Regards,
> BALATON Zoltan
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> system/meson.build | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/meson.build b/system/meson.build
>> index f7e2c8b826f..50d915bd80c 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: 
>> [files(
>>   'arch_init.c',
>>   'ioport.c',
>>   'memory.c',
>> -  'physmem.c',
>>   'watchpoint.c',
>> )])
>>
>> +specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>> +  'physmem.c',
>> +), libpmem, libdaxctl])
>> +
>> system_ss.add(files(
>>   'balloon.c',
>>   'bootdevice.c',
>> @@ -23,7 +26,7 @@ system_ss.add(files(
>>   'runstate-hmp-cmds.c',
>>   'runstate.c',
>>   'tpm-hmp-cmds.c',
>> -), libpmem, libdaxctl)
>> +))
>>
>> system_ss.add(files(
>>   'vl.c',
>>


