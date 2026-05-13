Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AACCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNA57-0004rV-Jb; Wed, 13 May 2026 09:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA53-0004rE-TH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA51-0007Lb-32
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:57 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAl33n4000222; Wed, 13 May 2026 06:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T2ciN/f7SbUh1blrfIHdCUBVDM5FzNV/kwAJxSJjz
 1o=; b=Cq4GDbKxj+f0Zr2S+uVTsnX+P6K1hbuOeblyckpZoKUwKjtn5O3VmPM94
 2waofiQxOGTwtg2H2Q9x62niBc7KvymOE6H4JjSHcRaKAdlyCyg4pKxVuBijlQ0g
 jOOE8VTzr84MFyOo+4KHbI5BogAOZdmmArixQzVVx4hc7UGW2X76LpPToOxExCfo
 2XnP4Iamk72OdkYs5clGwscssNg7bWdmvJRMIjDmYlWTb5KrkNsKVdQ1DAnl04KS
 uuj9hylrxr444tORtHYGYpdOVWO+M8AUSZvQ5GcMpM3Lh2IvskyedCSycmAYn3ca
 dyXk6ySoh5MUtQRTGqATw8Xu7nTIg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023082.outbound.protection.outlook.com
 [40.93.201.82])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e3nvpwt49-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 06:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfcQMggIexV2TdNjFD+YOPqeiPZ6vRJIQzAoiHp1UNhxsZkCWnAhY5N3XMRFyjisPdUL34uYSW+jAhd1+mRROZ0iCGZ6Y7mdFoC0Lojl9qso7wMhDIqvFzjFvzIGwhAbzJBgJy2wrELJqRlJ27IAzQ3K9m+2IzzKprHP0yMBjdAqJ9oPnRWZhROOfL1F2eGfdMpH01w82o5c+5tjvMSztHcUCc3kPI/A+pr9wW22mbxK75XPFSVKQPsdbg7mnA3P7alrvlM5EMqhziJze2s3SheGxxTjXepGyipVLI/lpoB7sRBsHJEStRTWIAzKSBPPMwScNnohWdvgWfsqoLpaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2ciN/f7SbUh1blrfIHdCUBVDM5FzNV/kwAJxSJjz1o=;
 b=YK+dN4UgKrEmOXzr0NOGCqHv5PN2UdXJtWODdRClFnsOZ7Acuz8U8JxDWhFzYj21hSqugseSgmDPP49tas7uweVCgkU+PkN2HNKVJO02d3Hme01ZZZYTJArq/sorfen/lon+zrmIrT7TSIIw0EAoW4nc3yt3JgAFIUO91/cM9R11uhFK7OTc+Hv/A6mkzpEgOd8HDvRQaPfcsxX4RwIxRXXote46aRWWh2f/GosNmdeVR50oxlyosiLMs6QxF66gMiW1cFeovTveKTa8YbbCyo9x2usl7gUw8xkCjUsUc8wl2o2qtCY9lzks+8wto655kgq8uQIPllp5a+cGuGO3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2ciN/f7SbUh1blrfIHdCUBVDM5FzNV/kwAJxSJjz1o=;
 b=Tms0VzPXj4wXuR46CItE85gsU/p7dYYi+Ga0q1C2KCeder91vCqPSrYiiiUqEKQ5vgexDmLJLi7KRAbVbwZon7gvildcB7XHsagF7/leNT5TNbJN6StN/psuJP+r7A3p1dgAHfxh27orUZ6Z4l3i+Gt3JxqG+k0J0QgZEuXEIGIDBtHxE4tw2WQ0ZYJ92bacJe/IEQOAh7DAqzmQTkMVUoz4nJ6zoGzkwTriF2eX11YzZhTK9a72jzaH/J0mt2hfzDamQy8RU4gkYQbPbTn/lxoUQAkxNjmsCoLqpeQnjhlecCX5rHqj+SyzdHLKqG7yfQcxlaKXGBZdo3h1LjvDxg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by LV3PR02MB10644.namprd02.prod.outlook.com (2603:10b6:408:28a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 13:56:51 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:56:50 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH v2 2/2] Add HvExtCallGetBootZeroedMemory
