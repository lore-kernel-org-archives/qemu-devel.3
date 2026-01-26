Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A3CCF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 11:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKm5-0008Kg-3M; Mon, 26 Jan 2026 06:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vkKm1-0008Jx-PN
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:28:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vkKlz-0004Ub-IU
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:28:49 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60PMvJqT449038; Mon, 26 Jan 2026 03:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=FBJE9CdaaTl4U72
 WWqRmuz80x2WpfcO7KUIrsHb+jPQ=; b=SXeI1O1utCaA/5ySz3ojnfWkM0QR/ic
 BeKwoBFZPOJr1kVmGYwDzNqs6Efg7IiwjSo8qyLfoVOVfF1rgcRuoZIcc/s4pxOi
 ibb/e9SX0zCxDsuzhz+60F5w3C2XfDwgIF9Z5OUND3yDMMrLez2CXUdi3izFx9iW
 jQRlaKColC/zmgDnPfmWywobKvH3zHFlh23jEQU3gMVYY2yZZJlX+0DzGm9hS29n
 u2MNhAdx1dGRKz7OP7rohvXWm1Sm9HRmG1VNY3GHpccySeV92/8q5mpWpDy0VIQ4
 Yh9GDuQYuyKjVWWZ0vj3VThAAVfWWUVYDSmI2Ub97iR90I3yZlb8uig==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020129.outbound.protection.outlook.com [52.101.56.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bvxg0asgp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 03:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrk8IWvByVWPK5yUQGuP6qVohWGzaAbo/DtHyyFlimc/YgBetLFtuhlq2N0yJFdWcbmejzUXrRNvlOegIhgopUUhlkCy8Z20nBQJ6Agm0utfVYh0gFHxP8Gm9V0vfTGzs+Q8yUS2neOZFjBvE0AkbTFTXluMvOSeXDPEsKEh6KTOcuNp/vDDbcxeAb9EMzl2WQo5RZsWmLAxeJRecqRJO69rVUgfWzjz9h5vKLWcc1RtJ+Y+Ak+8l4sBwXClKnJH2HXuTVjutk4L4hD5WvC1PCGZew6K1LOGn5XOe/fOR1L/B4mW/pw2lsRffmVAt21kmwvF8TEZ92esKS07THA4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBJE9CdaaTl4U72WWqRmuz80x2WpfcO7KUIrsHb+jPQ=;
 b=AVdb92RTNJvy4ULpZXyBFmKcUMPRBAqOQ9LOp9wZbhQqLo/Co3zlLAJSWOKQ3vTXR2A18k009vlKO94a3Fask0/OTyDRUzRIbdWl8D5UTjidsmGoW0D9DjQ5ggx6L6hFy82qtLKSKHJ1GhZnwcdIH1ob6H4sioYlTcXCGQ/CcYYqoCvHGYZz5t6g5G8rMd4iG9tYqs12DBU2hakd6fePD3eTyKmkGmDKemKMks0zbyrJKyRSwNvP6BvHWr6+MuwZuhNPzjGCiOfIGb+Yk0lBt+KolDvhI1QfEHWudzoty2q1di4rdZHDe9mAe9+4StZR6EHwXzj4vVZWt0W2z7ZKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBJE9CdaaTl4U72WWqRmuz80x2WpfcO7KUIrsHb+jPQ=;
 b=EIzHjhDqEXyusLiQli4SnW3q0A5tRFqGiZCPJKwlb3oHhHdSwx/Z+OTHleDClI1BdxkV8zOlpr5pWjaJ4jCzk6wsv0JpEH8600wSeRtuiXLRVpItxNL/iWWswBtzS6lp0hkwgjiLHAwAqVfSturkG8mmVqyvJJmeeRW9SPpn3u/hPT+GIPbe/X0xk3NueUcO0bEalP4ZTN3CeSataGH5chHf3DBScWBFhjE4jYL5b1KlkWq1mZ5kICkVBNlIffdeC3ng4KhytfKzLw1Rx2hTPPqQSRLi1ZspoP7r80/Qj+FGAT7TEUYkv4CDUAR0uDC/N5JH30QMEN4JgYgHoCY05A==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by BL3PR02MB8084.namprd02.prod.outlook.com (2603:10b6:208:35d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 11:28:30 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 11:28:29 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: Corey Minyard <corey@minyard.net>
CC: "minyard@acm.org" <minyard@acm.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Subject: Re: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Topic: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Thread-Index: AQHcflvnhI83B+K27EGlWAg0SVR8l7VD9QYAgAMMfACAHWyziw==
Date: Mon, 26 Jan 2026 11:28:29 +0000
Message-ID: <BYAPR02MB50296483A143E74433E77EF78593A@BYAPR02MB5029.namprd02.prod.outlook.com>
References: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
 <aVwP3MZtoHoEa3p1@mail.minyard.net>
 <20260107175747.2632041-1-yunpeng.yang@nutanix.com>
In-Reply-To: <20260107175747.2632041-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|BL3PR02MB8084:EE_
x-ms-office365-filtering-correlation-id: 56ffb21e-9cc4-4f71-539c-08de5cce0799
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5k/y9oa2/qtLk6dVbmyW5n+6O0H+1gBkCoLzBpA/GzKjFAO3Sm3rE+zqDC?=
 =?iso-8859-1?Q?cax6z9uKI91GpNWrYuGBNJ2bNoIwGZp59Mm4SvsqUDMEM3N9VG3H31QvgG?=
 =?iso-8859-1?Q?rSCRw/EjvCXXMDI07bUSonmUjC0AKYbGWmHMwMXI2AkUIdHyZwkhw4jBys?=
 =?iso-8859-1?Q?PHJeqeKDqgjSVeIyaaViEIlf3sKg3bYsnMV3MP/pGcfsLR53AmczTz7+yQ?=
 =?iso-8859-1?Q?VcX+lzMjqc5EGo2OYh2zOpzBA3bYeDmCTtOe/GeHl1BNhPckypJZndaCFD?=
 =?iso-8859-1?Q?1CY+9oFZB4TViFP1i+VZDsX2Cq1BZnX8dTOlIWE2WufSSam/l3GNteL6Ov?=
 =?iso-8859-1?Q?lpRxuP97wSJ2OECNCxKDjQ9/rHmdzFCHmKXR17vHgGM7GQIwJhdtrHFmII?=
 =?iso-8859-1?Q?lvcUg5yjvvdhOk25MCIsvIM0qrREyrje9E9CnoJmOGEQ6TQ0sb6OY46V/3?=
 =?iso-8859-1?Q?jkXgcoF3eEM0Viqid5dX+pciILVoi9DmiKLulTPOLb7isoMk+VOMdZ4Cwd?=
 =?iso-8859-1?Q?i9yaa1yhkvshKVjK1+p3RYVksoiRJGejRX5Henh6K3BbBQ+wPM/9rJ/N+e?=
 =?iso-8859-1?Q?dell+zyDesXxA0fVcVcedGf9TqZrIEoYI6P/jt4TxpeZPsjArKK8PMC6D+?=
 =?iso-8859-1?Q?VqqUEDwvCRCPZj/vCKaoaw8Dco5bzQwg5oaIVhLhgZA4HK9L3vF8nnZFUx?=
 =?iso-8859-1?Q?GTpwR9k/wxZs9rfRxv0lUsWNUENUTfrOaveyiJ751o5KfxKytJXpu3vIEz?=
 =?iso-8859-1?Q?BVt1Fz33ZJNfTbEwOIiJFGbTJ3I5wuyWWhBZVDNDE6haKySzt2qlx3oV8m?=
 =?iso-8859-1?Q?KOJk59JLze7cRAAS9Q571QQaZ/NU0+DJaFmxR8lFf74J5gLupMd3io1x/G?=
 =?iso-8859-1?Q?2u5WYT7ui+uWNNYwGyY8xfR+vl+4/iV+fO9aDUEAxZ36+FNvV0A7IN505m?=
 =?iso-8859-1?Q?z0ZvgXs0xHxPwOYJiRaGUG+/A+3j4oye755laWWYMuY8nBgOCDIa5kaTCq?=
 =?iso-8859-1?Q?XHzUAinxgWsfdWmcjXwxeHqyV2RNEhtxlrp8Yyc4SCEtjPFTIJ+wECrg0F?=
 =?iso-8859-1?Q?R4agc8/AHNHNF/TS5ce3+1yp6aMRe8NM5KjtkGDssgNqaCOqPWSR6zQy7m?=
 =?iso-8859-1?Q?Yls39MihwxL+//fU7KWY2ci70+9Kt657Jvr/EUboGBmX0iHTm6nHmI4vv+?=
 =?iso-8859-1?Q?s7nLUrZJnDJG387zruUbPCoPXHBliKz0WrlpjeGiqN7f4J5Qups1GUvN7c?=
 =?iso-8859-1?Q?XFvA7RQ4o6cY4TavzjUPZeOK3Qo4EFPFuZR96abY/SUS7MbzDsTJWCji49?=
 =?iso-8859-1?Q?//O9lpoM9rJwwBCbt4G8GEITcPLMiIxZWFCXzGCStglviYYJ3FmYu/sTmv?=
 =?iso-8859-1?Q?0nMrS55KeIgCeUhe3gZTGGaoGWVx7WqJF+s2VS8ZvOpv8gcNqLVaHhlHbN?=
 =?iso-8859-1?Q?2F5A65jrr4KNv5NA6c32xxrSooalMlaIzLgek5WXedBNrGgWHKZQl3KsTr?=
 =?iso-8859-1?Q?Z0f6sG5+IrzqyNMehqnjKWuU2j7G3butSURWXIZRCLEz2ikGbytO2ggco1?=
 =?iso-8859-1?Q?2jFEFELCKZWZLkT0wcCgjuU9Wxf1+Y2jfFRaNSLAXKwh7JR3rUAhXKsH8j?=
 =?iso-8859-1?Q?bfneFKahn8niOQ4fE1gTQ3pZsBr/hRo758S42EUptHlO/3t1jkHy7hKob1?=
 =?iso-8859-1?Q?E7YRIDRGDpmAAxUAnnY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eK9Ds4n42FWX6kIreA4KJC82vVf5neUs82Xx2NtGa6iFmaojoJ9UBQASss?=
 =?iso-8859-1?Q?Hhi37QFFHU+rE7mWAQagr0FGVBKSok7nYaV2wGjDxK+GZGHoIp+SnUTssJ?=
 =?iso-8859-1?Q?xg5Pg8fv0zmQI3O+j+6uSn2jXogKZwH3wLb97xtCLyekYFSGKIKpnUrgWB?=
 =?iso-8859-1?Q?2QoPrpfeCGon+EQAprvvKAzF4dpCIkYcn/VmL7rCjcwLed2imHNsLIO1U0?=
 =?iso-8859-1?Q?lKamgIDm4n0m6Y0VeDKSbXv7idTbi8SOet6YWDE7VCUylh16v5Bjrt4shK?=
 =?iso-8859-1?Q?zYnfD1+YKev4QUzACfud/CvQpmJY3MSldIyfcYUKv832FE1tEvlozvLRaU?=
 =?iso-8859-1?Q?9/O8jhuZJXqoonyDc8kc7Tvz5rOIbRS2ovMogjZeT2Z19pARqClEVDvddq?=
 =?iso-8859-1?Q?IsT/hl9y9IRD+AfIPkgNyVDE085zrXnc3nN4KuXQvOjv8pzUN1XCypKg5T?=
 =?iso-8859-1?Q?70XUKe6dFzjBEKrBPvGvgXFXCiAMvWyfXCwZ40Gj+XxP1vm9cIrkB7UKaS?=
 =?iso-8859-1?Q?dHrlxFAy4+lpn3ROSsY0ZuZ5soPHP51hpeZIGCfWVNzYoeKNNZBtUC7QUS?=
 =?iso-8859-1?Q?D4c05f+NaNA1HIxJpqEMkUGLwOwZH/8HVpxMeDwIf/DcL/J1JhPfCEWZbv?=
 =?iso-8859-1?Q?dj8CIJPs9fTPmkXpQqTZubzwxUgUWk5+jELksYUcOnNdIj6SpLKDSkYvRX?=
 =?iso-8859-1?Q?ICkt/IA01kxz4SvWUIDHqzuyH5FZE9YP+Yqpx9GV33I0UG9r9CnkjLNx/m?=
 =?iso-8859-1?Q?gB5EfY7b+HEbYj/ecw3nMz+OfhQRmFyCoKbvyK05PY3etGAyGyFt1Cfzy4?=
 =?iso-8859-1?Q?4evoZxJVtwmTgj+EK+iDtSVh8zjxucmb35oq6JILJR/d5QETGbz89gY7iG?=
 =?iso-8859-1?Q?rS8yHo4sr2xG4wSFj6jhhNCj9po0ausD4Prh3HTTq7Gx0BFHC9mzgo74Jf?=
 =?iso-8859-1?Q?UIG6HXjpjZXTPvtEHqUOinGpfhjYO5xD9EFYNMyhBbOhGAmuJ7CSvIOcHy?=
 =?iso-8859-1?Q?0aaM0cv7TwuEgPm5ox9BueKG2hJNLIoVWMn72mMzfiVJ3jklvxmaCOnNXx?=
 =?iso-8859-1?Q?qXGDrSyDyYpWRMmMhdORCiXYMzecajwBgZkl+vBrwR/b6STbymm47RJz/X?=
 =?iso-8859-1?Q?lYYPSoKbDqeuFvWZXt976TQNbUWgFvkOGdKpEg9D8TzZ+2gMeCb9W/MxuM?=
 =?iso-8859-1?Q?fiheaAcD0RFIhHKpKKQLjRQ5tgcUPPhH19SC6JrE1LLYBcWMnbE28zME6d?=
 =?iso-8859-1?Q?EJQMsBLHMl6Wrr4Y3Xj1OlBurczDOtYC2vrRN6GnVAHbKlH2EG3d3NK2W3?=
 =?iso-8859-1?Q?EyOrY41GXqcMdq0uRcVVnozrDTkYORnj6BKcRTm59NFJmZjM7u9abhjjyN?=
 =?iso-8859-1?Q?ysbaoYoCO5Lu8tLQRCHelyhciyF7602jXqn/coy1S+S9q+45SGE6ZIbOb0?=
 =?iso-8859-1?Q?IyeXyhG/gaFS6lp7rbNb2xx8wnBW/qaw4+N3zVqzQ6f7THYpcUSP69qAFK?=
 =?iso-8859-1?Q?OOjLay5aKaHxYHxqfgKlfeOscW1EbSS0hsUfMILyqBro7nmKkn7VT0jrpQ?=
 =?iso-8859-1?Q?FFUurZ18E/1zPAZ3hYiYMTgd6j1alJxeM+givHJP62cjqO3pORutB2ny8+?=
 =?iso-8859-1?Q?bBgVd0q8PluuHgz+cY1SaoEHEOmdCe5a9aEvmyM8R5NzxRNDGjYpKgCgFD?=
 =?iso-8859-1?Q?0OnXX+EkGB9Dsf4ZK53FNoCPIpimRlzsE117nCTx8+jGTbMXCC4KA6Ixgy?=
 =?iso-8859-1?Q?DcfSR+dhd/RyOq4g1lnbgWi3PDz60PbunFn5NqhowQXJQ7cIl0s3yZTCJq?=
 =?iso-8859-1?Q?pS5ONlZOAA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB50296483A143E74433E77EF78593ABYAPR02MB5029namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ffb21e-9cc4-4f71-539c-08de5cce0799
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 11:28:29.3451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09C0gvLkWzt8e2Oz5UsMUGUHCeYh+ci3/+wrF1YF1RKXYTwbrSFa8Kco6va4m7Y8auiXrpOkys89BTxAKw68yjomukT7leScm4Bsqekqomk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8084
X-Authority-Analysis: v=2.4 cv=TembdBQh c=1 sm=1 tr=0 ts=69774fde cx=c_pps
 a=68tMKWLL5ro13Q+0o2tD5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8
 a=HL3alpDKAAAA:8 a=KKAkSRfTAAAA:8 a=N54-gffFAAAA:8 a=20KFwNOVAAAA:8
 a=69wJf7TsAAAA:8 a=oEIp-2ov7y67WV8UVVgA:9 a=wPNLvfGTeEIA:10 a=GtYHaO1xT9IA:10
 a=VxR06f_1COkA:10 a=buraXQrDzntoDfZ8mRoA:9 a=tyWSCvNsO03RSCK8:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=KRX0AkppOCwXZa-dNZoJ:22
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: iBZ_R1e87UIV35pgboQt3gyL6ftSTH84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5OCBTYWx0ZWRfX7V/0UCaeh1FH
 RzJFfb/vif+alQMueKtEj/W1zWOq3ay9T1FXsSaEcKhOKcolQBD01SuZVbg8nwNvuKE879vTQkS
 o42cx3qSzpgjO5JFaF+2sWIe8KQqxdMwL5I/D5iOdKQ6QQrB11pL/5n/YB7T+rhlq7yzuPLR96o
 PqOSYMiWXN7Msj2rvuf768ZRnsW8+wJYqs9jl0QCIym+LG6AXt2YEcyiCceIJQht2Q01oDf+tb6
 7KMgWrn88GJHMvY1UGTaYjNMY0FW1FWkr7pKWuRFFoaviRVpT1UJpAJyeubKQQxuzQZ0ob4N/YD
 1EVBTp/bDJ8h+82UjJ/j3Nco12bn+MdhVYD6YdiBQ7lfj0lpBYAhJTgUDfdiyOHcbRCQuy/Zlsh
 wOfStq9ntaULAcmhAxAod3c1q6O1pwwYCLSwNztRXHBPEboSNPIYogAVroEiKn26FwFh2rJHe4i
 c8TRc2+9WKVAvUPEX6g==
X-Proofpoint-GUID: iBZ_R1e87UIV35pgboQt3gyL6ftSTH84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_BYAPR02MB50296483A143E74433E77EF78593ABYAPR02MB5029namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Corey,

I hope you are doing well!

Could I know when you expect these two patches to be merged?

Kind regards,
Yunpeng
________________________________
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
Sent: Wednesday, January 7, 2026 17:58
To: Corey Minyard <corey@minyard.net>
Cc: philmd@linaro.org <philmd@linaro.org>; minyard@acm.org <minyard@acm.org=
>; farosas@suse.de <farosas@suse.de>; lvivier@redhat.com <lvivier@redhat.co=
m>; pbonzini@redhat.com <pbonzini@redhat.com>; qemu-devel@nongnu.org <qemu-=
devel@nongnu.org>; Mark Cave-Ayland <mark.caveayland@nutanix.com>; Jonathan=
 Davies <jond@nutanix.com>
Subject: Re: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN conf=
ig

Hi Corey,

Thank you for reviewing!

Kind regards,
Yunpeng

>> Hi Philippe,
>>
>> Thank you for your comments.
>> I've modified my patches according to your advice.
>>
>> Kind regards,
>> Yunpeng
>>
>>
>> v1...v2:
>> ---
>> 1. `is_valid_netmask` is renamed to `is_ipv4_netmask_valid`, and is now
>>    implemented using `ldl_be_p`, `clo32`, and `ctz32`. It still ensures
>>    the netmask is not `0.0.0.0`.
>>    I didn't find any related helper functions in `include/`.
>
>I couldn't find anything, either.
>
>> 2. Now the `IPMILan` structure has its own `VMStateDescription`. It's
>>    linked to the parent `VMStateDescription` using `VMSTATE_STRUCT`.
>> ---
>>
>
>This looks good to me, I'll pull this in to my tree and pass it on.
>
>-corey
>
>>
>> Links:
>> * version 1 patches:
>>   https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg07505.html
>> * comments from Philippe Mathieu-Daud=E9 <philmd@linaro.org>:
>>   https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg00117.html
>>
>>
>> Yunpeng Yang (2):
>>   hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config
>>
>>  hw/ipmi/ipmi_bmc_sim.c      | 412 +++++++++++++++++++++++++++++++++++-
>>  include/hw/ipmi/ipmi.h      |   1 +
>>  qemu-options.hx             |  26 +++
>>  tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++
>>  4 files changed, 572 insertions(+), 10 deletions(-)
>>
>> --
>> 2.43.7
>>

--_000_BYAPR02MB50296483A143E74433E77EF78593ABYAPR02MB5029namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello Corey,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I hope you are doing well!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Could I know when you expect these two patches to be merged?<br>
<br>
Kind regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yunpeng</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yunpeng Yang &lt;yunp=
eng.yang@nutanix.com&gt;<br>
<b>Sent:</b> Wednesday, January 7, 2026 17:58<br>
<b>To:</b> Corey Minyard &lt;corey@minyard.net&gt;<br>
<b>Cc:</b> philmd@linaro.org &lt;philmd@linaro.org&gt;; minyard@acm.org &lt=
;minyard@acm.org&gt;; farosas@suse.de &lt;farosas@suse.de&gt;; lvivier@redh=
at.com &lt;lvivier@redhat.com&gt;; pbonzini@redhat.com &lt;pbonzini@redhat.=
com&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Mark Cave-Ayl=
and
 &lt;mark.caveayland@nutanix.com&gt;; Jonathan Davies &lt;jond@nutanix.com&=
gt;<br>
<b>Subject:</b> Re: Re: [PATCH v2 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake L=
AN config</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Corey,<br>
<br>
Thank you for reviewing!<br>
<br>
Kind regards,<br>
Yunpeng<br>
<br>
&gt;&gt; Hi Philippe,<br>
&gt;&gt;<br>
&gt;&gt; Thank you for your comments.<br>
&gt;&gt; I've modified my patches according to your advice.<br>
&gt;&gt;<br>
&gt;&gt; Kind regards,<br>
&gt;&gt; Yunpeng<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; v1...v2:<br>
&gt;&gt; ---<br>
&gt;&gt; 1. `is_valid_netmask` is renamed to `is_ipv4_netmask_valid`, and i=
s now<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; implemented using `ldl_be_p`, `clo32`, and `ctz3=
2`. It still ensures<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; the netmask is not `0.0.0.0`.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; I didn't find any related helper functions in `i=
nclude/`.<br>
&gt;<br>
&gt;I couldn't find anything, either.<br>
&gt;<br>
&gt;&gt; 2. Now the `IPMILan` structure has its own `VMStateDescription`. I=
t's<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; linked to the parent `VMStateDescription` using =
`VMSTATE_STRUCT`.<br>
&gt;&gt; ---<br>
&gt;&gt;<br>
&gt;<br>
&gt;This looks good to me, I'll pull this in to my tree and pass it on.<br>
&gt;<br>
&gt;-corey<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Links:<br>
&gt;&gt; * version 1 patches:<br>
&gt;&gt;&nbsp;&nbsp; <a href=3D"https://lists.gnu.org/archive/html/qemu-dev=
el/2025-10/msg07505.html">
https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg07505.html</a><br>
&gt;&gt; * comments from Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;=
:<br>
&gt;&gt;&nbsp;&nbsp; <a href=3D"https://lists.gnu.org/archive/html/qemu-dev=
el/2025-12/msg00117.html">
https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg00117.html</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yunpeng Yang (2):<br>
&gt;&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel=
 config<br>
&gt;&gt;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel=
 config<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; hw/ipmi/ipmi_bmc_sim.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 412 +=
++++++++++++++++++++++++++++++++++-<br>
&gt;&gt;&nbsp; include/hw/ipmi/ipmi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 1 +<br>
&gt;&gt;&nbsp; qemu-options.hx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 +++<br>
&gt;&gt;&nbsp; tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++<br>
&gt;&gt;&nbsp; 4 files changed, 572 insertions(+), 10 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.43.7<br>
&gt;&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BYAPR02MB50296483A143E74433E77EF78593ABYAPR02MB5029namp_--

