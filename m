Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9547F3C246
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZfU-0000se-6M; Mon, 09 Mar 2026 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vzZfS-0000qJ-Hr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:25:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vzZfO-0001C7-UV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:25:01 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Bf3782341067; Mon, 9 Mar 2026 05:24:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lTKZ5QyM4G8abBjcI7XMSW+pDilLcAhgo8Cbwf5WF
 rc=; b=meEvH9zVTHsxR0j4YLyncK+709LOlxuWamnp4P4Y9lVHztCrG3IPoLkIC
 7n38faKjbV/5anLk04PaE1XS90CpyyN65Bl2cfE0UO/DnPvoo74LhlDVFbfHcVPK
 0ypwyhbQI5nHMzupddpPINDZHf/U06bmMk0McQJpOqm+3/x97MU7GXvgdGhJ0L1c
 tGI0Du+194ReydK0Y+EmI4IudfF/1N1yVf9EHbTysxjJ0x+0hml8CWjWAQrZMi28
 bGdrzMozlaj8splNI3OjRCAhVTHuOWG3MyhhOqStjfAO5Q3FEqSCa+lkcHoyUX2d
 om0k1ZHIiZi1spwqlPbpWAIFPHN9g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020105.outbound.protection.outlook.com [52.101.61.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4crkyk3tew-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 05:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HibjdNZuCOimT5dHuxuQh6hXw6Oe2ck9jQ9BTtAkRv0mafyT3eHZrePPHr+IkE/CrgLh0qtDGeE2S/VUHfmDNcdrQPkLurBhAXFP7knYsnf6AqNu2jCKiiKU8gpN1+0o9Vf3oRnbEJmmwUBC73kR7zLukpTZ+cfE4CSYpCBJy8hJb39hB4tRT7RAU/1NJUV/vDe/BRqiv2pEpjKrhlpOldcKpGUZDx9As1ONLBWSZR+QkcQxuxrF9fhMbSSulNk7Dv1AgOEX/nEA6pn7DBOarWNSOCIKIG3sN/iHEbdfPJ0gU1FVE7ByFSa14v/cpRhT/PwwSy5/AkaD04EHE6oBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTKZ5QyM4G8abBjcI7XMSW+pDilLcAhgo8Cbwf5WFrc=;
 b=E1RHgH5LsYQ/8eWH2XNheaOAXbSWCdLht6qDaTfB8db3YlasrWD2Go7w9rGaUDS33Cbj5RXH0L/pISBmEVBxkbh8yium5lAe0IZTgaYGp4ejV4qV90uDe0lL7fiLQrxFf55VtzQ7ofYmv4YGzm4AiXuEZypjmBtIonhLSwrV/jpQQsfuoiRxMTtxQVDyDJ2q/0xsUlXne9HtJccgtyK4/WfUtgXLbOABtk0sYRaP4AV1uEf9rr5d/Yw1hx+zUK/+eLI/dasvz4j+KXNcoIcbfX+S2pqJAvnVUUQFrAgcSXEQocGjpvPdWoJdJO+aJyqrJqpdVPmL8dYm5Ar8WIyMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTKZ5QyM4G8abBjcI7XMSW+pDilLcAhgo8Cbwf5WFrc=;
 b=nwOqB+J50Hs/so7Y98ROCPG7tYPiLe6SBVAPVjFtr88ifH5KDY7qnqHKzcRlThtKAV9p0nTwnYpw4z0htDUQjmaopM0e773pJczgZ2qnKFgfYOa/wBZhN47O7VwBBcXPxvoqf1wUFlf2h6/h/E4YSJDdt/4nBNT8CbVz9vWB5/xTsmgFErfSyGQO8bnDyHU6K1TTVvYPzdRKEoS/XkquRQQ8HEaL5uYGWlSZMwDdQdjdVBfwmIboJ2WlhdkUDe4EQxYkkl4+xkMBPxyM13YNIGLUFjxBNB9jqTed9fT2FG8ROBDS3+/J7qOAiirmavQr2NMmq4Hph1DfJMS6q3BLnw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8255.namprd02.prod.outlook.com (2603:10b6:408:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 12:24:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 12:24:51 +0000
Message-ID: <4fc1a28b-36e3-4d1a-8de7-3c703b589a44@nutanix.com>
Date: Mon, 9 Mar 2026 12:24:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20260227134611.1229390-1-mark.caveayland@nutanix.com>
 <20260227134611.1229390-5-mark.caveayland@nutanix.com>
 <20260304122251.217cd93b@imammedo>
 <c578ab0a-d8b8-4474-8d5b-538a26a85c85@nutanix.com>
 <20260305134913.78e63dd0@imammedo>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260305134913.78e63dd0@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:610:11a::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6608e776-5969-4dc5-2c6e-08de7dd6dc99
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: znz+vrya2EyPPkynPFdJq9SWcMzwpqBdgQk4BQSdPkV2LcND073F6v20uWWV/aaK4MipWrF9eh0PQubd0EbaFIgOMiOxFNj5bWOKw3G/d8EhHPC/Uuu0tDc1fryMsX0jHK/wmVxCSg/D5WiwdKp47UL62qaf5+wm389SxrhY2CKA6VKCbODXdVWX4yOwVkEq9x53+mEEqtvNDUxHF2SZtoV+Nz2FUaOI7alGKgk/FeGBvk5ozp6yDhqDvfS6GGEKsqS7FORKx1EDRakXCXHgEL7iEOFiH6ikJZJXPm3XJiFbO1Zz81svNGJ5Bf4x2TpkHR+RX46sFfxKZEGZVkVPSguuPmLRU7s+io7Xlik/z19Z3G1wAGSfk65qhX8M/txQ58WXzt3Da68VrU38ZXe7Y3wKpW9FvZAa5r+x6fbolgvwCJCXHwEF6DuuboSbz0rd1ygtbDZF2uIM0Z0gUf8ehPQUZcRY/6hpjguBNm2oyY8L7QfGS0jpoAa+qhsveR6d6n1U7U24Rzfw9txFFPknUoC+SVS/t+SoTojwgv1SNG49gtu+vCQNuHd8RumgKBhDJh5kNRzbPXFhNIWIHnqXvZC8+gk/ACBfPPjPTEtm0kYxCMuvwZRddhwVI2BRHWhFxFitDOTja0ecR9AFwgswSsdNiuZ1A0GEzEI+kCULxTvME2dgiygBm189CTcjE/y6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXUyaDJoOWZXelFzS3NOT2tRUmlvVTJWM0g4dEdUQ3o1aytVTkR0Y3FxYlh6?=
 =?utf-8?B?NmxKWTFCdmpISkJYVXloVlhXcGU2ZlRkaXBmait0ZTNrN2t3d1BEVWphdnJX?=
 =?utf-8?B?bTdWUlFXVHFHNUw0VkJTQmloaXdlV2s2ZkNRNk9HcHA3SnlXRXRUaTJQUEYx?=
 =?utf-8?B?T05xcEdXeE1WczFJYVBqeEM5OVBscTErZVJUb3c1c2VmdG9ZWFVNYmdXNS9r?=
 =?utf-8?B?VG12ZDJZZmRPZ3pmeVNoR0FvZFBqZytyTlZ4TklEYXI3eHRqcUdGMG5tSWdX?=
 =?utf-8?B?NWJ5VkNabGhwRmY0UFFkbUF5UklvaGNVbmovVzc1T1pyWlRTamlpN1Z6Z2dW?=
 =?utf-8?B?MlVyczZ3Vzl2VS9rdlhhNXFLTlZBaTg5YVVUSlNHbzB0aUhyYmgweGFtMWIx?=
 =?utf-8?B?QjhGOUk0RUtWa0F1SVlyLy8rNk5Vd1JMTkJjUk9ackxHajJIbzF1V2pqR3lF?=
 =?utf-8?B?UkRwR292Mys4SEhQTS9XT05iVU9NWW9HdkFaR2kxWnJRVVpvMWFLMHdyZVp4?=
 =?utf-8?B?dXdPVzBaQTYrM2Y2NTEvRllsVlEvczhKamdQUXRlUlUyMmhPaFZ6Z2xFME8z?=
 =?utf-8?B?NGw2Zm0xK2xGWlZCbkV2YkpkNEZienhYSnJ2THRJaXUrMFFxbm1uaTliUGlM?=
 =?utf-8?B?NCtIS3BJakdpaGRnNDJDRWREczVGYmR3WlJyV21YZSszN3dNUDMxRGpLSm1j?=
 =?utf-8?B?MFJsQzNGYUEyc3lNQjNnMm1QdjdNSkJ6bmd5VFRrRVROYzc4WC9tSUdyRS9X?=
 =?utf-8?B?ZjV1N3EyVmgvZGlKaTdoeFhkZDdyU2wvYUF4NEFtTzI1dWowSDlvSzRuWlZL?=
 =?utf-8?B?NlFlcjF0NWlieklMRThrVnlXUnE3YWpWMkhyWHp2OTQ1bkF3VFlwdDYxZzl4?=
 =?utf-8?B?S09QWGdDaVZKOVFzU1dMc3FaeVhmL2U0c1FlUEpyN1dBTFVhUXFXL3prN1lp?=
 =?utf-8?B?VFE5U1lQVURjMzBOVWR0U25sVmNHdHJRQ2VzUmM3bWRhK3p4RHo5ZklwZEVo?=
 =?utf-8?B?WkFtTitQekZNc3dsZVVFVWxSd21BRFo0T2lkeVA2aDVNaUlHd29BYTJzZGJC?=
 =?utf-8?B?eXNHa1AwY3d3QjVvZ1hhMVNlc3NwN3JmSzhRNjBCNURKdHRwRCtBN1U0REVv?=
 =?utf-8?B?Y3NCanpHM1REQmo1bjB6a3JJdlhyNVRxb2lZSGEzd1A3c2NFQ3RqOXR4dkIy?=
 =?utf-8?B?TlVsYmVOZ05jMHZMQUxWZUlsTisxemtGY0YxMUxuWHY3Wmo1K2UzeUpPbENj?=
 =?utf-8?B?anJJV2x4cVc4TkZsZTIyTFBibmlpU1VBcklRdTNMVVZmK0RXUkhkb3lUUFdn?=
 =?utf-8?B?S2E1Y2JXaDN5ZDlzSCt3cGNRV214TFhzUmgxNmtRT3N6Z3d6SHBtNll4Y2ZZ?=
 =?utf-8?B?SHUxNjAra1VxcU80V3JUdjF5WHF1SUZpWXNYeWRSSkNVRXJUbmp1NnkrSnRG?=
 =?utf-8?B?eVB6NGEyRk9aM3pXSkFlQVBXTUJJanFxZ3Z3Z2JVcnZoWDlYZ1N0U0pTZzk5?=
 =?utf-8?B?VGNocDh6d2lZRHFETURyYVkyU24zcFIyRGRxeEtjR0hkT2srT3FrODN2a2pm?=
 =?utf-8?B?cjBEQlk3TisvaTZXM1hWZXZEckN0bG5HUlkrMXR2V0NadDY5VE1IZEpVREFD?=
 =?utf-8?B?UTZ0VlA4QjJ4MnErYlBNakw2TmNjejA1N3h4RVJuK2ZsSHp2NEpOb25EZkVP?=
 =?utf-8?B?d2dPdEhjSGk0Y0hzVWZJRHZTcTA5UGlkdWtDZ3BoOG5WU09xY3BZZlV0aWN0?=
 =?utf-8?B?cVFLOEpwYnAyYjRJRW84QldnS01Gc0VxSGNSdERYZHRVTHZwbzZxUVAzOFNE?=
 =?utf-8?B?SG9PT0FuOXlqUGlseC9UMElndFN6NEVIcjRLNzFjMnVJUk5GRzEyOWVNZ3pP?=
 =?utf-8?B?MHc4WHEvQUd5aG9UK1lkMGdWTHdrdnBENG1DcGYxSUdvNDBNcGQ5M2liTVdz?=
 =?utf-8?B?VFhrRlUrWlgvVnZ0TVFjdzRMMlpDbldmd3p2bnQ5R0VCZ3pPREZzZ3FRSFo4?=
 =?utf-8?B?QXFTa3dVVGRKWEFaeVR4N0Z1VnlwbnlTb1YwelFwcDdRYnJsT1FTMk9hZmRY?=
 =?utf-8?B?Vmd3c0lEQTF6UUJ1ZFdKVjhCMk5WVG5uYlFXcTV4MUNHaUVjNVBPMHExWVUw?=
 =?utf-8?B?d2JlOFRtd1I2QlV4dkNMem9NaFlTRDdBcjMxOWlwWDVnc25mNnorajlpWVNq?=
 =?utf-8?B?clBsOHhwY2RrelM3SXh3Z3hDWWlaY3ZvTnkwM3haRFZ0UTA1M01xalRvc3Ns?=
 =?utf-8?B?OEpGQVpWRE9uU0cxVFhQMGErcGxHWXlMZ1FOdDdlNlVyb3VCRG9MVXhZSTQw?=
 =?utf-8?B?eS92UHN3ZWViNldiNjhFWGxFNHRleGpjMXZ1b3gvMEFQS2U3T1B0d2ZvYVQ0?=
 =?utf-8?Q?pk5iHHBnVVK0I4bc=3D?=
X-Exchange-RoutingPolicyChecked: tJ4AWj0Uhd7SLCjsGoSgQYeMwZWCv5JD+pnqfatp0BvLDxtzoGLMT8ffvM6WuUDUF9QiBXJxQeBv453tKj9YWxVovs5KN+Y1x6eMq0l5m9dULMUj+G4mTxoxrzYk4T26nwAW+iFogyF36wO7QL81nSiR/22Ec1BWWTAQ1yIKeatW3DtJ9zXz2+tNtjZZGwN9sCwMy+H+JgXvvcvnHiFwBohw7EB5YsMEcwhjgxw4LtJkl9UiLQWy1q1HLwcbE+h3va19ltllzgh11jKN6PRYGmKO8DGt4z91zI+jvC1wQndXjiMLf5nTqc2Q4+wgrjfb1CdCC+CN81uKG+mYXE3IMw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6608e776-5969-4dc5-2c6e-08de7dd6dc99
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:24:51.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98pbPvwx5GCaOXJHt2CXnWVNb9YR6ZLqOg4uRMusaESSnsBEGQGXDenbGos5v3hUjYB5SYOtCQbJXpqOzrL8D68I8oaABTc+g2UsK+00/B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8255
X-Proofpoint-ORIG-GUID: XDhDT_R7_qTzM23BeHO-pnapIiYdEQI7
X-Authority-Analysis: v=2.4 cv=Y831cxeN c=1 sm=1 tr=0 ts=69aebc15 cx=c_pps
 a=SfbXOumlQYQ7ptoTXzRROw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=XYAwZIGsAAAA:8 a=64Cc0HZtAAAA:8 a=s2bIyWXYPUSis7LCThUA:9 a=QEXdDO2ut3YA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNCBTYWx0ZWRfX+8ANkmrteqo/
 pOzcrjzE427lshA1kSwGFiJpO8sR84Ibjvex765yuNQ233gO1W7dxTmuC5W2Obgb7xRO597RgWD
 cAC9pWcxw75Bn/XZYBExTdrQv6oUIwDcOP3DoI/BJf5ULYLm2ws4KZvYmOriXUvLttqBDOifuSz
 2cXeUmZcPCjgieabeGiJibeJhRITUmIx+lphAwSsF6ZmmfXd16gGp5bQl1PZh/ISXSnXQPu+SqL
 iKzzSbYXzAzm7v/KBA15YkhA+s+9e2T0EBwVZ78ATIVefSX9cjgxW6lfrOpdH0hCePLTeQxe6Hk
 tvVnz3EudKCXOUZBuWGGIzeWDm4jAUxqoGkOkSjS98ngeCyWeM4ov3GZVXGepF79vg9dvt9UrIy
 /GIn4dP0K3pctHn238kHVuEMkO9+UuPFPTxv+oPD6HLLuU+AjYxhzXbW55tDkTKBcfwXv/wAUk/
 PfRI4vPbuhKid2X6UlQ==
X-Proofpoint-GUID: XDhDT_R7_qTzM23BeHO-pnapIiYdEQI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 05/03/2026 12:49, Igor Mammedov wrote:

> On Wed, 4 Mar 2026 14:36:14 +0000
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>> On 04/03/2026 11:22, Igor Mammedov wrote:
>>
>>> On Fri, 27 Feb 2026 13:44:58 +0000
>>> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
>>>    
>>>>   From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
>>>> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
>>>> Descriptor is used then the interrupt is considered to be high true, edge
>>>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
>>>> an IRQ then if more than 2 serial ports are added, Windows indicates a
>>>> conflict in Device Manager and these combinations cannot be used together.
>>>>
>>>> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
>>>> ISA serial IRQ is low true, edge sensitive and shareable, along with a
>>>> corresponding _PRS resource so that the legacy serial ports also appear
>>>> at a fixed address. This enables all 4 legacy serial ports to be used in
>>>> Windows without conflict.
>>>
>>> What happens if we just replace aml_irq_no_flags() with aml_irq()
>>> (without compat knob and _PRS)
>>>
>>> wrt _PRS could you elaborate some more why it's needed and what happens
>>> if it doesn't exists?
>>
>> Good question. I based the implementation on the technote from Microchip
>> at https://urldefense.proofpoint.com/v2/url?u=https-3A__ww1.microchip.com_downloads_en_DeviceDoc_00001879A.pdf&d=DwICAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=Nx9ld5Tg6QCayccyKhC9WQbm1DwiJT2Ja3jlwtlv8RkPFaZcU_oTHCkJZetgQLfd&s=k-ubK6tfBDM7A3BN_S3lNy3s-SJGR0fU9O5oj-GWF3A&e=  and
>> found that it worked fine here on Windows 11.
>>
>> My concern from deviating from the document would be that any changes
>> would work fine on Windows 11, but then fail on older versions of Windows.
>>
>> I can try and locate a copy of Windows 8.1 internally if you still think
>> that is worth pursuing?
> 
> with _CRS present, I don't think we need _PRS especially in absence of _SRS
> and means to actually changes used IRQs/IO.
> 
> What I'd like to avoid is adding not needed code and compat logic
> if it's possible.
> The later unfortunately achievable only by tedious testing of
> the change with older Windows versions (the older it is,
> the more loose spec interperetation).

I've done some more experiments with both Windows 8.1 and Windows 11, 
and I can confirm that the _PRS isn't needed for Device Manager to 
detect and configure the serial ports for both OSs.

However it seems that indicating a shared interrupt with aml_irq() *IS* 
required for Device Manager to detect all 4 serial ports without conflict.

I think it would be fine to unconditionally replace aml_irq_no_flags() 
with aml_irq() in this case, however since the ACPI tables visible to 
the guest OS will have changed, wouldn't this still require a machine 
compatibility property? Or do we not care because Windows will almost 
certainly insist on a reboot for changes to legacy hardware regardless.


ATB,

Mark.


