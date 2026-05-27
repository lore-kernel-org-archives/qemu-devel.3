Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF1CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSF59-0007Mm-6b; Wed, 27 May 2026 10:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wSF4u-0007Lu-De
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:17:50 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wSF4m-0007x7-4f
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:17:43 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-30246cfd41aso1107884eec.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779891456; x=1780496256; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NLdC/SGTKiT/UJomgMxFzv9EgBD91mqiPvN7ks/9vJ8=;
 b=DZMzMKu4g5DfWKgba7y9OiHnsucEdb9ruATGMQU3IENM99nhACNDZ1W+/3dgY9kldC
 6xGMHHHQHrX6xC+XehreWgY1DZ5ijNBHzMavpi4YnQEPpW1nGPiPNv96MiKelJfvTEww
 ULnEYQ+AUpvQFeUUMjnizOyNJvo+Yz5Shyn/bl+z4sDC5GDpy8VGFaAXfY/K0fj14Bl3
 XXpVd4LRMItwf+d+4wgJycNjCcVvCAkJ8VRLJR8SHvVvuz8w+/Os/50N+Lge4YjwifJ6
 A9cLYYi9jGh+n84Y4BlBst5zyeGTSBU4ahhqczpk3e61+rmB6AIv2XSmjXehG9Xo8A/1
 5aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891456; x=1780496256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLdC/SGTKiT/UJomgMxFzv9EgBD91mqiPvN7ks/9vJ8=;
 b=SLlt8/Vlswi3IsSsF041IGnY8NDB1C4qGvOJJR9TlAdFU1GHa4ucx9iu3saX4zYcLj
 a3kBaDwAsXVatHAs2E6XFMCJiFEFa7w2XXa3xoZMeEcp0DkNz1piJzTW+ysps25v2G2Y
 a7M/8P2ZZaAxo7CeAUaxVKGKfVkvJlLk+xsTIP3wCLVDSB41zk09EeuRbg+swm3ptwrX
 e+v+ieD+K95fGgEzDNrjswb4h2yOmMuwCqunx1Kss37lK+nhyaxQHDvsIvooIaeeW3Iy
 Ll/TJakAqILMQU6GhcWxTSDURVLij7Mj092HRs31trVlkP/q2OCcdra3YSKk9JF+EIoI
 ICQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GK5a+V/7ABztNCuOKwcPQ1JKswZB0GtlSgRKbDrMg1Hs8jk7Qe9tMdZE6ykAacTzIMqGB84GTB7xb@nongnu.org
X-Gm-Message-State: AOJu0YxMFdE31U8cgVCX/ASRHJokrurifFZERm/KLSxloFsUpnCpvSQq
 JJAoRADespGFTSLOQewuZiBE6WTHVbkgGZFvH2kg6MTNExYRt6ykGqnj
X-Gm-Gg: Acq92OHCA04rCw4vLHK8H4a0il3i2E4Uauo1oozcTgCER/6Joq/nwyFHI7Y3197tMAG
 MVP3sApqVwHaqhUWTIgPXLBebDBdiq/I3t1kEyqB9tX9bbHy+o9qRrZvi+DoqOmuVvPYDog66Cd
 qX7oKwtf9Xz1jo8zVnD2aTnFz96SGDnvVnOuUe8hfaB4fqt/N/FJBukrWa1JHDgqlhynhbVMkkF
 tVjNZh/Idum8oXRLmJXDSU4hhxl7Aub2QKYim0EbLOri3unwhcRC6p6GalGK7JNdjPMND88DG+/
 OxyahVxscpmXfN73sgBlV2tuNw/URAu0jsYEf/PxEqQRQuwvufCEZIPdzwFuUIR10iGUrpfcYbO
 fBfnau56B4v9mWYLTvC7Z3MDrzP3TMM1YilZaQ12saKWE33mlvkoN/zgq/G/DJgrfL1wifHyO3H
 HCtDia7fhgbahpBBi57bn4v9hdE7IcyqGZJnyssLxTBxiFiWC8t2sE9BEThLU=
X-Received: by 2002:a05:7300:aa8c:b0:2f2:2e0b:24cc with SMTP id
 5a478bee46e88-30449192e35mr10650448eec.24.1779891456238; 
 Wed, 27 May 2026 07:17:36 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304be0851c9sm1428927eec.23.2026.05.27.07.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:17:35 -0700 (PDT)
Date: Wed, 27 May 2026 22:17:33 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org, 
 tangtao1634@phytium.com.cn, devel@lists.libvirt.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v6 0/7] riscv: add initial sdext support
Message-ID: <ahb8xIC6T76RN-lD@ChaodeMacBook-Pro.local>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
 <3e965cdc-3250-4443-8623-859e39441477@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e965cdc-3250-4443-8623-859e39441477@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

On Wed, May 27, 2026 at 10:13:04AM +0800, Daniel Henrique Barboza wrote:
> Hi Chao!
> 
> 
> Can you please re-send this series?  We did changes in the last PR that
> will conflict with what you did - most likely a trivial conflict in
> patch 2.
> 
> I'll resend patch 1 myself.  Feel free to pick the rebased version to
> include in your v7.

Sure, I’ll resend the v7 patches after you resend patch 1.

