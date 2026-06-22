Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70536CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclu-0004PO-CL; Mon, 22 Jun 2026 07:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclh-0004Ii-RC; Mon, 22 Jun 2026 07:24:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclO-0001R5-FT; Mon, 22 Jun 2026 07:24:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAoDqo810657; Mon, 22 Jun 2026 04:24:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uSQDPBrTTZj8Yb13NZCcgb0ZWJkLymTvIEAP5u/Wm
 bw=; b=0rx2wokBSE47YV4pCIjQORXSFfTMEjJ5p3F4SnltGa9uSORpGAnRabA4i
 pslE2tU+M5ZodkLi+H47HC6OBts2r4VdD3EfLUHMYNMkl1F4mnHjRWyWhSXpTqic
 FN3WeFrU+PFoPfWqJkRm9a3MR/BHl/AiiEOkgRElKeI9QH+umwdq7HPKhOupkBxE
 2l15haGQS6L69t2E1JWeh/DaFS6ZIACqiFHJKzE8cWjH0S/OugMQYZtxRF1+zoCI
 Q7e1BxgOKu6nuaAegmuVSCyOeZUqtNENlFRZFC4csbHAWi7JF9xoagsBoQ/zkWH3
 RNUykYamIlvwB5gt/YPyIPcKCkI0A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021106.outbound.protection.outlook.com [52.101.52.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewt6d3fhf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3FAVrCIiN2WRByJrw0s38GjmwhXnEDhUEZpsOu1xrwE31XNpxw0Up98ekiSMKp0H1g2l3bBsizcxLNTT9pwulQ1T4zk/+/WAr6jXs3mw8o10Bjw8/JdVvd/jYz4Zn1P2OT024ZHGyujrrgqv/uDoCv8lJFGft6DYGQnL1Mh3MNZjefOXArq1kGDcR2jViX24LSANYpqZFFpaMY2ImrmK7h7Ki2xsTJwFI2UnxTSQ00gfLQLgtUn5eqcNJLikOZyNIrZEkC07wmCRHxltWeVpCUGYpZ1goAynx1qnGRiBk/WIkNDCsGXgdHJ5oPC6PnbIQry+BHZNa2sprqzi/wIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSQDPBrTTZj8Yb13NZCcgb0ZWJkLymTvIEAP5u/Wmbw=;
 b=XhCU8uk2Fxm3N9W2WqecKjFo7TaNgzlQm1kahwzsH38tT9AtdZ8TqzOh/tWP2Zy67kBf+ydKhw8BpiSToplb4/JYjYJlYThALcmgisafkVmFOVhMYLNdUOfuC5WRidQTHrWN1/Vwsvy4YUyfw1nIKYVQR6EsC1ta9hvyjCe77IhEjxGRFQGuP5/ho7qnSiBmJKMo0SGR8zJD7d/3s/bmJ9JVWyrRzmIG/0AjpuvNOJNyyfmFa4xZn9ZFC2GwIF7eCAlfAH2PU/Lxlxe5/woMSEmoSEbWQpaHtsRR9468FLPKJU5XH/R1onCnmXReWytUPBqcs9amYkoWfVkrIR8HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSQDPBrTTZj8Yb13NZCcgb0ZWJkLymTvIEAP5u/Wmbw=;
 b=bBvwSn7eG1ldJK7SxlRdYg1aZl17Fu3/85d+/A1vaWaTVFKbHn68SwZMb8nGqMDi4esPeyAgc4qEQYRRX9VqEtnsnXhAeUpfch8GGYjan7G1KT5cYHhGOUT/c1tqVbGZSiQPATEvPgWysja+E819uNg8hvMBY3++VzHnDIVYvTNB/m16lqx5R2i08zYiDeE8YOPtKsnAh0xQV0vyFyURZni60VpSLxycwmykmyEu6FHx3KbDTZOvocno2ZtNoLWBI8KNcNn+np0x6P4xPmTG+zBZCZIwn7EAogB1mhOyq5+f9meHNboj7b4rxGboo6lUcKHw0Y3ijYRO5Qnh0XCMWA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 2/7] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props
 to class props
