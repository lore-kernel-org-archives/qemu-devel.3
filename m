Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFN-0000F3-Kn; Thu, 25 Sep 2025 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEF-0006nG-9D; Thu, 25 Sep 2025 07:33:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE6-0008RW-Nf; Thu, 25 Sep 2025 07:33:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P2Obno2033590; Thu, 25 Sep 2025 04:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LWy9PHZFbSjw4wMCWgEaiojND36v4vanBE2rXwi32
 QA=; b=EsKIqc/sgmCwHtUeHpYC/6rv2wp17kjR6iZS4ltKgOnCdjBaXaLP5e8hi
 AZYuq9SHzHBIMYb2bZSxTPfeJXOYqAewQB0ACtxiVZmKqLyzY6FCl8Bvujv0JH+G
 DgwU+034z8ij8J+sg6UPfDvEhFbYssxC3TMbSshnip6GrRFG33aLjfPJeRPxly4I
 lZU+kO5n52SBB+vOO4Qvf5hZ+0AtxzmjGHBCvXnZYX4U9XTo5dTTvP1AxIYug0+I
 anYTMFHhUOTKm8nu2b5LLwfwrC7ZH/rtyQaR3+hfnF/86Yn2TshhRxA3eGrSiwOQ
 zjcI9t4nlyjk4r7KiUEpO1qlK0x2A==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022128.outbound.protection.outlook.com [52.101.53.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cj95tkpd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzqNmKCUN1vYlws4UEBS1thsx4+fWt1RaRphsQyeY6jRZed7is5oqskm/8cq7IlhISI+pdieU1q0gU+8yYSR3iIxAWuVztAZ6aGKrfgiYxS0IRlFulKGxKPtjNcgszLYTPeyWxLa9r5tMFHDxfBhRagt4gcAGzcmf7srXiOdPtyH1g1olO4FiZjPZKbJ1Jv5XKXN5xaszT/QHero7iLiN+sjdrwzg1KyoD3t9iu3p6kYpk4Zm9YRvnong1Bn/fNrcd2xdpTd3CA1AzWsnsEJt1PIb9sedj7TLb+skXdNaa3BeI8MWnA/989g8ymP+LzVp6eLQIQzk6J/YgrcpIT10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWy9PHZFbSjw4wMCWgEaiojND36v4vanBE2rXwi32QA=;
 b=Lc5LmWSN3yVE4O4APPQEsg/yhWD2nWHlpi1gNRV+KAZcSkxB7iaK2a7ZTHtoCjKxw8dzAzG1PQCwO+4un1RfDxuMh9Ja5yqfCnYkUJb95gdHTPN28NWYs76yiNmllQe1WS5XGrQqs4fr9AWak0fJqy/J92H7pbWemYjnHQdpZ+6JJNKfyH41jDH3iHOKb9ASJ+K2IeVGTMbtJt0R/9OsPKZ1GU5i9qYDTp0xWabqhko8CKcTC9eT6fv4TcwG7iI+1T6SCEzKIYMsHwaspiVFWbPAn9OfyliAuaiB6y3DD5x1UVmCiD56DZ/Q9dAISD3f8fWaB7TgAdAV2tzN8hiwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWy9PHZFbSjw4wMCWgEaiojND36v4vanBE2rXwi32QA=;
 b=Rgb8HCb95BMDpyDoHNb+bi7mvNkJ4LFAozi5xIJPKUrBVwuc7iHpjmLPLr+jUAIJscN+8O7fPxjKf2AqQn6wbHbtJnJEIzq6Q9+h7XP7kO3/uYmGPkUlSUMDfGA2XDPwpOJIRBoLp4ivb4yL42b3v2AljeDC9F5a2k4S0GEWtaW4HfsyQMD9WKAhCWSoiZdRtp59rvyysgoXFa6WGcoHJSbL1UQDWEnEugToClb7+nerg+GpRagvaiXn/RAscYeAu3UGDi7a0ogA7CoqvLb9kiy6MH13MHamJ9AyUGTv5eAd3XBYUmD4YBq/0uHFATswPIr7WPxZl2lrMH/mYbx3pQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:17 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 22/28] vfio/pci.c: rename vfio_pci_nohotplug_dev_info to
 vfio_pci_nohotplug_info
