Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B96C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 12:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4Fs-0003dg-NX; Mon, 02 Jun 2025 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uM4Fj-0003cz-Ul; Mon, 02 Jun 2025 08:26:56 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uM4Fg-0005D1-Sl; Mon, 02 Jun 2025 08:26:55 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6f0ad744811so31657186d6.1; 
 Mon, 02 Jun 2025 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748867211; x=1749472011; darn=nongnu.org;
 h=in-reply-to:content-language:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8JMhavpWA/4U4YYWUWAvfRCop2v457n/RkEL4jJxBs=;
 b=J3+36MMouLwAcZNyEw9/Q6uEtqN5FstQ/5SEBau7cEYN1Pa2II0l2MaInsASQDneel
 u88OYERgt5QWx+FEs1ov7/m9gPkzvD63203E9lYEB19J6uVLcjlQTQQ00j3kL+x3UqN6
 +Iz+ERQ8jMwZBi2EgZbb7drzR4iVDlCcSQLS/qreIp0QqAhCUV1CgvPBV3S8xw4iC1Hw
 1ypRyVEOsOqWBV26Ec1vMFyr1E06Ylu1LKapydgMDl+GXXgdimdYEPNgQjEDVvQblmeC
 V4xirxRcpUHUI/6SFPtyiDCVuDCwN8QeecJt+ZVzpgqR2Wp8tkbMn5LVy7aZhmN1qT6y
 18lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748867211; x=1749472011;
 h=in-reply-to:content-language:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q8JMhavpWA/4U4YYWUWAvfRCop2v457n/RkEL4jJxBs=;
 b=JDowvlG9JaowvPJv6o4VSvmEvKwzP7LbfYDyTc3Ug/8/8b47IfYuY3wNgb22wwUlm+
 y2kiVjzP7Ep8UoqQ80ganeCSJSMZOALMQCfygyDjiIBpEpacgcwDFDCakI5yEh2DqUHZ
 lJgznyrdOXPF2L73wScso0lzn6Xa8rtUb4T4IIHVy/dKUMGluGu3tAMZ6oKBDv9DyEW1
 bYwSNuxO4tr1JWCgH/vui7z/gQAStsbHfDXlmzkJ2xHLOhQFiRnUBBBSWP8nmy0rmIOQ
 5edGS7rtJk+LB5PZI1rO1MyUz98Zr6aF6F+1PPowTcdLpryE9QOor6K2xkAhY7Zfc1gU
 CxZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJSWw+lEUbFAm18ZB3/V9dWIg17vjBIoWmB/Z5yi3phDWnqpuuzvXI1doBa7itYajpMEQlLJSHHDOc@nongnu.org
X-Gm-Message-State: AOJu0Yx0ZFsfrJpHjNA6UCX8ldF6g26Fc8dcANKKJDKg6DWHNvRm4qxo
 3E0wG0fSGpDD5GVT7BmOlROPVZdvWLHNHNlU6I9G7a2HK5z4FKmw8b5mb0u/iDdmYDE=
X-Gm-Gg: ASbGncuaRH/tOVt79K3m9W/KFEMEr2Sp8I0UeX/47utx6DMfj53w3zKRK92GThBesbA
 DZ2Pvr9tAapIabhwhsJl2Kviw0391jWS8qqrzqA55TXw1oB5J1kPbJtT45qLGQeND0Hp6RXVH8E
 GduYV2yuFYaqk3geZHq4k0FTfpIXpW4jkwyzDtr8wWQCYdpmG7Y5lXlABQuLfkxDd1kWpmacBR4
 5aAOV/1gTTy8XokqqwnwTn0sybKUHMpx6rdu6k+RCqaR493JYSpcfUHF+EHQn4Q0OSaD1qZcfBg
 Vkl8hsrkhlVn4arDidaE78P/W71ITbAUVGkx6dKppgF40ER+9YdeXH3PY1MoFRyWbtE2
