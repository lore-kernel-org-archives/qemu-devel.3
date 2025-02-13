Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D43EC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 19:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tifKb-0006Oz-PI; Thu, 13 Feb 2025 14:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tifKV-0006OF-7w
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:57:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tifKS-00022q-Fu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:56:58 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9WUln015774;
 Thu, 13 Feb 2025 19:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Hd7Zid+ehTHOBEEp5KhCUF
 Snnj6xcPdbkeVw1j6oa90=; b=lzsz3NowOH7RynjhL7ZFW6sEwW5XKpRQw5H2j5
 e1N0cuEQ0QWUWz0gJg7CydmfsO3N1hIJYC8gq/2Omw/1hLA5POE/73xyEX9K00/I
 qNu1OqVoyyF72K0T/3R2I/OVYCvK+a0gkJpoT3ClPgdTQvo8bijR711md8H6me5U
 9Rb0WpUbAzzaGnDQo5wSbXrHKJWomF00hsIw9+Vp2WoPm2qCW+lKbeKyGlf3sdF7
 KRc+FbDm9v43w+zuZh//bee7osl5YUKG7DaxJAalOqe253dsQyuoE6KUOwBic7fk
 SEHkHJpHw8iQKopiFvhBPXGb8BABdFQAAPbkyf1RXH8h/FLg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgp6c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2025 19:56:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGpuzg83qvtHKXyIAsA6nrf93bucnCuFyNDe34G7NcKdlqoJLkqrv+WEf7Z0ZDLXEy5P+GnafgdJ1Ciz0wokTrEtg/BR4kprV0AXJQOxtampobIzj1mqW2lmQ73+Vhew2hskD+5DjLkRuNvnlti2x5l8Soj1/x/P1J/zjCutrX5HyzHBNZI+PlrFuIJDmt5oDLFeUmvuAtDRU6bim8ecrXD9gKpdQvA1ZwXLi2jnwdrIb+ZDsM//pvP1CwviWR5Pg9d6/hSCe3yOjawsr4km2ZrObV5plAqAMyV01yaRgP9xxCpLsPAGkb2fOwOXPmfkxH2VvoexIri3kPeKyB+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd7Zid+ehTHOBEEp5KhCUFSnnj6xcPdbkeVw1j6oa90=;
 b=QHZL31PWouHPkIiIMxXALQr1R8L6x/avjB6RtMfbMMTpNT7WuMLHx1PzGU5AOn2IeWGBU3EEWSnSWmQjVKw36AU3Bi2eSIX2kPLVh1c+NvwDtXikagtUBayRzmYCEUjFxQIP29S7WB2AkkIRqHQqiHA5B9u/g5LUBc0tp51tzCOz8fApxKxjXLODQ8TF5MyiM+wXNkT3J89tketROmps5fhzTdF34M/QTzIFzeQ5BIwPv4Y+TxA4QxJxpONPFGBhquVR/dSvvAzkj5lhWjdHJbJRURff79PNYJ6LIOXE/HrO3fno6fpTi0Fj2UbQJMLUSvEahpTqkiQNFGKNg0gp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by DM4PR02MB9120.namprd02.prod.outlook.com (2603:10b6:8:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:56:51 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:56:50 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: Sid Manning <sidneym@quicinc.com>
Subject: [PATCH 1/1] accel/kvm: set coalesced_mmio_ring to NULL after kvm_run
 is unmapped
Thread-Topic: [PATCH 1/1] accel/kvm: set coalesced_mmio_ring to NULL after
 kvm_run is unmapped
Thread-Index: Adt+T/vjP8l2ZLcjT8aV0rWA72rdyg==
Date: Thu, 13 Feb 2025 19:56:50 +0000
Message-ID: <IA0PR02MB9486FF6FB2D71C90D8602007BEFF2@IA0PR02MB9486.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|DM4PR02MB9120:EE_
x-ms-office365-filtering-correlation-id: b8d9ffef-ff50-4b72-ea30-08dd4c688e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UQ9yXEG0I2XqlpFMx2z3tzm5GbBYLevwWfNS2jPqVRuBfXEYGnouSI1DtvJ+?=
 =?us-ascii?Q?W6OzfV26lWaKyjjYu8DT2MrF5BABr5OSsT58BM2pQLxDzN1ilxLZaw3MMK9Q?=
 =?us-ascii?Q?kR9E6m6wL+zNWpyNObLa3Vo5ZFuQosiLI4w9MrfJb8joglm/Y4y7FnLobldk?=
 =?us-ascii?Q?zVimGeEKV79dbVM+VidC5OP6VnLOkFAFe6RzmHpXmrjAeOQwhazykbEWPvmU?=
 =?us-ascii?Q?6BQjdSWdplOBJ+4JWxEz5wcNJHPej0wH7PceJC0yBvEhIvPxUcs/2e0+PxpW?=
 =?us-ascii?Q?dj7xf/La7m78cE3IFgyaTNTB1y2ysiyH64WFx0r0T0wfruZdjE3PwyJx9PiD?=
 =?us-ascii?Q?ee1xdcqdocOp1+/yRm2ZW6SmlIqioeEgYxImpuL8MLys7rp367iGCM3f4ozS?=
 =?us-ascii?Q?/VYca7Ht+XxHLjDLUGNIR+qvrPYr0U71Q3DM0yceJybl34dX+0rI81GACe39?=
 =?us-ascii?Q?E+52BF3aHNHOdQBLjGW/4ZCGY+A/etrqsFC4BOW/neyqCJqjkpYfqPIMvM+g?=
 =?us-ascii?Q?EtRaB2zPY80umUhLR38aD5QDfbYayE6FMeJQnUtABzkbjHtHzEYSy7cTjMF/?=
 =?us-ascii?Q?S1yLtTnKpN5q3b4DK9Dq9O+kVO5mH2xLM/WAmB+Dp9jrSuK9VVqPzniEyn2E?=
 =?us-ascii?Q?GU76ysbMq28tMTpA5RUwPMr4Yd/ogOunHMOio7k8WFc+7Cx6gqIaf035XtSf?=
 =?us-ascii?Q?apWjpQIQ0W0hpjwAEK2p3twLy/p52UAOO9rUu8DDljT6QDjQVuCviqHdMfm2?=
 =?us-ascii?Q?40t4R7z3TkzNf+NASGAAB77XeDIrU7hL5zzspJUW/86g1l4VlG32w/nuGEDM?=
 =?us-ascii?Q?iPTggRBt4WCY6iKkbHTwS02StbTG7STaLG1Cven5hBErdSI0EiZSQf7vqvBI?=
 =?us-ascii?Q?Ms1iNXDgvYNnk3Dx4AhOQgs+sX4DesKNynxwZRT7nJchGKiLI4xoYEgvF9vn?=
 =?us-ascii?Q?WRjBcOfwSxqjeBX1fdUx26PGNq8v5TjsVgNZ2iXRyyo2Y8Xudzmgpf/4nxMZ?=
 =?us-ascii?Q?BvA9GuvuyuQrxd8UlWCGx7ioqF7UP8zgYgQ0/TkhdOsTcR25Oioj519TNOHe?=
 =?us-ascii?Q?k+T+2L4Hi8klimO41WHDuhyqSbQ2WWIE/467PUdJlpEEyEOji2VpST7gy79N?=
 =?us-ascii?Q?vARinYpHtDY5emvUaA1VGON8eVYVVr46u23NITXt0bG+MWHD2uYnW+TVsMyT?=
 =?us-ascii?Q?lp5rjH20fQR78ZEsNpgua4XoboQ04uz4sKTfz0plwsWMpMPa8HWrWUNbm6es?=
 =?us-ascii?Q?Hn6DZbLwUPATdmN+pPqAnDeqCeT54/pS63tR/SBP8RX5cyZ9CICDD/BPwxFK?=
 =?us-ascii?Q?TccOVPc9gYhu0MEdaEBOHc4t5g0jkLvF9LBZmEBQrwJaayAB8cU1U6g5DEBu?=
 =?us-ascii?Q?8MQD8a/6R/YVcQt5XPA/qhDvnTcAdW7ZdWxMIbtskaPvJfOZSL41+ZC+Eq9E?=
 =?us-ascii?Q?+R+VyqptGvojiwCfaURAt2bF5N9MgIjb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WimAx5MTlEqYYRIN1cczzZfbfY9eIDSQ9WQ5oyl30viD3PmQLH/yGu7rlnB1?=
 =?us-ascii?Q?jDJrdTJF4A8mIgluVsB14zew+rhhnCTk+epMV7jAfK7NiofiirVYmdNnBF02?=
 =?us-ascii?Q?N/b3+iSAYHoW88oqMGQ3di8dtBvzyWUPmDDZd4eNmfYS84Sp0ABzsTxlfWOi?=
 =?us-ascii?Q?qfvZb4NuFiKjQuMlyaeWuZpkKWmFeBgLPtpONWEVXfriNuB+jRwTEfQ6/S0a?=
 =?us-ascii?Q?9kEAqcmXxRMn7mVoCjI9hyxAvKPeFh6qSHL0DpX4CAmxBCHEOK8FtFlbGYkc?=
 =?us-ascii?Q?FBjFZZ6hQ+SKZFVLBTQEJlkIWHzpP8hVgUWJ29dj5JghlFibcZgB0CRn5pfm?=
 =?us-ascii?Q?HJMOH/GeeNGuN4qPcQpBQk9psC0eFRpUQOOMpx9S1lOMuyWwEMuMmVJXnUiN?=
 =?us-ascii?Q?rf16fTss46WhoPhXWwtYyOr6IwZ+kXp54JkLIwdFjz3AIMUJivRnlX+GKJPR?=
 =?us-ascii?Q?zRTtOpPSw+dXpeO7it0a39xEfSw+M9WXHlKrzw7ZFFL/WvW1uaRSbi2OutUZ?=
 =?us-ascii?Q?u3w4zq4fm/5ud/n4qKXf4k7C3tjeXri0HC8ZTIpM0AJQF3Cg3AzPLHro7rru?=
 =?us-ascii?Q?YvdHeqztXz19t+uFkx7kCHE9CNWRwP7xQ2ws6NqK70a3JOVEA3ybh/D4dy3w?=
 =?us-ascii?Q?VvyDUvvKjQxhqGVpCnecNn+XOo71xS222NdV8oULcdMFTeYu3nQg2yYqBAf9?=
 =?us-ascii?Q?6t+HKmrfofU7+4miotL9AiQb86v+H40ZAtj9EAFD5vfKY4UipBZxokWE3Qfs?=
 =?us-ascii?Q?5KCR2GDdRY7KGRupNTioWBhA0asv93hrNj936+e6EHO740I3gbZQ/xnswP/U?=
 =?us-ascii?Q?DBfs83i5sqlplHzHU8se6IrUCcEaP3lv3MalNGWlLrr80Vhq7Ygs84KWjhGH?=
 =?us-ascii?Q?hUZNHz0wtFFKBnZzGrSvvjMhsZ8AIDLZOeC7W37WW8dexERTH0NOUHUZCahU?=
 =?us-ascii?Q?bZf/lQv0xaGV1mR8U+NqCf7SWyPG+p8/3HC640uNXaa1rJVlJrc4l9T7J0Lz?=
 =?us-ascii?Q?m8mt/0IzDRrr28ulqRSL5tXC9FyGXulFY6lEfmUBSCMUoEmCx7NyhkuP6ZRi?=
 =?us-ascii?Q?UOYRaAMKQYJpW8SSn9fsB33KJ5dkYWooNKCo+nN4N0UdUyBWOriFNoOENBqt?=
 =?us-ascii?Q?Px8Lgbc3850jd5nyq8RUyNauQRHM8ei3CFIbIU/W0C0gm02ajMmEjkuInUAX?=
 =?us-ascii?Q?/QgjuDIZCyLdVz4vJFo23Ib1v/h6bf5QDIQ5AP7Czsqb7BjqHfZyxhERGdaV?=
 =?us-ascii?Q?XsGSC6InZeTPEIiG9kcJJmfdxZh1YQUmG3bAp3nM6RrZwCeYTZ96qb69R+81?=
 =?us-ascii?Q?pslpatZCV92xjeeHJc6sq34NkEnaR1DaWr6WeOEM2gBc5HwNZlxDVgbdltQW?=
 =?us-ascii?Q?6qrL3YvuaOv8+hA/8/bVm8D1obU5JNQj7MrgMARoQHh6kRe7CwgWI0YNCWRq?=
 =?us-ascii?Q?r4p5xXD0OScZ3zLUFfl1AGU+WGIx6m8y4B2ra8bv/kxD9LYobuetQgZ/RDct?=
 =?us-ascii?Q?kHE1cJoWLIDdBvwyJ3WYFds/nRXTdlvGSB7xz6VaUbz1XsPy9mRDmW4H4jsL?=
 =?us-ascii?Q?jAaKYai0TT8vWOToVWnVfX1DRcoo/wSWyBvhgdIX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EOlzPD4bSDVbeFiDnuNDrPebhbNa5jHRP1U96h5qQc/WK9tVWxkBJgzg81etwnl8D085C1A9OuV0KyZWpk2HUzMhmvef0lo5/Z7pJmZ2h73sHYer/DP1lT5n3ZMuRbwM4GWVstGmDx1/yU7g1OjbwgyCPJj5mysIK7aEO9jxlLYZDsLkBXKg2uZXz3UDkIgtcnxv5gwpdnV4KCWVmDHXItam16xqwTsTSrD6k92tDRz8akC6KdYBORMzKGhzYG5Rxmr7Xl+NCiFT7JT/bApJXn/T2EH2MuhBPMQwSynFuMcDJ2ZvZtBWiBWFB8m4IC1wkAOEXrs3KqRlv+meNThJXg0+7YGRXM5iiMKED3OEJqTIMrTB760A9G6Y5HOBc7itdubHcMj1vWGB0T9hJ/9QItFuPtQRItMXJIsdxhx0guGRq5GaVhhRUhMZrTwk0azZm1jR8ByYK1fAQg74sBojlSfvsf/uCypQfG/KV6zq3CZOXIK2AD/bASZIpSoMyyqWPCJ051Ck7ayDlc3ekzrg3TAWgnkPqGd+mvPpk44bn5yanZJwf8R5+zht5m4ZFMNONkjg340ubx/kd61p73mGLDgkB41Avy2EhRTRMZ4gsTy9jTnyqHUwT+3ZGR942sqD
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d9ffef-ff50-4b72-ea30-08dd4c688e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 19:56:50.8420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvEb1HXWF3gqWxZgpoQIY6n8NABLeEc+1D6CLwYLs4KGLrHtA+iCwivbvlgP0YFce8J1xDRopBaOk398BNf62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9120
X-Proofpoint-ORIG-GUID: E9K1UCTvJMaE6FmEnBWhFIBzEKItA-CD
X-Proofpoint-GUID: E9K1UCTvJMaE6FmEnBWhFIBzEKItA-CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130140
Received-SPF: pass client-ip=205.220.168.131; envelope-from=sidneym@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

kvm_flush_coalesced_mmio_buffer explicitly checks for this to
be non-null.  Since kvm_init_vcpu sets this as an offset from the mapped
cpu->kvm_run it should be reset to NULL after kvm_run is unmapped.

Signed-off-by: Sid Manning <sidneym@quicinc.com>
---
 accel/kvm/kvm-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c65b790433..b67964e552 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -512,6 +512,8 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
=20
+    s->coalesced_mmio_ring =3D NULL;
+
     if (cpu->kvm_dirty_gfns) {
         ret =3D munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
         if (ret < 0) {
--=20
2.34.1

