Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A91C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDBu-0007IN-Tz; Mon, 29 Jun 2026 10:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1weDBl-0007Hj-Jn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1weDBj-0003qb-93
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782744137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5ora3C/45hhcBXGB5Cq7sLKi8YXmHjGP//Lj47Qoto=;
 b=IJ2BPL0bInXh+EgnP1Ex6wKyxpCWQ2W72kLAH1Ih69/MrlBp+Sw+lhZyvvzRTAkyAYmEze
 52RBJcse9RpJ4GhEU7LCSUDWR3j4/8dSfGu0QQMr3O3z/j9UnxLQqfC0VWKFkhMjAaY/H4
 Pn1Z9GycZiqpBNWN1gWqWo97LOjBBHI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-KvqH5WDOMX-DCQERVdiwzQ-1; Mon, 29 Jun 2026 10:42:15 -0400
X-MC-Unique: KvqH5WDOMX-DCQERVdiwzQ-1
X-Mimecast-MFC-AGG-ID: KvqH5WDOMX-DCQERVdiwzQ_1782744135
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c98775daee6so980752a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782744135; cv=none;
 d=google.com; s=arc-20260327;
 b=fOv4Cmldr3dsJUJGmOEu+1NtOL+dMwPTHf0ydYMBZ4D5tX/0epZsV2XnK3g6uZrkx2
 W3EJvv9nOdQCwZCsZKNwYH0C1xMMWSUfvnuJPpAU2NbS7+/xR0RE/+Z2pkeB6NcDkAWx
 D6AFiVGHAgo6REHp1cY0GpllfR5RB48gdFODmHK+ETJ4SJNXlRrf0eOPHvIccqsGUjOm
 WbtdtyWp2ycu2LidYkT01h+JaahzLyvUdRPMDsp0M/wlfD+El/wAsc3n0zGIF83Da7RX
 UW6TfYmz3QgczlbL/tjRMPsMb4giKV/jjUD1ONdr3+axOP/5S+wtf6SCK2F8T6ykrIUw
 1H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k5ora3C/45hhcBXGB5Cq7sLKi8YXmHjGP//Lj47Qoto=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=pa+HgDX+9My0BpBOw3Ee55BG8ZUetpiXLZG0rr8OaEo/fv/NRulB54nQL9vbi0GP6/
 NSKVX1v6iMlPET2StfEjMOCKqqOoW3s6El+dMnnyO2/pJ+wLKbJKCNG9+TedElgZXBj6
 r9pVUu7XPdGjuZE+omxEmX3N2v0VHRhs6gGjg32kLnIMdwZJWWL7mWZbP//LJCrTpqA8
 HUU3/2K+RwAmWiPKGSx/R4tqzFLHmYwYkdagpMxVtMrvOCGv5I4Mk1AZr/1zyHK/n4uP
 iyoEK4Oj+EfJgehGOSWgsNZyojLzA9sHOKhiP9rnzFlsFwsQmAiAOWtjCY8i3Vxi4XOv
 ypDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782744135; x=1783348935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5ora3C/45hhcBXGB5Cq7sLKi8YXmHjGP//Lj47Qoto=;
 b=PbVQ3psm+0E/NcSFihPCtJwghxsDNQC8DXXahAgWDMrTz3S1fsqAAeQ/riJxOiBfUg
 vaGtribtsrAhDzt9f1Mj5NJbhUaDV+SZp9PJoRjk/rIecdDsMhWayHaTRqhpXxOSpGiQ
 KzQV9VlQk00WywHwbDCHW7b9HC0d8DuDR/DiMwaW1WJgRbvmyCIqKybrjPZIlCJEj8aK
 jEiTJyHx6Ct0DNaI7b02dB+Dqru/diRAZSXP+2InIx12pl9Oq5Ke3hVY+FP65FIoWPjZ
 wAJEIgRtHFAmv00XDzlJ3qKc68chpEr3lMVjfv0Zv8cspW1xJIMaWgg4kEyrwxFbG8mD
 8zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744135; x=1783348935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5ora3C/45hhcBXGB5Cq7sLKi8YXmHjGP//Lj47Qoto=;
 b=o0vx9a+Xy+3sJsaPld8nw4gbPEL3jc+WcV9y6Ja6k6LaJnU5WCSLai39PuGYHsJLRW
 OnsIZY7iTb6fAkU9GneL7eS1l85LmwPiODseueI8XbqXj2HpkwD5ASLAPFNLtqAZsMk1
 WELmHk8zGUw79YixkBU55Ytvtljp+ad4oTN9OmsoLVMd7PuDaUf5uCgdbzN/ecLasGov
 ZFQKqRUi1dYWrXnmJ1aaaP4eevv833LbV5Q6qMqb+/kCXw7jFvY+lI2veikPNuIGIBI+
 /kAbTfEhr/5ZwdKZXHpKJQXfzI06lV8XyNmTaqK0cpnKbkBMT5y3bvcARkloUcJCdkrK
 w3mw==
