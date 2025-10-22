Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B898CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 03:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBPZ2-0002M0-UA; Tue, 21 Oct 2025 23:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vBPYz-0002Lr-92
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 23:31:01 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vBPYv-0008J7-LY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 23:31:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1761103841; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lcz3zRt33FMF3SPyxj7P6CwztOIMRbgNzOoaPbraeB56HBKDu3gQR4AAJ8ANrlkiJlZZf2gYBTZ9YUklk85cNDnUmqYPoMZ8lQLvhoYXQ3zp6bvnJw1Z4KyhARw5B+XbRYIIJirf8F2qxlX7hqLFefiN0G2opxSCIl9Q1CBgVB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1761103841;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XHeF+j8dx0VLPM2ywfz6XVaQshQvCJFq87SWg+mg4ks=; 
 b=M5jbf9HYMxuzu2uNS5PkA7TEXqotPeGv5JRxLjz2QPYCm4hYB6T4uVNJBDeMRABMgfXcHqVMNZxbOFZOOLhGWiDTmyO9y/frxgJ9u7V/geywY8b/93AegsAp5TjigV6Q+mA2All9MPuyGp+LQrAqLM3AwvX3ejn52vMIfRxvTj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761103841; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XHeF+j8dx0VLPM2ywfz6XVaQshQvCJFq87SWg+mg4ks=;
 b=D9XrDzeJismn7gC8OMxSIZsCsYRB2P1PjYpexIeGXXlQiAotmhPbHdsyi/m+uauW
 ziul3axGKnvs8SAvvndzMNhGki2tEWLAaD4TyUrzZqCoZIWl7ex1AU8YlyG0zyXCSUm
 WA+RdcFC7G+WsQ3KqSdWLBJH4phyX2KtA77ZYL9s=
Received: by mx.zohomail.com with SMTPS id 1761103838792595.3478881674172;
 Tue, 21 Oct 2025 20:30:38 -0700 (PDT)
Message-ID: <38973a24-787a-4ec0-866b-7f4a7a7824d1@collabora.com>
Date: Wed, 22 Oct 2025 06:30:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
 <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
 <626016e1-c7d8-4377-bf9f-ab0f0eef1457@rsg.ci.i.u-tokyo.ac.jp>
 <f89d4a21-635a-4779-95c1-7db0abe66863@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <f89d4a21-635a-4779-95c1-7db0abe66863@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/17/25 03:40, Akihiko Odaki wrote:
> On 2025/10/17 8:43, Akihiko Odaki wrote:
>> On 2025/10/17 4:33, Dmitry Osipenko wrote:
>>> On 10/16/25 09:34, Akihiko Odaki wrote:
>>>> -        /* Wait for one thread to report a quiescent state and try
>>>> again.
>>>> +        /*
>>>> +         * Sleep for a while and try again.
>>>>            * Release rcu_registry_lock, so rcu_(un)register_thread()
>>>> doesn't
>>>>            * wait too much time.
>>>>            *
>>>> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>>>>            * rcu_registry_lock is released.
>>>>            */
>>>>           qemu_mutex_unlock(&rcu_registry_lock);
>>>> -        qemu_event_wait(&rcu_gp_event);
>>>> +
>>>> +        if (forced) {
>>>> +            qemu_event_wait(&rcu_gp_event);
>>>> +
>>>> +            /*
>>>> +             * We want to be notified of changes made to
>>>> rcu_gp_ongoing
>>>> +             * while we walk the list.
>>>> +             */
>>>> +            qemu_event_reset(&rcu_gp_event);
>>>> +        } else {
>>>> +            g_usleep(10000);
>>>> +            sleeps++;
>>>
>>> Thanks a lot for this RCU improvement. It indeed removes the hard stalls
>>> with unmapping of virtio-gpu blobs.
>>>
>>> Am I understanding correctly that potentially we will be hitting this
>>> g_usleep(10000) and stall virtio-gpu for the first ~10ms? I.e. the
>>> MemoryRegion patches from Alex [1] are still needed to avoid stalls
>>> entirely.
>>>
>>> [1]
>>> https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-
>>> alex.bennee@linaro.org/
>>
>> That is right, but "avoiding stalls entirely" also causes use-after-free.
>>
>> The problem with virtio-gpu on TCG is that TCG keeps using the old
>> memory map until force_rcu is triggered. So, without force_rcu, the
>> following pseudo-code on a guest will result in use-after-free:
>>
>> address = blob_map(resource_id);
>> blob_unmap(resource_id);
>>
>> for (i = 0; i < some_big_number; i++)
>>    *(uint8_t *)address = 0;
>>
>> *(uint8_t *)address will dereference the blob until force_rcu is
>> triggered, so finalizing MemoryRegion before force_rcu results in use-
>> after-free.
>>
>> The best option to eliminate the delay entirely I have in mind is to
>> call drain_call_rcu(), but I'm not for such a change (for now).
>> drain_call_rcu() eliminates the delay if the FlatView protected by RCU
>> is the only referrer of the MemoryRegion, but that is not guaranteed.
>>
>> Performance should not be a concern anyway in this situation. The
>> guest should not waste CPU time by polling in the first place if you
>> really care performance; since it's a para-virtualized device and not
>> a real hardware, CPU time may be shared between the guest and the
>> device, and thus polling on the guest has an inherent risk of slowing
>> down the device. For performance-sensitive workloads, the guest should:
>>
>> - avoid polling and
>> - accumulate commands instead of waiting for each
>>
>> The delay will be less problematic if the guest does so, and I think
>> at least Linux does avoid polling.
>>
>> That said, stalling the guest forever in this situation is "wrong" (!=
>> "bad performance"). I wrote this patch to guarantee forward progress,
>> which is mandatory for semantic correctness.
>>
>> Perhaps drain_call_rcu() may make sense also in other, performance-
>> sensitive scenarios, but it should be added after benchmark or we will
>> have a immature optimization.
> 
> I first thought just adding drain_call_rcu() would work but apparently
> it is not that simple. Adding drain_call_rcu() has a few problems:
> 
> - It drops the BQL, which should be avoided. Problems caused by
> run_on_cpu(), which drops the BQL, was discussed on the list for a few
> times and drain_call_rcu() may also suffer from them.
> 
> - It is less effective if the RCU thread enters g_usleep() before
> drain_call_rcu() is called.
> 
> - It slows down readers due to the nature of drain_call_rcu().
> 
> So, if you know some workload that may suffer from the delay, it may be
> a good idea to try them with the patches from Alex first, and then think
> of a clean solution if it improves performance.

What's not clear to me is whether this use-after-free problem affects
only TCG or KVM too.

Can we unmap blob immediately using Alex' method when using KVM? Would
be great if we could optimize unmapping for KVM. TCG performance is a
much lesser concern.

-- 
Best regards,
Dmitry

