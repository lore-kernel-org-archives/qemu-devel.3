Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88C6C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7P-0004GY-Go; Tue, 22 Sep 2026 06:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7N-0004GQ-Mb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7M-0004WP-4R
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03Kqi2447648
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=z2Znuu4mJVfkKY7H15IlzlMP/u3vLjaKdxOoAaKfY
 dA=; b=JIrUHR1wnb60EwGl42OamyqSQJAXkQV2t4iVC3GU+YKQKMb54xzrHslMP
 yacjrGAltk9aXTAeA4ATGxRfx75FoUCwOB2JkGJgPaR3mAbWz7YXcBNImlMn1Swk
 hmyUAkLV441Dd2YfIeqqjyx/w70XNbMtqAaargRf4MmWfeE43TQ0xrC6yK7h5mJj
 a7a3aRENaXz5UMF8bhPgFoe06/W0pN8zbu4ihd6FTUvCo3WO8g8LG8fKIlOjD67Y
 O1CSe7WNVOTZP0pAoWQilmCio/wUMeOKYysBzBTcJwoXRijtZGYoOtZyBxPBS1hj
 Xkm6HCFCLqPgkr6M9pm2g9NM41Ddg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5tp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/lnxRiCk0J8x9khVO2+O7BCPLYT1W9UfsJHOOGIM1KSokvy3bRb28xXRLsi5zltxID/bnLdRbquRkqph1vnW27I1Y++WwNEYgrAwjm//fH7LJRt57kTdOAxoWR9I1aZnoFLiq7OQYgQ0uvHuzfZzlj6P9h/8jWvGDBufeKtg3CKMIqdvQoxADVk2mjbrshIJa4Uy0Hb5HkEIzjS6Z4ROMXR8xIkxemRQP/mxY9fiS/PLe2ldykpZ9ROuXjRT3PlzPTFyQulBCGnTwHr223nPllYpTbHLHsBOiQPYNmCqiFIWz74o+1hQPgBqA1DKG3vMbA/0mKZOTQ8NZeeoRSMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2Znuu4mJVfkKY7H15IlzlMP/u3vLjaKdxOoAaKfYdA=;
 b=zLASH24aTPfmozbDXUpdOlg6Tw9T+gDoyUBcoh8gnPM+UDHBdJTjdjK/bMcNnpMSBshX0Oeaev6V6f1niFF2ZCoPAl0YzHTcmJD4CwqzizjiYj9INaA1pNJBcfabSNbSMqA4ST0pktZo1GzgpLsx2e19Vq8fDCnzsNo57iLFPgSrOfrfjaSsyk8bMIxGU6XxDQeJbIH2odAXmck2HbtixWeRYKozMJNVpXMMtP0PGOsDLxHqZMo4qdMwMGIsbx3gN8k5BWJEgFmDw+hGCIInz1p4LuYeLcRNvt6AmuaI99dOJ0lI40rw9qI9eJfGheSFHy1ZYyWcjREL+FbSTLry/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Znuu4mJVfkKY7H15IlzlMP/u3vLjaKdxOoAaKfYdA=;
 b=RJbrjbFrI8+p1DSqDhTKP1kwEh+MlvSw38P/gf7TGUYLn64c0D6PKOAQG48jppWX94TPJnksGFLlPNo+tyTl+n9ZvjCXPqQWQ58rr5w+9SikwUDUfDI59ER307ZH2rZEIQbXDYv/JzqF443guZS+Drl23Xqo9x+TLS72GTCwWIp6j2fG06jWesovXG1/5ugKwPI9EP73ItKiSJkMAwDHfUvSfgcF2bPaYZTPxpRhkLqd8xzk9r7m+nW2RjbivPYMKqJBkfxmfJZL/Xa6crPHI2Ex3B08enRbV6db+I2h2HFTFH9ebtMBCGn5XSjPzlApOyZWVrkGFViQHucoxcWnZA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] hw/i386/pc.c: convert rtc-time object prop to a class
 prop
