Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA0D111A1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zSg-0003kL-7H; Mon, 04 Nov 2024 10:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1t7zSe-0003jZ-Na
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:57:48 -0500
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com
 ([40.107.94.44] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1t7zSc-0006WV-Kr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:57:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4nGjkWE/FnnlCVsW49EW76qzdsuyEMqVOroYcAQkozJUa3+aY2yW6vL2pL+WMR/b+xzJjf/996Q1uejTlhiWDfvdrTbISaEpXFhNBzuHn/0AiloTavcKbOXsLHAArvNI3QBDOIxQVXAdSt2zAZvE2Yf+nzJWR3YBxfRtXHa7FjqoacjRFmyOkMUGXgMIX+qKJpLK1RYbICx1UwVvRWt+DlU+Gra1ejwn9+QHahkcOXQS1fEOM1b2PHV51r5zUUhB/wJfzkoup7oW4AwuAHBrDwK5csUZgHMc4fVfDtgDkUBwkSB/6IUrsFRt8TvMjbX/pMM2H4a69t0EPDnz3Xv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NGr2CwOADCEHDrY6KZUTW+REiBXcLzOyek7WAt1mtc=;
 b=cY9G9/ow84+CdO8cbzSGVtTdn5jrzK5nXhsJtcYN2zpx8utAC/sthYyCbjGV4v8ASML8OoeDlnVm65tJOgKzyOACwXqQwvO7miiJQ7oJIy/foEctUvRU1FaHLwUNkH8WH7UVHqXBBVbPIStRkALyQUwmmd7u5HW1GWHvun0Xn24KWTMumE1UBG9e7kJxJJ+51vqNRu94CwEiotBOQxbIBeqCWWW2CEC9JXBiG/wmso4yKJ0V3f8HIXt6P7cSvEdxGMTDx/HYBoVikcp/OWg3MPY0lSrvIm4WWhtHSdky/92vA6W6klFy+q7NaP7pt+uGcOe5dMJqIjhkvm6YXhdIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NGr2CwOADCEHDrY6KZUTW+REiBXcLzOyek7WAt1mtc=;
 b=y4RjFvuQHiOSDyFoxUiTolv6W5aisRosL+tJktAi6sZznfdBuaegvPI8kMFwqEGRDBwNCLhk0uryYB/K7pngbmRVCv5DDDjckm7Whl5iOjonmFgRHYyDTAlRs2lGLfkjig9fIcBzuIGZHyj4ubSFmQ7qo++fq19p+rsvB9ZOBdA=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 15:52:36 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%4]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 15:52:36 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: RE: How to pass the EFI_MEMORY_SP type to VM in QEMU
