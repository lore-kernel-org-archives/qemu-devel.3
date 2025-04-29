Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1364C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9scM-0003n3-JM; Tue, 29 Apr 2025 17:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9scK-0003mY-S2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:35:52 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9scJ-0000hX-4s
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:35:52 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4c30a4bcceeso170926137.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745962550; x=1746567350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvDdc3EwXH5N/XlcQF9kgiKHTylaioIMBI9JnLnXtXw=;
 b=UEgSpVqsvsOrKofhuOD9mQlJA09Ld8apn+pNFlHwZNNEcahUVDSwlbcFki+s1rdua1
 E08aKczJF5MRKhFRg/4/QxWqw0NM1hGYtHEy9qMRAjxWxC0bXzsomrLRcxXxDuB6czcC
 Uh0j7cG850E6Slf1SfqQXkTo5MHTIRj5GyzqqPod8W76VxYEo8jy26i9HZU5MgH+Dg8h
 3DU1SszIyxN+ZMx/I+Z0Oda+NkDbOfZfUxXsarOyNmvJghz41Ul7zzcW5XM6H8+May1l
 2jDaiSN888dJJF2nHL5sfuCDP0Omi+JpVPufF7Hv4LDup5P39bHdUdiG6k31T2nCkBV4
 +BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745962550; x=1746567350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvDdc3EwXH5N/XlcQF9kgiKHTylaioIMBI9JnLnXtXw=;
 b=hcytoZaT94yjZc6+GzTKkV5i5HYyaP2aVeXXW0UVnWBWSoaaksmfrOaD5UMKLvvHHz
 3PxiiiAPCwmwoBq6zWbDUghX8PXT3KlC83UWfMi4NKI/QhXn3J4e5efT68dLBQG3hIYl
 4YevFo03dBWEgOP0j6wJKswbimNkT5H/uZtFUn2/xYd6Wc4pvIsmdRGPs1bfk3THqFer
 QLny4EMJ9mxDdMwHqNYIkKzWLRoci9+z6vQED5N/783HL9ZwB2Xu3hLfmn110qnSDOqC
 RGg5xZVJvb6quOAK9xKKCOsdwe3R8uqc/nS+T/eG2YGKrS54rs1Dmda3uX67VUlfCipa
 sNOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMPyKdnNTtGyBc0iOzVAEGeyuJc8uHDbrxDCQFyatSikpzmzL2H768UFUCUSdPwz0NEcWpBzZO4Dte@nongnu.org
X-Gm-Message-State: AOJu0Yxp+P/Zh6wc+gNoubrhybHBZ4AdfkWYbrUPTK+PXTTDOOI/u7ZP
 mGv+nqVwLom/W4Akne+2dSzbCY8utsXsL2CKZlBI5Fr2hno+tuFYBBXWrTgbtWAibCIM8OPAJIU
 YY9c2vJaXiRl0pMsPTaD3kKbk6JL9pjeo
X-Gm-Gg: ASbGnctOPIGHC2IQOQ5hEmlIfvyTJnhucjibmdqr0Lw29cUbzhyi74jton5kvy78UX4
 a6mZLQU/jgyzW6G23YTJjGTv5gPFH1n7IIl4mBtPaQK9qAlzQ+n1VQpku1GTvqgljOzdNsUj73K
 Cz4lzNTYpdM/umBGwg1PaEZ3Y22GNdfs1C7ny77mvlLgVYJGgpN8VtDmELQinqWJM=
X-Google-Smtp-Source: AGHT+IGVbqgzPvSHrTYGBAnrmh4e+A3PK7C6AyXyJqKsoE3PSdWY41EdRysnrE6UVuOfUAlwHD8wuQ77TIX46XBp97M=
X-Received: by 2002:a05:6102:c12:b0:4ba:974c:891e with SMTP id
 ada2fe7eead31-4dad376dc90mr676895137.17.1745962549650; Tue, 29 Apr 2025
 14:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-67-richard.henderson@linaro.org>
 <20250425183524.00000b28@huawei.com>