Date: Wed, 13 May 2026 13:56:16 +0000
Message-ID: <20260513135616.3519354-3-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513135616.3519354-1-flosch@nutanix.com>
References: <20260513135616.3519354-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|LV3PR02MB10644:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf3c52e-b1df-4bd9-454b-08deb0f77b71
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lVy621K3r0IWbRtL/Yx0S7trFCETc+UCmyDbtJRZw2pEqdVULTz8gCh6//3uaIax8yo9dy/Jkl+bQ3bIxFwJQLb6ZYLXO5jKsV2EyQUw19t0X6G7CNbXcCmEKEXHo8v/wdJ/9M2oq/suvWHd9NsDoQE7RxaGLAMHmYui8s7BQ4+UPbiYA23+I89RMYhQdg1XvjMb98uPOyFtb0wtZgBQ5oPNl4k/dVqt5q9wABZquTglLpNXvw4HmjETFBHRUwCkBjDcEmmwrDCR0I4q/GaH9rL1aNvEqPWLvNQ2JI5SpXBZDcOwlwjJJEBE5X4BLbTfRMOPxvO/IYcj//4nJ+nL1DLuxHRLusJUVjP3x8JiIIz/6j1KKRci0YQG9sjhCAzVH2R2Fs5+bJNOaxyfKL+xZZA8bBB3dmHEEeMYJKhsPil+xviY2zaQJBXz8dovyQXzI7je+RnVCmMVJ9Zo5TyUwd462sIAvKdPl5YUSbca8FDTscpROl74CNbHXkU+6EEfQnQv/rwKkQ8UllR+4aQOkk+d84uVbYtnfv6UXaXVSp6OXMHOKnwlwFxDt8h8AnjsTvvP6uLBURFNyiwegobk9aHpoSwU5XabakjmlF78p7b7AYGOnYKFa6al7C7KuzvngwxxhT9RIb/NjGSEBu8AwsIgM70k6w1teXbgl7LLrIXElVaE2RtpW7enHhJZvb5GVgoKG4YgJIJz5UwImvqhE9tQPS3yBL686sroF1SbPWIke2Im5KZSen2xU5O7K+Oa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4A0kMk+e7dcTWtgWFpwPmTyqfp36GB64290QrJQsts3FvkBsf5QLOqu3Sfp7?=
 =?us-ascii?Q?jT+CW0Ei5FvOBo02ey7WA3lqkldTqyllLoAiB6KlgV8MO0Aq96vfw0UeHQuy?=
 =?us-ascii?Q?JkeQua8syqIoGdnlI9Tsrh2VYdzdvxYVLwRvzu12ggXVO1Zql/JJmPIaXp2r?=
 =?us-ascii?Q?UkbLS7ZYS/jkAUnnvjiBYfj8CuRarWIdT5l4l5vNVFZVlORAfvcn1ZSDSu2r?=
 =?us-ascii?Q?E2cw/TQdl85LFl42H+6CmzFWdl+wIHqMiKjEXbj767qXMR6vRoteXOm92ul3?=
 =?us-ascii?Q?ZDXgBAEHOtLgl94XAHQtCqNhokPfgynbGnBgN3S9lH5k8kYWtV9T2PRPDyjv?=
 =?us-ascii?Q?oDgj8SIGbUfqALraDMjxmPdrf/uLdQOn8po7U32U/ts/AhhLC3LDu8KMNS81?=
 =?us-ascii?Q?lNV8AoujuNdrx2GPXjZFfgEoJSDAbNxE6M3GmrUU6aVLDYfVLzWaQvZzrENX?=
 =?us-ascii?Q?eT6oOWDui0e5UZhcMChC9CQIYKiJ/pe6gafDoXATD9SyV7uCkfanFngiL5Qq?=
 =?us-ascii?Q?2M28fU3YH0qcwMZr+QpKswk1wDrmw6tmdaJW4nrjGZiy3+oCUmR8SgNXCOl6?=
 =?us-ascii?Q?Wkk9RUgGVlO5KbbqFnDnA/EyVUG+q+PCg0xOIv1gmjbTYeRy3jAFrj2Qusgo?=
 =?us-ascii?Q?J/UixSuE11w/ZWC1Lwv8MUYHgu+3/+VmAf3z1y4SDCIGab7yN35DLfQeLcoY?=
 =?us-ascii?Q?6ZYxZLeiFXkhdvccw3DFkiguYolNs38bGtJr8DvvBwWmtpOKFvoZbGLJwP0D?=
 =?us-ascii?Q?Va2LlXBzRUasZ8xgKk/kjBWZlOk4DvdaSUtmdQhLBAxnPmHSvntid4Mh5BdC?=
 =?us-ascii?Q?TefbgbYfMJSvaFIZzCGCUbfBTAunUFISOP43mWybmBbwWz1DDAg+uNsRiWmD?=
 =?us-ascii?Q?RcpS4n6wsYmmaUpA3PvZwGOWiKzyUqWTQVNgmUibYhtuhUE6U14Zsel3Dyl5?=
 =?us-ascii?Q?mi2iHi39gZO69635Prfcw6ahD6fv27ZaKGUXeelMPwEve5sAG3W01kTLIKPW?=
 =?us-ascii?Q?mMy9XAh0iB/7w2lyr73vKK8iEYq4E40phZpm5zEAZWcUHJTwHYWo4Q6cvilY?=
 =?us-ascii?Q?4R1TokypgdnN3EC//1KKAcIq9ybvaGpDurLYPf+JMA1SSO9qay936JfAFi7e?=
 =?us-ascii?Q?yXlfTPMCFthwiQEbjqe8fI+MRtq+Nw7+UpXpXFydQuo8Aw+BNECJdTYtzOE7?=
 =?us-ascii?Q?93Kdas2sfbxIguCJQJJMEFN33Z+8k7Oylx07MTd5n3ZSnObLJrelsRkoMZ0w?=
 =?us-ascii?Q?smUToXNQXiRkqpyPjoDYj1yH7ydtuwwUvUqq6ufwM9nn3+holbk0FO56MAEQ?=
 =?us-ascii?Q?3+ElbPrPMm0EWUcyrQqpDjP/YHcr1WgOCfnkQqN8DSF0Vig5p1SopD5Y7AKY?=
 =?us-ascii?Q?YbeZGwf5m9bq2YruQsmcwGftu9QA32wqZQ/5ynxh7dtYp/3PjFlvBTsP/uVS?=
 =?us-ascii?Q?yZGq6/lC90gnIuvVhUaibes6p2G/oX47u1r/BWnLTd3yD9IUXy35NtDhj1rt?=
 =?us-ascii?Q?iPt6w5CMlAmv9hIFF+I6n+d13OWn/8MVxqtU4lHzGPGpk1BZ24Sce7C6a9Gw?=
 =?us-ascii?Q?uVKpVArFXXIFfpU9bxp6IFOMH9oLkvhyVDGHg2/pRWwZgRY7OO88EyNrwf3G?=
 =?us-ascii?Q?t49I8OAJ3EtitdYGJ/ODPwQWQKhnBaXQRn/VsZcbP4jVS9FTlzAeMiqyEiHt?=
 =?us-ascii?Q?ZPpOTRK1TqvJ0U99JrrEvvqcI2w0YE0RgnNUZLXth9AD4ss0XSduA+QrK8zt?=
 =?us-ascii?Q?d68IRP8qpvnAej2XkG8hy0X8UnZYhyM=3D?=
