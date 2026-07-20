Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CBEC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk84-0002uK-HA; Mon, 20 Jul 2026 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk80-0002se-1E
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7y-0007RO-Ev
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6SEG93770183; Mon, 20 Jul 2026 02:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=N4wvc8xCvzD9mHpeL3qfSQf/Kkjc/uWQgCXmYXQQR
 7U=; b=oXIsESg8qNWWkLD2+wSszqUzShCnwC9SIFKBTaXiLth641+eFjGVNvfiU
 EORYpi+Nvmbl8VfEecg8Nhs9BN/MtuKFxw2PT+n4ANtc9Ocai7MIJ72xc1D7tMhq
 aBDHNxBtRsXrY4qhgLQt/bYkrNfIzu//ERHrCuWC+NLDO6kbzzcKx77hC4jjdGxx
 2OGdqLrD8QbkOtYHx38NfcT55NwEWmJJP65DNAsI9lx42JGaOtK3qiusTfvd531Y
 QGS+gFCK5kIleUt3UMj3InUGhtFwMoLflRLdnEq61eG7rxSnRRpKDRWFc9eoGhZO
 QaxQav+xT9ol36s6I3McgklNpDxBQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xaqus-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0zm6aqc3t1V3XM+6NtBi4uO2F+ysBGIo6OVarS8ZRFaQuLaWrqkXZ4hnasnwxT4Fh0ygcngAz1c0Y9sFzZevjnJCCdmMq6IhN5egGiQrAID7a0tQMhKJtM225mwjfqk01nXvMY8g3BQZmPPIW7p5Be87pEc8G2WKzTomABU1fNBox13l8vsPc46MdBHm/MXHZravAjtrSHAukH/PzVQCXeCNS+ruGPf3GvhJEwLzD/e4SHUq+PG+kCyG3oRXasYTIH47jUbtUf2wZoF5p90iMr+z2Fnco8g7W4OnoC8veVFp9qYL10k3X8dx/7eg6+V80bTFL/aI66nzPC9cAwFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4wvc8xCvzD9mHpeL3qfSQf/Kkjc/uWQgCXmYXQQR7U=;
 b=IybVPG2JS+71gQ5GOQrXKe75YU7gGWwpgHa8O2qiEc990MopwxPFiCIIKg5OhyM12TXgMRTFq0UM/cBZX+Xj4kKVIMYcOLpPneSk1PjGDwqOn8ayYBmanjnX/vmAvrV3MQYoYN5yCGD81ndA/81pRimOdCsmdyqDl+fN6Cr/Huj6iZ2xrJwo/Yk2vH3GhldL4Yb1hFdYiRVQHltc+41IhD9ZkvSYpJ9RJgUGarXfoaPcSvI/gVrCxUFeAJd/jzfddhQ0KMW7xBYLQ2EVp4H3zmZacJWJzH4vOZWG12HEa4dge1cWIeWce9DZNhYZ4MN5slkLH4XhNhlz2L89R7oYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4wvc8xCvzD9mHpeL3qfSQf/Kkjc/uWQgCXmYXQQR7U=;
 b=cJQr1eEBGsdbHBK9BqMl+RHYWEYaj0RQU5MBH/mTaBwyfwZE69i1j+nUndkRQUZYTcmYScqbpKw4m2QOYD6jAykgED3HFecJmMnWrIAJWix0z1aNet15RLkckVwnjDX5jARw0lXhi0IcKBFDwwHxlH7tnYIurj77JkFNe4Tp/Fc5wzvLhldgaBBnVjGXmqIif0pU+OFcOyUfQscby6/oUbt8Z3D77wJUzKcHh39BDUORW3vd5b7xqb4jAdswou04goJH3m0PqHcoY1QGCNWiqKT0Eb7aLh0hd4PgY7RJ82MUG5W0vtMt46CqKb3z8M1k2nHX1QmTHoamHO9Wte9m5A==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DSVPR02MB12010.namprd02.prod.outlook.com (2603:10b6:8:41d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:17:32 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:32 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 5/5] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Topic: [PATCH 5/5] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Thread-Index: AQHdGCiYBdWW1VvgzU+hrmmEztneGQ==
