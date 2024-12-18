Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD109E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx99-0002sO-Cb; Wed, 18 Dec 2024 11:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNx95-0002po-Rx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:43:36 -0500
Received: from mail-db8eur05on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2614::620]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNx90-0005Le-5r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:43:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqnLr2xYcrL44NS+nLLHCXXEdVmrFYALqnmgAZcEOVW32OVCCjqODGSE8Xw72QMRtdSF+zQdaAL8KcU0Ad8uSuFAq9ICU32y2H6/3m/1QfVDvUNtecio7l/Ru/N9rsb0thVlmD7YETRj+JHWCKqzDdPZAJqHIAeN1QrCAlPaOC1g1AYT9LSi1vna18H0O0sY2GGtRKpR5UdzeIPo1iGmyMZbZNpkQRVwsvIjZ1V8m8bZxMMDbVDYnuhxbioJ/iyW8XZ1gROpnXbYap7zy8OTvlSz9Itq/b+hDUezSD4enSduLr4aPFWaYrZvGlDK5WTLzeSYbom4l/8fdjwZg2ZIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJThzpV2vm2hYerznfU2Db8ajKVT4MPbuYDQPWwa0xk=;
 b=P9NP/dJNp3AKqR6s4jbqPoDIhB4/FmzWbRvQ/hNAx0wW7uzcC65lmLnjBIw8WVUaIJOb3Nz3FiNAn08bboBTJLM4x60rrnj0U3SxLFc9Tpy2FSov54SgxX1Q5S+qiMccTuPhNrgzB33HH+LY6O/Grd15SwbM3kTTzFK8zA5hx8KI+4DFAET7/D1rcWfMvs8BkjaK22/+DusGT5TiUVGCF4BFIiPkwRgx/50m0QJBu8BWjpjjUiS1iqoWCEqJInDDoXOYZN6vu5Nz4/+bEmnwPEucFB6gAAZrpFaxnqgAX8n4/3XXlgwBY5Je1u4sSiD+aXP0g7tZl2iuXBkxQ0JDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJThzpV2vm2hYerznfU2Db8ajKVT4MPbuYDQPWwa0xk=;
 b=mkjgnF33SdaNZtPLdCmcACU8mWYImIsSILmtfnmzHx56k8ppSvD4+Ik0MPWUJvXacskMj9ET6sOmE1/ZZIl0cJXblV74X1Mt6tFzdi/3H8QRF3s8s2tdvs/TiYei8qtchlw5iE+Sr8x8JUHi30eUGrtwhlhSwA9nzYvt8zsUTtpJlh7Gk0HoZhSQUof1XJRlGoG8PKQfQPZMkTWIHy4ecWeHyaBvkAi2RJZOppID2x+0deLozKVyjc+kiZbWYzBXJYcYzfW2YyZn6skWDvH9fuRDtIgrLpwypY9TtUnbrmiS/mic9Mt6KmY2ijbYpxrId8nd+yA3WE9LhSOy6CSuAg==
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com (2603:10a6:10:274::6)
 by AM7PR07MB6261.eurprd07.prod.outlook.com (2603:10a6:20b:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 16:19:48 +0000
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3]) by DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 16:19:47 +0000
From: Markus Lavin <markus.lavin@ericsson.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Use of BQL from thread in PCIe device
Thread-Topic: Use of BQL from thread in PCIe device
Thread-Index: AQHbUWT1ESgMkIDn00u5tBZba8frkw==
Date: Wed, 18 Dec 2024 16:19:47 +0000
Message-ID: <DU2PR07MB8179DBDD123A4615CBD1688EE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR07MB8179:EE_|AM7PR07MB6261:EE_
x-ms-office365-filtering-correlation-id: d4a37af9-f4ca-451d-fed1-08dd1f7fcabe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cylZWJJ7q96h8nRTAmCw7zk1/GGSj5JsQO59I83P9pRGhaDYHuX7vGFf2t?=
 =?iso-8859-1?Q?ytXx2wRG88Kj9gyeYoQ1rBgIz7JaR+GTsN0fV3OVvfvOmrWKJRL5fttXkP?=
 =?iso-8859-1?Q?KeC7bD5Iy/vlQqbT4RiSJO6VCgeDsmBX6q32rmk3g51v9R7OXeth/NESO2?=
 =?iso-8859-1?Q?CwDJyFcDvOtpFuu2IlmctLZyFIKXLWr5qfm04max66iBoGSloSZYdW0kre?=
 =?iso-8859-1?Q?1rdnM5/hPdgf/3E4XN8SJGNgtaC1y1T6iV/r8xKeTQ53JGA7p1wLTAJlrR?=
 =?iso-8859-1?Q?zatJUFcUJxCCibSM5MMb3aPprohCE4b8HL3XQu04ogeRCckyj2JMos3U/t?=
 =?iso-8859-1?Q?9cc/GKTrJbZOPpCCTMJflfOMQv2PthKv3cFT8XLohtIHwhUlKNN9MP0zHX?=
 =?iso-8859-1?Q?nipYJxm2Fmj9QVbsnSHuMONX6aAP7X9778RFkm6rkNECZoFUhub3454KFI?=
 =?iso-8859-1?Q?B/qY04o2eyufjwNQSNyDaT4bFUIP9JO1SJ8tm1zq6WAvmfhKDoxmX4dLlU?=
 =?iso-8859-1?Q?qluOk134SHFVndbuFi6o0eRFL2GTBHNDMljR1KSfpCFm4VsqeDId+AZiN9?=
 =?iso-8859-1?Q?Sw4LIn1RdLnaB6+Hewnz7wOH8xLIwywxWDp+pfvVQ1lDRnHK0t8dlfCvSe?=
 =?iso-8859-1?Q?V7KBkgpVHnAMaNSegC5NgnJZHL933RsibyAgP44FQmoxjT4S4WOPC+e6Wy?=
 =?iso-8859-1?Q?/ajyJw3Ukct92VTKPGzEygRxHZL4OxUWJdbufQaGuCPKqXcw0JsFqrBXub?=
 =?iso-8859-1?Q?8a874+wp9Kd2JDNZVw84+c1JaiIqoeVCWYXkqAnnO1B0QKyqOdy9bcuHoh?=
 =?iso-8859-1?Q?QY0DfyRggsRQ4knRvZbYvcKlLwNEdvmrrzcCvYq3MM9hRg5wKNu2H+OCMA?=
 =?iso-8859-1?Q?08Zr8WOlWKCuaq9GQ+4LPc21g0PVz2jdOYGvsgYjYISunnn680jOOpDHtO?=
 =?iso-8859-1?Q?GccaosiXZdp/vjcMo9sYJrReJSJfDRI8XFzZEyEdTHVPRX9aiOOC+ZkxCw?=
 =?iso-8859-1?Q?mRxLUPBes1cDcsYqCxtSp59tBOLmpK+aKIb6vC5XyTHuSKfi7bdWxH4JbP?=
 =?iso-8859-1?Q?HUwyXXZRtSipf6uKIZSAeMESZlBlJ1RZMWjXlGA4OqynUlaVkUyZQqHzAH?=
 =?iso-8859-1?Q?GQwXUYHner+FECeEV6RHU7nW2cYUomVcwTY4TVmExsxKdfBDX2FiOK4XnZ?=
 =?iso-8859-1?Q?Cd9eeS3OFUToaKEdJIV6WPBVHhbQgmLqnkj6J7YVR8RjxlYtoo9vWoE2Am?=
 =?iso-8859-1?Q?FRLyYR33EY2+USs088bC9V879pY2iID03XDC80IizrcilfMpxTU4xBfGAL?=
 =?iso-8859-1?Q?59aY/kYn5HQGAMS8+a8Ni7lk2VFIDe4Km3JHGw5/7QSwr2z+ELT7XhVa4G?=
 =?iso-8859-1?Q?vChXHiSpYPF2BktooYRiAw9PRUKV0QjuyYFHeB1x6GfWCeXYKzE+/4aVZO?=
 =?iso-8859-1?Q?XsyH+a0Q5JV2HFuuteKDFSR2HAg1keEendAu+XYBkDfE4PYA9i24V5PY1t?=
 =?iso-8859-1?Q?neH80tz4ylBGwlPNRKe2yi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR07MB8179.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ShBGMo6GSbljrgEwNBxN9HIQEYUt52uKfDegq/w8VDK0kdl/fQjwY1RGen?=
 =?iso-8859-1?Q?Tc8v/3MjUnf3H+R1Kj0SIiVQW3dhCsirec30XgBu25WlSkUhsTfnq08598?=
 =?iso-8859-1?Q?X0CkSyPvbxFYoSAvDiXw+LDX0McuTHtFQ7pE0TYLcTm/mrnDr0rE7VPFWS?=
 =?iso-8859-1?Q?k4zftwg3n9bJQu0RP/mWU58C4WWSgvdSEpBh1dmmqTpvBI74/fIbXXgaAm?=
 =?iso-8859-1?Q?D/ueC86bSmdBlGWMgffcFQfyB2gztad6kcgLlqp5fDajiqAqMOe34BYgoq?=
 =?iso-8859-1?Q?0eh7bxltSplfdnNWkUuC71e+pVaw8lC1vnaWp/GklgJJVFFM4ZCpgnyo10?=
 =?iso-8859-1?Q?QJhzyqARLccqG26KRHFU0jiWnSmyZU6IhUGCPXU/7zVqNT3l2koPcgwOSj?=
 =?iso-8859-1?Q?DwccfdWIhbJLd5s2mWuD6UJMHMh79JVpzzdo5HRnsPuovDlbRkNvQuSUZg?=
 =?iso-8859-1?Q?7mtb7KAwcGzt9uRygNhEJzUCozAlsbi6OJJ5IOGPmne/YlPUO0Bdy526og?=
 =?iso-8859-1?Q?sUOLAaEfwbXTYR2sb+C/YHi0lWMDhRz+KZ6MJ9RLY9d4eVREtFuDrPdsVK?=
 =?iso-8859-1?Q?Lz1oceUr/fcWBqSYQ7gZtbqKROTwAdcKNBta6NmDl23cc+6HTePuyIvJ60?=
 =?iso-8859-1?Q?wy5OpcUNIOAt5R5cnoVWn0WVuQuz3WV+z4eNFI9QPnV2I0373IED1fxz3S?=
 =?iso-8859-1?Q?hZvrVJBV8RrhlACow5fLYmolw9IUU4OVOllNqwQIM3lg+MsAVHss3dO9R2?=
 =?iso-8859-1?Q?sxF5WOs5fCkRkMyfksWD3W0t8fDXEEgCbIVIN5QhH+b9o4F8/bmzQQlKva?=
 =?iso-8859-1?Q?oeV91/SPoggzPY5hddACikJzUMUBj475qcAvqCmi4O/azZByOi31BEp8wk?=
 =?iso-8859-1?Q?62A5meQrzDpakeIvYo/gl/yDWzRFxnYbH6un1zVNY9BmezUXPB0xG7txYv?=
 =?iso-8859-1?Q?sMLIcYnURyCsb+oDLXENIXmjF0crqrtw5JmCjX9nYFn7TjkeDK6JrZyqEI?=
 =?iso-8859-1?Q?9pr0VXkpQnIxSj+ELuCSQxzfvju94PQQo9URMiJUlH5KpzcOTZ328oKGLN?=
 =?iso-8859-1?Q?0xFa/KX+Y8yFllxZ9lw7beKH/BV4QbDR2z80KR2jAmoFX3V+hDYbHmQOjp?=
 =?iso-8859-1?Q?eyQhzk2jM7kXlLZwBR+ozZWyviR66TsPO1xr6ku4sIL8nTHVO6QHHpfz1x?=
 =?iso-8859-1?Q?xps4nxZt/duZ3vklgBYf181F5kIzUamMTRQvTKvMIb2m7cJpyMSxfGaMTz?=
 =?iso-8859-1?Q?uAgt9tREazLcMQTMk5twN4fXoJvs/5OtzkhnpNTnQEoVDn9PpYzqag8r2z?=
 =?iso-8859-1?Q?A9iBEeykTFtzy4zVSyXWYqlmi/7RUYzn0+1r/UzZCcee+8K3KuSHRx4iMl?=
 =?iso-8859-1?Q?egtix6RuWf0KTK1aqldVWCPD8hb7F8fx+yVmAgnfiGuTeR49adQFcyePE8?=
 =?iso-8859-1?Q?j1j+memxlSyJpqxJmIcz7Bi5bWC24OUUw47f0AfzmJfEtLKMg0kA4xbj5A?=
 =?iso-8859-1?Q?u4eAEKlH+2OnDwhVhkP8fXXqjTRDK7LwxdGRUGmoaZVI/mQuruPYD79Y6o?=
 =?iso-8859-1?Q?O7XnuNMji09aYXSApdI/PBeWjRGvzimYOVTWHXPFT3gO2ceA8/8PZmE18g?=
 =?iso-8859-1?Q?rv5Bk/svWhk0QRn7j3j63zMgF4PbxGlL/U?=