X-Exchange-RoutingPolicyChecked: HktCVBlYcFlWF2LCbCoIifn5oPrvzQtdAtTN0wmONW/rSfq2ocqBo2jHmBhX8LIRh6wW5jogwseWnnqlBOG5k9erKEcKG9UDhn1FgHAPdNsj0Q6owq3qSO+c91vjx14Zf9wOxJ6EWwJpF+Ihs8ZZYXMUbMHxTHy+wZBK11sFeW5+IHwZJL2rsEEZw3jEga1xU1qsdVuY8Fz7EOqae/jMh2YDvkqjdStKvJ+v45V5oERPmtGgjz8JWQ8zV+AnO6rdsADJl58hb/FSCVQl0mOGHjwCUjPp6f113ABHzRtsJGVAz2Sn1yfZ77QoZfu5WzI9nZf4tdMwx9YdF5AaFFi48A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3c52e-b1df-4bd9-454b-08deb0f77b71
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:56:50.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRHWJHz709UjFBQPY9JXJTSxqfDCEMObmHlHesyGCw1U2DdV4fEMLqTJrTQWeyRp5pMd4vCElg7+Ds9Cam7H7AkVvyysUw1C3S6MEEaISvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10644
X-Proofpoint-ORIG-GUID: QDbciS6NpFYTEyOhsHxeM5QjrTvNRZ_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MyBTYWx0ZWRfX4oslzKMJcZfQ
 4ziTKXnuzzw+dlS1QHNkz8jhmBJIYQ8hyfwlSuMtUyTfOwSE0pO4EJkGBQuGhl7JdRWH4irxRZB
 4v1zrUIeQtaTkvoHvafiVF3yMnLq9BBZZjOa2Wih23qpRnHg78wla+VaG1RcgRy5jRm7jo+iJRr
 wG7jnLbzJ0nQpE0MeH9RS1qMd53qZsnECr9GvPY/fF6esneg7u0f1aniO7G1b+EtAWjLWZSS4PP
 bkUTwuqgaQDUOl3r7RUw0NlsSSBRccPzXWMJmUOVe1MlGh1SJv42/c3wezpQSeV9BbdRndBJj+q
 Od3VZjcaKcVhbAHKeXXPWdTvn9+fNCYRoebAnThoix88Kyfo6qpT4UsPriNpKWURUOVsjjiaaYb
 U17/mfhddcRbABK6O9LoXEEopFdzahRh2rlxMIVfq2S2l7F29vEpmDLZofShvpVq8Up9fShdNfs
 JXO+Cwz+xczLIdp3LCg==
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a048324 cx=c_pps
 a=ulKS55DWmiSHHqtbYmVMKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=y-RcV8gkgojH_-w_mxkA:9