X-Gm-Message-State: AOJu0YwSAH0AynCs/+nS2g2Fcb+ilpt1ewL7kDSH3ZAG/OpWNLcpNh/4
 QQJ4NZ9JVJfnAT6FcMzOyDhJ6QReLamXDJ/BRnjKwYZJ85WEW28YEfj1SPslBmOn8sMa8HEeVnE
 CBOxSfapr+3BAyOX4fI0NjFZ3SZRkUvfoVYGAkCH6ErArmL3rSsldwXP7Y/POfyKH/aD/rdlEmM
 hTdbxDT2tmJIuCIGkZ6X4KC/xHnS9FmnPVV1jVqvAuYusLavM=
X-Gm-Gg: AfdE7cnQSih5Yd14hlG/ZM44Auk5YhM2MCVsH2t3I7GmRLjpMbCRrVdY4qAQRCwWoxj
 U9Z9VysGO1QsGX2KQvZGY4KUIZyVDPOPsWHuJbk0Py+R1AKkr6yleAznC744cP6sotF/0gJk9Ry
 FBCe/LCeqvyYy+yc3SFcU+MdzL2oHtzBxWoaR5T8kVb7pytB8ssS9dDUczC+oK6ktvq1iJRg0rU
 V1NcrkitKPqvdX9IQl3WNB1yCTV6kqIRqmtvbjFk+3NLjF5rkB9mRaR
X-Received: by 2002:a05:6a21:4d8b:b0:3b5:4fff:fa0f with SMTP id
 adf61e73a8af0-3bfc02ca92fmr662145637.14.1782744134314; 
 Mon, 29 Jun 2026 07:42:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8b:b0:3b5:4fff:fa0f with SMTP id
 adf61e73a8af0-3bfc02ca92fmr662121637.14.1782744133635; Mon, 29 Jun 2026
 07:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260628-gtk-v2-1-1e4839012f09@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvaxrGgD7EAwWdGG0BZgiyXPNrExExTVnANr6M2gw5+DzNQ@mail.gmail.com>
 <b57f9a79-f48d-4fab-a70f-e26f26fcfcbf@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CJoSn9qaA4JtNz1c3ZoAUJP1dPk58AOF-sQbf-t_YqKTA@mail.gmail.com>
 <470d9fc7-0a54-46b9-a1b9-4428b341b823@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <470d9fc7-0a54-46b9-a1b9-4428b341b823@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jun 2026 18:42:01 +0400
