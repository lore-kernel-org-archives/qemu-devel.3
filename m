Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5334C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfN9C-0005sb-Q2; Wed, 28 Feb 2024 11:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfN8k-0005fy-K8; Wed, 28 Feb 2024 11:50:44 -0500
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfN8f-0003F5-5d; Wed, 28 Feb 2024 11:50:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coKH26QzDbyfs5p51tHDR1Z1BjyVsL0zb+ILbPluQiIGtOyEQRdfLJ+ByXEMTz6tPXdHxFskw8VXl5pJa4TNQv3om87MFmeDBXULa1h225T2x1xFd/LLxxrtT4UXTMlXiRhR+S/0SQY53Q0tQAggLBKoV7x+0yKUbFmqFtVvU8QkrHfF31/3AXM0SqYQZwyeguGsDsCbe0zopBYnW3pvVG4ezmaxY9Q6rpA9YIZveO4ttambSDQM02/X+VtJxNTI0YewBoOBDtgd7oxlS8VUGc0uoyZ2f/zAQAkZMcHUdutCxGlcKzV9BGqu6LPIbimZuEWif8uVtwXsFmileMMKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tDXFJIl5RTgFY0yI6P2dHfa3T5Hu5JAbTUjXQ4CIOo=;
 b=KJYEa7y8CmtPwZubNWdlzJ5aP0tDMMnbLLaYPB6Qvr33K/40XAWjZLuUeQMFvjGA6zHZ3KNyOQju6y1Rzj3OzCUvYZs73SgPDxjC40G5Q2ONqsLifF58m2nEjsP0C4pOWqYpFlZ+KlPs6uxX+DxPDDsDhRF5uX6u4tDTn9Cl7U8BcwM+VPjZC3CIsRkpvTZgZUCkyU+ofrKrezx4zSYjRaHkN8A8eIQy8ILB9gIhyxxrf+2kYmBxF6RTjFmExiRan/C7+vmcALcvGYKIT8U8IDJJjiJbtvEbZotVj5IiCCbCWJjRsxc5STFYbMLje+VhE9wMXtmo2BMN1Vljsl5PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tDXFJIl5RTgFY0yI6P2dHfa3T5Hu5JAbTUjXQ4CIOo=;
 b=bKTWppu/t1Q4yeunBOMOYiQk5MqSKnkZuue4poxBDxW5GFaX+ln2juDzc4WtQqDDmMzEll0dSuN3b4jxM4fky6B/Bl9j/sn009smD3VwildD+HAv/3m4o9+l49nchHsj2RXDSHQ8Hn0QGBJipvnH+vJt3ySxwbqK2guj1gcYVrYpn73GXztXwjd0AF42BBWFLgi4YW2bRxGONvDKVwexlpD87W2ohqoDnAJbiRGQugk5OcnLaoUD8igJ8K1yjFJQ8vXxxKjBQH5QshqC0IGLhKEpPPqGFXigLURWeMm1GKEghOEJgZKQkeMchDTiv0wQc2PO2L3PmLwlSeCLkpzsUw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 16:50:30 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 16:50:30 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Markus Armbruster <armbru@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaZlXRpHP8fv3NL0CqBnE3t10aOLEfZKrYgABqHwCAACU5hYAAC4X6
Date: Wed, 28 Feb 2024 16:50:30 +0000
Message-ID: <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>	<8734td3uty.fsf@pond.sub.org>
 <20240228135504.00005d12@Huawei.com> <87bk80vaft.fsf@pond.sub.org>