X-Proofpoint-GUID: QDbciS6NpFYTEyOhsHxeM5QjrTvNRZ_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

This call allows a guest to ask the hypervisor which of its (guest
physical) memory ranges were already zeroed out by the hypervisor, which
means there's no need for the guest to zero them out again at boot.

To do so, we have to track what memory is not zero any more. The
conservative estimate for this is to consider all memory that we ever
touched to not be zero any more. To track this, we introduce a new
bitmap, independent of the existing dirty tracking maps.
This is for several reasons:
* Dirty memory tracking bitmaps are always allocated. This is wasteful
  when we only want this bitmap for one specific use case.
* Dirty memory tracking is tightly aligned with target page sizes. We
  want to track at a much coarser granularity, which reduces the bitmap
  size, and will also make our hypercall reply have fewer fragmented
  areas, without losing too much of the benefit.

Note that there are limitations of what we track: we only track initial
memory. Memory hotplugged later will not be tracked, and so never
reported as pre-zeroed. We also don't track non-zero memory over
migrations. Both of these are fine with respect to the use case: Windows
only enquires about zeroed memory relatively early during boot, where
both of these operations are uncommon. For those cases, we simply report
"memory is not pre-zeroed".

Finally, we currently don't track memory that the VM itself touched. For
this, we will need KVM support, and likely a new ioctl that helps us
track memory mapped by the guest.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 docs/system/i386/hyperv.rst      |   7 ++
 hw/hyperv/hyperv.c               | 121 +++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  11 +++
 include/hw/hyperv/hyperv.h       |   7 ++
 include/system/physmem.h         |   8 ++
 system/memory.c                  |   7 +-
 system/physmem.c                 |  52 +++++++++++++
 target/i386/cpu.c                |   2 +
 target/i386/cpu.h                |   1 +
 target/i386/kvm/hyperv-proto.h   |   5 ++
 target/i386/kvm/hyperv.c         |   8 ++
 target/i386/kvm/kvm.c            |  17 +++++
 12 files changed, 244 insertions(+), 2 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index c5ca25067e..71ee456921 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -263,6 +263,13 @@ Existing enlightenments
   provide any useful new functionality, but it's it's required to be enabled
   to use any extended hypercalls.
 