Thread-Topic: How to pass the EFI_MEMORY_SP type to VM in QEMU
Thread-Index: AdssabKydgSiEnpeS2KT2d6BYKpm8ACNZOCAAAxwIvA=
Date: Mon, 4 Nov 2024 15:52:36 +0000
Message-ID: <BL1PR12MB531740B8CB83F8F345011B37F1512@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <BL1PR12MB5317899723624202EDF03FC8F1562@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ujqnswmursutk3l235jv7sn6xo32y2fh2cxdmcqttx4mgfoula@3setckow5or6>
In-Reply-To: <ujqnswmursutk3l235jv7sn6xo32y2fh2cxdmcqttx4mgfoula@3setckow5or6>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8babb93c-f729-49dd-bfe6-33607b939f44;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-04T15:48:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|SN7PR12MB6838:EE_
x-ms-office365-filtering-correlation-id: c09d7c9b-df3c-41ae-8382-08dcfce8b453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yRgenl9Txhm0iS62cMudchXDQodFv3nGTX7oLk3kwX4duNsmy+EvIdIe9/?=
 =?iso-8859-1?Q?E9hEZDlufBAQtT429g/sWQZ2qtHL8Mybj9x7I8NUU6VHMQ8EVycjS23wvd?=
 =?iso-8859-1?Q?H7Iot++tBuX7yMr3ArMOsFoOtcG915Y3M84A5BBppdqHSP6066OfhgG8SS?=
 =?iso-8859-1?Q?DITVgq/n11buAYriWMoFcfgJySBbcsb6ESqZzjbGWE3cGgHLPqDxYILtIm?=
 =?iso-8859-1?Q?nvMs4XiFY/Rts3PVir1jjjGOYQh6OXVxj2nMP9G1u1szt2JxHF6Sx/XcJf?=
 =?iso-8859-1?Q?dFxLUdIQpZeqamm0m14VGh27KL3ZXMcS5ZPaBKvG0Iy4L27vAxOXWnSNOi?=
 =?iso-8859-1?Q?SVPiW4rEZNxLFG7fuXRTugVn0k+1YocWgAQ5noeFlBiOsYoqEzOogTIVWw?=
 =?iso-8859-1?Q?j3VQc2ylYdXVObVJxDiAidk4x3/bRjsf/6WAuMkX0nZaMCpEwoUQyaG5Iz?=
 =?iso-8859-1?Q?H0G6i3gUwvWYepG3W/9PcwI9BP+aNNQLUaVU2HJSbWaTuDd2ugIp9FLCBc?=
 =?iso-8859-1?Q?zxTKBCRhz1u8adOx2odRU1epOcZfldH+Jptst4cywDt4v0CYsYAWYO2Jt+?=
 =?iso-8859-1?Q?Z4ft4Ni7JLU5AfPyMsdXqS3cBbSvIPmcnLwBvOzKpM3xzbnF2LPomLCavl?=
 =?iso-8859-1?Q?c89FxG4/K0I6kNSc4vCpBTa5/0CWKLKROqsGb5FiiEtdnNwoOND2xbNVJF?=
 =?iso-8859-1?Q?go4a1IWzHWvh3gn18rCkVSVV6cO4Q90txgrns9HfC3PrGUe4hf0MArSIXA?=
 =?iso-8859-1?Q?M+guabIJZQ02JFKDhtsVgHtKP7pYQFsAW3pcDzilfMjjElwvcLMa6/t4qW?=
 =?iso-8859-1?Q?DcjRBbuvXLtZ3KueGejKEdxjGYiHPpaYWcQQB8GBhHLyq3KjjM3S9pDO7P?=
 =?iso-8859-1?Q?JB5jnS+uYSNJmA3ZQMJbei/IJFX1mKs5zRC4Rdcg2uFkRWXx+5DExNdut1?=
 =?iso-8859-1?Q?YDEgBdvcB9OaAjUWmXnzgIL8a3EcmwDQZbOJCe0f/lmBwF0Naugj2+eVrY?=
 =?iso-8859-1?Q?hcrnBGon3y6vcLKxSRVwaAqSEIPjYHTUBAwcYWp9Kksj8u2FzhU3O9iu5K?=
 =?iso-8859-1?Q?3lyZQrOalaylESLhVA1pv5l/zPzBAyfJ/kTbMxgE9CNJSmpQ4mFupPOFOA?=
 =?iso-8859-1?Q?1PiL1YiAlGfxduVQoXlVFdprbeLyXgBmhK1vMKE8cTGhzGsZ5aHhqnSoXt?=
 =?iso-8859-1?Q?qmDwlqqXKuJe+zhZBDHV27K//5mWglCfozZYE9kaBEkk1JzTJ3h8re9vcB?=
 =?iso-8859-1?Q?z5EXFyV7Ga4wzdQ23bzGFKTilY4sfKdo1nmwhQPfEYsQO+vwaJz7SsPajz?=
 =?iso-8859-1?Q?fYa0xNT4xoeD/cFgGpB8lBjaJimNkK0m5sIcJhJIHXRxZaGWJj0wyhnVTI?=
 =?iso-8859-1?Q?A7IZPyNFsg+EKT/I1INEEDkb1t2DXnEAWNeYZgk3K0D+weCQlwJws=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0IlOMVOmBL9SqmV0NjJ7NrZI5lUhUnSJboizO4aZSS1TYdnpRQdvTs+Cie?=
 =?iso-8859-1?Q?gnAMnNbpGtrsNdh69jgPQRBixidz68VQShiOloGpwyLb3RhZtWKHbi3R5s?=
 =?iso-8859-1?Q?km61YmsgDYljSbe3sbssIe/BBTie0ThPgLCLsYqN5WszePq4Iue4IYq32C?=
 =?iso-8859-1?Q?b1++8GzZq4e4kmAoMHwJSnVr7Ik05sMOyqEzube7VH28HpfbpS1FZYK+bm?=
 =?iso-8859-1?Q?a/b0IqtcSfo15FYT5TPfV/1x6cDqOIqfx2/pdYw5kFeg8pCZAdfNB0ufpF?=
 =?iso-8859-1?Q?bBlyoByVcvk7IavVGsmOnf+AJ/kNhr/RWH5QcQndjdF3w/Bm8Avw30Ll0a?=
 =?iso-8859-1?Q?f5Y+pdJ1Lj+xUIUVjgEfv+8WAVaIVZuC8n1momFPmqhkWp7k5Dg5ZPHiz0?=
 =?iso-8859-1?Q?nrlbtgC543Bwfqx8nXmphGsLGf6QAQcFABNEAwk6/le6ga9KjBf2zfXej+?=
 =?iso-8859-1?Q?8NjcGDhtzycUeQ6YfUNJvGeD9mlig0hximJR1wAJkNS9hcSwUVG7inYhAr?=
 =?iso-8859-1?Q?sEhfSvoO0GXySaU840TXkdjlklWT9/OrOZ/FcDF+/4JAb/vV3/YpfqThO9?=
 =?iso-8859-1?Q?Okwv4RvuBqwxjI+00E9vVm3LaddlLJutPnA5tO5dcfDfLxb5HDXk6FSdlc?=
 =?iso-8859-1?Q?OlLt3JpKOHk5dwHDOw1JK8t0fgY7V/nvH6SbYME/iDvErw6aQMclI9ahH6?=
 =?iso-8859-1?Q?hXOHWbe08CxInI12KBPsnYBQ1PW1UaG6al7HicyznvYJj04pnfH+T7Hsqr?=
 =?iso-8859-1?Q?kW4sF3EdpD4sdWkGqlQ7N4FSoI4PRPpIwAMDM/dklCMTIRG1AOPz5Dl5vr?=
 =?iso-8859-1?Q?4Sn95iM9KiVCbmPEWt7auRyArqlst7kJx4NiQNedB3DFq3gUSPHL6fyN9+?=
 =?iso-8859-1?Q?ZDixoLOYKVPcU1C288RTM9oDzaMf+2wnBolKtGwAAPywTBoUy5L/voTydZ?=
 =?iso-8859-1?Q?WIG8tCpfo2WMItx1GoHya7yZR3z9rMBKjxcU4Rhypo8ZpHysA+fvi7kuOv?=
 =?iso-8859-1?Q?ITsMNz3TbvcNE1AhKvtYBZg366gjmEhIsgbTIyDFWYCI0/EaSFuPLPILOx?=
 =?iso-8859-1?Q?ll140sVITMeiRQR1EL/fNi1/B6Rvo8TTHzX6GYbDhG1dQIwowp2Dxl9H2g?=
 =?iso-8859-1?Q?cY7gyQPcO3ztM1Z4lC2A8XKXMKjChyM0pKogpYmujZsiqKIiDrXE1TGHHM?=
 =?iso-8859-1?Q?91annv5qc34HIoesl31iS660tQ8rWcinZC+ykCWJI0R+9bKrTc+o1qqCXN?=
 =?iso-8859-1?Q?3kVjKjxCISt0lef1wO18UsCf4HArR2pt92VQhAXs5fb4u+xlAvSEEvHqKD?=
 =?iso-8859-1?Q?1HGQR96yj3N1LGi9q5TjHNKCIQmuWwnoZ/xb8FLycsgTno7Et8sXAE9AcQ?=
 =?iso-8859-1?Q?JKGOzd8Rk8Pz60v8/q0QdMDGp7bE9WICP/R7ab1HFpzuv3IZHzjTl2M2Qw?=
 =?iso-8859-1?Q?99ZiNjLGKKF5tZvt8YsmTgv8+PKtXuZcSKcSam1Kr4eZ9kNrJomPp+Jich?=
 =?iso-8859-1?Q?A6bEIAny+1yCBr8QA0wB8V+1mAaNAF6UAreFgEHgu/Wj+3IgjCxeGuMJYN?=
 =?iso-8859-1?Q?anvMLfnW+oqoBU9TQIefkDhxE7eGXvQWiRKtTT6DFg7+jVFQRaE4Ps6Mb/?=
 =?iso-8859-1?Q?rLQTvaVGoK7zA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d7c9b-df3c-41ae-8382-08dcfce8b453
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 15:52:36.7669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ufq8H6vB0pwb986avGy9yvdQMj5lPCQWre8SaSexH8UMBxCpG6mOGcqym0i+sSas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
Received-SPF: permerror client-ip=40.107.94.44;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Gerd,

