Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C97E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 23:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTURj-0008Vg-Fq; Thu, 02 Jan 2025 18:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTURW-0008MN-1F
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 18:17:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tTURS-0002CI-6V
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 18:17:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso80563375e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735859844; x=1736464644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5ct0UUSUaW7Yf/6vwIKU0AUc6/tsUP0dCNAZT40U6c=;
 b=LFNWZMaDw+ANVXvsiVnzp3k1iteYKDzaGBd47B7QmEdnuq/MFms+5gswNxtnC1CsJS
 WNxt4lBxyJ8uyGEMG93nmryy5w1LRPEbWOFP6SzSLWjnuGC/UHZ5fO8O0QDa3LVOrJuO
 rixbmii2DD1cROxfDwdLj2uhAyIJTL6ti8t5DUXhnD9b2XsFGmE53FaIJwqhIPl2SfWk
 EVvYtNHZWsbOV+Mn/HwQqEViEXQpUG8vZUq3Fworerx6xE/IDhi4CvmMeoKTKGIJQ0ZC
 7PO4ki2rhRTLyOxPHoe4H1Y3CH3FZInjx1HIMx5uM/JwA+c1dUDybN9ET7D9x0tb5zKH
 NRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735859844; x=1736464644;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5ct0UUSUaW7Yf/6vwIKU0AUc6/tsUP0dCNAZT40U6c=;
 b=GnFmRndwj7+1jyexvIu9fFTFNAsJINNQvHNG3yRVx2L7HqxMv4p/9fTv1syi4hpu+/
 TuNBZhZ9s4Xm+KmbZdMWm8JOzh6wRAl+eSU6QcTguMWEPUcdHWXgAcXlvEEMTqmdbu3d
 mPz6RAvbFJrnzEBev/4Rzbioaavbn/Y7iIZlNwqHu/L8ZH5keLnxHflxupMn8P01SuyL
 8OuBX4HsHX699er9yGbArBwDu7yems62xk8gAadYStkRYFuNZOjL7qhygEZ3qzYCHz4h
 KHd+Cl0UPy5H8SGTXr9eghihRilYrPjmuJGqonQ9KRKphtK+u0c421+OJCtFm1eZDr6h
 LPdA==
X-Gm-Message-State: AOJu0YzaxzFFUg4iNwiJVakg6fq7MieIV1RnaMZYMcm9/hCxV6v2m7H/
 y0w5JzyW4UWM3EU4+S3PeI3X9UHt73XP/q+AxMwSsPPRlQsbB7jWRvGckXAiruo=
X-Gm-Gg: ASbGncvWI2QPyqHNLzMiFnKmZacofa7WSUDk6gjAAcxynm886Z9elYFm+EKDZjEwj5/
 FZ0K7XMlFG0PAYsMjga9rsNfq5CJTvwyPtknrtYQd54VeqKxTxZnRNBsF+vxImdTozFA63rZ6jJ
 AJ+R4Jg6zalN0cDHF002guN8f5qbHCPJxijAm8zDV399VagqOjYlmycq2fdM9yG55lbLPhvqjrP
 UAhrIA1hce0L79ExWWCwjWO2PLumFjWbtJrhSHfpjLEgatW7kChIRo=
X-Google-Smtp-Source: AGHT+IGTU8tCl/Ao480y8x5qal9hyDB3t63hi9D+c8tRGvA5EcQl8pPJdg0PGHtaDHhWlmbEx/21Uw==
X-Received: by 2002:a05:600c:45cd:b0:434:a7b6:10e9 with SMTP id
 5b1f17b1804b1-436686462f9mr432060405e9.17.1735859844237; 
 Thu, 02 Jan 2025 15:17:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b287sm497131385e9.29.2025.01.02.15.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 15:17:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0ED355F8C1;
 Thu,  2 Jan 2025 23:17:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Liu Jaloo <liu.jaloo@gmail.com>
