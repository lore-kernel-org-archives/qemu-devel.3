Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F9C3DA61
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 05:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXZwq-0007wg-6X; Sat, 27 Jul 2024 01:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1sXZwo-0007pq-DQ
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 01:26:26 -0400
Received: from smtpnm6-10.21cn.com ([182.42.147.92] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1sXZwl-0005z5-JH
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 01:26:26 -0400
HMM_SOURCE_IP: 192.168.138.117:0.1813631041
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-112.44.135.226 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 8A48EB023C02;
 Sat, 27 Jul 2024 13:18:34 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([112.44.135.226])
 by gateway-ssl-dep-67bdc54df-qz2qs with ESMTP id
 33bef313a3c147af95851c15975a5609 for berrange@redhat.com; 
 Sat, 27 Jul 2024 13:18:42 CST
X-Transaction-ID: 33bef313a3c147af95851c15975a5609
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 112.44.135.226
X-MEDUSA-Status: 0
Message-ID: <80321ce6-1596-460d-b4e1-622a0b69f8e1@chinatelecom.cn>
Date: Sat, 27 Jul 2024 13:18:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn, zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
 <87h6cdogau.fsf@pond.sub.org> <ZqI9tgHzWudxBUn9@redhat.com>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <ZqI9tgHzWudxBUn9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.147.92; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

On 2024/7/25 19:57, Daniel P. Berrangé wrote:
> On Thu, Jul 25, 2024 at 01:35:21PM +0200, Markus Armbruster wrote:
>> Guoyi Tu <tugy@chinatelecom.cn> writes:
>>
>>> In the test environment, we conducted IO stress tests on all storage disks
>>> within a virtual machine that had five storage devices mounted.During
>>> testing,
>>> we found that the qemu process allocated a large amount of memory (~800MB)
>>> to handle these IO operations.
>>>
>>> When the test ended, although qemu called free() to release the allocated
>>> memory, the memory was not actually returned to the operating system, as
>>> observed via the top command.
>>>
>>> Upon researching the glibc memory management mechanism, we found that when
>>> small chunks of memory are allocated in user space and then released with
>>> free(),  the glibc memory management mechanism does not necessarily return
>>> this memory to the operating system. Instead, it retains the memory until
>>> certain conditions are met for release.
>>
>> Yes.
> 
> Looking at mallopt(3) man page, the M_TRIM_THRESHOLD is said to control
> when glibc releases the top of the heap back to the OS. It is said to
> default to 128 kb.
Yes, the M_TRIM_THRESHOLD option can control glibc to release the free
memory at the top of the heap, but glibc will not release the free
memory in the middle of the heap.

> I'm curious how we get from that default, to 800 MB of unused memory > Is it related to the number of distinct malloc arenas that are in use ?

At least 600MB of memory is free, and this memory might be in the middle 
of the heap and cannot be automatically released.

> I'm curious what malloc_stats() would report before & after malloc_trim
> when QEMU is in this situation with lots of wasted memory.
Here is the test case:
1. start the test process

     Rss:                1504 kB

     malloc_stats:
     Arena 0:
     system bytes     =     135168
     in use bytes     =       5808
     Total (incl. mmap):
     system bytes     =     135168
     in use bytes     =       5808
     max mmap regions =          0
     max mmap bytes   =          0

2. Call malloc to allocate memory 320 times, each memory chunk is 64KiB
    and total allocated memory is 20MiB

     Rss:               21992 kB

     malloc_stats:
     Arena 0:
     system bytes     =   21049344
     in use bytes     =   20982448
     Total (incl. mmap):
     system bytes     =   21049344
     in use bytes     =   20982448
     max mmap regions =          0
     max mmap bytes   =          0

3. free the first 319 chunks , total size: 20416 KiB

     Rss:               21992 kB

     malloc_stats:
     Arena 0:
     system bytes     =   21049344
     in use bytes     =      71360
     Total (incl. mmap):
     system bytes     =   21049344
     in use bytes     =      71360
     max mmap regions =          0
     max mmap bytes   =          0

4. free the last one

     Rss:                1636 kB

     malloc_stats:
     Arena 0:
     system bytes     =     139264
     in use bytes     =       5808
     Total (incl. mmap):
     system bytes     =     139264
     in use bytes     =       5808
     max mmap regions =          0
     max mmap bytes   =          0


>>
>>> For virtual machines that only have business operations during specific
>>> periods,  they remain idle most of the time. However, the qemu process
>>> still occupies a large amount of memory resources, leading to significant
>>> memory resource waste.
>>
>> Mitigation: the memory free()'s but not returned to the OS can be paged
>> out.
>>
>>> To address this issue, this patch introduces an API to actively reclaim
>>> idle memory within the qemu process. This API effectively calls
>>> malloc_trim()
>>> to notify glibc to trim free memory. With this api, the management tool
>>> can monitor the virtual machine's state and call this API during idle times
>>> to free up the memory occupied by the virtual machine, thereby allowing more
>>> virtual machines to be provisioned.
>>
>> How does this affect the test case you described above?
>>
>> There's an existing use of malloc_trim() in util/rcu.c's
>> call_rcu_thread().  It's from commit 5a22ab71623:
>>
>>      rcu: reduce more than 7MB heap memory by malloc_trim()
>>      
>>      Since there are some issues in memory alloc/free machenism
>>      in glibc for little chunk memory, if Qemu frequently
>>      alloc/free little chunk memory, the glibc doesn't alloc
>>      little chunk memory from free list of glibc and still
>>      allocate from OS, which make the heap size bigger and bigger.
>>      
>>      This patch introduce malloc_trim(), which will free heap
>>      memory when there is no rcu call during rcu thread loop.
>>      malloc_trim() can be enabled/disabled by --enable-malloc-trim/
>>      --disable-malloc-trim in the Qemu configure command. The
>>      default malloc_trim() is enabled for libc.
>>      
>>      Below are test results from smaps file.
>>      (1)without patch
>>      55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
>>      Size:              21796 kB
>>      Rss:               14260 kB
>>      Pss:               14260 kB
>>      
>>      (2)with patch
>>      55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
>>      Size:              21668 kB
>>      Rss:                6940 kB
>>      Pss:                6940 kB
>>      
>>      Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>>      Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
>>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> How would the malloc_trim() you propose interact with this one?
> 
> The above usage is automatic, while this proposal requires that
> an external mgmt app monitor QEMU and tell it to free memory.
> I'm wondering if the latter is really desirable, or whether QEMU
> can call this itself when reasonable ?

Yes, I have also considered implementing an automatic memory release
function within qemu. This approach would require qemu to periodically
monitor the IO load of all backend storage, and if the IO load is very
low over a period of time, it would proactively release memory.

This patch is a preliminary implementation, and I also want to discuss 
with you which implementation approach is more reasonable.

So, which approach do you prefer?
> 
> With regards,
> Daniel

