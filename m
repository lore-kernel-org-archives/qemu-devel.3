Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398B1CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqXoQ-0006cF-IP; Mon, 25 Aug 2025 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqXoM-0006au-Bn
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:04:39 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqXoE-0006f2-7a
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:04:37 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-24458272c00so51349255ad.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756130666; x=1756735466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyZkrXDZ4YF4atYTEtBegm7kT7FyJfwyls7AyxmGXUM=;
 b=V4fqg0zeNs0U8fNyH50814O4Y744ZXkhlScMRlmfjwhguwdNoRfc8mA0r/NIBxXDpY
 aUklE7bmbkCero1SP3GBe5recrR2xnGoVsLroUu7R15AgaH00T0aQmlVZw7NAm2TfXCs
 zg3b7fmJisJz8SaNGaRvhWkMEitOlyZuVNCcXjtX/Ve3hgCX1M/oO8vlEn7IAGZzI9fk
 aap4Zv2mAQZJ/0MV8ClKk13RtAzLICmeiIxpM+hVta5g9ZGal9po2yKscIu2wn7DI9/Q
 llvq5zVZLmvJWYXUxvSWY8739hDSIUsARdQ40KkjrNB10zu03go0mSS1baXEEq/aMMMn
 hxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756130666; x=1756735466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UyZkrXDZ4YF4atYTEtBegm7kT7FyJfwyls7AyxmGXUM=;
 b=p+iZK4KhtEONXzB9Y5OceZhFWWEsjTPzNsxRc/dwK3ub068gavZI70DQexge23nvRL
 mm0h7Hia13fXNFAwWA5n7+dTFfgmEY/8+mbvisNJUF5QW6wrmIG7G26WlBrEFAmMdjVv
 WXTi6nhHCy0VQnpYpIh+5nUG+pe44q5+VVhhS57jqs2PcK7o9174HOGh6GpE1OrVoL0r
 sbuNH8kycMW0vCGov1s7KwjFYk+WRsLLlPgqo5ERst/oE5qIGVMVSl++VPtoW6lAxD5l
 GFUjT55sXrEh/L31J8zQ2CtfEuqpcoJrGBIe+8DPVDnE1vVLMuKUFe5HKVytf4rd/tZo
 I+3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHCczCoZ0Z6IvfGl7AFNL5/m7PXUL9i2TxCHeF5H9zFqAmGh7Abtr+3g4j/p14RV5jJVXzGyPC7rlY@nongnu.org
X-Gm-Message-State: AOJu0Yy+45njofM2vzq9WwwxfVTGGJIr0jEDzxUS+11QvGzDjxqa5Nfs
 VrM/lwe1USQiCwagyO69zuqkub9Zea+PzuLP512vwNpiedGcl1CYyuaNbdzWCOLlEfE=
X-Gm-Gg: ASbGncvwuCvS6TXSXuejfPZNDiRV6QHDhCTWM/RePaguTzpjw54NGpW+exRPNQ8omOf
 Ch3PhzczwsfioilpwCwjeBLWIRM/GOWItdGadI4MNnQyUjPukoqWb3U/v+5LIgT4ZDcehEMZjCl
 2woMXHQ75L+629Xl2W67mLHfUIukS+ENPSkpnONVHSrirWQlCRM+TB+rZb9g409s9+LAIFUkOCK
 xznFOQIOXd8bfgEF+mcC0c2UeH/te4zLfUydeio7jZQBfSh/tv7xg4IZ94TJYXB+2Rr9P/VK5MW
 KUgg+FImz6TTRmQggZWSeO2IrOF2o6EJLPzTHyd3P2POCyBp9CSzdM8gbPa5C+oAnEnhm7Dk7XI
 /xfN7bRE53xbVrTgN9/85iNTTQ4HvkzBw+LdkBVmfixjW
X-Google-Smtp-Source: AGHT+IGOFbXikgEPb8HRjC0rCtrvCy/gLiu1suzNu1qCtuTHGxe57LDDlR5UV8gJRc2UiJl2Cwxlgg==
X-Received: by 2002:a17:903:2305:b0:246:916e:40c2 with SMTP id
 d9443c01a7336-246916e450fmr113586135ad.56.1756130665774; 
 Mon, 25 Aug 2025 07:04:25 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-246fbf368ebsm12959075ad.151.2025.08.25.07.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 07:04:25 -0700 (PDT)
Message-ID: <34c80114-8a7e-4761-add9-3b20a587ce18@linaro.org>
Date: Mon, 25 Aug 2025 11:05:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <20250819143916.4138035-5-gustavo.romero@linaro.org>
 <2ef8923b-18f5-47c6-b688-c9fa5b4fb0e4@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <2ef8923b-18f5-47c6-b688-c9fa5b4fb0e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Thomas,

On 8/25/25 07:34, Thomas Huth wrote:
> On 19/08/2025 16.39, Gustavo Romero wrote:
>> This commit removes Avocado as a dependency for running the
>> reverse_debugging test.
>>
>> The main benefit, beyond eliminating an extra dependency, is that there
>> is no longer any need to handle GDB packets manually. This removes the
>> need for ad-hoc functions dealing with endianness and arch-specific
>> register numbers, making the test easier to read. The timeout variable
>> is also removed, since Meson now manages timeouts automatically.
>>
>> The reverse_debugging test is now executed through a runner, because it
>> requires GDB in addition to QMP. The runner is responsible for invoking
>> GDB with the appropriate arguments and for passing the test script to
>> GDB.
>>
>> Since the test now runs inside GDB, its output, particularly from
>> 'stepi' commands, which cannot be disabled, interleaves with the TAP
>> output from unittest. To avoid this conflict, the test no longer uses
>> Meson’s 'tap' protocol and instead relies on the simpler 'exitcode'
>> protocol.
>>
>> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
>> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
>> before running 'make check-functional' or 'meson test [...]'.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
> ...
>> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
>> index 58d4532835..8b6f82c227 100755
>> --- a/tests/functional/test_aarch64_reverse_debug.py
>> +++ b/tests/functional/test_aarch64_reverse_debug.py
> ...
>> -    KERNEL_ASSET = Asset(
>> +    ASSET_KERNEL = Asset(
>>           ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>>            'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>>           '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
>> @@ -30,9 +29,9 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>>       def test_aarch64_virt(self):
>>           self.set_machine('virt')
>>           self.cpu = 'cortex-a53'
>> -        kernel_path = self.KERNEL_ASSET.fetch()
>> +        kernel_path = self.ASSET_KERNEL.fetch()
>>           self.reverse_debugging(args=('-kernel', kernel_path))
> 
> Ouch, that "KERNEL_ASSET" is worth to be sent as a separate bugfix (without the proper "ASSET_" prefix, the asset won't be precached properly). Could you maybe send this as a separate patch, please?

Sure!


Cheers,
Gustavo

