Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73409EDF16E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquPM-0006M7-15; Fri, 13 Feb 2026 09:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquPC-0006JV-8G
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:44:26 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquP6-0008Oc-Ol
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:44:24 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DDALH4069939; Fri, 13 Feb 2026 06:44:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l8sDar4cDp8+wg4nk5ITozzJar3s6rRKI2pnwBIAA
 WY=; b=0X42kw1nWUuglq1/SR7ZTjtDJeAmSduZdGSzFlBC1CI+jy9g56nRhWqo6
 0RF5hplJpSBCBX4nATnflQSJpVZbW16FIXAwf+zpARTa/qXFlPj43TRrPG9mnO9T
 xmN4ACRIEM+0fFGdUt9WdKbTxkgvfvezd6d1ZF1SvLdywrnrJNvIthkyM8RoHl9H
 qLkfC3TftO9njaiXNBod95cTT+h9kNen8MIzW/XSvewBd7stp5hvGF9NBdC1OK9I
 g1HXeylCjuaQLqsZ1p+F3ISfH0/FnNB/DhoTq4NBBnrKhnzrDWIEtkYCdFMmfhV7
 YvbnudJ3YBNilnZSvOj9MV64bbUZw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020099.outbound.protection.outlook.com
 [40.93.198.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9u9f9jte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3vHl2bj307Yk8GtSmZKlDsVKJ99YScvro/R6ZKSze0cRmuMLY3xR7GVlzlPAnbIzacECg9eSCahz5TfwG8kTrVqidLX4ZajREVmOCaRucbpLaMRkGyjr7m/8rcOOIoEFS4DVbJC4Nhj3SB85oX/BHQt4uC72SMlT1HglVp5rxE+fwH6mveSqbY74o2CmRM81FfJ2tA8irdHjJLNuzEzENjmZHkI7zbvryXtjPWRI7Fm4xk8Bzj3juaLxzLGyP51eMGzoX7ga6GOfs6UBz/QLVGhwndoM/LPW7tsseRtkkkYyPa4YOd07PywUZGt+zMGczCXzJP1aqqoTPsvDM4hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8sDar4cDp8+wg4nk5ITozzJar3s6rRKI2pnwBIAAWY=;
 b=QtJhZzcU/cOluhvhpoKveyDZFpjIW+3Ki8GvGDsVQoyzgLQrMwShWsz1n9edSbm9i0PEev9HK85lBjLW7gMyU34LBbWIpZMA7+tcic8gRo42EK3yDL+FkyXjWwZtFyLFJwcvliuNAtCBZLzmJWcMcVniuiGqWeMuLmhtwHX2Kh9lAtI0ul41ZHa4IEo9ETwig34/B4EcMp2c+sA4qPY0FYZk2shjFBSwRrDQlG/1Fp83FczI0yFwpT+bV5beRJr6r5r/FP14dxSbgZNvj3eCnkt2C7WVz7Yk7VaOiEsus25d+ZZi3XPXjZMzhzc1eJRqDT5Da+dzBCmSns63QkjL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8sDar4cDp8+wg4nk5ITozzJar3s6rRKI2pnwBIAAWY=;
 b=fOqGgCSW9pq13ZVi5XB1ER7l3RAaDQBF2uX3/UQRUxOXtPT1xycHis0cAYTUN4v8SsnpfZjBmaAOS5mV0DZzNN+jkFlKWjnhcgWHhyEHyKmon50XT0rhk/6nuDwASLwtxvPtRQfedl1CyYpbhb3zYk924UZpgJxz9/WJUhL/3YMh5UPGs/ayjhJKSlM0Ya0i5nHB3EOyLRk6EW5Q3JqzwwkyaPwHKMTp8AQZ0qALcJ8S1PNYx+9f8WaTzWrpUTMraa4WkZ19PTHcG4K92/dXAWRTKMyLSiqyRNTthWmX9HcHhh9ROUCvMHwrHLpHY9Ly9ERK+4LsEHvrmRva45v6NQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6649.namprd02.prod.outlook.com (2603:10b6:5:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 14:44:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:44:14 +0000
Message-ID: <bd540777-74a4-4b56-9823-08c7cc22448b@nutanix.com>
Date: Fri, 13 Feb 2026 14:44:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/43] audio/dsound: replace custom logging with
 error_report & trace
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-22-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:610:118::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba84a39-33a0-4d90-176b-08de6b0e5b4e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUNzSGI4U3cwV0IrczBDUmdIak4wRlg4R0VWRmRnTURHS1A0NnI3VzFTVUUx?=
 =?utf-8?B?dUVvWC9MMGkrZjU0Q2NxNHNCWW9JL013ejloSzhDSEVKUkFzQWYyZmJUU1dW?=
 =?utf-8?B?S0NKbzJqUythc1ZDamVTVnh1dzFHUEhVRi9vTTRBQlhMbmN3ZEFybUg1UnJ6?=
 =?utf-8?B?SWsrTllYVmx1RGtnamtReUZUS3FsV2t5ZkpsSjFLaG9FVUJGK2YwZUFpQ2Vx?=
 =?utf-8?B?c0t3SGVDRHdFYTR1Rm5kVnN6Y0k0RUIrb01wTlNCRUtmN1ZCeDBOY1VuWDFZ?=
 =?utf-8?B?L1Q5K1VYWFdaaUdkeWdqN3RBNmE1VWl3MmZUczYrTDNjZXc4U2lWRXU3UFFy?=
 =?utf-8?B?Mk5RalpkZ3FYYXVsbUZ2U1E4OXFEU3ltTCtJU09Eb1Z2a0IrdDZrS3hmWmVo?=
 =?utf-8?B?dmdERnBrT2JXclAxU1lwbnJmNzRmQzRUWWR4cXZka1g5WEJsK0xLaWJscW5n?=
 =?utf-8?B?UlZibDc1cmJYV1VKdGJ1S0NEZmwrTmxMWXF4VWNIODQ2dWlRVm9NWjNBL2FI?=
 =?utf-8?B?WlZ6cFBkRDlLZm9ramc1SEttdU93NDNSVDJhRkhSdklWeEk2MldENk02dUhS?=
 =?utf-8?B?QlF2Wkgyd29seXhrcmpiRG52N1h0cGlyOWV4QWdpanpGVVoxMTJyUkRCM21T?=
 =?utf-8?B?ZWt3ZFlrNk5HcDhtQStPWk9US2MzLzMybzM4bk9CRFlBcmNEdmthQktneks3?=
 =?utf-8?B?WnJxbmplRVYvdkdBSjM2ZkNUTXdXVXJKRlY2ZXJzRnFIWE5FSWlieU1OS1hs?=
 =?utf-8?B?bWc5ZUNyb3kwc1lUUGdDeTFYeGRDeUcrRzFKVEdFNFF0ZHpKSUJoUkdkZnNa?=
 =?utf-8?B?RCtqWk9ZbHQ1QVVQb0V1R3ZoOEpZRjMxeHUyNmpOV0JzUStYd1RhNEdVay9Y?=
 =?utf-8?B?dmNjUE4rRlViTE52Mko2NENVUEV0QkpqbGZRcUk3WWFhMC9xUWI5MjlYZkNN?=
 =?utf-8?B?NW50UDBOaDVHQW1rQmRWek1wMVdnMVROaGp4Mnd3VU9ERmpZblJ0bnhOQngx?=
 =?utf-8?B?ZSsxcGFwQUl4NkFnanlCV1dHSHdocVhXcEtUb1JYL2pCNXZxMFFDUzlXOTl6?=
 =?utf-8?B?QlRTMStDcTZzQUFoN0o1QzlCYUlaU01RR3RaVW4zUnp2WnRSRFpPbisyZERX?=
 =?utf-8?B?WkJ1YmQrRmhSbE8rYklrSFpaMkx0NWdBNjhIQ1grbTdDRVduZExaTXNpOVZN?=
 =?utf-8?B?Ym1kRFNCU0pjclR0RHcwakFjSmp1NTdEcmxXYklORUg2R2ZJSHVFV0dlS0Mw?=
 =?utf-8?B?S3EyMTQvZld5dW9zYmVHME1xWERuSHdnT2pFWng4QmlwM3BPV2cwcnhFMFIx?=
 =?utf-8?B?M1BsQlhQWER3R3EyTmppSmU2RjBlUUVuUFJKSHFTeDhOVkZ4OURFYWllZHRS?=
 =?utf-8?B?Q3VjQ3ROTCtHUW5pU1NhUWdwTThObEFpY2Znai9TSXMwQlpWV29sVzJRNGhr?=
 =?utf-8?B?bUJkcHErNEo0V0kvZzFyWWZ3ZGRZeDFCaW9nWHlSdDlxTUxRYXN2cjNXVDA0?=
 =?utf-8?B?bFF2NWlLcElscnZMaEFjaGFzWW9KUklZOGdIbWVobEcybm9uRWpVSW9RZkxF?=
 =?utf-8?B?K0d2RVEyRGRqNXZ4blZUQVZOSUtXSUV3M0tlYiszalBTTVZPbWU2YktVZ0ZY?=
 =?utf-8?B?ckkzN3YrWElpNnFOc1BzZWtmZy9Kek5HK2tkQ3hFTU5VbmsrbnFFR0N3OHR3?=
 =?utf-8?B?WXNuaEZZSHlhaEpaTFlvWnFkRG8zeHE2WVRWZ2tPVXEwVU9zc1dod3RGTndm?=
 =?utf-8?B?V1lhZ0xTVWF5WldXUWpwd1kxbXBPNDMvRzdEMW5ITVRMZUg5Q0tsMkd3Z3dk?=
 =?utf-8?B?NEJXa2orWTBKNUhiczBzc1lPTndCeFlJQmdMTkRtMTMvUU9ROTBJa2ZzVGRk?=
 =?utf-8?B?VWozSEk1cEJQSENseXg5SEZaeGtxVk13ZkZBY0l4RVZrSk1ZY1RSc1NFdXJJ?=
 =?utf-8?B?cGttT3Q1QXRuRlIwT0M5OXdyZDE3cldLZDhsV3craXdRM1VxbW9wa09SV2Nw?=
 =?utf-8?B?TFdBNEtnQjZOeVpBb0tQV0JWL3B5ZjlVc0pyeEc0YlJRTnpBTUd2UGVmaEF0?=
 =?utf-8?B?ZGswMzBlNUFpcE1lWDJjR2c0M0VWMXVTU2ZkZGoxN2l0N0tXMmowZHM3MHRT?=
 =?utf-8?Q?HUKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhwcU95YVdLMmV2UkNIRVoxNld6ZTlBU0prTkFibDZQbzJydEdybTVpMXRy?=
 =?utf-8?B?QVFUSGRwakJhbTNOSVFNUmxSUGpmcmtKWExjVTlCVGk3ZXQvb3E0Wk9RbjNJ?=
 =?utf-8?B?S0ZXWUxwLzh2MUdnYU5SbXFjRHlVbjRrOVhaQ1ZnRFhwdVByNHdvZlBOUVVr?=
 =?utf-8?B?UUk3YTYyQmRYeUowakhVeGZxRzN1dFcwY0Rwb2orekxGcjBISFFBL0RUU3Zx?=
 =?utf-8?B?RGZiNStMR2NwYXVrWXJYN2g3VGc3eGxzVjkyTWhMZy9MdnFDZDRiQi9MOFVv?=
 =?utf-8?B?UmZWMTYySzI5MDIrdkJFUllZV1M5QXRmVy9BWSsrbEVaSmQ3cDczMFVpYXE1?=
 =?utf-8?B?V1Y0WXJUbW5JUENZQTdZbzV2bFpyamVyRlI0SkZqWnllK0ZuMDBhR1BDcGw2?=
 =?utf-8?B?Yk1PUWpLUit5REQ0K0NhanNDU2tUVGN6WWtHdk5GWVh4YUExK2VIckZ5ZERo?=
 =?utf-8?B?N0l3bVBiMmRhNGsvbHhSRWNpKzRIanJaS3B4ZjBaUFhPLzg0Zi9ybnlHMHRL?=
 =?utf-8?B?eWRsSFdnRU1tVjlsTHNqQjhrVFhXeXpSVWYrUDhSd041bUFSL0NIVG1uTDdi?=
 =?utf-8?B?cTYzME9JY1UxQVF0SEg1cjhaK2pJeEs1SWt5QXJKRDQ3cnNENE5lVi9wamJB?=
 =?utf-8?B?bVFTWGRWa3pNeGVKSXhHbVBkcDBPSHFiNmxkb3N5U3hWa21iSjAyaCthZXh2?=
 =?utf-8?B?WkF5eGhRaGJWZGovK3Z1cHpmazc1Sk8rdU5XTGwvTTA4MzVMNlZFWnd3YzdZ?=
 =?utf-8?B?ZXBwWnRjNDJydFNmdWw2TEo2bnc2L1V5andoY3RZeitySUc4OGVZUDdJbHYz?=
 =?utf-8?B?R3p1YkJsNGd5Y21aUUhGQnJ4dm14YllQSVo3U05EQ2d6MEp0dWRIQ3BxSm1n?=
 =?utf-8?B?dlk4WmU1Uk5pd0dOakNSV3NwNjN2Ly9PbVBuSWJSb0RlRXdDaVJNUEJobjVi?=
 =?utf-8?B?eUNtbGlvUDJTQ2Qxc0Z2MjI2WWM2YjFyQmhVM2pVVDh3N1g5bnVlbWEwT2ZP?=
 =?utf-8?B?ekVsUUZtcWdUS083dmRRTDdNb3JGWW1NQ2Y2TzQrckwzbjR3ZVl0TFk3L1VV?=
 =?utf-8?B?ZnpMblVxYjVRMkxuOTVGK1h5SDNibHV3dUkwRHZ5aW8rdXpqM1BQd0wrOXhr?=
 =?utf-8?B?TGZsU2U3M2k4UFZZK1NXYzJaclZBbW5vSCtyOERzWUdta3RsVTVYSVZ1OXhX?=
 =?utf-8?B?Zis0a01tanpBcTBvV1JXL09UTTJ3ZGxuMiszaGpOU3B2NEFPTzZhN1ZNNlFY?=
 =?utf-8?B?eS96Q3YwUjAzTFk2emorWlhiaVRoSU1tWENmNGF1eUp0dmZUQ25wZ2xkSnV5?=
 =?utf-8?B?ZXNta0l6UGdYTDNVRTN4Wk9Yam1QMUtkbkk5WGxOL2lEKzdmNWxhMFZPNUgv?=
 =?utf-8?B?Qms5WVdpS3BXZm5PTFNSTDgxa09IYVVUM3QxMlk5NUNoaU8wOEdON2lLSFRx?=
 =?utf-8?B?azZMZGpDenJldW41bzF1eDRKU1Faek5VWndvUDVaazY4OVV1S3lDYVRtQWlw?=
 =?utf-8?B?UmlSN2xxQ2F5RG10MXpwTUpLSUlGVFFraElVQmNtdCs0RUg2QWYreDkzYTNq?=
 =?utf-8?B?OXVDbEhjdDlOSTRLWC9LQ05zWnNTLzdEcHV4SjYyWWhZTzZTNDI2UGZldDdS?=
 =?utf-8?B?aGlTUkhYNFkxZDNVeEdkdW1aN3ZVbXduNVFoL2k5bkxRMFJKekpVUVRFZWp2?=
 =?utf-8?B?SmFxd2xVSWhUWUxEMUxRd2VMUmdGQmZaZEYwdmN4dHdOcmlsK3JWK0ozZGd2?=
 =?utf-8?B?K20wOG40QlgwamRnMFRXVzdEd0tIb05YMXJCZUxMZEJZMUwzNDdGRHZkVlpD?=
 =?utf-8?B?bktwd0RmTFJjTDlaWHloRGM4akgrTHcyZ1BodnRKUUttTEpVbFBPVW00U1NE?=
 =?utf-8?B?YUZHMUYrTlNVTUtEeFZyS2RrRzVDS3NCUUVqdUJQTStHbi81MEVpcThReXhw?=
 =?utf-8?B?QUVsY1lzQ01QMlliQ1prS1QwM3BoeXVXenZZK3I1b0VLT2JLWU0zSWQ2cWty?=
 =?utf-8?B?bXRvaWI0MHcrS3kwVTJyck9MeTd1RXN3elZUSUxHYXpISVkwK3A4SGt6YW1y?=
 =?utf-8?B?dTBOM1B3MXMxdzZwektvSHpleWQzSVZrK3dCbXR5YWswZnpFeGcwK2V1Z21k?=
 =?utf-8?B?ZFBPY2x6QUNmY0JTRHlhc0czZ0JUT1ZDZ3ZDV0Nva2ZLV2RmVU1VTVZlZ1pC?=
 =?utf-8?B?Zk9jc1dWMmxZY2cydklPY2wyazFvdW51QkF1VTVuUCtrUEV4RC9uWDhIbXRI?=
 =?utf-8?B?bW16RGIzdXRHeDdBZ1dYNytULy9jcGcyQmhncEFzcmkvOE1scnZyOHZVbHZT?=
 =?utf-8?B?Q1o1Y0oxUjlIQ0xoeGJmV0FGVWdHZWxFUng5WmZQL3gzTi9JcHkwNFVXNmo3?=
 =?utf-8?Q?NnnSC6gjKwfygMYw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba84a39-33a0-4d90-176b-08de6b0e5b4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:44:14.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kn81+YdqHp+9tENCYOpOjZwEsPV8tFgKlK5zhYDCyRdO4T3hOFlzs+POjcGuiR9ixtOx7Dde7AKyEPURlHt7wy8Rpq/siiPgOsaFODd/Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6649
X-Authority-Analysis: v=2.4 cv=OuBCCi/t c=1 sm=1 tr=0 ts=698f38c1 cx=c_pps
 a=GknEWMF7HrfbFJOd498rxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=dlabe7nr7pjRcz3uKwIA:9
 a=Fn0bOqKrTMT2B-eH:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cDwzn70tvIzEaBbD74b8smJ4LlYPB_dO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXzr+KQ+l5aCry
 BwIMBh+DshYlnbmav9GUPVtGFiiZcuLPTQHfUKdx9gGtH1VRB9zgYow88mfhTMJP5QnYdMxIltO
 Jy8SkmXgiMLaLWtk4hSw/OyTYXab4Q8iNwONGmvZIJiPjUEfQiezzp8DyAcl4TaK7JrEtTZszXa
 rfFhg5zMxdgHdpn60wtcfSJhLOYLBm8e1wJ4D7Ki+CvFH7gMqJGeKFoFpGMzVzDvtMuJvUWSWrk
 7L6hbtJeFxdOkP8eYo1nKpHU68Jz/UG6uNRNp3GpJjifR/pY8R7v2WbD6nEqHtHiVWreEWt+qhp
 kr+9ClEb+TAY30lqxqVWEC+fDBiBdaoxqpGHRpCVPoqmPDO42riz0p1ivnncMCNTMNt70IrQHAC
 PcAHaNLwNPok9ulhB1v+XQspvN/YH9tH4k850IVfXGHWXL91ykEt35TXKIfQjiQ8L5FqH3AAUNN
 qRcT31I7azAbRLWoubQ==
X-Proofpoint-ORIG-GUID: cDwzn70tvIzEaBbD74b8smJ4LlYPB_dO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The DirectSound audio backend uses its own logging infrastructure
> (AUD_log, AUD_vlog, dolog) and the AUDIO_CAP macro. This approach is
> inconsistent with the rest of QEMU and makes the output harder to
> filter and configure.
> 
> Replace the custom logging with standard QEMU error reporting.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dsound_template.h |  72 ++++++++++-----------
>   audio/audio_win_int.c   |  31 +++++-----
>   audio/dsoundaudio.c     | 134 ++++++++++++++++------------------------
>   audio/trace-events      |   5 ++
>   4 files changed, 108 insertions(+), 134 deletions(-)
> 
> diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> index 022a7307c99..af4019bcb34 100644
> --- a/audio/dsound_template.h
> +++ b/audio/dsound_template.h
> @@ -53,9 +53,9 @@ static int glue (dsound_unlock_, TYPE) (
>   {
>       HRESULT hr;
>   
> -    hr = glue (IFACE, _Unlock) (buf, p1, blen1, p2, blen2);
> -    if (FAILED (hr)) {
> -        dsound_logerr (hr, "Could not unlock " NAME "\n");
> +    hr = glue(IFACE, _Unlock)(buf, p1, blen1, p2, blen2);
> +    if (FAILED(hr)) {
> +        dsound_logerr(hr, "Could not unlock " NAME);
>           return -1;
>       }
>   
> @@ -85,35 +85,35 @@ static int glue (dsound_lock_, TYPE) (
>   #endif
>       hr = glue(IFACE, _Lock)(buf, pos, len, p1p, blen1p, p2p, blen2p, flag);
>   
> -    if (FAILED (hr)) {
> +    if (FAILED(hr)) {
>   #ifndef DSBTYPE_IN
>           if (hr == DSERR_BUFFERLOST) {
> -            if (glue (dsound_restore_, TYPE) (buf, s)) {
> -                dsound_logerr (hr, "Could not lock " NAME "\n");
> +            if (glue(dsound_restore_, TYPE)(buf, s)) {
> +                dsound_logerr(hr, "Could not lock " NAME);
>               }
>               goto fail;
>           }
>   #endif
> -        dsound_logerr (hr, "Could not lock " NAME "\n");
> +        dsound_logerr(hr, "Could not lock " NAME);
>           goto fail;
>       }
>   
>       if ((p1p && *p1p && (*blen1p % info->bytes_per_frame)) ||
>           (p2p && *p2p && (*blen2p % info->bytes_per_frame))) {
> -        dolog("DirectSound returned misaligned buffer %ld %ld\n",
> -              *blen1p, *blen2p);
> +        error_report("dsound: returned misaligned buffer %ld %ld",
> +                     *blen1p, *blen2p);
>           glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p,
>                                      blen2p ? *blen2p : 0);
>           goto fail;
>       }
>   
>       if (p1p && !*p1p && *blen1p) {
> -        dolog("warning: !p1 && blen1=%ld\n", *blen1p);
> +        warn_report("dsound: !p1 && blen1=%ld", *blen1p);
>           *blen1p = 0;
>       }
>   
>       if (p2p && !*p2p && *blen2p) {
> -        dolog("warning: !p2 && blen2=%ld\n", *blen2p);
> +        warn_report("dsound: !p2 && blen2=%ld", *blen2p);
>           *blen2p = 0;
>       }
>   
> @@ -143,14 +143,14 @@ static void dsound_fini_out (HWVoiceOut *hw)
>   #endif
>   
>       if (ds->FIELD) {
> -        hr = glue (IFACE, _Stop) (ds->FIELD);
> -        if (FAILED (hr)) {
> -            dsound_logerr (hr, "Could not stop " NAME "\n");
> +        hr = glue(IFACE, _Stop)(ds->FIELD);
> +        if (FAILED(hr)) {
> +            dsound_logerr(hr, "Could not stop " NAME);
>           }
>   
> -        hr = glue (IFACE, _Release) (ds->FIELD);
> -        if (FAILED (hr)) {
> -            dsound_logerr (hr, "Could not release " NAME "\n");
> +        hr = glue(IFACE, _Release)(ds->FIELD);
> +        if (FAILED(hr)) {
> +            dsound_logerr(hr, "Could not release " NAME);
>           }
>           ds->FIELD = NULL;
>       }
> @@ -182,7 +182,8 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
>   #endif
>   
>       if (!s->FIELD2) {
> -        dolog ("Attempt to initialize voice without " NAME2 " object\n");
> +        error_report("dsound: Attempt to initialize voice without "
> +                     NAME2 " object");
>           return -1;
>       }
>   
> @@ -212,28 +213,28 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
>           );
>   #endif
>   
> -    if (FAILED (hr)) {
> -        dsound_logerr2 (hr, typ, "Could not create " NAME "\n");
> +    if (FAILED(hr)) {
> +        dsound_logerr2(hr, typ, "Could not create " NAME);
>           return -1;
>       }
>   
> -    hr = glue (IFACE, _GetFormat) (ds->FIELD, &wfx, sizeof (wfx), NULL);
> -    if (FAILED (hr)) {
> -        dsound_logerr2 (hr, typ, "Could not get " NAME " format\n");
> +    hr = glue(IFACE, _GetFormat)(ds->FIELD, &wfx, sizeof(wfx), NULL);
> +    if (FAILED(hr)) {
> +        dsound_logerr2(hr, typ, "Could not get " NAME " format");
>           goto fail0;
>       }
>   
> -#ifdef DEBUG_DSOUND
> -    dolog (NAME "\n");
> -    print_wave_format (&wfx);
> -#endif
> +    trace_dsound_wave_format(
> +        wfx.wFormatTag, wfx.nChannels,
> +        wfx.nSamplesPerSec, wfx.nAvgBytesPerSec,
> +        wfx.nBlockAlign, wfx.wBitsPerSample, wfx.cbSize);
>   
>       memset (&bc, 0, sizeof (bc));
>       bc.dwSize = sizeof (bc);
>   
> -    hr = glue (IFACE, _GetCaps) (ds->FIELD, &bc);
> -    if (FAILED (hr)) {
> -        dsound_logerr2 (hr, typ, "Could not get " NAME " format\n");
> +    hr = glue(IFACE, _GetCaps)(ds->FIELD, &bc);
> +    if (FAILED(hr)) {
> +        dsound_logerr2(hr, typ, "Could not get " NAME " caps");
>           goto fail0;
>       }
>   
> @@ -247,18 +248,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
>       audio_pcm_init_info (&hw->info, &obt_as);
>   
>       if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
> -        dolog (
> -            "GetCaps returned misaligned buffer size %ld, alignment %d\n",
> -            bc.dwBufferBytes, hw->info.bytes_per_frame
> -            );
> +        warn_report("dsound: GetCaps returned misaligned buffer size %ld, "
> +                    "alignment %d", bc.dwBufferBytes, hw->info.bytes_per_frame);
>       }
>       hw->size_emul = bc.dwBufferBytes;
>       hw->samples = bc.dwBufferBytes / hw->info.bytes_per_frame;
>   
> -#ifdef DEBUG_DSOUND
> -    dolog ("caps %ld, desc %ld\n",
> -           bc.dwBufferBytes, bd.dwBufferBytes);
> -#endif
> +    trace_dsound_buffer_bytes(bc.dwBufferBytes, bd.dwBufferBytes);
>       return 0;
>   
>    fail0:
> diff --git a/audio/audio_win_int.c b/audio/audio_win_int.c
> index 44a8ff24a6f..ecd599c87de 100644
> --- a/audio/audio_win_int.c
> +++ b/audio/audio_win_int.c
> @@ -2,12 +2,12 @@
>   
>   #include "qemu/osdep.h"
>   
> -#define AUDIO_CAP "win-int"
>   #include <windows.h>
>   #include <mmreg.h>
>   #include <mmsystem.h>
>   
>   #include "qemu/audio.h"
> +#include "qemu/error-report.h"
>   #include "audio_int.h"
>   #include "audio_win_int.h"
>   
> @@ -53,7 +53,7 @@ int waveformat_from_audio_settings (WAVEFORMATEX *wfx,
>           break;
>   
>       default:
> -        dolog("Internal logic error: Bad audio format %d\n", as->fmt);
> +        error_report("dsound: Internal logic error: Bad audio format %d", as->fmt);
>           return -1;
>       }
>   
> @@ -64,7 +64,7 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
>                                     struct audsettings *as)
>   {
>       if (!wfx->nSamplesPerSec) {
> -        dolog ("Invalid wave format, frequency is zero\n");
> +        error_report("dsound: Invalid wave format, frequency is zero");
>           return -1;
>       }
>       as->freq = wfx->nSamplesPerSec;
> @@ -79,10 +79,9 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
>           break;
>   
>       default:
> -        dolog (
> -            "Invalid wave format, number of channels is not 1 or 2, but %d\n",
> -            wfx->nChannels
> -            );
> +        error_report("dsound: Invalid wave format, "
> +                     "number of channels is not 1 or 2, but %d",
> +                     wfx->nChannels);
>           return -1;
>       }
>   
> @@ -101,9 +100,9 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
>               break;
>   
>           default:
> -            dolog("Invalid PCM wave format, bits per sample is not "
> -                  "8, 16 or 32, but %d\n",
> -                  wfx->wBitsPerSample);
> +            error_report("dsound: Invalid PCM wave format, bits per sample is not "
> +                         "8, 16 or 32, but %d",
> +                         wfx->wBitsPerSample);
>               return -1;
>           }
>       } else if (wfx->wFormatTag == WAVE_FORMAT_IEEE_FLOAT) {
> @@ -113,15 +112,15 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
>               break;
>   
>           default:
> -            dolog("Invalid IEEE_FLOAT wave format, bits per sample is not "
> -                  "32, but %d\n",
> -                  wfx->wBitsPerSample);
> +            error_report("dsound: Invalid IEEE_FLOAT wave format, "
> +                         "bits per sample is not 32, but %d",
> +                         wfx->wBitsPerSample);
>               return -1;
>           }
>       } else {
> -        dolog("Invalid wave format, tag is not PCM and not IEEE_FLOAT, "
> -              "but %d\n",
> -              wfx->wFormatTag);
> +        error_report("dsound: Invalid wave format, "
> +                     "tag is not PCM and not IEEE_FLOAT, but %d",
> +                     wfx->wFormatTag);
>           return -1;
>       }
>   
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index afd901518cc..2f17ab49730 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -28,8 +28,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/audio.h"
> -
> -#define AUDIO_CAP "dsound"
> +#include "qemu/error-report.h"
>   #include "audio_int.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> @@ -40,6 +39,7 @@
>   #include <objbase.h>
>   #include <dsound.h>
>   
> +#include "trace.h"
>   #include "audio_win_int.h"
>   
>   #define TYPE_AUDIO_DSOUND "audio-dsound"
> @@ -55,9 +55,6 @@ struct AudioDsound {
>       struct audsettings settings;
>   };
>   
> -
> -/* #define DEBUG_DSOUND */
> -
>   typedef struct {
>       HWVoiceOut hw;
>       LPDIRECTSOUNDBUFFER dsound_buffer;
> @@ -214,56 +211,37 @@ static void dsound_log_hresult(HRESULT hr)
>       const char *str = dserror(hr);
>   
>       if (str) {
> -        AUD_log (AUDIO_CAP, "Reason: %s\n", str);
> +        error_printf(" Reason: %s", str);
>       } else {
> -        AUD_log (AUDIO_CAP, "Reason: Unknown (HRESULT: 0x%lx)\n", hr);
> +        error_printf(" Reason: Unknown (HRESULT: 0x%lx)", hr);
>       }
>   }
>   
> -static void G_GNUC_PRINTF (2, 3) dsound_logerr (
> -    HRESULT hr,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(2, 3) dsound_logerr(HRESULT hr, const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    dsound_log_hresult (hr);
> +    error_printf("dsound: ");
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    dsound_log_hresult(hr);
> +    error_printf("\n");
>   }
>   
> -static void G_GNUC_PRINTF (3, 4) dsound_logerr2 (
> -    HRESULT hr,
> -    const char *typ,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(3, 4) dsound_logerr2(HRESULT hr, const char *typ,
> +                                               const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> -
> -    dsound_log_hresult (hr);
> +    error_printf("dsound: Could not initialize %s: ", typ);
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
> +    dsound_log_hresult(hr);
> +    error_printf("\n");
>   }
>   
> -#ifdef DEBUG_DSOUND
> -static void print_wave_format (WAVEFORMATEX *wfx)
> -{
> -    dolog ("tag             = %d\n", wfx->wFormatTag);
> -    dolog ("nChannels       = %d\n", wfx->nChannels);
> -    dolog ("nSamplesPerSec  = %ld\n", wfx->nSamplesPerSec);
> -    dolog ("nAvgBytesPerSec = %ld\n", wfx->nAvgBytesPerSec);
> -    dolog ("nBlockAlign     = %d\n", wfx->nBlockAlign);
> -    dolog ("wBitsPerSample  = %d\n", wfx->wBitsPerSample);
> -    dolog ("cbSize          = %d\n", wfx->cbSize);
> -}
> -#endif
>   
>   static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
>   {
> @@ -272,7 +250,7 @@ static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
>       hr = IDirectSoundBuffer_Restore (dsb);
>   
>       if (hr != DS_OK) {
> -        dsound_logerr (hr, "Could not restore playback buffer\n");
> +        dsound_logerr(hr, "Could not restore playback buffer");
>           return -1;
>       }
>       return 0;
> @@ -290,7 +268,7 @@ static int dsound_get_status_out (LPDIRECTSOUNDBUFFER dsb, DWORD *statusp,
>   
>       hr = IDirectSoundBuffer_GetStatus (dsb, statusp);
>       if (FAILED (hr)) {
> -        dsound_logerr (hr, "Could not get playback buffer status\n");
> +        dsound_logerr(hr, "Could not get playback buffer status");
>           return -1;
>       }
>   
> @@ -309,7 +287,7 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUREBUFFER dscb,
>   
>       hr = IDirectSoundCaptureBuffer_GetStatus (dscb, statusp);
>       if (FAILED (hr)) {
> -        dsound_logerr (hr, "Could not get capture buffer status\n");
> +        dsound_logerr(hr, "Could not get capture buffer status");
>           return -1;
>       }
>   
> @@ -340,11 +318,7 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
>       len1 = blen1 / hw->info.bytes_per_frame;
>       len2 = blen2 / hw->info.bytes_per_frame;
>   
> -#ifdef DEBUG_DSOUND
> -    dolog ("clear %p,%ld,%ld %p,%ld,%ld\n",
> -           p1, blen1, len1,
> -           p2, blen2, len2);
> -#endif
> +    trace_dsound_clear_sample(p1, blen1, len1, p2, blen2, len2);
>   
>       if (p1 && len1) {
>           audio_pcm_info_clear_buf (&hw->info, p1, len1);
> @@ -366,40 +340,40 @@ static void dsound_enable_out(HWVoiceOut *hw, bool enable)
>       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
>   
>       if (!dsb) {
> -        dolog ("Attempt to control voice without a buffer\n");
> +        error_report("dsound: Attempt to control voice without a buffer");
>           return;
>       }
>   
>       if (enable) {
> -        if (dsound_get_status_out (dsb, &status, s)) {
> +        if (dsound_get_status_out(dsb, &status, s)) {
>               return;
>           }
>   
>           if (status & DSBSTATUS_PLAYING) {
> -            dolog ("warning: Voice is already playing\n");
> +            warn_report("dsound: Voice is already playing");
>               return;
>           }
>   
> -        dsound_clear_sample (hw, dsb, s);
> +        dsound_clear_sample(hw, dsb, s);
>   
> -        hr = IDirectSoundBuffer_Play (dsb, 0, 0, DSBPLAY_LOOPING);
> -        if (FAILED (hr)) {
> -            dsound_logerr (hr, "Could not start playing buffer\n");
> +        hr = IDirectSoundBuffer_Play(dsb, 0, 0, DSBPLAY_LOOPING);
> +        if (FAILED(hr)) {
> +            dsound_logerr(hr, "Could not start playing buffer");
>               return;
>           }
>       } else {
> -        if (dsound_get_status_out (dsb, &status, s)) {
> +        if (dsound_get_status_out(dsb, &status, s)) {
>               return;
>           }
>   
>           if (status & DSBSTATUS_PLAYING) {
> -            hr = IDirectSoundBuffer_Stop (dsb);
> -            if (FAILED (hr)) {
> -                dsound_logerr (hr, "Could not stop playing buffer\n");
> +            hr = IDirectSoundBuffer_Stop(dsb);
> +            if (FAILED(hr)) {
> +                dsound_logerr(hr, "Could not stop playing buffer");
>                   return;
>               }
>           } else {
> -            dolog ("warning: Voice is not playing\n");
> +            warn_report("dsound: Voice is not playing");
>           }
>       }
>   }
> @@ -414,7 +388,7 @@ static size_t dsound_buffer_get_free(HWVoiceOut *hw)
>       hr = IDirectSoundBuffer_GetCurrentPosition(
>           dsb, &ppos, ds->first_time ? &wpos : NULL);
>       if (FAILED(hr)) {
> -        dsound_logerr(hr, "Could not get playback buffer position\n");
> +        dsound_logerr(hr, "Could not get playback buffer position");
>           return 0;
>       }
>   
> @@ -441,7 +415,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>       err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
>                             &act_size, NULL, false, AUDIO_DSOUND(hw->s));
>       if (err) {
> -        dolog("Failed to lock buffer\n");
> +        error_report("dsound: Failed to lock buffer");
>           *size = 0;
>           return NULL;
>       }
> @@ -457,7 +431,7 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
>       int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
>   
>       if (err) {
> -        dolog("Failed to unlock buffer!!\n");
> +        error_report("dsound: Failed to unlock buffer");
>           return 0;
>       }
>       hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
> @@ -473,40 +447,40 @@ static void dsound_enable_in(HWVoiceIn *hw, bool enable)
>       LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
>   
>       if (!dscb) {
> -        dolog ("Attempt to control capture voice without a buffer\n");
> +        error_report("dsound: Attempt to control capture voice without a buffer");
>           return;
>       }
>   
>       if (enable) {
> -        if (dsound_get_status_in (dscb, &status)) {
> +        if (dsound_get_status_in(dscb, &status)) {
>               return;
>           }
>   
>           if (status & DSCBSTATUS_CAPTURING) {
> -            dolog ("warning: Voice is already capturing\n");
> +            warn_report("dsound: Voice is already capturing");
>               return;
>           }
>   
>           /* clear ?? */
>   
> -        hr = IDirectSoundCaptureBuffer_Start (dscb, DSCBSTART_LOOPING);
> -        if (FAILED (hr)) {
> -            dsound_logerr (hr, "Could not start capturing\n");
> +        hr = IDirectSoundCaptureBuffer_Start(dscb, DSCBSTART_LOOPING);
> +        if (FAILED(hr)) {
> +            dsound_logerr(hr, "Could not start capturing");
>               return;
>           }
>       } else {
> -        if (dsound_get_status_in (dscb, &status)) {
> +        if (dsound_get_status_in(dscb, &status)) {
>               return;
>           }
>   
>           if (status & DSCBSTATUS_CAPTURING) {
> -            hr = IDirectSoundCaptureBuffer_Stop (dscb);
> -            if (FAILED (hr)) {
> -                dsound_logerr (hr, "Could not stop capturing\n");
> +            hr = IDirectSoundCaptureBuffer_Stop(dscb);
> +            if (FAILED(hr)) {
> +                dsound_logerr(hr, "Could not stop capturing");
>                   return;
>               }
>           } else {
> -            dolog ("warning: Voice is not capturing\n");
> +            warn_report("dsound: Voice is not capturing");
>           }
>       }
>   }
> @@ -523,7 +497,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
>   
>       hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, NULL, &rpos);
>       if (FAILED(hr)) {
> -        dsound_logerr(hr, "Could not get capture buffer position\n");
> +        dsound_logerr(hr, "Could not get capture buffer position");
>           *size = 0;
>           return NULL;
>       }
> @@ -544,7 +518,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
>       err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
>                            &act_size, NULL, false, AUDIO_DSOUND(hw->s));
>       if (err) {
> -        dolog("Failed to lock buffer\n");
> +        error_report("dsound: Failed to lock buffer");
>           *size = 0;
>           return NULL;
>       }
> @@ -560,7 +534,7 @@ static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
>       int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
>   
>       if (err) {
> -        dolog("Failed to unlock buffer!!\n");
> +        error_report("dsound: Failed to unlock buffer");
>           return;
>       }
>       hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
> @@ -577,7 +551,7 @@ static void audio_dsound_finalize(Object *obj)
>   
>       hr = IDirectSound_Release (s->dsound);
>       if (FAILED (hr)) {
> -        dsound_logerr (hr, "Could not release DirectSound\n");
> +        dsound_logerr(hr, "Could not release DirectSound");
>       }
>       s->dsound = NULL;
>   
> @@ -587,7 +561,7 @@ static void audio_dsound_finalize(Object *obj)
>   
>       hr = IDirectSoundCapture_Release (s->dsound_capture);
>       if (FAILED (hr)) {
> -        dsound_logerr (hr, "Could not release DirectSoundCapture\n");
> +        dsound_logerr(hr, "Could not release DirectSoundCapture");
>       }
>       s->dsound_capture = NULL;
>   }
> diff --git a/audio/trace-events b/audio/trace-events
> index 737e3e60694..b2f29666700 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -23,6 +23,11 @@ dbus_audio_register(const char *s, const char *dir) "sender = %s, dir = %s"
>   dbus_audio_put_buffer_out(size_t pos, size_t size) "buf_pos = %zu, buf_size = %zu"
>   dbus_audio_read(size_t len) "len = %zu"
>   
> +# dsoundaudio.c
> +dsound_clear_sample(void *p1, uint32_t blen1, uint32_t len1, void *p2, uint32_t blen2, uint32_t len2) "p1=%p, blen1=%u, len1=%u, p2=%p, blen2=%u, len2=%u"
> +dsound_wave_format(uint16_t wFormatTag, uint16_t nChannels, uint32_t nSamplesPerSec, uint32_t nAvgBytesPerSec, uint16_t nBlockAlign, uint16_t wBitsPerSample, uint16_t cbSize) "wFormatTag=%u, nChannels=%u, nSamplesPerSec=%u, nAvgBytesPerSec=%u, nBlockAlign=%u, wBitsPerSample=%u, cbSize=%u"
> +dsound_buffer_bytes(uint32_t caps_bytes, uint32_t desc_bytes) "caps_bytes=%u, desc_bytes=%u"
> +
>   # pwaudio.c
>   pw_state_changed(int nodeid, const char *s) "node id: %d stream state: %s"
>   pw_read(int32_t avail, uint32_t index, size_t len) "avail=%d index=%u len=%zu"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


