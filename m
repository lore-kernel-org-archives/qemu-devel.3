Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55676C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ana-0007MS-Ly; Mon, 13 May 2024 14:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6anW-0007Ln-Tc; Mon, 13 May 2024 14:53:19 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s6anR-0008HY-0b; Mon, 13 May 2024 14:53:17 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 44DHmK52027554; Mon, 13 May 2024 19:52:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=dDW20Laobrm+GJL7YlSDG3E8PwJ8ex9IcxGbU1OWtN8=; b=
 k4sLh4e9KrkYOaf6X2QjPJcZUVZrzCdV/ip6guIXyJ0HT19xLZSBnaHeh7XP7dyC
 iudvU9eMGhNETV1my9FK/dW7aqonSOIaveqXsh7B+WJZThSYVwFmn8Dq6ks6DT++
 s6zf5B96xaP45biymorIo8o/RKYrX3ix2+lNooJ9/mEYEXDoA9Nds9/XslZt45KB
 1a2HJULO/xQuJkEJNmUVmelL7LmZqiJddbdeJszO3CbHsmUa0kbUzAXCsfVyCBFy
 p+6qqG3nt/fJ6/NGwKScktzybrD5xC5sBXnN3vsARGL1RAU7z1wKsCgRVMhmFaPR
 o5aB2JM1ka1qDsk+VAAWvA==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3y1yxwtref-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 May 2024 19:52:32 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DGX2Mj013106; Mon, 13 May 2024 14:52:31 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 3y2njy8m4e-1;
 Mon, 13 May 2024 14:52:31 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id ED6B864EAC;
 Mon, 13 May 2024 18:52:27 +0000 (GMT)
Message-ID: <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
Date: Mon, 13 May 2024 13:52:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Zheng Chuan <zhengchuan@huawei.com>, Peter Xu <peterx@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
References: <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130126
X-Proofpoint-ORIG-GUID: HWugcSlVBAj9Kl27TNyaFCUyTovADyvo
X-Proofpoint-GUID: HWugcSlVBAj9Kl27TNyaFCUyTovADyvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130127
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

One thing to keep in mind here (despite me not having any hardware to 
test) was that one of the original goals here
in the RDMA implementation was not simply raw throughput nor raw 
latency, but a lack of CPU utilization in kernel
space due to the offload. While it is entirely possible that newer 
hardware w/ TCP might compete, the significant
reductions in CPU usage in the TCP/IP stack were a big win at the time.

Just something to consider while you're doing the testing........

- Michael