+``hv-boot-zeroed-mem``
+  Enables the HvExtGetBootZeroedMemory hypercall. This allows a Windows guest to
+  inquire which memory has already been zeroed out by the host and thus doesn't
+  need to be zeroed out at boot again.
+
+  Requires: ``hv-ext-query-caps``
+
 Supplementary features
 ----------------------
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 1764203d3c..c99b247bc8 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,6 +13,8 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
+#include "system/physmem.h"
+#include "system/runstate.h"
 #include "exec/target_page.h"
 #include "exec/cpu-common.h"
 #include "linux/kvm.h"
@@ -23,10 +25,13 @@
 #include "qemu/queue.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
+#include "hw/core/boards.h"
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
 
+#define HV_BOOT_ZEROED_PAGE_SHIFT 9
+
 struct SynICState {
     DeviceState parent_obj;
 
@@ -731,6 +736,98 @@ cleanup:
     return ret;
 }
 
+struct boot_zero_opaque {
+    struct hyperv_get_boot_zeroed_memory_output *zr;
+    const unsigned long *zero_blocks;
+    unsigned long num;
+    unsigned int order;
+    unsigned int count;
+};
+
+static bool bootzero_mem_cb(Int128 istart, Int128 ilen, const MemoryRegion *mr,
+                            hwaddr offset_in_region, void *opaque)
+{
+    struct boot_zero_opaque *p = opaque;
+    ram_addr_t r_start, r_pfn_start, r_pfn_end;
+    hwaddr ram_gpa_pfn_offset;
+    unsigned long b_start, b_end;
+    unsigned long begin, end, idx;
+    uint64_t pfn_start, pfn_end;
+
+    if (!memory_region_is_ram(mr)
+        || memory_region_is_rom(mr)
+        || memory_region_is_ram_device(mr)
+        || (int128_get64(ilen) == 0)) {
+        return false;
+    }
+
+    r_start = memory_region_get_ram_addr(mr) + offset_in_region;
+    r_pfn_start = r_start >> TARGET_PAGE_BITS;
+    r_pfn_end = (r_start + int128_get64(ilen) - 1) >> TARGET_PAGE_BITS;
+    ram_gpa_pfn_offset = (int128_get64(istart) - r_start) >> TARGET_PAGE_BITS;
+    b_start = r_pfn_start >> p->order;
+    b_end = MIN((r_pfn_end >> p->order) + 1, p->num);
+
+    idx = b_start;
+    while (idx < b_end && p->count < ARRAY_SIZE(p->zr->ranges)) {
+        begin = find_next_zero_bit(p->zero_blocks, b_end, idx);
+        if (begin == b_end) {
+            break;
+        }
+        end = find_next_bit(p->zero_blocks, b_end, begin);
+
+        pfn_start = MAX(begin << p->order, r_pfn_start);
+        pfn_end = MIN((end << p->order) - 1, r_pfn_end);
+
+        p->zr->ranges[p->count].start_pfn = pfn_start + ram_gpa_pfn_offset;
+        p->zr->ranges[p->count].page_count = pfn_end - pfn_start + 1;
+        p->count++;
+        idx = end;
+    }
+
+    return p->count == ARRAY_SIZE(p->zr->ranges);
+}
+
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    hwaddr len;
+    struct boot_zero_opaque priv = { 0 };
+    hwaddr write_len = 0;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*priv.zr);
+    priv.zr = cpu_physical_memory_map(outgpa, &len, 1);
+    if (!priv.zr || len < sizeof(*priv.zr)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    priv.zero_blocks = physical_memory_get_mapped_ranges(&priv.num, &priv.order);
+    priv.num *= BITS_PER_LONG;
+
+    priv.zr->range_count = 0;
+    if (priv.zero_blocks) {
+        RCU_READ_LOCK_GUARD();
+        flatview_for_each_range(address_space_to_flatview(&address_space_memory),
+                                bootzero_mem_cb, &priv);
+        priv.zr->range_count = priv.count;
+    }
+    write_len = sizeof(priv.zr->range_count)
+                + priv.count * sizeof(priv.zr->ranges[0]);
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (priv.zr) {
+        cpu_physical_memory_unmap(priv.zr, len, 1, write_len);
+    }
+    return ret;
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     EventFlagHandler *handler;
@@ -1014,6 +1111,30 @@ uint64_t hyperv_syndbg_query_options(void)
     return msg.u.query_options.options;
 }
 
