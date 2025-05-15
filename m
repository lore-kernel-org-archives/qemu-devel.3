Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B7BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamB-0007cv-5F; Thu, 15 May 2025 11:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalX-0006Il-Ow
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalU-0006Dh-Jl
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:59 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7p8s2009723;
 Thu, 15 May 2025 08:44:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JsL49K9a6ej+cz0VI0i4HZ8MV1hh+/ssVQkPAgqRe
 uo=; b=YyPloKPscUMJMk4vX9k9wqiyf2no5DMrZTKvWNXpYoLBTShS3HuHEqQGY
 VjCYS2zWiZoE96MPOsXQX5pCIRlab5ok7Vfo4WzOjjEGLk3p4+SRrVOKqJw0LkqP
 RznwoMrlppg5Djzpg4XvILWZ/OTYlb2+WZGYbuBdekuIUxvlmMVuerYlTDVHEfTe
 5G01kuxzK966EYJeZBixDH3vtg1ZoCofz8ZUS4onaOYinVRnKgvRzcDpnoWQ4G/a
 hLzRV+ej6tzgyueMyqCdJN+KVHFKtXaaIMVCktZOD/OVotJ5GgPcyyoIV4qFSf8g
 u1LSWbb3inKa5c9vyHAMCByizqiOA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcwwdy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwBiq8JutPM64RAkNXeeSD6PgZ9zLbhNnNLR5ngJCHynk2PdJ4W80eN6YxLU9Q8LCB9xWK3PPwiI2Lu03ofG9DCoJSL0H1E2oGylveiYP6mk+JK8kpwfHaOVPEHtHmow8RA7y080KRmRZNV37SeKOlIe5VS7Cc3zrmCMI0XTo7TeXsNMCOybtbv7MqBJq9eE+DF9iM48VEkXKqcu5NXDiy4GBYlhUlRmlI0CA5LzaLUwM5O8w4d5nShm5lHKCYgxU0O5dM5ib4W2mB+8RC5mGksl1V4iBgyknylqSH4OS7B+GF2w7se+4VwpkCLY+b1bKoIHfhd721JzBIkX3TDCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsL49K9a6ej+cz0VI0i4HZ8MV1hh+/ssVQkPAgqReuo=;
 b=HGM9c9TyZtTh+QuCZzBHH/YYbguNV58Q1GNV0lS/T9m0pvW9kr/7i5G1tcZ/CCO+xbInZI6a8daMZbRy1qQdEQ/lk6cRLbdkcLNLnb57U9u8B8hLa8YvMQ52qv/gKrJlOZvsWvm3WgUXhqjyL+0mrjZms2O2360vYjHvn0Rv8HCiGQSRR7495fpgRvGJqhxe6lpkus8ePV/5i9K4dSgIlpdw8KUIUbmrxNuK1ldRk/Rg9Y1bS9bdyD/Vu0nWMdLR67YHMYY6n+WVIuipdBz/kmz6V/XuC1SxlzTj4RGRoPBhcFo4wb0TtqXUNw7LGC7gcnZsCmJmaPLbDloqNAmc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsL49K9a6ej+cz0VI0i4HZ8MV1hh+/ssVQkPAgqReuo=;
 b=dJUBXpZCsF+Hk7D0WzPUk4yhGRuvLVc0N9e03auyxuKWDPLp3rLgoNwVuDx7HUsX9Hij5/TDl5FjtgWqNQ3/Q7FZAWkojY21Rpz2BdTT2OTihJXyDBvARjhD2t/GbDRwNsdOTsTn9Z10QsxcQVM6s8ZD5UFhvey1IKcc5NzgSCqyGZpnIpg/4lrJxOHdBmSjgcktfxFXkC5i7nPRjdLKUlUH51KGIjSgDiSJ2zQ4qUTKSQYPd0xiqtNFc1NduQr44SPPZYeo7P7Y/WD/mkp4Sn4GRaFi1215zE2ePmrl8NhYEpeqS5y0lnZoMsPtWfXT0hsal1fAn0pbRVPP71SVjA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY1PR02MB10459.namprd02.prod.outlook.com (2603:10b6:a03:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 15:44:49 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:48 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 12/27] vfio-user: implement message receive infrastructure
