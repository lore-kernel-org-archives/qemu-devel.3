Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B188EC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloYv-0006No-Qe; Mon, 20 Jul 2026 10:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW6-0004n6-Ai
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW2-0006Yo-8Q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:45 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqSXn548166; Mon, 20 Jul 2026 06:58:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uXFMfxvzDSC6inVch1e1f32kMKhvReSqW0rPZnN/V
 c4=; b=EaKelVe6nJRN83YcpzVUDgz7LQMCP6hwve1dSlboeVwDGHSwaQOcrT1Qu
 vXOlS/VlLmJvzx+WszCcSgn9cBNaWBQsmhAhClvqk/Xyk9Gah5SK9IDgumOVL28b
 7beRvtCBF4sVrwzB0C2LAmQIut0HVbPEl3HbKskTA0TAlBL428SKZpgPS4S35ejo
 BoqI7Sk8EkLqCpkOh9d4aY3NNdem8n8QtmB3k65QGBEYkfJIHfTDSWrra/f70xQP
 2JB752CxUD/OMRLu21VCj/sBZaw1tgZma8zEKKtBWPVst16iP2qSjRNY9cbrjmdd
 Y2tKcwW5dx1soZSP4brO8Bt3olxVg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xbckc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTNw784Km4SwZlpKFaf7RxZujDolcX6LQq5rsqKRlZwR3g2VPQgP0LZmf1s15of+ZKnOkLlSZ+Dfgalfsu2wu8I4DE43SRfc1W5HT8cE0o8RubETs9h8ZmqgkRLnRPkmuVljhRqox3vjShwEsB7peXxdcpIW3vhTQqYhRV7vUqliuToRXjqbX+A8V2xmUdkpMpo+85Gq8DPu9SPiuTFPyRykyMg5JxX+YM+0HPIMDEY5fe7q8VZVoNtdQCrbJbqmG093jYIfVlAhVDIRh2tMQABqWHBZiMLnBuR//eDg4T4AHqdZHbwPd146BIp6Nw03151bdJEjr7YeMMXmzLmCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXFMfxvzDSC6inVch1e1f32kMKhvReSqW0rPZnN/Vc4=;
 b=aCr+PFpVDaHulog+pMhtkho3EJS6Vw4LK8sMtSKVtJHg4K+2fe+Tb5TpRYREzJbKMhi0PksWmMgW0RuXy++ITEqyxGDM8YJuVXtmYmtqifiva+J0RHkZ01+RCTzepoYQJ0OGkBMw8gfCXH9FV8sk2XxZP/m0WE6MYyqQPVQ3XMv8wDOf5IJxrNOEszdNkD86ijiJLfsePGwvdBPWgWnLb/eQpnh+2oKXDK6KtxmAtF2fGc8D6tqMHeEUiNzrEQg1u7lYqMfdxm8ghdYnyQAlQGQMMteveOG088mQBiBWLSYi0qJU2BnnW2MYCPRRDUX2X872UmLkXi+Hjr330HUKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXFMfxvzDSC6inVch1e1f32kMKhvReSqW0rPZnN/Vc4=;
 b=DcplDUsaiK3qSHjnPCjoLPc6XbddZ2on352B2l+JnNX5fhW+76dMH3jU/CFPYH8mhmU3xFNt94K9DD+LYwsg+b4hLiXhCpPsOd9B0lIn6X6Pfs8lVf5DT+QlapXW5M+2wPLzwjPsV7dqn36Ti+i3q3ljP0/4kL6u1VUzWrYH26Ewq+nqm/xYYvaR5LiIbT3uuyiQIMN4tA3BMHw9zmRmPPyNjJfoyRh2c8dkAgxy3fzzJPdCltsQVwwGQrKhV/VNqTgFNXNBnDuyfCej1fU2Z+J4zQ2qR5FqxWtYFPKJ1TZxsI79Vh/JA7C4bo8BWlsBzMLuBtsWFK930wU3LKRZeg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:37 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:36 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Topic: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Index: AQHdGE/cu9eFH+JTE0yfU+CZbQ8hRQ==
