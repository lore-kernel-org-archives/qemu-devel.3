Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B97DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeBb-0001MM-Fp; Tue, 01 Jul 2025 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeBY-0001Ld-HW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:50:20 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeBS-0005Wy-Nf
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:50:18 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e81826d5b72so4752173276.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751388610; x=1751993410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35ez7Kc170voOUq5A4zUyhLBeVOgMP189lwSGDqJvck=;
 b=muYSX2upPlxE7Zm038ltMpO8cfyBVBVLW6zuE/8iM4MUgIzFbSOSkYqg4+S3Ug1xAH
 Wt7Jh4yXlKYPDtvZL1aLAuQSJ1rf6xE3QGQdN1CofF5FHZfXAP2gtA9jN0DX/PGBXYPz
 OUhSyNOXdrduLN2NXrorsG/mdUfxomV+R/GJ3Vm/HVgGlNeLT3f+vLxtd7SKmew0HopY
 5MpVXzukUN/XJSMl4EJInh9MbuxH/3R/EyLxvuTSM+Z7zCFLT89EHhpUpAgmSjPV//6Y
 bV708DLEQ8V3eK10A5+pVHXJ54xc1tMaGOdBrv1Ry+TKBPl+yU3f795O0xUu1OTFu5j1
 8uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751388610; x=1751993410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35ez7Kc170voOUq5A4zUyhLBeVOgMP189lwSGDqJvck=;
 b=DOwFo3u3LkyNgmdBixAFxQx0qKFh+GseW3hl2GsI7PbuPXEwbvs83RI5dJVJZ1/5wv
 cC30N/MFPNnbvvoSUQCQCNmnuqFe9xVAWWAHDpmwDzz22V8NwEF2Up8A8YzeUBiLgfLS
 vCRkhq5iuhqK+oASsOnlmfRLgraMjyHcwgWNl0mjb12fMC2lmFquTVFGBjjWk9+b+vwy
 MEEgDpmYaAw0v07bzMgtNIB50oavs9bcgwkvIHNV4uVCZU5rIHKFILeTtQ+++8iGUwEs
 O9+9lhPGC+u/AvAoYvh/OrEvTZukNpdeILbiOjgZsTZLAJbsu22Wm+50H/sXwZ4H7kev
 FqoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtr1r4TSNZTp0swpyjrqjnuTIgW+HAZ9tLmHXRSScaSUcRw4ZVFiBlKh6vPjjIarP1C1o3Oj1kq/m@nongnu.org
X-Gm-Message-State: AOJu0YzC+gN1xl4LpPsykXHxMUjVpY+eOY/+/uHnGl7vsMLY86dquQN+
 Hrj9Um0eJXfGNMIKXWTWCklb7tvBuGpmQKBay/HpiiT1uMjuUUA1Put88vDH/wVAUDfrDOZB8yM
 NfkFaAuAZTx4h3D8tJz6KwggLDtCz57PCeEqURlvuMw==
X-Gm-Gg: ASbGnctXuNwrqYvBNzUhsHoxLk/NHYO2jkIWcBK1DZCdowpNwoAzilXptr0E2UJhTl6
 eTPJoUStwjiFa0Cr0qsgnw3jjRxYA3VPJgpaKL5JGGGELXRpuXrAi0Zw79rPqgA93beKcIJOiwY
 fbMQDLoz3J2H8zRVMcn2/V3L9Imz0PMLcfS0UUS+0z3RJc
X-Google-Smtp-Source: AGHT+IFTfzg7zxbm1tLzoaUaVZDl2uQqTZJq8NNLOxX6vxXh0XpyMCVDc9uv5IHO5vj5V+Jkhzbnk6Q9LwooxYwplk0=
X-Received: by 2002:a05:690c:30c:b0:714:3e9:dd3 with SMTP id
 00721157ae682-715171582c0mr277642827b3.6.1751388609643; Tue, 01 Jul 2025
 09:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-14-cohuck@redhat.com>
 <CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com>
 <87bjq3rj3a.fsf@redhat.com>