X-Gm-Features: AVVi8CefjrMjNRVyU--fg0-c9xmVYb-_U1r_1IxGXDyBTsCMv_sMQAj_aK2tFaE
Message-ID: <CAMxuvaxoRddRPGZzh+VGdLiiJ3au4P2pBNHPphk5XsR8uYPOjA@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Narrow DMA-BUF critical section
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Jun 29, 2026 at 5:13=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/06/29 21:46, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Jun 29, 2026 at 4:24=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2026/06/29 18:20, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi Akihiko
> >>>
> >>> On Sun, Jun 28, 2026 at 5:59=E2=80=AFPM Akihiko Odaki
> >>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>>>
> >>>> Scanout operations need to be properly ordered to avoid tearing. The
> >>>> virtio specification allows the guest to use pageflip. With pageflip=
,
> >>>> the guest only modifies the invisible framebuffer while the host sca=
ns
> >>>> out the visible framebuffer. The guest may choose not to use pagefli=
p to
> >>>> avoid its overhead, accepting the risk of tearing.
> >>>>
> >>>> ui/gtk performs the following procedure to flush a scanout:
> >>>> 1) Queue a draw event.
> >>>> 2) The draw event gets triggered.
> >>>> 3) Blit the guest framebuffer to the host framebuffer.
> >>>>
> >>>> When flushing a DMA-BUF scanout, ui/gtk blocks the device before 2) =
if
> >>>> possible and unblocks it after 3) to enforce proper ordering. Howeve=
r,
> >>>> blocking the device before 2) has two problems.
> >>>>
> >>>> First, it can leave the device blocked indefinitely because GTK
> >>>> sometimes decides to cancel 2) when the window is not visible for
> >>>> example. ui/gtk regularly repeats 1) as a workaround, but it is not
> >>>> applicable to GtkGLArea because it causes display corruption.
> >>>>
> >>>> Second, the behavior is inconsistent with the other types of scanout
> >>>> that leave the device unblocked between 1) and 2).
> >>>>
> >>>> To fix these problems, let ui/gtk block the device only when the
> >>>> queued draw event runs, immediately before 3). Blocking before that =
is
> >>>> unnecessary since ui/gtk does not access the framebuffer yet. If the
> >>>> guest does not use pageflip but instead updates the visible framebuf=
fer
> >>>> directly, ui/gtk should not add the overhead of a pre-draw block.
> >>>>
> >>>
> >>> Are you saying this won't create undesired drawing artefacts?
> >>>
> >>> I don't see how the guest synchronizes with the display if the gl cmd=
s
> >>> keep running.
> >>
> >> The point of pageflip is to avoid drawing artifacts when scanout and
> >> rendering can happen concurrently. The virtio-gpu spec adopts that
> >> model: the guest can switch the scanout resource with
> >> VIRTIO_GPU_CMD_SET_SCANOUT instead of rendering into the resource
> >> currently being scanned out.
> >>
> >> So, if a guest chooses not to use pageflip on a system where scanout a=
nd
> >> rendering run concurrently, it can get artifacts. This change does not
> >> try to make that case artifact-free.
> >>
> >> What this patch is trying to preserve is the display model already use=
d
> >> by the 2D code and by the other display implementations: QEMU keeps th=
e
> >> framebuffer stable while it is actually reading/blitting it. The extra
> >> blocking before the queued draw callback runs does not add
> >> synchronization for that model, because ui/gtk is not accessing the
> >> framebuffer yet.
> >
> > I am missing some pieces to understand how the guest will be fenced.
> > How does qemu say: "I have consumed the resource (for the
> > flush/display), you can reuse it"?
>
> By blocking VIRTIO_GPU_CMD_SET_SCANOUT: once that command completes, the
> previous scanout resource is no longer the visible one from the guest's
> point of view.
>
> While GTK is actually blitting the current DMA-BUF, QEMU sets
> renderer_blocked. That stops the virtio-gpu command queue, so a guest's
> next SET_SCANOUT cannot be processed until the blit has finished and the
> UI unblocks the device.
>
> So the ordering is:
>
> 1. QEMU starts consuming scanout A and blocks the renderer.

I see, gtk blocks the rendering before the draw and this should be
enough to have a correct present scanout drawing.

