Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE0DC54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI1rD-0003Xy-D3; Thu, 22 May 2025 05:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uI1rA-0003XX-ON
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uI1r3-00010O-AZ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747904681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UQF9iAcSeIofk5PhEWnltNZobL88RbKqDt0sMN5zqc=;
 b=UCdToRpSsctE6/L1W3ttFgCfzk4k3EXkS358fVuuW117+09xxT1OQL56x/HRsQOtcZ061i
 FLInLT8xnjXk9w/ZDJtvWpcHHweeVl417eaO3WUch1kvXJ+HSjOqyJkTy/oVuWnTy3HU/9
 CZbQOLuWHImAWZzHuMqdQYDtKF/nhOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-om6-ztjcOuGO-AYZGJB6Eg-1; Thu, 22 May 2025 05:04:39 -0400
X-MC-Unique: om6-ztjcOuGO-AYZGJB6Eg-1
X-Mimecast-MFC-AGG-ID: om6-ztjcOuGO-AYZGJB6Eg_1747904678
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a375938404so2692731f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747904678; x=1748509478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UQF9iAcSeIofk5PhEWnltNZobL88RbKqDt0sMN5zqc=;
 b=s90xhue8Pfx7UHxqH4dgSIlaP+HUlpZDUnm9zVCHiT1Ll8h+RPCQrjv1cYHm9DUc+z
 vB2NEMgqInP/xDFTahDgKyXWsA2x3vu282LU6xDv7FUzqWik+pIC1sD9DT6AdW7zqIjv
 tofpR3EWQNOmXR/gFTKQ+xb86T0D4+t+t6sp4dO7gXpn8hLB2FiyUrnDC9lPexx08hfQ
 4BsNVroxtaBYZ7o5vSUKjF10BZMQ7HXGsoOlONc8KLmvM4UNuibUUcSb6ikenuOtdZ4Y
 WMhY5aXsE2Rbpvv/V5PzplecVtPZSsbwrBc9zEvo52vr6S1aMtxq74T/5loKRwFacTv8
 jx3g==
X-Gm-Message-State: AOJu0YxGnj+s5zZ43po74MiXO2SPQ7OXFaE2aAPKu86NVFKI6gCbakk/
 eW2Sr1sCNoSx6NMEDpVHNVXqYftgX/JqEQnDEfwtuMdyXrqWzEcC4djJ68HCC1J5IfFObWpLZcy
 /8HmEt9cbGMxc4Wv/Xz+mALk1fk0o1788YsUzSyVbwiNxPThGZPg6vLYo
X-Gm-Gg: ASbGncsWW/siG4xi1oAAF4MSgeYsQpn/YMp99B/nNaLF3PLxHVfYKJR5lKKuDzlputo
 MEs83FbT+0a+zWNhEVrcJm7XRbpGMzpLi+fFyqut7HFrRfE/mWRYMPX3rCFyodBCU8qrqtMMKTF
 fftMWWXjJiMAfPxjRnMUabri9EpfWY0f7nAVFTq79FgLbqjzDyrGMSSIfuZGWHpRLI5AgWZCDFb
 OuBZ6uTvWic9bWyjvtgBzjRREMd07RDMZYQa1oX9/WOPZETOfksdTJZIqu87LLlUfeURIvTxxSk
X-Received: by 2002:adf:faca:0:b0:3a3:620a:696a with SMTP id
 ffacd0b85a97d-3a3620a6a26mr19333986f8f.39.1747904677970; 
 Thu, 22 May 2025 02:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+hshikhtsYy7dpMhGXzRSiqKFMUKCgAlJJTq6VzaytmJXPIYxH6DQtxbsCNRxPmtdSuf99Q==
X-Received: by 2002:adf:faca:0:b0:3a3:620a:696a with SMTP id
 ffacd0b85a97d-3a3620a6a26mr19333951f8f.39.1747904677540; 
 Thu, 22 May 2025 02:04:37 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca888fcsm23483394f8f.78.2025.05.22.02.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 02:04:37 -0700 (PDT)
Date: Thu, 22 May 2025 11:04:35 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Message-ID: <ixiqrbp5ktv5awwdhnjrmbnsq4m5faf6mxpyr7qhhpchakbsrd@z3lzegdczbrg>
References: <20250521151616.3951178-1-jmarcin@redhat.com>
 <aC35pvtRC3OcQruO@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC35pvtRC3OcQruO@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Peter

On 2025-05-21 12:04, Peter Xu wrote:
> On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > If a virtual machine is paused for an extended period time, for example,
> > due to an incoming migration, there are also no changes on the screen.
> > VNC in such case increases the display update interval by
> > VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> > to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> > 
> > When the machine resumes, it can then take up to 3 seconds for the first
> > display update. Furthermore, the update interval is then halved with
> > each display update with changes on the screen. If there are moving
> > elements on the screen, such as a video, this can be perceived as
> > freezing and stuttering for few seconds before the movement is smooth
> > again.
> > 
> > This patch resolves this issue, by adding a listener to VM state changes
> > and changing the update interval when the VM state changes to RUNNING.
> > The update_displaychangelistener() function updates the internal timer,
> > and the display is refreshed immediately if the timer is expired.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> 
> Thanks for looking into it!
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One trivial comment (and partly, pure question) below,
> 
> > ---
> >  ui/vnc.c | 12 ++++++++++++
> >  ui/vnc.h |  2 ++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 9e097dc4b4..32f8bfd1f9 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3384,6 +3384,16 @@ static const DisplayChangeListenerOps dcl_ops = {
> >      .dpy_cursor_define    = vnc_dpy_cursor_define,
> >  };
> >  
> > +static void vmstate_change_handler(void *opaque, bool running, RunState state)
> > +{
> > +    VncDisplay *vd = opaque;
> > +
> > +    if (state != RUN_STATE_RUNNING) {
> 
> Just to mention in vm_prepare_start() it's possible we migrate a VM that
> used to be suspended, if so it'll keep suspended after migration:
> 
>     RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
> 
> Here I'm not sure whether SUSPENDED would also like to update the display
> freq.  I don't think it matters hugely, but just to say, if we want we can
> simply check "running=true" instead of checking the state to cover both
> RUNNING|SUSPENDED cases.

Thank you for the comment. I don't think it is necessary to update the
screen frequency if the machine is suspended. In case there is an
explicit request for that, we can change it then. The display frequency
is still updated when the machine is resumed, same as if it was just
suspended and then resumed without migration.

Best regards

Juraj Marcin

> 
> > +        return;
> > +    }
> > +    update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
> > +}
> > +
> >  void vnc_display_init(const char *id, Error **errp)
> >  {
> >      VncDisplay *vd;
> > @@ -3420,6 +3430,8 @@ void vnc_display_init(const char *id, Error **errp)
> >      vd->dcl.ops = &dcl_ops;
> >      register_displaychangelistener(&vd->dcl);
> >      vd->kbd = qkbd_state_init(vd->dcl.con);
> > +    vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
> > +        &vmstate_change_handler, vd);
> >  }
> >  
> >  
> > diff --git a/ui/vnc.h b/ui/vnc.h
> > index acc53a2cc1..3bb23acd34 100644
> > --- a/ui/vnc.h
> > +++ b/ui/vnc.h
> > @@ -185,6 +185,8 @@ struct VncDisplay
> >  #endif
> >  
> >      AudioState *audio_state;
> > +
> > +    VMChangeStateEntry *vmstate_handler_entry;
> >  };
> >  
> >  typedef struct VncTight {
> > -- 
> > 2.49.0
> > 
> 
> -- 
> Peter Xu
> 


