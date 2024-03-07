Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDACC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri42U-0007To-VW; Wed, 06 Mar 2024 22:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ri42Q-0007TQ-C8; Wed, 06 Mar 2024 22:03:18 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ri42H-00075J-Fn; Wed, 06 Mar 2024 22:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+eVm+ugWjCfVSvw+n1Zu0b1xan+E6Rpvx/0ZFZ+a5YIuhgFITd9dauzuVlnKcrxR2UXICMNPAvnnXtc+VpHMHJpwpv1hN2bhh1w4/OAyWr9xsOcFMgTxYjPrCs7kty717qFtdfClXbpozobngrJqeuidRRA3bSm+yEbniiUTvU3uZG75BANGosqqZazugz6aaw063gPmSebym3gfe5oKqNSU3UuXlj6YBQY4A+NIuCnKooQct5ZtRl5nrDnVml0gp+ANXZ2fQ2ZVxb4xBV/zZJXqgkRqp9XDGr+JphrAW43s6Ev1swLFSj8NA8NHlOrWx0Bye7p8cxIEijAPzHQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhjiDnUlPYHv4W4Y0DzMp+tVpw/DsxNVhvnJD6FTrWU=;
 b=m8vFgvs87MDyrhVS6VKYrijy3EWULz/5ExNizRiP+nTjyAYX7Yo4gFlkAoW66jhMGfazz+wePaRNbyhVJnbShU1c9bLcIpAqfOnxQstTPlT3MZSnAg7/ymwLfhq3nZODHvM7JjPsNfUwEFhOQ9Gu2qQdgAKsqYMb6OMNmJsVvVu5TsPmwiiPDj2n+wyTJib4XxTmv0AIJvc+ziab9HRY/Tw7gahdRO4yHExLlCyoE0TwSOuLq2R0Ks5pLgn+rKSP8ryVbOImLhCUQeUh13BToy+5iZY7ALqrimlesls3fGo8W790im0eMmGKBqrn/LBeD51eRWjoqD9XwGXAXp2//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhjiDnUlPYHv4W4Y0DzMp+tVpw/DsxNVhvnJD6FTrWU=;
 b=VCzettdrL0Iyoq7UW+AHgqJO91IQkeCSsVQumaLbfug3qLP32PgLMYIYDlNEoOK2V0uFgP1Umb4TIkywd3X3nhh6Y/MGJvLo6fKyjMcjBSoUtgWYrWla9U7bEd9QoYGGHVNrazuBILDYd/cTfWmmn+Ry7JqwdAIBeDj/k8YY8UhtRhwGJdaLepd6Dihe/Gd2qWd+ZmceE+uNjtBCwCO52z0OmOA9ebej9+kZ9toeQJHJ5KRLGZpZ/pyuUBS6HMlB54Po3s+CHebEh9rSsDU12LNZQiPVyzvurFQmpmvpck2l7Mmeq9vOGzX5r4pJ1uLtHig0tM6HV2LtA9fRSb8+Kg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 03:03:02 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 7 Mar 2024
 03:03:02 +0000
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
Subject: Re: [PATCH v8 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v8 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHab8KB6nodse2XK06h3c6o2tMqwrEqvUyAgADZUho=
Date: Thu, 7 Mar 2024 03:03:02 +0000
Message-ID: <SA1PR12MB71997549A6120677BEDF2287B0202@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240306123317.4691-1-ankita@nvidia.com>
 <20240306123317.4691-3-ankita@nvidia.com>
 <20240306135847.00007876@Huawei.com>
In-Reply-To: <20240306135847.00007876@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SJ2PR12MB8977:EE_
x-ms-office365-filtering-correlation-id: 9babf536-c803-4a6c-4277-08dc3e531a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gI3PRQ7t+ekT0z+cIveaEMph7ALXC9hoGN3olDoEVpWmbHSS8lGS9WpMhoePnRh75supbriojcC0xtZUaIAfizfSol46JsWjHYfbpDQhurJBQBz66f6S2qYU0pOcwovSFkqYY5l5XeT5uQtOZTDyb9HEhN9gYC6ERZwQgE6lYE3ukoC67Au5vvRwHCe+vFZ+Wh41ds4v85kQcgADlOVW77k+PPNaqTB2e4rvfLjM5f6OUE1H8AQ2ph+Y7n/xFImkcSM/dB1j7sB8gyDE6WSQLWiqzFDF2sGs+/mpHyuqFpPHanmU3RfqFNnHv0WS4NR9V/01LxrRI3zQxTg4H0Z2y+d9oAxDNdx/CUieDPFAh0dEE6FndC1puVTJczDTKPjlHJAVUrI/K6m2TbLRf6OISdUU2ZNPlbH/eTsBr8XRjjDZ43rnZxSjdDwRLoajVzWodYoBi/tUAwaoqwGgxHsPWI6uzrMW+7fGkkKcTQceMGHfBNG2D/2my3M4o70QAg8irDl2+uKarccAvvRVPL4CrSSJL+GwogXL7UdG1vGQdFhoCgSaFpyNxXKb1INmhSn8vDp8V6FPTfZKKCoE8QR4HVzcF7O0CMYnsKZ0AsZDHl+X6u2Y0EvCvvgbTpxDZGnveRYhs/+W805lSQRGvtLS49cYP+mQLp/niVCSXzmEvNI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4dkwmHQF7Yd6cKV60G2TeU5UjKHzrdcFmMKrrFxlXheNkNFvPQr5PmKYTr?=
 =?iso-8859-1?Q?jTaaCKcHBK1tYPD7BcJF0gffp03V50XDRNgWZipAuFW9Qh5KqOW6SQ9Hta?=
 =?iso-8859-1?Q?BTXlDTGNdbCM8K1PQIA2jbt5zY5vKdPY+2imX3I+YR6UvqD4TsOh4icYwC?=
 =?iso-8859-1?Q?fxBhblltYRT4EZFtVME/O/fITtST49ZHWVJJffDVGNaBbPRYeBJuk0ZSLP?=
 =?iso-8859-1?Q?PT4JM67VBqz6WiVDpRgyJ+y80zel6JDr+8iRw6h8mobD8WTckjcXIv69P2?=
 =?iso-8859-1?Q?B6psXF1WOXy6i0XeTqkifMeZ/ddL+BMolns45WdIbqBnH7duwVI2xW/0ew?=
 =?iso-8859-1?Q?1F2lK10tM+6N/I92qkbxI2Lznci0zA/+WXzJTQmgeeg9kDnl6Bj9pkmwqR?=
 =?iso-8859-1?Q?Q70F7RFgo6QFQZza5vmizLcxhaVxDUaLwxdl5mnO2ttFH6qTVlusJwT/MI?=
 =?iso-8859-1?Q?qU35FRdVDIz+8EP4vaObcq8n9nF48puznm0gISH4LzpGc8PxdSCuUu8Ej7?=
 =?iso-8859-1?Q?koba/aTRUNKG4rmqP9lbvrBXIsyq2D+cF9hJbWmkZbiu7D1ASfXy+IGKjX?=
 =?iso-8859-1?Q?Dphf48HsHTg7azZhDr5oMiSXmIqdw4eFpvMf6SXXIQMTOjEaaegG4IklK9?=
 =?iso-8859-1?Q?lEpBu3Gqitli0xXXnnjzoCEF6JL/gr7LjDV3Lj5aYRDbrDaZGlxFhGy1PX?=
 =?iso-8859-1?Q?pRDZRUKp19ng+OiARsZNHXJEx79WZVVf2ZNMPNFV5/2bp+Dooq2UuQet97?=
 =?iso-8859-1?Q?Aw00ZnhbjIO7eyNKa/icsaYVmUNbJAJAsHUv/CkxXssEj2oTGXtdp6xNU8?=
 =?iso-8859-1?Q?vZHCGfn8GVmCmusNnmZPCc4ybPRoRbJPY71WjjB2ycjv2Ob/3weTqi+shG?=
 =?iso-8859-1?Q?jHXIPFQ+hZoSgk/myHjaH61jjnM0G447cRXJLlo7vOv2L3AWMjmDpZkaNj?=
 =?iso-8859-1?Q?kU7p2AFKkEPbZhrzQo3WeGAze/cev6ioWNos9JwmmpYbVs/mejxdDHaxcm?=
 =?iso-8859-1?Q?hcNA69TKVEzo7Ld2EGT/uZ/gVYZtizsoO+ghKAuX2qeWmH+IZYYVAjskTk?=
 =?iso-8859-1?Q?4SMKkRxSUIRyfkuaHdT9WwklFnxfffCyc+qoK8jJY5BwgX1m65Ovrd0vZh?=
 =?iso-8859-1?Q?Y/e1Qazd6gMktDkjR/ZEBtV+AAtEB2IUxmQ9csums3PXljJoyE9p9enJ/e?=
 =?iso-8859-1?Q?d2lS3Amd2uOlMtOIAGKGHaQeV2/5RJ8riCbf/ozV0B+6Wuny2DxifMfgUf?=
 =?iso-8859-1?Q?zWkL05N4YFV58zeclT1cDpVkTF7DItWioqnDK59x5MsFHiGay2Dz4r/mE0?=
 =?iso-8859-1?Q?tcFmzfSDOxXeV3Z4HbZa2bYpHm2V2F4lZzR4bPwd/4KdUOdNcJRXa0JpRn?=
 =?iso-8859-1?Q?w2tvhDjfPN3R6PJ2qGuKFzc+jMJKvRBFLiSSwiLBJ1Tz3ExYluFi9OppoN?=
 =?iso-8859-1?Q?RzpqdgybgHfV5mXxXss7SEWCm7NyGgr9+kZUIveVS/Q8TeVit9zwaJxDl0?=
 =?iso-8859-1?Q?K4jPPc4XDo+nysJ6i9tQ7e1X1ZFGTjFt8WC0nY1HRdtMSnUj0XHXgTKleh?=
 =?iso-8859-1?Q?DA0Hp2Z+dZEirmqcKfaFQcGPzjZr25cBan0f23817eCuUkSARnZIWHcNS5?=
 =?iso-8859-1?Q?JYLzGV7HsoSgM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9babf536-c803-4a6c-4277-08dc3e531a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 03:03:02.5759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcbWTF1vBqffujyW8E7isXo9uha/y5WfME5LAW+qg/vSUVffLyQrh9JoRkwYsCNJvVyppNvb7ilxi9HJLEfYrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

>>=0A=
>> [1] ACPI Spec 6.3, Section 5.2.16.6=0A=
>> [2] ACPI Spec 6.3, Table 5.80=0A=
>>=0A=
>> Cc: Jonathan Cameron <qemu-devel@nongnu.org>=0A=
>> Cc: Alex Williamson <alex.williamson@redhat.com>=0A=
>> Cc: Cedric Le Goater <clg@redhat.com>=0A=
>> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>=0A=
>=0A=
> I guess we gloss over the bisection breakage due to being able to add=0A=
> these nodes and have them used in HMAT as initiators before we have=0A=
> added SRAT support.=A0 Linux will moan about it and not use such an HMAT=
=0A=
> but meh, it will boot.=0A=
>=0A=
> You could drag the HMAT change after this but perhaps it's not worth both=
ering.=0A=
=0A=
Sorry this part isn't clear to me. Are you suggesting we keep the HMAT=0A=
changes out from this patch?=0A=
=0A=
> Otherwise LGTM=0A=
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
Thanks!=0A=
=0A=
> Could add x86 support (posted in reply to v7 this morning)=0A=
> and sounds like you have the test nearly ready which is great.=0A=
=0A=
Ok, will add the x86 part as well. I could reuse what you shared=0A=
earlier.=0A=
=0A=
https://gitlab.com/jic23/qemu/-/commit/ccfb4fe22167e035173390cf147d9c226951=
b9b6=0A=
=0A=
=0A=
=0A=