Date: Tue, 22 Sep 2026 11:51:35 +0100
Message-ID: <20260922105223.1607725-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a6b0b9-53af-4604-f93d-08df1897a644
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: hakBC8UdugS/M4TIj5fAex4sN3FeMlOeK1jY9jxfotYNhiYRLdhgWd5H6sR7aM32HHlzJEXVF5J5R9fd/1p82VpAZH3VwoXS3OxO+VA8XAcA6bcGCnL3H78OcEM4cPxO/KjJq9+HAuFHwibV2+WHkCRCCN4DypTkaXbLMXsCtrI/x/USQCd0F0cm8BmEIra/NeFGHg4U9cfpBjDRkcggJvtrdAb7VN1hHipKHie3uPPF8CC18xBhJt1+u9qP/ZBbIK3kP4ndt28ADVTMYpZHCcUTBeVZnTyYopMwikTtv0dqsHq6Oz5+/qJ7E6dSKicnMTLUNF321aj1v1K0sT02vq4lh7vBULQZ98VkaajO89w9OQrOPsqDY5fy9LEI8cSc7FxHrGjucwx78BdCoqNaK/4VIAiMhvZpZ2BL90cxjbDsxqkVDScXqBbr31c/r8ffMciQ7nyzhbjmKwguWpZwBY+IoLVrh22Qw5l3DXCIXp0M7KiohXTZeUXxz+DVpLsrC/S5RjGqfbX0DANo3de9tIU6Labbf4FN2l4ZdWoJ/hq2kDJ+rD2QFHa2Z7jK2ozS68GKWNInDu7B50kpFA52o1Qm0lnGaeEilQ9BoGzWWkKacR2vvEV1AZpNkHVYZmdko4eAD0jP2zpLgYOzWaU3NfbxoulDfyG4S33uqtQyNYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVkeStmRnExem1UQ2RxRUFmbTcybEs4dmZGUjlkeGg1UzFnZWZvOHdadjFV?=
 =?utf-8?B?U1E4cnpQSlh4VWNSZmo0RWdEU2NnWStBaUo3QVJWL0NGTEpub1RCL2JzRk9j?=
 =?utf-8?B?ejYzSUFqOEdCeEJVdjFIYlBZb3pHdDFNL3VTZkEyUENHK1Rwa0MzQ2ROTnJ0?=
 =?utf-8?B?bm1SMnBqTExqZ1dWbVhWNUtBbjFiaDc1T0RoQ3Ayaklac1dIMGgyUnZDaTdO?=
 =?utf-8?B?MFRxZGZNcFBPQVVxV0h5c0RYcExsM0V3cUhVckFKeVFKZ3paUVFVbUYxMk9n?=
 =?utf-8?B?cTg4dFM4THpNZm5EbGp4azBKQmFFa1orZG5XMnZ3enVDcGUrNFdISVdkWlZm?=
 =?utf-8?B?U3hDZGttN2Z6WlJtekoxbjJoTDh6TURhRGV1c1ZCcVJYclg3Um5jaW5nbFV4?=
 =?utf-8?B?dFNwQWM2UU53WmI4bVg3NmVRcHRLcHNFem90V05zVHRMaDBFSGRKM01mc29v?=
 =?utf-8?B?OGI0NmVRVHRzZUd0eU9TUkwvbExGcnBRUFBrdzVpUmt0OEJlMm9NN05pZHA2?=
 =?utf-8?B?MlFFanJMU0FaZFQ0aGdWbFp2ajA1azcwMTY3TCtLN1JmSXJ4aXB2Ti9mY1Zq?=
 =?utf-8?B?eGIvTDBBN3ZYSitEZEN2ZkpzUVN2dmx2UWh0RXR3bnJwMU9PNVFmblk0VSsx?=
 =?utf-8?B?eVZySi9OYkVPWVBQWFhYTnJCbWhJL0xKZ3NtNVJzTVd2WEpJeTN6TVhicUtr?=
 =?utf-8?B?Zk9OQnRvdGVHSm5PaHRjZjI3OVZKTHVzWHhwZFVLcytlaDkvRU8yU0Foa3Jv?=
 =?utf-8?B?akFhOENubWo0bnNBTlpUbzFvbWxVSWtrRjlvaFBrMmNpaXppbEJWYjhRMzla?=
 =?utf-8?B?Z2VlWUpvWm15T2NBL0owWW1HU3ZTaktqdEVnb3U4bTNaTDNvbGkydTJSTnJ3?=
 =?utf-8?B?WWYxNGJuT3p2cGFhbU1KeW1BeGl6RGRaV1NwRkU2NmRTTXRlemNaYVowR1hj?=
 =?utf-8?B?emR0MDVSRVY3dWNBNUZZaWNuNUhYdXRoVWRoT2VSMm5GL1ZPYWJEZHdnRzJj?=
 =?utf-8?B?SGkxYUtYenUzQ2crMDhYS3k4SXRrclBUbmtyR0RYV3NBUE1EZHMyQ3BVMDZM?=
 =?utf-8?B?SDB0eCtCUGttbzd4UEVKclh3YVo5d1dnMVNFS0d0V2pITURCbnFOLzlSQ3Iv?=
 =?utf-8?B?Ynp6aHY0OUF6VjVpRVI1NDIzc2gwUllGcFUrdklOWnlYcnJ3VDlXeDhzU3Zz?=
 =?utf-8?B?QklwVnV2enlMVytVSXROd0EzOWZNT1F3ZW1sdnJqUWVIL1ZyUkhCVmxRYndi?=
 =?utf-8?B?aVBxSGF1WXRuSnUxUmhwQU9maTRPc1Q5aFRabm9Qa3NMVGlEWS9WN3lxd0ls?=
 =?utf-8?B?bXRpczlQVG44Vkt3QjJxdFM1Sys5NlNWS2E1Vm94UWl0Y3BJa01lU2N6R2pR?=
 =?utf-8?B?TXpQMjF5ZGtPQ3ZScWRCRW43cWE4eXBGUUlZT3g3blFlWnRTL3N4czF1bzls?=
 =?utf-8?B?T1dwTUxLY1VwcUtpSVVCZ0J6bHo0clVwZ2V4Q1U4VkRhbnZ6azJoV0czWWp3?=
 =?utf-8?B?aUd0VFBLa1JKcndja1FNQWZiU29TY216SEdYZDNBc3oxTkw2dVZaeGpTMEFK?=
 =?utf-8?B?cy9WcGJHc3ZuTjVJY05JNklFMHNrWThtZy96Sk1SRVg2cUxNdnhGSml1aits?=
 =?utf-8?B?S2FRd0hTeWtRYVdpNFNOMlJjTWkwOVR0QnJEZkFjMm1uSnpQUnFSVHQzUGc4?=
 =?utf-8?B?SHJJd3A2TklSeUdnRFFWdFoyc1lrM1ZrTXhXYUZKUU52aU9CMGJWTWJaRUcz?=
 =?utf-8?B?UTlnUDdFZm13Ynd6S3dDYUszZmF1UGcrc0JOTGtNWWhkQXN5dWVuU29pVFB6?=
 =?utf-8?B?NDB3YWwrdDFrRjFCZUs2TktZa05iQkU0WFVQOEpVN2Nid25aRmdpQ1NISHFV?=
 =?utf-8?B?UUxQSVI1WlhZT2wvM3pjT1VSWk04UWY4bUk2UUtvN2kxMlpveXdsa0xxalBS?=
 =?utf-8?B?SmsyZ3R5bHhqM0hWWFZDdGlMSG5WajhDdVVaa3FVUlBKWGNtQWZSTTUyWmhM?=
 =?utf-8?B?Q1NvNmlwaHcrVWJRVWxxN3dGUjBOdk9ZSmhUVzc1NlVnWDVMT2ZzTzlFRE5Y?=
 =?utf-8?B?TEZjWUhqaGFNR1NQbW5GSlN0dHRjVDVSMElSZHlBbmpOR2lOSE1pSjZJbE85?=
 =?utf-8?B?elEyalA1TlRrRUxWQzJPa2tFRFhPcEpEbGw4ZFdUbEFmNG1kdHVIUzVDZnFB?=
 =?utf-8?B?WXJ0VnpzNVE0dkxUYUp5T0wyd29IU3gxZkJjVFBhWC95ZlVLQ0xUNXAxSUFt?=
 =?utf-8?B?QmJrOC9tWFY0MERxaW5DUzEwYm9DOVRoeG4zRlZUcFFLZWU0b2NMc2xYRlIz?=
 =?utf-8?B?Qk5uVDV5ek9ZUFpmY2U2NjI4d2FkTStQaW9TMDQyKzBBNEM2MFN6ZTNkV2p3?=
 =?utf-8?Q?zRW4ZdoG8Dw+IaO8=3D?=