+void hyperv_boot_zeroed_setup(void)
+{
+    static bool initialized;
+
+    if (initialized) {
+        return;
+    }
+
+    initialized = true;
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /*
+         * We do not track zeroed memory across migrations.
+         * The hypercall is only issues early during boot, so we don't lose
+         * much by not dealing with the complication of moving the zeroed
+         * state of guest memory to the migrated instance.
+         */
+        return;
+    }
+
+    physical_memory_init_mapped_tracker(current_machine->ram_size >> TARGET_PAGE_BITS,
+                                        HV_BOOT_ZEROED_PAGE_SHIFT);
+}
+
 static bool vmbus_recommended_features_enabled;
 
 bool hyperv_are_vmbus_recommended_features_enabled(void)
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index f1d1d2eb26..5bf5684d11 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -36,6 +36,7 @@
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
 #define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
+#define HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY    0x8002
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
@@ -192,4 +193,14 @@ struct hyperv_retrieve_debug_data_output {
     uint32_t retrieved_count;
     uint32_t remaining_count;
 } __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_range {
+    uint64_t start_pfn;
+    uint64_t page_count;
+} __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_output {
+    uint64_t range_count;
+    struct hyperv_get_boot_zeroed_memory_range ranges[255];
+} __attribute__ ((__packed__));
 #endif
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index e29d60f565..8e7fec8e4a 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -102,11 +102,18 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
  */
 uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_GET_BOOT_ZEROED_MEMORY hypercall.
+ */
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
 uint64_t hyperv_syndbg_query_options(void);
 
+void hyperv_boot_zeroed_setup(void);
+
 typedef enum HvSynthDbgMsgType {
     HV_SYNDBG_MSG_CONNECTION_INFO,
     HV_SYNDBG_MSG_SEND,
diff --git a/include/system/physmem.h b/include/system/physmem.h
index da91b77bd9..7f5063b0af 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -53,4 +53,12 @@ bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t length);
 int ram_block_rebind(Error **errp);
 
+void physical_memory_init_mapped_tracker(unsigned long num_pages,
+                                         unsigned int order);
+
+void physical_memory_set_mapped_range(ram_addr_t addr, ram_addr_t length);
+
+const unsigned long *physical_memory_get_mapped_ranges(unsigned long *len,
+                                                       unsigned int *order);
+
 #endif
