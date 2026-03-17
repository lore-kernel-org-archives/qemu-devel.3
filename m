Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51082FEDA1E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aUH-00067N-96; Tue, 17 Mar 2026 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU5-0005ss-4Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1w2aU2-00072n-Rg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:53:44 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HH9Eli1688081; Tue, 17 Mar 2026 12:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=7h7vwYbqLxdoH
 61MLRl6DVFDJej7LATpRnGCjKAg2wI=; b=GtPpnXpex5wyVjj12OBp8W1IsJe+N
 WR/mKIkKwyDlNQy7/lFguwzBvRMRMlXrAXn7yOP9V2j79DT1rRzMNmP4YrBjzBHU
 seeYhoL2JiBKVZBvpw82rT39nHomX0TeBAkxx1gRl7WELl7uc0vLWOARwSBrAQ/v
 BBDiVVTIwd0nfUri5fdBD+zHxAt+cOCeoRseCmvo65nDEjL2hwb4RMb7RgPNQCcm
 m0ICLxp28naUbO63DJDxzJjDmgEPCnEIrdIJd9p91R7SbbudqOLxm7melV/0SY+6
 yqwVmtkmgDzJ6yKPw9LRWIkm5mIqOgAicxjOCQA4l1UxDoEbhjEfEm04A==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023100.outbound.protection.outlook.com
 [40.93.201.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4cyb3wgd8a-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 12:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqOvORLt+dHq44MZuLHoQt+NN8DyRg9JXYOw5xs7jpPVFIGwWiB3bObnY7dd39N+vhFte7JR8F2/AvAsblptFLXLN4Q7lvPv3kkzdxxmwmJYamzmNRz02BVSNmJnqs5CDnyxcwMQgifDUpByR9uOmmolp03DAMiwKpB70uNX+PbNfy94y9ps+fRtSxJ4Q0U9N9GrlbTu2tzfwEUDx2Cp2ZosmC09PaEt1M1d/5mOLYHuyh2aKuNU6wluEmYyr05kBRGWzovOEkBa/21OTAReuy7E5XkJ5pUeDRtJv6Jur9dKvG8V+CiutGANb/idy9r1d4+LFcnkS/sZsSOq9saUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h7vwYbqLxdoH61MLRl6DVFDJej7LATpRnGCjKAg2wI=;
 b=iehCYi5PWRUaCXjHO6FdiZ0rb1bO5OPg9ZQpq/wB2zmpfXJHNuLMB/sQkJiyLzwrj7QWpRmme7ZlMmsosaj0DY+W4YldnTZssaToK4iN9U7YUWtTNYsoIwFxKnQ+eFNZVvY9EZuZWatWqMtdTwW8nqHBojjmDf+t4MjnJm0NER0svvZOovisV472LVj+O44QPvqmtnh5aKaQzsj+lemK/JDkIdphhuM9GgSKoMcNTMqlSogCE/Z0UelC0Qaurgi+WOG6pn7RJ8QcO8Xpxtm0S56Q1ljtlBF2XrfODhq3TjVrYSqd9BUY+nRBXPanK02chw26XSsO5BWJ8T7UqH48FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h7vwYbqLxdoH61MLRl6DVFDJej7LATpRnGCjKAg2wI=;
 b=RmrKeUyT2hdFhCPdlD7KUl+FmEez+qTeew+0jJth7VriTskTTg/UV5cG9GK7MTBXwzS1PJzjTXceDJYw8fdtcU3Xrd0kYNbt6LfQI4Yjqbp47ITDK8sdBEJwTW+8ijfEf2H8HKBSyyQOfP8c9PX3pArLLCg8HYBSrUiQSXxTW2R0Jpk24I6fsZV8TqopxcIfLGZbBsoMYzC6EbXiMc5C9JMoz83fm5kBsRKrhoc3+jz8Rmu3/JymRHfFcCaUqSxhT+XoI0zf9zfltoMm614pT+v/t4uWFGhrnRfWUJwHYHmL7uh2kFXxOM+ZfHpFipG05DqVNBUCixc9NVHqkmjABg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM3PR02MB10293.namprd02.prod.outlook.com (2603:10b6:8:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 19:53:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:53:31 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 0/2] vfio: Implement device features for vfio-user
Date: Tue, 17 Mar 2026 19:53:21 +0000
Message-ID: <20260317195323.776669-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM3PR02MB10293:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe3c8d3-bbf6-4334-f9bb-08de845edd70
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: B+ECcae4qg4a2wO4jJnjTangr8PkNyIKFM7b2WY/3xpR9rTjhR3WnhzuaC5ysYRluW1kKmByyEbO44+DfEdpUI/rOpH5llywnDYUvOsigp+dIthdJ/DbyFRZv5JkiS82K+BdBncMAnvZGsHlwEVh/X2HpGAZ75qdDFn7ocJsv/yj/Abe0tqfADTTDYjG8s3MCPR7FaTkSJDdMbynA5Yz2VkxgfWIBXEEJMcX5SG/phIjQqs0qgjIiW0qG3eIq1XgiMITdW+0JQWfQKYmwG1n6jPSUJ2pQhkpGVmzJQUwnBLWjCRButHKtH9wrzhQskE7Cd5oG5a1j5L8Rko6mNQfcuMx3opB2Ymudk8SvqnMl+Buog4Q7U+QeJslUCCKzhhFuBYcUWLAuvJxqUFasgdzPX3ibyiGA+tbCqT3d5b/21fDL9fxTZhw/zysX0yZocEfYRjAITqgjEr1Cw3ggvwQ56egpk8WdZDvEd8V32e24oZH9zx3bPMVQj4LLACkkjJ/7v3WkXsD085dfa7kngM0uTViFj3KPRKKF8IRi3loSs1mEYa9luVbEPSjnK7GTWo0/J7G83dwxyIzP3tW1oJ4mK83Eg2XOr2hoZ/AzLE+rRdXai078PG8GXOvEjl5EBMTSvy8CXTHdS5N+cmt9k0eUKzj3iZbh8uLgJpyWW5kS/BWU5TTSfBqOceR6AWCWjdvtBVmIvX5u7sueehkttuQvfO0XakGPqeN0pXfEP28AVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdwWVlsQ3lBbThaQU5QS29CZEFueVBBZDQ5cVEvcDFxRmVnMzVwaDdOM29U?=
 =?utf-8?B?YWNHdjgwM3BCcDQxdjdjZmxEaUorNG1oMVNZWFdvYmNDWXg2UTdsZFhBUVp3?=
 =?utf-8?B?MHlMeDZ1QWV1WklWR05LZnRmb2hQT1VBK0FzSWc0cHdYR2tmczdzeFljMWFH?=
 =?utf-8?B?bmtFeEJtbWpmalBmSEV6Z3BodzBBRzRGK0EvNko3bGxLMWRoMmw5eVVrblR1?=
 =?utf-8?B?V3l3NzlpYlIvL0did3NUcENtbUQ0dTdSaHVHaHZvTWpZbW9QQ1J6cGtUaTk5?=
 =?utf-8?B?NVZ6RExIWE50OEZSbEpqd3BQcGU1SFNCeWxGUlpETGowRlNBcjBWeDE5aXFQ?=
 =?utf-8?B?cVZNMTYxVWxBMDE4VDdNeGVBeHVKYXpZMGNDOTB1SUwvaDNydW5FMFNuc3Rk?=
 =?utf-8?B?VUhlN1hRajZWdkFITnZtWmt1RlRYaTZkY05rNzB2bDExNWpnTTdQMklLZEdx?=
 =?utf-8?B?OUl0ZlZvcEtwNVRsZTZrdWM0dU92T3BLUUlDcHJSQS84cXR2bUlLN1h4UEJT?=
 =?utf-8?B?NGZMUHgxMEJTTE0yc0I1TitSc3VnUkFTR1JoQ2piYjBRRC9NS0E4eWh1WEpV?=
 =?utf-8?B?MUd4UzNaYTVBd3h2V3NUdTlPVXNNTXFoOEYycGo0RGw4THJSVFhBREFlQk5H?=
 =?utf-8?B?b2VacG1sL3ptSFB1eHkvL3hKODJyZ2NjV0JJVXZnejhWMkhsZFpmTGtvTkRS?=
 =?utf-8?B?K0F5SWc2am9vWFcvNnQ4bkRmVHN6ZitPL0dXUXpNUTZuSUluTUN4NWIxOVZL?=
 =?utf-8?B?dzNGZWIrRnVoN1RQeTdVSEtXeHVmSUtiZ2ZQdG9VY1pEc1RqbFJ1djJtWkdR?=
 =?utf-8?B?VEczb0plSmkwSklObzlIY0tCNW45ek1oL1ZmSDFMNXFmbkExZGJIL3c2MGlt?=
 =?utf-8?B?MjFJS1B6MlJHR2k3ek9CU0JGRi9LTjR3NUlsYURienIwdHZ2NnEvV0dYNDdK?=
 =?utf-8?B?SWJJRWNqbG91a2Mzc051WFNnMjJIdEVMMSsxUzhZMFZoYUxEZ3dxRlF3eTFS?=
 =?utf-8?B?ZTRjNzJLcEZ4MlNiaFBvT0ZNOEdrK0xVMllGcGJTbVl1U0NDM1dvcHF4MlJD?=
 =?utf-8?B?cklxMlMwSm9hV2EyYlFmc2lmdERXZTcyV3h1VmFVeTJoZ2pZc21rTHVCQkV4?=
 =?utf-8?B?NDd0c2tyQUV5ZXppMzNCWlFSbFdWbG5KVE82U09zQmhiejA1MDBES0FNSUl2?=
 =?utf-8?B?aXlkdCtiSWpJZ2wxckJkenpwOFdvN3NvODAvTW8rZWVoMU5CelZORWlUWFJZ?=
 =?utf-8?B?ZXAvOERqcklOMlV4T0UrbWs3TkpMZ3ZBWGxhbGh4SlFwb05iSG4vKzc5Z0Rk?=
 =?utf-8?B?OVhWS0ZlWkNNZ0oyeEF2YSt3OW5xYzhRQVNCODdwNlkxYkZDeGt5TCt6YTZh?=
 =?utf-8?B?dmxNSzgvQnc4MnpwRG96TWJYWWhjeUxRdk1BQUFLblZ1d3JNcUdrSDJoWEFK?=
 =?utf-8?B?L05xTWVzRmZKSzdCQVJYWmI3bHN4M2FIYWxEYVl2OXRVMk84QnU5S0k0U0VP?=
 =?utf-8?B?bXdHeStXY1V4SERJSFJLcmxaMmtOSEFHQ2xaUGw2bW5LQU1ySkwwRU5LUFZ6?=
 =?utf-8?B?ZVQ3cUR5a2dYbExlMEZIai9aT05uMURXaVJzYTBqSmR0cys5a2FrL2U0Zi9E?=
 =?utf-8?B?amZaYmdXN3JtcVNUSjRNby8wczQveEEvS0lvUVhoMmI5SXV0WkVmQm1ZbFBG?=
 =?utf-8?B?MkZLOXhRTUxaS0pCTFNyU1J2QmxkNmF2RGVIN3RVclByZGlBQTExRnFFdTMr?=
 =?utf-8?B?ODNSTVdtUnV4SjIvS0lrQ3E5UDdBN2xIR0hHSGo3clN2WEtOYTl3UVUxRGNU?=
 =?utf-8?B?Wm1ybDFHSEh6Rll5cHFXMXlVdkFHdXk5bjBMdVZhYkNxYVZTUjIyOTlNTWlt?=
 =?utf-8?B?R0hWaG9NT2JOamk4LzJWMkttWmI1WWVzLzBkck9iWmxzK1MyRjZjRlprZStZ?=
 =?utf-8?B?VzRyMDd2Yi9BZUdtM0hTdVl5Yjh1VGlwbUdrZXlrS3lFTWJTbTBQMGRqcFpn?=
 =?utf-8?B?UE5nUTJNdWU3aWtrTXJZUElQc043YXpUcThCcmQvYzFobndhVWwrbjRNc1Nq?=
 =?utf-8?B?Z1N2WDJTSEtWRlZoTkRGcWJvMUkrSndqOW40YlJjcnFqY243cGRBUW10bmVm?=
 =?utf-8?B?VVVBeWxoL1dHaGw2SnZpbGxnV29rbGhEc3gxWHVnNXhnZjhOeThGOFBvdlNm?=
 =?utf-8?B?NmEyVnA1blNTblN2VWVFMCtITW1EbVVCZ2FETGM3WlRmTnJJdzMvY3o5b1h2?=
 =?utf-8?B?L1orT3MvR0pjTFdZb1p4SmhaNURUMGxnVDVLWlNwbDdXNlFxM2t1RWJrNWtY?=
 =?utf-8?B?UUFGSzBjcHA4SEN1Sm9vcjUzOWtNQkhnN2V0OENTQVpmMnBXRDVJQT09?=
X-Exchange-RoutingPolicyChecked: pBVKCAItUpRQAygK7F3EhMZ1JdNfhPpZe724i5Gk2g/dCJQiN7ZkuR2cj426/2seDx1lHx6c+33eFErqhH+oEwbMiD5a0HWknHMuVIrl3zFsMW5A+mUpiI8dap6KQBeYY68Q4h46beAG3eWsE6lP4ijoJuTbkkBxi52boibjDcCOAxY2N0+Gly1Q4/Odh/K9ciGpPBRV+wBAwlQujq/i8A6fB3IJ13liWXQ2ljQluYMrhHgJqi9MrAYWb+eJNIsX5DZh97Vlw1MDUvwlyy/pgmuJhWZL4BLN6IncLduH7YAYuybFZrpdXtJwZ646msbgiKeE1+UER3xhiCL6DayRzg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe3c8d3-bbf6-4334-f9bb-08de845edd70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:53:31.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIzE2E0H11gcV6aSi+ayR5XGKOk6+SSivFlAuJ8NCxrNtbyXyxzNj/T6dP6fGz+UgDK9gIAoBbMxQj4a1uaLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10293
X-Authority-Analysis: v=2.4 cv=Wv4m8Nfv c=1 sm=1 tr=0 ts=69b9b143 cx=c_pps
 a=RZStT+UEo2YVQxgsfJfMbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=PNHnPdjPqVtWACtfMg4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WF7PQYFeC-Dp9lrfUecPa9wjqrfMq0J3
X-Proofpoint-GUID: WF7PQYFeC-Dp9lrfUecPa9wjqrfMq0J3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NSBTYWx0ZWRfX1sXO4mz3w0jl
 vYtTLMFGuEenSjkx8mtqXxXK0yZof1cXOivKqxuaCVFXz+BnucGtbpS+e5mq1t2Ai0xuAFAmXC/
 VPtUe+9rvXhEMFveRhQg+ncba84bMDIL2AgY0fWyQGy9NztAXNtdLHyaUPeWDgkZRxV3qzBdDKq
 /IKxnKzzEa3MxlIgb24mht4dpPqI++2oihllc5Svng0YqP8Hp9WtRXtP8sLL/2SmK5kEci45jPC
 eDVD4m1LO0SXLxrpnG81qgIMx771YDgDXkDj11yNFOWNJn+bTcz8uut0pqgAqXab7PRFPsCpOg4
 IYIr51BhsnSoifhfeDoOh/TgpfS4PN07L+2GxHw5v77gEoOlIyuYuIwpZ1Ip1Z81auuaRYnjtbs
 EDZk3v0c9VExaZxtz9d6mCeG0e7Wg5oP1I7DWjYJaqR6V4I2ib46Hq8Z2/ctL0PULd1xmEUpJ0J
 QeOxNKrjoOWkutiiekA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



John Levon (2):
  vfio-user: support VFIO_USER_DEVICE_FEATURE
  vfio: quieten dma-buf warning

 hw/vfio-user/protocol.h | 12 ++++++++++++
 hw/vfio-user/device.c   | 39 +++++++++++++++++++++++++++++++++++++++
 hw/vfio/region.c        |  2 --
 3 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.43.0


