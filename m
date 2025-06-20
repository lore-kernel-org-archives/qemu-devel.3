Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91613C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWzk-0003Dx-3v; Fri, 20 Jun 2025 04:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uSWzi-0003DS-J2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:21:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uSWzd-00083S-EH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:21:06 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K020V9032195;
 Fri, 20 Jun 2025 01:20:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zen5H3QnpleSPHTRSH6ZGW5n3ZZN8NHPk7TZLdwsD
 kU=; b=pAOfXxQm2Ub3KiUPsObYN8ctgNrzKWtRYwYI+bBdgmsa+VSSFBgDG8q0t
 7xB9ijIdX8/n1Sh18KMtW8nqeo4zd3GPvCJWVw3Qqe2JRs14k0GG20bhDPt/9H/k
 qBsfUIs1NiV8RXgc9WbFlgPO5Dk2X1ONu8u3e2baG9FwtFfI44ZJ1GJUxZf0fKTP
 E7gMuVVB1SjBhCF8CRbTysHW2T879ucNT753Sopya1n3NqeEVJ9XXi8NwMXszsA0
 2LAmEJWehzSejjBelxkqKd8W5h5BCj5bcarexA21dA3BnuA1Y+TndvGEaOMS/f/g
 +6tikeOxXz2++U0x5yfCDKQfIG88Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 479508nufj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 01:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlYOqkopr11N45quhmBw5Y/+I9Vm9OdYJ5YcoHMMhs7qdMXYAiROqnvp0KsOQlx5P77+lsqGOgtODfb7WghBinl1y1bnAXjJe9mKEQ5PUw9FRVcQlG+shu79/5m8BfRqUcxluvpGNky5qabrmenaIr7ennaTr0m5Kj0ORkGuNmyKcqLGKNJPBd2S6i54jzcyEBV84wzGVOVaETObw4erOZ2q6i5rr3E0OfaGSHPT9CNa/LeihzbonjlUJVfEWV0nuVU2yUvi34+80WPcdcl5TAePyUSY8lAHW/98EsmPFCgxNCeOfmtiwYbFmnP215tVCtnwbY9nHA9UglATRT7TeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zen5H3QnpleSPHTRSH6ZGW5n3ZZN8NHPk7TZLdwsDkU=;
 b=cHgnrjLzldNQHmrAB1Hm0CBaNsNhj8/nxw0dN4pbAKsozfcmEKKRxwyrl///eV52AqGdFPi+q2tkD0Ji3F1VyMlIoG8m4RBryJlWoRuo+ySH6jVZZISam0uL7gJvPN1ssrAwUnMoGloJwadYFPeAGZu6funKM2+g27Os0xks3j9RXvxsPKTsATC3xVVK4J+xruSWLDh6JhR5/WJddQFSTeaHE+OeGXh2fHUEhTUO56xYdX9hULnRaRd6pI2KFA+yBsxOleTEDY7Kgs2ne71LXPHrAwPmD0BU3UHN/jj2SfGeNYgknxeqEPIoYdXwPBiuga7pF8cGKDeSXSNaQLxd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zen5H3QnpleSPHTRSH6ZGW5n3ZZN8NHPk7TZLdwsDkU=;
 b=atR9zUbEScto3NHeI8dY1kcE68WrDxX1nbTDSz2//fBGD31mL5804KD4cerqW6x3XfcENsrpNoeOjTRagn4NUrYItjLoCgoRIfAVYWB75TnyMVgvZShFdbqFKziALsvPcNAkNoEzTxNUNytsPAyt84laEsu+WUUEc+7ge6un3l0Zn10ptl/EKzAldCUBygybGTu0At1i9b0eh2lnUNEWIurZPk0M39UoyWX0T9Mf0XWo8/KLXFB1ql6unriTj593LSv2P+EEu5HRXCYi9w+ePFZJM7H/0v0X/J3Q4zfZhUi3e6MphJGc4l3QvOn/gYClZ2KYOYQu4A3XapYyyv0ahg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8567.namprd02.prod.outlook.com (2603:10b6:510:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:20:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 08:20:51 +0000