Content-Type: multipart/alternative;
 boundary="_000_DU2PR07MB8179DBDD123A4615CBD1688EE8052DU2PR07MB8179eurp_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8179.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a37af9-f4ca-451d-fed1-08dd1f7fcabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 16:19:47.8841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gmwu+19eUELSTvA4fqQvAliztnyPc7qj1/GUED2zsYyFj2pKPrs/zEBVqu0ZGN0qVgrQT5iZjucNyas6VyeXSM3VNfqiDF4iyYTGy8UnPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6261
Received-SPF: pass client-ip=2a01:111:f403:2614::620;
 envelope-from=markus.lavin@ericsson.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--_000_DU2PR07MB8179DBDD123A4615CBD1688EE8052DU2PR07MB8179eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I think that I might have misunderstood something fundamental about the BQL=
 (or possibly Qemu in general).

I have a custom PCIe device that connects to an outside simulation environm=
ent using Unix domain sockets. To deal with bus-mastering from this outside=
 environment I have a thread created with qemu_thread_create listening to t=
he socket.

If I get a read/write/interrupt request over the socket then the thread sho=
uld perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called =
from the threads context I assumed I should first grab the BQL. Issuing a b=
ql_lock from the thread however hangs Qemu.

Is my thinking flawed?

I think looks very similar to what is going on in hw/misc/edu.c where bql_l=
ock is called from a thread.

Thanks,
Markus





--_000_DU2PR07MB8179DBDD123A4615CBD1688EE8052DU2PR07MB8179eurp_
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
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think that I might have misunderstood something fundamental about the BQL=
 (or possibly Qemu in general).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have a custom PCIe device that connects to an outside simulation environm=
ent using Unix domain sockets. To deal with bus-mastering from this outside=
 environment I have a thread created with qemu_thread_create listening to t=
he socket.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
If I get a read/write/interrupt request over the socket then the thread sho=
uld perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called =
from the threads context I assumed I should first grab the BQL. Issuing a b=
ql_lock from the thread however
 hangs Qemu.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Is my thinking flawed?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think looks very similar to what is going on in hw/misc/edu.c where bql_l=
ock is called from a thread.</div>
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
Markus</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
</body>
</html>

--_000_DU2PR07MB8179DBDD123A4615CBD1688EE8052DU2PR07MB8179eurp_--

