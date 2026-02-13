Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E4EDF145
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqq2s-0007u4-4G; Fri, 13 Feb 2026 05:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vqq2j-0007tN-8b
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:04:58 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vqq2h-00029l-0L
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:04:57 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9t6A63534724; Fri, 13 Feb 2026 02:04:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=5Bdlnxg+Cn6D+7C
 d/sFqjzY4WGV/+exrRNc146CtOU4=; b=zGJX3YCZaGwdFrUvr+K0OGBQiYOp+ly
 wi56JvDkieaLlgXgXcUd6pzI3x9/Y7ZD3TNQ364muXFUgs3L8msLXjsDHIi2q2Ow
 gpfGzPTPXNRW7EnXJolf5OB0FY01GKGN3TCt8jVMmqCLJg9T3zbppY+uu3ltMucp
 tliUx7mMG9WzKPFBFyFZeTYX71foUCLxkaiwAgqABFCZJiyddi93xPcGUlqHY7O3
 YIhxvFgssvGC0kZBlx3Wzr8k0ltUMNdT6L8Nnt9wTGlvcHN0KxTI+R8mPgonUxjU
 pf0ViuzEHILUvdhYtdlsQ7LE9w9QRDzyEICJDwV8abDhOwxlTHT6/ig==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020101.outbound.protection.outlook.com [52.101.46.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d6y54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3UVlwoaL+pHEWo4wQQi4n0thirJ0x4WSS2RI7RJ//co0hwTbGRDksotKw+3LHRL5CWe0WGrgy4qriAbYi4OjSwDX4/IHbMCl9F45u/DsEr6BaU1q29es1dAP+uvMSIMrsxkx3axX0gtbivwHm99pmLIkcnIqSkUdPOkUj9KHb4wLfGhVkkBJAsSf+ry331d1vS8+kgQQP9v773YmtMzYviu87CyCjJTAfX/DS5JF2AV5mjMtZ/7TLsVFD2GXzAfEcF+jYHYTdkMstQj5fCMb9pHuqMYfRwnDX/F9F7CbOwSFGIIgXM/XjjX9l/r6S5Q6AtvH5S18DVucXrqf5p86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bdlnxg+Cn6D+7Cd/sFqjzY4WGV/+exrRNc146CtOU4=;
 b=a/dLzAUMUu0wdWvwvb0KHA5eMIw2zjBuIZ+7akbwdIu3SR3gawL6zML+GqtIJErzTCyn3+kjRUx389rBhba8qWfcEkF3B9dhmSfqCtMy/aXhHw5pFBFb/w1IhPRZrPuGCc47jwrP8UzzNUrANtmwFJ0Hy2SA7R0na8jRFyxQ6PNHA8kiSNNjr/OcZb+8vmglOP4AwMbVZPS45LsydW665WCrjty6ITwZWIvrOGTg+gghz+QaOuXnpD4AXKXU1kdfZUcEGrbFcy/XvVQBoWvhF8JMNN+wWfRoc73MSD7BTrr7byGSDNw1d0u9CafloRFldL5ssJLBPpMaczgAUbzL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bdlnxg+Cn6D+7Cd/sFqjzY4WGV/+exrRNc146CtOU4=;
 b=HFNQDyfXGmNfsOPgNY+1l1JmiFx3hCPKFb6ILAJthIQug1Cr9edVK0BtdeESPmMXgudvlKa5DhH3xjslTD8vmo+ZvPeWUdu51UlzlLSVJIW1t3busbCYQ/5GXj8MybEFfv1E1MH5Ngj7QNo7BcW6sYA4TrMOjwVfS7SIpB3k0Bqq/vdFvdrZZ0nr1G2BjaZzAZGV+7Ahe4hWW2q4hJ2I9g0LsXyDPTLiOiIq65gANW8ekvi+r7aq+kLsEExMs0w675Pi06fLnQHBedHDaJaUYpvTwWH2zyvdzV0b0AUNX5LfpMaj0bFuu/Uj6Rk/4Dgy+imXUmDp4gOTH2x5cp5RsQ==
Received: from DS4PR02MB11281.namprd02.prod.outlook.com (2603:10b6:8:2fc::5)
 by BY5PR02MB6593.namprd02.prod.outlook.com (2603:10b6:a03:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:04:48 +0000
Received: from DS4PR02MB11281.namprd02.prod.outlook.com
 ([fe80::da99:df04:abd2:e9fb]) by DS4PR02MB11281.namprd02.prod.outlook.com
 ([fe80::da99:df04:abd2:e9fb%6]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 10:04:48 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: Corey Minyard <corey@minyard.net>
CC: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, Jonathan Davies <jond@nutanix.com>
Subject: Re: [PULL 0/2] Add a fake IPMI LAN channel
Thread-Topic: [PULL 0/2] Add a fake IPMI LAN channel
Thread-Index: AQHcnEbaRgYaOdFQH0mFiws8AxDRabWAZtxy
Date: Fri, 13 Feb 2026 10:04:48 +0000
Message-ID: <DS4PR02MB1128135C162F697444BE11C4E8561A@DS4PR02MB11281.namprd02.prod.outlook.com>
References: <20260212174103.504520-1-corey@minyard.net>
In-Reply-To: <20260212174103.504520-1-corey@minyard.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR02MB11281:EE_|BY5PR02MB6593:EE_
x-ms-office365-filtering-correlation-id: 984b1d26-8ad3-402a-d91a-08de6ae7522c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jbXq749mgk/SopjpDGrRP8zxFEJP3C+HcO3jJhXOZ3c3l6lp2+eilzFhcX?=
 =?iso-8859-1?Q?hn/Aod4wxR0DGzj0X0zX4AjfAClf41iez7okFGSEX5Ya8/Lknjj6jOGR40?=
 =?iso-8859-1?Q?Us49UvfrRSiouGi1dJXttsjBHpQNN1UJJp56SEtZf9f5e6kRJz2Vf0FKcz?=
 =?iso-8859-1?Q?5AfrywoFfxh1kjMLDANBeb2jyva2Y/KlUwFbkk0Ka6UglL5m8YVULSK4XX?=
 =?iso-8859-1?Q?A8TVZOOGnkVyBl1/7CGkzipzDFhwoXHT9Py0TFsHaq66QcIftjdE4fqeNq?=
 =?iso-8859-1?Q?hiEK3xpn6fETNsBcZfeDTFx3hIDJZnNJ4HlII+C4CesZV24dhCJKuEf5Ds?=
 =?iso-8859-1?Q?/H1UD9JSv0xoWo+79MGOKWzlvdbzYP3NzdCvVOn2fbjQsd31jmv94V7eKc?=
 =?iso-8859-1?Q?pnAyx57DRqRPpudp6oBXgDw38PChMq/MxFvTEu5oqUY6xeHfyp8kIsj5hg?=
 =?iso-8859-1?Q?FuDVdEG/4cbaQxg3rQl4y+sGwMnSQGGeMmUWsxwu1kRwKGHcoUKt6QlN0o?=
 =?iso-8859-1?Q?OYHGH8CaB07NRFOLetA/Woi3zFR4RV0F2pFSQW5h+YwnsUUzXggQCU05up?=
 =?iso-8859-1?Q?lmjZkwJJsOGm0vudfWsRuTd/el7q5Q2LZFrLOOtQoGOBBycqhbplVdNdTf?=
 =?iso-8859-1?Q?ztX1In+cKjxbPVCtllOI3xXHedw9y4etBX26sSiLu2JWtJqUc8mGEaLFzD?=
 =?iso-8859-1?Q?yg++k/pkxJEQ84Gkdjp+pAfgp+xyFoky/MEipCtH3i7aT94thEfbj4gKVL?=
 =?iso-8859-1?Q?HkiEmg4Dl08D4VqLmZJtrvLZkWKROe+HRZ5uXtd8tQ32FM8byGFKfl+US7?=
 =?iso-8859-1?Q?s8KYi1gANKsEvGKazsk9PHDLXmWw0I7L+F5iWh0VnO1tisq23U2c1x2sgd?=
 =?iso-8859-1?Q?EnFrs3KjvrNb0Kh8sCbIEvrA8Rrt+38u8Wns9CxVPNwKrqpZByUddn8vd1?=
 =?iso-8859-1?Q?8gwr9YPYd0euCSlNSBWeX37+fiAPM5XfBsiuDEJBXIp4J8biKIHHjOeSjg?=
 =?iso-8859-1?Q?Y3fPThDzUbeyeQPEQ5M21kH1/FdiS276vV86VxxODr+4pcuGkSGSCQph7S?=
 =?iso-8859-1?Q?Zt0038ugKEiFIQVAAia0tPtTcQrtjXvOmyBnbImM8xNFpDiJURwaFtwWra?=
 =?iso-8859-1?Q?eci3YB74kzj0y+cGqWPs8Bh/h25xtLfTlKbV86SzMd690IWNH9fOOX8fu3?=
 =?iso-8859-1?Q?8LF+YSWrUQrDIZVQyRaVFtwxnma8Mxnn5Ne1EHubw2H4raWSMLK0iSV3IO?=
 =?iso-8859-1?Q?n09uPU+EinIb1goSFfhdsToozjmKwo6dOw0vZTyxMBEJYwCmCVyWWdiYwZ?=
 =?iso-8859-1?Q?zqkVNJdsxNdhtzGzyfiZB3Dyu9r7PLqWgwbtfTZerpcS1kdnVuhm8tv9PE?=
 =?iso-8859-1?Q?4qyU2J7hnIktG2xJaRHHi5XMcDFzfWMdpgkA3e8bKxQCv1hAb1IBaG84Kw?=
 =?iso-8859-1?Q?2hSqb0BjhcMOL071rNkKwd632f4UuV+e9l5r9nBCrWw1C4XNlhJ8ZJ36r4?=
 =?iso-8859-1?Q?pLfi4zkn/19PTmlHAvL36UEG77hCx0Ke+futB9HOuiV2ey9oMBVysIBwsO?=
 =?iso-8859-1?Q?2wi8z9HZIxckxVmTw2HOoN7ZcCeOcWkozp9Gj7D4ioVb+byZNuWjeg4QSj?=
 =?iso-8859-1?Q?DAnzEtzvGBNfLtxZl8zcfMGwTvrXIy5aBl+5sodhTVeKPIucsGXNUfWIL7?=
 =?iso-8859-1?Q?lFvBzz8S7KC4cYVSPFTK9Nv+52ZCz4iDqbHLI/5N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR02MB11281.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nAq+VFNn34VWLhFHftN3p/a+C6/VMNlxTgP68GrGftpnI9TiP6/5nGwdA0?=
 =?iso-8859-1?Q?wVsVRFJVeuex0tdx44KzAbHoD8v4ID4etiZToEC9oPq29YOcQh1p1EnaS1?=
 =?iso-8859-1?Q?XZ8d2Zxl7lwphXiZJIsQy/qOWp8nLviM9bbc1mAKIafv755wWC5qzey4Pb?=
 =?iso-8859-1?Q?7lfgE4bg8RVKJ5vUy4bfohb9aDPkG3LIylRab3kO14Bk4IvfvXyNdY+l/5?=
 =?iso-8859-1?Q?ggjYkgxO9nrQyAFWjzz4ISgu8yGNVT7s6BOgHHc/lD4DRJVifHWV1t/gmV?=
 =?iso-8859-1?Q?SuWpn0k1x7fctoV3Tzl/xEoLj2i4i2iWbHUqs7nZfZh+DHNp6DOJHFfp0c?=
 =?iso-8859-1?Q?6X79TAHcNERlqzXtwHq6cpsrFYhRI615TVbdcxMC5wkfyM1dXg6Kdhpo5K?=
 =?iso-8859-1?Q?aW9og1AVTyAIgcOYvS6AZ3XQCFPEAUo0ReoQ3pkqBzMtsY6yUVOgCDkNNx?=
 =?iso-8859-1?Q?Fjmxu86YQ7XRy8rcvAy9WqUu9w79tguLX3nB/hdX+ozNZdCXfI9bc96E5X?=
 =?iso-8859-1?Q?H0SW7iU5Gm2FafWk2bsqFFXkiLalHwyoFE/PCveSSTmkBvbDjzTa7InXaI?=
 =?iso-8859-1?Q?oNodWovwXoQH4XV11jr3sOoHHW0Kh17sy8wNUOnMhQqGQaOB4VpMT/HsOE?=
 =?iso-8859-1?Q?tQj+CXvOaf9ukWygms/o+hn1WF5Xusv6TjGcbRP9iwdRM1mghlJjTgpcei?=
 =?iso-8859-1?Q?szulTCMpjGe9UcFa/uUlc8FBU+cU38e7HahkSmKjEy5rnjy5DmFfsGnNbn?=
 =?iso-8859-1?Q?TGIc0ZoO7bBo84QdaB1OZvj5eC+Xn7gAqz4LK+fmvinTm2m6rXdv3v30qK?=
 =?iso-8859-1?Q?92WjyAjxWUrVXUmtjr1K2Au4zanXZH6TcyVC5lvmM49wbF4JZ0efRQBC8S?=
 =?iso-8859-1?Q?rE6I49ex29OhuoXDHk5LVR6GznfG+mUUTko54pOCNlP3HM9UELbrnNL5PY?=
 =?iso-8859-1?Q?wEy6ldCbryMaQuK/N0dU2utV6u1kk3Va8fxxUn0zGvkTzy1YazaEn3YkVc?=
 =?iso-8859-1?Q?vNdCi5bOiP1HJawFxaJtvdEgDpFx8329SkK21CzCTzC1vAHFPxXJ2TtNdE?=
 =?iso-8859-1?Q?vgyA5TWK8nVzW15iG7IJF0ZlQynyor6WCFTHO4FnNNb/VQXTgepZTSj5eD?=
 =?iso-8859-1?Q?XnnlXgQhslqPS6LbedFwijS6n85bne8YS2TZYQKX5ISbVu80X1U/cjSrso?=
 =?iso-8859-1?Q?a76zUURcGXP1BTDAy+y9MTeUzR887onWad0ILB2ZkLVvhXPcVSIPWOk3rq?=
 =?iso-8859-1?Q?xY96rsuFh/LQrp+qcqmmpQVYGbbEvqNrTDR/McpG9m4WvE9LUqUa/0EL0L?=
 =?iso-8859-1?Q?LBXvf6VgRPiFDkedFBv2HvgFQwvuui2AL1nfbBVtxUGdiIwoPtDdCJ5LpV?=
 =?iso-8859-1?Q?MGIdOCiQitvoKSZCV1+cPEs4NoX7Rll6FeMWsrzg/2OzZT761OTRtvhukI?=
 =?iso-8859-1?Q?MSJ8VVDSKCH8Gl3jodmYinZw/FHx9/eMMySlpoIMe5hgPHmYDTAeXwjHTr?=
 =?iso-8859-1?Q?WNWnB3A4GLfeSm69400htt4GlPV0AXcKvDLZaVEBRR0cFJERMtUUplAazg?=
 =?iso-8859-1?Q?Kic1vBS23ilCWt+o/BCfmCMRssM448TGna8e3L/FQRxdUAv+1Ntfqi2sHs?=
 =?iso-8859-1?Q?SGTenLbMpo83ZVevl/Yq3ZQgdyQrw61XKWXq3ccILmmy6b4ezKvPZIiKT6?=
 =?iso-8859-1?Q?iWq6Bc5vq49h1SMulHp52/y+0Rlgmuua6Nq9biGIVmA/EJa/LS+lbbWzGJ?=
 =?iso-8859-1?Q?fkX0ocVrX7tnlboZSutXDqRkKWI3pby6OI/cfYb9zgNScUtDxF8t7D0Qm1?=
 =?iso-8859-1?Q?zekN6EkkVA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PR02MB1128135C162F697444BE11C4E8561ADS4PR02MB11281na_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR02MB11281.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984b1d26-8ad3-402a-d91a-08de6ae7522c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 10:04:48.1776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8kCQmsFtq7D4XDjOA//XDV2vU5qRw9WZ5OLYhdYH3LynajTALL0Nh1TLljGM5Wyj0RMAiFQBjc4N37+aVweXjRdv/t3ACrtuNb6M7sCzjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6593
X-Proofpoint-ORIG-GUID: pjGSAkwVFvNVcOvODGoEQWfBvPEya2M8
X-Proofpoint-GUID: pjGSAkwVFvNVcOvODGoEQWfBvPEya2M8
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698ef742 cx=c_pps
 a=hSUXT6xmpWUQcPkODs04Ug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=HL3alpDKAAAA:8 a=KKAkSRfTAAAA:8
 a=69wJf7TsAAAA:8 a=64Cc0HZtAAAA:8 a=axH8d69hBE5nhuF2Wn8A:9 a=wPNLvfGTeEIA:10
 a=xJmbjBRapQkXggqhpyQA:9 a=klNzJkf7AM77mjc4:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=KRX0AkppOCwXZa-dNZoJ:22 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NyBTYWx0ZWRfXzKnWfmPOsS3M
 EB+N1M3k2O+eziI2OsQGmRj89sA63Yl2VBXtXrSB9E2c2YTFH6Oic+qLvUzy3Ft1bf918W5vFev
 tNvfNMG2ERMAv/49Nwi6J9ovsn0rTGKuHW/Kj7/VmT1p7tN8+OFz84CkJ+4zhmaX7ObGmWPYoxr
 Dnju8mXKMKtLvk1t1GDeJ29XzbT1o6sbEaenn0fzkvpVvtBGhKKeLAYkMgtaNagJc9OiTdK966j
 PtExbtfGCyvqw+pEy+0NNmrD1Tpl9vgOEFdPjO00bknctKhibhPc3AG5w+fJwp9ThVkhYkErynJ
 Z2hp7S52UIf7oPDm/NVl5LVitIicILfgCTIiO/XbTMzYurSahtc95bF9zKbT7ppr3IDQ+qjwHdF
 njvqJN4rWNLeFfUrBSdMSqWVXMkIZFaGuu+jjpMY7z7hUN6Heb+PJSu8UTDQKKWJpbdxQ+kX/9V
 OYy5Q1Knn3C4NhLUQOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

--_000_DS4PR02MB1128135C162F697444BE11C4E8561ADS4PR02MB11281na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you Corey for managing this!


________________________________
From: Corey Minyard <corey@minyard.net>
Sent: Thursday, February 12, 2026 17:40
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corey Minyard <corey@minyard.net>; QEMU Developers <qemu-devel@nongnu.o=
rg>; Yunpeng Yang <yunpeng.yang@nutanix.com>; Mark Cave-Ayland <mark.caveay=
land@nutanix.com>; Jonathan Davies <jond@nutanix.com>
Subject: [PULL 0/2] Add a fake IPMI LAN channel

!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Apologies for not sending this in the right format.  Hopefully this is
correct.

The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65=
:

  Merge tag 'pull-hex-20260102' of https://urldefense.proofpoint.com/v2/url=
?u=3Dhttps-3A__github.com_quic_qemu&d=3DDwIDAg&c=3Ds883GpUCOChKOHiocYtGcg&r=
=3DgyJEZb_gH0rRUcKZUkVe15Lqy_BoDVLs3C-LhiDdmek&m=3DuCNHd87IKCyyLlKRYXB4g9EQ=
dMXOlb6EbzYIBJnoMJPkSQjXnzu7gx2MwhuhK9HU&s=3DYoRVtrsHH9NYvgRtbSDkF7nIZpkiQQ=
ceTlX42n4SVIM&e=3D  into staging (2026-01-05 07:35:40 +1100)

are available in the Git repository at:

  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_cminyar=
d_qemu.git&d=3DDwIDAg&c=3Ds883GpUCOChKOHiocYtGcg&r=3DgyJEZb_gH0rRUcKZUkVe15=
Lqy_BoDVLs3C-LhiDdmek&m=3DuCNHd87IKCyyLlKRYXB4g9EQdMXOlb6EbzYIBJnoMJPkSQjXn=
zu7gx2MwhuhK9HU&s=3DeLR9j_hI1DKOZYt26SV2qJIiZsaISoX30wQ2qO-n_ms&e=3D  tags/=
ipmi-add-fake-lan-config

for you to fetch changes up to 75c15651af1b2553ff292553545f7a6a56c32932:

  hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config (2026-01-05=
 13:07:23 -0600)

----------------------------------------------------------------
Add a fake LAN config operation for testing

Just add the commands, the proper data that can be set, and some tests.

Submitter ran migration test.

----------------------------------------------------------------
Yunpeng Yang (2):
      hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
      hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config

 hw/ipmi/ipmi_bmc_sim.c      | 412 ++++++++++++++++++++++++++++++++++++++++=
+++--
 include/hw/ipmi/ipmi.h      |   1 +
 qemu-options.hx             |  26 +++
 tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++
 4 files changed, 572 insertions(+), 10 deletions(-)

--_000_DS4PR02MB1128135C162F697444BE11C4E8561ADS4PR02MB11281na_
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
Thank you Corey for managing this!</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Corey Minyard &lt;corey@minyard.net&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 12, 2026 17:40<br>
<b>To:</b>&nbsp;Peter Maydell &lt;peter.maydell@linaro.org&gt;<br>
<b>Cc:</b>&nbsp;Corey Minyard &lt;corey@minyard.net&gt;; QEMU Developers &l=
t;qemu-devel@nongnu.org&gt;; Yunpeng Yang &lt;yunpeng.yang@nutanix.com&gt;;=
 Mark Cave-Ayland &lt;mark.caveayland@nutanix.com&gt;; Jonathan Davies &lt;=
jond@nutanix.com&gt;<br>
<b>Subject:</b>&nbsp;[PULL 0/2] Add a fake IPMI LAN channel </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">!------------------------------------------=
-------------------------|<br>
&nbsp; CAUTION: External Email<br>
<br>
|-------------------------------------------------------------------!<br>
<br>
Apologies for not sending this in the right format.&nbsp; Hopefully this is=
<br>
correct.<br>
<br>
The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65=
:<br>
<br>
&nbsp; Merge tag 'pull-hex-20260102' of <a class=3D"OWAAutoLink" id=3D"OWAc=
19bfa21-00c7-ffd9-2cda-1f26293c148e" data-auth=3D"NotApplicable" href=3D"ht=
tps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_quic_qemu&a=
mp;d=3DDwIDAg&amp;c=3Ds883GpUCOChKOHiocYtGcg&amp;r=3DgyJEZb_gH0rRUcKZUkVe15=
Lqy_BoDVLs3C-LhiDdmek&amp;m=3DuCNHd87IKCyyLlKRYXB4g9EQdMXOlb6EbzYIBJnoMJPkS=
QjXnzu7gx2MwhuhK9HU&amp;s=3DYoRVtrsHH9NYvgRtbSDkF7nIZpkiQQceTlX42n4SVIM&amp=
;e=3D">
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_quic_qemu=
&amp;d=3DDwIDAg&amp;c=3Ds883GpUCOChKOHiocYtGcg&amp;r=3DgyJEZb_gH0rRUcKZUkVe=
15Lqy_BoDVLs3C-LhiDdmek&amp;m=3DuCNHd87IKCyyLlKRYXB4g9EQdMXOlb6EbzYIBJnoMJP=
kSQjXnzu7gx2MwhuhK9HU&amp;s=3DYoRVtrsHH9NYvgRtbSDkF7nIZpkiQQceTlX42n4SVIM&a=
mp;e=3D</a>&nbsp;
 into staging (2026-01-05 07:35:40 +1100)<br>
<br>
are available in the Git repository at:<br>
<br>
&nbsp; <a class=3D"OWAAutoLink" id=3D"OWA3744950b-7293-5116-4e9d-f9b9678a8a=
de" data-auth=3D"NotApplicable" href=3D"https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__github.com_cminyard_qemu.git&amp;d=3DDwIDAg&amp;c=3Ds88=
3GpUCOChKOHiocYtGcg&amp;r=3DgyJEZb_gH0rRUcKZUkVe15Lqy_BoDVLs3C-LhiDdmek&amp=
;m=3DuCNHd87IKCyyLlKRYXB4g9EQdMXOlb6EbzYIBJnoMJPkSQjXnzu7gx2MwhuhK9HU&amp;s=
=3DeLR9j_hI1DKOZYt26SV2qJIiZsaISoX30wQ2qO-n_ms&amp;e=3D">
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_cminyard_=
qemu.git&amp;d=3DDwIDAg&amp;c=3Ds883GpUCOChKOHiocYtGcg&amp;r=3DgyJEZb_gH0rR=
UcKZUkVe15Lqy_BoDVLs3C-LhiDdmek&amp;m=3DuCNHd87IKCyyLlKRYXB4g9EQdMXOlb6EbzY=
IBJnoMJPkSQjXnzu7gx2MwhuhK9HU&amp;s=3DeLR9j_hI1DKOZYt26SV2qJIiZsaISoX30wQ2q=
O-n_ms&amp;e=3D</a>&nbsp;
 tags/ipmi-add-fake-lan-config<br>
<br>
for you to fetch changes up to 75c15651af1b2553ff292553545f7a6a56c32932:<br=
>
<br>
&nbsp; hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config (2026-=
01-05 13:07:23 -0600)<br>
<br>
----------------------------------------------------------------<br>
Add a fake LAN config operation for testing<br>
<br>
Just add the commands, the proper data that can be set, and some tests.<br>
<br>
Submitter ran migration test.<br>
<br>
----------------------------------------------------------------<br>
Yunpeng Yang (2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support getting fake L=
AN channel config<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/ipmi/ipmi_bmc_sim: Support setting fake L=
AN channel config<br>
<br>
&nbsp;hw/ipmi/ipmi_bmc_sim.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 412 ++++++++++=
+++++++++++++++++++++++++++++++++--<br>
&nbsp;include/hw/ipmi/ipmi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 =
+<br>
&nbsp;qemu-options.hx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 26 +++<br>
&nbsp;tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++<br>
&nbsp;4 files changed, 572 insertions(+), 10 deletions(-)<br>
</div>
</body>
</html>

--_000_DS4PR02MB1128135C162F697444BE11C4E8561ADS4PR02MB11281na_--

