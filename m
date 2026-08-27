Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3212C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbCA-0000is-23; Thu, 27 Aug 2026 10:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbC7-0000ZK-6t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbC4-00025Z-AG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:06 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8PKf4182820
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=b63oNvcf78lN8KfUwZxrVelN/6h72euIx1gS+AhYc
 mw=; b=RdKTA4e5E0o5uAAmGYByMrtj3vCIiAEolYs3CUkItx0rIiyvxTnMJ/eGK
 2bMn4XxDbOsB7+/Po+NbBKzMvZn8SeYCDovLDiGRk14KSFxfI+ffYcQxopKURxNg
 bT7KVUuZ+k62Mk+SBmoEoOGa6A1U+hxhBRehU8VT5ouCc1JMFqdg2Zz6fVjM2OoA
 rpbm2Ppme5atZpUesIis8fAvmf4n9hMP/DT6Lx1gxyuc6cR4gskSUSR0ikunuJ8i
 MBxpJCIVm+abd8GSThhaAQ/I8LZBEjAHF0pfoRmOpcA3ZfdfcNEjHHo6GosExmm5
 q3XsLzjAvMaGLeHxRTnrGQ24ZPhBQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023077.outbound.protection.outlook.com
 [40.93.196.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gafss12as-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6HmjoxFe2nbVAdgnmIONSlON1C71xzYOM83jPGsK/EORItrUJoaOqRB5DmvqMN63QWo9HRIXtDp06kgkvTwE3GtWCbl9u2vBeNP8VQhybEbHTc/u9o1ayU27Yq+pslXwZg2ZMxkJX5x5KoT4++WWOGmTaCdKFiGZuUmEQZbWi5gvT5qSnCSaB4DiAs0kEmAXS53p31xNg/vdgM/3kKlNolJaWS4wBHHj+kbiUNVHlZGvNDNbjxpoVtgSlyLueasqunQBXLJ+nq5O/DIpdlBYcaqwUM3ycFJpRBQZm3sF0tbn90KdDlxWOKkVqkfnGxVFKp3hOG8ELC4rYauMJo5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b63oNvcf78lN8KfUwZxrVelN/6h72euIx1gS+AhYcmw=;
 b=fDRLsXairk9tI/jDCQO1q/CyGr9HHc5H6DARRJXz4ZhU1M8czqnLWz9W3rjPoEY4DjVUWzjYZg3/+VcSTaDUWJAjNyhvBNe+vlEpZNPLHnffvGXowBShUs0eLMd8nEDpv/mOMp0wMrjd89czuoErWYCCu+BSxfJx+lkrg+MIFAaCJq9P+4vYqnB6mCL00LY9o5Y7L9m7b6AH95Y77izOOsGQP20sEJZdjacvDhsPXvmwSr8FscvQPdPS2if2Z7eIrrj27bYoe07dclyd1hbmamjMeUS6n6fEjJSOwRGjkZDQpXO8OaG99Zw/RvE3KQVyHYqDtuJ3StVLmXUy8OJ5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b63oNvcf78lN8KfUwZxrVelN/6h72euIx1gS+AhYcmw=;
 b=pxIl7lAeEAPpbNBB4Ijn27m9CW2o5ZwHcD9v835Wp3DprpOixG2t7AeVJrlf/eV7axVwB8+UC3UAvjvGr1jEQ7HcCz67YjxOFJ7TRppTnV9lWEhLQtH65sTbwG+wbYLno1rA1fPkepdWI+lFa6z8oqM3o1OTMjspw9RKtW2xuth8EjDpDY6syRhp1gAOqnh3lUUfp8uWZ18monX1mWfoY15aUomDUCchwgr6rBBhuFATlmuMW5TKQQ5lKeCgOHa7K4IahljlvdpZdEBjFPXg6/zTeWYMXI0DpcCYPp4ohrm24opiUqSlrQDSAREvDKE1UxhD8hOFdg4MAwJHZeLqug==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:35:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:35:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] hw/acpi/piix4.c: convert static variables to static
 class properties
