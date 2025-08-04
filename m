Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECB9C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0nM-0007QN-Hq; Mon, 04 Aug 2025 15:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uizc6-0004Dw-T6; Mon, 04 Aug 2025 14:08:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uizc2-0002cc-T8; Mon, 04 Aug 2025 14:08:46 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 574I89aZ063021
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 5 Aug 2025 03:08:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SKOSpHFfOCPcb8SgPg0FstxcoWlGqk+DWsErIK62MuY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754330890; v=1;
 b=Er3vupg+Kz2Atzg36oVfxwViHeW3y9Yx80j9ImDgt4VUdFKsyFtpI7aacRqBZ2nS
 ckBZzqmi/iLHJ+C0ixNQ52R6fzcIWGC2TdXI7p4foY0x90uLaBdhf1RG0M4wg8yA
 2Hgqe45DLH8seVy/DZvqMJelJjeI/L1cm+z4VkfJttZjbF3wsvWfuXaFCZTRrzFQ
 XjpJlAMOU7vETwpbhTVqft9P5XF9MjAT7GzgRLxfaftBjI5rQhozw8wjVcqr01Qc
 UHs7QzolJDIaZ8uj20ocS8d9Ik89ZWYmXbmRywBWjxwfeC6nbB/kjzvpk4xbBL2Q
 4ltDzkYdprSqKg2KRWiHAQ==
Message-ID: <0c75fd39-caa2-4ada-9cb8-a83e43119bfe@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 5 Aug 2025 03:08:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
 <f1a331ae-f520-44d7-82a7-c5dbef3440a2@rsg.ci.i.u-tokyo.ac.jp>
 <aIz5Hr7wDthdxgNP@armenon-kvm.bengluru.csb>
 <8905b290-24bb-4f90-a857-64d2a0f71a27@rsg.ci.i.u-tokyo.ac.jp>
 <aJBlvymcYCeixPGA@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aJBlvymcYCeixPGA@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/08/04 16:48, Arun Menon wrote:
> Hi Akihiko,
> 
> On Sun, Aug 03, 2025 at 04:15:16PM +0900, Akihiko Odaki wrote:
>> On 2025/08/02 2:27, Arun Menon wrote:
>>> Hi Akihiko,
>>> Thanks for the review.
>>>
>>> On Fri, Aug 01, 2025 at 04:35:34PM +0900, Akihiko Odaki wrote:
>>>> On 2025/07/31 22:21, Arun Menon wrote:
>>>>> Currently post_save hook is called without checking its return. If post_save
>>>>> fails, we need to set an error and propagate it to the caller.
>>>>>
>>>>> Since post_save hook is called regardless of whether there is a preceeding error,
>>>>> it is possible that we have 2 distict errors, one from the preceeding function
>>>>> call, and the other from the post_save call.
>>>>>
>>>>> Return the latest error to the caller.
>>>>
>>>> This needs to be explained better. This patch makes two changes on the
>>>> behavior when there are two errors:
>>>>
>>>> 1) Proceeding errors were propagated before, but they are now
>>>>      dismissed.
>>>> 2) post_error() errors were dismissed before, but they are now
>>>>      propagated.
>>>>
>>>> This message doesn't mention 1) at all. It does say 2) is necessary, but
>>>> does not explain why.
>>>
>>> Please correct me if I am wrong, does the following look ok?
>>>
>>> Currently post_save() hook is called without checking its return.
>>> post_save() hooks, generally does the cleanup, and that is the reason why
>>> we have been dismissing its failure.
>>>
>>> We want to consider
>>>     - the saving of the device state (save or subsection save) and
>>>     - running the cleanup after
>>> as an atomic operation. And that is why, post_save is called regardless
>>> of whether there is a preceeding error.
>>> This means that, it is possible that we have 2 distict errors, one from
>>> the preceeding function and the other from the post_save() function.
>>>
>>> This patch makes two changes on the behavior when there are two errors:
>>>
>>> 1) Preceeding errors were propagated before, but they are now
>>>      dismissed if there is a new post_save() error.
>>> 2) post_save() errors were dismissed before, but they are now
>>>      propagated.
>>>
>>> We intend to extend the error propagation feature (saving erros in
>>> Error object and return to the caller) to the post/pre
>>> save/load hooks. Therefore, it is important for the user to know
>>> the exact reason of failure in case any of these hooks fail.
>>>
>>> ====
>>> I do not know much about the operations we do, or intend to do
>>> using the post_save() call. But my guess is that we are going to
>>> revert things or cleanup stuff, and if reverting/cleanup fails,
>>> then the user should be notified about that.
>>
>> All what you stated sounds correct to me and explains 2). But there is still
>> no reasoning for 1).
>>
>> Previously I listed three possible design options:
>>> - propagate whatever error easier to do so
>>> - somehow combine errors
>>>    (languages that support exceptions often do this)
>>> - make sure that no error will happen when there is a proceeding error
>>>    by having two callbacks:
>>>    - One callback that is called only when there is no proceeding error
>>>      and can raise an error
>>>    - Another that is always called but cannot raise an error
>>
>> https://lore.kernel.org/qemu-devel/1ff92294-5c8c-4b33-89c1-91d37d6accb0@rsg.ci.i.u-tokyo.ac.jp/
>>
>> It will be a good reasoning if we can show propagating post_save() errors is
>> easier (or more important) than propagating proceeding errors.
>>
>> There are alternative options. "Making sure that no error will happen when
>> there is a proceeding error by having two callbacks" is one of them. You
>> wrote:
>>> We want to consider
>>>     - the saving of the device state (save or subsection save) and
>>>     - running the cleanup after
>>> as an atomic operation. And that is why, post_save is called
>>> regardless of whether there is a preceeding error.
>>> This means that, it is possible that we have 2 distict errors, one
>>> from the preceeding function and the other from the post_save()
>>> function.
>>
>> But it may not be mandatory. In fact, I searched "post_save" in the code
>> base and found all implementations are for cleanup and always succeeds,
>> which makes sense; most (if not all) cleanup operations like g_free() always
>> succeeds in general.
> 
> post_save calls do succeed in general.
> Now, we are introducing the post_save_errp() function which is an alternative to the
> post_save() call. We are adding the feature to catch errors in Error object,
> thereby clearly considering the case where post_save_erp can go wrong.
> So we have already deviated from the old design that all post_save operations are
> infalliable cleaup routines. The only catch is, these alternate functions are introduced
> a couple of commits later.
> 
> If that is the case, then we need to handle both the errors, and propagate only
> the most significant (which in my opinion is the post_save) one.
> 
> In other words, the reasoning for 1,
> 	1) Proceeding errors were propagated before, but they are now dismissed.
> 
> is that,
> a failure during the preceeding operation means that we failed in saving the state
> but a failure during the post-save call, means that we failed in cleanup or restoring
> back the system to a stable state, which is a more serious one, because it may lead to
> the system being in an inconsistent state.
> Can I write something on these lines, to justify the change?

That is better, but also gives another question: when will "cleanup or 
restoring back the system to a stable state" fail? We already know that 
the all post_save() always succeeds, so there should be some anticipated 
use case that requires us to "deviate from the old design that all 
post_save operations are infalliable cleanup routines".

> 
>>
>> So perhaps "making sure that no error will happen when there is a proceeding
>> error" may be feasible, and it may not even require two callbacks because
>> post_save() always succeeds.
> 
> I am sorry, I could not completely understand the part, where you mentioned that
> we need to have 2 callbacks; I am assuming you are mentioning something like try..catch,
> finally blocks from the other languages.
> post_save (that can not raise an error) being called in the goto block.

Such two callbacks would handle two scenarios you previously wrote, 
respectively:
 > We want to consider
 >     - the saving of the device state (save or subsection save) and
 >     - running the cleanup after
 > as an atomic operation.

An analogy with try/catch/finally will indeed clarify the idea, though 
"catch" is not relevant here. It will look like as follows:

try {
   /* A pseudo function that represents the save operation. */
   save();

   /*
    * A new callback that can raise an error.
    * It will not be called if save() fails.
    */
   vmsd->commit_save();
} finally {
   /*
    * The old callback. Returning non-zero value is deprecated.
    * Any implementations that return a non-zero value should be
    * gradually converted to the new commit_save() callback.
    */
   vmsd->post_save();
}

> 
> So if the main operation fails, we say goto cleanup, and then execute post_save which always
> succeeds. If the main operation succeeds then we call post_save that can raise an error. Please correct
> me if I am wrong.

Yes, that's what I meant.

Regards,
Akihiko Odaki

