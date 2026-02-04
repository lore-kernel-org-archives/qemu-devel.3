Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE28E9538A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbGf-00084n-Bm; Wed, 04 Feb 2026 06:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbGd-00084K-5g; Wed, 04 Feb 2026 06:41:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbGY-0003NV-6y; Wed, 04 Feb 2026 06:41:54 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 614629iE3813015; Wed, 4 Feb 2026 03:41:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sV0riDJjCBzE7bCSZL1S9KFj5LCWqsPXUvAVY4N0u
 KI=; b=y/V5qG6oWz2p4Vw8mb8sjllUDl4NCsViSHrjKsnGei+kZo+XpXW6aO/pf
 N7y26oOT9HR/kabjntXYqDi8/+r3hnz1yt/Hx5BOsCvZ59Qop+K1mtIsZnbnEw//
 G4TPx0qZs1+rRtu6QsgyOdC1XBHSol0IwnchQ7I466OcwXepK5g4UurTe2vzX3eT
 2Wpwo2vnGarqjAwS+i+06DvOKS1qrdQPmUf/2krxlUpDeTIDM0K8QPWao8buIkWE
 rjl2kMz53RJoRAMepEc7gQQtNtXXUnGqXP0JlG5TQaTsBP6dNi1paWiQe4nt9Sde
 6PWHnRp3LA9rtdO3a4XeOennvKR9Q==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020119.outbound.protection.outlook.com [52.101.85.119])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3nvva66b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxVDFRK2biR4OSgnMQZ80zBybIPtcnXEZrZd6nkk2+ZtUfPazxjzlR4IAbC1WhJEv9NluAE6SuIun+cGO4WcF0JGLRyjMCxXgf/72V+bq8bYCBaB+atGBaEVCcPxZmNVGBMTj9FibCms2JFJb90wmxqdfN5EM7H1hjzBgXj4zYdqmXUKBdm9HB/ehYs3Elko673s2PQkDH9A5WhlJ87+mHorrGxjkYVX+YMuX7wsoMd5SOX9hupMnJ7RUhMIhRMkLfoVseyI0stpf+jJAF8I4OIccrCCVOlOm5wjcm7RKO+YRVm9iqc6EQoQtpGb3WbmPcwxfL1W16QBRAHhGUMyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV0riDJjCBzE7bCSZL1S9KFj5LCWqsPXUvAVY4N0uKI=;
 b=fp2xM6vF/TVFYz4kxp+OMwfTvgvERY4xIDykA8Djcctap8LG637yDGxa0SH3JVyTzcGRWJnrXrzJeyH1RgGxGFDQ5Ie4B1gYQ5b5K0bEFOZNkTPkMthzoXGRn+JVzLPd5neCUhHrP0KgfJoScBTeE4bsUe8rrdwICJArUT7/9TNHe8TE0JHlChELTCOfUmwf3AEc1SYrYWy7PE3ojam428N3DAZJL+DFcey0xtl6TjX9US33wWrvSw9mh/BmjXB1joa1Ana2O/PUN/6x41vNKHiLZeaez/Bz/+pXqDVUTfZ3cR4VcxPpvREoeNQZXfUZjSDkrRBbsr847a/K8UNyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV0riDJjCBzE7bCSZL1S9KFj5LCWqsPXUvAVY4N0uKI=;
 b=cWkeOZvukQWCeyHPUv6QXO7jbXSi2gM+jYCYgj478v89W1ivc70HzIH2DlWYdqYRTabL38zDTD8ZTER84R4iuRwpDXDjuhgH7IwsLC6WLAZsV0ELDQcJhAY9E3PSgZlkyh3qSWtFmqjY8EkIf4HOsLH8sw40+yYb4ew7/t6Y2rpvLDiZX+wv/ZFed+QntKnkGTO0O0F+LXhJHF7wLNWa6DYvBfoSMFoGVQgFEDwx320ei6B/g9KBGOGNND5dF/n3nXo60jqx2/D77XPpJ++lfg/7rKVB5W99Or+XV1kQZrT7z5deuTWlYDBGBIVdPga3wxsr/AyU1tlGUMqvVTdGkA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10889.namprd02.prod.outlook.com (2603:10b6:8:269::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 4 Feb
 2026 11:41:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:41:44 +0000
Message-ID: <41aaa36a-89ed-4fdb-982c-73038e2dd097@nutanix.com>
Date: Wed, 4 Feb 2026 11:41:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/37] audio: make all the backend-specific APIs take the
 be
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-31-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-31-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0020.prod.exchangelabs.com (2603:10b6:805:b6::33)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 25714b56-fea7-41fa-361e-08de63e25eee
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3gzMWltK2FCUC90WUkzNiswUkxrY0FSWm02K3U4MlNUci93S2NTWk5wZVVy?=
 =?utf-8?B?WEF4VjZVTU5XQjZXZ1F0cHdwb3FzQzhPRmZvbjJYS0VVbnp3OXFvQmZkYnFv?=
 =?utf-8?B?VklZRDY1ZTg4dHNrTHYxbHZsYndEaUFVSHhoT3BYdC9ONmlKNXhJcUZuTElP?=
 =?utf-8?B?RXhHS1U1STZOakpHSG1lWCtWM3Q3cGh6MVB0azc0ak10OGRRcSsvQ1RWMjFM?=
 =?utf-8?B?b2hldUpxaWxkN2huOUVHRGxzVU5QeU5nSXErLzBLZDNvK1kzYTBTWUNJeElr?=
 =?utf-8?B?a0d0WGdwZjNieDUycjQwWWN4OXNvRGowc2hoZ2VreTArL3E0bjd5dW4xcGhN?=
 =?utf-8?B?aVpGLytSNjRXRlFiYUsxOGFVdUdpL3JRL2Y0WCtPMzhicjVReERnQk1GbHlw?=
 =?utf-8?B?S2hTcDFHMVlzdGVselZnQkpQaXhYV0RWcU03bXBzMmN6T0NpeDAzQmtvMFIy?=
 =?utf-8?B?Y1BTTUh1dnNPUTZjUFFtMHFBNzNyeUFKSnBZNDNtTmJVY0xPRzZHV2t6UUUy?=
 =?utf-8?B?SEtkZ2VRYzIydlFwdVJQdy9aeVpLdHdsV1ZmSkNycWt6YUlxVW4zakg5eEFZ?=
 =?utf-8?B?WHY1NFFlZmNqNVV4WTFRREVRUHZ5WUhRdUYxWFhPVlUraUsyYS9SMm5SNERL?=
 =?utf-8?B?UG85VE81M0YxalI0WWUvc0RVMjlkVzZQYXh1bFc2aEQ3bTZZV3BNRC9RelNT?=
 =?utf-8?B?SEF6VlVpSEhac1gzY0cxUFpMY3p1bmt3bU5xVXkvQnRncVFDQ0E0cVoweFp2?=
 =?utf-8?B?eWRKdzRZQ3NIU2xHT1Fxd2R4QmJNN1ZHd2pJYW1VRUlYb000NityTW9jSDFH?=
 =?utf-8?B?ZElvd2JEUzkyYlFyU3Z5bDdwZVVaMjA5b0h1eCtJV3R1dnk1Qk5RNGFjYUh4?=
 =?utf-8?B?U0t6R2pJMTRHb1FqNXFkVHBwUDJaeE14Y3hxQXRoOG9LOGlvTEUxTktuTDha?=
 =?utf-8?B?TVNHMEExaGQ2OWVpWVBVdys0bUpsc1VtY0pLRTNuL3IzRjA3elE3cm9hZXY4?=
 =?utf-8?B?V2kzZnhOWEFaTzlaNzRBd3MxNG52N05LTG55cmZtSlJtVDUrUy9aYURYR0Jh?=
 =?utf-8?B?V3NGNktWTVlpTlZJUGtjZkpQQWY2azVRTDBNbXpkK1lNMFVtbzZNdlN0K2o5?=
 =?utf-8?B?bG51UzBFTUV0Mm4vN3ZEdG5nZ2dMdGF1a2NuR0dvbms3VGNXUnpETk0rVkJa?=
 =?utf-8?B?RGdIMjE0a0ZyYkVXS3kwWmV6UThpQ1dIZlpnaExhZjQwcDdHOE9BQkdPWkNq?=
 =?utf-8?B?dHR3aWNYNFJWbzdtalZxUk5rRmlSbTlkTGY0YVRVem5WSHFaeVphZzhqTEgv?=
 =?utf-8?B?WG96cDdLSFp3cVQ3MC95WG52dENzOVg2L3pqRDhWSE5Nb25rOVY0blk3SzFQ?=
 =?utf-8?B?N2kwSWxOeEpuNUJ5WURIMTU2MUFlcnRRbUc3eWpiRkpNTXhGMmV3TTlCcm1K?=
 =?utf-8?B?OFR0cFM5U1owdnFlci9NNlVMY3UvWkVHWWFrTnF6UTZiOG9SemJLVXIxaGVS?=
 =?utf-8?B?QmQvRzdENytyS2grSjYrbVpKRy9SS1FqalNtdCtSVUVJVjk0SlEvb0RkL2sz?=
 =?utf-8?B?VjZXMWVPZmRxa1ZZZUVkUnZCTmFxZkpoQUczOXFScE85Y3JwdkN3L2V5UitW?=
 =?utf-8?B?STdORWNFNmkzeUlDNUJnVDJxTEx1azEweXhZVUVJcG02ajZ6MkdpT0svK24r?=
 =?utf-8?B?aFZVajBCM3hreDR2OXFNMy8rSjNvL1p4RTlWajZrTzRYbGNBbGVuYTNPc2o1?=
 =?utf-8?B?c3NGeEZPK3paVHJCSnFGckRKbVBPZ2ZyRHRYMDRjUk8rdDR6RVJGdGZBYU1l?=
 =?utf-8?B?emt1VEE2UWxZTExYK0VpOHduSWJ5MjJTM3BreTViK3Ric0RWeUcyRDJjZk5m?=
 =?utf-8?B?a2ZzbS8rakhTZm9iMXdSWXFVL3lBcVU1VHpTM1YxSy90cE5FVWFocHhnOGQ0?=
 =?utf-8?B?S2pqSUpQckpVQVIyMmVWMFlkcXNGL1pUZGl5U1pqNXRkNDRpMkhDQWZJMDlE?=
 =?utf-8?B?WkR5cmZCYi9VOE8ySm1oQm9WSVB5Ymx6aHM1WUtqcC9DdHVSVjZpeUcrNWZM?=
 =?utf-8?B?OFlpRzlDMmpiblk0NlZXdVNEb3RVS0RWak5XNThhblBMZWRBUXFmYWxiVGFO?=
 =?utf-8?Q?i+OY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxFTnh5YjNtU09XOFAralQ2aEptNVF4a3N2R2VucS80MEIwbnZhTU5hZUpx?=
 =?utf-8?B?bFo0UG5xSkdUN0h6eUtveGNqcWh0L05Fb2pCTnlJN0RaZHJpekFrL1o5aW1P?=
 =?utf-8?B?RGNCSUxlaHUrSEFqR1dybUJIYXp1WGFDS1N2Rm91MDcyMnF1LzVUb1A1L1NM?=
 =?utf-8?B?RVZtdXpwS1ZkVlZHRXlrdlhOV1RaUEcrZjBUaVp4ZDBXVk1RVVZ4TmNob0ZT?=
 =?utf-8?B?Z2t1cHYxTW1IMmcwWWNoMHZ2U1lRZmI2bDdNbHRqZFZ1YXJuZDBlWWVWd3ov?=
 =?utf-8?B?dmcyYlJxWEdrcFRJNUNUQWpKWE1sV0g0Ulg4V0hZUHBGMytoYzlsL21nMm5H?=
 =?utf-8?B?YVZRM0YrNXJic2pqN0duM2JUbUlCcys0bDIycTVkTmliSGhOMDJHNU53VHI2?=
 =?utf-8?B?dXZLRlZTVUd0b2FDN09rSnpJUUlDcWxLclVIQ1JSRlNNUy9Sa0hzZW8vZll1?=
 =?utf-8?B?dEF5MUNwbXZ5dldrcTFlNTIrVzJMcnh3c3NWdUdrZnNKU20vTVFMbitUd3NW?=
 =?utf-8?B?Rmsva0JNblZDYkxvc0ErcCtaekhxa0M2Qy8rc3NXWFJRQ284dERyWUdCc05F?=
 =?utf-8?B?UkIweTErNnpHV2poMVVrSlpURFVaQVpNSTdETk5pTndDVC9pbE1WTksyeWQ4?=
 =?utf-8?B?emZRRWVIR0Q5dEVsbXV0aHEvdFQ1REVUWkhmVm5yNTlsWWVIYjBYcDVBS1g2?=
 =?utf-8?B?RE5Ydm5MNkNmMzNrbnFOTlhpMHczWFJ1UzUxYmVScjRHTnNSZ0tiNmVWUEkx?=
 =?utf-8?B?OG9kNTloUUM1eXhiZHlxRWQ5QjVaZTJ5M3R3REhZUXhiaWhJOUYzZkx2OWlv?=
 =?utf-8?B?TEFpMkJCclkyT1d6SEhMYkZjc1JSZ3kweXhEcmJmWFVvK1RaQ0VJZTdnRXJY?=
 =?utf-8?B?Uk4yYkozc0FONUtIdEZlUU5McmxoU2pMYkQ2c0VCd0ZqQWtIZkFVdlR5d1dW?=
 =?utf-8?B?MTVkNlYwTGpHZmxRNmZiSmVEMlRCRStmZERwRUk4WTNWanYxeVJEZ0lNd2c5?=
 =?utf-8?B?Q1ZLQUo3aEpsclZwNmQvZXdjYTN2dDd2UmVLY3pHN0QvRmI0OXVKNDBtcEQz?=
 =?utf-8?B?UjBuMDgxSzJIY3V0SHBsTmptdE80bTVsNWhhd3M4aHpmQUpybzFTU1hIc0ZD?=
 =?utf-8?B?RTMyR1JqUm1jbUU3d0Z6Q3hBaTM2VEw2RVBBWVdWNWJnZkNHUEpienVnWGJC?=
 =?utf-8?B?OGVlc2pIdkY3WE50TFkxbzNNU0tFRWJvM2F1WWthMWoydy9MdTBPbVdLaTZt?=
 =?utf-8?B?RW04VC9LRkxZT2VsR1hIQTI4RkwvMmtlRkFxTEh0eUtqeFp4cmRISGNTbHBR?=
 =?utf-8?B?d0drWHpHdTZyVUxjUFNaOUJpeTVZdTVzaVB6ZjZYQkp6czUrRWQ2MnAzdUxQ?=
 =?utf-8?B?Q2V6Q3BuTTFEalJkT3VjRWl5aWk1Tk1MUFdORk5mRmpGY2VBZ1VYM0QzSEo1?=
 =?utf-8?B?R083QmVybVlvRytVZkdLU1Q2OExybkxTV21WbFlFMGw2ZkV1ZHZiRi9FZlBX?=
 =?utf-8?B?M0ZFd1ArbG1lVzJIcGNaQ0pvWGRHaVFzeURDMFdUOG53UUJmdlJMRWdnNDJP?=
 =?utf-8?B?TmFuVWw2R2ZHc2d0VjZTT3M1eHV5UXRhRDR3MG1kcnQ5N1orSXdDcEw0dyta?=
 =?utf-8?B?NVE3OGNZZUo0YkJGeDlFZnRNRXlRUjBWbVRJK2FpQnFoc0V4dThOUHB1RWZw?=
 =?utf-8?B?aHAzNXBiL0xscWNtSGlYY0hWRHo0NEJ2cnlqTVplL2tzTzJsTzZqUk05Z0N3?=
 =?utf-8?B?cFh2bE5LTGVxTUhiaDloWXd4dkpLaGd3SDZQWWJrUkkyTzZxdjlDa2JOOVZ1?=
 =?utf-8?B?aUNPY1VBMUticWUxN21IbjIxeE55ZTJFOEtrdjVYMElnSllpRXRtK2tPK01j?=
 =?utf-8?B?S3A1ZE85RFJVcnlsL3IwZnhlNVFwQmcycmhiTzVYWWJzOVhsYTdlT1FKSUFW?=
 =?utf-8?B?MGdvcXlWNzNhVFdYazdUMlpFV1JFSlltQmduTGhOSFZKSUZFcmVjdGkweXd5?=
 =?utf-8?B?UVVFbkRPWUpRV3RXN3ZNY0hZZkI0eEMxdWxZZ0pJK0RHay9JQytCZXNzMzRZ?=
 =?utf-8?B?ZnJFeERTOFoxY24yQVExTXYvZmFkWFUrQmdpVmpENG93anpLNmFJRm53S3Ni?=
 =?utf-8?B?cTZjRGEvQkJJUUVxV09jcFRVMHJNTEZ0Q0QrOGxtRTF6QVBRNVdVbDNwZlZT?=
 =?utf-8?B?dmdkeDUwa1NXRlo5QUY2WmtHUTg1bGo2dzBqQXR6VERwRGYwbS82bHJkVjcy?=
 =?utf-8?B?cUYyRTBDSE9Ca2xwUWtnbUcwZ1ZyVkJ1TDZ0S1lYVWxydzVHMTVWcVk2MmVs?=
 =?utf-8?B?cDhXTWYwRzBPVHdVanIzdExxM2RnY21hTGlsU3ozZFdjdW9MVVFnWTh6bTBz?=
 =?utf-8?Q?ARXdpaAk69stRBnw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25714b56-fea7-41fa-361e-08de63e25eee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:41:44.2062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDNZm9ooh179G03omiTX+tGAykFNClWC7tdGThcigtTdB2BsfXnkRak0RWDOjzKWlo4EoxyoKHC4UF0UC+oIG+ceuO4PZDEkwynLK24rCow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10889
