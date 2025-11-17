Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3357CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bO-0005QP-3B; Mon, 17 Nov 2025 10:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bL-0005Mw-BG
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bH-0000eb-S3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHA1qlm3969381; Mon, 17 Nov 2025 07:57:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b
 9A=; b=n7H4PTLmWuqdoCA5vjSdaAldyR93zB7C9LaG1cePzva5sZuvVKKiXepCq
 DqZcv6G38ecEt6CsQoDQSiKjK1Kf8g0ZvdylHS5AuqwQpTcGzBNqKbmFsE339Ys5
 Lckr1PzANSUVlyjjnUazVUNQE+OAKPt/z53IHZX6hErJF/dXSWrgphMH+eIZ3L8/
 kJXnfI+GJGAPP/FDpAlaZqtSHAqgzq7YL8pD6nMx0WbcmWtAPS6+ecCmwmnLfkvC
 jDVLPeLAa3noYKcLQ48K+RZYm4jPeytTLy2QwO6is8xpdHTltxdnDgx7uH7l/qft
 OPRoLPifzUkESFNIHwRrL+oDIB1Fw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021093.outbound.protection.outlook.com
 [40.93.194.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4aesxx3g0w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/UKQwqgZhHVWHf52Ldm//kynR5pllOGPJLs8/KI3+ye8OnIUUQi2/ul9Y5XFA69jUEGDQR/UW1WW4dCBxGIMj/G787FT+1bd8I1ehro91JcAGgoq/YIu4BcxrAzVaan4l+VVOe9OZBT9z0jB5N9N/9uOljKSwn6Wl12y3zJOjJO8YPh8CoEvQtA/osptT2NkHEaik6Fevx91qkC/yDkQ9kTa1y8tBsZLGwPiEWnnS5jXE0mYCS5tM2k6MWj8qMdLv6JLuvVMwaGya3F/FnN0m0/qPLihZzd71GI+uryVl3gE6+S2uwt0/QF6GmR1bDv0XO+vWoBdn0oQ+zUL8XKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b9A=;
 b=B7My8VWScf6jx6kIOPCyyqNYxnACyKVHvzxggm065C2jv1qF7c9Z1/uiTdN5TXnNc/1Hd4M7FDA3lDC6AVEwgrCAAAJXBAjai+KoI9/bGhHCB6XhQyiUY7ZXi/O06sznIdoOs/q0/5LRLk7K+uWG5EF/Q0wBQF82Raqn8wCtZ3UwJTlF5NmJXZUrdYljh6uGmCBgxpqvJjQ/Ce+nQ2bt6S8B65s8bKfSfvgJxOEtNIRDRDUaGtnXe6Tg7WquQMsTDMe0cdQnGh2mOtdc8HJb8aeNh4aE0uqYxuIG5zvC+CnpvIYKmu/ukNuBL+rnHEQTJF6mUjyrfHa+whAOm8X/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5SGEcykyIcg7kkW61/msA/tfzdKNwXkhKT/wbI1b9A=;
 b=JnqWqcmVqSHB2DSV4Oke7/Vm2FmWfZlpPdX3IlAh1pB4QtKX6WLdbm5aEBAXXq8TiYWHHq/bd6CKC8GBf209RtiCPaqkzHJBU/y/yxx+9bRa99qLmxrFKxUbMHSqet2k/3m0YvkZWnzI25WJkf5trEVm0U09/8/xHHiGYQyAf8wsJjPnYA7veGx/zBhA5RHjueG9WEavmGovivUtagE/61Tnp7g7fsKQ9A7h/MCxBoggI4bEJgCBTWsKT/Stye0Hy+0cFE1YnbsEEHr+4tHT3FfryCY2yUPB+7Jp3caeCqb0MIV0r2l2W+n6nLIIj8OqKDjQ7vns17VfQcxv5E+vQg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/5] vfio-user: refactor out header handling
