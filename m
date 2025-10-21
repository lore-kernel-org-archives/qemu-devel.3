Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C9CCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 04:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB3lc-0000MZ-1G; Tue, 21 Oct 2025 00:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vB3lU-0000M3-Tx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 00:14:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vB3lR-0005Cp-RP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 00:14:28 -0400
Received: from [172.130.10.202] ([115.90.12.10]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59L4E5TN053570
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Oct 2025 13:14:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NtViMifSKa8bcb2S8GAsLPfA2vg3FA20dkAtEFJgk9Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761020046; v=1;
 b=Qo21gj1NJYlAUyYBa6HNCK1GcDaWSmj5+LcrFVdHc57Ia3yYcbgTRUIC0NcW+x7f
 wqG1+bnaa/t8WFofCUhU9II7bxJV+iO8UD4nRORyCW5caEDgFF2b8SHvxB7gfOx1
 hu2fLeBomjz2VSy4ckJCBnIM2+tkqpyonEU2plyZnm6uOJtth/2hFjnAPSqbIwsb
 iXk6LrKOS/imK4etoZ73pw+Ta/LXYcqNj85cnN3yEnbSs4WutDiv/5J/q3Ot83Bj
 sgH8EfXrCH/+cwyT+K9zqiX1kSjljpx5/Qa3+im9LcdK33ZvqsCJ0gMe8HnUQILz
 0nLQYZxz9lT4c6c1Xaejzw==
Message-ID: <f5d55625-10e0-496f-9b3e-2010fe0c741f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Oct 2025 13:14:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
 <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
 <aa0b2645-cc24-40f7-b4c3-82c86eefc9b2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aa0b2645-cc24-40f7-b4c3-82c86eefc9b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/10/20 15:38, Paolo Bonzini wrote:
> On 10/16/25 21:33, Dmitry Osipenko wrote:
>> On 10/16/25 09:34, Akihiko Odaki wrote:
>>> -        /* Wait for one thread to report a quiescent state and try 
>>> again.
>>> +        /*
>>> +         * Sleep for a while and try again.
>>>            * Release rcu_registry_lock, so rcu_(un)register_thread() 
>>> doesn't
>>>            * wait too much time.
>>>            *
>>> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>>>            * rcu_registry_lock is released.
>>>            */
>>>           qemu_mutex_unlock(&rcu_registry_lock);
>>> -        qemu_event_wait(&rcu_gp_event);
>>> +
>>> +        if (forced) {
>>> +            qemu_event_wait(&rcu_gp_event);
>>> +
>>> +            /*
>>> +             * We want to be notified of changes made to rcu_gp_ongoing
>>> +             * while we walk the list.
>>> +             */
>>> +            qemu_event_reset(&rcu_gp_event);
>>> +        } else {
>>> +            g_usleep(10000);
>>> +            sleeps++;
>>
>> Thanks a lot for this RCU improvement. It indeed removes the hard stalls
>> with unmapping of virtio-gpu blobs.
>>
>> Am I understanding correctly that potentially we will be hitting this
>> g_usleep(10000) and stall virtio-gpu for the first ~10ms?
> 
> Would it help to have some kind of exponential backoff, starting with 
> 1-3 ms and increasing after the first wait?  Something like 
> 1.5/3/6/12/12/12 ms would have a similar effect but reduce the wait if 
> the vCPU kick is fast enough.

vCPU kick is needed only for TCG and triggered with force_rcu when 
entering the force quiescent state. The state is entered only after 
finishing all polling checks, so shortening only the early ones may not 
be effective for TCG.

It also increases the overhead for users other than virtio-gpu. I 
suppose the first 10 ms sleep is sufficient for the most case, which 
minimizes context switching due to sleep/wakeup. However, it is more 
likely that a few of the early sleeps and their wakeups will be 
triggered if they are shortened.

Now I'm thinking of adding an RCU API to request the force quiescent 
state for virtio-gpu. It will be able to utilize the force quiescent 
state (particularly for TCG) and is zero cost unless virtio-gpu is used.

Regards,
Akihiko Odaki

