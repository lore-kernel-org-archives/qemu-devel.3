Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96DFC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHh7m-0006co-69; Thu, 13 Jun 2024 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>)
 id 1sHh7l-0006cJ-5z; Thu, 13 Jun 2024 05:52:05 -0400
Received: from mail-he1eur04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:260f::600]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>)
 id 1sHh7j-0002QB-6l; Thu, 13 Jun 2024 05:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1t3/DkVXt2nwG8lBYTWLedNa7ovl0lg6dyy6W2OvpNlkceqAY6Z5nycT+iy3l6d1yzBXzJHcc/oJt8M1eS1A5b+uyhFsV+A0r0Q3Dfy7E0ji01DF9/bc00fHypJZL/sOlgzxDwBA0Trxxg/n8ghmyQB+PjVa5sQceDXVDcBoYJ44AoQg7du+J5K/8/2g1evqA152XiwuLoCx9Xbmd100J0GpDv+KhSa26grLjuoWLwMXCpeT1Mnw9MjdzX2+SZAHckMSt1VH6NG7WjfsDjpAGMMq51jVu2/MXa624jBeMEN5D3LSkl6BvPxeI8YXS9uB8xfCLWnosXbdvOGvywb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hR3EVxhGR4pgQS5qTSEiArhL5Tih91sCJhY4O7IQ7M=;
 b=BJuBhj2J9ZMRmzt4LgIzngRbLbcZJNFdbupz26OgNkVkfD7niBQ+5b8dL4wBE1jzUTFpzu019lluB0N/BcpjmqjAh3A1rV/bAdvJ6Y/lQSHMEMgtJqiPtwy5LcunuRQpDIuS+k+DarqAGDX3xOm0BtGl6pXEwhzUr12Mf3yFuMDnRyOs6mhVmil5MA3uEEeCrPl+Nz6NvQzj6n3If9/FZT0Ou3HWRSw0UINH/3VG9GiT3OFzMJn0pYfzY+YKruYn7+KmAR/0Msjc0ItbhgsWeWgmZ5pcUvcJgFxgX+U1GqcJyfMAXLayBOPJQ7aofPDkis6BpwQWi17MVuXxH9hr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hR3EVxhGR4pgQS5qTSEiArhL5Tih91sCJhY4O7IQ7M=;
 b=JaeENpHGxpTSiu8Nhw/o3T138/mWF4OqGtYoPJGQUc6/iaakV4gDAdYQMiJsaiYCLibcRXPRcGV/vLQU/taU4U41P6t63Vw3T//CceSFoGdP4+AbimopEiEP+O88rw/VYW+5ZQdTx0jo5N23xESn8w3olwErB1fd0R1Wz0UUbIE=
