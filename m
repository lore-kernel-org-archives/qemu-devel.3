Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9851CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 00:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5COq-0000nN-9T; Sat, 04 Oct 2025 20:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5COo-0000n9-EV
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 20:14:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5COl-0007Ra-Om
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 20:14:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-33082aed31dso3953027a91.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759623285; x=1760228085; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wSH5G13Q0l57VI8HthYXfsJ/xCfUFbeuvUbndwdfNwM=;
 b=U8QeZbyoNcaTd5Zlext/sQjzhcEroM1RC/08RsYqFM8BVKeqkOV46hLfkO2iBBhoDH
 jQfBvA+PKgN+oTfuMb6bGOsORqaZFcotiDlNOACMpfubwkD+B2ARWd7AnQOlWQ3y1/zH
 IpZCp8AKc252yO+VwktsAF0Wk7wXDKJGOs0fqbrDBcBrCqn2Zg+ftd4n0NniFla+s2PU
 td4gH9sYHk+TGTuTOqOLgdPsP6GPTZKD/bHz4P5Eu1lDSi3DGzG+Q8t1wLdIJ/EZrVWe
 s6GF3LusB+Ig4r13dZ8K8rDe43k/ZP4cD91BIzAvZiGASTcLiWMS3IzUO+p3AMHNctc/
 UFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759623285; x=1760228085;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSH5G13Q0l57VI8HthYXfsJ/xCfUFbeuvUbndwdfNwM=;
 b=o+XuvJz55eMVFrrGq4TqMyjbggWqVEGJurVWY1cKgnLZuUxr9jc1BlfDBfUc11QnPO
 hUcnF//fOYvmVPCeb3iTPqg17e6vmTxkjV2ujcQGuU7T7BmyukClS17FPqacOl9I+qFe
 OoLy9pdyJraVSPxyNBb0Tq2jrMTykv9ohz7mQotouvlxyl0xVp/1Svf26+rIqEmHGvfo
 pcDH8bGV0x1ys1TP+NOIXORCcxuYJarpKIjoAKT1E6bA8sMfpCSqg6M37gV7RpbBlxHC
 8lLR/oS9sWGRWvr5ulL4CyaEpwZ0fCYz04lVqbYT+JPF/5qvXK36fOO+iBQfoaIJDWAJ
 TYnQ==
X-Gm-Message-State: AOJu0YyKVWzejovxipktIv/fzU8JMzqBb+hMsQqOwiOmBRaiFK44pnAM
 /GSIirqhiUvLKaW3hFQx21BFL54MzIXQw95DV153Hq6WeJ2GDfQn1AX6QKbG5eef
X-Gm-Gg: ASbGncvLcow26FW3TrlvJvEPHOv/4HxOqT4LM4IiakWL+PPSHqE0Y/0J01NaSWn/WYp
 uwk7ZOqq+cGI5fiS90MpjymFKIrgiZBusydKpWTZr5PYgYU52o2GN1bZtZSShUZijvYEkeXFfoy
 L7aLFxbw4IHeQWBd77c/9K+TVaqZ6OYlaAgXzG6+6cnbEtDXIcb/S/JIs65/qIgQyNqJzONS7bf
 ZUFFqQdL8pIOYGIUf0eL5E9cnJ7U4yjaidFHyHeXgNDcby61qDOsctoKeCMAjW+MATM3yu+87Hb
 DW2646j458Z9HdiQFDqlwUsUvZWBHQX2dEkBmjsGo9v+WO1WtXOFvc8+FBfZxwa8W3lDIChOQMO
 K2DxSpkSzBuVy1N2FTDO9bPCrBfAqW9SK67qk1VilOyWd//vjiaywRtWe7F/3DK3ZcNxsYw==
X-Google-Smtp-Source: AGHT+IFZhqpGfu+pwSx1A5U8zJVJtPdjjNHbJtv8AfUvbW2y3+o/QZWwjSzbYpN7cYbf/IUaEXEn1Q==
X-Received: by 2002:a17:903:2b0f:b0:258:c13d:9b1a with SMTP id
 d9443c01a7336-28e9a61ab55mr84282585ad.41.1759623285436; 
 Sat, 04 Oct 2025 17:14:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d125ed2sm89273625ad.35.2025.10.04.17.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 17:14:44 -0700 (PDT)