On 5/9/24 03:58, Zheng Chuan wrote:
> Hi, Peter，Lei，Jinpu.
>
> On 2024/5/8 0:28, Peter Xu wrote:
>> On Tue, May 07, 2024 at 01:50:43AM +0000, Gonglei (Arei) wrote:
>>> Hello,
>>>
>>>> -----Original Message-----
>>>> From: Peter Xu [mailto:peterx@redhat.com]
>>>> Sent: Monday, May 6, 2024 11:18 PM
>>>> To: Gonglei (Arei) <arei.gonglei@huawei.com>
>>>> Cc: Daniel P. Berrangé <berrange@redhat.com>; Markus Armbruster
>>>> <armbru@redhat.com>; Michael Galaxy <mgalaxy@akamai.com>; Yu Zhang
>>>> <yu.zhang@ionos.com>; Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>; Jinpu Wang
>>>> <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
>>>> qemu-devel@nongnu.org; Yuval Shaia <yuval.shaia.ml@gmail.com>; Kevin Wolf
>>>> <kwolf@redhat.com>; Prasanna Kumar Kalever
>>>> <prasanna.kalever@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
>>>> Michael Roth <michael.roth@amd.com>; Prasanna Kumar Kalever
>>>> <prasanna4324@gmail.com>; integration@gluster.org; Paolo Bonzini
>>>> <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
>>>> Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
>>>> Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
>>>> Gao <gaosong@loongson.cn>; Marc-André Lureau
>>>> <marcandre.lureau@redhat.com>; Alex Bennée <alex.bennee@linaro.org>;
>>>> Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
>>>> <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
>>>> Xiexiangyou <xiexiangyou@huawei.com>
>>>> Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
>>>>
>>>> On Mon, May 06, 2024 at 02:06:28AM +0000, Gonglei (Arei) wrote:
>>>>> Hi, Peter
>>>> Hey, Lei,
>>>>
>>>> Happy to see you around again after years.
>>>>
>>> Haha, me too.
>>>
>>>>> RDMA features high bandwidth, low latency (in non-blocking lossless
>>>>> network), and direct remote memory access by bypassing the CPU (As you
>>>>> know, CPU resources are expensive for cloud vendors, which is one of
>>>>> the reasons why we introduced offload cards.), which TCP does not have.
>>>> It's another cost to use offload cards, v.s. preparing more cpu resources?
>>>>
>>> Software and hardware offload converged architecture is the way to go for all cloud vendors
>>> (Including comprehensive benefits in terms of performance, cost, security, and innovation speed),
>>> it's not just a matter of adding the resource of a DPU card.
>>>
>>>>> In some scenarios where fast live migration is needed (extremely short
>>>>> interruption duration and migration duration) is very useful. To this
>>>>> end, we have also developed RDMA support for multifd.
>>>> Will any of you upstream that work?  I'm curious how intrusive would it be
>>>> when adding it to multifd, if it can keep only 5 exported functions like what
>>>> rdma.h does right now it'll be pretty nice.  We also want to make sure it works
>>>> with arbitrary sized loads and buffers, e.g. vfio is considering to add IO loads to
>>>> multifd channels too.
>>>>
>>> In fact, we sent the patchset to the community in 2021. Pls see:
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20210203185906.GT2950@work-vm/T/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZl4NUEGc$
> Yes, I have sent the patchset of multifd support for rdma migration by taking over my colleague, and also
> sorry for not keeping on this work at that time due to some reasons.
> And also I am strongly agree with Lei that the RDMA protocol has some special advantages against with TCP
> in some scenario, and we are indeed to use it in our product.
>
>> I wasn't aware of that for sure in the past..
>>
>> Multifd has changed quite a bit in the last 9.0 release, that may not apply
>> anymore.  One thing to mention is please look at Dan's comment on possible
>> use of rsocket.h:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/all/ZjJm6rcqS5EhoKgK@redhat.com/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZ0CFSE-o$
>>
>> And Jinpu did help provide an initial test result over the library:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZxPNcdb4$
>>
>> It looks like we have a chance to apply that in QEMU.
>>
>>>
>>>> One thing to note that the question here is not about a pure performance
>>>> comparison between rdma and nics only.  It's about help us make a decision
>>>> on whether to drop rdma, iow, even if rdma performs well, the community still
>>>> has the right to drop it if nobody can actively work and maintain it.
>>>> It's just that if nics can perform as good it's more a reason to drop, unless
>>>> companies can help to provide good support and work together.
>>>>
>>> We are happy to provide the necessary review and maintenance work for RDMA
>>> if the community needs it.
>>>
>>> CC'ing Chuan Zheng.
>> I'm not sure whether you and Jinpu's team would like to work together and
>> provide a final solution for rdma over multifd.  It could be much simpler
>> than the original 2021 proposal if the rsocket API will work out.
>>
>> Thanks,
>>
> That's a good news to see the socket abstraction for RDMA!
> When I was developed the series above, the most pain is the RDMA migration has no QIOChannel abstraction and i need to take a 'fake channel'
> for it which is awkward in code implementation.
> So, as far as I know, we can do this by
> i. the first thing is that we need to evaluate the rsocket is good enough to satisfy our QIOChannel fundamental abstraction
> ii. if it works right, then we will continue to see if it can give us opportunity to hide the detail of rdma protocol
>      into rsocket by remove most of code in rdma.c and also some hack in migration main process.
> iii. implement the advanced features like multi-fd and multi-uri for rdma migration.
>
> Since I am not familiar with rsocket, I need some times to look at it and do some quick verify with rdma migration based on rsocket.
> But, yes, I am willing to involved in this refactor work and to see if we can make this migration feature more better:）
>
>

