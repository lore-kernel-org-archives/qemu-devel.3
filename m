Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406E4E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzRV-0003lQ-Fg; Wed, 18 Dec 2024 14:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNzRM-0003Yw-ST
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:10:37 -0500
Received: from mail-db8eur05on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2614::625]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNzRK-0007Av-Lz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:10:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfFCkNfnH0z/zNHoeT27hEDN8Fvc+zbrZWYytCxg3tdlfrvP5HnMeXc8zbjnE4E29IiWAifa7qD5VkD5l+FlHVV5YPNux5wOnX28dQnP7/2hqVptIYdvw2fX3t2GMAoCY9C5md2IrgkLLi7M9Y87JVqytMQS0PDgyt1IgA7FnI2mP7/t1UTgngn89BK89TasKc41gy/ITzBtHHxEL0cz0CyqSc3Ay8kXEIFi6NViEO+GOMeZYTAatvam1/VJNbeYnv+PkEVSeILtp8q6OfU7CnrBLaSbrTlPz30ludsrIPgBB1d+AJvgpI2f2cgq0nqVHDRQGnWeFHHUJ0nVvJZqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxU/50OEZTYR7opEjV6T/HWzpdRQMN0+Lf7EuTKS5LM=;
 b=ukbJVBmLifA//IbM3b86Ngt9RRHuMqG291dnKbfT8oCR+uskwotxEIQ1Y09A5FOE9iNBTlIvtFTpVHgb/oq6LoayLtW3EMRSPQ2bqzYBVCOkMfmG6YZyKjXXHvnkGhjVRQaEf1sZtmrPwBANJ63l98SJ30et4tgoqhRIo9l22LWOGAQPpQ7HF4rGBNZHPiGjrTM3lg1OaHtlFV4a7wuVJW1E5zD98NGZh2nuty6+9ZD+07HqJhun4Itj/CL/1CPTHjCF7Pqs1xfH5qplQmZIXTwo669xY4EB/iD0JHm3x6IhpJpvSVZYaTMkPBPTv6fEL2xllJQnHq1O+zcoqyF23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxU/50OEZTYR7opEjV6T/HWzpdRQMN0+Lf7EuTKS5LM=;
 b=xmXILaNJEPvhn/Yh+iJ1VZVb5ydP/fsQi5Ix86Yq9kIH6GQt7RujhJZKZE6XbbjYt/rjAqVPsz3UjWEsLSLNOGj/EkGcLpu/qKiXQkfd0RGbRNp2Jt4tctUYIyGlCEXpNRqLLNOl5OdhMvLUO3VDj79Q9QBatw27lblgsoQIpBrXPVWTOR6YQZMDa2FpSZLpr6huHKSvZBv0DQghykDWe8SZMNxwamIyJzix7QhT+5W9CY09B5CV644SowYdIYcxSXdbuw3i04g6PmVOZ6I0UGIUyFIddaCggSn4Hu6m0feggdzZhP0VfDDACWJuCsGrapLVHyExJgnra3eUzFEVpA==
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com (2603:10a6:10:274::6)
 by AS1PR07MB8879.eurprd07.prod.outlook.com (2603:10a6:20b:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 19:10:31 +0000
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3]) by DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 19:10:31 +0000
From: Markus Lavin <markus.lavin@ericsson.com>
To: John Levon <levon@movementarian.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Use of BQL from thread in PCIe device
Thread-Topic: Use of BQL from thread in PCIe device
Thread-Index: AQHbUWT1ESgMkIDn00u5tBZba8frk7LsQacAgAAabkw=
Date: Wed, 18 Dec 2024 19:10:31 +0000
Message-ID: <DU2PR07MB8179C2AC676CF8B8DFECD00AE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
References: <DU2PR07MB8179DBDD123A4615CBD1688EE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
 <Z2MGMM56+HzQ/ehS@movementarian.org>
