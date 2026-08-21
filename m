Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0C1C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFO-00075G-U2; Fri, 21 Aug 2026 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEz-0006sD-S8; Fri, 21 Aug 2026 07:16:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEx-0002Is-Lu; Fri, 21 Aug 2026 07:16:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MW76237449; Fri, 21 Aug 2026 04:16:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NlCveF2m/FJlryjjmXRcp0ZSxx0Y4xTALGY9umckW
 II=; b=JP6JAEm3/VP/2AK8c1z7UlPT5bidfQSMoGCduhxy5GHObmBJg0hyfQ44/
 pRYLdyqXBpmanYBatstBiRqLUfAnm1fh4m1S6ddcPBtLzfYjQVMTa6FzlYnfWZ+x
 DC7WJLvLoBwG3Kgxw3W417rnMSN/Y70W+VcIuW37dKtn3Unl/EBTB+H/O6sOR4IE
 4eaOgkJ4soRfRCwYgvPyTLkomN/HMeGT78ckBJf3LlmDd8BPh3jqurIiq9vY8rlP
 wgYT+q1B79D43Ssu71fpTCOmfQPtR9CMUI0wPO+RJhVxVGUfSw9zQFO6kTDaSTks
 NN9gRpmKBJpcFZWRzFrrJHxImt0Yw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022083.outbound.protection.outlook.com [52.101.48.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g658ua1a7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk8URYNX1mXD9iaYmw6ZGVsmYGz7aC/7fLsAL/GQagDdI9hYYwoh8vQn/tIhCbBma4Qk5yUlAUEFAsGZ3xEv/R7l7r4SZChnjLWTWsARHTmAG5jozy1KooZwlSlguvGkqzrl05pMu6p5eAxmlb8cRFVyF50SxoiN3veDU7elO9YPvFszoJZcnjLPwfWcYVy3KjI9g9HK2gCFW1wWy53G7tFJXEmPCu6om7Y2byQjwtgDbL45T+ot+YxoBD+Kg1Nh11SqWWMI+VjwruTGFGE/+2v307K8nsVMidRisY4/7PfNCizeVzKj6x+ddL3DSPd29ZouO99ICj6R6yimOIgn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlCveF2m/FJlryjjmXRcp0ZSxx0Y4xTALGY9umckWII=;
 b=d9AmpZPGf1LLP08lNf5lSUMSwvv6YTfti8Sp0CSTq+wQ36nUTZisWQx+kXKd7MIJd9n66r7gAW3iu0n8kfYYI6M8IdlrCwgzDGbLl9YdbqsJrN8p+yJF2yc/XMmNItBbMZfUuyGl9AHaSMTmYehZj839p6nrFCA/iYHNOLsFNRJKM0Xk7NO2WK3lhMj8gHl/iqyFQeqyxjOc2qcinM6EOaf1ii4OdfdWJxCf3vkW/O8WWoEOpWQ5MFkzwq06brJo4vLLu5j4VBPH/5QvDNvseyzdZtwQLvI3g6tjMFmm/gnR35za6rJeoBdGqspsnFZVOy2TZzwDxJR8BRvq44kW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlCveF2m/FJlryjjmXRcp0ZSxx0Y4xTALGY9umckWII=;
 b=mpFFCmRK33q6H/u8/fmU3zkoQA3aQmdrdIK3myEvwS6wThCwWNYFObnVG79lUFZb0u0gp6CbfLMB1ZMmfBeqTruw7/obDsPq88RjwNnoi9BdpZPGCRuaIzrnlI7YuBNSUDgzSkqK8ELpUp3N5aUei+p5zTUyyDOqTPCoT1nOVNZFehP6pZU5IMrlb2zGEWwQOifhwvCGWfgSDUieJVuHlmfvpqsZMuDsn7LneuNQ4NbB/AT75c8q4Am6qdZoVSHx6tdqJpHs1P//xhYiaJblqYwlp4UvV6pZByrnIy8+IWOmkmRmM31h3f2kyZoL4f+jn5NEa9yrNOh8f5P+n7RuHw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 12/16] qom/object.c: add
 object_class_property_add_uint16_ptr()
Date: Fri, 21 Aug 2026 12:14:24 +0100
Message-ID: <20260821111550.276011-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df4290e-9be8-46f7-ceb7-08deff75ab80
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: bP3rN0yQYHT6tyGrZOGnQg+d7NoDw2v30mYE6dqsQB4UOt+gYjJJBoNF8L9Syfbbc8qfQVvOnXSHV7ja30VZI1d1OpYyou+9QS+1/eXG7xQ8vlr+aoI9JKee0ghoMPC5yGFYngkXMeFeLY8RrzPBDjeCPkrBBUgOQ2hqYr1nmUCLTQWsYb6cv+7ys7ck9pTQIv+rlwdr0JtzQnRTrVUFwBIW0PjJGtYME/5it3n/RkEV6aJHicDmYLL0wegNMYrer8fusXaLKAhtW5I79PJn8CpvKYonl0uX4qDA6+U/oKB4VQ5U55Em8r/5c6c5y98+p9/lQdp0Z1WWXTrpuy1nRcHb+oY+uBtYt4zsw+Rreb9AoCC96nbwCI3du2d+S27H6xlDeLG/hj31YU8VCzigYGO1R8Sbd+Sa9QJrcqQl4qPfDs8HTXG91b6Tibipb7T1AWjCKVqFRhIjHVTNxpkzcq/ShR20X6PLwQ+gAGchoSkM/1ZPxmg2DrNOyM4ORTgwlZ6fpvTwIXZBvQCcJI//RXCVj+UO7LtlnHhyzBpiGC/2GyqxeFakS5hQkZyCD7a5pApB31MPbva3qcuWBPoyPH9SQhzHO9fQkP2WIPZZdgLJefeqYtSUd1bXX+FgwvU7sY46gvhkGv7ZDo8NABL84zZ6O9rkTwBfPMe4uwW2gcwiV6B0ppeU4cbfNslwola0N6bbJ5Pd9wTEk5hIKzgZ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xsSjdPbG5nZ1d0VysxblJuQ0dqSU13SWdYRDk2cVM2U2NSWkJrbEQxSnlx?=
 =?utf-8?B?VXVQMTlSbVpCRjREN1VkVkU2RWthcXpsWjhVaTc1WTZzN0hoVml6WGRjVjlm?=
 =?utf-8?B?cENhOTIyWEp5V0ZHeDFmTDFwNUttMVhuNkt3VVJlc0pzczI5N3pXbG9rTER2?=
 =?utf-8?B?Y0U5b01PcXhGYXZObFl0UnVRTVc4bkIwYTRqdWlvSnhVUnRzL2ZxeGRzN1Qx?=
 =?utf-8?B?ajRmbk1LU05KWTBXaUNOblFMVldCanVtQ0lLRW1HWjFNbCt3QUFCYkE3UHlQ?=
 =?utf-8?B?RHN3RlA2bEV1L0Q5eXA3NmpqSHhXNEl4Tlh4akVMYVM1SHRKREFvY2lYS0Fj?=
 =?utf-8?B?cGxGTUdINUc2eTJvemYvSjRhbktpeGovSXRkUHQ3aDIxL0lMaHdvNExhQ1g5?=
 =?utf-8?B?TGtmZEp1YmxrNy9UaThEcjZsMEhkaHk0eXlsUloxRmdLZXBGbmlkQUNIZXZR?=
 =?utf-8?B?YW5SaVoxc0tnVS84Tmt4SDFRQ3dUenUyMDFsT2c4WUJjR2NHME9OSC9WWEd6?=
 =?utf-8?B?NllMM012dHBNbG5ieDhvYkwxKzNvTXlCcWdEeFZEaDNTbnJBMzc4VUhNRi90?=
 =?utf-8?B?YmNxTWNENzRETWx2aUkwUDBzQUFEaTM1OWhmOGpHbHB1RHNEM29CYW1IVFlH?=
 =?utf-8?B?NUI1R3A4dVpwZzZadm5RdXVlVHlBd1VHU01CTEZiNDlWVE1PMndLTVBxWXhY?=
 =?utf-8?B?RXNtYXNyVUljYVVpNWxuT2xjQ0YxUU5Lei9nSWMrQjBQdWpUSWs5aDVxbmYz?=
 =?utf-8?B?UnR1RUFxeG1QbEhYM2dhUTVwU0ZZZGhZUG9TT3JWaS9IOGhqWDAwRXFBNUtz?=
 =?utf-8?B?TExDdWZQaGk3aUs3RC9pZXRQSUI1Q0FjM1dMcTN5LzVMSUwwbUlBS3R4RVRP?=
 =?utf-8?B?dHZBNVdpWXN0anE3UFFRRkFRREdaN28yTWZseC9kNjYrcmVoM3dJV2N4WFBu?=
 =?utf-8?B?Rkx1ZHMxSmFrVmE4ZkpEMkMzUVVoNCtYK3czS1pqQnVKRXlYQlN5WGpkNDRM?=
 =?utf-8?B?eTZkVkVpcy91ejh3Y3QwWWhqSFRjTThBdkdyRjhTNWhPT2Nmb3pIM0c5cHpw?=
 =?utf-8?B?SkFIVEdvSFpGaW1KN3hrUll2a1pjU1FwaWI3d2srNmo2d2ZybXF2akxvVG9y?=
 =?utf-8?B?OWJOQUhuYjFva2Z6b0owV29SQnRFeWtwODc4V1NkeWVwZVUwVkZEVFNDTFN3?=
 =?utf-8?B?ZVF3T1RReDE2Qzl4WWgra1UxcHZLVW5pUXA5UkdHSnB1eGUzemdJbTZXVytS?=
 =?utf-8?B?elBiN2F1UDRRSnl4NzdkMlpPSjhzVFdZbXN5aFIwdEJycjJCdEJZTGdyZW40?=
 =?utf-8?B?UThrOGd1TmJwaWxLZlRyUDlsU3RQa0FRdlJZYktqZzljS1U3VWZDRWdNS25m?=
 =?utf-8?B?UDZtTFBmSUpJRXlWZjUrVzAzVS9jT1dwVmR4RXMxb3dmWVVyY0xSTk93eEpS?=
 =?utf-8?B?amtHcHZTQ3JwUjBGRzM4Q3M0YVdBNDhwM1NMVjZTd1dIbUU4OFhWOTlJQlVT?=
 =?utf-8?B?b0d1d2RXNTZwZlhUZmNsa2V3ejI2SGcyUHdhRzdSM0RBS1QzeU5NVm10TFN1?=
 =?utf-8?B?cmhCQ1hsdHlMV2RjakY1ckYyVi9SR1dIYml6VGZDUTA1bVZOV1BnTkxOZ2c0?=
 =?utf-8?B?anpOTUI0SGMrSGJWeUFZb1AzdVhVaFhzQ2ZadWppdEwzRlYrQmRLandYK0RZ?=
 =?utf-8?B?UHZsUFZmUmRzWmNTVTU1VFhzQVlobjF1bEdDNUxUbC9IaGFYUmk1UVNKbzRy?=
 =?utf-8?B?c2VTLytDM1dxSEJQdlFaN3lyNDl3TTJmTHBRTU50K2t2NnJHMXR4N1gxNTNo?=
 =?utf-8?B?SG9MTGJkWHh4aEhaZy8yeDcyaDRJdExaRTJoTW1hSHBJaDJPK3kzWGVlOUdq?=
 =?utf-8?B?VUNIK01mOUhXN2Z6bEFGRFMwOW4zc3dXcGpFNi91d0FzQ3hlV09sVWJyL3Fq?=
 =?utf-8?B?bnVIL2VoQXA5elhPWUNOY1BML1czeUY0Zkh5ZlNqVjd4cHJCUllzQkNITisy?=
 =?utf-8?B?eDc3emFTZTVPbzBkMzlLd01UaUhOZmVjUTlLVjFwUVlpRGRWWFJuQnlkWHJF?=
 =?utf-8?B?SUFvdElyejFqWEFyVEtobmYzZmxBOXhtbEVCK2FDZ05HcWJOMnlQQU0xMkVh?=
 =?utf-8?B?WnRmZ0tmRlVBM3ZoRnVwMVgvOCtFRnBjYkJjU2RHTVRIVU5nbHYzSDU4NjB4?=
 =?utf-8?B?QnRrb3ZKZnRadUMvUWVqQ3pFQXJhWHVSVzN3MzN6R0gwbndTVlVhL0VrWU03?=
 =?utf-8?B?SHVsSWhTQ2M0c1NaaDJ0QUtkaUpSMVp4bUxmTEFFdmx3dkZ4NUNCZXR1aWtL?=
 =?utf-8?B?NTZIM3E5NzFzS2lRMzkzMVNtZE9XemcyL2JzYjM2ekxOWnR3RnlQSW9XS2NR?=
 =?utf-8?Q?56zIhkrldSR11e+w=3D?=
X-Exchange-RoutingPolicyChecked: tQsqaBDtwNf0poeAENJwvJa4E22wxaYltE1L3S0tA970Hfq+Bw3IhQgfPAT+FXoBFlvzE635hc7vx66gGC0urnyLnaKq7h3QwzpxFZ2kQLfyjsywRRyi6tBc4fkxOxhHGqZepaz5z54+SvcAhhqcsfGrCKQ4yD/6ethFgpXV4iMoIrgOfMGTJvrhzizkSmS5L/ZYHPceq1lXWGf2W6pTOQAv+bXop1/h8L8899UgS3KhdQb3pqoC8KOP/ZytChIL2zLydjJIik9RXl+GzP5ogflUTSStoYMdc3i9qJi7JAo/A5Y5c7LkA5QflwYapPx2kwoCPf+3liZPyJO3vbI8mA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df4290e-9be8-46f7-ceb7-08deff75ab80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:38.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78YW42PsimTD3qbybFm7LDWorQVXGwwVyHW3UsktQSXS7I1vaM2h43YWCNB8wSN2sQzq1mqRsgwEfv/qJ1/epg6jFuB8ZBTo92ghIIcMJLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-ORIG-GUID: FRMHMlXasbklaYe98U8AWQBdfrSmjOes
X-Authority-Analysis: v=2.4 cv=GeMnWwXL c=1 sm=1 tr=0 ts=6a88339a cx=c_pps
 a=80uo2vwcsYp3yIYYF8sMvw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FRMHMlXasbklaYe98U8AWQBdfrSmjOes
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX4+d+GbYcfXgS
 IRjxkfMnDZxSqgJrqCErrwUNhGmSmnM5x7AiETcngwfBXBmnwhS6j9tKEK/6CC93wyRN0myflb3
 c60eeihfsMG8UbJXvyXq19KgDFOzIMI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX9TO/kQ268nPk
 YPa2AMgJ/w+FSrez095W3rhe868oRe/t09nZMMssvyW2XBcQ6CGpqVorZa4RXBQcT5YX+c9lycR
 ln2IoRe83WyTNRX+XSc25Faj45VHdLe6TX/UbNJLfruDx0wu1YeR+zXhqIzWH92dXWHXbAMSj8e
 G7KBhKS6Oq9GkLiWlJLP6SLZJnjHgCqSLmRY486dGLSFEOcqPE4uyo62s/Zbn6Is6ykIUzGCJpR
 Y4ZYcJ9C8HMroyj4P7MLf7duEpFXK6TsYx2X4FhIWNykb5uYtokfu/WQvH/3x8a9W/qW0o1yJon
 mjvJasvwt0kHbkSbuqI2szM0s6ZBK34RVhUpsef1kvEpjunLQcOP2VL8Wi6aOaaB4pbDH2BMcgp
 ptX9hgtcYLqVdmdZNwWFfk7DXXP+4VxzI1ONmwMSZV40vvmcA7lNY+TlNzzi5OMZM7PmjWFpXph
 uEtmE82uMNvfe4uDRQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This adds a class property that references a uint16_t within the object instance
and is intended to be a replacement for object_property_add_uint16_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index de37016ba8..e24f0a2b2d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2108,6 +2108,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint16 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint16_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 635eeeac77..85bbd7f9fe 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint16)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
@@ -2874,6 +2875,26 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint16_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint16",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