X-Authority-Analysis: v=2.4 cv=MupfKmae c=1 sm=1 tr=0 ts=6983307a cx=c_pps
 a=S/VVeZWp6p+cRv86h7uDVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=S4E2XrDA0wYaV2BVI_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wdjBlBdydtSJNFRPJ3XLYR5goBBo8lXO
X-Proofpoint-ORIG-GUID: wdjBlBdydtSJNFRPJ3XLYR5goBBo8lXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX2hwjeGgySnkd
 pKGsU2q/wJBWBM6xQKokYxMqWg/MxWqAQ/o+R7ThJN3CVy0prvRSd+KvDwjJEwHhFZg4trdGk8x
 TI0QMVho9LPIy9k4XiCgDQXppRr/QbnzPixtYBlzGKvbAzyrCvAYfPoJYMYK8PUsa748kC4XdJb
 SatBW/0o/kdZF1b9MRlKH4f97k9wkN3xAiG/LkyQjRSFN0sTHICbAjm5JsrBKyaoJRKHFZqoRin
 GHW779zASnpkuFl2wBUkgZLD3GENsQOVD+xvgzjVvpuMmhiKgR8ERFuYfdM9eydnIfSLjZStBnL
 dSW2kXeUjrZ/lfVTC8PBvqpVnBYVOpdSXqtkq9ECjJAPuVN4PFrrqr8DbtXxuAQhQreVgAq7GEe
 2hTnOuK4IF0eAfJf183vmlx//LmiZZahdg4maI/4zDUa8Dl4RsX4Nr228AzX59ku2znoj2XvYb0
 +KcNVxoFV4VfeV87jlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to dispatch to different implementations next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h       |  2 +-