In-Reply-To: <Z2MGMM56+HzQ/ehS@movementarian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR07MB8179:EE_|AS1PR07MB8879:EE_
x-ms-office365-filtering-correlation-id: 79b98abc-5bd8-4b5b-6913-08dd1f97a440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cqOR/CIV2SZVkNXHCSzZ8I4eWW/KPD8ihWNbfZK/oWLW56/vWfoAh0HSsk?=
 =?iso-8859-1?Q?GtmlunPwYuoUgkkdicI4IftslESQrXswuD3zgwoZWLHnyZhpt+r5EmheZf?=
 =?iso-8859-1?Q?yHRXs2d2NdqERFKv+L9SBwAmTl9GUtd+ubXw/E8kVJ7I/CUFZK2qUb7HYA?=
 =?iso-8859-1?Q?bmvp2+j+DOrOHa9+VP2dvMluAU1b/UH/4sdtLYGJQj+Zew1XtClPtLA0Ag?=
 =?iso-8859-1?Q?d4P1rtmTYWBV0qzzsivW6M/GgDhwCxDQsdo+urmbXIJjRrMMnkNENe1qpY?=
 =?iso-8859-1?Q?+dJC+l6NNI8tLe4pNEZVwyGyYEpjWPyNmCf3PMMZ7HlfCkvv93U60c7u6H?=
 =?iso-8859-1?Q?FviaMT0oI+wqHc2sC8ip14MEZOQrER8nvbuDQQnoyLxkFQUUB3hHHHPMNd?=
 =?iso-8859-1?Q?Yz8fDVIuAhGt4AT15NGSLq8jC/5iN2o++EXerGCB2PODRFOn73UzM23y3w?=
 =?iso-8859-1?Q?uUYxGgQhSDpo8Izid0ucHFF7T/nmxRPAfHN6W62jjBhG78INc7idfGSWQx?=
 =?iso-8859-1?Q?IOeNdvOlzlPbMvTDnJ1JaZqvszG3nuDBxsLtG9YvIEmAmzz83Y2+4qYpvl?=
 =?iso-8859-1?Q?cmwGroVoLFJhWtg/EZeeRaPjAg8k8h6CZ1ErxHWPLZOKTyVap+Z1YvssV6?=
 =?iso-8859-1?Q?sZvm+eT9efgOP0x0iFCl9MoikDd6+/aKxAdkeKbT0j0B8n3WgufpXVY+tR?=
 =?iso-8859-1?Q?oHTERNaUYHYhEWGqWObeXfC4INBiuSU8h2A4TUR4DWf6YvPGpMFXeXRjY1?=
 =?iso-8859-1?Q?JUwr2OJhPNaqtwc641wMWx0CafMZNWXb7PxhldSZh8DhkzTu/s3gy+OmTD?=
 =?iso-8859-1?Q?JTphKW/obX+yV1wHzL4EJj5W3+OhTB2ubn4PM5qi8J8TvlVk5wEWS1l90X?=
 =?iso-8859-1?Q?LVjqbHyoIhwtAF8P1lD1z0ZNwDTKWaVNX8ZRyTwd91L8EMDyKDZVs8LtiA?=
 =?iso-8859-1?Q?YJAJMS/jV+2FO1GRuRiWtZzm6gXOiUFPSB8mIZ0JQOeYLB1yOQbwq4Le3W?=
 =?iso-8859-1?Q?xcFe6ipJ43Z2Hc4WZjcEoa0sLvVr2YCTnnPXS3qqnk2FITrJYmnPJcQX4m?=
 =?iso-8859-1?Q?VyYXqIFicgj65f4nTkyYTopvlNwG6IM19qmRxW/9HOodAzJzyQydFN9ZKK?=
 =?iso-8859-1?Q?x8KrtXRo5XMCKWCVJX7OrPvk95/DVty2lYUBPk/dyl/iLuLLynY+W/DhJF?=
 =?iso-8859-1?Q?jQKfZWN2+dI5PXMZI9p6sjk+9LAu0dUBQGg7awmTFKDNLJefaWWEd1UlnO?=
 =?iso-8859-1?Q?zI27G9G8ROBBnSsudMKr47tqW6eUnxuBaDBMvzT35ny3HsbIvehzvJa9IZ?=
 =?iso-8859-1?Q?WQKryU1eEtBZqrxx3HgRYaNtrRqbjcnmM6mdA9kG6VwjJwoNI9QdMhmyGt?=
 =?iso-8859-1?Q?DcQg8J6MYPi8Y9eSnJq+K5lTqDvU9KmgF98dt9LdM1EkUC0WEUVN+GbDRz?=
 =?iso-8859-1?Q?43hZwqgSBNM/ENeB2PScqNVwy80XbsN+RFjU+llsCgUHdYlDSmzdSr4QcT?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR07MB8179.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RAxf9Z+10HwKaouMIHqFCeJbgYjFk9WsrXoQDOCrpFgozWxYrv2rTXcReq?=
 =?iso-8859-1?Q?VVvk75VNYiK4lp0FkNUAyNqDi6imYVBxEoxxuEbSfntyD51R6WCAsDRQHA?=
 =?iso-8859-1?Q?tjDWDiNIk0fKGekms6i/4GHaOewnTXkIryaPf7RDIxjGHxlolyQhrl0t5a?=
 =?iso-8859-1?Q?+TVSoelf+pxTTj5fTT3PFIiCzgYsSV0fNkRMVFxII3ZTz1kLq5m29SvsIG?=
 =?iso-8859-1?Q?mYOAlaDImWslyIKiBKcmMyI/5wwqgUZP0sPmz2eL0+hlDB1PMnIrBgOJQa?=
 =?iso-8859-1?Q?y7UmUWc/PulMYGyGkuiLCIrZ2nwmWY8v0m7Vl7ywzVJyhNqMtl1HHxfNCL?=
 =?iso-8859-1?Q?MmSSMokMOjvDv1Epfutyu6x5ocki2sEfjFsYEuoHc3Vn/Rmo0uL03iPT3d?=
 =?iso-8859-1?Q?iHaFxPM3L1n26TFJmE2owJ9K7uT6KceBCJYSkWUMGoebcqpoeg1W4cq0Iv?=
 =?iso-8859-1?Q?RDVdLIphK8OL1bFPeK7T33BZIamH2iiao+1bi7+TpgFzzrepqcwT2x2ScT?=
 =?iso-8859-1?Q?evQQfuDs7U6KkjAIV9t26Yced/a2716E/EgHjbFK8zSG74UK/atxEuZuTo?=
 =?iso-8859-1?Q?1GOAsVWvehQRBqb03BnYj3jrY7ZRYqtSKRVoIaNwre+fyhFdWJ3E/c4+vO?=
 =?iso-8859-1?Q?8XpmXUunu6OeRvBUcxa2Lz9u8TlZaDFqvsljIrPtLpyqvdHvGj481PQMMl?=
 =?iso-8859-1?Q?rp7HJno60qpV8VWTAe2VnxTOI8J491v9dseFWykWhvwh3vOWMwd7pdRXYL?=
 =?iso-8859-1?Q?J5XF8OyC1kEeTwgarMBudioHwH2ub5BMf/wbN7pOQ1fgz0Zr9e3cZU6WfA?=
 =?iso-8859-1?Q?KMy2nRdOz78pK5HT/ygVUdXrQuPjHwz+1zzqXizUPe9lL3l4qkazup3FW7?=
 =?iso-8859-1?Q?hzWxFS3mPFGA7TN3M50boF49ZjhQ9Ci/KvwDSPNWvQ/hrK1kUOW4CV1BIS?=
 =?iso-8859-1?Q?iH6omUnbOChKAPwhuCuN4K5HgG/AXIpa3duiE9fvrpzEKVYd89+/8PkD2r?=
 =?iso-8859-1?Q?nM/xZLLTEvf0Z/oEztzU0aoW8Z8HIFcq7MapBoBlbDJv2htwNudkCZzBpA?=
 =?iso-8859-1?Q?5OouMwuhWyII4f6pWRUvrePPJ56KjWuevPtlTucDn3PoBXwv+RkbMIpEvX?=
 =?iso-8859-1?Q?4GfD7N8WqHunOgIlpmNGqLs2NE8GNbx7tl+AICafPAYUi5W+BDe1Z3m6Ym?=
 =?iso-8859-1?Q?QvsbSvQpFM/THIE0FjDWgtpcKUNWe9fZs9K0+me+ANN/+ppbJQclIjRY40?=
 =?iso-8859-1?Q?I1CHdVvBlxsmzIPpTkelsTXIeNQ48EZqayTZ1Rp7tNBwjf/lMI1RhK5HDP?=
 =?iso-8859-1?Q?gvmg66MLFGMfsfifNzciM4P3u23g7DHUtwfLR69CqAGS80Z4nSisArGOlu?=
 =?iso-8859-1?Q?bHAcGrN4f92f47xqnDPFmqhDQqjfJDDm8CXSdLkiwRtRVFAc+ohDiopFgp?=
 =?iso-8859-1?Q?4CVU3zZoMGxE0OYXPSwjF75SmGYJxZZtwegrPbqBdJBYCVs41d/p5zDme7?=
 =?iso-8859-1?Q?ZgzcSek93qcFiMGY21PyCnL/NNUyp5zwAy0dZTGY11NG/4zPtlA5NYgjWl?=
 =?iso-8859-1?Q?i5BBzAdP3T+ZKQNCfgmw64Bu9J6qyzzg8FnkVVXAiukDSGPvgFzQIvSMAc?=
 =?iso-8859-1?Q?YLWUVgKCgv3sXIiLXEev8l+EXOo/Z51+q9?=
