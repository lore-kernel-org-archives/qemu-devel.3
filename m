Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45680C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlwT-0005gP-8l; Wed, 21 May 2025 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHlwI-0005dA-PT
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHlwG-0000tw-Fy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747843500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bs7XGcyM2aC+svS8PZpt2c+NweJT8nx9A1SJr9WqvlI=;
 b=Ju98YPisjN32cfl8sUnQRAQtrpiR3gO/Qxg9sgWZx6DcKt7EBYCBH6d6GMem8XPe/EagDn
 lmo8N4sSX4kVU9lnf16t2pUCfo3zUAZYHHQBQD9R0uOAcZYKFpVSh2MZdOYnktmk8Pi7d/
 ROJrJH190QrZ3vqzr7Mll2JFt5/Xzn4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-QPHsCk-gPdqDHX1fQqfbBA-1; Wed, 21 May 2025 12:04:59 -0400
X-MC-Unique: QPHsCk-gPdqDHX1fQqfbBA-1
X-Mimecast-MFC-AGG-ID: QPHsCk-gPdqDHX1fQqfbBA_1747843499
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5b9333642so823667185a.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747843499; x=1748448299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bs7XGcyM2aC+svS8PZpt2c+NweJT8nx9A1SJr9WqvlI=;
 b=YMMVyrmBugkrqmE9Nya0xfEq8WCC+uV5MaQAGm1kjTORxoN+Wgk07TJEkLGJhLexip
 7bfMHkQsBdiix1qvJxiliWnmp3JD3MByhbXSnKxwb8F+C4ys47xrPHmYN8NeQyDP1g55
 OeYTEYhGMJ6l0QO899YomZbwUxfJuLdujZFOXo8JTVxRlkOysFsRmL3rLmatRViyDA8s
 /V+D7hBEzRV0JDULHN3UHAZB7smEx7hPGcCA4AxYEJq0WAZHwEROF40cfuszVjZV6YVn
 zq/3M4qkam/wfdZ5+Y+AdfSQXcjlobvOBg+FSyzdDgwsYbH4/QcTHwLdxGWaHAKpo0ir
 zupg==
X-Gm-Message-State: AOJu0Yx9kis6qHeuLxtkrbQTnnmmMfHHUpaAzDC92KgOABoKFklgZAG7
 HZdWx0OsIpsYz32GoXp67ZXe66JODzRYiikMVsbh8BJYcrcNePCkAuuIIU15CdjMf2h03mcYOIL
 qNV7CHQA5RCKl1cm1thzVUuq7P8WR/nYIiQYoTB4uU0KwyrC9Qz5BDWU6
X-Gm-Gg: ASbGncvFWM8kTOed8qKcZhJGOs+60j780Li8icnZLnrwRUvojPHcqRBJrBO0kEnFCSo
 p+Dq12F3sl+E+gugvuT838yTPx7YVgqsiPZVRGwgX9b+1U5Y1fZmoMrtiuQaMbx12VgRw7sUpzf
 EO2hreJscFQ3PbBy9tWR/Pw1oabqulydNJgiYCPXnqvayBG0bKuAWit8u71czOnZ4N21k9X+F55
 ihvIk95J4dFiduJgia6Oib0Sqaegnr8bmutPlr8D0TzdeaQMvLrrs93uhKS2a9czTDpSzSBYqNL
 dtA=
X-Received: by 2002:a05:620a:4415:b0:7ca:eb5b:9971 with SMTP id
 af79cd13be357-7cd4677ddb3mr3882323885a.36.1747843498682; 
 Wed, 21 May 2025 09:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtKmSV5scsRularTcU0VB+oALvGPiwcpMUEQxQIC8HVUjUzlvrg6PmlPTjZXJFjaH2MEbYww==
X-Received: by 2002:a05:620a:4415:b0:7ca:eb5b:9971 with SMTP id
 af79cd13be357-7cd4677ddb3mr3882316985a.36.1747843498132; 
 Wed, 21 May 2025 09:04:58 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467ecfbasm888286185a.49.2025.05.21.09.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:04:57 -0700 (PDT)
Date: Wed, 21 May 2025 12:04:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Message-ID: <aC35pvtRC3OcQruO@x1.local>
References: <20250521151616.3951178-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521151616.3951178-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> If a virtual machine is paused for an extended period time, for example,
> due to an incoming migration, there are also no changes on the screen.
> VNC in such case increases the display update interval by
> VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> 
> When the machine resumes, it can then take up to 3 seconds for the first
> display update. Furthermore, the update interval is then halved with
> each display update with changes on the screen. If there are moving
> elements on the screen, such as a video, this can be perceived as
> freezing and stuttering for few seconds before the movement is smooth
> again.
> 
> This patch resolves this issue, by adding a listener to VM state changes
> and changing the update interval when the VM state changes to RUNNING.
> The update_displaychangelistener() function updates the internal timer,
> and the display is refreshed immediately if the timer is expired.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Thanks for looking into it!

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial comment (and partly, pure question) below,

> ---
>  ui/vnc.c | 12 ++++++++++++
>  ui/vnc.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9e097dc4b4..32f8bfd1f9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3384,6 +3384,16 @@ static const DisplayChangeListenerOps dcl_ops = {
>      .dpy_cursor_define    = vnc_dpy_cursor_define,
>  };
>  
> +static void vmstate_change_handler(void *opaque, bool running, RunState state)
> +{
> +    VncDisplay *vd = opaque;
> +
> +    if (state != RUN_STATE_RUNNING) {

Just to mention in vm_prepare_start() it's possible we migrate a VM that
used to be suspended, if so it'll keep suspended after migration:

    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;

Here I'm not sure whether SUSPENDED would also like to update the display
freq.  I don't think it matters hugely, but just to say, if we want we can
simply check "running=true" instead of checking the state to cover both
RUNNING|SUSPENDED cases.

> +        return;
> +    }
> +    update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
> +}
> +
>  void vnc_display_init(const char *id, Error **errp)
>  {
>      VncDisplay *vd;
> @@ -3420,6 +3430,8 @@ void vnc_display_init(const char *id, Error **errp)
>      vd->dcl.ops = &dcl_ops;
>      register_displaychangelistener(&vd->dcl);
>      vd->kbd = qkbd_state_init(vd->dcl.con);
> +    vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
> +        &vmstate_change_handler, vd);
>  }
>  
>  
> diff --git a/ui/vnc.h b/ui/vnc.h
> index acc53a2cc1..3bb23acd34 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -185,6 +185,8 @@ struct VncDisplay
>  #endif
>  
>      AudioState *audio_state;
> +
> +    VMChangeStateEntry *vmstate_handler_entry;
>  };
>  
>  typedef struct VncTight {
> -- 
> 2.49.0
> 

-- 
Peter Xu


