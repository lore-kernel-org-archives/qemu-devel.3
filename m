Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC029CF6A86
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlfG-0000Sx-2M; Thu, 08 Jan 2026 03:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cuiyunhui@bytedance.com>)
 id 1vdlf4-0000LF-GC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:46:31 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cuiyunhui@bytedance.com>)
 id 1vdlf1-0006q5-WF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:46:30 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso2196376fac.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1767861982; x=1768466782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOcCsHo1DgMEXA5RVgANPUshiw64yx6M7ZjGkTRep7s=;
 b=C65ti6e3TSHvOwsv+lT3WSMM7lyo60EA9tio402Vw7WVRZ5fQTggWTmnJtgxqxyLhe
 K/8V1vHsFOIh5a167R0J0EyBIBTDQg636eTlTNWz6aUItp2UxtH2/lxz6xcZKcJznjjk
 gNQ34PreoyPZ3qMEo+Bt0FVOGX7kM3Cd560ZlGuIlvyo1C9Zs03hUYoJGGmw9jNVmK/b
 ON+Risy1XBXUR6iF+MywZ7lZ6046HvxU60ZLEu4W1Qr38tLZkcKbvnFWNIhg1gmjRHp4
 LcOQyZtkpi1PUPBXF1bvr2GDXXEPAu3o+ZVTD1SBFTyDY9o1UYtfMM7jUJg4alC8SQ76
 7phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767861982; x=1768466782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOcCsHo1DgMEXA5RVgANPUshiw64yx6M7ZjGkTRep7s=;
 b=aT5Ihb5je956CyZsHCvEZYH5qbG+8Eu8mqVj4e4kbbNmH7lgWQPK4iTIwIRxWpb2kc
 MU/guw3GNWYyL7PGpBaVW86UAcWfdzuuZ2j6pnyjFtXNUcWrDjVBmNxkhenCI9sjbpAS
 PUvmRC80eapEPLSG3ECVX829qyIpa8bgxxY82WEos+mCr1qGfJkLK1SAYOaxhUS82Tji
 GebeLzyPNPiUXeU50jO+BjDftD53wwfDRtHNN27vVjzwVNUTrS53P0MEir0nWO+DeckD
 rcbc7hy0l/72Vua2eg+xR0WxgTBVZaaw0msWqxeRHL1xfyU0ovmhgE5/TDs9r93SKDyN
 OBoQ==
X-Gm-Message-State: AOJu0YzSaTSwTs3pejHxbTC9tMQDJosN+o6B5bR4WKAeNDnGYci06t8M
 ZGA0UeGsNj/Zui/48HHUygUsGIA0UtUJTalp5JVqDbyP8Avcoh4+gd8PPeHNxpEC/lLmy9oJuGm
 EMmjHngx6ofIbapFuqRWsxmWT7zmLt/rZgzHBPqZArw==
X-Gm-Gg: AY/fxX63Z5XLf7XxAXzW1ayNdt3XlC9dvkZE87isZZDZGlfUBs+UFz790ly9I3pcg/X
 pmzsmdJ0Hlk6J1Ol+dFkGEvhXiOrQ0qn5oGq5Fx09qA61LEwRnrvFrfZWl2eIna2+Tsy2mAOAev
 oyydCChRJUb6ETJE82l4B79JPhan/ADbiAJsE2eD4AAHKx/WLUZdnk/EBW+v78Ffo51fV011woY
 fXYsI3E/TZFb+pNC1n6X6GbXxBvNkfJ7MZdZJSmeoywaTyuwJlGJA9iNVSKDw7ANb9O9uNllu2G
 IL850oqCtxic
X-Google-Smtp-Source: AGHT+IESecoVtNr2CIMvXCAuXAC1c9qZCW708g/6536pOfT7o5izR39d2ZOLzbq16iDhtUk2e9RyvlDVORGrZwAfcKY=
X-Received: by 2002:a4a:b28d:0:b0:659:9a49:8f2f with SMTP id
 006d021491bc7-65f550a571emr1667862eaf.64.1767861982382; Thu, 08 Jan 2026
 00:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
 <CAEEQ3wkM9h0kJNE4yTtN5ms2JgRBp6b_530KM8irbGKzjMkrgg@mail.gmail.com>
 <aV9drIreiKV84MjG@x1>
