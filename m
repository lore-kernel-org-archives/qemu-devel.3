Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D69EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDmP-0002qF-BP; Mon, 02 Jun 2025 18:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uMDmM-0002ox-SR; Mon, 02 Jun 2025 18:37:14 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uMDmK-0004t5-Ke; Mon, 02 Jun 2025 18:37:14 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7d09ab17244so502425985a.0; 
 Mon, 02 Jun 2025 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748903831; x=1749508631; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXsTHYB45FBW5fcX6Dw1m3y5f/LMQEL2rFzLAIwuwv8=;
 b=c+ww/Xa2Io4ztIP8Pk7x5/dj2Ri1VNOywWjZCNhriNY2Fyst3TGxvcL4XWSaFd15TV
 2I4U/8xdmJCgbxIYTIu2aTRCzoUIZSUNiUkbiduAmSL5FME3lEEmskW2PgweozXnbeTH
 Vnv5ek3DfDxlVshTIkbWh4zO0uMo8zkob6WJVXkPaFjxRJ6d2Fh9qt8/UG48j7glgXWK
 XE+yjCC/OaA4htJhc6fKznpBigSLAoKlcApvla+n+hQWlWkgMknm2BeDKbcfbgXRotih
 52pzNXMSUAwrQnEcJ7PcyLYJX+G3nN/uissMEmdKf8YjsXlwMZqqdCgVdDkeMCSEG4pu
 qe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903831; x=1749508631;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CXsTHYB45FBW5fcX6Dw1m3y5f/LMQEL2rFzLAIwuwv8=;
 b=cgAkFsvd3thBm+iFibmm6VYDgq9VvsoQyDmN61Qvdqg2XdWHnEspBFdTGGflYKcmrA
 61LMlA8+4nxbUeq2illo9OQ66n1Byoj1h3DdBInzjC+9LPAFsQP4N2KCv+9yZ30SAzbR
 QkKmP9D9FfVzrxHL4vpQSTzApq7ra87fVmgNyuHWpiO+PFvJFERdiwflzH4/awCEk5gv
 SvsBJ32sn83GZbLs/fFQtAZIkszX5sFfyK7Autz4oxiXNIn+5WRX3aF3Zl6n87GTBqPa
 BjEY14qJofmFYdt37Le4TrSMFR575UtV4MpYmYmUwEvqJ2UKNWoQ5sIkJYRSy00HrKzQ
 aCUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyAg9CKMjHRAcMUIMXFRnYwXjyeG4G3qmWzTSUzCq0ADoytV8ENHp3Uh8AzCD0hXbFX7BPCG7ICnIx@nongnu.org
X-Gm-Message-State: AOJu0YzgvaDSDmuXKNAgvwyCisT1Ej4S8I8fdJM4N25rXa5mjajrFcv8
 AbeJfh61/fp6JKDoYb3dQt0JR/C0rvORd1eisG137SyTJB00ri/S1ru6
X-Gm-Gg: ASbGncs6Xym6iVCeBRiKquVGcBp7IGa72GKdfyLIj8reeJ1j2aDHoB+4q0SizMhk1GF
 4k/HXxpOylm3shAPrb29qOCtHwEt+TwDvLrf1KoMSUnwIXAqzt9stqc8kheVZHfYSMOkfa7AsK7
 lGQkJPDzugHoldbg9+as/zYnApcv4gie/TBmHuQfKS0h4HtD9wJpDjJdOFljPYQlMZW3gjbtQnU
 xRwxpv+VRFswfAyWRolHJ1mDKRVf+InmCQFBfhfDhNHSzFEVAJv4Mjo7o2fiNLNK0FBT/yypyVh
 CMxpSEgT/vFULjLMGnMJjoORDfDzCwKCrjkXogfBko0Eyy+LS1MYapQL/umfmuScELZ8kuLbouI
 KqqpjO801OesAHVJ0cwz//knyIe/RUNv82N+RLEnG6b0=
X-Google-Smtp-Source: AGHT+IE0hX0judTei4IMArjvGmvNPIvuOVBYEOCCd21NKUCTUlgyfmLtST9DTTOJkvysYH9ItcDEsg==
X-Received: by 2002:a05:620a:2629:b0:7c7:bb3f:fd40 with SMTP id
 af79cd13be357-7d0a49e799dmr2281958285a.5.1748903830809; 
 Mon, 02 Jun 2025 15:37:10 -0700 (PDT)
