Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8534CD58E5F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwvtf-0003in-85; Mon, 02 Mar 2026 00:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vwvtb-0003iQ-KA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vwvtZ-0008GA-7W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772429558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ch0GpvSaRxxrLDAaFa6DKSBqcTna5d+3lp+DtapVCTw=;
 b=LsX/x3fThHqfqpEEArqk85sTuI4KcaZD/MCychvrujeVsJ6WhDn3wyIkarrulM5vzQ4ELu
 JgD5PZD24nBJesdVFzQnQnyczF0ftI6uxsHg7Clua0hzo0K7MxoGOQ5vXSLwyKtty4NYNz
 QSBfHF+MyjoId8H8blxMVqGB8SANGvE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-T5F00tDcNcGiOuPJ-CuDPw-1; Mon,
 02 Mar 2026 00:32:35 -0500
X-MC-Unique: T5F00tDcNcGiOuPJ-CuDPw-1
X-Mimecast-MFC-AGG-ID: T5F00tDcNcGiOuPJ-CuDPw_1772429554
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FC7D18001E2; Mon,  2 Mar 2026 05:32:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5B219560A3; Mon,  2 Mar 2026 05:32:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61E8321E692F; Mon, 02 Mar 2026 06:32:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  mst@redhat.com,
 anisinha@redhat.com,  pbonzini@redhat.com,  shannon.zhaosl@gmail.com,
 philmd@linaro.org,  zhao1.liu@intel.com,  rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
In-Reply-To: <CAFEAcA-DtSE4MsN2XcBkOk5t3Xbe_Kz_MtUwfCkas4Q7R7CFnw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 27 Feb 2026 15:01:28 +0000")
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <20260227104227.3d84f0d7@imammedo> <87ikbi9yky.fsf@pond.sub.org>
 <CAFEAcA_dXNiXCeYdBimBMR-hWvt6+DB1FdJ9iZ5q8zoejyRWeA@mail.gmail.com>
 <87qzq68ck1.fsf@pond.sub.org>
 <CAFEAcA-DtSE4MsN2XcBkOk5t3Xbe_Kz_MtUwfCkas4Q7R7CFnw@mail.gmail.com>
Date: Mon, 02 Mar 2026 06:32:30 +0100
Message-ID: <87ecm26bkh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 27 Feb 2026 at 14:51, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Fri, 27 Feb 2026 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
>> >> The larger problem is that we generally fail at documenting device and
>> >> machine properties.  I'm not asking you to boil that ocean :)
>> >>
>> >> The narrow problem is providing guidance on watchdog configuration.
>> >> What and where?
>> >>
>> >> Regarding where: you proposed to add a machine property of QAPI enum
>> >> type.
>> >>
>> >> The property can have a description, and you give it one.  Sadly, it's
>> >> basically invisible.  As far as I know, the only way you can get at it
>> >> is qom-list-properties and such.  I doubt anybody is going to read the
>> >> description there.
>> >
>> > I think it also will appear if you run e.g.
>> >  qemu-system-arm -M virt,help
>> >
>> > (which produces a list of all properties with their short descriptions)
>>
>> You're right!
>>
>> > For board-specific properties, we should be documenting these in
>> > the manual page for the board. For instance "virt" does that here:
>> >  https://www.qemu.org/docs/master/system/arm/virt.html#machine-specific-options
>>
>> Every board should have such a page.  Even if it's just a placeholder.
>> Placeholders would remind us where the gaps are.
>
> I agree. For Arm I believe every board should already have a docs page,
> even if a very minimal one. (Some closely related boards get
> described on a single page that covers that whole family of boards.)
> The full list of pages is here:
>  https://www.qemu.org/docs/master/system/target-arm.html
>
> We follow the same pattern (but not always with complete coverage)
> in most but not all the other target architectures.
>
> I don't think there's currently any automatic way to get a list
> of undocumented boards, because there isn't any tagging of the
> boards that are documented except in as much as the board names
> are listed in the title of the relevant pages.

Alright, here's a first and incomplete attempt at the manual way.

docs/system/targets.rst "QEMU System Emulator Targets" lists target
pages docs/system/target-ARCH:

    target-arm
    target-avr
    target-loongarch
    target-m68k
    target-mips
    target-or1k
    target-ppc
    target-riscv
    target-rx
    target-s390x
    target-sparc
    target-sparc64
    target-i386
    target-xtensa

These appear to be mostly per "arch", not per target, i.e. there's just
target-mips, not -mips, -mipsel, -mips64, mips64el.  Exception: -sparc
and -sparc64.

Checking against include/system/arch_init.h...  We're missing

    target-alpha
    target-hexagon
    target-hppa
    target-microblaze
    target-sh4
    target-tricore

Some target pages list board pages under a "Board-specific
documentation" heading:

    target-arm
        arm/max78000
        arm/integratorcp
        arm/mps2
        arm/musca
        arm/realview
        arm/sbsa
        arm/versatile
        arm/vexpress
        arm/aspeed
        arm/bananapi_m2u.rst
        arm/b-l475e-iot01a.rst
        arm/sabrelite
        arm/highbank
        arm/digic
        arm/cubieboard
        arm/emcraft-sf2
        arm/exynos
        arm/fby35
        arm/musicpal
        arm/kzm
        arm/nrf
        arm/nuvoton
        arm/imx25-pdk
        arm/mcimx6ul-evk
        arm/mcimx7d-sabre
        arm/imx8mp-evk
        arm/orangepi
        arm/raspi
        arm/collie
        arm/sx1
        arm/stellaris
        arm/stm32
        arm/virt
        arm/vmapple
        arm/xenpvh
        arm/xlnx-versal-virt
        arm/xlnx-zynq
        arm/xlnx-zcu102
    target-i386
        i386/pc
        i386/microvm
        i386/nitro-enclave
    target-loongarch
        loongarch/virt
    target-or1k
        or1k/or1k-sim
        or1k/virt
    target-ppc
        ppc/amigang
        ppc/embedded
        ppc/powermac
        ppc/powernv
        ppc/ppce500
        ppc/prep
        ppc/pseries
    target-riscv
        riscv/microblaze-v-generic
        riscv/microchip-icicle-kit
        riscv/mips
        riscv/shakti-c
        riscv/sifive_u
        riscv/virt
        riscv/xiangshan-kunminghu

Pages may cover multiple machine types (e.g. ppc/amigang covers
amigaone, pegasos1, pegasos2, sam460ex).  We might want to tweak titles
to help us find the board names more easily, so we can check for
completeness.

Target pages without a "Board-specific documentation" heading:

    target-avr
    target-m68k
    target-mips
    target-rx
    target-s390x
    target-sparc
    target-sparc64
    target-xtensa

Some of these do talk about boards, just in less greppable ways.  We
might want to adjust them to better support completeness checking.

Worth pursuing this further?


