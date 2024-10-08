Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278EECEF170
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9rO-000384-6h; Tue, 08 Oct 2024 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanjun.zhu@linux.dev>)
 id 1sy6ZY-0000wL-1L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:32:04 -0400
Received: from out-183.mta0.migadu.com ([91.218.175.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanjun.zhu@linux.dev>)
 id 1sy6ZV-0008Aa-4m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:32:03 -0400
Message-ID: <3cecfd89-b6a6-47cc-8361-de6be943cf80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1728379915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyDX2hRvovTAYvoIws3jWRBwqsnw6pkBjgs4txlDDoM=;
 b=CcY1caTQRvy4cJ98Nts2DNWBdQvgC/IRAcqwXBDITgutCeHUejmWXQBSV9kRA7MjDxt5qD
 3g8cZYJMwj7v8TRI4Kvgeu/uJlL//rhOtYj1wzjnFP9UBvv1MzhnqUCGB7nt65cVKVrnia
 z9u3zmO0VbpIKRmaXadFKyYvvFSeiWA=
Date: Tue, 8 Oct 2024 17:31:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Leon Romanovsky <leon@kernel.org>, Michael Galaxy <mgalaxy@akamai.com>
Cc: Yu Zhang <yu.zhang@ionos.com>, Sean Hefty <shefty@nvidia.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
References: <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
 <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
 <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
 <20241007181513.GC25819@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241007181513.GC25819@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.183; envelope-from=yanjun.zhu@linux.dev;
 helo=out-183.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Oct 2024 09:02:36 -0400
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

在 2024/10/8 2:15, Leon Romanovsky 写道:
> On Mon, Oct 07, 2024 at 08:45:07AM -0500, Michael Galaxy wrote:
>> Hi,
>>
>> On 10/7/24 03:47, Yu Zhang wrote:
>>> !-------------------------------------------------------------------|
>>>     This Message Is From an External Sender
>>>     This message came from outside your organization.
>>> |-------------------------------------------------------------------!
>>>
>>> Sure, as we talked at the KVM Forum, a possible approach is to set up
>>> two VMs on a physical host, configure the SoftRoCE, and run the
>>> migration test in two nested VMs to ensure that the migration data
>>> traffic goes through the emulated RDMA hardware. I will continue with
>>> this and let you know.
>>>
>> Acknowledged. Do share if you have any problems with it, like if it has
>> compatibility issues
>> or if we need a different solution. We're open to change.
>>
>> I'm not familiar with the "current state" of this or how well it would even
>> work.
> 
> Any compatibility issue between versions of RXE (SoftRoCE) or between
> RXE and real devices is a bug in RXE, which should be fixed.
> 
> RXE is expected to be compatible with rest RoCE devices, both virtual
> and physical.

 From my tests, about physical RoCE devices, for example, Nvidia MLX5 
and intel E810 (iRDMA), if RDMA feature is disabled on those devices. 
RXE can work well with them.

About Virtual devices, most virtual devices can work well with RXE, for 
example,bonding, veth. I have done a lot of tests with them.

If some virtual devices can not work well with RXE, please share the 
error messages in RDMA maillist.

Zhu Yanjun

> 
> Thanks
> 
>>
>> - Michael
>>
>>
>>> On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> wrote:
>>>>
>>>> On 10/3/24 16:43, Peter Xu wrote:
>>>>> !-------------------------------------------------------------------|
>>>>>      This Message Is From an External Sender
>>>>>      This message came from outside your organization.
>>>>> |-------------------------------------------------------------------!
>>>>>
>>>>> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>>>>>> What about the testing solution that I mentioned?
>>>>>>
>>>>>> Does that satisfy your concerns? Or is there still a gap here that needs to
>>>>>> be met?
>>>>> I think such testing framework would be helpful, especially if we can kick
>>>>> it off in CI when preparing pull requests, then we can make sure nothing
>>>>> will break RDMA easily.
>>>>>
>>>>> Meanwhile, we still need people committed to this and actively maintain it,
>>>>> who knows the rdma code well.
>>>>>
>>>>> Thanks,
>>>>>
>>>> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
>>>> along these lines that would ensure that future RDMA breakages are
>>>> detected more easily?
>>>>
>>>> What do you think?
>>>>
>>>> - Michael
>>>>
>>


