Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69737CFA47B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLrL-00049L-B9; Fri, 21 Nov 2025 02:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMLrI-00046I-Lf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:47:08 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMLrG-0006Xf-3G
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:47:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWmT/37OsfDZY0XtfVnCgOZkNeJxUkLAqcdB8uz6NZXceSf/Q16kTX2OOsgwe1o5089vZkbb2kuEbwnzUCPU29PRtWzEDlsjzAzHtB0fFWzwcMIcpoH8SoL3GK1oBqdma9eLqIS6sqpAeSICHvtf+HJe6oasbM+hOVH98uKmE/FKWbJ+/sktBsN5t6raff45NAxBJHKGjzbMbGvV2M8B/RgZgj6VqwidNPiCh5pb3iJ6GXB8RmriFHi1sLb40mgYtFkUtyr8hKj93DKeI3z1zRVMbQ6E62Jw2AK7Dt/vD/pVqEhQaZMwL83P8GWN7Kke/sjX/jFJ9MgrMhBW6+/OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsbNnKjTlHQr27WE72uu4bAY8Vq8xtyRB3oHjEyfZk4=;
 b=qHBkjpCP0Scx1+Ha97TApGpGNnfIA7dHANA7/d/9hCCIfys+b/pNSm7Wyj5hSep9WLBN+1/c8v+mCAtq07Qc4Y696uiS7cEtxvRmOh058qC/C3NMOgWUvXJm7tWi5KWwhWCSdGZZcSu/0qXnlIv0onpM/h5b1Hqv0Xa01u4vWvPDYqUM0Ip3kXm9OEapg+rXhILtH2APl3gydOObxrK3i+DX+TIr99abGHkRI5tX4lRYm0HDzcXXkdsaTW7Chhm3hWj5Tl6GonzRfMCkz1jRU5mOdfI9kX4DV3knQPwpKD+gube3PsaLR3z2z3X+Kj5QZEQs3EO3FXt9pCK7BwwdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsbNnKjTlHQr27WE72uu4bAY8Vq8xtyRB3oHjEyfZk4=;
 b=xSTjTEZ9BzuF2JrIgJZyhkCTAXEg8kRIW1xC47pxJrDOrEF9KSPmZyirNgJvHKUHvz4vioPzX6OkfHfY3bakOZ1a+gevyF61mvHOtRklcPvAWTXp17wcC7x6Uybtk1IPtlHbgF2JWtjQfFCeP8X09sRwgPTb+cvIifnpAF5Y0AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 07:47:00 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 07:47:00 +0000
