Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FCC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZt6-0001RQ-Sp; Fri, 03 Jul 2026 05:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZt5-0001Qz-Gb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZt3-00084P-T6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:43 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636sHP12069502; Fri, 3 Jul 2026 02:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jwy9BBzk0ZDkh1ibuptR0lFgxIYSDADAlhsZXRYWF
 6A=; b=E/N2+sijN/CifxFt185hOt/1oquNPxfL7o79veqbaaHo3ecETE4v74JsQ
 ydKK+jCOkDmS7s2SXBxTZIwbXkPBYcYgXGnrK2g9NW9jYezv6j0/2YjDaEGlvPi2
 eecOkMom4lcMGx6x+LkGWd3WX59ML2kqbcr8CxdIL56Wh1bMyHNUOJJ6aldzxi+3
 a04k9wT/86Db4PKQp6Am9XH1+A3fT6NmHMjIrciPbLKxjPQwJH0G8NvTijZ7UICH
 EsMqbJ/4KzMCQsNlOvnR/uS6hLU53ZLTaUvFmBjtdTklq6DLC0TuX2yi7fhhhRMB
 H4N87EOSi00nw2p0nUf8+cJlPn2jA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023087.outbound.protection.outlook.com
 [40.107.201.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f687k0982-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma4ExMUV2FRVljyj9g04gwy8Dg7I3hOX/VuUYB9GWNLPpf46wdnZpPtZqFVVJOqFirxsEYdPO5pLtc4Q/r4sfdTAmXUnJnXoWhY1s1sjsYlcLJjsS72GJTJE0710A/p5WsbHVWThZDJ2UFzynd3qEaR0y/foDsgZ25usjg5r1r5FMOKo7oZ3YCdT6v7SLSxFbDHu7284dHuMOgYvl6jPE6Jifa112FChLJbPElbsWMb2GyXZw1pAXMa4myQsT6qQy4IIi/SMtlOKynjRD17jogrXlT7NE1Bq3o58dFk5V9FJNH5HDrIjENxLHnF1R/sdBE15VHH/4h/XfHXcvEOdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwy9BBzk0ZDkh1ibuptR0lFgxIYSDADAlhsZXRYWF6A=;
 b=lII/d4zx9Ht10GMkvzNTec2E33rR56mn/+FlM7g8Ncg2l/dYiielg/zD5/ColhHYW/LWxx7wvn4c5r2rDJBHewhMv5W7TvZ7yMVlb+pvkhClgiWU1GZi1ek6puZGENTK1iotF36EAQB4EtvtyjLw9E4s9p7jRgVcnl5K/JHKJwSvnr4tPH6lCGTW3iqn49GfLmmFl1W4JKwUpoIw9Lvq4Ktq+GEQsev2K3gEwFD2a5SitqCJTPThIh/ZOA7LLid78ZYKQvorYKVBnYkRLEr22PyLa0BMwDAnEPZR9hqEB3EINzHWICdi0LdCL2iOMpEgFvjxEK5iU+g2T3Op8MO4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwy9BBzk0ZDkh1ibuptR0lFgxIYSDADAlhsZXRYWF6A=;
 b=V3tXAdD+UIc47/NdY3lyoS4+RMkxLywVeLTVkmTTZtqx7csmgeuuy0JftOrcueA95sBENtJLiLjqqu0Gf6fx+jz4Ww3ykbedII031ZdhbyoS/x1eZRDfCZEvGa20bR9jhsm2rQ7GtAcdlsI7EUNbjTyj4gQ2cK5V31syz43sjS7AFBlB9Cz5qsQYcwXM2raryJiTqE4bScurHaPMq4jIXJEA49BZodjX04gaEavYEtTss7y99PrZWkIgSRATYm1rCYqVeAK+zjwVqXLaR0yxjMqYcl4Dl/hyAs8RrB0zZ9PhLlxa/uQfFobqY/il3qGS44/jqEI5fk0t8PXNh3yIkw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 4/9] hw/i386/pc.c: convert pcspk-audiodev object prop to a
 class prop