Received: from DB7PR04MB5948.eurprd04.prod.outlook.com (2603:10a6:10:8b::21)
 by DU4PR04MB10531.eurprd04.prod.outlook.com (2603:10a6:10:55a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 09:51:59 +0000
Received: from DB7PR04MB5948.eurprd04.prod.outlook.com
 ([fe80::c0af:95ea:134a:5cda]) by DB7PR04MB5948.eurprd04.prod.outlook.com
 ([fe80::c0af:95ea:134a:5cda%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 09:51:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: RE: Qemu License question
Thread-Topic: Qemu License question
Thread-Index: Adq9QX7lF9lk8P0xRz+2PWgCJu+f7QADegqAAACQfsUABp52AAAAkD4AAAIyieA=
Date: Thu, 13 Jun 2024 09:51:58 +0000
Message-ID: <DB7PR04MB59488613745D9EFF1EAE007788C12@DB7PR04MB5948.eurprd04.prod.outlook.com>
References: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <f06ai.hy2gx5h8080@linaro.org> <87h6dxct8g.fsf@pond.sub.org>
 <2624ae07-f61d-4c07-9510-ebbd243670a3@redhat.com>
 <ZmqyPje6_9I1YeTT@redhat.com>
In-Reply-To: <ZmqyPje6_9I1YeTT@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5948:EE_|DU4PR04MB10531:EE_
x-ms-office365-filtering-correlation-id: 236b8b0f-bc1d-4b18-4fb0-08dc8b8e7792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Kn72oMGB5tmy3HUh2OIzj3fotG4n7gArqVTiO91B5YfypRvLfWMgt0tcAF?=
 =?iso-8859-1?Q?a+lWLbwvNlMN/4KmYVz9B3k+26k7ctGRkHgphznDR1EM0J51Cl19fyYRx2?=
 =?iso-8859-1?Q?5pAmGscZcZqZXip6rMTY6+8Tmot/QaHbGNeaVLGj18X9tFejibdbuivmkN?=
 =?iso-8859-1?Q?qWHcaY1dbMGk5cvz+jsdi32zJyjomI4O/Kuib8knekZb8ifIs9hYLCcmz7?=
 =?iso-8859-1?Q?Mqa4sJNDrJ5hBkcp+x41AcW6Prc7251JWDItYuNQoosDw7plVX0WZ41+gp?=
 =?iso-8859-1?Q?ZD3cXA8H3Ss4vF1/1brIWf5xLcp/KsCQDhsMYa5MjsPqx+h2uECrF9Uy6a?=
 =?iso-8859-1?Q?C+2a9phBaeuX5CY2wi7fA6f9UzM4YIeShaW6HyRH0el2TdsfGNVSdQtezh?=
 =?iso-8859-1?Q?VDDzrIp8gZMo9VY57wdpFx8tZ15hzs6r7otArfJb7tOnk3NBujzJswjKNT?=
 =?iso-8859-1?Q?OJ2qwKqfzs7ZNt1tayLVOrHpY0ngJ6H1/WUnUQxw1METU75aOIs5qXhnGf?=
 =?iso-8859-1?Q?qNg8SzZLeTfMgysslDy/e6Inhw/7FM3DvO7SC+czQdcIPLECQq/Ee0i/Yq?=
 =?iso-8859-1?Q?K+BuYcs7mJMi7g02mhL3Za60fjuD7GiXYXry6ogj5+m2wWLLpaLZnx5Rfz?=
 =?iso-8859-1?Q?eeJ784r8U2zfK/wCDmkCRvsgUQgVzNu7tBETrGcHX2wvZLgzz7syMTUgVv?=
 =?iso-8859-1?Q?pL2tg6gWw5WjBbD+hCeRjuWnFiGoPSSEXMimbf2UzzksCL/wLONbzplwNK?=
 =?iso-8859-1?Q?4rOFIJGv4yESKDJShKfoiBuLBOCHuLayH0vSaGzOcvuiaCIjtWb3XgmaNq?=
 =?iso-8859-1?Q?oxaVLW4fhlTUfkEiQWWgPTgcUhxns4LMwFrc5oP7nARJI28+89i5TgEpqF?=
 =?iso-8859-1?Q?wZVjVWcUU8e7RFo4iZmbAgqoUZIUxTc6r1HQGSCDVZAovnOaFvDdk2oQ4r?=
 =?iso-8859-1?Q?VBUt+40wOU0CHHya23XuZODyLPhlCd6iuBrHuqLPUWITf+TwVHgAXBYCVB?=
 =?iso-8859-1?Q?CLtuSc6FiwppnUTXyPkFkVFcFoYOk+OQlHZ7wlinJyeeGvMKlye2rHXWSR?=
 =?iso-8859-1?Q?J8g4iKUiAmaGpbg/X1yWzFCa6FFBykn5fG09mBALL1kDduGKFmCj2hemWb?=
 =?iso-8859-1?Q?DseIGYLIN9d5lF+5TFpKhJPNKc+Jdd+I2qabvK5LDduxQHCffLFnyxtK2z?=
 =?iso-8859-1?Q?XR3V6CQi0Wv/LrQ3wxDpX0sGJyDoF1wE53UqFmVcH6BxWO60QcJdegqeZZ?=
 =?iso-8859-1?Q?xOg6d2dJ4m6zRwUbVa429FoaliRJwW1x+TsedIHzHwSbzzDdW4c0ju6uz4?=
 =?iso-8859-1?Q?9IHA/vZlgxgUVnv+gFKzvXqPE63PSEJOPddqkcTeV8lAjtXmwVxcLnHr2E?=
 =?iso-8859-1?Q?n1qGrWFIa3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB5948.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(366010)(376008)(1800799018)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w6o7NXwh51RknwtILLpo7bEyY1DAIrcoalmXn2KOLIGrU8Lhe8IltuSyAF?=
 =?iso-8859-1?Q?oSKxOzJd5D8kyerIYXKICbi6O3OVhOCEAdiEMUTb5sb7ss9NuC9FJhl0od?=
 =?iso-8859-1?Q?HV0ozsm1fSLzIRIjta/TJmLCyYTGtIW0LbRS9LCYi4Vaqkh7FX7uAq6s7m?=
 =?iso-8859-1?Q?Oaty3N5gfJ9F9yYzrhxIT0yE9uzqKK4Se4lhmADP2xi0N5M3CbR03Q81Mc?=
 =?iso-8859-1?Q?gI+WW+GOaxIDnwAGuqQUmIF5S4E36kAmhjeTOP81gudCFDl7oOCK8u9kXc?=
 =?iso-8859-1?Q?zJKODK3/O6Cjb08ODsXU73VB1uv2Q3O0HuKUMgAxzcCQtLjJi9Wh7f0XQ2?=
 =?iso-8859-1?Q?sB92phhmhq3EtVWXBqFRHIZDY6bf6qF16sApY8oy41fozSx01OL2FTYBbf?=
 =?iso-8859-1?Q?2MckLBt+Exdi6Nca4XPTiYNXMgf4CmHL9NIKovVnfJPNBCiq8ZRTYAbx4O?=
 =?iso-8859-1?Q?HNzA9v6lHfbfF9RbVRvus5ryVAmf+qaIE4oBRmw5YZWQKLA9oCrfOPxFtC?=
 =?iso-8859-1?Q?8VK8Cxe9xbx/KSc8fDNS/Hr7carlm0LlG+qkJJmzOtGABiPlgreSwU7qBq?=
 =?iso-8859-1?Q?1bLf5EI8YaFBtuKiSXaL5sTxMvLnV9c1DhLf0/bJ2UX7fwxXjRRDETxUCM?=
 =?iso-8859-1?Q?/QF5rE8BqSsx6ZeWqHtXFoIJIbfSd3kDHEgJnwyRvaLCTjYEmkV6Vo741P?=
 =?iso-8859-1?Q?kOsCl/NneAmichLwBvP6nM3ncr4EAM/fiLNmjz18IJRLicsxn/z4z8cOWY?=
 =?iso-8859-1?Q?C+7FBnWJgcefLWAy+nnUKUsRJmYszWtgH/dbcRdDH96Lab9JFX3D6x/tcp?=
 =?iso-8859-1?Q?prZnQhJwHfvh0Dhp6NCc8NbZwvj8E+s3pBxrhN0+l2qZyCZpPP0OnGcdVY?=
 =?iso-8859-1?Q?9MeVFWskMXWhBDbxpD0BVmqe5YHFirspqZg/XNiHL8n6ieZqxWeS72itDo?=
 =?iso-8859-1?Q?PeSvxyg0XezI5xbHjXPlTIttY6cHnwM9vm+S9ymPJ5+rkM3dgOtdTXqtxV?=
 =?iso-8859-1?Q?58+OsS5cbh+g+7xcKJTLxxKS7T24zASk6j1rm4+VcefAseEVdk6rsOa+vL?=
 =?iso-8859-1?Q?XG10mTSImVorfhvAxLIlaZn4/L/LPmqs4zMObBsdVo0m8SLvF1Pd4SocXA?=
 =?iso-8859-1?Q?spjz/YoQ8Q0pZGi+184bHZqSqqIG5FnAUg1CczJYCN7CrnAyUNpKo0LnT+?=
 =?iso-8859-1?Q?ZgpTw//OLNl0AwtSy4Y5cLrtA+5jjnQGXHZgVvq6xgM4sfyIzrchjnWlCw?=
 =?iso-8859-1?Q?R/ieSs4n8JWOQfHU2Knw+KqUn9JUjS6IvSiMj6NbW3a5SiEe0hxsAJCajn?=
 =?iso-8859-1?Q?W+9eEpkL4qwOJrgE4UR23ETtgAxo9HlZIAIEBCrZAdeAdta/ze3NbFvdxZ?=
 =?iso-8859-1?Q?a8s9GRyhxtJ159oMHdVndAh0IUfUiKYgVhw+S+wTH22YUKnhnXG1ci5KhB?=
 =?iso-8859-1?Q?wtmxgiNBaC3JGdncOs8kCtFWFip6XGwv4+5l/RHyPx2+cFhtwJGwprt+gR?=
 =?iso-8859-1?Q?7LYLiJvhgK5h0XT1cryHzzVB/nm8aIx6uxfM9RxnLWRsFFtSgPSNeYvGiU?=
 =?iso-8859-1?Q?7vUaaXVqzIpBDliQcAZzrckXx7HJMsgbAfBPoJprIOVXKsSiwMj8RzRPLF?=
 =?iso-8859-1?Q?H7ehoL2MPET3E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236b8b0f-bc1d-4b18-4fb0-08dc8b8e7792
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:51:58.7091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUDmtjlJPlEfSyD7qL1a6qs6fGye1h/cZg4lZx3cqxZzej78r6AC8jxnNrjg0/bzWCatQrnBUUZVBVygKXi1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10531
Received-SPF: permerror client-ip=2a01:111:f403:260f::600;
 envelope-from=peng.fan@nxp.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

All,

> Subject: Re: Qemu License question
>
>
> IMHO this is largely a non-issue from a licensing compatibility POV, and =
thus
> not neccessary for stable.
>
> This is self-contained test code that, IIUC, is not linking to the bits o=
f QEMU
> that are GPLv-2-only, so is valid to have any license. GPL-2.0+ is just "=
nice to
> have" for consistency of the codebase.

Thanks for clarification. So it is fine to keep as it is.

Thanks,
Peng.

>
>
> With regards,
> Daniel
> --
> |:
> https://berran/
> ge.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C2e14613ddb004d3
> df0ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638538652961675235%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3Dv6sctb73jXj9Fs%2BKkIRaBMATHX%2FrT8ZFiShWDAguYIs%3D&re
> served=3D0      -o-
> https://www.f/
> lickr.com%2Fphotos%2Fdberrange&data=3D05%7C02%7Cpeng.fan%40nxp.com
> %7C2e14613ddb004d3df0ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638538652961684479%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C0%7C%7C%7C&sdata=3DL5m4fucqhtzi2r3curbSR9OTY8cKu5ALciS%2
> BUmxJBRg%3D&reserved=3D0 :|
> |:
> https://libvirt/.
> org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C2e14613ddb004d3df0
> ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38538652961689321%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> &sdata=3DgNx8JVBD0Hopl%2B6qIrOhOQtfZW2PC0QJpzRW8u42K3U%3D&reser
> ved=3D0         -o-
> https://fstop1/
> 38.berrange.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C2e14613
> ddb004d3df0ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638538652961693870%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3Ded01aWLeV8f2Hg5gRrxUE2GjuBYiFtmhfNDvNQeT20g%
> 3D&reserved=3D0 :|
> |:
> https://entan/
> gle-
> photo.org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C2e14613ddb004
> d3df0ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638538652961698472%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3DW%2B8XurlQlElHGZrX5UhMT7Ep46hVa28MNuqzspviBSs%3D&re
> served=3D0    -o-
> https://www.i/
> nstagram.com%2Fdberrange&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C2
> e14613ddb004d3df0ed08dc8b858f71%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638538652961703289%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C0%7C%7C%7C&sdata=3D5qza2JAiHmt%2FgPkoDWp4j%2B4LSi9HCWNX
> VORGviICTMg%3D&reserved=3D0 :|


