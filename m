Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A2C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHgfj-0000PA-Uy; Wed, 21 May 2025 06:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uHgfh-0000OZ-JO; Wed, 21 May 2025 06:27:38 -0400
Received: from mail-db8eur05on2071b.outbound.protection.outlook.com
 ([2a01:111:f403:2614::71b]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uHgff-0006K2-La; Wed, 21 May 2025 06:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI513UBLuLfV/fRBkjqiQASwNwCG01I9XTsxdYVquTEbXnTcbUDLT1GDpGOnhFDPD90ONx57m+ofujLGsf9APrhJE82PvslRLGNr0WBtJCn1abfux+IVY7BmomSTx8QZty94mST+HJ6c2bPLC0ak3N+a0E1moCxSIgq0VFlRDSv7i7BS+Ua7qPFre0BGQ5Eop7AKSbAEjOZc6MaVBTmE8O6JHpAzizHTmdX9dkYeSjU6cePleizw7kDAk+htANs3YPz1gsY00CBLDlhEV0a2xWv5aUZYHg0dV0cMqw1q3XE8OBGOz75nkQ7DVvMLrdEV+Eji8eEEpMQyJzQu8GIPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VfaTRQN7/FXsDOrXWgMo4tc2nnHlTxA+4kvifnqlC4=;
 b=yUYFZphcu6P79XhgtaxiTZUvdr8AIZhQKqrL+ux5yJXFWMnDGL16DpNB1k4o+Z9E8bzYogf2eVNKop2u5PquRPBsvo42QFylyYsfdDskbiiJzcOf283arLwMhOSlZyeT7+Msj7Y2cL73LazX+2/ze4Q2knZHt5MtofgBzQrBxUW4Zh8O5H4pPztcv/29m38Xx5d8dOwL/QLK4fy+I2lCaBNEJIB/WNMYeQJgnj01uX7NeqQYKRB8jwr36fEW1oA7qDuLZQ+R+Sv327/Z4ArwooE3MYTOf+ZxoA1Yzdv2UHedYTRth85mZSh7y+BpnuZKxRnMLHE1E0CbbvPDf6bItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VfaTRQN7/FXsDOrXWgMo4tc2nnHlTxA+4kvifnqlC4=;
 b=MraiCNApvtyUrD7pqUq2cnMryC747W9vCkMOL2GWE0xsLYK6tAvM9Rib3CBRmbSJ0ZdkhI92lwN9eE6GiFwk+FrdBF5ssaVWAeZIfLSzXOfYba7Wlg3XCNZ2GWc2bA29u7e8eE8eeQDEDDXx2Zp/IQJ3n7nSwn3JV90EBZ3lFPBRgWNYADY1zlBUqJrMfNbP0HhYAtlSMruQk28hUzM3LP1K1MvYxaiWKO9UJp7sPjBcxxgAsrow/lqym94xBaz61udlWOxA65hcEaOcHciZKqtTKyfwJPViyfwdRi2YJuxjCSmZUnKEUF/4Qq0de5sZmvNIyLFvQquqca434yFGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by DB3PR08MB8795.eurprd08.prod.outlook.com (2603:10a6:10:432::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 10:27:32 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::e543:a83c:a260:602b%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 10:27:32 +0000
Message-ID: <f309622e-dbab-4e2e-b153-36cf631ceeb0@virtuozzo.com>
Date: Wed, 21 May 2025 12:27:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/copy-before-write: reverse access bitmap
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
 <20250513013238.1213539-4-andrey.zhadchenko@virtuozzo.com>
 <exbcf5hpdrc7lbcyhjgh4movj3fo2xt3sync62icuierlbtzeq@3z6venb5sxfc>
Content-Language: en-US
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <exbcf5hpdrc7lbcyhjgh4movj3fo2xt3sync62icuierlbtzeq@3z6venb5sxfc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|DB3PR08MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 26518884-4f2b-4533-80c1-08dd9852187d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW13ZFBycDM3eWt3anV4Z2NyT3VPeGViMStVZGFFNTFZMGZkSDlmeTRSMXRu?=
 =?utf-8?B?cHFPUitrRnRXQVhUVXdsZjQ2M3k3aWdubHN3UmhCcllIV0FsWVNZMHgxZFQ4?=
 =?utf-8?B?NEk1dDlWeHZ0T1RBZncwbXg4UTJvUGRZK3VJR1R2L21WNXJZbzE4a1RVSFA1?=
 =?utf-8?B?ekV4SHFRem1aalMvTHhHTUxVeU5UdlNpeDBnV2FqSm5rNmpQd3pNUyt6N0sr?=
 =?utf-8?B?dXN1S0M1SkNmZzNDejUwRnduSmVFYTFJeTh2ck1NaWlPUERxSjdTOVRWazE4?=
 =?utf-8?B?QUJNQlNnK0RLNTAwRk1FWkJkQzVWUEV0MUZvQWhFUEpHVkFLSmZHeVFERDRt?=
 =?utf-8?B?SHp6RkZoNlVwZmRFTlY1YmpTWjY3NnQ1Y29zVDkrQWRwSzBWQUkzSU9UL1dD?=
 =?utf-8?B?Si9mRHQvaFlPNDIwL0hhejRyeDNjTlQwSEpKeVVwU3NxeDBzd21YVmxoMUtw?=
 =?utf-8?B?eXZ2T0txU0NETW5VbTFRc3VtUjZVRzFRQjcwSjNSSmsxNkQ2bk9RTXFZcnVk?=
 =?utf-8?B?eGdaU2dMZndYa2hKemRXUHdxUGRJR1NXZ0NQd09QN2RDYkFDbGc5ckJrcUR0?=
 =?utf-8?B?M1JvL04rOUtNTHFWTmtYNjYxUWhYN1dKbGtQZ3lxdzdTMVlrcWlPMEVIdW9K?=
 =?utf-8?B?NTR5UDZ4WTkwVXFiL3haMXFrcXJ1RkQ4YS90U3JMRE1PRTNmVmVzcFJhd25u?=
 =?utf-8?B?anpyNkxNYmVwbFdzV29UOUt0SHJkOTFiSllUeFo1d2lZWU1EYmtMY0x6M3gv?=
 =?utf-8?B?TXl6MTArV2JDbkMrVW5saTRjOVhuVjBEWGppZVJzak5qV2hGekFBVlNhSjEz?=
 =?utf-8?B?S0IyNjF0ejNmTFQxWWlaS3o5Sm0rS2xGeXlRSHArUTRVbkhIWTVOQ1U4QXpW?=
 =?utf-8?B?ZmdPZGtCYnZiN1F4YnlRT2FkT05kRGE3Z1NHRFI2TGV3a1ZxVXprRldERVVn?=
 =?utf-8?B?S1QzcnFiMG45TVVzQXpPTnhTaVd3RjBLODdOb2VHbVk5TFgvUVFGRkl4MTF5?=
 =?utf-8?B?Zm1SUXVTdVVUb3JwNmxuemkrYkw2aWhLY3M4VDJDd215RStKdzBaRUhUTkJQ?=
 =?utf-8?B?dmVtQWp2OTh0M1puMFRkdEFnY09oWjkvakc5OHdicS9qZDVOdXlLcTlvc0do?=
 =?utf-8?B?eDB6akJLaXJQVVAycXlVb25RUVdwci9hb3FqdWNEQWlHSzlJWXUxOHcwQ2RZ?=
 =?utf-8?B?cEpaajE2dlpYaGc1OW5PRVpmWER0c1Y2ck01VEtuQmsxUCt2TWZNVHR5RWpP?=
 =?utf-8?B?eHVsNThNQkxxMGRXUzBPMzRJSG1JU1pNQWRnUzVPa2tLSFJERkxaZG5oeU9B?=
 =?utf-8?B?OUNuZWM0c3k4VVVLVjIyV0IvSEZPOXV2bm5GWkFtWTA3eXVIZW4zbFVnbWo0?=
 =?utf-8?B?b2hHeUlvUWF4cFRRbVV4UVpGT2ordFhsMXBQemFKeE01Qno4R2RwT29pSDJj?=
 =?utf-8?B?UHRvUnU0RjdlUXc2WkZHUGZHTXFrREEwM0VGazFMUHJ5UysrQ21SOW5OaTV0?=
 =?utf-8?B?eGRxNDBaQkhJd2J6ZEU1N1ZxL0pTNHBydUozdDNReUdWSVV5aDVoKzJ2T0Uw?=
 =?utf-8?B?ek84bVRweU5BY3pOdldJQzY0SC9LM1ZZMmg5UG1SeURIZnNDaHpzZWp1UGZN?=
 =?utf-8?B?VCtYVmx6blNxRHFKQlhMVllDak85N2I1cUI1d2hYL2tVVVcwaUVEdUV1MEtD?=
 =?utf-8?B?T1YydWtkYTAyNmJ1a0d1Qi9BU3ZoUjVWT0huam1BSjZLZXJ1TitycENDR01O?=
 =?utf-8?B?bG5CdXpyS3N1UHRVaUxEL3ZybVduWXUvMnhsb050eDZqYzRUc1c2Yi9scVNu?=
 =?utf-8?B?Z2ZmL1lFQnNqOWZySktzcEZpSnBjQWlFMTA0elFUNzZFb0EwaU1aS0hieFM2?=
 =?utf-8?B?WDlKT1JqWWhkZXk5SjhVeW53VlRVTmhLdnpvSnlFbEVqTGRZQ2NON2hjRmlT?=
 =?utf-8?Q?A7eZgxmXhFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGJXQXpMdGlKWXVOdzMwVE1pTVFhdXlrYW1GSXhRL0FKWEkvVUVNVjZEeGla?=
 =?utf-8?B?SnFqWkc4S3o2MGRWV09tWC9pcFV3bTgxMk9RMGJQcmI1Yms0ZlplYnlpZXlu?=
 =?utf-8?B?NjQ3V3Urb25laDIwRTdBSzA4NURUTTBJYjdraU9kN3hDS0xwaGRvRGY3R2Vl?=
 =?utf-8?B?RVRna3ltVm1UUDlJOW1UMVdVc2FhSE16eFRyTWNvVnM3bGg1UWM4NnVBcC8r?=
 =?utf-8?B?Q3RicFpGU3NsMldBcFhxMGgzaEJTbXVvSVB2VVZ5cHRSb2gvemppcFczUyt4?=
 =?utf-8?B?WkczaEE0VjQ5OWlBcW4rd0xpRXI3bThIQ0VIeXgwblRUVDVQVGdqc0lQTU5N?=
 =?utf-8?B?U3dYMVpGcG9za3pRYWgySnNXMzVmMFltWm1sMm1ONWUzZWdhMERudDFuOWw1?=
 =?utf-8?B?NWJrZFlqMFVtMlRCbTgxUUY1NGRSc2xxNzVVNzNnL01iQ3lubFRUQlBLOU5h?=
 =?utf-8?B?K3hUQjlnRjRCM0FmcDYyMzFzOFkvcFJmWWY2dE5OZnZyNGl1bmxpTk9qalNp?=
 =?utf-8?B?U0dweUFxcjhZaWpTZHpQQ0FKQXpOTDNoNi9SVkNZLzlXOGtnZUVpRThwOVd4?=
 =?utf-8?B?L3pURUZmWlJYN0pabElGd2YrakFNcEl4V294bm1MeTY0MmkyWEU3bGg2Mld6?=
 =?utf-8?B?M2NkbzlsU3dFU1RCOEN1YW5VRE5TRGQxY1oxczZ0OHdTSk0wUnc0dkhGbWFp?=
 =?utf-8?B?a1VRWEIvdnlDTnRFYzNpQmxyWjlzZ0hRWG85eE5zamptTWZsSjZpOFdORFZY?=
 =?utf-8?B?MFc0a2FsYjZ3U0t1S1J6Z3hoRUt5bEdkREhiTjByYUhGbmdLUDlLeWlnN1Qr?=
 =?utf-8?B?b2ZHTTZTYUdXbk9jZys0enZEZmNWRllHdTBGMHFsdnZjQnFCNTl5REdUc1Qr?=
 =?utf-8?B?R08ySWtzZDFvME1VU2ZHb3JkbGZMTUluUGtSMXEveUlZVVQ2WWpDa1FTVmxK?=
 =?utf-8?B?UVh5N1VWdkxqWHk1ZEFINmNHSS9mUm5yWUdRUmJGMUQvU1ZtNUZPOWhYZFFL?=
 =?utf-8?B?c0w4R0FiRGVuR3YxMC84bTJqQVB1R1pabzhpb2FyZ2dyekMwNWRDUE5rWXRR?=
 =?utf-8?B?NjlIU1B4eGdJL3N1djhFRmxYSyt5T09pWHEzY1JTTUs0TWxBN1ZiQTJVcThi?=
 =?utf-8?B?VnZwQjBjYW94UUhXeDgxQWVQU0tHWHh6U1RxV2lGUk8yTVAzblEvNjNpa0pV?=
 =?utf-8?B?S0tWcWdLSithWW5DMEw4djRaUVFZQzJYeWEwaEpwNW5oZlVrUDY1QVJrNlpE?=
 =?utf-8?B?Wmc1SDdnSlBSOGttZHRhcjI3QmhyQkk5dEczWDVqeDZRZ2plMVdOMzZPcWJP?=
 =?utf-8?B?bWpuLzJ5UTZRSGRwM0NPZ1IxK05vVnFXVk5UREFOT0FjaGJoNEh0azFRL1VF?=
 =?utf-8?B?RkdMSkRKWUxBUms5dGdlaE14TDdnUDBKOWNaQUxmQ0RtYUpJMnBrTjJXcFNi?=
 =?utf-8?B?T0l2TnQ4dGR0TzdWZk5tUGpoVFZXbDhpNzc3SkVqUEphQjJyNnY4ZzBzTW9S?=
 =?utf-8?B?SkpPcTNLZ1Y0TGhOZ3VLNksrWTdjK09kWHdJcG9DQmdEaWl1aTE0SjVsUjJY?=
 =?utf-8?B?dlp2YVhtUThpZXFYTzluVEFpaWVhTGxXZG1HWGhtOWhmNXRPYjRTRm1vbHR2?=
 =?utf-8?B?WE5RNi9uT3o0TUh5SmFjU3c2K2U5TGZHRVdoWUF5RlV3RVQ5cGpOMytWNXJn?=
 =?utf-8?B?Tk56NTB5VVlvMGJxeVowdVpRQ3AzeUMrdHRNL0ZSNTRQODBhcEtLb1FBMDlU?=
 =?utf-8?B?bHpBTmpOZGthZldhQng0QlI2RWdrZ0FBK1BhZmFsRXVla2U2Q3VBc3pXZ3Fa?=
 =?utf-8?B?VXdJUGNEOU9RZGNGaVhMZHhkcy81MWFYRFJjdmFuMzVManZibnkxVkhUMkh5?=
 =?utf-8?B?bFprRnpRZzZyVDBhbXdham4yTC9FUXhZUFEwd0hVMUlBY3lZR2tBZlRScWYr?=
 =?utf-8?B?TGNtY2FjRWdXTXRUYWVtbnl3ZTlucVFZTlhCaXJDVEp0RjlxWG5Fa0xZQ25V?=
 =?utf-8?B?ZzFFRDd2OEh0SDlMTEtiMVVrU1dHa2hhL0tGWkpMaE1IanZaMWZJcytWaStl?=
 =?utf-8?B?REFybVp3V2JCd2NidzJXemVTSFJTREx3YUFFR3EzUjlMVUN3QU1xMEpqWGJF?=
 =?utf-8?B?bHdTMFFiQjgvTkZ5dnZ6ZEFpdm9DV1E2d1hGTjJpcGJMeURZbHpqaExacXNN?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26518884-4f2b-4533-80c1-08dd9852187d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:27:32.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTDrfgrVWHVl3ppOdGuTIN3lxeBs1MpqtN4QFz+apJn8m8rCf7CQu6dMdxYYBFIJhViw5K5cCBe7lNOd5vYGFeju36fW1V8V1Xa0xwi6xc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8795
Received-SPF: pass client-ip=2a01:111:f403:2614::71b;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 5/20/25 19:26, Eric Blake wrote:
> [?? ??????? ????????? ?????? ?? eblake@redhat.com. ???????, ?????? ??? ?????, ?? ?????? https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, May 13, 2025 at 03:32:37AM +0200, Andrey Zhadchenko wrote:
>> HBitmaps allow us to search set bits pretty fast. On the contrary,
>> when searching zeroes, we may be forced to fully traverse the lower
>> level.
>> When we run blockdev-backup with mode=full on top of snapshot filter
>> + cbw filter, the job fills copy bitmap by calling block_status()
>> with range (X, virtual_size). The problem is that we check for zeroes
>> in this whole range. We also hit the worst case here, as access
>> bitmap is fully set and we need to scan the entire lowest level.
>> After scanning the full bitmap we actually ask the block status of
>> original image, which may return significantly lower amount of empty
>> clusters.
>> Beacuse of this, the backup job 'hangs' on block copy initializaiton
>> for a long time with 100% CPU.
>>
>> Example copy bitmap buildup time for image with clu_size=65536 and
>> preallocated metadata
>> size                 10T   11T
>> blockdev-backup      52s   57s
>> cbw + snap           325s  413s
>> cbw + snap + patch   55s   61s
>>
>> To fix it, reverse the access bitmap in cbw filter: rather set it
> 
> s/reverse/invert/
> 
>> when the user is not allowed to read the cluster.
>>
>> Update qemu-iotest 257: now access bitmap have count 0 instead of
>> the image size 67108864
>>
>> Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
>> ---
>> @@ -501,9 +501,12 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>>           return -EINVAL;
>>       }
>>       bdrv_disable_dirty_bitmap(s->access_bitmap);
>> -    bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
>> -                                     block_copy_dirty_bitmap(s->bcs), NULL,
>> -                                     true);
>> +    if (bitmap) {
>> +        bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
>> +                                         block_copy_dirty_bitmap(s->bcs), NULL,
>> +                                         true);
>> +        bdrv_dirty_bitmap_reverse(s->access_bitmap);
> 
> Is this setting the bits correctly?  Inverting a bitmap is a
> reversible operation, but it looks odd that you are only reversing
> once around the merge.  Either the two sources of the merge have the
> same sense (whether that be 0 for dirty 1 for clean, or 0 for readable
> 1 for avoid) and no inverting is needed before or after the merge, or
> the two sources have opposite sense (in which case, I would have
> expected inverting one of the bitmaps before the merge to get them to
> agree on sense, then merging, then inverting back to the desired
> sense).  Am I missing something?

We have just created access bitmap a few lines above. So it is empty: 
everything is accessible.
  - If cbw did not have any bitmap, we don't need to to do anything
  - If someone set bitmap on cbw, we used it to init block-copy dirty 
bitmap. So to get the access bitmap, we inverse the bitmap that marks
to-be-copied blocks: access bitmap now has all of them as 0 (allowed) 
and not-to-be-copied as 1 (disallowed)

This case is also covered with iotests/image-fleecing with filter 
snapshot + cbw bitmap case: some not-in-a-bitmap blocks are accessed and 
we expect to get errors:

--- Sanity Check ---

read -P0x5d 0 64k
read -P0xd5 1M 64k
read -P0xdc 32M 64k
read -P0xcd 0x3ff0000 64k
read -P0 0x00f8000 32k
read failed: Invalid argument

read -P0 0x2010000 32k
read failed: Invalid argument

read -P0 0x3fe0000 64k
read failed: Invalid argument


> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 


