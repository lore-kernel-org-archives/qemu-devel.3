Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EC1C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 16:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVwTx-0007IS-MT; Fri, 02 Feb 2024 11:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwTv-0007I1-Na
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:33:35 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwTt-0007d1-Ti
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:33:35 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so3354540a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706891611; x=1707496411; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LdZ7rTnVWaosibzs/+L1FpeFFK86dFXb7hh0F2lbe0=;
 b=XTnVzl/iGEWYqlmUCETpdhHdrfLpwp8SMkp+E8kJyt/2NrX6u2HP1kyeahc7bsKbMh
 nOZJrD9Kaxb+qprJD20MzJ3FcY0T5kzCymClqSpVKY0bHLWESjUgkjVSenr3Wsoi0/fK
 Kd2GOv9+wpc9EcK/bWzG//govE9S1ukLDZhP9Z3zOyPBU68O7jFQAb09hTSqpTpnP3EM
 DtCTdzanOcNXVfnFOIKD85QIOYxhehHebLF0pf39fUyUel9edn8uoJqVWC5iPhsBzryR
 8hEZOGIYfEwexYQsPM3LDH58hTmJPKZRuBmXyyJPbBMW5PjK3bIJ0Ux+haCcLiMR8dPt
 ubTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706891611; x=1707496411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LdZ7rTnVWaosibzs/+L1FpeFFK86dFXb7hh0F2lbe0=;
 b=FZF5ldoCKuMOXpMlhq8sINd8Utg2hQY0vrkLZA0cPtjhmAuhr3Medlvnk58RDfNi3j
 rCpUOmAxHn35IsJ744Ns7EpkINo9M+TjaJxFTSY1MJmZ3CHpa1O7ck+eV+/vPqcp7OYX
 kB8/PMRTo+ubdaRJvGn0UUc2vT1vtFb/xJfsTOyCcohHZihF4avaMOmFZu/heP2a23Qy
 NL7SKclou1WKnvJJj2tGmaqtSsXxHV+JhidqTv21Jq8n4wDxudT00S7VXfO2wKLb+npa
 w3A+2B7kmGn8+ajU/1vuuUOOSRl2tcyOcqStrCt00oS9UilmgFTSylwvtpBWHNzoOToj
 9TMA==
X-Gm-Message-State: AOJu0YxXKkQOJvZ50TNl3K4gjy4a8+gbwjyT8o1JJgyAJrtNjRnHJq3T
 MeLvrmcTlnVxzYEU7L77azvLnSm7U9Hw+FlOkEclwipO3tkFe9yf5eGLOfvGI472NEwKvB2KHHW
 U63m4Upp6LZwtlE8sSVRIEbvPD3a4xpofyJCailOUm/ZdX6wI
X-Google-Smtp-Source: AGHT+IEkuQlF2nzi7pqzt6rtEWIlxA9lyO3nPuKmyFQIY/i7wWrNdMAS4XMS4MFp2yEFCWNSw9QDPeR5Y8FvIiylZl8=
X-Received: by 2002:aa7:d71a:0:b0:55f:fd77:7b2d with SMTP id
 t26-20020aa7d71a000000b0055ffd777b2dmr141937edq.5.1706891611313; Fri, 02 Feb
 2024 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com> <20240202162633.0000453c@huawei.com>
In-Reply-To: <20240202162633.0000453c@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:33:20 +0000
Message-ID: <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 16:26, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> New exciting trace...
> Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffff4efe6c0 (LWP 16503)]
> __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> Download failed: Invalid argument.  Continuing without source file ./nptl/./nptl/pthread_kill.c.
> 44      ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
> #3  0x00007ffff77c43b6 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> #5  0x00007ffff7b2ed1e in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #6  0x00007ffff7b9622e in g_assertion_message_expr () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
> #8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
> #9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
> #10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
> #11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> #12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> #13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
> #14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
> #15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
> #16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
> #17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
> #18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
> #19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
> #20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
> #21 0x0000555555ca2c61 in mmu_lookup (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1803
> #22 0x0000555555ca3165 in do_ld4_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2416
> #23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=0, oi=32, addr=18446741874686299840, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
> #24 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555578e3470, addr=addr@entry=18446741874686299840, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:294
> #25 0x0000555555bb6cdd in do_interrupt64 (is_hw=1, next_eip=18446744072399775809, error_code=0, is_int=0, intno=236, env=0x5555578e3470) at ../../target/i386/tcg/seg_helper.c:889
> #26 do_interrupt_all (cpu=cpu@entry=0x5555578e0cb0, intno=236, is_int=is_int@entry=0, error_code=error_code@entry=0, next_eip=next_eip@entry=0, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1130
> #27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=env@entry=0x5555578e3470, intno=<optimized out>, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1162
> #28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=0x5555578e0cb0, interrupt_request=<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper.c:197
> #29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=<synthetic pointer>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844
> #30 cpu_exec_loop (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:951
> #31 0x0000555555c94791 in cpu_exec_setjmp (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
> #32 0x0000555555c94f7c in cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:1055
> #33 0x0000555555cb9043 in tcg_cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops.c:76
> #34 0x0000555555cb91a0 in mttcg_cpu_thread_fn (arg=arg@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> #35 0x0000555555e57270 in qemu_thread_start (args=0x555557956000) at ../../util/qemu-thread-posix.c:541
> #36 0x00007ffff78176ba in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:444
> #37 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>

Here we are trying to take an interrupt. This isn't related to the
other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
it's called with the BQL not held, but in fact there are some
situations where we call into the memory subsystem and we do
already have the BQL.

-- PMM

