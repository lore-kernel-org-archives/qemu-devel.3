Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D133DC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y74-0004DU-KO; Tue, 22 Sep 2026 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y70-0004Cj-VR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y6z-0004Uw-9l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:34 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03iha2606360
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kKjqv9xCqHhxiBrUsMpx7ac1UTDLcwEKvtdobrWTD
 hs=; b=vEuptpciL9SBdQ+Je5qLGI8V2T84k7z680J97FclaOUsuQHIJy35h/vwF
 MWXrJDpogWAXHN6tMuDFcGG1DS3TFnA8Y4aZ4+lzDSWXG6vLuH1OirlVLVmD+08Z
 E+xHaG+CGtC0juP00LHJJcK73cE0KzHO2Sk7ZgBqA23oqDGxtmWnneL4+feC7f5m
 05IB1W9iPxb3l8XFdCPm4z8rF8Vs4xS36uzCRYbofCqqC/cf6zntca+LWjKWjXP+
 q+k8IvkZTbrKoUnZf811jkH2waEOzy+nZmKn0Yg9n520oKqBBSdi8K7tM6n1JzXa
 vcvsg94l4LmQPf6lhzueiutpruXcg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021087.outbound.protection.outlook.com [52.101.57.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gspa76eb5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJTaP8C5Eh2N6sTBiH+7VED0jAcyT7IBWK7lyHNl0OH0cX3qAb8B/gihA6Df8PRXgyUmIG6Wm0AD/cp+Bn3Fv+DJVemOyt85PfxtoIgh00RwfVRFRL8sRLTRY+9fbgsd3/hFOjJqremrSrQAa2UAWXBWKaOIkCTmBZP90JhPH4gW7qoUXi2V+xmfXLxd/QvthOP5l30zUbdDSH2Rzb0wcyGSbohUCM4YazTvHk6o0BncWialOHMQZ0GFqsIg02rIHsgX8VsTOlqmZfBswwwwHee2qFRF2ml8K3cZleEA371PGgT3HHH913vPd7wbK6IwIaph/AJFCb0WKidob5Vhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKjqv9xCqHhxiBrUsMpx7ac1UTDLcwEKvtdobrWTDhs=;
 b=EuWbG4hqhZ36stD0TwWvGmwHlz2gUMP/YiEPcHemUoa7KPvMVi5uhHpnrnCMoMl080V98TJJ6+l1GczJNfWMyM8eVGflUOSq1uiAV4EtfWrtnKtG8GTgIUDyytPhh/cDG0jywzLXEbSUNlowJLr4jiLFRGLiREas/nibYqCrG4UtFAWars7GRvh50tXgJEMlWMrSIw7HqJgPg+XRnjbQxuvMiLACxcj6ljpfkYezmBnRrVMlruH4WkhyZLLIWJ62uW6op2EZZzxFEkEFYh8PCWZzffOOofQM5e1SfwNkAFdPTBn+EpaRF32Muf6dCUDl+WfXw2l+ohcNsa6c0taQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKjqv9xCqHhxiBrUsMpx7ac1UTDLcwEKvtdobrWTDhs=;
 b=BOY1ACGREUbz3vRqJjYmTsfb5jKgJpNNq8tRwqPVeRyklxjMNcno1wiM7YU8mRDwpyl8tQ3f6y2QsYGIp1AKsZKqCCe4Utce9dlX+djtmthcuj17pXfPox2pO1ggKnEL7dNfppX5jb1eiYeMmTIDBjTh400bA7oxEa5W4Cw3ewwWaxlGC9MvfAS/HlISvPXNp/A+S6mKD5rcEgzNa8TrUP9NGgX6SeWnPMi6UiIG0WzhIRb0X67mzyMUq11PCywNOS4AmpbN4NCA9Xr1YxZgY+8HkUKsMpBJTzqjWpm33d5oeDX+/nJQPNVXxiXaXL+E1k0M9aOxffwu92d4qzoeuA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props
 to class props
Date: Tue, 22 Sep 2026 11:51:29 +0100
Message-ID: <20260922105223.1607725-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9984b5-d0df-4870-f47b-08df18979982
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YkTXVcB9x5Bdz7Ktbq7AshcS3i0QK3xbZ/J4pCa5T9rSUEBH9zWfwNo1/z+TGjxYe6Kanvnl8xcUnYhgLWVI2Y7osjvEfAaZkpaeeh+TmTeuZ7kkQKzolXUcX6hJEQ8ttrOVELtIaNmSWutPOJzSRytTICVfi/qwxqzlgIr0CUEq/BkQCOMDFhkboFV/oBNVbyUQgesz/jVL4HlnlNar0k/8uSc7O21Dih8uWXQWubRey+XLZ1IU+mOB2Eql+PIYkhnMFcnJ+I1YZ6GaPuhgB+7u6hV0Qnp0A2X1Efx4T2LBRh4meGhYoO6Hv3TI4/ftYVbaQh+iNESHeZdHuMUqoqrv+euPP7CVRn/eAQx/ZY1hiYGfD3JoU/JgpoV7CACMwwEvjGH2oKYmf6rZgK1Mu/5Ue4p93K3P3UF7jfGjLXa+C0x8Faq0Y2nJeNl9WgT7FYxBOC+XOy7WbLw8kCtVhZWTauziOjHhCRKPp8X983T/GCNkjQyHoXPvX2vPSWFIhP0DFnqnnJqgP7DQejfMQ1Hbb0pOSl3Ei3M/meg/4g+hcPrHKJkXAaw3xon4FP07XMBqMTPmX3xizV2OTYb7t7+13BoRKaBo8yXN5Xi/27E92bdSz2CGFOMO2T2IAJFsKfs8eNCWMxtPjEoQjankS9TBeG5phwpSYnLz+3UIk+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3R0LzIzcVpsVHVYajJob0NHNUVLRWdwYmQveVp1K3pDM3NXNzJmQXk3cEth?=
 =?utf-8?B?ckZlN083c0RtNkR1UUpkSTdKV0dtaDFQbkFrR2JtZkpNZFBwVzVVVkNEc3VT?=
 =?utf-8?B?d1NMcit3dEdRU2xhK01lZXl4V0ZKcmEyeFR6VkYvQkE5dTEveXk3cXQzYXZX?=
 =?utf-8?B?UU51YS9DYVRtTlFlbWRSOWtpYzhXY2NqOHhCVjJnOHYxZGh5dndRZkhtUHFh?=
 =?utf-8?B?Z2pRTjNKYnlDM3RLcGF6T1RpRTZPNGtqZFZaTS83T3RlUFlkRVJzc000OVk1?=
 =?utf-8?B?Y2FjaFh0aDI4Mk9ZMnVZNmk5eFE2UVovQzBFQ2RuZ0RqSVM1R1hwRVg1TlZ5?=
 =?utf-8?B?UTlQUE10eVJTaXVJNTE3QTR4dDB1VmFNZC91SjFzRk5QTWkxaERLQjhCRXph?=
 =?utf-8?B?bDNQZ0plVTFZMkZYTm5rd1h1UzZxb29EWGVBbW9jbzBUT09GdFpTc2s0bFZL?=
 =?utf-8?B?dG1rbm5XVEczbW81Y2Yybk15U0lKNCsvV2NZYUZnWmJPdmJ1dExVSzc1Vk15?=
 =?utf-8?B?WFhjTE9IYktacTdXMThkNEwrTm1MZzFYaU9XZXVBWDYrWjNDN2FpMnpiWW9M?=
 =?utf-8?B?MGVIRkkrai9zOUhBZlg1NnJjL1VtRFdtbUpVT2VMYURGWGJxN3BoVFJaTk82?=
 =?utf-8?B?ZEo5eTVoTkQ4WXVDYnVBNE52ZEhrdjVqTktScS9nT0NLK3RiS3cyZ0NuajRS?=
 =?utf-8?B?SUxVMXVwN09ZYy9OODdVSnVhWndVbm0wWUdrdjFuYVRZK3RnM2U3ZGRuUFR4?=
 =?utf-8?B?UHd5RWRBMEliTnlrWFlpMjFIWElVRjY4V3h5Y0I5YzNRTjgxSGdSNUFVMnpV?=
 =?utf-8?B?Nk1TSXJrRkYxck9kbStleVRLbmp0V1NMUUlEVlBqTURMazUrR29XNUdITnhu?=
 =?utf-8?B?TVpkL0htQ0h2YjlOSGM0VGd0aXhoSFlaa3hTTmNJWjFLeXpQelFHVXZkWmhs?=
 =?utf-8?B?dklNSVdiU1BYdkRWYkZHL0VFVVoxMHBoT2Z5T1RKb3NiZmVReHFzajdzdGVB?=
 =?utf-8?B?SWNyV0hseDEzTERTU3JiSUZBbjQwYlNOZk9Oa0JQclFGeEliVTl6Tmx3NnNh?=
 =?utf-8?B?TElid2U3YmpXYlBLbVlwaTJ5MGkzZENSN04xYTVNdU00NWlzS1JlK2ZoQU1H?=
 =?utf-8?B?UHJBVWFGZTY1S0NVdFhLUmhJZGo5ckpJajdsVjhISTJtV3NNRnpBTXN5VWpY?=
 =?utf-8?B?OHlhRTR5NG53bnhBUjhJeDkrd1VLTnFxMVE2QS9aV09jTWlrd1V5RDMvTkVO?=
 =?utf-8?B?NU02UFNGTUFKOFRQMndsejJhenZSZnAyeXliV2V1OVFZbTZxQUc3elp2R1N5?=
 =?utf-8?B?TnJZUVVZZlQxQlpEdmZGK3RuV1NKeVNJV3VpRUl0bDM4V25sN0pDVzZjZ3lR?=
 =?utf-8?B?UFNWZ2NuUkxZRXRyMk9YeXFYRkhadVc2RWEydGhibU1WMXdyZk1ZVUU1OXpw?=
 =?utf-8?B?MHJmK010MVhaNzE2ZS9seUdhUDc3TUV2OElRZGdub05TZmx4eGV6UUJvTWpw?=
 =?utf-8?B?ZUwwSHdZT21kcXh2d1RSYzNoRkxnaDBoclB5UFhubFVJN2RoNUxDQ2FSSjdm?=
 =?utf-8?B?TGI1TUZXbk4wZ0xyVUVMNExqUmk2NkZwRS9nZU1UUG1sZkw2SEJidVltWEFu?=
 =?utf-8?B?S3RlL2UyQk5TRHFxVkppY0RZYTB0NGp4cGxvWFcyTDVHOXl2c1NsNW5tMXpw?=
 =?utf-8?B?ekI4K1p0OHNvRXlGdDYzZVduYXNtSEJXU1BIc28rZDhnbktjSDBwbDZ6aGdU?=
 =?utf-8?B?VzhFRG1xZ0FlOWR2bVZYSmFzRms1cExhMXRUZjBMa0lWenBkdllNbGtZT3JT?=
 =?utf-8?B?NThQSjdOQW9KREE2Ti9yUDNjbnV4ZW9VcHE3cXNwSFE0d24ycFI0WXQzSTJO?=
 =?utf-8?B?dDN0b3c4RnlnQ2dKTHJaVkJqMVhsK1F4d042UStBR09PQjZZWkNtZ0Y5VG5D?=
 =?utf-8?B?V1lINnJjakxNY1ZzSjJjS2VOV0hBUjlia3AyS0I1b1c2M0EzREhqV2RMRDd2?=
 =?utf-8?B?Wi94RnBCaEJRaVZXY0xzNEgwYk1iVGFMaVBhaGFEQTdUTmtESDIybW0wRi9s?=
 =?utf-8?B?NzFkZUxsU1ppU2VWaUlOeEFqeHRQa21DTTJlY0tQUXllNThMcjhneE9hc2hQ?=
 =?utf-8?B?SmdVUjU5VEhGOVkybG9pMDhDWXM1MXBSdXQ5eVNXOUxWVzhTVGtuMm5tLytz?=
 =?utf-8?B?UG45R1V2WHVza0Vyd3h3MDF5Ny9HUjlWS2ZHNXNxSXlaMlpTamMzY05FVVhC?=
 =?utf-8?B?L3NWS2RIRURsc0tyNGtvNkt1SWgyOG00dFkwZFJEaTBJUEwrYTF6R2dHSmtS?=
 =?utf-8?B?Tk5ja0NVeDZla0FRa1pWZFFiTThZL0F4KzY3RDNyY21yMjEzMDFiNnkzKzRF?=
 =?utf-8?Q?WX3RkdWyMHFo5iZE=3D?=
X-Exchange-RoutingPolicyChecked: ZZ4QdPvRIRJKOC+RntzPidxAJt9JSZF2r0yKJ31Ph63n8+KME6USjS25fSEFFC4QpViq09qYzkFEBO/gsRJwhzRm35FzYThwbHOy727yJlCZoZjaEAA79JMeKlezc86KQT37iqx7Wx4Cdb7R+SK6d+klQmq4GJl0GPRre7L4m4IcTmS0QSIceOiBFEpAI1rlrm6IL1UD8JVcEiz4/3K8oTxvm6K5m2XZXlXOysiExWnMVMHeiVRzOSedybt/BtgWz5ey1/A4cwNAor8+hz+LUny6o2fVnWmvvmbaFHQuzOSCMNPlABHbIdeZaTJRdqND/JkBPTQWng1eAbqqBgEZXg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9984b5-d0df-4870-f47b-08df18979982
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:30.6396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUaY7473V7dlqFmx9TeKOcnZSv3bUjO5SGptYSXzLtMTNv2KJSW79TaDMBBGXAddp3PmaWPandPrpa2sPQO7amQJKHyn7N+76/OEyxq1TKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Authority-Analysis: v=2.4 cv=fPWsTpae c=1 sm=1 tr=0 ts=6ab25def cx=c_pps
 a=PDMYrpmLcA1CqgnwcVHdMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WW1ICioD1yZG-cFgb_cA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX/+Ul9n+l59ap
 tOMAhjTL5x8uWfIpI0UQtLwOZY0jBVpybnyZiqqoz/jMCUdnUFtwh9qo8MsJ9qBZmJiUAZTrUW6
 5g7ZHXxIk2sxDfJBT/s8vJ7bea9hCrk=
X-Proofpoint-GUID: _LUa8IE7GX6ZsbtF3DaODXR9SUuXH9_j
X-Proofpoint-ORIG-GUID: _LUa8IE7GX6ZsbtF3DaODXR9SUuXH9_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX8pnuALMrmwsE
 YeTXV7ZLZZBelumoKyY7ZHaUyslS5klsGuIza01S50S3i7xXcQvkfdS/RhAHn5OU4k3WNbs92wX
 UEKCmQacSmyainZeZZ5UhNIRfxJi9Ywwtvag/8dhMcgwdv4tYhbaH9aYxsUF5z+TOBUn0bm9oCT
 HnOo5a8meeOejkorq3poAmGKV4rR7GKomELtw8+7PuPZ8cU0tyZW0LPIGLeKIxESCFR5dxB+Uwa
 o4KZDR7tad4BpVu31JdHV40QfVO+cNsrGFtm45Ah2wamK85WSoj4mUzwygd1TQFFUx5JVXxod/J
 2OJ/Duk5MmoYAPLCINp946wc/w09eRjN/lUylO3L8e8M+6v1zFyMiWazTa/pG/ILjSaScX6CQcB
 bNEz/2VXeMqfw3fcWI6i8dSZ3ce//w8Q0SD2FxNR9Vn5Tmr572YM+Rl9M/C4gtqVo8vrcAECBnS
 6iMs+J+NKlOrBrPzDfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/adc/npcm7xx_adc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 3584c27c75..27d42f87b1 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -229,7 +229,6 @@ static void npcm7xx_adc_init(Object *obj)
 {
     NPCM7xxADCState *s = NPCM7XX_ADC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     sysbus_init_irq(sbd, &s->irq);
 
@@ -240,12 +239,6 @@ static void npcm7xx_adc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
 
-    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
-        object_property_add_uint32_ptr(obj, "adci[*]",
-                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
-    }
-    object_property_add_uint32_ptr(obj, "vref",
-            &s->vref, OBJ_PROP_FLAG_WRITE);
     npcm7xx_adc_calibrate(s);
 }
 
@@ -275,6 +268,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    int i;
 
     dc->desc = "NPCM7xx ADC Module";
     dc->vmsd = &vmstate_npcm7xx_adc;
@@ -282,6 +276,17 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = npcm7xx_adc_hold_reset;
 
     device_class_set_props(dc, npcm7xx_timer_properties);
+
+    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
+        g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
+
+        object_class_property_add_uint32_ptr(klass, adciprop,
+                offsetof(NPCM7xxADCState, adci[i]),
+                OBJ_PROP_FLAG_READWRITE);
+    }
+    object_class_property_add_uint32_ptr(klass, "vref",
+                offsetof(NPCM7xxADCState, vref),
+                OBJ_PROP_FLAG_WRITE);
 }
 
 static const TypeInfo npcm7xx_adc_info = {
-- 
2.43.0