Date: Thu, 15 May 2025 16:43:57 +0100
Message-ID: <20250515154413.210315-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY1PR02MB10459:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d86423-a5a5-4230-9313-08dd93c76c87
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDRHRzBMcGErOVFOWndzNGNlVnBIZ1Z4VmRJbEs0VDRCSTFCT2FnZlBhSkpw?=
 =?utf-8?B?M3dpSTgwUnhhc2VPWmNBQndUc0dMTnJkVWRYYnR2UldHNjl1VG85NHp2NGMw?=
 =?utf-8?B?NUplNFZTSGplWXJuUC9yeHk5d2g4c1dHeDF1V3B2RG10aWU1cW1Hd1R1Y3Bw?=
 =?utf-8?B?ZjhzblhWMjI0TmtoZC9MRStHbnNKN1BDcmdhSU5sMmkvb2I3NnYxaU9DSVVt?=
 =?utf-8?B?SWM1dVhYQnBNcWdNY3lOWGJHa3M0UDhlcW5ERHd5NTBNRnl6VDN6dWhNbUl1?=
 =?utf-8?B?VXBVMElVMkxjVDBTU0h4ZnB4Uko1UkRVZitDb0ZQV0ZXRmo1aHlUWWNxcHZH?=
 =?utf-8?B?dU9xelhzUGhpTkVYZyszalh0QmNBVE9yblF6RnM5NytnSUt5WTlDWVNOajBO?=
 =?utf-8?B?WWNzRGZFSGtORkVtbFlrZUpoV3lTUm1pRks0Yjc5V05FZndwRmhidldzcWdZ?=
 =?utf-8?B?ejNwR1ljUXdxOHJjbHh2UnhIaDNYMWFMRy9JbmZnYXRuOGo0RW9xYTd2a3Yv?=
 =?utf-8?B?Nkp3VzR0TExxUU9oREoxbG9JS09MUjh2elJjOGY1TDZnbkNkNXJqYnhMbFJl?=
 =?utf-8?B?RCtDcDl0eVpoUkNGRUtOajV4dnBSVjZST3R4dE9aU3lQQ3ZUKzRuZGN5N011?=
 =?utf-8?B?N0RMbXF0U25iRm02bTRRSlFISUxVRkovWkJmaGlwQVp2bjF1YnZTVVd6VXlC?=
 =?utf-8?B?blVzdnpQd3hqdk5CSEw4aWxLcUo0Qjg1SjNwcGJ1RTU5OURYTHdLYmNqa2R2?=
 =?utf-8?B?UWx6VW8zbVh6SVRjZE96YXNqaDd0NkM4OFpNejVhNEhIMndMYVZVZXZFdUNG?=
 =?utf-8?B?SVBWUkN0dTJwQWRBUjNCZEJOc0t0UUY0b2sreG9rMmVLMjk0MGliYXdaWVlG?=
 =?utf-8?B?UGhjbzkxOTFmMmJtSWp2ZWpaS2loSnp5UjdSemtiTXZWWE1aaWpJQ1pLZmt3?=
 =?utf-8?B?bXJDWGNMTEs1YWl6YndVUG9GN0RpM0lxQ25TRGVKZWV2Y1MyWTFpVzg5NlRB?=
 =?utf-8?B?UTRIQTBDTWNQdjFiVXY2YjhFWU41enhGcmJoSHM1SmVKUDYzcFBMQzJTalJz?=
 =?utf-8?B?ZFZQdmozR3pTdWFBSHQwUXdsQ0NwaGovaXl2ZjZCeHptZVptUEJOamVIc1hn?=
 =?utf-8?B?eWZKT1RFMWpURmFVaXR6c2VjdG1vaVVSUXo4UEFTeUxQYnFTa2hSVTRGUmEx?=
 =?utf-8?B?dEZwMU8yV21McHlXN3RhZDFoeTJySFV3UjV5VjlRa0dxZU50cTR2aXlJKzRF?=
 =?utf-8?B?YlB6WVJVaGozeHhnVko3d1IrWmpDSzdTWEpKcy9XZFR4K1JxUk9SeWE0VFd5?=
 =?utf-8?B?VkhDOGxRM01WQ2RXdno0cjgyRWgzd1FHbFQxZWIybE1lVEc0cnVTbURoWWVK?=
 =?utf-8?B?d0dvK1pkMmhkcjdKR3RZNGk4RExoNEQ2VVhuYmdiV3lRelBUd1NWT2o3QVhu?=
 =?utf-8?B?UHUyZlJmVDVGMSsyS2FpeGNrQzRYVENVM3Rsd2wyZktxc2ptaGZLOENudHlE?=
 =?utf-8?B?emF6Q2RJQTlpT2FCQUk5WU14TEM0U1Z3UU9HdHNhYnNMeWV4ZHU3em16ZzhD?=
 =?utf-8?B?ZWY1eExzYnlaWWRXYlVRem1hY01KemN0NE5TVW96eWtBUkc4YXNNQUVPQzUv?=
 =?utf-8?B?djFpWDlDTWJwdGcyaFJaNG5kNHkrUS80enVLUDZIaytiZ3dhM1VCcVk4ZGN6?=
 =?utf-8?B?WjM2c0JIYUlhWUVoSDJ5cVBxSzYrTjM3d1JkcXFFQjFYZTZjclZnSlBWeU9l?=
 =?utf-8?B?SDNiUFRhR1dlWjNFSEZpeitPWUNORC9BZFdpQXBSaU1acG40SXFPbGZIZnhY?=
 =?utf-8?B?OHhCelR3WDgwTWpUNmNDTkJLbDhwRnN6MGx4Y0FiUFZhRXgvdHhGTmpkZk1q?=
 =?utf-8?B?NjRpaTlhM2o4RmpqTEtxeDFOc29hbHdDRnVTSS9BaFJXY3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXUvelhSWElDNVBCb0pYSTh5Vmo0L0hIQkNaMTdiVGRhaG91ZG5FdWlpeFFa?=
 =?utf-8?B?Q0lRZnlScUpqYTEvbnkwNUhjZTZ1RC9FTmxrWldremIwek9HZUtKQnNzcTdQ?=
 =?utf-8?B?Y0NZdjRpcjN4em5EbEZ4WU9lMEVneWZpQStDTzN4bTRMYlVYdndyLzArWDMz?=
 =?utf-8?B?M1BCa2t1akx3MVdDSHR2MXRBOVpMMC9IVk5zUFhUNVJ3SHp6clZYODFxNzk1?=
 =?utf-8?B?NHMzQkFlUFBUWHB0VFFGUzYvbU94V28xajREMGpoNkpNd2JCczBEWElKbGp4?=
 =?utf-8?B?WFo4UEpwaDJYaXV6a2dnM0lHTGpYMDcxaGRTMXJIb1JNTzQ0TmF3dGxycEFp?=
 =?utf-8?B?S3UvMnY4dFRiVTJId3N4UmhOMW9ONVBxZURWVTJmaDBGeStRUmQvc1V5R2to?=
 =?utf-8?B?dDdqeVovTDBDakg1dFI5ckpVeEU0Y2libkVtV0RISHA0UGVFUGJjU2pldUU1?=
 =?utf-8?B?OVBsdHlDRU5KL3BMNTcvQkk1aDAzeVl0RktIWDkyRFdPRFBzRUlRRWhOaWtl?=
 =?utf-8?B?aksvNEdZSWVXODhIbmVuMkJGRSs5SkFEb0lBUkxxbnhIaWgxMTNvd3Y5clFR?=
 =?utf-8?B?UTQzclZhVk9UVzVSVFhVVnhTQWwvTUtCWWN5dmNZNlRobDY1RUxyeURYNmFq?=
 =?utf-8?B?ZlhuUWRRV0FKZUtZVjl5RXpQNWM4WVQ3NXZzSVZnYXdtWk12d0s4TFo5UjZM?=
 =?utf-8?B?bGN6TEZHblB6a292SlY5Tm5TbktDZ1p3MU9BNG9SM0lsWTNaM3FoYkNobkRW?=
 =?utf-8?B?bFdUeER5MjZaR3FNaUJwbVptUDhZVHhpU1owcHhmMlg0N21CbEN0a1RINkFL?=
 =?utf-8?B?U0N0czVHU0VLbTQ4em9rQXphUXVWVkJSKzVPc1F0T0dyZjJ3cEEvNW5TK0lj?=
 =?utf-8?B?Y2E4VTQxQWwvU2EwR3U5MEtidWsvNmRGOS92YjdOSmNKWG1RaXlpZ2Y3SWtH?=
 =?utf-8?B?Q0hJSjgyUDhpU05rd2pGcVJTcjFlWGlkUks4TU1zZXBFRVdjd244ZE1DVGRL?=
 =?utf-8?B?dXZMWDRyOUMrYlNsaDBCcWlXWjNBelhYNVRlWThpMXRBZXZxVVJjUVdKUXll?=
 =?utf-8?B?KzdXcEw2M2FEbzIrV0RYQ3kxT3Nzem5UWjVTRGNXd1JqNmtNNUh1eTZ2bWx3?=
 =?utf-8?B?ZGFEY1k0WDdPNC9veW5rd3QrYWpsWUNQUGFaaU9aOGdwdVl0S0o2TXF4Risx?=
 =?utf-8?B?ckpHaHludk1janpaUVVVT3IvS2w4T0NRVkhZRG9zbyt1RVNsdzZPV3p1ZnV0?=
 =?utf-8?B?RUp3RFdxNldZWnVUM3MzZFduenhhdGJwa0VXZGhlcXA2WGNZZnJGSWwvZlJ1?=
 =?utf-8?B?NHAvWTFVWFFEa3h3dG96NlNzYkduUk0yT1d6ak1sZlcrTFVRUEtqRjR3VGxS?=
 =?utf-8?B?eDVrSWlaTm9vS1BVMW1tZWhaSGlXL1lJV3lsZC9Pc3lpZzB5Y0dMdnFYWjJW?=
 =?utf-8?B?OXhjRHpIaTd1QWdYRmNPd3g1b2RNeElqQTRWeW1JZDEvL05XMXh5dXZvaDc4?=
 =?utf-8?B?MzVMQ2V6ekJWb2RERlM1eDlTYlVmbi9zWEhuQVJQR1NJMldQYWpHMm5ZUDlr?=
 =?utf-8?B?ckdVR3cvc3Y3NFZKbmxiVW5GbS8wWXdTZWF2T1FnTFNEZGNjZnBzRmFBRTJv?=
 =?utf-8?B?R3A1eW54REF4eGsweUtvMnpYdnQyMUZHaXBEcHdwSE1jMU9YcmpRaGJnbUUx?=
 =?utf-8?B?UG5ZRTBaaG9Vc2pacWtFaDFCRUxvdFlSZThrODhUaENzN1hyOXdMZG9XY0U4?=
 =?utf-8?B?U282bU1ZWExSRjFFR05mcEl6ZGxoY0plQ1ZiTWNQQkdkQkw5cUVnRHE2b2cz?=
 =?utf-8?B?Vld3T3N2bHFJcjRzdHFwQUxBTEs2Y25YdmR6eTNTRXhhTVVQZDV6MWFNbG16?=
 =?utf-8?B?VDljZXJVcExtQ3NnRmpyTno2aWhsZVFCelJVU1JzUVUzcGhJK24zVWVxdFZS?=
 =?utf-8?B?ZEp3cjN2VzlxR2ExMWdxTWhBc0hwMW01WlRuV3NRS1dEbUFNbjVjdE1YRTg1?=
 =?utf-8?B?dkw1U0NvRVJWcnFoZVBZKzZMMUJ0b1Q0TzhObTZLM2FjTmJldkZ5VXRqUzBQ?=
 =?utf-8?B?N2VLS2pNaDMyZ25KZ2ZUQUlOaTcrTjFRa3A1UjVxOGhxNlEvTGhydyt6R1Nn?=
 =?utf-8?Q?9EdOFn0ytOEfdImoGqln8KtRF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d86423-a5a5-4230-9313-08dd93c76c87
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:48.8091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atjFNd0OeqIZCk6sFX6IzrAmCa7trx0Cc18S8GJFDPOaRwUd1OBkjn76Cd1d0DH+ZmL0I3tHk9sS39JBXGv5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10459
X-Proofpoint-GUID: JrcDKCaMwBYGlHATCJnY0rjLPys8LuJ7
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=68260bf3 cx=c_pps
 a=94i1PXq8WVRBNmfdvHlv4w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=vXCtUE0a-urccVGwgxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JrcDKCaMwBYGlHATCJnY0rjLPys8LuJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfXzYgV8fH2yzUm
 fwhk8TmxHGvlmTMUpUgwX7Nvd82tWNV2f2yIxP2TZnwJITT6NliZnqVpcT7HFzmPVSzLuNs2O58
 UQzNBJwhrquDGPqgXoxOwvW3Bd56At4us01NWivLOC/dYii7bXpbI2dTYF6gVmWbuVYnCvVhl1u
 bEpJHOXbNf0pNXP3Odr/jEQBkjnIVVxMntYvonLes8yGjQhuBMfYx9DVNHOvxj/s+fShV7sH0CX
 rtXj/4SHzU7FJUX8GreKWiM7n6dAb0V3pPdmHIUo5gohB7Gc2c+hNdghJj1FqXivCZO32u3oA7w
 sASmRmzxYftTHbQ+HVkP9bB7sgnpKtNTv32QCnW/jlSMyfzYypj9jCTvqfy3QJXXMPoEek9ysWM
 5hq49XuHUQgdcQimNyEofJigisIH/A+kGA9kQ2nGB+32eAC7sLI9o0Ntl5ccRFxlwAWyScDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  56 ++++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   1 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 409 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   6 +
 7 files changed, 495 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 7f91500bb7..1873f92313 100644
--- a/meson.build
+++ b/meson.build
@@ -3642,6 +3642,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..6300c681e7
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,56 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 60fe3e0b6d..0105479d02 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -31,6 +34,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -70,13 +74,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..574b59aa89
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 593104d15e..53fbc218f3 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,16 @@ struct VFIOUserPCIDevice {
     char *sock_name;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -69,6 +79,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index ac481553ba..4a654d7597 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -14,15 +14,32 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -35,10 +52,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -54,6 +401,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -92,6 +486,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -102,6 +497,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -117,6 +524,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..89d6c11c4c
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.43.0


