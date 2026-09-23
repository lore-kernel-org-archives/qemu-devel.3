Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD80C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Krw-00058J-KD; Wed, 23 Sep 2026 07:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Krr-000543-6e
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:10:29 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Krl-0006RL-PD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptxYe/aYQMgHFg2TUnB4Kxho2Ed5eMM3SdZqBjNzT38Uq9RGWE6DTr10XNXv3x8i1NNvlK/8KlDgPNtgs0amwDKX+stUXTDWh3hdaRUDYSfqz2majHuTtvO7C+k2lK5+pNKOTgrJFCm1NpETB3PgeesYXGTOs3AMGYfPl7TDNliCtGgWT0CCn4xOC9CeSf6LndhLKxdsypjpVmcuE1hNBNlsibKFuSgi7/MvKMEqronWf63oHCiycoJcoZVpe/tbFJu7dbRR0irg1r7Y+GBf9tIKW4oqOV4P4PQ/VNovTSDIT7j2IFEvpyQZerMpfx7HgummqCuCDd5RPpp9ij3qOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/+6gLjBc5O6uyZFnscEnH54rBJCw778AX+Z4xAHSkE=;
 b=QYUXEqPkExb9PGu2rUy5I3dtB8ag5btAq+jADZ2vpLl6NcVS+75VLw47V8WcaJ0oUigC6RISx2bdCpr51IfdpwNp6mIcDaKAvpZB2mbeIngcwjDaV5KsuSV705zG++CemBoszDxmMB3S2p4vqfRjSssrJ3+qGGUeuACIU61HC80OyEw45GFihPaFlpO4AkgCvJ9BJ0lfQeXnsUf8TI2MhthWOZjNvLs06vWoUIkjmbS0jvf9goXKu2WoBuLJk2KvbxtJdMioDMdd5tyUFWyDQ2cCJAlIjgLKvHjkYu+RLDzKoU5ys+i9sftTa53CZE0RuLow8qfZu77H+qZ2I84eTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/+6gLjBc5O6uyZFnscEnH54rBJCw778AX+Z4xAHSkE=;
 b=ZL6Ui3yrg4+Ni8eZ7y1wdHPDZhV6Uo3A6pSUpXECJJcRlpsV7mSqxJzHcFkR1AJLTSRu+1z8dHpA3GdaTTw9hyXDc4TgdnD3GLymc59gTmVtumErMynX0B2GADZ00XyUmf6WfDA8NttvdgqCJffaknTqvx74Y0OU1qhYZU5f7d9ENTzYp5P7zfL2Ll48lMGfq/Q1TYFU0S1LYE2FXi625gCf4LhpJMQfTJtd5Q+iKb47XaGoiQFKYUyNjjdOAbZoI2EXCem9zJgz1zZyPWqtUDIlg1/zFThr9ezNPM3x88yxmoTQwIMqA4z7qXyCnkcSpEyFvppJNZ7C/D4QjZC5Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9810.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.5; Wed, 23 Sep
 2026 11:09:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:09:45 +0000