X-Google-Smtp-Source: AGHT+IFtCNpXsVHEfaZcDX+Y9vyNF+NXQ8PxDavIIDV60hId3d14laZLMIK1Z+4sWeugCUbl6Rp4/g==
X-Received: by 2002:a05:6214:acc:b0:6fa:cd35:3db6 with SMTP id
 6a1803df08f44-6fad90abf8dmr160795466d6.18.1748867210429; 
 Mon, 02 Jun 2025 05:26:50 -0700 (PDT)
Received: from [192.168.2.59] ([174.92.118.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d4d0cesm59801036d6.35.2025.06.02.05.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 05:26:50 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------uHkLPvmu8skt0mKNUTH8wScJ"
Message-ID: <a0a98436-5e4e-46d1-9a66-b6edce5c0ecc@gmail.com>
Date: Mon, 2 Jun 2025 08:26:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian <hibriansong@gmail.com>
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
Content-Language: en-US
In-Reply-To: <20250528190916.35864-9-stefanha@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------uHkLPvmu8skt0mKNUTH8wScJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 3:09 PM, Stefan Hajnoczi wrote:
> io_uring may not be available at runtime due to system policies (e.g.
> the io_uring_disabled sysctl) or creation could fail due to file
> descriptor resource limits.
>
> Handle failure scenarios as follows:
>
> If another AioContext already has io_uring, then fail AioContext
> creation so that the aio_add_sqe() API is available uniformly from all
> QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> unavailable.
>
> Notes:
> - Update the comment about selecting the fastest fdmon implementation.
>    At this point it's not about speed anymore, it's about aio_add_sqe()
>    API availability.
> - Uppercase the error message when converting from error_report() to
>    error_setg_errno() for consistency (but there are instances of
>    lowercase in the codebase).
> - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
>
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> ---
>   util/aio-posix.h      | 12 ++----------
>   util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
>   util/fdmon-io_uring.c |  8 ++++----
>   3 files changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/util/aio-posix.h b/util/aio-posix.h
> index f9994ed79e..6f9d97d866 100644
> --- a/util/aio-posix.h
> +++ b/util/aio-posix.h
> @@ -18,6 +18,7 @@
>   #define AIO_POSIX_H
>   
>   #include "block/aio.h"
> +#include "qapi/error.h" struct AioHandler { GPollFD pfd; @@ -72,17 +73,8 @@ static inline 
> void fdmon_epoll_disable(AioContext *ctx) #endif /* 
> !CONFIG_EPOLL_CREATE1 */ #ifdef CONFIG_LINUX_IO_URING -bool 
> fdmon_io_uring_setup(AioContext *ctx); +void 
> fdmon_io_uring_setup(AioContext *ctx, Error **errp); void 
> fdmon_io_uring_destroy(AioContext *ctx); -#else -static inline bool 
> fdmon_io_uring_setup(AioContext *ctx) -{ - return false; -} - -static 
> inline void fdmon_io_uring_destroy(AioContext *ctx) -{ -} #endif /* 
> !CONFIG_LINUX_IO_URING */ #endif /* AIO_POSIX_H */ diff --git 
> a/util/aio-posix.c b/util/aio-posix.c index fa047fc7ad..44b3df61f9 
> 100644 --- a/util/aio-posix.c +++ b/util/aio-posix.c @@ -16,6 +16,7 @@ 
> #include "qemu/osdep.h"
>   #include "block/block.h"
>   #include "block/thread-pool.h"
> +#include "qapi/error.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/lockcnt.h"
>   #include "qemu/rcu.h"
> @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **errp)
>       ctx->epollfd = -1;
>       ctx->epollfd_tag = NULL;
>   
> -    /* Use the fastest fd monitoring implementation if available */
> -    if (fdmon_io_uring_setup(ctx)) {
> -        return;
> +#ifdef CONFIG_LINUX_IO_URING
> +    {
> +        static bool need_io_uring;
> +        Error *local_err = NULL; /* ERRP_GUARD() doesn't handle error_abort */
> +
> +        /* io_uring takes precedence because it provides aio_add_sqe() support */
> +        fdmon_io_uring_setup(ctx, &local_err);
> +        if (!local_err) {
> +            /*
> +             * If one AioContext gets io_uring, then all AioContexts need io_uring
> +             * so that aio_add_sqe() support is available across all threads.
> +             */
> +            need_io_uring = true;
> +            return;
> +        }
> +        if (need_io_uring) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +
> +        warn_report_err_once(local_err); /* frees local_err */
> +        local_err = NULL;
>       }
> +#endif /* CONFIG_LINUX_IO_URING */
>   
Is there a problem with the logic of this code snippet?

If we fail at fdmon_io_uring_setup, specifically at io_uring_queue_init,
local_err (or errp) will be set to a non-NULL error value. In that case,
need_io_uring will be set to true, but the function will return 
immediately.
As a result, the later if (need_io_uring) block will never be executed

>       fdmon_epoll_setup(ctx);
>   }
>   
>   void aio_context_destroy(AioContext *ctx)
>   {
> +#ifdef CONFIG_LINUX_IO_URING
>       fdmon_io_uring_destroy(ctx);
> +#endif
>   
>       qemu_lockcnt_lock(&ctx->list_lock);
>       fdmon_epoll_disable(ctx);
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index 2092d08d24..ef1a866a03 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -45,6 +45,7 @@
>   
>   #include "qemu/osdep.h"
>   #include <poll.h>
> +#include "qapi/error.h"
>   #include "qemu/rcu_queue.h"
>   #include "aio-posix.h"
>   
> @@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops = {
>       .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
>   };
>   
> -bool fdmon_io_uring_setup(AioContext *ctx)
> +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>   {
>       int ret;
>   
> @@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
>   
>       ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
>       if (ret != 0) {
> -        return false;
> +        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
> +        return;
>       }
>   
>       QSLIST_INIT(&ctx->submit_list);
>       ctx->fdmon_ops = &fdmon_io_uring_ops;
>       ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
>               ctx->fdmon_io_uring.ring_fd, G_IO_IN);
> -
> -    return true;
>   }
>   
>   void fdmon_io_uring_destroy(AioContext *ctx)
--------------uHkLPvmu8skt0mKNUTH8wScJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 5/28/25 3:09 PM, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250528190916.35864-9-stefanha@redhat.com">
      <pre wrap="" class="moz-quote-pre">io_uring may not be available at runtime due to system policies (e.g.
the io_uring_disabled sysctl) or creation could fail due to file
descriptor resource limits.

Handle failure scenarios as follows:

If another AioContext already has io_uring, then fail AioContext
creation so that the aio_add_sqe() API is available uniformly from all
QEMU threads. Otherwise fall back to epoll(7) if io_uring is
unavailable.

Notes:
- Update the comment about selecting the fastest fdmon implementation.
  At this point it's not about speed anymore, it's about aio_add_sqe()
  API availability.
- Uppercase the error message when converting from error_report() to
  error_setg_errno() for consistency (but there are instances of
  lowercase in the codebase).
- It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.

Signed-off-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E"
      href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
---
 util/aio-posix.h      | 12 ++----------
 util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
 util/fdmon-io_uring.c |  8 ++++----
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/util/aio-posix.h b/util/aio-posix.h
index f9994ed79e..6f9d97d866 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -18,6 +18,7 @@
 #define AIO_POSIX_H
 
 #include "block/aio.h"
+#include "qapi/error.h<a class="moz-txt-link-rfc2396E"
href="mailto:structAioHandler{GPollFDpfd;@@-72,17+73,8@@staticinlinevoidfdmon_epoll_disable(AioContext*ctx)#endif/*!CONFIG_EPOLL_CREATE1*/#ifdefCONFIG_LINUX_IO_URING-boolfdmon_io_uring_setup(AioContext*ctx);+voidfdmon_io_uring_setup(AioContext*ctx,Error**errp);voidfdmon_io_uring_destroy(AioContext*ctx);-#else-staticinlineboolfdmon_io_uring_setup(AioContext*ctx)-{-returnfalse;-}--staticinlinevoidfdmon_io_uring_destroy(AioContext*ctx)-{-}#endif/*!CONFIG_LINUX_IO_URING*/#endif/*AIO_POSIX_H*/diff--gita/util/aio-posix.cb/util/aio-posix.cindexfa047fc7ad..44b3df61f9100644---a/util/aio-posix.c+++b/util/aio-posix.c@@-16,6+16,7@@#include">"
 
 struct AioHandler {
     GPollFD pfd;
@@ -72,17 +73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx)
 #endif /* !CONFIG_EPOLL_CREATE1 */
 
 #ifdef CONFIG_LINUX_IO_URING
-bool fdmon_io_uring_setup(AioContext *ctx);
+void fdmon_io_uring_setup(AioContext *ctx, Error **errp);
 void fdmon_io_uring_destroy(AioContext *ctx);
-#else
-static inline bool fdmon_io_uring_setup(AioContext *ctx)
-{
-    return false;
-}
-
-static inline void fdmon_io_uring_destroy(AioContext *ctx)
-{
-}
 #endif /* !CONFIG_LINUX_IO_URING */
 
 #endif /* AIO_POSIX_H */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index fa047fc7ad..44b3df61f9 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -16,6 +16,7 @@
 #include "</a>qemu/osdep.h"
 #include "block/block.h"
 #include "block/thread-pool.h"
+#include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
 #include "qemu/rcu.h"
@@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **errp)
     ctx-&gt;epollfd = -1;
     ctx-&gt;epollfd_tag = NULL;
 