X-Exchange-RoutingPolicyChecked: y+KsqjhvFiBYOoC1eD1yUq1StmlwAbwnqhGn8OtaaJPdk/35PMvJUMMGnn+F3hvkXT1odUBTW9JqSYY5JsjP/qi19VNXx1mgwRHXK3V6VScAKhzQBdqwLZK5ZW7HX5gP3+YKngznBx1U2jSWyebTpVXucrI0+hHjIPsGipz4EVRRPGMTVW0f5aoNs+UnbBOKonpjPLREFyqr1V2o5/sRzQW8ixFSnrTSKluN/DxzQNZv4gqDIENcgJTy2mfZvpkiVKGA1jHxPD6QFoucFzZaOoCTbI2lIqNJdYMKuOkcxEw/oopnp3yk0+N/8usjxdFte7hvTmD6Golo27g5TP3OVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6b0b9-53af-4604-f93d-08df1897a644
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:52.0127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YXMUR9VbkxYjqo/KHpB0nV3zj4wnpcSbxnyyzqd8IdA7CMZrsd8Dr97GJQU9vo7hF03jweSQoqHncQVF1WUpM4wnkaa6f9oJ7q8qep6piQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfXw28pyxVg7nTH
 3LQ+NcB9ur8rpvW6m4YX3pKi0TpVFirL58upbZcu280619QQo/ooNZ3Vb4UKCyApZp3ds7O9aYz
 YOkO4RjViIbvSe2ELXbovadACRFjdKKXsX8rbIlC72PIEhHmYpP7vAHElVGy5ENundqOJTNlyga
 Aki9yP2GNVIVijI9vtPkHlsHl+EtjcgGSqLlPXdGWk1L8Tjp+qa/gCFNc++Lv/PCpg1jNfm75ho
 AOas50rmjKlT3ozZIpNq9+IjdysxpKeRm/pC4eT9ZhDKMxJggYb3W8BAiCLh1ZuhtUBmWFiIWSz
 N9Yfx11Ha7fn3vDB9BpwsyEYRN9cF7meNYsJsLTX/q+LYblEhSMxpeN1qqJKGc+RQFUABVAkd2H
 rohcZETtBD6Et9UkB2Pk2x/y4gxDvZsVKD1EX1LQNqgdzEhTOUk5+jbP6/EOXoIVN6XGCzu90dy
 6/lWk8FbiVFI774PVng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfXwJowJri8Rkq0
 O2mq5EL+BV9ozGmfxzZxR2t6Cd87SeKw8eAAVPMqupJTUpCZR+9QlWZVLHHIRlBJw57BuXIdD6l
 X3QArZZJdRI3AE25nJ/rhhgoNGXf7dk=
X-Proofpoint-GUID: 7gHLm7tumnJbUYnp-lJTD190I_O0TxXE
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25e05 cx=c_pps
 a=Tfh5kxD+BHZRkXOJdNqs0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DDMMZ6NTPqBClWpVUZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7gHLm7tumnJbUYnp-lJTD190I_O0TxXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921113559.1299740-7-mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2f1603e104..cbe88a1788 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ typedef struct PCMachineState {
     BusState *idebus[MAX_IDE_BUS];
 
     Object *alias_pcspk;
+    Object *alias_rtc_time;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e2ee1bd88d..70677786bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1097,8 +1097,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     }
 
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
-                              "date");
+    object_property_set_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state));
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
@@ -1792,6 +1791,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_pcspk),
                                     TYPE_PC_SPEAKER,
                                     "audiodev");
+    object_class_property_add_alias(oc, "rtc-time",
+                                    offsetof(PCMachineState, alias_rtc_time),
+                                    TYPE_MC146818_RTC,
+                                    "date");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


