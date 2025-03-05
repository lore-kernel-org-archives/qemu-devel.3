Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F1CC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnom-000125-TY; Wed, 05 Mar 2025 07:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpnok-00011q-OP
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:25:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpnoi-0000qt-Pb
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:25:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso4775235e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 04:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741177539; x=1741782339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/Si9X9Cr7YSJFEBEiIfBCq0LzgzaOp8PRjuYgCRuck=;
 b=hIMUPaKRKdaw+aW4TxueVlIYnCzyEyz7jP4Gu/9mAn3PSt2jGPIU9tAwGhOkYGKJGI
 E5vZoF7UtYeHFHWDBB1JDgGbAJMazOA98FaZoRdFYcLxvSGmMrNZ20YaKMxQ3UKZICJi
 wZc8SrAsmx2jNcp6Kf4Rfrw3r/8tFpLNe5JQie6/12GFlEmvH619GuZiLRMuQpxVWv4k
 GGaZIQyL9wQcitlcwG0lK+zwMdWaR1t2Z+qrAjycHvDZbdQn/h+OcZo/MOkdnQfDU0EY
 QNlx+HrfoR88aLjToEkNkzB47/I3OA8Hx6u/ObEMeQQN9pM/nrijAf80CNKvscjXa7dL
 zH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741177539; x=1741782339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/Si9X9Cr7YSJFEBEiIfBCq0LzgzaOp8PRjuYgCRuck=;
 b=ZkH3mcj8PAL6TPphE9L6f9p8YWPfNqr4KNx38Qywr13tQPnFuvI293sAP0M3XVD4o8
 R36RBFpUoQh+hrBHcphXicvSYZq+5Xue3yAnIZA1RKd3rl47mLswa6hTYN07fOiJUAql
 S7tkfaNI9AxMxmA0LvRqXr1k0efRCoVRarQ5B+hwsZZTq0wt1k7q74frMbRxtQSkDezt
 Un9lVE4SDb4fbTCVxY0k/76+49A16FMF3AkCIxfalS/TJiwyDyzZCjZwwv6nGBh0tmm+
 ZAEVlRbBT6T0QPEBXIyRk+rPuzgGgzl+e1BkDPWcrlZFrzvcU9r+a31K6toTh6aUrHPA
 TUhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPIIniM8gYql60ln4hcBaZEmpv9O4zQGc5/C8WIHw0wfiYjUyoaZTxsW2SwsV2URhd05LPZABivj1E@nongnu.org
X-Gm-Message-State: AOJu0YwDPheXxO4qJE07oVCUIWekUYAPt+WVo64iLdceGIY8FLoJiizx
 VdSjoYCv7EpAQ9miHwkYTjPTTosQ3sO+AqO0kXpuJ+F/kHgoeo9rsqJSc2OkXSg=
X-Gm-Gg: ASbGncuLyitb+0bH3Ky3UDWTpOJ5hg/nBVYRt5HOC1wGxtej+KANkioxVbMzuggdDc9
 RPqmBPW6AsfZRaBpfMq+V5KBcV3DtIknDvFcGFO9fR5oyMqNIT4v33aRHlXTXfqh+uHMcL3g6Km
 NbWCAgkcBMreX428QdZS76PhM6oOcQHsw46AozEC948FuYcLXC5dncmOXkYQBlTxDf5Q6Ye+Z+5
 EHyr/40egZqBSIRo/YNHlFoPkyPUSTxf/xJUy5kfFxrY86TcoXEDArXPIXsJpq2Nogp+p4FzRhX
 PjtX6TKQAdiCgIXjms+9JQzIUBdUVGiVk6rOr5F01/RSdpOWaQf7+OsYmxzfeE/jz0IowRuHVDD
 YunWauW2m7UxF
X-Google-Smtp-Source: AGHT+IGW9TG9rxsKcMUHSBCeWJ83XMJ8Lnsr6Ascw6Lf6MIz5rKjAqzB0eCB/ezAnDzdQoAc5sYC8w==
X-Received: by 2002:a05:600c:1d1d:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43bd20b4d27mr22161885e9.6.1741177538787; 
 Wed, 05 Mar 2025 04:25:38 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a9fsm21121120f8f.36.2025.03.05.04.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 04:25:38 -0800 (PST)
