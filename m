Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2134EC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTL3j-0007JL-2C; Mon, 15 Jul 2024 08:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTL3g-0007G6-KP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTL3e-0004bF-H8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721047437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h35hl/jHrebhXaw3QkF2/ztgJRYyFPTkbphcaT1d35Q=;
 b=Nj52cIJcqt9l97riGfrHvQHweXaZYQSSId2r1F2Il9+nr8hMgfUcGOlR+l0C4FxUv47fuX
 ehamS2/tkJWDMka1k3s4J1LgzBdPzyvowR19kKWz6EuMf0o0N9T8BQ0VAc0ghdtx3dX139
 QCJwiakNFZEGCpcVNgdybYxvwYbHcoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-c5nuOlPdMjuF1ktUhjvpiA-1; Mon, 15 Jul 2024 08:43:55 -0400
X-MC-Unique: c5nuOlPdMjuF1ktUhjvpiA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso2800007f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 05:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721047434; x=1721652234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h35hl/jHrebhXaw3QkF2/ztgJRYyFPTkbphcaT1d35Q=;
 b=g+j8D1bmo+2GENGMB/Ha9DhznemxELyfwG8xIQxqHIMDE0bhtR5Dzcf1PvVmE4/u1s
 0POSsA/qt5Gd0nYWD3bnJW+MrT5NQFKwmQKR137EIaoyu7AKDWd2RNeECSNl2/4w+bne
 Oy2oYcfkSbqjWrCCFfQA0ypAgS+ZFEdJmNLLMPq5JIrmu7PgyyWGzxLeoBnAnh2YTjGS
 UNtwt22AaKMoPxalqxkHHHrRN6f+FGId1b9fbuVu0q9S9oybnu8rKJ++Qb6EFLN1swpu
 Htlxe6toouu4pOAqEebRYhmxQJOOy/cmq3aAw1XPMYy6OQx5yz+Rf7X/rOy7ZHjczVvE
 lqqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5+G0s3mcNtf+54tyMaPX08L/iNfe1Qls3OLy8t+XJZUpkAjUKGvdbUcA0f4nd+P1ze+QARCoXlu/GbNTD10iEpThVNOo=
X-Gm-Message-State: AOJu0Ywd36i8lfu7ZICMZeGlSZ6MGUIQdD57AHvy6Xqdmnx60oZ/1zLT
 uBiSgFRprQT4g8YtmJNNUPX7yPKGrGelPIREMLG1x3O6BGr+egc+T4x3kH1P/g8VQkcXiMCuZE4
 6ejM0VKGx8Zi/nlQxx6LlXGPck+tSW3xntmMXUg3n+IVgZOvAII+E
X-Received: by 2002:adf:fe4f:0:b0:367:8e59:4220 with SMTP id
 ffacd0b85a97d-367cea73793mr10804480f8f.24.1721047434682; 
 Mon, 15 Jul 2024 05:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeAvfzCZJBLDfLMpiQ2JlaXq0Qarct8k0py/4TEXpe6htkXAcg8Q2z4KEHXVQLaxiZzzHOjA==
X-Received: by 2002:adf:fe4f:0:b0:367:8e59:4220 with SMTP id
 ffacd0b85a97d-367cea73793mr10804472f8f.24.1721047434296; 
 Mon, 15 Jul 2024 05:43:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db03851sm6280421f8f.90.2024.07.15.05.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 05:43:53 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:43:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Sunil V L
 <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <20240715144352.22d36779@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240714034105-mutt-send-email-mst@kernel.org>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
 <ZpEmuB6xyh2K77Ic@redhat.com>
 <20240712155010.3756bb82@imammedo.users.ipa.redhat.com>
 <20240714034105-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 14 Jul 2024 03:46:36 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jul 12, 2024 at 03:50:10PM +0200, Igor Mammedov wrote:
> > On Fri, 12 Jul 2024 13:51:04 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote: =20
> > > > On Mon,  8 Jul 2024 17:17:32 +0530
> > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >    =20
> > > > > This series adds few updates to RISC-V ACPI namespace for virt pl=
atform.
> > > > > Additionally, it has patches to enable ACPI table testing for RIS=
C-V.
> > > > >=20
> > > > > 1) PCI Link devices need to be created outside the scope of the P=
CI root
> > > > > complex to ensure correct probe ordering by the OS. This matches =
the
> > > > > example given in ACPI spec as well.
> > > > >=20
> > > > > 2) Add PLIC and APLIC as platform devices as well to ensure probi=
ng
> > > > > order as per BRS spec [1] requirement.
> > > > >=20
> > > > > 3) BRS spec requires RISC-V to use new ACPI ID for the generic UA=
RT. So,
> > > > > update the HID of the UART.
> > > > >=20
> > > > > 4) Enabled ACPI tables tests for RISC-V which were originally par=
t of
> > > > > [2] but couldn't get merged due to updates required in the expect=
ed AML
> > > > > files. I think combining those patches with this series makes it =
easier
> > > > > to merge since expected AML files are updated.
> > > > >=20
> > > > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > > > > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04=
734.html   =20
> > > >=20
> > > > btw: CI is not happy about series, see:
> > > >  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> > > > also 'cross-i686-tci' job routinely timeouts on bios-tables-test
> > > > but we still keep adding more tests to it.
> > > > We should either bump timeout to account for slowness or
> > > > disable bios-tables-test for that job.   =20
> > >=20
> > > Asumming the test is functionally correct, and not hanging, then bump=
ing
> > > the timeout is the right answer. You can do this in the meson.build
> > > file =20
> >=20
> > I think test is fine, since once in a while it passes (I guess it depen=
ds on runner host/load)
> >=20
> > Overal job timeout is 1h, but that's not what fails.
> > What I see is, the test aborts after 10min timeout.
> > it's likely we hit boot_sector_test()/acpi_find_rsdp_address_uefi() tim=
eout.
> > That's what we should try to bump.
> >=20
> > PS:
> > I've just started the job with 5min bump, lets see if it is enough. =20
>=20
> Because we should wait for 5min CPU time, not wall time.
> Why don't we do that?
> Something like getrusage should work I think.
>=20

It turned out to be a meson timeout that's set individually per test file.
I'll send a patch later on.

>=20
> > > We should never disable tests only in CI, because non-CI users
> > > are just as likely to hit timeouts.
> > >=20
> > >=20
> > > With regards,
> > > Daniel =20
>=20


