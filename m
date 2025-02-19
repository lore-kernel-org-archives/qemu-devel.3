Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8262C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPG-00044K-Sy; Wed, 19 Feb 2025 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPC-0003o7-Bj; Wed, 19 Feb 2025 09:50:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP8-0007ZP-5U; Wed, 19 Feb 2025 09:50:29 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBEuNk022547;
 Wed, 19 Feb 2025 06:50:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DKDm8DZbRTnYTY+8HOnT3pbBPW7w1QFY++eASlZ37
 iM=; b=FvvDX1YQLp2A2pCCdNsn7DKFjmw9vAaWEYCoZJizN97MYrtM15r7j2rx1
 66bAUMdluS/1ovzGNa9HbEY09l6ZjYlgmvFHfaUnMSjAIXzJPX3O6oEi25WZiGeZ
 9aFBhfGlJfvlLpi3mAYcnUCeWbg5a+McQrp7KLqYi5heyPwLYV2Rbmvm7k7kvBOv
 QUg0smtnM0yiJhRLILoJwCKJWjZ1wPta7Uqu/ZbYUEOMteQR/LY/IwFwPJhfwNuy
 9X1XvArGDt4XthFeOlP4OM/gu7k+/zIrbkcYU/kZpUTpGEzMGxPYgApBZHySuIAV
 uVepPWZFmYq4b9CTunTmpuxFI6whg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy5d-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS5fEsUpchrlRBLbfy77VI2FarX7mA79vm5aUuX7gy7V6vEv9LvkUdMH6DWadBglJsYWXwDMTzzvhp9CF8KEcMlAeCPNqieRaG/rqWXzzRzkeaVupoL6MW7+nScxtVVq9Jv49bX8pzQ+25xhOxdQvZW8wIUNnVqNc9aHuZGDe3aYq5qYNz8nBVFhVlrmUL3loeO6u+XBl1/sU9HLb4WsmdVHjej70hNRR9h1y6QVsI/hqMHrNnMAI9r8wEFFM/bSgyNwRa1wX/FOuBCV1GIf5+pUntshcBVj0gtlrnIEQejlWdYh45W5hpLmAWp0Bjsut3mZXkch7ItHcMrd1BT9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKDm8DZbRTnYTY+8HOnT3pbBPW7w1QFY++eASlZ37iM=;
 b=ZiWlPEeXPAmV92uuyyHmZVgQC+7i7T0IAWLveT2GONuZnvBRclALSh9mcKoqjuNr6V4AmbBrQK4fTPKWnNEa7IOQEZuc8dO6HEduu+iyE4vezlf1m7bKI70+R/gB2+aZQxfAGIOZZ11QO1MkG9lAfNZszUnajR0FuNYjnJNlTTH5tK+nE/VK4xAZIhg91xklDj6fkX4vnM5lbU/MniiexbSijH/JAGrvTYgcotiZNGcbY2AG6RDonTY3UiP8fdD48JU9BCgz/WXwJrD/atQMV8fIQADK08+Apg7g36lfsM5Oh6F4bV8+SzzPFsIprNYok4Tntw+weeoMSL9dol0Gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKDm8DZbRTnYTY+8HOnT3pbBPW7w1QFY++eASlZ37iM=;
 b=nwMt+hUEXGNTxGqH+v1250Om+ZLl6XEsZ0sD0ayXuNDhYPy56qixRZad9lW8QItgzYMECo+fmDaySwnv0FT15VfSwR8FKdB8JE4ZcppB38xT+tRNUwn2te8kVurj6AneprB5wXeo9rfDF7xfabpchBWEYU1qSUvFVQo244M09XU8O8ie3AClA/k7wVPYR9LrKvpak3BpYgx3AvvxpyuFUa7zLC29en+DunPJaLeVCtivjiEUgn/9hiFgRgm/IefXrNq/aWygj2mptZhTM7kluIUrPVbSARWPiQMV9nNzOPvpMpN54NRI4KNelLMKS4N4cMb/Zv+E0HXPQWMQv64JdQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:12 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 18/28] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Wed, 19 Feb 2025 15:48:48 +0100
