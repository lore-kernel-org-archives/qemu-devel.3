Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9644DC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloWV-00053v-NG; Mon, 20 Jul 2026 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW9-0004pO-8X
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW7-0006a4-K3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:48 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDq7K7587428; Mon, 20 Jul 2026 06:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=taSwb97PtJK/d7URjCNzflFbiBGWh5zvljg1/I9Yd
 Zw=; b=1pTBePFZpUhnWWGrxGY7J/wVJtAsy3+oWU6ClY4XWxX3LXryXXj80n07H
 cU+OU+HPONOGdC/s3ebOarVXcRN1JP5j0a0I5rVJVo99lkGCmhhi5O2O2SrRYw6D
 rgFVcBi+Bb0Uvy20YmFwD1/QUGoulKEuQQ9h/D/8XFmZ/7M+007qHEaH36PN0C9I
 4pOQcWc4PGrNKJgAzNFgJpYQe5heLquyQuypIpczSIxEs5ZMnOHmUFYD0zE1UUIE
 8iiBQJLlmhiTUpWuJUiHFzRIw6NsBRHEDArAbewHqWmcpqZMjc1PomDvMbzf4+L9
 OI4+m7ydQY5SSmuEG9zRBeQbdMnjQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020117.outbound.protection.outlook.com [52.101.201.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8tbkdru-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmaVLOMVF7cKksutULQNLmHHbaXdjYLwxI3qRcRe1pWl63FMeXpOqwOEkiS95cg74k1J7Lq/A0VrPMCfxTzTY11Yt4N5JaxaMBRjbrDuKclILUbdaI23psPhrtjK0nK+PUaoxaNcMUJjvMmZxtp3/edT0SczKtCKXqvwc9L4fz5T/XbBfMFZy3dcwftrAB2f/rhocvpSTGc6a5/6ErlEz01E5B6cpT94lqjrc7qv4nIe8PIoSDO2gI2W7FSwy7k0Bid3Z17isnq0soOGP3uLzS3PQ+cKCgMO0N+RJC8LxkdQ574xyu5DQrPcn9Ha7lOqk9li7NSF8SLLXQI3fHx0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taSwb97PtJK/d7URjCNzflFbiBGWh5zvljg1/I9YdZw=;
 b=D3jNyW6tYNtVRmFm/t3FvYqn6FvG6UnRUhgb9xmGwuuLTiJnHEjmcyQr1BEu4ZQ/yykt5CQP6GuPoF25DgqBl6DApiUpad0q5u0UumD42/b/kp6SMdNFrtAeKhVrAWRwVLCxFIoOjh1BHWp54vyn7d5vBSco+cAQnllEIPBrfwg1qp22syuDeEkZ2SAZ5Vur3I0mPzK4cpuVWr0N6RfjTyOTRlkEBHguUWLxEYnWMB8LotJgBH/ZfDiN34uOKHiD1wzMRmfoiW5leJz66DnBOfYX/AqLBaz86XD0IUkw/RXZH3qWfkTU9PJ5Czxl52sYYdZO2uuoG8SV4fVCQUtsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taSwb97PtJK/d7URjCNzflFbiBGWh5zvljg1/I9YdZw=;
 b=pSSSqFJuqM9w645qCDrQqryAhmm9mN0+d9cDqOdbY3nM5hFWUTKBUyV9LS0eANR0pP9pNqMlbO2v/ca0PnL9mF5Io0rJrlGaiNMGjlb3O/FQopBrnVNC38PZVo+Njc6nlXZn4JbSj+no27fEv6Bfs/juESXC5Nl1Cr9eKHETDlj12TmF9M+6kt8AeLszgXWpTGpRZyHaS1c2JbOcbEGdPgu7kf+6gyHQLjjU+tzm4PxvjNoUUxjrxjXNDX5xyed4G3m8Sc0NR+D9oTENmCxO24yWAdJvJuNB/pvgwmURufoc+68R+HaQ1Le8kHGp1zKpjO/uw+B5WUnngRyVeCJzsA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:45 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:44 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 5/6] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Topic: [PATCH v2 5/6] vfio-user: vfio_user_device_io_get_region_info:
 fix capability check
