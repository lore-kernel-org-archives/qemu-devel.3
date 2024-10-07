Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACDDCFB451
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 18:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxsGt-0003tN-0l; Mon, 07 Oct 2024 14:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxsGd-0003lM-PP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:49 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxsGa-0003Qm-NJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:15:35 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a0c9ff90b1so16094825ab.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728324931; x=1728929731;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMHfCE92AI/4fdd3aBWQCBhtjRUGTHXYjW+4DgMtQOQ=;
 b=fBVAYGaHIurdBw7S2y+UomGK3hUFkxJBmxwaxBcgxAvHQ+JE7bizgPYOvHkFXMGSZO
 keHTJ1oiWBJUV6k8SvAGBahXJVpm77R7168EuYvSxwLmOOaQ5/bhOLB84WywFJ48CHWQ
 gF5dXExe0y7nQ73ePuB2CeRegBs4B7zmWNC7enPwVpnnJX1oSOcnbZ1ryjAbmhP9UkXN
 E2ebHZ8zu5D/I0+sXxAHGihEuspVH4qCfet7/hJW9fiS4C9rB/1n1v3XFuRbQG7FwpOv
 4S2mTHc21ugw0l05FNWW+pbHzkDMbe6w0tORsMF/uw2AX4zqtV441NZJffPaLWZkYVh+
 cHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728324931; x=1728929731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMHfCE92AI/4fdd3aBWQCBhtjRUGTHXYjW+4DgMtQOQ=;
 b=HzBydbWuMTV1E+/5RPmG/0sQu8UmxWwqfFZC9kw8pivHxCMXgDVj9jLqQMlCzuvbEx
 IJCsYedbfBZf5gS7Bx0a3hqWoTfDw6AKqjyG7uBx1Zkm55EMLda4ebc13qQAGourCH4Z
 1t2MK+M3OyFemKb9TSOhd9QkOEAmT86SaaK9w7qO0nuMBRO7l0bnpWhoqzaeZuYVjTeg
 +RjeynKy6qcmT9XrmWx1rzCy4PlqDrg+TEvcYnVS+QybRUyXCpYoIE42XxdSF9V9AWU1
 qr4PL5At1vbyUPVN3sorU6ayIEp6L25jiP3RxR6nn4knJjIXgKaLYomC1YliLunaqj8e
 pWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz65iOWGH0B1H0DCj2ozJoyiUzzoqFVNC1rtgLSMeG/ZgHCQOOR2fTQt4L7LzhHpIemwF7AZVitRLz@nongnu.org
X-Gm-Message-State: AOJu0YyxR8XaB9Haw5DEEoLFRt5FfltnyY9Gkiw6J0yb8Ahk20cLFPqi
 Px1UGUUGTC6HFcV7/DzubHsrEZZZig74V+T5yL7mrsok2+9m5S9PFjh4YAGZMjw=
X-Google-Smtp-Source: AGHT+IHdJk+n8Hv0p53/RS4skidltu+uVyFkWSGmxJeuLetxKj5T+kl/WXyunvGjAN4x9u5SHpgCiA==
X-Received: by 2002:a05:6e02:170e:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a375bba4d7mr111280845ab.21.1728324931335; 
 Mon, 07 Oct 2024 11:15:31 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c49803sm5278783a12.79.2024.10.07.11.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 11:15:30 -0700 (PDT)
Message-ID: <94909191-a1de-4be7-bbf1-0056fd8b2887@daynix.com>
Date: Tue, 8 Oct 2024 03:15:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ui/gtk: Don't disable scanout when display is
 refreshed
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
 <20241006234353.3201037-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006234353.3201037-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 8:43, Dmitry Osipenko wrote:
> Display refreshment is invoked by a timer and it erroneously disables
> the active scanout if it happens to be invoked after scanout has been
> enabled. This offending scanout-disable race condition with a timer
> can be easily hit when Qemu runs with a disabled vsync by using SDL or
> GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
> content shouldn't disable the active display. Fix it by keeping the
> scanout's state unchanged when display is redrawn.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   ui/gtk-egl.c     | 1 -
>   ui/gtk-gl-area.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 9831c10e1bd5..6b85a51c4284 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -179,7 +179,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>   
>       if (vc->gfx.glupdates) {
>           vc->gfx.glupdates = 0;
> -        gtk_egl_set_scanout_mode(vc, false);
>           gd_egl_draw(vc);
>       }
>   }
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index b628b354510d..b00817abc011 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -148,7 +148,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>   
>       if (vc->gfx.glupdates) {
>           vc->gfx.glupdates = 0;
> -        gtk_gl_area_set_scanout_mode(vc, false);
>           gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
>       }
>   }