Date: Mon, 20 Jul 2026 09:17:32 +0000
Message-ID: <20260720091718.2642-6-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DSVPR02MB12010:EE_
x-ms-office365-filtering-correlation-id: 813824f4-c724-4447-3701-08dee63fbac3
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 8vLW2tox72hQVpeSTAIC/pGs0PlXibcFu+lAO1Q9WNcN3G+YDnkQdeTHYJKPG86jrJGmmy7mXhl9U6jWq6oQjZhpci/rtkePWpV8LBvtG0y90nMgUF6yXTobQIRCeH9+dUypI34FXfkNIuumgNokjtiT0lnoeLwBoot6zDtFCsmzGmQ9NYH9KlG5Rtn7QFUnynE0AhZidBXM6rAhiHbGlaVLTl1nKGtM17zsADynBs773spGKul/OGqBylQZZyzvZhrDjCd/cAwGR2quibp55g0tFxWG4C11oZmUaurTojR5l8ikdkNYXT6YmseyVuKXKhYIcvJ+H1KtEK60f1dajscpexWA9RWbdPfYZ1WRP8Snv5GfxSmjDBQtQgP75LPmY/1WN4JEZk7xhypOTrzLB98ATjtPzqU31dLrU64wtqW4R9kKFWlCIGfe3/cyh9ezhOrxbCZJY3NkeXdRz2wJnNd/ROea+9elL4JDHez9C2fBGlYDgqjTC9tTeNr7CemBQafUuXLeZB7zEyq5wBVNYfudIkYEKcxkmEso4UwcNFvHIXf4N3ZomQJM9NVhgfg+lwQ+pULwE42kbrnKPBbGhJKmqqtqsBYs8n2YVgA0pheNOtrSrZHWXJv7Tq1TrJHKBTQmxFCdx1XOx0d3n+T4IZgRCMH05+BFj/w+bZWW8oCcqTlpDwsGMwm4wrra9sjmydkr5idD1AnEsebqTbQi4Kx2B6P7Q2TvozcC0MX+Z1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/jdgMpnmHKW/hSvb3Nm6yqHRs2NTZaGeU7aG6AGJSfSoZyIA0WySTev5cb?=
 =?iso-8859-1?Q?LdYmDjY8d7cMdVamyFtbQ9MBFUeH4Diu8AjvuAYs7WO/mLzCHmWQu+HZhl?=
 =?iso-8859-1?Q?fjNzGn+QkSapw4pz889Ijzcs5105NiTaPCNhhLWlOJl/v0bo4GojcMNj+n?=
 =?iso-8859-1?Q?IHopmo184pjk0CfBLm2omDm/zrQp3n2pvSVM/TN/4zWW3zeu79wyK+BVww?=
 =?iso-8859-1?Q?suJY7jvkS+Mqvy/dowQL/zrmsI4P7GPX3dfxhmoo4rZknT7A8HafzAPuRI?=
 =?iso-8859-1?Q?JqivwQgDew5rIXX7dJ7L7mNyI3SC5uOVvsxOdk7eQuEx4FepNehEV+IhEY?=
 =?iso-8859-1?Q?ny9PDdeAwjjF/0D4oOGRVN9HXePkFTRxIpLZVNwL4cCy7riwvXrMMSrJRN?=
 =?iso-8859-1?Q?eEGvz3qFG8wUMAEB6m5SrmncIBPIZUnxSWLeVXNkTps/9An2TxAnVch3Uj?=
 =?iso-8859-1?Q?aXw1RWGoHhO49ZyWGuCdwtA1GFUvXmKXl/QFo5423cRDJEBbK9XaC7GIhg?=
 =?iso-8859-1?Q?Q4tyE80Wwfg1/MuvQD5fiFEOxVjvV/gM57PjJYppjk+pkEa7XfbqDypwOs?=
 =?iso-8859-1?Q?3Y5zi7G4wngmbqdkM/MSEIU7ZjzmVoV00K120A9nnTHFcZaC5558dR61Ix?=
 =?iso-8859-1?Q?PmRwAw226aIr9kRu5yH0B3/XGN4qjBgNlpKOR1Nt/GIZZku/gni/2LlygT?=
 =?iso-8859-1?Q?vEgTtpc/S4Nu6y4gzphxqQM3FfbS5CphvFE8axEmeOZB/Fw+ONmQ2vN27p?=
 =?iso-8859-1?Q?gwT1qF0apdPFkxdpuOS5zKsphXclPpSc8P0QsyUfv0rRVS7imkzxBH8k5A?=
 =?iso-8859-1?Q?+uXeK4OMtOaTBwt1IKu9hmiTiXJPxKHAouljvaU2M/af/oLMwVFa2EaT0H?=
 =?iso-8859-1?Q?yd7siU5TorSVY9NiReMpfk+dXnJwmsyojJbXr+0UToOx8xd86BSpbU9uPG?=
 =?iso-8859-1?Q?632Mc7v+bpQ0OBJW/ozZAAnzevq+SD/+Q9hRZ90ha4xqILANPJwIUy61ih?=
 =?iso-8859-1?Q?XjLRXaU0X5RZICsmZCbSFwfCcOCS4mmJhgXjeXj3fXVym1Kquv0C1teZIO?=
 =?iso-8859-1?Q?z3R+Dm4SJ8CWp3OYftYr6Q3RCJafm6a457C/C2oGhOmOJNQ9rUz7lmBVYH?=
 =?iso-8859-1?Q?QPliDeQ4zLH3iR06DicR2JCIpDM0fRRj/jbOym6bDNzdI9G939EYM13w7v?=
 =?iso-8859-1?Q?jHTGNhXJ1f8DdHfloU2WRaUyWVxextEsMmkbJXltpLwCb41eXwyDm4qqJh?=
 =?iso-8859-1?Q?AcFjOgMn59shGb4yh0FOZ/6ueFDkAL69YGAPTgKPrGX/ryJQMxjpvt43A+?=
 =?iso-8859-1?Q?iIWqsBRycHxpkMwI4/512jmIEvMMHUYJQ4CSU/l484nFJDjaIeFQOmGnCE?=
 =?iso-8859-1?Q?uRqbBDjfgr4igTL0iCXBv1cWFwoJ9yIFqyNvwTxzWekpE4T3T62iTxQwJ4?=
 =?iso-8859-1?Q?LQXVUGzhs8nHx/42PZR9wWIVp6bIkXP8PkOL9d7xIOq0b4Unvto89a/84m?=
 =?iso-8859-1?Q?T085hLs71akGNutWV8xcH343LOIhzGC+qrt+r8WZ0+FZuyI1Ncz7KuieXM?=
 =?iso-8859-1?Q?yImy2ASilOyOiNNM+6N/VnbhPurvLWMBs4PyKr8HOoan2Jt37WcW68Hfws?=
 =?iso-8859-1?Q?rCFhhom99W0UpSC/fRZuupZ2m4jNfApNU32KNjKrxZ3ugGujD/vhNFQh9W?=
 =?iso-8859-1?Q?xpK5G9VmX5bn8+f7Ih3fg9d8rnyjh6AWZQcc2uIp6T0GEu1efOmHIAyYhn?=
 =?iso-8859-1?Q?R7mk2ZPTJsfklshPBY+DxYrbFYSNWo7ARh6VnkAtnMCtRI85N/y5jSw1Ea?=
 =?iso-8859-1?Q?qaUrxdFmeycdGMlvoxt4ET7urZDCwX8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cnyZN5m0t4jhNR6QPnzSl5gLCbB0iMlHO2aNut/GPKwYZMOmw9E5nDSp+q23QYbd8hd+WRuP4e553uQLyKE8Xma8Q7peCyUbUtwZO9a7inykUYHCsEcOs+A6dm7HddodaxojnEoAkESylPef45F8F5SnYEr6Q8t+6vmFEeEbLrkN5++zuuUZvII8BzL4CHj6RICUCXhaRkuLOnTbQip432oF/zPiDyPztcouhZlW0v4+bLIsg3w/sqsXzq4NZqVT3ZIPNl/pJECTT51iWN8q8ynirkrVrnnyVmYp3F+zWB+6I+mDaPj5pjLFgP9GYIRDvd4TdAvXi+hqRTkrQqhG8w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813824f4-c724-4447-3701-08dee63fbac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:32.2708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMKBykA7jZbvriz7VkMSRQtzbP/6PbAQquCikX6ABBfRos5kegGyJzcq95boF6q1Zg1HqK2EJ5C07sVGUu1iU/vNpFPav4G+yLbeK66ZWqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB12010
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX/bZFmBveHo0e
 yLK67+YWlViLuSCJ94KcQDYYmHLKV4kIFZRCtoxqy1XKq2aTG1+ozKODkaZUnYt/jELsPZt0qdm
 E7olZFVQ0tV28EnuluF3mXwlUC+Ddms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXzYdTUSkRfLiw
 /Sbhu+GjWA0KWmEZHPelZ4hcxiHZyHldW6R6KdLQ6H4oOACog8r/1H3B6iDom59QiHXIu35u3NB
 BWM8K/f2mCUAbBlpHMUGiEzngiF9wwuHAdY3AalQtrt4oa8iSXSC16ixqWb5w4Xzi/mNvN0koS1
 CMwDQC9wqSynUgEkyV8gZSvrVSvTH12HTcdNG703o+kIl1ankv8LKeGAFqM4GrDcihbGfik+MnT
 WyI9TPkmnqnUY6Ra2iTKWuHsIp9Ielb5eEmD2K50RbvcYbkHOtqhg4cvreqrT2WeDAz6LLr4c7i
 VkQnY+cY2FD0G04ztQ0xp9iArIZAOPgFQgC7UOPRGHOi4ZUINvEhOjw7mT/Hzoffy6Xs6fHQ0x2
 j/kF8UmR9GwJ6byVALFV2D8bqS+PBoeN5QAFFRRJvI872vBLJb+3EsqBPGIN5Fi6eFokwPxM2J7
 pAGntvOz6OEhaJHK6IQ==
X-Proofpoint-ORIG-GUID: SToq7YiZsHIdEnHt_PEMD3ut4hPone6y
X-Proofpoint-GUID: SToq7YiZsHIdEnHt_PEMD3ut4hPone6y
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5de7ad cx=c_pps
 a=bA8WxO540RzhAQ9tgvMHlg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=qQMp8MJb-caXfZ2aa2cA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
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
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index d7cf39dda7..ce437b2464 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -215,7 +215,7 @@ static int vfio_user_device_io_get_region_info(VFIODevi=
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

