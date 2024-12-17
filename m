Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A97E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa8b-0006GD-45; Tue, 17 Dec 2024 11:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNa8R-00062H-Ne
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:09:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNa8K-0003Kv-7m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:09:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361c705434so39991495e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451754; x=1735056554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ev53uTb7NbwG8SyhMg5j33gklzQzPRup2l9rzIa3A9k=;
 b=V8nqcCB0UdndmN3ME4nSYaV/fPNMkp4zFZwRYUUtiZn16Z/MUnfkPun60qoBXMfQQA
 eywO6WAYRNc1FKIYVWbxG1Ya37BGLUtdk5JM995zN4veEWMRf4hoELNMsEX/sScjd/k5
 WKV8khayxDC/63N5+J6Ke9KJQuJkM3UWTpx1qo0tzFmYVB+l0/HH4RbU6MkIe3e99fjK
 9N2D8cf3aOEh0JoKDM/JYzMqOfBqLYs2+DjMhAAoF0Jq+yvGqLVGJYss9EkJT1KJ0Jzk
 sKGCUknARV4lQs80am51/EPFYXSNfNKeLCArZn7kF24QPh0yqkJjKfhH7BfDOmx7DRGu
 rVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451754; x=1735056554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ev53uTb7NbwG8SyhMg5j33gklzQzPRup2l9rzIa3A9k=;
 b=fT2xWuyxC3OGGqF2wNIxJ3/KbBLfmXRbYQRjCr9R8x5i4wa07jKRPKUFe10E3pixTd
 VEuQDR2XCYrMn67op12rQi+VC4EGC6TYhTUK2oAL1xp3cy2G/ARYwX7lwp1RpwWP+jS+
 cTPkyEUWQcWO68Y0hUMy5hEEqm8njhNdBEcM8yOaess/w01u8uxUdRhklmVkLCRXE7cV
 EvWww0b2/7CPuXIgfFuKQKIClyQ8iThpPTmo0ntHl3JI8TkexOUnNIV9EX70xXjZ+dcf
 uVu0qjXJ46zpeteeRdLUO6ufCh1WTJRMB0axRhOlrOaHW8ZVSMkZXaSYFmzD1MbTK3tW
 C1Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3L1sTU81JCw9nukJzX5QPaxSgzCEIcgvkMINu71Imo907Wlu7FPcRllxjej/h2JlD7UfWE0hoA1sA@nongnu.org
X-Gm-Message-State: AOJu0YywGTSsomxe91cdnyPyqRYmIqjmuaD01PwjdIZOAmo+zgLsSGo1
 BU2V8QBr1foR1KOoq1lHqa8S9uOQ2OecjKfn3UQtKNfr6Q5oAtEvXujQ271flkU=
X-Gm-Gg: ASbGncv8lxbOWXt194pJ0dJKfxHnadlBxcM37COH1hiknoh6NpnMU9ObtASIJz2CuTW
 YlAdQI7YW1f5Ad6l50BTA+cj5MAuS4SX2pYiDBgwqQXRayHLz2xd9GzWl11T/ZgeF1iJhlOfYFt
 e2zzwYiMwSGkBXQo1hvxvEUL+/3dFCHcwyr5TgULhqfz6e8I7B0Mm3vC/5S4LJVwDslEqsVCrtk
 k78/TKhRMHxPZ0wTX51GXoAGolGTNu2nLkvJc0YMm6o/JaLOSQSOeHoRJrpdwECouFW16TI
X-Google-Smtp-Source: AGHT+IH1B0203uqa1ZBzymIiHUN46OWj/roDzbXuqjV4OkBHJAQrZOv/XEZie+aKPuVksQjj3WupCA==
X-Received: by 2002:a5d:6d8a:0:b0:385:fc97:9c71 with SMTP id
 ffacd0b85a97d-388da380bf0mr3290044f8f.12.1734451754327; 
 Tue, 17 Dec 2024 08:09:14 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012081sm11475313f8f.19.2024.12.17.08.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 08:09:13 -0800 (PST)
Message-ID: <127fb329-901a-4561-80b8-baebef099812@linaro.org>
Date: Tue, 17 Dec 2024 17:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the hotplug_cpu avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20241217142020.155776-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241217142020.155776-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/12/24 15:20, Thomas Huth wrote:
> Since we don't have ssh support in the functional test framework yet,
> simply use the serial console for this test instead. It's also
> sufficient to only boot into an initrd here, no need to fire up a
> full-blown guest, so the test now finishes much faster.
> 
> While we're at it, also unplug the CPU now and check that it is gone
> in the guest.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  1 +
>   tests/functional/meson.build                  |  1 +
>   .../test_x86_64_hotplug_cpu.py}               | 58 ++++++++++++++-----
>   3 files changed, 47 insertions(+), 13 deletions(-)
>   rename tests/{avocado/hotplug_cpu.py => functional/test_x86_64_hotplug_cpu.py} (25%)
>   mode change 100644 => 100755


> -        self.ssh_command('test -e /sys/devices/system/cpu/cpu0')
> -        with self.assertRaises(AssertionError):
> -            self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'cd /sys/devices/system/cpu/cpu0',
> +                                          'cpu0#')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'cd /sys/devices/system/cpu/cpu1',
> +                                          'No such file or directory')
>   
>           self.vm.cmd('device_add',
>                       driver='Haswell-x86_64-cpu',
> +                    id='c1',
>                       socket_id=0,
>                       core_id=1,
>                       thread_id=0)
> -        self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
> +        self.wait_for_console_pattern('CPU1 has been hot-added')
> +
> +        exec_command_and_wait_for_pattern(self,
> +                                          'cd /sys/devices/system/cpu/cpu1',
> +                                          'cpu1#')
> +
> +        self.vm.cmd('device_del', id='c1')
> +
> +        exec_command_and_wait_for_pattern(self,
> +                                          'cd /sys/devices/system/cpu/cpu1',
> +                                          'No such file or directory')

Good idea to expand a bit the test testing removal.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