lgtm then, thanks for the details
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> 2. The guest may submit SET_SCANOUT for scanout B, but QEMU does not
>     complete it yet.
> 3. QEMU finishes consuming A and unblocks the renderer.
> 4. SET_SCANOUT(B) can complete; at that point the guest may reuse A.
>
> A guest that renders directly into the current scanout still can tear,
> but a pageflipping guest gets the reuse point from SET_SCANOUT completion=
.
>
> Regards,
> Akihiko Odaki
>
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>>> ui/gtk still blocks the device during 3) for DMA-BUF. Unlike the oth=
er
> >>>> scanout types, 3) can happen asynchronously with the device for a
> >>>> DMA-BUF, so ui/gtk needs to keep the visible guest framebuffer stabl=
e
> >>>> for the blit.
> >>>>
> >>>> With the problems fixed, the workaround to repeat 1) is no longer
> >>>> necessary and is removed.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Clarified that guests can use pageflip to avoid tearing while ui/g=
tk
> >>>>     only needs to keep the DMA-BUF stable during the blit.
> >>>> - Avoided the unprotected gd_egl_scanout_flush() fallback by queuing
> >>>>     redraws through gtk_widget_queue_draw_area().
> >>>> - Link to v1: https://lore.kernel.org/qemu-devel/20260115-gtk-v1-1-5=
7f49e856408@rsg.ci.i.u-tokyo.ac.jp
> >>>> ---
> >>>>    ui/gtk-egl.c     |  6 ++----
> >>>>    ui/gtk-gl-area.c | 23 +----------------------
> >>>>    2 files changed, 3 insertions(+), 26 deletions(-)
> >>>>
> >>>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> >>>> index 7c5c9b2428c2..adc81f34b1c8 100644
> >>>> --- a/ui/gtk-egl.c
> >>>> +++ b/ui/gtk-egl.c
> >>>> @@ -91,6 +91,7 @@ void gd_egl_draw(VirtualConsole *vc)
> >>>>                } else {
> >>>>                    qemu_dmabuf_set_draw_submitted(dmabuf, false);
> >>>>                }
> >>>> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>>>            }
> >>>>    #endif
> >>>>            gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->g=
fx.h);
> >>>> @@ -405,14 +406,11 @@ void gd_egl_flush(DisplayChangeListener *dcl,
> >>>>
> >>>>        if (vc->gfx.guest_fb.dmabuf &&
> >>>>            !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf))=
 {
> >>>> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>>>            qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, t=
rue);
> >>>>            gtk_egl_set_scanout_mode(vc, true);
> >>>> -        gtk_widget_queue_draw_area(area, x, y, w, h);
> >>>> -        return;
> >>>>        }
> >>>>
> >>>> -    gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
> >>>> +    gtk_widget_queue_draw_area(area, x, y, w, h);
> >>>>    }
> >>>>
> >>>>    void gtk_egl_init(DisplayGLMode mode)
> >>>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> >>>> index 23806b9d01bb..29497019ee46 100644
> >>>> --- a/ui/gtk-gl-area.c
> >>>> +++ b/ui/gtk-gl-area.c
> >>>> @@ -86,6 +86,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >>>>                } else {
> >>>>                    qemu_dmabuf_set_draw_submitted(dmabuf, false);
> >>>>                }
> >>>> +            qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>>>            }
> >>>>    #endif
> >>>>
> >>>> @@ -163,27 +164,6 @@ void gd_gl_area_refresh(DisplayChangeListener *=
dcl)
> >>>>
> >>>>        gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : =
vc->gfx.drawing_area);
> >>>>
> >>>> -    if (vc->gfx.guest_fb.dmabuf &&
> >>>> -        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> >>>> -        /*
> >>>> -         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw h=
as already
> >>>> -         * been submitted, but this function does not call gd_gl_ar=
ea_draw() in
> >>>> -         * such a case due to display corruption.
> >>>> -         *
> >>>> -         * Calling gd_gl_area_draw() is necessary to prevent a situ=
ation where
> >>>> -         * there is a scheduled draw event but it won't happen baca=
use the window
> >>>> -         * is currently in inactive state (minimized or tabified). =
If draw is not
> >>>> -         * done for a long time, gl_block timeout and/or fence time=
out (on the
> >>>> -         * guest) will happen eventually.
> >>>> -         *
> >>>> -         * However, it is found that calling gd_gl_area_draw() here=
 causes guest
> >>>> -         * display corruption on a Wayland Compositor. The display =
corruption is
> >>>> -         * more serious than the possible fence timeout so gd_gl_ar=
ea_draw() is
> >>>> -         * omitted for now.
> >>>> -         */
> >>>> -        return;
> >>>> -    }
> >>>> -
> >>>>        if (!vc->gfx.gls) {
> >>>>            if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
> >>>>                return;
> >>>> @@ -347,7 +327,6 @@ void gd_gl_area_scanout_flush(DisplayChangeListe=
ner *dcl,
> >>>>
> >>>>        if (vc->gfx.guest_fb.dmabuf &&
> >>>>            !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf))=
 {
> >>>> -        qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
> >>>>            qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, t=
rue);
> >>>>            gtk_gl_area_set_scanout_mode(vc, true);
> >>>>        }
> >>>>
> >>>> ---
> >>>> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> >>>> change-id: 20260115-gtk-424c2b910e65
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>
> >>>
> >>
> >>
>


