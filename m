Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566A8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNQ-0002dW-BQ; Fri, 03 Jul 2026 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNF-0002ZS-Ir; Fri, 03 Jul 2026 09:56:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeND-0006dv-QP; Fri, 03 Jul 2026 09:56:09 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635qxWE1963617; Fri, 3 Jul 2026 06:55:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZiEmCU+G4TIFSJ0SzGFQKGm2il0g4Q0aopY5dbIKi
 nE=; b=YDWjyI4EYkfqr3HYWl0O5O86pHAmJXtw6JfXqYf0R0CEDXvBfVLxh5LaK
 1SPyx5R87uuvKE8ZkKNcf6KALAW1w3AfULD/KlM8O4i/yjY07neIEHkTfENQO4rr
 7Yni8ORXeuL6NENS7VJ2fpbo313WKQyBv8GkP769QduTesoPSfTrT55l1OEU8RFh
 YVxBE80A70blloZM0r+h7q6XDnDIQbU+iG0/VuUE4PkbbhJbXXnFhpRNc3FiQqQj
 yx3+kzB3dpHG4u2SiPukkinx+k9t4IsMweACqWpD9ahf5yne8IyT27qEgAIuFIAV
 9nBwTp4rmqle6yY8AE28KFkE/jjWA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020087.outbound.protection.outlook.com [52.101.61.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6080spxq-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emhq6po+SHpb97BNKvKdTQwwtzWn/eNpClB7NCixstSI1O0WHYm+J1+qQlyO527lr+EUF9KVhRFqpD2SK8n2kBRFD4r+ukkWJgfL9scjatip200o1zcBv/4HVnEuDwR7VxYtFseLgkgUIJXmj/0OqlqfPpSPqZoY5oMqp0oGB/9vsI1kM6TdKfF8vziPwosmoB0Px0vya/otpzq8SwZbc6BLdLAV0j1hw0Cmje0fLF/vv13k3G2xtjKLpo8GhFWAxxR4XzJ8BVjMFTTmAP9omCcSG7+thZ9K8EIhpxsy5zRi0aZHGMIHVH1FzcoFOwUbKhYKkSuyvZObT2Q4DjdniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiEmCU+G4TIFSJ0SzGFQKGm2il0g4Q0aopY5dbIKinE=;
 b=IhyrCAJ5ulQxDkWxLXQotf5rD8BToeF0vAzKorzaLsSH5lIboFpwEwHjnf6CycDSdQ8qzqkuGmE/7x2+6HIAtW2fejCvyczmQS1pXdLPGHtEIJr7qMJoJ0rPxWZ87KB3RP7yztSxVzcLgTa5kg/hGWui0RXcEgh5spWHU4S2v22DgwDKhT1GH56gWM+EqJcB6K9MbD4FCkvl1H0bkqi1lKtR4cwjKw8aNBNPfn/ZTb7fspAGoMr9RWncS5bdPs3roVWB3pf5Xed+gdNZ5fl4Vge9fk+GR+htT5KfBeEmwvxYh9NdtHuyOCl3uYbjs6lnBjSoq1omCkg7N5tHWEOcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiEmCU+G4TIFSJ0SzGFQKGm2il0g4Q0aopY5dbIKinE=;
 b=UDjF5XaIlwI/D03qpTJS5WoUvETWIkiZmWl/+N0zxH4FXxMcHBEjlsjVDTzsiNth1MFZ9g5wIrb9yZSpYFjwEH0TUAsgfPdzv0BQFIcBrFuGPaRPjpcChvaf+CRfUPeW+ddIF2nWo6HKF2D4RxT5ZJFW4WrFX2ormyUIQW7jeK+wkZzfvPdFgcyhQzDnafBCdQJ9NqMRLUTNQKtYJqEcKCXVuN9rqsZIXEOGrVJcJGLY3cgyuWoxebg7ODzarHncczHflHpz1u2rqsfFRrFFAqlVpt3Br1lBpM0/H84GzvEp0T3TsV+SgQQ0hxDY5S/YK0arRry+7cti1j3FndG7vA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 10/12] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Fri,  3 Jul 2026 14:53:12 +0100
