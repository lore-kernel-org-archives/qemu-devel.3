Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4130C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoyp-0005Er-R9; Tue, 13 Aug 2024 06:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdoyi-0005Dm-1J
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:42:12 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdoyf-00012A-IL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:42:11 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a94aa5080so621263366b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723545726; x=1724150526; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=246wt2aiZOtIC+BgMNamECdWvufIyHe6wexvtUbyK9U=;
 b=IGnRDR2y52at5LGnz8BzlymSHPlAfJ1hOy1WvXvE0nVAbeKYn9OxjRctCsGgnc4GHP
 Al8z1mWdLZWT/FETle3qdQNNzb9MVkbxXIirlQgiQ4n6mbHpMaZhJYbiRSm/BrrKNAKo
 VcbBgDyEazJaeieG2VdFCwjG7GqzwjCsUIRGDbR0tS6Qal622IuR/ZAbF1KjP/bw1vZp
 49eTp1f0Kti4c57yKTQGYnO8japhcwcDxE3fZhNJVIGaHT0pv7HV02V0bNffpW3KKwyU
 VEZm8LqtjvPkl/2F4bh3/fUch+AgGYRg/1oLtLAv9ClPiRHZ05nQ3QyMVTzB342iowBR
 Pq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723545726; x=1724150526;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=246wt2aiZOtIC+BgMNamECdWvufIyHe6wexvtUbyK9U=;
 b=ok0MvthvhxtJ1ouF1IY+3DSNuNjAJcWUEinuzngZmGzGZTPw3NYT12TeH2xDNyJzwo
 lOY6XT5GHHf1dlaN52RJGxlFSl0/8DzOfnJsSDynRSAxWLocMXcX2sCsPQBFB0R7sGEg
 OZnT1P97f2JgRwqRqmjJF0Ytjbaodgz8d+a9mhOUc401L7MQBphaHBlGFeVUsV/hjjv0
 VFqpPl1kVEgrFw3ufJnyt/nFs2jVbw6QhaKL8DRbmxyzCuDp8UoXiMwtJud1RFa28rBU
 1bLubIyh1/7KxAduqkboZ7SeSZZ1L05e49gUpBgGCsZxizyCcYa588WBo0Zsi1rG5XYW
 F6Rw==
X-Gm-Message-State: AOJu0Yxt292ozeCyc5d/6n7qKOTulC01YadjlDD5u8J7b1XgWFmGm1K2
 7bEN/oht1OtRu019QGBA60J1OGHmGpSSB0b/yOruzdnoKgN6Y1gDNyWDFZS7kVw=
X-Google-Smtp-Source: AGHT+IEQOEY/2L3o4diI+U/hLy2/oyoSLzDSL8OjR9rP7NoeZcfIuHH06VBvrrZ+aJm0ot9oDISJ2g==
X-Received: by 2002:a17:907:60d5:b0:a77:de2a:af00 with SMTP id
 a640c23a62f3a-a80ed2cff0emr248659066b.44.1723545726368; 
 Tue, 13 Aug 2024 03:42:06 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411d937sm58797766b.111.2024.08.13.03.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 03:42:06 -0700 (PDT)
Message-ID: <edd4bbac55112f046d81d5378d5a843061fad867.camel@suse.com>
Subject: Re: [PATCH v4 05/17] i386/pc_sysfw: Ensure sysfw flash
 configuration does not conflict with IGVM
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
Date: Tue, 13 Aug 2024 11:42:05 +0100
In-Reply-To: <ZqE2N3tXTOMi7dgP@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <c58c4b5cc8a35245b7ef31fefcc67a72e6346a07.1720004383.git.roy.hopkins@suse.com>
 <ZqE2N3tXTOMi7dgP@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=roy.hopkins@suse.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 2024-07-24 at 18:13 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jul 03, 2024 at 12:05:43PM +0100, Roy Hopkins wrote:
> > When using an IGVM file the configuration of the system firmware is
> > defined by IGVM directives contained in the file. In this case the user
> > should not configure any pflash devices.
> >=20
> > This commit skips initialization of the ROM mode when pflash0 is not se=
t
> > then checks to ensure no pflash devices have been configured when using
> > IGVM, exiting with an error message if this is not the case.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
> > =C2=A01 file changed, 28 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> >=20
> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index ef80281d28..f5e40b3ef6 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -219,7 +219,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flas=
h)];
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (!pcmc->pci_enabled) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_bios_rom_init(X86_MACHI=
NE(pcms), "bios.bin", rom_memory, true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If an IGVM file is =
specified then the firmware must be provided
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in the IGVM file.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!X86_MACHINE(pcms)->igv=
m) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86=
_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory,
> > true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> IIUC from looking at x86_bios_rom_init, the 'firmware' machine property
> will be NULL if no -bios arg is given, and non-NULL if -bios is set,
> so we can give an error message is -bios is set, while doing the right
> thing if unset.
>=20
> [Snip]

I looked at changing this, but the `firmware` machine property is not NULL =
even
if no -bios arg is provided. This is because `default_machine_opts" in pc_q=
35.c
and pc_piixx.c both provide a default file for the firmware if not provided=
.
Therefore I've left this unchanged.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > @@ -239,8 +245,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (!pflash_blk[0]) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Machine property pflash0=
 not set, use ROM mode */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_bios_rom_init(X86_MACHI=
NE(pcms), "bios.bin", rom_memory,
> > false);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Machine property pf=
lash0 not set, use ROM mode unless using
> > IGVM,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in which case the f=
irmware must be provided by the IGVM file.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!X86_MACHINE(pcms)->igv=
m) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86=
_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory,
> > false);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Same as earlier
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_enabled() && !=
kvm_readonly_mem_enabled()) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
> > @@ -256,6 +267,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 pc_system_flash_cleanup_unused(pcms);
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * The user should not have specified any pfla=
sh devices when using
> > IGVM
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * to configure the guest.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (X86_MACHINE(pcms)->igvm) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZ=
E(pcms->flash); i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(pcms->flash[i]) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("pflash devices cannot be configured whe=
n "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "using IGVM");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit(1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > =C2=A0void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> > --=20
> > 2.43.0
> >=20
>=20
> With regards,
> Daniel