Thread-Index: AQHdGE/h2BHcn+9wLEi6wXUrwFnDcg==
Date: Mon, 20 Jul 2026 13:58:44 +0000
Message-ID: <20260720135823.21070-6-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: c0e5ba22-b9a8-4195-3a10-08dee667038c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YBQkwfyPzHzQiACbo59WA18TbxGo9WSdtEWCOqEOY/NpuffQwROOoaAIKlEaUond23MhgUxcedauW05KRlSB8XettV8zn0PtCFBrbpYk/qxn6Ldhq087T2cXR1LYCX+o8z9rEffnTaAGrE7w6JU6Pu998oiKgOkEkLLanA0QP+BLdzeKfmBH1mLwWxjLC3oFYm13fTEtSmiBeyL+PnTksq5fI2tvOsBH8W34ysFnfqthRQ7IW/VHyGDZGvMIiTvOcywdtE8pbZfKgl+6jyAsEU+s51cB69rMpPGzLPhVWhu5j3GLwrI/JhXTqdxxFzRHgBu3Ds7l7on4tZGeY+rHeYMpB+cKlKS5uMO3QXakomvO5CfIsbKi0AyDDvXmxwubO5AZQhKMJWu6hgDZqYf5Yc5BJi9b0Fx7NdG4LctFXNv776N6hngLk8jF7VyQhalxF2+9cjgLcnxJieZRJvLvQ3IQVZzC/hK3UtiKqEXRkU+Nc8ze6TZkmwfjHnUD0DZUfY7hl0V1rCBTpsn8HwP87NNbJdGHHWC7LlrMES6AQXpAgce9CZtZWrKasSnJ7SAC9sPOmitPMOxT7z97atSqrj4GZpsyO3w3XWEpnCyG7zyPUL9m3tGP63/0firJdBlXdzFRss+ttfgpfbs3UKIp8vOpE2IMkZBufxeketWp5x/z3zDDqcYF6a1mHPzgFkILEV+7fwEp/p9JLz2mYnF2SC1TyVst/pmkiPzIau1fsuc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?onQGZHxmPViA8nQx2JG3qG/SEL1GYdS6LBIunG+R0KN4NCWvNpXneVQX9x?=
 =?iso-8859-1?Q?yHSW3yuhAskJrhbgMu2GamYg5pluIt1WW22YDVKbM4JQtGX3zzVlpvSlFI?=
 =?iso-8859-1?Q?duCXYCUh49RM2jFHtwNp4jrMPwyHlLYJEmIpbIli+P60sRWhB390ZW8j6q?=
 =?iso-8859-1?Q?eS10LL44WqO8v9Z1Joc6IJUstZJI6mUK280IwnNv5HYYhYIqwI5ghWYTJB?=
 =?iso-8859-1?Q?EnbW5FpUJV7TufSEiarEEcEUGFFbXep8aJgoQ/7VXipr4Q4ied2nq53Vxa?=
 =?iso-8859-1?Q?S3IaSLO5R0mjUStVqzXz0Wzww1A5Vn34iLGo/35Ud3lre1Cpidbq8bz5Gb?=
 =?iso-8859-1?Q?HVATm0/Bt985c9fCPFXC1U3HBwmnY8MOyGCtTLVw0hQmqJ+AIs0J7/tuHv?=
 =?iso-8859-1?Q?s15kkWF2Iw+0ts4l1mqOr2clZf4+ypF1/l/5sXLGEWxzeQjn18jGw+/oal?=
 =?iso-8859-1?Q?6SpWacqfsUgFDtNidRn3DRS8PrH2hwxdkOTboUlvZtcVsVfrSQr2dh2QX/?=
 =?iso-8859-1?Q?rRPF1Wzb1t4leF7j6OuxhtfF7KkmcPRJS5j598h6leHHsgJ9AwV2qKsvgY?=
 =?iso-8859-1?Q?HzmlYYTAEGOONitopF0np6aQzJuWmbmuxeRYEYWJ11o33wExW719r86CL7?=
 =?iso-8859-1?Q?EHa9t59EfyYRrd5GekMlVB68c852+7mSNzoV0jnpDUQgTHKF6+8zmVU7G8?=
 =?iso-8859-1?Q?Pv1ZZVWvE80Ux+wnJ6oY6VqNumVZ3GHqy/2D8pA06/RI4hoJttE194DHet?=
 =?iso-8859-1?Q?S8LZf9IC/cypsPXA3cdn1gNo77JuHXjVJVOsdkPSh4Igi4Wp3FLDM078o2?=
 =?iso-8859-1?Q?M+Ox45Y3iexDcrcsLXGuW28F+4eRASU4Yj3alHe6Dnxr/gR/zrq0ZLe53f?=
 =?iso-8859-1?Q?ma8pZKYxrzXJSDYqHryQgkXD2NDtwphqHLL0F96lmrElcd00zBo3onkKrf?=
 =?iso-8859-1?Q?L4yZjRImpEvTnAPknX9hQnrBJjNvdJHd/5NpVhO78nPWS1gxXuAbjrl5Me?=
 =?iso-8859-1?Q?TFELBbN3bhVPbjT+jAdQBkVuxRaMa5TY2r/FAGvr8YZqHcNref/DM3JNDz?=
 =?iso-8859-1?Q?ivQi4ChePMiRpAJZBl7tdCMkyLj52FbnSsZ3gGS1RCcSiibAp1jIAKMlQK?=
 =?iso-8859-1?Q?YmzgQ4b9UQGyOhsN4yBkFO4UR0i+7o74zBFjoRN5dtlILShHQE5TD3yk+/?=
 =?iso-8859-1?Q?kTEJwgkNbNCqC87JM30+XphaWfTP3PUSQIq2RTH+YYP0EtBjuEy/ZGp5XB?=
 =?iso-8859-1?Q?OxHFqFmgbC77DJeAURQqK3cgD+dhyNZ9TkcTaaZuj1GgBBBAuBS1qmqsNR?=
 =?iso-8859-1?Q?UqbPhJgbdvgpv2bEvg6rmkLctECXDGzBJTJ0zSFZrscKgvOQjmJ2fYjeRI?=
 =?iso-8859-1?Q?wHy45IztD/6tyhbMThwi+QymtMEyRc6tu2ysGCSGZhNvOX0D12ehB+mJnk?=
 =?iso-8859-1?Q?IMCjvjycKNQtDXdLHORHbZxhKX13gyZBOE+XA5b37uHhplergfQZsmeg7o?=
 =?iso-8859-1?Q?0lSDL4C47pergh4bcJsTGEQ3HD330pyL0VEI3dCGHVIQ+VVnfU/tA/kZxz?=
 =?iso-8859-1?Q?KWOIhHkYE0ChvQnLZVZiY10X1BqLneRQp94a/N7kl0RWyytG43S+Ids8Hk?=
 =?iso-8859-1?Q?VKqJm2WN/T0JpshDj3+xfTwr4c1ZORoB1lct4mVbOrBKFXVwNmG3arKkBM?=
 =?iso-8859-1?Q?MTCwmc5xWk7zI6kpcMNb9zzRA3PDkXa2vg9hYT0ZyE3oXcQY96DeVMpMa8?=
 =?iso-8859-1?Q?3BHnSRmD7cR7SIj4VW6Bp1sO13NxMLIDInyVdK0KkF98F+bxFrqGxosivm?=
 =?iso-8859-1?Q?uixmvI1oIEDNfovHj221wmSOwzlRzg8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YcjeGdOg2AziB9PWoxlcl6mVun8I/fdvNX9T+JOVNmbtGfy/F19NLKy+3PlPqPnqOvEWKiP94cuxWOeysnURDtYsrayiqk//o9tKVp2hLoEOvHLhmkpWnlhb91Xt0s9izPy/Jpb5RcaT+fU3N6MDcxbC7x6fM0rFmVZs0s80ynkrJC8J7BQEIbotNEN+u4/IElI4TmLVVm04JPGfc1nyDv7Qz/dLw8+6RJ5n54tLri8UzHuVCh0DpJefIFkPJIx7o1USm0xyYsB9vDFsUfzrZnjDhgkdMXDFN7fxD1u4FDpNSYh4BXzvsTuy88B7XQE3DBLokyBcmCLThLsmIduI0w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e5ba22-b9a8-4195-3a10-08dee667038c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:44.8510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Y40cpE9INpFx3QgAEjJvWdYfH6Q/EkywqcIGeu2Uo6W16P6CzJhd9qSwuU0LZuGRJdkd7qElCaGdPvvT7l4jqy3hvMik4H4xIydVW25r+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX5wj/KICseHof
 47CzBtX3doRZSw8Qchq+xmdV0DJQKZwhJOjVaSiaPkNCtnKXeGvcV8hoGEYDJgQld7CuygioSC2
 0/OP4VzWGmnlQsa+bYoz1LhBeP9lZ5+2DG/UOu8cx0peiDAs6WftzkCl2y0zw1WiOi1WGdvDliY
 r1ZW52YA+IY80p+3B4Mi7DtCeZHQWeAexnn22lzIv/Va+egK56xkfB9nevLRYb9qpGSwE4qIuYB
 NDK//kWVz3Y/dhyx5/GsV+kBF/LQgpEmQRuAN26f+Lt4ADphPZnGM+0PViEHzOPkWdN6WuctbAO
 0uFhUo5oC8jnSSeNbU/8a+qtLlWTgH10LtSUm4R1Pn1e3MGJ1oZFoh3aTbZi62oa9MVDZDDVs3A
 5S/Ceb5rFRgvqHS6AKmbe57FQPJvubHqKHAV7HmdKpNxbtu9niQWdOeGLRnRkqybli6ZB0SDHXD
 t3urZaPyvLSZa2chLig==