Cc: qemu-devel@nongnu.org,  joel@jms.id.au,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: which test.hex is right for qemu-microbit?
In-Reply-To: <CAOYM0N2sXVBkPz64J44kFGPhdSq+qvheQD-yy53trAjv0NDh0w@mail.gmail.com>
 (Liu Jaloo's message of "Thu, 2 Jan 2025 13:49:59 +0800")
References: <CAOYM0N2sXVBkPz64J44kFGPhdSq+qvheQD-yy53trAjv0NDh0w@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 02 Jan 2025 23:17:21 +0000
Message-ID: <878qrsvm9q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Liu Jaloo <liu.jaloo@gmail.com> writes:

> in qemu branch statble-9.2=20
>
>  $ ./build/qemu-system-arm -M microbit -device loader,file=3D/path/to/hea=
rt-hearts-makecode.hex=20=20
>
>  Segmentation fault

Is it really a hex file?

The code in question is generic_loader_realize() and it falls back
through a series of steps:

    if (s->file) {
        AddressSpace *as =3D s->cpu ? s->cpu->as :  NULL;

        if (!s->force_raw) {
            size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, N=
ULL,
                               NULL, big_endian, 0, 0, 0, as);

            if (size < 0) {
                size =3D load_uimage_as(s->file, &entry, NULL, NULL, NULL, =
NULL,
                                      as);
            }

            if (size < 0) {
                size =3D load_targphys_hex_as(s->file, &entry, as);
            }
        }
>
>=20=20
> about the error, gdb backtrace like this:
>
>  bash-5.1$ gdb ./build/qemu-system-arm
>  GNU gdb (GDB) 11.2
>  Copyright (C) 2022 Free Software Foundation, Inc.
>  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
>  This is free software: you are free to change and redistribute it.
>  There is NO WARRANTY, to the extent permitted by law.
>  Type "show copying" and "show warranty" for details.
>  This GDB was configured as "x86_64-slackware-linux".
>  Type "show configuration" for configuration details.
>  For bug reporting instructions, please see:
>  <https://www.gnu.org/software/gdb/bugs/>.
>  Find the GDB manual and other documentation resources online at:
>      <http://www.gnu.org/software/gdb/documentation/>.
>
>  For help, type "help".
>  Type "apropos word" to search for commands related to "word"...
>  Reading symbols from ./build/qemu-system-arm...
>  warning: File "/home/jaloo/slackware/qemu/qemu/.gdbinit" auto-loading ha=
s been declined by your `auto-load safe-path'
>  set to "$debugdir:$datadir/auto-load".
>  To enable execution of this file add
>          add-auto-load-safe-path /home/jaloo/slackware/qemu/qemu/.gdbinit
>  line to your configuration file "/home/jaloo/.config/gdb/gdbinit".
>  To completely disable this security protection add
>          set auto-load safe-path /
>  line to your configuration file "/home/jaloo/.config/gdb/gdbinit".
>  For more information about this security protection see the
>  --Type <RET> for more, q to quit, c to continue without paging--
>  "Auto-loading safe path" section in the GDB manual.  E.g., run from the =
shell:
>          info "(gdb)Auto-loading safe path"
>  (gdb) r -M microbit -device loader,file=3D../microbit/heart-hearts-makec=
ode.hex
>  Starting program: /home/jaloo/slackware/qemu/qemu/build/qemu-system-arm =
-M microbit -device
>  loader,file=3D../microbit/heart-hearts-makecode.hex
>  [Thread debugging using libthread_db enabled]
>  Using host libthread_db library "/lib64/libthread_db.so.1".
>  [New Thread 0x7ffff228d640 (LWP 2380)]
>  [New Thread 0x7ffff190a640 (LWP 2382)]
>
>  Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
>  0x00007ffff60e53d1 in __memmove_avx_unaligned_erms () from /lib64/libc.s=
o.6
>  (gdb) bt
>  #0  0x00007ffff60e53d1 in __memmove_avx_unaligned_erms () at /lib64/libc=
.so.6
>  #1  0x0000555556037ed9 in address_space_write_rom_internal
>      (as=3D0x555557afe160, addr=3D0, attrs=3D..., ptr=3D0x555557de8290, l=
en=3D1313804, type=3DWRITE_DATA) at .
>  ./system/physmem.c:3040
>  #2  0x0000555556037fa7 in address_space_write_rom
>      (as=3D0x555557afe160, addr=3D0, attrs=3D..., buf=3D0x555557de8290, l=
en=3D1313804)
>      at ../system/physmem.c:3060
>  #3  0x0000555555977704 in rom_reset (unused=3D0x0) at ../hw/core/loader.=
c:1252
>  #4  0x0000555555986644 in legacy_reset_hold
>      (obj=3D0x5555576c12c0, type=3DRESET_TYPE_COLD) at ../hw/core/reset.c=
:76
>  #5  0x00005555560a3938 in resettable_phase_hold
>      (obj=3D0x5555576c12c0, opaque=3D0x0, type=3DRESET_TYPE_COLD)
>      at ../hw/core/resettable.c:162
>  #6  0x00005555560a2049 in resettable_container_child_foreach
>      (obj=3D0x555557a2a9f0, cb=3D0x5555560a3820 <resettable_phase_hold>, =
opaque=3D0x0, type=3DRESET_TYPE_COLD) at .
>  ./hw/core/resetcontainer.c:54
>  #7  0x00005555560a3687 in resettable_child_foreach
>      (rc=3D0x5555578ced10, obj=3D0x555557a2a9f0, cb=3D0x5555560a3820 <res=
ettable_phase_hold>, opaque=3D0x0,
>  type=3DRESET_TYPE_COLD) at ../hw/core/resettable.c:92
>  #8  0x00005555560a38dd in resettable_phase_hold
>      (obj=3D0x555557a2a9f0, opaque=3D0x0, type=3DRESET_TYPE_COLD)
>      at ../hw/core/resettable.c:155
>  #9  0x00005555560a353c in resettable_assert_reset
>  --Type <RET> for more, q to quit, c to continue without paging--
>      (obj=3D0x555557a2a9f0, type=3DRESET_TYPE_COLD) at ../hw/core/resetta=
ble.c:58
>  #10 0x00005555560a3494 in resettable_reset
>      (obj=3D0x555557a2a9f0, type=3DRESET_TYPE_COLD) at ../hw/core/resetta=
ble.c:45
>  #11 0x000055555598696e in qemu_devices_reset (type=3DRESET_TYPE_COLD)
>      at ../hw/core/reset.c:176
>  #12 0x0000555555cf5826 in qemu_system_reset (reason=3DSHUTDOWN_CAUSE_NON=
E)
>      at ../system/runstate.c:527
>  #13 0x000055555597fb9d in qdev_machine_creation_done ()
>      at ../hw/core/machine.c:1689
>  #14 0x0000555555cfd197 in qemu_machine_creation_done
>      (errp=3D0x5555575be0e0 <error_fatal>) at ../system/vl.c:2690
>  #15 0x0000555555cfd30f in qmp_x_exit_preconfig
>      (errp=3D0x5555575be0e0 <error_fatal>) at ../system/vl.c:2720
>  #16 0x0000555555cffce8 in qemu_init (argc=3D5, argv=3D0x7fffffffdd08)
>      at ../system/vl.c:3753
>  #17 0x00005555562479f0 in main (argc=3D5, argv=3D0x7fffffffdd08)
>      at ../system/main.c:47
>
> according to docs/system/arm/nrf.rst
>
>  $ qemu-system-arm -M microbit -device loader,file=3Dtest.hex
>
> from the page https://microbit.org/projects/make-it-code-it/heart/ downlo=
ad the hex file :
>
>  wget https://microbit.org/downloads/heart-hearts-makecode.hex


Hmm it looks like its crashing after it loaded. But did it get to load_targ=
phys_hex_as?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

