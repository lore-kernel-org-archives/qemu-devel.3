Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98BBC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAW-0007jN-8V; Wed, 02 Sep 2026 10:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAO-0007hR-PX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAL-00029w-8W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CUQFk4013759; Wed, 2 Sep 2026 07:42:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=7L9sPL6EJHCSF
 PFW3pwnGK9A9h4vtPJOh11vlKLl7Ow=; b=wFvuqAujBZXEuAeG5CN0TzdVJrZHJ
 EB8GFQzuDcXQm2kO/DzKSNvq1dubTmrYt4zQbB1Ybjt+jwn+gqFcdwIco9saoOJh
 BeQbcsE+93URbl1KaWxrroLJ/aGaRC0n2EFf15Zrgxi4PcLmCsAhQRPb0A3UIjHA
 Rc48rGwiiFsQnSv7T21a50f+puT5sl90F/luTjrz1qhppgklWK/iGJUOkfo/Jgxk
 PVHbocKHj0bTcAoXprQp+jQLgPl2NVylu1hiSaZUlgSaT58OBBPh7VMUnz+02DJ2
 +a740/fndjf8WlHx5HMa1UBLubnyMp0X9qPPrI86+H+bzdr9LnmohYrag==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020098.outbound.protection.outlook.com
 [40.93.198.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gdmw3n0b3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woYGJs106AWtRk2DgeZXoXp7VBbeOT+ZC/SeS41Ex1s8VMK5Ys9GvoTtPSrELm3X9Am8xyOSWb0iH2ejxfKpEFC4rjrIWHWyAgavdSsFgm7HpCiSgAi5XtLcSCYsg/UE8GbnKEDQPzF9YZc3MzQt90FXzHejgG34WD8x6/7Ir9dxiQxh+oNDPGndk3hSyXZfvh2FvrzaVKdKvarH4fjjzYsWX0DI5vVHiLRJQzu0nUha8ylurv0b53XTovSjbq5j2QMH+B271+MAEIzw6QhnT+zgjQJzgJGFRxhVynYXTJ7SxDpKpfIQhhfBM5vKRA2I0q2CnQcJstKJyYuPl3xgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L9sPL6EJHCSFPFW3pwnGK9A9h4vtPJOh11vlKLl7Ow=;
 b=UOdAEFk55IKwr7bQaxGfzKIqBQbtGoMOmbkOb+FPw3PVBRQnmxU49fCo7trPip6ZxFipeZnoxzcb46xBkC+b7vb020g0gdK63AgSIP6h/Yk9cQukqJ7t3T8Wb9EJAjhtgjKWMQgrjcbZ7CAXD0vmGYOcJctLZBL0jkMaKm5B3XCpOxnfyEmkSYoAAL3sIxKyanh2ghnMmwZWjAUIz8aJiXNx41tjwiuWg1S146MC4n0HfPR+U6E61eBsPu/AuDIMzuhQ/HKGzVkB9ia2/8gMWUo1dRvoFOOWsWTf43GpqR2UOhPgHCWRQypnOn521R1xg0MQGhg5OstwKWWMTmgHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L9sPL6EJHCSFPFW3pwnGK9A9h4vtPJOh11vlKLl7Ow=;
 b=LkrD1xG8q5A9cf44M/RukHQHBy8Uv/1V9KYhsZw/w3ihfry5PjFL4RRUL7g+asO67sbf+hi9jW8n+37ZUhTauzq19esOBhmKsEWqCVUT6OnOGtU5pAzUTwMqTKW9fFFpNCtEIRnV4c8nG2LDNHP+6r1x/KIUaWONq+40k/Ei18U76ol/cibOTFhVUDUu3ynaPiFqUT3TMXONj8Ov1lD6CZ3Ch6U5nJOLYZqxOCAZ+aM8YPLRRbMT+kTvkFFSNSnwgp9N7sfpVDSbcmI5x9tTLCJrRqq22TEyC1TVrS6d4qP+T8GaqFsZapjlWBjTffiKX9zDrQ9yj0xN6F5kgNcTlA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CHXPR02MB11331.namprd02.prod.outlook.com (2603:10b6:610:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] hw/i386: convert object props to class props
Date: Wed,  2 Sep 2026 15:40:47 +0100
Message-ID: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CHXPR02MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: f9469774-75f5-4885-787d-08df09005efb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: HMW7aTiDjXE02OSMTvcTbPqfqjSHjNksmid7LwLsQtgS9N6p/1o6S2ibslxF+1G3R2HY+1HQdNHjU5V17sIf5laYNfeYsp3hassuOqEh87CgO1nD4S4Y6QeQSUzzu/JKB/+jAHLmTNANU1ADw4veJjQk1foTmyHmQ1TIl8FPOSDNQOBw97nExXmXVQai1BJLK/Dg0XzsOJ75/lr38rf5jxPxSjRO+6QQyRni8imlHLfoa9LTwwahKzD6/zZQXXAPmFCrvpRY55QjBah2mMOpN5jM+sSXTtveOmBVgVviGpO4KK4wDSqZtO+72sIvxgaT9uMLNi5PfsL2tX14QvC8EH3zrZ3g6PB7TV4rh26Ibf+0tez9Wa1uJulGAmuGQ2MSexEAO0mJIiGewGebmKDq0amhTEcqEO9hPXDTNLOwHKW0oFhw4b6TXoxfig3a2LZmJfl+S2dAcrTF63Es9MfzYdZjSYLzhI5arovMyzpWYeLnBqWY9c3yGk7mPt6WMaLz7ieko6NhqXOaklAOvmjqyph6akK5zu4ubZBKoTHE6OBALfFF/XF+TAN0WXKxvFxQoxIog5HuhCCnG1Kzg5RjGDYo8Q2Jk1g87icYP9JDKvuLpVoz5v/h2wB5ep7A3TqUQQKs9+5bQiWcTEp+DvNL/b0tutj9KegsiJ4KnVKFQjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJCZHhwVUsyZEp3UlJ6MkJCVGkyUERIWDlyN1ZVK1ROSC8vVjdRT2Yvb25j?=
 =?utf-8?B?WHEzVmZZYTZnTnc4bEdDRG5MYkZJVWloSmgyZTlsbndUMk5TbjZQUVJhUGRm?=
 =?utf-8?B?d0lGUGxqa3ZTVGdZVzR5YzlNZ2Vtbk56Qno1c3oyNmZiaXZodkYyQ0FiNjk4?=
 =?utf-8?B?Q1pKRUpwUCt0QjJNcXRzSHNQTm5oMzI3bnpPZkozbWMvTVJOUjFQUUh0eCt2?=
 =?utf-8?B?UU43M0daSlpLekNGNFNMb2NOM3pSZWJTVWt2MVRkVThjUEI5UjhOZnhzV2lz?=
 =?utf-8?B?MjM1R05rVEVtSmNtVE1Xd0U5UzJCaEtPRGZDWXR1Mkt2Y2hxUTlxWkRxT0U4?=
 =?utf-8?B?cFBhaXRCM3lOTEoyQkQ4T0dNTndKSTlTblFrSWt3R0ZUNTFkNGtOVU1XMWxu?=
 =?utf-8?B?L0ZrdWtCdzV4THYvS0xobVF4SG5jWEZHZFpaSzJ2Z1EzcmVWcy92YW1vQ3lu?=
 =?utf-8?B?SWhwNEZscEhtY2F1SHFnWHNOczJRYVkwUGt2QWFwRkV1YlVpT3pYWlZKM01s?=
 =?utf-8?B?UkxnLzYrQjhtTnA1SXh4SnJJZ3RGemtBRm8ySjJOd1dEWlhWZCttdmJoQWtX?=
 =?utf-8?B?UHdhNXFIMFFwWEJJU0ZlcXFkc2VvRTVSSC9MNFRSVmQ4UjE1dEh4amU4NEZD?=
 =?utf-8?B?SWl3WG1IWklpUkpxVzg5eC9ySzByVU9rNUVKWjBpNHlZNzk5WWtmaTVDYkxJ?=
 =?utf-8?B?VUxjQ1VGak5xZStoMFR1RkhGdmpZWnhSNHl3Q2FhQmtLZ2JkVjhqYlpqS1Jv?=
 =?utf-8?B?TlZCbnl3SFVHS0Jiam5rZmYyU2NTcGYzbExtS3VSdUNVMng5dzF5V2M0bjk2?=
 =?utf-8?B?VmhpUmFFS2I5dWlINlhIK0prcFd4NVdwNFJvZnR2MGx4OEcxREl5K2NZTWxm?=
 =?utf-8?B?cDl6Q3Zzd2NEaEllOXcyVWxhRTZFLzB4Z1RhYzNQek10UzlkUVZQVXFwVVRC?=
 =?utf-8?B?VHJpVzFxNTRuaU1EU28xL2ZGekJNalN1SzB1cFNiRmNvaDlhODkxQnJoRU5V?=
 =?utf-8?B?dkVMeTBOb3R2ZWpqTTdTcHhvYXhnaVlyNUt3QTZQTEtrL3c4OC9ja0FWbDcw?=
 =?utf-8?B?dndwTU00Z2UzUng2WnFLck9SaTZQcXZucGlUSVZyZk1qN1NiLzBTTmpPSW1h?=
 =?utf-8?B?alNpQUNmcFdiUGpiTkVGci92Wk1tL2NyYjVTM21hOTA1N3N6K3NBdDFjWEUv?=
 =?utf-8?B?WHpXaHVnMFdNMlZINXM0bW9nNmhsODBvc0RIYkFjRWtvVnNjS202bWRwN2JO?=
 =?utf-8?B?Yk9Qd3JETWIzY1J1ekRFVnFnTDJZcHFJc3l1RmE1a0Y0QVNNemJDcFJXVVFU?=
 =?utf-8?B?WVJhczFZYWhRWHptK045cDNmWGYwUVJOV3lhVi9OdUVIMHNGT0tRMU5Hczdj?=
 =?utf-8?B?Z01NV0RhVnlXbUlXN0t0c1BYTXlMUGtZYnQrMHdpUytiSG5XeVJFZTNSL0M4?=
 =?utf-8?B?bnExMzZtSXN3YVhZa25iWnVTN2lhV28yYXo5WEw1dGwxSTA4dVVnZko5enQ2?=
 =?utf-8?B?cjQ5V2V4ZkM4WGdXNWpPUFdqQm9HRVUxN0xXWk8wLzRCWVN4eVJZV3NPdk53?=
 =?utf-8?B?ZU1PYVd1bE1zQ3hTWjIwSkV4WWN1WWpveHExZUg5QVBLakp6d3pyVldtOVk4?=
 =?utf-8?B?YXFMWi9CT1NJWDEySnFtbEJJRWdEV0hhbXFXT29vVG9hSFh2bkJrU3AvOWNr?=
 =?utf-8?B?NTA2Rk1rU0l0OG8wNVlySXhsbGlDdjJRRms4RTBKYlR6WUtJZ29iZU1Md3pC?=
 =?utf-8?B?TDI4c29xeGtrSm5tcVNGS1BvMTVZbTYwYVhoZjZUcWZGRXZUOC9rVWUzTGhZ?=
 =?utf-8?B?bG9Ga3dmbHlDL0NzT0psd3VHQlFXTVRsajVpNHR1bWVHcXpvS2xtY0dpZVYv?=
 =?utf-8?B?R0V2ZHd4M0JVcHA2ZFVhc3BPZS9oc1NDVnFYTUIwc2ptalRod2hqQ2haQkE4?=
 =?utf-8?B?ZDVLVDdmVWxpOG9SN2xPU2RMOUY5L1ZzZFlPdDZsaW9SSm9kN1JUQ1djUFdt?=
 =?utf-8?B?aEFqTXZaUmlQTngxNjBCbVlWTmU5UW9OaWo4V28vSU1YSHV4bEdKREh3OWJH?=
 =?utf-8?B?d1k3ZlhpN291R2YzY2pJVHJIekYyM1ZBZlBPV2UrdjhucnUxUHcycndScS9v?=
 =?utf-8?B?UzdsOGwrdHpnRHBPL3BPbWgrdG44cGEvUE5pK2JrN3ROT1dIS1JlUW9nVUgw?=
 =?utf-8?B?V2V5bHNZRnlmdW0rZUdjT0tJZUsvcStxRDFDQ0hIeGlGMDZJbWNYL1lUR3Iy?=
 =?utf-8?B?cTZ4bU16aWZxKzFac01pWFRtbDZSZUtHREEzdjNtS3BhMXlIS1RuTVR1eUFr?=
 =?utf-8?B?cXZwNVdxWHFJMFQwMkc0bEpuckpjWTFLVVVWemFWOUJTOHBoai9semdkMEds?=
 =?utf-8?Q?zbNGKM6gjxCzPC+A=3D?=
X-Exchange-RoutingPolicyChecked: 45yy31/bCb+Df7OmQp2jjT+E85Q5CRh8Lh9llgHw9PvBtDz4WLGEkXS6wLrCpNs67YskWYk6siAt+mNfAauIdRCiMQykzLlqYtUDVQ6Xpmd4RnfJRutLMvizdPV8Z1EFxka9RXrAHsa6Mi0uMQXq+coaT+nHk/Fahw97hVsZs/N/HRERxztCYO4a7V/k0D1mY1vKgXkyVjCh7v5KlaMIQM+UJs49QS3Jm2b5OQncdXFpGeQMyhaBjXtedLBwlA9nEsqaywdBM96uQzySHl3iozIbVLMCmIFdvQm51SK2DHclfMnce9frt/1mFXRAjsN1gu9AARO6EV7chbHj9WT7aQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9469774-75f5-4885-787d-08df09005efb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:11.4612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2LB5tI/THqxIbJ5YD3BbkRJ8b77bSieky6ytdPQLWA5wfkWA9f89ZvhFCc/ovLguNGFTq6FYl49ibGLv1dALFwv1vhsIN5Nbtgm7FB1FU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11331
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXxRWfV/wcgw/s
 wqCOtdKCzrpJ57ZZNe5loYCZsnq1Rx73SFLdb6YVQ5b6itTC8ZpTVRI0YINvcXtIVS2BzgWEvKZ
 4CcehD3l3ASp6tYtN3nrn/3hOGDLYBo=
X-Authority-Analysis: v=2.4 cv=PZfPQChd c=1 sm=1 tr=0 ts=6a9835c6 cx=c_pps
 a=5WG37Iiv9zZuKkK3l3Cj4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=fftrgsByXVBibpBSsv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXwBMVU98q1VYs
 FKndGlzSYUmGWo4AHPii1GS9Ens5GgCFstRR3u+u+q8iMhsI+f9BlzhQ/GB9lmNdE0teA2s7OSu
 tFC75Ukxadka9EQPhl7paHwk9e16t+oudMr2TzkpcpdgeRIyY+tPMAc7lzWyWcYqG5Ms1P1dtiS
 KlSyrZ1mJVlunylXAs2SARJa4/KsCe7jgpCMo4IxmOYWrGz8MikqMv5GT602JkLJ8a+XKOKxB5u
 hnRrN30RJs7jOP5qR/iCP8+r5E6XOMgleNnqrATMmyXuYneVpwMgj2BO3hgX8+ICJZ9Nyt0wv4C
 7qO9ZW+L5vE82ea+eh/l+5E+dhZh1+UDnwgRoUK5feDJ+lBShDK0h97P5j9MhajYcTDA+JlMO3I
 HhRd5yM5lZa4ga0X5Lu5n6yncjE0pM8aD1a/EqeuMYkfDkaAm7NskhBY/4qxoLgfjxMGPQViFm1
 5B5HsEQl5h7np2KxCBg==
X-Proofpoint-ORIG-GUID: a1wey-S2VasZ8_akrgfraybaBtU3Exhy
X-Proofpoint-GUID: a1wey-S2VasZ8_akrgfraybaBtU3Exhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/i386 to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

In order to facilitate the conversion of alias properties, this series
introduces a couple of new QOM functions: object_class_property_add_alias()
and object_property_set_alias() to declare the property and to set it within
an instance accordingly. This implementation is hugely inspired by the
existing link class property code: many thanks to Marc-André for doing this
initial work.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

(Patches still needing review: 1-4)

v3:
- Rebase onto master

- Add R-B tags from Phil

- Add kernel-doc to patch 2 for the object_class_property_add_alias() function

- Update refcounting for alias class properties according to the description
  in the kernel-doc for object_property_set_alias() which is taken from
  the existing object_property_add_alias() kernel-doc


v2:
- Rebase onto master

- Add R-B tags from Daniel

- Update comment on patch 7 to explicitly describe the change in behaviour
  of the pflash0 and pflash1 PC machine properties


Mark Cave-Ayland (8):
  qom/object.c: introduce object_alias_get_targetp() lookup function
  qom/object.c: introduce object_class_property_add_alias()
  qom/object.c: introduce object_property_set_alias() function
  hw/i386/pc.c: convert pcspk-audiodev object prop to a class prop
  hw/i386/pc.c: convert rtc-time object prop to a class prop
  hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from object prop to
    class prop
  hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object props to class
    props
  hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop

 include/hw/i386/pc.h |   5 ++
 include/qom/object.h |  42 +++++++++++++
 hw/i386/pc.c         |  29 +++++++--
 hw/i386/pc_piix.c    |   5 --
 hw/i386/pc_q35.c     |   5 --
 hw/i386/pc_sysfw.c   |   7 +--
 hw/i386/sgx-epc.c    |  12 ++--
 qom/object.c         | 146 ++++++++++++++++++++++++++++++++++++++++---
 8 files changed, 213 insertions(+), 38 deletions(-)

-- 
2.43.0


