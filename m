Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1F5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv0O0-0002D7-Oc; Wed, 19 Mar 2025 16:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tv0Ni-0002Az-8z
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tv0Nd-0001la-Jm
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742417471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IQ7ZardZrP4W6cAJy0wLw4+WBJHsMATkZAr7891wToY=;
 b=A+1UwzDpIWptPJ4KL4eJUZKKpvA/K0nt5d0YwlvtCzruuz6B8cTMF58JHI6yEoXYOtlGHF
 OGSrPUY1c1G0BUBuhU1XDVmdchW3w0sqjOMd+z1I8WSx9nO50wlWtF+MGNw2ZTtjiMW7Zc
 v/Xh3T2pLonHhK6YEmm9fBFC2L+NoDw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111--w09esGQO3upIkjhTxAYfw-1; Wed, 19 Mar 2025 16:51:10 -0400
X-MC-Unique: -w09esGQO3upIkjhTxAYfw-1
X-Mimecast-MFC-AGG-ID: -w09esGQO3upIkjhTxAYfw_1742417469
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so38565f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742417469; x=1743022269;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IQ7ZardZrP4W6cAJy0wLw4+WBJHsMATkZAr7891wToY=;
 b=DKFvpAU5l4jISFV1kXsxp4+ZmWwxdW4ZuccFh2IzktEZTXGVOQtmuVut/9hRKl/1M9
 9Tv/P3DSipBrwJF6r96YX8HzLFgq3scQGYSHBNcZTEuBOm3uaIxxV4BH0D0tUyQxn/lU
 sowmdGKIMRj7SfiURqLBuO6e9K0HIshlXov9gWOIZBGC0thCweJeSw20QnoWwvDFGKWB
 G+160NhCSQMMLQ+ckXpQr4Addtsw59Kga9P7TyC4qrUQhFqwxtLbVTLoKqOxY6RG2imw
 n8Pzgtc0/Ff6u89N6AQAsiRK3TD8Zg31oP0iRr1ike6qpuTgLdlg3MubBGpgF5DxVYQX
 /9Ww==
X-Gm-Message-State: AOJu0YxPKWf1Hb2iriw3tOLX0XtnHQ5C0ZbWoaoDL8rLeieYH1GfqpXK
 DfQbpECCCUNdfx7mGKTuvpxHWygzGGfbNL2KX7Sf8jPssh7iTrFNW6gCZ/XQlGTf/EptirMsubx
 i0i+gaZmYBCBdEZyfThs3T49LcchoduMiA+bnZVc9N3qn75afFVyn0a50QHlK
X-Gm-Gg: ASbGncthh2uJzNAtTmWe4KX+CpM89F894+ENhENgvMH8NwHoDLkLPLznLozTtFWP/Lo
 yim07KYs6EtOgZ2HIqe/SbdQmQlkAjusnKpFB8i91JAHCsIKskPsrK0UzRQ3V5N4PG+8yN7CzHI
 /VM8YQYpkiMmHqlccE0q5iJwe3Hp1gQesLE3AD3w16S2dYyUS15IKCa/uNbKmQGizEFfod6V5KR
 D/9M7wnG4fy0R3uZteCLM5UXDH3fdyJXj1/EjJyKRALAeQq6i7m0O5cIedOwIpaTy5IMFvwOSs0
 1a2BjFvmgi0LqcVoTnAt
X-Received: by 2002:a5d:6d0f:0:b0:391:98b:e5b3 with SMTP id
 ffacd0b85a97d-3997957c8a5mr887266f8f.14.1742417468804; 
 Wed, 19 Mar 2025 13:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQM0CWcf+bPSUMFV/GGqml/CSjF9pkqpPric+QbbFN6aJFMFtHGZjlVQ24oyANHSE4IK1Pw==
X-Received: by 2002:a5d:6d0f:0:b0:391:98b:e5b3 with SMTP id
 ffacd0b85a97d-3997957c8a5mr887248f8f.14.1742417468319; 
 Wed, 19 Mar 2025 13:51:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb9ccsm22254913f8f.96.2025.03.19.13.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 13:51:07 -0700 (PDT)
Message-ID: <88766804-2004-476f-a437-c161cc04ab2a@redhat.com>
Date: Wed, 19 Mar 2025 21:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 19/25] rust: pl011: switch to safe chardev operation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250309103120.1116448-1-pbonzini@redhat.com>
 <20250309103120.1116448-20-pbonzini@redhat.com>
 <CAFEAcA_orQ2Na9+MWnbyScNjQsDQBKB=s3c8D86FUE=q_1Mkaw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_orQ2Na9+MWnbyScNjQsDQBKB=s3c8D86FUE=q_1Mkaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/19/25 20:25, Peter Maydell wrote:
> On Sun, 9 Mar 2025 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Switch bindings::CharBackend with chardev::CharBackend.  This removes
>> occurrences of "unsafe" due to FFI and switches the wrappers for receive,
>> can_receive and event callbacks to the common ones implemented by
>> chardev::CharBackend.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Hi -- this commit seems to have broken use of the PL011 in
> boards/SoCs that directly embed it in their state structs, so
> "qemu-system-arm -M raspi2b -display none" now asserts on startup.
> 
> The Rust PL011's state struct size is now larger than the
> C state struct size, so it trips the assert in the QOM code
> that we didn't try to initialize a type into less memory than
> it needs. (I don't understand *why* the type size has changed,
> because this commit doesn't at first glance seem to be adding
> anything to the state struct...but it definitely goes up from
> 0x540 to 0x550.)

Thanks very much for reporting this.

The reason why it changes is that it switches the imported symbol from 
bindings::CharBackend (the C struct) to chardev::CharBackend which has 
two extra values in it (a count and some debugging info to provide 
better backtraces on error).  It is guaranteed to _start_ with a 
bindings::CharBackend, which is helpful for the qdev property, but it's 
bigger.

I don't think there's a good fix other than not using an embedded PL011, 
since you probably would not have that option available when using a 
device without a Rust equivalent.

Paolo

