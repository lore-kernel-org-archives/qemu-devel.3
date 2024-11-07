Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD79BD29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 00:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8qTR-0003Wm-0u; Wed, 06 Nov 2024 19:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1t8qTP-0003W3-KY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 19:34:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1t8qTN-0007nt-Vw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 19:34:07 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MSvXA030880;
 Thu, 7 Nov 2024 00:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ZxszQywBUXXoN5kwsOikuMPEqc2HZ8yMUwprLUstBKs=; b=
 jCGl2+5YROwWcB06FH0oAuKFgBPYe660UK/TN9DJS66J+BLaQhBuCgzU0foq0eby
 rznAneE3owDBEWuXK8vj723R0yJzZwHnguiaHiTEP1xETI/rs+9ZZ8lx+NenwjRX
 kPLG3LlBwAQ+SQTERV0UPo2ylVrSdryxf3DPCfroXKC0GsjbZMtcaRbmxmSIWtzP
 zZZJiCzRRd1Y9D5/mXugoQDMm42d/nCrcZZzv7ZtT+YOMZgi7FoVQk7ERrrrA8RY
 QNMB758uLjaqCPaZqZwnMUE9npDBRvauuQj3L4VkJunbjTDI9qNAcNRthKOLW3dc
 e08C9+o2bDvaRR1v17enaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap01e69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 00:33:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A6MmgfK009833; Thu, 7 Nov 2024 00:33:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahfkw7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 00:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds5D5oY/OzuHGiBOixHA8ArdzbweJuigGUl4b5tj64FqFakAG0tzlK/FR5sqy+tz6N4Pm8VVJ1akVguS+A0LSBEDa04t9EmClIc7khmm4FpalW8KCixwAiJhpxgolyv8+B+dfIyq986TPTOtCINdxsoNOr3NY1O2mM+ngB/BOp86Xl+5Dak3Ci/xuGBtvH0y8LIIrCUqmyno1ZANlRKDERllBKeAOpcVY9tz2w5SXE5RiweDRAVjXpuFnCrfg/8s2Y3ymnKa0HLaa69D5X79ccCuRjcU6WhRXOvDsn5YKqS+yYwroi+rUzdLl97xTqvRCNmaiLKiucqPvFCVZCRA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxszQywBUXXoN5kwsOikuMPEqc2HZ8yMUwprLUstBKs=;
 b=fPXUqPK/JGesEEX5B1qI/QuiebVghlxsnbgUpE2Q5f298nEW3IvnSa+Ro4cD9qjP43Sh2GXnlQ7UHSOhGGqSdK5j2emIdF2ZzCcxodGcNVi2rKPlbfEMcJiHAe+C+PkajhPG3Y8FR4XkPoDogPA13NTxqkSHMFNwoLtg2036p/soDY5O5uYyLvLN8szoPR1/qYz6/0F0RvCeRk3eKTtXAkmOqTJTTT6UlrOY14AzFePmFuhUEH90mfeYRfIRxiY4k3w7WGHjifMA+AHQFaqAxflNc17p6HrRgxXHD83cOzh2LMvmX4hdhXQhy455twygDoOlpXA3hQnpGgKJQNsJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxszQywBUXXoN5kwsOikuMPEqc2HZ8yMUwprLUstBKs=;
 b=YzqmBs+bVsjBPpFtpZevPCOL/UbiATPCRujK7Hy0xXYCQPHlHgahuPJpnyaoZ7uarPvnN4lAbGFhKe0h5bB803v7fDBYAFdJTOLWgdbUNNWajlzpvG1ZWLQkihPXO6fOsy7/qJ9gkJIcku3SVL+u0zU2UwvBA+eIbH2wLeMwPm4=
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 00:33:53 +0000
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9]) by SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 00:33:53 +0000
Message-ID: <6aa6bb0f-884b-48ad-b2bc-1ef2aac64626@oracle.com>
Date: Wed, 6 Nov 2024 16:33:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/i386/kvm: reset AMD PMU registers during VM
 reset
To: Sandipan Das <sandipan.das@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, babu.moger@amd.com, zhao1.liu@intel.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 davydov-max@yandex-team.ru
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-6-dongli.zhang@oracle.com>
 <50c2e774-999a-4103-94a8-55243c695dfd@amd.com>
