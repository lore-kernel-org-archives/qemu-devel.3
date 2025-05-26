Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14094C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUYD-0008Lu-AF; Mon, 26 May 2025 05:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUY9-0008Kr-I4
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:55:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUY7-0007SA-8s
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:55:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so27548015e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748253313; x=1748858113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vyNWev/uTZKwLF1P5A6rFwSNTFLMFDVh0vnkQwgzAzA=;
 b=NG1WYEk+xMQ2y6E//Ts+HkYjzHEFaRri7/nPUyRHnnwsZl1NYa2yJCcsWC2LDCnSL9
 Q7xUK9jE9sJY31ZHm/nz8BPyULTFHmxTdlwUW2bY5o7g1sUdLqUxbdggaC/yUJCdFm4L
 iFyKaw+4JsrYqt09SrSuVa9fln79pdsY/vv5DX66g+bl9fLqJOeSScvfZDuLbG5mnbSF
 +vGdK8it9wLknrM4q+AgO98Ek4w81Tv7Ej4d7YRhvfk2x7K8wh1fmKpdelMftjFb2N67
 MTkh2rwBxZnMibK3oKYsCyXFjTDPM/1nzq4MlNrdQ6mpvHEhSZQ4sUPbTuyU5aBvm54g
 zuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253313; x=1748858113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyNWev/uTZKwLF1P5A6rFwSNTFLMFDVh0vnkQwgzAzA=;
 b=F7jGPz/7QzmNJcDFL5O1f45RNTKsePDwWvOIET/gVaibGt2RPJNNU4AnvVdcG+pal5
 ll1ZKhVQnX442VyYsx1d0dgURu9RZXftjGJr4Rp8Jni27Bws9vPofOMY0xp+AIOMQJ5+
 UTxR6mV7h9M/UXsw53NCodmf4beecp6u3p3q41mIB/2YDmCHh+G+9k5Gf1nXzMpex6Tb
 A7pwyjdZJOl4atC1g8HB547LoGdpVkK5Oud28U/VkwYpkf7qYtrNmhUHorivgcxIpK22
 CUC9feQ+bm8dEOFk7PeLqqEYpFJXhcO/JOUs9iqIjrn+7YqVnhkr+v18lH2n4O/V9YQq
 HnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXisIkfallR9YyGFkHWYAtlcrQx/fWfHSrP8hinPnqIFnGzUNyT17ry++Gp9ibZWD0rgFBk/fwqjET+@nongnu.org
X-Gm-Message-State: AOJu0YzxDxEMK6GYRiMvI9yHcXItnbItikYV5lc5rwclSd37IpLJvhDW
 5HQV08aHQ7g/r0Tz4ktWHImEFjvKIdiXXrhLf4lT4BWWn+2zZdnOcVF6NOf1SRCewWk=
X-Gm-Gg: ASbGncvBh7MAzw3bpIpzo7AROIvVf9cuLGEMqhl86z/kJIZNECfDKKn1t0Tt5ETRuWe
 BQlX0JyHsFFMJnW3rlmYJ2Gn6XWzjHXrn9HfGOslZSQFuom9xpyWIztAGe+ThS8oRKvFPm7AKdI
 ViCNiBgZRG5LXw6AaZAiR+pYYxMo3DkCwa2aI1vM35douzEhP5TT1X1Th6gUxD5cEbfpU3Mk3Zk
 MsNTxNFtr4xGzKibWIlMOzeqberRslDyXTsYMsaRwcgyBb0M+SluKv9sHjgNUuZRyhjO5hOFKVi
 Tz1SRtCSPOSMpyXSULQlA5mXhgpra8TeuTkZG8GIMcjT4P0n8dz3OFuY6Wma3VfRrDorCfQOQws
 WuWOEUNhIL6I/BU2CxCXNfQsx
X-Google-Smtp-Source: AGHT+IGhvATRD0w8r3gSJ7GwITlp2L9UpE9Y043m7sbrELGU3uniQI3LQqxG+L2d6j338L4ruINpVg==
X-Received: by 2002:a05:600c:3d8e:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-44c95aada01mr76595465e9.30.1748253312670; 
 Mon, 26 May 2025 02:55:12 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b295e7sm230694365e9.2.2025.05.26.02.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:55:12 -0700 (PDT)
Message-ID: <34c305f8-700e-4ff7-a8ba-3b1921c1ccdc@linaro.org>
Date: Mon, 26 May 2025 11:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_mips_malta: Re-enable the check for
 the PCI host bridge
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rakesh Jeyasingh <rakeshjb010@gmail.com>
References: <20250522080208.205489-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250522080208.205489-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/5/25 10:02, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The problem with the PCI bridge has been fixed in commit e5894fd6f411c1
> ("hw/pci-host/gt64120: Fix endianness handling"), so we can enable the
> corresponding test again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_mips_malta.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
> index 89b9556f30d..30279f0ff21 100755
> --- a/tests/functional/test_mips_malta.py
> +++ b/tests/functional/test_mips_malta.py
> @@ -80,10 +80,8 @@ def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
>       exec_command_and_wait_for_pattern(test, 'cat /proc/devices', 'usb')
>       exec_command_and_wait_for_pattern(test, 'cat /proc/ioports',
>                                         ' : piix4_smbus')
> -    # lspci for the host bridge does not work on big endian targets:
> -    # https://gitlab.com/qemu-project/qemu/-/issues/2826
> -    # exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
> -    #                                   'GT-64120')
> +    exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
> +                                      'GT-64120')
>       exec_command_and_wait_for_pattern(test,
>                                         'cat /sys/bus/i2c/devices/i2c-0/name',
>                                         'SMBus PIIX4 adapter')

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


