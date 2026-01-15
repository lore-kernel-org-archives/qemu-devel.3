Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71997D41144
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJBl-0002mk-Fm; Thu, 15 Jan 2026 03:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgJBb-0002kl-R7
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:58:36 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgJBZ-0000T8-3t
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 03:58:35 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F8w4UY098871
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 17:58:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V9D6uD06tA+y0PeKJN7YfRkc31Jv0PTu72czwkhwAOU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768467504; v=1;
 b=Y1bxxRH+9ES6hQI457T+wA0nlTBv59pGUGhNvzXnoP5v2Fj056jk+CDsQlUs3m70
 BlKdmjdXT2b39iXOtaB7wLiEQbo8VePxYkqcGq8CbywPwlyHxSD6GlKRagoOfGrA
 XOZafZLtWmJDXESW8WXmJdwbmdEztwci3x4AhMEidxW+e9Z2PebQtxf+Znwgwx4G
 jUewErS/yhEKvY4PuLny3/QaQPoFKWIBP7o6sZ3KgCsrijY1Y/rgMhUQP/iA2CpU
 Xaj4lZXmng50pDUytcmtGgYSo7WVzjZ4A4wrzdqYXNzGRqUrLrfxfZXGx2q79lZp
 41k7E5TsJE6o7B47YbR7gw==
Message-ID: <93ffc0c7-e3bc-448e-b7c2-33af77e8f95d@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 17:58:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Narrow DMA-BUF critical section
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CJDdjL5fKKzsDUGN8y20aX5dkb7Xere_cXJ5WZw-V0HOg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1CJDdjL5fKKzsDUGN8y20aX5dkb7Xere_cXJ5WZw-V0HOg@mail.gmail.com>
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

On 2026/01/15 17:25, Marc-André Lureau wrote:
> Hi Akihiko
> 
> On Thu, Jan 15, 2026 at 9:44 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> ui/gtk performs the following procedure to flush a scanout:
>> 1) Queue a draw event.
>> 2) The draw event gets triggered.
>> 3) Blit the scanout to the framebuffer.
>>
>> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
>> possible and unblocks it after 3).
>>
>> Blocking the device before 2) has two problems.
>>
>> First, it can leave the device blocked indefinitely because GTK
>> sometimes decides to cancel 2) when the window is not visible for
>> example. ui/gtk regularly repeats 1) as a workaround, but it is not
>> applicable to GtkGLArea because it causes display corruption.
>>
>> Second, the behavior is inconsistent with the other types of scanout
>> that leaves the device unblocked between 1) and 2).
>>
>> To fix these problems, let ui/gtk block the device after 2) instead.
> 
> Wouldn't that let the device overwrite the buffer before it is displayed?

That's correct.

The rationale I wrote in the commit message is that it is a 
long-standing behavior for the other scanout types.

You can also "infer" this from the fact that the specification mentions 
pageflip, though it is a convoluted way:

 > It is possible to create multiple framebuffers, flip between them
 > using VIRTIO_GPU_CMD_SET_SCANOUT and VIRTIO_GPU_CMD_RESOURCE_FLUSH,
 > and update the invisible framebuffer using
 > VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D.

https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-375001r381

If scanout flush is truly atomic, there is no point of performing 
pageflip and you can instead simply always use 
VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D for the visible framebuffer.

So, from the guest perspective, there are two options to implement scanout:

- Do pageflip to avoid tearing at cost of having two framebuffers and
   late display.
- Do not pageflip to avoid having two buffers and display the content
   as soon as possible though it may cause tearing.

> 
> I wish there would be a clear design for how virtio-gpu handles
> display buffering.. I suppose more demanding users, like crosvm may
> have documented this.

Allowing tearing to occur when not doing pageflip is a common sensible 
design (e.g., EGL: eglSwapInterval() with 0 as the interval parameter, 
Vulkan: VK_PRESENT_MODE_IMMEDIATE_KHR), though I see other things 
lacking in the design (e.g., vsync).

crosvm performs no synchronization and prone to tearing if I read it 
correctly. A code comment says:
 > It is possible that we are committing frames faster than the
 > compositor can put them on the screen. This may result in dropped
 > frames, but this is acceptable considering there is no good way to
 > apply back pressure to the guest gpu driver right now. The intention
 > of this module is to help bootstrap gpu support, so it does not have
 > to have artifact free rendering.

https://chromium.googlesource.com/crosvm/crosvm/+/51cf0f429d64bd24281d9c9920c6712c491b5473/gpu_display/src/display_wl.c#1238

I suppose they care the Wayland passthrough more than the plain scanout 
mechanism. It will be nice if the specification clearly documents the 
expected behavior. The current documentation is more like saying "use 
the common sense and see QEMU if not sure"; it doesn't help much when 
writing QEMU.

Regards,
Akihiko Odaki

