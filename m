Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0056CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUNc-0002O6-0G; Tue, 19 Aug 2025 18:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoUNa-0002NU-9o; Tue, 19 Aug 2025 18:00:30 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoUNX-000208-Tl; Tue, 19 Aug 2025 18:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ZekTRE5bCeFhCoOBNksaxf3SH0BpB4kCZ+W36yVylRo=; b=gtfRRthmHgMe6Rcj
 toAWtlktxReLX5PuIXMr/z7Twj7xvC+yfOmO5nrpt+skcuDn1u5YLwbBGu/PQmU2nw60+awGmTe0M
 7iNcOeyjOqMBkYAiSVMrFaDMRgAsosCs7z48RLH+AkOjLWVWesubF6+P49uRrLoHrDHpESTMFmuro
 U18w9sSoxAuPe1rgqAXAmkDiBlUzaUcxujaPig6xPVDV4nHN+lGPlEb8AROlcfHXM9Wb2aol2Ju2a
 JpewcSQd89shBmeq1gf+ea23KOeyRm7oMwh3hMGfCUNBGuYpcVn5hLZxk0AUjfcbJrZcGg1prBJYP
 ulNKYWrut22mto0C4A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uoUNP-0055ba-0v;
 Tue, 19 Aug 2025 22:00:19 +0000
Date: Tue, 19 Aug 2025 22:00:19 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/12] system: unconditionally enable thread naming
Message-ID: <aKTz83RUDPHMjDE9@gallifrey>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819202708.1185594-4-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 21:59:20 up 114 days,  6:12,  1 user,  load average: 0.11, 0.05, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> When thread naming was introduced years ago, it was disabled by
> default and put behind a command line flag:
> 
>   commit 8f480de0c91a18d550721f8d9af969ebfbda0793
>   Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   Date:   Thu Jan 30 10:20:31 2014 +0000
> 
>     Add 'debug-threads' suboption to --name
> 
> This was done based on a concern that something might depend
> on the historical thread naming. Thread names, however, were
> never promised to be part of QEMU's public API. The defaults
> will vary across platforms, so no assumptions should ever be
> made about naming.

