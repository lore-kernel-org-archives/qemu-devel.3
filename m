Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F78C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBna-0004ax-Ow; Mon, 29 Jun 2026 09:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weBnY-0004ZZ-Hu
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1weBnU-0003CF-Bb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:16 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65TDD50i078765
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Jun 2026 22:13:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=b0kGlyV3rUK5bAvtdPhdmMGBj2pWS94NAqeNMalkqDM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782738785; v=1;
 b=qbrq6cVBVXvWDZ51ucQt0ne4w42GnCZtsGNmTrCS82MPB572OY6TR/tiNLJOzpE1
 XUeljBxtu08HHf11l22lRKzqATw3Sarz7v9D1jFKW3D3IfqbTPg5jiqUfnzFpH/J
 PD94adZnI9lcXBDEgNJPihlmZD/OrKWPV9ddPCZNRd+j/NlQdELVeSjZLUKUwQbP
 HeT0vG/ftB4HApDGnCU57Ks9/RNJy1ck2hrHgUyUDKxW6VravCEBZ57i1+T05rXI
 +NfoVq8hGcRxuWuUt/SB5cQXZzOdOEE3kY4Tgxa5hbLq8Ami1416mVNVGtKwEXSo
 Pd1sOpd81rgwAqDA7lHpIA==
Message-ID: <470d9fc7-0a54-46b9-a1b9-4428b341b823@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 29 Jun 2026 22:13:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/gtk: Narrow DMA-BUF critical section
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvaxrGgD7EAwWdGG0BZgiyXPNrExExTVnANr6M2gw5+DzNQ@mail.gmail.com>
 <b57f9a79-f48d-4fab-a70f-e26f26fcfcbf@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CJoSn9qaA4JtNz1c3ZoAUJP1dPk58AOF-sQbf-t_YqKTA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1CJoSn9qaA4JtNz1c3ZoAUJP1dPk58AOF-sQbf-t_YqKTA@mail.gmail.com>
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

On 2026/06/29 21:46, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jun 29, 2026 at 4:24 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/06/29 18:20, Marc-André Lureau wrote:
>>> Hi Akihiko
>>>
>>> On Sun, Jun 28, 2026 at 5:59 PM Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> Scanout operations need to be properly ordered to avoid tearing. The
>>>> virtio specification allows the guest to use pageflip. With pageflip,
>>>> the guest only modifies the invisible framebuffer while the host scans
>>>> out the visible framebuffer. The guest may choose not to use pageflip to
>>>> avoid its overhead, accepting the risk of tearing.
>>>>
>>>> ui/gtk performs the following procedure to flush a scanout:
>>>> 1) Queue a draw event.
>>>> 2) The draw event gets triggered.
>>>> 3) Blit the guest framebuffer to the host framebuffer.
>>>>
>>>> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) if
>>>> possible and unblocks it after 3) to enforce proper ordering. However,
>>>> blocking the device before 2) has two problems.
>>>>
>>>> First, it can leave the device blocked indefinitely because GTK
>>>> sometimes decides to cancel 2) when the window is not visible for
>>>> example. ui/gtk regularly repeats 1) as a workaround, but it is not
>>>> applicable to GtkGLArea because it causes display corruption.
>>>>
>>>> Second, the behavior is inconsistent with the other types of scanout
>>>> that leave the device unblocked between 1) and 2).
>>>>
>>>> To fix these problems, let ui/gtk block the device only when the
>>>> queued draw event runs, immediately before 3). Blocking before that is
>>>> unnecessary since ui/gtk does not access the framebuffer yet. If the
>>>> guest does not use pageflip but instead updates the visible framebuffer
>>>> directly, ui/gtk should not add the overhead of a pre-draw block.
>>>>
>>>
>>> Are you saying this won't create undesired drawing artefacts?
>>>
>>> I don't see how the guest synchronizes with the display if the gl cmds
>>> keep running.
>>
>> The point of pageflip is to avoid drawing artifacts when scanout and
>> rendering can happen concurrently. The virtio-gpu spec adopts that
>> model: the guest can switch the scanout resource with
>> VIRTIO_GPU_CMD_SET_SCANOUT instead of rendering into the resource
>> currently being scanned out.
>>
>> So, if a guest chooses not to use pageflip on a system where scanout and
>> rendering run concurrently, it can get artifacts. This change does not
>> try to make that case artifact-free.
>>
>> What this patch is trying to preserve is the display model already used
>> by the 2D code and by the other display implementations: QEMU keeps the
>> framebuffer stable while it is actually reading/blitting it. The extra
>> blocking before the queued draw callback runs does not add
>> synchronization for that model, because ui/gtk is not accessing the
>> framebuffer yet.
> 
> I am missing some pieces to understand how the guest will be fenced.
> How does qemu say: "I have consumed the resource (for the
> flush/display), you can reuse it"?

