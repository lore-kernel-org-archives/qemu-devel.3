Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D94DC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZdU-0001YP-4o; Thu, 27 Feb 2025 03:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZdS-0001Y9-2G; Thu, 27 Feb 2025 03:52:50 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnZdQ-00016h-8b; Thu, 27 Feb 2025 03:52:49 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so1069904a91.2; 
 Thu, 27 Feb 2025 00:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740646366; x=1741251166; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ujFaYe4TUypeC/SmoVj1IufzKJgfbMTG6FaXX45G50=;
 b=GtcAmLBS4o5DyciQ0zwvdW1CaDAMmoE/UpcdeIbCB6wBXCGA2p0OB4TjW4uQhqdMxY
 wFT++o1i8+IcrUeqA4HVAzz/n0nsNL4o1DlLMSrxBVlsHc3FOdX553vGBpEX7BjTYTmj
 22eFyuvX6YXuZLrjG419WQKPG8JO35+EQ5meeZAMGhBpGbG4wY4IcRlvuZPzu1zdCY0F
 0JG3TQvq6rHtL48U3LJYFpkTwWgVemO3P2DQO8ViTJbZSvVF48ihsM3+FUh1clfphucM
 hnez4/MNZxwxCLzZmVMutvwqqOP47aiK2UKaUTNCds6GMbLYETSr4994HPMNBCC1Gbrl
 tt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740646366; x=1741251166;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ujFaYe4TUypeC/SmoVj1IufzKJgfbMTG6FaXX45G50=;
 b=B6iHK0dHTby0cryUYLeGlBZ4NF1I2PHb1KFMvUa7ntCZOxotBLuOPTahYSoXg8woJ9
 zfct2lxrTGEJnEkj10gIprPGdw6rfHY8tiQ/DDPPv3NIcJuW6DfTuYDLXQfGBf3EntJA
 AbpvvXENve+CB0MCjhW6EABHRzVT7FKpBoXMu62fAFDq9/pYXQfSNeHMxUQewqbQq5T4
 QIa9vukt/15ygXlNa74uiLo+HXSiS+U1zcx8Nqjbtd+KIW2/VuaSR5FpxhC/cXPPmKjO
 M7Khzfz2+17KH76r9Dl2H1LkXJx+PTlLQPqMDBdcSXlZt17iyeKnRgxsbeFEZN3rx/DG
 3Hbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEqOemMmKkW2dzjRiSCBP/TWEONYqQzm5OKV02LOaJhFJwov+LX0kw296XUNC6brd+eH5KGtkeg6kR@nongnu.org
X-Gm-Message-State: AOJu0YzUv7YjVR1PfewSkbyt5D0ApKmaPQH6Dl+rmG5xHrzm+IR4scW4
 Eg1XMezVWNll+VGu5zX+ue+2n+nkQpNEigsIKZ7S/HN7WXbr3sE1
X-Gm-Gg: ASbGnctqD2sR6sY80v/2ScFa0QtrsSrR3kd+NOhBjV1wwfkBjnSpkPRxzAreDqk6Ygo
 5ErG9CDIUj530RGmDS9gweNJ4mmP6MUoHJMFqxE3Ryi/QPF9U7bkr5cCy6M8qMjU9EAPMWv4u8h
 8Dj6zlE4ShPCLPlOUWKBob3noGe0nmEC612uQs/SeBiJPdxJkNTE2ghfX/+G/k6vgJ/FA5/ReDF
 5DXPIsuThKTato3Bp8+t3FucYi5A6Jt1J90BWlEo+Bg6dV4czkL5ZPlIK4XoscVsjIy4A/y1hdS
 Ulv+oWYzPUyXkWIjsg==
X-Google-Smtp-Source: AGHT+IEeIFOOL+XZQnSSdME1wEMfFevAzCqb2F8wRSYyhZ20dhfoYfzajscH/y83CrBM9lyq1vJZyg==
X-Received: by 2002:a17:90b:3ece:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2fce8740b67mr39541144a91.29.1740646365881; 
 Thu, 27 Feb 2025 00:52:45 -0800 (PST)
Received: from localhost ([1.146.124.39]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea675336dsm1002397a91.7.2025.02.27.00.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:52:45 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 18:52:38 +1000
Message-Id: <D833MY4YIZIO.2WT22FPU95D09@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 6/6] hw/ppc: Enable Fadump for PSeries
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-7-adityag@linux.ibm.com>
 <D82WUV05QWZP.10KAOOHN6YFFP@gmail.com>
 <8108eb0d-7efe-4549-ba74-c7de50935dfe@linux.ibm.com>