Message-Id: <20250219144858.266455-19-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: d04eb0d8-3a01-4f0b-92d1-08dd50f4b6cb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F3AC84czEaqYAo5z9XhLxUBNAwAQLG5XmocnTTO+7sE2oGKYcOc3gRpHGe83?=
 =?us-ascii?Q?g3WGiIdVaGSVSfEvCUby153ImpKXpkydAmpi6eAjFAxLATm57sitB7yBwqEc?=
 =?us-ascii?Q?pOSOvgTHFFQOb4mB85d6VMEhZ8zZKuZOcH4S5nPCvzdFWbXD3o01Nm99RGEd?=
 =?us-ascii?Q?ZJSqJuMkhjGtdK4HEyVY8MWYjKLNFTaCz9TBlPCfVOhYuha7FM2vRQ2mSvo8?=
 =?us-ascii?Q?UaCkLn9ySJM5s7oX5r2ld7IuyMXwBc9YstZUYRPtoBfZBYHjci738ShQ3JSm?=
 =?us-ascii?Q?4zgz/IAuRAjGXW+iK5E4TenGJAmkVp6EiTENmdql0RDapF5bPe29O9TealQp?=
 =?us-ascii?Q?oUd+oNDS474IYnsKF9IO0Kbm+3t8F8GuZBVqewtkKUhPgMG93gCj0wpIN98g?=
 =?us-ascii?Q?QwOlgcGPFf8EfOMMrJOvAZRpE5PzFBXKfcmpIxZXZhrigLxiLttZKCXs+wOi?=
 =?us-ascii?Q?jc6Xks1GBQdV8/QepY0O/hVzVqvO1PHEpH7S6c1wBpn2Fs4izc7D5US+KnND?=
 =?us-ascii?Q?R/x71WlEnDS/lSwYbrvGA8o2lJ1PByTR1ja9V3CURN+AmL6mlTY8Swq8g0lT?=
 =?us-ascii?Q?AsAXqUeqljlG3mLfTGPsW44AxSdmovym/s3JnqZ8WxfZsqX7cMh/lbTKRE7S?=
 =?us-ascii?Q?cAHupEA8qW+FIcbx+1V3qNuYoIsnHWUgdiDfqybAQA2DjuzZxM1+DgJFIpId?=
 =?us-ascii?Q?JHeIf/+qv2MYn29V2zz974NCcWaiF/plQV0yiI5C1JNv6BRwZEwjb94nYJsy?=
 =?us-ascii?Q?Olz+a/KkrfGvYlYbqPCEl/tb0RCXNt8pBCthJYmiBQh3BXKZWna7BcZYzMQr?=
 =?us-ascii?Q?52/6VUQ5ISl+JsMnridfxWEogkbUf0fflb1nnAr9ODL9dRvFQqSYSa3gK9gF?=
 =?us-ascii?Q?aTYd4oU4RarTDH6tsfVfIizWJShFdECI71IfWZvRZE7ZOf2XNGh77V8uq9JK?=
 =?us-ascii?Q?vzyfeJhVr+vY/ZZRNFx+EahB28iYgsrsQ1WOxT7zd2J9W+l0MMc4b0TGI5r2?=
 =?us-ascii?Q?QUdNnQl41NfWSYuuXyzZ0jAjfDYRAKTZ7nKdT+9knDr1aPYZ50by+GvAa9jZ?=
 =?us-ascii?Q?9k9wPh95dSVp+su/b6wOOagbWzlddJnQKnU525cIZtW6TVmuInnbqbfEkAIH?=
 =?us-ascii?Q?0sEKlave/qx3P83VUbr49L3aTTydJYiAh+EpQuHJTtVarYOUPSMZjUQPjNln?=
 =?us-ascii?Q?tCqXS/bvMm+V6uSuIJykDVhC5i93RGZqF+9ncEhKVyzcQ75jaNLSTzzjuorv?=
 =?us-ascii?Q?desVCoyBSt9594QPFV6eLlPQFVD/jrFvqQRazcj20nUjDSuMqVfB96r+gG4K?=
 =?us-ascii?Q?Z4XThNo5HyQdmo2X7ASxxGz8zLajRgCpnKIWeYus6uSQALnN3CLSj729Shur?=
 =?us-ascii?Q?QexbdHumj9Nm4ByIMgWTEOUdtbtJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QnTcncMio0ckd+hgmDYmDd7T+SzTFgdCCDn8XuFNMHSj9Kw2xgFiuMDTGN4G?=
 =?us-ascii?Q?OW1DPBZKI7cfzq04LSPdH2xIbUUT7wkgYWknZw3RwzFpmvOU7io3rgbzi4aj?=
 =?us-ascii?Q?wKUB8TyroNZ2mfuiOmPJEIe48snEIQ432IdqOXxGF5+Eu2KFpQZHiThw64zJ?=
 =?us-ascii?Q?vzIba8CONrTJKoinPG1Im+t/pPYtegjbNPgfytC+My3SNoSB6M+6XQsphnf7?=
 =?us-ascii?Q?xcSKSoTEghULtDbM3tCLaF5W8qdRT0cq06UOWk9mMWqBbDBRqx4Epyfhpf9O?=
 =?us-ascii?Q?ZdGH5v9VEeawcXCcoIFYI+wbU8dMLL/PcePTn3coc5V4Xymf0Mr3vdLh9rWV?=
 =?us-ascii?Q?LidZyitN0F1/9HfaUsjqWX/ULtVD8Vil8mw3cRHz9kBX97GtpLkcv0P20hj6?=
 =?us-ascii?Q?XG5GYhT35DkHRB/+sN4MCxv2q/wO51CsUuyshQjx50hk7Q8lL9rPocDKigYz?=
 =?us-ascii?Q?Q1g2/e3LXZF5PdkrnSJMlO74oypuowaXDNuPiqGgNF9x/ERmep0jJCizusZF?=
 =?us-ascii?Q?n1HWw0HGaUqMaR1+Y/FLemKk29D3zLcN6m+lEKtEKPECpVM/sRajS8he6jTJ?=
 =?us-ascii?Q?6ZcraRfE1Ddw/RdncQJypvISd2zIwhKhd/EK/nIKTi9Cx1H3F9kU7bURin4+?=
 =?us-ascii?Q?zpQZkvnziiyAyerFTatlWB0Ev9seACrfcj5r13wsrOBNzUILSwV4osFEflTS?=
 =?us-ascii?Q?p5T/Pcl0k7To8mDHhBRaADGr18i4fOfp3VjsGrxjTVJ+ueWZU+txIbH56xoy?=
 =?us-ascii?Q?jQ3aZT6+Pvj04fbtySXxNzul784Aw6bgDl6/kUZWTxFwm6DfLtNbD/qExNyt?=
 =?us-ascii?Q?7x62zKF35ik/vWBRWVLHolJg3nn1ENjtLi63loWzby5RGuHuP/jCFUYLpHt9?=
 =?us-ascii?Q?FW9STFdySaKAoHgDRTuniKyEggrUX86woBtXbOU1HOHIqjcHImZOPq2mh/0j?=
 =?us-ascii?Q?IdJlYzgiM2MvpLK4iRQvyiJywk8Uy2mN24N0tjJNF5gnu5yFX0+7/jzoruQ2?=
 =?us-ascii?Q?OLBp7HdSD4OGdtK6ZnS/PA7cE6qdlLXa/S0BrTUKamkP30hnQ3eUPiBIvQQQ?=
 =?us-ascii?Q?cKh/Os/qFJHyPVe7xfBWpbydpJyQokBpjQcMvxT+igc2Gu2nY1/xb2VsXtu2?=
 =?us-ascii?Q?DqUnELpNw16tDrQK33i6mso5473404ozAqA1Y9iKCBy5kt0ocUV/cvolIjRN?=
 =?us-ascii?Q?HjIK2yRoeqH9nHoIgA8a/iVib4F1L/Ah1QvU0IeWD5ClgPCxEEutbPjzpQ0r?=
 =?us-ascii?Q?YS40IwFXydLnJjf4Zc1ThNslTmspbl3yo10EecGrqbwP0DYJUpricCIyeOhI?=
 =?us-ascii?Q?NQf3palZb/sEGzqSnpf5VnZ4eFbomifH3MudHp2qOcB4KufGJcqR7JAsJkcp?=
 =?us-ascii?Q?FrqD6ffZJHPekngDoKCsgcDUohwAickGJKS2sXOpYTCuYOWKiXw+wbMHAl5O?=
 =?us-ascii?Q?TJrKdoKThQR619Mq7HDJmuZFyhvyo2cc6WZI4AMuKi/ZshjQBFQHdjFuuS+6?=
 =?us-ascii?Q?l1mLGmSJ0butjp8Zk/RpLnIiy/RLxgZP+31N2I7gbsOGtfIVsD/PjDi8hNHB?=
 =?us-ascii?Q?bcdP2CK8sjeAoOIzRXw4e4SsVjspcQgj6tTH9erj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04eb0d8-3a01-4f0b-92d1-08dd50f4b6cb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:12.7708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysHXaO+NiqAYX7wMLh/BpPBlVsrp1MoQupjCMiVt+yKfUbf0/AL4KDdwgR+D/V+MzXUbZwck3U4iZiYXcbhvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: rnF96_WwRPo185M73iD-EERV7nJqSiKy
