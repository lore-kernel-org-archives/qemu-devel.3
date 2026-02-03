Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42539E83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6HF-0002gc-6i; Mon, 02 Feb 2026 21:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6HD-0002gN-Vy
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:36:28 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6HC-0004y4-CH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:36:27 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3532aa9a77eso2387843a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770086185; x=1770690985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgeOt9/6xAZdBDWOTYcZcrZL4DZk6Feit8gyjfJfU/8=;
 b=YP7p9MJabKq9sGPb9lmETF9zcELI2FQQiEGVqHWsC/pkD5gHKlKAn8muSp970M79ZG
 PsR3+u3nz1dnSsAzQOeOMxJne5+it3eenvz8c3fNh5vIENFzOB35OCv88bUdAWgav+N6
 Jsxf0erKIyWlJl0GUVc72DZs9dOrAqxbG6VopOykGXkQA11QV5I91ZqUXB/TULiUtOvz
 zw7eQ63gj36jvxLx8xek7MxaKkHq931PWISsWAwMsMjJGJCbL0dTzHh4BvLGF7/9kagx
 OtRVOcMrx/RVF0ctTCfMi51OD7rqeIhHhxtR0oO8BtXj7j9R8fyidVr5fHTfx/BMWxkm
 b1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770086185; x=1770690985;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgeOt9/6xAZdBDWOTYcZcrZL4DZk6Feit8gyjfJfU/8=;
 b=uGngjmPoX/VWrg9Y/3sitz/QuSTZGfqEb+y3f6oxs8yXmU0JlQG0cctCZYBBQZPzPB
 Y5Ho1LXPGj4ZA7Y5XPSonMOc9vPfxvXG8EvhU3xycUJGSEKjKAV5vNMCijPjy0csUWz4
 l/P2rYyl+aUhTViVMj/da+F0lDJmIjjMtpRY3FNSoP+kHuo4L3Ds9ybWWt7szrH21kKi
 TWs17ukS54gHFHsylkoT8ULcsjRn5CZK6cHFLta8KCqOg6IYn9iMPxJWyA5w0um4sB4y
 AsXjppbaV4h0KGfiYS04i9dXpFHoJz7rCj3kRNmos238Wsbn48Ns7cjpAZ7EZgAMgod1
 kSjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW9Np4HmzwsigCrGfg23CupEojScoiIh7YTzmvqbkUgBJ3ASm6j6uMfOoLFu/sqGgBlkxpDZ9sLFbX@nongnu.org
X-Gm-Message-State: AOJu0YzkDevJKafkolC/7YKvNj3YC0d0pOPrEtUdNqYWhQUgXr9r+unP
 WKK7oM/XtQ5n+z6pJJ1BYRDYQWGJpDDPMvwFboCKDI/7qTDRUL5zJj+hQJGmdXKxWYY=
X-Gm-Gg: AZuq6aInES8gYXjERU75jktEtvt4lvq6Pm753O0hS9dE0TFWUYExrdlR6clPhKL53FG
 FbUFOp23WtHY/kDnQwX+BrBqVAY5SJAgl6i4LiWScIOc5N5yKHlXjhNH8IiyPdje/tfgZbnXCBy
 g59c4HXWh7qUOElhr19+Bg3Swz7p+GQx6mEaU7giU0+opvuNW++wAGDGfcWG5YMafj+OiAbnwQA
 ut1KSsKeCli5wlolfkn6jcCp8njtdyhN7KAGhcOXuOZvh0rekzhPwAMZf3pYCO0jR66Jid87vIy
 BAausEchajHjt1bIzRUqlr7zKo6407OLQ2U1dQlkULK3Pkv/tgY/d4WLUWfs68eVtd7YKFee23F
 QFg0q2wL89n4+6r7SAi9ymqgBf60TdlIl7VQJkmn3Z1UUuooIrJydsdbkShNKixdoaJBMnhZScw
 0pJtdyO0dxgH+hxWPeVtqrWlJ9iKMjC8c5pZEFCc/Ce2PLW5/DD2ZMe7VwT252rDmfKWpBGXiNT
 w58f4VwZPok+Z/1QcqREbZ7oCblOjEhk6jMxHBy2g==
X-Received: by 2002:a17:90b:4b02:b0:340:d06d:ea73 with SMTP id
 98e67ed59e1d1-3543b3b24aemr11220496a91.19.1770086184614; 
 Mon, 02 Feb 2026 18:36:24 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3543babe32fsm5729724a91.0.2026.02.02.18.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:36:23 -0800 (PST)
Message-ID: <d104e4b0-94c4-4de4-84e7-1011253ab5f8@linaro.org>
Date: Tue, 3 Feb 2026 12:36:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial v2 7/7] rename CONFIG_EPOLL_CREATE1 to
 CONFIG_EPOLL, and stop checking for epoll in meson.build
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260119140557.2167351-1-mjt@tls.msk.ru>
 <20260119140557.2167351-4-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260119140557.2167351-4-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/20/26 00:05, Michael Tokarev wrote:
> Since CONFIG_EPOLL is now unused, it's okay to
> perform this rename, to make it less ugly.
> 
> Since epoll is linux-specific and is always present on linux,
> define CONFIG_EPOLL to 1 on linux, without compile-time test.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   meson.build      | 3 +--
>   util/aio-posix.h | 4 ++--
>   util/meson.build | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f4eae50764..157189e306 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2673,8 +2673,7 @@ config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
>   # has_header_symbol
>   config_host_data.set('CONFIG_BLKZONED',
>                        cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
> -config_host_data.set('CONFIG_EPOLL_CREATE1',
> -                     cc.has_header_symbol('sys/epoll.h', 'epoll_create1'))
> +config_host_data.set('CONFIG_EPOLL', host_os == 'linux')

I guess my question remains: Why keep CONFIG_EPOLL if it is identical to the existing 
CONFIG_LINUX?


r~

