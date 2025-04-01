Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E435C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzZot-0007VT-1E; Tue, 01 Apr 2025 07:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZoq-0007VE-1U
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:30:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZon-0000dY-R4
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:30:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso25222325e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743507006; x=1744111806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U1hfFxtqfePmhoVmvo13zftrxQbeBmpEGB9yf1vrJNA=;
 b=k7ph2yTtGGnarubQCHt3uD1331Vvq0pIYomdIT2by+xzguKEBMYYSrFZO0hXzIY3xF
 KnyiCyqIvTgJjeeOh8u1kQk4vSAG8yBiKTqke+ppnuEuOIfhEid6qln2w41u/H38Ymly
 yDzb/lMuzDbqrMr/6Lao8vIb553oc/33W+6pzhyPAlT5PewnnkhAW46VgQOc9Z5MqoCC
 JQZq+V8/3qTWxYqdbuJAE/jpCC5Zz5YYf9sV40sSIXQiVDUxAE8PQn67TNAoRh5EUjK4
 44ImG+u7lZD/KHGmFSlHpESfPx86D2R9MgLqZYbRUw4vtwOJGI6CkDoRn+WC05dx5aDE
 s/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507006; x=1744111806;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U1hfFxtqfePmhoVmvo13zftrxQbeBmpEGB9yf1vrJNA=;
 b=wwA/nOnzg9cY0b93ZL4bWHiZzfeL+5eHYQPYYZuTluyWJAB33dT6UPS0vl03FcyvVT
 myM+NS2PTEgeX64Yq8pPq/MMTo95HU12bP3piL/zeYnUI9jS/WkTIMf7MeQKGXkdpnvz
 FOc3yQiIIAG6elcoWJjsGm4mvhn1ZdeggBB6sZx38ZarIBo13Oec1c8gBY/wJr+f+6UC
 8wwfsvRApTq41XObaRcJF48yHXy0OXnvCshcZEeQOSEakX62lWfzmNB81Mw7cQyAsSqV
 /x/GR7uxI9/JchckgX0ti6QzAjpcqUFgVnOhgl++2eSHb/6zHuJQ2slfQShTm+hFsE8w
 0Jyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA877KBjss7ft8MeDD9pBWj1566D22b8hteiOfLroh6akeRikCJk1i1rRYuoKtKmPacQtXoLvppSsB@nongnu.org
X-Gm-Message-State: AOJu0YwrwnVjSdkfJCmzt83JUt6ABNaSpkuxTDap7FMnTdnaclBpR99t
 zOx8uR1fNf/P7v5rMPoV08cIXQCOCPvPHhznPlyinu1omIPcTYRq6Xl1Xkb0ypk=
X-Gm-Gg: ASbGnct6HVtisk5pekwTv0xx6o/zHnfmmlbBa8tesLfTCMzh1pCO3/wd2c1Yw0I0/lQ
 W0qpyRXzshU611hRoCrwGLNLdCVGVCLPBtYTNZcClWTKY8nGOhIOo+2bw/HTGl0WZsfoiZFaeRo
 HdoTxQPqhQ7Q8rI8zRrCt5UqNbTfATA5/DgOl5BYX/O7UwEkwJbw99iIEmR7ZDlaWDnfwSOSU2K
 C+sWcW0VVEYH73xvk8xcHEHUGjCECGgZVb7gyg+MstHIE3Uu2VTyDLCHTFcHRrY2OZNWwW2f2y1
 lC7nGyouwBVkGs7EMt4EfQt/ZlkZtE0PKUEQPpYQdrvbtQ/5wAZG04kZcw0vmZ12HH8GcWcVIzm
 7hYcUsqOFHd4hnUGCRv0+c3s=
X-Google-Smtp-Source: AGHT+IF8/88X1YCzOToJILVT7hh3pHKzTz+JVLIyy3z6I89N1LhkrhIM6Qn4dGWkgKvfqSUXEin8VA==
X-Received: by 2002:a05:6000:420d:b0:391:2ab1:d4b8 with SMTP id
 ffacd0b85a97d-39c120c7d4cmr9496993f8f.1.1743507006484; 
 Tue, 01 Apr 2025 04:30:06 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0d1sm13858802f8f.70.2025.04.01.04.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:30:05 -0700 (PDT)
Message-ID: <24a30054-eef8-4ce0-971d-0b50d28154f1@linaro.org>
Date: Tue, 1 Apr 2025 13:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/29] ui & main loop: Redesign of system-specific main
 thread event handling
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-24-philmd@linaro.org>
 <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
 <3e8e7649-2ee3-4e72-9cd6-17db0551ea66@linaro.org>