>   include/qemu/audio-capture.h |  9 ++--
>   include/qemu/audio.h         | 34 ++++++++-------
>   audio/audio.c                | 18 ++++----
>   audio/wavcapture.c           |  7 ++-
>   hw/audio/ac97.c              | 24 +++++------
>   hw/audio/adlib.c             |  9 ++--
>   hw/audio/asc.c               | 16 +++----
>   hw/audio/cs4231a.c           | 16 +++----
>   hw/audio/es1370.c            | 12 +++---
>   hw/audio/gus.c               |  9 ++--
>   hw/audio/hda-codec.c         | 20 +++++----
>   hw/audio/lm4549.c            | 12 +++---
>   hw/audio/pcspk.c             |  4 +-
>   hw/audio/sb16.c              | 14 +++---
>   hw/audio/via-ac97.c          | 14 +++---
>   hw/audio/virtio-snd.c        | 14 +++---
>   hw/audio/wm8750.c            | 24 +++++------
>   hw/display/xlnx_dp.c         | 10 ++---
>   hw/usb/dev-audio.c           | 12 +++---
>   tests/audio/test-audio.c     | 83 ++++++++++++++++++------------------
>   ui/vnc.c                     |  2 +-
>   22 files changed, 192 insertions(+), 173 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 512abbfe22f..33f2ff432eb 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -569,7 +569,7 @@ SW *glue (AUD_open_, TYPE) (
>       return NULL;
>   }
>   
> -bool glue(AUD_is_active_, TYPE)(SW *sw)
> +bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
>   {
>       return sw ? sw->active : 0;
>   }
> diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
> index a07412db857..f500b0a7f8c 100644
> --- a/include/qemu/audio-capture.h
> +++ b/include/qemu/audio-capture.h
> @@ -36,8 +36,11 @@ CaptureVoiceOut *AUD_add_capture(
>       AudioBackend *be,
>       struct audsettings *as,
>       struct audio_capture_ops *ops,
> -    void *opaque
> -    );
> -void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
> +    void *opaque);
> +
> +void AUD_del_capture(
> +    AudioBackend *be,
> +    CaptureVoiceOut *cap,
> +    void *cb_opaque);
>   
>   #endif /* QEMU_AUDIO_CAPTURE_H */
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 03ce9adbc88..e87708e3d1e 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -63,7 +63,7 @@ typedef struct AudioBackendClass {
>   
>   bool AUD_backend_check(AudioBackend **be, Error **errp);
>   
> -SWVoiceOut *AUD_open_out (
> +SWVoiceOut *AUD_open_out(
>       AudioBackend *be,
>       SWVoiceOut *sw,
>       const char *name,
> @@ -72,11 +72,11 @@ SWVoiceOut *AUD_open_out (
>       const struct audsettings *settings
>       );
>   
> -void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
> -size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
> -int  AUD_get_buffer_size_out (SWVoiceOut *sw);
> -void AUD_set_active_out(SWVoiceOut *sw, bool on);
> -bool AUD_is_active_out(SWVoiceOut *sw);
> +void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
> +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
> +int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
> +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
> +bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
>   
>   #define AUDIO_MAX_CHANNELS 16
>   typedef struct Volume {
> @@ -85,19 +85,23 @@ typedef struct Volume {
>       uint8_t vol[AUDIO_MAX_CHANNELS];
>   } Volume;
>   
> -void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
> -void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
> +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
> +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
>   
>   static inline void
> -AUD_set_volume_out_lr(SWVoiceOut *sw, bool mut, uint8_t lvol, uint8_t rvol) {
> -    AUD_set_volume_out(sw, &(Volume) {
> +AUD_set_volume_out_lr(AudioBackend *be, SWVoiceOut *sw,
> +                      bool mut, uint8_t lvol, uint8_t rvol)
> +{
> +    AUD_set_volume_out(be, sw, &(Volume) {
>           .mute = mut, .channels = 2, .vol = { lvol, rvol }
>       });
>   }
>   
>   static inline void
> -AUD_set_volume_in_lr(SWVoiceIn *sw, bool mut, uint8_t lvol, uint8_t rvol) {
> -    AUD_set_volume_in(sw, &(Volume) {
> +AUD_set_volume_in_lr(AudioBackend *be, SWVoiceIn *sw,
> +                     bool mut, uint8_t lvol, uint8_t rvol)
> +{
> +    AUD_set_volume_in(be, sw, &(Volume) {
>           .mute = mut, .channels = 2, .vol = { lvol, rvol }
>       });
>   }
> @@ -112,9 +116,9 @@ SWVoiceIn *AUD_open_in(
>       );
>   
>   void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
> -size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
> -void AUD_set_active_in(SWVoiceIn *sw, bool on);
> -bool AUD_is_active_in(SWVoiceIn *sw);
> +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *pcm_buf, size_t size);
> +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on);
> +bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw);
>   
>   void audio_cleanup(void);
>   
> diff --git a/audio/audio.c b/audio/audio.c
> index a03ca397d33..6bfec5e1d75 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -846,7 +846,7 @@ static void audio_timer (void *opaque)
>   /*
>    * Public API
>    */
> -size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
> +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
>   {
>       HWVoiceOut *hw;
>   
> @@ -868,7 +868,7 @@ size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
>       }
>   }
>   
> -size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
> +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
>   {
>       HWVoiceIn *hw;
>   
> @@ -890,7 +890,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
>       }
>   }
>   
> -int AUD_get_buffer_size_out(SWVoiceOut *sw)
> +int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       if (!sw) {
>           return 0;
> @@ -903,7 +903,7 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
>       return sw->hw->samples * sw->hw->info.bytes_per_frame;
>   }
>   
> -void AUD_set_active_out(SWVoiceOut *sw, bool on)
> +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
>   {
>       HWVoiceOut *hw;
>   
> @@ -951,7 +951,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
>       }
>   }
>   
> -void AUD_set_active_in(SWVoiceIn *sw, bool on)
> +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>   {
>       HWVoiceIn *hw;
>   
> @@ -996,7 +996,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
>       }
>   }
>   
> -static size_t audio_get_avail (SWVoiceIn *sw)
> +static size_t audio_get_avail(SWVoiceIn *sw)
>   {
>       size_t live;
>   
> @@ -1937,7 +1937,7 @@ CaptureVoiceOut *AUD_add_capture(
>       return cap;
>   }
>   
> -void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
> +void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
>   {
>       struct capture_callback *cb;
>   
> @@ -1976,7 +1976,7 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
>       }
>   }
>   
> -void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
> +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
>   {
>       if (sw) {
>           HWVoiceOut *hw = sw->hw;
> @@ -1992,7 +1992,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
>       }
>   }
>   
> -void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
> +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
>   {
>       if (sw) {
>           HWVoiceIn *hw = sw->hw;
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index b33a38ff45b..2950ceaf242 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -1,4 +1,5 @@
>   #include "qemu/osdep.h"
> +#include "qemu/audio.h"
>   #include "qemu/qemu-print.h"
>   #include "qemu/error-report.h"
>   #include "audio_int.h"
> @@ -10,6 +11,7 @@ typedef struct {
>       int freq;
>       int bits;
>       int nchannels;
> +    AudioBackend *audio_be;
>       CaptureVoiceOut *cap;
>   } WAVState;
>   
> @@ -84,7 +86,7 @@ static void wav_capture_destroy (void *opaque)
>   {
>       WAVState *wav = opaque;
>   
> -    AUD_del_capture (wav->cap, wav);
> +    AUD_del_capture(wav->audio_be, wav->cap, wav);
>       g_free (wav);
>   }
>   
> @@ -159,6 +161,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
>           return -1;
>       }
>   
> +    wav->audio_be = state;
>       wav->path = g_strdup (path);
>       wav->bits = bits;
>       wav->nchannels = nchannels;
> @@ -169,7 +172,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
>           goto error_free;
>       }
>   
> -    cap = AUD_add_capture(state, &as, &ops, wav);
> +    cap = AUD_add_capture(wav->audio_be, &as, &ops, wav);
>       if (!cap) {
>           error_report("Failed to add audio capture");
>           goto error_free;
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 0694f0adf9c..65a4141b8af 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -246,15 +246,15 @@ static void voice_set_active(AC97LinkState *s, int bm_index, int on)
>   {
>       switch (bm_index) {
>       case PI_INDEX:
> -        AUD_set_active_in(s->voice_pi, on);
> +        AUD_set_active_in(s->audio_be, s->voice_pi, on);
>           break;
>   
>       case PO_INDEX:
> -        AUD_set_active_out(s->voice_po, on);
> +        AUD_set_active_out(s->audio_be, s->voice_po, on);
>           break;
>   
>       case MC_INDEX:
> -        AUD_set_active_in(s->voice_mc, on);
> +        AUD_set_active_in(s->audio_be, s->voice_mc, on);
>           break;
>   
>       default:
> @@ -378,15 +378,15 @@ static void reset_voices(AC97LinkState *s, uint8_t active[LAST_INDEX])
>   
>       freq = mixer_load(s, AC97_PCM_LR_ADC_Rate);
>       open_voice(s, PI_INDEX, freq);
> -    AUD_set_active_in(s->voice_pi, active[PI_INDEX]);
> +    AUD_set_active_in(s->audio_be, s->voice_pi, active[PI_INDEX]);
>   
>       freq = mixer_load(s, AC97_PCM_Front_DAC_Rate);
>       open_voice(s, PO_INDEX, freq);
> -    AUD_set_active_out(s->voice_po, active[PO_INDEX]);
> +    AUD_set_active_out(s->audio_be, s->voice_po, active[PO_INDEX]);
>   
>       freq = mixer_load(s, AC97_MIC_ADC_Rate);
>       open_voice(s, MC_INDEX, freq);
> -    AUD_set_active_in(s->voice_mc, active[MC_INDEX]);
> +    AUD_set_active_in(s->audio_be, s->voice_mc, active[MC_INDEX]);
>   }
>   
>   static void get_volume(uint16_t vol, uint16_t mask, int inverse,
> @@ -416,7 +416,7 @@ static void update_combined_volume_out(AC97LinkState *s)
>       lvol = (lvol * plvol) / 255;
>       rvol = (rvol * prvol) / 255;
>   
> -    AUD_set_volume_out_lr(s->voice_po, mute, lvol, rvol);
> +    AUD_set_volume_out_lr(s->audio_be, s->voice_po, mute, lvol, rvol);
>   }
>   
>   static void update_volume_in(AC97LinkState *s)
> @@ -427,7 +427,7 @@ static void update_volume_in(AC97LinkState *s)
>       get_volume(mixer_load(s, AC97_Record_Gain_Mute), 0x0f, 0,
>                  &mute, &lvol, &rvol);
>   
> -    AUD_set_volume_in_lr(s->voice_pi, mute, lvol, rvol);
> +    AUD_set_volume_in_lr(s->audio_be, s->voice_pi, mute, lvol, rvol);
>   }
>   
>   static void set_volume(AC97LinkState *s, int index, uint32_t val)
> @@ -904,7 +904,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
>           int copied;
>           to_copy = MIN(temp, sizeof(tmpbuf));
>           pci_dma_read(&s->dev, addr, tmpbuf, to_copy);
> -        copied = AUD_write(s->voice_po, tmpbuf, to_copy);
> +        copied = AUD_write(s->audio_be, s->voice_po, tmpbuf, to_copy);
>           dolog("write_audio max=%x to_copy=%x copied=%x",
>                 max, to_copy, copied);
>           if (!copied) {
> @@ -948,7 +948,7 @@ static void write_bup(AC97LinkState *s, int elapsed)
>       while (elapsed) {
>           int temp = MIN(elapsed, sizeof(s->silence));
>           while (temp) {
> -            int copied = AUD_write(s->voice_po, s->silence, temp);
> +            int copied = AUD_write(s->audio_be, s->voice_po, s->silence, temp);
>               if (!copied) {
>                   return;
>               }
> @@ -978,7 +978,7 @@ static int read_audio(AC97LinkState *s, AC97BusMasterRegs *r,
>       while (temp) {
>           int acquired;
>           to_copy = MIN(temp, sizeof(tmpbuf));
> -        acquired = AUD_read(voice, tmpbuf, to_copy);
> +        acquired = AUD_read(s->audio_be, voice, tmpbuf, to_copy);
>           if (!acquired) {
>               *stop = 1;
>               break;
> @@ -1275,7 +1275,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
>       AC97LinkState *s = AC97(dev);
>       uint8_t *c = s->dev.config;
>   
> -    if (!AUD_backend_check (&s->audio_be, errp)) {
> +    if (!AUD_backend_check(&s->audio_be, errp)) {
>           return;
>       }
>   
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index f79654627f5..dd5d9cf6772 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -95,7 +95,7 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
>       int a = nport & 3;
>   
>       s->active = 1;
> -    AUD_set_active_out (s->voice, 1);
> +    AUD_set_active_out(s->audio_be, s->voice, 1);
>   
>       adlib_kill_timers (s);
>   
> @@ -143,7 +143,8 @@ static int write_audio (AdlibState *s, int samples)
>           int nbytes, wbytes, wsampl;
>   
>           nbytes = samples << SHIFT;
> -        wbytes = AUD_write (
> +        wbytes = AUD_write(
> +            s->audio_be,
>               s->voice,
>               s->mixbuf + (pos << (SHIFT - 1)),
>               nbytes
> @@ -255,7 +256,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
>       as.fmt = AUDIO_FORMAT_S16;
>       as.endianness = HOST_BIG_ENDIAN;
>   
> -    s->voice = AUD_open_out (
> +    s->voice = AUD_open_out(
>           s->audio_be,
>           s->voice,
>           "adlib",
> @@ -269,7 +270,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    s->samples = AUD_get_buffer_size_out (s->voice) >> SHIFT;
> +    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> SHIFT;
>       s->mixbuf = g_malloc0 (s->samples << SHIFT);
>   
>       adlib_portio_list[0].offset = s->port;
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index a934c2e82c0..43cd51939a3 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -355,12 +355,12 @@ static void asc_out_cb(void *opaque, int free_b)
>                * loop because the FIFO has run out of data, and the driver
>                * reuses the stale content in its circular audio buffer.
>                */
> -            AUD_write(s->voice, s->silentbuf, samples << s->shift);
> +            AUD_write(s->audio_be, s->voice, s->silentbuf, samples << s->shift);
>           }
>           return;
>       }
>   
> -    AUD_write(s->voice, s->mixbuf, generated << s->shift);
> +    AUD_write(s->audio_be, s->voice, s->mixbuf, generated << s->shift);
>   }
>   
>   static uint64_t asc_fifo_read(void *opaque, hwaddr addr,
> @@ -470,9 +470,9 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
>               asc_fifo_reset(&s->fifos[1]);
>               asc_lower_irq(s);
>               if (value != 0) {
> -                AUD_set_active_out(s->voice, 1);
> +                AUD_set_active_out(s->audio_be, s->voice, 1);
>               } else {
> -                AUD_set_active_out(s->voice, 0);
> +                AUD_set_active_out(s->audio_be, s->voice, 0);
>               }
>           }
>           break;
> @@ -489,7 +489,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
>           {
>               int vol = (value & 0xe0);
>   
> -            AUD_set_volume_out_lr(s->voice, 0, vol, vol);
> +            AUD_set_volume_out_lr(s->audio_be, s->voice, 0, vol, vol);
>               break;
>           }
>       }
> @@ -545,7 +545,7 @@ static int asc_post_load(void *opaque, int version)
>       ASCState *s = ASC(opaque);
>   
>       if (s->regs[ASC_MODE] != 0) {
> -        AUD_set_active_out(s->voice, 1);
> +        AUD_set_active_out(s->audio_be, s->voice, 1);
>       }
>   
>       return 0;
> @@ -614,7 +614,7 @@ static void asc_reset_hold(Object *obj, ResetType type)
>   {
>       ASCState *s = ASC(obj);
>   
> -    AUD_set_active_out(s->voice, 0);
> +    AUD_set_active_out(s->audio_be, s->voice, 0);
>   
>       memset(s->regs, 0, sizeof(s->regs));
>       asc_fifo_reset(&s->fifos[0]);
> @@ -658,7 +658,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
>       }
>   
>       s->shift = 1;
> -    s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
> +    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
>       s->mixbuf = g_malloc0(s->samples << s->shift);
>   
>       s->silentbuf = g_malloc(s->samples << s->shift);
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index 7489cf42b7d..3b8ed092fe4 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -327,7 +327,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>           goto error;
>       }
>   
> -    s->voice = AUD_open_out (
> +    s->voice = AUD_open_out(
>           s->audio_be,
>           s->voice,
>           "cs4231a",
> @@ -339,7 +339,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>       if (s->dregs[Interface_Configuration] & PEN) {
>           if (!s->dma_running) {
>               k->hold_DREQ(s->isa_dma, s->dma);
> -            AUD_set_active_out (s->voice, 1);
> +            AUD_set_active_out(s->audio_be, s->voice, 1);
>               s->transferred = 0;
>           }
>           s->dma_running = 1;
> @@ -347,7 +347,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>       else {
>           if (s->dma_running) {
>               k->release_DREQ(s->isa_dma, s->dma);
> -            AUD_set_active_out (s->voice, 0);
> +            AUD_set_active_out(s->audio_be, s->voice, 0);
>           }
>           s->dma_running = 0;
>       }
> @@ -356,7 +356,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
>    error:
>       if (s->dma_running) {
>           k->release_DREQ(s->isa_dma, s->dma);
> -        AUD_set_active_out (s->voice, 0);
> +        AUD_set_active_out(s->audio_be, s->voice, 0);
>       }
>   }
>   
> @@ -465,7 +465,7 @@ static void cs_write (void *opaque, hwaddr addr,
>                   if (s->dma_running) {
>                       IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
>                       k->release_DREQ(s->isa_dma, s->dma);
> -                    AUD_set_active_out (s->voice, 0);
> +                    AUD_set_active_out(s->audio_be, s->voice, 0);
>                       s->dma_running = 0;
>                   }
>               }
> @@ -551,11 +551,11 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
>   
>               for (i = 0; i < copied; ++i)
>                   linbuf[i] = s->tab[tmpbuf[i]];
> -            copied = AUD_write (s->voice, linbuf, copied << 1);
> +            copied = AUD_write(s->audio_be, s->voice, linbuf, copied << 1);
>               copied >>= 1;
>           }
>           else {
> -            copied = AUD_write (s->voice, tmpbuf, copied);
> +            copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
>           }
>   
>           temp -= copied;
> @@ -614,7 +614,7 @@ static int cs4231a_pre_load (void *opaque)
>       if (s->dma_running) {
>           IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
>           k->release_DREQ(s->isa_dma, s->dma);
> -        AUD_set_active_out (s->voice, 0);
> +        AUD_set_active_out(s->audio_be, s->voice, 0);
>       }
>       s->dma_running = 0;
>       return 0;
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 566f93f1eae..44b204730b5 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -411,7 +411,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
>   
>                   if (i == ADC_CHANNEL) {
>                       s->adc_voice =
> -                        AUD_open_in (
> +                        AUD_open_in(
>                               s->audio_be,
>                               s->adc_voice,
>                               "es1370.adc",
> @@ -421,7 +421,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
>                               );
>                   } else {
>                       s->dac_voice[i] =
> -                        AUD_open_out (
> +                        AUD_open_out(
>                               s->audio_be,
>                               s->dac_voice[i],
>                               i ? "es1370.dac2" : "es1370.dac1",
> @@ -438,9 +438,9 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
>               int on = (ctl & b->ctl_en) && !(sctl & b->sctl_pause);
>   
>               if (i == ADC_CHANNEL) {
> -                AUD_set_active_in (s->adc_voice, on);
> +                AUD_set_active_in(s->audio_be, s->adc_voice, on);
>               } else {
> -                AUD_set_active_out (s->dac_voice[i], on);
> +                AUD_set_active_out(s->audio_be, s->dac_voice[i], on);
>               }
>           }
>       }
> @@ -627,7 +627,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
>               int acquired, to_copy;
>   
>               to_copy = MIN(to_transfer, sizeof(tmpbuf));
> -            acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
> +            acquired = AUD_read(s->audio_be, s->adc_voice, tmpbuf, to_copy);
>               if (!acquired) {
>                   break;
>               }
> @@ -646,7 +646,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
>   
>               to_copy = MIN(to_transfer, sizeof(tmpbuf));
>               pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
> -            copied = AUD_write (voice, tmpbuf, to_copy);
> +            copied = AUD_write(s->audio_be, voice, tmpbuf, to_copy);
>               if (!copied) {
>                   break;
>               }
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index 69ddc419191..1ede1c4a51d 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -87,7 +87,8 @@ static int write_audio (GUSState *s, int samples)
>           int nbytes, wbytes, wsampl;
>   
>           nbytes = samples << s->shift;
> -        wbytes = AUD_write (
> +        wbytes = AUD_write(
> +            s->audio_be,
>               s->voice,
>               s->mixbuf + (pos << (s->shift - 1)),
>               nbytes
> @@ -257,7 +258,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>       as.fmt = AUDIO_FORMAT_S16;
>       as.endianness = HOST_BIG_ENDIAN;
>   
> -    s->voice = AUD_open_out (
> +    s->voice = AUD_open_out(
>           s->audio_be,
>           NULL,
>           "gus",
> @@ -272,7 +273,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>       }
>   
>       s->shift = 2;
> -    s->samples = AUD_get_buffer_size_out (s->voice) >> s->shift;
> +    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
>       s->mixbuf = g_malloc0 (s->samples << s->shift);
>   
>       isa_register_portio_list(d, &s->portio_list1, s->port,
> @@ -287,7 +288,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>       s->emu.opaque = s;
>       s->pic = isa_bus_get_irq(bus, s->emu.gusirq);
>   
> -    AUD_set_active_out (s->voice, 1);
> +    AUD_set_active_out(s->audio_be, s->voice, 1);
>   }
>   
>   static const Property gus_properties[] = {
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 6445d227594..0373d2f7271 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -275,7 +275,8 @@ static void hda_audio_input_cb(void *opaque, int avail)
>       while (to_transfer) {
>           uint32_t start = (uint32_t) (wpos & B_MASK);
>           uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
> -        uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
> +        uint32_t read = AUD_read(st->state->audio_be, st->voice.in,
> +                                 st->buf + start, chunk);
>           wpos += read;
>           to_transfer -= read;
>           st->wpos += read;
> @@ -354,7 +355,8 @@ static void hda_audio_output_cb(void *opaque, int avail)
>       while (to_transfer) {
>           uint32_t start = (uint32_t) (rpos & B_MASK);
>           uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
> -        uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
> +        uint32_t written = AUD_write(st->state->audio_be, st->voice.out,
> +                                     st->buf + start, chunk);
>           rpos += written;
>           to_transfer -= written;
>           st->rpos += written;
> @@ -375,7 +377,8 @@ static void hda_audio_compat_input_cb(void *opaque, int avail)
>   
>       while (avail - recv >= sizeof(st->compat_buf)) {
>           if (st->compat_bpos != sizeof(st->compat_buf)) {
> -            len = AUD_read(st->voice.in, st->compat_buf + st->compat_bpos,
> +            len = AUD_read(st->state->audio_be, st->voice.in,
> +                           st->compat_buf + st->compat_bpos,
>                              sizeof(st->compat_buf) - st->compat_bpos);
>               st->compat_bpos += len;
>               recv += len;
> @@ -408,7 +411,8 @@ static void hda_audio_compat_output_cb(void *opaque, int avail)
>               }
>               st->compat_bpos = 0;
>           }
> -        len = AUD_write(st->voice.out, st->compat_buf + st->compat_bpos,
> +        len = AUD_write(st->state->audio_be, st->voice.out,
> +                        st->compat_buf + st->compat_bpos,
>                           sizeof(st->compat_buf) - st->compat_bpos);
>           st->compat_bpos += len;
>           sent += len;
> @@ -440,9 +444,9 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
>           }
>       }
>       if (st->output) {
> -        AUD_set_active_out(st->voice.out, st->running);
> +        AUD_set_active_out(st->state->audio_be, st->voice.out, st->running);
>       } else {
> -        AUD_set_active_in(st->voice.in, st->running);
> +        AUD_set_active_in(st->state->audio_be, st->voice.in, st->running);
>       }
>   }
>   
> @@ -466,9 +470,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
>           return;
>       }
>       if (st->output) {
> -        AUD_set_volume_out_lr(st->voice.out, muted, left, right);
> +        AUD_set_volume_out_lr(st->state->audio_be, st->voice.out, muted, left, right);
>       } else {
> -        AUD_set_volume_in_lr(st->voice.in, muted, left, right);
> +        AUD_set_volume_in_lr(st->state->audio_be, st->voice.in, muted, left, right);
>       }
>   }
>   
> diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
> index f85226d1ac5..b875e83d454 100644
> --- a/hw/audio/lm4549.c
> +++ b/hw/audio/lm4549.c
> @@ -101,11 +101,11 @@ static void lm4549_audio_transfer(lm4549_state *s)
>       uint32_t i;
>   
>       /* Activate the voice */
> -    AUD_set_active_out(s->voice, 1);
> +    AUD_set_active_out(s->audio_be, s->voice, 1);
>       s->voice_is_active = 1;
>   
>       /* Try to write the buffer content */
> -    written_bytes = AUD_write(s->voice, s->buffer,
> +    written_bytes = AUD_write(s->audio_be, s->voice, s->buffer,
>                                 s->buffer_level * sizeof(uint16_t));
>       written_samples = written_bytes >> 1;
>   
> @@ -129,14 +129,14 @@ static void lm4549_audio_out_callback(void *opaque, int free)
>       static uint32_t prev_buffer_level;
>   
>   #ifdef LM4549_DEBUG
> -    int size = AUD_get_buffer_size_out(s->voice);
> +    int size = AUD_get_buffer_size_out(s->audio_be, s->voice);
>       DPRINTF("audio_out_callback size = %i free = %i\n", size, free);
>   #endif
>   
>       /* Detect that no data are consumed
>          => disable the voice */
>       if (s->buffer_level == prev_buffer_level) {
> -        AUD_set_active_out(s->voice, 0);
> +        AUD_set_active_out(s->audio_be, s->voice, 0);
>           s->voice_is_active = 0;
>       }
>       prev_buffer_level = s->buffer_level;
> @@ -285,7 +285,7 @@ static int lm4549_post_load(void *opaque, int version_id)
>   
>       /* Request data */
>       if (s->voice_is_active == 1) {
> -        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->voice));
> +        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->audio_be, s->voice));
>       }
>   
>       return 0;
> @@ -323,7 +323,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
>           &as
>       );
>   
> -    AUD_set_volume_out_lr(s->voice, 0, 255, 255);
> +    AUD_set_volume_out_lr(s->audio_be, s->voice, 0, 255, 255);
>   
>       s->voice_is_active = 0;
>   
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 916c56fa4c0..a74a263b37e 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -106,7 +106,7 @@ static void pcspk_callback(void *opaque, int free)
>   
>       while (free > 0) {
>           n = MIN(s->samples - s->play_pos, (unsigned int)free);
> -        n = AUD_write(s->voice, &s->sample_buf[s->play_pos], n);
> +        n = AUD_write(s->audio_be, s->voice, &s->sample_buf[s->play_pos], n);
>           if (!n)
>               break;
>           s->play_pos = (s->play_pos + n) % s->samples;
> @@ -164,7 +164,7 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
>       if (s->voice) {
>           if (gate) /* restart */
>               s->play_pos = 0;
> -        AUD_set_active_out(s->voice, gate & s->data_on);
> +        AUD_set_active_out(s->audio_be, s->voice, gate & s->data_on);
>       }
>   }
>   
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 3c5beb9dfa3..da0c33ea41b 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -185,11 +185,11 @@ static void control (SB16State *s, int hold)
>   
>       if (hold) {
>           k->hold_DREQ(isa_dma, dma);
> -        AUD_set_active_out (s->voice, 1);
> +        AUD_set_active_out(s->audio_be, s->voice, 1);
>       }
>       else {
>           k->release_DREQ(isa_dma, dma);
> -        AUD_set_active_out (s->voice, 0);
> +        AUD_set_active_out(s->audio_be, s->voice, 0);
>       }
>   }
>   
> @@ -215,7 +215,7 @@ static void continue_dma8 (SB16State *s)
>           as.fmt = s->fmt;
>           as.endianness = 0;
>   
> -        s->voice = AUD_open_out (
> +        s->voice = AUD_open_out(
>               s->audio_be,
>               s->voice,
>               "sb16",
> @@ -378,7 +378,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
>           as.fmt = s->fmt;
>           as.endianness = 0;
>   
> -        s->voice = AUD_open_out (
> +        s->voice = AUD_open_out(
>               s->audio_be,
>               s->voice,
>               "sb16",
> @@ -879,7 +879,7 @@ static void legacy_reset (SB16State *s)
>       as.fmt = AUDIO_FORMAT_U8;
>       as.endianness = 0;
>   
> -    s->voice = AUD_open_out (
> +    s->voice = AUD_open_out(
>           s->audio_be,
>           s->voice,
>           "sb16",
> @@ -1196,7 +1196,7 @@ static int write_audio (SB16State *s, int nchan, int dma_pos,
>           }
>   
>           copied = k->read_memory(isa_dma, nchan, tmpbuf, dma_pos, to_copy);
> -        copied = AUD_write (s->voice, tmpbuf, copied);
> +        copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
>   
>           temp -= copied;
>           dma_pos = (dma_pos + copied) % dma_len;
> @@ -1302,7 +1302,7 @@ static int sb16_post_load (void *opaque, int version_id)
>               as.fmt = s->fmt;
>               as.endianness = 0;
>   
> -            s->voice = AUD_open_out (
> +            s->voice = AUD_open_out(
>                   s->audio_be,
>                   s->voice,
>                   "sb16",
> diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
> index 019d2968534..5b344d7a0fc 100644
> --- a/hw/audio/via-ac97.c
> +++ b/hw/audio/via-ac97.c
> @@ -53,7 +53,7 @@ static void codec_volume_set_out(ViaAC97State *s)
>       rvol /= 255;
>       mute = CODEC_REG(s, AC97_Master_Volume_Mute) >> MUTE_SHIFT;
>       mute |= CODEC_REG(s, AC97_PCM_Out_Volume_Mute) >> MUTE_SHIFT;
> -    AUD_set_volume_out_lr(s->vo, mute, lvol, rvol);
> +    AUD_set_volume_out_lr(s->audio_be, s->vo, mute, lvol, rvol);
>   }
>   
>   static void codec_reset(ViaAC97State *s)
> @@ -189,7 +189,7 @@ static void out_cb(void *opaque, int avail)
>           while (temp) {
>               to_copy = MIN(temp, sizeof(tmpbuf));
>               pci_dma_read(&s->dev, c->addr, tmpbuf, to_copy);
> -            copied = AUD_write(s->vo, tmpbuf, to_copy);
> +            copied = AUD_write(s->audio_be, s->vo, tmpbuf, to_copy);
>               if (!copied) {
>                   stop = true;
>                   break;
> @@ -208,7 +208,7 @@ static void out_cb(void *opaque, int avail)
>                       c->stat |= STAT_PAUSED;
>                   } else {
>                       c->stat &= ~STAT_ACTIVE;
> -                    AUD_set_active_out(s->vo, 0);
> +                    AUD_set_active_out(s->audio_be, s->vo, 0);
>                   }
>                   if (c->type & STAT_EOL) {
>                       via_isa_set_irq(&s->dev, 0, 1);
> @@ -317,20 +317,20 @@ static void sgd_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>           break;
>       case 1:
>           if (val & CNTL_START) {
> -            AUD_set_active_out(s->vo, 1);
> +            AUD_set_active_out(s->audio_be, s->vo, 1);
>               s->aur.stat = STAT_ACTIVE;
>           }
>           if (val & CNTL_TERM) {
> -            AUD_set_active_out(s->vo, 0);
> +            AUD_set_active_out(s->audio_be, s->vo, 0);
>               s->aur.stat &= ~(STAT_ACTIVE | STAT_PAUSED);
>               s->aur.clen = 0;
>           }
>           if (val & CNTL_PAUSE) {
> -            AUD_set_active_out(s->vo, 0);
> +            AUD_set_active_out(s->audio_be, s->vo, 0);
>               s->aur.stat &= ~STAT_ACTIVE;
>               s->aur.stat |= STAT_PAUSED;
>           } else if (!(val & CNTL_PAUSE) && (s->aur.stat & STAT_PAUSED)) {
> -            AUD_set_active_out(s->vo, 1);
> +            AUD_set_active_out(s->audio_be, s->vo, 1);
>               s->aur.stat |= STAT_ACTIVE;
>               s->aur.stat &= ~STAT_PAUSED;
>           }
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 9101560f387..47fef61af88 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -463,7 +463,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>                                            stream,
>                                            virtio_snd_pcm_out_cb,
>                                            &as);
> -        AUD_set_volume_out_lr(stream->voice.out, 0, 255, 255);
> +        AUD_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
>       } else {
>           stream->voice.in = AUD_open_in(s->audio_be,
>                                           stream->voice.in,
> @@ -471,7 +471,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>                                           stream,
>                                           virtio_snd_pcm_in_cb,
>                                           &as);
> -        AUD_set_volume_in_lr(stream->voice.in, 0, 255, 255);
> +        AUD_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>       }
>   
>       return cpu_to_le32(VIRTIO_SND_S_OK);
> @@ -561,9 +561,9 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
>               stream->active = start;
>           }
>           if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
> -            AUD_set_active_out(stream->voice.out, start);
> +            AUD_set_active_out(s->audio_be, stream->voice.out, start);
>           } else {
> -            AUD_set_active_in(stream->voice.in, start);
> +            AUD_set_active_in(s->audio_be, stream->voice.in, start);
>           }
>       } else {
>           error_report("Invalid stream id: %"PRIu32, stream_id);
> @@ -1166,7 +1166,8 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>                   buffer->populated = true;
>               }
>               for (;;) {
> -                size = AUD_write(stream->voice.out,
> +                size = AUD_write(stream->s->audio_be,
> +                                 stream->voice.out,
>                                    buffer->data + buffer->offset,
>                                    MIN(buffer->size, available));
>                   assert(size <= MIN(buffer->size, available));
> @@ -1258,7 +1259,8 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>                       return_rx_buffer(stream, buffer);
>                       break;
>                   }
> -                size = AUD_read(stream->voice.in,
> +                size = AUD_read(stream->s->audio_be,
> +                        stream->voice.in,
>                           buffer->data + buffer->size,
>                           MIN(available, (stream->params.period_bytes -
>                                           buffer->size)));
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index 336fb6d20bd..bc347fe5376 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -72,7 +72,7 @@ static inline void wm8750_in_load(WM8750State *s)
>       if (s->idx_in + s->req_in <= sizeof(s->data_in))
>           return;
>       s->idx_in = MAX(0, (int) sizeof(s->data_in) - s->req_in);
> -    AUD_read(*s->in[0], s->data_in + s->idx_in,
> +    AUD_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
>                sizeof(s->data_in) - s->idx_in);
>   }
>   
> @@ -80,7 +80,7 @@ static inline void wm8750_out_flush(WM8750State *s)
>   {
>       int sent = 0;
>       while (sent < s->idx_out)
> -        sent += AUD_write(*s->out[0], s->data_out + sent, s->idx_out - sent)
> +        sent += AUD_write(s->audio_be, *s->out[0], s->data_out + sent, s->idx_out - sent)
>                   ?: s->idx_out;
>       s->idx_out = 0;
>   }
> @@ -145,30 +145,30 @@ static void wm8750_vol_update(WM8750State *s)
>   {
>       /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
>   
> -    AUD_set_volume_in_lr(s->adc_voice[0], s->mute,
> +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
>                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
>                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
> -    AUD_set_volume_in_lr(s->adc_voice[1], s->mute,
> +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
>                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
>                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
> -    AUD_set_volume_in_lr(s->adc_voice[2], s->mute,
> +    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
>                       s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
>                       s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
>   
>       /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
>   
>       /* Speaker: LOUT2VOL ROUT2VOL */
> -    AUD_set_volume_out_lr(s->dac_voice[0], s->mute,
> +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
>                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
>                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
>   
>       /* Headphone: LOUT1VOL ROUT1VOL */
> -    AUD_set_volume_out_lr(s->dac_voice[1], s->mute,
> +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
>                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
>                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
>   
>       /* MONOOUT: MONOVOL MONOVOL */
> -    AUD_set_volume_out_lr(s->dac_voice[2], s->mute,
> +    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
>                       s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
>                       s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
>   }
> @@ -182,9 +182,9 @@ static void wm8750_set_format(WM8750State *s)
>       wm8750_out_flush(s);
>   
>       if (s->in[0] && *s->in[0])
> -        AUD_set_active_in(*s->in[0], 0);
> +        AUD_set_active_in(s->audio_be, *s->in[0], 0);
>       if (s->out[0] && *s->out[0])
> -        AUD_set_active_out(*s->out[0], 0);
> +        AUD_set_active_out(s->audio_be, *s->out[0], 0);
>   
>       for (i = 0; i < IN_PORT_N; i ++)
>           if (s->adc_voice[i]) {
> @@ -235,9 +235,9 @@ static void wm8750_set_format(WM8750State *s)
>        * for mixing or combining paths to different ports, so we
>        * connect both channels to where the left channel is routed.  */
>       if (s->in[0] && *s->in[0])
> -        AUD_set_active_in(*s->in[0], 1);
> +        AUD_set_active_in(s->audio_be, *s->in[0], 1);
>       if (s->out[0] && *s->out[0])
> -        AUD_set_active_out(*s->out[0], 1);
> +        AUD_set_active_out(s->audio_be, *s->out[0], 1);
>   }
>   
>   static void wm8750_clk_update(WM8750State *s, int ext)
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index a24e95f0a73..deda7efe15d 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -331,7 +331,7 @@ static inline void xlnx_dp_audio_activate(XlnxDPState *s)
>   {
>       bool activated = ((s->core_registers[DP_TX_AUDIO_CONTROL]
>                      & DP_TX_AUD_CTRL) != 0);
> -    AUD_set_active_out(s->amixer_output_stream, activated);
> +    AUD_set_active_out(s->audio_be, s->amixer_output_stream, activated);
>       xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(0),
>                                         &s->audio_buffer_0);
>       xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(1),
> @@ -401,7 +401,7 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
>       /* Send the buffer through the audio. */
>       if (s->byte_left <= MAX_QEMU_BUFFER_SIZE) {
>           if (s->byte_left != 0) {
> -            written = AUD_write(s->amixer_output_stream,
> +            written = AUD_write(s->audio_be, s->amixer_output_stream,
>                                   &s->out_buffer[s->data_ptr], s->byte_left);
>           } else {
>                int len_to_copy;
> @@ -413,12 +413,12 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
>               while (avail) {
>                   len_to_copy = MIN(AUD_CHBUF_MAX_DEPTH, avail);
>                   memset(s->out_buffer, 0, len_to_copy);
> -                avail -= AUD_write(s->amixer_output_stream, s->out_buffer,
> +                avail -= AUD_write(s->audio_be, s->amixer_output_stream, s->out_buffer,
>                                      len_to_copy);
>               }
>           }
>       } else {
> -        written = AUD_write(s->amixer_output_stream,
> +        written = AUD_write(s->audio_be, s->amixer_output_stream,
>                               &s->out_buffer[s->data_ptr], MAX_QEMU_BUFFER_SIZE);
>       }
>       s->byte_left -= written;
> @@ -1401,7 +1401,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>                                              s,
>                                              xlnx_dp_audio_callback,
>                                              &as);
> -    AUD_set_volume_out_lr(s->amixer_output_stream, 0, 255, 255);
> +    AUD_set_volume_out_lr(s->audio_be, s->amixer_output_stream, 0, 255, 255);
>       xlnx_dp_audio_activate(s);
>       s->vblank = ptimer_init(vblank_hit, s, DP_VBLANK_PTIMER_POLICY);
>       ptimer_transaction_begin(s->vblank);
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index dfda2dccc04..0f36587fc6f 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -669,7 +669,7 @@ static void output_callback(void *opaque, int avail)
>               return;
>           }
>   
> -        written = AUD_write(s->out.voice, data, len);
> +        written = AUD_write(s->audio_be, s->out.voice, data, len);
>           avail -= written;
>           s->out.buf.cons += written;
>   
> @@ -683,7 +683,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
>   {
>       switch (altset) {
>       case ALTSET_OFF:
> -        AUD_set_active_out(s->out.voice, false);
> +        AUD_set_active_out(s->audio_be, s->out.voice, false);
>           break;
>       case ALTSET_STEREO:
>       case ALTSET_51:
> @@ -692,7 +692,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
>               usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
>           }
>           streambuf_init(&s->out.buf, s->buffer, s->out.channels);
> -        AUD_set_active_out(s->out.voice, true);
> +        AUD_set_active_out(s->audio_be, s->out.voice, true);
>           break;
>       default:
>           return -1;
> @@ -805,7 +805,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
>               }
>               fprintf(stderr, "\n");
>           }
> -        AUD_set_volume_out(s->out.voice, &s->out.vol);
> +        AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
>       }
>   
>       return ret;
> @@ -980,8 +980,8 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
>   
>       s->out.voice = AUD_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
>                                   s, output_callback, &s->out.as);
> -    AUD_set_volume_out(s->out.voice, &s->out.vol);
> -    AUD_set_active_out(s->out.voice, 0);
> +    AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
> +    AUD_set_active_out(s->audio_be, s->out.voice, 0);
>   }
>   
>   static const VMStateDescription vmstate_usb_audio = {
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> index e1e518df2a7..c05285967c1 100644
> --- a/tests/audio/test-audio.c
> +++ b/tests/audio/test-audio.c
> @@ -137,7 +137,7 @@ static void test_sine_callback(void *opaque, int avail)
>   
>       generate_sine_samples(buffer, frames_to_write, s->frames_written);
>   
> -    bytes_written = AUD_write(s->voice, buffer,
> +    bytes_written = AUD_write(s->be, s->voice, buffer,
>                                 frames_to_write * sizeof(int16_t) * CHANNELS);
>       s->frames_written += bytes_written / (sizeof(int16_t) * CHANNELS);
>   }
> @@ -158,7 +158,7 @@ static void test_audio_out_sine_wave(void)
>                                         &state, test_sine_callback);
>   
>       g_test_message("Playing 440Hz sine wave for %d seconds...", DURATION_SECS);
> -    AUD_set_active_out(state.voice, true);
> +    AUD_set_active_out(state.be, state.voice, true);
>   
>       /*
>        * Run the audio subsystem until all frames are written or timeout.
> @@ -183,7 +183,7 @@ static void test_audio_out_sine_wave(void)
>   
>       g_assert_cmpint(state.frames_written, ==, state.total_frames);
>   
> -    AUD_set_active_out(state.voice, false);
> +    AUD_set_active_out(state.be, state.voice, false);
>       AUD_close_out(state.be, state.voice);
>   }
>   
> @@ -219,13 +219,13 @@ static void test_audio_out_active_state(void)
>       be = get_test_audio_backend();
>       voice = open_test_voice_out(be, "test-active", NULL, dummy_audio_callback);
>   
> -    g_assert_false(AUD_is_active_out(voice));
> +    g_assert_false(AUD_is_active_out(be, voice));
>   
> -    AUD_set_active_out(voice, true);
> -    g_assert_true(AUD_is_active_out(voice));
> +    AUD_set_active_out(be, voice, true);
> +    g_assert_true(AUD_is_active_out(be, voice));
>   
> -    AUD_set_active_out(voice, false);
> -    g_assert_false(AUD_is_active_out(voice));
> +    AUD_set_active_out(be, voice, false);
> +    g_assert_false(AUD_is_active_out(be, voice));
>   
>       AUD_close_out(be, voice);
>   }
> @@ -239,13 +239,13 @@ static void test_audio_out_buffer_size(void)
>       be = get_test_audio_backend();
>       voice = open_test_voice_out(be, "test-buffer", NULL, dummy_audio_callback);
>   
> -    buffer_size = AUD_get_buffer_size_out(voice);
> +    buffer_size = AUD_get_buffer_size_out(be, voice);
>       g_test_message("Buffer size: %d bytes", buffer_size);
>       g_assert_cmpint(buffer_size, >, 0);
>   
>       AUD_close_out(be, voice);
>   
> -    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
> +    g_assert_cmpint(AUD_get_buffer_size_out(NULL, NULL), ==, 0);
>   }
>   
>   static void test_audio_out_volume(void)
> @@ -258,13 +258,13 @@ static void test_audio_out_volume(void)
>       voice = open_test_voice_out(be, "test-volume", NULL, dummy_audio_callback);
>   
>       vol = (Volume){.mute = false, .channels = 2, .vol = {255, 255}};
> -    AUD_set_volume_out(voice, &vol);
> +    AUD_set_volume_out(be, voice, &vol);
>   
>       vol = (Volume){.mute = true, .channels = 2, .vol = {255, 255}};
> -    AUD_set_volume_out(voice, &vol);
> +    AUD_set_volume_out(be, voice, &vol);
>   
>       vol = (Volume){.mute = false, .channels = 2, .vol = {128, 128}};
> -    AUD_set_volume_out(voice, &vol);
> +    AUD_set_volume_out(be, voice, &vol);
>   
>       AUD_close_out(be, voice);
>   }
> @@ -277,13 +277,13 @@ static void test_audio_in_active_state(void)
>       be = get_test_audio_backend();
>       voice = open_test_voice_in(be, "test-in-active", NULL, dummy_audio_callback);
>   
> -    g_assert_false(AUD_is_active_in(voice));
> +    g_assert_false(AUD_is_active_in(be, voice));
>   
> -    AUD_set_active_in(voice, true);
> -    g_assert_true(AUD_is_active_in(voice));
> +    AUD_set_active_in(be, voice, true);
> +    g_assert_true(AUD_is_active_in(be, voice));
>   
> -    AUD_set_active_in(voice, false);
> -    g_assert_false(AUD_is_active_in(voice));
> +    AUD_set_active_in(be, voice, false);
> +    g_assert_false(AUD_is_active_in(be, voice));
>   
>       AUD_close_in(be, voice);
>   }
> @@ -298,10 +298,10 @@ static void test_audio_in_volume(void)
>       voice = open_test_voice_in(be, "test-in-volume", NULL, dummy_audio_callback);
>   
>       vol = (Volume){.mute = false, .channels = 2, .vol = {255, 255}};
> -    AUD_set_volume_in(voice, &vol);
> +    AUD_set_volume_in(be, voice, &vol);
>   
>       vol = (Volume){.mute = true, .channels = 2, .vol = {255, 255}};
> -    AUD_set_volume_in(voice, &vol);
> +    AUD_set_volume_in(be, voice, &vol);
>   
>       AUD_close_in(be, voice);
>   }
> @@ -414,7 +414,7 @@ static void test_audio_capture(void)
>                                   &sine_state, test_sine_callback);
>       sine_state.voice = voice;
>   
> -    AUD_set_active_out(voice, true);
> +    AUD_set_active_out(be, voice, true);
>   
>       start_time = g_get_monotonic_time();
>       while (sine_state.frames_written < sine_state.total_frames ||
> @@ -459,10 +459,10 @@ static void test_audio_capture(void)
>           g_assert_cmpfloat(match_ratio, >=, 0.9);
>       }
>   
> -    AUD_set_active_out(voice, false);
> +    AUD_set_active_out(be, voice, false);
>       AUD_close_out(be, voice);
>   
> -    AUD_del_capture(cap, &state);
> +    AUD_del_capture(be, cap, &state);
>       g_assert_true(state.destroy_called);
>   
>       g_free(state.captured_samples);
> @@ -470,26 +470,27 @@ static void test_audio_capture(void)
>   
>   static void test_audio_null_handling(void)
>   {
> +    AudioBackend *be = get_test_audio_backend();
>       uint8_t buffer[64];
>   
>       /* AUD_is_active_out/in(NULL) should return false */
> -    g_assert_false(AUD_is_active_out(NULL));
> -    g_assert_false(AUD_is_active_in(NULL));
> +    g_assert_false(AUD_is_active_out(be, NULL));
> +    g_assert_false(AUD_is_active_in(be, NULL));
>   
>       /* AUD_get_buffer_size_out(NULL) should return 0 */
> -    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
> +    g_assert_cmpint(AUD_get_buffer_size_out(be, NULL), ==, 0);
>   
>       /* AUD_write/read(NULL, ...) should return size (no-op) */
> -    g_assert_cmpuint(AUD_write(NULL, buffer, sizeof(buffer)), ==,
> +    g_assert_cmpuint(AUD_write(be, NULL, buffer, sizeof(buffer)), ==,
>                        sizeof(buffer));
> -    g_assert_cmpuint(AUD_read(NULL, buffer, sizeof(buffer)), ==,
> +    g_assert_cmpuint(AUD_read(be, NULL, buffer, sizeof(buffer)), ==,
>                        sizeof(buffer));
>   
>       /* These should not crash */
> -    AUD_set_active_out(NULL, true);
> -    AUD_set_active_out(NULL, false);
> -    AUD_set_active_in(NULL, true);
> -    AUD_set_active_in(NULL, false);
> +    AUD_set_active_out(be, NULL, true);
> +    AUD_set_active_out(be, NULL, false);
> +    AUD_set_active_in(be, NULL, true);
> +    AUD_set_active_in(be, NULL, false);
>   }
>   
>   static void test_audio_multiple_voices(void)
> @@ -503,17 +504,17 @@ static void test_audio_multiple_voices(void)
>       out2 = open_test_voice_out(be, "test-multi-out2", NULL, dummy_audio_callback);
>       in1 = open_test_voice_in(be, "test-multi-in1", NULL, dummy_audio_callback);
>   
> -    AUD_set_active_out(out1, true);
> -    AUD_set_active_out(out2, true);
> -    AUD_set_active_in(in1, true);
> +    AUD_set_active_out(be, out1, true);
> +    AUD_set_active_out(be, out2, true);
> +    AUD_set_active_in(be, in1, true);
>   
> -    g_assert_true(AUD_is_active_out(out1));
> -    g_assert_true(AUD_is_active_out(out2));
> -    g_assert_true(AUD_is_active_in(in1));
> +    g_assert_true(AUD_is_active_out(be, out1));
> +    g_assert_true(AUD_is_active_out(be, out2));
> +    g_assert_true(AUD_is_active_in(be, in1));
>   
> -    AUD_set_active_out(out1, false);
> -    AUD_set_active_out(out2, false);
> -    AUD_set_active_in(in1, false);
> +    AUD_set_active_out(be, out1, false);
> +    AUD_set_active_out(be, out2, false);
> +    AUD_set_active_in(be, in1, false);
>   
>       AUD_close_in(be, in1);
>       AUD_close_out(be, out2);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index a61a4f937d6..c142d9fc7c0 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1289,7 +1289,7 @@ static void audio_add(VncState *vs)
>   static void audio_del(VncState *vs)
>   {
>       if (vs->audio_cap) {
> -        AUD_del_capture(vs->audio_cap, vs);
> +        AUD_del_capture(vs->vd->audio_be, vs->audio_cap, vs);
>           vs->audio_cap = NULL;
>       }
>   }

Hurrah!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


