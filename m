Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A8C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGM4-0006PG-DP; Tue, 22 Jul 2025 13:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1ueFjg-00047d-QD; Tue, 22 Jul 2025 12:21:02 -0400
Received: from outbound-ip191a.ess.barracuda.com ([209.222.82.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1ueFjd-0004KL-26; Tue, 22 Jul 2025 12:21:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2132.outbound.protection.outlook.com [40.107.236.132]) by
 mx-outbound11-199.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 22 Jul 2025 16:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/I3CtoPpzHMew3s6joNXXg7nOfhulZX/MvTcIQORE6j57lAYEfDm7T4OC8RHKXw9nCmL1tlW8RqWWaFOgfj1MxmQGSCmT0tbRsEKkNmkSGmNVRyDv8ZhpIgFCp2dy9H1wyftyujwnsLmF/EvQEpP1Mb9NUGXYoKr9HoXE11dodHizSFlorfWNHblBy/266g1AeMPGpfzv1DOVS/Urvud1bAAgv/fmCH2BoY0rHQKQhz3wLApZ7LykrvcLNpWNcpVbphR4UCRuqmBplUyEFH6GyjCB73mJnjhSnSCMy3BycW1bdAIh4RRtnyFmhoSe+bN4ocxCfvDowOIRY8fkYwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6e0IAQnU00AoOnsxjC0bHZbbcQ4Eo9Z2hUfyjwo4h0=;
 b=AEszqaktBgqZrBHdOGcuXahxMeJm2rY6m1214E5r/6ms1Jv/6doCfCHPwU01u4Z9MyTQP2SfM4C4lEWX5wbdA3NhIwXWHp814fBJlzqAjuO5Iw5IC1gqj3zKu4YDOV/3mSw/udMn8XRAaKVQhUCH3D2Nm9nw7zS1bQNvfKCXnIZOoM8nF+oVxQFWrGHQXkwlmv9OdZJHJNaRk+wGzruN0u2RphvYViB4Q0P1VfhlHAwPbPIHQ2EkIAXfcXSq2rzedYxmqDKV6ueRtDtdYpF5FJB7FOY/n8jyqEvNnUFWaONi1L30CsO/OtvVW6Jsd5Xlfh1VYbcVFaAtCzwCn+BNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6e0IAQnU00AoOnsxjC0bHZbbcQ4Eo9Z2hUfyjwo4h0=;
 b=MsgIzsi7vQidKGVFpGMyMicOuZx5WMdLtOCIZK6AGj6SjwwozFbE+yP+VKlQzVya07PLmWu2cRvmSJzNl/cX+AmIPNB6kjNCFZzm8AqD8qZidBdipuh+TuMGDqxBFf4dCyv++hTQim832yTgD1riPw2sRDbAfB1ZzMhrBpQSa6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BL4PR19MB8878.namprd19.prod.outlook.com (2603:10b6:208:5a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:20:46 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 16:20:45 +0000
Message-ID: <ab8dda6a-7908-419e-a270-5f9a6163d93f@ddn.com>
Date: Tue, 22 Jul 2025 18:20:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <20250721005346.GB32887@fedora>
 <e8210399-9d04-46c1-8a23-6e8cdb472c6f@ddn.com>
 <20250722154357.GA21935@fedora>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250722154357.GA21935@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::27) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|BL4PR19MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c04b29-a101-4a7d-944d-08ddc93bb617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|19092799006|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlpiK24xQXJwOHI3aGpIQ2FIeHlJR2F5N0xBYm5uc3NqTTlIVUdxQ004MzMx?=
 =?utf-8?B?R3ljZ3VUYVlyRyt3WWtvZU9GQWJqcDVOUHQ5a24yaGp5YmZmT0ZHdFZ3aG1n?=
 =?utf-8?B?MkJib1drcnlidUh0M21jWFU5VnpiMkorUjV4aExPWFJ6U0p0dzVYNmp3N2ZM?=
 =?utf-8?B?WDR1b3Z4OFI0N0tWSjcrNHRMZDJjVzlxK1ltd2YrcVUrdXVOYzJZRGlaeFZx?=
 =?utf-8?B?RWNRVm9Xa3Q3V1U1akVRNzNJVVRuU3pLd3BqOHBtdm9mZ3U3NC85czcrZkRZ?=
 =?utf-8?B?QjB4azdYbTdWeVJUR2YvWU9EOFN2SnJQMlMraElSSUN0QzJvUmkrRDJFMjdS?=
 =?utf-8?B?N25UVmdkb25DKzNZSE9MckU2bG1PbkFGaFp5bEJvR3VlcDBXRWc3MDBzWDBC?=
 =?utf-8?B?enM1U3dYT3EvVzN2dy8yWXNSUzVJZDhQL1diemNxcmk0d1owTGRjSWJkczBP?=
 =?utf-8?B?WTZhd1RWTmVTRGtwdTF3SDlOTVU5WGRnL1VsMnBOQXV2SzVHUFAxYzVBZjla?=
 =?utf-8?B?dUNTMmh0Y1Z5NGJJbUVPMzZRRHpjMTJoRUNKR1pUbFZ3M25sRTRxeEE1UFBx?=
 =?utf-8?B?eHBia2Y5aE8xeHpSdjhrZ2xEc1FUNTl6UzFHaXVmZFZQd1E5d1gwV1R3THhp?=
 =?utf-8?B?VVBZUWxjbXBJQ3hrVHNjMm5WQU8raWgzUklLZ1VodHpGbVNrSk1Qd1kvYll1?=
 =?utf-8?B?d2VaLzhSRjJaYURXOEVMemZwMG15K2V0NmhpS3hUWDVjMEQyd2NFTWxxeFdP?=
 =?utf-8?B?QVdod1Z6cFFlemNtbmlxQ1YzWVgxS1lpK2dnT1NTV0xTdzJkQ085bGMvczhZ?=
 =?utf-8?B?emt0UndEWHFla2kxT0tKYTZxKzlBcys5Q3NGSVh5NjdZZnI1dTBnKzR1QVVx?=
 =?utf-8?B?Q24wNzd0UE9QeGNPRkFOUWpyVWtSMG9sZS92MGZOVEZSazMzdjRxbEw0YitG?=
 =?utf-8?B?dlQzQUZlc0J6cUkyN1A0OEo1akdoSmhMak1sMDZpbjhiMFhvV3NpN0llMVFX?=
 =?utf-8?B?K1BVK0pqcFBsZ1BqSFkxblN6SlQ1OVdaNDlNelNEWVl5WlpUZjZ3VFRJSDNE?=
 =?utf-8?B?ZzFqUHNsc3M5MGNXdkM0ZGVSMU5FMlA1alFDV3FJWDM5N2VxRE5meGlpYlRm?=
 =?utf-8?B?d3M5bTl4aHpMNEpETmpFS1FSV1kra1JrYjJuVjNkTzBPTjQ1eFRVQnZiTWNP?=
 =?utf-8?B?bWgxbld1bWtiUkpMYWo0M2xYSW1pWVZEZm4xOTNhazgwS0o3VTlkdTBPVnhZ?=
 =?utf-8?B?NjY1Z1ZoS2xPM1BvMmxQUHI0bmlWT0lNbE5yUUQ4R2IwdmQ2K2h3bVN0Q2VQ?=
 =?utf-8?B?aU9CWkg2YWlXTkJsamVmemRDWC9zZndBTDhsZ2hrWGxuOVRBNTFtS3RnTDdG?=
 =?utf-8?B?VTRtT29UeHZCRk1DK29oT285bUJRV3h1bE5JTjdHZ0NycHRKcTNzL0xGMlFQ?=
 =?utf-8?B?TFJhVFlPTzh2bDBxRGdtTFJScmxKcGhMU0svekNOdDE1M3BVQklxdVo3dVpG?=
 =?utf-8?B?YlkyZWt3OGxCQWlaYUF2S00xaGxMSHYvZzcwMDB1VUdmZnpiTVdzaGV1TnhK?=
 =?utf-8?B?TlIzUW1qMUFvbW5oTFJsZjdISFM4UjdKbVJwMUZtMngwYnRBREo3ZXF4UzNn?=
 =?utf-8?B?WHEzYjBrNWVvdzZDNTIvMGtUdUtzQkJqT1NpZzFPS3QvSXlGK3lwK2dkMDk0?=
 =?utf-8?B?KzdZcVc4YTZQVjdXSlA5MmNwdjA3T0JKMWVoY3JtU01LOWdBOEk2N0V6Ylha?=
 =?utf-8?B?VlM0ay80bUc2WHVqVDNWZTRJODNzSWp1ai9jNTczc3BLYjlIekdwWEQ5Y2xr?=
 =?utf-8?B?bmxRV0VFcXZBN1M3T0xSQU9SUjBSeFlubGlpNkQwVGlPN3c5bUlyRklIVWV3?=
 =?utf-8?B?Q0Q1QXBzRWU4Wm9MZHN4MmZDSDFQNWFES0g4YUtvcFhuV3VJUSs4M3RucHZT?=
 =?utf-8?Q?ii3NtzqBQlE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR19MB3864.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUVOTGg4MFFFM3dVMXdlZ2cxUm1IOVEyUzVRYnArdXRCUGhrdlA2bWRCNVFD?=
 =?utf-8?B?QjV6R2k1aXR5VHpFS0VmV0oyNHFobnp2UHROMWVjVFAwQmFCaW92aDIrM0Nm?=
 =?utf-8?B?ZVZTdzFnMUpqbzFrcStBakRqSmZSckl0NlRJSEI1cTRxSXRJaWtJZzFObnNh?=
 =?utf-8?B?bHF3VDFFQjdxbjFOR0RxdFF6UWV3bUt6a2NCQjdKclVtcFJZM3Y3ZUJueWxZ?=
 =?utf-8?B?YXhaUCtPV0hhRjZqUVNiZTJoR0dtb01iak5pZktZb0c3QzBjN25STFZyY01q?=
 =?utf-8?B?Rm5HNnV0ck1WQWR6SXdxUEdEYVR4NTNnbm1hcjkyeVUvRHhJdDFncDNwNG9y?=
 =?utf-8?B?UGdmM0ZDdmFnd3NJUWpqYUZrYk5JRE9ib0hXU0pBQmxBQTNQYXZ1akdITGJi?=
 =?utf-8?B?Qk8wdzJCclYvNk8xL3RZQ0pGWS8yb0RTMDZoRUhKUG9MaGQyUzA5ZnhCeFJ0?=
 =?utf-8?B?ODBBVGxXOHZER1hOeTdUV1YrQTIybmlKNWY2QzdOSi81L3VBV3VDWDhEUnd1?=
 =?utf-8?B?YTQwYmRVRmoyMmFwYU1rc2FDWTlyT1ZMb0lHWGVXSWJudnNXVUJSSWZ5V3l5?=
 =?utf-8?B?aVl5TUlENWoxYnl1ZUEzMlRBNi9yTHY0cUw4bmZpa2ZCbjl1dXhZV0lnV1cw?=
 =?utf-8?B?QWd3UmJhZkdBWjBKV3NaajFreUxvY285b21GRXc5clRCQVpxclVrbmNTQXV1?=
 =?utf-8?B?NzNHUnYwQlgwcS9uM1BkeDVWUTUzZVBzTHdaYmw5eTJGblZpYkRTVXkxZ2pP?=
 =?utf-8?B?VlZuSW9ZMnVYN0FqditpaDB1cDU4VHE4ZVhCZStJaUlUcEhyUSt4bElTSEYz?=
 =?utf-8?B?UzRIYXV0N0pYYzluVVoyOEs1TGZxN2xSNW9HVkpKMmlQRWxReVVXY2s3ZmQx?=
 =?utf-8?B?QWRLdVNNWW9xdXdXUVcyeXdrY211WWF4N2hsRE1QT2RwbVhsTGM2N1IyMWxC?=
 =?utf-8?B?S2puVERTWWZtZnBPdCt0Vy96d2RaNVdPOUNpalZSZVJhZXRpaWhnaVYxVzBJ?=
 =?utf-8?B?T055TlZsUjFEd2Yvb3dIdWg2VUlDS3lTMGkzaXgrWGdIVnhJb3RsV3MwbTN0?=
 =?utf-8?B?dG1EVWQxRFVjdjF0Q0F5VVRnc2Z0aytNaWJnb2FEYzFYa25iM0ZEbUtHOXVN?=
 =?utf-8?B?TkEyRDg1TUhJa1N1RDBvMUl4UHhYQ29wR0tUaUwxZEJsVFphVkpCNG5rS2N5?=
 =?utf-8?B?UVljdnFGL2JjL1J4em80cGlIQWVWUERFUDJVSzI3L1V0N3lZVFRJbWIwbUpa?=
 =?utf-8?B?bE9WNmlxRjhibnBQV2ZyNWlWaVhvaHZjNjBSMnJjT09jRllhTzdmdkwrRytn?=
 =?utf-8?B?NnI4ODlpOFVkSmtVZWY0QjlhNHdPMjgzazFvMStXbFlnWGtjUDVkK1drZ0ta?=
 =?utf-8?B?c01CRXMyQUI2SXpDaVRKN01YaURvTWtTN01CMHRDRFVqVzU3MEhabk13Y3pm?=
 =?utf-8?B?aHZwcW5PYmhkOUR0Mm1QT3ZzVkt1ZGtLU0U5a0dUY2NuNkVLdDhKVm81YUY5?=
 =?utf-8?B?VjZpM1dFQXFGZHNxMS9pVjdFektiYTY1dUliZjNjREl4Yzg5TWhsVWFUSEZU?=
 =?utf-8?B?bGUxb1NxZ3hRSHhmK3d0c245VUdaWVJ0UC9QcEdLUldwVEVXMnhBNW5ya2tK?=
 =?utf-8?B?RmxlbmRQSUE5bS95NWFuVVVBTFBTSElmeVk0RE1oTkd6eXZ2SU5DTmgxbW1w?=
 =?utf-8?B?OVlGNXMzMmZjV2VGTS94Y1lZVmNYT3JDMCs5Nkg1SnA0cGNzc1dmelFIQ2hJ?=
 =?utf-8?B?akdIVXhmMXZzdFc3NTNOY1ZFOEZZYk5DMS9RM2NhZEorSDlORUUzdWE5N3B5?=
 =?utf-8?B?NDRKb0picXRGSFNITU9XbFBIZ2lwcGNrU0haU0NiMHN4YW1wTzMrd1ZuTys1?=
 =?utf-8?B?YkU0YUwzeWNoSlQrNzBxSzJ2TjdxN01Pa1lCWFllSm10ajlBL2MzL1hPMGR5?=
 =?utf-8?B?VFZ2ZkUzUTBKWENlSkN3QW0wTHBjdVdqMTl4dU5jWVN2MS9GUEdBSW9sL1F2?=
 =?utf-8?B?dC9GbFVpTFBSQys2aTJOSVRVR29iaWhKbEZrQUEzMjhVSmlQa0tZdE94M3ZV?=
 =?utf-8?B?bDM3K2ZxSmNmc1A3M0tsRDBXZTA1NjdyU1dlOEhpb1lRckRyOVdIK05CbWI4?=
 =?utf-8?B?amF6aUcyTnYrM1BST3lac21FUkkxWTVvd1poL3A2UUY5MnM4cDRxNnRQMHZR?=
 =?utf-8?Q?14V2XsnktLZNVEx06k2cMdmHxmME+valBZLHirDgfV3S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PpYvpH3B5mVSJhjx0j0Fx9XiYgP3PKckD3qLev7zq/2U31dEf4yuDEDWYHW3b9EFoxu3KSSxS+GD+REHZ0v9LJu8oNmcaXmyKgxMO/dxFYCnp8EYw5pY28BA2hX3ezKFNRTmQkbQVEc44p7Kz/8nW6BRnow+awyvx48mTkbX/JS2VHv6/Vew3x1Vuvt3cSPYZAtykCgOa8tM4wPkyJ+e4S8L4hgzhSNJlWFHs9wER9sxqbM+Kf5TLSwPRmPEr8/Dpl3k8fpqy4d8e3t58RNooy5NWL7y9P/4lfZGz9IpBpHr1jgQKvbzLftmWyYwKIhVW+aytkUXAmdMxvItCnevkDrYqk7YzF15w+EPdvy3sH/EEpPCmn+43Dtc4jSkHJGAj6pgOwlj25mmSR6uGgsv9YgZNl2uJr0K8ObZXTivuwdn55o7y9cc6JDCylxjKCycJD8CaJiaz02JgzeEipO/zWlgnXs4rxlBFZwLZ8HLZ7wef5p8FIniC/0szNhW0RUqVfKRGdgbOaEQTzjqiPq6421lgiAYdgmheqQHUG/bsT96/7pVFLENssqCEa0h0s4uJs7apu+kOpwtfURk8dtdo0ustb7O7fIOk9V5veXWlq9690QoU42Y+YBBT22UKtoV4YEMO8cWDlPgm6GYC5UchQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c04b29-a101-4a7d-944d-08ddc93bb617
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:20:45.4426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIW0CxL5+9yXe2KhPGX7QPsxmCTDae/d0vsvlRcHKPKqUTiJL9u5OWSNRKb0tJMHQtJnkABlTHGgnuf1ygN2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR19MB8878
X-BESS-ID: 1753201249-103015-14738-3624-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.236.132
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGlgaGQGYGUNTS3DjR2DA5zT
 DR2NIs0cgy0SzN1NIgyczA0tTIxNgiRak2FgChLbQTQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.266231 [from 
 cloudscan15-6.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.58; envelope-from=bschubert@ddn.com;
 helo=outbound-ip191a.ess.barracuda.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



On 7/22/25 17:43, Stefan Hajnoczi wrote:
> On Tue, Jul 22, 2025 at 02:06:04PM +0000, Bernd Schubert wrote:
>> On 7/21/25 02:53, Stefan Hajnoczi wrote:
>>> On Wed, Jul 16, 2025 at 02:38:24PM -0400, Brian Song wrote:
>>>> This work provides an initial implementation of fuse-over-io_uring
>>>> support for QEMU export. According to the fuse-over-io_uring protocol
>>>> specification, the userspace side must create the same number of queues
>>>> as the number of CPUs (nr_cpu), just like the kernel. Currently, each
>>>> queue contains only a single SQE entry, which is used to validate the
>>>> correctness of the fuse-over-io_uring functionality.
>>>>
>>>> All FUSE read and write operations interact with the kernel via io
>>>> vectors embedded in the SQE entry during submission and CQE fetching.
>>>> The req_header and op_payload members of each entry are included as
>>>> parts of the io vector: req_header carries the FUSE operation header,
>>>> and op_payload carries the data payload, such as file attributes in a
>>>> getattr reply, file content in a read reply, or file content being
>>>> written to the FUSE client in a write operation.
>>>>
>>>> At present, multi-threading support is still incomplete. In addition,
>>>> handling connection termination and managing the "drained" state of a
>>>> FUSE block export in QEMU remain as pending work.
>>>>
>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>>
>>>> ---
>>>>  block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>>>>  docs/tools/qemu-storage-daemon.rst   |  10 +-
>>>>  qapi/block-export.json               |   6 +-
>>>>  storage-daemon/qemu-storage-daemon.c |   1 +
>>>>  util/fdmon-io_uring.c                |   5 +-
>>>>  5 files changed, 420 insertions(+), 25 deletions(-)
>>>
>>> Here is feedback from a first pass over this patch.
>>>
>>>>
>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>> index c0ad4696ce..637d36186a 100644
>>>> --- a/block/export/fuse.c
>>>> +++ b/block/export/fuse.c
>>>> @@ -48,6 +48,11 @@
>>>>  #include <linux/fs.h>
>>>>  #endif
>>>>  
>>>> +#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
>>>> +
>>>> +/* room needed in buffer to accommodate header */
>>>> +#define FUSE_BUFFER_HEADER_SIZE 0x1000
>>>> +
>>>>  /* Prevent overly long bounce buffer allocations */
>>>>  #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
>>>>  /*
>>>> @@ -64,6 +69,26 @@
>>>>  
>>>>  typedef struct FuseExport FuseExport;
>>>>  
>>>> +struct FuseQueue;
>>>
>>> Use "typedef struct FuseQueue FuseQueue;" here...
>>>
>>>> +
>>>> +typedef struct FuseRingEnt {
>>>> +    /* back pointer */
>>>> +    struct FuseQueue *q;
>>>
>>> ...and then this can be "FuseQueue *q;" so that QEMU coding style is
>>> followed.
>>>
>>>> +
>>>> +    /* commit id of a fuse request */
>>>> +    uint64_t req_commit_id;
>>>> +
>>>> +    /* fuse request header and payload */
>>>> +    struct fuse_uring_req_header *req_header;
>>>> +    void *op_payload;
>>>> +    size_t req_payload_sz;
>>>> +
>>>> +    /* The vector passed to the kernel */
>>>> +    struct iovec iov[2];
>>>> +
>>>> +    CqeHandler fuse_cqe_handler;
>>>> +} FuseRingEnt;
>>>> +
>>>>  /*
>>>>   * One FUSE "queue", representing one FUSE FD from which requests are fetched
>>>>   * and processed.  Each queue is tied to an AioContext.
>>>> @@ -73,6 +98,7 @@ typedef struct FuseQueue {
>>>>  
>>>>      AioContext *ctx;
>>>>      int fuse_fd;
>>>> +    int qid;
>>>
>>> Could this go inside #ifdef CONFIG_LINUX_IO_URING? It seems to be
>>> specific to FUSE-over-io_uring.
>>>
>>>>  
>>>>      /*
>>>>       * The request buffer must be able to hold a full write, and/or at least
>>>> @@ -109,6 +135,17 @@ typedef struct FuseQueue {
>>>>       * Free this buffer with qemu_vfree().
>>>>       */
>>>>      void *spillover_buf;
>>>> +
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +    FuseRingEnt ent;
>>>> +
>>>> +    /*
>>>> +     * TODO
>>>> +     * Support multi-threaded FUSE over io_uring by using eventfd and allocating
>>>> +     * an extra SQE for each thread to be notified when the connection
>>>> +     * shuts down.
>>>> +     */
>>>
>>> eventfd and the extra SQE won't be necessary because
>>> aio_bh_schedule_oneshot() can be used to cause threads to execute a
>>> function.
>>>
>>> (I think this comment effectively says that connection shutdown still
>>> needs to be implemented. The implementation details don't matter at this
>>> point.)
>>>
>>>> +#endif
>>>>  } FuseQueue;
>>>>  
>>>>  /*
>>>> @@ -148,6 +185,7 @@ struct FuseExport {
>>>>      bool growable;
>>>>      /* Whether allow_other was used as a mount option or not */
>>>>      bool allow_other;
>>>> +    bool is_uring;
>>>>  
>>>>      mode_t st_mode;
>>>>      uid_t st_uid;
>>>> @@ -257,6 +295,126 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>>      .drained_poll  = fuse_export_drained_poll,
>>>>  };
>>>>  
>>>> +#ifdef CONFIG_LINUX_IO_URING
>>>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
>>>> +
>>>> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
>>>> +{
>>>> +    CqeHandler *cqe_handler = opaque;
>>>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>>>
>>> Passing ent in opaque instead of cqe_handler would simplify this.
>>>
>>>> +    FuseExport *exp = ent->q->exp;
>>>> +
>>>> +    fuse_uring_co_process_request(ent);
>>>> +
>>>> +    fuse_dec_in_flight(exp);
>>>> +}
>>>> +
>>>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>>>> +{
>>>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>>>> +    FuseQueue *q = ent->q;
>>>> +    Coroutine *co;
>>>> +    FuseExport *exp = ent->q->exp;
>>>> +
>>>> +    int err = cqe_handler->cqe.res;
>>>> +    if (err != 0) {
>>>> +        /* TODO end_conn support */
>>>> +
>>>> +        /* -ENOTCONN is ok on umount  */
>>>> +        if (err != -EINTR && err != -EOPNOTSUPP &&
>>>> +            err != -EAGAIN && err != -ENOTCONN) {
>>>> +            fuse_export_halt(exp);
>>>> +        }
>>>> +    } else {
>>>> +        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes,
>>>> +                            cqe_handler);
>>>> +        /* Decremented by co_fuse_uring_queue_handle_cqes() */
>>>> +        fuse_inc_in_flight(q->exp);
>>>
>>> Can this be moved inside co_fuse_uring_queue_handle_cqes() to avoid
>>> calling inc/dec from different functions? That would make the code
>>> easier to understand and more robust against future bugs.
>>>
>>>> +        qemu_coroutine_enter(co);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
>>>> +                    const unsigned int qid,
>>>> +                    const unsigned int commit_id)
>>>> +{
>>>> +    req->qid = qid;
>>>> +    req->commit_id = commit_id;
>>>> +    req->flags = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseRingEnt *ent,
>>>> +               __u32 cmd_op)
>>>> +{
>>>> +    sqe->opcode = IORING_OP_URING_CMD;
>>>> +
>>>> +    sqe->fd = ent->q->fuse_fd;
>>>> +    sqe->rw_flags = 0;
>>>> +    sqe->ioprio = 0;
>>>> +    sqe->off = 0;
>>>> +
>>>> +    sqe->cmd_op = cmd_op;
>>>> +    sqe->__pad1 = 0;
>>>> +}
>>>> +
>>>> +static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
>>>> +{
>>>> +    FuseQueue *q = opaque;
>>>> +    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
>>>> +
>>>> +    fuse_uring_sqe_prepare(sqe, &q->ent, FUSE_IO_URING_CMD_REGISTER);
>>>> +
>>>> +    sqe->addr = (uint64_t)(q->ent.iov);
>>>> +    sqe->len = 2;
>>>> +
>>>> +    fuse_uring_sqe_set_req_data(req, q->qid, 0);
>>>> +}
>>>> +
>>>> +static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
>>>> +{
>>>> +    /*
>>>> +     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
>>>> +     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
>>>> +     * the kernel by default. Also, max_write should not exceed
>>>> +     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
>>>> +     */
>>>> +    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
>>>> +
>>>> +    if (!(out->flags & FUSE_MAX_PAGES)) {
>>>> +        /*
>>>> +         * bufsize = MIN(FUSE_DEFAULT_MAX_PAGES_PER_REQ *
>>>> +         *       qemu_real_host_page_size() + FUSE_BUFFER_HEADER_SIZE, bufsize);
>>>> +         */
>>>> +        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
>>>> +                         + FUSE_BUFFER_HEADER_SIZE;
>>>> +    }
>>>> +
>>>> +    for (int i = 0; i < exp->num_queues; i++) {
>>>> +        FuseQueue *q = &exp->queues[i];
>>>> +
>>>> +        q->ent.q = q;
>>>> +
>>>> +        q->ent.req_header = g_malloc0(sizeof(struct fuse_uring_req_header));
>>>
>>> It's probably easier to embed the header as a FuseRingEnt field instead
>>> of heap allocating it.
>>
>> Hmm well. So we have two additional patch in the DDN branch for which I 
>> didn't have time to upstream them yet. These patches allow to pin these
>> buffers/pages and with that the application doing IO can directly write
>> into the buffer - saves context swithes. The initial RFC kernel patches
>> were using mmaped buffers and when I had to switch to userspace buffers,
>> performance went badly down. I didn't run real benchmarks, but just
>> xfstests  - with mmapped buffers it was running like 3 times faster than
>> legacy fuse and that advantage got lost with normal buffers that
>> get mapped per request. Switching to pinned buffers brought back the
>> fast xfstest runs.
>> Issue is that the buffer needs to be page aligned - which is why libfuse
>> takes an extra allocation here.
>> In libfuse I should probably make this optional, as pinned buffers
>> will mostly only work for root (needs locked memory).
>>
>> In principle I would need to document these details somewhere, I should
>> probably create blog or so.
> 
> That sounds like something we'd like to try out, although we try to
> minimize privileges needed for qemu-storage-daemon.
> 
> A question about pinning and resource limits: qemu-storage-daemon uses
> O_DIRECT for I/O as non-root without hitting mlock resource limits. Is
> there a difference between pin_user_pages(FOLL_PIN) (for direct I/O) and
> pin_user_pages(FOLL_PIN | FOLL_LONGTERM) (possibly for
> FUSE-over-io_uring pinning) in terms of resource limit behavior?

And O_DIRECT read/write is just pinned during the time of the request and
and from the application doing the request. Pinned fuse req buffers 
(header and payload) are pinned for the live time of fuse-server.
Right now that is (nr-cores * queue-depth * IO-size) + 4K. Patches to be able
to reduce the number queues will go out today.

Btw, going to be on vacation from tomorrow on.