Date: Mon, 17 Nov 2025 21:26:54 +0530
Message-ID: <20251117155656.2060336-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117155656.2060336-1-john.levon@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d447cdb-b040-4c6b-c9d0-08de25f1f361
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j5le5xLoh0A5nXS9DBBhMIobqkZsXQaZ7/XfYMY9PfTuKUOuwwjeOesoRE6I?=
 =?us-ascii?Q?Dc/uHbXQDtCscQepUYvWVZcyUwSPx99kMAOgLD4PItUOpska4f1p+3tOa1+M?=
 =?us-ascii?Q?11dOaK4c49GpYv8vDBWuPmVoiqZX/8L/Mzqs8EEqk1l9GJswytQ0Bxt69uuY?=
 =?us-ascii?Q?6zSdvj/YdsU5o+0eQmeooIVKcqZEavZWe2yIPuZogiHeMdje2lqSPCYqj2Gd?=
 =?us-ascii?Q?0Arc/6XiC3g0nT3g3LQCb4jGsRuu43esK8CsTlr3VBGlLPHltBx+CpKmFBys?=
 =?us-ascii?Q?UCnlg9zaC//24574uhDQq6PlgnQjerT+KyCEcrbdWoP/7GOp+LaONWMrLPK4?=
 =?us-ascii?Q?NjJPBDWzuBxrXEFc8qyoipai5emhpi9tDh7UT/EaSsDo5H/QeTeBVleInU7E?=
 =?us-ascii?Q?4/Juzd56lFp3W9x7Q8IOQKwK7u8/yx1SygMKF+rksinnH/eGCa5wdYx/KSa7?=
 =?us-ascii?Q?XYv/WirIDHTKduvnXZUDw40gFASCQ5QjWQRnpdRavsyxsKCuEWzr6tcHkBSP?=
 =?us-ascii?Q?6eEzScjJ9RhRIykgtwWw7MlUTlMRuL3vhr6PzDLV8jbFrkJteA6IKcJ1m8Mn?=
 =?us-ascii?Q?Yux0rl6p3m/+V+zr0g/SNYmMTj3Ciezfzt6zzqR9IVLXhJ51hjF6j8P/epf6?=
 =?us-ascii?Q?+tqiVh2camcFmILH4Z/Hz0UWdwWcyq34V8xdRoee1qAt9CsyeX5aMqy27NBT?=
 =?us-ascii?Q?u0JZs8GleewdpDMutRl9gl4Mf3ye6mPa8kgOj4CN2NRt//+BJGVF4TTo2Yks?=
 =?us-ascii?Q?ZLqxTIIx42Wn5SepZ/5oARKVFhkRqQ38dkDwlpT6OBTGmCdLr5RG0pkWYBHK?=
 =?us-ascii?Q?+5sfdndibC6wTGh6TICLkLsnIbX13pQA1prvKVYVG0jte0VbB85/JYRbd2Wc?=
 =?us-ascii?Q?4CmyTJkv+5Bl3Lc709T1wP/5JZoGetdXW4+MguMKI+CblbQzX5vh4MuaWnnu?=
 =?us-ascii?Q?cfeaKDdNxu1z+UGqOOVeZ/ST8kFU1eum+KL03BWNVX8I9TIiOoy4vv4H5iwE?=
 =?us-ascii?Q?+DHJLB54chUf4Ct6RFTELLf8MNPzWUr928rhnNzsDy6oFh0CEOIug7uCbTz2?=
 =?us-ascii?Q?usS8IVV61m2DOFuI5OeS9rDewGgGUWlKzBlJBhUvRQjlX6mWG/U5rCUq08A3?=
 =?us-ascii?Q?chqO4IjGuUx2OL9P+RlWKDjnizcb2jA//AIf2brUXkNEKoR9tPpuz1mH7cFB?=
 =?us-ascii?Q?t3ENiZcy4QpxUj0b8Ic75EYgUVDcESHgW8ELFC7Do9p74MBEq5jOwW4xsixl?=
 =?us-ascii?Q?nHd3X5DvNZ/8hazUspMROgUbQtVXhsOL5BNbsneh7RzW9do4GBqYnH7Le06L?=
 =?us-ascii?Q?d0eC0MXE9MGyio7g6LLgfscqDWQwySWMfrbhMw72sL0Qkh2I/8/5hrNJU77+?=
 =?us-ascii?Q?L34Rd1IQj9T2Y5PzJRmhc2qFrczGtiPl7c7TwyiW9toJ+2EuhNsbZMfwqito?=
 =?us-ascii?Q?5Yb8rdyn1GkX84JapIpWt4lH6Ozmx/76?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cV8p0EpZK9FNLMuNv9fBcLvEIWomrETjCrSTfCdrjyZGCZwueixH8fa/bkqe?=
 =?us-ascii?Q?3w2bcxHMjOAacdL0nR/SE7jL4p1V7sRFPMBtwARqaAWq1rStMszrE6gkmvk/?=
 =?us-ascii?Q?WfyVqhtopsEtIsVJ0yQiHHeiqXjZGeNcuHR9nzdUI9FQsIkwmVziPloC9qJE?=
 =?us-ascii?Q?8bkSOtyNQ4BpNz2J+LhUHl9A5UsDB77A4RGFcPDYR1/aoCFGYuOgL95Tdz7T?=
 =?us-ascii?Q?2iu0Y6ir8JMHD+mXCcQOCBTedQ2/9XiAKpZUTsdNnhcrsFJt/Y32+4Ewa4Ug?=
 =?us-ascii?Q?3j7rb5RjSmyuKW2D+dtIHhSnGL/q6DsHXBADI6GUTGE2jT8j8msTu/rNz4f9?=
 =?us-ascii?Q?XmOL5iQ/H8EQNdJHqzbRUckHeXBQMiiT/R+4CYGwhCywK9LUvcXv+qsJQhxq?=
 =?us-ascii?Q?6UrYkgrqJTwvcqHCFACbors7y8UHFI7+ujlRMCAGxXLBT2zooF3yHPAb/6/+?=
 =?us-ascii?Q?dQEq0gabFcTEycxwVailf0LaZyp5jjmv/SJqbCKZHWnHo6+1rxXXJ55ARR/y?=
 =?us-ascii?Q?YdidvR2RALtyCBn6f7o71cDvJ1tOJskMuuntAF7CuHHsLs4nEPVwD2M9b4J4?=
 =?us-ascii?Q?4da7KZwxaGK1iRMUDHgaVJ0VBdMFDYXPyyr+5KeL0Fm65GvFsXt6ueJOG5Ge?=
 =?us-ascii?Q?lvrEIaqY1Kv4x2pGDncO3mFwmZm5/EltmNPVmMqkTxHYFMSTxaAPGXEUSI02?=
 =?us-ascii?Q?K2zHx94PGGnh1H6GvwNNK5isIst1o4VNY/KuY+ruHejqTEJhMHz2W/6iJw9s?=
 =?us-ascii?Q?tM82glbIH6N07rGJ0rburQdstNglbA+SrWsGmox46eMhV38GVRF2oIxvJHCb?=
 =?us-ascii?Q?fCtN7r0xx/hhrSIZCdwkASI1PEbwMXUeW0Mql/6CLXFgq0L3BCdSMMpstQPM?=
 =?us-ascii?Q?NQX0iwPj8Z4QoOWz29oI95LV0AvmyT34XEmLJ7snfnKsFwUm0QOc4e/nzniS?=
 =?us-ascii?Q?ES3hD3z9MEkxGp6fzoh2BAH7TMfvQnPECtsY2eDHrwkzDdV6+OvsXwACu/9y?=
 =?us-ascii?Q?Q0J6YY+o5ITOBK12Zdbxyl/PxX6NOehDN76Wzm1dIlvjnvin+xcMHzDz2i7L?=
 =?us-ascii?Q?7EMTIhkaP4LkqIEgcT3iIk4Uxmq4hox+X6E5oOY2L7AdtWDXvyEn36bAV8xI?=
 =?us-ascii?Q?Y9AQMSGZDRzAVTF67UJ+heaAuiqmlWjX3j1pA9WXovfLbH3TeJxULCDS34Ei?=
 =?us-ascii?Q?SL5Sv99npAnk3sS+zhRDac0jD764JDCSlz4O77QCiGjnQ6WOtzEPcm7FbTHx?=
 =?us-ascii?Q?FMkaYXD4587VY8CLZpnBLmAR3cCLdzCgu9L/UGrWPLcrrZRlEPEad3hLb5Ik?=
 =?us-ascii?Q?gTdXDvk66zvX+7s3pzKyaMjDmffMOZ5brHGVV8x4zEwdLAUXFYlgj5aX5k9W?=
 =?us-ascii?Q?7rHV+HJgntGiMPTOKD+G3GXZttP50G/xlmDa7FlclNWl9fbgEvpzNz7VVX+z?=
 =?us-ascii?Q?cub7b3sTDsJH8KU+3y95+8VQq5/q7uuZcxjmruGtUmnyRmGlhMbjT78YKmcE?=
 =?us-ascii?Q?7c4+RzagiL56B7mZ05aFYVLF5q/bcJN0lLAw8cSQOGh0TFYOoUaKD5BAD9xc?=
 =?us-ascii?Q?rNcp9xBd+rRfc4kDWh+4VQZG0cQkrhAeJejufkl+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d447cdb-b040-4c6b-c9d0-08de25f1f361
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:03.5121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPasYDsDyXYuxQbbwq7ulUEhMioI1cUSODBvTrw67b2WsUnTWzLdrJK7GEBW1L88ov6WgFPPYbrZVs6kjhMr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfXw2gFDg1wEPak
 mNIeppqQobbg2v8sFGIts5d/Ddhppfe0N4UF1wzcnHLJWecKaFRdxxID2SohioKDBvqhnFLegkE
 9FY1YM69ibUSIfZt1HkAgvJt5RsA0E9DTR0u3cwzjZQDWZTovkig2mODaqW415EIWGXXNT7tWBe
 fQ+4IwApFIr9EScAJ0JV4ysgm2Ssc/CiX9/y7IGtRCtFXHyNuH5+8HqYkqzeFFJjvSm6V/8lmGu
 JITl3gHr0C3gPgSYRX3dyyp/jXoh/eiFEwyALapZTSs5eH0YnDWeH8MxTmXMRW+/Fw+iTKXGVQe
 6K3YHWQmFskFlI0cuqGBYR0DmQvETn1U0nJIAWj3Uq4i+ECcP/YGhcZkpfAWA0JhQydv91eb2Mp
 s/me5DI6A1M3lqjilQxBfZSMKOQw6g==
