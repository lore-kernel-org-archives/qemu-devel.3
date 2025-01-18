Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D183C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 14:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZAAW-00022e-JI; Sat, 18 Jan 2025 09:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tZAAJ-000220-4w; Sat, 18 Jan 2025 09:51:11 -0500
Received: from smtpnm6-06.21cn.com ([182.42.144.170] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tZAAG-0002g9-CN; Sat, 18 Jan 2025 09:51:10 -0500
HMM_SOURCE_IP: 192.168.138.117:0.1188369201
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-125.70.78.163 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 9E5F8E34B1;
 Sat, 18 Jan 2025 22:39:47 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([125.70.78.163])
 by gateway-ssl-dep-84dfd8c7d7-bnxj5 with ESMTP id
 698b0ed951d4485e9c569b716afe0cf4 for berrange@redhat.com; 
 Sat, 18 Jan 2025 22:39:51 CST
X-Transaction-ID: 698b0ed951d4485e9c569b716afe0cf4
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 125.70.78.163
X-MEDUSA-Status: 0
Message-ID: <00d9f300-97b6-40a9-84a6-08df71f1155c@chinatelecom.cn>
Date: Sat, 18 Jan 2025 22:39:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, eblake@redhat.com, armbru@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] support block encryption/decryption in parallel
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
 <Z1xZK9u8L_ydtnAJ@redhat.com> <Z4j9mGpbbXyjKbmI@redhat.com>
 <Z4pTMyvOTefCep87@redhat.com>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <Z4pTMyvOTefCep87@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.144.170; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thank you for the additional background and suggestions.
I will resend the second version.

On 2025/1/17 20:55, Daniel 【外部账号】P. Berrangé wrote:
> On Thu, Jan 16, 2025 at 01:37:44PM +0100, Kevin Wolf wrote:
>> Am 13.12.2024 um 16:56 hat Daniel P. Berrangé geschrieben:
>>> On Thu, Nov 28, 2024 at 06:51:20PM +0800, tugy@chinatelecom.cn wrote:
>>>> From: Guoyi Tu <tugy@chinatelecom.cn>
>>>>
>>>> Currently, disk I/O encryption and decryption operations are performed sequentially
>>>> in the main thread or IOthread. When the number of I/O requests increases,
>>>> this becomes a performance bottleneck.
>>>>
>>>> To address this issue, this patch use thread pool to perform I/O encryption
>>>> and decryption in parallel, improving overall efficiency.
>>>
>>> We already have support for parallel encryption through use of IO threads
>>> since approximately this commit:
>>>
>>>    commit af206c284e4c1b17cdfb0f17e898b288c0fc1751
>>>    Author: Stefan Hajnoczi <stefanha@redhat.com>
>>>    Date:   Mon May 27 11:58:50 2024 -0400
>>>
>>>      block/crypto: create ciphers on demand
>>>      
>>>      Ciphers are pre-allocated by qcrypto_block_init_cipher() depending on
>>>      the given number of threads. The -device
>>>      virtio-blk-pci,iothread-vq-mapping= feature allows users to assign
>>>      multiple IOThreads to a virtio-blk device, but the association between
>>>      the virtio-blk device and the block driver happens after the block
>>>      driver is already open.
>>>      
>>>      When the number of threads given to qcrypto_block_init_cipher() is
>>>      smaller than the actual number of threads at runtime, the
>>>      block->n_free_ciphers > 0 assertion in qcrypto_block_pop_cipher() can
>>>      fail.
>>>      
>>>      Get rid of qcrypto_block_init_cipher() n_thread's argument and allocate
>>>      ciphers on demand.
>>>
>>>
>>> Say we have QEMU pinned to 4 host CPUs, and we've setup 4 IO threads
>>> for the disk, then encryption can max out 4 host CPUs worth of resource.
>>
>> This is a lot of "if"s. Even just that it requires explicit
>> configuration and doesn't work out of the box would be a strong point
>> for me why having something that works by default (like a thread pool)
>> is worth it.
>>
>> You're assuming that it's even possible to setup 4 iothreads which share
>> the load evenly. That's not a given at all. The only device that can
>> even make use of more than one iothread is virtio-blk. (And if we're
>> looking at all devices that exist in QEMU, most devices can't even make
>> use of a single iothread!) But if you do have a virtio-blk device, then
>> that setup means one iothread per queue. In a Linux guest, if all I/O
>> comes from a single CPU, then it will use the same queue and we'll have
>> three idle iothreads and one that is overloaded.
>>
>> So in order to achieve a similar effect with iothreads, you must be
>> using virtio-blk, you must explicitly configure four iothreads and four
>> mappings of virtqueues to iothreads, and you must run a workload in the
>> guest that performs I/O from four different threads running on different
>> CPUs.
>>
>> There are certainly good use cases for iothreads, but with this number
>> of preconditions, I don't think we can assume that they make it
>> unnecessary to parallelise things in other ways, too.
> 
> Ok thanks for the background, that all makes sense as a justification.
> Lets capture a summary of this in the commit message.
> 
>>> How is this new proposed way to use a thread pool going to do better
>>> than that in an apples-to-apples comparison ? ie allow same number
>>> of host CPUs for both. The fundamental limit is still the AES performance
>>> of the host CPU(s) that you allow QEMU to execute work on. If the thread
>>> pool is allowed to use 4 host CPUs, it shouldn't be significantly different
>>> from allowing use of 4 host CPUs for I/O threads surely ?
>>>
>>> Having multiple different ways to support parallel encryption is not
>>> ideal. If there's something I/O threads can't do optimally right
>>> now, is it practical to make them work better ?
>>
>> The limitations inside the guest obviously can't be changed by QEMU.
>>
>> We could in theory add iothread support to more devices, though if they
>> don't have a concept of multiple queues that could be processed by
>> different threads, it's pretty pointless (apart from working around
>> limitations in the backends like you're suggesting here).
>>
>> And of course, the most interesting one would be solving the
>> out-of-the-box aspect. This is far from trivial, because the optimal
>> configuration really depends on your workload, and nothing on the host
>> can know automatically what will eventually run in the guest. So it will
>> be tough finding defaults that improve this case without also hurting
>> other cases.
> 
> Yes, understood, I was missing the impact of the guest usage model.
> 
> With regards,
> Daniel