In-Reply-To: <aV9drIreiKV84MjG@x1>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 8 Jan 2026 16:46:10 +0800
X-Gm-Features: AQt7F2puqvhDQwmNWuREZQ3iCGPXMtZCqGltXUKAVwgK_lVg5XIpS_xbbx-1oUA
Message-ID: <CAEEQ3wmebe9ArBEYP--mh3f6Na_k-V6y+CWCCrUzGdCRpibHqQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 0/6] riscv: implement Ssqosid extension
 and CBQRI controllers
To: Drew Fustini <fustini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=cuiyunhui@bytedance.com; helo=mail-oa1-x2f.google.com
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

Hi Drew,

On Thu, Jan 8, 2026 at 3:33=E2=80=AFPM Drew Fustini <fustini@kernel.org> wr=
ote:
>
> On Wed, Jan 07, 2026 at 03:38:34PM +0800, yunhui cui wrote:
> > Hi Drew,
> >
> > On Tue, Jan 6, 2026 at 5:55=E2=80=AFAM Drew Fustini <fustini@kernel.org=
> wrote:
> > >
> > > This series implements the RISC-V Quality-of-Service Identifiers
> > > (Ssqosid) extension [1] which adds the srmcfg register. It also
> > > implements the RISC-V Capacity and Bandwidth Controller QoS Register
> > > Interface (CBQRI) specification [2]. Quality of Service (QoS) in this
> > > context is concerned with shared resources on an SoC such as cache
> > > capacity and memory bandwidth.
> > >
> > > Sssqosid srmcfg CSR
> > > -------------------
> > > The srmcfg CSR configures a hart with two identifiers:
> > >
> > >  - Resource Control ID (RCID)
> > >  - Monitoring Counter ID (MCID)
> > >
> > > These identifiers accompany each request issued by the hart to shared
> > > resource controllers. This allows the capacity and bandwidth resource=
s
> > > used by a software workload (e.g. a process or a set of processes) to=
 be
> > > controlled and monitored.
> >
> > 1. The CBQRI specification does not mandate 64-byte access width for
> > its registers. Therefore, is it necessary to add a field in the ACPI
> > RQSC table?
>
> Sorry, I don't follow. Why would a new field be needed in RQSC?

Different manufacturers may design CBQRI registers with different
widths (32-bit or 64-bit). See:
https://github.com/riscv-non-isa/riscv-rqsc/issues/10

>
> > 2. In addition, although CBQRI does not require configuring a specific
> > number of RMIDs for each CLOSID like MPAM does, creating a control
> > group will by default create a monitoring group. So on RISC-V, the
> > number of MCIDs should be at least no less than that of RCIDs, right?
>
> Yes, I have working on the assumption that the number of MCIDs (RMIDs)
> will be greater than, or equal to, the number of RCIDs (e.g. CLOSIDs).
>
> Chapter 6 of the CBQRI spec states that: "In a typical implementation,
> the number of RCID bits implemented (for example, to support 10s of
> RCIDs) might be smaller than the number of MCID bits implemented (for
> example, to support 100s of MCIDs)."
>
> I would be very interested if anyone can share the RCID and MCID count
> for their CBQRI hardware implementation.
>
> > 3. By the way, for Linux, could you also release a version of the
> > CBQRI/Ssqosid patchset with ACPI support?
>
> The series I am about to post for Ssqosid+CBQRI [1] just contains a
> device tree example, but I will do a followup series for RQSC. The
> kernel branch [2] from the RQSC proof-of-concept was based on v6.14 so I
> need to rebase it. The good thing is that 6.19 now has the PPTT helpers
> from the MPAM driver series.

Oh, that's great! When will the RQSC-supported patchset based on 6.19
likely be posted? Looking forward to your update.

>
> Thanks,
> Drew
>
> [1] https://github.com/tt-fustini/linux/tree/b4/ssqosid-cbqri
> [2] https://github.com/tt-fustini/linux/tree/dfustini/cbqri-mpam-snapshot=
-v6.14-rc1


Thanks,
Yunhui

