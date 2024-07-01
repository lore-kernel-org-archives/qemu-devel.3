Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFhj-0006Ij-Bl; Mon, 01 Jul 2024 08:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOFhf-0006Ht-5i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:00:15 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOFhZ-0006FB-1g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:00:14 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so33388641fa.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719835205; x=1720440005; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mmyfMxDWtGloWx5cH5bGWkqDtB4PbAEP7YCYfDaa3n4=;
 b=Y0rMLSAYsGwIX2/oytzvUTtIoQ+h89dDXJ9kRkjUvjqB1X8BimugoVWMw0b3Ol0yX8
 N3Ir2dm9gDuDOaaNYx2uftnJSpgNC1KRDPaHgYThQdNOm0N09oHJd7b/FeqtccbD8CnW
 JgNqMChz7fI23PWtQnxFkIemQcweky2BYKiyR+Vf9qLJnwsStm97ciTjyrmSUZFNNBnL
 AGyfykvcIQO65HIgbXwVFZVbPm8Pum92EZC7GRkBs8Nc3pXMH+d2TQ/6c69M1MTCMzG9
 eVFFbL1EsOTJgPLt3OsWn4uWMBE8sSDa33zjAHwPKm2ZFzfUCv1J4bdVGqXOnBFmwuCh
 AyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719835205; x=1720440005;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mmyfMxDWtGloWx5cH5bGWkqDtB4PbAEP7YCYfDaa3n4=;
 b=O20vWG+t78dI5rBn68RJyNgpqnCZFC2T/G07gHDN/CdWP1IW3FS1Nyl5v9EY2AqgwK
 Ly57z7aanRJ50AerA30+YpJStsbSjNvChEycU2qkwzoSr83pCjiNufK9NvhKnDVXKm7D
 G/yhm5/ydPy4+cswzoQCO8KTaPA5lQA7pir/R9tVkFcIahsZVuQwPvGj51CFTc3RmUKk
 e8+XPCYpeZtOQT8UOS2fYmTjUtFGWYmq/o7IWtHHb42bMTWR+QICaFHVa/bNdbNexme0
 UZHnqM7RIM6xeQ5+EojdGWjYmoph5gAO9ZZxHJ2c8FlTZKz4VGwHmM9qo1z7dOrYwar/
 4RmA==
X-Gm-Message-State: AOJu0YyEYABKRdaFiqP2IFkFoBqxyM55viNFi0IaHvI86Zgvt77LkOV2
 EmzDnCUe4ENKng7m7s/qchrYI47a0MoMJD8AXPSH6fCPNEbk/s1/0/hcggOK5Qs=
X-Google-Smtp-Source: AGHT+IHkBg1HwbHtuKzMxXrWiYFSAnAWqfhjCSnX6Q8OxA3TDIzaIEqC+Xp3mcff1ePd191EFdeEUQ==
X-Received: by 2002:a05:651c:b23:b0:2ec:5fa1:2434 with SMTP id
 38308e7fff4ca-2ee5e33a9e5mr37663871fa.9.1719835205543; 
 Mon, 01 Jul 2024 05:00:05 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569467sm63082765ad.227.2024.07.01.04.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 05:00:05 -0700 (PDT)
Message-ID: <98664badcc2eec3d5816a3fdacc7fd5c974c8905.camel@suse.com>
Subject: Re: [PATCH v3 04/15] hw/core/machine: Add igvm-cfg object and
 processing for IGVM files
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Mon, 01 Jul 2024 12:59:54 +0100
In-Reply-To: <Zn6dSd6NiZl0_NeK@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1b2fe6b03cba51f2f64c899163b9a0b7eea35b47.1718979106.git.roy.hopkins@suse.com>
 <Znl74gNWUQQxR_oE@redhat.com>
 <2171f08dc6630e20201d04cd96f84366111fae20.camel@suse.com>
 <Zn6dSd6NiZl0_NeK@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::22b;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x22b.google.com
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

On Fri, 2024-06-28 at 12:23 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 28, 2024 at 12:09:59PM +0100, Roy Hopkins wrote:
> > On Mon, 2024-06-24 at 15:00 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Fri, Jun 21, 2024 at 03:29:07PM +0100, Roy Hopkins wrote:
> > > > An IGVM file contains configuration of guest state that should be
> > > > applied during configuration of the guest, before the guest is star=
ted.
> > > >=20
> > > > This patch allows the user to add an igvm-cfg object to the machine
> > > > configuration that allows an IGVM file to be configured that will b=
e
> > > > applied to the guest before it is started.
> > > >=20
> > > > If an IGVM configuration is provided then the IGVM file is processe=
d at
> > > > the end of the board initialization, before the state transition to
> > > > PHASE_MACHINE_INITIALIZED.
> > > >=20
> > > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > > ---
> > > > =C2=A0include/hw/boards.h |=C2=A0 2 ++
> > > > =C2=A0hw/core/machine.c=C2=A0=C2=A0 | 20 ++++++++++++++++++++
> > > > =C2=A0qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++=
+++++++++
> > > > =C2=A03 files changed, 47 insertions(+)
>=20
> snip
>=20
> > > This adds igvm-cfg for all machines, regardless of architecture targe=
t.
> > >=20
> > > Are igvm files fully cross-platform portable, or should we just put
> > > this into the TYPE_X86_MACHINE base class to limit it ?
> > >=20
> > > It at least reports errors if I try to load an IGVM file with
> > > qemu-system-aarch64 + virt type
> > >=20
> > > $ ./build/qemu-system-aarch64 -object igvm-cfg,file=3D../buildigvm/ov=
mf-
> > > sev.igvm,id=3Digvm -machine virt,igvm-cfg=3Digvm
> > > qemu-system-aarch64: IGVM file does not describe a compatible support=
ed
> > > platform
> > >=20
> > > so that's good.
> >=20
> > The IGVM specification is designed to support non X86 platforms, hence =
its
> > inclusion for all machines.=C2=A0Support for non-X86 is likely to resul=
t in
> > changes
> > to the specification though that will impact the library we depend on.
> >=20
> > There would obviously need to be some further implementation to support=
 non-
> > X86
> > machines in QEMU, in the same way that further implementation is requir=
ed to
> > support other X86 confidential computing platforms such as TDX.
> >=20
> > So, this poses the question: should we move it to TYPE_X86_MACHINE as t=
he
> > current supported platforms are all on X86? Or should we leave it where=
 it
> > is
> > with a view to adding non X86 platform support with less impact later? =
I'd
> > appreciate your views on this.
>=20
> The pro of putting it in the base machine class is that we don't need to
> repeat the property creation in each machine as we broaden support to oth=
er
> arches, I presume aarch64 is probably most likely future candidate.
>=20
> The downside of putting it in the base machine class is that it limits
> mgmt app ability to probe QEMU for support. ie it wouldn't be possible
> to probe whether individual machines support it or not, as we broaden
> QEMU support.
>=20
> Then again, we will already face that limited ability to probe even on
> x86, as we won't be able to query whether IGVM is SNP only, or has been
> extended to TDX too.
>=20
> With my libvirt hat on, probing is still probably the more important
> factor, so would push towards putting the property just to individual
> machine classes that definitely have been wired up to be able to use
> it.
>=20
> With regards,
> Daniel

Ok, thanks. I'll move the instance to 'X86MachineState' and the call to=C2=
=A0
'igvm->process()' into 'pc_q35_init()' and 'pc_init1()'.

Regards,
Roy


