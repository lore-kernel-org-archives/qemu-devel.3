Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6EC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 08:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiUCg-0008FG-Ce; Sun, 03 Aug 2025 04:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiSwn-0000sB-50; Sun, 03 Aug 2025 03:15:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiSwj-0003BD-5b; Sun, 03 Aug 2025 03:15:56 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5737FHxT076395
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 3 Aug 2025 16:15:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Hv5KTXWgvj9opnQ8ldaHU998EOjFFxCL1fMkesPehq4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754205317; v=1;
 b=IHoRQZlmgERn9YX8JVaSisvvBzw7K0wL4rxMASyd2yqp8NV7yRP+D34+nT2EV6SI
 SMjI/xdFQyNapEZkVTA9oozbRjeAWKCgJyiBC1t8r/1B7PVVK4ZHL9FRbj1u2Ojb
 ghCsEqogdrP/vXJwm8BZLURe36iQDhHAuFOLZ0M6hw3LJ/C1BofN5Rbq7WJGrSpI
 pIFzgUVTlc+I984TUp9POHJudaOt0xcSlK2shwyKBSYjxCe7IYNa0ra3NWiCXj99
 pzUQyTqc6xWEHWtZv0rTic3MvM/9TqHMOUqq4Fmc11NYQCaSHXH7i+sTISgebkLF
 0Qomp3MxAsDGVutbTNGlDA==
Message-ID: <8905b290-24bb-4f90-a857-64d2a0f71a27@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 3 Aug 2025 16:15:16 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aIz5Hr7wDthdxgNP@armenon-kvm.bengluru.csb>
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

On 2025/08/02 2:27, Arun Menon wrote:
> Hi Akihiko,
> Thanks for the review.
> 
> On Fri, Aug 01, 2025 at 04:35:34PM +0900, Akihiko Odaki wrote:
>> On 2025/07/31 22:21, Arun Menon wrote:
>>> Currently post_save hook is called without checking its return. If post_save
>>> fails, we need to set an error and propagate it to the caller.
>>>
>>> Since post_save hook is called regardless of whether there is a preceeding error,
>>> it is possible that we have 2 distict errors, one from the preceeding function
>>> call, and the other from the post_save call.
>>>
>>> Return the latest error to the caller.
>>
>> This needs to be explained better. This patch makes two changes on the
>> behavior when there are two errors:
>>
>> 1) Proceeding errors were propagated before, but they are now
>>     dismissed.
>> 2) post_error() errors were dismissed before, but they are now
>>     propagated.
>>
>> This message doesn't mention 1) at all. It does say 2) is necessary, but
>> does not explain why.
> 
> Please correct me if I am wrong, does the following look ok?
> 
> Currently post_save() hook is called without checking its return.
> post_save() hooks, generally does the cleanup, and that is the reason why
> we have been dismissing its failure.
> 
> We want to consider
>    - the saving of the device state (save or subsection save) and
>    - running the cleanup after
> as an atomic operation. And that is why, post_save is called regardless
> of whether there is a preceeding error.
> This means that, it is possible that we have 2 distict errors, one from
> the preceeding function and the other from the post_save() function.
> 
> This patch makes two changes on the behavior when there are two errors:
> 
> 1) Preceeding errors were propagated before, but they are now
>     dismissed if there is a new post_save() error.
> 2) post_save() errors were dismissed before, but they are now
>     propagated.
> 
> We intend to extend the error propagation feature (saving erros in
> Error object and return to the caller) to the post/pre
> save/load hooks. Therefore, it is important for the user to know
> the exact reason of failure in case any of these hooks fail.
> 
> ====
> I do not know much about the operations we do, or intend to do
> using the post_save() call. But my guess is that we are going to
> revert things or cleanup stuff, and if reverting/cleanup fails,
> then the user should be notified about that.

All what you stated sounds correct to me and explains 2). But there is 
still no reasoning for 1).

Previously I listed three possible design options:
 > - propagate whatever error easier to do so
 > - somehow combine errors
 >   (languages that support exceptions often do this)
 > - make sure that no error will happen when there is a proceeding error
 >   by having two callbacks:
 >   - One callback that is called only when there is no proceeding error
 >     and can raise an error
 >   - Another that is always called but cannot raise an error

https://lore.kernel.org/qemu-devel/1ff92294-5c8c-4b33-89c1-91d37d6accb0@rsg.ci.i.u-tokyo.ac.jp/

It will be a good reasoning if we can show propagating post_save() 
errors is easier (or more important) than propagating proceeding errors.

There are alternative options. "Making sure that no error will happen 
when there is a proceeding error by having two callbacks" is one of 
them. You wrote:
 > We want to consider
 >    - the saving of the device state (save or subsection save) and
 >    - running the cleanup after
 > as an atomic operation. And that is why, post_save is called
 > regardless of whether there is a preceeding error.
 > This means that, it is possible that we have 2 distict errors, one
 > from the preceeding function and the other from the post_save()
 > function.

But it may not be mandatory. In fact, I searched "post_save" in the code 
base and found all implementations are for cleanup and always succeeds, 
which makes sense; most (if not all) cleanup operations like g_free() 
always succeeds in general.

So perhaps "making sure that no error will happen when there is a 
proceeding error" may be feasible, and it may not even require two 
callbacks because post_save() always succeeds.

Regards,
Akihiko Odaki

