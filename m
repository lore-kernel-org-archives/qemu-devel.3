Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68811C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3w5-0006HM-Pp; Wed, 06 Mar 2024 21:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ri3w2-0006Gf-OW; Wed, 06 Mar 2024 21:56:43 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ri3w0-000536-H6; Wed, 06 Mar 2024 21:56:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci9xYMGa+m7u+XF16yDJtpEzCKP4A8weHhZI0DgD/MhhC1OfrHoJvDeFHpc0eWXmNMWuP6cn4chvM+aejq+2/6hPNiu+zXYXRi9Mj9GjWbMb79Ax3MSCk+WbaSZKDVPS1tNVdGIq3/QDtus1DtsoXzZEK2masrIBQsNjWndZaK3W6YjlQMCTsEds4FX9ZM4lUtGal/lmRPGbMrGacRAYwMIPI6y81QQ72DjvD/tEAVYPEFfLYvv/XqVaPwOcwvdBWNfMceUdOVs12bHOTFvgP1jR3iXHCw1zwEHwHN580o4VYa4YoGF1vlxxnK8Vpma7TFOfIfkUZW7DTyDPMcZMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRpWeqFqImYouyrGPK2IHvW3ku0pqOf1ApMMrpfOQBk=;
 b=Fnz2KmnzcRCSp41cspna216D4T8qQKIKuxcM8oSFDFkP7xds/YLuhHOwNiiq1K/hvHI/Go3/XGyoiCOq5XLw2IyVlS4AZBfybJ7FDT+KeDInT85hlNO8egUJ62HEs//CeJhpXhwJXTfBa9h9lnFfHmHG4a20aAOdAn3Io99r77PFE4dsdpjngSJxpN4eHh8pxG4n0cxFi+JAVS2tyAhsrcIWUtdMlRECbGam6V29cXwipwFxE6sO/agE4tstVYIbdN3qXbVlRNsUX5qpkgUysp348Lkqiyc4jTPobWuar7BRBpGrAk+aJgDCECfsddUqzazP2oz2G2q/DPxsk79cPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRpWeqFqImYouyrGPK2IHvW3ku0pqOf1ApMMrpfOQBk=;
 b=inzU3oHqoufbJvLoR6hNtQ7QCpzP376B0TOh5ETP9YxJ7GT5A33XDAL6kVJqapQd8/7qUGwpGLM+i7vnY4oAguuIkMTrE9n6PnOJNr1p4diCB/J1dfW4nl+QZKV9yozp24abvfbYRS2ryu96EvLPjrwPQ+8ayV118dev3Csrq2WFmRGnuIweXMNlqs7XrA8hfy2Edsz30fMVvg/skEdO3OiyBDGacYFmZ9VY9YSS62jdxtNyU9lN0Fg7MSqTS/PmWx0WMq/bnACKbvR+fD1B9147Wr7BmnhNfdgwg7hk5P0hEbqghthVTuM+DRSBnSoyhTf8bwm3q0oeNfttuZjZnw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40; Thu, 7 Mar
 2024 02:56:32 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 7 Mar 2024
 02:56:31 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 1/2] qom: new object to associate device to NUMA node
Thread-Topic: [PATCH v8 1/2] qom: new object to associate device to NUMA node
Thread-Index: AQHab8KAGKU3ULlvlU6gntZVHgcPsrEqupuAgADaA9Y=
Date: Thu, 7 Mar 2024 02:56:31 +0000
Message-ID: <SA1PR12MB71994D65E90175F6916AE5C9B0202@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240306123317.4691-1-ankita@nvidia.com>
 <20240306123317.4691-2-ankita@nvidia.com>
 <20240306134909.00000a3a@Huawei.com>
