Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0275C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 05:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrt49-0003M6-1c; Wed, 03 Apr 2024 01:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>)
 id 1rrt46-0003Lf-Pr; Wed, 03 Apr 2024 01:21:38 -0400
Received: from mail-mw2nam04on20700.outbound.protection.outlook.com
 ([2a01:111:f403:240a::700]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>)
 id 1rrt44-0007of-1K; Wed, 03 Apr 2024 01:21:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds2conan595fG1o367prAt1TYl+LOCYFIBI8vUEF4CNy43tnb/m8eVhg/YBC+F6ZCHymRHEn1j9v7jpixp4pJhbZzDhT245izzWcbubewXh2HKcY0T+noJJ9xIfmTXJjbMPe5QX2njiEMgSDkfBHIrJWyqlxFAVRJpqMO2WWo6+lxdVMCsx3yOh8E0HCzJTlGyxleu6zy9N+r1V5wOjrXXRHHIzs1D+Q8Vp44oPT0YCbBWACvyJfCdg3d0Gjq8mSSe8XkpQ76SUHTYmGhvy0gOVDpfLlHhk8IemdZdJarfdNlW7zsAKaC4z632kjLK4HRaQmr24njOxfpS1iZjcmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2TliB4kxv78tcDfx1dc/Bizpou8WyAS/7qcYWeUBIw=;
 b=lnreNhNisj433sEazqD9CBUlYc5XWqW+0fDrFnuvD4yuFxJYV1UJJf0D3ItfoL1oia33neH+03O6PyTHh/rEP8zd2bNu7zDr+4ndhCDG8h9XMF7B+WbM+gf9MVuMQnzUKrLq/LC1oY0szTaT2FAqsCGDhff/afOrXgnpBGllEkZgdj4iC4v5n+XnCRJ3JEMvVU8T+i63ifhyD1rKQfKXfzKI/St7JRBGqnaIzPSgBUAB4K/sljYeA1Lex5RGkQj0f/F9hBdrj3STr3UBuumgR9Uku5B6h3U19ylTbllsR6WDSXmtsqGLoS0qRL3GyRDd6Htnqm1tKzZVJi6ZV+97mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2TliB4kxv78tcDfx1dc/Bizpou8WyAS/7qcYWeUBIw=;
 b=Pi/IDVgDM38+ECpogugs3kYWgwuz3Cw7HbK7MPAgdBbe/OsOROmzg4grYsYfmzFFpHaTLhZnR2Hxvva3HEuU+CCb4o0xOe3dH3zccTmSS6PBorOp/wiZn7TooM3mmThUw8ywTTdG5ssVF17GnsV9ER/MhlE7Lk7opHWM9SfdUDgP8LaDijp0DDEfKopF495pBPOekUeVmBAExnHvUbDmtKIeFBMKYvevksv+A1pXAVMxBVGVFgPQPbp/kGnzpmw81utInX36R290HAYxAJZkaXgAsEgwndyyGothR8lpfp1jDd0Vq+CWYK2BDGBoy5qA/6+QGyrSanYClXxVSHg/XQ==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 05:21:29 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 05:21:28 +0000
