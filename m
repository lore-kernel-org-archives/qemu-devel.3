Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADA5CA1014
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttxj-0003aV-WF; Wed, 03 Sep 2025 16:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxW-0003WC-0j
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uttxS-0005Gj-Sr
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:19:57 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 583H4PrR3647093; Wed, 3 Sep 2025 13:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=glhPYFGUuJJjPzAqyIzGTxHQvhlyLPJTZAKN8zeq0
 Gw=; b=z/MsNUMhjOopkDPwNOjEv6WeXUHgLuPbS5ADmcOZFOsLKYDDkFxUag5wk
 QiSGr5KPcOetVji1Qyn6KtC7KmuADY34IsiwLRvnUqKjqlQRKz2Xp2Twah5a+Mz6
 yHaBZoe8qK+9NdpAnSKLfobf15TBZhM4+H5b/yIwU5ecQSyL1rcfJ8nhpGfdk2J1
 jqt6/Bp2sqJJG2oCneU/pV84oet3nimIKA+vcTVRD4AKoBLvcuoQRpGgAlKIFRxr
 6Eq32psXHl5MZAUvXIaRzm6JZonSi45epGB7KIlsjEsZvwxIqLbLnbnf++X9PmHd
 V8p5OZ8JXHvVhCXSl/lu6ZZ7NGAhg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2132.outbound.protection.outlook.com [40.107.236.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48xsrn0dm0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 13:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUE/hUf63LMGIQJG2ienzPisnE4D84ywrpKZAYO07c4T3abomYAe1H3zAiWj/UBPydgceRu+hsa5/R9/+PK/edJFn381whMG1znitxS0Ry/ttW1hdBMRF8ZNskg8RzAvpwiu9W5riqRUv8QG4roNtDtV3Il6iB16BJc2gwUCrrBLU8LZP+q8xIsSgtL+a3+Yjgf0GQUPBbD8/7soHeRwXjBkCd+s6ExcmVU43cl/tb+jrHAXaqMvS0h7/jK2CvwBW1hF8qczc76dK3GEUm3W91w28+DRthFGLP288Zq5hVTjD92eHv1e9q75Y8/7iDFGF8zKhVuS2RHts6HWTkPaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glhPYFGUuJJjPzAqyIzGTxHQvhlyLPJTZAKN8zeq0Gw=;
 b=R/BhmBR+vSc2uQwVRSMdQhLitF8ltzFGmhmYLo38bj5jiLLDc97LnL7IfudHE8UvN73Byp12DcpXVaUGLLZf2aJouGB9MQcH2sLjpl2ibrgzNLJAIOGfxo18CvdA5c63xq8KYJ5V4PWDMKCvpszmcO/9tXaUmv7c4F54lfV8tCh+qL9e0jViMbaeOx+uZxChyrzMUl6scCPYE4XfkyIkHgw/agRGxa47hbNJfLmO8kA1/3sQoa8UgJaGZXYTXtiUe6AzcEf/+Y6llsEhXSWIqNyGPWC2NdNkQDD3F4as8ShNjqM+4zu1KBPA5y2nn3W7GkHpe4vXphza3SFplVgJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glhPYFGUuJJjPzAqyIzGTxHQvhlyLPJTZAKN8zeq0Gw=;
 b=bzxFBWGwHP92bfx8WTEUrw4edOTxUnnQtaTaQOCmlfdJG4qct0CevZ1kCBAG2ttDBwhIfifuNR8NBrpR2X9W0v+WmkKKXXTd48hkQGua7slSfKK35anwxjD48gLnggVxkSnJ8BDj09X0NBXV/NJ10ir03XFCK0n70BeZw5LWsYbKnPk92E1XKJ5YhXmwSE9OfKRg9qJXFqQlS772++UZk9H30Olg0IPNyoV2NkOP9gmZ1mHMKyx+dkKPmmwAZpUXYpOjjOrtCelNV9TpsZ9tznCwAkGgr6cxOEz4AgkkCwM6Aak3nfcEwYflNZBGkWqhWN69WNozgI7lvnHJ/hU9wA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH0PR02MB8133.namprd02.prod.outlook.com (2603:10b6:610:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:19:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 20:19:43 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 3/3] tests/functional: add a vfio-user smoke test
Date: Wed,  3 Sep 2025 22:19:31 +0200
Message-ID: <20250903201931.168317-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903201931.168317-1-john.levon@nutanix.com>
References: <20250903201931.168317-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH0PR02MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bad6fd-e5b0-4cfc-9951-08ddeb273823
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+XUPQ5K+TlvTNcuqvHWkCNQAoFAejfTIQSVDK9UUVfasIVUsnrplNj8o0kQX?=
 =?us-ascii?Q?Pkupmegm5cvrL3uKURiw71QuSy9MHI6UF+/F8nVq8UM85E9R1ZbgPPAIaaQ9?=
 =?us-ascii?Q?K0FxZ6Ae23fwjdwCTov11y18ITpUU+R1RabNE7ERWFUeGJ8zvDv26G2Z7t90?=
 =?us-ascii?Q?zL8FTVFHfIj2hr6HT+GGeWsHL5nqbLWc7ohdq4Smy/ZdqFTc0VdStSULomUX?=
 =?us-ascii?Q?beEJ68AKKb6Sr6MlniCkijoIzpHN2Y4Wucuirp3+S19IgaVbLH7oF0aXRT0y?=
 =?us-ascii?Q?gpGGSAL53P6rnndBCOH0bQfJ9U2hxjHnes+RPwK45AN3JvB09kb1qiJjwIGf?=
 =?us-ascii?Q?QiwrtGqwDiOPeLAHVxZAdHPpvIShG4kwWUOFdAp8AzHYOTd3C5zjJJcanH8L?=
 =?us-ascii?Q?a/ULhAFlHouEJjEgW4qMnyWASxsgTHhbEa0mKZG+lWwUzJIg+K7kfTVGay0c?=
 =?us-ascii?Q?HH4uGCuulitIAVuj5vMzdpUZBqFeYUv9VTEEJUn1dzCbcTC+UkLGrq4afc4e?=
 =?us-ascii?Q?oKLjRMbiZQT7lY7rPKK0o2Wcbt8zYuGuhDidS/ebeHD5W1kbmdq1l1F9LJdI?=
 =?us-ascii?Q?huYruzi6Cv+ERI+4uANLqWHcyVOrnpxwxoStDqK+3/nUKOS/I3sV+lX/jg/V?=
 =?us-ascii?Q?6m8b74BeFajULwzcgch4Ll6E7pxbJF3Uet1aB54wL0VQ9rJvMl27hNKX59hO?=
 =?us-ascii?Q?1Ns0luy64iMFq8I1sRlGK6gOCmxDjgmuJSxXQdvOGQgfWEumOaCEbSBu/NCw?=
 =?us-ascii?Q?7IA2KLATO+K9wM8aIKK4g5mQre1SsB3nzmbzmup5V0A833ywUgdkz0g2nTVs?=
 =?us-ascii?Q?KTyejieV6I7buTh7MpcyenOcsEwjnC2zQz1mZl4y8gv9obFYZvzIdmGMMIuS?=
 =?us-ascii?Q?DWr/kj/Ms5aXy/QCUHzmi1AQW5wcgZq1nCYmhOQHMapX6LmAIuzV31ZCmV+x?=
 =?us-ascii?Q?vvJQPcuK0G2Tc4OnAh57TWZqizaCEyx4kDxpRfpNmQol6S9hNC6ES+VoXB1d?=
 =?us-ascii?Q?w9/+vMn8zDhpFxwDP3xra+QdUzUuIp96MVWAXd9j5xPESi0y86yg6ynuQnfK?=
 =?us-ascii?Q?w//FQYp+Txms8RuEG8TrF+Oizuj+Bm2l6SGExBV2ZEXfyNll6CcHNu8WAI7a?=
 =?us-ascii?Q?h9JsQlqIzb3a0YhXpppvQYvvn7SyHHJtnNY8AfV/e2oYIhhSrDi4g85nyA52?=
 =?us-ascii?Q?ExBMvnh6ZAXZrKL1rzGNL1v7xs7+IDYkuE+FyxEv7T4vfOLTLzuVdNR26tg6?=
 =?us-ascii?Q?8t/3WdLtz3HZ1+TunuGnQWAKvAX4IdbVSopq2aDjqMBnY3tO8DJovnl1WHwV?=
 =?us-ascii?Q?7oPBLbGaN6X/sFaEkPRNJfqgVtaK/LAana1yBCR66KSfN9EKp4o4z8DmLhC3?=
 =?us-ascii?Q?gpwXxs999lIsDjujGWndUEv1ruBvIKCwB9TEQRHrZvxWPvib8fjZV2tRScX6?=
 =?us-ascii?Q?ndrMZjnlFMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ToggJ2xY+9zPEYbIkZj5WkTs32bZ/p3Zx74E9d3RdHyq/go1B0ELUmUcJwZ/?=
 =?us-ascii?Q?L5xBDCd03dIEDgyIMDxf8AsOgMgkdC9MxOsrOC/16tqS4XUDEiTS0sFAhsLl?=
 =?us-ascii?Q?4kMRnvQM8AVjgxh+7pc90lQQFbtrKOCuuYM7iWz3A0XM139tI6PaEY6KFTsT?=
 =?us-ascii?Q?kF3ayvhkRGOojln/WDbHMILNGRJNoWh1IgVbSsWGC6vq/uaUfC5m+M7vIZSK?=
 =?us-ascii?Q?oEZ7d8VOMxbfQeLphOb2RNKpKSYmBLCVTKWpfqHyg0z2YBVemjhyQmG245Ic?=
 =?us-ascii?Q?vKNPYbv82qjFX6Z7jXFDi5HG0CB/+o9c8b1AdKKLP/75XAH+I+qq8NrJszRy?=
 =?us-ascii?Q?XsamV2nPy1gr46c3FtAueJ9z12lG4WBR7zf2WMscJe9YHZAQC0xztaCY8JBO?=
 =?us-ascii?Q?z6juxVFCEp50niV/o5HK6g9bt5Aqb5zhpTM0Q0A1sPTnlEap4ZtBhT0PsULi?=
 =?us-ascii?Q?IMbIbq+S8YokL8Yb2pWceQBG1V/GB/GJ3/mzaeheGCtBYc/nu3mMarcwdmys?=
 =?us-ascii?Q?YiKs63+LpzWLP0bGfyHK3glbhsnaW0i5Tyi2/fwwg1QNIbfMo+3fxWuQFS3x?=
 =?us-ascii?Q?1+HZNkC5/uJnOIcHQDBftP4eugcwp0dXSP3SAo5ZXxvNzorJ7yNdQiYNgREh?=
 =?us-ascii?Q?eh/B/FrAq0QtVuE1/jAO/ZC6dfkRH7rnpU5JKaYS9F7spUKWyNXi9Rp1sT9s?=
 =?us-ascii?Q?13WeJupFBzCISYRctTY2pNTBju92YJfiYHUM0tYYlslp7RK3Idz0AOmUtYGZ?=
 =?us-ascii?Q?j8njKxirf2P/F3x54HVi3cheo4sGojZGp9R3WitTr0KBS5k7RDq1F7juAAM9?=
 =?us-ascii?Q?BbDyNjBdF+ZZ88eucE5Gw4vwaWT4EDZsjCgqDJ2jEuaLTsjvaYP6DQaba1pH?=
 =?us-ascii?Q?7Sqk68b8DUCMr7/TmkQVRDdNudm/DzaIinbF4DapxX6QQiWi2KHT0Q5w5DNE?=
 =?us-ascii?Q?TDOdMLvAwVaFa3FPQbNXlJKhb10WhQOC1ra+l5Dn8OJmpxUE5XRLDmXztlpA?=
 =?us-ascii?Q?gm1CV7bfUUKUnZCCq9M8PKhZ2Kkiozh+0Q4IPHEB/5YY0WjOjxQSUEjMqWWP?=
 =?us-ascii?Q?OGlYRMT7UpX6IxBQsYBSKeuRM2cEZ1cHymd1zqGvmH2QzQ32uNKT5agGFJ39?=
 =?us-ascii?Q?gbZmNTmJVnW9hk0yCgV2JBzj78lYf2DSM8c0HwQW11G11+X66g0kU4dh8RTl?=
 =?us-ascii?Q?wUuyrNGSZo83MxA7FQ3Ebub9yd7xM/UVm47mXR9F3lhL9ygSL3LTF68PZ7L9?=
 =?us-ascii?Q?/c7RLrA/KVX0vDJBK2mYrNamcIIqtZpQ22ZayQlb3XVQ0khk807+87dBbUsO?=
 =?us-ascii?Q?WWQAiKR9fsgGY71i8G/RqcTEOkSYr5aCsuq6CEjOafobeiBUvJTpAd9wujmQ?=
 =?us-ascii?Q?ypN9IcJI74YgkbCNu8aLPQNgcqwbz1LkpLSdipnCgd29bhahvyhLbtGQCbwi?=
 =?us-ascii?Q?l6eBt7+rXpXi13jGKR8ky2Zd4ZOdKDDer6PXUgA5TeWVZjIr2CLbg2Kfo5/e?=
 =?us-ascii?Q?tB8PQmloaFdAVtjOL1lfA2PdnBeJClrZqrJ6hbsxHH9T4uwdKfQTJ4m0rA/A?=
 =?us-ascii?Q?EHQd8B6VZFWXwjSjaUmDNtU7uF2e7a1+A826PRAD?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bad6fd-e5b0-4cfc-9951-08ddeb273823
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:19:43.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JKxxxdY1iDuW2SzFILUJiK1duXV4E/5YMrDWEF2ylBNTksobLsIEGJjH9uOTVboHxp0WNs5H2Z02kifX8X6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwNCBTYWx0ZWRfX7PvHIgC2NLgT
 hzwEEd3BRE13+01CN1aNEcclay/drBcmkVRCbQyZCPPx2qain6q7CU3F1Y/qa0QLku2J3Bn34r9
 QMPJrxqHmD3ej4wTJ6YjqXA8Fj8XgC2Rl/6qOx8sGmwZ5KZyTAlScWipp3qoKxUz5XKglWhSNIl
 RLN/bKlp/m7PqIF1RByK6YbgHrNyrbqoROaMTDLyXAFJ+icHQ1I2/U9Rqzq6LbuPqgVdQOjiZ3L
 OzG4BB3287gxF4sLotsD+a0sVLfu5OAHcUYAU9qWDs0iipCIgPgbtWmP6EefkM5z/dq40I5MF53
 MYSwGUdQNmNkBqwSSEe9irPQU08FGzzEAgGrBjTN5oX/ooNUXvh68nk9GPZlAQ=
X-Authority-Analysis: v=2.4 cv=d+L1yQjE c=1 sm=1 tr=0 ts=68b8a2e1 cx=c_pps
 a=lf5jeAKrdlMBwfqj0N7mMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Qao5vpg7bkeMYIVlSYQA:9
X-Proofpoint-GUID: TCQUs6FhqrkAdPW-sDWQh0Wwws9phBRm
X-Proofpoint-ORIG-GUID: TCQUs6FhqrkAdPW-sDWQh0Wwws9phBRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 207 ++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ae28e8804..9987ac8a4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4305,6 +4305,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8..eed1936976 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -31,6 +31,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
new file mode 100755
index 0000000000..a9cb2f4621
--- /dev/null
+++ b/tests/functional/x86_64/test_vfio_user_client.py
@@ -0,0 +1,207 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import difflib
+import logging
+import os
+import re
+import select
+import shutil
+import socket
+import subprocess
+import time
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+# Exact output can vary, so we just sample for some expected lines.
+EXPECTED_SERVER_LINES = [
+    "gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3",
+    "gpio: devinfo flags 0x3, num_regions 9, num_irqs 5",
+    "gpio: region_info[0] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[1] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region_info[3] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[4] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[5] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region7: read 256 bytes at 0",
+    "gpio: region7: read 0 from (0x30:4)",
+    "gpio: cleared EROM",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+    "gpio: SERR# enabled",
+    "gpio: region7: wrote 0x103 to (0x4:2)",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+]
+
+class VfioUserClient(QemuSystemTest):
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+
+    def prepare_images(self):
+        """Set up the images for the VMs."""
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.server_rootfs_path = self.scratch_file('server.ext2')
+        shutil.copy(rootfs_path, self.server_rootfs_path)
+        os.chmod(self.server_rootfs_path, 0o600)
+        self.client_rootfs_path = self.scratch_file('client.ext2')
+        shutil.copy(rootfs_path, self.client_rootfs_path)
+        os.chmod(self.client_rootfs_path, 0o600)
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.server_rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.client_rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+        # wait for libvfio-user to initialize properly
+        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        self.prepare_images()
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        sock_dir = self.socket_dir()
+        socket_path = sock_dir.name + '/vfio-user.sock'
+        socket_path = '/tmp/vfio-user.sock'
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        pattern = re.compile(r'^gpio:')
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if pattern.search(s)]
+
+        for line in EXPECTED_SERVER_LINES:
+            if line not in gpio_server_out:
+                self.log.error(f'Missing server debug line: {line}')
+                self.fail(False)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