-    /* Use the fastest fd monitoring implementation if available */
-    if (fdmon_io_uring_setup(ctx)) {
-        return;
+#ifdef CONFIG_LINUX_IO_URING
+    {
+        static bool need_io_uring;
+        Error *local_err = NULL; /* ERRP_GUARD() doesn't handle error_abort */
+
+        /* io_uring takes precedence because it provides aio_add_sqe() support */
+        fdmon_io_uring_setup(ctx, &amp;local_err);
+        if (!local_err) {
+            /*
+             * If one AioContext gets io_uring, then all AioContexts need io_uring
+             * so that aio_add_sqe() support is available across all threads.
+             */
+            need_io_uring = true;
+            return;
+        }
+        if (need_io_uring) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        warn_report_err_once(local_err); /* frees local_err */
+        local_err = NULL;
     }
+#endif /* CONFIG_LINUX_IO_URING */
 </pre>
    </blockquote>
    Is there a problem with the logic of this code snippet?<br>
    <br>
    If we fail at fdmon_io_uring_setup, specifically at
    io_uring_queue_init, <br>
    local_err (or errp) will be set to a non-NULL error value. In that
    case, <br>
    need_io_uring will be set to true, but the function will return
    immediately. <br>
    As a result, the later if (need_io_uring) block will never be
    executed<br>
    <br>
    <blockquote type="cite"
      cite="mid:20250528190916.35864-9-stefanha@redhat.com">
      <pre wrap="" class="moz-quote-pre">     fdmon_epoll_setup(ctx);
 }
 
 void aio_context_destroy(AioContext *ctx)
 {
+#ifdef CONFIG_LINUX_IO_URING
     fdmon_io_uring_destroy(ctx);
+#endif
 
     qemu_lockcnt_lock(&amp;ctx-&gt;list_lock);
     fdmon_epoll_disable(ctx);
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 2092d08d24..ef1a866a03 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -45,6 +45,7 @@
 
 #include "qemu/osdep.h"
 #include &lt;poll.h&gt;
+#include "qapi/error.h"
 #include "qemu/rcu_queue.h"
 #include "aio-posix.h"
 
@@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops = {
     .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
 };
 
-bool fdmon_io_uring_setup(AioContext *ctx)
+void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
 
@@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
 
     ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &amp;ctx-&gt;fdmon_io_uring, 0);
     if (ret != 0) {
-        return false;
+        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
+        return;
     }
 
     QSLIST_INIT(&amp;ctx-&gt;submit_list);
     ctx-&gt;fdmon_ops = &amp;fdmon_io_uring_ops;
     ctx-&gt;io_uring_fd_tag = g_source_add_unix_fd(&amp;ctx-&gt;source,
             ctx-&gt;fdmon_io_uring.ring_fd, G_IO_IN);
-
-    return true;
 }
 
 void fdmon_io_uring_destroy(AioContext *ctx)
</pre>
    </blockquote>
    <lt-container></lt-container>
  </body>
</html>

--------------uHkLPvmu8skt0mKNUTH8wScJ--

