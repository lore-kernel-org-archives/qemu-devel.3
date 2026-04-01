Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D10107637D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vwM-0003op-Ff; Wed, 01 Apr 2026 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vwL-0003oc-0y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:49:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vwI-00012k-V8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:49:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so12634465e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775051337; x=1775656137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZO2vBNoQcQIsYMgsYyjrotopfk+3tQnuPhVTrobSpYU=;
 b=bDumao4SkA9rGEp6e5US9VnGxV2zk+vGoUFW9/fDtkZztcyXq94TcIucp6ZJm76RTG
 mD1rAgTiC6yuHjp+L2QKtw3/2lvfK9iFD9HIlXEGFUD/kpxf67Cz/Akxiy8DtIzsdcox
 JiTU+H95L8N0bb+yvSfe0fEEL97QYwOHzHogRw/LSh7tAuzYev08MNM0saMi1J+YSH7l
 jgxiQ7LQlTfwIzc8aMCs10u8xaXU8DchUFqZwNE4OI5qa6orwHjtn7MtI7dYBVRUC4su
 ZRDHlmPi1ou5ahtwGnwfPs0mFAAloN2UCdY8m9drmFhPNQzJpW7EtcR4TmZSxEUz9eHl
 dR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775051337; x=1775656137;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZO2vBNoQcQIsYMgsYyjrotopfk+3tQnuPhVTrobSpYU=;
 b=MPfA7ktehtu9wP9tPXGkTntmE07IQRoS35NDAR0ZuhnpQU43M/UNSCcYfoWWVEa4hy
 H5qsm1aYsaEmIAgDpfu7NKWm9hh3PhE45/WWcudYSvFgtgbdRDG5w8FYdYTpiL0a6cvm
 LODXvHWMxn8t2LsuWj9diwSACp8SaPSBWEaUOpQS/SUo5BI8AgV51GSJ6YDBOjhYngdN
 M2BWV/XpGmFt4eqWC/7zrnwhO4ROv85NmeuAhOwGQ7UrpZn5DVyMKVBcp0Wdg6ULPmqu
 8F56N0nONOOWWhvAvhI6QJxZu13G/NGRKgh2rYFfr64u+4L1ZcQtChCQckINrQJ3/4mp
 mPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD35t2jHcIXK98Rh5SZXLM2S13DSmDRSKd00w0nxNWwiOPYKwTKQTeQRhH0pTEWtwgkCZJvMdoL6JL@nongnu.org
X-Gm-Message-State: AOJu0Ywf7snIGoYkkBojE+/plILSZBUhqJ+X5ic2JVpulrybvdH+z0kD
 HH0IqMYwGicSI/mS7xIVGBbHDyiH6Nl+xWLu1xhcbKUoGZBSDFtFoxDq1WpL2T4+Tfg8zDR2O22
 PdpNGfB0=
X-Gm-Gg: ATEYQzwfVshAcFqdZe7EKk/auzT9VoiEzT+/fVV8QQ1TQNiVgLxXJu9JkE4oVpjpd92
 RDU7DSP6sCPuJRhH+a9pAr8zsvQLUl2GLQZZ4nK22ppnpUx1QOWwgLnD2YWpYmr//WSGliE8OAk
 8JSAZ0t0WdKVVRUULePZH/JOw3QEwH9L0wt0opSgtHGDRCs7huNfIOVYsCu1GdMURPWzVYFMPZ1
 V4c1wJBOylVgKWCHuXaG/0ayPHFsOihx0eDt+lx1+hHihjcLskCKzC4/f9uCiksDKAAQKOd+aPR
 lmyzq6Ee70wfyH1l/vLquyQt3U8K9vCmDS+ANBtlyWcAMVY5Htr8xrROvf1t0ZLl9aR+a1aW0aZ
 eIyMfU4LsKGQCT9j9RX46lVs4QWUI0BRjvU7tjagaaMSKzeT9QbJfRLi9pMxQHNe07A7qev7h4k
 7f2aO//jv9zBqtwbMkAkshQSWIxVoFl9cNSKum3a2tPsiwmKyDoN+fHYVXSSrVThAq2w==
X-Received: by 2002:a05:600c:5252:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-4888358a459mr59499745e9.6.1775051337313; 
 Wed, 01 Apr 2026 06:48:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e832585sm229489195e9.6.2026.04.01.06.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:48:56 -0700 (PDT)
Message-ID: <a30b8c59-995b-4761-b4ea-d55ae2b63b48@linaro.org>
Date: Wed, 1 Apr 2026 15:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/60] ui/console: remove console_ch_t typedef and
 console_write_ch()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-31-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-31-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Since commit e2f82e924d05 ("console: purge curses bits from
> console.h"), console_ch_t is a plain uint32_t typedef and
> console_write_ch() is a trivial assignment (*dest = ch). These
> abstractions were originally needed because console_ch_t was the
> curses chtype when CONFIG_CURSES was enabled, and console_write_ch()
> handled VGA-to-curses character translation. That commit moved the
> curses logic into curses_update(), making the typedef and helper
> dead abstractions.
> 
> Replace console_ch_t with uint32_t and console_write_ch() calls
> with direct assignments.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h         | 11 ++---------
>   hw/display/jazz_led.c        | 10 +++++-----
>   hw/display/vga.c             | 16 ++++++++--------
>   hw/display/virtio-gpu-base.c |  2 +-
>   hw/display/virtio-vga.c      |  2 +-
>   hw/display/vmware_vga.c      |  2 +-
>   ui/console-vc.c              | 11 +++++------
>   ui/console.c                 |  2 +-
>   ui/curses.c                  |  6 +++---
>   9 files changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 401e5a010fd..152333d60fc 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -350,13 +350,6 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLContext ctx);
>   
>   bool console_has_gl(QemuConsole *con);
>   
> -typedef uint32_t console_ch_t;
> -
> -static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
> -{
> -    *dest = ch;
> -}

Why not just remove console_write_ch() but keep the typedef which is
simpler to relate than 'uint32_t *'?

>   enum {
>       GRAPHIC_FLAGS_NONE     = 0,
>       /* require a console/display with GL callbacks */
> @@ -370,7 +363,7 @@ typedef struct GraphicHwOps {
>       void (*invalidate)(void *opaque);
>       void (*gfx_update)(void *opaque);
>       bool gfx_update_async; /* if true, calls graphic_hw_update_done() */
> -    void (*text_update)(void *opaque, console_ch_t *text);
> +    void (*text_update)(void *opaque, uint32_t *text);
>       void (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
>       void (*gl_block)(void *opaque, bool block);
>   } GraphicHwOps;
> @@ -386,7 +379,7 @@ void graphic_console_close(QemuConsole *con);
>   void graphic_hw_update(QemuConsole *con);
>   void graphic_hw_update_done(QemuConsole *con);
>   void graphic_hw_invalidate(QemuConsole *con);
> -void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
> +void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata);
>   void graphic_hw_gl_block(QemuConsole *con, bool block);


