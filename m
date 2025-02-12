Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF67C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEa7-0004Yj-Ce; Wed, 12 Feb 2025 10:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEZx-0004X0-N7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiEZv-0000xV-Uf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739373786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drT8QrMZ6YeXdCgvW5wO8RfF7/c4dg91kDmL/U6bLdI=;
 b=XLP/iloV3wVXmZHo4KOn/z9DkOah0wsiUnarIWSnq2W6Ebb5Q8IwBTQ8LvCLQ/K/T9bC5J
 I2YnUUdiMKmheN7sFyCTdr1qyak/lm3hN0tHzKyPX3XxC9w5Y9efLfp+9JMni9aNZ/ah/+
 UjTMny/3KH1Cdeoltyrtq66USp+3gVY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-JNPX9WvlM6uuh11-rk6egw-1; Wed, 12 Feb 2025 10:23:05 -0500
X-MC-Unique: JNPX9WvlM6uuh11-rk6egw-1
X-Mimecast-MFC-AGG-ID: JNPX9WvlM6uuh11-rk6egw
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e549c458692so9544981276.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739373785; x=1739978585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drT8QrMZ6YeXdCgvW5wO8RfF7/c4dg91kDmL/U6bLdI=;
 b=gkw5zJ9R6I1x74g2RZ/+6vbLtlrWH4CvXRxvdvciQDnkZYVyXMQzPLjt/Ekj14d/Xo
 2JvBHMd5Ck6kv7yjFDdIG9s5Cz7BWr0MtW6kZ9G2v6wkqz89UPBgSzM9UiWoun6RrbVv
 ZKM3ViGCRoUq8Kz+FWAL4ByP2heELi20hdipdJFzncJ7hOFFX/ZQHhLTtsQ3sz6/PEAX
 p7t3vnwqZTCwSvasvwQMHyLTuPJJuJN0NGI87v5XCXna59HDlWtYVd2xUDDw7lb+aw0+
 pJ/n8RgPwsxtd1fqMqJ7T1LFhMy2HB8rPLHlB8+pkTz68I36kMx815B5rSM5ibNKiQTj
 m/Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygTlekeJUIs0jyaMQ1/3fT1CDz3Wg+8pZ6PSXnKyRaHVCNf+FS2cq3RS5kb5sXWeCff/2N2VEYx42@nongnu.org
X-Gm-Message-State: AOJu0Yx4V64htslkznHU6biMNLNmOOlnXPQQiStpHpKdP8FIrDGbGxTw
 x8qhGomZW1RJTkiUQOg0esXiYDN3S101PYTq8vNSS9uP82Q6NhPkpOmEoinR1GzSawEKDJMM3UD
 QT7L3VwkJprxG5nqaqK8605inisse7isKO/D8d5DWts8GoAmh68Ww
X-Gm-Gg: ASbGncue/KMsydWxUPr9U95KP7HvA+nDIVTf/Sumv45b3i25hFH7C+8WEBnzk/PZPzv
 +nbGqZ3puTy/t8vMgRW8wk+5hKC+bkyMDRMPkRB5Lulha94CgagZZF7W+d7pM6kL9uwHpFdjsLD
 h/MPvc1jfajDFZ0tJP7udieilYgXrL2QsA4UDmEc6C1TR+MFkW/9jWrJx0rMRY+f35N6dlvmHMj
 Qqded18lFfv4jw+w3S1GUIzGlJlfpE6wQRkUPHbPLRUZalIc6APNmcRDA0=
X-Received: by 2002:a05:6902:270a:b0:e58:37fe:4a17 with SMTP id
 3f1490d57ef6-e5d9f1965cdmr3519906276.46.1739373785155; 
 Wed, 12 Feb 2025 07:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAXYqpeLldnaGb2nNDcpTV++ad1FthejS+nnHtB5N/4slBrUdTBeWAYp0m1UFds93mVKNN9Q==
X-Received: by 2002:a05:6902:270a:b0:e58:37fe:4a17 with SMTP id
 3f1490d57ef6-e5d9f1965cdmr3519871276.46.1739373784805; 
 Wed, 12 Feb 2025 07:23:04 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a48d1c1sm4092200276.56.2025.02.12.07.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:23:04 -0800 (PST)