Message-ID: <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
Date: Fri, 20 Jun 2025 09:20:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] vfio-user client
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com> <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0641.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1c4075-1839-4be2-37df-08ddafd35e15
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BoSlRVZ01iYWRDRFlHMklNU1ZKcGk1R2dQbjZWVVVNazI1M3NwaGJzVEpG?=
 =?utf-8?B?bUhET2h4L3ROMTNmQ3pnTXBpMnYwRE52ZlBKeDNMRVhtcTNWWjhsRlVnTTZL?=
 =?utf-8?B?Njhvdmx5VEVuK0lEY3kzeVpab1o2cmtETXA5aDJGVllaSitaQ00zenlFMmJt?=
 =?utf-8?B?WWFpckhmeUM5T0h5akVldURaNWhTUXZvYkRtMEhncndJditBYnc4QldBQ09E?=
 =?utf-8?B?V0dpaTdHRDVBTEJVSkJuRWNlaThScVJGKzVLeVNrdHg3QUQ1UXMrUml0WDR3?=
 =?utf-8?B?bDg2WmwrR1NIN0h1RFJSZzZXTkpiYWxhOHd4OFlHNS8ybGNpZHBHR29rc0Vv?=
 =?utf-8?B?Vi9kcFJJQlJCNTJuVzQzcE1PR3RaK2FGcFJsU3lyNk5lWWFqdHRIa0dZUlAx?=
 =?utf-8?B?eTQySUxDTWR4MzA2M3FvanRCRVJsRGdWcFRJWk5vNjV3S0dZUjUwQVV1SFQy?=
 =?utf-8?B?U3l0U0ZtNGRNM2g5encvYzhNZExIMkplWERIQjhrRnlsWnhZUDVWcWV0dElm?=
 =?utf-8?B?TzdvSlpFM1ZTMUMrMmNEdFlSVUpQeUdlRUVLaGlLKy9XVDd4TmIrYStxSkpl?=
 =?utf-8?B?TTBBRllsUHdnUXdlMTh4Nk1yUWpscER3TkdVcU9QUGF5TDB4QkZoaFY4aTlJ?=
 =?utf-8?B?bDkyaUZ1MGUrb2VrYno2OUROcThZeTAvdnZPRGIyU3J1MXlEYTlsTFJoUHh2?=
 =?utf-8?B?Q1c4VW4xbHVUeEl4QVpmaGFFUjJ4SW9yWEt2MVBhQ0NldlZOeWtQNjlwc1dZ?=
 =?utf-8?B?WU53bjFVZ2tXODdIRkFkNVZDM3U5R1AzeHdKZXI5UGRHYTJJQndaODBxZEVP?=
 =?utf-8?B?SGtnRE1KRUtsMXlUNmJ4bUxHc1I3RndFcldZaUF3U3RVMGJGSWF2UHNtdmFm?=
 =?utf-8?B?QkZ1SkhDMnJrcEFRZmhGa2krV1BMSWhRajNvdG5zenptaTNzNHFGdi9JelND?=
 =?utf-8?B?WldGQ1d3bTRMc09JakRGRWR3TE9yN29lZVh5RHF6ZHMwMXphU2d6ZmkrNlRw?=
 =?utf-8?B?YXlYc1dBbTdoUmJSL2ppZDg2V1FBVndLTXRocE9EdnBDZjZIRjBiWHByaURl?=
 =?utf-8?B?SkN1VUwzd2JWTzRnclhNYk80OEZNTmRuTUpkR2EwNTN6NGltWEh5NldwNkd4?=
 =?utf-8?B?Q1pxbEFjVzFvMmhrdHAzaDFRN2JuMktzRXBiYW9xT2wwNk5Nd2h2b2h6TzBV?=
 =?utf-8?B?NG5meGRMMGRSN2FscllJNkszWU52YWFQY0dyRUZQYmIzYnpCU0doaU5kcXkw?=
 =?utf-8?B?azlaNkhQaVJHSnNIOU5IT0dKL0l0bFA5MldDT0xBVGdOOGNJRDgxUDU3aHMy?=
 =?utf-8?B?c3ZURjQ2MDI2VjhHekJWajQyTnR2VThXVUM1WDNacTVEV0k5RFdyRWgwZFpy?=
 =?utf-8?B?WU04dkFJcklrQkFrcUNLT0lodzQxdHBZMkVySi9mUmF5MFVaUSs2dHFUU0dx?=
 =?utf-8?B?QjRBa000b2NTdmRXdElZL0hSb3dFWnFhd1poV2lwMDdTbS9hTlZMWWZyd1Rk?=
 =?utf-8?B?WGdFKzdsYmhRaXU3eENIZGlmWVlMdGdyYVpLMkkyam82Uy8yNUw0ZDgzWXh2?=
 =?utf-8?B?VFlrL09CRHZSZmJXalNlYWVwbFRnZTc1TTRNYlpYeFpUaWZuZkl1VEI2RTBz?=
 =?utf-8?B?b0dvcDJ3aFZsbjFlQlJZL1ZVMUhUK2lGQkJveHZBRk9rT1UxZmRjQ1V1VllP?=
 =?utf-8?B?VkpJSWJlUE51SjlYdVJiSlZzcWFDNEZGNUdRUFRJeTkzbXRKRnRqa3Vta0RW?=
 =?utf-8?B?VXBUTndWQUp4N0tXQ1NkWko0OWFTYlB5U3NSMVJjY1l1NERWdG5rOTVveGRO?=
 =?utf-8?B?OFk1eTFZQ0ErSldxeS9nUmFrVEdQZ2pwVHpmWmxCM2IzUGhlRjE3Ulg2d1pn?=
 =?utf-8?B?UFUxVktUczEvaDJ4UXEycDlTeEZObzRvTGxtajZKNlR1RHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2YzYlVYaHNSMWZBbXVsNlQvVVJ1UGV3YWVRdXM0M3JURnBkb2g0WHdiSnFI?=
 =?utf-8?B?UHY3TkxFQWVmam9Qa1pPL2JpZktFamdYb244MlR0ZmVFRE5FbHNJVW1Da0dR?=
 =?utf-8?B?NGJzdFRxeU5aczVtQmlzZE9CSHA3Q08zN0lxMVJGdk92VlNhMEpVRTloRStl?=
 =?utf-8?B?VUZFRSs4RzVWWWhZb0ZEaGQxM08xYXVQNyszK1BjMzJYZFBrRDlTN2MzNVRj?=
 =?utf-8?B?OWpqMGVzS1BEUWlhOUFaOXBLUzh0N3lzMG1CbUJ4NThuYmFXL3ZFblZaSkxD?=
 =?utf-8?B?eS9Da1lMc2R1NXEzb01GcTkwRDJyN3YvMGd0QkRxbU92RkpIZG1GekU2TDR5?=
 =?utf-8?B?cHQ0bWxzT0gxRzJOMG9DdnJHM3NrRCtuZjNVTjN2TTBoamVTMW9MNnBPQ3o0?=
 =?utf-8?B?OHVKNks1VHhCd1pvRHdwalZvUTU5Rm1kT3A1UjNweVlQN2VQR0xFUG5nbnNl?=
 =?utf-8?B?NDMyWVE5WVlKRWNTdDQ3TEZhMDJ3eWNFQTVsUXBDblBBTmYrbEZtSWNvcXlJ?=
 =?utf-8?B?K2wvdVZaQVgydXRveXlGdjlVLzF4UE1PZERGdW5xdFYyTXdodVFUT3F0bEM0?=
 =?utf-8?B?SUx6N29aT0lkY0E4cDE2SzIyencrTmlnWHRvZDI5SENnVTJtRkRveHI5TTR2?=
 =?utf-8?B?WGxtTTNYQU1HOW5HeXJLc0xyQjliZUpSek1CbWdLVlM2YVJWWnRmaWRTdmxW?=
 =?utf-8?B?WlJISnBBbkl2Umc0K1BXOXVuOUpYcnBRWG9pZWNibHh5c0xjYi9yUXMrV3Uv?=
 =?utf-8?B?RzlZbnZ1elBHYUlsUm5VVldvTUNwbnlUcVAyZ3N4YkZjM2VwdTlCalJqVjNP?=
 =?utf-8?B?Z08zU3lQV1FMMG15ZVgrcXNyQXY0OUxFU3JpWUovNEVjK28za3doT2VqQzRM?=
 =?utf-8?B?MjRuaUoxSXRxbldkdmRhSEhIRkVHR2FvMDRKQ05ObHNROGRKSlhoclN6WHpS?=
 =?utf-8?B?RWlvbEpSS2xFaktHSGxOcnRHZllqczBjaVdjcktFcUhwdENKemVDQVd5dWsr?=
 =?utf-8?B?VGQ4TEE1eHFxdUlUU0FaUWpMU1BkUEh1aXBjWmNBeFBuZUpyUVJXQUZyTm9X?=
 =?utf-8?B?bUYxMXRWNU5TY2hEdWhxd0UvcDJTNFNDN05rbXJ1NHhRZ0pVSGNKK2hSaXVU?=
 =?utf-8?B?STBWaURzLzdkSzVVMktmT3Q3eEFzWDRFaXUrd2Y0RG5xOC9QTWhOOXJWaXFH?=
 =?utf-8?B?L0tTUlZ1SSt1ckYvaVVkM0dtcmp0ekZxa0trazZsREx3OGNrNTBzOENNWmVv?=
 =?utf-8?B?NFdGakw2RmYwLytRcXh4elBna1pRdDdmbGdWK1VnWUZsNkFjRE1ML2JYMmRm?=
 =?utf-8?B?NWdmcjlsdklxNms1QXltR05ubjdmQXpabVJBTCtrdGdoaTRoSUJWRDRianJl?=
 =?utf-8?B?U0tLNzBuWjNDcWFCaXRaVHgrYmJodzc2RFJDQ210VzFOZWhhcFlxNGM5SUw1?=
 =?utf-8?B?ZUpqU0FHUnFiUlo5aFJLQThYVU12d3g3ZGI2V1BuKzhwcytieUFZb0M0Vmx1?=
 =?utf-8?B?UUk2TXpBUmxrUlI3OXo4dzBoVDV4TmJrWmNmckFrNmhtZmYwQTlTTUdwZzk0?=
 =?utf-8?B?MldsbXR5cE4wQ2RKTEV3WFB4WFpLMEhVekQ4azFFWExLd3N2dkFabXRLV0RP?=
 =?utf-8?B?NzU1RGlQVlJ3YWtuNmkrOGo1V0ZyWGtjeDBNTndFU1F0Q0RsVzBzbXkxVFJu?=
 =?utf-8?B?czltVCt2b2IycnB0US9LeTJYTXNsNjcyVFJhakRZdXpOWm5FNGZuT1U5a0xF?=
 =?utf-8?B?Q0hOVUFHZjVORGthQi8vYVJqTDBSRnFCbUVpQVUyTzQvaSt3c0V0NUZtYm5T?=
 =?utf-8?B?QVB2VWtJYUJUM2Nwd2Zxd1ZmT003UGdOSTNzeHdnU3NzVnJybmt3aFlFQk96?=
 =?utf-8?B?S1U3WE9ZUkFIdzNUbzBzekFSV0dBR09OSm9NOHl3clVXU0lxTWFva0Mwa3JW?=
 =?utf-8?B?N0ZPc2ZmTGZMbXFrbThXVjJWOW13emhUMDMrOFgxNFp4eDdLemp5UVZyaHdq?=
 =?utf-8?B?Z0dhaGxzaTFlREk3N2lUckdUMG1YMUY2eTN3Q2kvalM3S05WTmNPMXVBU29G?=
 =?utf-8?B?MVpvNUx3ZTdFbkVnMFVCMnNDMjNwRURkLytvSHFwdkJzNzRXbHhtQXVwVEo4?=
 =?utf-8?B?TXUzelQxbUFXbm90WjNvYkFGVnZlelFOcDBxd3NhU2dBMzZBNnVtQmlKcnd0?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1c4075-1839-4be2-37df-08ddafd35e15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 08:20:51.0348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+VuXNFr2JdJFajgnR1f4o1DjNi+5RyoaeZXU+AFYMxNwqFpj28nYp/bdIUXZHRWK0RkMjJ4CK0ppiYbvoN30pdVKwKDAOkPByPRR2VaHJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8567