Date: Thu, 27 Aug 2026 15:33:36 +0100
Message-ID: <20260827143404.1393166-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0197.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a98b7d-9f66-476a-056c-08df04485fa9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w8LxYI9mA46eziPIxo0mXiXpUQi9yHojqTfn8cRSiOgGMCP8OC4E2mjca8VA8/iPPkUSQ26n2ui0O0ImBTo+I6BN3jVGTvPzgeOid7EtPVD4jywWQHDErbvoZIXo8hn6DMqTaqgoKzZp4kj/IhEx5H/AVzbnGyfkTln7QXkrOSvAmxqAr1ChQja/1xyInLkzBP9U4aSqbXRjaMkf9I95dvG7DKqfyLWoDZNsGFiZXJIOjYzMMJ7Fb5EamlXfisRA24+Vd7pOtnRqCnLE82XJFrHoUzoRBPk8BhS0qPpYPHLKhkdhETttMu0IlR7EBrqLh6Uor2sN+lqsh2mV/EeZO1KJxj9zJrAxfuAjNVGj0SZxix8mcTGaOPhoxyxc41xiki+P0OPihCVDMsy/dZM5fqVBx8+aDR1kGLcqGPv7kVRq0815v2GrGVSZ53WKd2vRQFD63BzYptF6K1Yjzmb9DivvHi571SR8jN09SKfKFs4yFtmuT+5cZh+Q5jXos2zpse/Qbi8tU6CUlpdrw2+RKkSa9RMIkVyFF1vzSUPd1OInN6W5Nn5TpVu/rbeaXnDZQgVMQ7bCEPyyYDeHWM/YHL+ItAc9fq7yrx0MEGeeY2VDcvSH0Wx4NPrqOsHZ9QHaThPH5SQnIUVsFcQBdDR5j+autDKwm8RB3Nr/Ju89CDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2hOckMyaFlyMGt4RXhNQVZYNUhVVy9oRXlmMThaNURIRUVYanFGcUR2NG53?=
 =?utf-8?B?Mi9RQVpDbVcvMjdWdVVtYzZmSldlTDFubnhRZ2NvV1VualRvRmY1Q3gxcWlL?=
 =?utf-8?B?TWt4d0d6bC9jZTNaQ1hITnJjM3Y2ODhVT3JUQUNYak9ubDFOdlJLSFh4Umdi?=
 =?utf-8?B?TmhwallYMUhodFJLckNIaVZTWXpnS2JMMFQ4enVCajZKNU5HQVVIcjFiN1V6?=
 =?utf-8?B?YmhsTkFSMnloN2tDem9EWHNuTHc3NDh4aWZ1dGJJN25lVU5FOHBNSFh2RzRv?=
 =?utf-8?B?MzJQbEFjaXZPWDBwUGdGL0VLM1RmVHNLSGdsL1IzVERTVXhsWHdEL1ZTMVVx?=
 =?utf-8?B?ajZlZlJldDVzdmUvSE16YVBXM0pMUUFJbUUwWm9IVXRCMEdWRlJMNzNYc2xl?=
 =?utf-8?B?VjJ2aUUzcmFMUGpMdldwY0k3NjJRcGI4SDc2bzNNcW5GSDJJMm10VlNtc3Yz?=
 =?utf-8?B?L2tIaVFyNTMxMVNlbWxMcExXWWpvQUhoM2NTQTJsY0ViRUFobXNyT005ZjJH?=
 =?utf-8?B?ckFJQ0JwZ1pBQW1NY3V6ZTcxa1NySnZjNXVFMTZWOFQ1MW1YWEhKWE1DZjU5?=
 =?utf-8?B?TlowYlBBOElLZmRJR0tkb1hmSEtVYytpNHFtMWpXQzBNZTJVYUNBeXBDZFAr?=
 =?utf-8?B?U20zaXM3UVZBanBwMGs4dFBCTjh6ODNINlZrZEVTM3dXLzQvR3BWeDJhQWtv?=
 =?utf-8?B?ei9XZnBjUlFtTnNEdkJaa1ovcjdCSFk2WkRQcUlQNjRlSEtsSktiWFRQYWF0?=
 =?utf-8?B?K3JGVmVmVFgwMS9uc09mYlZvSWRKMmtTTzRRQVlGb2Y1ZGNMV3pUNkQ5SmJX?=
 =?utf-8?B?SWxtTVEvUFF3TnBDYmFNMlRvLzNBNm5lYVdMZlRMKzJUcXAyVW42aEtpOHR0?=
 =?utf-8?B?SzE5T1k1WnJENk90SDA0N3RLa0ZUbWFCN3ErMklodEgzNHk2SUFvLzV6SzVT?=
 =?utf-8?B?VEozcDdEN3RFNjRDRHJralJEZmtmQWo5a3pCWHNWZWR2N1pqMTVTb01vWG4r?=
 =?utf-8?B?MmVGN2QwMGlUaXlPckt4OHpEN2VEZTdBQzUrL2lBUzVYMXl2OGlGU2xyMmI5?=
 =?utf-8?B?M2tEQ1UvVWdkOXFjRWhIcVJiWFRFcDNxOGozWmVubE5vcTFuZ0U3d0xZZS92?=
 =?utf-8?B?aE16enAwSE94bG13WFU5b0ZMOVdiZUVpMnVtY0MxOElWWk9hQnVRSnVFbkFJ?=
 =?utf-8?B?QkZFMXdqQUxhbndmMkxlaEd2K2dHOTlOYk5jVDkxeHB2T0RscFdtVTl0WUl4?=
 =?utf-8?B?MnY5SHQzNmhQZ1ZidHZSelFVaHFadlZZZWlYUWJjMGF3M0ZrTFkwY1luNGw3?=
 =?utf-8?B?T0ZoNExoV2lHd2YrMm1QMnk2d1FVR3ZSdXlodGNXd3VDdzFxemZyYlBIMjNC?=
 =?utf-8?B?YmZGRy9nMlFXSEFUY1pKSldoWTJpa3BUMytKczVyelF3czNDaVFHSzZ4T2R4?=
 =?utf-8?B?UXRYRXNGcE43U25RU2wwNXEyWGc2QVhCUUlRUzBxUThpRUpFODZOdW5wY0Q2?=
 =?utf-8?B?US9tb3dpRnF2NFAxYnl4S0RZRFdLZHN6NkhsaXZXNVd5TnlISS9JcEtGeHg0?=
 =?utf-8?B?MVgzeW1zYktFcGdYT3p5U24yWXU2cUdtWWUyVUliaDMxb2RZMlJ4ZUpSWWdI?=
 =?utf-8?B?ODE2Y3NOWUlsL1RpZ1R3REY5MzNSOUpYSEVWRXBWd1ZNVy91RThadUdsa0Jo?=
 =?utf-8?B?VTg3bXRxQXQxSXdQNWplWTJmWm83d09YY3hVdlF0MXZPMkV2MXp1STFhZVpq?=
 =?utf-8?B?WTduUmF5UDhoVlh0ditXY2tMRytKM1lZWFFCN2IrNnUzaDRJT3NjZHdkcGYz?=
 =?utf-8?B?RnM3dW5PdU9pRDhXaWhOUlkvalNvQ0xOMEZBci9menBSU2M3ODJVRm00bXZi?=
 =?utf-8?B?QitTRnlZdjN2a2ttNFI1eEw3Rm91eXhUNloyZFQyTWQwTFZlRGFiVm9OQmVj?=
 =?utf-8?B?bm83bnk2ZnNQb1VSV3dTRC9neVA2R1dGVUxzWC9ORmNMd2lHQTZHQjhuclQz?=
 =?utf-8?B?cS9LVm9IQlFWYUI1dm0wMHNpT2tudTVXR0YxQWhqeW5qcnRON3ZWSkljYWNn?=
 =?utf-8?B?cGlSWkNpdHZqZjd2bVhUd3VUSjE1VTFTRTZnazlqOTZVZTluL21nOGlHMm9G?=
 =?utf-8?B?T1NQRTRzTnNYMTdETkd4c211TEo0VW1JQWkrQytHRkh6czlCdUZUSGRVd1RX?=
 =?utf-8?B?bHF2TytRYlNDM0ZiekdPb3ZDa3luWmtHZGh6VmlIVDF3MURzZk1lREQ4MlQx?=
 =?utf-8?B?VEllRFJ2b3pQMFFiZWJNUEhyNGJ6THkwSlNUdVBLVHVCUFBweHdKZjh4blpV?=
 =?utf-8?B?L29rU05MV01XcFAwcUlCZ0FsaC9aN1B3eVlodjBVVXdSbkdZdExjTmhQWUdo?=
 =?utf-8?Q?YnKkKwmkT+Gn1sJI=3D?=
