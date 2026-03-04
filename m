Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D601EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 02:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbe4-0001Zv-3k; Tue, 03 Mar 2026 21:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1vxbdx-0001ZR-U1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:07:22 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1vxbdw-0002at-5h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:07:21 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-5ff10630b18so1944729137.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 18:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772590038; x=1773194838; darn=nongnu.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vnddJ1dU0jsRySyXHa3Oltw8L8oZe09VDB8l9emP4vg=;
 b=NFD0QjlYsQGyQMqEMnICaCkh3F2spmi/74NzXULeMy/sHZescHycxs6OfTfjT/p7Mg
 6SYb/2TUdtCDjFdFv7G9KW4qlFBK7XUHmiFNRzlDVg0cVkb1HNs3o12cTwKEmlpk48Ky
 mCT9veiTh/MvfJ73OSsIlUB0SBDyWic5SXbY3vBvRpTuvQYexPO7rTB2vpFLtyk5SVuG
 R6VW4B4kNc9JiWT/QlBarQ+yomiANDQ4ebzV+TJtkPaF6AW47NufgyS9T/HSL73DwnRm
 5pkq8CtvUEmNwMRi89HjpLQ2AYJZ261tA5N8WT3tK056Yfn2tKB4wovfvsVR9C+W1CxL
 zcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772590038; x=1773194838;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vnddJ1dU0jsRySyXHa3Oltw8L8oZe09VDB8l9emP4vg=;
 b=hraK2tmVY4yvPo0DfewD7Opqdx0Vtyul6wx5YAXy8pk9WRWhbEUe1koHWHPu2aCyeM
 fuKLIasF8snBCBgWvU1/D1DFjtU3XztYdbVZJaJ9BsWe6ZtCfg0hEePfmqoEnFppdsr+
 CDmdrde30o/W2NLWGdX14QoSGwDT6sqx+wnX2MFpYZ2xSfwGsEnWlJH78PSwx0mKYpH4
 90V8n/or+oyxAOflNgPz0Dd8knuQMkPUAqVdqd1+k+ZRZ9Zyt9yVZ+DyaW+H05pv82pN
 dshCfsWftaX9vJ42eftOzZaW4Ph8BlGIwJiVkJtR+ab/PTnr9+TB2wPVAPbOm9h7yb0E
 RhxA==
X-Gm-Message-State: AOJu0YxW0SocIFuH7+MJN1/fSREHhCcXGD79lpH/2UgTtx4QkyyUrsLH
 TQZF7xCJDCPdymnFuBfgLHkcq7QG/aRW+sqtkt7Ux5Yze/OhhUAvR9qUz10bYWNd91o=
X-Gm-Gg: ATEYQzyRWnKHQKj60iMvc283n15i8u69lVWpPUxdv1xQ6hWMw2YsCLaYJH/Mct/8v+7
 Py+3XyETH8WzrIf66KLXhpfmp5gePDQDY4R2gPqvZuLRPI/nSQYdgFmy6PViVfJa8Wk5C00Ranx
 KsFPJm8xYsxZ8/rN1jiEALvBQmbPKPxGng0Dp3vO6y6oIfik37OkN42OAyPgi7GUlpmtZvj7UkZ
 kLZMBuGnGzs3EhEDv9bKokpPMQgiKqDpl6gbJyGk02WlJICQOUXEpEaJKU40iqjmoTxn2usXMn3
 q/QRHKBeoSChcB8tSjRowa95IEJ+9a8YRKpdLx2kHB2Duf+Wl7kJsmojoqpQM230XjlMBilbTeI
 NqHoO5BLhRDPNyeMimu9ELz2qT2fW+hhZ3Va+1zBH0vKvbSGqPJKInzODl7dE5KL+j1SncQ84d6
 B6Mrltm2/RqB7u3ani2D6L5JL9QId6FZ5mSXFww2GJtNRR
X-Received: by 2002:a05:6102:3050:b0:5f7:24db:fdb8 with SMTP id
 ada2fe7eead31-5ffaaeec1bemr229182137.25.1772590038405; 
 Tue, 03 Mar 2026 18:07:18 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8083:f04c:42e3:5943:38f6])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ffa300c3f8sm1506831137.6.2026.03.03.18.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 18:07:17 -0800 (PST)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4 00/84] target/arm: Implement FEAT_GCS
In-Reply-To: <87tsv1fr54.fsf@linaro.org> (Thiago Jung Bauermann's message of
 "Sat, 28 Feb 2026 01:06:47 -0300")
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <87tsv1fr54.fsf@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Tue, 03 Mar 2026 23:07:15 -0300
Message-ID: <878qc8e4a4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=thiago.bauermann@linaro.org; helo=mail-vs1-xe2a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thiago Jung Bauermann <thiago.bauermann@linaro.org> writes:

> I tried using GCS in current QEMU trunk (commit d8a9d97317d0 "Merge tag
> 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into
> staging"), but I get this kernel oops with a simple program (attached)
> that just tries to enable GCS using prctl:
>
> [  226.334899] Unable to handle kernel paging request at virtual address fffff1ffc36c8008
> [  226.335033] Mem abort info:
> [  226.335088]   ESR = 0x0000000096000004
> [  226.335117]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  226.335137]   SET = 0, FnV = 0
> [  226.335153]   EA = 0, S1PTW = 0
> [  226.335172]   FSC = 0x04: level 0 translation fault
> [  226.335192] Data abort info:
> [  226.335208]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  226.335224]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  226.335241]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  226.335284] swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000dbe9b000
> [  226.335306] [fffff1ffc36c8008] pgd=10000000dcfcd003, p4d=0000000000000000
> [  226.335475] Internal error: Oops: 0000000096000004 [#1]  SMP
> [ 226.336917] Modules linked in: tpm_tis tpm_tis_core qrtr sha256 cfg80211 rfkill fuse
> dm_mod drm backlight ipv6 btrfs blake2b libblake2b xor xor_neon raid6_pq zstd_compress
> sm3_ce
> [  226.337746] CPU: 0 UID: 1000 PID: 950 Comm: simple-gcs Tainted: G   M                6.19.0 #2 PREEMPT
> [  226.337963] Tainted: [M]=MACHINE_CHECK
> [  226.338035] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202408-prebuilt.qemu.org 08/13/2024
> [  226.338281] pstate: 21402005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  226.338411] pc : __get_user_pages+0x4a4/0xc0c
> [  226.338889] lr : __get_user_pages+0x3fc/0xc0c
> [  226.338977] sp : ffff800080e236f0
> [  226.339042] x29: ffff800080e236f0 x28: fff00000c3c21e80 x27: 0000000000000000
> [  226.339203] x26: 0000000000000000 x25: fff00000c1a988c8 x24: 0000000000000000
> [  226.339327] x23: 0000ffffa3200000 x22: 000000000000000e x21: 0000000000000000
> [  226.339453] x20: fff00000c80bc300 x19: 0008000000000000 x18: 0000000000000000
> [  226.339573] x17: 0000000000000000 x16: ffff95c0712386b8 x15: 0000ffffa363bfff
> [  226.339699] x14: 0000000000000000 x13: 1ffe000018271e21 x12: fff00000c138f10c
> [  226.339824] x11: fff00000c138f100 x10: 0000000000000001 x9 : 0000000000000001
> [  226.339962] x8 : 00c800011b200f41 x7 : fff00000c138f108 x6 : 00000000000008c8
> [  226.340086] x5 : fffff1ffc36c8000 x4 : ffffc1ffc0000000 x3 : 0000000000000000
> [  226.340207] x2 : 0000000000104a00 x1 : 0040000000000841 x0 : 0040000000000800
> [  226.340392] Call trace:
> [  226.340554]  __get_user_pages+0x4a4/0xc0c (P)
> [  226.340701]  get_dump_page+0xe4/0x150
> [  226.340797]  dump_user_range+0x64/0x2e8
> [  226.340886]  elf_core_dump+0xbf8/0xe10
> [  226.340955]  vfs_coredump+0xea0/0x1c80
> [  226.341026]  get_signal+0x644/0x82c
> [  226.341097]  arch_do_signal_or_restart+0x118/0x3c4
> [  226.341184]  exit_to_user_mode_loop+0x104/0x16c
> [  226.341269]  el0_da+0x8c/0x90
> [  226.341344]  el0t_64_sync_handler+0xd0/0xe4
> [  226.341419]  el0t_64_sync+0x198/0x19c
> [  226.341626] Code: eb00003f 540029a0 924d0113 b6982d88 (f94004a4)
> [  226.341893] ---[ end trace 0000000000000000 ]---
> [  226.851631] note: simple-gcs[950] exited with preempt_count 1
>
> This is using Linux kernel v6.19 built with defconfig.
>
> I also tried the QEMU commit corresponding to the last patch in this
> series (af0bd678df72 "tests/tcg/aarch64: Add gcsss") but had the same
> result.
>
> The same binaries work as expected using Arm FVP, so it seems to be
> something in QEMU.

This turned out to be a kernel problem after all.

Using kernel v7.0-rc2 with its defconfig works fine, so I was able to
bisect the problem to this kernel commit from last week:

commit 8a85b3131225 ("arm64: gcs: Do not set PTE_SHARED on GCS mappings if FEAT_LPA2 is enabled")

I did try several kernel versions (as early as v6.13 which was the first
one with GCS enabled) to try to determine whether the problem was in the
kernel or QEMU, but failed.

Sorry for the noise.

-- 
Thiago