By blocking VIRTIO_GPU_CMD_SET_SCANOUT: once that command completes, the 
previous scanout resource is no longer the visible one from the guest's 
point of view.

While GTK is actually blitting the current DMA-BUF, QEMU sets 
renderer_blocked. That stops the virtio-gpu command queue, so a guest's 
next SET_SCANOUT cannot be processed until the blit has finished and the 
UI unblocks the device.

So the ordering is:

1. QEMU starts consuming scanout A and blocks the renderer.
2. The guest may submit SET_SCANOUT for scanout B, but QEMU does not
    complete it yet.
3. QEMU finishes consuming A and unblocks the renderer.
4. SET_SCANOUT(B) can complete; at that point the guest may reuse A.

A guest that renders directly into the current scanout still can tear, 
but a pageflipping guest gets the reuse point from SET_SCANOUT completion.

Regards,
Akihiko Odaki

> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>> ui/gtk still blocks the device during 3) for DMA-BUF. Unlike the other
>>>> scanout types, 3) can happen asynchronously with the device for a
>>>> DMA-BUF, so ui/gtk needs to keep the visible guest framebuffer stable
>>>> for the blit.
>>>>
>>>> With the problems fixed, the workaround to repeat 1) is no longer
>>>> necessary and is removed.
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> ---
>>>> Changes in v2:
>>>> - Clarified that guests can use pageflip to avoid tearing while ui/gtk
>>>>     only needs to keep the DMA-BUF stable during the blit.
>>>> - Avoided the unprotected gd_egl_scanout_flush() fallback by queuing
>>>>     redraws through gtk_widget_queue_draw_area().
>>>> - Link to v1: https://lore.kernel.org/qemu-devel/20260115-gtk-v1-1-57f49e856408@rsg.ci.i.u-tokyo.ac.jp
>>>> ---
>>>>    ui/gtk-egl.c     |  6 ++----
>>>>    ui/gtk-gl-area.c | 23 +----------------------
>>>>    2 files changed, 3 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>>>> index 7c5c9b2428c2..adc81f34b1c8 100644
>>>> --- a/ui/gtk-egl.c
>>>> +++ b/ui/gtk-egl.c
>>>> @@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
>>>>                } else {
>>>>                    qemu_dmabuf_set_draw_submitted(dmabuf, false);
>>>>                }
>>>> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>>>>            }
>>>>    #endif
>>>>            gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
>>>> @@ -405,14 +406,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>>>>
>>>>        if (vc->gfx.guest_fb.dmabuf &&
>>>>            !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>>>> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>>>>            qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>>>>            gtk_egl_set_scanout_mode(vc, true);
>>>> -        gtk_widget_queue_draw_area(area, x, y, w, h);
>>>> -        return;
>>>>        }
>>>>
>>>> -    gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
>>>> +    gtk_widget_queue_draw_area(area, x, y, w, h);
>>>>    }
>>>>
>>>>    void gtk_egl_init(DisplayGLMode mode)
>>>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>>>> index 23806b9d01bb..29497019ee46 100644
>>>> --- a/ui/gtk-gl-area.c
>>>> +++ b/ui/gtk-gl-area.c
>>>> @@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>>>>                } else {
>>>>                    qemu_dmabuf_set_draw_submitted(dmabuf, false);
>>>>                }
>>>> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>>>>            }
>>>>    #endif
>>>>
>>>> @@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>>>>
>>>>        gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
>>>>
>>>> -    if (vc->gfx.guest_fb.dmabuf &&
>>>> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>>>> -        /*
>>>> -         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has already
>>>> -         * been submitted, but this function does not call gd_gl_area_draw() in
>>>> -         * such a case due to display corruption.
>>>> -         *
>>>> -         * Calling gd_gl_area_draw() is necessary to prevent a situation where
>>>> -         * there is a scheduled draw event but it won't happen bacause the window
>>>> -         * is currently in inactive state (minimized or tabified). If draw is not
>>>> -         * done for a long time, gl_block timeout and/or fence timeout (on the
>>>> -         * guest) will happen eventually.
>>>> -         *
>>>> -         * However, it is found that calling gd_gl_area_draw() here causes guest
>>>> -         * display corruption on a Wayland Compositor. The display corruption is
>>>> -         * more serious than the possible fence timeout so gd_gl_area_draw() is
>>>> -         * omitted for now.
>>>> -         */
>>>> -        return;
>>>> -    }
>>>> -
>>>>        if (!vc->gfx.gls) {
>>>>            if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
>>>>                return;
>>>> @@ -347,7 +327,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>>>>
>>>>        if (vc->gfx.guest_fb.dmabuf &&
>>>>            !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>>>> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
>>>>            qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
>>>>            gtk_gl_area_set_scanout_mode(vc, true);
>>>>        }
>>>>
>>>> ---
>>>> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
>>>> change-id: 20260115-gtk-424c2b910e65
>>>>
>>>> Best regards,
>>>> --
>>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>
>>>
>>
>>