In-Reply-To: <20250425183524.00000b28@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Apr 2025 07:35:23 +1000
X-Gm-Features: ATxdqUEM458_V82H5APnbvVtxrxkSnRlK8oGlqxEm40is_1yXoo1haD0Ep9M7p0
Message-ID: <CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to
 slow flags
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Apr 26, 2025 at 3:36=E2=80=AFAM Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> On Tue, 22 Apr 2025 12:26:55 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
>
> > Recover two bits from the inline flags.
>
>
> Hi Richard,
>
> Early days but something (I'm fairly sure in this patch) is tripping up m=
y favourite
> TCG corner case of running code out of MMIO memory (interleaved CXL memor=
y).
>
> Only seeing it on arm64 tests so far which isn't upstream yet..
> (guess what I was getting ready to post today)
>
> Back trace is:
>
> #0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=3D0x555557ee1=
9b0, addr=3D18442241572520067072, val=3D18446744073701163007, oi=3D8244, re=
taddr=3D<optimized out>) at ../../accel/tcg/atomic_template.h:140
> #1  0x00007fffb6894125 in code_gen_buffer ()
> #2  0x0000555555fc4c46 in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557ededf0, =
itb=3Ditb@entry=3D0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=3Dtb_=
exit@entry=3D0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
> #3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4bfb744, las=
t_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffb6894000 <code=
_gen_buffer+200511443>, cpu=3D0x555557ededf0) at ../../accel/tcg/cpu-exec.c=
:904
> #4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x555557ededf0, sc=3Dsc@entry=3D0x7f=
fff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
> #5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555557eded=
f0, sc=3Dsc@entry=3D0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
> #6  0x0000555555fc5f6c in cpu_exec (cpu=3Dcpu@entry=3D0x555557ededf0) at =
../../accel/tcg/cpu-exec.c:1061
> #7  0x0000555556146ac3 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x555557ededf0)=
 at ../../accel/tcg/tcg-accel-ops.c:81
> #8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555557=
ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
> #9  0x00005555561f6450 in qemu_thread_start (args=3D0x555557f8f430) at ..=
/../util/qemu-thread-posix.c:541
> #10 0x00007ffff7750aa4 in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:447
> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:78
>
> I haven't pushed out the rebased tree yet making this a truly awful bug r=
eport.
>
> The pull request you sent with this in wasn't bisectable so this was a bi=
t of a guessing
> game. I see the seg fault only after this patch.

I see the same thing with some RISC-V tests. I can provide the test
images if you want as well

build/qemu-system-riscv64 -machine virt -cpu rv64,h=3Dfalse -m 1G \
    -serial mon:stdio -serial null -nographic \
    -append "root=3D/dev/vda ro" \
    -netdev user,id=3Dnet0 -device virtio-net-device,netdev=3Dnet0 \
    -smp 4 -d guest_errors \
    -bios none \
    -device loader,file=3D./images/qemuriscv64/buildroot/Image,addr=3D0x802=
00000 \
    -kernel ./images/qemuriscv64/buildroot/fw_jump.elf \
    -drive id=3Ddisk0,file=3D./images/qemuriscv64/buildroot/rootfs.ext2,if=
=3Dnone,format=3Draw
\
    -device virtio-blk-device,drive=3Ddisk0


#0  0x000055555598b0f1 in cpu_atomic_xchgl_le_mmu (env=3D0x5555567ff290,
addr=3D33554444, val=3D0, oi=3D3619, retaddr=3D<optimized out>)
   at ../accel/tcg/atomic_template.h:111
#1  0x00007fffb2c5e537 in code_gen_buffer ()
#2  0x000055555597c661 in cpu_tb_exec
   (cpu=3Dcpu@entry=3D0x5555567fc6d0, itb=3Ditb@entry=3D0x7fffb2c5e400
<code_gen_buffer+113632211>, tb_exit=3Dtb_exit@entry=3D0x7fff47ffe764)
   at ../accel/tcg/cpu-exec.c:453
#3  0x000055555597cb4a in cpu_loop_exec_tb
   (cpu=3D0x5555567fc6d0, tb=3D0x7fffb2c5e400 <code_gen_buffer+113632211>,
pc=3D<optimized out>, last_tb=3D<synthetic pointer>,
tb_exit=3D0x7fff47ffe764)
   at ../accel/tcg/cpu-exec.c:903
#4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x5555567fc6d0,
sc=3Dsc@entry=3D0x7fff47ffe810) at ../accel/tcg/cpu-exec.c:1017
#5  0x000055555597d23d in cpu_exec_setjmp
(cpu=3Dcpu@entry=3D0x5555567fc6d0, sc=3Dsc@entry=3D0x7fff47ffe810) at
../accel/tcg/cpu-exec.c:1034
#6  0x000055555597d909 in cpu_exec (cpu=3Dcpu@entry=3D0x5555567fc6d0) at
../accel/tcg/cpu-exec.c:1060
#7  0x0000555555af1c62 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x5555567fc6d0)
at ../accel/tcg/tcg-accel-ops.c:81
#8  0x0000555555af2012 in mttcg_cpu_thread_fn (arg=3D0x5555567fc6d0) at
../accel/tcg/tcg-accel-ops-mttcg.c:94
#9  0x0000555555b956c7 in qemu_thread_start (args=3D0x5555569e8da0) at
../util/qemu-thread-posix.c:541
#10 0x00007ffff77f2f14 in start_thread () at /lib64/libc.so.6
#11 0x00007ffff7875aac in __clone3 () at /lib64/libc.so.6

Alistair

