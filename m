Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D77DEDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvYV-000755-CW; Fri, 13 Feb 2026 10:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvYT-00074t-PP
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:58:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvYS-0001Od-54
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:58:05 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAiW1K1341835; Fri, 13 Feb 2026 07:58:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yKAb5Tgs6DQeszQRVR4WpzCGLR6J2d30lQTbyhzsf
 Tc=; b=gdRgdnTSf0ab7gM3wqMpOWFE9gyOyxhs00kIhErWA+5CGE5527CNvBxnd
 TFttz7dHvt8l01u3ynNuYyejoUKeNpgf16Lj+alXGBFR+ktWYs+RDz0tyhLn0zHS
 7OOLGyv7ZEQ2HUCDgwo4fo3MMjX6rgIo0ZTqwOKALLois9YIghRBcwBvkp0HP+nY
 I/9wwcAdmsp61AL98bpLZPPpo1CCvZMFjvKaYP0flx4ggyI/VltinK7Iin087VpN
 cVI4/I/Hiek6v8BNmpp8PbhzQVl2IcW/GlmVEhjXdNJVUyT4lXcosXJYkM3eFYcG
 CmkEn5/ty3dBsKCHJn6/Agz24uhZA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023131.outbound.protection.outlook.com
 [40.107.201.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8k9s8de6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNc6CW6TEIJI1g1W+OhHvLjqziYjDT5haUDqgyjJCelMROAicDTr0aQGp4oVrO8C+h0f7knKJnf2LT0Yfpxr3Lk+Cl9G6kca55AU/Ro8Ih5WdUxKLReJE3cRTaJWYfdXhhwmmH1yayz/27/UyH4sBla2+x2JrmrpZbopI6eI0eZTkuyHE460UMShfoKru5JQ10tWFS6rmkzEyAFAkJW1wKJArpA4Db1nhy5MwXwEmq8l1TYZBl8s1zn6Z6xQhCpjEVQTDRn9gegiq4sI6Xg9i5Y7cLRiXawhcUwHWBfervkmWOw2+L5FK6FtjN8bwYNP7z61qj+kuA+lZXXO28AhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKAb5Tgs6DQeszQRVR4WpzCGLR6J2d30lQTbyhzsfTc=;
 b=DBVJGi8iQ/EV7K4ewRRAW1BOxROZ1MatZQcrAeX8sDPTiM7wLx50Dy6yxwSbrrThB466jCR6NOSH3bUJO0anWevC1cVYD+fKtYWBrJ31KqpY6qSeMJS+aML3ArwAEO2t7m6+nV9/sJ9ofcKSNQcSJbaoteyLG0HcXL+cLoz8MxY3pkMr5YLxXbER+tta1mBNMS5eypgTc89vklZozfpMfPAke5XT6dpbD8RyGSJ5gfhSxS8QeIIZHv7PJLZGs1iXWN49EpNbUQYOxPWUvt7op8WY8ZYNV9f6pzu8HPjQOM9S3nWSuNEwwC9NCiUWHvTy0gRsZt29Eo1/4XNsQAMSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKAb5Tgs6DQeszQRVR4WpzCGLR6J2d30lQTbyhzsfTc=;
 b=JFJOfhFpDEABn1aycj+IVDc6mL6EGJYf/EwZfS+uP//W+pe8ImQG4DSsYE1WNYsuZ9Ha1iJQKFOPRdIpGC1GwCdax7Ig3+3LsksA1BlpM0396rtjYnF+LMBT8/V/AQO8tDD5EC9JHQPdZwAt1mvg1kZG8H0G1q2qgA5U/7mfbDIcpz7JBBVFCBVqyIqCzSg1643yIbpBQnxCS7YkDwCmOEFjE0jaDfp/9lSpNaqWNMONwQLLx/1eswM+emrUjFDw5ganU2vU1gitX7fePuRcqCuYY/2ElP4qTYIzY1GPGG+LkpQjUjrQWFLwFutUFGXv65rZb1Mn2fk9uYZHdBavWw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7866.namprd02.prod.outlook.com (2603:10b6:610:ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 15:58:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:58:01 +0000
Message-ID: <a6e7ec45-7a52-442a-bb1a-9a11eb52db87@nutanix.com>
Date: Fri, 13 Feb 2026 15:57:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/43] tests/audio: add an invalid settings test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-39-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-39-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:610:76::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a2f929-8df8-4706-ae4f-08de6b18a9fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3A0UDk2TmRoZGI3ZlArdVVGQjMwU1JuckxnZlJJOGo4T0dFZ0VOQms1aStk?=
 =?utf-8?B?djkyVXNDVXdUbVl2OXRyQytrR3dzazUwNG1LVzczOCtueEtCeENheTNJeldt?=
 =?utf-8?B?SDVCNmZ0ajdVdnpUeS9vMXJOMkFVRGsxT1R0Tm9Ec0FuUW1mR1lEZlA0T3Yz?=
 =?utf-8?B?S2cxREVhS29vbTE2T0NodTI1TFVkbmxaNk1XaEVUK2FIa1dpTE5SVUFaUS9J?=
 =?utf-8?B?L3ZEM1V3SjlmcHUxemRjNzIyem4zK0tPT3IrUE9jU292ZzdieUZIZXdKSGVa?=
 =?utf-8?B?TkZDTzN4anFXbC9CY0QyNWZvaHFxY0lLL2lCalY0V21hSkpiWU5wRUlXWm5y?=
 =?utf-8?B?VW9wZGRWdytacERoYVYwYkNqUUMxSk9KQzFKWUtybjJHMjFjZWxoTFlMQlQx?=
 =?utf-8?B?WmRlZEo1Tm05RkNyK1lncUVUNjF2OVd2SjA1bjRoZlB3TmhqZ1daVFRIcnhT?=
 =?utf-8?B?QkxTN3VNbHhEN0J6Q3YwR05QOFQ5YVdIWE5UZksrNWc3UnZVeU5jb3BxQUdj?=
 =?utf-8?B?Q1FIOGxDTUtoZWN2ejFmU0tRdFlvV1BOajk4Z0lUeGp6UVAwWGhKN1BCc043?=
 =?utf-8?B?RnNiRjlGeGVIZ1NwdWROTjF0Q0MyNzJ5NnYvbmhtYkFhOUIxWjlhZzlBaXEv?=
 =?utf-8?B?Kzl6THNSMDdFS29iVVJsSW5ZcFBSRklCR2RPdzdORUVmajArUURaSVJPM0M5?=
 =?utf-8?B?RllhMU95dUU5emZlZ2tsR2RZS3A5RGJIeFdTaWxGRkRDcElvckZTSEJGUUxP?=
 =?utf-8?B?Tm5vekxjTkV5aHc4WXE4NE1IZDJ2Z1d5M2FqZm5KcE9IZ1BPMWJxK3ZuRTRZ?=
 =?utf-8?B?SE9mdFVhREpTQmMwd3pFTUIrcUNTRXh5Y3hVanN1d3d4WGFIZkxtTythVldD?=
 =?utf-8?B?cXR2VGlhNDZ6L0NHenU3Q09NRUFuMWl0QXpnb0FEQXpDK21aVjZMbVJIQ0FK?=
 =?utf-8?B?bFFDQ3ltY2p2NW5vbXBMZXNGTjBLWGRYTG05TUVyT1I2Vzc3b3ZwZUFBRWJG?=
 =?utf-8?B?eW9DMzdJVit6VkZiT1lxb3BheEVHWWVSV2VDTU9USGE0elZEbmdUMG41OEtD?=
 =?utf-8?B?bExTWCtJWEZwdzVySkJMdE9UOTRpZmRpeVpzVS80eGgvM21SZjdiQ1JERUFQ?=
 =?utf-8?B?MUlxbXBMR0gxL0dVM1o1R0JsNVdrQjJLcmFEN2l5NDcxNDZzZEVCUzVITUVi?=
 =?utf-8?B?d1N1R1lFOFo1eUQrTHpocGg5aUZ6ZVJhUGxlTk5mVTZpNGFUYlJIKzFxSzB2?=
 =?utf-8?B?WmVMeWx3bnlhNTlwbHNXUVM0cnRuUTVRL2xON3h5TDFOclVwNnJkTHpHOVc1?=
 =?utf-8?B?anJvMlJTZ2JyeE4vdSs4bDZ4eTE3RWlUbWNXblN4NG1TZ1RtS0RuYkozYUt4?=
 =?utf-8?B?bmJIbWZ3dDZDNXNnZWo1WlRTcjdxNERLeW0wL2ZienM3cVEyZUo4by9Pdmpx?=
 =?utf-8?B?T2Z4Qjd4TkRTU1IzM01RelNzaXU3S0tIcFRrSzdGM2VsMDYyeG9kLzR1eWRr?=
 =?utf-8?B?d0FPUGZhMGZkUXMyVm0ycVdlRWVUZlZ0R0tiVnZ2YTJVWG1FekpaaUE3WjFl?=
 =?utf-8?B?VDdvanFqUWtUeW5paEtJcDA5cUpnb0xCNUJ0TFJCczdFL3BTVlJyV0pGNmtm?=
 =?utf-8?B?YW5rZmxad1Z6WkZqL1hlb0YzNnJKNGt2ODBCeDZrMXZ3Q0NnQXk0YjcrN1Fa?=
 =?utf-8?B?ZnU1ZzJUa205M3FFRlQ3MzBmclI0T2ZWZHIwM0s3VUlLRk5VQ2lqcGtuM0s3?=
 =?utf-8?B?dTBqVE1QdEFYSEVoWUlzVTg1OTZ2S3cwZFZFUjYrQTcxb2Q4TGZwRTFxNStE?=
 =?utf-8?B?anNMQWFNY3dMWWN0NXAwTHFxVzlCVU0ySWI1R0UyOFlqQUFveVFGOWZHZFUv?=
 =?utf-8?B?WlNYUTd6VE1jK0cyeFo1bU85ZlNqVDAvTVUwSjZ4WFdnZ1draDBQS2JvWE5E?=
 =?utf-8?B?OUFFcjlJZUZPT3BnOTJPbmx1d2dOMjJlTnV2R0txNTNyaVJDZWdxWmswUHlj?=
 =?utf-8?B?ZlRsWDVIeWE3VTZXTGdNWEs3T1VkbHgveENiYkFjQTBsYUhzR01TYU5UMUVB?=
 =?utf-8?B?aEFMUzlsMkEwQVlaZnc4Z05IYTZDR0hGdW1CUjVGV0d5ZElmbzRRazhGQlQr?=
 =?utf-8?Q?524U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xtYkJzVXlxWHgvUXNKUG5RTnRiZVNRcU5oUXhkTHRMN2lzNmF4RVJ3MU5a?=
 =?utf-8?B?NzVUeFJIV00xalBxRXdBYkxFQTlVTUc1K1lWMWh2RFBmd2lJblRDcnR4eXRR?=
 =?utf-8?B?N3B5ZWZWVEo5bE5XU2pBTVA4bGd3aHhDWVBwSERTUGtZeTdLQ0hUdlpCdkZH?=
 =?utf-8?B?aUdHMmttYXZuaGcyQ0RNSzRadVFCM25SVEw3cWpvWXRoaXZLU2NQOWRtWktz?=
 =?utf-8?B?eHRkd2dBZzc2NlZpejhyYXBuZ2t2M2c1ZWl2WndQOWJtRWROemRqRlMxT2k3?=
 =?utf-8?B?SnV3QTBpbkhrOGtqUWNaa1YxK3AvT0UyNnV2UWtlVG85TU5sWWZjaTN6ejRj?=
 =?utf-8?B?VVVWTGFIRVF1NG1DSGg5NFRRY3RIYjhGRTlxK016NitjVm4wSW9aMGRsd05X?=
 =?utf-8?B?OTVPdWliaTlOUmFGVWUxcmU4ejlPb3drQUFWZmZpT2ZnQ3oxVDlaMUMzbHBx?=
 =?utf-8?B?Tzc1UzlMTkZyeUt4aVlCOGFhWTZqSzN0b2NMekZoRjIxaTVCRkN3TFpLdGxh?=
 =?utf-8?B?WFZrOFVEY3NNaEJzeTVnTEQzWnB2WUNoZ0syeFVvNHNDd1VjV3A5MzhHQkRN?=
 =?utf-8?B?a1djOWcycDduZ2FIZzZXTG9HKzVQTjBsWnQzVHdZVWZROXE0QWFMclQ3bjJs?=
 =?utf-8?B?U3VGMXNweEw5U2tqOXh4NFdzUzZPNXVGckhsN2h1L29LRnZyTGlxMEIwS09J?=
 =?utf-8?B?KzArdmFtems5MnlDUUJYYUhVb01kMGFaakhRMkwvWThzdjJzOW5sUm5sd2pN?=
 =?utf-8?B?eXNJYVJoSm0vckVRS2pBK0xuTi9oRzdwVEVjUHp3V0w1RTFuOWNmK2JxSFZO?=
 =?utf-8?B?dEhPbk1nblc1aHhESlJkMkd0enIwMmtOZ2FSYW9QVUtBTUtnSkNVdk9jVmdG?=
 =?utf-8?B?WWQ0NzBXcmh2NFhQMVBwZHBaeFJTZ2xmb213c1lwZ1lFOVZVTFh0eGlJOHdM?=
 =?utf-8?B?MnVOL0tjb0NGaXhyNjZzZmhwalU0TkZKa05FRkQ1ZCt6OGpWbXFZbEpYQ25w?=
 =?utf-8?B?NFZlRjZSU1RKSktzUGdDWmhRazJ3RTNrZFlxenJpQVI4eWtVaTRCbVVWWUhJ?=
 =?utf-8?B?dnBKUXdCdGwrSXc2Y29GeENXWFBBUGl0U2tITVdIT0RyZWNkZ2VxY3lqcnZh?=
 =?utf-8?B?bnIxM21hUFF3eW84K0g5Zy9XbnQ1OURiRHBTS28vUlpCU0w3akZOL21zTkdU?=
 =?utf-8?B?UVBsU25Ja3ZSclpPdEx4c0UwdkRhdTJMd3pOeDQ0aEUrKzQ3TFlwazlDc0Z3?=
 =?utf-8?B?Y1ExRWtaTExCeVg2Z203MkRtS1h1M2gwcVh1bTJpTmQ3d0ZRYlEreERUMXRu?=
 =?utf-8?B?K21lc1ZlYmo3MDh3QkJHNU5oamlxdDdhR0JHeTVjWGIwUHVvaUNTazZBcUVL?=
 =?utf-8?B?UHdyWjdxV3MwSmhPR1g0bTU5SEVMa3prVlovdXB0ZTk3Z0RpRURQUThpMVNJ?=
 =?utf-8?B?MHlGenIwK3o5RlJaNFFIaDBxbjJ6WUwxVFlHeFpBYnhSWFJ5cmlXREdld1ZO?=
 =?utf-8?B?QXdPbU5HUkQ5TnFVV0hpTWJ2cEZMODV6cEYwRW1FYThyWk1URHZ4c1QvWTJ6?=
 =?utf-8?B?WFd3RURLbTdxcXVSalI1NEdoUHM0VkZ6Wlg3QXduWE90eG5nM3Q4ay9ZY0Z1?=
 =?utf-8?B?MXF5aHNaa2xHcytSeGV3WUdCY0tLTmIrMkFaVUN4NitoRnk0S1czdmxWdUtl?=
 =?utf-8?B?bTU0L0dLbnBYZDJwWHQrdVd2WEJCMGlWbGZ6WTdQcTJLRzhWd1JPeFBVR2VV?=
 =?utf-8?B?eVNRNGtwUzlwSHZGSmtkaU91bkRUSFdMeEZUMVJ0MGNJRHJSbVRSS2w5RDBz?=
 =?utf-8?B?Z1RCNmdSY0p2emsreVRJanF4eXZEbzJ1MVNnY2g1dHMyWGpUeEt3c1gzOG93?=
 =?utf-8?B?R3VyU2ZhczZXRkRCR2U3Z05PYS9Ba2g2Tk9LcmQ2a0ZYdjNabk41VHdmRS9X?=
 =?utf-8?B?RjZOK2ZoaEUrNWEzNjE1YlIxRWsybDBRVVZNWlRyUFowaGtYRmNBNS9McHZ4?=
 =?utf-8?B?bldPU3BVRDhGSmM1blliYkJBVkNiNUFpdVpmWldJbzljMU1jOXYwMzZwYmI2?=
 =?utf-8?B?cXJGSVY2T0FyclRCVkJmRGd2QnZyUkFrbkZNZzdtWWRhNTA2YnU3VW5rZHNz?=
 =?utf-8?B?Yy9oYVp3c2tpVldlTG4wYTNJMnRMUkVjbGlHOGFHZTQrTmk2SlNOTXg0Qmlu?=
 =?utf-8?B?K0xBdDQzYUFxZGduWEYyNWwvTmtzOUprVDdJd0dnY1B5SGFaVk1hVWRYOW9x?=
 =?utf-8?B?TjBPS2YycEx6V1V3SzBMTitaRWVRTk9DaklrRDdxR1l5dUN6OWIzMFZxQmFt?=
 =?utf-8?B?eVB0TjZZamlWK213L2xqdGZnNWdOc29kYmNsc0U3ZzBQcVVDUjg0azY1bGlj?=
 =?utf-8?Q?MBTLJYRDib/c+P1Q=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a2f929-8df8-4706-ae4f-08de6b18a9fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:58:01.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PA7b2GVAuAq1k3ylfdrdAq4emHG+ITnXIqfUUnfNlo5vG9v5yjeyBapb8a13kvKb5FHLV6FDG4cXjgaUoXRm5BZLJb6Eae8E0r+ccG27W3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7866