Date: Fri,  3 Jul 2026 10:07:57 +0100
Message-ID: <20260703090814.2993188-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0479.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 049f8273-7c8f-4acd-8aec-08ded8e2aae0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: yes8M1PIAIfJ2QF7ntXV8uFQ9ueVlaVMwdQnJPPYM1t1eP1X8JNV6sNOXDSW7M+KdUYB8aVpXo20NeoH4UfvHbpURZEuEyzqP/+lkWzwtb1lBidEQqg07M8OTN/2pCcYf0Wubcx179pSdWOODfDlBSeXqd9e6Q+Rd2wCBhtZ1VvMemI4MmQg3FVyFbneJcuqPpSYb1pH9udwOvfYv9cVuEB+cuDeO8WkSyapYh61pipfrI6ueBWQ6WET0LM8Y40zBkFAovrX3pcw/YSfkUiwk1arpg9ZDzX2L6QYTe081SJyIVTSfoctvoa/utbi/YYFmzo6VxABPJI2UjbhU/T6hoZcKOYZWA+UwHEEmwEKbQS/BNFEag93UNCdRV0ZwSrxc+zBlZS0f5fM27YQ3d+fvT7Dml1tF3dnv6+uL5aDjJif6A3iC/HCf2jR/WheYemupwNxNZk4QHa8eQAZFz+Pn3QzFHDiqqilMOdyaImyLoFSIvRHdQoDWs96zDAcZRVn2iy4DLoPyyHB/LITv4Qx+b2yUoCEqFV3J9LnzcRdLHb4EowQSq4hEve7laHMvNGToJctnHaW/ltOB5KUTBn1zOpzqxAgqb6b2qjC/EpnaYgJ+okj+NvZu01gvosXVt0gIVv8HGCc82sXm/n1/4+O0hP57kaoPosez9d2y4ewPG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWfpOuzvm2Zj999UACBL/Wc7P+zD8UTNOQ6zZUr8oYNEhoKBTXZasD0k/GvV?=
 =?us-ascii?Q?hL+H6vDU8GUI6iB/OnK/jMJ3J7ElEqwlHtTFEggaDVA4hMBZGATBCnPkZ4a9?=
 =?us-ascii?Q?I/CCE9AEk/MaZ4R5H/OxUf48xWdXJN5763hjgu4sLJw5qPdSoV0L7/xBzyoD?=
 =?us-ascii?Q?QAbkEBkWnFhgrrmSISzWqnSzII+gYe4n6Ym60WIEBOt4gmuL4uQpuneJ6Y6o?=
 =?us-ascii?Q?dOsBkIqPSBTSrQ2lKk/RyLmkFtpOymVvuv2u7p6cgMkhjmZnCVFleN1IPZyx?=
 =?us-ascii?Q?tq080jBRifgk+QWWy7eJzvyTI83xLfDIRxu/8aOVEDgAKLqCHqzcV5Qw2LLr?=
 =?us-ascii?Q?v5vOjChCah3Tjx1EinGLr6GuPjh6gW3RQA424CJx8mJYBfQPjVjPIG7BhT+Q?=
 =?us-ascii?Q?pQXICDzuPrrmWVUi9xyOqYoV79RAdVDQwdOd26Dx/YDK7EOTB53Lk1wbMyar?=
 =?us-ascii?Q?EfJzyHZQFwaMruAYnEosbJ5y3Rj1d7nKhXh1OckUUPNPf0Z1HcIYGcoMpU0n?=
 =?us-ascii?Q?u4QBEBbeW9j/VmiqsEuXaa1fB2TO6nTBjZkHUjlhn3QZ4qDYGE8yIlLBQ/Qn?=
 =?us-ascii?Q?3rlylikjTIpf0ajyIH58XtIRv41YNa/88zbveCNbkKIyI9hYbNhwlnLgyDuD?=
 =?us-ascii?Q?DTF+BIvJvQ4JF5PhKU/2fhfV8NX54ObtQVyMT+vK8vLYYk8b+cvb4AO3i9Fi?=
 =?us-ascii?Q?qGr6g8ujNV1fKPlz7xMgXQkcYnZiLku4L5B0g87uDNvFg7T9cV4m489W+5uE?=
 =?us-ascii?Q?4U5tQHZMNyE7X2UrGA06ZMbIHMnSuFGYTHY7TebaU3U2lscrU1DwFOVchSJX?=
 =?us-ascii?Q?wgGSpO3SaLUoay+AmG7CjefopnK3VJKCUoTDdlG0PFkJ3FqRRjqC7uQKIprQ?=
 =?us-ascii?Q?PvfeKO/O+Lj3JjqWdE7Gf0p9ElCEs6FeJhyrbKq2c1uriZL7U91Kg/AEsPGd?=
 =?us-ascii?Q?yIHfXL79XktM2oTMPqM2MnhjT0tMMjcVCgBS3eH1hQ7V1ZVc2n3a/Oub2yVh?=
 =?us-ascii?Q?wU8zmAKtK2OP7QivtkvyiosjZ8G2M8DIuKzN6IulSNpU5r1QsHWOb33MtsZQ?=
 =?us-ascii?Q?leE4coQxZsOjJocxZW48UXdpgZBJh6+qaWG+rwYvALQQB/kppkJ1stXBaqgd?=
 =?us-ascii?Q?0nys4pKHbsW6eKF6vxrZRL03/jq2VsbmRVHpVelheAY+TMf+Ur4VFeBJ9uF1?=
 =?us-ascii?Q?3abrENLj7MiEVs15Y1bPo7MoHZmWuxm2pnS8ESamI0qnD8ImWEA+Ya+7F0mL?=
 =?us-ascii?Q?G1N7Sf8V+RAfOtz7MSvEABY7xTGyqdGJEaThAbz2Yvx6gSZXyyawJbu7uwpj?=
 =?us-ascii?Q?/90Ew4SovRClzsrEpCNtbwsDOfulespXndpS75YSGP6ZGr23O0aYE7B0CWxq?=
 =?us-ascii?Q?UNCDoz/O9vRR7t/pFbODH/kksV/yQPsEhs9nFOg20FDlUzqt8grJn6flE3xz?=
 =?us-ascii?Q?TRDEMszgxSIM0SkYWpcCPi8kjtBjeeR8beIjtDztMU5afiOOj62pCjWcrhFb?=
 =?us-ascii?Q?ll/gpKzISz1ISvwI1BPFBM94K45ZduPD9JGytJzu5WkamXDFC5JGoQ8ymYKp?=
 =?us-ascii?Q?eUFNYY5SWYTDfOj2cQS9uvMMwqLGpSDbNdS2Y3Lf13mLw0o+N58kESUh0q4G?=
 =?us-ascii?Q?PaU2SaL6VPVp+Q4Kwvo6rGwILxTeJkN1Glmm+nHmsKx+EpGVFYCVl1JlCi21?=
 =?us-ascii?Q?74zWNPOaLm/RxDR2OX/d4x3377/7yRA94W+6IfZgx936YXEKPWkLbWQoCvxV?=
 =?us-ascii?Q?AQgd4A/VSemHORy7AInshGn9AdV4kww=3D?=
