Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11A1C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhQL-0008Gd-5T; Thu, 27 Feb 2025 12:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tnhQI-0008Du-6a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:11:46 -0500
Received: from mail-dm6nam04on2074.outbound.protection.outlook.com
 ([40.107.102.74] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tnhQA-0004P6-2j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spmU9dBkmRzGlx1qvraagn/oz9xEmacv08bWQvgIpC/r5vFw0PmVEKK9sJu4ydfBZfkpzPInYx18gG8K/YvECWKTZwkkcNiWYKZaqEiv8ObxF+3rD1fpZqdSTlyf86DE9O3eARaL4sKunIIyVMJGJ/BPTnsJ7doMP261pvZ6cygZH1jmeBQng46FV7kSP+aDvthaxGAINNvSAW2RI+cghOV0D4M/m3767zddUjg88soeTPLRWpYtbMYM4AK5UesN47l7gItNp7dclkAHrR+0dJdErvzbB0CywKxE1tiE0VJS02SBn4UCpHOfwSNo21MsCpwYk2SwqQ1XXvsNUsL3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHOVQ7Y5y5G5c3p5OjLGxbFMESUbrhe9GzaL2+vlVgg=;
 b=Rhkt4RdmVa9mjT35Ov2ppR7mhWLEL2T+vdiu+MxSLXLCpzCQXvBz9MmgNztOsqovs1Z/IL+RiqQZi9LLln6jzVnIiBZwahQhXkL779b59e7SMlTqrcH0hgt5O7SKwww6sueZerTUeeXZ7UiyVU6UR3nOCauERXxt/2GKDIiLCDuSnTPQasZSWHhPM1phqjPkB2r4WA2u2uUnRp68vZyDXLySZOmbb0E/ukLVYdVKwTvdByH5fH6YtKKXbdvPl5ubqSULm5w8SGIrQEFOBEI8EWCKKZDatsbIYkkptMOzGbpgPl14wWEZ322Jr5DJArIkgKbuybIpAxvBaPG60HjbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHOVQ7Y5y5G5c3p5OjLGxbFMESUbrhe9GzaL2+vlVgg=;
 b=LWDs7Nsq1+b7jQUTvX+IEPQBi+AYf44CSEJwKiv8xXLu18lg6bQF4ERc7ch+B5jtEhDg4yI7qUbD0Zf7Vizu0dv613KOatOUlwbL0h9y67fPzmRKbcH8ZSe++cHbdCW572CFw2l4kF4f0ZHf92C6fxM/DOVIm8rehq0FXwDAJYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 17:06:24 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 17:06:24 +0000
Message-ID: <c522c153-5363-4672-9d39-41c0950a3d2c@amd.com>
Date: Thu, 27 Feb 2025 18:06:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] i386/sev: Refactor setting of reset vector and
 initial CPU state
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <b8a8b588.AVUAAGPfklQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdy@mailjet.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <b8a8b588.AVUAAGPfklQAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHdy@mailjet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e323b1-6bb6-487c-ac4b-08dd575110f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkQ5VUdxUUZaV3BBK1c3dkJ1S0dpMzIvTmdUWEZBV3NZSm11UU1wUVozWXdF?=
 =?utf-8?B?TGE1cHViSTJTQ0ttV0dMRUZJcDlScEU3MHI1bzIvejdkWlNnU3RvOUNERlNm?=
 =?utf-8?B?SEY5eXovQzVaYzdsc3RuMEN2RGFKVXNoSVRlQ0o4cEpKVS9tMlAzM09Jd2xO?=
 =?utf-8?B?M2FmaDBXRnBOSWlqa3h2cTdPRVYxY0J6RW1kR3gvN2FhVEVlU0ZUTEw4VUQw?=
 =?utf-8?B?YVhEOHd4T1B1NU96N0QzOHNucWYvZEE2ZEVhenhJTzNFS3AyOS8rbk9vZEFV?=
 =?utf-8?B?Q2lWZkZrcll2Mnh3OXdOZFRGNysyb3BobmtINFl3WmlmK1FyS1NvTUw3N29o?=
 =?utf-8?B?S3NFb2FGZkNkOERFT1dXY211UkF2VVBoR2R0SjJiK2FMc1VvRG9rd3VUeXVJ?=
 =?utf-8?B?MElWeFRDWFI0Wkdkd0kyYjJORDhadWN6ZGxwVkVEb3VkM0w4TUZFK1dKN3RS?=
 =?utf-8?B?NlZpVW5zSDhHOWJNYkxtVXJUcmJUVm1KeWhyVm9kVkFoZ1hibFFZOEFvQmhN?=
 =?utf-8?B?THNXN0JBOXdNR2ZtMHNSTHQ1S2kzSDVrR2Y1WGVaQ1R2VmlDMld6eUNaeHNo?=
 =?utf-8?B?anJOdHkrVGg1THpxMlYxd29NQXVremNYNnVsRXVhNVlUSlgrQjBEb0JPZHU3?=
 =?utf-8?B?ajJvaytwSy82cmJPUG54dFptQ3dwLzhBc3pXUDlMQ3F5NHNCeFptOGhDeGY4?=
 =?utf-8?B?SS9xeGRxc3ZmNkQ5VDJ0Vlk0ckIrcS9NSU1Qc3NIS2QybmZ2Q1pITkpvMGhp?=
 =?utf-8?B?cDFzVlRzT2ZOektiQU1ZY3ZQR0FDR0dhVTY3VEwwRWRMaXpJVVJxRXB1K1J0?=
 =?utf-8?B?Z0FqNjhCV0NMYVBFRUUvNzlLMFMrdVNTb2oyNW1LQnVzYzVqNndDM3VlV2tx?=
 =?utf-8?B?OStRbDhWTEsvSkFDTjhTRXJRMW5sUitIY0ZXRDVOZUhZWWFwWE1QamVKT3B0?=
 =?utf-8?B?eU01cTZjdXV2Mnhhd2tjNVQyZVpUN2x5bFpRcFYxMFA3bnNmWFUwYUZUTzMr?=
 =?utf-8?B?MXBqeXRYTlE2c3ltalp3eEduRVNXS082dHhpSkN5dWhVWGwrWXprc3crWmlH?=
 =?utf-8?B?UzBkMzE2YTl0aFBja1pYa2pvL3VMWGNzVzV2Q21yVjNIWGFGTVhqMllqRFBQ?=
 =?utf-8?B?enJ2UUxTY21KSWY4V0VYclN2WE1VbFdiNGdxTHZVMTl4ekl0VkhCcjJ2aEpq?=
 =?utf-8?B?TkZMd3ZXRnNoaStYM1M0SDJ5emJEU21oRGdQdzl0SC9nVmpPRDFtc095dUVC?=
 =?utf-8?B?ZHFxOTdRUnhsdU1kRGh6bms5VFZQNTJBaGtpZzNsWnlLbGNOeXVMeXl5bFd5?=
 =?utf-8?B?eHZVU3J5ZzVzSzNJd1JvaGdVd0ZnNDBuUllIc1I0TXp0WHIyZ3h0cWJLckpi?=
 =?utf-8?B?S29Db2FtWjd2Z2NsYS9kZ1c3ejJXVU9RVXI4enNEby9PWm9JVmZyYlBxcFEw?=
 =?utf-8?B?R0hUUkpWMXFUalkwT1ptTHZUVmR1ZStiZHBrYitZYzNFVFB1M0RhU1lTYzl1?=
 =?utf-8?B?emZ2L2QvdkVOdkh0QTRMVnF5WWpYMmh1MkFWUkUxVDYzT200MEo2VFhwZito?=
 =?utf-8?B?OFJRRnR0VGdMbDNWdDNvby9FZURhM09OcWJiSGVSQmg5L2c2RU1zTEZkV05x?=
 =?utf-8?B?L2psS09kVEpQQWFWaEdRRVcyRU1CK1JiNHRZWUU0K1dwcXFsdFF1ZW10Zjhh?=
 =?utf-8?B?Tndnb094TDZGWTFEZ0RLdXZuOTFKa3Y4NXdGMnNBMU5MU2hsbVcvVHRRVjFD?=
 =?utf-8?B?dXQzYnpDc3UvOE1jWTg4L2wwN1E5VXllcjErVnJ2ak9xRmthdFNpL0NaNTRU?=
 =?utf-8?B?WTJwdy90aGszWGlxQStlRFlIak80ZFVySXRmUG16cUxCWXNkNlBKdlY5SFF6?=
 =?utf-8?Q?tAbwIlL0YL/Fa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZOLzhacnlialFlR0FJSGJRNHBXYWxIeW54NGprRVViRVp2dkFxM3VpQzRP?=
 =?utf-8?B?eEk0RzVxbUJOY0ZBWWlHaEk3c0dnaUN3K1RNRk16TzhmcXppR1gwQmxxcGRG?=
 =?utf-8?B?S21aRVBHclYyZ2VrRmtnWXZnU2lGRmpNeko3ZDBRYlovSXMwNlcrNHpHV1Mw?=
 =?utf-8?B?MWFndExvUm9yd052UGhvWXIzMXh3bndETTEyMDFCNVgwNDJkT3NEVmVzREdO?=
 =?utf-8?B?TURjYWZjcG5uNXN4MXI4U2ZXdlJ5dFY1TGJIcnJRS3pSdXpLaWk0NFJQOCs1?=
 =?utf-8?B?Yld5cFlPSWZ5TlhFcDd0RFgwUm5XN1VOWXhJajhrOVFJYTF6TEVaajYzMUp2?=
 =?utf-8?B?czJqcy9CU1VqWmk4KzlsamQyVzF3ZEVBc3hZZHBpbXkwYjdUNGtIZ2ZrdTFw?=
 =?utf-8?B?SmdpRk5SSm1jYzQ2allNSXZMVkNEQUpyM3ZPSzA5aVJ2RGtlWE9IUFAzaktJ?=
 =?utf-8?B?bjVjam1yQW9Jb0VpOTFpeXk5MlVNdktjL0xYY0xHOUdnVTNJUG41M2htS2pY?=
 =?utf-8?B?WkdwdzRKZ3V5VjJwYUx5TUNkcjJBdWk4QURJVlZLTFJQOXlUaC9JeFUvR3lZ?=
 =?utf-8?B?M2puMFoyMXVLZkhGa1FzU2o1NUJyWVNDWU9CRTVOTlZHdEQrNFZDSVNFMkF6?=
 =?utf-8?B?ejZGR0xNeVNsTUNsTWxGR2tqSDRQdlhVSW5ReWdrdFEwODYzaUwvYzZndGlI?=
 =?utf-8?B?QzV3M0JMMU05NVNHVUxzRzZLQTZIaDV6clNNK0VUUjV0Y0o2YzRPVjA5NUJs?=
 =?utf-8?B?ZXZRSGplU2lHNHV5Nm1JSXZWVkNZaGlvT1VZbTRHYVJGUjczN1ZKdjRPVURW?=
 =?utf-8?B?cFpielBDajgwdTdlSDNtdm9NU0FBYUlTWFRWTUp5bEsydHJYWWtWZnFhTFFU?=
 =?utf-8?B?d0FQNEVNc1VYUTg2MTlPL3BuNnlPZ0xmQmpwSSt2aWZJb0l3YkFsakRQckNk?=
 =?utf-8?B?c3lrcllJbFFzRVg1QkZEaGY2NzNvUzlOMDhXNytZZXNHRXozN2FVS1h5RjFG?=
 =?utf-8?B?eXF4b2IvZU9HQ2hQZVFpelNEQytnVU92NWd4MndCZ29WampkOTBlUFFFTzJ0?=
 =?utf-8?B?YlhsTnFxMTIxakQzcE0wTU00aUFxcGRHUk02aVp2eHF0aVZsRnRicS9kdmsy?=
 =?utf-8?B?S0ZsdEhFdlp6dGlQeWRzLzk5UDRiYkNadmdYMVRrWDdVaEZCdHVqMzVPb0dH?=
 =?utf-8?B?aGZvWjZPdmFJT0FTaHEwTzk2aFJ2L3IyQ3JmT1F2S0UrVXZQY2RaWGxJVC9p?=
 =?utf-8?B?cjBlN281cWtTcUZucXRGMTA3M3NKYkQ1M1Nnd0xKZkNyTnVuazdZalNBS3dl?=
 =?utf-8?B?UEQwczlZRGljRHBuL1RadUlrMzV1d3ljWVlyT3hjYldhQUlrSGl3N0V4QkM5?=
 =?utf-8?B?Y21ZL2R0WWNPTE0vOVBtZXllaXp3YnlPK1dQUEpBRDRjN05Mcm5GRHZvZ25i?=
 =?utf-8?B?aXZCVkpHWEtRZ2tacFZLQ21MTDByNmVyUE5OR3NUMVlwOG5mWCttV3MwdDJJ?=
 =?utf-8?B?YlBWTHJUWGQxZXNSdkhSLys0aTBJZS9jY0ZoOHFJYXVaZUdkSlFQNVo5eEMv?=
 =?utf-8?B?OE9XNjk1UEdzcC9CcE9xUWdhNjRUZzhhM09JcG92aFRGOExLNzIyUm5uNWFh?=
 =?utf-8?B?U0VrRTBlY0x2UWJ4UXNvYUZUK1FweWRONzFUYkgvRUVlcUQwcFVnTmloMkpp?=
 =?utf-8?B?WStZa2tab3BzcEVDK3ExcHI4UElhcnhqSko0ZlRBVWgwbHpDZE5mOXFUS2xD?=
 =?utf-8?B?aDBIMy9kY3FVbk9USFNPUWFHTytmVHVVWjFScmRDem5xNmpMejFnYjBSRW5N?=
 =?utf-8?B?VWdpTUxTcXJ5dHlNTlR1QTUzeVFuU2JuekN1aUN4dFhPczR3L0dEUkJCY3lD?=
 =?utf-8?B?TENyM2JTQytCU0pmRW5Xams1V2RqNnVLL1JWbFF5b00rNzN4V2RSWmZDZm1W?=
 =?utf-8?B?SUJFTlkzQWx6TlhQY1BGdHdrVi9rWVpZMlgwRzVWbHdrZmJNVEJwN3ZrR2tn?=
 =?utf-8?B?Qm9FMzAwZHc4eFNGQTAvcUtVdFJwODIrT3d1eFAzd3d1RjR3YjNuRXFuOUtL?=
 =?utf-8?B?WnNEOWtHZWQ1ZWRSS1RoMzBuSHhSYjZVU0RpM0MzZDIyeURDQ2kzM3lFR2U4?=
 =?utf-8?Q?hMv/o/Xe1Q2/D4EulPZjoHH3P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e323b1-6bb6-487c-ac4b-08dd575110f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:06:24.7320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMfTWx4/CuSF2L3bpk58hXEkx0Rdn4368wEy5+yjHIxZCfHWa9Xs8OTIEhTIN5RYUR50+eS/U+TOBUC4+g3WdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
