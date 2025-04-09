Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8DEC369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2W3v-0004UR-4z; Wed, 09 Apr 2025 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u2W3o-0004Kv-5G
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u2W3k-0007tT-HK
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744207543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXpzjH0wmH12EgOOYARPuDYUpIMGYWhEcpVFwC8gjms=;
 b=A7ChLzefMhnjyIGnDYLzm6WOgk22bgykTw8Zm+cf9jhIMBCJbjoZ/JgW0jikX8kBzIBJJX
 OeRTV0Xc9OiTlr0rniB0dDwA27IZPV1y0PYr/++b8oFEbpllzafUN9A4TUAJHlcsDYbTQC
 zQLpcgBZkplvuk7ZvyG03mlxVwu2ELA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-8zTBs8iBMXyxJTixuFuGAQ-1; Wed, 09 Apr 2025 10:05:36 -0400
X-MC-Unique: 8zTBs8iBMXyxJTixuFuGAQ-1
X-Mimecast-MFC-AGG-ID: 8zTBs8iBMXyxJTixuFuGAQ_1744207536
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d01024089so59138375e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744207535; x=1744812335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXpzjH0wmH12EgOOYARPuDYUpIMGYWhEcpVFwC8gjms=;
 b=EanmAWc0FL+RAteGX81o14Ci0btgbkXIfqBYWlRNatMe0eeMoxM1uruNtRFTEktfoD
 AqKGl9mu+SzPrVYbq40S2K/CjDEKjHvkxsjY2xMYpAYerJtEsROhAv+ASVRTDgWbx76B
 q6C3m6ipdgH0/qFxPjLvakmfR8H5PLilKve4JxlOiXsRe4lvweYXIRfkZtWKCEvrMy19
 xwrOnNs5T1D0/GD+svjxTjfKeT7VHuUnMyhSc/b0LeuTq8ccHVcThW0cFJpfycsoiE8k
 4x090FvTymUd+zNpSscIa3czAsF4I/fC61NPMYrFPvTc67OKHpxR87jVCYsncJM2nt8x
 AumQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgl3gVEvwLe/jMvcjTTkBhq0AwPIM2PDtT2vWtGwKMiBoJGTMHeZL0/phE+HePNR51BAIR2P4wCYm/@nongnu.org
X-Gm-Message-State: AOJu0YyGcZJVPvXBdlsp5en/TEBtq7b1nPcQsuI3sVScLiQ2caFjb3so
 5ngSHG4YaCQ+jXVdeUyf11E0C/lyS3RKvxv0aadtaKphTcT+Y72ZqJlzY30A0mxq7tK6AMWrW/f
 38QIGTeaLMiqCiexkxRRv4LUf5SEd/RdezRdqEknvZKBFTpiPxEGG
X-Gm-Gg: ASbGncsBPeV6oIu5x2f6RwGwlxsvTg0y23xgzu9PfnayyjQacH1PTcKFK41e437qm1c
 izYf/Um7BeOhyJV8lyl9qs8yQQWHfR4XSSjMQ0UVMpy+6zuv7/NN55zPMEzP4efUmLtk8ipXPsX
 +CgGTMm+DK5d4qe15MAG4scbZBYSVO2HDAcC4PPZEHlCB01eeQKeSFitGw22csW64AYdbcFS5k0
 TPbMExJ0TXincYwiE785CvUXKgc+kckGZkVKJ4sab8chlcfFIuV0OC5XdZHLmW0Y5NOIZgXxcpm
 RXXmB/jbq8aRfjkN7WVXyif06UAKwjuC
X-Received: by 2002:a05:600c:3584:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43f1ff3f3c6mr23760205e9.20.1744207535147; 
 Wed, 09 Apr 2025 07:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhePg+Ys4LBzVmUmR1LhE0xZo8o8HspSka4M4T8US8tkqPYXJmIJAtNDl8tAE4Urle6qyybg==
X-Received: by 2002:a05:600c:3584:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43f1ff3f3c6mr23759135e9.20.1744207533853; 
 Wed, 09 Apr 2025 07:05:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecac8sm21264715e9.4.2025.04.09.07.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 07:05:33 -0700 (PDT)
Date: Wed, 9 Apr 2025 16:05:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org, Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Message-ID: <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
In-Reply-To: <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 4 Apr 2025 00:01:22 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Phil,
>=20
> On 4/3/25 17:40, Philippe Mathieu-Daud=C3=A9 wrote:
> > We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> > test. In preparation, copy the ACPI tables which will be
> > altered as 'its_off' variants, and whitelist them.
> >=20
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
> >   tests/qtest/bios-tables-test.c              |   1 +
> >   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
> >   tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
> >   tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
> >   5 files changed, 4 insertions(+)
> >   create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
> >   create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
> >   create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> >=20
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/=
bios-tables-test-allowed-diff.h
> > index dfb8523c8bf..3421dd5adf3 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,4 @@
> >   /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/aarch64/virt/APIC.its_off",
> > +"tests/data/acpi/aarch64/virt/FACP.its_off",
> > +"tests/data/acpi/aarch64/virt/IORT.its_off", =20
>=20
> I think your first approach is the correct one: you add the blobs
> when adding the new test, so they would go into patch 5/9 in this series,
> making the test pass without adding anything to bios-tables-test-allowed-=
diff.h.
> Then in this patch only add the APIC.its_off table to the bios-tables-tes=
t-allowed-diff.h
> since that's the table that changes when the fix is in place, as you did =
in:

if APIC.its_off is the only one that's changing, but FACP/IORT blobs are th=
e same
as suffix-less blobs, one can omit copying FACP/IORT as test harness will f=
allback
to suffix-less blob if the one with suffix isn't found.

if blobs are different from defaults then create empty blobs and whitelist =
them in the same patch
then do your changes and then update blobs & wipeout withe list.

Phil,
the process is described in doc comment at the top of tests/qtest/bios-tabl=
es-test.c

> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07082.html
>=20
> Plus, adding the blobs, which are actually related to the test in the oth=
er
> patch, and ignoring them at the same time looks confusing to me. I unders=
tand
> that only the blob that changes (APIC.its_off) with the fix should be tem=
porarily
> ignored and, later, updated, as in your first series.
>=20
>=20
> Cheers,
> Gustavo
>=20
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> > index baaf199e01c..55366bf4956 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(vo=
id)
> >       test_data data =3D {
> >           .machine =3D "virt",
> >           .arch =3D "aarch64",
> > +        .variant =3D ".its_off",
> >           .tcg_only =3D true,
> >           .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> >           .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> > diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acp=
i/aarch64/virt/APIC.its_off
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe=
73eb7cb9100fcccfa
> > GIT binary patch
> > literal 184
> > zcmZ<^@O0k6z`($=3D+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
> > bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
> >=20
> > literal 0
> > HcmV?d00001
> >=20
> > diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acp=
i/aarch64/virt/FACP.its_off
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25=
d3a4127eeef227434
> > GIT binary patch
> > literal 276 =20
> > zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ =20
> > CVg~^L
> >=20
> > literal 0
> > HcmV?d00001
> >=20
> > diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acp=
i/aarch64/virt/IORT.its_off
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849b=
af568a8e93e426738
> > GIT binary patch
> > literal 236
> > zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=3DRgMkDCNC*yK9F_<M77!bR =20
> > zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@ =20
> > R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
> >=20
> > literal 0
> > HcmV?d00001
> >  =20
>=20


