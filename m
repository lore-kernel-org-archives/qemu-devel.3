Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30213C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPzP-0005Fy-IL; Tue, 05 Mar 2024 03:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhPzL-0005Er-SR; Tue, 05 Mar 2024 03:17:27 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhPzJ-0004pd-CG; Tue, 05 Mar 2024 03:17:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmlICCfjaDY5vyR+1zCm34QvlqdXqFSSIH+0YFyGpiff5dJ426DpmUios20HbMj5GPpShKiTwFEMFSne1QadG7EDS4LnxEMyPRRvwVQCdg8WN5t/1ivKNigXTGdjBLcnnEdkzjQ+owbGNEJKW36W02qU7SOY19v+9DHibNp+u+wetN3nTrFrb7aTnL0PHFh9HSQWU3bcdBYYt9aQ3aiTffDwPQmWzv10WNYkinw/xWYxUaXItMkKpWPtey/cz/uD9EzRI52JtN9vs3xMC7yMlLIMbLd2IiJ+vabrP5UtHhLrlj8zjmfbqQs4oXttfkqtF8lSE43fjguO+aYuDW+kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Ej3ZIdfsOvOaLz5w4VttL0kx5H4AVzwQCon/zT/lQ=;
 b=cLb1cteCHcBCCiwCy+51R+0xgRaB9JO9UP+LgqEeMLLi5dQDAN+JZ38DMDH6PbaRuaiPEaoZskcSAyCyU1yKjihygWmoe0W7NNbnRHjIQJRv99sUyuLFA/XNZTCgGmTsaX0cJVFFdKiqJyR5S9+xp8A9R1SngEuRTTVWpxnQvgY+pQY85VWehzgEGcb4Ll9bA04I5wVg3S14TEA+55wwZT1XYXN1G4V16AsYVKlWN2rylrj1gXLnh1DaTINQRB8WJupNkIh/nxRmddjO+0y5s2xdFAZtvaJLCFSP/5F/t5yb9OE3YdzNLgJKNxYanf1CQcK/WHYIlMBBSIPDhDj0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Ej3ZIdfsOvOaLz5w4VttL0kx5H4AVzwQCon/zT/lQ=;
 b=obTBhrq1+PvfADJ5Vh5nm5n74Lg5ji4ut7+87wA+J97jaPRsgQYuUQ7iBq5IwRD4tTnlG1ZkFz4iV3A/fWAJWXbwf0fmkdprty8xjFEk0LmUCqSkklVA+P0rJt54W7yG3gHqDT76Jj5gMBjXjxW3PgTwgSPNEg2tzST1smVchfq3eEvk78qqg++G1pd4l/iFMeBLv/PhhnDYRg2WU/wvKh36+tEKuJIkl2C8IOlxaMfGUQk/oidnQit7X79XsTtoubDTuA4Q6bATWvuoBtPpa1XdpK8aclve++NPBOVjFdyxMr+Q9goTHo0D8s+qz24vqqOtUVmAVLPdfhv+Yj2ZYA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 08:17:19 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Tue, 5 Mar 2024
 08:17:19 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang
 <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgAvebIGAABSxAIAAAZo5
Date: Tue, 5 Mar 2024 08:17:18 +0000
Message-ID: <SA1PR12MB7199E6243CD2838335893CFCB0222@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71995AAADE78D3D0052FAC01B0222@SA1PR12MB7199.namprd12.prod.outlook.com>
 <533ccbfc-7d90-42cd-9183-a5b128c41fad@redhat.com>
