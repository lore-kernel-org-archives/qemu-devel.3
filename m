Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C285E94625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdYW-0004mQ-2I; Mon, 09 Feb 2026 21:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vpdYU-0004kW-62
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:32:46 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vpdYQ-0001BE-1d
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:32:45 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1249b9f5703so4994835c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 18:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770690760; x=1771295560; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UZYDZ4V/Vwzvjujhi7DFw2NymGYvq4MsB73rOY00KFY=;
 b=mu3ojv+CC8YYFe4g7HuX9VOEaTU5BMndPeZ2E7oIE6OU/96Vx/hBy3c0hEmQYrzcVq
 QJCkyepKbn8qir3M41E9oDtYt9Jm3Lv3atOB2+fxDHDIVXhwx9M75n+QKCxVT3pMbWAB
 NuCnX8hOQn5ydmVctPWGnWHWka6l7ASN/RGy7d5tfQUpEQihxiJEtepfJxGnK+oRvT46
 G0sOeOkMrSL79vZSrKzjKiLhjI55Zygtu9Hr1q3dP0EQRbl7/SxSEs9DwIE5C0hIJ3xa
 u37QeIoZYuWfPs7UMGvQQ6f/jyMzXyhHvk7OmW3uIwfzPsIljLUHAd5RcyBlp9UhC67D
 nkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770690760; x=1771295560;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZYDZ4V/Vwzvjujhi7DFw2NymGYvq4MsB73rOY00KFY=;
 b=kUK74y7UXMq341PxEO3tKNxp6GldrrbD7eGAFJw64ylmFOZtZm72aV8x9+dMKnf61M
 fIu4srR/Ij35yA0aVzBJ6dqOLj4WwIarU2gET2tj1lT+VdOBdb4ibqspZyTMkqb6KbB+
 5JpEjVvWKRxmxR6s5E7QiggzukqTYVupPJuBqUNEx/CpjA8brIt/vO/xacvehrukioMQ
 tejK6JuUGt5tavCPzpWIVEv6JJW31DyKBJyaix760NkELcjTuaTThLKrrmhJWnhZ2ujp
 hH510zQYVH2blS363zobdcw2vXFe6C62u+cKRG6QdtnoMqAlp8TQ+E8KDqgMbTdV7uf6
 Pqvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpUN1++qQvi+YPoRg6L+uVq0PqtBkAmuY/iv+ML4ZeuntT0eY0nAMNvy+RUnrdrA9UhB4iFKMtafZr@nongnu.org
X-Gm-Message-State: AOJu0Yy/3REBcBnJJvFe/E6HzqhRNkuKYqAbwa/8kqa5lQN1zu0LBCya
 FzXhWxUTBdcho/6qyO4AG4PwdCdSpE8vx0VMjQdDM7MYpIbtM6Vbk5BV
X-Gm-Gg: AZuq6aLs6SVZ/PzLtWVlVSloxd6GUptuZqPrOawcqPCQyr7AQ0RZ1icBj0mymIh4zYf
 s98g3W1NlIsYe8RfVxcY5DoFAv3SZe0YbislBMk5yEokq+69sybmZnHfpw8EDkMku6nhyNBI5iS
 Y5ucEmAZ8O2dW+oxm39IFYbH+mtP4hOCvwL1S1B9Zth6B0mUKnIcAifCU9Bkg5/l3pGiqMoXkcr
 WAt3CQTTlRVGteVtT42w4LjY0l9QT2ibDY9i76W1pMzJ0poOZ9/BR84CDA4LjSwCX4y6+I/tTfY
 p+AyMT9IejMjwVgAwnAq6EWZCfqN5zMY+LWhtvxTwISgbZPKnj6G3ut2Vkxv/IZkRvCsD5SIBQy
 Q++mkHieYk50ATFIm11/aWH4BoN6+Z4wrIAcMB/637a90K1mxZWx2WOTmvT8SNOIYtg8dZrsPuA
 7Z7AZl8Av2kv0QRIwa3bxYHInGqFetg3gFHUuJxO/OF2itUSCV/KMl/p85CHpCzkyEOea+k5YEa
 kSEmTVkXEe7EyDedTf5ThswuWuuXDQ=
X-Received: by 2002:a05:7022:418f:b0:11b:38b6:a95a with SMTP id
 a92af1059eb24-12703f4f89bmr6363849c88.11.1770690759828; 
 Mon, 09 Feb 2026 18:32:39 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127041e5460sm9564019c88.6.2026.02.09.18.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 18:32:39 -0800 (PST)
Date: Tue, 10 Feb 2026 10:32:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org
Subject: Re: [RFC PATCH v5 0/7] riscv: add initial sdext support
Message-ID: <aYqWyJ-2HBSzoZGe@ZEVORN-PC.localdomain>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
 <3e07e5b4-0a6a-4fc1-9ed2-57624d0e96dc@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e07e5b4-0a6a-4fc1-9ed2-57624d0e96dc@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 09, 2026 at 04:21:09PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 2/3/2026 9:55 AM, Chao Liu wrote:
> > Hi,
> > 
> > Per Daniel's review feedback, this v5 series is based on Alistair's
> > riscv-to-apply.next branch [3]. It depends on patches 1-5 of Max Chou's
> > "Add Zvfbfa extension support" v2 series (not included; apply them
> > first) [2].
> > 
> > It is based on RISC-V Debug Specification 1.0 [1].
> > 
> > It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
> > Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
> > trigger action=debug mode.
> > 
> > To reduce review load, this series focuses on the Sdext features first.
> > The Debug Module (DM) and related flows will follow in a later series.
> 
> 
> We still need a reviewed-by in patch 1 (that I can't give, after all it's my
> patch hehe).
> 
> Aside from that the series LGTM. It's not sensible to think that we're going
> to push upstream an error/bug free extension. The code will need more
> mileage with more people using it and we'll fix what is needed along the
> way. We have a long time until the release anyway.
> 
> My vote is to queue this up (we'll need Max's series queued first). When
> this lands upstream we'll go back to the Server SoC reference board and get
> that upstreamed too.
> 
I agree with your points. I’ve also added a Reviewed-by sign-off to patch1.

Thanks,
Chao
> 
> Thanks,
> Daniel
> 
> 
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
> >    the extend tb flags." (not included; apply it first) [2].
> > - Patch 2: default sdext to false in riscv_cpu_extensions[].
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
> >    the extend tb flags." [2].
> > - Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
> >    inst-count triggers in tinfo.
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
> > References:
> > [1] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> > [2] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
> > [3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
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
> >   target/riscv/translate.c                      |  16 ++-
> >   16 files changed, 545 insertions(+), 25 deletions(-)
> > 
> > --
> > 2.53.0
> > 
> 