Date: Wed, 12 Feb 2025 10:23:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
Message-ID: <Z6y81mXn7yaXy63A@x1.local>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On Wed, Feb 12, 2025 at 05:39:17PM +0300, Daniil Tatianin wrote:
> This will be used in the following commits to make it possible to only
> lock memory on fault instead of right away.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  include/system/os-posix.h |  2 +-
>  include/system/os-win32.h |  3 ++-
>  meson.build               |  6 ++++++
>  migration/postcopy-ram.c  |  2 +-
>  os-posix.c                | 14 ++++++++++++--
>  system/vl.c               |  2 +-
>  6 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index b881ac6c6f..ce5b3bccf8 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>  void os_set_chroot(const char *path);
>  void os_setup_limits(void);
>  void os_setup_post(void);
> -int os_mlock(void);
> +int os_mlock(bool on_fault);
>  
>  /**
>   * qemu_alloc_stack:
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index b82a5d3ad9..cd61d69e10 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
>      return false;
>  }
>  
> -static inline int os_mlock(void)
> +static inline int os_mlock(bool on_fault)
>  {
> +    (void)on_fault;
>      return -ENOSYS;
>  }
>  
> diff --git a/meson.build b/meson.build
> index 18cf9e2913..59953cbe6b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
>      return mlockall(MCL_FUTURE);
>    }'''))
>  
> +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
> +  #include <sys/mman.h>
> +  int main(void) {
> +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
> +  }'''))
> +
>  have_l2tpv3 = false
>  if get_option('l2tpv3').allowed() and have_system
>    have_l2tpv3 = cc.has_type('struct mmsghdr',
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 6a6da6ba7f..fc4d8a10df 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>      }
>  
>      if (enable_mlock) {
> -        if (os_mlock() < 0) {
> +        if (os_mlock(false) < 0) {
>              error_report("mlock: %s", strerror(errno));
>              /*
>               * It doesn't feel right to fail at this point, we have a valid
> diff --git a/os-posix.c b/os-posix.c
> index 9cce55ff2f..17b144c0a2 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -327,18 +327,28 @@ void os_set_line_buffering(void)
>      setvbuf(stdout, NULL, _IOLBF, 0);
>  }
>  
> -int os_mlock(void)
> +int os_mlock(bool on_fault)
>  {
>  #ifdef HAVE_MLOCKALL
>      int ret = 0;
> +    int flags = MCL_CURRENT | MCL_FUTURE;
>  
> -    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
> +#ifdef HAVE_MLOCK_ONFAULT
> +    if (on_fault) {
> +        flags |= MCL_ONFAULT;
> +    }
> +#else
> +    (void)on_fault;
> +#endif

IIUC we should fail this when not supported.

Would you mind I squash this in?

diff --git a/os-posix.c b/os-posix.c
index 17b144c0a2..52925c23d3 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -333,13 +333,14 @@ int os_mlock(bool on_fault)
     int ret = 0;
     int flags = MCL_CURRENT | MCL_FUTURE;
 
-#ifdef HAVE_MLOCK_ONFAULT
     if (on_fault) {
+#ifdef HAVE_MLOCK_ONFAULT
         flags |= MCL_ONFAULT;
-    }
 #else
-    (void)on_fault;
+        error_report("mlockall: on_fault not supported");
+        return -EINVAL;
 #endif
+    }
 
     ret = mlockall(flags);
     if (ret < 0) {


> +
> +    ret = mlockall(flags);
>      if (ret < 0) {
>          error_report("mlockall: %s", strerror(errno));
>      }
>  
>      return ret;
>  #else
> +    (void)on_fault;
>      return -ENOSYS;
>  #endif
>  }
> diff --git a/system/vl.c b/system/vl.c
> index 9c6942c6cf..e94fc7ea35 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts = {
>  static void realtime_init(void)
>  {
>      if (enable_mlock) {
> -        if (os_mlock() < 0) {
> +        if (os_mlock(false) < 0) {
>              error_report("locking memory failed");
>              exit(1);
>          }
> -- 
> 2.34.1
> 

-- 
Peter Xu


