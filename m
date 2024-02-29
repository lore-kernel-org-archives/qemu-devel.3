Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBDDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 12:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rffSP-000367-MH; Thu, 29 Feb 2024 07:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rffSN-00035J-2w; Thu, 29 Feb 2024 07:24:11 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rffSL-00069l-7t; Thu, 29 Feb 2024 07:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqx6jB2oBkn1CsQ/u0TpfOK/ZL4AOxuQqWFte2Ax0+GJF277EFgLMGCsnf7CypcZR2yrR22VlZhaXNON1YmXjFLTCSbFQvM7Ii5Q8VkDTT80KhrqkGTkYjUHqbDtZnnxKaj98OxzXi8ip26P8IcPv6w+kRuxm/aY2GpVYLJQFUKj/QUZASdy/RX/jhJoodZozoIpzTzCtsVaLlJ19S34fTb99nmWQ32cDNsGuKn8Yu0tNNrWNngaRdRL5aphSmEE/GgZcxk8DN5OVTaqkvubhzA9ZDNd6PfvQ5Pau85Lt+6T1Pm30ZY52lYSjkk45GR4ta1b5aBbn6DFhGNfDjy68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0eUqwq/89j2FdlSyT2UWw+eDsbRMbmes+C8CtfDJWI=;
 b=X8uCxFxSVlMlGsK+rJ8bc1Y9W8KyxSKhZjigBTwun+/uPjyb/AfzKWU2SEAWO80R5ck1VgGiYfmHeVLiYTBW32tGfVWzXt5rMgtXdVcd8Nj20OlgexmrxLUWSDkEIcpirRg77E56EkTihHngusfF46SMzR2sq5+zSJQ0HPgNcpH5MiVrEi5FgC1Ybh8OfWXkzu9PzrJMIqcxEfrQ0w6NC3FsxQGBfU+Vy5lqjNVPkxk2ok5FperKc493FurWM0lVWZkL3V8ldMNjvhaI0fKnMIMHtt6QpQMJlo4cNJKeUiZz6Uibm9+dAvv96OrEWp2YcMCVusbZfCHkqHSUKQyd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0eUqwq/89j2FdlSyT2UWw+eDsbRMbmes+C8CtfDJWI=;
 b=AE+SFg09nD7jpT6svIaSvDult0HrPJOp04KiNA98VMwfrtFKcIuWrTkUodo83XkaeFgpzYWuqSf8O0rbZoT96PWW/Z8UT7/l+T1wOQxHu1uW3SLaxg65i/8GNUruUofdFrFQdsIazhapO8U57qKBF5Du9Ofc/HmWOpGsEtgnv/oNzP6vsag61aaCiGzzjCV+lEmrX8/Q/P6nBv1WgcvnvvnZtNjZzgCcM9OwXbZinrMnCp8/frsxN2REJ8xpi+3S5K95Ok8VY5uQX10KsjAaJDce1bx4usk0Nm8kxz2zWmVSrqPflQuOSxEzwpSq+Ed2TB/BOY6XvoSUkfHU3gX2hw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 12:24:03 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 12:24:03 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaZlXRPSA0zxYvqU+8THPBcca33bEc2OaAgARh1QCAAAs5AIAAATuj
