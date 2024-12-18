Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10C8E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxf9-0006ea-JM; Wed, 18 Dec 2024 12:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNwup-0002Ww-E5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:28:51 -0500
Received: from mail-vi1eur03on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:260c::61f]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markus.lavin@ericsson.com>)
 id 1tNwun-0001mM-Gd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:28:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzrbowvdUaV9J4BGqEGBSIhiAKqSLX7bk7bPku0VdF+SalG7HWuToMyzNlLFdGHcVdLM0rtZKcCCr1Rp9gBVvu94tLNg3rE92bUz5ODkK0PZV+0rwDUVdhHHDP9tOWNus9nGXAyPanxTblQs37uW/VjDbs2EGVvG6KuyJFGG+OAITBHCUmFauJDCflyXsLKc1SDCR0jii986/RRg0i+CcYxlfgQ11NZdA28wZeFuPfL9Z+1ZBdXdFjjdfZF7a1/9z9WVtteq5wFH54i0iyFL8jmQiJReBvg2Sfc7EKC52F8ZTC6gFebNRM50+AC/INk/udNrIq4Jh1KYz3lBkZdkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IZw+K88Vzd74kSvlfDnYTBVD0YmL7jF6IEBLgY+wuk=;
 b=EBEl6h2iT3MQgDvhCi9ardWR1le75J3ArmfPzDdvhsYSfQUWZrQSWxfIAl311j8crjKrrjOUHCKutowjaTEUb9GS8+wDw8r8V78+eaar88D5cSi+wdokz33fk0TT+sYCghHVk1tVmRQVZ0ez0qYQOhiuTCK8XPOcR0za7hkCvMMw9DsuD7oL4c+oFp2QE33G5YO/M33BaUh5q/MDe+Jbq867iXV4YnTq0VCSbllb3tmLA9kMSUsLWvE5OnMoHvb+H32Zd96nlWkmAFCMYq13kBJWckuu0xkiiYLf+EgsOFmq9si9ZddZGk182HY3o45EGkphSZsmwhl7ccrKjyIcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IZw+K88Vzd74kSvlfDnYTBVD0YmL7jF6IEBLgY+wuk=;
 b=CFA+byTYfXG+Xd0bEOs7TCNpQt/+5obacI1RjrVFl43aVf9bN2CJYbNDojDLC7FAqSxjAZCfz751q2b2duB/BhTvkDNhDo1VCHts8cM4+2axvlK+gOov94TJAPa0SQbIrqim98zu82VijqJZEzRPnjEP7lYPjSr0lJgr3BYroVg6lTjynMcy0HP2fifWGtiZeUf/BEbTunKKNSq0V8KHDSfY9hm4Z5aTWgyEy22Kjq2CTNfb/4wxfMuiRjnQq/cUzv5mdO+1Pc9BM811PvhgidUIcwN5m0NS9RK0R/WyRyW01NTOfS1IisviMgw95+5/yowxUVRZLR1pN+a7o0Rt/g==
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com (2603:10a6:10:274::6)
 by AS8PR07MB9463.eurprd07.prod.outlook.com (2603:10a6:20b:63a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 16:28:06 +0000
Received: from DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3]) by DU2PR07MB8179.eurprd07.prod.outlook.com
 ([fe80::5f27:3841:f232:78e3%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 16:28:06 +0000
From: Markus Lavin <markus.lavin@ericsson.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Use of BQL from thread in PCIe device
Thread-Topic: Use of BQL from thread in PCIe device
Thread-Index: AQHbUWmn1XHOF0Njq0m2dqiEzAkUuA==
Date: Wed, 18 Dec 2024 16:28:06 +0000
Message-ID: <DU2PR07MB81797845C370D348A5CB9100E8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR07MB8179:EE_|AS8PR07MB9463:EE_
x-ms-office365-filtering-correlation-id: 42f1ffd7-0d2d-4561-5385-08dd1f80f3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Qa82mOn7vfSeVFIkd3i1yJSYeKUEXfa9qfqkRQOrfNEjShPXW1TpJ9S1RP?=
 =?iso-8859-1?Q?6M0W1u88G2P8YFeqNLtQ4PIzD1HXgqyWBDxnd/pPtUfYrBDpFKg/a2a1iY?=
 =?iso-8859-1?Q?HBUdBJQyhplyshFA/wWIkoJ5gG2Sd55orR4Xj1+Y20K1Xg0fufRKBSw78F?=
 =?iso-8859-1?Q?GoQnn2PAorO1Y4UMC1O5/+6//FxipaoNYRYt+6e5cPFJOOIkYRWJLvMYiY?=
 =?iso-8859-1?Q?hmjmEy/YJKtvz80LSqb9xVaxdAOtcFIhuWbn2BWMI2oIU9WrTe2F6KAHVj?=
 =?iso-8859-1?Q?UCriV1Hn5qQN+dp0WA1EACUc5teGzCRnR7VLimimtQymyd/UHk6+vAYUxo?=
 =?iso-8859-1?Q?MLvLrrpfLVm+sfDVnRAXaLTAZJsBonQyPHZ/3z/t4f7bsCRL7wRxANTxHg?=
 =?iso-8859-1?Q?SX8qq0SltuesSpb8zGk5BiTHkS5Fr4jyZOzdeVeV5iqZZ4DMl0jVRLdf75?=
 =?iso-8859-1?Q?RuZjeZp4XAEihJgxTmBPdLlOBCJ33vUldXTBZxMNaXh/VnJ0zANJB4EFCS?=
 =?iso-8859-1?Q?iqd4F4V+0s4RQ8U7TedvdNfLbHqKJ6ZJ79vxy70F7JuBPWNu1C4TYbo52Z?=
 =?iso-8859-1?Q?JVOAvEMcsxqIH8jsofK3NvUlHPHyEY0zf0InNs+8HmzX0Y95hv9mJabrWS?=
 =?iso-8859-1?Q?ta/+wOhJTMLUSOx3faeEXd6pO7q0N+5hyXEHz4PBsRQd2ydIBD46kjn/AA?=
 =?iso-8859-1?Q?vj11kvf3wd4PkWX23KWSQZrcYWXcGRoPZ+xwCIzLSEwJl9lJaTLsczNbwQ?=
 =?iso-8859-1?Q?PItRKEQ2Vg7qyhNXb4KFpvzGEgCGQ+eYwgkHdAgbCbQOPFAJur+pHn3aF0?=
 =?iso-8859-1?Q?ZjGykctCe9lTNy/HGO+UAKABvj5BOnOcpr5aH1hC9uRQGlTS0CPKdpjWQx?=
 =?iso-8859-1?Q?S5dix//XCrqaOMKQRC62RpiaveL9N9Uvh+bcccqZBxsZlbMV7d4RbsFOhq?=
 =?iso-8859-1?Q?qRHz2IwqNwthajC6pG21GYImctj0JzI/1mnJ+wJ22DOZGw4hHCAOZpvf6Q?=
 =?iso-8859-1?Q?d2ucUvw+O/Me2UKNv42EaJWrI5kUTlAcKnb4DbUci/7YYHQoRPyY1GwBN3?=
 =?iso-8859-1?Q?aDHuEct+X5ScotCChvXThGHMYx2cUtdTQTKxLFq2+S8UCJ+HAM3e7T48wl?=
 =?iso-8859-1?Q?c7zTr6nAY70+qDpf4pr/k+m7om9GmKCqSp6oSo6I53gAywfURmC63u+4B2?=
 =?iso-8859-1?Q?q3yEujlKqhFYdyuOO5kvGPvtXovOyTREs7Tv+YzyHfSa/TnAw6qdqL21P2?=
 =?iso-8859-1?Q?RouNQyzbaotnFttRdoTb4efta/Kk7XadLkxaPhDf5jJCo/bzsOOxtFRLph?=
 =?iso-8859-1?Q?BJPpjOar8F/BS+b16Rq+61JfPh2n7kCxjBnOpwg4IBUQPBm4q8FImT9mTA?=
 =?iso-8859-1?Q?4w79+Fc26uwTXUbNbJOLdVNuSDtwHG77VD9gvY+Qx2D9puy4M/7S7/1e+y?=
 =?iso-8859-1?Q?Gs5y1cRvgXzxTYGfCXKK3l3kxmlKNOMFDupDGhKhwlCRgRiI/LpFFIuRHa?=
 =?iso-8859-1?Q?++kNxC7Qb3LPtPrEpPf/rr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR07MB8179.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LHr8EF3+BRWfUNHJENolZ199XGdQAgU4OSLtuFA/1Hjb/uFDVGQkB31JJy?=
 =?iso-8859-1?Q?3jzp9VfoFkVMEXr+oCsubkjipkesCyl7kcVzigyN02dhzHflbnetOHLQTi?=
 =?iso-8859-1?Q?45elW1Epuvq4m3XWRqYtNYPB65aWGKOwFq6JOyxvmqCkMLXUad4uIpl+fW?=
 =?iso-8859-1?Q?j/CVTQUc0wHvdRyV932DnJN2179kBSHCCQE2Exbly5/IO9Y6fUure1/3/0?=
 =?iso-8859-1?Q?/IPVS/wVwAtKNWPMhKA/9dySI2F/QOquBbk3K1yjAkqk47tdkPz/RwoRCE?=
 =?iso-8859-1?Q?oJLbJeJ7FISX0s7wIidGsyvbYBUD0URhKePgZ+FRNFI5PL0IayR+xMqQPB?=
 =?iso-8859-1?Q?uYhcSZ6EGFWuruvkfBsQ6Sz//LsRScRXNv8EiSfMi1w55Zq5A1AQKmVmRl?=
 =?iso-8859-1?Q?3v2rLNtcgL/Favw+WdJs4dwWVWIXOclwRvt+J8rEf5Ub1nKyC+Fz4CDSQ/?=
 =?iso-8859-1?Q?/Mfi7CGeK0QOvOZ2oL4t2PptjTrISSwtGLo91tcmFC9ZpcY8d0jqFN20Nv?=
 =?iso-8859-1?Q?8FdaVEQAJMtarEyludKjSYZ9ntP7jzh4L4Mq4bC4yJCEt9gliKUDTeXm/v?=
 =?iso-8859-1?Q?3yyZqfQzm478N7IcVWgiG1bBDOSoaf/nQX82ecdim8wFGrRAXhyFG4BrWu?=
 =?iso-8859-1?Q?HlsaKw/z7HBcFigUQmaJDXs2k2XM8Y9W91Ya2dmkGXsrWMPcavftqLDjYD?=
 =?iso-8859-1?Q?XY/7jOEjGevt4mZ9dwD+KutLWAwkF1jr+IuqW8FKNnKaLvqpH+AX2V16bz?=
 =?iso-8859-1?Q?TZ8BlAEiFUNUpWOOkwXt+i8ezoMt+2ZnAIxspfZTwu8uTPUe/vzQOwas82?=
 =?iso-8859-1?Q?HbB9nW9WIit5J1W0U3jqCpkyLGSkXdiWXa9icyXtoY17dBjcxhEDy/quVA?=
 =?iso-8859-1?Q?JQEqLiUj5i/KN3xw+gf1Ooz0IgJ9CfSAf5nmyF+lQ9YX8DtuY2uE/wwMss?=
 =?iso-8859-1?Q?+lbAzFqycdU0h8VXgpZwIC8o6qiRDiG4jh0AoJtPPtilMsQVXdypeeqxLy?=
 =?iso-8859-1?Q?M+LG1ygF1g6+OVwLCYIpt9+3n3RhULAkIV4Qk3E7Gy2Yf9doc1TQrnPeER?=
 =?iso-8859-1?Q?iWjUY/UdnMRvcdZm/q89YSLuvwVLFqHbfOIDIvigP9Ps9kv5RJvohODhWf?=
 =?iso-8859-1?Q?n29mJliOlDAiiVgKwHmLcSCZ3fe6+EXQFWhHafpvit3qrIQAyQ4GNkVsXO?=
 =?iso-8859-1?Q?pLqifzoyYO/RxTFRK8L1nbDdZcDtnWFideD+HTOCLi/v3kbcPCa8gBtPbk?=
 =?iso-8859-1?Q?wBUuHiv7p3EdEUQvAfGkpDttrxPR4eV73ktpqjYNZwpoUOS3crr5g0xi5g?=
 =?iso-8859-1?Q?i/oA528S1t70kRHjQG6zKQcqIAqr+nBVnYd0+GHyEr757swMD1PW+i4V4Q?=
 =?iso-8859-1?Q?wG4uwHEsyreLlZ8JeSwR0sOqsM8BXFyHETmXabxiVNo2h/GCvixSbv96i+?=
 =?iso-8859-1?Q?u3ItvUzlxE6M1qftmEeHktCFhh+S2GD0/YBiHPSM37czA5Ohmz4KKHQT9V?=
 =?iso-8859-1?Q?ZN6n6hywBFdtziVZO5MbP11gsEpaLbL7xBAnTV8klpkYVtLLzz28GJtavt?=
 =?iso-8859-1?Q?o88j79aVvsHaGGLhcy0hYmRrGyjkd4D/ZbjVPQ84oy0NWc/K81mZS+4VFo?=
 =?iso-8859-1?Q?7DQ2KQUmtIDq8enJpxV3SzxzI84q82wa2j?=
Content-Type: multipart/alternative;
 boundary="_000_DU2PR07MB81797845C370D348A5CB9100E8052DU2PR07MB8179eurp_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8179.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f1ffd7-0d2d-4561-5385-08dd1f80f3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 16:28:06.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZZBH00P97sYLbcflLMKyb7v5X6n5DnnXEtawpGGDcevwp2WIn2Q2ITV94/tLmnjJ0CTxexGtfAz45yQwvKbVlZsM8yUTId7PO1QTektmhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9463
Received-SPF: pass client-ip=2a01:111:f403:260c::61f;
 envelope-from=markus.lavin@ericsson.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Dec 2024 12:16:41 -0500
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

--_000_DU2PR07MB81797845C370D348A5CB9100E8052DU2PR07MB8179eurp_
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


--_000_DU2PR07MB81797845C370D348A5CB9100E8052DU2PR07MB8179eurp_
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
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi,=
</span>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think that I might have misunderstood something fundamental about the BQL=
 (or possibly Qemu in general).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I have a custom PCIe device that connects to an outside simulation environm=
ent using Unix domain sockets. To deal with bus-mastering from this outside=
 environment I have a thread created with qemu_thread_create listening to t=
he socket.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
If I get a read/write/interrupt request over the socket then the thread sho=
uld perform a pci_dma_read/pci_dma_write/msix_notify. Since this is called =
from the threads context I assumed I should first grab the BQL. Issuing a b=
ql_lock from the thread however
 hangs Qemu.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Is my thinking flawed?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think looks very similar to what is going on in hw/misc/edu.c where bql_l=
ock is called from a thread.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Markus</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DU2PR07MB81797845C370D348A5CB9100E8052DU2PR07MB8179eurp_--