In-Reply-To: <8108eb0d-7efe-4549-ba74-c7de50935dfe@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Feb 27, 2025 at 5:07 PM AEST, Aditya Gupta wrote:
> On 27/02/25 09:03, Nicholas Piggin wrote:
>
>> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>>> With all support in place, enable fadump by exporting the
>>> "ibm,configure-kernel-dump" RTAS call in the device tree.
>>>
>>> Presence of "ibm,configure-kernel-dump" tells the kernel that the
>>> platform (QEMU) supports fadump.
>>>
>>> Pass "fadump=3Don" to enable Linux to use firmware assisted dump.
>>>
>>> Logs of a linux boot with firmware assisted dump:
>>>
>>>      ./build/qemu-system-ppc64 -M pseries,x-vof=3Don --cpu power10 --sm=
p 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=3D=
on crashkernel=3D1G" -nographic
>>>      [    0.000000] random: crng init done
>>>      [    0.000000] fadump: Reserved 1024MB of memory at 0x000000400000=
00 (System RAM: 4096MB)
>>>      ...
>>>      [    1.084686] rtas fadump: Registration is successful!
>>>      ...
>>>      # cat /sys/kernel/debug/powerpc/fadump_region
>>>      CPU :[0x00000040000000-0x000000400013d3] 0x13d4 bytes, Dumped: 0x0
>>>      HPTE:[0x000000400013d4-0x000000400013d3] 0x0 bytes, Dumped: 0x0
>>>      DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000=
000, Dumped: 0x0 bytes
>>>
>>>      [0x000000fffff800-0x000000ffffffff]: cmdline append: ''
>>>      # echo c > /proc/sysrq-trigger
>>>
>>> The fadump boot after crash:
>>>
>>>      [    0.000000] rtas fadump: Firmware-assisted dump is active.
>>>      [    0.000000] fadump: Updated cmdline: debug fadump=3Don crashker=
nel=3D1G
>>>      [    0.000000] fadump: Firmware-assisted dump is active.
>>>      [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000=
000 for preserving crash data
>>>      ....
>>>      # file /proc/vmcore
>>>      /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 75=
00, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>>>
>>> Analysing the vmcore with crash-utility:
>>>
>>>            KERNEL: vmlinux-6.14-rc2
>>>          DUMPFILE: vmcore-a64dcfb451e2-nocma
>>>              CPUS: 4
>>>              DATE: Thu Jan  1 05:30:00 IST 1970
>>>            UPTIME: 00:00:30
>>>      LOAD AVERAGE: 0.74, 0.21, 0.07
>>>             TASKS: 94
>>>          NODENAME: buildroot
>>>           RELEASE: 6.14.0-rc2+
>>>           VERSION: #1 SMP Wed Feb 12 06:49:59 CST 2025
>>>           MACHINE: ppc64le  (1000 Mhz)
>>>            MEMORY: 4 GB
>>>             PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>>               PID: 270
>>>           COMMAND: "sh"
>>>              TASK: c000000009e7cc00  [THREAD_INFO: c000000009e7cc00]
>>>               CPU: 3
>>>             STATE: TASK_RUNNING (PANIC)
>>>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> This is very cool, nice work. Does it work with KVM? I think... probably
>> it could?
>
> Yes it does, atleast for crashing CPU :)
>
> But there are problems with reading the CPU regs, regs don't seem=20
> correct for non-crashing CPUs.
>
> Crash is able to work perfectly for the crashing CPU as of now (as the=20
> registers are stored by the kernel in that case).

You may need to call cpu_synchronize_state() in the CPU_FOREACH loop
before you read out the register state. Does that fix it?

>>
>> Are you able to add a functional test case for it? This is something
>> that people (including me) will forget to test...
>
> Sure, I will add a test case.
>
>
> Thanks for your reviews Nick.
>
> It might take few weeks for me to post another version, will see into=20
> the tests in qemu and arrange the code bit more nicely.

Yeah that's okay, I'm way behind with reviews and merging unfortunately
so may have to wait for next release, but I'm keen to get it merged when
we can. Sorry for the late review.

Thanks,
Nick