Date: Thu, 25 Sep 2025 12:31:30 +0100
Message-ID: <20250925113159.1760317-23-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0695.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: a30b3137-e29b-4e13-0b8c-08ddfc275280
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzVYT3JUWDlib2NYaUNseW1jczBqdFl3UFJ2aUl5QzQzSGh3SnJHclpwUUVJ?=
 =?utf-8?B?QSt6cDFTYks0L1o0Z3FQNzJSUnlzemtqYWMyWGw4NTRFU2sxeGQzL2taR2Rn?=
 =?utf-8?B?eFczS1A3MzMrQk1KTWJZbzNUc3ZmQmxXM2o4aFdBV1ZZZCtTTmx4bVZUUTFm?=
 =?utf-8?B?ZlEzOWZ3R0IvamhDN1FrUERUb0JXMGxZSm4wYkZuMGhUVFBSbVlSTm9teUs2?=
 =?utf-8?B?ekdPQzMzSVZ3RmVzQnR6Qi9sTGFzWXIrdmtGT1VkTmsySkwvdU80b2planpt?=
 =?utf-8?B?dWdoMDc0OGZRN1JGcGQ0aktROWJ6UUZDdXBRMmduU0FvQ2ZYNm0zS2MvYnhO?=
 =?utf-8?B?UUpjOEQ3OW9Od2pyMTQ5M1BVdmRzRk9HaDRySTd6K3BIdSthWmdCYVYwc0kv?=
 =?utf-8?B?OFpTNDZEWWo3QUlheTUzbEVxeWFDZmpvZDJhak1UbGhkUjlDeGhGNjlIczl6?=
 =?utf-8?B?d1lQNCtObHUzZ29rY0RJTDVtQXNCSDQxQXlINXVPZGVwSmExN25rYzRHUWlo?=
 =?utf-8?B?aElYa3I5bGJlYStxdlNRZFZvcFRsVWNSTS9MZXk2UjgyZ1dWdjVucW5hSHc5?=
 =?utf-8?B?VUFoTUNPa1lQNkV4TXlKWE5XY2pwdGI3Z0w5OWZ5S1lKYWdIZzRzRkxsNVpo?=
 =?utf-8?B?VWxSemZ3ejg1Y0hENUx4SVFJL3lPcGtHOWJLRGs1SFJRcFpWTDgxZkFoMFJF?=
 =?utf-8?B?Q2Nsb083eVZlRlFacnhIN0FzSzNaY1F0RGFYSldDNjFnajNjeGJZWDE4L0F3?=
 =?utf-8?B?eHRNOHRudUN1bklSQWJ0V2tZamRUS0pSa0srVkw5ZFFVQVNZck83a1FCc2dH?=
 =?utf-8?B?Y0lyT2JJbVRQbENib0tEWW5xeHc3d2l4S3l1d1AxVU5xb2xpOVpOKzJwU3dn?=
 =?utf-8?B?R3U4cGlMOGNDZ1hSbWNzak02UUVuY1pJMVJScmZwcTBhSzdWSHE0aEhCdHR2?=
 =?utf-8?B?dFVKOXE5NkV0K3ppYkxpaG9jdXo0clJ6ditYU2w4WUFzNCtIa1M2eG8zMERU?=
 =?utf-8?B?TTBsZlN5MFZVdUVRVmcwV3dBNE5yY0NnK0NaVnVoOXBjd29wNnEyMGhnWVg2?=
 =?utf-8?B?L1JPYnVaUzd2ZElPbjdTdTh2YXNuQ2NZN2hSamJmSUs5NmhLY2dlYXBuNGNZ?=
 =?utf-8?B?SGxidzUvSnNuamc4bmNQSmIwWkwvQ1lvMlBvNXdQY0R5bFM1Qlg1Nys4bkRJ?=
 =?utf-8?B?MGh2YXVFL1A5NVkvbkxYSWNMRHByOTAvOEhSNjJIVncrSm51UUkxR1VId2hG?=
 =?utf-8?B?aGMrY3FFcDBOSFYxMWVDRnF4OVdvR2ZZYnBkbVlubWRXdHdZVGNJYlNsM2pX?=
 =?utf-8?B?SHZnQ0N1eDlibjBVVkQwZm9DL1hjcnB2QzVsV0dpTzhYMExMTG9SbjEzQzFl?=
 =?utf-8?B?b2haWEEvSXlobGtoS1Y4R1lsRmt1YjhIeWlmeDNrWjZsNkJSdUpaQm41VnB3?=
 =?utf-8?B?cGZTSStDYlJIaGZObUZxemdiUXhsYXQrSUpGcDVPd3RYUmprY0tmdTJtV1pP?=
 =?utf-8?B?UzVJT1RJbitMVm4wNWVqWllscUtJdW93OG1kWlNsVTYwejRUMm5FRENxMmU0?=
 =?utf-8?B?N2E4TTA1STlUcXBjeVorTWh4Vi85UzFKTW5CQjljMlpmdEdrMUhld1BUZlNi?=
 =?utf-8?B?d01IMFh6RFlrSDlHVGZwS1JWZHJ2UzBsYzZGZGhDT25mS3AzdEozMG5qM0lG?=
 =?utf-8?B?ZGdhMC9aOSttMWpBMW5IQ2hxa01IOUk1N2JlWVRJNHNRd08zWjZjNm1tSU4r?=
 =?utf-8?B?S3MwT0Z4ZU9yNkV6NjRKbFcyVGpYMkpKZFhjU2hxblQ1Y0w0WEpvdmEyWVhQ?=
 =?utf-8?B?Y2I2VFFGbEdaWW5SZ1Mzekt0ZHhKQzk5MUhGT0RxVDg3dzczMHBON2VnM2Fu?=
 =?utf-8?B?d0N5ZExJc1NLWmFpbUozVDVWTTRFa2ZNZ3hVTE4rRDZFaWIya2JYdnpwd2Ey?=
 =?utf-8?B?SDB4bWxCcXIzQkVadC90Y2pySnQ5UXJoRXJYOGZBQ3ZWbCtEVWJSVG1qc2lX?=
 =?utf-8?B?dmZXczVXQThRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxTSlcwNm5QSjcyNEZRcnFDQWxabXYwVndhZXVnWmU2RDlTQjRObnhESlVT?=
 =?utf-8?B?M3VVNkhDMDFybHlWY0V2ZE41by9hTHRQZ3pyWTZ3Ykp1Z3M5MHVldlFPblJH?=
 =?utf-8?B?R3FMZVc3T1JRTmxabW51Rks2OStmbzR4NHpWOExLQmNZNGdaMlhTSktTU3Nr?=
 =?utf-8?B?RzliQTlmY2NrbGZWZjhHc0NwQ2VOaCtNRmJxRGgvdnhZWEdGc2t6VG9lT1Ns?=
 =?utf-8?B?aWRqaTdzYzVrU2h0RWlncU54d0xqSFRObkxCSGE5YVRmaVBicFdHTVUvTUww?=
 =?utf-8?B?QTFMdSt3bE8ydzNSWkd0NENKR2lISTg5dDR4cWQ2WldsV0dGMjNHT0VlVWpY?=
 =?utf-8?B?d09zSDBsekIrMDd4aW5URFBsMUZ0SXlINVFYMTNScGVtUDk1NkVlaFVxc3Zj?=
 =?utf-8?B?SXAwQm8yWGZEUWZxMlZmNXNDczBmZEVJeUlZZUovL2ZVYnJPb09kZnE4RkFx?=
 =?utf-8?B?TUVFSE9CY1AybytQbUtSTjR6Z1ZwMnhxSDBBUUVPSFVaM1lKUkYweTV3a09k?=
 =?utf-8?B?TVZIVnQ4R3B5cHRCNEltdkNPRHNiRy9XeGdOaVltSHdORXMzUTV4QjF5L0Ja?=
 =?utf-8?B?NWxiaFJzUUdpZS9JRmlvNnFzQTg4d050Nm1PMnpGa2dJTGNxUFBlOXUxL3ky?=
 =?utf-8?B?dklmeW95eWJjTFRwaVFES2kwUm5uUHEydzZMdzE0TGNzYzZ3NjcvdnlTU1oz?=
 =?utf-8?B?VTRKcEcrOVZyaXhsUlhBdFc5dlN3NGNRaC9uRithZTlIckJJZ1I0K0c0bUtR?=
 =?utf-8?B?aEdkUXdCcDhRZ2JOZDY0ZG1ORVVPSzNwSFBwNGJycUQ5WHJmaHY5RG0xTElj?=
 =?utf-8?B?WmJkZlF0WnRmekJjTzNpTW56REVxSXRVQ2o5TExEbUJXbWFuMWVDZmZaY1lG?=
 =?utf-8?B?bkdIb3l5bnoyL2FUd3N4Y3RERFUvbStsb1hDVjZWazliSVAvMjdXOFVIMk5H?=
 =?utf-8?B?YnNyV25ycWh0K1RVcXlNYzc2bmlCaVBTd3NFUHVuMTdsT3d4OE9DUldzWUd4?=
 =?utf-8?B?YzNYai94citkdVd6SmRvM2RCNUhLcUxTbGMySVpkOWMzNUJHQkZNckt5K2N4?=
 =?utf-8?B?WnNzMjNOY1c4QStXejFRWENKNzhjWWZJcFZiZUdPQTV2d01jNTgyMXEvVklJ?=
 =?utf-8?B?L2s1NVZ1cUJxaSsyNUwvVnFWZE45T21vQkFuZHcwRkJ2SjZndi85NlBITkhj?=
 =?utf-8?B?VHdUNHhHa3hiNy9UTE4wQ3k2TytqMythY2dUMEVEejM2c3NFNTFGV3l6SUs4?=
 =?utf-8?B?U2U1Y1pINU95M3U1Y24vZHJRSWh4MDVsU2ltU1lrbGxaLzZaWmFXMnBtaXB2?=
 =?utf-8?B?SlRVZ0lnSnNxdnlLcUpOOUFCeGZuRzFQZkdKQ3RGem5ZdE8xMFU1YVpsb2gv?=
 =?utf-8?B?K3RsN0dsV0VGRjRDeklmQ2pIVjVPaUcrUFJERlB5d0Fpbkk0OWpTbWRLMHZr?=
 =?utf-8?B?dVkwMHBka0FYc3FrYnZMM1JWeUE5a3UydGtVc3VkaTZyT1ZXNWpYdjNaUlVK?=
 =?utf-8?B?K3FiaVhOdHZYS0RkSEpyQlhSQys4TW1ZaURaZS9pMjdMTXNReFM5ZXhnMTkz?=
 =?utf-8?B?N1VycDg2WmZUSFRMN3p4MWxGckhzb1laZmtEYmxRdllaTkpBdE5SU3VBRW5s?=
 =?utf-8?B?cjFiRzhUT2paSG9VSVA5L3VPQW5HckF1d2VFaU94NXlLZnk2TW8xNkc1QSth?=
 =?utf-8?B?aGhtbXdrdUwvYnUxaEdTZmxUUXJWOW16UmdCZnByU0xRd2VYTjlZWVY4UEp5?=
 =?utf-8?B?TDUrSWlPd21LQ3VXMGpZVlB1WU1tSVd4MC8xR0FmS2F3RTVvSFVBeVMxTlBt?=
 =?utf-8?B?bUVzN3c0dkpOM3pXekhHNERyc0RvTDg2Vnpmd2pjZWozY2QzZzl3QjFxNk00?=
 =?utf-8?B?UWhSbE9YcGFzampWMyt1Z0FFNVEwb29XL09WNjJ2WGlsNE9hTmJ0WVY1U0JQ?=
 =?utf-8?B?aVJqbmhFTlkrTU9TUW80Z1RhZTJpQzhtU2RCcUVjdXcvajloSS9ob3Z0a0ZQ?=
 =?utf-8?B?R2w1NmtwN0ZzZEhlTFMxZEEzcUZjZ3F0Y1orek55QmMrK3ppWGQwY3p0Qk9M?=
 =?utf-8?B?UkdSWC9yTStaOUFVckNPQmk2K3hLOTBhQlZxbVI5VGhmR2V0RHEvQU9pUjJK?=
 =?utf-8?B?MVdBeWV5VkNYajhwdzdpOUh2M1hwSjNVTXhKbWUyS3QyM1B1TFhJU25zRW9C?=
 =?utf-8?B?UWE5TTJvblRYUWQ3aUFhU0hBQkNkMlRWQUpiUm1VZGVpQm1rT1Z0ZDhZSWpa?=
 =?utf-8?B?THdzNHR5a1NnV1gzbCtLYyt3RVZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30b3137-e29b-4e13-0b8c-08ddfc275280
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:17.5621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4dW5as99eAqoiQVcBuWO0mJ5H69rdZhaiBYu2IjC2G5XM4vGILnfvv6Ew+L+IUBNU/NIr6x70n+5mAqbiE2jNAhwjZ4m+HwBusQ7ZtfubA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Authority-Analysis: v=2.4 cv=fPk53Yae c=1 sm=1 tr=0 ts=68d52881 cx=c_pps
 a=wiAqGZatgNl135eAsGeZeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qez0XmMeheHOlNJAWGmck5uOs5E3eJYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX879s6LIu8Bp0
 DhpC4hDHjH7vCPV5+dVZ9kiP7/D53gmkZtHX3lrKzFxh/8H7x0mW7RDLh5voZaG08AFqZtpO61t
 q/zDIMwcHsYuQMCaXh36jQQFxSKoLqhKffRm6jXk4IEcCqVzVyfQdih+lv949Z1JNxrujh2rL5J
 J0m5V9P0sMumwl9dMouWdQGxtP0gM9doLYIxizStRwWPMVhISEE6pI5dkyfCEokgedN4Mte1m/l
 a5eSHaN/z9nXACKZqb0S7a8g88B763Ex8a54iCqZNK/1kgWvFSx7TrBR0ngT+hq/WV0lgEwYzq4
 IRW/qa9OEHy5vCeB3u90G1kHC3GomRdiDYo9D266w+yY92pawO+Z1TRlqoFTmg=
X-Proofpoint-ORIG-GUID: Qez0XmMeheHOlNJAWGmck5uOs5E3eJYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 10313edc7e..5b022da19e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3949,7 +3949,7 @@ static void vfio_pci_nohotplug_class_init(ObjectClass *klass,
                                           "Controls loading of a legacy VGA BIOS ROM");
 }
 
-static const TypeInfo vfio_pci_nohotplug_dev_info = {
+static const TypeInfo vfio_pci_nohotplug_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
@@ -3971,7 +3971,7 @@ static void register_vfio_pci_dev_type(void)
 
     type_register_static(&vfio_pci_device_info);
     type_register_static(&vfio_pci_info);
-    type_register_static(&vfio_pci_nohotplug_dev_info);
+    type_register_static(&vfio_pci_nohotplug_info);
 }
 
 type_init(register_vfio_pci_dev_type)
-- 
2.43.0