Received: from [10.36.159.1] (wn-campus-nat-129-97-124-1.dynamic.uwaterloo.ca.
 [129.97.124.1]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a1a790csm706197585a.96.2025.06.02.15.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 15:37:10 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------4GIw5tG90NEoPeEONcMejVeU"
Message-ID: <736d9b1a-af8f-404a-9fda-c44e8a4c6df3@gmail.com>
Date: Mon, 2 Jun 2025 18:37:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
 <a0a98436-5e4e-46d1-9a66-b6edce5c0ecc@gmail.com>
 <20250602202051.GE300284@fedora>
Content-Language: en-US
From: Brian <hibriansong@gmail.com>
In-Reply-To: <20250602202051.GE300284@fedora>
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x733.google.com
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
--------------4GIw5tG90NEoPeEONcMejVeU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/2/25 4:20 PM, Stefan Hajnoczi wrote:
> On Mon, Jun 02, 2025 at 08:26:39AM -0400, Brian wrote:
>> On 5/28/25 3:09 PM, Stefan Hajnoczi wrote:
>>> io_uring may not be available at runtime due to system policies (e.g.
>>> the io_uring_disabled sysctl) or creation could fail due to file
>>> descriptor resource limits.
>>>
>>> Handle failure scenarios as follows:
>>>
>>> If another AioContext already has io_uring, then fail AioContext
>>> creation so that the aio_add_sqe() API is available uniformly from all
>>> QEMU threads. Otherwise fall back to epoll(7) if io_uring is
>>> unavailable.
>>>
>>> Notes:
>>> - Update the comment about selecting the fastest fdmon implementation.
>>>     At this point it's not about speed anymore, it's about aio_add_sqe()
>>>     API availability.
>>> - Uppercase the error message when converting from error_report() to
>>>     error_setg_errno() for consistency (but there are instances of
>>>     lowercase in the codebase).
>>> - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
>>>
>>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>>> ---
>>>    util/aio-posix.h      | 12 ++----------
>>>    util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
>>>    util/fdmon-io_uring.c |  8 ++++----
>>>    3 files changed, 32 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/util/aio-posix.h b/util/aio-posix.h
>>> index f9994ed79e..6f9d97d866 100644
>>> --- a/util/aio-posix.h
>>> +++ b/util/aio-posix.h
>>> @@ -18,6 +18,7 @@
>>>    #define AIO_POSIX_H
>>>    #include "block/aio.h"
>>> +#include "qapi/error.h" struct AioHandler { GPollFD pfd; @@ -72,17
>>> +73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx) #endif
>>> /* !CONFIG_EPOLL_CREATE1 */ #ifdef CONFIG_LINUX_IO_URING -bool
>>> fdmon_io_uring_setup(AioContext *ctx); +void
>>> fdmon_io_uring_setup(AioContext *ctx, Error **errp); void
>>> fdmon_io_uring_destroy(AioContext *ctx); -#else -static inline bool
>>> fdmon_io_uring_setup(AioContext *ctx) -{ - return false; -} - -static
>>> inline void fdmon_io_uring_destroy(AioContext *ctx) -{ -} #endif /*
>>> !CONFIG_LINUX_IO_URING */ #endif /* AIO_POSIX_H */ diff --git
>>> a/util/aio-posix.c b/util/aio-posix.c index fa047fc7ad..44b3df61f9
>>> 100644 --- a/util/aio-posix.c +++ b/util/aio-posix.c @@ -16,6 +16,7 @@
>>> #include "qemu/osdep.h"
>>>    #include "block/block.h"
>>>    #include "block/thread-pool.h"
>>> +#include "qapi/error.h"
>>>    #include "qemu/main-loop.h"
>>>    #include "qemu/lockcnt.h"
>>>    #include "qemu/rcu.h"
>>> @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **errp)
>>>        ctx->epollfd = -1;
>>>        ctx->epollfd_tag = NULL;
>>> -    /* Use the fastest fd monitoring implementation if available */
>>> -    if (fdmon_io_uring_setup(ctx)) {
>>> -        return;
>>> +#ifdef CONFIG_LINUX_IO_URING
>>> +    {
>>> +        static bool need_io_uring;
>>> +        Error *local_err = NULL; /* ERRP_GUARD() doesn't handle error_abort */
>>> +
>>> +        /* io_uring takes precedence because it provides aio_add_sqe() support */
>>> +        fdmon_io_uring_setup(ctx, &local_err);
>>> +        if (!local_err) {
>>> +            /*
>>> +             * If one AioContext gets io_uring, then all AioContexts need io_uring
>>> +             * so that aio_add_sqe() support is available across all threads.
>>> +             */
>>> +            need_io_uring = true;
>>> +            return;
>>> +        }
>>> +        if (need_io_uring) {
>>> +            error_propagate(errp, local_err);
>>> +            return;
>>> +        }
>>> +
>>> +        warn_report_err_once(local_err); /* frees local_err */
>>> +        local_err = NULL;
>>>        }
>>> +#endif /* CONFIG_LINUX_IO_URING */
>> Is there a problem with the logic of this code snippet?
>>
>> If we fail at fdmon_io_uring_setup, specifically at io_uring_queue_init,
>> local_err (or errp) will be set to a non-NULL error value. In that case,
>> need_io_uring will be set to true, but the function will return immediately.
> If local_err is non-NULL then this conditional is not taken:
>
>    if (!local_err) {
>        /*
>         * If one AioContext gets io_uring, then all AioContexts need io_uring
>         * so that aio_add_sqe() support is available across all threads.
>         */
>        need_io_uring = true;
>        return;
>    }
>
> If the logic you described is correct, please rephrase it. I don't see
> how what you've written can happen.

Sorry, I didn’t notice that need_io_uring is a static var. Was confused 
about when if (need_io_block) gets executed

>> As a result, the later if (need_io_uring) block will never be executed
>>
>>>        fdmon_epoll_setup(ctx);
>>>    }
>>>    void aio_context_destroy(AioContext *ctx)
>>>    {
>>> +#ifdef CONFIG_LINUX_IO_URING
>>>        fdmon_io_uring_destroy(ctx);
>>> +#endif
>>>        qemu_lockcnt_lock(&ctx->list_lock);
>>>        fdmon_epoll_disable(ctx);
>>> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
>>> index 2092d08d24..ef1a866a03 100644
>>> --- a/util/fdmon-io_uring.c
>>> +++ b/util/fdmon-io_uring.c
>>> @@ -45,6 +45,7 @@
>>>    #include "qemu/osdep.h"
>>>    #include <poll.h>
>>> +#include "qapi/error.h"
>>>    #include "qemu/rcu_queue.h"
>>>    #include "aio-posix.h"
>>> @@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops = {
>>>        .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
>>>    };
>>> -bool fdmon_io_uring_setup(AioContext *ctx)
>>> +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>>>    {
>>>        int ret;
>>> @@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
>>>        ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
>>>        if (ret != 0) {
>>> -        return false;
>>> +        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
>>> +        return;
>>>        }
>>>        QSLIST_INIT(&ctx->submit_list);
>>>        ctx->fdmon_ops = &fdmon_io_uring_ops;
>>>        ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
>>>                ctx->fdmon_io_uring.ring_fd, G_IO_IN);
>>> -
>>> -    return true;
>>>    }
>>>    void fdmon_io_uring_destroy(AioContext *ctx)
--------------4GIw5tG90NEoPeEONcMejVeU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/2/25 4:20 PM, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250602202051.GE300284@fedora">
      <pre wrap="" class="moz-quote-pre">On Mon, Jun 02, 2025 at 08:26:39AM -0400, Brian wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 5/28/25 3:09 PM, Stefan Hajnoczi wrote:
</pre>
        <blockquote type="cite">
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

Signed-off-by: Stefan Hajnoczi<a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
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
+#include "qapi/error.h" struct AioHandler { GPollFD pfd; @@ -72,17
+73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx) #endif
/* !CONFIG_EPOLL_CREATE1 */ #ifdef CONFIG_LINUX_IO_URING -bool
fdmon_io_uring_setup(AioContext *ctx); +void
fdmon_io_uring_setup(AioContext *ctx, Error **errp); void
fdmon_io_uring_destroy(AioContext *ctx); -#else -static inline bool
fdmon_io_uring_setup(AioContext *ctx) -{ - return false; -} - -static
inline void fdmon_io_uring_destroy(AioContext *ctx) -{ -} #endif /*
!CONFIG_LINUX_IO_URING */ #endif /* AIO_POSIX_H */ diff --git
a/util/aio-posix.c b/util/aio-posix.c index fa047fc7ad..44b3df61f9
100644 --- a/util/aio-posix.c +++ b/util/aio-posix.c @@ -16,6 +16,7 @@
#include "qemu/osdep.h"
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
        <pre wrap="" class="moz-quote-pre">Is there a problem with the logic of this code snippet?

If we fail at fdmon_io_uring_setup, specifically at io_uring_queue_init,
local_err (or errp) will be set to a non-NULL error value. In that case,
need_io_uring will be set to true, but the function will return immediately.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
If local_err is non-NULL then this conditional is not taken:

  if (!local_err) {
      /*
       * If one AioContext gets io_uring, then all AioContexts need io_uring
       * so that aio_add_sqe() support is available across all threads.
       */
      need_io_uring = true;
      return;
  }

If the logic you described is correct, please rephrase it. I don't see
how what you've written can happen.</pre>
    </blockquote>
    <p data-pm-slice="0 0 []">Sorry, I didn’t notice that need_io_uring
      is a static var. Was confused about when if (need_io_block) gets
      executed</p>
    <blockquote type="cite" cite="mid:20250602202051.GE300284@fedora">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">As a result, the later if (need_io_uring) block will never be executed

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">      fdmon_epoll_setup(ctx);
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
      </blockquote>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------4GIw5tG90NEoPeEONcMejVeU--