X-Proofpoint-GUID: ZILIuewpStwG4m6FCXJ_4Op8nI0khYT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMiBTYWx0ZWRfX/3cuq5VgmksG
 2Hu4sInB7ToemOxSLsfxMnfcelbrXc4Q90654nUpXGMQ+7thP3hzop1CcHrGGM4M/SQfqjR0wZl
 CNMrM7l3Aty1BzpAg0Hkq2bvBNdcf/UvlCuackkIPMhzmR2NTvoZTf/cTkJCc1Fs28PnAjRlCgX
 oDukIzfL0TZuKj3D5hxc2SqCy37PTckN507ujFtgzQTtIfDPctHSXbjxNdiuSiWTSRMw6gf5aBx
 494e4cMydeLMDOrp9G79CcpbDToa+n1v8e492nX9xyjYPeD2o3IHy6cHDB0GgN8Kjrc3BJ11uc0
 0UTun16Wipsu9HNZLNfumT8Jn4SI+btK9ZJINw23rl53C9ctGEGmPYnGCNcaSb/M3N35ZmB0/Ns
 ZwzvrsK3nXxVEowT3BOrsvvlt18X8v/4RTheTNfcQxGw6mO+mJMs9tXn2NapwyzCPFJZNd5ao+K
 Op1ftMHsULBnJrgDZtA==
