Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3445FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjpy-00070Y-EC; Mon, 24 Jun 2024 09:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLjpx-0006zo-0O
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:34:25 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLjpt-0001FC-Qz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:34:24 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Subject: Re: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHaxjswjiYo8LQw8km6A62m1DK/lw==
Date: Mon, 24 Jun 2024 13:34:08 +0000
Message-ID: <a15cb952e03845b684f5211d75dfb4ff@baidu.com>
References: <20240624131426.77231-1-gaoshiyuan@baidu.com>,
 <20240624091745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624091745-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.68]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2024-06-24 21:34:08:777
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > SHPC driver will be loaded fail in i440fx platform, the dmesg shows
> > that OS cannot get control of SHPC hotplug and hotplug device to
> > the PCI bridge will fail when we use SHPC Native type:
> >
> >=A0=A0 [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0.S28_)
> >=A0=A0 [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0)
> >=A0=A0 [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplu=
g
> >
> > Add OSHP method support for SHPC driver load, the hotplug device to the=
 PCI bridge will
> > success when we use SHPC Native type.
> >
> >=A0=A0 [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0.S18_)
> >=A0=A0 [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplu=
g via OSHP (\_SB_.PCI0)
> >=A0=A0 [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\=
_SB_.PCI0)
> >=A0=A0 [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss=
_vid 0 ss_did 0
> >
> > According to the acpi_pcihp, the OSHP method don't need parameter and r=
eturn value now.
> >
> >=A0=A0 shpc_probe
> >=A0=A0=A0=A0 --> acpi_get_hp_hw_control_from_firmware
> >=A0=A0=A0=A0=A0=A0 --> acpi_run_oshp
> >=A0=A0=A0=A0=A0=A0=A0=A0 --> status =3D acpi_evaluate_object(handle, MET=
HOD_NAME_OSHP, NULL, NULL);
> >
> > Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> > ---
> >=A0 hw/i386/acpi-build.c | 14 ++++++++++++++
> >=A0 1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index f4e366f64f..79622e6939 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1412,6 +1412,18 @@ static void build_acpi0017(Aml *table)
> >=A0=A0=A0=A0=A0 aml_append(table, scope);
> >=A0 }
> >
> > +static Aml *build_oshp_method(void)
> > +{
> > +=A0=A0=A0 Aml *method;
> > +
> > +=A0=A0=A0 /*
> > +=A0=A0=A0=A0 * Request control of SHPC hotplug via OSHP method,
> > +=A0=A0=A0=A0 * no need parameter and return value in acpi_pcihp.
> > +=A0=A0=A0=A0 */
>
> Quote spec and earliest version documenting this, please.

I cann't find document describe this, only find in the kernel code
and describe it in the commit message.=

