Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A453CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqQt-0000eK-O7; Tue, 26 May 2026 07:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wRqQn-0000e2-Br
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:58:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wRqQd-00031e-W2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:58:40 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64QBwKIA066309
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 May 2026 20:58:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SBVpjL55EPSIGUpAEhzj7vUcXdB6yr0HxPEuFNFzuZg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779796700; v=1;
 b=fBwKLSEXZmO8CDb1KHuCeOLlPVYCjGqVehJGQZqVxce8UFeDmbEb3HGu1EPlD9Cy
 dFX0Mi//RkLN8C2yFrYcFMfrh/E4pTRHFUSVAKLbcsd+QWM/634795xjgBlbY+e+
 uYOyXbk+Hcg6wd2ePaehjri7GFBffb+g9S6IQum8ArbOqSXSxlrFnZ7RVUnnVBWf
 oMMOPSPJuk0yJzMiyxPu52ShjtSlEadWiqBbVsnRP3JHAjwfkmp+bB91q0Y3u5VM
 2V331LD4zoWOxJX1pig9AeH/yzLmQ3ET98eNcUVCMxSDyU1LUYzJ2afFs4OBUSmM
 2SmV5ZbGvf/uwkJWHeUJMw==
Message-ID: <39c1c69a-0c4e-43f3-9abb-269fc100024c@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 26 May 2026 20:58:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Synchronize ram_list accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
 <b0754ae4-41bd-4f9d-b24b-9981ebea5a3e@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b0754ae4-41bd-4f9d-b24b-9981ebea5a3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2026/05/26 18:22, Philippe Mathieu-Daudé wrote:
> On 23/5/26 14:38, Akihiko Odaki wrote:
>> Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
>> access to ram_list [1]. Ensure the concurrent accesses to ram_list are
>> properly synchronized with atomic accesses, mutexes, or RCU.
>>
>> First, the plain assignments of ram_list.mru_block are replaced with
>> qatomic_set(). A comment in qemu_get_ram_block() explains why the
>> ordering requirement is relaxed, but it still needs to be atomically
>> accessed. include/qemu/atomic.h says:
>>
>>> The C11 memory model says that variables that are accessed from
>>> different threads should at least be done with __ATOMIC_RELAXED
>>> primitives or the result is undefined. Generally this has little to
>>> no effect on the generated code but not using the atomic primitives
>>> will get flagged by sanitizers as a violation.
>>
>> Second, ram_list.version accesses are replaced with atomic operations
>> or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
>> has tighter ordering requirements for one of its goals: ensuring that
>> the reader-held rs->last_seen_block value is invalidated whenever a RAM
>> block is reclaimed between two RCU reader critical sections. Below are
>> steps a reader and an updater follow:
>>
>> Reader:
>>
>> R-1. Enter the first RCU read-side critical section:
>> R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
>> R-1-2. rs->last_seen_block = an element of ram_list.blocks
>> R-2. Enter the second RCU read-side critical section:
>> R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
>> R-2-2.     rs->last_seen_block = NULL
>>
>> Updater:
>>
>> W-1. Enter a ram_list.mutex critical section
>> W-1-1. Update ram_list.blocks
>> W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
>> W-2. Enter another ram_list.mutex critical section
>> W-2-1. QLIST_REMOVE_RCU(block, next)
>> W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
>> W-2-3. call_rcu(block, reclaim_ramblock, rcu)
>>
>> W-1-2 represents the write observed by R-1-1.
>>
>> ram_list.version is read non-atomically on the update side because the
>> update side is serialized with ram_list.mutex. The other ram_list
>> accesses in these steps are reasoned about in two cases.
>>
>> When the grace period of W-2-3 contains R-2:
>>      qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
>>      enforce the following ordering:
>>          W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
>>      The value of ram_list.blocks stored by W-1-1 or a newer value that
>>      was loaded by R-1-2 is still valid because of the grace period.
>>
>> When the grace period of W-2-3 ends before R-2:
>>      call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
>>      the following ordering:
>>          W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
>>      The value of ram_list.version stored by W-2-2 or a newer value that
>>      was loaded by R-2-1 differs from rs->last_version and the reader
>>      invalidates rs->last_seen_block.
>>
>> Together, these steps ensure that rs->last_seen_block is invalidated
>> whenever necessary. With added atomic operations, pre-existing memory
>> barriers are no longer necessary and are removed.
>>
>> Any other ram_list accesses are already properly synchronized.
>>
>> [1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   migration/ram.c  | 10 +++++-----
>>   system/physmem.c | 16 +++++++---------
>>   2 files changed, 12 insertions(+), 14 deletions(-)
> 
> 
>> @@ -2260,11 +2260,10 @@ static void ram_block_add(RAMBlock *new_block, 
>> Error **errp)
>>       } else { /* list is empty */
>>           QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
>>       }
>> -    ram_list.mru_block = NULL;
>> +    qatomic_set(&ram_list.mru_block, NULL);
>>       /* Write list before version */
>> -    smp_wmb();
>> -    ram_list.version++;
>> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);
> 
> Should this be:
> 
>         qatomic_store_release(&ram_list.version,
>                               qatomic_read(&ram_list.version) + 1);
> 
>>       qemu_mutex_unlock_ramlist();
>>       physical_memory_set_dirty_range(new_block->offset,
>> @@ -2608,10 +2607,9 @@ void qemu_ram_free(RAMBlock *block)
>>       name = cpr_name(block->mr);
>>       cpr_delete_fd(name, 0);
>>       QLIST_REMOVE_RCU(block, next);
>> -    ram_list.mru_block = NULL;
>> +    qatomic_set(&ram_list.mru_block, NULL);
>>       /* Write list before version */
>> -    smp_wmb();
>> -    ram_list.version++;
>> +    qatomic_store_release(&ram_list.version, ram_list.version + 1);
> 
> ditto?

ram_list.version is read non-atomically on the update side because the 
update side is serialized with ram_list.mutex.

> 
>>       call_rcu(block, reclaim_ramblock, rcu);
>>       qemu_mutex_unlock_ramlist();
>>   }
>>
>> ---
>> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
>> change-id: 20260520-tsan-c6f1aa909a90
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
> 


