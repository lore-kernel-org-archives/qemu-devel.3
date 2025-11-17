Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAB8CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL86I-0004J0-Km; Mon, 17 Nov 2025 17:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vL86F-0004Ie-Vv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:53:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vL86D-0005hE-3I
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:53:31 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AHMrGm2014938
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Nov 2025 07:53:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xTd+F72y/EJGy+yOoAdShSygA7ECXF/Mec+8GssCCkI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763419997; v=1;
 b=OMB0YTgw24GscRF2Erm6XSGnjlSO6va/13b/s63CYsxXy0QwDWdwvzC3OxO6SmoH
 VTUQEy8HhGuGji5p4rNYRJDXezfGUwZVzltLYDmRJKQEMQ1uNAShcyjbNgFiK+TU
 54nX77WkLGgFv3Vu8oynPbVKEQSWf0VPN3MJ7yLJszjBTPP2FXWvcSELxR/BNx4c
 sVmajG0A3aQ3uDtMnPKyBqka0RkxmFtgqwHiYzkSKCPWPQus+5z1XmaUN7Bgb3/z
 LLBVuxMgj5ZQYOtamUPGGGG19I5Dk2y7JkOKfsGuWf7VKgUrxVVQSOJVhOB1AaVg
 PLdAwHceQyORbLzJHEMmcw==
Message-ID: <692cdc87-a384-42ed-bd97-843a936a5bcb@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Nov 2025 07:53:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
 <aRYPXh_9m5ZvTi2w@x1.local>
 <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
 <aRdLFwxzJwjsXFpY@x1.local>
 <a8c03d1e-a3f4-40de-a633-7b15ec2288e3@rsg.ci.i.u-tokyo.ac.jp>
 <3c3ad5f1-37ac-4c4b-93c4-ca67b5a1edef@rsg.ci.i.u-tokyo.ac.jp>
 <aRtQbzMifFW3BejM@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aRtQbzMifFW3BejM@x1.local>
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

On 2025/11/18 1:42, Peter Xu wrote:
> On Sat, Nov 15, 2025 at 11:59:01AM +0900, Akihiko Odaki wrote:
>> This is wrong. The following can still happen:
>>
>> call_rcu_thread()                |
>>   qatomic_sub(&rcu_call_count, n) |
>>   (sets rcu_call_count to 0)      |
>>                                   | call_rcu1()
>>                                   |  qatomic_fetch_inc(&rcu_call_count)
>>   qatomic_read(&rcu_call_count)   |
>>   qemu_event_reset(&sync_event)   |
>>                                   |  qemu_event_set(&sync_event)
>>   enter_qs(false)                 |
>>    wait_for_readers(false)        |
>>     qemu_sem_timedwait(           |
>>      &sync_event, 10)             |
>>
>> I'll fix it with the next version.
> 
> Please take this as an example of why I think these orderings are very hard
> to make 100% accurate.  Consider when someone else who is less familiar
> with the rcu code and may mess up with some of the orderings without being
> noticed.
> 
> That's also why I personally liked a sem because the important thing here
> is not missing an event, which sem always guarantees as it doesn't have
> resetting at all.  Then we can be open to false positives on events as long
> as keeping it as minimum as possible.

It doesn't matter if it is a semaphore or event in this case. You can 
simply drop qemu_event_reset(&sync_event) here and the situation will be 
same for both event and semaphore.

Regards,
Akihiko Odaki

