Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEEECF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 19:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssSHt-00016b-VJ; Sun, 22 Sep 2024 15:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1ssSHp-00015v-Rd
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:30:25 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1ssSHn-0000Yf-CM
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:30:25 -0400
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 48MHo0RC016258; Sun, 22 Sep 2024 20:29:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=ZksYdjXX6xnlBu3k0eV8lP8yi+W69pQVELSsLsJaNTo=; b=mUDf5rnl9G6K
 G8IUCUwej4puZFIxA6tJyC+VscVrOcmzjHp68s6Z+AdDsOFlpXWz9QMHNawCOAa3
 Ope9WLe7S/3DJJV0NDYzTH97ceHN4+EuVwqyjoXSbbRRHvwaAbHH/DyTc3lpOzCp
 Rlrr0MbieOTQH5Z8uSwUkTomli14sB86sDLddob7lYunZDvlcapdUnIPCEOR1QUT
 3qRphylJhitzlpgMZcCQ2SZqxjUSkDOFr49exTCfhiSEAgs1CTKXXZJp/AIsMwoh
 rvPWUItnXIqhSA/e7g6DTQyPyB1+3iVZJHqh5WmQK8xvhpkdveiOPRLdPnvYxCLT
 KLpD/+f0Mw==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 41t7ft9mu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Sep 2024 20:29:39 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 48MD2nv9012780; Sun, 22 Sep 2024 15:29:38 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTP id 41ssfxrn93-1;
 Sun, 22 Sep 2024 15:29:37 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com
 [172.27.166.123])
 by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 9089163691; 
 Sun, 22 Sep 2024 19:29:34 +0000 (GMT)
Message-ID: <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
Date: Sun, 22 Sep 2024 14:29:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 yu.zhang@ionos.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com,
 berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com,
 pbonzini@redhat.com, xiexiangyou@huawei.com,
 linux-rdma@vger.kernel.org, lixiao91@huawei.com, jinpu.wang@ionos.com,
 Jialin Wang <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240827165643-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-22_19,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409220150
X-Proofpoint-GUID: GyWlgh7Tvyv0VqHMkvHLJyxugqdrXxJP
X-Proofpoint-ORIG-GUID: GyWlgh7Tvyv0VqHMkvHLJyxugqdrXxJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409220151
Received-SPF: pass client-ip=67.231.149.131; envelope-from=mgalaxy@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi All,

I have met with the team from IONOS about their testing on actual IB 
hardware here at KVM Forum today and the requirements are starting to 
make more sense to me. I didn't say much in our previous thread because 
I misunderstood the requirements, so let me try to explain and see if 
we're all on the same page. There appears to be a fundamental limitation 
here with rsocket, for which I don't see how it is possible to overcome.

The basic problem is that rsocket is trying to present a stream 
abstraction, a concept that is fundamentally incompatible with RDMA. The 
whole point of using RDMA in the first place is to avoid using the CPU, 
and to do that, all of the memory (potentially hundreds of gigabytes) 
need to be registered with the hardware *in advance* (this is how the 
original implementation works).

The need to fake a socket/bytestream abstraction eventually breaks down 
=> There is a limit (a few GB) in rsocket (which the IONOS team previous 
reported in testing.... see that email), it appears that means that 
rsocket is only going to be able to map a certain limited amount of 
memory with the hardware until its internal "buffer" runs out before it 
can then unmap and remap the next batch of memory with the hardware to 
continue along with the fake bytestream. This is very much sticking a 
square peg in a round hole. If you were to "relax" the rsocket 
implementation to register the entire VM memory space (as my original 
implementation does), then there wouldn't be any need for rsocket in the 
first place.

I think there is just some misunderstanding here in the group in the way 
infiniband is intended to work. Does that make sense so far? I do 
understand the need for testing, but rsocket is simply not intended to 
be used for kind of massive bulk data transfer purposes that we're 
proposing using it here for, simply for the purposes of making our lives 
better in testing.

Regarding testing: During our previous thread earlier this summer, why 
did we not consider making a better integration test to solve the test 
burden problem? To explain better: If a new integration test were 
written for QEMU and submitted and reviewed (a reasonably complex test 
that was in line with a traditional live migration integration test that 
actually spins up QEMU) which used softRoCE in a localhost configuration 
that has full libibverbs supports and still allowed for compatibility 
testing with QEMU, would such an integration not be sufficient to handle 
the testing burden?

Comments welcome,
- Michael

On 8/27/24 15:57, Michael S. Tsirkin wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Tue, Aug 27, 2024 at 04:15:42PM -0400, Peter Xu wrote:
>> On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
>>> From: Jialin Wang <wangjialin23@huawei.com>
>>>
>>> Hi,
>>>
>>> This patch series attempts to refactor RDMA live migration by
>>> introducing a new QIOChannelRDMA class based on the rsocket API.
>>>
>>> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
>>> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
>>> detail of rdma protocol into rsocket and allows us to add support for
>>> some modern features like multifd more easily.
>>>
>>> Here is the previous discussion on refactoring RDMA live migration using
>>> the rsocket API:
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/__;!!GjvTz_vk!TuRaotO-yMj82o2kQo3x743jLoDElYgrXmp2wOfMTuCS1Y4k2Son1WGsRnZG_YYS9ZgBZ8uRHQ$
>>>
>>> We have encountered some bugs when using rsocket and plan to submit them to
>>> the rdma-core community.
>>>
>>> In addition, the use of rsocket makes our programming more convenient,
>>> but it must be noted that this method introduces multiple memory copies,
>>> which can be imagined that there will be a certain performance degradation,
>>> hoping that friends with RDMA network cards can help verify, thank you!
>>>
>>> Jialin Wang (6):
>>>    migration: remove RDMA live migration temporarily
>>>    io: add QIOChannelRDMA class
>>>    io/channel-rdma: support working in coroutine
>>>    tests/unit: add test-io-channel-rdma.c
>>>    migration: introduce new RDMA live migration
>>>    migration/rdma: support multifd for RDMA migration
>> This series has been idle for a while; we still need to know how to move
>> forward.
>
> What exactly is the question? This got a bunch of comments,
> the first thing to do would be to address them.
>
>
>>   I guess I lost the latest status quo..
>>
>> Any update (from anyone..) on what stage are we in?
>>
>> Thanks,
>> -- 
>> Peter Xu