X-Exchange-RoutingPolicyChecked: FW7hUXBl5fdYrV9wm0+/3a7BLfxgkO+pB6kTB7pBPk+dMj8pRJhMFRwlu4TAHWOUMJlWhoHhXJpDPFpBUVZ2zd35RzwGlrFFeH+a8bDrEtMbonUFOGOC7jpQAbVJa8DuYLlMrR0zGe/3hH/kMNfhAW5mRoJ1JDuI93N/Q3381a1GVAdpd9cjC1PFl41LHLXmnc7bCoF2kxX+EFQKgocXEYDaZIzbBsuEPCIEBWcPT6AE4674OB2EZmiHGZMVkgxjt16FJ5a69U/VBpLgQbpBZr7w/MlHobh539VxfNwu6Py0G5r1E53oG1TzH3ljbaJlG8GQzDiR/U6gyyZOUkycVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a98b7d-9f66-476a-056c-08df04485fa9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:35:00.1772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZOG11ls/Lw5NKo52Kr0Akye6B/3GZMsUzFbLMnP9lzOUPjLm2SkKKkejD66KxZB+tLHA5zMs9zTvYn6Iay4Nnj3rJqBEueV6UCN2/i//EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Authority-Analysis: v=2.4 cv=YOWvDxGx c=1 sm=1 tr=0 ts=6a904b17 cx=c_pps
 a=I1rsLqJrwb5vkj+WUQplAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=58YoiKW9jOSK7lV6N_YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oR_dWZC5855HoQsVZTWFYxeWUVzCVag3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9mX+Q4KX9uET
 vmfU8hpu5UWRQpnSQNXseYfhyTHuB1wF13S4KNGBDKTMOYTlir4SLOyAfLrmEaaLNC28wcIqBot
 MH8eMiM/YnhKbShRiicWtN39BkSs9+k=