Date: Thu, 29 Feb 2024 12:24:02 +0000
Message-ID: <SA1PR12MB71997A683E212F75548681F3B05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB7199C32D46CF39363F38D2E7B05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229121750.00004feb@Huawei.com>
In-Reply-To: <20240229121750.00004feb@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|IA1PR12MB7760:EE_
x-ms-office365-filtering-correlation-id: 206304fb-5124-4a83-8bdf-08dc392150ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: equiumV1Ku+2tZS92pekRByo7Lfb07LHq4qp0gsddfyq6oFURkudGF1bQVT705t83UfH5t1BBM/IOxqEPn5xtocezCCqG8q8uEX5OiTJ0pKie0WWa62sk5eTsoaAHRH3RkMrXke0VIVGeIGxE9L1IQAtzYHjTCCiH+rbPVBXgMQ2BKEt5lyG3x99x0zOTrCkM4Sz1GCt2KxDahd2YO+K6sUtXej/bgweOM8meJSjLxHy6504XocKH7060rdWOMQn/h+Irap9DqzRpYcqo9zEEN5vTYEONlUTfTrYvOi9WyOhquFYQFFuFt5wniKibIKP3J8SzpZ8RgzCnT7hoV4cjfU0A4tJwMSx29W7sHv0sqiQesqUErh93ZUtElxpq01TnC0pL8zY8BmmQvCiSdPtFCb9Y5Q++pyQ0CPGFyOImV/FTy4H93INaM5YrHlWSUJnq6CnPC0Iq+3iXMvu+OXHNMoRgDl+0b2Rpck9izpQwowp+a3zfpWeTwTB7atLmD/FA7DvYwtSDvk8mKI662moJ81ynHvdU4Y7Lbk08fLz8ZRdmHglvbnX1NvMwZ+Gs137n3nmDsYaEOoAAD5qL5QGLedUPEGgZ2NUPBZrgbVAtSYoKEihCfWXwumbKkKYTeyCq3pCkU7lOGbmV/pctyyXl2IZ6r1P69kq/BonPonr7Qowi9mLoxU/zuUhWm/s2sxJH7B5qfUfWdo6nj9164PBWAZ16wYXYT6TD6Qzw7AWU/w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wyj37cIz/7HvFAc9Wd3xt2KfsGQvJztzWeCv2Dq6ld0H//59PPQszbD2f3?=
 =?iso-8859-1?Q?9hMfyU/lRVh8bRfvtUt8cQ+AQXE3hXNLeXlC8qc7TWz79TY9CSihg2lhJR?=
 =?iso-8859-1?Q?elcr50JtV8848v0DIYOHmPU0K4OjKndbSbK0WPBkg0psvKd0KMRR2sXusa?=
 =?iso-8859-1?Q?y0IxGr25P+lctT+aBHq3eGva7bTMgdd4zKdzYHc/M+BXYb25a7O0QVPaFI?=
 =?iso-8859-1?Q?TIZaxTQbTtnxOqI10xmULoiEQT3UsOyp3CzNLeY7YDfvtbfNAiLs/6B+q9?=
 =?iso-8859-1?Q?tQ5p/Fd/DjBIQQt7oeL4asazukXfBAMMo5hRWuDzNRlFwMniGjAlmosczO?=
 =?iso-8859-1?Q?w+D3foBZ+l8KFsn7+97CrpjMkf1LGBX3G4tnlkFTi0xl6L8jaIIwok6r8G?=
 =?iso-8859-1?Q?bllmzUPpRvr/a3Dty0Dv2Nhi3iExxx7ZKLvLn3k5JnDtnSThT2csZy5EaF?=
 =?iso-8859-1?Q?8kqilgZREhfayfBarBFTNfXyJhbmEuwDZtPvtKj/JrCqZ1nInl3fXFSz9q?=
 =?iso-8859-1?Q?k/83DJD5CAg7cDcZcKUwi49xEIpYBGsECose+hiqQAVnTn060TBUTLQm2V?=
 =?iso-8859-1?Q?9w8R6u41B3Cx0EJQhF8LQ774kw9u5/lQTT+BoyUP/HHbUJ4zXETh+cbnWx?=
 =?iso-8859-1?Q?npuzsXoAz28AxTjX6UEvvmpS5takyEGBag7JBnfsWVavsvG7HM8aQ0vZC/?=
 =?iso-8859-1?Q?IMy+hbZOzaVMvI/pfC5Ii/0vJ37H60fqZsjyq4eedCxHC/5Mo6VCXTKdkK?=
 =?iso-8859-1?Q?QeXdK3xPXluoSth6/NO2bL4wyJIaL82z4SJu34mIR0Z/MroJOKFc506Ad+?=
 =?iso-8859-1?Q?RSgaCEy8cr8Uw5r8YU8YDOsbwSdHr1StKC0H2SCJnh1R1akzAJ1IRn5urF?=
 =?iso-8859-1?Q?hdF0Rofl+NdAATujtr0+ZxDAD0SfPcDRxNhj+DYFXR1/usIHq/JEXbkddd?=
 =?iso-8859-1?Q?VsOrpgpyTsU33+r01N31J7tOQiH5YZqCNfgkyx+6eLXkoAsyyIIHVyVvxB?=
 =?iso-8859-1?Q?DGDXh2o8MKSL9UmJaLxnzXdW2HpPZQppDodrRc4yXb/iaXpziarlcYXMam?=
 =?iso-8859-1?Q?8yMn1uixo3a1sQScV5iqC1mLopgroo/1a7qfGMjIYWgGLPfUxk7G7DpXXW?=
 =?iso-8859-1?Q?/0rDHTS138yqtPURqWEMxkIXtB4uC9gAGjLK/MrRGusC0220gYui5QtLYR?=
 =?iso-8859-1?Q?2NPK+QRoHkMjXwTsjHdK4M7z1WGpuxQ6QCXLVYURl2vFJ65MKjxf/1xSbD?=
 =?iso-8859-1?Q?cm90XLR2ZT/tAnjyWm0TWqFrebQwSr0IlT7F5ZlSIMCt/S7Pra0+04a1nB?=
 =?iso-8859-1?Q?QcGcwhvELpyVIAIzQtjaktNvsidtePBox2HUfF5qIrnlstafulE7GvlnRJ?=
 =?iso-8859-1?Q?WwVCxNy7/7FFaJUBJRKaIa6O8dVG1pzQK8WD8pE13j7CWan+RaBJgUy5Q6?=
 =?iso-8859-1?Q?+TZI7ZWmA4ndwqmDoqX2/pNejqLxjvZzc1Xsbqj8yApHSxsqP88Wl0OzPV?=
 =?iso-8859-1?Q?NimhjhaAUi1qrLOx9pGC/rEJVoXbpgIAQJ68crWyD2j7cblFtPsilVf4yq?=
 =?iso-8859-1?Q?kGRA2IasOiH4ugmwDPknHx7JiEWdVRBHp62KJ0+kmz5LfZIU7/xcYuJAON?=
 =?iso-8859-1?Q?9BeOsDFHmFNFE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206304fb-5124-4a83-8bdf-08dc392150ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 12:24:02.9760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 416Tb3NHdNgZbhzY187+Wap48D/WcH0TwU0eCaPcYvjWxlvOBeXVwCFUrbyuSVD0A6/O63qFCVbYvuUj6iyY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

>> > One thing I forgot.=0A=
>> >=0A=
>> > Please add a test.=A0 tests/qtest/bios-tables-test.c=0A=
>>=0A=
>> IIUC, we need to add a test for aarch64 to test the interface with the=
=0A=
>> acpi-generic-initiator object.=0A=
>>=0A=
>> > + relevant table dumps.=0A=
>>=0A=
>> Sorry it isn't clear where do you want me to add this. In the git commit=
=0A=
>> message?=0A=
>=0A=
> I meant as part of the test.=A0 Typically you then include the relevant s=
nippet=0A=
> as part of the commit message to show what the key part of the test is.=
=0A=
=0A=
Got it, thanks!=0A=
=0A=
> Thanks,=0A=
>=0A=
> Jonathan=