> (It would be good if we had a compile time check that the state
> struct sizes matched between Rust and C, rather than having it
> only be caught in runtime asserts. This does cause failures in
> check-functional, at least, so it's not completely untested.)
> 
> Here's the repro and gdb backtrace:
> 
> $ gdb --args ./build/rust/qemu-system-arm -M raspi2b -display none
> [...]
> **
> ERROR:../../qom/object.c:562:object_initialize_with_type: assertion
> failed: (size >= type->instance_size)
> Bail out! ERROR:../../qom/object.c:562:object_initialize_with_type:
> assertion failed: (size >= type->instance_size)
> 
> Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
> Download failed: Invalid argument.  Continuing without source file
> ./nptl/./nptl/pthread_kill.c.
> __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimised
> out>) at ./nptl/pthread_kill.c:44
> warning: 44     ./nptl/pthread_kill.c: No such file or directory
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=0, signo=6,
> threadid=<optimised out>) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=<optimised out>) at
> ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=<optimised out>,
> signo=signo@entry=6) at ./nptl/pthread_kill.c:89
> #3  0x00007ffff4a4527e in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/posix/raise.c:26
> #4  0x00007ffff4a288ff in __GI_abort () at ./stdlib/abort.c:79
> #5  0x00007ffff6e58f5b in g_assertion_message
>      (domain=domain@entry=0x0, file=file@entry=0x55555678fdeb
> "../../qom/object.c", line=line@entry=562,
> func=func@entry=0x5555567906d0 <__func__.33>
> "object_initialize_with_type", message=message@entry=0x555557f7f400
> "assertion failed: (size >= type->instance_size)") at
> ../../../glib/gtestutils.c:3331
> #6  0x00007ffff6ec1a97 in g_assertion_message_expr
>      (domain=0x0, file=0x55555678fdeb "../../qom/object.c", line=562,
> func=0x5555567906d0 <__func__.33> "object_initialize_with_type",
> expr=<optimised out>) at ../../../glib/gtestutils.c:3357
> #7  0x0000555556188bc6 in object_initialize_with_type
> (obj=0x555557d4e190, size=1344, type=0x555557a0bd40) at
> ../../qom/object.c:562
> #8  0x0000555556188cb5 in object_initialize (data=0x555557d4e190,
> size=1344, typename=0x5555566d9142 "pl011")
>      at ../../qom/object.c:578
> #9  0x0000555556188e3d in object_initialize_child_with_propsv
>      (parentobj=0x555557d45710, propname=0x5555566d9148 "uart0",
> childobj=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011",
> errp=0x5555578636f8 <error_abort>, vargs=0x7fffffffd360) at
> ../../qom/object.c:608
> #10 0x0000555556188db6 in object_initialize_child_with_props
>      (parentobj=0x555557d45710, propname=0x5555566d9148 "uart0",
> childobj=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011",
> errp=0x5555578636f8 <error_abort>) at ../../qom/object.c:591
> #11 0x0000555556188f3b in object_initialize_child_internal
>      (parent=0x555557d45710, propname=0x5555566d9148 "uart0",
> child=0x555557d4e190, size=1344, type=0x5555566d9142 "pl011")
>      at ../../qom/object.c:645
> #12 0x0000555555d446ea in raspi_peripherals_base_init
> (obj=0x555557d45710) at ../../hw/arm/bcm2835_peripherals.c:100
> #13 0x0000555556188639 in object_init_with_type (obj=0x555557d45710,
> ti=0x5555579d4af0) at ../../qom/object.c:428
> #14 0x000055555618861b in object_init_with_type (obj=0x555557d45710,
> ti=0x5555579d4950) at ../../qom/object.c:424
> #15 0x0000555556188c49 in object_initialize_with_type
> (obj=0x555557d45710, size=597040, type=0x5555579d4950)
>      at ../../qom/object.c:570
> #16 0x0000555556188cb5 in object_initialize (data=0x555557d45710,
> size=597040, typename=0x555556738ca5 "bcm2835-peripherals")
>      at ../../qom/object.c:578
> #17 0x0000555556188e3d in object_initialize_child_with_propsv
>      (parentobj=0x555557d34760, propname=0x555556738cb9 "peripherals",
> childobj=0x555557d45710, size=597040, type=0x555556738ca5
> "bcm2835-peripherals", errp=0x5555578636f8 <error_abort>,
> vargs=0x7fffffffd630) at ../../qom/object.c:608
> #18 0x0000555556188db6 in object_initialize_child_with_props
>      (parentobj=0x555557d34760, propname=0x555556738cb9 "peripherals",
> childobj=0x555557d45710, size=597040, type=0x555556738ca5
> "bcm2835-peripherals", errp=0x5555578636f8 <error_abort>) at
> ../../qom/object.c:591
> #19 0x0000555556188f3b in object_initialize_child_internal
>      (parent=0x555557d34760, propname=0x555556738cb9 "peripherals",
> child=0x555557d45710, size=597040, type=0x555556738ca5
> "bcm2835-peripherals") at ../../qom/object.c:645
> #20 0x0000555555f07080 in bcm283x_init (obj=0x555557d34760) at
> ../../hw/arm/bcm2836.c:49
> #21 0x0000555556188639 in object_init_with_type (obj=0x555557d34760,
> ti=0x5555579af8a0) at ../../qom/object.c:428
> #22 0x000055555618861b in object_init_with_type (obj=0x555557d34760,
> ti=0x5555579af6e0) at ../../qom/object.c:424
> #23 0x0000555556188c49 in object_initialize_with_type
> (obj=0x555557d34760, size=666592, type=0x5555579af6e0)
>      at ../../qom/object.c:570
> #24 0x0000555556188cb5 in object_initialize (data=0x555557d34760,
> size=666592, typename=0x555556739030 "bcm2836")
>      at ../../qom/object.c:578
> #25 0x0000555556188e3d in object_initialize_child_with_propsv
>      (parentobj=0x555557d34500, propname=0x55555673917b "soc",
> childobj=0x555557d34760, size=666592, type=0x555556739030 "bcm2836",
> errp=0x5555578636f8 <error_abort>, vargs=0x7fffffffd8f0) at
> ../../qom/object.c:608
> #26 0x0000555556188db6 in object_initialize_child_with_props
>      (parentobj=0x555557d34500, propname=0x55555673917b "soc",
> childobj=0x555557d34760, size=666592, type=0x555556739030 "bcm2836",
> errp=0x5555578636f8 <error_abort>) at ../../qom/object.c:591
> #27 0x0000555556188f3b in object_initialize_child_internal
>      (parent=0x555557d34500, propname=0x55555673917b "soc",
> child=0x555557d34760, size=666592, type=0x555556739030 "bcm2836")
>      at ../../qom/object.c:645
> #28 0x0000555555f0859b in raspi_machine_init (machine=0x555557d34500)
> at ../../hw/arm/raspi.c:313
> #29 0x00005555559d4674 in machine_run_board_init
> (machine=0x555557d34500, mem_path=0x0, errp=0x7fffffffda90)
>      at ../../hw/core/machine.c:1680
> #30 0x0000555555d8615b in qemu_init_board () at ../../system/vl.c:2709
> #31 0x0000555555d8650c in qmp_x_exit_preconfig (errp=0x555557863700
> <error_fatal>) at ../../system/vl.c:2805
> #32 0x0000555555d891bf in qemu_init (argc=5, argv=0x7fffffffde48) at
> ../../system/vl.c:3838
> #33 0x000055555634c832 in main (argc=5, argv=0x7fffffffde48) at
> ../../system/main.c:68
> (gdb) frame 7
> #7  0x0000555556188bc6 in object_initialize_with_type
> (obj=0x555557d4e190, size=1344, type=0x555557a0bd40) at
> ../../qom/object.c:562
> 562         g_assert(size >= type->instance_size);
> (gdb) print *type
> $2 = {name = 0x555557a0bec0 "pl011", class_size = 208, instance_size =
> 1360, instance_align = 16,
>    class_init = 0x55555634ede0
> <qemu_api::qom::rust_class_init<pl011::device::PL011State>>,
> class_base_init = 0x0, class_data = 0x0,
>    instance_init = 0x55555634f0f0
> <qemu_api::qom::rust_instance_init<pl011::device::PL011State>>,
>    instance_post_init = 0x55555634f1e0
> <qemu_api::qom::rust_instance_post_init<pl011::device::PL011State>>,
>    instance_finalize = 0x55555634eb40
> <qemu_api::qom::drop_object<pl011::device::PL011State>>, abstract =
> false,
>    parent = 0x555557a0bee0 "sys-bus-device", parent_type =
> 0x55555798c650, class = 0x555557a72370, num_interfaces = 0, interfaces
> = {
>      {typename = 0x0} <repeats 32 times>}}
> (gdb) print /x type->instance_size
> $3 = 0x550
> (gdb) print /x size
> $4 = 0x540
> 
> thanks
> -- PMM
> 
> 


