Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C471CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 23:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwU79-0001FS-MD; Wed, 10 Sep 2025 19:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwU77-0001Ek-VL; Wed, 10 Sep 2025 19:20:34 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwU76-0007o2-0O; Wed, 10 Sep 2025 19:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=V05Fo7ANJnDC5ZX+NUXYakZRAff5C+IuhRx9RHiUqNI=; b=deOENFPXh98zq6k+
 jIhdMYW6EyO4NBofUNDCY5jaiJsom+ZM2jqZ/CIXWkToF9dfXlqsi3B9S+V90bmDo0zJPbQleJlcV
 QFZoHgJaUc4Xr2D8bxMklkpEhAsDFrj0oQr/Jt0wooabxYYDYqGFa88sGD0Ag7Y44qnGMtIju0suD
 Vka+ZYNV4m1jmqfGxehGv+hL2B/nQjlxEdTiolpXMdWLY7Asoa+r1Rf1HcKFIaXP9GOf2pUNCdcad
 XiMYtrvEUvVmy2ZnCjdT0n/ef9kz2eaU+nAP4nggRFMOyOtZ8z4eAbybjImVrN5SszlH+6Fu6ao1T
 1adzrnCo+DVURc+u9Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uwU70-00A37P-1Y;
 Wed, 10 Sep 2025 23:20:26 +0000
Date: Wed, 10 Sep 2025 23:20:26 +0000
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
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aMIHuolKr68TkRVn@gallifrey>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910180357.320297-9-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:20:19 up 136 days,  7:33,  1 user,  load average: 0.00, 0.00, 0.00
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
> Some code makes multiple qemu_log calls to incrementally emit
> a single message. Currently timestamps get prepended to all
> qemu_log calls, even those continuing a previous incomplete
> message.
> 
> This changes the qemu_log so it skips adding a new line prefix,
> if the previous qemu_log call did NOT end with a newline.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  util/log.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/util/log.c b/util/log.c
> index abdcb6b311..2642a55c59 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
>      }
>  }
>  
> +/*
> + * 'true' if the previous log message lacked a trailing '\n',
> + * and thus the subsequent call must skip any prefix
> + */
> +static __thread bool incomplete;
> +
>  void qemu_log(const char *fmt, ...)
>  {
>      FILE *f;
> @@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
>       * was emitted if we are delayed acquiring the
>       * mutex
>       */
> -    if (message_with_timestamp) {
> +    if (message_with_timestamp && !incomplete) {
>          g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>          timestr = g_date_time_format_iso8601(dt);
>      }
> @@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
>          va_start(ap, fmt);
>          vfprintf(f, fmt, ap);
>          va_end(ap);
> +        incomplete = fmt[strlen(fmt) - 1] != '\n';
>          qemu_log_unlock(f);
>      }
>  }
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