Thanks for your response. So, on X86, I need to add a new type in qemu and =
firmware. Is my understanding correct?

Regards,
Zhigang

-----Original Message-----
From: Gerd Hoffmann <kraxel@redhat.com>
Sent: Monday, November 4, 2024 4:53 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>
Cc: qemu-devel@nongnu.org; Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Subject: Re: How to pass the EFI_MEMORY_SP type to VM in QEMU

On Fri, Nov 01, 2024 at 02:45:44PM +0000, Luo, Zhigang wrote:
> Dear QEMU Community,
>
> I hope this message finds everyone well. My name is Zhigang, and I am cur=
rently engaged in a project that requires virtualization capabilities provi=
ded by QEMU. I am reaching out to the community for guidance on a specific =
configuration that I need to implement.
>
> I am looking to pass the EFI_MEMORY_SP (Special Purpose Memory) type memo=
ry from host to a virtual machine within QEMU. This memory needs to be EFI_=
MEMORY_SP type in the virtual machine as well. This particular memory type =
is essential for the functionality of my project, and I have been facing so=
me difficulties in setting it up correctly.
>
> I have reviewed the available documentation and resources, but I have not=
 yet found a clear method to achieve this. I would greatly appreciate it if=
 anyone could provide insights, share their experiences, or direct me to re=
levant documentation or examples that pertain to configuring EFI_MEMORY_SP =
memory type for a VM in QEMU.

The memory map is passed from qemu to firmware using the etc/e820 fw_cfg fi=
le (on x86).  That would be the natural way to this, for example by taking =
a approach simliar to the linux kernel and define a type for this (E820_TYP=
E_SOFT_RESERVED).

On arm / riscv etc. the memory map is passed via device tree from qemu to f=
irmware, so on these platforms the device tree should be used for EFI_MEMOR=
Y_SP too.

take care,
  Gerd


