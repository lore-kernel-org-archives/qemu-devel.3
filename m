Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A827CF6ABD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnKq-00031k-6E; Thu, 08 Jan 2026 05:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdnKe-0002zE-JR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdnKc-0003zP-7a
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767868409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tUadwYYkCJag3XrHLQrbQR5iw0PpCdKk2ZyxFYy2BBo=;
 b=QMyxV3yU2FdrCuppx1sE2R13q3qo33eHOiBIQNJyZl/RWm0HWiQtEwiXyYoqHVoXR/Hf4B
 fndDSxco02RZFF6xvlNidekQkSVAH72kZGIPlSw0wlubOVYWJLTg9e369sB/JW1dXs8ITm
 Ui5BE4NGRTKkDZGcMBLZamK2oiy1MHM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-bGj92p-eNKK1liqV0jj56w-1; Thu, 08 Jan 2026 05:33:26 -0500
X-MC-Unique: bGj92p-eNKK1liqV0jj56w-1
X-Mimecast-MFC-AGG-ID: bGj92p-eNKK1liqV0jj56w_1767868405
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325ddc5babso1513676f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767868405; x=1768473205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tUadwYYkCJag3XrHLQrbQR5iw0PpCdKk2ZyxFYy2BBo=;
 b=Z0Kz2ecIcv0n6goQhKLt5l9j2PXQGzCD1LlqZqz58DPo0OgmKr+TgDq+vcl6JHq3ef
 CzfXf/O0eWMO46ptpdynlkxbw5L6955gpIZYUgblN3/S9tHmclW4XliTHL28kKDTdfIe
 NEycY3if6qJU9MErswpA6rSOjPiuYEpcYorbfpRPxHPPJ2cRr17xVG6r+P0Qwuu+/zJo
 PbBrZ5oPw/1I6O732qrQj2XOZsMMFgfYNJIV0Sqix88m6WAAT6TrKgJHClHvhqq9IMrn
 MTLmTNLKsg/3+N0+fjgnDUOsMP6XXzG4keAwacp2uWg6jorgWJC5QT8G2PdaNi6uV41l
 feQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767868405; x=1768473205;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tUadwYYkCJag3XrHLQrbQR5iw0PpCdKk2ZyxFYy2BBo=;
 b=egpbE3Q/8Z6Up0E6QBtBzzODGmlFP40NJP4WV/UIT6i60vWNUmonshueUQXUdYKs8E
 zlPA9H5FFRzkrwMpy85pAy0pyW0N67Butqy1ezZ4s2jzN+LJnctmDTKoW0ACIOzTwBnl
 vdtA2j66/ljA4bxR/En6KZ56IhhKreeu1jTEyZVZONzUbP55pFA9DS3i9CG9GKsbfhdA
 OxAaXs8ZPZdfSycy/4lxwEdtUIrnofvKChgwWB1XErAa8Zvg9ANQ7cI1hm6yu2unVo1a
 Af4NdettZAhA9QhCa12HBIVmCcne8IjzdkqiWvtj8rIS/0GDIc8xSuiPicLthZ3ZZ/Kw
 Pchg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9EdCtSZsuXeFJHW3rsdpzN1K+O8E+c7YMTa4ERJksClHm0ysU3fzTGPTjQuV+pVDusjaQ9V4uH4nd@nongnu.org
X-Gm-Message-State: AOJu0Yx6zVWEhOzAjZ69nEtQYoCbrybepO3J5gi/MrPZztQU3TwgsDv3
 K/RAnB6IYNVsiF7ypoHPnC1QbKmYwOdHmBJZKOcJfL4qQBk0tmANE6posJI4bBjzFyDxuAIIevu
 rAcFIAytwk5nSkgLr6tiDIH8g0wfyjZa6Q0eVdwypyKHh2ax7NALF7cjr
