Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6BACD1284
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 02:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr7Az-0004eP-JL; Sun, 31 Mar 2024 22:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rr7Ax-0004e9-V8
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 22:13:32 -0400
Received: from mail-co1nam11on2115.outbound.protection.outlook.com
 ([40.107.220.115] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rr7Au-0001XF-Kj
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 22:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9D7FprIId+HuQfllFPHA72ei+hD4EnPPlvM56PObXP9tz1kb95OzSEjCVy7XZ05HruZzG4qPjeTbiI25btfb5zpHqBIf8bJfoKMvW34/4Q4RwxutECcy+PVYkhlKUmobktLLceVDGeoi0VtBV4jHnnX69yWPAuu/KGgbGT+kJDYqlwgHVuCKu9vBUhHJ3kRXrJuAurHOfDai8HJU1Nr8eNoT+rtfhgWfFhRBwuqTpe/WbQmKAGfC5phYYeBd4+nu/DL5onECuH/GpXm6DVDePSrZdwxplLKdvF+yY+znk38/fF4rOgoXoQV4/F9u/76/CWee/SMbA23oIlKBipgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMiGEeTw2GfeX7zBSRV3bKMeAxJZPpLYgDa4SBJcQIc=;
 b=WSIs4zOV6XYnVQztLdZckXWUA9+q9NnwuM+zx0+YChiRmVbvTET5yGdIxR7soYyCMjSyMRPcN/1hmB+CDYBoTgmLEiahROwJvVny3J7/gNx88A+Zx+VuSAqnWKs5bwTl0jMBmYt2z0GVW4xC08nGjV0B23If4q4KBq9O+o6Xl+QdJImX0OP2kwvMJcWrUlgl/MA608a0fD3jpBmYoeJhjPK+TTqXa/eQRCQqMv2kHMQtE1es56VSRvfDz1tT8MaZgj5VbqLCrzKmvB1FAu2nB/VrWIdvVCYvOtheren8AFWql2saRk5aLKZhasZcEoULvX5NMsnzl7DhnDL1Kxf2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMiGEeTw2GfeX7zBSRV3bKMeAxJZPpLYgDa4SBJcQIc=;
 b=rUwP3YnBL3dNZeVyo285HBXhLs7yYyHPg2ZQJ8nu7WpgnA51/neGsxzhCA/oNPVA2bi1K1lc5pXSbqdCzFvenBFwLNXd5hHzdNPP4BVvGBMnAIyjcxEwwdgFmdH2twZruVkJ2/PEaGT5nCqUAOzroQ4fgOlApuL9g0jl+Q9f7XxqYHvTvvWJCZYSkzyDmrFTFh2hVkLJbT7DHwV1/tQ2eI+dsEBUH41/FHV6iopaURcXhw1bJQIg6gITYs6JPIdGz142hQ1AsEiJABYvlQy7NBVYuP6HHAyCpXqBnHdlBYJ0OETR3WBhvw+pNSxWs0H4gNCAX/uoMAsOziXdh3hBXQ==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 02:08:20 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 02:08:19 +0000
Message-ID: <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
Date: Mon, 1 Apr 2024 10:08:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: vhost-user-blk reconnect issue
To: Stefano Garzarella <sgarzare@redhat.com>, ",alex.bennee"@linaro.org
Cc: "fengli@smartx.com" <fengli@smartx.com>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
 <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|MN2PR12MB4160:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySNuPZhQ5PmwMTTSKn0dF+seJ2K14hwbtDLVdYWEF4ayX/5g95z/znMkkPhW7CeLQhBiiMNkfd6yuX2a5w5U8KkliPV0NvUYlAyw/ojDVH5Q51cGCOa7nDrQykEsaDctKvZIpe10n798zZJXUT+5sPsHgX31ZxnooL2p5z6M88xuhKj6gPD3IZeSmHqNiWkP/HWHmNTlUu2/++6GyoB73ME7npwfmNLsd+P/4rFkD+Hgxw7mfyr0MHUImU3U/iR5Ws9XuuaTCBsWXPOLBd3iWXDpKDpk25MQxWjyAqtjq2EF6vQUJaCL2nwNS4F5ujpM9jUMKpDO8aYRean5ypVlho4+YOz4PqfTuBM6SnK5UKZn2uwmN2qJULIoL7H8HYJd9uNA2areNppJMBhSu3Mv5qnw1FKvrrm4SWX/2KFVc78OmDdKB7sbk4IbNOiZgHN3stP6yn+CffcUNTpsA3n6z7YfaJ5yj7rh0cNz3TVHn9rZXYYZwffw7iVYNm6iNR9fvS2IHtW0jjsZ7VhE/UtRkdT/JbsQIeMOcqE8wN1vMNwk7dp0AjY+/gPqcKUY0NLSgIYAXtRjOHtwMjLzbSV01rYYKCRY+cSarFrcuLLFdYZO5GO4LgxFlaDme7pCfZrAkdrbdottCbjOe5spLuwEhJ+zkef3M+VbC00vboRs0R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akN4NDIvSkp3Yk9KU0tOMkxVT0lGNnM0MmJOZ3VIM1ZPUFQwWkRvTXJ4dmxh?=
 =?utf-8?B?YUd5a0ozRlRDbmorTkI5ZE56akFZR0ZwUmMvNHpVYmozb1BXRzluZmwwYU03?=
 =?utf-8?B?YW1hYnJ5d3l3Nnp6UDNKdW84Tm9aZjJpdjRQSS9ZQkdNd1Q5VTlESUM1KzRO?=
 =?utf-8?B?MlNCdHl4cTJXREo4R1lKcWN3a1BQSThvKzJDdU9IMHFWNkl1UDRTT29vbE1L?=
 =?utf-8?B?MHltd0lqVUVLa2hwQk5GeVVzNjNOYkJFQ0QxV1NmSit4K0Vjc2haUHYvelM4?=
 =?utf-8?B?VjBIa1NxWFV3UDlwU2FzV3VmdUdaYThWSmp4UkN2MkZEdmpndDdtS0d1RFBo?=
 =?utf-8?B?M1hXRkY1Zk5xcnN3bXlYMWZEUysvcSt4VG5DNlp5aG02WHJnOXFHV3Y3MnY2?=
 =?utf-8?B?Q2ZjZ0FYb3J1MFk3OUpGcmtidXdCeXpnaDB1YTZYdXduM1lwTW00SlVpekVn?=
 =?utf-8?B?NnZVQjh3M3hKelp6aWZFemdiV2FIa1pCRkpkUVgvRGp2a3BSNUQrS0hyYzNw?=
 =?utf-8?B?eEFzZnZiRy85MEdaSXRwUk1Qa0ZHZWhpZTZmcGRGQjB3SWQ5SEMzNTFpQnRY?=
 =?utf-8?B?SkYzakJpR1A1K2l2Z2ZHQzJZeU01YUZOSWNKRm9mcVpNdWJCVFYwSWhKOUo2?=
 =?utf-8?B?NGNHSG45NnRJUnU5eWc1SnllVmpTUGFlZWhYcjM1YVgrQUZEMXk2M0hlcGxY?=
 =?utf-8?B?NjhWL3Y1RjBMSENSOW9DOXlpZVNscEZJSTNZVEZwa1dIRHlxb055bG1SQlRy?=
 =?utf-8?B?WUtMazZRQnZITzUwUVNzOUpmTWZtYm1RYlhkWmg4Qy9kaWE2bThrbU12UkV5?=
 =?utf-8?B?emRKM3BvM00rWFo1RFpFQUljdXA3WmR0V3IwWFNDUzY5elI4UEdkVzRnUDRK?=
 =?utf-8?B?VWFaSlFRQkpkazVoY0lzL1RzT3Nla0taaXZHYUxkdEZoKzh3a08zcDdaaGVE?=
 =?utf-8?B?M3JNdUJ5bU1PVzR1Tm02VUZRckg0SElPaklyWDJtWVZHdHN1bmpEY3VOOWtV?=
 =?utf-8?B?dWRqM0tRajlTVWRnc005TnhyMURFV2hMdGlTSXpmeXJnQXgzSGtDeDdPTHdq?=
 =?utf-8?B?QldyRW1ub25MRWhQb3hORjd0OTVDNDJQOHJsTHdiS0NZdFRZTVRTeVRGRkRt?=
 =?utf-8?B?Y08rSGh5V0pGdVd5clV2UFJDZEViazRwMFhodFMwaStjeGtNUTdWMVZxMXdi?=
 =?utf-8?B?Q1JuQVRRdzlaZ0huUG9DL01rbUtYWDBDVC9KSDRoMFZuOWtzdmIrNDZmalFo?=
 =?utf-8?B?MDBUNWtZZGxtS2F0dXJYd21tWGp5MDF4SEZxckFPQ1lEeGk5YjRhSGJyc0V3?=
 =?utf-8?B?ZEpUaC9rc3BoRVZJM21Na01HRmo3RDkweWMxRXR5OC9iUDk1Z3RBRTdIZFdj?=
 =?utf-8?B?V3YzU0pYSXNmTWxhQkZWUWZlSXc4Y3VaK3VmVE02bGREL0FTYTV5VmRheXV2?=
 =?utf-8?B?bWZneXlMaEZEbndvNWZ6TndDMlp2UEZCQVVIWjM5QlZwRHllWllraVJ2bEc1?=
 =?utf-8?B?YUpIMkRMd3pvYnFPY1RINkd2d0NZVHpMM0RoMGhzSXFZTmJQTmtlbjR2bjJn?=
 =?utf-8?B?aWtQNVF1b0NLeVY2SytpYWZiV0FXME9ZVnk3cFVleFcyZ0hIaHlpRUNsN1FP?=
 =?utf-8?B?TnVpMzlEa2lEbnFsYnltUlN3bC9JTHZSU3I3N2prQ0hRd2h1cTloL1phYUZ1?=
 =?utf-8?B?UXFMeWp6OS9LLzdqK0w5cjV5aHV3ZldIRFRoa3p5Zyt4QjdsdEhuTk0yVitr?=
 =?utf-8?B?SiszTFd6djVvdkd1ckg3ZlpKYktwclRBdmhLSytMVUpSZnpweGFvdFFkK2Uw?=
 =?utf-8?B?aVVqcVpTUElVSVZaOFlXWmI1SC91MVFubSsyYmlKcnA5Y1loem4zZk95VjZl?=
 =?utf-8?B?SHJYRUdJUXpCWUhCa1hYOVdYTXJWaTI0NHJPeEQwN2RtRERSekNrMWthWSsx?=
 =?utf-8?B?TFdHS0JaTHhOb2tsK01tU2g1Y3E2dm12d1FnQ2lXeDBhTm5IamlYQ0lLMDh3?=
 =?utf-8?B?aTdDaG54QmNXVkZpNnhNOUtsWHB6OXVHSWNjenQwOC9JZzNEd011TGt0eEN1?=
 =?utf-8?B?eml3R0JIRGlRT09telNOWU1MdW0wTUJHdnpXNEk3V0VQMDBLZ0lGNUFjNmo0?=
 =?utf-8?Q?UfnNlZS7l91iimxFTW84mdKVi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af45837-55ba-4d01-8048-08dc51f099c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 02:08:19.7305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdYnIS9o3V7rXu0sTTSKfoDwQGw2VvIQrYkQtCvSvU5Iuzs9tY40BUqpyUSTosO6NzV2c/Hopj/sz5N2zvJLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
Received-SPF: softfail client-ip=40.107.220.115;
 envelope-from=yajunw@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 3/27/2024 6:47 PM, Stefano Garzarella wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Yajun,
>
> On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
>> Hi experts,
>>
>> With latest QEMU (8.2.90), we find two vhost-user-blk backend reconnect
>> failure scenarios:
> Do you know if has it ever worked and so it's a regression, or have we
> always had this problem?

I am afraid this commit: "71e076a07d (2022-12-01 02:30:13 -0500) 
hw/virtio: generalise CHR_EVENT_CLOSED handling"  caused both failures. 
Previous hash is good.

I suspect the "if (vhost->vdev)" in vhost_user_async_close_bh is the 
cause, previous code doesn't have this check?

>
> Thanks,
> Stefano
>
>> 1. Disconnect vhost-user-blk backend before guest driver probe vblk device, then reconnect backend after guest driver probe device. QEMU won't send out any vhost messages to restore backend.
>> This is because vhost->vdev is NULL before guest driver probe vblk device, so vhost_user_blk_disconnect won't be called, s->connected is still true. Next vhost_user_blk_connect will simply return without doing anything.
>>
>> 2. modprobe -r virtio-blk inside VM, then disconnect backend, then reconnect backend, then modprobe virtio-blk. QEMU won't send messages in vhost_dev_init.
>> This is because rmmod will let qemu call vhost_user_blk_stop, vhost->vdev also become NULL(in vhost_dev_stop), vhost_user_blk_disconnect won't be called. Again s->connected is still true, even chr connect is closed.
>>
>> I think even vhost->vdev is NULL, vhost_user_blk_disconnect should be called when chr connect close?
>> Hope we can have a fix soon.
>>
>>
>> Thanks,
>> Yajun
>>