X-Proofpoint-ORIG-GUID: ZILIuewpStwG4m6FCXJ_4Op8nI0khYT_
X-Authority-Analysis: v=2.4 cv=DrxbOW/+ c=1 sm=1 tr=0 ts=698f4a0a cx=c_pps
 a=YiOwH4ClqGLeqjbxKXDYtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=2ljc3MGQc4D50yr7iioA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> As we are going to change the related code next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/audio/test-audio.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> index 98e77cf542b..4590e2f7259 100644
> --- a/tests/audio/test-audio.c
> +++ b/tests/audio/test-audio.c
> @@ -519,6 +519,26 @@ static void test_audio_multiple_voices(void)
>       audio_be_close_out(be, out1);
>   }
>   
> +static const struct audsettings invalid_test_settings = {
> +    .nchannels = 0,
> +    .freq = SAMPLE_RATE,
> +    .fmt = AUDIO_FORMAT_S16,
> +    .big_endian = false,
> +};
> +
> +static void test_audio_invalid_settings(void)
> +{
> +    AudioBackend *be = get_test_audio_backend();
> +    void *voice;
> +
> +    voice = audio_be_open_out(be, NULL, "invalid", NULL,
> +                              dummy_audio_callback, &invalid_test_settings);
> +    g_assert_null(voice);
> +    voice = audio_be_open_in(be, NULL, "invalid", NULL,
> +                             dummy_audio_callback, &invalid_test_settings);
> +    g_assert_null(voice);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       GOptionContext *context;
> @@ -573,6 +593,7 @@ int main(int argc, char **argv)
>   
>       g_test_add_func("/audio/null-handling", test_audio_null_handling);
>       g_test_add_func("/audio/multiple-voices", test_audio_multiple_voices);
> +    g_test_add_func("/audio/invalid-settings", test_audio_invalid_settings);
>   
>       ret = g_test_run();

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


