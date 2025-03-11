Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA47C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2lY-0005Ji-Ro; Tue, 11 Mar 2025 12:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5165902861=chris.friesen@windriver.com>)
 id 1ts2lN-0005Dy-DZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:47:30 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5165902861=chris.friesen@windriver.com>)
 id 1ts2lH-0005af-65
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:47:29 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B5dJ6b017999
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 09:47:16 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458j27bgs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 09:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8/eHFLV5D2sf0W8tjoj/GhdcNVgOZ6e3w48ru+DU6uHytWyXUV0H/bv6+ptC77uMZvKD1RN/ON1m/9s4lH7R0lSrFuE6nUCtrmGRM7NvinGNnO2s5vKYwgJA5nbtaejlQkUMh4FTMyQh+70K2vutwIuT8UwbIIQSBj7xEDmsu0r+Slpsx5/VBHu5Gb8BTyN2vXhnM7FqmKm8BDmAPcNAgGWIiOw+8SWjAmEiF2FYvHvcSKBBK/yWpIx+tEe6INQadkbjqUlNtnpg4ycSNL8myjuHHAUh+SoYAYfFG4bTGfvmZ7LQv+mga0YgdIYrzvjIr+bGyo4zExwNSOYOKAYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r80KqSS4IfdMEEf72sXVyJgnY0eU26foltWu+KZnKV8=;
 b=dPZ7x9l+/K6459phz7qjq65/iB8BG+mXSI3hCAaxzu0C0DSOYk+EqRsyZT6Ohr0ym+eLaswkAzVamDVxD4IEhSqOa+cYkln2HaQu6Mf6TJvkxV8TVPHW2jWXaLOdjRMNLeuZ+rnv1v+5G8xKIRNdLAIUtpbAbcwbkwzXlz4vdFGpAYiYedF9Z14eACfGwt4xKCiMC4+wZpIoGUIPMl9wuAxg40HCeLhpIQiYCDtMgtKyP0U8d3CITAEReAHHXT17Z1+/ZA0ivHl/pMnvy+AAVfqvZ5xpc3jrb/o5ftmKTsBzv1Y4fAYD6uHJcsX0oW2UBRms4+4LEoiGZ4ruJiJ2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:47:12 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:47:11 +0000