X-Authority-Analysis: v=2.4 cv=cZffb3DM c=1 sm=1 tr=0 ts=691b45d1 cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=YItANLEf2SIYaAbUJgsA:9
X-Proofpoint-ORIG-GUID: rcoTYv_nZnlUIjxdF78OegZBjkPz1X_5
X-Proofpoint-GUID: rcoTYv_nZnlUIjxdF78OegZBjkPz1X_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Simplify vfio_user_recv_one() by moving the header handling out to a
helper function.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 82c76c6665..87e50501af 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
     return 1;
 }
 
+static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
+                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
+                              bool *isreply)
+{
+    struct iovec iov = {
+        .iov_base = hdr,
+        .iov_len = sizeof(*hdr),
+    };
+    int ret;
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
+                                 errp);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        error_setg(errp, "failed to read header");
+        return -1;
+    }
+
+    if (ret < sizeof(*hdr)) {
+        error_setg(errp, "short read of header");
+        return -1;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr->size < sizeof(*hdr)) {
+        error_setg(errp, "bad header size");
+        return -1;
+    }
+
+    switch (hdr->flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        *isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        *isreply = true;
+        break;
+    default:
+        error_setg(errp, "unknown message type");
+        return -1;
+    }
+
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
+                             hdr->flags);
+    return 0;
+}
+
 /*
  * Receive and process one incoming message.
  *
@@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     g_autofree int *fdp = NULL;
     VFIOUserFDs *reqfds;
     VFIOUserHdr hdr;
-    struct iovec iov = {
-        .iov_base = &hdr,
-        .iov_len = sizeof(hdr),
-    };
     bool isreply = false;
     int i, ret;
     size_t msgleft, numfds = 0;
@@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         /* else fall into reading another msg */
     }
 
-    /*
-     * Read header
-     */
-    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
-                                 errp);
-    if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        return ret;
-    }
-
-    /* read error or other side closed connection */
-    if (ret <= 0) {
-        goto fatal;
-    }
-
-    if (ret < sizeof(hdr)) {
-        error_setg(errp, "short read of header");
-        goto fatal;
-    }
-
-    /*
-     * Validate header
-     */
-    if (hdr.size < sizeof(VFIOUserHdr)) {
-        error_setg(errp, "bad header size");
-        goto fatal;
-    }
-    switch (hdr.flags & VFIO_USER_TYPE) {
-    case VFIO_USER_REQUEST:
-        isreply = false;
-        break;
-    case VFIO_USER_REPLY:
-        isreply = true;
-        break;
-    default:
-        error_setg(errp, "unknown message type");
+    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
+    if (ret < 0) {
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
         goto fatal;
     }
-    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
-                             hdr.flags);
 
     /*
      * For replies, find the matching pending request.
-- 
2.43.0