Date: Mon, 20 Jul 2026 13:58:36 +0000
Message-ID: <20260720135823.21070-1-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: b846531d-7724-4205-29d6-08dee666fecf
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: nrf7kuwWuGsfDKAD6Tj9t9vppNI1d5HjD5ilbtw/sBSncz/xQnSw+zIIdMAMN4UcNykVfXrt2tHY0J2TVBgJcmpD9P+BICdumW71K0p9iNCaJ0u7uvX56poCgc8dnVQjtSQBQAQ/LNPYVQa5marMBnzEti0sI2yxxhiMpIXjkXIYP8Lkcp5jeUWzkGVIc/EYxP/W+7GCc9YHq4FRrN8DhxNrQgxyIM3AHk0XlUI4t4VYd7ZfwIfeJq4NtrMcWl7oNB4dIqmvr5oarXSd+Dd9UvG1PI4OdeY0MoRD6xpU9CCMXoI645GYfyNGO/qMhZaDMUKCDGTtgnBB1XY+1DDo7Isy97CYq+iU7moUAFjcXhBl59duUo7fHSdCtptegQVWmX968RGG8CcTz0eBhJGJygati2iLH9XL7FtUF2fqdzdKGftxAqNelj3aRQpUurZLlAOdlALX59c8XMeeILMtwJchAYBiTLFYTISWytDy7OuPullAAjMayCvN/WnOIuhb9vMV/Kn2Ycn1MoDxANxw1drtAPIQe3LX8wgKzw/6h5WeHuahudNDdZclA60JU2B7/Y6GFT8Y0mTb5ilaXD1RlWhZ6fyD74IajO/MKG2LqnhDErABcBKh5Q2p1O3+eNsWbZhq6qwtQ8YcHo/yL0AkPaj6ILwa2Fd4lVpW0CnuWhfQCYRFOTP0z2hkjz2ksuvIzaD0cYMYee79WxaaW5cNPJ8q4httLBmIg175+ExfMxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3kswsg9MeBbcn4fOaWFiVRXw8CvIfrylhWDrpNDyw9UDT2TI0LwPVMT7ip?=
 =?iso-8859-1?Q?4otE5bKmOyd9KTuuA67Uvr7OGgmf7TRXV8ykU+my2/Hx88sbchxNZkXRpO?=
 =?iso-8859-1?Q?QYAwCfPrfPmcxDR3Huu6jk4wxyrGIUTHr2KqVq+xOeu3JspiP0nI+wIJIP?=
 =?iso-8859-1?Q?sL4a0m3YLfDAX8E8ZuhWrhzFXFTwv3q/zUw1U5PXVSVzjRj+8p49osqqdT?=
 =?iso-8859-1?Q?1G8PZ9tX3aybbm0myySUFd2KqDE98vEEuPurET3f62Iz5lqIaYtOcXdspA?=
 =?iso-8859-1?Q?7FnEfpns/sf5Yn2gmu11MI+tqiHgP/lB9++xWS6irwMa/RbQqBp+BHV51L?=
 =?iso-8859-1?Q?IizO2rQBPQvF8e3LjFZ3dr/S26G/Ffja8VQ4h9ev+rIHjliiqUB6Pq9FcF?=
 =?iso-8859-1?Q?0Pvtp9c1Q18LMDv8TsGhFubOpGo9QYNQ4qdLITO8cVdjSY79FBg9FbqoLm?=
 =?iso-8859-1?Q?VpwOKMpEsdOBukiYp/DZvEJjixe5S3zvlIAvGS9vcc8ENc8nCaQXso3yED?=
 =?iso-8859-1?Q?EmaXXfsmCgRgDSZqODfHRa5kKhEKu9o/cEcka6XeJeNwjn0umQuqW1XRId?=
 =?iso-8859-1?Q?O6ekgVZ5jqdBYUIN5TjjepyuQAstGNZqXxJ3vKOefd8nt0ymmjXmf9UHrC?=
 =?iso-8859-1?Q?fzb2hAYDQfnxEF8kcG36O8FCV1sivbPjfiFICyXG0j/NzKzhEGnE7vtEzh?=
 =?iso-8859-1?Q?Jim0Wn8AXx3hOfzERF/1Auz8jd4s+WbXWs8MVhorS9wi3mYydjcNLwtKpC?=
 =?iso-8859-1?Q?uXKwnraUsxjHCBTqEZnEgKt3nDwewg1aSw6ZCEG+mo5ID5ddHEhZGRqRha?=
 =?iso-8859-1?Q?vk94YHJyGOR5euNONYtkHHQ+tBkuegzbyewLeTzKgqjKWFaJZ1n8jmavf1?=
 =?iso-8859-1?Q?2ro5A7ajEBkwwnhvYSG1Lbmepwl3Vdsb+WSiLNRvNXs98q8bjA0akZn8lJ?=
 =?iso-8859-1?Q?M12TFdhOXpd7BE1H7nj563WuwYmMsCrFy6p/3AmLK/bTzXwR2XA9i2YsXK?=
 =?iso-8859-1?Q?FOtuSImDJAwpyPI+LZK8RLxiBxh2DOogXlN0U6Sk3aSdtyF2wdktAqJMrR?=
 =?iso-8859-1?Q?Usl9l5/CyE0MrFTQXFcLhd8yLBuiZIybR4Dj4mCsFD5lrbaI0c0wXhdvBp?=
 =?iso-8859-1?Q?Plr/whzdJV1qyIG9k2EvVHUR6XoL2q0VVn+767bVjKFCZZw+QFf01UzWeb?=
 =?iso-8859-1?Q?B1hAgDXh/FmWDlHP+ExyxaoiS6pBatWnyfqHN+FJxphQprlQZIlsOgWMmg?=
 =?iso-8859-1?Q?Lk2PZ+3fGS2TYsB1+u5u3Hl56q66NyDRxUv3p4gEf5kw9ILkGwMjbuhsL3?=
 =?iso-8859-1?Q?MaOVEksH3Nt5mjJZACoU9o2E3woBB/75QzpSkM31MoMIwEodpbzruw3qIt?=
 =?iso-8859-1?Q?LpV3stOfmcBNZeJwFpGRe5Um0VhObO146iZcS+GOxF/uj8QiPMgchorxSJ?=
 =?iso-8859-1?Q?rn9wzS8q3zAfmNJHvrIWpX9FAIE3sFr6a+LEyD08KEtbQJhZOTHgbBxo7a?=
 =?iso-8859-1?Q?hznYH8eFw6pjKRG4LPa+EiXGDihql6+C7R257L8V/31pK/YMRl7soMpmX6?=
 =?iso-8859-1?Q?Z3NGy9un886K8qbViDgMTwId72JAIQyX1RO8F0FiQdCngyn/P+l4M95yG9?=
 =?iso-8859-1?Q?4Ti6ZSRKeL/ZjWJsce1Xvp68F8qth4NLvnSGWZmBrrmOFBeTq3ryQk+pGY?=
 =?iso-8859-1?Q?bOs9XT0XTSFMxJ9FCogdD9wr9VjCtb/jmvoJbtNo3EpFv+ZPC5jWRtDYML?=
 =?iso-8859-1?Q?PnxYUcWRx2KXrxptovYJ1r3Gez5jd6dMtc1YRgX41KvAio0Ytb/ZMkfcP+?=
 =?iso-8859-1?Q?YizH8UvCsHc+LaRZ9cDygf34j2QzEBQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jmtWR7t/0bT7YcdnvPSWa9qqrVpTvm8xf3CJ7pC4GYObK/EGj2xJ2U//jrARwC7NgQecdTZzqiwMHdV4wZcOkv9iFGIuIDFkqpcDzuQGfPZYMPcjkcCYghLgLC4l0q0ZQivisi+gORmdVGvVT1i7MysHDn2D7xRx9Eh4wEYeLRBSuiswC0Dv0Z5z1L4KIy0gn2CF+2HDRH63JSf05x2Da+CELKZ5pGwjrSMckgoI7VsHDnFOwSXDiKMcwtPSSZGkVNEn1D22x4zyZUC8CYpxkOUYemEtVFHTSUn1wJfU/iAkZrt+PFvW7g7M93Bzi//ywoVHD5YQk8YUAN2wToGcVg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b846531d-7724-4205-29d6-08dee666fecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:36.9157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vv3fzK9mNlP5kg2CZGXUmOrMrSln2aMDzQUU2MAl6L+qOoD2JigmKfURr77X6upoNxamR8Uemze+iTAqnxFbYl0jJ1qDbyw/PqTiEfRryPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX2F++xzuvKpei
 dcfUqa2Nn9zLeHlOCKKSMMsbYcl7Air7ryKZBEB2K3mwcCdP7R50XAikHy3HJtuGUHFdFWyCJBg
 s6G0u1FmCIWmMp4WyWdfAYYutzVHneQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfXwjOuKuhSdsL/
 DdZYeIdch4dnaLvXTvMtUIOfWAro/RQoSnEFf7uq0TbwBNmYZQJByL4w8HBhv1gKbpsFMynDYTl
 oNfcQ568vuP0v9irrZEB8waePMoTkbkZDirSa1lAGmuxEA4X1TOwgUWpBxuL5PW/LrerQN75dYM
 fboSn1Vm1GKzJOqrruOZsWQnjMLFZ+bdecM3iolWRuaSH4ILHHQlbII4ncibmh7w8D4H2qW9PMI
 9//+Sy2RS7t3PdxJL5ZY71nyidV34I8F6BhTKRwCRdVpE/T5R25L4maI0x2GiZVJ12GDHqZYf2+
 SztUaVC+JHCdrsLl4obiBLoNEKlLF+JXvtS8pwwrU+WGN381djnc8vv3TFhv/hjbLdrnYubyAPk
 w/vCJtgvDIvKlbWVSkkpGyg/5lBR+ODZp4u5+Pa676fG8V28V+amuCULJisFkua/dusFvW3S1ec
 d58d+9RudwycO5L3XgA==
