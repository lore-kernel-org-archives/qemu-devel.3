Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47798EEA860
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpkq-0004v4-1l; Fri, 13 Feb 2026 04:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpkn-0004q8-Qe
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:46:25 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpkk-0006ib-OF
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:46:25 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CNjUUF2354264; Fri, 13 Feb 2026 01:46:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=grUDt4RjSHA7JIRl/X9DcIzvLLeVA2hD0nSCa194i
 kc=; b=y7U6Ni1JCm+5xjH4v1lyB/tdgMoMmjt555uqtnl6e0F6J5xbu4ohMqZME
 qBkuZ4MGPw4cBiQyQ3MRYCAlSamIdGaT77PnKwuhpQQ5/YDNoJZTriAXs2bEZTrA
 yivojv2qN0AN6NJ43Ej6AdTwoWjrNc16UohTo3lMO4CttfSMKXgGmwn0/QfQvuGN
 U3sVIdEGBmkXj2OA8ucHlbfMfRgb/RwZNt85N+Tr9JhpIb+v3Wbq42o1Ah4IaesF
 x4ws9KI/T/EJr6wQ+gwmn8v+6Y/K+Lai9dErfVMh2W1mkqHQMGIJ7veRELBkrk5J
 ddikM9c214+cfBZni9s03H7TsoJkw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020118.outbound.protection.outlook.com [52.101.46.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9fukap5e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 01:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bumj4hy9yXmNbm3oFVKyuStAWj9Qf2FVHWFQxewnsDlbodc32bLdopqKe5GwUMbzBtKlFFHeVC3uG0KIz9wjeue2I2u+Cgnj3KDUxkgxO4p41RXn68toicSRt/vbaNIx4juQ36Af06eB5ClbRfVP11tKjfUf6Pn2UpK79pj7A1h8fdbzZT169hqas3C8WiVg4Zs+3Qz9wVT+tiNtMMfmcRFGLJyBJi+0uWx2ihGrluB0AWYJLVPMiB6up/Cn+HnFc0dHQfLF3R/oJGiJaeTkeQq4tn0Z+SgdBvGFBRbjZZQAF7yDjtM4zKO45bimyrlfUtrTrf5I2/UaqnfGwJeXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grUDt4RjSHA7JIRl/X9DcIzvLLeVA2hD0nSCa194ikc=;
 b=RZ9hdj0dZucnkuspMK7Dv0QgYKDyv6nMm/pidqSj9XF7nnmF0QLD2tKKjDEoDB3ZW3WcRsikhx8gNAC67CCFqmS5OAaH9fAJz41KwadHxbkGWVaLjPtY91sgcATMZr5tZY/2Xc6wE/guGLeif6xJc2xj3eWAX0EjHkq9trSZ7JDfc/JV/9kzFmKIZ2UAYVKsA/Usl7K2+AYxtPwjeVphqcG62phGYECzOh6rP7Gyl8iImn3RBGKf6fcldV9GoN0fyZPVNUFNQYLV2MwdqoiIGv1dH0WU51zuDmGzAKFimiSQVE/kCKDh3NbmP1azF/wJb1ZrawQuKdEIfyt/xgBZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grUDt4RjSHA7JIRl/X9DcIzvLLeVA2hD0nSCa194ikc=;
 b=eZBMcZSjjN4Rr04yTFJWKS3Auk06LgD6Ttn1SePGktihYb8FCsWNTee1ZCBqaX2Oo8e/wa8CbKIsBfXDN5gRBG0+eqz01ShXhSzZpdpZzhU7AABMLX7P6qc1c9sxfbvJjxVuQZsK+V20anMnQYmnaAsSAjINoqz3ujSbIvkV/+DN48tYy1ptPVDb4iGc97xADG9UYhwlZspQHue9oDyyzfklEAd7Iakibh87XzVwv+9niK8uc/2+R475p8aFLKYID+tut8g+JesKx6jZjCbZKiw6thqHUgYBcypFlgn4wsnx5xubYWAUjDbzowfWApSbFe79eYcvwpzJJPy15ZlBTA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8852.namprd02.prod.outlook.com (2603:10b6:806:1f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:46:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:46:15 +0000
Message-ID: <ab566c6d-686b-49c5-ac95-9db670578496@nutanix.com>
Date: Fri, 13 Feb 2026 09:46:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/43] audio/dbus: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-2-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0012.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d2b09-bc87-4765-b40e-08de6ae4bb0b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkdxNHNINGEzVkZQeG95OGdjS2FxV2JnOW1QTWVMT3Y2Q0s2RFhJMnlwZDZ4?=
 =?utf-8?B?M1dITm12VGVqNHh0UzdzaHZXMTVvREo3T1hFbjQ3UHRZRmkzeVdYZG5wMS9C?=
 =?utf-8?B?MFZqMnE1SXBwdU02Q3A3QkZGSTFRUWZJSlhueGQvQTdxUkVEQ0tZa3QycUNj?=
 =?utf-8?B?YXdKU1VVVG00OHVLZU5waysrdzVDekJaTmp1RVBhbytPTXVVTXIyWTU0WDZJ?=
 =?utf-8?B?VWtqOFg4dEx4NkxNOEZ3a3BHNXNPZkl5QzJtVWNabUdrZnRtNjVxSExiOEI3?=
 =?utf-8?B?bmpNUXc3OEtLaHhxbG1jdE93eDNicGRucXpOWEgxQ29nbmlCdEQzZmJvMjc2?=
 =?utf-8?B?QTRaeXQ4U3lDN0RTTEliYnBGSzdYNGlXWnUyWVh3eXFvRUNrRzFRNFFlbytT?=
 =?utf-8?B?TW5YbnREMWVsM1g1eWVYTFhSSXFma3dNbTc2NExjNjFlaDdWN1Yrc0NXNzBF?=
 =?utf-8?B?K2lCUXZvdU04aURCRGxnM0MzS2pORkxjOFF6YkJKVkFJZTNrcE1XQlFsdUtw?=
 =?utf-8?B?NXM1UWJGTTFnRWNhb2E5eWdoUUpLVXBMUFEwVjVGVXF3elRFRkpXQ1hndVRh?=
 =?utf-8?B?WjZrcytKV3FNQXpqdHIrVmU1OHg0OWhMcEdxOWNsMlF0NXhOSEUvcnpuZHlE?=
 =?utf-8?B?ZE5zT0hMTFZaRmpMVXB6eGY5RGt3TWlwWklPeEJEN0dOZWVtbHhGZTVoVDdX?=
 =?utf-8?B?aWhveG9QNjZiWm1OY1BPWWE1NUIwaGVVTC9MR1MrbGJuZFRycTl1Qlg1NVho?=
 =?utf-8?B?Z3o0YTkzeTFPb0JYZ2dPalVMa2dXQkE0MzFTSXZaVnVPTmk1UE9ydlJIZFZO?=
 =?utf-8?B?SURRQ2JCU0g3NVozSXRrSnRXNllIeFZGK1BrSndQbWowQmxqanBhbnZuQ1h5?=
 =?utf-8?B?ZmNGbm1UT3U2dTR6OThUNTEvMHRCTUw0ZldCbmJMc2xPTnRIWXd5TGt2QlEw?=
 =?utf-8?B?Vy9Td1pkU200c0JJanBLb0t3V0R4MUt5ZjRLWmYxVzMxTUF2T0xLeWd2U1E5?=
 =?utf-8?B?WlRPZDl5TS8rSmpWSFBKamhXcXRmdTlNcTErMCtxdVJ2YnJrMEx2bExOamhS?=
 =?utf-8?B?QzJaWHlwU2VFcHBiWlBsamc5TVBlbDFCbkxZV2k4ek9aY3RoK1Jlb0l4ZUc5?=
 =?utf-8?B?aVVYYmxORmJnelNCdmtlVUpMWUVTVy9FOUZOaWlINm1OTEFjamtEK3lZa0g4?=
 =?utf-8?B?RlpScWQ2VEoxNlloQ3NWR1cwTk1YTTlKMUtLYXg2S21PZG5MVmZwNGFmdkw3?=
 =?utf-8?B?ZEd5eEcwRzltRnpiYmhxZHZIdElHVnBDSEpLQitaM3Rray8zcG52bGhqcmVE?=
 =?utf-8?B?bGFLTjVNa2xpR1hWRGZQdE1Yb2lUT1RBempPbUh5ZmtVSTkySXpyd2JuTnBK?=
 =?utf-8?B?UEpidmFrSkRsWEU0MHpxUHdLeU00N1k4RmpxeU1SZDA1Sk9hZFdTbVBOTWVS?=
 =?utf-8?B?NjlqbkE2cE8wOG9KazdDVzhQODFrQmxKOEtMTlA3YXBKbjBHMlRVWDhhaVhQ?=
 =?utf-8?B?U2xzdytQcG0zVzJtRlluREt5d1VzN1VFTDNQVDlTeTFRTGl0eCtCMU0wWDEw?=
 =?utf-8?B?RXdkSVBQZHlaK3pESnRiRVFLQmVnMTZuZ05xTWhTV0I1NWdFdFk2VnlmQi9Q?=
 =?utf-8?B?bzZJQU5oZmQ3TDJWeDR0SG1SZG9NbVlKUUJ4RGZwUkRRcWJJSDRJbzRKK0E0?=
 =?utf-8?B?bTVibmw4OGM2cmRqSmpDYmFZY2tXWm9vODBrbWdwejgwRk41Rm5scytpQS9W?=
 =?utf-8?B?SGFRMnVDUHFGNVRoSUJjejZkS1NRYUYzMCtiS2piaFhzZHlWODJnSjZNeTNa?=
 =?utf-8?B?WTIwdk9zaEJPYWQ5MThVanZJTUxpVThhSkNBOTdjRTd1V1hyQkxZcWVZMVBH?=
 =?utf-8?B?T2YwYWZFQkw5bklmMTljamhlK1pJR2QyaTRMWC9ZY2RSa0dxVW42OGhCZWd3?=
 =?utf-8?B?VkU1SDdrTmkrVDF2dFJ6MDFLTUFkclAwaU9sMnorSGJ1Mzdmc3NXY0JjR0ZB?=
 =?utf-8?B?SExVdWs3ZUdPQUNpU01BcnZpL0R1K2t5WGNhUUp2UXFndEhqODlHN1dzUWpl?=
 =?utf-8?B?elN1L2NHbDBDY3RBSkdHcGRrVi9sQ2hMcE0rd0NpVTBxNXUrd2JzV1hxQ0pM?=
 =?utf-8?Q?VNGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNUOFd5cEs0eVNTa1R1eC9KVWF2T2d5REx3TlN2SXZwUnAzZU5Ea1hBSWM4?=
 =?utf-8?B?YVRkbVlBM2lXWmF1MWVwLzZYMmxFdk8yWFk0R05vL1NJVlRsSzZhZzdPWmEr?=
 =?utf-8?B?cFFoRkVuVXNwbEUxT1p1M0V1TUxadTZQeE5pcWoyM1p4dXZqcy9sTGlXNHhy?=
 =?utf-8?B?RTFPYUplbmlmWFZOL3IvZitibTBiVVFkMCtLZ0pMdjZ0WUxRa0I1dFdSbSti?=
 =?utf-8?B?TzZlWGFINGcvOHZGb1NwVlQyVDNLNjZHUllQRGtUZmhzRnkwY0xyWXNPazNN?=
 =?utf-8?B?RkJZWVVJUG1GR2MyZmpDSnIzOCtpclk5aEl6SjlHb3U2Mmt0L1pPRmg3aytt?=
 =?utf-8?B?bDhrUlpLb1dwRUtZMmphb2l4RlIwUDRjMWZJRFNiNHd6Ny9TVC9DQmJ1STNW?=
 =?utf-8?B?WEoxS0V2d1pFdVBEc2VxZnFwY1pGbTlQQ0h2ajhhTW56U0dJL3BNSHJjaHRu?=
 =?utf-8?B?TWpZMnBIbzhpUEt5Skd0SmZZd3F5REdMT0wrbEdZdGQwRHI4a2g3a0hSRXhn?=
 =?utf-8?B?emR5OFRtS1JWeFM2MG9uajZlNXkwU3FXVFJOc3lMVjJhbHF6S0FwZ2hNK2ZJ?=
 =?utf-8?B?Q0xpaU9qenpKTlFxRVZzYm5nN0lwVXZtc0l1Uys5SnpCbHlyZlZpcTdHeUVH?=
 =?utf-8?B?Nks1VWtsRzhMZGJxTEU2YzArVDcvUTdSalhPMUZydFlqOFFaOG00YnQ1UW5W?=
 =?utf-8?B?SzJDd3BPSDRoeU9Gbjh1OWU4Z1VzUmZIQVE1eVN6akp3eWp5R2NQZ0RJcVdD?=
 =?utf-8?B?MnAvaGVuQW5kZkRlb1UxbWY5Yi90eFBvK080b2JRUXBNUG9DMkhwY0Z5ZlN4?=
 =?utf-8?B?REMrYjBXWW9BVzBmT0FmYklLMTd4cUtZYTNoajdZWnFwT25jNHNEbWptMCtl?=
 =?utf-8?B?NWNNdk5ZZHBqOStxRE9DcnhpMkZCMk1jdG82MU1oOXBWZFVtdE5HNndwcjBK?=
 =?utf-8?B?R0ltai9YK1lOM2lVN1k0bnhJcElMS2pSMXBtK2EraUE2MVRYNzVhejB6aGlW?=
 =?utf-8?B?ZTZNL1dCaFlrMy9ZdXo3anVBYjU1bGxQQk94Y0VkbCtEOWNLTW9kM1J3Z3Rq?=
 =?utf-8?B?dVcxQXh5S0F0S1hkNWF3a1o1bGZHcTlXc3Q3RWJsQ2Y0aDBPNjFXbVJrc0Rv?=
 =?utf-8?B?dXJUTE9Qby93bnJ5QTBVbHk3ZytqQlBNRVFqODFaM1lDZ2ZxSTZFY25IbVZP?=
 =?utf-8?B?L21OT0dWb1JMSi9CMjAvQ1JaYzVlK1VFOUE5VGs4Y0FBNEZ5MStLaW5vcVNs?=
 =?utf-8?B?ZVA2RmJ2R0FSdGZFK3BVcmZnMFJDSzI5NmdEL0pyZ01UaE1VYlBKaUNBM3Vo?=
 =?utf-8?B?V0h5NXVidXlwdFgwYitZandyMjViZU9JUkpoSWhMSzNjZ1BjYVZ6UzI5K240?=
 =?utf-8?B?b0xQUTJXZFFtYzJKNnFKWUpCaWVqdkdXV1dMdCtQc1VGSStTcXNjQ21LWjk4?=
 =?utf-8?B?S1pKSWIxbDB5Q2M3UjZGeU9EQnRVT093UWRhWnhhRWROZG5XRmNRcTV4Z1dT?=
 =?utf-8?B?ZjZrUVd5SHZWZTJtdzhxaUsrSGZCd3h4QXhDMzNHcGxaZGhPL0tWYkI2NnAv?=
 =?utf-8?B?bVk0dmsySFd1RHNLcXlGUEtNQlAvYlBsc1ZEa2xnakFyeE9rd3BTSVI4S28w?=
 =?utf-8?B?NnovUVdVTEUwaVdySmwzT1ZGL3VVenZqeHh2cXdVbm1Cdm50bDE1ZmVHRE0r?=
 =?utf-8?B?dGIzQ2JlQmFjSExtSWRLUHZWQ3JFTG82YU1GQ3J0NUhDbEhqVGxkUjAxVUsv?=
 =?utf-8?B?akE5M0NNbEdSdHBhY3FmZExvQlpNa2xML3ovK1N2RnVzMzRSSWRqN0V1WHYy?=
 =?utf-8?B?bVNhZ3lKbWQ4WWR1ZHI3UGFJaTlSNnptcWJZdzIzV3ZnY2dMSWtybkYzazkx?=
 =?utf-8?B?N2ZlYmR0Q0tJdDVmcll6WVpWRTN6N0s3YXpOK0o5QlhNYkFkWkxONm1ENFNa?=
 =?utf-8?B?Zy95ejluc255eDNTRURFSFNkdmZ6SnV0NVdGdnpEMm8vWmJQY1BUUUhqc0JD?=
 =?utf-8?B?RkhTc0dnb0VzODgzR3VMb1FZbzBjc3NDRjZ6MTVPaGxEWjRjUlJrampjT3BW?=
 =?utf-8?B?c2JHcEZpTlFjMFZidzRTTnhFOG1kU1lMZ0p5byszRmdzOWFvZjZ3NWJCUHZH?=
 =?utf-8?B?M1pwRVZqZkNUYWMrc1pYQWRMU0FGQVRjZ1BuME9lVkRMcDNabFdJZ0ZUek9M?=
 =?utf-8?B?K0QyRmhZZE5UajFUM3k2eGI2U0M4VFNwOEJuTW1wT3lpb2VPOXEycW9BNCt2?=
 =?utf-8?B?d0Y3K0hIQmJ2WklVQ0pZOWFpclI4Z2tpNzlCMy9sRUtBcVVubnhwdit5Ujhp?=
 =?utf-8?B?VTBhTGJ0bVFZZjFQZHpWV0ppSkU3akZlcFJCajJqTXoySWY1MjJFMmpFb0xo?=
 =?utf-8?Q?WWhjduxvZ7hgRn28=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d2b09-bc87-4765-b40e-08de6ae4bb0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:46:15.8056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfV/JJQ2ypRHJsnRDDuQgY36hRMxwJGwmP/EtIZCB0lHwczYtmNhEV6AeRGfVoY5Hmri6lTwANb+8fDJaqwxzfbeZiU5g8To3fjClk2QGvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8852
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NCBTYWx0ZWRfX6Zqfi4AR894P
 59kgovbETK9RNeRrA0jwQQQq9bxuY9RHy5HH5pw4CVCSzkzr+7SPxl0UhFa1AScezB59eESo1Pq
 WH/QCFMG38cLR6gkgYoXV8qDKtnNxadB1hwhTYLNbaAUcuxKOGeDp26hVupAnJhyb9iConFVnCe
 sPcGyQFRqyZaLtdB+7iraHXWORjDFpfoqN4FUzk8sv2VIIP4Tv/gfS8knNZfCq/45viU4iS+llI
 imCzBbYT62OftH99zSB9qo8XamGGt6/GiPQSn8t+jtBU4KJO0ecmbXWCJ9L+VBEj5woSMEV93r7
 lnZz5cCX3kDrHB+MXzGUCPd1t8Z3Br4VcfBXK7VblcwBcVC3lb/qLqEL8JrDZlX9kOfi1EXfI1U
 xQ9fW+H9+dnv07LBmKH8/1TwAvECR31YnXyapMvR36dWIbLjO7xahqjnuHTAyEHFF5Jzi3BMgZp
 JljU6dKBe8ELS9KIezw==
X-Proofpoint-GUID: NOD5gxCTo2ZrBewSY29Ers1g5qACsOfQ
X-Authority-Analysis: v=2.4 cv=NoHcssdJ c=1 sm=1 tr=0 ts=698ef2e9 cx=c_pps
 a=Pshx6wbRF4nJNM9KARsp/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=XORy1pq1pS_TbCCOve0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NOD5gxCTo2ZrBewSY29Ers1g5qACsOfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the D-Bus audio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
> 
> The DBusAudio struct fields are now embedded directly in the AudioDbus
> QOM object instead of being allocated separately as drv_opaque. This
> allows accessing the backend state through proper QOM type casting
> with AUDIO_DBUS() rather than casting drv_opaque pointers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/dbusaudio.c | 76 ++++++++++++++++++++++++-----------------------
>   1 file changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 2e76d650df1..b31bfd88d81 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -48,21 +48,20 @@
>   #define TYPE_AUDIO_DBUS "audio-dbus"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
>   
> +static AudioBackendClass *audio_dbus_parent_class;
> +

I was wondering why this was needed, however it looks likes this is just 
a temporary measure until "audio: remove audio_driver".

>   struct AudioDbus {
>       AudioMixengBackend parent;
> -};
> -
> -static struct audio_driver dbus_audio_driver;
>   
> -typedef struct DBusAudio {
> -    Audiodev *dev;
>       GDBusObjectManagerServer *server;
>       bool p2p;
>       GDBusObjectSkeleton *audio;
>       QemuDBusDisplay1Audio *iface;
>       GHashTable *out_listeners;
>       GHashTable *in_listeners;
> -} DBusAudio;
> +};
> +
> +static struct audio_driver dbus_audio_driver;
>   
>   typedef struct DBusVoiceOut {
>       HWVoiceOut hw;
> @@ -105,7 +104,7 @@ static void *dbus_get_buffer_out(HWVoiceOut *hw, size_t *size)
>   
>   static size_t dbus_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -162,9 +161,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
>   }
>   
>   static guint
> -dbus_audio_get_nsamples(DBusAudio *da)
> +dbus_audio_get_nsamples(AudioDbus *da)
>   {
> -    AudiodevDBusOptions *opts = &da->dev->u.dbus;
> +    AudiodevDBusOptions *opts = &AUDIO_MIXENG_BACKEND(da)->dev->u.dbus;
>   
>       if (opts->has_nsamples && opts->nsamples) {
>           return opts->nsamples;
> @@ -176,7 +175,7 @@ dbus_audio_get_nsamples(DBusAudio *da)
>   static int
>   dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -195,7 +194,7 @@ dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>   static void
>   dbus_fini_out(HWVoiceOut *hw)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -214,7 +213,7 @@ dbus_fini_out(HWVoiceOut *hw)
>   static void
>   dbus_enable_out(HWVoiceOut *hw, bool enable)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -256,7 +255,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
>   static void
>   dbus_volume_out(HWVoiceOut *hw, Volume *vol)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -290,7 +289,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>   static int
>   dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -309,7 +308,7 @@ dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   static void
>   dbus_fini_in(HWVoiceIn *hw)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioInListener *listener = NULL;
>   
> @@ -346,7 +345,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
>   static void
>   dbus_volume_in(HWVoiceIn *hw, Volume *vol)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -363,7 +362,7 @@ dbus_volume_in(HWVoiceIn *hw, Volume *vol)
>   static size_t
>   dbus_read(HWVoiceIn *hw, void *buf, size_t size)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       /* DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw); */
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -398,7 +397,7 @@ dbus_read(HWVoiceIn *hw, void *buf, size_t size)
>   static void
>   dbus_enable_in(HWVoiceIn *hw, bool enable)
>   {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>       GHashTableIter iter;
>       QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -416,28 +415,31 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
>       }
>   }
>   
> -static void *
> -dbus_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_dbus_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
> -    DBusAudio *da;
> +    AudioDbus *da = AUDIO_DBUS(abe);
>   
>       if (!qemu_using_dbus_display(errp)) {
> -        return NULL;
> +        qapi_free_Audiodev(dev);
> +        return false;
> +    }
> +
> +    if (!audio_dbus_parent_class->realize(abe, dev, errp)) {
> +        return false;
>       }
>   
> -    da = g_new0(DBusAudio, 1);
> -    da->dev = dev;
>       da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
> -                                                g_free, g_object_unref);
> +                                              g_free, g_object_unref);
>       da->in_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
> -                                               g_free, g_object_unref);
> -    return da;
> +                                             g_free, g_object_unref);
> +    return true;
>   }
>   
>   static void
> -dbus_audio_fini(void *opaque)
> +audio_dbus_finalize(Object *obj)
>   {
> -    DBusAudio *da = opaque;
> +    AudioDbus *da = AUDIO_DBUS(obj);
>   
>       if (da->server) {
>           g_dbus_object_manager_server_unexport(da->server,
> @@ -448,14 +450,13 @@ dbus_audio_fini(void *opaque)
>       g_clear_pointer(&da->in_listeners, g_hash_table_unref);
>       g_clear_pointer(&da->out_listeners, g_hash_table_unref);
>       g_clear_object(&da->server);
> -    g_free(da);
>   }

This feels a bit odd in that there is no corresponding _init() function 
for things that don't depend upon AudioDev: a bit confusing to look at, 
but not necessarily wrong.

>   static void
>   listener_out_vanished_cb(GDBusConnection *connection,
>                            gboolean remote_peer_vanished,
>                            GError *error,
> -                         DBusAudio *da)
> +                         AudioDbus *da)
>   {
>       char *name = g_object_get_data(G_OBJECT(connection), "name");
>   
> @@ -466,7 +467,7 @@ static void
>   listener_in_vanished_cb(GDBusConnection *connection,
>                           gboolean remote_peer_vanished,
>                           GError *error,
> -                        DBusAudio *da)
> +                        AudioDbus *da)
>   {
>       char *name = g_object_get_data(G_OBJECT(connection), "name");
>   
> @@ -482,7 +483,7 @@ dbus_audio_register_listener(AudioMixengBackend *s,
>                                GVariant *arg_listener,
>                                bool out)
>   {
> -    DBusAudio *da = s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(s);
>       const char *sender =
>           da->p2p ? "p2p" : g_dbus_method_invocation_get_sender(invocation);
>       g_autoptr(GDBusConnection) listener_conn = NULL;
> @@ -667,9 +668,8 @@ dbus_audio_set_server(AudioBackend *s,
>                         bool p2p,
>                         Error **errp)
>   {
> -    DBusAudio *da = AUDIO_MIXENG_BACKEND(s)->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(s);
>   
> -    g_assert(da);
>       g_assert(!da->server);
>   
>       da->server = g_object_ref(server);
> @@ -711,8 +711,6 @@ static struct audio_pcm_ops dbus_pcm_ops = {
>   
>   static struct audio_driver dbus_audio_driver = {
>       .name            = "dbus",
> -    .init            = dbus_audio_init,
> -    .fini            = dbus_audio_fini,
>       .pcm_ops         = &dbus_pcm_ops,
>       .max_voices_out  = INT_MAX,
>       .max_voices_in   = INT_MAX,
> @@ -725,6 +723,9 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>       AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>   
> +    audio_dbus_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_dbus_realize;
>       b->set_dbus_server = dbus_audio_set_server;
>       k->driver = &dbus_audio_driver;
>   }
> @@ -733,6 +734,7 @@ static const TypeInfo audio_dbus_info = {
>       .name = TYPE_AUDIO_DBUS,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,
>       .instance_size = sizeof(AudioDbus),
> +    .instance_finalize = audio_dbus_finalize,
>       .class_init = audio_dbus_class_init,
>   };

Regardless:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