X-Proofpoint-ORIG-GUID: oR_dWZC5855HoQsVZTWFYxeWUVzCVag3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX4QOeo5XQiQwN
 WOAlNQnhFeV+EAcXVQvMmARrzXtzXftRLdVKZjxUIy5hlBzVBtDB5p2w7OPYo1MYjschqILuopd
 bLTLfUxLlExnjKrFHuXCuZFCHKVTZ0KHL/l7Ay6POZcV9GK0IRMSrQc70v03yQ1xFPmSUrZGLJj
 4CHiijUsjosdlpQcfd1+ScDK7Tg7Qr/9G76fjK+mP8HPzewVaNRRUpFZHs4TnU9lYT+ge5BCo3k
 WRLtJEpdzWebBmjOsJWrwd4u+8G8end1H0Wv8p72a1cWzwbITL75rqiDLpjveGYY8xD2Sp0C5da
 8ucA3QIqGoQSKjICequmzIEF0kwDkfwXUAuGOqrn7gTQa7cTBz3Pxca5EcEP3SNXI8hnzhDcg23
 2e6UDvrtqk37sG3H4Q5IVckNq9tHCenr3ELqAvb6aG6VArig9xQV8q9Sa742wFuHzUcwzd+P7Ra
 UIAzYqEdLjAxsbiuhbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

The majority of the properties in piix4_pm_add_properties() are assigned to
static variables and so can be converted to static class properties. Introduce
piix4_pm_add_class_properties() to hold the static properties and soon all
other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-16-mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1d209ac96d..6462ba970c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,6 +406,12 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 }
 
 static void piix4_pm_add_properties(PIIX4PMState *s)
+{
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
+                                   &s->io_base, OBJ_PROP_FLAG_READ);
+}
+
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -413,18 +419,26 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK,
+                                                &gpe0_blk,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_blk_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint16_ptr(oc,
+                                                ACPI_PM_PROP_SCI_INT,
+                                                &sci_int,
+                                                OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -616,6 +630,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                                          offsetof(PIIX4PMState,
                                                   acpi_pci_hotplug.io_len),
                                          OBJ_PROP_FLAG_READ);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