X-Proofpoint-ORIG-GUID: PxN2WuIAwyqx5Hb-uc0Rv4gUaiVBgQgF
X-Proofpoint-GUID: PxN2WuIAwyqx5Hb-uc0Rv4gUaiVBgQgF
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5e298f cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=2sZVQdwPqDbLieFrDCcA:9
 a=wPNLvfGTeEIA:10
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

This patch series fixes some bugs where the vfio-user client doesn't=0A=
properly validate information returned by the vfio-user server.=0A=
=0A=
Thanos Makatos (6):=0A=
  vfio-user: vfio_user_get_region_info: prevent buffer overflow=0A=
  vfio-user: vfio_user_get_region_info: respect max_xfer_size=0A=
  vfio-user: vfio_user_get_region_info: reject unreasonably short struct=0A=
  vfio-user: vfio_user_get_region_info: prevent excessive malloc=0A=
  vfio-user: vfio_user_device_io_get_region_info: fix capability check=0A=
  vfio-user: vfio_user_device_io_device_feature: prevent buffer overflow=0A=
=0A=
 hw/vfio-user/device.c | 40 +++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 37 insertions(+), 3 deletions(-)=0A=
=0A=
Changes since v1:=0A=
- added 'Resolves:' in patches 1 and 5=0A=
- added missing SOB from patch 1 =0A=
- removed reassignment in patch 1=0A=
- added a new patch to address the same issue as in patch 1=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