X-Authority-Analysis: v=2.4 cv=HaIUTjE8 c=1 sm=1 tr=0 ts=685519e8 cx=c_pps
 a=cREajeUs7dwWx3wSMBFr+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=cVvFDpPUuB9CfuH_leUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w4Pl2divYZz-esQbkcftwXR8E-3ZFAtJ
X-Proofpoint-ORIG-GUID: w4Pl2divYZz-esQbkcftwXR8E-3ZFAtJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MSBTYWx0ZWRfX0pV0JykDElC4
 WaPvDoMAdZ3vzyUqNkdSSa1+1refwiElhcW5UqgGLVejJeL3yBBi6dpdx3tHga24DhHh68gPxwL
 kaIB4dIlFo4ZxXlvvtmIJX2sG3MzX34sSKisfw7QWPo+Gd0f3KCST6hBe2V/ve2P3NZr16/wTyz
 8Qw0Iz+1MNROqUetNCzuKDR0AeRRs+jVlsPKSMZ1db+d5STCJRYFlFePJcQQ0q3DVcIBlx5UTuF
 hHxGe3KMZ9S3Bs8dW5ib9Iuly0LUR4hqvZWVu0yYlSFhOP215gCa4EHK/2skpT2nlEYbJwZuRor
 mFcF6U9kwjc8Z3GXb8j+cGM595EUICROTgeuxaENKrKZFx2/AnjAeSDmtvDPCZEYva8erriRk7c
 hNrmiv9ukmDfIn7cuSaGze9GLlwFXEnBudFsbjO6JFKhmde2SH3JreTL94b31GSA1j4DnwXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/06/2025 12:56, Cédric Le Goater wrote:

> Hi John,
> 
>>> I *really* would prefer if we had functional tests although I don't how
>>
>> I agree it makes sense to have a working functional test before merging.
> 
> Any progress ?

I've had to look at some other bits and pieces this week, but the basic 
status is sadly still unchanged - I have a test with 2 VMs, a client and 
server, that works fine when run by hand yet hangs when run within the 
functional test framework.

I do now have a VM with lots of extra debugging installed, but figuring 
out why I see these hangs is proving to be quite time intensive. If we 
could point you towards a manual image and some scripts, would that be 
sufficient for now?

>> In the meantime, I would like to continue with review of the main 
>> chunk - as you
>> said, there's a lot of code. I've not made substantial changes since 
>> v3 (only
>> the comments so far), so I'm happy to continue with v3 review, or if 
>> you prefer,
>> I can send out v4 against master. Please let me know.
> 
> I doubt we will have much more reviews on the vfio-user part. Can you
> please send v4 ?


ATB,

Mark.