Thanks,
Chao
> 
> 
> Cheers,
> Daniel
> 
> 
> 
> 
> > Hi,
> > 
> > This v6 series is rebased on Alistair's riscv-to-apply.next branch [1].
> > 
> > The implementation follows RISC-V Debug Specification 1.0 [2].
> > 
> > It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
> > Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
> > trigger action=debug mode.
> > 
> > To reduce review load, this series focuses on the Sdext features first.
> > The Debug Module (DM) and related flows will follow in a later series.
> > 
> > Changes in v6:
> > - Rebased onto latest riscv-to-apply.next
> > 
> > Changes in v5:
> > - Patch 2: removed redundant `cpu->cfg.ext_sdext = false;` in
> >    riscv_cpu_init() since it's already set to false in MULTI_EXT_CFG_BOOL.
> >    (Daniel)
> > - Patch 7: changed LOG_UNIMP to LOG_GUEST_ERROR for invalid trigger
> >    action=debug mode when Sdext is not enabled. LOG_UNIMP is reserved
> >    for unimplemented features, while LOG_GUEST_ERROR is for invalid
> >    guest actions. (Daniel)
> > 
> > Changes in v4:
> > - Fixed linux-user build errors: moved debug_mode/dcsr/dpc/dscratch
> >    fields inside #ifndef CONFIG_USER_ONLY block in cpu.h, and wrapped
> >    all code using these fields with proper guards. (Daniel)
> > - Updated dependency from single patch (patch 5 only) to patches 1-5
> >    of Max Chou's "Add Zvfbfa extension support" v2 series to avoid
> >    compilation errors.
> > 
> > Changes in v3:
> > - Rebase onto Alistair's riscv-to-apply.next branch.
> > - Depend on Max Chou's patch "target/riscv: Use the tb->cs_bqse as
> >    the extend tb flags." (not included; apply it first) [3].
> > - Patch 2: default sdext to false in riscv_cpu_extensions.
> > 
> > Changes in v2:
> > - Drop the RHCT expected AML update from this series.
> > - Replace the split sdext/sdtrig config bits patch with deprecating the
> >    'debug' CPU property.
> > - Rebase and update patch subjects to target/riscv prefix.
> > 
> > Changes in v1:
> > - Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
> > - EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
> > - Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
> >    It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
> >    the extend tb flags." [3].
> > - Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
> >    inst-count triggers in tinfo.
> > 
> > ---
> > 
> > Differences vs Debug Spec (known gaps):
> > - No Debug Module (no DMI, dmcontrol/dmstatus, haltreq/resumereq).
> > - No debug ROM, program buffer, abstract commands, or SBA.
> > - Resume is modeled by leaving Debug Mode at cpu_exec_enter.
> > - Step/exception ordering is simplified: if the stepped instruction
> >    traps, the normal exception is taken and Debug Mode is not forced.
> > - Several DCSR fields are not fully modeled (stopcount/stoptime, etc).
> > 
> > Roadmap (next stage, DM focus):
> > 1) Add a DM core with DMI access and hart state tracking.
> > 2) Implement halt/resume handshake and move Debug Mode transitions
> >     under DM control.
> > 3) Add debug ROM, program buffer, and abstract commands for GPR/CSR
> >     and memory access.
> > 4) Add SBA if required by tooling.
> > 5) Tighten ordering rules for step/exception/trigger priorities.
> > 
> > CI (all jobs passed except check-patch which flags pre-existing
> > upstream style issues, not related to this series) [4].
> > 
> > References:
> > [1] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> > [2] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> > [3] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
> > [4] https://gitlab.com/TaoTang/qemu/-/pipelines/2446308835
> > 
> > 
> > Thanks,
> > Chao
> > 
> > Chao Liu (6):
> >    target/riscv: add sdext debug CSRs state
> >    target/riscv: add sdext Debug Mode helpers
> >    target/riscv: add dret instruction
> >    target/riscv: add sdext enter Debug Mode on ebreak
> >    target/riscv: add sdext single-step support
> >    target/riscv: add sdtrig trigger action=debug mode
> > 
> > Daniel Henrique Barboza (1):
> >    target/riscv: deprecate 'debug' CPU property
> > 
> >   docs/about/deprecated.rst                     |   7 +
> >   include/exec/translation-block.h              |   4 +-
> >   target/riscv/cpu.c                            |  59 +++++++-
> >   target/riscv/cpu.h                            |   9 ++
> >   target/riscv/cpu_bits.h                       |  33 +++++
> >   target/riscv/cpu_cfg_fields.h.inc             |   3 +-
> >   target/riscv/cpu_helper.c                     |  90 ++++++++++++
> >   target/riscv/csr.c                            | 128 +++++++++++++++++-
> >   target/riscv/debug.c                          |  58 +++++++-
> >   target/riscv/helper.h                         |   3 +
> >   target/riscv/insn32.decode                    |   1 +
> >   .../riscv/insn_trans/trans_privileged.c.inc   |  24 ++++
> >   target/riscv/machine.c                        |  44 ++++--
> >   target/riscv/op_helper.c                      |  70 ++++++++++
> >   target/riscv/tcg/tcg-cpu.c                    |  21 ++-
> >   target/riscv/translate.c                      |  15 +-
> >   16 files changed, 544 insertions(+), 25 deletions(-)
> > 
> 