Message-ID: <56d3a918-1768-472d-a0d7-576e4718f33c@windriver.com>
Date: Tue, 11 Mar 2025 10:47:09 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Subject: Sapphire Rapids missing from "Preferred CPU models for Intel x86
 hosts" ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40)
 To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: aeda470e-f7c2-495a-3657-08dd60bc5ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1dMLzA3ekI4VHlocndBWGdEazBjZllEaFNGYWFTZXJBMXJIbU4rQnN2Z09L?=
 =?utf-8?B?aVpreTJSMll0RnBHTllNa0xmbmtsN0VibndPN040L0NlelVBejN5Q0RTY2or?=
 =?utf-8?B?N1htMy9HNG9HMGs2dGM0ODBwR0lDQUJEZWNkWitxSGt3dTh1UDFENDA1ME9V?=
 =?utf-8?B?TWIrQVM5OU5mNGpBNkRiOStGVGliYkV5WFJ1ajdZaWZJbXNsbURQMFViTCtD?=
 =?utf-8?B?eFFlcTZidnlyTGc5UkZBMWFBeGdUYlI1WmdVY042aUlXZ0tpa2RsL3U1T3Ur?=
 =?utf-8?B?VmtUVDV1c3dHckNFblNlYzdjT3JvbG90M2ZIQ2k1R1diWnVYSUZneGdpdmQ4?=
 =?utf-8?B?K0JDdTluMWJ4MEcyajYyMGNCajdvUmx5R3NCckNWQ0RLN3JFcmFuRlc0QVFm?=
 =?utf-8?B?SHdJbWJFQzJDOGd0ODJQWEt1RDgzd3JBQXZ0eWVVTU8rSlN1WUs2dHhQdGlv?=
 =?utf-8?B?OC9KWG84MEJFOFUxYTdBdDl1S2hhVWlCZFE0T1dSSWxEU3VuT3YwWnorNlBJ?=
 =?utf-8?B?TzlDZ2FPSEVjeWZVaWhpdXRuNlRvY2poR0crNFVRckoyZDN5TU42aFM3WmNt?=
 =?utf-8?B?TWw4clZvdDg1ekZCZm9KTnEydDVUYXBsUElGUWw5bmtZNlovWk9adjVGdmlG?=
 =?utf-8?B?OCtQcDd2SktSSWRPQjJzWXcyRWJ6UGxnQ3VScDZHT3VvYWRMY0ZwWFFxbUVi?=
 =?utf-8?B?RVFBNHBhM0NjRnhTSjc0ZDY2Z3FOWW5GYTVYeGVYKzlyQkNTODJnYWRFa1Z0?=
 =?utf-8?B?SURxVHlNczJpbzN1UmdKZVlMLzJOb0FtREl0Q29mK0xYS2svanJwZmlHQS9r?=
 =?utf-8?B?ak9Bc1VjbDZhVEg1SE51SzBnT1RPekZMSGtUS01Nd21LdmtMZTFyUkhERDlF?=
 =?utf-8?B?cHNaSk1GU3J3MU9sL2NqazIrNXl2L1J4UVdFL1h6VUg2WFNha2FlMnJuWlFQ?=
 =?utf-8?B?dDhiTG40R0dnNjVoMFhSb2EwRVBDQisyNGtseUhJblRrck9mN292c3VlbUhj?=
 =?utf-8?B?d1RlQ2RIY3M3MGxaQzRLZWE5Z1hXTTRwdEw2b3JzMkVvNjc4QnV6dnRFcG5Z?=
 =?utf-8?B?NlZObytmdlVCK3V5ckVwQ25xcVV0MWVxL2RRcC9ZRHhLa2VpWTQrQ01qaHd0?=
 =?utf-8?B?UTF2Y0kvYjU1TjcwMTNxa2Zna2tET0FHM0tKSHJUZnZVZlMrMk1hOFZjSTl4?=
 =?utf-8?B?UjRaakNCWUlhSUYyVDdxbExZaUk3UFlKTWpPS3NFa2NhdWhxTHcwVUcxYUpv?=
 =?utf-8?B?SWZjQ1JSbW9lcGdLUmo3RlQvczZ1aHVZMTROQTE1WXh3WkxjU3VSdGxURDJX?=
 =?utf-8?B?S0l0OTIwWDl1ZVNDNUdEVlFIUGk4STZsazQyaUlDR3gyTEpXeXJ5ZlNFVXlm?=
 =?utf-8?B?bVE0ZDBLZFNSbnJtMWJSZ1NScWhTVDFybDdtT05JbUk4L0JOVUNWMTdmQ25V?=
 =?utf-8?B?SWZiZmpZUElDUkNUSXE4M0dyV0FqMmVxWTV6K2EySHRSbzZ3dGpaVHdSRjR3?=
 =?utf-8?B?Q2tkZHgyalJlZnNwM1B3ZFM1R2NRV29uTk9uVnFZN2U1U0dOQzhTUXJ1TFgr?=
 =?utf-8?B?R2p3a0VRK213cC9PTklsb3JoYzQxWVpGSXhWV3lzRmtiVmJIcThkQWNEeHBL?=
 =?utf-8?B?OGFYSXZKM2x0dmdWbWtCU1pQY3FCNE53S1l3T3VvY0t6cXFjWnIyc3M3SzBi?=
 =?utf-8?B?MUYwUXI0RmlGaFREYzd0OEdodGlVYlBWUnl2TjQxdjYra0VrRklVQWUvUndq?=
 =?utf-8?B?VHJKUlRZeHRnREJDMWFGNC9HeFErQm1aR2pXd2Vsd2UraCtyRUxkeTYxWnly?=
 =?utf-8?B?TnFrdkloUzIyM0plbTJDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB8806.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk8yS3I4UUVPbHFIY2g1MEZXM2JtTjZtNFpEZm16bmsvMTdWQW5RN0p2c1FE?=
 =?utf-8?B?RW5BcHNjVlp6enFsVCtMd1gxdS9BeTNFVFhXSU5sbDU2Njh1V2JRQzV3S3JW?=
 =?utf-8?B?c1NWY2ZsQnY4MkM3MlhQQkpQSmFiL0lOQ3lmN3AyOWhCN3J1UXFrWnBpQ2wx?=
 =?utf-8?B?Y0kvOTRPSVlnVTN0SWpsTlI5ZzFqQ3h3TE1SWFJCc2ZFN1c5S3lRekMxNWlD?=
 =?utf-8?B?ajNPWHgvS2Z1SlRXUGhoNCs1Y0lFUVM3aS82UWpURTExS1h0WjNCS3hHVUhS?=
 =?utf-8?B?UUI4R0NQY0MzTnNHOGRPNVlTNjkvbVAyYVVrdHgyWHlua0Z4VjlXSGFDdjRi?=
 =?utf-8?B?VWR6WERzbWUraTErVHRDSVoweUtQTjdtTUh6OW5rNHpnVWl0Nk9POXFwcWtQ?=
 =?utf-8?B?VW05d3c4U1NmajQ2cUIyMHlLTFNBZlpzYVAyV1I5L1pQZytreHgrWUFQR1gy?=
 =?utf-8?B?RXZXbi84TExBWHZpSDdyTU1tZm5qem5uZVB2SHVwVUVPalI4aU9oaTM1NktK?=
 =?utf-8?B?TTh6QmZmSWNVMFlNYUQ4VVNCbUdVOW41dFJuVmt2bEJ5TFFhRXF6cEkrOEdj?=
 =?utf-8?B?azFGb2F3VHROSlRvNWJHdC9idTZ5OEpRdkVxaHJOcTZPYTNKOWhxZ0FIbGR6?=
 =?utf-8?B?b2g0b2NvdzEvRHlGaXZGeHh2RzQ2OTNDZVlMSFBldWtGWTNYb1p5V3M2QmJl?=
 =?utf-8?B?Z3NKelNSVk9vZ0pHcG1HV1VXVDBuSzh2cGdUM3RNR3NObWt1ajIrcnQ4Qmtq?=
 =?utf-8?B?SHFLT3oyWndqK1dTeVIyQkxzQk5HclovOXVyUU5mWHhaMVZXbE9Sd0FLQXZZ?=
 =?utf-8?B?YmVLTXIweW8xOS9leUpvSVN5S2tiR2dlYXJva2E1djFxRVovUmpsV3ZtMld5?=
 =?utf-8?B?bjJoK3VubUhldkFvUWN6ZnlnbDkvTW1qN215dHFENi84ZzF3T0NMNy91NHE2?=
 =?utf-8?B?RktLOWJkcmo1YlJRS05MUUwwbnNsZk01c3FhZ0VQLytEdmVmRTZ0c3BpSHN1?=
 =?utf-8?B?R1dPNFJKNkZHWkpoankzU3cyVlhGMklPM2EwYk12bWJWb3hRemxrWlgvdDE1?=
 =?utf-8?B?bjRSbE5ac3dtRVhCK3M4NW42bFBKOUxDeHB3UDlZc3U3c2JqOWRkM3RoeEVC?=
 =?utf-8?B?SEFUaThvRmhNQmVvQ01VN3B0SGdrRFFXaFo2UHhwU2VwcmJHUktLeGpzRlVN?=
 =?utf-8?B?WFltOTNpcjRmWFRMUjNaamxydXlCMmFMOGZYcTEzTFJrRjVQQUdkWUovUTRm?=
 =?utf-8?B?alk3MjB1WTBIN3EwRmpqVi9jUFZPc25HaC9Qb3dhMUUwNXdaWTA0WXNMOVB2?=
 =?utf-8?B?WjRSUVFrelh4MzRtRDdiQVZ5RnFhekVoSi9XenF6eEZBcDhlSXdrVDJWb3Nn?=
 =?utf-8?B?ZjhWM3hIZW1FMnNjemZ6Ny82L1gyVkNkbmNJUVRtTjhTMXBYdXplUHIydzZ5?=
 =?utf-8?B?and0cis5NmwzSmQ2aVBqejN1eHZCb1dDU0VaRm44TDJtNDlYNEM5RCtXZFRZ?=
 =?utf-8?B?QTRVbVZWSEFnaWsxZjlqa3VZWHg1WkVZZGlnVEVqb2hhaDhvZVl6TUhsbUxK?=
 =?utf-8?B?TzVKSjlGVXJwckRyeE0zVytXc25abmYvK01YQ21qVUFpWmN5QkpmR0NOWVpX?=
 =?utf-8?B?cmRCWkh1d3dUcGJ5QXhSV3JCdjB1cUdHd25VN1A0eUI4dDQxc2VOQXI4dHlH?=
 =?utf-8?B?VGMya1hncjYzNVM2RjdZTmQ2ZXg4TzhNZVlRV01FaDZ1K1NyeDA2MFBNaUtE?=
 =?utf-8?B?QlR3ZDR2YkpMSFRhRDVKWFdzYUkycTNzTkVDV3NrOS8rZ21jem93MENBUUtJ?=
 =?utf-8?B?MDFaMDJqMU14WjBUekljSDZkRWxoVUVlY0tIaFI3NjRmTURkejF4czdrdUdT?=
 =?utf-8?B?RXYzRjgwUSsreXliWlJYQTVtKzc4MGxKTFozdHJtQVNJNGlSaXdXNzF4VnVl?=
 =?utf-8?B?NUszeGlabHQyM0M1VlRGc2d4MlpKaFFiSDJpRmQxQzgzZmtBWWFsaURhMTdM?=
 =?utf-8?B?cG14ajJVRGU1NDdOLzR0WXB5VlhsbzhtQzNBbllYRDJxRG03WkhwTTEzd1Za?=
 =?utf-8?B?MG1idnB0ckduNmpoeFg0MVd0V3hqREQwNnJSdy9tenRRNUtMQUZET1MyZFE1?=
 =?utf-8?B?S0xseStvMGYxdG02cTN5bmRtbis4ZHgrYnp6OGpHV2pES1pmekllOG9mQTNu?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeda470e-f7c2-495a-3657-08dd60bc5ea2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:47:11.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo0DYXWDSd9Cqbo+jWLTxjIsM8Fysk0jaCv0A7TJSb6fCn4ukycaEyhOengLXL7XjB/yey9XEIlkcvixl5HxA/dqrmFr9BsmiXSuhCQSCHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-Proofpoint-ORIG-GUID: 5tzNF82wNsN-1D6b9ezBNtD9_a5ERTcs
X-Authority-Analysis: v=2.4 cv=WNuFXmsR c=1 sm=1 tr=0 ts=67d06914 cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=NLiCwHATAAAA:8 a=y1PfYWXgbiHTJFzwTkEA:9 a=QEXdDO2ut3YA:10
 a=Su0QMmwSe1oA:10 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-GUID: 5tzNF82wNsN-1D6b9ezBNtD9_a5ERTcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=897 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503110106
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=5165902861=chris.friesen@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Chris Friesen <chris.friesen@windriver.com>
From:  Chris Friesen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I was looking at the website and noticed that the various Sapphire 
Rapids variants were missing from the list of "Preferred CPU models for 
Intel x86 hosts" located at

https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#preferred-cpu-models-for-intel-x86-hosts

Is this intentional, or an oversight?

Thanks,
Chris

