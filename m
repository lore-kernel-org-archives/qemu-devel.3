Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E5CC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0A-0006Fm-TQ; Fri, 17 Jul 2026 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj07-0006FJ-Kl; Fri, 17 Jul 2026 09:53:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj05-0002TU-7b; Fri, 17 Jul 2026 09:53:15 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCJ2qg3917005; Fri, 17 Jul 2026 06:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=GFrjecIc/avlB
 T0EapMLZ73VpebKbq5c6EMHncnRQAM=; b=y6arYCQ/PLuVeAWoS/PvSzcxMzq+/
 ohF33QZJmILVgwnNB9P+HjH5iy5mMdVUrUfwGTaJlwzYclnKICBcTMygGdr6IaSY
 vLlVr0IsfTQxFteMpFTT7nAwVrHr73vi/z4b8mwmMOeGvXomqHvvNc9MrAq3igPN
 EtH2eXbSXj4YMlN+F5Ut9k2XWF5eppPKV2dYc4oEAB5cx1kV+1qlSeLrn2Lwu8nx
 FR6pO716IcJWsfu6Q814X6aNV8WVIL07DcZNjrC1SOwvdqUqwiLmd29sxhWyZn7P
 VsLhME9ZElRGSSZ+hKsw8DeutKCtMnlDBE3TSqnNRt66l7kg+c84scmIA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022122.outbound.protection.outlook.com [52.101.43.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ffh4j0m40-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTG0Mik1I53vn5DF3RFC1rMkoxlFOm7+ZcdH0yrWNNnTv7i45vDDFR1OqyRjQl/xaYFHnM7PBaaCPKc/veN82uj+R1XG3R/Ob0b3d551CrSSe4lq7WVg0w0ps0+CBKuh3/seQAzGQqXx9Cwnl5XLelGi4TtPmVgS+d6fRn5tlg6RMB7X6z8/PF/an2T5cIuvkYvG3jOENIzsItNEZ5JyALIlmnPoyJbgj2tjKKPN9TV21cZMjo2YF6ieSyo7+xDCoT6WmrkTf8cjExrz8VnTaI8xjIHmojXvh0T2axx29uRI1pIQiHoFK33b4VXQXi3czlA6Tm1pHFuiri+OQwpaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFrjecIc/avlBT0EapMLZ73VpebKbq5c6EMHncnRQAM=;
 b=dQp1li5r720d3Mg8vhjwwTBsF5BVbLHeLtQoVCIczgxhqH5aBeXevzvM6szp4rVTY9hDFLoO48JErVmcD1YguRJUMXHLyvtsldNpfRd7SSG9+LOM+bFWBNcKq6UcbeuILTLPxOevbro9AYncW1Pl6aPEl9oUAZ9Nj1rbybCr9Agk/Utk8LMQU+VqWoIFopIYLbgZmepzM+x3CKqAqVpGaOE5LfbJ/MK76p31iNqwTbrYVJIgFAvZsUSLVmkqbRjOsedjim/MeV33DuIeLGvYG1dxERr7zrHnWcxu6SAlpujjsMOpB7pU7XEDxw8fvdA8CJeXHA97sBlIvsp2tW3KzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFrjecIc/avlBT0EapMLZ73VpebKbq5c6EMHncnRQAM=;
 b=CqRkolNzldraNnoWiyLW2Tvh9oqr9DARIFPVT5V5b1/3L/jONcbCGl5P3jJ67J0zx3Aa/3Y9r2pTDBdqa9nlu0WV3IZnzqBuogLSJtbP9il34lK9hhlxmFGxU7DfiRxY7C7bpQrAoXVwcPnHPYHKdJRYtN7oZTyn+3aHLj53aaxlBIIgcGKACJzx1hBJlvggaLOxLrw+4w70hU18ad3Q8IPcPF6HAUkIDivCXnWwAXJz8Kd1BrFK9O4oaAHOCOnDF79S306HSCY/OLvs+6GVJmo72vdKfmNCHa8KNCu4F2EoAXa6JoMskOtKA6ajqXNaYWYNItcDQjO9OdDvBb2z5A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6888.namprd02.prod.outlook.com (2603:10b6:610:86::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 13:52:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:52:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] qom: tidy-ups and preparation for class property
 conversion
Date: Fri, 17 Jul 2026 14:51:40 +0100
Message-ID: <20260717135254.508701-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:930:a2::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0e6d79-34db-47bc-e5f3-08dee40ab583
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: aRBL8tjdugao6ncAHFXVXksaRacS5q8NIG7V3km1pkpSBR87kmk7skd7V8msljMpd9JY1lG10U4IMPODND3VXQCxtXJivOKBwTThdDHLNCTBr3pJ40souXm8IxVCrK/7nOPSsDZRkMNoaATG3sxCscSxMRLdKx26To/6BMeACOzM3j+EOrrUSTFJDeR4XCpgX/P1VGV66vB5KvEHKGFV/DwqE3rX24I+GtIyk3ooNlRE1N9bJ0PmK3PO6GUbrrSJVD0UtsEonRhNMLNRnWzYvLYvFPLQqPs7cC8h5iyGbZZdzX1eAmERLnMqK/9+LUncI8Bxje4DGahFGxhrc5WT3G16zR3N2JaLP4i8aHdcI8stN+jqVKmwBKjAEYBcX0mvZqpD3YdMZ4AmnKpMhwDCt1x2eC3AvR1KaNu1A0OAiaM65hK7nYhJ0C4Yb54P6DkF7yWxt0+opjDq/pIm5CylG/wXGMHWlYjWk3KttVci4NOczBNELOoAowfTxb3iqtGVtXhAOEU80uziTEuRSzCw8xJydWWQsHEebqZvOLBWNYmINe8nWcYLefeiVPzMDfBT3uyYe+x4Y+tA/zDqnYBOTCH+Lc2JfU+rwKjSsK6MPaAKyNLJOVtXqWX5an7+iyIFRbYSg6DKIVjhcxnF2Mkj05bs+AfWWxYMjIlM5rCRBjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndwSzF1VHN3VGZhSGlqZWxFRU12VVRRZ0NDcXFCc0VLR2NNc2Rjek1KNm9q?=
 =?utf-8?B?c3ZuRC9IeFZBTWJkcG1mMEZ4MXk5WnRIQWdwcUd1TGwzYWp6RkJhc2xoSlR3?=
 =?utf-8?B?WVRmOE52VlZkR1VjbE0vbjg1WlBxTXVmcUpFL2E0YThjSmR4cFNTK1pyNTg0?=
 =?utf-8?B?SndNc2ZnWDk5Znhmck5GVStHRm9hZm5USktka2FUQUpXREwxZXd1QVdYTHdF?=
 =?utf-8?B?WFBvNlAwRHdScFFZdzZsMktUa3hRT1dUZWJrZGpJbmhQdUpjcGZYU3huUFNK?=
 =?utf-8?B?K1V2alBBYzFpZXB0bnRIT0JMbGY0T2U4a3Z2cmhJWlI1ZHdyaU5DUjFpZVVD?=
 =?utf-8?B?d2dwZ2RZck5Land2cUxqRXJqeDNDUDJkbzJ3Wk9rZ1M0UkdXOUQ2dkdndURH?=
 =?utf-8?B?WlZUTjdZWkJPdldTQytOWnBkQXFMeXh6dEhJVHc5bHFodklxLzRWdEthU1Fy?=
 =?utf-8?B?SHVacDZDUk9nZ0ZEOVBEOTBPMTJlUTlwRzZlLzF3amZQeTFsWis3Z3B0K0Y0?=
 =?utf-8?B?VFRYdDlXcVpsaTd4YlRPK1JYSGZnUHZmUERGeFdqV2hyS1ZleHpHVTlLR25r?=
 =?utf-8?B?Qy9vcXdZN2FXcFBzOEgrcC9OZVIzcE1IcG5oaEs4ckpWYjEzbTc3M04xeHVP?=
 =?utf-8?B?TzJYcUtlTDd2eTd1RUZQQzFuYkRBbUZqZEp5eHU0ZG1Rak56L3d0cGpSTUlR?=
 =?utf-8?B?L2srckNVb1R0Tm94N2dURlZONTBJTDFlY0lNZis5dStuejFNc1hJZThvTzc3?=
 =?utf-8?B?V09LMFphczVGa0lleE9QY2hjMllqeXRDdE9BbnBQMFg1M2VzZXlJZ0hCL0VN?=
 =?utf-8?B?MitiWDJXMzBGVWJjVnNhNnVzNExMbFgveXVUVFlMQW1VR2ZYVHVjMjJZcnhz?=
 =?utf-8?B?b1JnNW9GRkk4a0FKeklHWmZvRFllYzFyUXkwZUx2QWtoOEc1Y1hlVm5JWG9k?=
 =?utf-8?B?VEh2OHVvQWxEZzJScTd4MnhLN2J1MzhMS0VHNUVQczZrTEd0NmZabU02d05v?=
 =?utf-8?B?RG9pcHVER3l4U2dYdm4vUXBsdGhmNUE5UjBlY2dHa0xNRUc3N0RDSGpRK3FY?=
 =?utf-8?B?eVUxb3BodHVoK2FNRmRBODN0RUZoY1pHazBFd2JLRXg2UzB0WjlWR0xiczNu?=
 =?utf-8?B?NFdxZFpabUkyMGdVakFBYTNhbUtjcDd1dkVvK3Y1dFA4a3VLRGljL0VDbllm?=
 =?utf-8?B?SDJ5cUJWSTV4d1labWdybUt1eWM0Q2J3RkxsbU9LVno1MXVHcm92SDc3MWo1?=
 =?utf-8?B?VzZPUEtHeFpRZnMyalJHNnY2bllRT0NVeUJCTkpRT3orM1l1U2VzTGxTSFVZ?=
 =?utf-8?B?aWxBZ0RWcWJnSzVISXhTLy8xbVhSRUkvNFphTWdXQ1VPd3JEK2RTYVNFY1A4?=
 =?utf-8?B?bFJzK0hBZm0rS3QyWmtjdit1MGEvdXNqTGdwZ0owcFdNNjZ3SWY2NmZaOEhU?=
 =?utf-8?B?YmFhQnpUZG9WbTlkYW0ybTlCeXNIU25tVmMvaHpxa0JpSXI1aGRrejVERWx5?=
 =?utf-8?B?elpkYkdCSCsrdFM5TjNBOU84V2tDSkRIRlR6SnZ3Qis1VTE0K2pCNXB5VWtS?=
 =?utf-8?B?aXRucmEvdjVaT1FhTHhEUXo3QUtMSmhUWFNqcDZ2eWJvNkF4c0tqeWcreEFl?=
 =?utf-8?B?bW9pazkrNzF2NnQyZXhrOWxvVEZtV3haRTJpQldrbjlLc3RocHp3SUM4WkNO?=
 =?utf-8?B?Q2w4U1pCVkJWdVc3NUVtN3hwVm0yNzNxYU9sczRjbjk5QlNQNloxODZJSGUw?=
 =?utf-8?B?d1c2WGNJY0FOc0lVa1E0OHI1U1UrRGZZMmFBYU9BcnErYTJic3IyZUdaUlNL?=
 =?utf-8?B?SkJac1RlUDNoUS9uTFM2WnozM09HVERoWW5ZQ2RyVXZTRmNFd3Y4czc2bWFu?=
 =?utf-8?B?VmZ3UnBSYytyampDbERXT29lSjRMazRiQXl2RWhMS1Y4UDlOTm9Xa0JUUWkx?=
 =?utf-8?B?SXNVQS9wRGxRN2xOQkR2MmRBNjRGMmFQSEJJN0RtcDZabENhbGZwNnpQRlQw?=
 =?utf-8?B?YldaZHpNR1NSM05ub0VWYldKd3BVOERNSlU1azd4ZzFRTlRuZVluY2ZZbzNh?=
 =?utf-8?B?eTZITytySWpZVDB0RCtqaGN2M09mZndEVzJBU2JrbmFSVnRWbDRYL2hiNDRv?=
 =?utf-8?B?cnBJdE82blBtcUFvZUZRaHhLMng4M0RyOVh5amR3L21jbDJtaHFudjdmV2Vu?=
 =?utf-8?B?dEYyd1Z6OFA4ZXI1em1iMTFEeXI0NUVKQ0pLL09qaTkzVmIrZEJUOHR6SWFB?=
 =?utf-8?B?UHBaUStkNFJJSU90OFRza0dld0docFdJTExnclVrOWZicEkyZWFodXBjNkNN?=
 =?utf-8?B?VXpPU2xtQXdhME1VQm56a0Yvdk85U2k1TFJZNWJ1c1VQclc4c0JBVFIyQVE1?=
 =?utf-8?Q?3rxxz90CqGdnyzYY=3D?=
X-Exchange-RoutingPolicyChecked: aRjNz5E1BqJxHs7M5M2V7eV1NWQZdvHQIKRj3v3K0LAHYbUbr6DOOPFYECWJA+oUusBkiDcyIOF9e98R80Jjg+byoWp3NkVScvo0BD+WOZvVWX7//Y2fX8Obd6oqRayL67LB0Mrldc77F0+5SqCncBkj1whOVAO+kIq7nzWQXr68M4cPYjAeL7sTG/0gR0LCjHTc/yrPfoUwTmNzH04uchmhfguXO3rwFm4EK70ZSRm8cgTmsab8rqDJVBYHAhXorkXXb2Qp69BW0Mk6D6WeIKQz6VbeykJC5V4dguPfhaMM6A+Sg+lRK6aIxTlFwxYFS+lmCk724wVcey9tYcktlA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0e6d79-34db-47bc-e5f3-08dee40ab583
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:52:58.0571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqaXOBF7BFNyjMiRnpJ3670ULH+dj+8tan99aDwspoWfq+foKWQ7q9Pc577WC7J1MLLPogaazpaLrI+jxpE4LR7kPMjLobcI4TAw2rzOoRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6888
X-Authority-Analysis: v=2.4 cv=FNgrAeos c=1 sm=1 tr=0 ts=6a5a33bf cx=c_pps
 a=Z8bsAIsP1tKwyndEcU5KlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=MQT6d3jYLYhd-RoBnOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX4fSMATwaF6mV
 XXez2QSKoUyuf+agkjPlTs5/jxSEGk5oQeCLTy4aSBxsl7WyzmHkbw/NEUJIioXz9w5Jg1G5VMb
 Mx+us+/9rJfETGaxsLgQDRquG1rCFZALBmqedrZpm7fOxrR9vqyaphrSRIhORGomcExcWTGo02e
 9rXJCY/ieqS9SX/C8fx44Gc08mopq8QJ73CaLP8hbzmeZRvy8oVJp9+K3KaeouN6UnMI7jeYdOw
 rQ6hyBYUGT0rC+Y4Zx2an1tAXgI3pH00j0zuNaBKAw7+x1OG5MKoMiaxO4rA0RDgWLuFoKY6P/7
 nDhPwfnanJDA99iMxwn8KfpsufSqJH0YhNSNknk7krlQ3TZ8fFNC8pxue9/R1Dxy0OF+Wlsr4Oh
 WmdF1YGxLYyLHI8wOgQ6OAtfC6VwHqpQWRQ+fPN0nJPKDVuzO2Kp8m876gbSoFkw5BiknYBfJAg
 E87ETg1/LiPbystVlwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX0i4DgTCo04Yi
 W8aGd6MrxCzsXRM3mq/Yq1TPnfB9OQkahYpS2Xj7/YaRB5SBzowRbK+B7biSilioxhGOziRAxdB
 CXRQ7FFIlIGJSgJRqPwsOVRGe4aHeDo=
X-Proofpoint-ORIG-GUID: TIQSyc6DXEZeNCRoYnqOAQGIsDYGH8PS
X-Proofpoint-GUID: TIQSyc6DXEZeNCRoYnqOAQGIsDYGH8PS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Based upon feedback from my existing efforts to start converting from object
properties to class properties, here is an initial preparation series which
I hope can be applied soon after 11.1 is released.

Patches 1-3 introduce macros to generate the QOM scalar get/set functions for scalar
memory-based properties as suggested by Daniel. This makes it trivial to add any
additional scalar types as required in future, and a similar pattern will be used
when introducing proper class properties.

Patch 4 fixes an error in the existing documentation for object_property_add_link().

Patch 5 adds missing documentation for the current object_class_* property functions
since if we're looking to deprecate object properties, it seems only fair to include
the replacement class property functions in our documentation. Again once class
propeties are added, the new functions will be documented in a similar way.

Finally patch 6 renames the existing object_class_property_uint*_ptr() functions to
object_class_static_property_uint*_ptr() to both confirm that the property is shared
amongst all instances, and also clears the object_class_property_*() prefix ready
for the introduction of class properties in subsequent patch series. This is taken
from one of my existing series to convert object properties to class properties, but
it seems convenient to include it here.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v2:
- Add R-B tags from Daniel for patches 1-3
- Add patch 4 to fix up the existing documentation for object_property_add_link()
- Fix up the object_class_property_add_link() documentation in patch 5
- Add Daniel's description of when to use static properties in patch 6


Mark Cave-Ayland (6):
  qom/object.c: introduce OBJECT_PROPERTY_SCALAR_GETTER(type) macro
  qom/object.c: introduce OBJECT_PROPERTY_SCALAR_SETTER(type) macro
  qom/object.c: introduce DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
  qom/object.h: rename @child to @targetp in object_property_add_link()
    documentation
  qom/object.h: add missing documentation for object_class_* property
    functions
  qom/object.c: rename object_class_property_uint*_ptr() to
    object_class_static_property_uint*_ptr()

 include/qom/object.h | 172 +++++++++++++++++++++++++++++++++++++++++--
 hw/riscv/spike.c     |   5 +-
 qom/object.c         | 126 ++++++++++++-------------------
 3 files changed, 215 insertions(+), 88 deletions(-)

-- 
2.43.0


