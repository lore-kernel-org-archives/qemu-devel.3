Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6A9F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDSk-0004fC-Ty; Fri, 10 Apr 2026 11:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wBDSi-0004ew-9p; Fri, 10 Apr 2026 11:08:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wBDSf-0003Hl-U2; Fri, 10 Apr 2026 11:08:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 57144596A2A;
 Fri, 10 Apr 2026 17:07:54 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id PPxvSXg4-Ulq; Fri, 10 Apr 2026 17:07:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3D83E596A22; Fri, 10 Apr 2026 17:07:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B457596A1E;
 Fri, 10 Apr 2026 17:07:52 +0200 (CEST)
Date: Fri, 10 Apr 2026 17:07:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Ani Sinha <anisinha@redhat.com>
cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com, 
 misanjum@linux.ibm.com, gautam@linux.ibm.com, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
In-Reply-To: <6816BC33-C3A0-4E89-8F85-C6ECE1108409@redhat.com>
Message-ID: <2302cd01-b2ed-f0f2-93aa-8fd6c4836a7f@eik.bme.hu>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
 <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
 <69167029-AE49-4BB3-9A5C-D16E51E5D40F@redhat.com>
 <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
 <c49859ce-7d98-04f7-69f8-d241e4148278@eik.bme.hu>
 <6816BC33-C3A0-4E89-8F85-C6ECE1108409@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1384376333-1775833672=:7256"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1384376333-1775833672=:7256
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 10 Apr 2026, Ani Sinha wrote:
>> On 10 Apr 2026, at 6:34 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Fri, 10 Apr 2026, Harsh Prateek Bora wrote:
>>>>>>> The lock imbalance:
>>>>>>> When kvm_arch_process_async_events() returns true, the function returns EXCP_HLT before the bql_unlock() call.
>>>>>> Why should it unlock it before returning? In fact it’s opposite. If the function had unlocked bql, it should lock it again before returning.
>>>>>>> This means the early return path keeps the BQL held,
>>>>>> This would be the correct thing to do.
>>>>>>> while the normal execution path releases and re-acquires it.
>>>>>> Because the functions it calls after unlocking requires bql to be unlocked. Since it had to unlock it, it locks it again before returning.
>>>>> It had to unlock it for the same reason - to give others a chance to lock. We need to handle failure/exception cases for the same purpose as well.
>>>> But by unlocking and returning you are breaking the semantics of the function and introducing imbalance.
>>>
>>> I think it is better to unlock bql early in failure cases.
>>> Even Otherwise, it would become a bql_unlock followed by a bql_lock in the caller for EXCP_HLT, which might look a bit odd as well.
>>
>> So why not do
>>
>> bql_unlock()
>> /* comment explaining why this is needed */
>> bql_lock()
>> return EXCP_HLT;
>
> If we go down this path, what would be wrong with
>
> bql_unlock()
> sleep(100);
> bql_lock();
>
> This would make the window even larger for the other thread to make progress … How about sleeping for 1 min? 10 min?

If the reason to unlock is to give a chance to other waiting threads to 
acquire the lock then no need to sleep long as we'll wait in bql_lock if 
another thread got the lock so less than a second sleep or maybe just a 
few milliseconds should be plenty of time for other threads to get a 
chance to run and avoid a deadlock.

I understand that you say that maybe there could be a better fix elsewhere 
but we don't seem to fully understand the issue and trying a bigger 
rewrite now is more likely to break something than this hack that should 
give suffucient work around for the relase at least.

But I'm not involved in this just tried to at least resolve the deadlock 
between you if I can't resolve the deadlock in BQL. :-)

Regards,
BALATON Zoltan
--3866299591-1384376333-1775833672=:7256--