Message-ID: <20260703135512.3213964-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:52c::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4edb27d3-ea7c-4643-172c-08ded90ac9d4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: XcofWL9hLEQI7wJf74H7aor+n7xrQ0R89elV1JvH0bBupiKuO1i3gV2GoMrie/Ng9k0XrPmhq/gABDBCJt5vjcKj/3Tkp0PT5S3KyE7AD/fg0DiBmFP9o4srC9VmMUBhsXDUcnxbKYCMNbSFrOI5M1Tm4z9MsLO0lC2OR/2LvMhaI72ku4tUd/m4f+kRZCR6eygRBz0Bq+VeWVlMngrVUNj9KEn+ZG0NKwlQla/PhMlbwR4lojnjJUr5EAM1ADD3ki0VrbOtHJRRQOLadVR9cvpAjJcz9oyy7ttV+xc66m3Q7PPeWv/9pMi5hr1bhWylOpBKtwCQXzVfNB4/XPeJbHE7A0As8KUVFJ2qEi8uWNj4dy3VYyioNuwblXNDVDjVEaBZY/rCWd2rARDvKeS4LES9WCY8IFujiryZk3S08sxcpVf11JR57tBezlSU4POg6Y6WQ5fVYDO3iIXgIBs+i+fUmz1BUFZXs0mNReKZfqTIRah3NfR9rOvKaqdx4jBn9hSOpU3A0hC3x+1Ny0RK+zG8zcMGzap2JeREilhkwu/jXLVrmytjuWIkBPNSQIRPZ1r7gTuCLI+zTU9+49gF5lHY/eBwfuiW1l5JnJw3JNA9borx+Hbt3skm/0FUYabTn7fjUvsytBK1fLSwpcBxcb4L7MiNkfe2q8N6X10A/lSPTn7DVHWEiLd0BIFJa3RQF/SBOEFuN8VD9hPHDbs28Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlMtSK/l3gZmrYo6DKvT4jc3uZnhsRjviz3BdNOrLn7o9FJxxa54PwzV2WXM?=
 =?us-ascii?Q?zirhrp3PYHxLnkJXQWJ456ICc3Dc0c0Ct46VeEcD28k+0d2sD/JtLpLJQomK?=
 =?us-ascii?Q?7UF+AoK2KG4uIdrh/UZDJvvcOuOouWvmOuELMQb1sezM1GWAz2syxkdSAJCP?=
 =?us-ascii?Q?+Ndjm8vA7OvQ9OMDKryMSlmnBjc0GXarA+YlkT3tzP3BCCX//6a4sn5jz683?=
 =?us-ascii?Q?pEdQuSRnlbyxskO80VhLrgjzsstPm9FGd++aUjQceWsEMN4GEO0J1D2w6gFX?=
 =?us-ascii?Q?7yiuu2jgQcYPO10fJxf1PXeGer+ZvsLYHWSuZgvBqsy4bT7b1c6KVcjvfAyL?=
 =?us-ascii?Q?3zW+T8Wn3a4XGzvh5e37NyupY7z6/8nyPo7Y/btChzOKXdXYzgGS89rYRow2?=
 =?us-ascii?Q?RLBv7LurMqlohjnYXTxwAP+4WLryMzMcnuZI585uKpZbY6F9ODyrRX9PoFMA?=
 =?us-ascii?Q?7LPjUERlOwdLc33TpnByc+cJHkZrzutgWZ/2EvQHMBOAZJvVKR1szx6pY43e?=
 =?us-ascii?Q?bfyFNreKqAIP64d3o7ZLTe066cfoheFAUcJfQ0y/k++yQnAwj7wtRCtwiyf5?=
 =?us-ascii?Q?GbbiIBpQxtvLpGbZh4YtiiYuotZCGGDtOMg2X7QdoUbpZvF/nO2LPTAu08Sn?=
 =?us-ascii?Q?I+DvNIXOnVimHiwGkqgyHMgSf9cDjHozUN5nrFULGE16rwCNciwob12vx11I?=
 =?us-ascii?Q?YA6hFYNH6UezNgVTKxCqSjpDA1nqJOGGA0S1oCp3/kO8Hfsc8EFgaBIZcny5?=
 =?us-ascii?Q?0n2RG47I06dNbeB86XMzZSFBzweqDZ4TASLUEqoxE9vP2zsM82falVPi+UpW?=
 =?us-ascii?Q?hV0gX46Zy/5dV9GYpFQwSxrRkkZDO0ytKoQasPXflYPrvJeuPqTcdulrTDRK?=
 =?us-ascii?Q?yiio1Hqtjzns2ENGHwkU+pOB+VXmVtMRUPV6Onps7iiN+saIN2fIa2D9DLy7?=
 =?us-ascii?Q?z4ujXMY+0MQLa26AuthrFlmQd3fHS1NlEJxOgryy4H1To3pTjjPgGAAdw17B?=
 =?us-ascii?Q?t+ZINGMkorkF0J9v3dLyO7YKIE3rkMO07MNcNJnBba6956m0PMEmzcjv7Tgv?=
 =?us-ascii?Q?B5SanzR39zO/sOE7Gwtqy7rJQklk7eaoTVzLbLCd2A4kL/yTVnDaxBykbc0G?=
 =?us-ascii?Q?K7NLgyJp6HmWjwlX0wZ9WtwgN7bWuC/n9km9doFqB8kXvNXpxlknpkqip2aZ?=
 =?us-ascii?Q?+DRUzSZB+EoqB2U4wlJGO+ILPqALyiTJjnTqmL3y7quLn2Xyy/v6dTRZQIl5?=
 =?us-ascii?Q?WMnXKFouBQSl9NmfM9p1+xKbATDzFflQ1Csnqw73BGj+Z9fBOfKPnA/wwzaD?=
 =?us-ascii?Q?62C7J9XU2MD20/qP+muU19HJktgl1dcT1oq3ZJPJPtjEmy7CJNvagnKXUDUx?=
 =?us-ascii?Q?A5cWs+D4T81XV/6hmvzA6C4TvhJFvf2QDPVjFsmCjGojqg35EqbjLVjrj63B?=
 =?us-ascii?Q?eRP8rJIvrKDyqZLiCtcpHsevjjbYbl99ME7PuQJ9Kdrb87mYTwlexq+IDTyw?=
 =?us-ascii?Q?5xFg+If2Kk0mERrpLsLuwT23iLYI0dSbQYTJ9o3SdIihjbMr6dDkACMSzlhF?=
 =?us-ascii?Q?LuAIBEx+xbysg1HeMy34xey9KB/8F++1D2nqKy7ilp9mDZ4tW4IVyhsXmlMk?=
 =?us-ascii?Q?fDkf6G68pO2KVS+zGIOxIvwkhLvOsamx/aIN2TXJLXwsIowDENKRlqEVJwSE?=
 =?us-ascii?Q?w11CLWfP3e0IXkNjoTmbxprSfAwlhUsL+mS7+eA9a5MLZK5Gcsv6AjKfh/s5?=
 =?us-ascii?Q?0EHIYiXfuFWGaGu83yyID2EcTTgZErA=3D?=