In-Reply-To: <87bjq3rj3a.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 17:49:57 +0100
X-Gm-Features: Ac12FXxH6G6SW_BVrh5mED54ufWIrOs3TRJVPA_Y5UCQOxGxPr3hVy6_FRNJx3A
Message-ID: <CAFEAcA8+OjptoJgPDeQkw5TQtVduhq-KvP-Br6JNDmW57jgXbw@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] arm/cpu: switch to a generated cpu-sysregs.h.inc
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 1 Jul 2025 at 17:07, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Jun 30 2025, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Tue, 17 Jun 2025 at 16:41, Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> Generated against Linux 6.15.
> >>
> >> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >
> > Stripping out all the lines that just moved around,
> > here are the additions:
> >
> >> +DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)
> >
> > This is ARMCPU::id_afr0. If we want to store this in
> > the idregs[] array that's fine but we ought to move it.
> >
>
> I guess the *afr* regs fell into the cracks because they were not in the
> isar struct -- makes sense to move them.
>
> (This reg "must be interpreted with" MIDR_EL1; I'm wondering if that has
> any implications once we enlighten guests with possible midr/revidr/aidr
> values.)

It just means that the contents are entirely implementation
defined, so you can't tell what they mean unless you first
look at MIDR_EL1 to find out what your implementation is.

(Linux doesn't appear to ever look at the AFR0 registers.)

> >> +DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
> >
> >> +DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
> >
> >> +DEF(ID_AA64DFR2_EL1, 3, 0, 0, 5, 2)
> >
> > These are all ID registers we don't implement yet
> > because we don't implement any features that are
> > described in them (i.e. our implementation is RAZ/WI).
> > I guess it's OK to list them here, though we won't
> > do anything with the array entry.
>
> I don't think it hurts to include them, it makes things easier when we
> want to deal with non-zero values in there via kvm.
>
> >
> >> +DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
> >
> > ARMCPU::id_aa64afr0
> >
> >> +DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
> >
> > ARMCPU::id_aa64afr1
> >
> >> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
> >
> >> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
> >
> > More ID regs for features we don't implement yet.
> >
> >> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
> >
> > CCSIDR_EL1 isn't a single ID register, it's an array
> > of them (indexed by CCSELR_EL1). We keep them in
> > ARMCPU::ccsidr[]. I don't think it makes sense to
> > have an entry in isar.idregs[] for this.
>
> Hm, IIUC, kvm gets the correct CCSIDR_EL1 under the covers already
> (i.e. no array).

There's support in the KVM GET_ONE_REG API for reading
and writing the full array (see KVM_REG_ARM_DEMUX_ID_CCSIDR).
We just don't bother in QEMU at the moment because we never
need the values in userspace.

> >> +DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
> >
> > ARMCPU::clidr
> >
> >> +DEF(CCSIDR2_EL1, 3, 1, 0, 0, 2)
> >
> > This is an array too.
>
> Currently, kvm handles this as undef.

That seems like a missing feature in KVM -- it ought to be
implemented on anything where ID_AA64MMFR2.CCIDX says
we have FEAT_CCIDX (which means that the whole cache ID
format changes and the info is split between CCSIDR
and CCSIDR2).

> >> +DEF(GMID_EL1, 3, 1, 0, 0, 4)
> >
> > Another ID register for a feature we don't yet implement
> > (and a slightly oddball one in that it should UNDEF
> > until we do implement FEAT_MTE2).
> >
> >> +DEF(SMIDR_EL1, 3, 1, 0, 0, 6)
> >
> > We implement this as a fixed zero in helper.c.
>
> Undef in kvm.

Probably because KVM doesn't have support for SME in
guests yet ?

> >
> >> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)
> >
> > We construct the value of this one in aa64_dczid_read()
> > based on ARMCPU::dcz_blocksize plus some runtime info.
>
> That one's another bit of a headache (I didn't manage to spot kvm code
> dealing with it.)

The hardware handles it for you -- inside the guest, the
value of the DZP bit depends on HCR_EL2.TDZ (and maybe also
SCTLR_EL1.DZE). The value of DCZID_EL0.BS has to match the
real host CPU anyway because you can't change the block
size that the DC ZVA insn is going to use. (You could
trap DCZID_EL0 accesses via HFGRTR_EL2.DCZID_EL0 if you really
wanted to, but you'd also need to trap-and-emulate the
DC ZVA insns, which is a lot of effort for something
no guest is really going to notice the difference on.)

-- PMM

