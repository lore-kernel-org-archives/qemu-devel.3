Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CD9C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 20:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tifVG-0000cx-5w; Thu, 13 Feb 2025 15:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tifVE-0000cR-5y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:08:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tifVC-0003Sv-CB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:08:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso578618f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739477280; x=1740082080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=78+LxEkgm8og5imx+lPSGQQlrIzXvf136owDVPSH1WQ=;
 b=RXO6pplMispe/5Ba3zkFe+IzVJn3RGdYUP5ksOZ/aRIn7lKBq97T9G9lFbdDBFc48/
 tRQhIDZv1/27K0Tse0UJ9xXHPpo4T2t7CItqrtEn6cJpmIe4s7+dTcmDykW99G2M396P
 Z3RR3OptnH0umUCSqRiamvRoZEIGgiQwh9MXWX4klWEXJpW6ts18xxKLKFZxJ2HjwQBy
 kCVLBErXjNQ4VsCBPS1mCuy2uf2em6A0tS99RpzxuuqnZH6bNe3hhX1i52r358gDtHP3
 Zp1/8HUMq8PHIS+vDemYKt1iaOcaH4EqzSh+ZugtIuQ0DO/tf0PpqshMf7VpiklRO8sS
 3hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739477280; x=1740082080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78+LxEkgm8og5imx+lPSGQQlrIzXvf136owDVPSH1WQ=;
 b=pT2W7jQv+llojdYa19lfckR3AIT/L+SQCmhQbczj9J1hmFn4HTW7x15z8XOjQeHOqL
 cj+o3it5SAH7V10Td8HiF7viGerkS+sYngYameTzYz35hdPpR3nYccbj380DKiyc21UJ
 tWK/j3233h5WjshtdB8eb5UIjHvYOzLR/uDZp2rnwyxaMMSv7C8ziAnRl7sPKLP3+qcM
 1rN5UiXETVfCC/RwLR0vckWSU3S6W39Hci4Ih1qNCnU7geH0HPKc4cJDqS7Bdj/+xcFC
 Ll9u3qTafLDfCuJ5prJsUBarbb8kpmPox8THupeUrkgHQn/uD5CHSMWqAy9Ll0P971J1
 91fg==
X-Gm-Message-State: AOJu0Yz6yyjFf29DmA23y17gAMYFGuTZZaqHmXIphNqShfpO8fV7CzC7
 mbF76CPJJedz0sHUx4ELITKKrgyiekwYg2p6R35Y5QuXLmSLVzSSlcAflFVx3Lw2WQ7Nbi/wYwS
 J2KM=
X-Gm-Gg: ASbGncs8dQ1LWlWzbEQTMDftlQwWi2lfPlm9eXQLWkclCYXj0vmkly7AAnAuV7cmAgG
 HaFmOWZRkKiCp52WsXm1t0BWNDrJ8ib6zfS2QOSueB/k5aHPS9E9C5/8CjaB1A1L4aoF3KOukPf
 4YcKef79A6ZbeMaOdfhmZD/EfhA9ltpqPrUgP+4ghyNFv7Xzl5IkrneWaa/4eOY6fFg4wfUnvgj
 xnhcA6PjLo+qXqr7+3t2pvB6i46YRDKaMWQ2FUJnJ/0FfcAkAFpKh+eMHcQKZ6z/K1YMsQLDsz4
 FxW/vBhv2AvEHXTEgHZo4KtHEVSb5COabGOK6KCSmHpF8Hww5W9AoFvYp607nbtoPaK1DFY+XQ=
 =
X-Google-Smtp-Source: AGHT+IGDTCRSJ/MbmAZmz8cTVtjTlwJUuii88XWUXFsAdrT9ZidqsHu2ag0bnVZJSaOX+U+ozbWXrg==
X-Received: by 2002:a05:6000:1a51:b0:38d:e166:8dc2 with SMTP id
 ffacd0b85a97d-38dea27135cmr8666505f8f.16.1739477280364; 
 Thu, 13 Feb 2025 12:08:00 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd51sm2731716f8f.29.2025.02.13.12.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 12:07:59 -0800 (PST)
Message-ID: <4c493d3b-3113-4be8-99bd-60ec960dd6a0@linaro.org>
Date: Thu, 13 Feb 2025 21:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] Misc HW patches for 2025-02-12
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250212155408.29502-1-philmd@linaro.org>
 <CAJSP0QUg0X0E7m2Pm0Ni9HiVeXnaHHTAaxgC1+fkZjFcHHeisg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QUg0X0E7m2Pm0Ni9HiVeXnaHHTAaxgC1+fkZjFcHHeisg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 13/2/25 19:46, Stefan Hajnoczi wrote:
> On Wed, Feb 12, 2025 at 10:54 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> The following changes since commit f9edf32ea2e18a56de5d92f57e9d10565c822367:
>>
>>    Merge tag 'pull-request-2025-02-11' of https://gitlab.com/thuth/qemu into staging (2025-02-11 13:27:32 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20250212
>>
>> for you to fetch changes up to b374adcae577dddfe6cfd404985014fdd2443428:
>>
>>    hw: Make class data 'const' (2025-02-12 15:39:46 +0100)
>>
>> Since 2025-02-10: Dropped MicroBlaze endianness patches, added constify.
>>
>> ----------------------------------------------------------------
>> Misc HW patches
>>
>> - Use qemu_hexdump_line() in TPM backend (Philippe)
>> - Remove magic number in APIC (Phil)
>> - Disable thread-level cache topology (Zhao)
>> - Xen QOM style cleanups (Bernhard)
>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
>> - Invert logic of machine no_sdcard flag (Philippe)
>> - Housekeeping in MicroBlaze functional tests (Philippe)
> 
> Please take a look at this CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/9133190122#L949
> 
> Thanks,
> Stefan

Same error of previous PR. I'll drop the tests.

>>    tests/functional: Explicit endianness of microblaze assets
>>    tests/functional: Allow microblaze tests to take a machine name
>>      argument
>>    tests/functional: Remove sleep() kludges from microblaze tests
>>    tests/functional: Have microblaze tests inherit common parent class



