Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607B2C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 06:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSrGo-0002ql-5h; Sat, 21 Jun 2025 02:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSrGl-0002pt-HF; Sat, 21 Jun 2025 02:00:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSrGh-0002Qu-3X; Sat, 21 Jun 2025 02:00:02 -0400
Received: from [192.168.201.189]
 (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L5xh1o008238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Jun 2025 14:59:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=A2K7dukmy58VPS1HXZpQskpJaho+5/KzxKe+927BTMA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1750485584; v=1;
 b=U8eG6PjwzMMRlbbG4bfoCu4RWkjeR1o3d/RrWnVlcFcLE3nMKWoK1HJaeffRTdtq
 gs5fRxW5r6uEiT7jgqGhR3Q2AkIiH/CBxIv0AxGpSMhiBFh1YHSVQhrQSwdK47/F
 3dr9j0Fvwewhnz6mk+iMbhyGQ6E7upC33MQ58WAzKl3imwV6Jou5ltlwDijEKnOZ
 aAvTMITZ59qDamfuapvrUjvFLnxxOjRFN5gqF3f1njvR2cFv0JzJbomVQCSvAP+T
 16+l9AtxVnvuweaCFBHJQzF1cWrz1B90Hboj/TX5KVCo62GEmKaXfq1Iq5a8yf7E
 /BjFWyw3JgN8A62SRSyd/A==
Message-ID: <155e2866-cb7c-4f15-a527-d19688401ef1@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 14:59:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/17] virtio-gpu: support context init multiple timeline
To: Yiwei Zhang <zzyiwei@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-13-alex.bennee@linaro.org>
 <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+hS_jUtitaeqYYxHN6q9ijqBu=Zyviid+EJc2sJ1yQLRxSDQ@mail.gmail.com>
 <877c16ud1r.fsf@draig.linaro.org>
 <CAJ+hS_insLDZRmQhVWfbLxqzdA4oWXYGHHOkFVJTdz3TucYqjg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+hS_insLDZRmQhVWfbLxqzdA4oWXYGHHOkFVJTdz3TucYqjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/06/21 4:47, Yiwei Zhang wrote:
> On Thu, Jun 19, 2025 at 11:45 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Yiwei Zhang <zzyiwei@gmail.com> writes:
>>
>>> On Sun, Jun 8, 2025 at 1:24 AM Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> On 2025/06/06 1:26, Alex Bennée wrote:
>>>>> From: Yiwei Zhang <zzyiwei@gmail.com>
>>>>>
>>>>> Venus and later native contexts have their own fence context along with
>>>>> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
>>>>> the flags must be dispatched to be created on the target context. Fence
>>>>> signaling also has to be handled on the specific timeline within that
>>>>> target context.
>>>>>
>>>>> Before this change, venus fencing is completely broken if the host
>>>>> driver doesn't support implicit fencing with external memory objects.
>>>>> Frames can go backwards along with random artifacts on screen if the
>>>>> host driver doesn't attach an implicit fence to the render target. The
>>>>> symptom could be hidden by certain guest wsi backend that waits on a
>>>>> venus native VkFence object for the actual payload with limited present
>>>>> modes or under special configs. e.g. x11 mailbox or xwayland.
>>>>>
>>>>> After this change, everything related to venus fencing starts making
>>>>> sense. Confirmed this via guest and host side perfetto tracing.
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
>>>>
>>>> I suggest moving this in the front of the patch series to ease backporting.
>>>>
>>>> I also wonder if "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call in
>>>> refresh" requires Cc: qemu-stable@nongnu.org. Fixing -display gtk,gl=on
>>>> for Wayland sounds as important as this patch.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>
>>> Hi Alex,
>>>
>>> +1 for Akihiko's point. I'm also curious when will the venus fix land
>>> in-tree?
>>
>> We have a problem that there are two contradictory bugs - one that shows
>> up in the x86/kvm case and one in the aarch64/tcg case. Both are caused
>> by the weird lifetime semantics of the virgl resource vs QEMU memory
>> region and we haven't found a solution that solves both yet.
> 
> Sounds like irrelevant to the venus fix. Might be worth filing a
> virglrenderer issue with some details. More eyes would be helpful if
> this turns out to be some known kvm issue seen before on other vmms.

This patch itself looks good to me so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It's up to Alex whether to wait until other patches (the blob 
mapping/memory region fix in particular) piles up or not.

Regards,
Akihiko Odaki