In-Reply-To: <20240306134909.00000a3a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: b38354e6-5898-4a75-5020-08dc3e52315b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H44geO34FFIrbQWCg3pFymm7F+TN9Q/te3lwFL5b3nmkNntu9KQ1pONtACO5Sf7sYykAgdr22rbpcM3qHepYQgcGHvZY7QOYHjziYyWDNcYBDajIjX5FZXcFdz4WJCAcPOt7nyVFPVurawfWuEIR56nx+I5QAL8y+/DGACufBpDC8MEz08mZygAdRj12KGJT32gQXC3tte5jKiL9cSM/RnGXl8v2oO9V9nCi9kgbUx5s852u6fEiFuiWU3woZvHiU/1XaIeIjWqr7ZS7DP48AB2uz61habSzrjIHWq/G1mr+5w+0IG4gKRFKCl0LlG0RIJ8GuQ+EEITLxULvNVNRmrvFNonJEszgpy7YFJjwcV4mE4sVzD4Pal4wSMAjiRCnoMxhXVGOaFFMcNG9cnH6ToYDQl7F+6BfnwHlreGrZTuS0VW+FpFxXTkio3Qt/YCLeH1BjBjOFyfKhdU1sgOjXLl4SepRWkD+3xT0lt02TE6uK+/opcLlc+Co/IHnWyvuM42ToD7R9iepyKBLs4S1bvqjOw64rd3u7Wa/ZowuC6P2D7AH7F8qum2fjQHSqJh5gwtPL02tOpacDr8mCl0WKR/GHQ/MJkeyQ+xMZq785NOmwQge/eSC1fL0COo0Lj7Ulg6rr5dGP85hpMhPpLmbJ7I7zFy66h05Buq9UPBjyig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jPtHh1zxpgugLN8zUNhyJgdVNkMhloYjZWQ+pZKz2Ymr3dPgSAPR5EYkr2?=
 =?iso-8859-1?Q?tenf/89JFKUwy6ONotMpD2d4ao4d4lrjwxt3tOcIylq05y7sQLQt7CR4eB?=
 =?iso-8859-1?Q?Lxjfetq9Vzrxbch7YPA8+xQ06YyTtM1QCheJ69GmbF6kGR1tW+QtRj8itB?=
 =?iso-8859-1?Q?D5Ml+zuJ6EFEgLhRm3lN2dslLivU8EATMY5OrE4ROfoq7PkjWcrZakbB1s?=
 =?iso-8859-1?Q?eEOexRyVqt+ah5B/KpFQqryV92DMLOahPZR8htO2wSYRNpnO2VZVLzo1MK?=
 =?iso-8859-1?Q?fP4sXrucnTvf2i/fJc/qwQpYiaxGBjuHcJqW3yOskGc/YpAbmHk4BjVGuW?=
 =?iso-8859-1?Q?lhpTWXjOWZTs+kd8Shquk0Dj/yDEL+xkcLKI1vdL8KrgDW5G5ypPP3c1vk?=
 =?iso-8859-1?Q?AvaiSFsGW7rJ3YRhpSIVFZ+SiYdM2FHp+2x4x9dkL6E7howi318VuigKDi?=
 =?iso-8859-1?Q?ObSNqTWGyvcMscJjeiWQ7fXBytrHlr7Qaj2F/rHGHVMtOXWKDEy808cQNr?=
 =?iso-8859-1?Q?z6Um+e1TydYLvphx508dCZMNfaQKJDsNm30m14IiBMzCdoAdEppd1jmWkI?=
 =?iso-8859-1?Q?NU5Qcwa6/SrlGmuZxej1tv2SJ39ozezTtDvYivJwUDM9q8so8pKpyJHnrw?=
 =?iso-8859-1?Q?gJxW5rEGOKqBYBhSIgxZQigYCzwYWLWQi0TgMmxGwIYHktkf+sl+Z3vSsW?=
 =?iso-8859-1?Q?TiNSqABa04TxP5VhpgLiJlPlGYCNgPlVWaS4xydr2ufXe0Vb6hdoEcLNUb?=
 =?iso-8859-1?Q?0q8Bv/LSXFVErKoPf2WIIsGI19h36GK7O74bVMxPMX+K24N0H+lnK928lF?=
 =?iso-8859-1?Q?feKeQOPq29UTtn5j5ou0ejVPlzBCOI0SYRj323RPQsF0zpLhjDxIk93eqL?=
 =?iso-8859-1?Q?0N2VSOH+I8qighpuwWa9LqbB4BElvyGV6tPS2xjyMY3ey86a8BTHulfCq+?=
 =?iso-8859-1?Q?HkOAH1ae/Jcky1rv9JH/iOproubLdNvjNP9fC3SMOVvRvlSkaXdqbs5wDm?=
 =?iso-8859-1?Q?sBwRMKyFt8UlKOle//yMEXp+fojY9uafCLM1heRbOcoui4gwvvSBH9xjmY?=
 =?iso-8859-1?Q?TjLa++C+2liuAYlyVO5q0uT8/quMudJL2iDOEDd63YIq+zwTYGCc02MmS8?=
 =?iso-8859-1?Q?+fdFNRisHHCVmlwfXBxsFJIE7N/a+gxNmKspgo2czhHeFbNjgLdEyprIu3?=
 =?iso-8859-1?Q?UUjmrqycXeUVpeEFfLNuMohiZFWObgQVaif0gIc/CfRET2+LhRlNe5zMh5?=
 =?iso-8859-1?Q?XqsY+x6Xrn8JSb05v3csmV5kx7ZY95cAug2i2MRVjpjWD6ybkcnrDkWi7a?=
 =?iso-8859-1?Q?MEe+dghvZycfeMJoM5LafElUWckipx8rvSuEAdlArNTwLFXdkg2EHPrav+?=
 =?iso-8859-1?Q?YDzbLDt7GPCH+F0mbtCPITSL8H3MSIyx1c9pj33Ri6IkYBa0HSWSHGAjRA?=
 =?iso-8859-1?Q?wscSDZuZjY/FTlWpaJfhjSjc4B0TcU0N6e56PJnlq8KCkpiMgDFH8uhqzP?=
 =?iso-8859-1?Q?ilkaeimuFPCqayjQ/qv8RGby9aGH69WolDCwfrj/UJrbleFPpso7rkzaV6?=
 =?iso-8859-1?Q?9KtLSq21WdfF7xNH1C7g+vOkY+AO6X+g4H9O3+eOUW+nvvT+g+FyI9HdOj?=
 =?iso-8859-1?Q?ujnbvY+HTLiic=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38354e6-5898-4a75-5020-08dc3e52315b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:56:31.5467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkc6gZfFw5mcvTgtD6FlD89VgqOGdwPr0rLo/X2FxTEsJ2S1BVJ5cboLJz0TzoGRT8WmwhoOd1w3I1NnMXjPqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>> -object acpi-generic-initiator,id=3Dgi14,pci-dev=3Ddev1,node=3D16 \=0A=