Message-ID: <5b5bcdd3-f102-4f32-967a-a352cd1803ed@linaro.org>
Date: Wed, 5 Mar 2025 13:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250304183340.3749797-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250304183340.3749797-1-berrange@redhat.com>
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

Hi Daniel,

On 4/3/25 19:33, Daniel P. Berrangé wrote:
> There are two race conditions in the recently added virtio balloon
> test
> 
>   * The /dev/vda device node is not ready
>   * The virtio-balloon driver has not issued the first stats refresh
> 
> To fix the former, monitor dmesg for a line about 'vda'.
> 
> To fix the latter, retry the stats query until seeing fresh data.
> 
> Adding 'quiet' to the kernel command line reduces serial output
> which otherwise slows boot, making it less likely to hit the former
> race too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
> index 67b48e1b4e..308d197eb3 100755
> --- a/tests/functional/test_virtio_balloon.py
> +++ b/tests/functional/test_virtio_balloon.py
> @@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
>           'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
>   
>       DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
> -                             'rd.rescue')
> +                             'rd.rescue quiet')
>   
>       def wait_for_console_pattern(self, success_message, vm=None):
>           wait_for_console_pattern(
> @@ -47,6 +47,9 @@ def mount_root(self):
>           prompt = '# '
>           self.wait_for_console_pattern(prompt)
>   
> +        # Synchronize on virtio-block driver creating the root device
> +        exec_command_and_wait_for_pattern(self, "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done", "vda1")
> +
>           exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
>                                             prompt)
>           exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
> @@ -65,10 +68,21 @@ def assert_initial_stats(self):
>               assert val == UNSET_STATS_VALUE
>   
>       def assert_running_stats(self, then):
> -        ret = self.vm.qmp('qom-get',
> -                          {'path': '/machine/peripheral/balloon',
> -                           'property': 'guest-stats'})['return']
> -        when = ret.get('last-update')
> +        # We told the QEMU to refresh stats every 100ms, but
> +        # there can be a delay between virtio-ballon driver
> +        # being modprobed and seeing the first stats refresh
> +        # Retry a few times for robustness under heavy load
> +        retries = 10
> +        when = 0
> +        while when == 0 and retries:
> +            ret = self.vm.qmp('qom-get',
> +                              {'path': '/machine/peripheral/balloon',
> +                               'property': 'guest-stats'})['return']
> +            when = ret.get('last-update')
> +            if when == 0:
> +                retries = retries - 1
> +                time.sleep(0.5)
> +
>           now = time.time()
>   
>           assert when > then and when < now

Unfortunately I'm still getting a timeout:
https://gitlab.com/philmd/qemu/-/jobs/9318095233

2025-03-05 12:09:55,360 - DEBUG: Console interaction: 
success_msg='Entering emergency mode.' failure_msg='Kernel panic - not 
syncing' send_string='None'
2025-03-05 12:09:55,360 - DEBUG: Opening console socket
2025-03-05 12:10:32,722 - DEBUG: Console interaction: success_msg='# ' 
failure_msg='Kernel panic - not syncing' send_string='None'
2025-03-05 12:10:32,823 - DEBUG: Console interaction: success_msg='vda1' 
failure_msg='None' send_string='while ! (dmesg -c | grep vda:) ; do 
sleep 1 ; done

2025-03-05 12:10:30,534: Warning: /dev/vda1 does not exist
2025-03-05 12:10:30,535:
2025-03-05 12:10:30,598: Generating "/run/initramfs/rdsosreport.txt"
2025-03-05 12:10:32,720:
2025-03-05 12:10:32,721:
2025-03-05 12:10:32,722: Entering emergency mode.
2025-03-05 12:10:32,724: Exit the shell to continue.
2025-03-05 12:10:32,726: Type "journalctl" to view system logs.
2025-03-05 12:10:32,727: You might want to save 
"/run/initramfs/rdsosreport.txt" to a USB stick or /boot
2025-03-05 12:10:32,728: after mounting them and attach it to a bug report.
2025-03-05 12:10:32,729:
2025-03-05 12:10:32,731:
2025-03-05 12:10:32,823: :/#


