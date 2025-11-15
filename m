Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5BFCE8D7A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 01:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK5Yf-0002XW-4G; Fri, 14 Nov 2025 20:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vK5Yb-0002Wg-8q
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:58:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vK5YY-0006AM-Lf
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:58:28 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AF1wBKm093332
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 15 Nov 2025 10:58:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/rRPfQMHYXIti5J/uYa1p1g9UBoYEzR34chujsG5sVk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763171892; v=1;
 b=kTbc7nCZiprGH9JrYRFbC5n/76tBAVc9BGSSSXkrLRVUoGVdMJbuYrskV0OnOAkf
 SSjBxPFqb8x7OPQkKyNzCLirI3+hjM+htJsx94aiWV2bjNjO8ridxQPxFRGaxkvB
 4IgD/04ehE5LfNoyTA6F938/2NfsYZXugklje/yePkBvG78Og7VBNfoG6x6Uk5GV
 esDv9DhM7nh2E/e7lciLhrOZWxsH9xofLfIQccfpP6ZyCzFhIviyyT6hno9CosGV
 zRdC7BEWUn8s9Ufp63yUocg8FCWXZXnEA8QBUh6Gss852fjGquVNbpAycBIXMSHy
 GfX+IO6V8YtwcyZXv+2Eog==
Message-ID: <a8c03d1e-a3f4-40de-a633-7b15ec2288e3@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 15 Nov 2025 10:58:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
 <aRYPXh_9m5ZvTi2w@x1.local>
 <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
 <aRdLFwxzJwjsXFpY@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aRdLFwxzJwjsXFpY@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/15 0:30, Peter Xu wrote:
> On Fri, Nov 14, 2025 at 10:24:40AM +0900, Akihiko Odaki wrote:
>> However it creates another problem. Think of the following sequence:
>>
>> call_rcu_thread()              |
>>                                 | call_rcu1()
>>                                 |  qatomic_fetch_inc(&rcu_call_count)
>>                                 |  qemu_sem_post(&sync_event)
>>                                 |
>>   qatomic_read(&rcu_call_count) |
>>   enter_qs(false)               |
>>    wait_for_readers(false)      |
>>     qemu_sem_timedwait(         |
>>      &sync_event, 10)           |
>>
>> qemu_sem_timedwait() incorrectly interrupts the RCU thread and enters the
>> force quiescent state.
> 
> First thing to mention is, IIUC above can't happen because if
> call_rcu_thread() is already waked up and reaching enter_qs(), then there
> should have been, for example, a prior call_rcu1() that incremented
> rcu_call_count and posted to sync_event, hence rcu_call_count cannot be 0
> anymore in the call_rcu1() above, because the sub happens later:
> 
> call_rcu_thread:
>          ... sees rcu_call_count > 0, quit loop ...
>          ...
>          enter_qs(sleep);
>          qatomic_sub(&rcu_call_count, n); <-------------------------
>          ...
> 
> That means the concurrent call_rcu1() above will not post sem anymore
> because it will only post it if rcu_call_count==0.
Below is an extended version of the sequence:

call_rcu_thread()                |
  qatomic_sub(&rcu_call_count, n) |
  (sets rcu_call_count to 0)      |
                                  | call_rcu1()
                                  |  qatomic_fetch_inc(&rcu_call_count)
                                  |  qemu_sem_post(&sync_event)
  qatomic_read(&rcu_call_count)   |
  enter_qs(false)                 |
   wait_for_readers(false)        |
   qemu_sem_timedwait(            |
    &sync_event, 10)              |

Note that there may not be a qemu_sem_wait(&sync_event) call between 
qatomic_sub(&rcu_call_count, n) and qatomic_read(&rcu_call_count).

> 
> Besides, IMHO replacing the event with sem shouldn't change similar
> behavior comparing to when using events.  Because any spot that can post()
> concurrently can also does qemu_event_set() concurrently... after all, we
> only have a few spots resettting the event in the original patch, after the
> reset a concurrent qemu_event_set() will re-activate it.

The sequence I showed is handled properly with properly placed 
qemu_event_reset():

call_rcu_thread()                |
  qatomic_sub(&rcu_call_count, n) |
  (sets rcu_call_count to 0)      |
                                  | call_rcu1()
                                  |  qatomic_fetch_inc(&rcu_call_count)
                                  |  qemu_event_set(&sync_event)
  qatomic_read(&rcu_call_count)   |
  qemu_event_reset(&sync_event)   |
  enter_qs(false)                 |
   wait_for_readers(false)        |
    qemu_sem_timedwait(           |
     &sync_event, 10)             |

Note that a concurrent qemu_event_set() after resetting the event can 
only triggered with force_rcu(), which is intended to interrupt 
wait_for_readers().

> 
> Sem does introduce possible false positives on events, but as I was trying
> to justify, a generic VM boots and shutdown should need less than 1000 rcu
> calls, so worst case is we loop read rcu_call_count 1000 times... I also
> didn't measure how many of such call_rcu1() will see N>0 so they'll not
> post() to sem at all, I believe it'll be common.  So the perf overhead
> should really be rare, IMHO.
> 
> Note that I was not requesting you to replace this event to sem before
> merging.  Frankly, I think your work is good enough to land.
> 
> However I still want to discuss a sem replacement, not only because this is
> the best place to discuss it (after all, force rcu starts to introduce a
> genuine second user of the event besides call_rcu1, hence the "being able
> to remember more than 1" will start to make more sense than avoid resets),
> it looks also cleaner to remove some new code force rcu adds.

How do "being able to remember more than 1" help?

Regards,
Akihiko Odaki

