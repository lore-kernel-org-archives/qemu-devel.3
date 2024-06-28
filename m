Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D78C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9Uc-0003O5-Uq; Fri, 28 Jun 2024 07:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9UW-0003Nd-RN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:10:09 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9UQ-0001IU-Mg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:10:08 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso4521311fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719573000; x=1720177800; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SgXpsdCvjLoEYsPbbZ4YGvsEvoUAw9naK5S818ptwo4=;
 b=TEbpqzojg6ci6Vg8rrS4fy4x8YFn07gKgh3ktvs2u59CMqOwWvhY3qsgf15ttGfu7n
 i0+TrNfIV4x53fu27lVUhsyzAXPzexL3LxEg91jU/xfoyxJsHC812Crim8UOrutc4feu
 GYc07f/++xXWtstCuy7yYJEd+5veOWn9I36rIvB5lylIE7Eb+0rSjpWC6sNgAoljUTPo
 jroHxZ6UsL3iRkIdxWbQcps8qNcvjngdUY7hziJC6hMevPrGeYSU/JaGMQAIfmgBjV1i
 0smhLx6FtatoWnS+CnWO/AeDiSpMJ7Vsmmyi7NTk4y7m3qLbckxg1jn42jX8VDRPTaL+
 nedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719573000; x=1720177800;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SgXpsdCvjLoEYsPbbZ4YGvsEvoUAw9naK5S818ptwo4=;
 b=erxseuQe/ROjSZWzAkeRr05wy9WmFBPFUJO6UTZtQ2WMi/XKaqTP4jRPhnMhIIpyNl
 Q85J5/bDtk9Dnaj+SXypFSvTqG/NdHDJLPi3Mq5RS4wwAKBlFNXnJ02cqdzkvNXbxFj0
 RifI8Tia4/oYVtBrrbhLTsilnzwBqTir83kC4xgznJjJQWHauOohmzEsiXiMxUbP4GKp
 575mShUdWHSbimHgJE7ukGWwdXR6evNONj9o96T50z91lU4NWqxO07PoC8rfrb1oXFAQ
 EkB0GiU4E4HjPgFOjEkV5PhP2Yqy2TH6+9nv2K6d4NdC5tml/rFYPqSigDcGgIyif4O+
 v7jQ==
X-Gm-Message-State: AOJu0YzGC5FabrMtnBU5aamS0W1a9QlWtlzSOXYmB+KaqlU2aSNhV8Jh
 ZlKfR96iv95+X+pK8fyxttxfMWFP2ffSw7F+2EcG1aah7/kPR4tdfC254nJJMuQ=
X-Google-Smtp-Source: AGHT+IGXNmRoqX2igCWY/UwWCEV/nGf7/UrlVlJdM6iv3vVdJeUvR+DQSYqbZFXAf1/Ae7pdAw8NZA==
X-Received: by 2002:a2e:8792:0:b0:2ec:5699:5e6 with SMTP id
 38308e7fff4ca-2ec5b28ba0dmr97925261fa.26.1719573000239; 
 Fri, 28 Jun 2024 04:10:00 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c172csm30543655e9.41.2024.06.28.04.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:09:59 -0700 (PDT)
Message-ID: <2171f08dc6630e20201d04cd96f84366111fae20.camel@suse.com>
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
Date: Fri, 28 Jun 2024 12:09:59 +0100
In-Reply-To: <Znl74gNWUQQxR_oE@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1b2fe6b03cba51f2f64c899163b9a0b7eea35b47.1718979106.git.roy.hopkins@suse.com>
 <Znl74gNWUQQxR_oE@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::22c;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 2024-06-24 at 15:00 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 21, 2024 at 03:29:07PM +0100, Roy Hopkins wrote:
> > An IGVM file contains configuration of guest state that should be
> > applied during configuration of the guest, before the guest is started.
> >=20
> > This patch allows the user to add an igvm-cfg object to the machine
> > configuration that allows an IGVM file to be configured that will be
> > applied to the guest before it is started.
> >=20
> > If an IGVM configuration is provided then the IGVM file is processed at
> > the end of the board initialization, before the state transition to
> > PHASE_MACHINE_INITIALIZED.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0include/hw/boards.h |=C2=A0 2 ++
> > =C2=A0hw/core/machine.c=C2=A0=C2=A0 | 20 ++++++++++++++++++++
> > =C2=A0qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++++++=
+++++
> > =C2=A03 files changed, 47 insertions(+)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 73ad319d7d..4c1484ba0b 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -4,6 +4,7 @@
> > =C2=A0#define HW_BOARDS_H
> > =C2=A0
> > =C2=A0#include "exec/memory.h"
> > +#include "sysemu/igvm-cfg.h"
> > =C2=A0#include "sysemu/hostmem.h"
> > =C2=A0#include "sysemu/blockdev.h"
> > =C2=A0#include "qapi/qapi-types-machine.h"
> > @@ -382,6 +383,7 @@ struct MachineState {
> > =C2=A0=C2=A0=C2=A0=C2=A0 bool suppress_vmdesc;
> > =C2=A0=C2=A0=C2=A0=C2=A0 bool enable_graphics;
> > =C2=A0=C2=A0=C2=A0=C2=A0 ConfidentialGuestSupport *cgs;
> > +=C2=A0=C2=A0=C2=A0 IgvmCfgState *igvm;
> > =C2=A0=C2=A0=C2=A0=C2=A0 HostMemoryBackend *memdev;
> > =C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * convenience alias to ram_memdev_id bac=
kend memory region
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 655d75c21f..f9f879172c 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1094,6 +1094,16 @@ static void machine_class_init(ObjectClass *oc, =
void
> > *data)
> > =C2=A0=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "con=
fidential-guest-support",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Set confidential guest scheme to
> > support");
> > =C2=A0
> > +#if defined(CONFIG_IGVM)
> > +=C2=A0=C2=A0=C2=A0 object_class_property_add_link(oc, "igvm-cfg",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_IGVM_CFG,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(Machi=
neState, igvm),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_propert=
y_allow_set_link,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJ_PROP_LINK_=
STRONG);
> > +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "igvm-cfg=
",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Set IGVM configuration");
> > +#endif
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* For compatibility */
> > =C2=A0=C2=A0=C2=A0=C2=A0 object_class_property_add_str(oc, "memory-encr=
yption",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine_get_memory_enc=
ryption, machine_set_memory_encryption);
> > @@ -1582,6 +1592,16 @@ void machine_run_board_init(MachineState *machin=
e,
> > const char *mem_path, Error *
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 accel_init_interfaces(ACCEL_GET_CLASS(machine-=
>accelerator));
> > =C2=A0=C2=A0=C2=A0=C2=A0 machine_class->init(machine);
> > +
> > +#if defined(CONFIG_IGVM)
> > +=C2=A0=C2=A0=C2=A0 /* Apply guest state from IGVM if supplied */
> > +=C2=A0=C2=A0=C2=A0 if (machine->igvm) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IGVM_CFG_GET_CLASS(mach=
ine->igvm)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ->process(machine->igvm, machine->cgs, &error_abort) =
=3D=3D -1)
> > {
>=20
> Perhaps use error_fatal rather than error_abort, since failures here are
> more likely to be user errors (incompatible igvm config), rather than QEM=
U
> programmer bugs.

Makes sense. I'll change it.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0 phase_advance(PHASE_MACHINE_INITIALIZED);
> > =C2=A0}
> > =C2=A0
>=20
> This adds igvm-cfg for all machines, regardless of architecture target.
>=20
> Are igvm files fully cross-platform portable, or should we just put
> this into the TYPE_X86_MACHINE base class to limit it ?
>=20
> It at least reports errors if I try to load an IGVM file with
> qemu-system-aarch64 + virt type
>=20
> $ ./build/qemu-system-aarch64 -object igvm-cfg,file=3D../buildigvm/ovmf-
> sev.igvm,id=3Digvm -machine virt,igvm-cfg=3Digvm
> qemu-system-aarch64: IGVM file does not describe a compatible supported
> platform
>=20
> so that's good.

The IGVM specification is designed to support non X86 platforms, hence its
inclusion for all machines.=C2=A0Support for non-X86 is likely to result in=
 changes
to the specification though that will impact the library we depend on.

There would obviously need to be some further implementation to support non=
-X86
machines in QEMU, in the same way that further implementation is required t=
o
support other X86 confidential computing platforms such as TDX.

So, this poses the question: should we move it to TYPE_X86_MACHINE as the
current supported platforms are all on X86? Or should we leave it where it =
is
with a view to adding non X86 platform support with less impact later? I'd
appreciate your views on this.

>=20
> With regards,
> Daniel