X-Proofpoint-ORIG-GUID: tVpPTvhxG6BrcwUkT-vGqUKxxU8z5mAG
X-Proofpoint-GUID: tVpPTvhxG6BrcwUkT-vGqUKxxU8z5mAG
X-Authority-Analysis: v=2.4 cv=ZJ3nX37b c=1 sm=1 tr=0 ts=6a5e2996 cx=c_pps
 a=DiLq/RQzOYCy0eeu/ZkwIA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=nq76yYeXid8ee0yPedAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX+Hu3MoP44gEs
 +8+1t4LKDPRKsCijjSycwnjATOth2cGcAU7vAXc9GBUlh3aMaezU32XUKDUeY7Rt2JN+tqOiz75
 TIv6xU+eeoaeEYFctj/bkgAN6Nms5Z0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The existing check for PCI capabilities misses the case where=0A=
info->cap_offset =3D=3D info->argsz, which results in accessing unallocated=
=0A=
memory. Fix the comparison.=0A=
=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3865=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 008e5cf687..67736383b8 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -214,7 +214,7 @@ static int vfio_user_device_io_get_region_info(VFIODevi=
ce *vbasedev,=0A=
 =0A=
     /* cap_offset in valid area */=0A=
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&=0A=
-        (info->cap_offset < sizeof(*info) || info->cap_offset > info->args=
z)) {=0A=
+        (info->cap_offset < sizeof(*info) || info->cap_offset >=3D info->a=
rgsz)) {=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

