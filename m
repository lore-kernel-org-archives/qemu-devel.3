Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A320CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0dn-0000OC-V2; Tue, 09 Sep 2025 11:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0dk-0000N3-GB
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0dJ-0007EH-MC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757433102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G/ZwhD66N9u6PzjZ8WHJ2caDZqN+md0v4rrL3PDWG+8=;
 b=GWzBDWHzLledvDj0nlgGCQc7yFWODh9kwqR0UlyHCUBiUtGJsuO9OhQ5rEwEdpFX/HBRak
 EebwLU/wnoa9TvCqeGREyswdeMRLdb8YK/36fnmDrFNWM1KWOEFemqHx+6307shz5m1Qa6
 G3mLJ4vVo8aqdlSvqa3M1JePrclDqDE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-rByN_Q-fOmOQnaFaB-StqQ-1; Tue, 09 Sep 2025 11:51:41 -0400
X-MC-Unique: rByN_Q-fOmOQnaFaB-StqQ-1
X-Mimecast-MFC-AGG-ID: rByN_Q-fOmOQnaFaB-StqQ_1757433100
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-72048b6e865so118589286d6.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 08:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757433100; x=1758037900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/ZwhD66N9u6PzjZ8WHJ2caDZqN+md0v4rrL3PDWG+8=;
 b=NsmLE2dGltu9OCr5XLoEalAuBXwYYmFUonnNNmsEbTy1xpWLu7jqsrpicBuM0nYnMD
 5x7lHLzN5x4movBa1+PwsRZun4DCOxVROytn/cED4yOGuEhUbq7Veldpa08Fh/dPW5Vu
 m6Sy2CrHlkKBcrQzZ22usaUHCe0JkMunM1W4EIp3WGIqbz7pnQ907xVi3WE9s9AkkEVk
 JfWjXjccWX53KN5jvZpLg2gLUHFnbs0suVPUy8pTf4VqInr66c0UMxokyCTvunOtl5F+
 D4WIw2PqCrSnViWo5oSx5CBUoXWTc6RSH9ch7lCkkZYJM7XDHkyNwRxTG1X8mULLHcHZ
 rycA==
X-Gm-Message-State: AOJu0YwbFBEQIrcMsryyGSqsOmJ77TfYQkrQ0jhX1W4xKzi+dvN3rEBA
 es5kuTNY5RUyVqFy2BkXDrvAuxGryrrSYoelEL7+dIvbvXoMMrZvUczSdRKQz5LvNkCiWfck961
 HFYO9wv5vu5/KK6De8Ud83C3ZoLT9qror/Bzblipsch1GiyuR/fqNnVJg
X-Gm-Gg: ASbGncuOlBAmX6HEjM2xqk6Xs0GX6XkD2j8PdiwPwOtHFmR6K8/RqIBBPh7sej4nndM
 MMFuZ+AlGjVxmIvERdVfvncw0Jba2/IhHv4bawdIe7I2mUSbYDrzqox5uJ0OxDJMFUd75m05/FZ
 +EYKBICd+3ZbRbmYcN7azElbN57/yMZqV5nrb1ed+wZSK6ZqteqF/VHcqWdavU7cTJaxUkpjrD8
 ER2QR0c2mfMn3Z7NP6zYNT3r0LYGu8l4Doknk85QsG2fZgNFP1AubqjXnzvWJpXSB7w0CRxDgYY
 ayRarLk6Zt7Tp6B+H88CQ8C5Q98exmQ/lkUDgLOYld7j6oY4EXnSmyj1WB/ORIR/Jqzeu/69DdM
 2/+JayjnBzB7tmZ41QEI8RA==
X-Received: by 2002:a05:6214:29ee:b0:727:9f8a:8f2b with SMTP id
 6a1803df08f44-73921b3c86bmr147816186d6.18.1757433100437; 
 Tue, 09 Sep 2025 08:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQoKdBaIsDfoEgNfPBmRRrYAyBNXRN+JPsFvlgszIkAj3UjqDvJqg8fT9IC3X/Wex/6LrlCw==