X-Exchange-RoutingPolicyChecked: r5g/OTm1ZWcGizyxPxgyqCP+UJRAGTmtvLmjglS9Xh7itGGOVCdacL1roJoFdnX1kRWkzItUKYj+NnlbAkdIzYJbzr9E8mbbdETLeXwmF6sbkxz+gufwFeFmcX1ctzZITXXRqIqIXH+Hv9AjHJ2CExjVANuhJxszPLeWJyBAzP9FH22kkMQXBngtTWKB0Iwypi+WahOOX0ygeXrzLi6EVSPQZ7SZPO8fNFvXuKXva0m4OV9sLX/VsFW6NOvgz14hNIJPiwXEzccsAm/SR72a+myQ47M0b5Z97s+fMtrnoeoWoyU/z+Mv5UHIWjqqKaW+cEdnjvVWeT8VjkBDU9rxaQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edb27d3-ea7c-4643-172c-08ded90ac9d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:49.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epC/Z3RtE9QCzuYl3IaP9ZIclbFcV3r/ZI98GLPpzWBMqMB2+zHVhoW824ZXdGMRoFzEYGKkaEJp86T0+w/XbDKPOJnpJAdAwf5ax1BfXFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX5MaaKsxfZccP
 A9zc1WmseFdckz48ctM1cdelHqxBy/xI+vYq+Px4aLbrw4L1v5VqbwGBAh5pi8XDB+ygCc1DMRL
 3yKFMadcglqKguX9EiVoKlcheb54YiA=
X-Proofpoint-ORIG-GUID: Sh-5dKjRSKeoHUvds5YFcCEfXxcicehM
X-Proofpoint-GUID: Sh-5dKjRSKeoHUvds5YFcCEfXxcicehM
X-Authority-Analysis: v=2.4 cv=ftLsol4f c=1 sm=1 tr=0 ts=6a47bf6b cx=c_pps
 a=uUOONCeAppmmVOxUvBiRog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=pnBmNuUOYQARQnUSyu0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX+RL/5QBBCNuu
 0RqxF/zJeWPetoIMDrkH53eCw4iki+45YFxrJim6HpwN0rpf3mRBS3TYCBJMLDXjVo0IsMNAeOp
 JpqBuZDO5k9Z0RPEZ4iP8ntmnfAl6fJjckJfGBrTuQTpYfM39yHeuV/yIkAoR9w+iRnmQ8vRtZT
 TwpZjHAfhfAStwJbDDfDsCTLPWSdaZtwiXfYSOXNNWdEScTXolMtjCIIs8W6RJ0Cjsfdsgknh4Z
 +l9qidBJKLQZC2A+dLLKqGCQAYwzN6y7fwOiXsl0Kj2RBRWnDk3Ueegf1W/V3B8iKuwp37eCZmx
 StDJXpAStmEkPaAxNtmub//vvXWP3GZIeJPgf//fS053uWKK7kHGM9quM21l+06oLGYGReHF6vZ
 rJP9/Za38b+Uc1O2nnH/+SvtPBn2AqByMhhdAv4DMqgNEroTWhocj7bnbL2Eo5pJNidbPl12Sqf
 57S52U6E7YZMT32UQfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/generic_event_device.c | 10 ++++++++++
 hw/acpi/ich9.c                 |  8 ++++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                |  9 +++++++++
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..67c9e9b3e8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -608,6 +609,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index cf36dfc3d8..0b295cbe5b 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -438,6 +438,14 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
     object_class_property_add_bool(oc, "x-keep-pci-slot-hpc",
                                    ich9_pm_get_keep_pci_slot_hpc,
                                    ich9_pm_set_keep_pci_slot_hpc);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(ICH9LPCState,
+                                                  pm.acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(ICH9LPCState,
+                                                  pm.acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..1d209ac96d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -607,6 +607,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