Date: Sat, 4 Oct 2025 17:14:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
Message-ID: <46ea9b87-cc73-4408-82c4-2de96dddca0a@roeck-us.net>
References: <20250503212708.3235806-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503212708.3235806-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Sat, May 03, 2025 at 02:27:08PM -0700, Richard Henderson wrote:
> This should have been done before removing TARGET_ALIGNED_ONLY,
> as we did for hppa and alpha.
> 
> Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

When trying to run sh4 emulations with qemu 10.1.0, I get quite interesting
error messages. Bisect points to this patch, and reverting it fixes the
problem.

Guenter
---
Bisect log:

# bad: [f8b2f64e2336a28bf0d50b6ef8a7d8c013e9bcf3] Update version for the v10.1.0 release
# good: [7c949c53e936aa3a658d84ab53bae5cadaa5d59c] Update version for the v10.0.0 release
git bisect start 'v10.1.0' 'v10.0.0'
# bad: [14b5a799339d2d21826eac5ab1e98d00b1f1f89f] hpet: return errors from realize if properties are incorrect
git bisect bad 14b5a799339d2d21826eac5ab1e98d00b1f1f89f
# good: [54e54e594bc8273d210f7ff4448c165a989cbbe8] hw/i2c/imx: Always set interrupt status bit if interrupt condition occurs
git bisect good 54e54e594bc8273d210f7ff4448c165a989cbbe8
# good: [f0737158b483e7ec2b2512145aeab888b85cc1f7] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
git bisect good f0737158b483e7ec2b2512145aeab888b85cc1f7
# bad: [e86c1f967a323165d13bcadfad4b92d0d34cdb08] hw/block: Drop unused nand.c
git bisect bad e86c1f967a323165d13bcadfad4b92d0d34cdb08
# good: [89d2a9f3f7564c9421d61153bbf7e24af95d34ee] hw/misc/aspeed_hace: Move register size to instance class and dynamically allocate regs
git bisect good 89d2a9f3f7564c9421d61153bbf7e24af95d34ee
# bad: [981f2beb161b9bcaeedc1f91ad22bff255856cb2] target: Use cpu_pointer_wrap_uint32 for 32-bit targets
git bisect bad 981f2beb161b9bcaeedc1f91ad22bff255856cb2
# good: [221d22d830eb1a96f780eec28e6a45286b85fe85] hw/arm/aspeed_ast27x0: Fix unimplemented region overlap with vbootrom
git bisect good 221d22d830eb1a96f780eec28e6a45286b85fe85
# good: [beea772666fb1bb86136042fd8ee7140a01bb36f] target/microblaze: Implement extended address load/store out of line
git bisect good beea772666fb1bb86136042fd8ee7140a01bb36f
# good: [36a9529e60e09b0d0b6b5ebad614255c97bf9322] target/microblaze: Simplify compute_ldst_addr_type{a,b}
git bisect good 36a9529e60e09b0d0b6b5ebad614255c97bf9322
# bad: [eb978e50e42f3439e7a7a104e76aafc81bc4a028] target/sh4: Use MO_ALIGN for system UNALIGN()
git bisect bad eb978e50e42f3439e7a7a104e76aafc81bc4a028
# good: [11efde54f248c2da9e164910b8b1945e78a7168e] tcg: Drop TCGContext.page_{mask,bits}
git bisect good 11efde54f248c2da9e164910b8b1945e78a7168e
# first bad commit: [eb978e50e42f3439e7a7a104e76aafc81bc4a028] target/sh4: Use MO_ALIGN for system UNALIGN()

---
Sample error log from Linux:

delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#2]
Modules linked in:

CPU: 0 UID: 0 PID: 1928 Comm: kunit_try_catch Tainted: G      D          N  6.17.0-09936-gcbf33b8e0b36 #1 NONE 
Tainted: [D]=DIE, [N]=TEST
PC is at gso_test_func+0x298/0x6b4
PR is at gso_test_func+0x23c/0x6b4
PC  : 8c5073c4 SP  : 8cfedebc SR  : 40008001 TEA : 8ecf141d
R0  : 00000000 R1  : 8ecf13f1 R2  : 8cc77c50 R3  : 00000000
R4  : 8ffd8e40 R5  : 000003e8 R6  : 00000000 R7  : 00000000
R8  : 8cc29e48 R9  : 8c73fed8 R10 : 8cc77c60 R11 : 8c7bfb60
R12 : 8ffd8e40 R13 : 8cc77c7c R14 : 00000000
MACH: 00007696 MACL: daaa5ec5 GBR : 00000000 PR  : 8c507368