X-Exchange-RoutingPolicyChecked: XzTjS0EYk78xFqZSC7Hfs8DGfSJgaqSBwGT9X/6z6OrwGPvwQAVHgFpBsr49B/kA6xjGupSc374lwFvpYoNsdz+4oR5w87e0DS1vJwOpFwjhbLUbStLRARrdXsekG8P6D9roLIRobhWYTlBxDqQT8Z4+0u6UkTBGGtraWzHCJPX2obgF4dGFMsncrN5rlUMO1A+UYeuYWjmi2TLea09UzdR1LOgtd7R9EemaHie8ZQGBeoBNvMc9G8yh+DcIQQ+Da2JLLz3jD8hyDuSzaSIXF8NxpvM2lEr942Y3eyKCfRZ0YYC5j6uoyaXq89r/Luf2n1h7DeE4rswS7WgBUKzzQQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f8273-7c8f-4acd-8aec-08ded8e2aae0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:37.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRhqiuPzHT7l6bb1g4jfhH7y/8qyZW66QpzqbfbIhK8YA23jyS+K8RozKnrxn8Fn30H3FPt1AmOvbutr85nkchQ3n6KeNIHIUzrOCC7Prf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXysvrYPg+ttQn
 NETNRIl+PIcWIvaZWiPq3iBV4E7Y6YCUIZtTBzN0ErvvQ5shdSHkuzww3PevcP1PwbNtHD1uLFy
 0GlxbN2DNqLcCYRJ/CmFfrVaXm/7MSEAciGMbhec24WnHoen87aicaDlXkeZEbFb4os8iDK/2CV
 VCx10BNi/wgupMPlEmY6QHD7uNOgw59Qj/3E9Z7PQ5CT854h7N2QKkJpADLc00Kmz3FhH8y0cen
 nczt7fxchrmYd1xBClVneoIFuTXtrtjpub1HE326fBsYErnRklUcRn+7gRJJo2TIwgU1LJ98zZp
 HUy5xhpzx1/9pCHXyz2BJ/clwgzlaQKfOqCMLbvCW1L11eV5UwPDatZOutcniMISSM3fkcNsuXH
 qzgmE1T513q4v0NT140QVf9r6rf0IXtBr67AKtouuSmKgLpNPFAjqHMh8OGK4qkFTr/nMUbfaVz
 5chyILCR5AZGQ5q2peQ==
X-Authority-Analysis: v=2.4 cv=EZz4hvmC c=1 sm=1 tr=0 ts=6a477c17 cx=c_pps
 a=poqohWOkhvWL7PloZTu5+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=L8dKEXyYK7uH4lZ-jiMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX/CK4ZHrkWDL2
 a4IDqp5e8k3v1FQ7XXGkZV7joxUxyK7JyItJULdjaG5l25L0FjuSZBQ5hwWnYSyiyBo9P+iLSlJ
 bQDG9v5SSV1oHlW0gW0NB+hY5L64Hbg=
X-Proofpoint-ORIG-GUID: NCC_S2q1r7996TVJkQdexOq5wyCbyYBf
X-Proofpoint-GUID: NCC_S2q1r7996TVJkQdexOq5wyCbyYBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57..843a5a9e1f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,8 @@ typedef struct PCMachineState {
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
 
+    Object *alias_pcspk;
+
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73a625327c..b049c9f880 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1605,8 +1605,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
-    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
-                              OBJECT(pcms->pcspk), "audiodev");
+    object_property_set_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk));
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
@@ -1750,7 +1750,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_alias(oc, "pcspk-audiodev",
+                                    offsetof(PCMachineState, alias_pcspk),
+                                    TYPE_PC_SPEAKER,
+                                    "audiodev");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