In-Reply-To: <533ccbfc-7d90-42cd-9183-a5b128c41fad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|LV3PR12MB9267:EE_
x-ms-office365-filtering-correlation-id: 0f8a4b05-29c4-4128-7147-08dc3cecacd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfHE0dafvDQEdRNvWxUNrGl5ttXOPoIWXgqO1MO8AJaEfF8O/FTeUkoResWNHyBGB+MaYGmPmWrnvTJbJsaJPTxYPDME9g3a4vxM2Rr/AaE2lH6AFS6kPJ3aKvrduIJ2papUfL4gEIcNiASGJWfOSvZNlHWYNoXtAq5i+vkidBRcIwXgXgAa8i05ZrhQQQs7xuxz61ySZg4jKyClysD3WSeyQVOi1p5JjNS4vCjj5FeK99JWWq2741fdQhrWvEYMRDCc47c2Docn58UgpPxJY6jwbTS4znAX+GQzKp1KTqGEXfCIylgFuYNLrZIsZahKl3ytcz+N1qky0zAGk+dAkQPG1208BSokRGH+g/IREsqzdiZfuKPGzhpm/RvjWLF18IZBMJLaeF2C0VmdFd/7s67NoQMx0J5CzzXtyc5PBRN0g4FGNJPlSJk0qCk5gAXo8FR6tKWdtxPA1dvozYLxXmcfk9BkWAPg6ZuONyzMBb7sRehebY8ImnqCZiD1VTnm5D1thfbvZnoSq1GYkM8Hk/6LasgMpv7UlIvNb1Eyj3zXgGO1mjqwdGDnIR8cQ/DhJaNHNIDt5lnSY52n7AZSXtoq3OItRz0r0t5OsIIGbNwNpnnr1PpHA8Syo6DLf2+eQRfD6lildKQ42UiI1SU4GRUMbXGFYEW+eS4lDUfdxWhVNNesyfD3o3Bak0QuBfZqkur5ZWouzU4A51pE+s2QfkxPdR4AP/nfC/zb1EZIHUc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bvWS1C1YU1/HeM9GoTRdNHwgzqpfeewzPion8NSszCiTN81JLmt/D7zz4V?=
 =?iso-8859-1?Q?LN47JMM+SRrroA9eERKFqVg/4JClWCcBVzEano09yltq7FztPFAHiQbapp?=
 =?iso-8859-1?Q?s9E6GzN37oQx95LrjwxdTSxx0xKhXnFujeZsopTXfPPgcTUCQ7awobIMtE?=
 =?iso-8859-1?Q?ovAY2KdAtFvN5Nsfvct7Yl+cpgKDeraUgZbHt5yAZrjmFFBoI1bLZvR3oh?=
 =?iso-8859-1?Q?Iq20uC9XOcnDGfebpNCjcaTUvmIZrXHxvNPfx88uVIMm14EBzG3iC+M1BF?=
 =?iso-8859-1?Q?W/v3sHCUZeN47ToROBrAhTbKUWqu96FAyW9McsXYnjGO+a/jvxzz9ojuHo?=
 =?iso-8859-1?Q?n6/HE4xheEOQ113djD8OFx4IEwREsAM+Br0SkSigRyf7l7jTa2nXNioNx1?=
 =?iso-8859-1?Q?mwjB7UtS6PYwU6tuRB6/7j+CxtT9JvJkoIVRXSo7GCVLITpmZ5BRJzXlv8?=
 =?iso-8859-1?Q?Xq6wIOQVsFpfyI44XyazfDC/3LOOAbnstXZkeBwgIz4bdbOlTwl+TCWxM1?=
 =?iso-8859-1?Q?DJqvm7YIey83ZQMuntfiDXgzFrgJPyE/Esbwbw7oeraXIaREgRcivwZxvL?=
 =?iso-8859-1?Q?/nX3f/rHfTAk8+P+qWHesnbm97ga6iMALGNObcm06BQQkFuJ9aiQNpxrbd?=
 =?iso-8859-1?Q?GEKs1EJcJwa7c2ZxifVhNknHbfhfDE12koY2J+Cddlpq6d+SThpJzpM6Dj?=
 =?iso-8859-1?Q?s8lsWrZeSKcjAOqstXZuD0pxqmRLmioSM0CzClNopf0yjkGRMLr/juWyR+?=
 =?iso-8859-1?Q?I+wpppVmrwLSWIAfi01q1lS8ChtrPIikDJZH8szz5G6SfXoEsymlBFla4M?=
 =?iso-8859-1?Q?p6FrzH8z7x04aTsRhjAli68TtT2Fmz86RFRAzMTn1Lxci3swJ6AwGa4m/J?=
 =?iso-8859-1?Q?m0Ri/VzAgOg9ohXDI00dNXaln2dKyuSjFCJJDfDxrFjfuueR296umouB9t?=
 =?iso-8859-1?Q?jjJIp2yxMLn7027IfY1ZtNJ5U4RXWeMbj2y8izBjny9CCz12nCNoFFzIZI?=
 =?iso-8859-1?Q?wBeNEGBFAfO7FbdEE0jl9jzPX2AN+MhPS/Z7BYFHcgYef8wNsSLmaNRmIu?=
 =?iso-8859-1?Q?SRGlIwUCCcQ5o4qR2PJz6xjftF+xDbMTvLOK7H6Z57gDdYN2c/WL9EjBl3?=
 =?iso-8859-1?Q?mdJwdE20n8Gi3pbindo1YzRpgaQncVuLdk8eiU3YEbsS5dd2HDrRE2ONOv?=
 =?iso-8859-1?Q?MG2dLEePvXrU8brJ5suWNvdij5z4nLNyLmY1w1zPrS4G/sX8Pu3snn2Tj7?=
 =?iso-8859-1?Q?dE47uj6i05L14+HHlBoY5H7K35q1LFNgpMBOZwGnQTZ+unfiUdBEfnlKCZ?=
 =?iso-8859-1?Q?prA5UW2qgdC62FMbaXse9NVNxX/naOttS/gRjI+cQBQiuviDYZTicymWml?=
 =?iso-8859-1?Q?pdXvegJBJlyddR5/+fX2kRXkTsT8llNMgd0C9capAFtMef78sla+/PZUC2?=
 =?iso-8859-1?Q?3nq9jvfkfo/HqX6YS2rxV9JWHV8oTrA3ksOrowzyEEINFGideDITnu9q1A?=
 =?iso-8859-1?Q?tWxm3XmoaN8HfMjssP6CaTKdaZ/WEt2kAPf3f7VyqItKps7nVUUXaGroFX?=
 =?iso-8859-1?Q?qBpdqqz+KKsWY/MCHmEiO0YZD9f2ES1WoMcM39/9zphe+6O8rNZJRv5yya?=
 =?iso-8859-1?Q?fKMwKcg9oQy0Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8a4b05-29c4-4128-7147-08dc3cecacd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 08:17:18.8983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLhiht7WRRRjc054Ecch/ZQUVpbzO5Kb77TNwJjs+7UyQ5XI7QjaLDMxZYmcyP/H2NBmY4opCfWQeGgMxUz8zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

