Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC21CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NUQ-0005dk-Hf; Thu, 16 Oct 2025 08:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v9NUH-0005dD-4w
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:53:46 -0400
Received: from mail-westeuropeazon11013010.outbound.protection.outlook.com
 ([52.101.72.10] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v9NTx-0004Qf-1S
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApJQklbNGVBVmTzSdZhCtcAF89oTGqqJVEpRea0pO0p4KVjliaDT65z7yk5jD9MwPpV5Mq+zw58yy7YBOJciM7I5m2f2nlBo+zUMRsHpKj7eOAbdTnsXRDEayxiayuEjc6it8u1gIZ//v+tsOJcIypwt50SOJZnaCuHzG+dDNjkEpFBr4dxrI/JNxNFg+V7lrrNE6BxmmjsTN8DQCgHT87YCyHORhaji8S+pZJL3TyjCQ5E4/T0aAzygonjDQ+jDx+NIR/4Uzh/fIN7ylmLmjaaIv+IVk+K5KGG+HOYxfTNi8gzen/3XUHt82Ogmamj6PotXsv837prvarFKZdZb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDaQvOkiIDm6VsaP48SHBU4Pe85Eh8RhYIuUeJPTYJg=;
 b=FMec0YGsuHzCymvFwf5MzvayFqMNclkWcQXltU1EfiZ/M8eAfBn6HARQccQwcV01P0lkmmU3ma3rX3bfRSoyHe8DP92Oa3giKd6n00egMrsDROgxgwME0cCbwE3kX1xha2zf+gmntxBzLO7y8RugRgYyPfQP+D1oa2VqEn2TJ3y3xpFabmqYSjKz4TxGDKMaxKFGzAwvcBRSSqxaEyyYQH0VdlWIs7BOFmjG4/0tXRUQAOPXNQM28MYuEOE6rds/rQ7G4rvIYfJZEvgccON92c2YeP9juqpt8y2efWagYxsLegqexvFSLxyAVaQzb4r4Mx8/dVAfR1wtouU7X94l4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDaQvOkiIDm6VsaP48SHBU4Pe85Eh8RhYIuUeJPTYJg=;
 b=UH4iSJ2ItsTHPLaTUOxExQ0Zt6v1CbzNzsrhphcySxhoxDyJUp4AV00td8bIRL+QMZH2+bmQ5Qk70eK9/P6r3YlQL3BSm3rA7jktLxuMfdxGds5XQDTu0fF+MtOioFAOLFAOXfuSXaKjAZ+nDZebGu9iCw2TzlH/YASVbeIWc4a7xt+b7Cb71v8I49YTI/c5+WyJA1gI1Zxf6Kojpfno876Nd/V/G1x0yWcth/I669YfeWNpJns7RxBoS6Uer75QjB35mmOVm5gKarq1QyXV43bpaJotlAI4EsAJUS2esRnuiiFoYtYKlDxNRF6CdlOCw/7PBCRMEacR+pFbowo4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 12:48:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 12:48:11 +0000
Message-ID: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
Date: Thu, 16 Oct 2025 14:48:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] hw/openrisc/openrisc_sim: Avoid buffer overflow build error
Content-Language: en-US
To: Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaff721-6faf-4f44-ab0d-08de0cb24361
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnhpZU5UdjhhYVJWNVFXVFRGS0J0NStOck1aWUlVd2VIcWczdWxiUStvWW1L?=
 =?utf-8?B?ODdlTUtXa0ovTFoybVVsN2s4V0ZBaWhPdXVvbThjbkRJeTFpZGN6QkJ4NGx3?=
 =?utf-8?B?eis3L2c4RjBQakpieEFEOTVDQWI5VW5OR2V2eTlmNGVidGNGcXpIeS9uMkFj?=
 =?utf-8?B?Uk1VOWRmcDRIQlpiQ0xjZE13QkR6MFMvdEtJT3Y1Q0JNR1VMdkdzZ1FiZG1J?=
 =?utf-8?B?OEw0bHBvb3Rzejl6Vk5wRjFXaWtKMmxuR05sRHlYVUl1M2YrdDl3K2VtMkU0?=
 =?utf-8?B?M3JrYjhhbEVkS254ZzRINXZYeTVNU0dENTRxckh4emIyOGN2bGJocmF3TVNn?=
 =?utf-8?B?TnlydHhRNmd4YmliOGhweDk0dWUzS0FkSUJDQWhBY0N6Zm1Vand0UjNRTUM0?=
 =?utf-8?B?Z0ZCbWZaTlVVVFlhck8vOHl5bnk4S3VaWXpmN0RldUQ3N092NlAxdzRXREty?=
 =?utf-8?B?YVVEdFR5MzJmVnRBcjZoL05ZbzVaREtQMU96NjJ0ZDFZdFE0V0JRTjNLeU4y?=
 =?utf-8?B?RUhQYXlRMGxXYmxla0RVMm1ja3Zoc216VEJXc0pKeVczVThJMGYvSm5PREdl?=
 =?utf-8?B?bU1VZjJkK0lIQ0g4TjBoejVyVjc5N1NGZXQ5RkEyOWZrQkFoR1pvelhNUCtM?=
 =?utf-8?B?ckpRSUtSN2IvRUk5Sm5CYTZuUy9NYmlySjdBc01PdTdQR2VFQXZxSURwdDJi?=
 =?utf-8?B?ZDFqTEU5R2JVeFZic2NsTitGNDV2aSt1ZFBRaFU4Y2d5aGN1QjVnVnd3OW13?=
 =?utf-8?B?YlFGZ3d4WkQwaEt6aFdZWDlIZUZHa25aRE5jOVZqTmpzYWp2SzBZZmZtNkov?=
 =?utf-8?B?YzlGOWI0V21oZmhDTEJLV1FYWldqd0xnakdPZDZvVzBhZ2luQmNJMDU0TTIr?=
 =?utf-8?B?dFpkd0lJZ1d6Ymt5NmVxYVVqK0ZMdlhONnJpZVZzTU1VZXFIVXRWY0NBMVY4?=
 =?utf-8?B?MnBaM2VyRHI1TnhodXIzQjlSY2l4U05mc0ZmRmVBYmRoRER6bUwxanJ4cXdI?=
 =?utf-8?B?TnlOUHo5TVA4NUVTK1VuQzBkcG1JN2FhN1JqYXVJYTVXOUpyY05vNE9UWXFH?=
 =?utf-8?B?QWJ6dU14NHp1VjJRWWdWOWJIeUZ6ZVNJTkk4MFYydnZScUVrZ1VuSHg3cVdH?=
 =?utf-8?B?dDdZejh3c2RwWmpIUUViM0x1amtXc01iWlJhWitYRVZ6WGd2cTB0TmlFeEJL?=
 =?utf-8?B?eEMxczd6eFk1TkppL0MwR3Y4UWpPak8xRFRGbWtqanNQaUhKTzREQlZpam1G?=
 =?utf-8?B?c2s2bUtnWURFam5NQWFJSCtFTGdmTW5CR3VuVEx6SkdraXhoT1NBRUlHU1Jy?=
 =?utf-8?B?bm5mdHYyUXBmdTNSMFY4YVJyMzJJT1ZudjZzN01TR21aWkxPN3d1a2pEMHgy?=
 =?utf-8?B?WmtQOWF2WTl4R09zTGRZa3FBZ0x0TTAzRXRVQTFIRjNCeTJMZ0VJeExaeGpn?=
 =?utf-8?B?MURxTzNENllXZTNhcGNKZUlSM3A0VXJ4cjhzN3IxTmdEREZOSkQ0UVRDR3lw?=
 =?utf-8?B?NTNJUVZWeCs5VnN3bFJ0NytXcE5xa0JrV2FiaGp0bHo2U3JqTmdVSzk2Sm5o?=
 =?utf-8?B?dEg3M0NpNTZtZHh2NVFlL08yTG5ieWxad1hQZEdiVjlRcDRHSGxRL0xySjBC?=
 =?utf-8?B?bWtoYzBYNjJrUE9pdWIzcEcxTGFYei9yaHQrczhKNGJKRzJsMDRuNjdkWXJH?=
 =?utf-8?B?a0FKc3lKd2tKYk9laWdRbHg3TWlyWkxsUWVQVzFmSjExSGMzY0JDcVdBY2U0?=
 =?utf-8?B?VkFrMkJWK3RESXhUZlhNUE5QRHI3c3RMRkFZZ2o2K09OVTdTZE56UWZ5WXZx?=
 =?utf-8?B?N2tLVTFid0lTNHBSZHAyQ3Q2T2R1MmJPTWo3RjlKeUZtSEcxMTZwYjlXUE1E?=
 =?utf-8?B?clFGWjlGMC9HVDdhQ0pJQ1FGOW83eGVLNHplbjdLNTgrdkVoTkxjOGlwa0I0?=
 =?utf-8?Q?QOYe1prBPecw6lQ7X/n1JPSLxXuAlpvT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZQVks5OW42RGxLY2tOSUFiMldEc05ZR0lBV0dGajVENUd5dnZTZXl1bGY4?=
 =?utf-8?B?Zms2eEtNRXRFenlFbGd5SFQrdXNlenVGVnA5WUVqZkJPQmtLellqRWVkNWRG?=
 =?utf-8?B?dGdKTFdDdDN4LzZTUFhxRWxjQzlEVkRESG50WDRaanU2TGxYY2NVekgwUXlQ?=
 =?utf-8?B?NXhjSnlkQ3FUamlqUmhnWjFwNjIyYUhUTWtoa0FKMkxTV0JnVHpmOFNwS25z?=
 =?utf-8?B?c1c4ZnY0TnZWdTF5QlNEd3ltaHFGbVcydUxjemNwTTdzdlFSL05ZbHZnaWs5?=
 =?utf-8?B?UUV4bDJMK1dCcGYrdEdoc0R1OGVFYlFLakN0azZ2aVNPYjdXY0ZGN3I3dWI5?=
 =?utf-8?B?bWVRRGFTSjJKbjFtdFB6Z3ZlWVEzdC9pWnFvREdaSWM4eTdFYVZzNzRXSFAw?=
 =?utf-8?B?Q0lqRXZ3YnA4UWsvb1gyc045QjdjREN0OFRzcU1xdUNSa3FmYk9mZTZyZmR5?=
 =?utf-8?B?L09IeC81TWM5cGRIWWo4ZllpWTNwc1ZDdjB1d2FxK0JpME55aDBjRDdReUh0?=
 =?utf-8?B?d1FFOHdwQnQvd2o2RzFWZHROekFDWTBOQ01JdDJaOVE1UERrbkVPaURqTEpY?=
 =?utf-8?B?Z1lEbjBNUGlwSmxSd1BST3pHdnBOS3UrbVViNjU0dGFJMlhYZUpoUTR4OS9w?=
 =?utf-8?B?T1VWOHdQYkJxSHFkYm0xNWY4TGEzSk9wcTNqN1hGdTExRG1PM3daZFBKMFRO?=
 =?utf-8?B?WG04cWdyZ1hiS3Z2Ynh3TkNmMVNaVWZMMFVGRFFIVmh0RXc4ZjNnSXFpVHNk?=
 =?utf-8?B?VlVsWnNEdERzVk0xSFRWdUx2YVFWMHZWbk93RDhRVDhHUERKTVpia0pWdnEr?=
 =?utf-8?B?UGFYd05FYUtFdHg4M3hZWEk3VVcvLy9vbUVkUDFEVEkwM3RrbG1WL2hSSlJG?=
 =?utf-8?B?VHpqUjY0QVdMOFNtKzhWall3eHhWMkZ1YzB4TzVJU0NmbmVDMWZIQVBVY0Qr?=
 =?utf-8?B?K1NvVUNxaTgxMGR1MXNyUzQ2NDhPRDJzQTRhZ081djVPQkVIaE9PeWhBcDV1?=
 =?utf-8?B?Zmh5RDFEL3JtUXB6WDlRK21BVis4em1Pc2Nlai9HczRBTVBERXVRNlVtem1F?=
 =?utf-8?B?TmxKUGNvNjFDZ1UwRmpnazZldVVaYUZ4ejZzbjJPV05aU3NRZWV1MHlUOVpr?=
 =?utf-8?B?bnNxUjNMSlBDVHFWWGMrVlM0NGNhSTdCdWkxSDA0UGFLbURXcG9ZU1ZaTXV6?=
 =?utf-8?B?c3VBam83aFc0bFhnM2lsOUFnS1BsQk9EQmJKUEdETFp1ZXVPU2pnYXVWKzUy?=
 =?utf-8?B?QVFOUkl2WTI4TUlselhHWDVWL0FIWVQ1dW5ScFZaUHFNSzN6Sk9oakQ0MlRX?=
 =?utf-8?B?YW5maXAzQXVBK2xSR0lyN1JtMEVWM3VpYk1qbmZiRktVUlp0WWdGcnVVZjZH?=
 =?utf-8?B?MGlQNGl6c2cwRGVMK3IyZVpJK1d5ZENjaU9JTmdvVEFISkMzenN0NGREVkYy?=
 =?utf-8?B?clQxWEdGTU1pVUxlQU5RSVhxT2NuOU5memFobmcrYzg4a1MyaUJ0ZzlFZzBX?=
 =?utf-8?B?RjZlVitkYUdya2pvU1VtRnRtZEsxNHIzWHJLSEJoM1hFeDFlWTdTQ1JjYzY0?=
 =?utf-8?B?aDZVK0JublU1QnBBQXlodkx2LzgrMzh0RUVucFVzUkVxTzlPYm5mY2JaY2J3?=
 =?utf-8?B?ejNMYUhBL1dYcHVxMWtNQ3pQVWc1TzhxVEgva2VnZkNhbDRHTEdrL3RIQlBx?=
 =?utf-8?B?VUJrWDFwN2ZZU1p6SWxiempSR2E0aGZzVjZuK1I5eGNSTGdoYTk1V0VIOW5a?=
 =?utf-8?B?NjV5eXUxMDFpWWNOcldWL1l1Y1BrOTNnSGJhOTZBZC9XSmdSa0ZodHJ4Wmcw?=
 =?utf-8?B?TWxSSnlFRnRXdEU3bktZM1N6eU54cTBncVVDR21zVEgrMnczd1Q3QU5KVWdD?=
 =?utf-8?B?Y0tKVUZJc0xEYUlWTWgzc3h5ZnFTSWRnOGx4enMyZzQ3amx6a1RnMlhzYWtG?=
 =?utf-8?B?UG12cWJLRWZaVERKaDZXTlhNaWVZY0hiQmlNM1B0ZStNOXlmMVYxcmhCVFpP?=
 =?utf-8?B?NkVhT1dvNjh5WVYxbXNqQ1FVZ0RZeERsak9RbURyZW1PNWhvRGc3Q1JVdW1r?=
 =?utf-8?B?dlNRNkNYV3F0MmxQaDlJZUhWYUJZd3kzNldoSGxsbDhGck5HcThMci8xdjE1?=
 =?utf-8?B?TEpCbXBtZ0kxWlRVT2NqaDBBSnYwd3NjdmRGQW1wU1pVVlBlYlNyQ2gyU2VG?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaff721-6faf-4f44-ab0d-08de0cb24361
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:48:10.9269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9HAXO+uLRo6S7FacOWqimTLDnl4eZfYPm2qa+dGzOdcxTv/LM7mngtuYGFhC2EW8pxmTC00UPlD5E705JtTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8512
Received-SPF: pass client-ip=52.101.72.10; envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves this build breakage (which is actually a false-positive)

../hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
../hw/openrisc/openrisc_sim.c:284:45: error: ‘__builtin___snprintf_chk’ output may be truncated before the last format character [-Werror=format-truncation=]
     snprintf(alias, sizeof(alias), "serial%d", uart_idx);
                                             ^
In file included from /usr/include/stdio.h:964:0,
                 from /data/qemu/include/qemu/osdep.h:114,
                 from ../hw/openrisc/openrisc_sim.c:21:
/usr/include/bits/stdio2.h:54:10: note: ‘__builtin___snprintf_chk’ output between 8 and 9 bytes into a destination of size 8
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __glibc_objsize (__s), __fmt,
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~

by using a modern, more robust allocation pattern.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes to v1 ("Avoid false-positive overflow warning")
 - switch to g_strdup_printf

 hw/openrisc/openrisc_sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 880c8ebbb8..b7d9cdd900 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -247,10 +247,10 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
                                      OpenRISCCPU *cpus[], int irq_pin,
                                      int uart_idx)
 {
+    g_autofree char *alias = g_strdup_printf("serial%d", uart_idx);
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -281,7 +281,6 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         /* The /chosen node is created during fdt creation. */
         qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
     }
-    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
 
     g_free(nodename);
-- 
2.51.0

