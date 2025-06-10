Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A0C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOwVr-00066V-CJ; Tue, 10 Jun 2025 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOwVp-00066E-1G
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:47:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOwVj-000184-Dh
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:47:22 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A7Tc1H005494;
 Tue, 10 Jun 2025 03:47:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iA5SI8/mE92xdTJtovs6dRhprwI0o9+g1x0RretrL
 Y0=; b=qKoZtmrV96ndxsGsN8MK15J7V8yhhg713R7oJKmy37aphylmEmJuSSitH
 hc/4ok3R3Rej2+s+AZIKyaM5OkxC6Sd/kJIejhHEiXo4jjbEFUJE0ZFjKYrtx+5R
 7+8tGjz4DVzOaTpWTTGuqCzjIqv6zwDut1rMbf74V/wECLwO+7IHme6NzNkqPKDG
 o/d/h9ijezvmFX5blfYZBnBnndTcYpzJqUTgJugTpsERGdNAkObugBym+XMn/wOw
 JFLQlixPc2u9StS/Y6LrUl6pxyrc/cQxPwHUpjNfXXQVYkyUCRtJxSP198Aip9xy
 2uGePeCi+zmLqtykWzeUBhnw+vgKA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2109.outbound.protection.outlook.com [40.107.223.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474sdgdnew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 03:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnBXVMWHjv2iXhI4wNFyuWS8bRAVC+1UfGvyhJAqecyzsFbFdjgS/i3/S6YMM7z2WfiLCYeynOzFIRajmgQWBrJYwBOlJ/wWVaKzbI3Uk3fTuxIb+kSAg4GaHtSwapBPqRIIeH27gBCRhrdt8oCcRdZ2f++u+PcPWfS+6hxhPDNr/hJQkIt7AYgE1SPzJMjPd+jBrCCKteiXKGOMWGliGnGTX9/csngYEHsK6x41XjzPI8SWVedxIIRCz8mEQymIFsmdA7D1xsqm6OC7K+D5NGbKbY2a1D+uyj1l6+DFTwmg3koaoGat4UHX49eP5+Opv1WMFf5GaLUPNWd/KJ6SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA5SI8/mE92xdTJtovs6dRhprwI0o9+g1x0RretrLY0=;
 b=K19jaLGg9nKVAWjgtJfhgeNWsUjwPrKKriorFfp6MTl6qbblDnm9iOj+S12awr8X3uXo8yiemrSvgiRhkgTv0O59lzOmUOmxq0aW6hqoFbWlEgM/PI3cmTAvSWHxPFon1d4spWiJffp9HxVYkJOgbs2BK7VceZgxErHqG6CleFnZO+NZvAq8alF4sozjj6ascuRX1KYPQQSHA3zzBTAFSofU2K1rURTnSNs8Dn6d0xf8Hga4W7z3PwFKlNhf9nFUhly6tftIN7yCfiqlR1uJdzL1wP0wSkpto5tw95CZQSuG4LxmX9eHcM/Njy7ufBduMFgT7kTtKvH77Y9WHyBgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA5SI8/mE92xdTJtovs6dRhprwI0o9+g1x0RretrLY0=;
 b=pZvD2mme3JamzNl3jtvup7sKAAGWOw1PK2D1deUIacrKBTnY28FXOEKy2vF4GoxMVgyac69Az7nvHdv7vLbyOGZrq32rjPVDI8j5yAxHDHxxn1TVotS2vv4bON0INORinlJld24Guh7eb6ZQHl6sgvIVyBnB0lmWA7dROAwqnZkDbmcvCPoB8vVjS9Mm3EV093OoZcCjxFr3p7QNIGG+LOvW+rIJYY0ESKkr6KB6ruJlXXi3Evp48pm9VMjkY53UE1mgOSqu/WwBrlHLpBrLPvxYS4j5pqLBOV3d8D3y9d77COoO9uccVYs1UOFetrWzcfpceJRXOlqYTO7qW2xITw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8157.namprd02.prod.outlook.com (2603:10b6:408:163::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 10:47:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 10:47:10 +0000
Message-ID: <c10b3213-4814-4da6-91f6-edcceb41575e@nutanix.com>
Date: Tue, 10 Jun 2025 11:47:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/23] vfio: export PCI helpers needed for vfio-user
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-2-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250607001056.335310-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ea34c6-e903-4aab-c519-08dda80c26e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDAvKzB6RHBHNjVBRWM4WGJWMWlSd1hYYkFFZ3lxdE9ObVNFSHZkTzI5NHFX?=
 =?utf-8?B?a0xCWnkydTdwSGlnUm9RemF0eDRjOXdLbDJJYnUyRW5GUDgxTDlsSDRvd2Zr?=
 =?utf-8?B?VTRQUU1EbG9uVEVvQkRWamM3OUx2Ykpjc2lRZkw1eU95WnIzUVdKKzJyczR3?=
 =?utf-8?B?cUw2WHVuVytWZWhEalFaV21qT3NPbHNScDFIaFdCU0J1cW92c3krZ05ZL1V5?=
 =?utf-8?B?MncwSmVKdW02UXhyU1VMdkE1aUV1WGx6ODFYOS9nTnJCZlFkYkcvdTJSZCt2?=
 =?utf-8?B?VitiY3JYZWtiWUtWMFUxOGFmR0tLZEgwV3lrOXg5SGc5bDhHRm9YN3ExWld5?=
 =?utf-8?B?aVo2bjRkRlB0SXI5SjBUcGM3dWw1a2NFeWpMdmpCRDNRVTRDVUphSDBlRXUz?=
 =?utf-8?B?cFhYaHhCWERsT0d6ZVp2aDBqL1lmMGtjd2phcnBmdE1tcVQwMnZpa2hUWUNx?=
 =?utf-8?B?NVRNVXRMVGVKNGpLb0J2TmF1NVBvWS9nT2JqQUlvb3h6eWZNNDZnSHZ1V1JF?=
 =?utf-8?B?T0ZOTm1QN1p3RDErK0FjU1UwcDRkb1RLYkxudHlJWEZ3a0NuQlpmb3pXT00w?=
 =?utf-8?B?ZnAzMityQVpWbTJPSmpBNDBKWWYrY0MxQmV2b3RjRTVIQnU5WTBraGlHZ3VM?=
 =?utf-8?B?RU9qQU03aHM1UzRCNCs2akNHdzh2c1pjWXN4dWYyWUg4dTN0Z2xidFhaMDhj?=
 =?utf-8?B?ZldlYjBPb2l5QWJocUhrS3Y0TmRZbnUyUXpRM1BlVTVuSWFSeFNJaUpGTkR4?=
 =?utf-8?B?SC9aN21LMmlGZHVWcjY2UUpLcnFkakxKZUNoSCtNTTh5SzBoWDNyZUVoa2RE?=
 =?utf-8?B?N20vTFI2QVNhSU80WmxhTXdQNlhRdFRUcHlLRlcrSUgvd3dTRDFtUURXRzk5?=
 =?utf-8?B?dTJHVWkrQXZ4bjhwaUJLWmFmR0d4amNxTE13YzhHczFFT3QxREFQdGlLenph?=
 =?utf-8?B?MmdXNnhGUVN2a2Y5Qm41THl0KzBtdzg5b3B3NlhWdTV4RWFjUkZCbFh4R3F6?=
 =?utf-8?B?cjhRQ2hFSWhnWXFDak1rdlBjUTZwdWNhTFhQMFJWdVJwcHJJSlp5c0JaME9N?=
 =?utf-8?B?dFFVc05Lb0dkeVVwcExqeGY3cHBidzVYSGtMY01GQURWRU40YVBSeWE0UGRW?=
 =?utf-8?B?SllyUGl5czE4OVlMelJ6dDdmYS91eTdFWlBINjJ6WjdtNUtuWEgvTzg4bWVy?=
 =?utf-8?B?Qm5yODBzbzI0ZHJKYVpWV2hFVVF4bENxTDZwVGtTUkFmTG5jK0VhZFM3NTRB?=
 =?utf-8?B?S1ZJM3M4cVBrYjh0NXNDTk45NzFlZURLcWNoSkhmQjhDRE5BcVJld05ETm1x?=
 =?utf-8?B?cXQ3VVc5aWFXRVZTVzhjMm5xeE1RNEZ0S0hnSitUQmI1eTRybExsVjViaTg1?=
 =?utf-8?B?SS8weUZBUVA5c1JBS0dJQlNjem9taEJKdkRqUFVycHIrV2tjNWpFQlJpRldu?=
 =?utf-8?B?UEpOTFg0d2tuUld5K3lNL25sc1pHUlJEcnJIbFRYblRZYTVXclJsL3V0a2xs?=
 =?utf-8?B?NFJ3dnE4U2NHeDZIRnludnUzM0pGMWprV2NYbHhFYWNZSC9VdWhEbzl5VC9S?=
 =?utf-8?B?Uit4WjVNYkhvVW50VWpzcVluZG9QNGh3ejdYVFVYZ242RG1PMzVRRmx4Z2o1?=
 =?utf-8?B?Y016NE02RFVHbGYraURueDBKREhWRGxHcUM1SkQ4SzlJYU5mZWlVZ0xacHdp?=
 =?utf-8?B?a21ET0RlL1hyR21adWgxbXBkY2Y5N3lXZ04vd3RJMlZ3Wm8xRUFzVkRNcmxv?=
 =?utf-8?B?bHZlZ2ROaldXVnFzczRzTEMveDQ1bjRIbFg1ZGNoZHBRd3EyR05aZ3FKWXVO?=
 =?utf-8?B?MFFQZFBjRjhRU3l4Z25Cb2YxWGcrclZvaXFTVjFBa2JqM1NMWmhUS0hZUHRo?=
 =?utf-8?B?UWZaQ3k4Z0ZZTXdaMlExb0lwTEljVkRSQXFMV3E5QWdjNDZzSDhpdGJLOUJa?=
 =?utf-8?Q?wHnnGT/62yg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhiOHpqOWg0TGp1RmZKalRKU3pLdnF6NTgrTlc5a3RacWw1dFQrUFBVU1NZ?=
 =?utf-8?B?TU85bGlsMmxFd3pObnRVRzlrSWFZWEZyVk9JWkNxaDVRQ2xBUUtYYlhzUlZ5?=
 =?utf-8?B?bkVPbi83ZXcweHF5Z0VONVNlblAwTTFNUzlDMVZCT3FPWkJMUG8yN0g0WWdk?=
 =?utf-8?B?eURLUVZXOWlibm1lb1JMb3YzWXJpdlRtYk1sRkYycGJwS1lQQ3h6dW1wSkhX?=
 =?utf-8?B?MG9jY3FpZ1BsNFUzdCtIWmlGaFNqdGFna3oyZVhtWm94MDNpMDhYd2RKL0g1?=
 =?utf-8?B?Y1k3RXpDQ2FYWmY1OUlLaXhFR2I2SXd5SjI5eXpITlNPb2tEbGIxd3o2Y0hR?=
 =?utf-8?B?RmJtSTdmZnQ4Yll6QWRwajhDeVFIREFMd3BTTFpMbml2cEdyRFlmT09Qb1B0?=
 =?utf-8?B?dlpSVmcwRG9PK0w3SWZDWVRrVlpid0h6NDdFNGl2Tm9DK3puTnpKTFAxN2Np?=
 =?utf-8?B?ZGF3NUlNb2o5a0lsZUFQeldDZlcwK3dnM3ZtalNWMlZjMDZyVmlEMlpSNll6?=
 =?utf-8?B?VzZkbjZqUExSMXNYeVpUbjJiRk1KQm5VVGUrMWZsUjZ5WDIwbFFmblNZbTk3?=
 =?utf-8?B?QkMzdFk5ZEJVa29jeXRZdGp2MzU2eVpkWlFQVWQzTk8rYXNOSEVtcHFRdWZM?=
 =?utf-8?B?RHQ0aFIvcEtSQWtGRHR2TUNIWnJpMXZjOG56NkRmT3Bqcys1eDFNa3k0WVEy?=
 =?utf-8?B?d0tKSXVpVzRibHpkeWZEeCtjUWhwVHZvMUVmcDlvK3ZXUFZramZ6Zzlqa1Nt?=
 =?utf-8?B?WWk0QytBeER0azFTaTNEd3MwVzZ4ZDNkd2h5NndBc2t0VnZvY0ZiTk95bUdy?=
 =?utf-8?B?cVluak04ZTl0S0dLSXBEQTllTEoxeU0rdEh0ckQxckE5U0lkT056Uit4TE5H?=
 =?utf-8?B?aHo2cklKbUpCT3laZ3UxZVEvN1REMlFrSXZWZXRGUFdscEUvcUI1a2xNYzlZ?=
 =?utf-8?B?SmpnYnVmM0d2ZVJhTmpGVlRUd2pLNzE0MW54cFFnR2MwWHJPY1lvcmU0U05Z?=
 =?utf-8?B?dFlZNmI2TXFNWno0eTB6eDZZR3ZKVlArcHI5dUZBa0ZTV2lud2tMWTVTVVox?=
 =?utf-8?B?QVc1RzBxbHJFSXZ2VE9FTmlFUUFWTjhlK0wwcm1nbmpvdENkV0xmMTNSYXNW?=
 =?utf-8?B?SEhBVUlDSnlPSnUvTDhVQW13OUt6RTBlaWZDU1I0aDBjck1GZThtclNPL05V?=
 =?utf-8?B?WUFvWWQ0K1ZxejBndzd3VFV4QktobStvRElvUHpPbnVZWnQ0OUxMRFFIV2lw?=
 =?utf-8?B?NFp2Z29iWHF2UTQ0MkhJZEtiVm9pTWQxdDVIVkFHZytDMHNma3V6NFZUVXQy?=
 =?utf-8?B?Y1Y4SVkzQUd0aE84eFRuQjdKTm9iblI4WWhtZ2I1RzhXT3NWY0k1MkhZS1Qx?=
 =?utf-8?B?a2htZUFZUWgxTDNKRzFqazBZbGhMRjF4RjBQQ3k4SXd3akpYLzBtR2EwN2pD?=
 =?utf-8?B?ZHZNNXBwM1JGVzRyR3k2eTFyeDcwTnBQNkNuYXRnQlpWRlBJOEMzSXJDZXNY?=
 =?utf-8?B?WVFjUFRKUkhZa1owcHNxZVlxa3ZETXd0TVNqSldoZmF4dnE5MGJRNGtNZjJD?=
 =?utf-8?B?bXJoNjM4aFJzOHcxYVZyK3FiQnNwZmdPWGdiK3J4QXBvaVkwYzRXZll0MjZj?=
 =?utf-8?B?dDU0NXhvdWlVb01FU0hhc3ZrakJleHJkYjdiVkZvcFpCNEtIMHZZbFpaTTRM?=
 =?utf-8?B?QXVnNHdNenJSRENBaWsyRE53R3B4bDU4aklrYUhnNmp1T0JzUWVuYWl3dXl3?=
 =?utf-8?B?b3g1Qy9FblJrN1A0WVRLSm4zRWxlY1VrTThRcWJEM0lYdlYxWU95RitwenR5?=
 =?utf-8?B?NXlDRGJ6cW5WZ0x4bHBaTjdQMHY1c3p3ZjRJSTVRR3Nqbk5hLzdwcUtzOXQx?=
 =?utf-8?B?RUdOc3pQVytRczVTSUlYWklDOEtYSXFNdE52V1lkRnRIQ1NLVU9hVjFKdUF1?=
 =?utf-8?B?SkFVbzlVWndiTFBldDVMM25LY1VYTmNFcVVFVzV5S3NWUUs2WHFtMFZmcWF0?=
 =?utf-8?B?SytkWUxNdDR1Ny9mZ3FwOUtmWVl6aGUydng2Wjh0NWdoN0F4YmNqQUxnclBp?=
 =?utf-8?B?Nll0Ui9TdnBvYWd2K0UyODFDREVNOFBZbFAzM2ZUeS9oNmtDNnM1VXpKcXBm?=
 =?utf-8?B?SU5aV1BYNXNLOFROV25FdExtcU83YXdBekpEejhCbm1KMnhldEJSQ1d3ZndS?=
 =?utf-8?B?Q2QzYnV5dHVWNEpVZ3pFcTVxSGJPbDdzcGQzbEZqTkV6MVkxZVJZQVJuTGFQ?=
 =?utf-8?B?Y2grZk5MSUpYaERqejA0L0pBNWlRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ea34c6-e903-4aab-c519-08dda80c26e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:47:10.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiewCT5sd0uJBI57p27dg13rrNyUvGyG+oSJC/buurOreHVGSkqpP8EzKmam5hc6Ynn5XNrQR3jOKj/CA76sO2l0PYlPIqFeSuY/SOU50xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8157
X-Proofpoint-GUID: boHFbGhEBwKyuCpQxcJS1w_Nb-y-Eup9
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=68480d30 cx=c_pps
 a=JCInGfjmQJ+O+leRUSAC4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=8_AniDzTzyVSuhZCgjwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: boHFbGhEBwKyuCpQxcJS1w_Nb-y-Eup9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA4NCBTYWx0ZWRfXzIIC1Bxwdvqd
 oooN2WshwSXcm5JxDcYGNi6eEsdsWQ4SMrdv3B4vnt38QNA9BD3NxWQPVoWVNvLfNrBJrEs/SO9
 oAReWPbwCGwY73RARQAKro7PMERlG52CXqWCNugCWcZ//jBppijeegMzmRDwbn3i3SgvOIC6uJQ
 ZJjf5tymQYRZ9myWuc5yChIBvsInE0+W4/8+6QSkGnqGLy/U41OaFgDOB9rczk6Z9oyD5LJ+Pxg
 1O8380ykrzPwMJ2jWPzPJ1UXaIyvGNcCLqIXAHHOJIjohm8vY16Mqy0U9Vun7nYLGvvoP+coj8Y
 LcJI7un5jW363OZNZxptoxCHcMT/DcXGDhFysqRwt5XbDaqnkowmrCaxB6F9hveRdMOg50soqKL
 XXBDvSUU/2aFUvrM9LvesqT1uLo8hiJRMX9xnzapgnhKFkFaemnDrqlfKmp23cYc0ZsKEx5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 07/06/2025 01:10, John Levon wrote:

> The vfio-user code will need to re-use various parts of the vfio PCI
> code. Export them in hw/vfio/pci.h, and rename them to the vfio_pci_*
> namespace.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/pci.h        | 11 ++++++++++
>   hw/vfio/pci.c        | 48 ++++++++++++++++++++++----------------------
>   hw/vfio/trace-events |  6 +++---
>   3 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb916f..d4c6b2e7b7 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -248,4 +248,15 @@ void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
>   extern const VMStateDescription vfio_display_vmstate;
>   
> +void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
> +bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
> +bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_intx_eoi(VFIODevice *vbasedev);
> +void vfio_pci_put_device(VFIOPCIDevice *vdev);
> +bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
> +void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
> +void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
> +
>   #endif /* HW_VFIO_VFIO_PCI_H */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b1250d85bf..a49405660a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
>       }
>   }
>   
> -static void vfio_intx_eoi(VFIODevice *vbasedev)
> +void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>   {
>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>   
> @@ -111,7 +111,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>           return;
>       }
>   
> -    trace_vfio_intx_eoi(vbasedev->name);
> +    trace_vfio_pci_intx_eoi(vbasedev->name);
>   
>       vdev->intx.pending = false;
>       pci_irq_deassert(&vdev->pdev);
> @@ -236,7 +236,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>       }
>   
>       /* Re-enable the interrupt in cased we missed an EOI */
> -    vfio_intx_eoi(&vdev->vbasedev);
> +    vfio_pci_intx_eoi(&vdev->vbasedev);
>   }
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
> @@ -1743,7 +1743,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       return true;
>   }
>   
> -static void vfio_teardown_msi(VFIOPCIDevice *vdev)
> +void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
>   {
>       msi_uninit(&vdev->pdev);
>   
> @@ -1839,7 +1839,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static void vfio_bars_exit(VFIOPCIDevice *vdev)
> +void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
>   {
>       int i;
>   
> @@ -2430,7 +2430,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>       g_free(config);
>   }
>   
> -static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>   
> @@ -2706,7 +2706,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>   static VFIODeviceOps vfio_pci_ops = {
>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
> -    .vfio_eoi = vfio_intx_eoi,
> +    .vfio_eoi = vfio_pci_intx_eoi,
>       .vfio_get_object = vfio_pci_get_object,
>       .vfio_save_config = vfio_pci_save_config,
>       .vfio_load_config = vfio_pci_load_config,
> @@ -2777,7 +2777,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -2823,7 +2823,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    trace_vfio_populate_device_config(vdev->vbasedev.name,
> +    trace_vfio_pci_populate_device_config(vdev->vbasedev.name,
>                                         (unsigned long)reg_info->size,
>                                         (unsigned long)reg_info->offset,
>                                         (unsigned long)reg_info->flags);
> @@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
>       if (ret) {
>           /* This can fail for an old kernel or legacy PCI dev */
> -        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
> +        trace_vfio_pci_populate_device_get_irq_info_failure(strerror(-ret));
>       } else if (irq_info.count == 1) {
>           vdev->pci_aer = true;
>       } else {
> @@ -2857,7 +2857,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_pci_put_device(VFIOPCIDevice *vdev)
> +void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   {
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -2905,7 +2905,7 @@ static void vfio_err_notifier_handler(void *opaque)
>    * and continue after disabling error recovery support for the
>    * device.
>    */
> -static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
> +void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
>   {
>       Error *err = NULL;
>       int32_t fd;
> @@ -2964,7 +2964,7 @@ static void vfio_req_notifier_handler(void *opaque)
>       }
>   }
>   
> -static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
> +void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
>   {
>       struct vfio_irq_info irq_info;
>       Error *err = NULL;
> @@ -3018,7 +3018,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>       vdev->req_enabled = false;
>   }
>   
> -static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> @@ -3124,7 +3124,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
> +bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
>   
> @@ -3214,7 +3214,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> -    if (!vfio_populate_device(vdev, errp)) {
> +    if (!vfio_pci_populate_device(vdev, errp)) {
>           goto error;
>       }
>   
> @@ -3228,7 +3228,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           goto out_teardown;
>       }
>   
> -    if (!vfio_add_capabilities(vdev, errp)) {
> +    if (!vfio_pci_add_capabilities(vdev, errp)) {
>           goto out_unset_idev;
>       }
>   
> @@ -3244,7 +3244,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           vfio_bar_quirk_setup(vdev, i);
>       }
>   
> -    if (!vfio_interrupt_setup(vdev, errp)) {
> +    if (!vfio_pci_interrupt_setup(vdev, errp)) {
>           goto out_unset_idev;
>       }
>   
> @@ -3288,8 +3288,8 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>           }
>       }
>   
> -    vfio_register_err_notifier(vdev);
> -    vfio_register_req_notifier(vdev);
> +    vfio_pci_register_err_notifier(vdev);
> +    vfio_pci_register_req_notifier(vdev);
>       vfio_setup_resetfn_quirk(vdev);
>   
>       return;
> @@ -3310,8 +3310,8 @@ out_unset_idev:
>           pci_device_unset_iommu_device(pdev);
>       }
>   out_teardown:
> -    vfio_teardown_msi(vdev);
> -    vfio_bars_exit(vdev);
> +    vfio_pci_teardown_msi(vdev);
> +    vfio_pci_bars_exit(vdev);
>   error:
>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>   }
> @@ -3338,9 +3338,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>       if (vdev->intx.mmap_timer) {
>           timer_free(vdev->intx.mmap_timer);
>       }
> -    vfio_teardown_msi(vdev);
> +    vfio_pci_teardown_msi(vdev);
>       vfio_pci_disable_rp_atomics(vdev);
> -    vfio_bars_exit(vdev);
> +    vfio_pci_bars_exit(vdev);
>       vfio_migration_exit(vbasedev);
>       if (!vbasedev->mdev) {
>           pci_device_unset_iommu_device(pdev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e90ec9bff8..f06236f37b 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -2,7 +2,7 @@
>   
>   # pci.c
>   vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
> -vfio_intx_eoi(const char *name) " (%s) EOI"
> +vfio_pci_intx_eoi(const char *name) " (%s) EOI"
>   vfio_intx_enable_kvm(const char *name) " (%s) KVM INTx accel enabled"
>   vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
>   vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
> @@ -35,8 +35,8 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
>   vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
>   vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
>   vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
> -vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
> -vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> +vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
> +vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>   vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>   vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>   vfio_pci_reset(const char *name) " (%s)"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


