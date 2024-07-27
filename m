Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504CAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 05:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXZvk-0005bg-Fc; Sat, 27 Jul 2024 01:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1sXZvi-0005ad-89
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 01:25:18 -0400
Received: from smtpnm6-11.21cn.com ([182.42.117.141] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1sXZvd-0005is-3o
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 01:25:17 -0400
HMM_SOURCE_IP: 192.168.139.44:0.1287774539
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-112.44.135.226 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 4FD2BE010B47;
 Sat, 27 Jul 2024 13:25:04 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([112.44.135.226])
 by gateway-ssl-dep-67bdc54df-cz88j with ESMTP id
 b2020b8e87f6422c983323d2277888f6 for dave@treblig.org; 
 Sat, 27 Jul 2024 13:25:08 CST
X-Transaction-ID: b2020b8e87f6422c983323d2277888f6
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 112.44.135.226
X-MEDUSA-Status: 0
Message-ID: <6757d560-e8b1-4857-8be6-073af062bcc0@chinatelecom.cn>
Date: Sat, 27 Jul 2024 13:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn, zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
 <87h6cdogau.fsf@pond.sub.org> <ZqI9tgHzWudxBUn9@redhat.com>
 <1020253492.3796.1721956050910.JavaMail.root@jt-retransmission-dep-7c968f646d-qxbl2>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <1020253492.3796.1721956050910.JavaMail.root@jt-retransmission-dep-7c968f646d-qxbl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.117.141; envelope-from=tugy@chinatelecom.cn;
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

On 2024/7/25 20:50, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangï¿½ (berrange@redhat.com) wrote:
>> On Thu, Jul 25, 2024 at 01:35:21PM +0200, Markus Armbruster wrote:
>>> Guoyi Tu <tugy@chinatelecom.cn> writes:
>>>
>>>> In the test environment, we conducted IO stress tests on all storage disks
>>>> within a virtual machine that had five storage devices mounted.During
>>>> testing,
>>>> we found that the qemu process allocated a large amount of memory (~800MB)
>>>> to handle these IO operations.
>>>>
>>>> When the test ended, although qemu called free() to release the allocated
>>>> memory, the memory was not actually returned to the operating system, as
>>>> observed via the top command.
>>>>
>>>> Upon researching the glibc memory management mechanism, we found that when
>>>> small chunks of memory are allocated in user space and then released with
>>>> free(),  the glibc memory management mechanism does not necessarily return
>>>> this memory to the operating system. Instead, it retains the memory until
>>>> certain conditions are met for release.
>>>
>>> Yes.
>>
>> Looking at mallopt(3) man page, the M_TRIM_THRESHOLD is said to control
>> when glibc releases the top of the heap back to the OS. It is said to
>> default to 128 kb.
>>
>> I'm curious how we get from that default, to 800 MB of unused memory ?
>> Is it related to the number of distinct malloc arenas that are in use ?
> 
> I wonder which IO mechanism was being used - the 'iothreads' used to sometimes
> blow up and start 100s of threads; is that the case here?

No, qemu is not configured with iothread. If what you said is correct,
then in the case where iothread is used, the qemu process might occupy
more memory when storage IO is idle.

>> I'm curious what malloc_stats() would report before & after malloc_trim
>> when QEMU is in this situation with lots of wasted memory.
> 
> Yes; maybe also trying valgrind's massif:
>     https://valgrind.org/docs/manual/ms-manual.html
> 
> (if it works on Qemu!)
> might help say where it's going?

Thank you for your suggestion. I will use this tool to analyze which
part is allocating more memory.

--
Guoyi

> Dave
> 
>>>
>>>> For virtual machines that only have business operations during specific
>>>> periods,  they remain idle most of the time. However, the qemu process
>>>> still occupies a large amount of memory resources, leading to significant
>>>> memory resource waste.
>>>
>>> Mitigation: the memory free()'s but not returned to the OS can be paged
>>> out.
>>>
>>>> To address this issue, this patch introduces an API to actively reclaim
>>>> idle memory within the qemu process. This API effectively calls
>>>> malloc_trim()
>>>> to notify glibc to trim free memory. With this api, the management tool
>>>> can monitor the virtual machine's state and call this API during idle times
>>>> to free up the memory occupied by the virtual machine, thereby allowing more
>>>> virtual machines to be provisioned.
>>>
>>> How does this affect the test case you described above?
>>>
>>> There's an existing use of malloc_trim() in util/rcu.c's
>>> call_rcu_thread().  It's from commit 5a22ab71623:
>>>
>>>      rcu: reduce more than 7MB heap memory by malloc_trim()
>>>      
>>>      Since there are some issues in memory alloc/free machenism
>>>      in glibc for little chunk memory, if Qemu frequently
>>>      alloc/free little chunk memory, the glibc doesn't alloc
>>>      little chunk memory from free list of glibc and still
>>>      allocate from OS, which make the heap size bigger and bigger.
>>>      
>>>      This patch introduce malloc_trim(), which will free heap
>>>      memory when there is no rcu call during rcu thread loop.
>>>      malloc_trim() can be enabled/disabled by --enable-malloc-trim/
>>>      --disable-malloc-trim in the Qemu configure command. The
>>>      default malloc_trim() is enabled for libc.
>>>      
>>>      Below are test results from smaps file.
>>>      (1)without patch
>>>      55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
>>>      Size:              21796 kB
>>>      Rss:               14260 kB
>>>      Pss:               14260 kB
>>>      
>>>      (2)with patch
>>>      55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
>>>      Size:              21668 kB
>>>      Rss:                6940 kB
>>>      Pss:                6940 kB
>>>      
>>>      Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>>>      Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
>>>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> How would the malloc_trim() you propose interact with this one?
>>
>> The above usage is automatic, while this proposal requires that
>> an external mgmt app monitor QEMU and tell it to free memory.
>> I'm wondering if the latter is really desirable, or whether QEMU
>> can call this itself when reasonable ?
>>
>>
>> With regards,
>> Daniel
>> -- 
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>>

