Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D1BC3DA5E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjAB-00022p-Q0; Tue, 16 Jul 2024 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjA9-00021X-QE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTjA7-0008QD-7h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721140093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvZ99WZGHNNJL/1pbkXp9By1bGmdjsSz0FHFOR+ydPs=;
 b=RDk11JaknywMccAAZ9R9HwA421U6M8jgnlRi3T4Xz/hgnlFzyC9HPs0b3XOdelX0cbKtic
 QGtmCyXyx4GAe/UPE7BttelsxTFvnzBw9YLjohG6oi3gIGGJNYn6ZjSEUjGgUnwAEzbjwg
 AAbk4sSy99L6x62IWUXDCR/9sFmnNv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-9L7ihSRqM92fQmumcC8iqw-1; Tue, 16 Jul 2024 10:28:11 -0400
X-MC-Unique: 9L7ihSRqM92fQmumcC8iqw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990a5796so3418765f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140089; x=1721744889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvZ99WZGHNNJL/1pbkXp9By1bGmdjsSz0FHFOR+ydPs=;
 b=I33AqAiYsTF9GzYl5bMwvLxejycu+9AL0+5LLCeiSV4E2O1GRS47j+XfuXQYb7zXfo
 9ogox6/1Q6RYcgAwqxuybfkmq+7KCipT0bNC0Nqv8KW7gbl60bh7yjWYrozIirkoqUL0
 +RN14eXA0+yh2bWmScMz241zkc+O56pAC3KRpROJZnVqXD2KaKX9W0Yn+KtxpDttrwcz
 yL6+y1n24qSqe8YYmda708MZ7wUos1kt10jJQzj/7e2+HOj+ZFxLczWGULGSHm4qB9nY
 xLFZ/mDMTzIXC865PtLrVHnzwmMpetwyuiSc7z1Ra4mgSrEQOstMQ2fvp5PlQie+ywtY
 MrVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7T+12dIbvXrGg3CvoxA0xRJGzuK6FI+Fq0SRA5u+pGGTrMDY9r3JIVmQDaCtN8a/bxqgcjn9t8YISbjcJOe5lHVFKlyw=
X-Gm-Message-State: AOJu0YztGhrJTXMzZqQ9IojCDv1LCdTP1uluBy79mCfSyIfsAFxi3r66
 hsH1jWPEXEWugaCXzShLz4wYgG8PEq/tgrZqsfs2yl5yKws8tQHX8x2PA1jRgE3sF93WRVYx2AV
 TpgeurFJggYzIMIBbXf1QchJHkpRINTWuEEGeT6zO8s4ygtIhuh4C
X-Received: by 2002:adf:9b83:0:b0:367:f281:260e with SMTP id
 ffacd0b85a97d-36825f65dfcmr1493564f8f.3.1721140089534; 
 Tue, 16 Jul 2024 07:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBiI/Rz6MbcptMVBR6eBR522D9sI5H+9GNR6dib3RCPLy1CUI7f6DflnvUTEBa7L4VbujMvA==
X-Received: by 2002:adf:9b83:0:b0:367:f281:260e with SMTP id
 ffacd0b85a97d-36825f65dfcmr1493549f8f.3.1721140089144; 
 Tue, 16 Jul 2024 07:28:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbf29sm9272528f8f.70.2024.07.16.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:28:08 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:28:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <20240716162807.3aa78399@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZpZm48s9zt/glU/H@sunil-laptop>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
 <ZpEmuB6xyh2K77Ic@redhat.com>
 <20240712155010.3756bb82@imammedo.users.ipa.redhat.com>
 <20240714034105-mutt-send-email-mst@kernel.org>
 <20240715144352.22d36779@imammedo.users.ipa.redhat.com>
 <ZpZm48s9zt/glU/H@sunil-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 16 Jul 2024 17:56:11 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Mon, Jul 15, 2024 at 02:43:52PM +0200, Igor Mammedov wrote:
> > On Sun, 14 Jul 2024 03:46:36 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Fri, Jul 12, 2024 at 03:50:10PM +0200, Igor Mammedov wrote: =20
> > > > On Fri, 12 Jul 2024 13:51:04 +0100
> > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > >    =20
> > > > > On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote:   =
=20
> > > > > > On Mon,  8 Jul 2024 17:17:32 +0530
> > > > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > > >      =20
> > > > > > > This series adds few updates to RISC-V ACPI namespace for vir=
t platform.
> > > > > > > Additionally, it has patches to enable ACPI table testing for=
 RISC-V.
> > > > > > >=20
> > > > > > > 1) PCI Link devices need to be created outside the scope of t=
he PCI root
> > > > > > > complex to ensure correct probe ordering by the OS. This matc=
hes the
> > > > > > > example given in ACPI spec as well.
> > > > > > >=20
> > > > > > > 2) Add PLIC and APLIC as platform devices as well to ensure p=
robing
> > > > > > > order as per BRS spec [1] requirement.
> > > > > > >=20
> > > > > > > 3) BRS spec requires RISC-V to use new ACPI ID for the generi=
c UART. So,
> > > > > > > update the HID of the UART.
> > > > > > >=20
> > > > > > > 4) Enabled ACPI tables tests for RISC-V which were originally=
 part of
> > > > > > > [2] but couldn't get merged due to updates required in the ex=
pected AML
> > > > > > > files. I think combining those patches with this series makes=
 it easier
> > > > > > > to merge since expected AML files are updated.
> > > > > > >=20
> > > > > > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > > > > > > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/m=
sg04734.html     =20
> > > > > >=20
> > > > > > btw: CI is not happy about series, see:
> > > > > >  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> > > > > > also 'cross-i686-tci' job routinely timeouts on bios-tables-test
> > > > > > but we still keep adding more tests to it.
> > > > > > We should either bump timeout to account for slowness or
> > > > > > disable bios-tables-test for that job.     =20
> > > > >=20
> > > > > Asumming the test is functionally correct, and not hanging, then =
bumping
> > > > > the timeout is the right answer. You can do this in the meson.bui=
ld
> > > > > file   =20
> > > >=20
> > > > I think test is fine, since once in a while it passes (I guess it d=
epends on runner host/load)
> > > >=20
> > > > Overal job timeout is 1h, but that's not what fails.
> > > > What I see is, the test aborts after 10min timeout.
> > > > it's likely we hit boot_sector_test()/acpi_find_rsdp_address_uefi()=
 timeout.
> > > > That's what we should try to bump.
> > > >=20
> > > > PS:
> > > > I've just started the job with 5min bump, lets see if it is enough.=
   =20
> > >=20
> > > Because we should wait for 5min CPU time, not wall time.
> > > Why don't we do that?
> > > Something like getrusage should work I think.
> > >  =20
> >=20
> > It turned out to be a meson timeout that's set individually per test fi=
le.
> > I'll send a patch later on.
> >  =20
> Hi Igor,
>=20
> I am unable to get msys2-64bit test in CI to pass. I tried including
> your change in meson as well but no luck. I can't guess how enabling
> bios-tables-test for RISC-V is affecting this particular test. Does this
> pass for you?=20
>=20
> https://gitlab.com/vlsunil/qemu/-/jobs/7343701148

it doesn't pass for me either,
but bios-tables-test is not among those that timed out,
so I'd ignore failure in this case

>=20
> Thanks!
> Sunil
>=20


