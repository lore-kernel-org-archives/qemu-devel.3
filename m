Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9254C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 07:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rStrF-0007HN-3G; Thu, 25 Jan 2024 02:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rStrC-0007G6-RB; Thu, 25 Jan 2024 02:09:03 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rStrA-0001UY-Ld; Thu, 25 Jan 2024 02:09:02 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-599a6d731easo1713478eaf.1; 
 Wed, 24 Jan 2024 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706166535; x=1706771335; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+atoXai5trvSDP/Nbzt582yyAZCcrYkTr6J6VWHTJc=;
 b=kqQFWAi7+sQxNTS01iJtDekZrEmfYHGq7MKc3DyFFcfWIZUO8HOX2FmghMAnT4zrHt
 D1PIE9t8Dx/+EKrK4hSSF7LiLMF0hzSguxJIUwbS1Q5ZawgvDrLTmQG62lgV+usMel0x
 7yMZPAcreXxdRn7ebp6YwZaVlh0+nwEz/GSZA3U8+F/52Ie9VuRRt/kzcZcQtOSzzILU
 sWK8DQjS02d439xDdhqf5hYvTUEKuUTu05scOzBSRfkE2ix1REjCk0Lu7S8tIe5jUxuC
 zKW7SBjyQ7YyEDRT3/TWjWmUyYcgcCTAc1AKCeJ3FybDjIImgejTi2+7jLW6hlahN8T+
 7idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706166535; x=1706771335;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z+atoXai5trvSDP/Nbzt582yyAZCcrYkTr6J6VWHTJc=;
 b=HuDbUMCRUlLHPtFDPswkvS1QujyjIkem5zvm13uFA/HxnSCwpu3Zre1MaaBbRzup2h
 hqM3bZ9XpGFNFvUG0g8TXflq0s/j6Si1zY96OodsFFpYfMHNi2VaheXe1Ga7S5HgBo98
 gdFsIgNHiatNGTB0J+LUrJAcw1L7spuDlpJ6SjWHVEjHHA+moRL+43WYdn4kNgAXQaD7
 pP+iiuFaRW9UH0L2uykVbMBZ4h9lA7o59tCTLhkEc3s7oTtB0vsWDQNWWJumC8QOC/Pc
 OVAE+kO+decBUG5pePC5ir1VGLw0fwjoKRcJCu9e1s/8rc1q3f6sXXYLWaQ1km5PvCvz
 IxcA==
X-Gm-Message-State: AOJu0YxGkNz60FaLXijlimobvW0Nzryj8pjpuMRqnRWPJcwYfvB3tbCE
 Fk+X+KlReJ/zAq0Cz7OAlzWXb4TCn32I7HImJvkxf6iiPyWFrlZp
X-Google-Smtp-Source: AGHT+IGFNsY+h7Wj9F4W5g2W7c5MSxgTgsMxcGDdjsa57IAZEfhFOje1Bd8Roy9QxZVt820/N4vLjA==
X-Received: by 2002:a05:6358:5288:b0:176:3451:7ce2 with SMTP id
 g8-20020a056358528800b0017634517ce2mr785409rwa.28.1706166534976; 
 Wed, 24 Jan 2024 23:08:54 -0800 (PST)
