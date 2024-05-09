Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13157C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4zcY-0002EP-3P; Thu, 09 May 2024 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1s4zcQ-0002E0-2F; Thu, 09 May 2024 04:59:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1s4zcD-0007Yk-AF; Thu, 09 May 2024 04:59:05 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VZm9d3HVNz1HBqy;
 Thu,  9 May 2024 16:57:25 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E9D31400D2;
 Thu,  9 May 2024 16:58:43 +0800 (CST)
Received: from [10.174.186.51] (10.174.186.51) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:58:41 +0800
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
CC: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang
 <yu.zhang@ionos.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Jinpu
 Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia
 <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Prasanna Kumar
 Kalever <prasanna.kalever@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Prasanna Kumar Kalever
 <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Pannengyuan
 <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
References: <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
Message-ID: <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
Date: Thu, 9 May 2024 16:58:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ZjpWmG2aUJLkYxJm@x1n>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.51]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500005.china.huawei.com (7.185.36.59)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.944,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reply-to:  Zheng Chuan <zhengchuan@huawei.com>
From:  Zheng Chuan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Peter，Lei，Jinpu.

On 2024/5/8 0:28, Peter Xu wrote:
> On Tue, May 07, 2024 at 01:50:43AM +0000, Gonglei (Arei) wrote:
>> Hello,
>>
>>> -----Original Message-----
>>> From: Peter Xu [mailto:peterx@redhat.com]
>>> Sent: Monday, May 6, 2024 11:18 PM
>>> To: Gonglei (Arei) <arei.gonglei@huawei.com>
>>> Cc: Daniel P. Berrangé <berrange@redhat.com>; Markus Armbruster
>>> <armbru@redhat.com>; Michael Galaxy <mgalaxy@akamai.com>; Yu Zhang
>>> <yu.zhang@ionos.com>; Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>; Jinpu Wang
>>> <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
>>> qemu-devel@nongnu.org; Yuval Shaia <yuval.shaia.ml@gmail.com>; Kevin Wolf
>>> <kwolf@redhat.com>; Prasanna Kumar Kalever
>>> <prasanna.kalever@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
>>> Michael Roth <michael.roth@amd.com>; Prasanna Kumar Kalever
>>> <prasanna4324@gmail.com>; integration@gluster.org; Paolo Bonzini
>>> <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
>>> Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
>>> Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
>>> Gao <gaosong@loongson.cn>; Marc-André Lureau
>>> <marcandre.lureau@redhat.com>; Alex Bennée <alex.bennee@linaro.org>;
>>> Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
>>> <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
>>> Xiexiangyou <xiexiangyou@huawei.com>
>>> Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
>>>
>>> On Mon, May 06, 2024 at 02:06:28AM +0000, Gonglei (Arei) wrote:
>>>> Hi, Peter
>>>
>>> Hey, Lei,
>>>
>>> Happy to see you around again after years.
>>>
>> Haha, me too.
>>
>>>> RDMA features high bandwidth, low latency (in non-blocking lossless
>>>> network), and direct remote memory access by bypassing the CPU (As you
>>>> know, CPU resources are expensive for cloud vendors, which is one of
>>>> the reasons why we introduced offload cards.), which TCP does not have.
>>>
>>> It's another cost to use offload cards, v.s. preparing more cpu resources?
>>>
>> Software and hardware offload converged architecture is the way to go for all cloud vendors 
>> (Including comprehensive benefits in terms of performance, cost, security, and innovation speed), 
>> it's not just a matter of adding the resource of a DPU card.
>>
>>>> In some scenarios where fast live migration is needed (extremely short
>>>> interruption duration and migration duration) is very useful. To this
>>>> end, we have also developed RDMA support for multifd.
>>>
>>> Will any of you upstream that work?  I'm curious how intrusive would it be
>>> when adding it to multifd, if it can keep only 5 exported functions like what
>>> rdma.h does right now it'll be pretty nice.  We also want to make sure it works
>>> with arbitrary sized loads and buffers, e.g. vfio is considering to add IO loads to
>>> multifd channels too.
>>>
>>
>> In fact, we sent the patchset to the community in 2021. Pls see:
>> https://lore.kernel.org/all/20210203185906.GT2950@work-vm/T/
> 

Yes, I have sent the patchset of multifd support for rdma migration by taking over my colleague, and also
sorry for not keeping on this work at that time due to some reasons.
And also I am strongly agree with Lei that the RDMA protocol has some special advantages against with TCP
in some scenario, and we are indeed to use it in our product.

> I wasn't aware of that for sure in the past..
> 
> Multifd has changed quite a bit in the last 9.0 release, that may not apply
> anymore.  One thing to mention is please look at Dan's comment on possible
> use of rsocket.h:
> 
> https://lore.kernel.org/all/ZjJm6rcqS5EhoKgK@redhat.com/
> 
> And Jinpu did help provide an initial test result over the library:
> 
> https://lore.kernel.org/qemu-devel/CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com/
> 
> It looks like we have a chance to apply that in QEMU.
> 
>>
>>
>>> One thing to note that the question here is not about a pure performance
>>> comparison between rdma and nics only.  It's about help us make a decision
>>> on whether to drop rdma, iow, even if rdma performs well, the community still
>>> has the right to drop it if nobody can actively work and maintain it.
>>> It's just that if nics can perform as good it's more a reason to drop, unless
>>> companies can help to provide good support and work together.
>>>
>>
>> We are happy to provide the necessary review and maintenance work for RDMA
>> if the community needs it.
>>
>> CC'ing Chuan Zheng.
> 
> I'm not sure whether you and Jinpu's team would like to work together and
> provide a final solution for rdma over multifd.  It could be much simpler
> than the original 2021 proposal if the rsocket API will work out.
> 
> Thanks,
> 
That's a good news to see the socket abstraction for RDMA!
When I was developed the series above, the most pain is the RDMA migration has no QIOChannel abstraction and i need to take a 'fake channel'
for it which is awkward in code implementation.
So, as far as I know, we can do this by
i. the first thing is that we need to evaluate the rsocket is good enough to satisfy our QIOChannel fundamental abstraction
ii. if it works right, then we will continue to see if it can give us opportunity to hide the detail of rdma protocol
    into rsocket by remove most of code in rdma.c and also some hack in migration main process.
iii. implement the advanced features like multi-fd and multi-uri for rdma migration.

Since I am not familiar with rsocket, I need some times to look at it and do some quick verify with rdma migration based on rsocket.
But, yes, I am willing to involved in this refactor work and to see if we can make this migration feature more better:）


-- 
Regards.
Chuan