Date: Mon, 22 Jun 2026 12:22:34 +0100
Message-ID: <20260622112403.928954-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:930:8f::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 144c1b85-bb1c-4295-7893-08ded050ca1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: Q9SgPFP+xq1B2rNa+o80PYDrc87A+XEBx4tY5Eb1DivFqGjmcoA+WE1wFiLxpZrsadlgsUzfrelpXPpBEIzhIlT6rJMbpSM43IHX+4KWxH2SZEmBS6DIKRC17g2/yxlTwdD+U+AsN1VCsXOPklrEmn+KBxNwhtqW3Mp97wtyXbF0U2CeiJmJ1riOaKDS/xDr03FTyLu7K+W1MoGIbAt+3BcLaerlX0bQPqL5/r3MpV7isZtwgKZEDDawc8g8QNrXbElaaq5UzxCyHM2NFecCPA2u+DLRReXfK0X0K3DNRXBbRlko2OHgX3RROYQ9q/LsiCjN204sS+A9oLhPpAIZ4IQVm7B19rQ/xXI09KrW2WQBOm7NnXDrYh8KrM3uPKiJ1GRK+sMXnUt8nDyVjqW0Y7nNG3BzZnnc4GrIw6cP13De4xEK7I5VJy3pdSTEZF83xOGAqFT8DJxqOMjmKIduDMygkX7B9pm7h/e7gHK0OpqUbteuK2qUsi3F+U3Cf6vo0hWEjzYXNicWbvv+Ifo9FYvjTsYULB7I63xWoDYNRXYM7JaOGRkvRrY7rdKy53QV5jARRUgv2JXk9+kSgbLB2tYbzhf7H4HYJ+I8FeBafco7t3pi2LnQUz/vOBPbtxj50iq/jxzlFgGK8tmbbNlAEyTx/MaoZh1dY8jYA7MUrdp0JcV72gZYPBRqgJu71F1bPC2mDrFPaQX9fS0SAVXQJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9i9phkaNKJXstDGcqxlNoLdmkw6UxiMuIlUuj0FjmgLDJ+Gy01aWJTHAQf3O?=
 =?us-ascii?Q?KDy49GtXhgkGLddT/4qJPr4mEWH7IYY6sjkISWaST5R3X4giqtnQIHNYlpQt?=
 =?us-ascii?Q?9/+cemLu3jkVFGzw7vieiEa/Be5yI4X5FDGhz3ViPREfaT06jX+8tWkmX7ky?=
 =?us-ascii?Q?5jEp1iYoStMDKPR1lNFIEWCgxhASG+bITGyGfJY4tnM2sY10iSv9JrvxaSzB?=
 =?us-ascii?Q?PkmaP7yBYdstqTEG63I5Pmk5Q1Cdr5tiv3bxOHWBb2mmDwhF0XNNATTcWRbB?=
 =?us-ascii?Q?XvCCwLww033j5eGM+0I5kquswsrTVOMokOAqG2GEcsFDtfP2Y8Yknn4zIMfz?=
 =?us-ascii?Q?8U1TCoIXf4dOj/hZRn4dIp8Q0JZ6NPiG9hf0s5DwgjLQIQ7G25nlaqxP0qwb?=
 =?us-ascii?Q?BV4hhotpZJ4QLUEtah60/p7HlCdIDsM1JtXsajlZ7SUjILW8SwhNxmE7YtdN?=
 =?us-ascii?Q?M/rvu4YSZ/7rtAGu8BVanaADVE5omVrXkvMm+WhmbqX4Ek7mz5s1xSJksY5b?=
 =?us-ascii?Q?xhFH3xGnK1+2Fpiiy1AwU5CEb2xgpECge1VXR+4Odk9LqAXF6JQK5MMX+7mL?=
 =?us-ascii?Q?VPhXzv9pgTTHChY4c7gEroLK8e/AJ/3/8flHgXiCSon6bS2QEONDTd7STlte?=
 =?us-ascii?Q?OtevPJKNdP5QvLz9XfxRnrQhyPscSFdLEEUzT6+C3PCJk69XK5G0rkmcAuN9?=
 =?us-ascii?Q?IsGRpDKIp8m7PfKgwKWtJ1JY+340iX9T17OhXT1L1EoDqVECxAgKVq5p3FA0?=
 =?us-ascii?Q?kGrfkAFaE5IWrkO+yAptoT2e4ICCvEmbHAuMdUClS9y5KHblcHcEmKdKxnqU?=
 =?us-ascii?Q?JBZLrcQ+3zWo4de5O9IHUgASIWiz/hdhs9ys2gSWwNR1g6s05DdspnfFr9oj?=
 =?us-ascii?Q?2kdVAmpY+q+HfiTaOMjeNiU14sY1BiPqLQ0wEhDb7ZoErpEZaI89vwZTmD5W?=
 =?us-ascii?Q?ZMtKYNxRM94wJHXluq3C9ZO9Ah3+wSdH5RJSfC8l/whwqqbnLUDtZeOAHJOc?=
 =?us-ascii?Q?nL6N6Rf+WzwWdC9xwl4T++1fkL+B3qgYcJohZK/zuL0DkbWc0xt0WOprd6JD?=
 =?us-ascii?Q?2+9OV0sI4Kkwc9MKxoWnq2GuhZwKspjW9Rp2fqZvin+yyl194UZWFIV7oN4R?=
 =?us-ascii?Q?gmkp/qsRcBILnw5AvbqxxVS4w3yqseRly6omrrEoaptA/W9IT/UuhXtndmhM?=
 =?us-ascii?Q?1WxfpJ36S77gtPib0150E/ONr8QA54UkHAs3agfpJ+Gp1AD5+Fxx11p8qVSx?=
 =?us-ascii?Q?v9P/zaGOGzrWMxIyG4jdp4yT5hqcu7wH55ZE5/PXAevR9/9El8meQp+TZUgb?=
 =?us-ascii?Q?YsnQd7zwimGgq4WmPi7+KjiBq9wT57mWJGUYddoGhThmvwrXMW4e3tFC6Dzc?=
 =?us-ascii?Q?QMBQhWSR746yujC+19X0leSwoKfew7cteeuorVDrAXoRIKuXWqoAdzofAfko?=
 =?us-ascii?Q?18Rbogli7Ljj2WgIwv66arFymluEEBlxS8WkBvmJ2ko9dFpYxtrpwczSj1bO?=
 =?us-ascii?Q?QbBgV+xj6sdTHg1yTUXApQUES0L4CG9Q2gyCFeVNhppctm8ffKDaobL80PoU?=
 =?us-ascii?Q?JwmOLlO2za5V7MTQ/42bFD02vOy7mdYQLssEY73/J3iAj3kgcKkRwnHCIxPW?=
 =?us-ascii?Q?eLKS9tCnvymd/4snqx51KBqS9DPFUbhUINbNcyvLmMQiTH/g4QVwuzthOm4c?=
 =?us-ascii?Q?+fYJCd7RPY/pehXB+wRBzpn/gRz+me2LRVL2/AjJRelewrmy3gy6wpeyTBEp?=
 =?us-ascii?Q?/uibgM0D0CVHggcPuIZalFX+F8CFvxU=3D?=