Message-ID: <35a8add7-da49-4833-9e69-d213f52c771a@amd.com>
Date: Fri, 21 Nov 2025 15:46:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
 <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
 <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
 <21b94d50-79c4-4942-84f7-f4c96f432dd8@rsg.ci.i.u-tokyo.ac.jp>
 <dd14c464-bd74-4d0d-9578-e28367319475@amd.com>
 <9b48903e-09eb-453a-aa8f-903fca99cb7d@rsg.ci.i.u-tokyo.ac.jp>
 <f95196fe-27c8-4eef-8b64-b1ede138425d@amd.com>
 <24853a9b-9f75-4e69-a9e8-5ff796d6cc9f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <24853a9b-9f75-4e69-a9e8-5ff796d6cc9f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dced76-8c99-4dc0-6f82-08de28d2273b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE91eWN5bXBPYzdMRmtGdzNKU0J4Q3g1eDMxbGMwSkdBQVppQzd0RHpZVTBY?=
 =?utf-8?B?MlVDYkkxemRtMnJQQVpna05FRmxWMDVqcTgvTThOSFhGLzM3Y3YvNWszZ3VP?=
 =?utf-8?B?MTAwOTRyd0ZwdHcvWWdiUlBscE1xL2J4UkVXUEx0OHgzN2R5ZGsyODRMZlFw?=
 =?utf-8?B?b0tZazRNK2FpV1JpcE9lMzdyTzQvaDVOR0w4aWtsZWp4VU9qZFFNdE9JNHBQ?=
 =?utf-8?B?YW9nVWtUb3loaitlVTlUcjNOVzFzbnYwNG1XVUlVYnQyL25rZVVLRmNCeS9z?=
 =?utf-8?B?S3VmeFh6VHRuWFlJaWwvTFFib2pjSFR2SFNSNW1ISTdCbDRHNUFKdkttSTVO?=
 =?utf-8?B?NzNjT280U20xSEd3Ny84QWt6ZXVabkFLL21KUGE4dXMyQklhWHBUYWJDc1Bh?=
 =?utf-8?B?OE81V0o2bWFPRlhLbWFhcjN1NTZ0V1p0SEJ6Vjg5dG5SOUxIQnZyYTZVOFBQ?=
 =?utf-8?B?czhhemJNYUU3ZUREeUtXWkpsdjd4eHIzRlpmNU9TQW14cnNtQUp3NUVCcmlm?=
 =?utf-8?B?S0RraVFjbGIyYjVPeG1Zc3Vlbm5sR0FlQjZEVW5MWTA0OHZ1UGt5S2tGdGZF?=
 =?utf-8?B?MEo2SXhiRUxyWTI2ZXN2TXY2WHZ4WUY3ZHJxb1N5cHNZLzZURTExby9GUnJ6?=
 =?utf-8?B?YVA4RkhzS2FSWnMzQ1dsdXo5ZThndmFjeW10aElRNys0cWo1KzJXNkpCeU92?=
 =?utf-8?B?UmNJSkd1LzN6bElUdVJiQjhySnloYWdEeDJxMjVmNnRIMUVxUm5uNG9WeCt4?=
 =?utf-8?B?M1BXbEtYSjVqTzBaZmpqZ2hBZzU4RnNOY2VpZG9qdk0wdFdlWFM3Q1BxVDl4?=
 =?utf-8?B?S0dmVC9RaDZlZXk1VlhGYTVkQkVST0RjYnAzZ0hXYmdISC9tRU9RcWxpZnhU?=
 =?utf-8?B?clkvOHVGbE1LRHVaNkszaUdMYVBSWG1uUmw2S2JxNVBRWmJxQk1RNTJXWnVY?=
 =?utf-8?B?TWtBM0ZENTdISVNVTFN1NDd6YnlWOW5yeFB4a0MySjJTeU5yYVBTZWpFV25O?=
 =?utf-8?B?VTlDWmxIQi9kK2s4Mkx6eEViVzhEeXphR3V2YUtuVlc3UUtvTVdIejhpYVN0?=
 =?utf-8?B?ZkwxKzQ1SDBiNGx3MjFkSWpYbzEwTkkyTm0xaUx3YjdNSWxvTEhhRjhPZVhl?=
 =?utf-8?B?bTBTVDR1Q1BGbVRHSzlmVUpVRXV4dFdKaUU3SE5iNUJVZm5XcEFra21lVDdi?=
 =?utf-8?B?bUVXV1RySm9ZWVFGRGl5MS9NdnBqYjkzcEFXaVdDSTF5ZUExRFI4cXk4ZVhI?=
 =?utf-8?B?eUU3aDROdWpPM0VoSjBiU3BwRmwvT3hCaXo0bkFtM1NoajJkZHhIWkxDcC9I?=
 =?utf-8?B?dmVTTUxYT0h4eEp1Z0t4eVBXa2V4R2J2ZlFmZFBRN1c4NEk4VXZua1kwTXNE?=
 =?utf-8?B?K0sxUW14N0VyaXpkVDZTTEVvOVczcGJkZElFMkhtUUpoNG9vNElMNmk0TUt1?=
 =?utf-8?B?MEg0S1JRRXhMTnNTZVd6TTRWS1dlTGVxUldPTS9QcEtnN2ZWV09ZaUxkcE94?=
 =?utf-8?B?RUtuMGcyUkpkY01Cbmh5UEU2MWpXbVNXeEFFTjJrZFRBbFlKaDB3bkppU3Ns?=
 =?utf-8?B?ekFxeVpERlF6cEE0cFBMaUcyWFhkbHIrbHFwYWJMZTVEbWhKTkdiVkE1WkV4?=
 =?utf-8?B?T1NGMTZlTXNIMDU1bWVMak1yVjMrb1FzMDRmVjNCT3VDcU4xY2txVDRjM3pv?=
 =?utf-8?B?VDJNL3pCZlhyd2NhRjJNU3BJOVVIaHB3OHUvVjJJK0UycTJVNWl3eW1BKzZh?=
 =?utf-8?B?M2pUVmhsZ3FtYXRUbENYcFQ5MjQyRnk3YU5TMmJPZlJmRjFvUndYZUQ2cTR0?=
 =?utf-8?B?N0U3aWRiK0ZLVEdMRlVaaTFsRmxxVmUwMnFhWHo4c0tEeUwwSms2c3ZlUEpT?=
 =?utf-8?B?WU5tQVJtclNkV1hIeVB3SDZnN3RHMmJCQUM5aVorQjNId3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxRSUpYbzBEdEs1Q1B5aStnWGNocmJqcSt1NjJ0Z3FYdWNWMW9ydmcxKzVU?=
 =?utf-8?B?L2hMSnBsMmhmbVpFV3hVd1hhTnFTRWlZaE1IdG9TMkh1Uk5tSHN2SHpadWV0?=
 =?utf-8?B?N1RTbElTWDhsdm9NWjNzcE5rTHpWd0ZVZHB1RVFkUWFvU3NoRjRub3dhZkow?=
 =?utf-8?B?b0NVWjZTVFBOTjNaVWd1NTZEY21tM1Z4Q2p1WWlEa0ZQS01SckZHcElDNCtv?=
 =?utf-8?B?K0pMdTRKRUFmNms3Y2x4dEF1ZWZFTVJ3NG1OQWZvQ2FpN0M3b1hxQjJ6SXJS?=
 =?utf-8?B?M3QrYS9IeWZHODFiYm0rMVY2RzlaQzVVSEZoeEk4dzlrM2ZtNlEraHFqU295?=
 =?utf-8?B?VkpFUjhBV1VEY1R0UFU5VThuallEMlpMVDMvcE9aWlAxaFhCbkxjZ1F5d2N3?=
 =?utf-8?B?SzNXVHdZa1RIZTVqWTNKK1VtMC8vVFEreGhuZjc2bE9QYlBRVSsybkNFWkVl?=
 =?utf-8?B?eHlpUXd4OG1xM0p3enJJL2w1cEkrUWg0YTErMEpTbnpkV0lteHhLVG5aMXY5?=
 =?utf-8?B?TjBHcHN3bGVlYzI0Rm5HUmZZNGRkWnZpT2QyclVxNERaRDNmWkZWSmpvaU9M?=
 =?utf-8?B?MkRtMWxRNXZVVk81TUdKWE9maW9xclk2NVJFZVBIZkJIQ1NJWnJRR3UvckZZ?=
 =?utf-8?B?N1RxbjRManp6dXFUcmhKUHM4NytSN04yc1liTzJabjB5OG5aUjg1RHYrd3M2?=
 =?utf-8?B?d0tHaVdHN2M5enZ1R0lhbHZRNUEybzR1bm5jc1oyNnNYSktyU3hpcS9UZWhq?=
 =?utf-8?B?UnFPOGxKWWI3Z05PT1pybkxlcll5SDl4ZFAzUk5GWWV1OWR4Y1Q1TEZrNUx5?=
 =?utf-8?B?Umh1c3dIWkZkR1V3bXJKZytPb3A3a0t6N0pnaXREVXU2bHh1Ym9sWEwyZmNL?=
 =?utf-8?B?MnJrMXlRYUo2TzNLY1FPdytENUpGT28yQllwb0V3VjRkNWp2YW1RbU9OazEz?=
 =?utf-8?B?b0ViaGN3aUtIOEpQWTkwQVhMRFBpNFhLbHByMSs0TktXcE14Zlg3QVNoMXJZ?=
 =?utf-8?B?VTlab2lvSHJuVEhVVU1YZXZXWERBcndCd0o2RWNiQlNueVY4R3ZlQ05nMzEw?=
 =?utf-8?B?NndVb0Y1L0swY1g3ZVphQVJEQXJyNGI1MmZESkszM1NJc2xWblZnUVpqMWd5?=
 =?utf-8?B?UVpaREo2SXZkT20wUmkrUEpSa0Q5Z213Q25waXdlempVa3VKcnZJRFBDYncr?=
 =?utf-8?B?QWh1U0wrVmFFRGNkdnF2R0d4Qk9lRklnc1ZDK3BCR1BUY2dEbGJ4b3BBcnFr?=
 =?utf-8?B?N0NmYUduMVBQaTlMRWRrcE9VSEVFd3hNcDJISGJkMzlCNHMxR3duazNTbUo1?=
 =?utf-8?B?UFFGWGtwd0szOUpWMFJJbFZUa1YzN1J6TXJqa0FYRTNKSzFjb1dPNFVacE1I?=
 =?utf-8?B?NVpPUDZvaEMzd1NsL2VPSUIydkJnUUVZVzR2RmZqNG1HMzJjMkxvSEd6Nkpt?=
 =?utf-8?B?eXJqTkRIUDhaN1RzM2NwOEs1cTVIOHZZWHpkbkI1a2ZqNDlaZTh3ak5nUkNt?=
 =?utf-8?B?U2QyOWQzb09kK0ZSU3p4Wm1qeGZDc09FK2o4UGM0WGEvdWxnZ0hoTkRPemc3?=
 =?utf-8?B?NlkzRk00MW8xL0lSTnhVTmZrUHhWeU9RTE43YlBjNDB2MEFGZjd4Q1prVVNz?=
 =?utf-8?B?bXk5SUNuZmJLS01zVWdheFNLRnZEcC9nVTZ4OE5rS0YxNVZuRDhydGg4RlhO?=
 =?utf-8?B?d3BKTzlQQ2t1K2NTcUlVcFAxRnFWYmhRRGxFcWFGZmNRak5mYlZXOUFNZG5y?=
 =?utf-8?B?QllRVzd0Z0JaY3VFUCtRR2lwZzRxaU1pdnhmcUdJcHBTZDArRThJZzR3Qjlz?=
 =?utf-8?B?NlRISWVxUXJLbFpzVHJOdExBMWJ0VzZ5QWhpU1JlRHpzRm56bVJiQXRaZEM0?=
 =?utf-8?B?ajBEajZpWk15ZjQ3MWZXYXJmNnFSVHlKcEVicVFoSGlVNC9CckdPK1ppbFJy?=
 =?utf-8?B?ZW9OZXI0RWwzYjRyaENJTzFyWEJEd3lEK0FwbFpDbzJQbzFkRld6UVh0NVU5?=
 =?utf-8?B?Z0wyU1hYMElHeURhSjRyZ2xjUmFSYzJ1YlBxUXhUY092UDR3RVA4WS95M3du?=
 =?utf-8?B?djNRSGhiVjByT3JCTTQ4UVhuYVFKUXN6bmlpUjM2MzZ2c3NQN29sVHBlVHlj?=
 =?utf-8?Q?kqLOFZaIExWpYPwEQ7ZI0agIA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dced76-8c99-4dc0-6f82-08de28d2273b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 07:47:00.2701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DjLmgD/6azMgFmjI7QEtB+/YVeIy/D+ZBr+j+zGiGT3t357Q7H8o1mS8cPsW4JywAuxtJ1jUL5+6xGRGNZzQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 2025/11/21 15:36, Akihiko Odaki wrote:
> On 2025/11/21 15:50, Honglei Huang wrote:
>>
>>
>> On 2025/11/21 14:12, Akihiko Odaki wrote:
>>>
>>>
>>> On 2025/11/21 14:43, Honglei Huang wrote:
>>>>
>>>>
>>>> On 2025/11/21 13:28, Akihiko Odaki wrote:
>>>>> On 2025/11/21 14:21, Honglei Huang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/11/21 11:39, Akihiko Odaki wrote:
>>>>>>> On 2025/11/21 12:14, Honglei Huang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2025/11/21 10:56, Akihiko Odaki wrote:
>>>>>>>>> On 2025/11/21 11:47, Honglei Huang wrote:
>>>>>>>>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>>>>>>>>> user pointer mapping for blob resources. This allows guest 
>>>>>>>>>> applications
>>>>>>>>>> to use user-allocated memory for GPU resources more efficiently.
>>>>>>>>>>
>>>>>>>>>> Changes include:
>>>>>>>>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>>>>>>>>> - Enhance blob resource creation to handle userptr flag properly
>>>>>>>>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>>>>>>>>> - Add conditional handling for userptr vs regular blob mapping
>>>>>>>>>
>>>>>>>>> I don't see the added conditional handling.
>>>>>>>>
>>>>>>>> Sorry, the additional handing is replaced by the fixing of value 
>>>>>>>> check.
>>>>>>>> I will correct this commit message in the next version.
>>>>>>>
>>>>>>> Not just the commit message, but it also questions the utility of 
>>>>>>> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and 
>>>>>>> VIRTIO_GPU_F_RESOURCE_USERPTR. Neither of them adds a new 
>>>>>>> functionality. They should be dropped if they are also replaced 
>>>>>>> with the fix.
>>>>>>>
>>>>>>
>>>>>> Yes totally agreed, it is my mistaken, I shouldn't mix the code 
>>>>>> for fixing and the code for adding new features in one submission.
>>>>>>
>>>>>> Actually this patch set are for another components upstream test, 
>>>>>> for the sake of convenience, I have added both the fix and feature 
>>>>>> here,
>>>>>> that is a bad idea.
>>>>>>
>>>>>> Will split the fix part into previous thread.
>>>>>>
>>>>>> And for the check value fix thread, will send v4 as the final 
>>>>>> version.
>>>>>
>>>>> Splitting fixes and features is a good idea, but that's not what I 
>>>>> meant.
>>>>>
>>>>> What I pointed out is that, it seems that one of the "features" you 
>>>>> are adding, namely VIRTIO_GPU_F_RESOURCE_USERPTR does nothing at at 
>>>>> all. So I'm wondering if you forgot to add a real implementation or 
>>>>> the feature is just no longer necessary.
>>>>
>>>> Understood, actually the resource of flag 
>>>> VIRTIO_GPU_F_RESOURCE_USERPTR just reuses the feature of 
>>>> VIRTIO_GPU_BLOB_MEM_GUEST: using the virtio_gpu_create_mapping_iov 
>>>> function to map the iov from guest.
>>>>
>>>> In qemu, the handing of VIRTIO_GPU_F_RESOURCE_USERPTR and 
>>>> VIRTIO_GPU_BLOB_MEM_GUEST basically same.
>>>>
>>>> The VIRTIO_GPU_F_RESOURCE_USERPTR is from guest userspace, but the
>>>> VIRTIO_GPU_BLOB_MEM_GUEST comes from guest kernel.
>>>> So in VIRTIO kernel and virglrenderer they are different, see VIRTIO 
>>>> kerenl: [1], and virglrenderer: [2].
>>>>
>>>> May I need to change the organizational form of this patch set?
>>>>
>>>> [1]: https://lore.kernel.org/lkml/20251112074548.3718563-1- 
>>>> honglei1.huang@amd.com/
>>>> [2]: https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
>>>> merge_requests/1568/ 
>>>> diffs#14086999aaf57fc68a3d7d639ab280c3a2672430:~:text=if%20(args%2D%3Eblob_flags%20%26%20VIRGL_RENDERER_BLOB_FLAG_USE_USERPTR)%20%7B
>>> Why does virglrenderer need to distinguish userspace and kernel?
>>
>> It seems like the blob resource in virglrenderer doesn't support the 
>> guest resource/iov resource, virglrenderer doesn't let guest kernel 
>> resource go into get_blob callback.
>>
>> But some feature I am working on really want to let guest userptr 
>> resource get in get_blob callback.
>>
>> So I use this flag to extend the feature of virglrenderer blob callback.
>>
>> The different is:
>> guest kernel resource -> won't go to blob callback.
>> guest userptr resource -> go to blob callback.
> 
> Now I understand what you want to achieve. But there should be no reason 
> to distinguish kernel and userspace; you just need to run some code to 
> set up a resource for hsakmt using some memory.
> 
> In that case, you can simply add another callback that achieves the goal 
> to virglrenderer. There is no need to change the guest-visible interface.

Yes, totally agreed, I come to realized that maybe there is no 
difference between guest blob and userptr resource in qemu/virglrenderer 
when I replied to you. The handle paths can be unified.

Let me think carefully and simplify it in the next version.