In-Reply-To: <87bk80vaft.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|MW3PR12MB4474:EE_
x-ms-office365-filtering-correlation-id: 979fcc16-120b-4fba-44f9-08dc387d5f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKXBp7PRViwG7WWB7ir7AMCFmYMeWfqGecTtUegVPtigceLDl/69crj6W5QayWISuJas4HzK2OPnF1lK2wz4rxtVsCHW+/EsXU7t4ilHxUrrcAY1cnam5G5sJgG3KpY/C0g99sRKduo0U8IDQO/FOo1f58m8oAXklT+konbpT1+C9zh0RhIyLp2YXkTEtNTMLq0f4FmjHiFKf2fSViqE3HaSCydmW9rQkdKwtJEPSgmkglRg4QngrQaQETgxCHmWRdPO7gfY5ZKj7g0MlY4AasLdG5DVor5rbmkRY00fBI5FM9NUeNyI/jQXbXOMzbTwyZFcDa2MKk2ulv5sTWMlSjbTeXVg+weJmn7CDe/PGOnhWlZrKfB1Wd1fl5vNoGzbjLmk6gcXrm15SWxny30Y/T1RPnrSmvvQ9pN/vUUVGe3w4MaMo2J8vBFuC52KPoPivSNpik/GTnn18QvJAjQ6oBOr4I+XURJCf/n3HvInymnotnQ2G8X/AqZzU3MZX0XzE7f0mTq7AYpxoSdZ+s8mGPz1pF+2djsxx8i7rkWpQbldAG45ndFtZCDRYDTiO1vRNf8qTWcirwxOo13oVFy+SbV++z2DzRN+X3kDTTImeCwdP1/cBnMyP6Lr8Ty6reSbkZNNQITl2a1g4yFvXB78qWa1H5Jw/iiNIWc8C5b1eF4GpZFq8yOjeu2Cc0EZdg46Z66eK7GXm00Qnryzz1acfS1jH+Hkobc6vPpXMfMyh+A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0hxymucNMMoun7SF0qUfGoNO8NmtQIO6aWjKyNXWGsUDIan6nY+X/4qAsN?=
 =?iso-8859-1?Q?ld2/bmbiz3feWatHtMZDQtoNq+9FVqJd2P3vbvr01CdbXrvE5RC9OnpnZf?=
 =?iso-8859-1?Q?47gx0KdIpYC9BXTpTmfHr30a36E/TS60ltA4DwespScHVGOaAeARbnvz5C?=
 =?iso-8859-1?Q?kmRzBblthyodcbAhsz/4JZR8jqbO0LQ5BsF1JZnBjjQtfCRtoVzC/b03/r?=
 =?iso-8859-1?Q?yswSZVNtyLigzh85T+dCfKTn+kYc5hEWlsWGwsOKlGpnFMF6bHIHuIos5s?=
 =?iso-8859-1?Q?T8Gi40a493nhPprt6En3WxRo4i/9MWsbwpYazuByyl2cIVLf5fSS8HuhBi?=
 =?iso-8859-1?Q?PZ8eXbOJOU3rtRLW1uU4ACQEbrLGDiZ8bOdtD3woGVZJaFS56toGnIB16C?=
 =?iso-8859-1?Q?XTM6ijvz5eGYRqZiNpJrhyzHB9dnkz1JxrNZQvfRnz/9hj5euued7T70BW?=
 =?iso-8859-1?Q?Te84HIyHGWxDTACmPbu7sqHFHABMgmkcQnVcsq9Lf2J9PdL7fUmm6a5nTn?=
 =?iso-8859-1?Q?d5wlwHHanyIeQyQQUpV3l1cawy/NaBICOi1+NGkNVRsT5zGBKMQlY+K8zL?=
 =?iso-8859-1?Q?+cEa9Y8DCiNatmpwYnV/y2NbXBZwI78jE8BkxCv1DBS9CxmUAsT5Rn1/a1?=
 =?iso-8859-1?Q?602m1FV9h1sCFCajymsNnacb4RQJsoKiCZ2NUvEkXPsiHZwtI2TrX8axhf?=
 =?iso-8859-1?Q?0PpGXEqMVvilXRHhvncq4ppO8l8VyNBgF6vnw50uTsF/kh1RFVnvZmzptl?=
 =?iso-8859-1?Q?LpSC2UrP30k6L5yztf0JtFYVV1iJ9cEF8v1F4JjI3aOw4zsgmLXECdAHn0?=
 =?iso-8859-1?Q?yuMqVsOoQ5dUHq9tuTK1nLfugj5N/8gaZpoQkqe9f6izEhSJB2HBrRN6C4?=
 =?iso-8859-1?Q?g3HrgC9XSeMjHhs/h322OdMXd3R0Mvq+LFYd/5a4u4j9+u9FkzQUz9fNuq?=
 =?iso-8859-1?Q?AMF81FGFqu0sSjjQhjK4dOmYLLPPx6xRBNuYRGrVYuyEhALowvLeKHPts6?=
 =?iso-8859-1?Q?lXdBgOgyoGNn7V/HQEZ/YPDSbLQwx9sdsATf/X53ev0vYjO+v5jbnmCfUa?=
 =?iso-8859-1?Q?U/i8UklWPZU+k2Aw/c9Iy7hghIvYi8AcRzFAC7m9PWZLvxDmBcpNtOv38/?=
 =?iso-8859-1?Q?GSQAWswslriSOLFsOFjbCw27mR8d8EcR6Mmi0DTMovVMkpWzbTopCsdI8q?=
 =?iso-8859-1?Q?hAe4uCSxhZb6cHAxShdWW93t7kVOK50XOw015/YBKATVXnlkFr/kQ8IpSx?=
 =?iso-8859-1?Q?8Tl9FDuQd7JJAG31g5fG29mBk3jeZwZ6rjczut4twr7LzVCBPJJhgM3K/H?=
 =?iso-8859-1?Q?+mjwC/lBrkzPeQpMDi7eOSrCFwNewC2fyKdPKfscoy1Hb1y9mM1IZK2HZP?=
 =?iso-8859-1?Q?ghYdcbh3b+Mo+OmTePwG8ANqS+CdST5TSv0KfMwP7F/SFq5TeMRNZo1bap?=
 =?iso-8859-1?Q?VhcMtOnaV4jcWRE9vVkZne3nxNFI8iSaFOV28lhOX72J61TgdTUQnoNpqt?=
 =?iso-8859-1?Q?zUos4b7ADOiezHuZlm/6yWv/SB3WpvYpvof17H2/m+srBTQ/wLz1G4d/qe?=
 =?iso-8859-1?Q?nEvTbl1F9JTBtjMQRI1mgqdEAkq6i+6pJ7Twt5eIGHljvNZ22YvHN/X3/9?=
 =?iso-8859-1?Q?4em0y5/8j1amc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979fcc16-120b-4fba-44f9-08dc387d5f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 16:50:30.2663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OubBEucc9o+m/r4O/G1zdmA72eeWiQmjnpg2KrzoH7WE+6pIGqX/qNanQJuGxeNnxW1GQ+vSMXezwp9bRkefew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
Received-SPF: softfail client-ip=2a01:111:f403:2414::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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
>>> Jonathan, you pointed out interface design issues in your review of v2.=
>=0A=
>> Are you fully satisfied with the interface in v3?=0A=
>>=0A=
>> Yes. I'm fine with the interface in this version (though it's v7, so I'm=
 lost=0A=
>> on v2 vs v3!)=0A=
>=0A=
> Looks like I can't count to 7!=0A=
>=0A=
> With NUMA capitalized in the doc comment, QAPI schema=0A=
> Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
>=0A=
> Thanks!=0A=
=0A=
Thanks! Will fix that in the next version.=0A=

