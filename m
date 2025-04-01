Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03C7C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaHB-00022W-Gg; Tue, 01 Apr 2025 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzaGZ-00020R-Sk
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:58:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzaGX-0005xQ-TV
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:58:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so55945735e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743508728; x=1744113528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTsG+pYddH1wx1MjNuH5x48pHhcIB9quAniQeSORezI=;
 b=Y43IftPMqfyjh+L7rU/QMK4Hepz3TgvESgTHL06i0D92pVC3d+HS8HYOe6wSwev7+A
 D4YSY0dYaD3dBptC9Oq61FllJL7QvGJQ8iTRYayw2nqXBvaZPoGT99I18gFmINgyTPUp
 ge4tBWIVaSyyYuzqgFhGRN5+xz+kfNEthqf/rXGcbmQVqloEyWwsJ1vv+tPbkUP2Fw6U
 WunSNoLrZiDv1P4HLK/OEKLdN2C0DVJjrq5wcHrg0SzBQG1E2tRrz591nthlsB7SQLwo
 49xxU55lhmdYo/iSQRlzCYsLUN82AETy2sh4ZU7BJlt+jIHph9ta1/Gx4nbk7ZtrkCIo
 htOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743508728; x=1744113528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTsG+pYddH1wx1MjNuH5x48pHhcIB9quAniQeSORezI=;
 b=VvuMf1NBI3ybcdWdP+BpE3xpTeGWEK31WBO8VxjvKMGybjU5mVWQhCGHpZR6G8wBCz
 dPWmq+hU1S15dJYx2nAjvb03cAAAbhmoNlaBJDHIS56iE11Ot80RpKl8RC9mZC/73+yk
 U+YLwNXCXD0sYqYVeXHku1d/z/EUXjOSDyx2Er470OOuQjFSZtumb4mUqgp2uXTeY1bU
 SW1t0PvLLji6AyGmChOeUs5IAW5oLIS43V28fn1jVp7fTBB3OJ2sXD59gNjuR67ZnbV2
 AdERj9o/cOgc1EXqwfCksnkNxifWuFwUqKC6QAob+uEIsejerA75+Awuk9r69hDcPyvY
 K/xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw2G0USBzwM1E73Tmnztry4vLLqkSemndG0TB1ObbhCC92SmDjO7AfvaQPHYBpPB3f1oUO41ZSKb4C@nongnu.org
X-Gm-Message-State: AOJu0YzZc/F7uqbxTDR1cdG4tl1u38mgiKsqvSjCtXKibVNMACxFNnMF
 OK7/pKbqMPoaeTXBH6QhaMDeSIXq9zz97rC3BnFmnZY1gE9RNeaBcw+1G93PGZg=
X-Gm-Gg: ASbGncvQNe/YhntKAzgP1TmrPjaE9fau7SjufYcgTeqXFNy/YjyOdZ96G+3Wdt503vS
 0fG4Q9QnXRzrQGlTgPazYLtXfSUHwyS1lf840m0716AJXILmZJVucv93PDgDabl8D5G2XcticVZ
 H3WSIonqdVYrGJPld3J60rXA1voA/cIcbtiQ6Mo8ueKLljzTDzmhb5Ub2DPdubHF/zuYY4TcE00
 89xMlKnVnOYmwPABQi/+LgqexEaf5wwIYHx51voOeXNZaJafvnZE85tTkLxZ33tTNx968O0HGDQ
 Th61GG1MbsmlrJfSmI9CJ5WSOgHeXsHMzHSiVjELI6ma7Ds5c+E4/eNHn4S7vNHtWEaGbmJf4Yx
 F3cMZSu23v056
X-Google-Smtp-Source: AGHT+IGS6aGb+xvOChK72MrxAfSTSN7WEBtwtV7fqj9p0hSVoI4X/xqDFoDOqGga8Ylb1kWOWps17g==
X-Received: by 2002:a5d:59ae:0:b0:38d:e584:81ea with SMTP id
 ffacd0b85a97d-39c1211abe5mr10725814f8f.45.1743508727589; 
 Tue, 01 Apr 2025 04:58:47 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e12bsm14153967f8f.62.2025.04.01.04.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:58:47 -0700 (PDT)
Message-ID: <9ae8882b-35d1-489a-9f5c-579bd9ae89df@linaro.org>
Date: Tue, 1 Apr 2025 13:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/29] ui & main loop: Redesign of system-specific main
 thread event handling
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-24-philmd@linaro.org>
 <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
 <3e8e7649-2ee3-4e72-9cd6-17db0551ea66@linaro.org>
 <24a30054-eef8-4ce0-971d-0b50d28154f1@linaro.org>
 <aedc72a0e5dabe190427dd536b2882f0ca8713c4.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aedc72a0e5dabe190427dd536b2882f0ca8713c4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 1/4/25 13:43, David Woodhouse wrote:
> On Tue, 2025-04-01 at 13:30 +0200, Philippe Mathieu-Daudé wrote:
>> On 1/4/25 13:18, Philippe Mathieu-Daudé wrote:
>>> Hi David,
>>>
>>> On 8/1/25 14:51, David Woodhouse wrote:
>>>> On Tue, 2024-12-31 at 21:22 +0100, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>> This change tidies up main thread management to be more
>>>>> flexible.
>>>>>
>>>>>    * The qemu_main global function pointer is a custom function
>>>>> for the
>>>>>      main thread, and it may now be NULL. When it is, the main
>>>>> thread
>>>>>      runs the main Qemu loop. This represents the traditional
>>>>> setup.
>>>>>    * When non-null, spawning the main Qemu event loop on a
>>>>> separate
>>>>>      thread is now done centrally rather than inside the Cocoa
>>>>> UI code.
>>>>>    * For most platforms, qemu_main is indeed NULL by default,
>>>>> but on
>>>>>      Darwin, it defaults to a function that runs the CFRunLoop.
>>>>>    * The Cocoa UI sets qemu_main to a function which runs the
>>>>>      NSApplication event handling runloop, as is usual for a
>>>>> Cocoa app.
>>>>>    * The SDL UI overrides the qemu_main function to NULL, thus
>>>>>      specifying that Qemu's main loop must run on the main
>>>>>      thread.
>>>>>    * The GTK UI also overrides the qemu_main function to NULL.
>>>>>    * For other UIs, or in the absence of UIs, the platform's
>>>>> default
>>>>>      behaviour is followed.
>>>>
>>>> When exiting an emulated Xen guest with <Ctrl-a x> on the
>>>> console, I
>>>> now see:
>>>>
>>>> (gdb) run
>>>> Starting program: /home/dwmw2/git/qemu/ball/qemu-system-x86_64 -
>>>> display none -vga none -serial mon:stdio -machine q35 -accel
>>>> kvm,xen-
>>>> version=0x4000a,kernel-irqchip=split -smp 2 -kernel /home/dwmw2/
>>>> avocado/data/cache/by_name/bzImage -append printk.time=0\
>>>> root=/dev/
>>>> xvda\ console=ttyS0\ xen_emul_unplug=ide-disks\
>>>> xen_no_vector_callback\ noapic\ loglevel=0 -drive
>>>> file=/home/dwmw2/
>>>> avocado/data/cache/by_name/
>>>> rootfs.ext4,if=none,snapshot=on,format=raw,id=drv0 -device xen-
>>>> disk,drive=drv0,vdev=xvda -device virtio-net-pci,netdev=unet -
>>>> netdev
>>>> user,id=unet,hostfwd=:127.0.0.1:0-:22
>>>>
>>>> Starting syslogd: OK
>>>> Starting klogd: OK
>>>> Running sysctl: OK
>>>> Saving 256 bits of non-creditable seed for next boot
>>>> Starting network: OK
>>>> Starting dhcpcd...
>>>> no such user dhcpcd
>>>> dhcpcd-9.4.1 starting
>>>> no interfaces have a carrier
>>>> forked to background, child pid 111
>>>> Starting dropbear sshd: OK
>>>> #
>>>> QEMU: Terminated
>>>> qemu-system-x86_64: ../block/block-backend.c:1290: blk_in_drain:
>>>> Assertion `qemu_in_main_thread()' failed.
>>>>
>>>> Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
>>>> 0x00007ffff5ffc724 in __pthread_kill_implementation () from
>>>> /lib64/
>>>> libc.so.6
>>>> (gdb) bt
>>>> #0  0x00007ffff5ffc724 in __pthread_kill_implementation () at
>>>> /lib64/
>>>> libc.so.6
>>>> #1  0x00007ffff5fa3d1e in raise () at /lib64/libc.so.6
>>>> #2  0x00007ffff5f8b942 in abort () at /lib64/libc.so.6
>>>> #3  0x00007ffff5f8b85e in __assert_fail_base.cold () at
>>>> /lib64/libc.so.6
>>>> #4  0x00007ffff5f9be47 in __assert_fail () at /lib64/libc.so.6
>>>> #5  0x0000555555abf911 in blk_in_drain (blk=0x555557ca6680)
>>>>       at ../block/block-backend.c:1290
>>>> #6  0x000055555593410c in xen_block_dataplane_stop
>>>> (dataplane=0x555558982950)
>>>>       at ../hw/block/dataplane/xen-block.c:695
>>>> #7  0x000055555593441a in xen_block_dataplane_stop
>>>> (dataplane=<optimized out>)
>>>>       at ../hw/block/dataplane/xen-block.c:689
>>>> #8  0x00005555555dfd5e in xen_block_disconnect
>>>>       (xendev=xendev@entry=0x55555880aa60, errp=<optimized out>)
>>>>       at ../hw/block/xen-block.c:172
>>>> #9  0x00005555555dfeca in xen_block_unrealize
>>>> (xendev=0x55555880aa60)
>>>>       at ../hw/block/xen-block.c:282
>>>> #10 0x000055555578ef71 in xen_device_unrealize (dev=<optimized
>>>> out>)
>>>>       at ../hw/xen/xen-bus.c:978
>>>> #11 0x0000555555bfe65f in notifier_list_notify (list=<optimized
>>>> out>,
>>>> data=0x0)
>>>>       at ../util/notify.c:39
>>>> #12 0x00007ffff5fa6461 in __run_exit_handlers () at
>>>> /lib64/libc.so.6
>>>> #13 0x00007ffff5fa652e in exit () at /lib64/libc.so.6
>>>> #14 0x0000555555b523dc in qemu_default_main
>>>> (opaque=opaque@entry=0x0)
>>>> #15 0x00005555555609c0 in main (argc=<optimized out>,
>>>> argv=<optimized
>>>> out>) at ../system/main.c:76
>>>>
>>>
>>> Is this still an issue?
>>
>> Likely fixed by commit e7bc0204 ("system/runstate:
>> Fix regression, clarify BQL status of exit notifiers"), so
>> I'm closing https://gitlab.com/qemu-project/qemu/-/issues/2771.
> 
> Indeed. I think I was assuming the explicit Resolves: tag in that
> commit was going to magically close the issue when it was merged.
> Should I have closed it manually?

It should have been closed automatically. Maybe some transient
problem on GitLab side ¯\_(ツ)_/¯