diff --git a/system/memory.c b/system/memory.c
index 739ba11da6..21d14489b9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2188,9 +2188,12 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size)
 {
+    ram_addr_t ramaddr;
+
     assert(mr->ram_block);
-    physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
-                                        size,
+    ramaddr = memory_region_get_ram_addr(mr);
+    physical_memory_set_mapped_range(ramaddr + addr, size);
+    physical_memory_set_dirty_range(ramaddr + addr, size,
                                         memory_region_get_dirty_log_mask(mr));
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index c58d940e80..0728367035 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -180,6 +180,56 @@ struct DirtyBitmapSnapshot {
     unsigned long dirty[];
 };
 
+/**
+ * TODO: Or as part of RAMBlock, but we don't intend to extend once set up at
+ * init time.
+ * @mapped_blocks: pointer to the the bitmap itself, maybe NULL if no tracking.
+ * @mapped_blocks_num: the length of the bitmap, in sizeof(*mapped_blocks)
+ * @mapped_blocks_order: the order, in pages, i.e., 0 = 1 bit per page.
+ */
+static unsigned long *mapped_blocks;
+static unsigned long mapped_blocks_num;
+static unsigned int mapped_blocks_order;
+
+void physical_memory_init_mapped_tracker(unsigned long num_pages,
+                                         unsigned int order)
+{
+    mapped_blocks_order = order;
+    mapped_blocks_num = DIV_ROUND_UP(DIV_ROUND_UP(num_pages, 1ULL << order),
+                                                  BITS_PER_LONG);
+    mapped_blocks = g_malloc0(sizeof(*mapped_blocks) * mapped_blocks_num);
+}
+
+void physical_memory_set_mapped_range(ram_addr_t addr, ram_addr_t length)
+{
+    unsigned long first_bit, last_bit;
+    unsigned long max_bits = mapped_blocks_num * BITS_PER_LONG;
+
+    if (mapped_blocks == NULL || length == 0) {
+        return;
+    }
+
+    /*
+     * Since we don't track hotplugged memory, we may get requests to
+     * (partially or fully) set a region we don't track.
+     */
+    first_bit = addr >> (TARGET_PAGE_BITS + mapped_blocks_order);
+    if (first_bit >= max_bits) {
+        return;
+    }
+    last_bit = MIN((addr + length - 1) >> (TARGET_PAGE_BITS + mapped_blocks_order),
+                   max_bits - 1);
+    bitmap_set_atomic(mapped_blocks, first_bit, last_bit - first_bit + 1);
+}
+
+const unsigned long *physical_memory_get_mapped_ranges(unsigned long *len,
+                                                        unsigned int *order)
+{
+    *len = mapped_blocks_num;
+    *order = mapped_blocks_order;
+    return mapped_blocks;
+}
+
 static void phys_map_node_reserve(PhysPageMap *map, unsigned nodes)
 {
     static unsigned alloc_hint = 16;
@@ -3131,6 +3181,8 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     assert(ramaddr != RAM_ADDR_INVALID);
     addr += ramaddr;
 
+    physical_memory_set_mapped_range(addr, length);
+
     /* No early return if dirty_log_mask is or becomes 0, because
      * physical_memory_set_dirty_range will still call
      * xen_modified_memory.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d77de52b4..0a47dc376d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10762,6 +10762,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_BIT64("hv-ext-query-caps", X86CPU, hyperv_features,
                       HYPERV_FEAT_EXT_CALLS, 0),
+    DEFINE_PROP_BIT64("hv-boot-zeroed-mem", X86CPU, hyperv_features,
+                      HYPERV_FEAT_BOOT_ZEROED_MEMORY, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index eb870fa015..9e64c78eaf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1481,6 +1481,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
 #define HYPERV_FEAT_EXT_CALLS           21
+#define HYPERV_FEAT_BOOT_ZEROED_MEMORY  22
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 4eb2955ac5..ec38b717e4 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -94,6 +94,11 @@
 #define HV_NESTED_DIRECT_FLUSH              (1u << 17)
 #define HV_NESTED_MSR_BITMAP                (1u << 19)
 
+/*
+ * HV_EXT_CALL_QUERY_CAPABILITIES bits
+ */
+#define HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY   (1u << 0)
+
 /*
  * Basic virtualized MSRs
  */
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 807acaf6b1..dc226b4419 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -123,6 +123,14 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
                 hyperv_ext_hcall_query_caps(hv_build_ext_call_caps(CPU(cpu)),
                                             out_param, fast);
             break;
+        case HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY:
+            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+            } else {
+                exit->u.hcall.result =
+                    hyperv_ext_hcall_get_boot_zeroed_memory(out_param, fast);
+            }
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 586656258d..70ac56624f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1143,6 +1143,14 @@ static struct {
              .bits = HV_ENABLE_EXT_HYPERCALLS}
         }
     },
+    [HYPERV_FEAT_BOOT_ZEROED_MEMORY] = {
+        .desc = "enlighten guest about pre-zeroed memory (hv-boot-zeroed-mem)",
+        .flags = {
+            {.func = HV_EXT_CALL_QUERY_CAPABILITIES, .reg = 0,
+             .bits = HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY}
+        },
+        .dependencies = BIT(HYPERV_FEAT_EXT_CALLS)
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
@@ -1378,6 +1386,11 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
             continue;
         }
 
+        if (func == HV_EXT_CALL_QUERY_CAPABILITIES) {
+            /* These do not correspond to host CPUID feature bits. */
+            return true;
+        }
+
         if ((hv_cpuid_get_host(cs, func, reg) & bits) != bits) {
             return false;
         }
@@ -1819,6 +1832,10 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         hyperv_x86_set_vmbus_recommended_features_enabled();
     }
 
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+        hyperv_boot_zeroed_setup();
+    }
+
     return 0;
 }
 
-- 
2.47.3