Message-ID: <a4ebbe6e-72dd-4769-a9b9-65ecd278bd16@virtuozzo.com>
Date: Wed, 23 Sep 2026 14:09:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] migration/cpr: support vhost-vsock devices
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <arJJ6K7A49p0AHGD@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arJJ6K7A49p0AHGD@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a0afa3-4c7a-42f3-0f76-08df19632c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Lp4u0MDYkWsrNFReY1m1cYUD8Ke/bVPdILb+T0R1oC9mgJGg/2aEirsUKjBhU2PdeWR+DfLdr1LxSkOvqQhBmHpvCSgfGpQ1T9idedlHHpFGJQKmYyMbXEl2OpJkx8O5nJE2EKglfY6/vdYHzSap5s3ewXgu4m4MY3MJhwB41f94R2Em+JkWo6TMbhAyvua/ALlyf5kQhriJlOMLEPMi+JsFuPceNYHxRyHgGFn4TMrH1iyexi+DgM5GAmY+We5BLkZoCFuqOlwLxSqv4OZ1JFUjVO0pSfC4aPfyTBD9l9YB6YeG3lk8/e1sENbCekdJkQDX+F9B3gsvZLQFr+Bh0y9UByKldUQId57zihN3VjWNuCUohzsZF4ih46wxvY00C31cKxl07BEXb34TMjs8M3mvsDevPsAsy+6UWTgJvi2NC4w8fGEOxIXHr7Ll5OCMzZPpwF+nVfyDGnAXA5HPLf1VWGOHulriMos1/52venkcmdU/WYOiG340JGGkn0Re3n4ave0g6eHtUFGKoeLqzlxmcLAnHjIwDMm+ORmOwEk3jnbrOycVJ/X/c3eSijWcdx1AbyOgytzpsYnemK8UAqRGJJazEwb6j46onn9PaMDcLKfMvu7+CRdmdgkkddw1dxNPdJrGTWL6gqVcokcOjjLUXtL6RcDgHaEqAfaIqp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBPMldBUFlMYWFBZUlkeTdCMUlmSXJCa2F5aWlDc0FuZHZPZTY1ZFAzN0FE?=
 =?utf-8?B?akZQaHZSbDhRd1QwNFV6bTl4d1haVWxCQjJLTDE1T3AyUE9hcHlPTXIrMWtS?=
 =?utf-8?B?K3pTc1lpeDlySlJpZUFiSW9XUm16T1pucVFiV3lzdHlCT2FxTHRuYlMxbVBZ?=
 =?utf-8?B?NHZNVURpR05UMlJWSXBCQStZVVZ1Q21XQ2pYdEpscjU0REJsTTNjbVRNSzZN?=
 =?utf-8?B?LytzRXA4WXBUL0hqNjRjaFM5bXZGMWEyNXgzMkNReTUvd01EVjBodUt4K3Vw?=
 =?utf-8?B?enZldFBSYWRWQ01sRzFYN1U5UFNaelVIdk1FTDFFaDlwZVpSSzNUUmdKY09R?=
 =?utf-8?B?dzMwaTByaWlwa0syb2UrRkRHZzY4cmNEQktJS3ZXSmxOWk13cU9tZ1RtdWtS?=
 =?utf-8?B?dzZEblBlWHF1RHBtWVhsM1JFL0lTRU0rZVZ4ZW9SQ3BsMURHUWwySjV3MFdq?=
 =?utf-8?B?cEJZeUVXVUpxUnhHY2JwMHM0TThiSWE5NTdEL0w3S090UmE1VjJLN3p3cEFV?=
 =?utf-8?B?ZmE0QmMyWXRWUTc4b0lrWHpFQzlVT3Q3amhNNVBhNjdPYmNHY2FlMUtYRXcx?=
 =?utf-8?B?Sk85WEF3STdjclB6U3laT3lCS3lXTzBHSnJUelpCWHNZMzhCajV2WktiV0JK?=
 =?utf-8?B?ZEs0Wk10d0Jmb1MxMVNCVkp1eEw5Qi9QT3J3TWdBbzN0Y0FtNml1OFpGLzRo?=
 =?utf-8?B?V0dRTGhwS21lZjlPVU9MZThLWmtkRU1jMWZhWS9kZGJRQ0pZdTVFOUdpY1Jw?=
 =?utf-8?B?N2laWStKODRtWHU1bURFMStEU3V1OEdhMTZwbytyMTZDdkw4Z0ZwbXc2THF5?=
 =?utf-8?B?Yk53S0l5UUtHOXdQMUNYVHhjUkk1ckEwOFZtSGJJbld6YmR2enNJMmVXUFVy?=
 =?utf-8?B?Tm9Mc3h6enQ0eE5oVC9qZkx5UXlyNzRKRDF4VVlHeit5ZVhwZnlSTWQwUmU0?=
 =?utf-8?B?UGRjSmNVSnlDR0I0SnZJeGtqNUhUaUEyQUtyTzdNNnRBWHpWMVd4YVkzQVla?=
 =?utf-8?B?WnpxR0EwblllcTByUit6MFJtY0lXamlUbG95YUtqMjNNVzBhSFpnRFZPZlpj?=
 =?utf-8?B?S1l2QUs5L0tMOERKbWhxdzA2YVVWUUVaeEF0VHl1REorRTh4MVlVOHhNanJj?=
 =?utf-8?B?YXhVZDdGZ3BuY2JUQ2lrWXhMbWR3bjFuK0pLY1JSZXVqZWFub3Z6ZGtNZ2Yx?=
 =?utf-8?B?Q1pNeW9lMnNjZysyc2hleEowTXhZeFlLKzNSZHEzZDBPR1pzb2h2YVRLeGM4?=
 =?utf-8?B?WndQZnBib0RmUXpvbG90WWRDaGM4bXJBL3IvOXJZNTA1T1pYK0Z1cmh4c3Bo?=
 =?utf-8?B?VzlXNm5nNVp4OHlwUUh4Rk5ma21hZEdHTDZZS0l1YlJiS3VsUkVqOXFoUFNF?=
 =?utf-8?B?U1kva2Jkd1RWclE3UmpRQklzZkpZajIxaGN4UnhoNFZTby92WmJrcGR1R0tm?=
 =?utf-8?B?VnFNdENWbHFPNXBpNS9oSGNaQ3Vlb3NSYmpFMlN6Y1RseVY0NUg2ekdMT0Z0?=
 =?utf-8?B?WjZFY0pVZmV2dEQ3MTBoekhqZ3VKZDRTcU83c0ZTUlJUOGpLVUl6aEVjZWd2?=
 =?utf-8?B?WW8xdVlIV2FXL1VnWXlHZXl1ekRWNkpjbUI4NnhZUk1Nak9ZNnVWM3ZXdE5m?=
 =?utf-8?B?QTVYdTc4ZWw4UTBoMWVjVkQvMUh2YkQ2NXlKeDFnVndhUjFaN1VjWVlOcVFr?=
 =?utf-8?B?N3h4WDRIcFBQbFNydnE0Q2ZTT2hxWWk0SEJzYS9lYmxYT0ljbHFPUXk4UmN5?=
 =?utf-8?B?QXB1Nmt5VlBPMSszeGk1UzlsOTNSVTdJMVZacEg4a25WU2piL0orVGtKcUhT?=
 =?utf-8?B?bUZ1M1ZlU1FFYmFtNys0NTNNcUVUZHE2K2l1d0NpRFcrTGF6SjlVZXpTNll5?=
 =?utf-8?B?VVlzV2s0WlJ6U3dTNE9JNHBxNjZXL0NUMkZVMzl1U2pCTm02U3dLTTBjQitJ?=
 =?utf-8?B?VTlzREUzZnVUbGw2aFRqUHNMTWR3a3grYndUZnNWdStoMUppMk1VUENJd0J5?=
 =?utf-8?B?Mi81c09ybDA0WlYyT3BhWS9VRVlzZnRYSkhNL1hwQjU1K2MxOWxYajhKR0tw?=
 =?utf-8?B?RFNDTGNmRkJzakhGamxIc3VtUUU1dTBLM0tPMmtPK0QzNFlKcDNHZHp1OW8v?=
 =?utf-8?B?TDNlMmM4TzRLYmR1WnI1THdjQUlseFRHWis4Z0dIdnlmakticE1jcFo5SlBi?=
 =?utf-8?B?Y01oWnl6MEFJVjk4Y0JpU3U1dTlJVFdydlkwL3Y2M0gwWlNWTWE1Q0plRUZs?=
 =?utf-8?B?ejlDbERwbTcwQ0FvOERGUGR1M21zTnVZZElESmZueTNzSnJzeTlWVW50ZjVK?=
 =?utf-8?B?dDExQXpXRVJQaTk1L1J0MDJibzFxZWFKMFh2UlN1QzNIa3h0SEZybG5WSFha?=
 =?utf-8?Q?qOw9IyKbJn6Ga5ic=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a0afa3-4c7a-42f3-0f76-08df19632c8d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:09:45.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KP/nnVLSetJua2dswngfYtoX9/rw9R3lbkE6hn6KzaZZKxQjg6XPX9FsbpZnDtXLTa8sR0ArFNR84Pr2n0HdSHpTA+NMVscFvQsC1+Xx78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9810
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 9/22/26 12:30 PM, Stefano Garzarella wrote:
> On Fri, Sep 18, 2026 at 04:46:51PM +0300, Andrey Drobyshev wrote:
>> v6 -> v7:
>>
>>  * Patch 9:
>>    - cleanup closed vhostfd here rather than in #14;
>>    - add !cpr_incoming guard before saving CPR fd;
>>
>>  * Patch 14:
>>    - remove closed vhostfd cleanup (moved to #9);
>>    - lift !cpr_incoming guard before saving CPR fd - not needed with an
>>      early return;
>>
>>  * Patches 15-16 (NEW):
>>    - add qtests running cpr-transfer/cpr-exec with a vhost-vsock-pci
>>      device attached;
>>    - add functional test with a live guest doing host<->guest vsock
>>      transfers across a series of CPR migrations.
>>
>> v6: https://lore.kernel.org/qemu-devel/20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> Andrey Drobyshev (16):
>>      migration/cpr: forbid saving duplicate CprFds into hash table
>>      tests/unit: add test for duplicate keys in CPR FD table
>>      migration: forbid snapshots in CPR migration modes
>>      tests/qtest/migration: add test for snapshot rejection in CPR modes
>>      vhost-vsock: block CPR migration modes
>>      vhost: add vhost_reset_owner op
>>      vhost-vsock: don't reset connections during CPR
>>      vhost-vsock: fix FD leak in realize()
>>      vhost-vsock: preserve vhost FD during CPR
>>      vhost: factor out vhost_dev_init_backend()
>>      vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>      vhost: add vhost_dev_is_initialized() helper
>>      vhost-vsock: hand off device ownership across CPR
>>      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>>      tests/functional: add vhost-vsock CPR test with a live guest
> 
> I think I sent my A-b/R-b to all vhost/vsock related patches (if not 
> please let me know). As for the other patches, I don't think I know 
> enough about CPR.
> 
> So for vhost/vsock everything LGTM, I left just a comment more for my 
> curiosity.
> 
> Thanks for the patience and the work!
> Stefano

Thanks for your patience and your reviews!

Andrey