Message-ID: <c67b9d37-c806-4086-8716-c425ccc8bec2@nvidia.com>
Date: Wed, 3 Apr 2024 13:21:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
To: Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20240402045109.97729-1-yajunw@nvidia.com>
 <a75271ae-57e0-4f59-9a96-1696bdcd3566@tls.msk.ru>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <a75271ae-57e0-4f59-9a96-1696bdcd3566@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|DM4PR12MB7573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eycSjTpnTrU2DNfeUXiKQs6TIUQGbvkYusTOqu2dqaOYBmIbFUGH+HU8AQ7xUO+PlCU26SGnIt54452e1HYqv6EdtowSNvcLOO1TytmAunSw7kokgrcGMRZyAQLRQdL4r0LzrUxum0wXHIdW45rUVIxmTnYG9cmwq5Src76dyYIMLR1jXXH48W6BLn36w6pVcxqKnSwoW8Z7W7EOhcMp2bbIEDk4HUETs/y2r2McunRDoQcAuFz263fH568t91xJOS6Oom/1LfKxZXYcQXBnrlNz9v1kW2sByYozwzEcK2Hv9DBtw9rlPXXddykvNsGifbnb7HacRuv6KQz+Z9MxRNNOhIbDvzJasWNBte2KF8NQ2lCMip77mrFAqZvIkk+Rl8IfWtS+SIOuGRh1utEAZBeoGNRZHf115HVC1Lf1pRFGoBIDeJz9J2XRAzgvPeU2UtxJ3c/Q1DTRNsTt/rSMQiQrd0e2FrViCqsagq2ORmFVjCCvQy51zUKIRtbM6W/lWT1f63iaffVpFGCQ3Vh6zqIcx+duXEFzXHDe9dbG69Xyh4mNnfT20cjtMvLPkv2d6r1mti7W4L4TO1WrKfKiQcfZt7m/CaVPdV7VriSm0uoeagtm5XM5HfFuKxZzgGnvUOBZ6uk0VMMmJ5GwPla/czc4PKFbctVZ6Kv9y+wEak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpTcXFQZktIMy9NWXNrNENQQ1h4VUVSMEJpeFNaLzJZRWJCRlQwRm1BelZR?=
 =?utf-8?B?MU4yOWZObGtCRG1TNWNFUXEzWlVXeGh2RlBQZHJnc1NrdENBNTlkK3lHRHYw?=
 =?utf-8?B?ckdoeEluSVNMM25GVnhVZzh4OEFTbVJNMlhPTVlDMHc2TjhOcUxnTmtVTXdI?=
 =?utf-8?B?enlYZWxYMnE0T0ErOGJ2c3BDRHhQUit6UVBIbmkwTGNBTFBRMzg2Y2JDNS9U?=
 =?utf-8?B?Qm9mbFlxZ00wRUJtUnZ3QkVLNHVrS2YwdjROYlJoZCt0aXZXSlBCR1Z3M2lS?=
 =?utf-8?B?WDBNOU4xejBSSHJTdVNZSDIrajFXVDFqQUtRcVgvMmh5bysyS0VoUUtwMXdP?=
 =?utf-8?B?VmVkcnFhRHk5aWxEMmdvOERuQVBPZVpvTm4xQURwK3RsaDBoWWpWQXlHTi9Q?=
 =?utf-8?B?QjE4K092NTYvZEtUNW9Vb25PMHIycTVtYlp5bVZPWlYrRlJJUVozczdXY0lw?=
 =?utf-8?B?Nzc5dHdWcXR6ZzVKbmhqbVkwQ2tmb254d2pHWWxqYWZYdjFiVnFseVJIQjNQ?=
 =?utf-8?B?WWZZZkdvOGRMNWE4QVZmTWJtc2V0dkdyRDZ6bnA5OEM1WmcvTndXYldDeHRv?=
 =?utf-8?B?eCtrZFpEV1ZDOGpnbTl1c05HenRNZk43ZXprMXh0RkpsUzhOOUtzUXNjdjdK?=
 =?utf-8?B?NjJidzlPQUtYMTFHQ3BpWU53UkFUcFQ3MFdPdXM2WHg1ZHZBVDRlSld0KzZR?=
 =?utf-8?B?bVpaZG1rWnpwZ2hyMTBhNWlIRHJ0MGJkUTcvcTEzL3ZIdlBOY28zTEpxcmVj?=
 =?utf-8?B?RC9PbGtvejltZ0xmYTYxOE0yenMrVldLZmNxRXdDZHhGc3U0Z2NWTVBPRkkz?=
 =?utf-8?B?aUNKaDcwOEF5c0tzOGpjY2l5YWhFVE5ybUo4T2loNGoweWV2UFgrR0taM2E1?=
 =?utf-8?B?dmkvbWdjSTVGZVNEMEZ6ZDlDSjVnMENZbGxMcFF5Zmh4NWs0a1BJdXZXR0VF?=
 =?utf-8?B?Vm5VakRIMkVHTy9BMDZ4RHpuZ0E1a3NlTDFqOTM4T29RQmU1Q2ZYanlNZit0?=
 =?utf-8?B?bk5NaVQ2WXhSNTZlQkhrQW83aVg3dkF4UWl2NUdRZU9VZEU4RlMxaTNITGVM?=
 =?utf-8?B?dWNDNUhqS083dVREWEhqMGJzMWttalJoSjV3NDVaMjBucW9HNGJxbzQ5K0RN?=
 =?utf-8?B?czdGVjVveHNFZFNmQnFmNnQ0bTl4STN4RGxMS2ZyV3hPa2pVRFFlSGJOcUFZ?=
 =?utf-8?B?Uk9hOUp4WWNFMkd3K1drM0dFekZKOGJiWDBrekY2Wk1ldmIraHQxK0RBZ3VR?=
 =?utf-8?B?bmR6ZWZhTlI1NzlZSS8zMnpMWEJzSmxtV2Z6NmNlS2FjWlcwTFROUVpXMTFB?=
 =?utf-8?B?WU9tdEZnV2ZhTExyUkMzNldXVVJxOVBjQW9FYzhBU2hEYStYZTQvR2huSGo0?=
 =?utf-8?B?bzV3ZjBjUGFPcExLSUJObmpnRkw3ZnZ2OWwxejNrYjNDZmgvTmJSYUdJU3dG?=
 =?utf-8?B?MjBHdUczaCtzTnMwTWN1SUlqNXp3aWFFWXRRT3ZDMDFJU1hpWHRvUVoxOWt1?=
 =?utf-8?B?U3FBMGJUYU1PREhyeHdUdklxUXRRRWcwTEg0bElrTXErMFRHczAyWUJ3ZE5N?=
 =?utf-8?B?c2wvVG13SHNhRG9qdHhudEFlbDFJOVVGWGZPOW11aUtMVnhoSGtzT2kwdFd2?=
 =?utf-8?B?bERGNWVjdDlXUGh0Nnk1bHVqMVAwNmRmd09OYkJ1Q04xTGFnb2M5TTIzWEhW?=
 =?utf-8?B?NmRmNE05aS9hZ01ZeGtmSmtybGk2QXBQdDNkQ1p6eWRBMnBGbHpLTHBZK1Qz?=
 =?utf-8?B?SXdRSGQ3eXVUeGs3bXh5WGpGUHlzZGZrTHovWEZiQUtCTDZLZWVzZjFnU2FR?=
 =?utf-8?B?MWRpVmcycGdTS2xwVlg4ZUZva1JCVzJKVzdNMXBvTE5mZkhJZThIK2NmTjI5?=
 =?utf-8?B?MkZXYTlhQ0tLT29TbGxIQ0NtL2VJTFUrRXZJY1VRbzdEWnYxeU9DOHNFenRz?=
 =?utf-8?B?VThRZ0haTXB6MW1vVm9VaDdkcW1TRldZRUpuM2NMSEhFa0hWUzFuMnpCYjlP?=
 =?utf-8?B?ZVNYa1FNbWs4Wlc1QUtQMlVFS2F0VWpqOGdnOGllZE5YSFd5V1ppV0VKazFN?=
 =?utf-8?B?OWtKc1lodzA0UUxUVlBNN1dyYSsrUmJlVzRuUE5ibldMK2paNVd1YUtFTGFJ?=
 =?utf-8?Q?+FRNzuzUw0uza0f+f8kjgruP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c185572-ee1d-4318-32bb-08dc539dea24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 05:21:28.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojRJABMDyf4dc+gMlkVc3wxwo6rXLaPMOBYsm1qi+1OYwcOGlRmIasWIY69ELMqQjWxhf31s0E2+B5d5ujJDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
Received-SPF: softfail client-ip=2a01:111:f403:240a::700;
 envelope-from=yajunw@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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


On 4/3/2024 1:10 PM, Michael Tokarev wrote:
> External email: Use caution opening links or attachments
>
>
> 02.04.2024 07:51, Yajun Wu:
>> When vhost-user or vhost-kernel is handling virtio net datapath, qemu
>> should not touch used ring.
>>
>> But with vhost-user socket reconnect scenario, in a very rare case (has
>> pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in
>> following code path:
> ...
>> This issue causes guest kernel stop kicking device and traffic stop.
>>
>> Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
>> VRING_USED_F_NO_NOTIFY set.
> This seems to be qemu-stable material, even if the case when the issue
> happens is "very rare", -- is it not?
If you mean this fix needs back port to previous version? Yes.
> Thanks,
>
> /mjt
>
>> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>    hw/net/virtio-net.c | 4 ++++
>>    1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index a6ff000cd9..8035e01fdf 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2865,6 +2865,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>>        VirtIONet *n = VIRTIO_NET(vdev);
>>        VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
>>
>> +    if (n->vhost_started) {
>> +        return;
>> +    }
>> +
>>        if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
>>            virtio_net_drop_tx_queue_data(vdev, vq);
>>            return;