Call trace:
 [<8c057258>] __pick_eevdf+0x0/0x3bc
 [<8c5c21b4>] __schedule+0x2ec/0x6ec
 [<8c5c21ce>] __schedule+0x306/0x6ec
 [<8c21f978>] kunit_try_run_case+0x58/0x174
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c089678>] ktime_get_ts64+0x0/0x184
 [<8c5c25ce>] schedule+0x1a/0xf8
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c221d18>] kunit_generic_run_threadfn_adapter+0x10/0x24
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c04aca8>] kthread+0xb8/0x1b4
 [<8c0241c4>] ret_from_kernel_thread+0xc/0x14
 [<8c020698>] arch_local_save_flags+0x0/0x8
 [<8c054198>] schedule_tail+0x0/0x58
 [<8c04abf0>] kthread+0x0/0x1b4

Process: kunit_try_catch (pid: 1928, stack limit = (ptrval))
Stack: (0x8cfedebc to 0x8cfee000)
dea0:                                                                8cc2c000 
dec0: 8cc2c060 8c057258 00000000 8cc77c00 00000000 8cc29d0c 8cc77c40 8c5c21b4 
dee0: 00000000 8cf03c00 8cc2c000 8cfedf10 8c5c21ce a16aaf05 8c21f978 8cc29d2c 
df00: 8c221d08 8c04a8e4 8c089678 8cf7f000 8c78310c 8cc29d0c 8cc2c428 8cc2c000 
df20: 00000021 00000000 07dc6b68 00000000 00000000 00000000 00000002 a16aaf05 
df40: 8c5c25ce 8cfedf60 8c221d08 8c04a8e4 a16aaf05 8c221d18 8c221d08 8c04a8e4 
df60: 8cc29ab0 8ecd43c0 8ecd43c0 8cc29d2c 8c04aca8 00000000 00000000 00000000 
df80: a16aaf05 8c0241c4 8cc35f1c 8c78e25c 8cc2c77c 8c020698 00000000 8cf03c00 
dfa0: 8c054198 00000000 00000000 00000000 00000000 8ecf0ae0 8c04abf0 00000000 
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
dfe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000 00000000 
---[ end trace 0000000000000000 ]---
    # gso_test_func: try faulted: last line seen net/core/net_test.c:170
    # gso_test_func: internal error occurred preventing test case from running: -4
        not ok 3 frags
delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#3]
Modules linked in:

CPU: 0 UID: 0 PID: 1930 Comm: kunit_try_catch Tainted: G      D          N  6.17.0-09936-gcbf33b8e0b36 #1 NONE 
Tainted: [D]=DIE, [N]=TEST
PC is at gso_test_func+0x298/0x6b4
PR is at gso_test_func+0x23c/0x6b4
PC  : 8c5073c4 SP  : 8cfedebc SR  : 40008001 TEA : 8ecf3035
R0  : 00000000 R1  : 8ecf3009 R2  : 8cc77e90 R3  : 00000000
R4  : 8ffd8e80 R5  : 000003e8 R6  : 00000000 R7  : 00000000
R8  : 8cc29e48 R9  : 8c73fed8 R10 : 8cc77ea0 R11 : 8c7bfb84
R12 : 8ffd8e80 R13 : 8cc77ebc R14 : 00000000
MACH: 00003b51 MACL: efffda09 GBR : 00000000 PR  : 8c507368

Call trace:
 [<8c057258>] __pick_eevdf+0x0/0x3bc
 [<8c5c21b4>] __schedule+0x2ec/0x6ec
 [<8c5c21ce>] __schedule+0x306/0x6ec
 [<8c21f978>] kunit_try_run_case+0x58/0x174
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c089678>] ktime_get_ts64+0x0/0x184
 [<8c5c25ce>] schedule+0x1a/0xf8
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c221d18>] kunit_generic_run_threadfn_adapter+0x10/0x24
 [<8c221d08>] kunit_generic_run_threadfn_adapter+0x0/0x24
 [<8c04a8e4>] to_kthread+0x0/0x1c
 [<8c04aca8>] kthread+0xb8/0x1b4
 [<8c0241c4>] ret_from_kernel_thread+0xc/0x14
 [<8c020698>] arch_local_save_flags+0x0/0x8
 [<8c054198>] schedule_tail+0x0/0x58
 [<8c04abf0>] kthread+0x0/0x1b4


