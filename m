Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33091C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 11:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpQQg-0004Jm-D0; Tue, 04 Mar 2025 06:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpQQa-0004JE-Qm
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:27:13 -0500
Received: from mail-bn1nam02on2044.outbound.protection.outlook.com
 ([40.107.212.44] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpQQY-0005XW-37
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 06:27:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDLZrVQNTeKYYFOuhY1ozPNeWvrGiWf7NG8sg6m+KydZx2R6/jIUhNN+egwk7EUQPidoRAc9jwEKbUp+1YlijWQSh6eUFGDxuNmbPw+B1oDvT51TAs30b+kCQ7CPO2GXhrFwt7fnQZMJn2mNJU62AYuJt+MredZ44jMeyJ/vNG4UVNi14UuWzVyEV7Uh6IOMX0dPPwHFvz0G2u3XKRGiDz/18iYCE29SFPWr992iEp8AsyBE4Oeg3vN6U3GUxyGAE31mO4pvxXC+Y9BEkXF8ho+XrD8rci7Wy/UsR0Lz00ikKaZ1PH8cd8VYtxly2eF768okmBE4rC9KrmdKVLN/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFZrG5ZPdJkoVaecZYm8By2HWwzVfZ1NOYB2GU2a2z8=;
 b=zTiQjzEx0QidqQ+yw/WJ4+tA9bzKlSeQNN7aUrQZnpVmbO6Tu9YO7d/Sbf/lt3RikF/JuBtPYmEO8yI+fMUJdyHg697gXGXOrNKgRRxSaqZzM3APbKJf5vBsu2IIOqyTjxn0EMRfxinL8zV3i+A/BPz/s7NPfX0BMrmaZA9rwzeXvuEd25ErrvAgDn4M6/ptThE3fs9lTuKclCG7DjNM8jPFW4wzh13Hs9NpVCOV3197hUtDx7Nu+pA+A83l1OWGA5VF+vtmfOAVtLSsYEEoO4yQIujTJWTz73n5N64qNcUbxwlENJWtOTb4Hi1O7bQ5G7gmkTRXoU+xx15msDAdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFZrG5ZPdJkoVaecZYm8By2HWwzVfZ1NOYB2GU2a2z8=;
 b=berwpreBDuQtlksi3x2Kcc+vJSgr2xkaVwb+aC4qPc2ZRDwABffhq5J2+2xJSIYEK4b6ZCgL+Ho4Npy7CgkhLCKkxnd9psgNYDy/snJ3he3pkjssErKmgT9o/cA4JV2MpF9nbZ5KQeIksw14mtXqdWpBuxfvY8hvG7wMGj1ikh3vt4hA3s2uz6K5UbRDjZLhOAqzXP+Hsp0GyVJNEh9V36mtZo8mX7nkYct+TCUUDOtFR+S9Pqe/TyjjJas66eycLoYScSVg4jvIj8cCFGFXQpmKCt5B9iTFa+vD3G9uP8MgYMo/UfVWbvlAHHSerPNw8ZrCYK2FL4bU8TCdyEF5aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 11:22:00 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 11:21:59 +0000
Message-ID: <e2408a83-8517-4e1e-9474-672bc085253a@nvidia.com>
Date: Tue, 4 Mar 2025 13:21:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
 <2fe12099-be41-4ca3-8ede-add04cc76b19@nvidia.com>
 <4e5c36a1-80f4-4902-9c1b-3d21a48092e5@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4e5c36a1-80f4-4902-9c1b-3d21a48092e5@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0609b6d3-5137-43a4-47c9-08dd5b0ec7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVdRYzV3VUsrMzFXak1OcGpmV0pONW41QWIzNEVCZXhpaDgxbWZBaTVJVUVu?=
 =?utf-8?B?SmtVMnkvTCtnZmJua3BsbEl1SThQMlhPRFBKSWJycTJhdmswampVdTBTdGNU?=
 =?utf-8?B?bVd4WHU3MG5DYjg2Ly9USld1dGpFa0tOazlWb2srYmU5cHlHT0FMRWdNYUlJ?=
 =?utf-8?B?TTdXTlU1TjVsaVhhMUFoUHdhUXRXeHF1SkNLZDVCWWtXbUpFbk1mS0RhbVcr?=
 =?utf-8?B?Myt5L3VuSVQvTmdxdFBVUU5OOEdIb2UzaXpyS0dqOWo5R3NpR05xTEk1U3ph?=
 =?utf-8?B?Z3kwKzBBWU1EbVFwRnFZUXJGTDVOem0rYkZ0THlEcnIrL1FGSktWVmdWd3lL?=
 =?utf-8?B?OXA5K2lDVmtRMUVscWV4bllIVS9GYkFiS3ZJbFFXTStIQnVhQy8vQXFxOTlZ?=
 =?utf-8?B?Y202azN3elpYdEM5UTdFWVpTZ1RxckV6dFY4T1R5VVBkMTdoYXQwS0VBT0tl?=
 =?utf-8?B?aVYvbEpkRVBvTTBhVGtoLzNxbm1ZL01BN1kzYVltWVR3dERNRVBCMTdVYUo1?=
 =?utf-8?B?em9uUWd0ZUYzTDdLeEtGejZ1UUNmU1BsUFpVY3RnTzhaUngwR3VORDRvQUZR?=
 =?utf-8?B?Uk1BVlhPY0lqcHpwTkRtVEQwMXEyNkorOFFLTGp6N0NoTWUzQ2RwZ2pkZWxN?=
 =?utf-8?B?SjJ5SmxlK2RvYW5WaXBXaGczcWdjMmQrZlBQRmFGZGlPalNybGxOc0ZRbWVY?=
 =?utf-8?B?UXhGdVAxQzlWa29Ec3NJemFWUk4xWVVvTlNvOUFQeHl3dGROWmlwOTRXTE5U?=
 =?utf-8?B?eGFzN3NRbDUvb2ordVAxblF3YXh5SVJCRmZDbERqTDFPWnRlQ0wrU0trQ0NL?=
 =?utf-8?B?Y0F1eXZ4b3hVNWtkNWdsb2VJZFQwT3U3VVZlQlBkckJEdzhXMzNiZ29mNFFu?=
 =?utf-8?B?WjVtY2IxeUM3R05GVGZmc2Y2ZmxWekdUOTN3eFlCRzE0d3c1VTlEWnN5c2Nw?=
 =?utf-8?B?L2lkNStvemxvUzJjd1ZZSDRHb3VLcThQbW1Db21DK0twUVlWN3ZnWmdSTVdY?=
 =?utf-8?B?Ykp1QkZTMVY5UG1xaG5od1hSY2hadjBkZjhOMkl0VHR1b0tUMXpYZ0RRbEJH?=
 =?utf-8?B?eTUrWkVvZXhwcG8xTTJqLzQxZUh1ZHArQWQ4WmZPckdzNEVrUkFyZWV4ZkxX?=
 =?utf-8?B?VldaWGQvUHIvdUxqMDFZU0NsWTlkalhZSXpSamc2dTZMaUUvbjA0SjZIZXBo?=
 =?utf-8?B?VGlmaU42ZzlMQ3I5WWdQVlEwdnVQa2F5aStrbWRVaWl6cGxDcC9tOUdVZDg3?=
 =?utf-8?B?Z1ZueFR2V3NtMTlwY1Uzdlk5Y25yWVdMVklYOHp6Z0RFU1RGVkZUdS90dVF3?=
 =?utf-8?B?aUFsUWhUVDBvc2F5Tm10bHVua25PWGdKTmFuWGZSNmxmZmZYSFpzYXhjZlZ4?=
 =?utf-8?B?a0RIK2VPVG1VRGFZa0liTS9JblhiZTk3a3Y1SDJLTCtXR3AxbGJWMVB1UkdW?=
 =?utf-8?B?S0xKTUcyZFQyNEROeHBrRCtUU3ZHc3JWMldlT1RxN3dMTWdUeHNOM2o1MkEy?=
 =?utf-8?B?L2lEVE5XS3ZONHdXYW8xZ1VkODZYU0N2MWJsYWREWWJIdWhwWGQ1QVYwakVR?=
 =?utf-8?B?dzNwYnVpL2IzV0trUlBTY3U3ZFNmOGxWTWhtcndRM21tQlNiRmJSWHMzcGRH?=
 =?utf-8?B?VlBhUm9zaHdHMXk4Z3ZyNll1SUF1c0VSMG1zbXA5TkVnVXk0NUN6dTd2ZVht?=
 =?utf-8?B?OUZZWk9TUTNkWkFFdy91Tm1vTHVmOXRoMW5lbUVMOHRpbW4zU3RlWTBJR1V0?=
 =?utf-8?B?aE5HV1NCTktIVHdMTVA4ZnhrM1BodmFjVHFHa0xPS1UrUXJid3FlNm4xUGFN?=
 =?utf-8?B?OXAxd3lCZ0hsamg4ZEhLd09RK21vaWUrOW5NeXFkRlArdDVuekZJK3hGY1Fq?=
 =?utf-8?Q?DQU4j/Xl1zhYe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Vvc0JCNUpSQjNUdi9vZE1lOHVxSnIwTGplV3pGTHZqeWlGOGJKNVcyUnpn?=
 =?utf-8?B?N0J0RkhhMXNpT1J5OEw5bCtvY1dERlRsMEZQWkZ1cGFCSkNaSG9XSWJabnY0?=
 =?utf-8?B?b0JVSll5L2VDVkNtYmpzb2tSYWlib3ZkNU9uT2pNQWhnUWd6R2hxWDZJSU15?=
 =?utf-8?B?UGNKa0RCVVd2ZVFzZHJYZU8yQVRqa1lhVzNHL2VoOUxoREtKSDdkSjMzNmJG?=
 =?utf-8?B?dy90VzkyS2pmRjg1Q0g3RHRRdlZsU29GZXNaTDl2dnlva2RNVWZZM2VTZ21y?=
 =?utf-8?B?MmlPSDR6VGtSakJrQ1ZEVytxNXhrVmFDTEtpQU5vZ3VZSjBvenpSejZlWjBz?=
 =?utf-8?B?ZnI5YzNBSFdWRlZJbWdINWs2Sm1EK2hwQ1o4Y3FQM1dkdjhhY3A1aklkMDEz?=
 =?utf-8?B?d3RvNDhnS0wzdXloUXQ1eE9Dam1Oa3FJQVFsYlBGN3pUb0ZFVFlscUlqc3Z5?=
 =?utf-8?B?UGo5UC9tRWRTMlNLRndvcE8rcEk5ZEtoL3lScTJhNzZZcGNxenJSd2FFQXpU?=
 =?utf-8?B?bzBhdWlVUGI4Q3lwM2R6Rjd4T3pza2ZYdVVBenF0d0ZQcy90Y3VHSDk0TDNr?=
 =?utf-8?B?YkVmSC84QlRCWjdVVk0rK0FrUUtqc2FIYzRVd1hNLzRYYkk2RlFyZE40UFlw?=
 =?utf-8?B?eER4Q2xMK2Z3ZDMzL1JOY0lQY241QWJDRFBGZFArSVBMelFWaDRRWjYwUDlu?=
 =?utf-8?B?OWhJUUdRQVBMUkpNQUxyeENzb3c3alpNekl1UzQxelVIUG1VVUQ4bHp2WGJH?=
 =?utf-8?B?OXdpYkdWN3JqRDhJZ1JvMFhtdWdiRSt2ZFRlZ1pCbnkvTGVueG1VZlJ6c2ov?=
 =?utf-8?B?TUVYenlna29ocFdBbWJkZXVMdHFvaW81cGZlQ1JJNXpGVSt1KzNSeFhtTitv?=
 =?utf-8?B?TEMvTWVLRmhTOWpZY1luMzh4L2pkTDgvWWdPRzVWNDVYQmFlV0I2L3gzWmVM?=
 =?utf-8?B?djFCeUxENG1VSkp1NGNEL0Q5Z1FGbXVBOHhmbE9iRnJtUVYyeVlvV3RrSkpW?=
 =?utf-8?B?ajV5bE9QOEhza1VCOVA0MUFYS3NtdEFQQ2xabVRuMlNLR2UyQVZ0N1ZBVkx6?=
 =?utf-8?B?ZU9SZVVJVFpjeXQrS1NtRmNaOFVmYVM5ZkhOVUcxY2dhWWFXcGdad0FEdFlU?=
 =?utf-8?B?L3c0RWw4ZjJ6TzlLVzNzSlVrYlVsaEVUQWZ2SjFiN0JhSFhYSzJoMHZRUDg5?=
 =?utf-8?B?SXBPVnNQa2J5NG9LcExuWGM1NU1SVnBGVDVrVmNQRzFmSVZ6SWpZNnlOb0hX?=
 =?utf-8?B?U0l0VndETUJxdkc1M2toRGhBTmYyM2tKVjFqSzlsUXJCelU1M2ZsWHVTOFRX?=
 =?utf-8?B?OGJaOGkwTVFPaWxBMUVablJScEw5Y2Q0SytmQjc1blBmTXhhdzFwUnpQN2E5?=
 =?utf-8?B?ZzlVL3Y2OThITTNzTW1iRVl5ZkkwUGFEWHZqc3BWRVVWejJOZStza1kyUU9R?=
 =?utf-8?B?YTdnUEUvVTNOMTVMUmxtNHZkcmI0ZzdieGRNcU1PZitObU5EZ2VGa09GaVFG?=
 =?utf-8?B?bjFsbW81MWE5R21RMWtYVkpJYkRwOTVmc0l1M2JWbmYrdFJRaVhnMlViamZ0?=
 =?utf-8?B?dHR1MjRXUGhEblhHTlV5cVNBQjRsRlQyS01Ld3lmdCthdkVCWGRwcmx2ZDI3?=
 =?utf-8?B?MldaSm1nakdVOXRUK2ZyT2F5U3A0akRVeURacG5vVG9GZmFST0ZXTmNkZXVE?=
 =?utf-8?B?U2VoeFlyZlZrbHFka3hEcnFmNU5Vam9KK2xlVXlGN1gwZGlpVXZvZWk0bFZQ?=
 =?utf-8?B?bkpQcm9oUG13QU92L3FDRW1Nd3FoZW95TTdBWTNzRXBVckhVL0FXRDczcysr?=
 =?utf-8?B?TCtuOHIwYVFISUpJakFwS2kreWVKKzR5WXJzRFgzMTBJK0I0RXdJdnluSVlG?=
 =?utf-8?B?SjdlL0dNb3hSaXljZUNSV1QreHN5WFMrWFkwazEvdW5DbXZKaXFHeDZnR2No?=
 =?utf-8?B?Ymw3Vm52WFcveXo4Q2tSNTgwZU9ZbWM1NjZPUGVtWmxNaTVnSk5xazNGcWpt?=
 =?utf-8?B?YUtFeHJpS1gzOVZidUNxWEdNdFZCZjE0YjVKRU43cmxSVndjVEp0YytuTTZy?=
 =?utf-8?B?dExuYzVNRUVnTFU2V0g0Q1ArRk9VRGtFSnFtRmxkTTJTMS8yM3BvS0M3ajg1?=
 =?utf-8?Q?IyOh+TuOOesPrJ7Q12B/tVaEk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0609b6d3-5137-43a4-47c9-08dd5b0ec7a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 11:21:59.6399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dl0YfcapPyYQnkCS+nQa4LIUo8UbGad7uXvRxlipbGupYqHinagtGrGhJlDHqxqeumYB5Ub5e3XPx4vzj2jITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
Received-SPF: softfail client-ip=40.107.212.44;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On 04/03/2025 0:16, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 2.03.2025 15:15, Avihai Horon wrote:
>>
>> On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Maybe add a sentence talking about the load thread itself first? E.g.:
>>
>> Add a thread which loads the VFIO device state buffers that were 
>> received and via multifd.
>> Each VFIO device that has multifd device state transfer enabled has 
>> one such thread, which is created using migration core API 
>> qemu_loadvm_start_load_thread().
>>
>> Since it's important to finish...
>
> Added such leading text to the commit message for this patch.
>
>>> Since it's important to finish loading device state transferred via the
>>> main migration channel (via save_live_iterate SaveVMHandler) before
>>> starting loading the data asynchronously transferred via multifd the 
>>> thread
>>> doing the actual loading of the multifd transferred data is only 
>>> started
>>> from switchover_start SaveVMHandler.
>>>
>>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>>> sub-command of QEMU_VM_COMMAND is received via the main migration 
>>> channel.
>>>
>>> This sub-command is only sent after all save_live_iterate data have 
>>> already
>>> been posted so it is safe to commence loading of the 
>>> multifd-transferred
>>> device state upon receiving it - loading of save_live_iterate data 
>>> happens
>>> synchronously in the main migration thread (much like the processing of
>>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>>> processed all the proceeding data must have already been loaded.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration-multifd.c | 225 
>>> ++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/migration-multifd.h |   2 +
>>>   hw/vfio/migration.c         |  12 ++
>>>   hw/vfio/trace-events        |   5 +
>>>   4 files changed, 244 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index 5d5ee1393674..b3a88c062769 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>>>   } VFIOStateBuffer;
>>>
>>>   typedef struct VFIOMultifd {
>>> +    QemuThread load_bufs_thread;
>>
>> This can be dropped.
>
> Yeah - it was a remainder from pre-load-thread days of v2.
>
> Dropped now.
>
>>> +    bool load_bufs_thread_running;
>>> +    bool load_bufs_thread_want_exit;
>>> +
>>>       VFIOStateBuffers load_bufs;
>>>       QemuCond load_bufs_buffer_ready_cond;
>>> +    QemuCond load_bufs_thread_finished_cond;
>>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>>       uint32_t load_buf_idx;
>>>       uint32_t load_buf_idx_last;
>>> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char 
>>> *data, size_t data_size,
>>>       return true;
>>>   }
>>>
>>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>>> +{
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd 
>>> *multifd)
>>> +{
>>> +    VFIOStateBuffer *lb;
>>> +    guint bufs_len;
>>> +
>>> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
>>> +    if (multifd->load_buf_idx >= bufs_len) {
>>> +        assert(multifd->load_buf_idx == bufs_len);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
>>> +                               multifd->load_buf_idx);
>>> +    if (!lb->is_present) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return lb;
>>> +}
>>> +
>>> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>>> +                                         VFIOStateBuffer *lb,
>>> +                                         Error **errp)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    g_autofree char *buf = NULL;
>>> +    char *buf_cur;
>>> +    size_t buf_len;
>>> +
>>> +    if (!lb->len) {
>>> +        return true;
>>> +    }
>>> +
>>> + trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>>> + multifd->load_buf_idx);
>>> +
>>> +    /* lb might become re-allocated when we drop the lock */
>>> +    buf = g_steal_pointer(&lb->data);
>>> +    buf_cur = buf;
>>> +    buf_len = lb->len;
>>> +    while (buf_len > 0) {
>>> +        ssize_t wr_ret;
>>> +        int errno_save;
>>> +
>>> +        /*
>>> +         * Loading data to the device takes a while,
>>> +         * drop the lock during this process.
>>> +         */
>>> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
>>> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);
>>> +        errno_save = errno;
>>> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
>>> +
>>> +        if (wr_ret < 0) {
>>> +            error_setg(errp,
>>> +                       "writing state buffer %" PRIu32 " failed: %d",
>>> +                       multifd->load_buf_idx, errno_save);
>>
>> Let's add vbasedev->name to the error message so we know which device 
>> caused the error.
>
> Done.
>
>>> +            return false;
>>> +        }
>>> +
>>> +        assert(wr_ret <= buf_len);
>>
>> I think this assert is redundant: we write buf_len bytes and by 
>> definition of write() wr_ret will be <= buf_len.
>
> It's for catching when the "definition" for some reason does not match 
> reality
> since this would result in a reading well past the buffer.
>
> That's why it's an assert, not an error return.