=0A=
>>> Please add a test.=A0 tests/qtest/bios-tables-test.c=0A=
>>> + relevant table dumps.=0A=
>>=0A=
>> Here I need to add a test that creates a vfio-pci device and numa=0A=
>> nodes and link using the acpi-generic-initiator object. One thing=0A=
>> here is that the -device vfio-pci needs a host=3D<bdf> argument. I=0A=
>> probably cannot provide the device bdf from my local setup. So=0A=
>> I am not sure how can I add this test to tests/qtest/bios-tables-test.c.=
=0A=
>> FYI, the following is a sample args we use for the=0A=
>> acpi-generic-initiator object.=0A=
>>=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D2=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 -device vfio-pci-nohotplug,bus=3Dpcie.0,addr=3D0=
4.0,rombar=3D0,id=3Ddev0 \=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 -object acpi-generic-initiator,id=3Dgi0,pci-dev=
=3Ddev0,node=3D2 \=0A=
>>=0A=
>> Moreover based on a quick grep, I don't see any other test that=0A=
>> have -device vfio-pci argument.=0A=
>>=0A=
>> Jonathan, Alex, do you know how we may add tests that is dependent=0A=
>> on the vfio-pci device?=0A=
>=0A=
> There are none.=0A=
>=0A=
> This would require a host device always available for passthrough and=0A=
> there is no simple solution for this problem. Such tests would need to=0A=
> run in a nested environment under avocado: a pc/virt machine with an=0A=
> igb device and use the PF and/or VFs to check device assignment in a=0A=
> nested guests.=0A=
>=0A=
> PPC just introduced new tests to check nested guest support on two=0A=
> different HV implementations. If you have time, please take a look=0A=
> at tests/avocado/ppc_hv_tests.py for the framework.=0A=
>=0A=
> I will try to propose a new test when I am done with the reviews,=0A=
> not before 9.0 soft freeze though.=0A=
=0A=
Thanks for the information. As part of this patch, I'll leave out=0A=
this test change then.=