X-Gm-Gg: AY/fxX4IhN7w2ZoAwFxYv76rMMh9CwnVmg8vXdqFFpVt0faj/tHbzRIcRpktXhPfkzA
 cGaC63LV7C/i1Ja1Xan8Zit942yGsbmLjHxhnt+qcAok0M7PqCMU0UA9kJjIxLa7CMrSDw874BT
 tIAq3PSCO5D615otHsszMnRqPpcZo7zXSWjUJ0fyN+UqoUUrGRalCszcvIec+nYy0wJXfJ72JP6
 UrxAM4+wSTmWXc5WCWhz0Fm43TSByMvN0BYizLt+gvz33UUbX/E2USWbvIb0Eu6dRsUSI3zPWea
 aKGgYTWT26f3lQfUJS9FutLiE+DRdLBdpB/SxhyfnTQNTnRG/qKe+x8XFBLwNbotxrGd+9uicKC
 i/1GT/8AZ7YiKRGPovoDngyPBai7P42Ya3SRwsRyxXFgGsPvKCh3wFjZtnuZRvAEi+WNICimgzE
 u2k0v2R5kOQc1I0g==
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-432c37c1462mr5936826f8f.55.1767868405374; 
 Thu, 08 Jan 2026 02:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrndCpbnClTWdapriNe3rReCZx3sgHMk8BNJef6v+3v136b3gCpQxMj6ZOj8ytq2NjzvecWw==
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-432c37c1462mr5936797f8f.55.1767868404885; 
 Thu, 08 Jan 2026 02:33:24 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5eesm15684862f8f.34.2026.01.08.02.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:33:24 -0800 (PST)
Message-ID: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
Date: Thu, 8 Jan 2026 11:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/50] Remove 32-bit host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/8/26 06:29, Richard Henderson wrote:
> Long has it been threatened, but here we are at last.
> 
> 32-bit host support was deprecated with the 10.0 release, and so
> with the 11.0 release we may remove it.  Phil already did some
> cleanup in 10.2, removing support for mips32 and ppc32 within tcg.

What is the situation with wasm?  If I understand correctly, wasm32 
really is a 64-bit target from the TCG point of view, because it has 
64-bit registers internally (similar to x32).

If so, why remove testing it from CI?

Paolo