Received-SPF: permerror client-ip=40.107.102.74;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/27/2025 3:29 PM, Roy Hopkins wrote:
> When an SEV guest is started, the reset vector and state are
> extracted from metadata that is contained in the firmware volume.
> 
> In preparation for using IGVM to setup the initial CPU state,
> the code has been refactored to populate vmcb_save_area for each
> CPU which is then applied during guest startup and CPU reset.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   target/i386/sev.c | 323 +++++++++++++++++++++++++++++++++++++++++-----
>   target/i386/sev.h | 110 ++++++++++++++++
>   2 files changed, 400 insertions(+), 33 deletions(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 7d91985f41..1d1e36e3de 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -49,6 +49,12 @@ OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
>   /* hard code sha256 digest size */
>   #define HASH_SIZE 32
>   
> +/* Convert between SEV-ES VMSA and SegmentCache flags/attributes */
> +#define FLAGS_VMSA_TO_SEGCACHE(flags) \
> +    ((((flags) & 0xff00) << 12) | (((flags) & 0xff) << 8))
> +#define FLAGS_SEGCACHE_TO_VMSA(flags) \
> +    ((((flags) & 0xff00) >> 8) | (((flags) & 0xf00000) >> 12))
> +
>   typedef struct QEMU_PACKED SevHashTableEntry {
>       QemuUUID guid;
>       uint16_t len;
> @@ -88,6 +94,14 @@ typedef struct QEMU_PACKED SevHashTableDescriptor {
>       uint32_t size;
>   } SevHashTableDescriptor;
>   
> +typedef struct SevLaunchVmsa {
> +    QTAILQ_ENTRY(SevLaunchVmsa) next;
> +
> +    uint16_t cpu_index;
> +    uint64_t gpa;
> +    struct sev_es_save_area vmsa;
> +} SevLaunchVmsa;
> +
>   struct SevCommonState {
>       X86ConfidentialGuest parent_obj;
>   
> @@ -106,9 +120,7 @@ struct SevCommonState {
>       int sev_fd;
>       SevState state;
>   
> -    uint32_t reset_cs;
> -    uint32_t reset_ip;
> -    bool reset_data_valid;
> +    QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
>   };
>   
>   struct SevCommonStateClass {
> @@ -371,6 +383,172 @@ static struct RAMBlockNotifier sev_ram_notifier = {
>       .ram_block_removed = sev_ram_block_removed,
>   };
>   
> +static void sev_apply_cpu_context(CPUState *cpu)
> +{
> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    X86CPU *x86;
> +    CPUX86State *env;
> +    struct SevLaunchVmsa *launch_vmsa;
> +
> +    /* See if an initial VMSA has been provided for this CPU */
> +    QTAILQ_FOREACH(launch_vmsa, &sev_common->launch_vmsa, next)
> +    {
> +        if (cpu->cpu_index == launch_vmsa->cpu_index) {
> +            x86 = X86_CPU(cpu);
> +            env = &x86->env;
> +
> +            /*
> +             * Ideally we would provide the VMSA directly to kvm which would
> +             * ensure that the resulting initial VMSA measurement which is
> +             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated from
> +             * exactly what we provide here. Currently this is not possible so
> +             * we need to copy the parts of the VMSA structure that we currently
> +             * support into the CPU state.
> +             */
> +            cpu_load_efer(env, launch_vmsa->vmsa.efer);
> +            cpu_x86_update_cr4(env, launch_vmsa->vmsa.cr4);
> +            cpu_x86_update_cr0(env, launch_vmsa->vmsa.cr0);
> +            cpu_x86_update_cr3(env, launch_vmsa->vmsa.cr3);
> +            env->xcr0 = launch_vmsa->vmsa.xcr0;
> +            env->pat = launch_vmsa->vmsa.g_pat;
> +
> +            cpu_x86_load_seg_cache(
> +                env, R_CS, launch_vmsa->vmsa.cs.selector,
> +                launch_vmsa->vmsa.cs.base, launch_vmsa->vmsa.cs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.cs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_DS, launch_vmsa->vmsa.ds.selector,
> +                launch_vmsa->vmsa.ds.base, launch_vmsa->vmsa.ds.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ds.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_ES, launch_vmsa->vmsa.es.selector,
> +                launch_vmsa->vmsa.es.base, launch_vmsa->vmsa.es.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.es.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_FS, launch_vmsa->vmsa.fs.selector,
> +                launch_vmsa->vmsa.fs.base, launch_vmsa->vmsa.fs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.fs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_GS, launch_vmsa->vmsa.gs.selector,
> +                launch_vmsa->vmsa.gs.base, launch_vmsa->vmsa.gs.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gs.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_SS, launch_vmsa->vmsa.ss.selector,
> +                launch_vmsa->vmsa.ss.base, launch_vmsa->vmsa.ss.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ss.attrib));
> +
> +            env->gdt.base = launch_vmsa->vmsa.gdtr.base;
> +            env->gdt.limit = launch_vmsa->vmsa.gdtr.limit;
> +            env->gdt.flags =
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.gdtr.attrib);
> +            env->idt.base = launch_vmsa->vmsa.idtr.base;
> +            env->idt.limit = launch_vmsa->vmsa.idtr.limit;
> +            env->idt.flags =
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.idtr.attrib);
> +
> +            cpu_x86_load_seg_cache(
> +                env, R_LDTR, launch_vmsa->vmsa.ldtr.selector,
> +                launch_vmsa->vmsa.ldtr.base, launch_vmsa->vmsa.ldtr.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.ldtr.attrib));
> +            cpu_x86_load_seg_cache(
> +                env, R_TR, launch_vmsa->vmsa.tr.selector,
> +                launch_vmsa->vmsa.ldtr.base, launch_vmsa->vmsa.tr.limit,
> +                FLAGS_VMSA_TO_SEGCACHE(launch_vmsa->vmsa.tr.attrib));
> +
> +            env->dr[6] = launch_vmsa->vmsa.dr6;
> +            env->dr[7] = launch_vmsa->vmsa.dr7;
> +
> +            env->regs[R_EAX] = launch_vmsa->vmsa.rax;
> +            env->regs[R_ECX] = launch_vmsa->vmsa.rcx;
> +            env->regs[R_EDX] = launch_vmsa->vmsa.rdx;
> +            env->regs[R_EBX] = launch_vmsa->vmsa.rbx;
> +            env->regs[R_ESP] = launch_vmsa->vmsa.rsp;
> +            env->regs[R_EBP] = launch_vmsa->vmsa.rbp;
> +            env->regs[R_ESI] = launch_vmsa->vmsa.rsi;
> +            env->regs[R_EDI] = launch_vmsa->vmsa.rdi;
> +#ifdef TARGET_X86_64
> +            env->regs[R_R8] = launch_vmsa->vmsa.r8;
> +            env->regs[R_R9] = launch_vmsa->vmsa.r9;
> +            env->regs[R_R10] = launch_vmsa->vmsa.r10;
> +            env->regs[R_R11] = launch_vmsa->vmsa.r11;
> +            env->regs[R_R12] = launch_vmsa->vmsa.r12;
> +            env->regs[R_R13] = launch_vmsa->vmsa.r13;
> +            env->regs[R_R14] = launch_vmsa->vmsa.r14;
> +            env->regs[R_R15] = launch_vmsa->vmsa.r15;
> +#endif
> +            env->eip = launch_vmsa->vmsa.rip;
> +            env->eflags = launch_vmsa->vmsa.rflags;
> +
> +            cpu_set_fpuc(env, launch_vmsa->vmsa.x87_fcw);
> +            env->mxcsr = launch_vmsa->vmsa.mxcsr;
> +
> +            break;
> +        }
> +    }
> +}
> +
> +static int sev_set_cpu_context(uint16_t cpu_index, const void *ctx,
> +                               uint32_t ctx_len, hwaddr gpa, Error **errp)
> +{
> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    SevLaunchVmsa *launch_vmsa;
> +    CPUState *cpu;
> +    bool exists = false;
> +
> +    /*
> +     * Setting the CPU context is only supported for SEV-ES and SEV-SNP. The
> +     * context buffer will contain a sev_es_save_area from the Linux kernel
> +     * which is defined by "Table B-4. VMSA Layout, State Save Area for SEV-ES"
> +     * in the AMD64 APM, Volume 2.
> +     */
> +
> +    if (!sev_es_enabled()) {
> +        error_setg(errp, "SEV: unable to set CPU context: Not supported");
> +        return -1;
> +    }
> +
> +    if (ctx_len < sizeof(struct sev_es_save_area)) {
> +        error_setg(errp, "SEV: unable to set CPU context: "
> +                     "Invalid context provided");
> +        return -1;
> +    }
> +
> +    cpu = qemu_get_cpu(cpu_index);
> +    if (!cpu) {
> +        error_setg(errp, "SEV: unable to set CPU context for out of bounds "
> +                     "CPU index %d", cpu_index);
> +        return -1;
> +    }
> +
> +    /*
> +     * If the context of this VP has already been set then replace it with the
> +     * new context.
> +     */
> +    QTAILQ_FOREACH(launch_vmsa, &sev_common->launch_vmsa, next)
> +    {
> +        if (cpu_index == launch_vmsa->cpu_index) {
> +            launch_vmsa->gpa = gpa;
> +            memcpy(&launch_vmsa->vmsa, ctx, sizeof(launch_vmsa->vmsa));
> +            exists = true;
> +            break;
> +        }
> +    }
> +
> +    if (!exists) {
> +        /* New VP context */
> +        launch_vmsa = g_new0(SevLaunchVmsa, 1);
> +        memcpy(&launch_vmsa->vmsa, ctx, sizeof(launch_vmsa->vmsa));
> +        launch_vmsa->cpu_index = cpu_index;
> +        launch_vmsa->gpa = gpa;
> +        QTAILQ_INSERT_TAIL(&sev_common->launch_vmsa, launch_vmsa, next);
> +    }
> +
> +    /* Synchronise the VMSA with the current CPU state */
> +    sev_apply_cpu_context(cpu);
> +
> +    return 0;
> +}
> +
>   bool
>   sev_enabled(void)
>   {
> @@ -1005,6 +1183,16 @@ static int
>   sev_launch_update_vmsa(SevGuestState *sev_guest)
>   {
>       int ret, fw_error;
> +    CPUState *cpu;
> +
> +    /*
> +     * The initial CPU state is measured as part of KVM_SEV_LAUNCH_UPDATE_VMSA.
> +     * Synchronise the CPU state to any provided launch VMSA structures.
> +     */
> +    CPU_FOREACH(cpu) {
> +        sev_apply_cpu_context(cpu);
> +    }
> +
>   
>       ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA,
>                       NULL, &fw_error);
> @@ -1787,40 +1975,110 @@ sev_es_find_reset_vector(void *flash_ptr, uint64_t flash_size,
>       return sev_es_parse_reset_block(info, addr);
>   }
>   
> -void sev_es_set_reset_vector(CPUState *cpu)
> +
> +static void seg_to_vmsa(const SegmentCache *cpu_seg, struct vmcb_seg *vmsa_seg)
>   {
> -    X86CPU *x86;
> -    CPUX86State *env;
> -    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
> -    SevCommonState *sev_common = SEV_COMMON(
> -        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
> +    vmsa_seg->selector = cpu_seg->selector;
> +    vmsa_seg->base = cpu_seg->base;
> +    vmsa_seg->limit = cpu_seg->limit;
> +    vmsa_seg->attrib = FLAGS_SEGCACHE_TO_VMSA(cpu_seg->flags);
> +}
>   
> -    /* Only update if we have valid reset information */
> -    if (!sev_common || !sev_common->reset_data_valid) {
> -        return;
> -    }
> +static void initialize_vmsa(const CPUState *cpu, struct sev_es_save_area *vmsa)
> +{
> +    const X86CPU *x86 = X86_CPU(cpu);
> +    const CPUX86State *env = &x86->env;
>   
> -    /* Do not update the BSP reset state */
> -    if (cpu->cpu_index == 0) {
> -        return;
> +    /*
> +     * Initialize the SEV-ES save area from the current state of
> +     * the CPU. The entire state does not need to be copied, only the state
> +     * that is copied back to the CPUState in sev_apply_cpu_context.
> +     */
> +    memset(vmsa, 0, sizeof(struct sev_es_save_area));
> +    vmsa->efer = env->efer;
> +    vmsa->cr0 = env->cr[0];
> +    vmsa->cr3 = env->cr[3];
> +    vmsa->cr4 = env->cr[4];
> +    vmsa->xcr0 = env->xcr0;
> +    vmsa->g_pat = env->pat;
> +
> +    seg_to_vmsa(&env->segs[R_CS], &vmsa->cs);
> +    seg_to_vmsa(&env->segs[R_DS], &vmsa->ds);
> +    seg_to_vmsa(&env->segs[R_ES], &vmsa->es);
> +    seg_to_vmsa(&env->segs[R_FS], &vmsa->fs);
> +    seg_to_vmsa(&env->segs[R_GS], &vmsa->gs);
> +    seg_to_vmsa(&env->segs[R_SS], &vmsa->ss);
> +
> +    seg_to_vmsa(&env->gdt, &vmsa->gdtr);
> +    seg_to_vmsa(&env->idt, &vmsa->idtr);
> +    seg_to_vmsa(&env->ldt, &vmsa->ldtr);
> +    seg_to_vmsa(&env->tr, &vmsa->tr);
> +
> +    vmsa->dr6 = env->dr[6];
> +    vmsa->dr7 = env->dr[7];
> +
> +    vmsa->rax = env->regs[R_EAX];
> +    vmsa->rcx = env->regs[R_ECX];
> +    vmsa->rdx = env->regs[R_EDX];
> +    vmsa->rbx = env->regs[R_EBX];
> +    vmsa->rsp = env->regs[R_ESP];
> +    vmsa->rbp = env->regs[R_EBP];
> +    vmsa->rsi = env->regs[R_ESI];
> +    vmsa->rdi = env->regs[R_EDI];
> +
> +#ifdef TARGET_X86_64
> +    vmsa->r8 = env->regs[R_R8];
> +    vmsa->r9 = env->regs[R_R9];
> +    vmsa->r10 = env->regs[R_R10];
> +    vmsa->r11 = env->regs[R_R11];
> +    vmsa->r12 = env->regs[R_R12];
> +    vmsa->r13 = env->regs[R_R13];
> +    vmsa->r14 = env->regs[R_R14];
> +    vmsa->r15 = env->regs[R_R15];
> +#endif
> +
> +    vmsa->rip = env->eip;
> +    vmsa->rflags = env->eflags;
> +}
> +
> +static void sev_es_set_ap_context(uint32_t reset_addr)
> +{
> +    CPUState *cpu;
> +    struct sev_es_save_area vmsa;
> +    SegmentCache cs;
> +
> +    cs.selector = 0xf000;
> +    cs.base = reset_addr & 0xffff0000;
> +    cs.limit = 0xffff;
> +    cs.flags = DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK | DESC_R_MASK |
> +               DESC_A_MASK;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->cpu_index == 0) {
> +            /* Do not update the BSP reset state */
> +            continue;
> +        }
> +        initialize_vmsa(cpu, &vmsa);
> +        seg_to_vmsa(&cs, &vmsa.cs);
> +        vmsa.rip = reset_addr & 0x0000ffff;
> +        sev_set_cpu_context(cpu->cpu_index, &vmsa,
> +                            sizeof(struct sev_es_save_area),
> +                            0, &error_fatal);
> +        sev_apply_cpu_context(cpu);
>       }
> +}
>   
> -    x86 = X86_CPU(cpu);
> -    env = &x86->env;
> -
> -    cpu_x86_load_seg_cache(env, R_CS, 0xf000, sev_common->reset_cs, 0xffff,
> -                           DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
> -                           DESC_R_MASK | DESC_A_MASK);
> -
> -    env->eip = sev_common->reset_ip;
> +void sev_es_set_reset_vector(CPUState *cpu)
> +{
> +    if (sev_enabled()) {
> +        sev_apply_cpu_context(cpu);
> +    }
>   }
>   
>   int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
>   {
> -    CPUState *cpu;
>       uint32_t addr;
>       int ret;
> -    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>   
>       if (!sev_es_enabled()) {
>           return 0;
> @@ -1833,14 +2091,12 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
>           return ret;
>       }
>   
> +    /*
> +     * The reset vector is saved into a CPU context for each AP but not for
> +     * the BSP. This is applied during guest startup or when the CPU is reset.
> +     */
>       if (addr) {
> -        sev_common->reset_cs = addr & 0xffff0000;
> -        sev_common->reset_ip = addr & 0x0000ffff;
> -        sev_common->reset_data_valid = true;
> -
> -        CPU_FOREACH(cpu) {
> -            sev_es_set_reset_vector(cpu);
> -        }
> +        sev_es_set_ap_context(addr);
>       }
>   
>       return 0;
> @@ -2075,6 +2331,7 @@ sev_common_instance_init(Object *obj)
>       object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>                                      &sev_common->reduced_phys_bits,
>                                      OBJ_PROP_FLAG_READWRITE);
> +    QTAILQ_INIT(&sev_common->launch_vmsa);
>   }
>   
>   /* sev guest info common to sev/sev-es/sev-snp */
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 373669eaac..38caa849f5 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -55,6 +55,116 @@ typedef struct SevKernelLoaderContext {
>       size_t cmdline_size;
>   } SevKernelLoaderContext;
>   
> +/* Save area definition for SEV-ES and SEV-SNP guests */
> +struct QEMU_PACKED sev_es_save_area {
> +    struct vmcb_seg es;
> +    struct vmcb_seg cs;
> +    struct vmcb_seg ss;
> +    struct vmcb_seg ds;
> +    struct vmcb_seg fs;
> +    struct vmcb_seg gs;
> +    struct vmcb_seg gdtr;
> +    struct vmcb_seg ldtr;
> +    struct vmcb_seg idtr;
> +    struct vmcb_seg tr;
> +    uint64_t vmpl0_ssp;
> +    uint64_t vmpl1_ssp;
> +    uint64_t vmpl2_ssp;
> +    uint64_t vmpl3_ssp;
> +    uint64_t u_cet;
> +    uint8_t reserved_0xc8[2];
> +    uint8_t vmpl;
> +    uint8_t cpl;
> +    uint8_t reserved_0xcc[4];
> +    uint64_t efer;
> +    uint8_t reserved_0xd8[104];
> +    uint64_t xss;
> +    uint64_t cr4;
> +    uint64_t cr3;
> +    uint64_t cr0;
> +    uint64_t dr7;
> +    uint64_t dr6;
> +    uint64_t rflags;
> +    uint64_t rip;
> +    uint64_t dr0;
> +    uint64_t dr1;
> +    uint64_t dr2;
> +    uint64_t dr3;
> +    uint64_t dr0_addr_mask;
> +    uint64_t dr1_addr_mask;
> +    uint64_t dr2_addr_mask;
> +    uint64_t dr3_addr_mask;
> +    uint8_t reserved_0x1c0[24];
> +    uint64_t rsp;
> +    uint64_t s_cet;
> +    uint64_t ssp;
> +    uint64_t isst_addr;
> +    uint64_t rax;
> +    uint64_t star;
> +    uint64_t lstar;
> +    uint64_t cstar;
> +    uint64_t sfmask;
> +    uint64_t kernel_gs_base;
> +    uint64_t sysenter_cs;
> +    uint64_t sysenter_esp;
> +    uint64_t sysenter_eip;
> +    uint64_t cr2;
> +    uint8_t reserved_0x248[32];
> +    uint64_t g_pat;
> +    uint64_t dbgctl;
> +    uint64_t br_from;
> +    uint64_t br_to;
> +    uint64_t last_excp_from;
> +    uint64_t last_excp_to;
> +    uint8_t reserved_0x298[80];
> +    uint32_t pkru;
> +    uint32_t tsc_aux;
> +    uint8_t reserved_0x2f0[24];
> +    uint64_t rcx;
> +    uint64_t rdx;
> +    uint64_t rbx;
> +    uint64_t reserved_0x320; /* rsp already available at 0x01d8 */
> +    uint64_t rbp;
> +    uint64_t rsi;
> +    uint64_t rdi;
> +    uint64_t r8;
> +    uint64_t r9;
> +    uint64_t r10;
> +    uint64_t r11;
> +    uint64_t r12;
> +    uint64_t r13;
> +    uint64_t r14;
> +    uint64_t r15;
> +    uint8_t reserved_0x380[16];
> +    uint64_t guest_exit_info_1;
> +    uint64_t guest_exit_info_2;
> +    uint64_t guest_exit_int_info;
> +    uint64_t guest_nrip;
> +    uint64_t sev_features;
> +    uint64_t vintr_ctrl;
> +    uint64_t guest_exit_code;
> +    uint64_t virtual_tom;
> +    uint64_t tlb_id;
> +    uint64_t pcpu_id;
> +    uint64_t event_inj;
> +    uint64_t xcr0;
> +    uint8_t reserved_0x3f0[16];
> +
> +    /* Floating point area */
> +    uint64_t x87_dp;
> +    uint32_t mxcsr;
> +    uint16_t x87_ftw;
> +    uint16_t x87_fsw;
> +    uint16_t x87_fcw;
> +    uint16_t x87_fop;
> +    uint16_t x87_ds;
> +    uint16_t x87_cs;
> +    uint64_t x87_rip;
> +    uint8_t fpreg_x87[80];
> +    uint8_t fpreg_xmm[256];
> +    uint8_t fpreg_ymm[256];
> +};
> +
>   bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
>   
>   int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);


