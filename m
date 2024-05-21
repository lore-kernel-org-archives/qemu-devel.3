Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CC9C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI6-0008Gx-TK; Tue, 21 May 2024 09:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHX-0007j3-94
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0001aP-VT
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297113; x=1747833113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OdoSWUTa9ddjTSMitoGhaOWL+giZnUC0wKZ/HGPO8cs=;
 b=cOwrdBR1zaDTpwBkwMs+n3cJ2SWZWMfMNGTVvK9giYklD7p5DhV8Y9Ie
 5IVUMQ1HyC23EeBJud/jEjUb9YZS/4EfLpqd8K5r4h/5FWrOvJdFja/kJ
 1VZd+1uPPWaZrx1nDNaTY6l8aGuSacQu763fKZhgfUOONRcnxrSRdjQ2P
 SA2DYi1d3r6WYCA+HyjuFLQe14NL1oCRYh/+aZTRtWk6c5PP+PCnGCQsQ
 53GsiQ+t3aTqp/CQSUMwG68PCp7bGGc9/+WhDM+gC4PfCh1QbhTefty/k
 VshLYDpklBbYvNW7lwMHGQT9GD7Ns8lZrInZQzXW4S/BHPcsfAtbAMhRV w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13007994"
X-MGA-submission: =?us-ascii?q?MDGNhRK9jPNimaYx1YbthKwrNoZunb2sl4B97n?=
 =?us-ascii?q?hxMoqaHfsRyddSr4+Fm41BA11IL5wBI8vlMFfsD5TMxx4eKC3SriyKUw?=
 =?us-ascii?q?ZY8gbEktDucLxkwyNOszJVLy+pJNVHX1Mw0xVzSQHU7tPae1x0mtZzcT?=
 =?us-ascii?q?+K39mxj5iKvSzDuSz+6hrTog=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQPDoNYaGuhSJt6S4RHLjD4qKlNsRFWB1ewsmxfChdW2rzvz98gudJQreZ4luFAr4OCq1nZ7hhofJd1BSiumUltFJOmxPYCQdLRpfEXMPsTUNtjFOv3sd1BwEl6+VXV+2Dxj5Q2I+XKylI+CKSLh5djQR3Up2FIyPVPzsbjkBYKlxXD1BK7ZYpgOU1A62vDVPvk8Dca703Io8Z5MactW4WKuoNHOBhNXQYFMgpXmxYN+ETkZ/M6531AMXoraOs7lRqZdEwtBtX47U4mfH91fwnrqLade/Mw8XhwDXny1IcujzfjR9ji1n5Hmb9rYUtqB49K00U45lv+85XJfUo27NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdoSWUTa9ddjTSMitoGhaOWL+giZnUC0wKZ/HGPO8cs=;
 b=mNjAy6lPmI2owi977ljDjUTPrtQgnYBgLbZjnLamk5tmq7PJW/YdpH2mqak9z+vGnQ/uUodIRimVYgC0eC4VtKEpQCOrdRP0V2h+iF2u+BnlgT0MaKg13Oub4UZRtT91ZSmVm4WQ0h6Bd2AEq07H5Y33PxYJ4bGXvSU4Ck29MTCviASvT5jenaPlUfs4Q5tUxihzc9BuS0JZQIRNwvGuBQATvzk6wINFHLu72XqfBorWBSiIrDheil4HdqEla7F28gjFg6cwABywmlUxBv9WS8Skc4eAx5AtbRht2uD0cL3i+kBdAzU0tV01pdt1F04WAroMV3PVTzpk1x4lrmOgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 04/22] intel_iommu: do not consider wait_desc as an
 invalid descriptor
Thread-Topic: [PATCH ats_vtd 04/22] intel_iommu: do not consider wait_desc as
 an invalid descriptor