> With a net -7302 in the diffstat, I think the motivations are clear,
> even if half of that was tcg/arm/.
> 
> 
> r~
> 
> 
> Richard Henderson (50):
>    gitlab: Remove 32-bit host testing
>    meson: Reject 32-bit hosts
>    *: Remove arm host support
>    bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
>    *: Remove __i386__ tests
>    *: Remove i386 host support
>    host/include/x86_64/bufferiszero: Remove no SSE2 fallback
>    meson: Remove cpu == x86 tests
>    *: Remove ppc host support
>    tcg/i386: Remove TCG_TARGET_REG_BITS tests
>    tcg/x86_64: Rename from i386
>    tcg/ppc64: Rename from ppc
>    meson: Drop host_arch rename for mips64
>    meson: Drop host_arch rename for riscv64
>    meson: Remove cpu == riscv32 tests
>    tcg: Make TCG_TARGET_REG_BITS common
>    tcg: Replace TCG_TARGET_REG_BITS / 8
>    *: Drop TCG_TARGET_REG_BITS test for prefer_i64
>    tcg: Remove INDEX_op_brcond2_i32
>    tcg: Remove INDEX_op_setcond2_i32
>    tcg: Remove INDEX_op_dup2_vec
>    tcg/tci: Drop TCG_TARGET_REG_BITS tests
>    tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
>    tcg: Drop TCG_TARGET_REG_BITS test in region.c
>    tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op.c
>    tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
>    tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-ldst.c
>    tcg: Drop TCG_TARGET_REG_BITS tests in tcg.c
>    tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
>    tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
>    include/tcg: Drop TCG_TARGET_REG_BITS tests
>    target/i386/tcg: Drop TCG_TARGET_REG_BITS test
>    target/riscv: Drop TCG_TARGET_REG_BITS test
>    accel/tcg/runtime: Remove 64-bit shift helpers
>    accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
>    tcg: Unconditionally define atomic64 helpers
>    accel/tcg: Drop CONFIG_ATOMIC64 checks from ldst_atomicicy.c.inc
>    accel/tcg: Drop CONFIG_ATOMIC64 test from translator.c
>    linux-user/arm: Drop CONFIG_ATOMIC64 test
>    linux-user/hppa: Drop CONFIG_ATOMIC64 test
>    target/arm: Drop CONFIG_ATOMIC64 tests
>    target/hppa: Drop CONFIG_ATOMIC64 test
>    target/m68k: Drop CONFIG_ATOMIC64 tests
>    target/s390x: Drop CONFIG_ATOMIC64 tests
>    migration: Drop use of Stat64
>    block: Drop use of Stat64
>    util: Remove stats64
>    include/qemu/atomic: Drop qatomic_{read,set}_[iu]64
>    meson: Remove CONFIG_ATOMIC64
>    include/qemu/atomic: Drop aligned_{u}int64_t
> 
>   accel/tcg/atomic_template.h                   |    4 +-
>   accel/tcg/tcg-runtime.h                       |   23 -
>   bsd-user/syscall_defs.h                       |    2 +-
>   host/include/i386/host/cpuinfo.h              |   41 -
>   host/include/i386/host/crypto/aes-round.h     |  152 -
>   host/include/i386/host/crypto/clmul.h         |   29 -
>   host/include/ppc/host/cpuinfo.h               |   30 -
>   host/include/ppc/host/crypto/aes-round.h      |  182 -
>   host/include/ppc64/host/cpuinfo.h             |   31 +-
>   host/include/ppc64/host/crypto/aes-round.h    |  183 +-
>   .../include/{riscv => riscv64}/host/cpuinfo.h |    0
>   host/include/x86_64/host/cpuinfo.h            |   42 +-
>   host/include/x86_64/host/crypto/aes-round.h   |  153 +-
>   host/include/x86_64/host/crypto/clmul.h       |   30 +-
>   include/accel/tcg/cpu-ldst-common.h           |    9 -
>   include/block/block_int-common.h              |    3 +-
>   include/qemu/atomic.h                         |   39 +-
>   include/qemu/cacheflush.h                     |    2 +-
>   include/qemu/osdep.h                          |    6 +-
>   include/qemu/processor.h                      |    2 +-
>   include/qemu/stats64.h                        |  199 -
>   include/qemu/timer.h                          |    9 -
>   include/system/cpu-timers-internal.h          |    2 +-
>   include/tcg/helper-info.h                     |    2 +-
>   .../tcg/target-reg-bits.h                     |    8 +-
>   include/tcg/tcg-op.h                          |    9 +-
>   include/tcg/tcg-opc.h                         |    9 +-
>   include/tcg/tcg.h                             |   29 +-
>   linux-user/include/host/arm/host-signal.h     |   43 -
>   linux-user/include/host/i386/host-signal.h    |   38 -
>   .../host/{mips => mips64}/host-signal.h       |    0
>   linux-user/include/host/ppc/host-signal.h     |   39 -
>   .../host/{riscv => riscv64}/host-signal.h     |    0
>   migration/migration-stats.h                   |   36 +-
>   tcg/aarch64/tcg-target-reg-bits.h             |   12 -
>   tcg/arm/tcg-target-con-set.h                  |   47 -
>   tcg/arm/tcg-target-con-str.h                  |   26 -
>   tcg/arm/tcg-target-has.h                      |   73 -
>   tcg/arm/tcg-target-mo.h                       |   13 -
>   tcg/arm/tcg-target-reg-bits.h                 |   12 -
>   tcg/arm/tcg-target.h                          |   73 -
>   tcg/i386/tcg-target-reg-bits.h                |   16 -
>   tcg/loongarch64/tcg-target-reg-bits.h         |   21 -
>   tcg/mips/tcg-target-reg-bits.h                |   16 -
>   tcg/{mips => mips64}/tcg-target-con-set.h     |    0
>   tcg/{mips => mips64}/tcg-target-con-str.h     |    0
>   tcg/{mips => mips64}/tcg-target-has.h         |    0
>   tcg/{mips => mips64}/tcg-target-mo.h          |    0
>   tcg/{mips => mips64}/tcg-target.h             |    0
>   tcg/{ppc => ppc64}/tcg-target-con-set.h       |    0
>   tcg/{ppc => ppc64}/tcg-target-con-str.h       |    0
>   tcg/{ppc => ppc64}/tcg-target-has.h           |    0
>   tcg/{ppc => ppc64}/tcg-target-mo.h            |    0
>   tcg/{ppc => ppc64}/tcg-target.h               |    0
>   tcg/riscv/tcg-target-reg-bits.h               |   19 -
>   tcg/{riscv => riscv64}/tcg-target-con-set.h   |    0
>   tcg/{riscv => riscv64}/tcg-target-con-str.h   |    0
>   tcg/{riscv => riscv64}/tcg-target-has.h       |    0
>   tcg/{riscv => riscv64}/tcg-target-mo.h        |    0
>   tcg/{riscv => riscv64}/tcg-target.h           |    0
>   tcg/s390x/tcg-target-reg-bits.h               |   17 -
>   tcg/sparc64/tcg-target-reg-bits.h             |   12 -
>   tcg/tcg-has.h                                 |    5 -
>   tcg/tcg-internal.h                            |   21 +-
>   tcg/tci/tcg-target-has.h                      |    2 -
>   tcg/tci/tcg-target-mo.h                       |    2 +-
>   tcg/tci/tcg-target-reg-bits.h                 |   18 -
>   tcg/{i386 => x86_64}/tcg-target-con-set.h     |    0
>   tcg/{i386 => x86_64}/tcg-target-con-str.h     |    0
>   tcg/{i386 => x86_64}/tcg-target-has.h         |    8 +-
>   tcg/{i386 => x86_64}/tcg-target-mo.h          |    0
>   tcg/{i386 => x86_64}/tcg-target.h             |   13 +-
>   accel/kvm/kvm-all.c                           |    2 +-
>   accel/qtest/qtest.c                           |    4 +-
>   accel/tcg/cputlb.c                            |   37 +-
>   accel/tcg/icount-common.c                     |   25 +-
>   accel/tcg/tcg-runtime.c                       |   15 -
>   accel/tcg/translator.c                        |    4 +-
>   accel/tcg/user-exec.c                         |    2 -
>   block/io.c                                    |   10 +-
>   block/qapi.c                                  |    2 +-
>   disas/disas-host.c                            |    9 -
>   hw/display/xenfb.c                            |   10 +-
>   hw/virtio/virtio-mem.c                        |    2 +-
>   linux-user/arm/cpu_loop.c                     |   19 +-
>   linux-user/hppa/cpu_loop.c                    |   14 +-
>   linux-user/mmap.c                             |    2 +-
>   linux-user/syscall.c                          |    9 -
>   migration/cpu-throttle.c                      |    4 +-
>   migration/migration-stats.c                   |   16 +-
>   migration/migration.c                         |   24 +-
>   migration/multifd-nocomp.c                    |    2 +-
>   migration/multifd-zero-page.c                 |    4 +-
>   migration/multifd.c                           |   12 +-
>   migration/qemu-file.c                         |    6 +-
>   migration/ram.c                               |   30 +-
>   migration/rdma.c                              |    8 +-
>   system/dirtylimit.c                           |    2 +-
>   target/arm/ptw.c                              |   18 +-
>   target/arm/tcg/gengvec.c                      |   32 +-
>   target/arm/tcg/gengvec64.c                    |    4 +-
>   target/arm/tcg/translate-sve.c                |   26 +-
>   target/hppa/op_helper.c                       |    6 +-
>   target/i386/cpu.c                             |   10 -
>   target/m68k/op_helper.c                       |    7 +-
>   target/s390x/tcg/mem_helper.c                 |    7 -
>   tcg/optimize.c                                |  322 --
>   tcg/region.c                                  |   12 -
>   tcg/tcg-op-gvec.c                             |  113 +-
>   tcg/tcg-op-ldst.c                             |  130 +-
>   tcg/tcg-op-vec.c                              |   14 +-
>   tcg/tcg-op.c                                  |  765 +---
>   tcg/tcg.c                                     |  376 +-
>   tcg/tci.c                                     |   73 +-
>   tests/unit/test-rcu-list.c                    |   17 +-
>   util/atomic64.c                               |   85 -
>   util/cacheflush.c                             |    4 +-
>   util/qsp.c                                    |   12 +-
>   util/stats64.c                                |  148 -
>   .gitlab-ci.d/buildtest-template.yml           |   27 -
>   .gitlab-ci.d/buildtest.yml                    |    9 -
>   .gitlab-ci.d/container-cross.yml              |   17 -
>   .gitlab-ci.d/containers.yml                   |    3 -
>   .gitlab-ci.d/crossbuilds.yml                  |   45 -
>   MAINTAINERS                                   |   16 +-
>   accel/tcg/atomic_common.c.inc                 |   32 -
>   accel/tcg/ldst_atomicity.c.inc                |  149 +-
>   common-user/host/arm/safe-syscall.inc.S       |  108 -
>   common-user/host/i386/safe-syscall.inc.S      |  127 -
>   .../host/{mips => mips64}/safe-syscall.inc.S  |    0
>   common-user/host/ppc/safe-syscall.inc.S       |  107 -
>   .../{riscv => riscv64}/safe-syscall.inc.S     |    0
>   configure                                     |   47 +-
>   docs/about/deprecated.rst                     |   29 -
>   docs/about/removed-features.rst               |    6 +
>   docs/devel/tcg-ops.rst                        |   32 +-
>   host/include/i386/host/bufferiszero.c.inc     |  125 -
>   host/include/x86_64/host/bufferiszero.c.inc   |  121 +-
>   meson.build                                   |  101 +-
>   target/i386/tcg/emit.c.inc                    |   39 +-
>   target/riscv/insn_trans/trans_rvv.c.inc       |   56 +-
>   tcg/arm/tcg-target-opc.h.inc                  |   16 -
>   tcg/arm/tcg-target.c.inc                      | 3489 -----------------
>   tcg/loongarch64/tcg-target.c.inc              |    4 +-
>   tcg/{mips => mips64}/tcg-target-opc.h.inc     |    0
>   tcg/{mips => mips64}/tcg-target.c.inc         |    0
>   tcg/{ppc => ppc64}/tcg-target-opc.h.inc       |    0
>   tcg/{ppc => ppc64}/tcg-target.c.inc           |    2 +-
>   tcg/{riscv => riscv64}/tcg-target-opc.h.inc   |    0
>   tcg/{riscv => riscv64}/tcg-target.c.inc       |    4 +-
>   tcg/tci/tcg-target.c.inc                      |   84 +-
>   tcg/{i386 => x86_64}/tcg-target-opc.h.inc     |    0
>   tcg/{i386 => x86_64}/tcg-target.c.inc         |  552 +--
>   util/meson.build                              |    4 -
>   154 files changed, 1158 insertions(+), 8460 deletions(-)
>   delete mode 100644 host/include/i386/host/cpuinfo.h
>   delete mode 100644 host/include/i386/host/crypto/aes-round.h
>   delete mode 100644 host/include/i386/host/crypto/clmul.h
>   delete mode 100644 host/include/ppc/host/cpuinfo.h
>   delete mode 100644 host/include/ppc/host/crypto/aes-round.h
>   rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
>   delete mode 100644 include/qemu/stats64.h
>   rename tcg/ppc/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
>   delete mode 100644 linux-user/include/host/arm/host-signal.h
>   delete mode 100644 linux-user/include/host/i386/host-signal.h
>   rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
>   delete mode 100644 linux-user/include/host/ppc/host-signal.h
>   rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
>   delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/arm/tcg-target-con-set.h
>   delete mode 100644 tcg/arm/tcg-target-con-str.h
>   delete mode 100644 tcg/arm/tcg-target-has.h
>   delete mode 100644 tcg/arm/tcg-target-mo.h
>   delete mode 100644 tcg/arm/tcg-target-reg-bits.h
>   delete mode 100644 tcg/arm/tcg-target.h
>   delete mode 100644 tcg/i386/tcg-target-reg-bits.h
>   delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/mips/tcg-target-reg-bits.h
>   rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-has.h (100%)
>   rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
>   rename tcg/{mips => mips64}/tcg-target.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.h (100%)
>   delete mode 100644 tcg/riscv/tcg-target-reg-bits.h
>   rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.h (100%)
>   delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
>   delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
>   delete mode 100644 tcg/tci/tcg-target-reg-bits.h
>   rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-has.h (92%)
>   rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.h (86%)
>   delete mode 100644 util/atomic64.c
>   delete mode 100644 util/stats64.c
>   delete mode 100644 common-user/host/arm/safe-syscall.inc.S
>   delete mode 100644 common-user/host/i386/safe-syscall.inc.S
>   rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
>   delete mode 100644 common-user/host/ppc/safe-syscall.inc.S
>   rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
>   delete mode 100644 host/include/i386/host/bufferiszero.c.inc
>   delete mode 100644 tcg/arm/tcg-target-opc.h.inc
>   delete mode 100644 tcg/arm/tcg-target.c.inc
>   rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{mips => mips64}/tcg-target.c.inc (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.c.inc (99%)
>   rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.c.inc (99%)
>   rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.c.inc (89%)
> 