X-Exchange-RoutingPolicyChecked: OLXL7TAxhy+orXHoKGe6VnflJKjIzxUbWvghiTwZMnxjakRC+8n52kr6rZ2tX1NVLt8rilywXSNBMUVYdwz7fix33Jbo4BB1npANeEOP9RjAGkmDDvBMd/Mbsh8h94Yxnf+HFpQoMrdZ1FSZNzdEu2mkKMf1OC4ceTWJl/D60zpknQT6YB/yO0BuvNueoG22B1gzTnkrQdwWNQ7tKw7aMJqjCN7iXWOJtotgNhkauuhyMKbuvUHxrc6LtGReAqLqDqXBRqarqjuAmUVXJ4OjXxXNsr+7EsULybK2CKfUOFBlrFDs2gG9Fl70izOJDQWM4LcKVgbg/x3ygRvMnpdOtQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c1b85-bb1c-4295-7893-08ded050ca1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:14.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0uV1lavPHXcOmHsq7A0HzIaL8D3psAi5DzfKaTX4BI+yFeRv5yZ7Y67DIZQp1HUd5IrUd+FpHvHDANOfQYqPuFaOd6VXx9n4DlqlQr6WRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a391b5f cx=c_pps
 a=8AR2Or5FcovIRbB7TUUKGA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=1677IaiEuyO47b-9faYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX876b1rceoc0l
 qdPAuIClA9U7wMRjHV/4nyn13X4wqoIxgd7NUnfH0EQ1UafG53lRfPisbopPeXCibLtNKY6VgdP
 8dYVNk6L14MgqB8TGXEBGEe9GfcA7yR4GR8gwyTpVCuhTeXNwgbwH+rdm7my/pxanqsxbXpwFLq
 gi5p1N60AMsfOmNrevFmy6Jdins/XJi2ycYMP/S/gJPTi2ikNJnHQRq+Mmazs5GbnSqFDgPbDyl
 33d3QvHTtxwtw1svKc1vlH6t+bjUD9dwsPbkhy9mYZLFk9L7unzdpaXs5aS2gPtQcvoEciJ58TZ
 FHerL1F9bSAk50tLgQG5nFhx9jeZxuh3DJFx+2cV4iXbT1lU9ODrpb0RyljvajK8dIq+4rJ1BQn
 nFy2PCdwLP2SU0Icul4K//96Mt4TuNWbmkyqHc1pFFx5Y4EVx0wvqvd+tLMurYeDcICO0cNsosY
 2AAzya1QX2T3oshvr7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX6vySq6SMwtXv
 Iy5EApp5ufIcnoxULWLLNT2VI+oTuML2OowjYbYNEP/Y6T001nKPrvKiilwT91SV2IPL5Cv1A9T
 p1dnw8sSOJhoZb9Qm475euKxQbpMKqk=