Received: from localhost (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a170902d64300b001d74031b250sm6918347plh.266.2024.01.24.23.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 23:08:54 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2024 17:08:49 +1000
Message-Id: <CYNLK2X6DAAA.2I40127UHT4UN@wheely>
Subject: Re: [PATCH 2/8] ppc/spapr|pnv: Remove SAO from pa-features when
 running MTTCG
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: <qemu-ppc@nongnu.org>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240118140942.164319-1-npiggin@gmail.com>
 <20240118140942.164319-3-npiggin@gmail.com> <ZanA-usH_Ec0uqie@zatzit>
 <CYLPOZ0VDE7U.40VIK25R65PQ@wheely> <ZbHRaWhUbpsHa4I-@zatzit>
In-Reply-To: <ZbHRaWhUbpsHa4I-@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu Jan 25, 2024 at 1:11 PM AEST, David Gibson wrote:
> On Tue, Jan 23, 2024 at 11:57:56AM +1000, Nicholas Piggin wrote:
> > On Fri Jan 19, 2024 at 10:23 AM AEST, David Gibson wrote:
> > > On Fri, Jan 19, 2024 at 12:09:36AM +1000, Nicholas Piggin wrote:
> > > > SAO is a page table attribute that strengthens the memory ordering =
of
> > > > accesses. QEMU with MTTCG does not implement this, so clear it in
> > > > ibm,pa-features. There is a complication with spapr migration that =
is
> > > > addressed with comments, it is not a new problem here.
> > > >=20
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > ---
> > > >  hw/ppc/pnv.c   |  5 +++++
> > > >  hw/ppc/spapr.c | 15 +++++++++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >=20
> > > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > > index b949398689..4969fbdb05 100644
> > > > --- a/hw/ppc/pnv.c
> > > > +++ b/hw/ppc/pnv.c
> > > > @@ -158,6 +158,11 @@ static void pnv_dt_core(PnvChip *chip, PnvCore=
 *pc, void *fdt)
> > > >      char *nodename;
> > > >      int cpus_offset =3D get_cpus_node(fdt);
> > > > =20
> > > > +    if (qemu_tcg_mttcg_enabled()) {
> > > > +        /* SSO (SAO) ordering is not supported under MTTCG. */
> > > > +        pa_features[4 + 2] &=3D ~0x80;
> > > > +    }
> > > > +
> > > >      nodename =3D g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
> > > >      offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
> > > >      _FDT(offset);
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 021b1a00e1..1c79d5670d 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -284,6 +284,21 @@ static void spapr_dt_pa_features(SpaprMachineS=
tate *spapr,
> > > >          return;
> > > >      }
> > > > =20
> > > > +    if (qemu_tcg_mttcg_enabled()) {
> > > > +        /*
> > > > +         * SSO (SAO) ordering is not supported under MTTCG, so dis=
able it.
> > > > +         * There is no cap for this, so there is a migration bug h=
ere.
> > > > +         * However don't disable it entirely, to allow it to be us=
ed under
> > > > +         * KVM. This is a minor concern because:
> > > > +         * - SAO is an obscure an rarely (if ever) used feature.
> > > > +         * - SAO is removed from POWER10 / v3.1, so there is alrea=
dy a
> > > > +         *   migration problem today.
> > > > +         * - Linux does not test this pa-features bit today anyway=
, so it's
> > > > +         *   academic.
> > > > +         */
> > > > +        pa_features[4 + 2] &=3D ~0x80;
> > >
> > > Oof.. I see the reasoning but modifying guest visible parameters base=
d
> > > on host capabilities without a cap really worries me nonetheless.
> >=20
> > Yeah :( It's not a new problem, but changing it based on host
> > does make it look uglier I guess.
>
> It's not really about whether it looks uglier, it's the fact that any
> dependency of guest visible aspects of the VM on host properties is a
> potential landmine for migration.
>
> The qemu migration model is - pretty fundamentally - that the VM
> should look and behave, from the point of view of the guest, the same
> before and after migration.  If the behaviour of the VM changes based
> on host properties it breaks that assumption, and it does so in a way
> that the user can't control or even easily predict.  Tools such as
> libvirt, or even qemu itself, can't verify that the migration is valid
> if there are effectively invisible parameters to the VM configuration
> that come from the host instead of the command line.

I agree, you did manage to drill this lesson in.

What I meant was that -- today we have a problem where a target can
run on a host with buggy implementation, whether boot or migration.
This patch addresses the boot case. Migration case is still broken,
arguably the situation is still improved. Anyway...

> > Other option could be to just disable it always. I don't mind
> > but someone did mention experimenting with it when I asked
> > about removing support from Linux. They could still test with
> > bare metal, and if ever started actually being used then we
> > could add a cap for it.
>
> I think that's a better idea.

Alright we'll go that way.

Thanks,
Nick