Yes, but it's highly unlikely that write() will not match reality.
But that's a minor, so whatever you prefer.

>
>>> +        buf_len -= wr_ret;
>>> +        buf_cur += wr_ret;
>>> +    }
>>> +
>>> + trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>>> + multifd->load_buf_idx);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
>>> +                                            bool *should_quit)
>>> +{
>>> +    return multifd->load_bufs_thread_want_exit || 
>>> qatomic_read(should_quit);
>>> +}
>>> +
>>> +/*
>>> + * This thread is spawned by vfio_multifd_switchover_start() which 
>>> gets
>>> + * called upon encountering the switchover point marker in main 
>>> migration
>>> + * stream.
>>> + *
>>> + * It exits after either:
>>> + * * completing loading the remaining device state and device 
>>> config, OR:
>>> + * * encountering some error while doing the above, OR:
>>> + * * being forcefully aborted by the migration core by it setting 
>>> should_quit
>>> + *   or by vfio_load_cleanup_load_bufs_thread() setting
>>> + *   multifd->load_bufs_thread_want_exit.
>>> + */
>>> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, 
>>> Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    bool ret = true;
>>> +    int config_ret;
>>> +
>>> +    assert(multifd);
>>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>>> +
>>> +    assert(multifd->load_bufs_thread_running);
>>> +
>>> +    while (true) {
>>> +        VFIOStateBuffer *lb;
>>> +
>>> +        /*
>>> +         * Always check cancellation first after the buffer_ready 
>>> wait below in
>>> +         * case that cond was signalled by 
>>> vfio_load_cleanup_load_bufs_thread().
>>> +         */
>>> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
>>> +            error_setg(errp, "operation cancelled");
>>> +            ret = false;
>>> +            goto ret_signal;
>>
>> IIUC, if vfio_load_bufs_thread_want_exit() returns true, it means 
>> that some other code part already failed and set migration error, no?
>> If so, shouldn't we return true here? After all, 
>> vfio_load_bufs_thread didn't really fail, it just got signal to 
>> terminate itself.
>
> The thread didn't succeed with loading all the data either, but got 
> cancelled.
>
> It's a similar logic as Glib's GIO returning G_IO_ERROR_CANCELLED if 
> the operation
> got cancelled.
>
> In a GTask a pending cancellation will even overwrite any other error 
> or value
> that the task tried to return (at least by default).

Ah I see.
I was looking on multifd_{send,recv}_thread and there they don't set an 
error if cancelled.

Anyway, what confused me is that we set an error here only so 
qemu_loadvm_load_thread() will try to migrate_set_error(), but that 
won't work because a migration error is already expected to be present.
If that's indeed so, then to me it looks a bit redundant to set this 
error here.

Thanks.


