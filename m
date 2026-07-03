Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB5EC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZtH-0001T9-69; Fri, 03 Jul 2026 05:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtF-0001Sy-ND
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtD-00085O-8l
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:52 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636qxK82079481; Fri, 3 Jul 2026 02:08:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CeSyi7x7MlJlUozEquIOOA9pBz0YG6Ekqy0uREcyM
 p4=; b=ahgvsopy5cyT1Tu+EaGuiUkztGQeUiGRK9z0cWwmYRspGmvK0B/y4R4r1
 Rh+xjCny59oR8pxIUgtp4PXtHWRpipehmbeVKklkWXGWSZj/Zv0qZl3mEubWIUdN
 VDqYyq/su9ntFggLM4JtJiC5VJxf9RhR09Gq2hdGvI79qka4pdF403hOpCaaIJqu
 8uQFhSfUqPOjLZq78pjLSfDhkYjlKwpbNELjonQmRz6rIwtwJkD8zZcOjIr13Fbi
 443vRzxVTkqDwjK/akgAfhgpgjTWTxrgw2vv7AWFY0vTFc0HFHAo2hQEcDeGC5ma
 cnGFNJ9nvEvlHoh5eOdslHory/5hA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021089.outbound.protection.outlook.com
 [40.93.194.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6871r9d4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgZAWY+UosW4eh6wsySLDCxGpeWLY0rsLc8P8X7aI2Dq3hX2AEpeViCz5YRSRBCA2jO6zuofJvU4Y4tRnXv51zMs2+FFMgSMxMRpLDis53hHlRCgZEH7pU6ObLWIXT+c5lMNczwuWIaN1vkAJqjXYwoKnQid+wTnrttspKPp0ON1U2N/BX5iUbFHiypSr4Xfk+B98ysGbQDHvmw9N4zW39X5+Hczt3NoMjL/MiC7MPkyabrytCuh6pjRubS0QG5yiZ1LvQHCWti4PGNmBlPcaUzEmAui1z50tYNkseFLH9XjJ3Cf5X2QiiyjaLHR+e5PZHlHn6le1L9KfsmzQU3fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeSyi7x7MlJlUozEquIOOA9pBz0YG6Ekqy0uREcyMp4=;
 b=jOo/qbL61wVng39wVcjN1689salfFI1o/UugCwg09TdPL5cqt9zG/OfpXIDYhXMlIr9NhwS7wz8m+drRFiI35cTrNZLCvqgUgyhh8YxJ0dsBR/siWQSS5BF8scECU3AT8fOcr53e22CdXCrWc5mnjLeEl2w00SHPDTAHZuxzatj5eYjTiuqiOrvXnxn9kLqP8t+yrzzbxvyvut10uQGTNR0al9rjC7NOGLyBedUgf6Ntp7pUQUAhGoGgZnQYEHGRLsWLb/U7KNQ38UM86ZSnKvvFUYSEXL4X+JinaDNbZr4i+V0gTaFu3H7yxLCCzCPp+pz0dd14sO3BXU+YBc9tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeSyi7x7MlJlUozEquIOOA9pBz0YG6Ekqy0uREcyMp4=;
 b=Ixhua3woEHuGkREhwVwkbbF17C4tEpvtN3rG7lr24qWT1H3a3LSYN3w5JQIzIgREVJQ1b+7HmcDqQNOnHSf4I28bv1deo5cGLJVcS7uHjQSd7u/nV/bKT4pPkZe2dFz0EWGkDxvKw74afDOXe6TOErak4anMwXVS8MrsF38VI0Eqm6S+s78bHw5Ft3lAoWWCn+Y5/d3WC7ITeGU/OKldpQQgugw/0fvDmkcyUufWaX+bxXD/ybTTHEtEMejLMYCVheDzRH0vvO1iMRa28/Vjap1YZe/h0uFPrcqLKh9Mz+K3qwGtpEjwmfytDWPZZ09yXBpRi3rN2hV/fSt3BgI6WA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9420.namprd02.prod.outlook.com (2603:10b6:208:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:08:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 7/9] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from
 object prop to class prop
Date: Fri,  3 Jul 2026 10:08:00 +0100
Message-ID: <20260703090814.2993188-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7a0a1c-da19-409a-59d6-08ded8e2b042
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: VPxS+lDu62BX4r7dlEQaTTm+Qk365Xy+b6XbJitwTtMgRUjryrq7+1T8LPWi8RjUSVWunoQdNrG3ZDgGEgEm+T7di5g/jFEABR0/ljuyNDYO8pKTXdNYix9bGy7mMgYQtBFKMUCQNwBBo1LZW5DOydtwsCbG8Bf4Qh0TTKL9G1jUmyNbA2cQsOKb24AO1y2bA0d6Ynqxf7h8qfuhYpMsRevBuTmY7RV+rP7KcD2sYVCnScGhU+ZrVtyluHO2jvOFLPuIyL7ZIT/M3zXhndwl96mBWMZUDMyOcA92wb5rwFmk3dZ2fH0ud8gxuwcWsBR7wIHOQL3tpnRQ3M7g5f2e+U9/6G8HYnl8LumHK9oEM37iS+Dzq7cFBzNcyc5psk0+YXp+s1tByCwb37pXToFg5jjxFpoCQJOidU7gNqKxgWzcd5k4p7DM/PG4DzEFrVI7mQkk+ZDcnbzMHkR7dF+Mg4ytqu8jf7wj2Gyo042lnJFaJPKVSLDDAa6veS36gb/+r+jwdxFUdY4r5a1jWudTlbeOBDbEhf7kkRxiC6DVPiYsrlLYy0wHPuYlCdBd7jc3jMCcde3bagVXG592ZT2WKcnBHh1j1vSl0gBt2bwAVgbMEZ82wbCqmLsrxjl9vJuYFyoFpHyPESU0NDfqGhCDKYb8dnLI0Py92pvivjJj+Tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mo8pxD57cPgg+2vZ5iRZDclF5IjQP67o9xWkK9LD3h4ERxXqRo23bGyUe/P7?=
 =?us-ascii?Q?3ZE5eIkkTGJ34urZdKHouQ4pEDalwBbWW5VbONgnVOpyr0ZFLdRDKmeSOOGm?=
 =?us-ascii?Q?Biam9NtNvpZzGcbakspJxbWsByzywM7McGtZuPAs/yQ1/POYiUS2AStpmcsy?=
 =?us-ascii?Q?TxFGZwPyxVBRq4ujpDcHk+zYtB3gYpzuwYAf2Xvjde/z12y6IqYFkGC4Sg6M?=
 =?us-ascii?Q?y2oOSbMQPJ86w5snzSRj0BPmVO4awjdCAXTY5txn7RlGc56vaNFC0cD57byL?=
 =?us-ascii?Q?uNasexVMYv2VJ7nLmPQ/LnN/gaC8ZqLqDXEWyV6MEwFIfJYq0lAeQKo7Wunj?=
 =?us-ascii?Q?MZzMg2h6btIJQB3Q4KE20lBbMmfnlTCvttvfcqogO4Ea1VepiInYdUzS4ybC?=
 =?us-ascii?Q?wchC3qSFH/VWysTGSn8lSma6JqKHrf9DyEcmog1mdAjaCv0h7+2f3Vz/QP7i?=
 =?us-ascii?Q?Z2/ygjg85h8PaT28tWJ+ZMDJPpsXGxrjhgONTbEZ5iaM+wblZfV9W8yba8us?=
 =?us-ascii?Q?3qC9EZSTOBfXTTRILNmY+e3NXqLcGEUkNsiu7zpq+aU074bA+4j4DKA886M3?=
 =?us-ascii?Q?phf6R8ie1C6TF2MWN5qHm6ncwsft5B11XbikWp4a3SNxGhcXBCr3lWpeOSRT?=
 =?us-ascii?Q?3tdr4WWkojwohS/g4VUtCOg9FHc8HZp25SIWz5IC8HwQAJhi52YoHVYqVPXF?=
 =?us-ascii?Q?hPfQcjeh/2s6yvLiZ8q/10EHHYEKpX1MzG6OgwV5T44mZNJsouLxdPMATE8a?=
 =?us-ascii?Q?wXgYqTTMr2TQ7xrJNT6ZL7oM60OJliSx0eKTyenR8LLY9kI2zYT2YHvanIRR?=
 =?us-ascii?Q?5UfpNs9O8d0RLu/Va13BSB8J2sKJFmdRNJVuaS5Bod7jRQH7WfUotWtMaAUn?=
 =?us-ascii?Q?xU8/GB/xtbbpp02x9oWr2P4K4PxcLzJDYn0Pg0TvtOS6NfHwSIVutqjYtg/u?=
 =?us-ascii?Q?ODL5E+8/A3mOya9WzROUpnWMFbIpHKeJaG1rqhwk6u6osa8jyQEwEtgzf00q?=
 =?us-ascii?Q?4KPQlWrrtNZ4nGEf8SoupJAphG9esW/ScX2Bi43KAyE0u5uL0cU7h1QvElUd?=
 =?us-ascii?Q?sWWce3cJs+bHwqPjMjg3jQgvo+uMVezivHKlVw4H6b/Cgok5Wnv1O4CImlPG?=
 =?us-ascii?Q?CgKjBKwcnO6BYa0gihFHaRQBww+utwO+GrxN5k2sMMAQtjRMfaxe5J9ybpGq?=
 =?us-ascii?Q?ga9p5EdJBJYhY84XEISh4183nu88TgdaDDtpOIt8UwICQXhnbJOV2NdcYeKz?=
 =?us-ascii?Q?6E1JMM57tfbAnPj0Og515Z828j28iLi6BHajHtLhRuEv0vWzipiIdaxs5e4a?=
 =?us-ascii?Q?7L9NwcXbIqei936AxW4saeCQqyCiCqmOvZXabrjn3RvIsvZU0wUGkkn7twyr?=
 =?us-ascii?Q?DwWsborpQZNNcs8KItvqvxGJ/83l3cOt7Jlb61Csql7ikzYgiH8dMlsJ59Kr?=
 =?us-ascii?Q?vBIx3DeygkyPQcp84ZynV7RiXmn69ocGn7Mn9+r7kpKBdevdG7g22GmTeYAI?=
 =?us-ascii?Q?l74aZ1Qw41IwCZ5s/Tfy1WvFFTJPeEr74O+DjiPEHMq/qVFLyei0ExeNH3m0?=
 =?us-ascii?Q?0LH9SBvy2Cp+yyFizDcQ5Eago6aPghYrPQ3BwElmRQduQHRC9X/DDamCBMRl?=
 =?us-ascii?Q?KSEoZs8PrkXeIpDCHs01Rxsk10vu0pzmif1fXgPE3qCW9LpW8QiQRoFGGQ6S?=
 =?us-ascii?Q?YXgtM5Thl5JabDcd6YULb3wq8CEJhJdYct6SFnp0VkKin2PkMZLl07Tn0jNg?=
 =?us-ascii?Q?xMOFvb8aCxKQQXHhnjP2ilP219ZudMg=3D?=
X-Exchange-RoutingPolicyChecked: GiRRmwbZT+VjeS0M1/W05nBar1ZfTXYxjcOsYs9CpyksnIYDQhQIi0NQBNI3PvGuqstX80znvtu66L7i2lSFTPEVvYQ3tiiDjazvXjhs1AdAs3ZPijCa9I+eNt5ozKhMtTeujRv9jYfOzdmimriyFFYPiPRN7gSkHCtU9Gxx2+lrine57WBXSdiOzYN2JOpxEwOB5vRK/s1eUNu/PslaZmYV1ubK64wD33wL2epYESHydDCOPrOcMoWRIpZGqQlZW5TYfJyXXgRlqdBpsgXo8F0rgMosuKV4UE+rc/1b5Tp9k1m41M2ISRHS12hmTlPIaO6l5WMLi2xkuqhPShutBQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a0a1c-da19-409a-59d6-08ded8e2b042
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:47.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwg7GoR9lc+jBfP4n015CmwdvmxQlOBzSgYmqxKPg69U6tlKnPqF7EBJ688qDR+dOOiNX9bl3eKnizkGAgmC0z4IMOP8pDkHH/Ql6vohgHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9420
X-Proofpoint-ORIG-GUID: msk8leVQN-oXYIAvUTTKg8QNATQmUbsL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXwuHQKQwtFeB1
 bbwJ+M/bwc0FtGmkpY1ERiK1jAvozq73cVztNbKYcLbd+Tn5ZjpR+4u0NVXa32Ie0mC3sUmA31z
 ajYuqb7JegJPrMwh92Fxa7+RY6e8iv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX4khJgXVlWeP+
 +7I2hh85X9JNl9Tx5eOrF60+BQStq64qN3dgY/ufGaiZZ6rSU23960M6lTWqYwSR1zl66GoP/w2
 tM+C8VuJ3/eNj8zqZkVrsqZ2YbT03zsWIGB6MVf4VphG8koo1HUTYEL+GnGH3Gg0ixc4Hdao6ou
 QsrqJRvlWTHL2N3X3iWxi7m/DQOHUykP+bRBElMTQweSaASR0jvE59R8giEiJcpJF4ewDYHbnvI
 NM2nnmhzHSssGEAuBKf+KW2imDT2sgcohAQUo/giJG5cataExXxts9Pqw3WcLE+PXS3Jc39NDvM
 qS2j2p32Mcc4gjbZkr83IVG43T0WmCPdKSKOjOdUxj6zZtAHTw1Nso+Ht4haEPJzgobfd9+6WHn
 1Yp05N6kVykTQY4teiy546NNfTpVlmbb3NIlQn64gj1YtZTodyXtrOd0eP1EVjF4I63IUVUHLLw
 Wb/vJjxIrpwBpzpscug==
X-Authority-Analysis: v=2.4 cv=S5/pBosP c=1 sm=1 tr=0 ts=6a477c20 cx=c_pps
 a=/L+qah5tOETEvltlblSARw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=UCpAsvFGFtcHmW4zG-sA:9
X-Proofpoint-GUID: msk8leVQN-oXYIAvUTTKg8QNATQmUbsL
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
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b3d4a26c94..13c9c1bfc8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1757,6 +1757,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_rtc_time),
                                     TYPE_MC146818_RTC,
                                     "date");
+    object_class_property_add_link(oc, PC_MACHINE_ACPI_DEVICE_PROP,
+                                   TYPE_HOTPLUG_HANDLER,
+                                   offsetof(X86MachineState, acpi_dev),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..98f2c4303f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -306,11 +306,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  piix4_pm, &error_abort);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f..d851a98273 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -247,11 +247,6 @@ static void pc_q35_init(MachineState *machine)
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-    object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             TYPE_HOTPLUG_HANDLER,
-                             (Object **)&x86ms->acpi_dev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              OBJECT(lpc), &error_abort);
 
-- 
2.43.0


