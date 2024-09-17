Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A7FCAC581
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZX1-00028N-DK; Tue, 17 Sep 2024 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqZWm-0000zh-5f
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:50:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqZWi-0003Ic-Hj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:50:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so3731762f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726584598; x=1727189398; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wJogFBELuzvb1PRQUyy0Dd9nwBPVV9ZQawuJiGzMtxg=;
 b=egGgFuwUB1XRlZclbR/m5e27jiPiaruPFFflA2RAjiRXEJcsfIqdzn5uvANRnxJOKK
 EvLOlFQxfosor3IP5V61TeAE4mP5c7A2ghBhGLR3AyQ5fvOuUyWM0x3LNphoI5FwVUkT
 DPZljAw3BUiZtQanK95PinemXDSurtWZK/8k84AviLH+tAHBR2TyRR/sev30aa9PrlsQ
 r/crIYZRNU/vFjjPfiGL32ph7IGeKA+Bn/qKTHcPdGnKY5qeTPYUTlE1LgR8bx9v7jQy
 nbdt7dBMJ2fFUcVdLop+OOdpwkuepUkYDqQbzbBwS7TNJLZd4bfKpsvG1IQWe2H3GAQF
 JPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726584598; x=1727189398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJogFBELuzvb1PRQUyy0Dd9nwBPVV9ZQawuJiGzMtxg=;
 b=cDC5uRTu6SKYzXmIltAtKMWLituaZ6MoXQHLqICAtgvO8BtEpcMe4iX4FbD9+gumn8
 5G7QYXSPOCn5P1WAL6qqGpTtTY+trnAOU7SjOBPW+WhVb/jTvYlmKaOBbdHzLCQ93KXA
 XYKNInBElPpabLZsW7hBjIfmkcye15QqufiXn8pkRlCurQjlbKYHUDFgscpmg6zYm8DO
 FWSFkw7XlhSqAV8Mow/nIkj3Wnfd1yCYbDJmkVmW8ZnLcYYl8GmU1chttsjhSmNf7s9k
 /NDrthbBCVqi5idgQ93bjn6BLDvGHwdgVPnPT5dS4bz+UTH27iw3/zFyZyrrIW7VWVVF
 xT0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIcdxQUbGkdw0A/2Vdjb8MpnkObzNsxn48aXPUQ3na/Ez76IkkdNjX/hFUle8mxve1vkj8KgiDin8o@nongnu.org
X-Gm-Message-State: AOJu0YyTzxZORIvqU0ZkH4uOqLEJ767z8igE8OQyMagOAr/Rj7cl4D56
 88RvUpwIeWfX2WHfQUTXLuHJILjwCSWrXe/zhf5XO0JSjnEkCY6Cj4JSV87/mvw=
X-Google-Smtp-Source: AGHT+IHsw1n4nFb8AM4GbZs6I8V/ahBphNJG6B7WQ2rGtkN39D/GSKuBolFB4D2jdW/4IfYwN8xEtQ==
X-Received: by 2002:adf:fcd2:0:b0:374:c8cc:1bb1 with SMTP id
 ffacd0b85a97d-378c2d51632mr11335192f8f.39.1726584597793; 
 Tue, 17 Sep 2024 07:49:57 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f9b10sm9770906f8f.59.2024.09.17.07.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 07:49:57 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:49:56 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
Message-ID: <20240917-b13c51d41030029c70aab785@orel>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 17, 2024 at 03:28:42PM GMT, Heinrich Schuchardt wrote:
> On 17.09.24 14:13, Andrew Jones wrote:
> > On Mon, Sep 16, 2024 at 08:16:33PM GMT, Heinrich Schuchardt wrote:
> > > OpenSBI enables the floating point in mstatus. For consistency QEMU/KVM
> > > should do the same.
> > > 
> > > Without this patch EDK II with TLS enabled crashes when hitting the first
> > > floating point instruction while running QEMU with --accel kvm and runs
> > > fine with --accel tcg.
> > > 
> > > Additionally to this patch EDK II should be changed to make no assumptions
> > > about the state of the floating point unit.
> > > 
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   target/riscv/cpu.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 4bda754b01..c32e2721d4 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
> > >       if (mcc->parent_phases.hold) {
> > >           mcc->parent_phases.hold(obj, type);
> > >       }
> > > +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
> > > +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
> > > +        for (int regnr = 0; regnr < 32; ++regnr) {
> > > +            env->fpr[regnr] = 0;
> > > +        }
> > > +        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
> > > +    }
> > 
> > If this is only fixing KVM, then I think it belongs in
> > kvm_riscv_reset_vcpu(). But, I feel like we're working around an issue
> > with KVM synchronization with this, as well as with the "clear CSR values"
> > part of commit 8633951530cc ("target/riscv: Clear CSR values at reset and
> > sync MPSTATE with host"). KVM knows how to reset VCPUs. It does so on
> > VCPU creation and for any secondaries started with SBI HSM start. KVM's
> > reset would set sstatus.FS to 1 ("Initial") and zero out all the fp
> > registers and fcsr. So it seems like we're either synchronizing prior to
> > KVM resetting the boot VCPU, not synchronizing at all, or KVM isn't doing
> > the reset of the boot VCPU.
> > 
> > Thanks,
> > drew
> 
> Hello Drew,
> 
> Thanks for reviewing.
> 
> Concerning the question whether kvm_riscv_reset_vcpu() would be a better
> place for the change:
> 
> Is there any specification prescribing what the state of the FS bits should
> be when entering M-mode and when entering S-mode?

I didn't see anything in the spec, so I think 0 (or 1 when all fp
registers are also reset) is reasonable for an implementation to
choose.

> 
> Patch 8633951530cc seems not to touch the status register in QEMU's
> kvm_riscv_reset_vcpu(). So it is not obvious that this patch could have
> caused the problem.

I don't think 8633951530cc caused this problem. It was solving its own
problem in the same way, which is to add some more reset for the VCPU.
I think both it and this patch are working around a problem with KVM or
with a problem synchronizing with KVM. If that's the case, and we fix
KVM or the synchronization with KVM, then I would revert the reset parts
of 8633951530cc too.

> 
> Looking at the call sequences in Linux gives some ideas where to debug:
> 
> kvm_arch_vcpu_create calls kvm_riscv_reset_vcpu which calls
> kvm_riscv_vcpu_fp_reset.
> 
> riscv_vcpu_set_isa_ext_single and kvm_riscv_vcpu_set_reg_config
> only call kvm_riscv_vcpu_fp_reset if !vcpu->arch.ran_atleast_once.
> 
> kvm_riscv_vcpu_fp_reset sets FS bits to "initial"
> if CONFIG_FPU=y and extension F or D is available.
> 
> It seems that in KVM only the creation of a vcpu will set the FS bits but
> rebooting will not.

If KVM never resets the boot VCPU on reboot, then maybe it should or needs
QEMU to inform it to do so. I'd rather just one of the two (KVM or QEMU)
decide what needs to be reset and to which values, rather than both having
their own ideas. For example, with this patch, the boot hart will have its
sstatus.FS set to 3, but, iiuc, all secondaries will be brought up
with their sstatus.FS set to 1.

Thanks,
drew