Content-Type: multipart/alternative;
 boundary="_000_DU2PR07MB8179C2AC676CF8B8DFECD00AE8052DU2PR07MB8179eurp_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8179.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b98abc-5bd8-4b5b-6913-08dd1f97a440
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 19:10:31.2228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukqi1v/ye07BRiL5w7Z4i9Lrnr0+VaO3HPVIL77/9J93jqxbEIOxh+4CkgxYuVU9HgMezS8hsOwz89/O+d2MJIMlBXcn2zvcQMWy+PAhgfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8879
Received-SPF: pass client-ip=2a01:111:f403:2614::625;
 envelope-from=markus.lavin@ericsson.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--_000_DU2PR07MB8179C2AC676CF8B8DFECD00AE8052DU2PR07MB8179eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry but I don't quite follow. Which callbacks are we talking about?
Are you saying that it is fine to call pci_dma_read/pci_dma_write/msix_noti=
fy from a thread without acquiring any particular lock in advance?

Thanks,
Markus

________________________________
From: John Levon <levon@movementarian.org>
Sent: Wednesday, December 18, 2024 6:28 PM
To: Markus Lavin <markus.lavin@ericsson.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: Use of BQL from thread in PCIe device

[You don't often get email from levon@movementarian.org. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]

On Wed, Dec 18, 2024 at 04:19:47PM +0000, Markus Lavin wrote:

> Hi,
>
> I think that I might have misunderstood something fundamental about the B=
QL
> (or possibly Qemu in general).
>
> I have a custom PCIe device that connects to an outside simulation enviro=
nment
> using Unix domain sockets. To deal with bus-mastering from this outside
> environment I have a thread created with qemu_thread_create listening to =
the
> socket.
>
> If I get a read/write/interrupt request over the socket then the thread s=
hould
> perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called fr=
om
> the threads context I assumed I should first grab the BQL. Issuing a bql_=
lock
> from the thread however hangs Qemu.
>
> Is my thinking flawed?

The BQL will be already taken for these callbacks higher up in the stack I =
believe.

regards
john

--_000_DU2PR07MB8179C2AC676CF8B8DFECD00AE8052DU2PR07MB8179eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry but I don't quite follow. Which callbacks are we talking about?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Are you saying that it is fine to call pci_dma_read/pci_dma_write/msix_noti=
fy from a thread without acquiring any particular lock in advance?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Markus&nbsp;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;John L=
evon &lt;levon@movementarian.org&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, December 18, 2024 6:28 PM<br>
<b>To:</b>&nbsp;Markus Lavin &lt;markus.lavin@ericsson.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b>&nbsp;Re: Use of BQL from thread in PCIe device</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">[You don't often g=
et email from levon@movementarian.org. Learn why this is important at
<a href=3D"https://aka.ms/LearnAboutSenderIdentification" id=3D"OWAf660a6b0=
-c4e1-1d4d-287d-60143ed4e541" class=3D"OWAAutoLink" data-auth=3D"NotApplica=
ble">
https://aka.ms/LearnAboutSenderIdentification</a>&nbsp;]<br>
<br>
On Wed, Dec 18, 2024 at 04:19:47PM +0000, Markus Lavin wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; I think that I might have misunderstood something fundamental about th=
e BQL<br>
&gt; (or possibly Qemu in general).<br>
&gt;<br>
&gt; I have a custom PCIe device that connects to an outside simulation env=
ironment<br>
&gt; using Unix domain sockets. To deal with bus-mastering from this outsid=
e<br>
&gt; environment I have a thread created with qemu_thread_create listening =
to the<br>
&gt; socket.<br>
&gt;<br>
&gt; If I get a read/write/interrupt request over the socket then the threa=
d should<br>
&gt; perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called=
 from<br>
&gt; the threads context I assumed I should first grab the BQL. Issuing a b=
ql_lock<br>
&gt; from the thread however hangs Qemu.<br>
&gt;<br>
&gt; Is my thinking flawed?<br>
<br>
The BQL will be already taken for these callbacks higher up in the stack I =
believe.<br>
<br>
regards<br>
john</div>
</body>
</html>

--_000_DU2PR07MB8179C2AC676CF8B8DFECD00AE8052DU2PR07MB8179eurp_--