>> -object acpi-generic-initiator,id=3Dgi15,pci-dev=3Ddev1,node=3D17 \=0A=
>> =0A=
>> The performance benefits can be realized by providing the NUMA node dist=
ances=0A=
>> appropriately (through libvirt tags or Qemu params). The admin can get t=
he=0A=
>> distance among nodes in hardware using `numactl -H`.=0A=
>=0A=
> That's a lot of description when you could just have claimed you want a n=
ormal=0A=
> GI node for HMAT and we'd have all believed you ;)=0A=
=0A=
Ack, I'll remove this part and change it to say as such.=0A=
=0A=
>> =0A=
>> Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu [1]=
=0A=
>> Cc: Jonathan Cameron <qemu-devel@nongnu.org>=0A=
>> Cc: Alex Williamson <alex.williamson@redhat.com>=0A=
>> Cc: Markus Armbruster <armbru@redhat.com>=0A=
>> Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
>> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>=0A=
>=0A=
> Hi Ankit,=0A=
>=0A=
> Some minor things inline. With the includes tidied up.=0A=
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
Thanks!=0A=
=0A=
>> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/=
acpi_generic_initiator.h=0A=
>> new file mode 100644=0A=
>> index 0000000000..23d0b591c6=0A=
>> --- /dev/null=0A=
>> +++ b/include/hw/acpi/acpi_generic_initiator.h=0A=
>> @@ -0,0 +1,32 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0-only=0A=
>> +/*=0A=
>> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights rese=
rved=0A=
>> + */=0A=
>> +=0A=
>> +#ifndef ACPI_GENERIC_INITIATOR_H=0A=
>> +#define ACPI_GENERIC_INITIATOR_H=0A=
>> +=0A=
>> +#include "hw/mem/pc-dimm.h"=0A=
>=0A=
> Why?=0A=
>=0A=
>> +#include "hw/acpi/bios-linker-loader.h"=0A=
>> +#include "hw/acpi/aml-build.h"=0A=
>> +#include "sysemu/numa.h"=0A=
>=0A=
> This should only include headers that it uses directly.=0A=
> If they are needed down in the c files, then include them there.=0A=
=0A=
Ack, will fix this in the next version.=0A=
=0A=
>> +typedef struct AcpiGenericInitiator {=0A=
>> +=A0=A0=A0 /* private */=0A=
>> +=A0=A0=A0 Object parent;=0A=
>> +=0A=
>> +=A0=A0=A0 /* public */=0A=
>> +=A0=A0=A0 char *pci_dev;=0A=
>> +=A0=A0=A0 uint16_t node;=0A=
>> +} AcpiGenericInitiator;=0A=
>> +=0A=
>> +typedef struct AcpiGenericInitiatorClass {=0A=
>> +=A0=A0=A0 ObjectClass parent_class;=0A=
>> +} AcpiGenericInitiatorClass;=0A=
>=0A=
> Trivial, but you could push the class definition down into the c file=0A=
> given it's not accessed from anywhere else.=0A=
=0A=
Sure will move the AcpiGenericInitiatorClass typedef to the .c file.=0A=
=0A=
> +=0A=
> +#endif=0A=

