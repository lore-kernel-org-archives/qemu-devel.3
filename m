Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9CDCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 20:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwntS-00054M-BK; Thu, 11 Sep 2025 16:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwntP-00053d-6O; Thu, 11 Sep 2025 16:27:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwntM-0000TS-BG; Thu, 11 Sep 2025 16:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Sif3muZR8+GGi2HhISFxgaNnVigEZam3ukk+56tOQH0=; b=AVLWgyiVS5KzZO+m
 Wfd7qIv79ehr9na8tObZoTmGY2ceUZIgjrKNBC6UzScv0BAPVVELL1eCr9b7CU0uKhiZpwqaNXnda
 DnQkjaytTj8QiHKQ5NJj2OEX65MPau90WAa/F8Aj4sSMnjGiSlTYi5vkEwETpdHwZjlReqQRmduEd
 yvgzd0451KTVKeGU7cV2hW4i8arbPkosjFBgzcM84dNDLI02HLx7ntdXFlb7YFczE0BLdox2pOJq9
 rAxV741J2TQ5i2dOctuR2myUmcnHm2KNl0++nlF187kmxBUdbwBfEkERo42CgLMYt1j2ful/iLf60
 wV/p4n6EjY6w43x4sw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uwntI-00AV17-0C;
 Thu, 11 Sep 2025 20:27:36 +0000
Date: Thu, 11 Sep 2025 20:27:36 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 17/20] util: add support for formatting a workload
 name in messages
Message-ID: <aMMwuEqguq62FZhU@gallifrey>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-18-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910180357.320297-18-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:25:58 up 137 days,  4:39,  1 user,  load average: 0.10, 0.03, 0.01
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
> The error_report function can include the guest name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
> 
> This introduces support for a "workload name" in the new
> messages API, which in the case of system emulators will
> be the guest name. The possibility of defining a workload
> name for other binaries is left as an exercise for the
> future.
> 
> This change has no impact on the output of the error_report
> function, but will change the qemu_log function. This can
> be easily seen with the 'log' trace backend, and how it is
> now more closely matching error_report output.
> 
> Before:
> 
>   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>   qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>   qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>   blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>   blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Are you going to want to escape that? I see later you're adding []'s around it,
which makes it feel like you want to end up with it parsable, but if some nasty
person does:

-name ']})🐧({['

then things get confusing; I guess you're hoping that whoever calls qemu will
be careful not to allow that.

Dave

> ---
>  include/qemu/error-report.h |  3 ---
>  include/qemu/message.h      | 10 ++++++++++
>  system/vl.c                 |  6 ++++--
>  util/error-report.c         |  7 -------
>  util/message.c              | 12 +++++++++++-
>  5 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index c8000778ec..ffc305f828 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -70,7 +70,4 @@ void error_init(const char *argv0);
>                                fmt, ##__VA_ARGS__);      \
>      })
>  
> -extern bool error_with_guestname;
> -extern const char *error_guest_name;
> -
>  #endif
> diff --git a/include/qemu/message.h b/include/qemu/message.h
> index 0a06421f77..cfc3c92648 100644
> --- a/include/qemu/message.h
> +++ b/include/qemu/message.h
> @@ -5,6 +5,7 @@
>  
>  enum QMessageFormatFlags {
>      QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
> +    QMESSAGE_FORMAT_WORKLOAD_NAME = (1 << 1),
>  };
>  
>  /**
> @@ -16,6 +17,15 @@ enum QMessageFormatFlags {
>   */
>  void qmessage_set_format(int flags);
>  
> +/**
> + * qmessage_set_workload_name:
> + * @name: the name of the workload
> + *
> + * Set the workload name, which for a system emulator
> + * will be the guest VM name.
> + */
> +void qmessage_set_workload_name(const char *name);
> +
>  /**
>   * qmessage_context_print:
>   * @fp: file to emit the prefix on
> diff --git a/system/vl.c b/system/vl.c
> index 696dd92669..fee6fdf7b1 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -818,7 +818,9 @@ static void configure_msg(QemuOpts *opts)
>      if (qemu_opt_get_bool(opts, "timestamp", false)) {
>          flags |= QMESSAGE_FORMAT_TIMESTAMP;
>      }
> -    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
> +    if (qemu_opt_get_bool(opts, "guest-name", false)) {
> +        flags |= QMESSAGE_FORMAT_WORKLOAD_NAME;
> +    }
>      qmessage_set_format(flags);
>  }
>  
> @@ -3520,7 +3522,7 @@ void qemu_init(int argc, char **argv)
>                      exit(1);
>                  }
>                  /* Capture guest name if -msg guest-name is used later */
> -                error_guest_name = qemu_opt_get(opts, "guest");
> +                qmessage_set_workload_name(qemu_opt_get(opts, "guest"));
>                  break;
>              case QEMU_OPTION_prom_env:
>                  if (nb_prom_envs >= MAX_PROM_ENVS) {
> diff --git a/util/error-report.c b/util/error-report.c
> index 719f059494..c40cdf3bb3 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -25,8 +25,6 @@ typedef enum {
>      REPORT_TYPE_INFO,
>  } report_type;
>  
> -bool error_with_guestname;
> -const char *error_guest_name;
>  
>  typedef void (*error_print_func)(void *opaque, const char *fmt, ...);
>  typedef void (*error_print_vfunc)(void *opaque, const char *fmt, va_list ap);
> @@ -218,11 +216,6 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>          qmessage_context_print(stderr);
>      }
>  
> -    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> -    if (error_with_guestname && error_guest_name && !cur) {
> -        print_func(print_opaque, "%s ", error_guest_name);
> -    }
> -
>      print_loc(!!cur, print_func, print_opaque);
>  
>      switch (type) {
> diff --git a/util/message.c b/util/message.c
> index ef70e08c5f..a91c008e08 100644
> --- a/util/message.c
> +++ b/util/message.c
> @@ -6,18 +6,28 @@
>  #include "monitor/monitor.h"
>  
>  static int message_format;
> +static char *message_workloadname;
>  
>  void qmessage_set_format(int flags)
>  {
>      message_format = flags;
>  }
>  
> -void qmessage_context_print(FILE *fp)
> +void qmessage_set_workload_name(const char *name)
>  {
> +    message_workloadname = g_strdup(name);
> +}
>  
> +void qmessage_context_print(FILE *fp)
> +{
>      if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
>          g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>          g_autofree char *timestr = g_date_time_format_iso8601(dt);
>          fprintf(fp, "%s ", timestr);
>      }
> +
> +    if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
> +        message_workloadname) {
> +        fprintf(fp, "%s ", message_workloadname);
> +    }
>  }
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