X-Proofpoint-ORIG-GUID: rnF96_WwRPo185M73iD-EERV7nJqSiKy
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5efae cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Qylz81XdT_8TPN73I5EA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Also add support for posted writes on remote devices.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c         | 120 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/common.h         |   1 +
 hw/vfio-user/pci.c            |   5 ++
 hw/vfio-user/protocol.h       |  12 ++++
 hw/vfio-user/trace-events     |   1 +
 hw/vfio/helpers.c             |   8 ++-
 hw/vfio/pci.c                 |   5 +-
 include/hw/vfio/vfio-common.h |   3 +-
 8 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 7b96d715cb..1a9033af5c 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -55,6 +55,8 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds);
 static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                 VFIOUserFDs *fds, int rsize);
 static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
@@ -626,6 +628,33 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                 VFIOUserFDs *fds, int rsize)
 {
@@ -1139,9 +1168,84 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /* read-after-write hazard if guest can directly access region */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+            proxy->flags |= VFIO_PROXY_NO_POST;
+        }
+    }
+
     return 0;
 }
 
+static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
+                                 off_t offset, uint32_t count, void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = offset;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_region_write(VFIOUserProxy *proxy, uint8_t index,
+                                  off_t offset, uint32_t count, void *data,
+                                  bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    int flags = post ? VFIO_USER_NO_REPLY : 0;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
+    msgp->offset = offset;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* async send will free msg after it's sent */
+    if (post && !(proxy->flags & VFIO_PROXY_NO_POST)) {
+        vfio_user_send_async(proxy, &msgp->hdr, NULL);
+        return count;
+    }
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 
 /*
  * Socket-based io_ops
@@ -1171,6 +1275,22 @@ static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                    off_t off, uint32_t size, void *data)
+{
+    return vfio_user_region_read(vbasedev->proxy, index, off, size, data);
+}
+
+static int vfio_user_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                     off_t off, unsigned size, void *data,
+                                     bool post)
+{
+    return vfio_user_region_write(vbasedev->proxy, index, off, size, data,
+                                  post);
+}
+
 VFIODeviceIO vfio_dev_io_sock = {
     .get_region_info = vfio_user_io_get_region_info,
+    .region_read = vfio_user_io_region_read,
+    .region_write = vfio_user_io_region_write,
 };
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 30a3125ea3..31b11ed614 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -84,6 +84,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index fdff6c99e6..26d2960985 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -37,6 +37,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
     bool send_queued;   /* all sends are queued */
+    bool no_post;       /* all regions write are sync */
 };
 
 /*
@@ -99,6 +100,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (udev->send_queued) {
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
 
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
@@ -170,6 +174,7 @@ static void vfio_user_instance_finalize(Object *obj)
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 6f70a48905..6987435e96 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -139,4 +139,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 1860430301..3f5aebe7ac 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4ed393420e..6bc7600ab1 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -184,7 +184,8 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf);
+    ret = vbasedev->io->region_write(vbasedev, region->nr, addr, size, &buf,
+                                     region->post_wr);
     if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
                      ",%d) failed: %s",
@@ -365,13 +366,14 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    region->post_wr = false;
+
     if (vbasedev->regfds != NULL) {
         region->fd = vbasedev->regfds[index];
     } else {
         region->fd = vbasedev->fd;
     }
 
-
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
         memory_region_init_io(region->mem, obj, &vfio_region_ops,
@@ -837,7 +839,7 @@ static int vfio_io_region_read(VFIODevice *vbasedev, uint8_t index, off_t off,
 }
 
 static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
-                                uint32_t size, void *data)
+                                uint32_t size, void *data, bool post)
 {
     struct vfio_region_info *info = vbasedev->regions[index];
     int ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4ab3bfa2fa..168e331607 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -51,7 +51,7 @@
                                  (off), (size), (data)))
 #define VDEV_CONFIG_WRITE(vbasedev, off, size, data) \
     ((vbasedev)->io->region_write((vbasedev), VFIO_PCI_CONFIG_REGION_INDEX, \
-                                  (off), (size), (data)))
+                                  (off), (size), (data), false))
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -1782,6 +1782,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
                                          ~PCI_BASE_ADDRESS_MEM_MASK);
     bar->size = bar->region.size;
+
+    /* IO regions are sync, memory can be async */
+    bar->region.post_wr = (bar->ioport == 0);
 }
 
 static void vfio_bars_prepare(VFIOPCIDevice *vdev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ab7fa7135a..5adbff4fa7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -60,6 +60,7 @@ typedef struct VFIORegion {
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
     int fd; /* fd to mmap() region */
+    bool post_wr; /* writes can be posted */
 } VFIORegion;
 
 typedef struct VFIOMigration {
@@ -211,7 +212,7 @@ struct VFIODeviceIO {
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                        void *data);
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-                        void *data);
+                        void *data, bool post);
 };
 
 extern VFIODeviceIO vfio_dev_io_ioctl;
-- 
2.34.1