Thread-Index: AQHaq4Brm3Er4wjTZk+767IR2JUSug==
Date: Tue, 21 May 2024 13:11:40 +0000
Message-ID: <20240521130946.117849-5-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: d04919dd-939c-4392-c243-08dc79978db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?clJyRHBCVWVVNkFGRHYwc2FsSGpBVmlreFBWUU1wbVJwa1FEK1l6K0JKaGpa?=
 =?utf-8?B?Z2xpWWdWV1BIRGtmbk1YSytxTFl6aE0xUlZ2R2RaZG9MTllSL3pFWmlKd2lS?=
 =?utf-8?B?UEQxMzFqaW9PaTdjbWZacnlwRjFHNlB5dGhnOWxEdFpsOUZpNlJYY1NoRnpp?=
 =?utf-8?B?SisycjEyTzFuaXdMWE9pZGZZMHJBY2tSQlBwYTF5SGdxV0lOcERpVzNuRFdi?=
 =?utf-8?B?dnhwTUJGZG9DRkc0MEJ1akwxTEh3aGpodys1YUtkb09XZkxhYllWZXZGSmRS?=
 =?utf-8?B?R1hzSGlDbE1rb01XZVloWnFzTGdqdUttbVFjYmxZZXFrdzBUbkdlVnFsWDJm?=
 =?utf-8?B?bWFlU2ZtWGJDZk9QU3BPL2tvSHZGT3RQZGVqeDFMVDNTTGVzQUViNHFFcDRY?=
 =?utf-8?B?WUJTdDRHNTdaN1hsc2loUStzak9JSFVoYzZsSVpFY1pLRjl1MkppNVNjOVBD?=
 =?utf-8?B?RlNUcEpqYVA5aFlTWWo1akNoWEp0WVRmS2VWQmFjeVl0MnNUS0d4NExXL2R5?=
 =?utf-8?B?dVVJNkQyMVRHSzM0U3R3OWdOWXluTnVweTBmbzQwWVFvK3JFWW9VQmZpaDJG?=
 =?utf-8?B?UC9QcEJGTmhtWUxna0ZOOUFZdklnOUFiQzgwNGFzbnBaZitSTTRzbFplS0FX?=
 =?utf-8?B?c0JqbGlMYWxhZlpDTE5HdGZiZ3E0QjZvSXYydDVSTW9JOHQ5dDMrVEdLVk9D?=
 =?utf-8?B?cnc3aXh3SDRPdlhraUtETXUvYkszWGROWDVFQngyTnhGZ1VrcTdCOHJBb1Nv?=
 =?utf-8?B?clQ2NXhsejdVWnpIb2wweEdzcHdpWTkrQzRIMVlGa0JIR1JMZk1Nc1BaaVRr?=
 =?utf-8?B?UTJRWjRxNXZzb3R2ZVVJSjNsNXRTdlRPbk1XbHFPOHRaaXFuUUpiWU55OW1N?=
 =?utf-8?B?dTRSNWZBNVMyQVhJNnN5ZGFralJtdWhFcnlxTTkxNzNCVS9La3ExRzNTbnRn?=
 =?utf-8?B?Z09BRXFyVlFwbjdkaXpZQURGVUxEa25JbHlzNGkyazNlYUFXQlNtU3Y3M0tp?=
 =?utf-8?B?eEY3ejJrMFM0THpFNkkwTk9IZnp3MzJMNWx2RTBaell3OE1VMjVEdmZUZUcz?=
 =?utf-8?B?U2RFdlRkZDNWZTVpalV1SFZNTXlkeWU0U05XZVJLalN6blBUNEVaMXBWdVRW?=
 =?utf-8?B?a09aelhvWTRMMjdtTmFZamd1WHF0Y1JreWpDZWxMRG9BRTB6NWp4TzNweHpL?=
 =?utf-8?B?UE41bzlOM2pTeE1iaHg1aXZEbHJqWG84UkxLTHk0a0lYWFNJQVJIVnJ5Y3VH?=
 =?utf-8?B?Q0l4dDNzYjZxbS9wWjBXdzFXZElLUTVJdjhlTXppMmlLZ1NUb1FrWkhhRzlM?=
 =?utf-8?B?d1krTkxFMGpGTWZQZm1ZMmRDWVp5dUpJWE9Nc3c2Y0dUdEJERllJOUZIcSt4?=
 =?utf-8?B?WG1ZSE05Z3UzVi9CSGJDd3FDSnYxQmZxaVhYbFYyU29xcjl2bzBLZ2N2bG5U?=
 =?utf-8?B?eGJoTTRISTg1M3IzMm54RFl2SWhZd08wTWlOWXpSNEdxU3pBYndIM3RSMVZ4?=
 =?utf-8?B?ZWE3VWlXUU04Y2FsaGdqV3NtbkZsQmI3Q1Q5TmhHYWZ4THk4VlVVQy90bjVL?=
 =?utf-8?B?VVpyaUtHZThEOEFGSElJYVAvT1NaVUM1eWNiSUFmRk5MUUlUTEE5ZkJtMzUz?=
 =?utf-8?B?RXNsZ0RiV0YycmlkbWEyYWJZVG1PR2NBa05qNHlNcDFUOEpvVVB3a0FDam12?=
 =?utf-8?B?NGM3MW5MYlBSaDhCVU9Bc0ZDMm50akUwSnpyUEdhNUNOSTNoZDdlYlp1TFc3?=
 =?utf-8?Q?1vIxQ1Di7HOhPieBqYZ/JraB37Vfro/4GfoHqF0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dis1NHVoUzZjc2RDOS8xNTkzYWs1YjQyUG4wRjJUWG1yQ1E2L1NrK3V5NGl2?=
 =?utf-8?B?UElBZ050WG9ld3ZrOWYwQkRGbWlxUXpRZXVSU1NUNlFhR2lWNXBVdnlvdzJl?=
 =?utf-8?B?NThiTFI5Q05nRWQ0OE9STVpZbXVyOXRXcERjcXdnVS9HMzlET1FqdkczL2lF?=
 =?utf-8?B?OVI4d0hYK0dCaVdkVlA0bi9tTzI5cE9mc2tlendjWTNZUHF0SXZHMG55RzlC?=
 =?utf-8?B?ejFKZU1QMURjaGxRVVBRbjd2OTVOM1RoUzdtTkliUDNKeHdUZEtPa1JhNGcz?=
 =?utf-8?B?WTZ1b0lrZDB5SmpRNVQ2UVRaS3ZHYjJ3ckNlK0hpcEpNZzI1ZjI0ZzQ2dlYw?=
 =?utf-8?B?RnBXeUpxOGpLRkk5WE9rQ1pLVENsTVJsQmpLdUo0RkxMOE80VkIxcW5LbTVq?=
 =?utf-8?B?aTZULzQxeEJ1Mm1Lek5ENGM5Rjk3M3kvcnhNekozbjVCQ0svcTl0Z3FsazUy?=
 =?utf-8?B?UGRvK0Rhd0dRc200UU5PMjVmNjlFakNKcnNLSFh0bjVaZng1T1kybFNVWFZT?=
 =?utf-8?B?ZytCRWFtbHBydmlVM1huZEFicTZPMEd6dGhaUTNWeGcwaTBRTG42Q3orUXY3?=
 =?utf-8?B?MjZESm5tdE5jcERyVkpheXlrL1pWT3o0eWVtQTZ1anZQenJqb1JiMTZEd0p1?=
 =?utf-8?B?U2pHemZtSTZ4dFpFN2t3ZHVBakQ0RWFtUW9DdWZ4aThZVG8xZWN3enU2MXdP?=
 =?utf-8?B?RFJCQWJUWlVUcm8vOS9IcGVXV2RWU2JSK0lvei91dWtRSUpac1gwNXU3d1V4?=
 =?utf-8?B?REo0bEJnS3ZlZlVOK2M1M2Nxc1o3K2t0dExmdGNEbDVoVmdzQ2VyVmFXU2hU?=
 =?utf-8?B?RGpOQll5QnlFcTZnclVKRTJ6alJQbk9ndExLZlp4S1JIUE1xZG9nR25uczNF?=
 =?utf-8?B?OThnaFhXUlZFdlhReHNaZ215dCtvbzkzeHRBaEsyUzFPNnNHRWcvaElRczhM?=
 =?utf-8?B?Z0M4QW85YVZwbjdhOHpjdTdvMVBORmVoSVBNNnYrK2t5M09SelBEK1VaUkRy?=
 =?utf-8?B?SzNrVktpTWFKYWQ0U3F0VE1qZTA1VXZJK0tHLzArY2FncTRqUFM0QUxWZVBk?=
 =?utf-8?B?aS9NQnE3ejJSdWZnKzd5VzA3cUFRc1hUdzVqSXpWK25pZ1poekplbGxGam9U?=
 =?utf-8?B?VCtVWXFPUGRBNjZWcEQrZVZIMGhlOHM4YjNFV21qU0d2WVZvWURhREJBWEF5?=
 =?utf-8?B?bUhsV1Rybk9YVVdUU3FkRFJIYmNOV2hUOS9iZUM2YWMzc29JYThLNDZzNzA0?=
 =?utf-8?B?aVd4UEtURVhQcW84T3doZ1hUVzVQTTN0VVlHRmFUSExhMHhzVXB2YnoyNmtQ?=
 =?utf-8?B?cERlamFvQ3V1Qytkc25yaDhPKzNMQ2hoYTBDSm5tSER6dTBPd0p0S3VrTko0?=
 =?utf-8?B?NnJTQmloVVcxaFNacG1vNlFoMUpEWjlDbEZSRWFOVDF5L2gyNUtkWk9OSG45?=
 =?utf-8?B?eXdORERIcUZoRWo5U3JsR3JPdkl5NjZqYnpHRzJ2cWVQekplcm45V2d6dTJn?=
 =?utf-8?B?Qlo1TUV5MWhWOGVGb3pXcnZsdDlsQWpvWDJrYUFYSWorT29EWU03SlVoNWRT?=
 =?utf-8?B?R3krOUFJcXJ3SnBGdnZWajdPVm5IQ241a2p5aDJMandkWkF0MVU4YzNIR1pB?=
 =?utf-8?B?U29VWEx4RE5QWEtLeGQ1M1pvSXFsT2o3YnZ1djVSWldtcW56R3VmcmpkTnRp?=
 =?utf-8?B?d2FwWi9uQWZZS3BSVXNvSXZRdVZ6R2hGOXNWR3JsbXByYk5kaG5qMDNHdFFQ?=
 =?utf-8?B?VFNrUmlBQVp3d21BTGNrTWhqT2ZyRExSa0FjTGczbXJEZTIydWxpR1g2SDZt?=
 =?utf-8?B?RXorYlJRUXRSU2VGN3JYUXNvdVpGVlZOVkFTb3kyaks4N3NleGd1aDlCR1Ny?=
 =?utf-8?B?UnJYWTNRd0sydzVVTUtqdzFUdUgxbFpGSk9JTU9IWW81VmZ0cXpwOFhkNWt0?=
 =?utf-8?B?M2ZVSVRuUVdMMDJkY2Yya2VIUEtNVXBMTmx3a2FSQk9pMXA5QWo0aHpIaG5X?=
 =?utf-8?B?RExDUUhrdDlKM0U4ck4wVG4rS1FzYlREQjB5TEdXUGpTZXI0Vi9CTy9DYlZm?=
 =?utf-8?B?OUpJUFpVV0dWaVpRZ0tyZTBINkdhK25uYlVCbU5UaVJZQWFSMHdpMzg4UklY?=
 =?utf-8?B?MjNGeSt4SzdvSWFoRnlNVVBhWEhjS0JvT1lQUmdsR1NjTU1PK1RrcWdIMjRN?=
 =?utf-8?Q?Z1X4ujcGk5GondWzkL8Jy50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDE83A9BA4FDFE48A93A08C10572DB19@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04919dd-939c-4392-c243-08dc79978db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:40.3880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBVBqRtMurVK5BdvZ0bnReyxQdDABthkCLIvQVxub8sE9+gwp9NuDll/2brt3jMb8lL6cTD6x7S5Da52rRBe++FJSZjiXUo9l2kOJ/FS0YS1VAua8DE2Ur2C+47CMm0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDUgKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGEyYjI3NTAxNmMuLmY3
MWMwNGQzNzAgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KQEAgLTM0NzYsNiArMzQ3NiwxMSBAQCBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc193YWl0X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVz
YykNCiAgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBWVERfSU5WX0RFU0NfV0FJVF9JRikg
ew0KICAgICAgICAgLyogSW50ZXJydXB0IGZsYWcgKi8NCiAgICAgICAgIHZ0ZF9nZW5lcmF0ZV9j
b21wbGV0aW9uX2V2ZW50KHMpOw0KKyAgICB9IGVsc2UgaWYgKGludl9kZXNjLT5sbyAmIFZURF9J
TlZfREVTQ19XQUlUX0ZOKSB7DQorICAgICAgICAvKg0KKyAgICAgICAgICogU1cgPSAwLCBJRiA9
IDAsIEZOID0gMQ0KKyAgICAgICAgICogTm90aGluZyB0byBkbyBhcyB3ZSBwcm9jZXNzIHRoZSBl
dmVudHMgc2VxdWVudGlhbGx5DQorICAgICAgICAgKi8NCiAgICAgfSBlbHNlIHsNCiAgICAgICAg
IGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCB3YWl0IGRlc2M6IGhpPSUiUFJJeDY0Iiwg
bG89JSJQUkl4NjQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICIgKHVua25vd24gdHlwZSki
LCBfX2Z1bmNfXywgaW52X2Rlc2MtPmhpLA0KLS0gDQoyLjQ0LjANCg==

