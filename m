Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92CEC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LsN-00037z-7P; Tue, 07 May 2024 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s4LsK-00036d-Vc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s4LsI-0001Jd-J0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34d99ec52e1so2093036f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715092376; x=1715697176; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VGkdIXNxX6cZuzNQR631K9h3CCPgg151J6P18kArUwg=;
 b=PHzLKqyczjIciGIE9TWofi54jGnPgkDwHuw7VB0zFPcVVUIpu9QyBCpE+4E7o6/sNu
 EGNMdTMLaHZVqtYpIdOB9mEcEW4KMIVVKdtx9cHtRaqqbBUInJ6TN7i1ulPHEXOt+p9D
 FREDJjRSFejOgJr5mhzYHlyQe8tEltMeynPQFWZYcx4diEDVrDbTV5OrV8v9wxSGtDtS
 61JJ4cEcMCza2MnCNkVJ+Ljx4PxrLrdffo7C3bU3fwDB114SBH+jZn++7lyr9jCe8v7H
 AgqZav8KRrkdpvaD5L3MoP2j5az4BMWIOmnA2Rnq6jxeoe4PqYim9vO/q+mqzEb8pLxN
 tsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092376; x=1715697176;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGkdIXNxX6cZuzNQR631K9h3CCPgg151J6P18kArUwg=;
 b=e7sQZaoO3WkomhTCWpOlB4LX8O7+YYGZKFNDYU5iabk3MHSSI5gYQb0Zm+Givig/rr
 53itbVxQVRxcIVZI7so30rdv6x1YQhQSnDmCwFitHEEbBLvSzf1RJY/7rit7mKR4JOlR
 2pRjqX13tc8Un3fTXyI4dfMcVngyimwZxZWrZ2X1aKttBO7tfcYawdTApEN4USQO5E6x
 ai2+DkRqRGumVCeRNn0wGsqKBRlFNBFCS7SZ7yKTlz8ooHpEZAFoc7Vhxee5ehidFQGS
 FUnEnzrr6SMOLENm5RzWxMjmOlpyOCporLTUUp7o7DuuCaPeIL28QUifuOmx6U9/OpIw
 iz/w==
X-Gm-Message-State: AOJu0Yxr4OsGioMDoAHHo17dOLYFelXUlnhAZ5yMOkgXuN7wESfcaH0/
 soJg2hivx/xWDptJrP6vc0OafWpZUuIL60kyKdNF0ONS2LJyNstttwu+R0vxHKM=
X-Google-Smtp-Source: AGHT+IHqJDsxXxxUGLRb5254lqfKE3qHCOm/rLVL5TXHJoZxqPGrIoK9Af70hVPqd9/M5Ei2jTMtWA==
X-Received: by 2002:a5d:45cb:0:b0:34c:9383:844f with SMTP id
 b11-20020a5d45cb000000b0034c9383844fmr8911032wrs.57.1715092375706; 
 Tue, 07 May 2024 07:32:55 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a5d5284000000b0034b1a91be72sm13089870wrv.14.2024.05.07.07.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:32:55 -0700 (PDT)
Message-ID: <2bd15d1f23169ca7effb9803b53c9273132ac4ca.camel@suse.com>
Subject: Re: [PATCH v2 06/10] i386/pc_sysfw: Ensure sysfw flash
 configuration does not conflict with IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael
 Tsirkin <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez Pascual
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Tue, 07 May 2024 15:32:49 +0100
In-Reply-To: <54875E49-0710-4DD9-A6A6-79BEA4F09EFF@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <613c3dc97a29fa9b8baa8acf45cefe4fac24ea87.1712141833.git.roy.hopkins@suse.com>
 <54875E49-0710-4DD9-A6A6-79BEA4F09EFF@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::42b;
 envelope-from=roy.hopkins@suse.com; helo=mail-wr1-x42b.google.com
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

On Thu, 2024-04-04 at 18:06 +0530, Ani Sinha wrote:
>=20
>=20
> > On 3 Apr 2024, at 16:41, Roy Hopkins <roy.hopkins@suse.com> wrote:
> >=20
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
> > hw/i386/pc_sysfw.c | 23 +++++++++++++++++++++--
> > 1 file changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index 3efabbbab2..2412f26225 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -226,8 +226,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0 if (!pflash_blk[0]) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Machine property pflash0=
 not set, use ROM mode */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_bios_rom_init(MACHINE(p=
cms), "bios.bin", rom_memory, false);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Machine property pf=
lash0 not set, use ROM mode unless using
> > IGVM,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in which case the f=
irmware must be provided by the IGVM file.
>=20
> What if the igvm file does not contain a firmware? Can we have a check fo=
r
> that case somewhere and assert if firmware is absent?
>=20
I don't think we can easily check for presence of firmware. In fact, using =
IGVM
means that you can effectively launch a guest without traditional firmware.=
 A
good example of this is if you use IGVM to deploy an SVSM module that is us=
ed to
help with guest migration. In this case, the SVSM code would be placed in m=
emory
(by the IGVM directives) and the initial CPU state configured to launch the=
 SVSM
kernel directly.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cgs_is_igvm(MACHINE(pc=
ms)->cgs)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86=
_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory,
> > false);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_enabled() && !kvm_re=
adonly_mem_enabled()) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > @@ -243,6 +248,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0 pc_system_flash_cleanup_unused(pcms);
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * The user should not have specified any pfla=
sh devices when using
> > IGVM
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * to configure the guest.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (cgs_is_igvm(MACHINE(pcms)->cgs)) {
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
>=20
> I have not tested this change but looking at pc_system_flash_create() cre=
ates
> flash[0] and flash[1] for all cases (well except for isapc machines). So =
for
> igvm case, would this not cause an exit all the time?
>=20
Although the flash devices are created, if they are not configured then the=
y are
removed by the call to pc_system_flash_cleanup_unused() above, meaning that=
 this
check succeeds in the IGVM case.

> > }
> >=20
> > void x86_firmware_configure(void *ptr, int size)
> > --=20
> > 2.43.0
> >=20
>=20

Regards,
Roy