Ah finally!

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> An opt-in behaviour is also unfortunately incompatible with
> RCU which creates its thread from an constructor function
> which is run before command line args are parsed. Thus the
> RCU thread lacks any name.
> 
> libvirt has unconditionally enabled debug-threads=yes on all
> VMs it creates for 10 years. Interestingly this DID expose a
> bug in libvirt, as it parsed /proc/$PID/stat and could not
> cope with a space in the thread name. This was a latent
> pre-existing bug in libvirt though, and not a part of QEMU's
> API.
> 
> Having thread names always available, will allow thread names
> to be included in error reports and log messags QEMU prints
> by default, which will improve ability to triage QEMU bugs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  include/qemu/thread.h     |  1 -
>  system/vl.c               | 11 ++++++-----
>  util/qemu-thread-posix.c  | 18 +-----------------
>  util/qemu-thread-win32.c  | 27 ++++++---------------------
>  5 files changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..bd6f865558 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -81,6 +81,13 @@ kernel since 2001. None of the board types QEMU supports need
>  ``param_struct`` support, so this option has been deprecated and will
>  be removed in a future QEMU version.
>  
> +``debug-threads`` option for ``-name``
> +''''''''''''''''''''''''''''''''''''''
> +
> +Thread ``debug-threads`` option for the ``-name`` argument is now
> +ignored. Thread naming is unconditionally enabled for all platforms
> +where it is supported.
> +
>  User-mode emulator command line arguments
>  -----------------------------------------
>  
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index f0302ed01f..3a286bb3ef 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,7 +215,6 @@ void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> -void qemu_thread_naming(bool enable);
>  
>  struct Notifier;
>  /**
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..a64fd90d4a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -403,9 +403,7 @@ static QemuOptsList qemu_name_opts = {
>          }, {
>              .name = "debug-threads",
>              .type = QEMU_OPT_BOOL,
> -            .help = "When enabled, name the individual threads; defaults off.\n"
> -                    "NOTE: The thread names are for debugging and not a\n"
> -                    "stable API.",
> +            .help = "DEPRECATED: thread names are always set where supported",
>          },
>          { /* End of list */ }
>      },
> @@ -554,9 +552,12 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      const char *proc_name;
>  
> -    if (qemu_opt_get(opts, "debug-threads")) {
> -        qemu_thread_naming(qemu_opt_get_bool(opts, "debug-threads", false));
> +    if (qemu_opt_get(opts, "debug-threads") &&
> +        !qemu_opt_get_bool(opts, "debug-threads", false)) {
> +        fprintf(stderr, "Ignoring deprecated 'debug-threads=no' option, " \
> +                "thread naming is unconditionally enabled\n");
>      }
> +
>      qemu_name = qemu_opt_get(opts, "guest");
>  
>      proc_name = qemu_opt_get(opts, "process");
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index ba725444ba..7c985b5d38 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -22,22 +22,6 @@
>  #include <pthread_np.h>
>  #endif
>  
> -static bool name_threads;
> -
> -void qemu_thread_naming(bool enable)
> -{
> -    name_threads = enable;
> -
> -#if !defined CONFIG_PTHREAD_SETNAME_NP_W_TID && \
> -    !defined CONFIG_PTHREAD_SETNAME_NP_WO_TID && \
> -    !defined CONFIG_PTHREAD_SET_NAME_NP
> -    /* This is a debugging option, not fatal */
> -    if (enable) {
> -        fprintf(stderr, "qemu: thread naming not supported on this host\n");
> -    }
> -#endif
> -}
> -
>  static void error_exit(int err, const char *msg)
>  {
>      fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> @@ -361,7 +345,7 @@ static void *qemu_thread_start(void *args)
>      /* Attempt to set the threads name; note that this is for debug, so
>       * we're not going to fail if we can't set it.
>       */
> -    if (name_threads && qemu_thread_args->name) {
> +    if (qemu_thread_args->name) {
>  # if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
>          pthread_setname_np(pthread_self(), qemu_thread_args->name);
>  # elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index ca2e0b512e..9595a5b090 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -17,8 +17,6 @@
>  #include "qemu-thread-common.h"
>  #include <process.h>
>  
> -static bool name_threads;
> -
>  typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
>                                                   PCWSTR lpThreadDescription);
>  static pSetThreadDescription SetThreadDescriptionFunc;
> @@ -44,16 +42,6 @@ static bool load_set_thread_description(void)
>      return !!SetThreadDescriptionFunc;
>  }
>  
> -void qemu_thread_naming(bool enable)
> -{
> -    name_threads = enable;
> -
> -    if (enable && !load_set_thread_description()) {
> -        fprintf(stderr, "qemu: thread naming not supported on this host\n");
> -        name_threads = false;
> -    }
> -}
> -
>  static void error_exit(int err, const char *msg)
>  {
>      char *pstr;
> @@ -328,23 +316,20 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>  
> -static bool set_thread_description(HANDLE h, const char *name)
> +static void set_thread_description(HANDLE h, const char *name)
>  {
> -    HRESULT hr;
>      g_autofree wchar_t *namew = NULL;
>  
>      if (!load_set_thread_description()) {
> -        return false;
> +        return;
>      }
>  
>      namew = g_utf8_to_utf16(name, -1, NULL, NULL, NULL);
>      if (!namew) {
> -        return false;
> +        return;
>      }
>  
> -    hr = SetThreadDescriptionFunc(h, namew);
> -
> -    return SUCCEEDED(hr);
> +    SetThreadDescriptionFunc(h, namew);
>  }
>  
>  void qemu_thread_create(QemuThread *thread, const char *name,
> @@ -370,8 +355,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      if (!hThread) {
>          error_exit(GetLastError(), __func__);
>      }
> -    if (name_threads && name && !set_thread_description(hThread, name)) {
> -        fprintf(stderr, "qemu: failed to set thread description: %s\n", name);
> +    if (name) {
> +        set_thread_description(hThread, name);
>      }
>      CloseHandle(hThread);
>  
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