Content-Language: en-US
From: dongli.zhang@oracle.com
In-Reply-To: <50c2e774-999a-4103-94a8-55243c695dfd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:408:f4::28) To SJ0PR10MB6430.namprd10.prod.outlook.com
 (2603:10b6:a03:486::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB6430:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3f9c17-4289-446b-5fc7-08dcfec3db03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEFnMmhHYUNsYkxoRG1WSjY5MGFSbGREbzk0aTV2bTgwdFhjV3p3cm83b2E1?=
 =?utf-8?B?cUp4QjUycTB6NWtzTTJaQmtmR3lQNG54QVhia2RaZkxKY0U1SDd5QkJCdS9S?=
 =?utf-8?B?THFGaVB6b3pKM1J0K2ZzSDE1L2hMZjdwQy9UM0Zpb0xIVEl2NWZDTHZDSzht?=
 =?utf-8?B?elArU2NFaFJQWWxvUlZxZUdzcVBZK1FsK1k0a0xUaXNtVk5PaWFSQ2JKOWRV?=
 =?utf-8?B?T2ViVEFVbE9HQUxqeUF0NkMwRThDK3Z4THhUOHlNN0pEYmt1OGpzYWNaOUhR?=
 =?utf-8?B?em5Lb2R4MGhIYlpmNExJR28xekpUc1dFeTA2NFBvQS9yT3lGcEE2b2UxRzlj?=
 =?utf-8?B?TG5oeWJjd1M1QVg3VkNYMTBIeFhERW5KSkNpQnJTNkdUMzhESExaR0pVOUYv?=
 =?utf-8?B?Ty92VHIxS2VTS0svV0pLdXkydUpTMmF5VkdENjI3bjN6Vnp3UFJiRnY5STV4?=
 =?utf-8?B?eStBa3VwWHF6aUNoQVR1QUZOWW9mQytqSEFUWGNpT05GaEJ6WlBYbWgzT09m?=
 =?utf-8?B?ajJXN0ZSQXVsbkFOS3VRL0gzcUwydnJkbXFMZDlZZFVIYm5VVG81K09ZUFZ2?=
 =?utf-8?B?NVVNc2c5WXRBb1JUUXFCOGNSSU53eUpMS3pHZnJlcjArTEdINEJkWkdkZEpV?=
 =?utf-8?B?UGVZeEorN0MyNy80WjBhSWVORkhRL2ROM0lHR1J3WjJ4SXVYU0RRY3htU3Aw?=
 =?utf-8?B?WE1vbUU0V2syMDIweEVLNmV2aE1RMjMyS3N5N3FyVGc4ckw4cGhSaTIreDgv?=
 =?utf-8?B?anhEWUFiR1RVOFhNdDQveGpndE1HV3hqSC9TMy81YldCd3JvaXFGVnR1NHZZ?=
 =?utf-8?B?bkUySGtYR3RvZkZ2SDdOMEVTUGJoZmtLTDVMaFRqUllTMjJQNlFUQU1GMDBx?=
 =?utf-8?B?STdmV2szcFpLU1R2OEN6dmlsbis2MjYyVHJKbHlWbkMzQ3h6Um0zbE9ZYnpO?=
 =?utf-8?B?SGc0SVBDaE5xUTN6SDVCdUhEZ08wV3NsZ3hleDBhbXFaMEJ0L1pycEVzSTVt?=
 =?utf-8?B?QWZkTW5zZlhMU0tYS1lzZ2RZL1JFV2I1OTBkQml3aUhJVGJjeGprSk1HNzdH?=
 =?utf-8?B?K3NuOHQ3TEVTb2Z3YS9Ma04rTWhiUjBPN24yOUFoMURaK1lwRnpxRnZyN3lB?=
 =?utf-8?B?dUlOL2ZlVEtveVF5UGJNc3NvSWZBMG10VjBvSWJaV0kyOTQ5ZnBXMGR5aXoz?=
 =?utf-8?B?MFkyZTRFa1ArYzFvQVBBVXpmcVhCTkhkVWkwSVRIQlRuNEZCYUJsdXpmNHlI?=
 =?utf-8?B?RXNjQzdRdXY0YXFpTDRrclhUU3JrbTBuRUE3ck9JdWZtZWJYOGxRSkdrME1o?=
 =?utf-8?B?SUxmTzlySWRqaHpWNk1ybExsd3FWTHQrMkZ5QTZIb2hRdWx1UkZXQ2t1V2NN?=
 =?utf-8?B?MkZKU2UwTm9TbUVmQURaTXBnZmhDaVN4b0txWDBnQ0NlM3B0ellhcmRSU3JK?=
 =?utf-8?B?c1ZMREJ5emxPTVJPY3k4Y0w3VVdYc1o1VHE2cFVJZDRSVnhJaFlhL29XWDB3?=
 =?utf-8?B?Z1IrNmJ5cTV2UkFkMGs4ZzFFay8wREQ2cXFyT1dJaSs0ZkVQYngvQ0Y1OUZ6?=
 =?utf-8?B?Qng5bFhqNittVFhGWFgvT1Fmc2hlMUR6bG9Vb0NGN25NQ05XbjdHdU5Kblgv?=
 =?utf-8?B?UEcwY1hoc25aSThCTGw0bDBOeE1lM0ZWWG10dnl2bEpZUjZwTDJnamhHd1JK?=
 =?utf-8?B?czlUSUxLVDJEUlYxV1p4MVRFZEVBSDVna0JCeUdyK3JvZlQwdC9mN1F5bTN1?=
 =?utf-8?Q?uZYxLubONxnakd6soF1FE3P3+AjUAwZUx9TRA1O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB6430.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhhc1pOVjdZa3JwNFpSRXBSZnhoWTM1RWtXSUptTGo2ZWRicFNRQko5d0h2?=
 =?utf-8?B?dnZLLzB1UUt5NURyQ1JmQ253YVdQa3ZNWW9LazhTYXJVK2FlcTk0RW9ENTkx?=
 =?utf-8?B?bFRRNjZGd1dyVkt0cGkvZ245MEIrNW5HL09oWGhKbm1taVo1SDRLOHBFRGN1?=
 =?utf-8?B?RFVwZjAwa2l1NzdQbHJ2aEZocUd0bTdSVjFXU1BjTWhPY2w3Z0UwV3BlR3Zl?=
 =?utf-8?B?NUlHQmlDc0hhVkVHWXNTbGNrc2VKVFR2eks2UzZjeHFXOTZiMmdjYXM3WHZP?=
 =?utf-8?B?OTZiT20rNnc3eE9nQ1FZQlEyUm9pK3hQSGVOSGFLa1RYS01VUEFLelZTMmdN?=
 =?utf-8?B?a2M0dzdWWFNhUXNaNHhGRVpic1NFV2pHTFhWckpiUWtRNkpJcmF3TGVOa21E?=
 =?utf-8?B?WlNqYzBPQnRvdFM4WjYrVU5DeW5xajNSTjJQYWNsaHZRZFpRRE9ONGlNd3kz?=
 =?utf-8?B?NWxQbnBINDNPMlVqUCtSRGc2RzVvdmRKWGFlSElGQlMxY2RrdHAvMWRmc3Z4?=
 =?utf-8?B?S1JKclNGdGFNbmdubVBZMngySE1pWG1SSlJrOGMrSm9vZUtzc0o0TzVIelQr?=
 =?utf-8?B?Mnl4WVQ5MFoxUVczY2o1MytUQlhwTlZvdzJEUmlxUlVYMmNwUTdsNWY3K29C?=
 =?utf-8?B?NktpVm9meVlBVGxycVR0RW1wT1Z2UmxuMGZZYmtpVytFUkFyU1lZUFNadHJr?=
 =?utf-8?B?OXNYbVFFSHJuVXBTRHVqcCtHdFRhd09WQVp4amZlZHcrRFN5TUJaN29oYkRu?=
 =?utf-8?B?bTM1ZVN6YXNXUTFpV3dKcVU0a2pQdzRabWQzeGxLWmxlR0FLSlFndGVNT0R4?=
 =?utf-8?B?WHFtd3lsbGVZQTJOWmNKYkhYUDVSNEpCZm1sRS9pWHB4RE9kUm9IYnhiaHBr?=
 =?utf-8?B?SmxjZ09NYndJdjZEaUYvbWlRNTBIWC9zbHVNVWxBR2N6VjVTdmhaOHY0SFRk?=
 =?utf-8?B?bXhvR3ZST1N0cmMvMW10YkxCT0I1alZDVGI0bGNzL05ocHE1QzdUamNHNXlG?=
 =?utf-8?B?aFdFYmdKTmgydXlramRXTzR4UndmaHJwV3NCVnU0UWNHRVFnUGxxSGhYTkRq?=
 =?utf-8?B?T21jcHpPVmQ4OUkyRXpHWmpMQSszUEdUKzZobXAzTkpBa1lRWHZhcXlObVNL?=
 =?utf-8?B?RmNVa2pROUNWeDh6bDBvQXZUcnRJV3hzYmFZM0xwQzloV05kL3hNdWJUUlNn?=
 =?utf-8?B?a1lvZm5PNXlEa0tETVNnNDZ0U0VTU1VXeTYyM28yTitTMmFkMklTZmNhNHZO?=
 =?utf-8?B?am14bzY1bU9ZdGlHeWFsMVlmR3M4SkNjNXhFNGVSNkF1Q1htSTl5WkYwcGFM?=
 =?utf-8?B?bC80NUEzcFVXWGtxMyt4bXNYMkNTTVNuZCtSWHNlVjl2MHV4ZW4xbjVDdjRD?=
 =?utf-8?B?cnN1U0VqWDdjMUNhakY0U0t3ZThiL29TeDdWYjdlOUNjU3BpN0FqMjYrc2RI?=
 =?utf-8?B?MGhNNXNUenB5ZWpNaGtpcC8ybFgvVTIwM2paQVdwNWlqUVk0aURJbTN0UkUx?=
 =?utf-8?B?L2pmZTgzWTdWbXN0eXFLT3psVlA4WlJNdmRNSitmbXAyOXNDTGI1SGdmR0Iz?=
 =?utf-8?B?YkxJUENqZGkrVHJMcUw4eG5yOXFqUUF2MkNYVXdnaG5TdTU5ZEhzQW1Jc0ta?=
 =?utf-8?B?NUI2V2J6UXpUTm1TRnc5RE5xS2I1QSthVXY4M21FeVVYT0VLMjRKdFZkbGRT?=
 =?utf-8?B?L0Q4YVFieEFXR0kwUGszSWJMZlZQRXJRU3pLOUd1VE1aeFJXWEtnVGZnYXE0?=
 =?utf-8?B?RGg0UUwrejdTaTU2amRwWENUSFNYRnVoYWpIMDJ1YWczeUZQWXhiV0h5SmRR?=
 =?utf-8?B?eWQwNkduTGU2K2FTWkJIWnJBRzN1cEsreUhmcWlUeUlFUWtKOFlDMDlYZlBS?=
 =?utf-8?B?cGNhcG1HK2dWdnR0N0NYbmlWbFlmdlBZT0xoT3V2azcrT2JlbjczdjVkVjRp?=
 =?utf-8?B?ME9JanpRSmtpbjlwNWQ5c1EwM2U3ZHQyUDNwL1FadFBnRStTZDBkcDQ4QWc1?=
 =?utf-8?B?R3Y5bllYVWUzYXJkZkk5QjFqakttTTJzb0QvYXA1SHcrTVlrNVhBM3ZuWjVX?=
 =?utf-8?B?YjBMSmdjRGRVS245Y01GUzEwY0xkZDdhWnl5QWZnOEk1OVVlSmo0RVRpYzB3?=
 =?utf-8?Q?pLTcxelLs4LwI8CgOgYjuVNnS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l2AV1GrWWOsWSPRo3o+QbLqzMLb8/G1FfBwTNBfIcxguZKjItahdWSMwQKesxnwsnr+jHHNswx7ZY/HE8vE8BIKFO7udP2ufdycXg2lHyVEdPlsfUHIkbc56GfJMUDL1JtxlniLtvv905cB4xPXERFYqiNwngYPrFsa94pjFCGhlvCj1nfz5xH8QZUrpWxkndvNDM3jYpzON9c2Ocw48YqlckSsOovlAt31TzTbBJPqn0AEpuGXQsNNY+SOdteOz1EcUbGg1z4ZFEQozq5swI6CnTChi5laFqkPl6XmOAJsOclh9CDfwiaBd32Es/Lg/hFepW5f+d4UWncnSp1cGpoUBzjTTNEJ5SQ6xsOhSmwdfiFx9HUIQFhqKoCtDyHM9Nte5Qol6q/328sdcUS7otF8bJ9hQzaTC0MRW+DG3L+8rW5DJG9VwnARjFGEimraaxi4pN3w2Xc18m1JSluC/PYYYgvagovIl7TkOiqtcu0ZHsOONoUpudazza9NLES3HacWMlgfQryoSDbrsF7wMnD0vLDxqekSoW+erZn3npNJTgNl4lDdOY57eTWiKjsFf+28UEIzQH8HyDXRwddDeSuNlU/k4hzS87zTzfZTR+Ns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3f9c17-4289-446b-5fc7-08dcfec3db03
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB6430.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 00:33:52.9381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ccM4bShfCm7HlpWg6hkNzeADE09bHHgIx3KOJ1oyN9SNnfB9/j4KseCOp8EBiRUEIFXNh48FbEbdWDyxB1K2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_19,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070002
X-Proofpoint-ORIG-GUID: 4WjkODYHC-vpblnZNOllukXl0M_3V0jk
X-Proofpoint-GUID: 4WjkODYHC-vpblnZNOllukXl0M_3V0jk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sandipan,

On 11/6/24 1:58 AM, Sandipan Das wrote:

[snip]

>> @@ -4830,6 +4966,20 @@ static int kvm_get_msrs(X86CPU *cpu)
>>          case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>>              env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
>>              break;
>> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + 3:
> 
> The upper bound is very unlikely to change but rewriting MSR_K7_EVNTSEL0 + 3 as
> MSR_K7_EVNTSEL0 + AMD64_NUM_COUNTERS - 1 may be more readable. Same applies to
> MSR_K7_PERFCTR below.
> 
>> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
>> +            break;
>> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + 3:
>> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
>> +            break;
>> +        case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTL0 + 0xb:
> 
> Same as above except this one needs AMD64_NUM_COUNTERS_CORE * 2 - 1.

Unlike the AMD PMU K7, I assume it is more likely the number of counters may be
changed in the future (so far it is still 6 on my test server with PerfMonV2).

I will make it more readable in v2 following your suggestion.

Thank you very much!

Dongli Zhang