X-Received: by 2002:a05:6214:29ee:b0:727:9f8a:8f2b with SMTP id
 6a1803df08f44-73921b3c86bmr147814126d6.18.1757433099662; 
 Tue, 09 Sep 2025 08:51:39 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720ac16e418sm144697286d6.4.2025.09.09.08.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:51:39 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:51:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 4/9] vl: helper to request exec
Message-ID: <aMBNCUXuMzxUToff@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 10:17:18AM -0700, Steve Sistare wrote:
> Add a qemu_system_exec_request() hook that causes the main loop to exit and
> exec a command using the specified arguments.  This will be used during CPR
> to exec a new version of QEMU.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/system/runstate.h |  3 +++
>  system/runstate.c         | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/system/runstate.h b/include/system/runstate.h
> index 929379a..c005f49 100644
> --- a/include/system/runstate.h
> +++ b/include/system/runstate.h
> @@ -128,6 +128,8 @@ typedef enum WakeupReason {
>      QEMU_WAKEUP_REASON_OTHER,
>  } WakeupReason;
>  
> +typedef void (*qemu_exec_func)(char **exec_argv);
> +
>  void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
> @@ -139,6 +141,7 @@ void qemu_register_wakeup_support(void);
>  void qemu_system_shutdown_request_with_code(ShutdownCause reason,
>                                              int exit_code);
>  void qemu_system_shutdown_request(ShutdownCause reason);
> +void qemu_system_exec_request(qemu_exec_func func, const strList *args);
>  void qemu_system_powerdown_request(void);
>  void qemu_register_powerdown_notifier(Notifier *notifier);
>  void qemu_register_shutdown_notifier(Notifier *notifier);
> diff --git a/system/runstate.c b/system/runstate.c
> index 6178b00..b4980ff 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -41,6 +41,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-run-state.h"
>  #include "qapi/qapi-events-run-state.h"
> +#include "qapi/type-helpers.h"
>  #include "qemu/accel.h"
>  #include "qemu/error-report.h"
>  #include "qemu/job.h"
> @@ -422,6 +423,8 @@ static NotifierList wakeup_notifiers =
>  static NotifierList shutdown_notifiers =
>      NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
>  static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
> +qemu_exec_func exec_func;
> +static char **exec_argv;
>  
>  ShutdownCause qemu_shutdown_requested_get(void)
>  {
> @@ -443,6 +446,11 @@ static int qemu_shutdown_requested(void)
>      return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
>  }
>  
> +static int qemu_exec_requested(void)
> +{
> +    return exec_argv != NULL;
> +}
> +
>  static void qemu_kill_report(void)
>  {
>      if (!qtest_driver() && shutdown_signal) {
> @@ -803,6 +811,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
>      qemu_notify_event();
>  }
>  
> +static void qemu_system_exec(void)
> +{
> +    exec_func(exec_argv);
> +
> +    /* exec failed */
> +    g_strfreev(exec_argv);
> +    exec_argv = NULL;
> +    exec_func = NULL;

Would this really happen?

If so, do we at least want to dump something?

> +}
> +
> +void qemu_system_exec_request(qemu_exec_func func, const strList *args)
> +{
> +    exec_func = func;
> +    exec_argv = strv_from_str_list(args);
> +    qemu_notify_event();
> +}
> +
>  static void qemu_system_powerdown(void)
>  {
>      qapi_event_send_powerdown();
> @@ -849,6 +874,10 @@ static bool main_loop_should_exit(int *status)
>      if (qemu_suspend_requested()) {
>          qemu_system_suspend();
>      }
> +    if (qemu_exec_requested()) {
> +        qemu_system_exec();
> +        return false;
> +    }

Some explanation of why it needs to be done explicitly here would be
helpful.  E.g., can we do exec inside a BH scheduled for the main thread?
What if we exec() directly in another thread (rather than the main loop
thread)?

>      request = qemu_shutdown_requested();
>      if (request) {
>          qemu_kill_report();
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


