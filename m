Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCBBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2G5-000655-Cb; Thu, 06 Nov 2025 10:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH2G4-00064v-1Z
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:50:44 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH2G1-0007fO-Lv
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:50:43 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6B6Uuw2166353; Thu, 6 Nov 2025 07:50:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1Puyfq1Qj9yGX
 rd+M5Jqe7YGDnK36oAI+pUcxNlhyGk=; b=gtmJbhE2TCO+xojis2O0Foi4J94HR
 bEgtxEKt0qBi5aNH/0UsO4a/3J9l9ST6BLYmt19CChRBCRgxBbLzxfkDfweJZPX3
 q5TLAeJ6yTmrwlRPZsd9GUZrtDV4j9IExUJdVJkEVPXuQWOyd8m1YhoPiOlj2Xdc
 lB+ItPlAgURB/hexFJw5qMzPwS5HR9P2lGaIb/sn6Ghldi/kBmx0ehau2FQQDjan
 DH2otIzggms3ynHi1oEpdI8bAolXatpGF4f5u2VIsvPqHCaMsS08vJx/jBBfsHUq
 UWLkEPpxNsqyddRdjQRL+wy6D0DZcVy7rDrcKaD6212N55OZCVPpxtc8g==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022115.outbound.protection.outlook.com [52.101.48.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8tgt0mjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 07:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/9FXs5q2dkqieGBPz/amLXUVNiSzHFDY4QH17ODdaTlp8Ehcm9Dw93IyNwlFwZ/vVISo0Xv5nLtmNHYMlFH1KBT6pvNj/Dcnev/9HJzk9isfCR59jX0gwVjDLUQob8CXrlxj79Xx1K03Q805eym1eEkVZhXcgo5aK415Xik4WTsf5d5VG41woKAGFSBK91ptxCO1SBdV6IWlFnl7n3zYSYyG08lzdWkZl5XrpxUlrvDeZcSEsmQgg+kvbNQKOZatM0Qg20jLMbWQ6+J3dovLGOF9G1QyzbPhsXbJWi8EvJCW+ZUz++r07VNneEyg3DoYgT9Gbl3nHZF9fMTzwdv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Puyfq1Qj9yGXrd+M5Jqe7YGDnK36oAI+pUcxNlhyGk=;
 b=PQyU52FIvvJU2rQYvmYMMDqdv6IhpWHzQBII/pH5KWq3JKPEjVB5vciORztch2NP49EYkoRvNYWDRk05zf4U5hMMnHe3mMD8+VItbO50+mLIhEn9ilKPR7yOr6+PuIYGdJ87v4iYLpa+LKNPMSwJbj6qCtYgPg0Z4RKpM637u2MTkVU4Ie3xD4muPEK3HuBY3GLYq3HRUgOPnbutW9nswbKuvmKvc9hxnEylvb7XspLTyYeiZpCeE7bM0OqTsEH1HjeyRnB3TTuM+Ao4FdAs/TyWLOXEnSwmchwMUHnHtZkVDDRuxZMlJeemgFSRHLv+WU3mqt4z3PJpTEWznYQX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Puyfq1Qj9yGXrd+M5Jqe7YGDnK36oAI+pUcxNlhyGk=;
 b=o0XZoYFCBDpKsgAetdTx5Lp33PuwC2wdyI4XrrtPl3zjWHAAzLN8+vIJrXxMSFFAtG+75u2LlbAW7V+1xa2H3rcITYn/Ptplbysur+CFR+b+f7F3hlzgH+camBqK52/DrTi52nCeKhhWnWQmvdkEDvGkFpCY2te0lsxE701lsZ1om6ZWRIec+r4+cq06rqyB88un7We6foJBRUefPtMwwLlABTFckPTrjaJEgvu3eLOA3NtvaNRM6/HFOuLqdSOW4YNJldiQBgJnrDB4BmW8+L3SQYbhFPjdb5iBz/pvOUi5n04IhRJ5Ng3MYr+a/872D+IUkbK/+1dOhZ66a1kC3A==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA1PR02MB8416.namprd02.prod.outlook.com
 (2603:10b6:806:1f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 15:50:35 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 15:50:35 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH v2] util/oslib-posix: increase memprealloc thread count to 32
Date: Thu,  6 Nov 2025 09:31:43 -0700
Message-ID: <20251106163143.4185468-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|SA1PR02MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 45581327-69fc-4d30-704e-08de1d4c39ba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGlaO/Oq7nYIsfve1WBJ3y9AxY+VBrLCWzaEcAmP+TUpTMeP0olOr0NcVUo6?=
 =?us-ascii?Q?8PET9yQTnTIOm5sZmwdhcaIIT+tdfeVwIZX1bODYFlhCEVWLNh1/JmzM5m6q?=
 =?us-ascii?Q?bMT7QVOOA8wbn7GECkxdbn8gKOc7M/RXu/OMMffvoQAZzpBcziVuCJgmP/jy?=
 =?us-ascii?Q?1DiSLXQ5onF/arjwIuUEcx/IMjoC6LOqPT3Rib85TbjgXfXiocGuDs8gFIaj?=
 =?us-ascii?Q?XGTCG+/ehfDVt5KKML9UuTVx6ZzDcpy7yBkYveuIWSsVkjLEHAtoevM+hk3O?=
 =?us-ascii?Q?a1377rozSivpdWPS48zGH/ko1b3KarLTyzHWKbDWuJAzxlTrdAQZzdPbWpMX?=
 =?us-ascii?Q?IvKUS2TI4mXMFe8qyRjDRDXrqL+4DUNglkmwDdELgk6/AwMRfqAVzZ7JQm3s?=
 =?us-ascii?Q?NWrwFixBDsS8OxIH3JlidYb6naGN2Tlv9YyfqFQ+5Jej/pP8pUwZOpzBZ7tV?=
 =?us-ascii?Q?ZUkTUzHXPgqMf2ARlooGJ1/B6VM44AW6ay7HPZZkIEy0opfOy/KcEyqlL8hn?=
 =?us-ascii?Q?umhYlR4aAaeF04r8yNCKs2EyQlzgmPwjfHbwF58DvRt3lN16mbdshL1F1rtb?=
 =?us-ascii?Q?peo5wEfyAu8BKV7wSF47QIfmKQLstqXlcYRn+gDGq7m5xtVjOMdiqrVKw4FF?=
 =?us-ascii?Q?jTKIRkjXGC1Jm0ZOARaScWCmWC7wMMKJQur0Vvgka9yrWvEmrYoTxYbpu88I?=
 =?us-ascii?Q?uAT5nfhGZCOuYvs4xu8Km90rnCmRmGRyWeP9vQ44Q6SA4kiNklZ8WDSjclDI?=
 =?us-ascii?Q?NelGtljjg2A3Q/pSyGciJ2riMmFlD5SRqW9SOgOWllCQU6C9KUu+nYBF6zLW?=
 =?us-ascii?Q?9GmzS7/GxSmXIJxegK2HnWqLJteZXqF3l4OMOGGFKYImKIXd90BiJwhPEK9M?=
 =?us-ascii?Q?sbsDi6Y2iL4JYsw6T30KTZXWeG/mDbEGarmz0INzeKi0HADX0+f/Gb5VfgPe?=
 =?us-ascii?Q?+zGC09klXloPEVwPQlMi2EJBeaaAufh+vKGIhERIl0uiMlPcIPIhw5f/nn4d?=
 =?us-ascii?Q?2XdJxAKgHi0nrHK4k4C2ipZnNYiMkWmmgp73+r2HKZWtLS8HlcSiD9h6xlxQ?=
 =?us-ascii?Q?ZOky6gXpWT6jxZE+xw1SIHyNWXRMWnJxnM5WBHIx0UVRhfeR0d5ZuATBJ8Ke?=
 =?us-ascii?Q?wkkkULuH5y6shzrEh0+SEJzv+dMDKJmeDgSWLqwzItgNBNN/ThMeVYxs5Vwm?=
 =?us-ascii?Q?GxUmevUXEa+CUsQt09+urywnL7ijQSG+vzBp2N7di6Ksejow1X13XdlIL4Aj?=
 =?us-ascii?Q?QEk/cGgmGX0zK6RgxnH7bujvPcyNXiz5grGDgFOmmkhN1HWMiLzNE/oiQB7n?=
 =?us-ascii?Q?6R1fdowIydTqqD+Hymk1it10RiCDxO+OVQHbRI9mwTT6LVQFSq5ozBAovtqC?=
 =?us-ascii?Q?YfF+wnjWKw5r6GVsv7E5lzplw+ddqrQmxVVSCuzkEeg3IS7DdTAgfgm647+W?=
 =?us-ascii?Q?8p0PWqoI8v2tHuWWlvu9TDTGC5hb6sVlqxLtLFDYzNA2pIFSrE4pG5bJ+ib3?=
 =?us-ascii?Q?PKn29+d8hQrTseg0S4EoK/rp39FHfoHCqO5c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx+4FNGwXFHmQPm0Nc0yz0eRuIa3JwkTTPfcWCVpsgldn2rPV8f4mu6ye+cr?=
 =?us-ascii?Q?fal3oZSkEdotrTaYv4B6Mdj64sEQpUDeWTkuVwxv8IkgmelZ6IIsreZUp2bW?=
 =?us-ascii?Q?snKpnnrt+3B9ys8D9Pr9EMTowzHmwwzkbaw5b+IiYs4M6Cnt1z3iNPCOdbGI?=
 =?us-ascii?Q?6W0BazEi1Y1tHugnnO3xbFj3kJKpiJ9av3c1DYVGgil6A7cVw2Bux2S7+uXJ?=
 =?us-ascii?Q?PE/tZayRLRnFnLRW5XSIbb8IfqPerHxS2dQNCWjVMmlj0ZaaIZeKR4d4jLj3?=
 =?us-ascii?Q?3z1OcfjuAKsfIfFTspb4ME/yE71c8cH0vwlJY0YBirdC/sXFhYyLdTUOhVTY?=
 =?us-ascii?Q?lzAj3S3EL6zirO2KZqiOdRLvWAjitMHbWiFWibKoHpGqUKw9BtytnVHOKRcH?=
 =?us-ascii?Q?lYCKekFE1a6fxlfxEG7gcydRDhtAq6ArPkbEdpc8vHLeWzk+/iANKJy1rGrf?=
 =?us-ascii?Q?yhvtyXgAiTV0j87dmm9fw/N7t16n67TN75n5DJIYiLYeuXu/NjlUFyQfhYeK?=
 =?us-ascii?Q?ag6sDDeBKqre/stCkNKdvGu0jwItN/nHGCzo2Hhjb4B45d8S8ZHJnavj1pGX?=
 =?us-ascii?Q?9vOJv5a8lfj/gkSS3vh7084CAL2tI5Sw+chqGbYhQpFW82IVjmAfX7nQaeWc?=
 =?us-ascii?Q?tZaWPF5wVtdBEpbQDSc0Ux9FMmiSFzktfOQBEep3lw1w//4jVf7NVtD8fwuB?=
 =?us-ascii?Q?nAG47n21Cxm77T29q8cNV5lOoxyjq86hFrJQHQ4eeDGYQNV2j54lb+luDac6?=
 =?us-ascii?Q?jYxvAiSRn6sYGPWso5fMSchVzXweQDxFLK28sdBAroRZyFLrlm7Wpzy/EqaE?=
 =?us-ascii?Q?U5+R+eFMRn38YoN84svzSgqpy5QuCM56Wi+mz2X7Ui0GzxsUEJ8L9IcvKazl?=
 =?us-ascii?Q?6sRemHX8kvtEwcdQtr87+DwQtzKxllWblM+D3TmkEcdIjEWQgOi5zzs2ps5z?=
 =?us-ascii?Q?QLTJCRJVOwaViBZ/TR0xpgnC9CixmASj2gojKPgWVYclMv/m8JJ4ULIcUamK?=
 =?us-ascii?Q?omvGP20YoBTEuaN1N9i0p8VluB0p47l4tnpXzVLeRWbYyn5bN/uzvIqfrCtc?=
 =?us-ascii?Q?s7hSO29jclS73fPu4wQOEshW5+AnOBDmmiZPWWjbXTe6jurelum/pltULjMu?=
 =?us-ascii?Q?hpFHJrhlhMN6zHUuVUXDsp7JHNhjRu9zXlxyMauy8Wg+EZKaFCGFj+YzaiA8?=
 =?us-ascii?Q?8s+CdqyJydnuM36Pi0TYsWimERvGjRKetPpHwTvXUhyIC6DVj4unMbdWcxFo?=
 =?us-ascii?Q?jDOHdJvhOeg5KDMJs3TGcTzqxMTRfsovzoOlOAPvQbBVTKvNjwQ3btEJWImI?=
 =?us-ascii?Q?tFVjYQ6IrCQQhyrzzM/o5dOKCotL5AYPJEysaEYzLizQewb1jwKk4t1e0cpH?=
 =?us-ascii?Q?CcFU+1B/qqWUZsWCn0DMErthfaiviFkzGrn5+hdqv+b/ZtJdP9KuPRgyQyc5?=
 =?us-ascii?Q?ML6aJmOQUy/83L58nx75xh+sQnLtqXjpINaPuCf6PyunnbpUqHCUnosz5IE1?=
 =?us-ascii?Q?rJ5kZcyiaWg5WimFhUSCzCkxAhU9NOnIekhlZSppVtmIYPd2kJc2MEibPp9f?=
 =?us-ascii?Q?vsWooDRpoQE4wa2P/4ug+NJ5shJmSwJ2xSfxezRyrOIeLRf0WwkoMrIGqY4z?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45581327-69fc-4d30-704e-08de1d4c39ba
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:50:35.7147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo1a22OS93jdVEqvLJ6kRfAC6e847xLarVymymA76ohFYpjwF6ojIe24yj1nw46f8NFDr5uByl1VmPGI5jCAg8CuUiW88dUJgT3EblrgVhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyNSBTYWx0ZWRfXxnhEp1/LiNUc
 BfnCRxZOXHLrx7jOot0p5YxyHTSBZ9K75QwXDznxI9sETaNVwPL2Q6tTS32/qhOtFe/KCpkia1j
 hiiS3nO/iEWmZOqSjrW2gvZZICDZhnV38DjB23Z3DYKUlAOJMZeWTSA5UBSN4UWMSHxy3RtdKjZ
 GG9YgeWpqrFZwY3dxz6ymp6hKFcm2dwWUP2Gs7ygkUITdCpAGTCWO4bZS5LZMSkKJWRMdaNu7NA
 1nsl2zCEVVQHTyTDKwZP7ylYTsIFYUbu4Uml9O5J20sobrNIlPj9Sw3ZDO3OocDDYJdlWD0W1dS
 WhBg7RPNKHOvfJmOb7+lAuKG7MsFp4TWDqAadt1a8N6OwgZxoV/Cyzpuq94jJdS/MeQtazR+GhN
 Fa6yKJys6SvNONWRMjQOaAmW7Yu9rg==
X-Proofpoint-ORIG-GUID: 2vmos9tOjCAGW0ZeiMlAQhXjAlIf4NFE
X-Proofpoint-GUID: 2vmos9tOjCAGW0ZeiMlAQhXjAlIf4NFE
X-Authority-Analysis: v=2.4 cv=T4eBjvKQ c=1 sm=1 tr=0 ts=690cc3cd cx=c_pps
 a=p38iFvuc/7KNR/RXw9CScQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=MNuAG6uZD-8TOZ5Yle8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Increase MAX_MEM_PREALLOC_THREAD_COUNT from 16 to 32. This was last
touched in 2017 [1] and, since then, physical machine sizes and VMs
therein have continue to get even bigger, both on average and on the
extremes.

For very large VMs, using 16 threads to preallocate memory can be a
non-trivial bottleneck during VM start-up and migration. Increasing
this limit to 32 threads reduces the time taken for these operations.

Test results from quad socket Intel 8490H (4x 60 cores) show a fairly
linear gain of 50% with the 2x thread count increase.

---------------------------------------------
Idle Guest w/ 2M HugePages   | Start-up time
---------------------------------------------
240 vCPU, 7.5TB (16 threads) | 2m41.955s
---------------------------------------------
240 vCPU, 7.5TB (32 threads) | 1m19.404s
---------------------------------------------

Note: Going above 32 threads appears to have diminishing returns at
the point where the memory bandwidth and context switching costs
appear to be a limiting factor to linear scaling. For posterity, on
the same system as above:
- 32 threads: 1m19s
- 48 threads: 1m4s
- 64 threads: 59s
- 240 threads: 50s

Additional thread counts also get less interesting as the amount of
memory is to be preallocated is smaller. Putting that all together,
32 threads appears to be a sane number with a solid speedup on fairly
modern hardware. To go faster, we'd either need to improve the hardware
(CPU/memory) itself or improve clear_pages_*() on the kernel side to
be more efficient.

[1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3c14b72665..dc001da66d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -61,7 +61,7 @@
 #include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
 
-#define MAX_MEM_PREALLOC_THREAD_COUNT 16
+#define MAX_MEM_PREALLOC_THREAD_COUNT 32
 
 struct MemsetThread;
 
-- 
2.43.0