X-Proofpoint-ORIG-GUID: 6_xKJarlTzRfRL5cuLeIOBUeaKb60QES
X-Proofpoint-GUID: 6_xKJarlTzRfRL5cuLeIOBUeaKb60QES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
 hw/isa/lpc_ich9.c | 64 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..c6d31a3957 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -880,6 +867,40 @@ static void build_ich9_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
+static void ich9_lpc_get_sci_int(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint8_t sci_gsi = lpc->sci_gsi;
+
+    visit_type_uint8(v, name, &sci_gsi, errp);
+}
+
+static void ich9_lpc_get_smi_negotiated_feat(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint64_t smi_negotiated_features = lpc->smi_negotiated_features;
+
+    visit_type_uint64(v, name, &smi_negotiated_features, errp);
+}
+
+static void ich9_lpc_set_smi_negotiated_feat(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
+    uint64_t smi_negotiated_features = lpc->smi_negotiated_features;
+
+    if (!visit_type_uint64(v, name,  &smi_negotiated_features, errp)) {
+        return;
+    }
+
+    lpc->smi_negotiated_features = smi_negotiated_features;
+}
+
 static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -888,6 +909,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +936,20 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add(klass, ACPI_PM_PROP_SCI_INT, "uint8",
+                              ich9_lpc_get_sci_int,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                        &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                        &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
+    object_class_property_add(klass, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                              "uint64",
+                              ich9_lpc_get_smi_negotiated_feat,
+                              ich9_lpc_set_smi_negotiated_feat,
+                              NULL, NULL);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