Content-Language: en-US
In-Reply-To: <3e8e7649-2ee3-4e72-9cd6-17db0551ea66@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/4/25 13:18, Philippe Mathieu-Daudé wrote:
> Hi David,
> 
> On 8/1/25 14:51, David Woodhouse wrote:
>> On Tue, 2024-12-31 at 21:22 +0100, Philippe Mathieu-Daudé wrote:
>>>
>>> This change tidies up main thread management to be more flexible.
>>>
>>>   * The qemu_main global function pointer is a custom function for the
>>>     main thread, and it may now be NULL. When it is, the main thread
>>>     runs the main Qemu loop. This represents the traditional setup.
>>>   * When non-null, spawning the main Qemu event loop on a separate
>>>     thread is now done centrally rather than inside the Cocoa UI code.
>>>   * For most platforms, qemu_main is indeed NULL by default, but on
>>>     Darwin, it defaults to a function that runs the CFRunLoop.
>>>   * The Cocoa UI sets qemu_main to a function which runs the
>>>     NSApplication event handling runloop, as is usual for a Cocoa app.
>>>   * The SDL UI overrides the qemu_main function to NULL, thus
>>>     specifying that Qemu's main loop must run on the main
>>>     thread.
>>>   * The GTK UI also overrides the qemu_main function to NULL.
>>>   * For other UIs, or in the absence of UIs, the platform's default
>>>     behaviour is followed.
>>
>> When exiting an emulated Xen guest with <Ctrl-a x> on the console, I
>> now see:
>>
>> (gdb) run
>> Starting program: /home/dwmw2/git/qemu/ball/qemu-system-x86_64 - 
>> display none -vga none -serial mon:stdio -machine q35 -accel kvm,xen- 
>> version=0x4000a,kernel-irqchip=split -smp 2 -kernel /home/dwmw2/ 
>> avocado/data/cache/by_name/bzImage -append printk.time=0\ root=/dev/ 
>> xvda\ console=ttyS0\ xen_emul_unplug=ide-disks\ 
>> xen_no_vector_callback\ noapic\ loglevel=0 -drive file=/home/dwmw2/ 
>> avocado/data/cache/by_name/ 
>> rootfs.ext4,if=none,snapshot=on,format=raw,id=drv0 -device xen- 
>> disk,drive=drv0,vdev=xvda -device virtio-net-pci,netdev=unet -netdev 
>> user,id=unet,hostfwd=:127.0.0.1:0-:22
>>
>> Starting syslogd: OK
>> Starting klogd: OK
>> Running sysctl: OK
>> Saving 256 bits of non-creditable seed for next boot
>> Starting network: OK
>> Starting dhcpcd...
>> no such user dhcpcd
>> dhcpcd-9.4.1 starting
>> no interfaces have a carrier
>> forked to background, child pid 111
>> Starting dropbear sshd: OK
>> #
>> QEMU: Terminated
>> qemu-system-x86_64: ../block/block-backend.c:1290: blk_in_drain: 
>> Assertion `qemu_in_main_thread()' failed.
>>
>> Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
>> 0x00007ffff5ffc724 in __pthread_kill_implementation () from /lib64/ 
>> libc.so.6
>> (gdb) bt
>> #0  0x00007ffff5ffc724 in __pthread_kill_implementation () at /lib64/ 
>> libc.so.6
>> #1  0x00007ffff5fa3d1e in raise () at /lib64/libc.so.6
>> #2  0x00007ffff5f8b942 in abort () at /lib64/libc.so.6
>> #3  0x00007ffff5f8b85e in __assert_fail_base.cold () at /lib64/libc.so.6
>> #4  0x00007ffff5f9be47 in __assert_fail () at /lib64/libc.so.6
>> #5  0x0000555555abf911 in blk_in_drain (blk=0x555557ca6680)
>>      at ../block/block-backend.c:1290
>> #6  0x000055555593410c in xen_block_dataplane_stop 
>> (dataplane=0x555558982950)
>>      at ../hw/block/dataplane/xen-block.c:695
>> #7  0x000055555593441a in xen_block_dataplane_stop 
>> (dataplane=<optimized out>)
>>      at ../hw/block/dataplane/xen-block.c:689
>> #8  0x00005555555dfd5e in xen_block_disconnect
>>      (xendev=xendev@entry=0x55555880aa60, errp=<optimized out>)
>>      at ../hw/block/xen-block.c:172
>> #9  0x00005555555dfeca in xen_block_unrealize (xendev=0x55555880aa60)
>>      at ../hw/block/xen-block.c:282
>> #10 0x000055555578ef71 in xen_device_unrealize (dev=<optimized out>)
>>      at ../hw/xen/xen-bus.c:978
>> #11 0x0000555555bfe65f in notifier_list_notify (list=<optimized out>, 
>> data=0x0)
>>      at ../util/notify.c:39
>> #12 0x00007ffff5fa6461 in __run_exit_handlers () at /lib64/libc.so.6
>> #13 0x00007ffff5fa652e in exit () at /lib64/libc.so.6
>> #14 0x0000555555b523dc in qemu_default_main (opaque=opaque@entry=0x0)
>> #15 0x00005555555609c0 in main (argc=<optimized out>, argv=<optimized 
>> out>) at ../system/main.c:76
>>
> 
> Is this still an issue?

Likely fixed by commit e7bc0204 ("system/runstate:
Fix regression, clarify BQL status of exit notifiers"), so
I'm closing https://gitlab.com/qemu-project/qemu/-/issues/2771.

