Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308D0C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVUI-0006co-VI; Mon, 24 Aug 2026 10:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVUG-0006cU-NX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVUD-00073o-Kw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787581035;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Un9M8tppQEOg+zg2JA8jhs9hpLxvQP54RTbFcD4X+2M=;
 b=Y8xcazYYk0de8cxA1hfFraTeivkg67dcQDcCTRKT/isc36yDxaVlbhNv8MxhFA/3GL5c/6
 V7SIIgFXxhuypEnitZJveiTz2qflOZLt5KU5cMurywbfOhXnvygl0v0EwpEVTQhT5ksEYP
 qFTCPhPqHG9Knuy2zcaDDzcR/p8K8z8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-FglxZFygP0y1brEdUXZkbA-1; Mon,
 24 Aug 2026 10:17:12 -0400
X-MC-Unique: FglxZFygP0y1brEdUXZkbA-1
X-Mimecast-MFC-AGG-ID: FglxZFygP0y1brEdUXZkbA_1787581031
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 349F81955DD6; Mon, 24 Aug 2026 14:17:11 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B74997D9; Mon, 24 Aug 2026 14:17:09 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:17:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 35/49] error-report: switch to use monitor_cur_hmp()
Message-ID: <aoxSYsbavuGtwCUO@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-35-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-35-e53fc35bc550@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 16, 2026 at 11:13:02PM +0400, Marc-André Lureau wrote:
> Instead of passing a Monitor pointer through error_vprintf_mon() and
> error_printf_mon(), call monitor_cur_hmp() directly. This removes the
> monitor parameter from the internal helpers and the manual
> object_dynamic_cast() in vreport().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  util/error-report.c | 72 +++++++++++++++++++++++++----------------------------
>  1 file changed, 34 insertions(+), 38 deletions(-)
> 
> diff --git a/util/error-report.c b/util/error-report.c
> index aaa15bc79827..70cbd174ffae 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -30,34 +30,31 @@ bool error_with_guestname;
>  const char *error_guest_name;
>  
>  /*
> - * Print to the current human monitor if we have one, else to stderr.
> + * Print to the current HMP monitor if we have one, else to stderr.
>   */
> -static int G_GNUC_PRINTF(2, 0)
> -error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
> +static int G_GNUC_PRINTF(1, 0)
> +error_vprintf_mon(const char *fmt, va_list ap)

Please don't remove this 'cur_mon' parameter.

>  {
> -    /*
> -     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> -     * IOW this will only print if in HMP, otherwise we
> -     * fallback to stderr for QMP / no-monitor scenarios.
> -     */
> -    int ret = monitor_vprintf(cur_mon, fmt, ap);
> -    if (ret == -1) {
> -        ret = vfprintf(stderr, fmt, ap);
> +    MonitorHMP *hmp = monitor_cur_hmp();

This calls qemu_mutex_lock/unlock, which have trace points.
As a result if you have 'log' tracing enabled, error messages
will get trace point output splattered on top.

We must fetch monitor_cur_hmp once only at the top of
vreport() and never query it again.


> +
> +    if (hmp) {
> +        return monitor_vprintf(MONITOR(hmp), fmt, ap);
>      }
> -    return ret;
> +
> +    return vfprintf(stderr, fmt, ap);
>  }
>  
>  /*
> - * Print to the current human monitor if we have one, else to stderr.
> + * Print to the current HMP monitor if we have one, else to stderr.
>   */
> -static int G_GNUC_PRINTF(2, 3)
> -error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
> +static int G_GNUC_PRINTF(1, 2)
> +error_printf_mon(const char *fmt, ...)
>  {
>      va_list ap;
>      int ret;
>  
>      va_start(ap, fmt);
> -    ret = error_vprintf_mon(cur_mon, fmt, ap);
> +    ret = error_vprintf_mon(fmt, ap);
>      va_end(ap);
>      return ret;
>  }
> @@ -67,7 +64,7 @@ error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
>   */
>  int error_vprintf(const char *fmt, va_list ap)
>  {
> -    return error_vprintf_mon(monitor_cur(), fmt, ap);
> +    return error_vprintf_mon(fmt, ap);
>  }
>  
>  /*
> @@ -79,7 +76,7 @@ int error_printf(const char *fmt, ...)
>      int ret;
>  
>      va_start(ap, fmt);
> -    ret = error_vprintf_mon(monitor_cur(), fmt, ap);
> +    ret = error_vprintf_mon(fmt, ap);
>      va_end(ap);
>      return ret;
>  }
> @@ -183,13 +180,13 @@ void loc_set_file(const char *fname, int lno)
>   * Print current location to current HMP monitor if we have one, else
>   * to stderr.
>   */
> -static void print_loc(Monitor *cur)
> +static void print_loc(MonitorHMP *hmp)
>  {
>      const char *sep = "";
>      int i;
>      const char *const *argp;
>  
> -    if (!cur && g_get_prgname()) {
> +    if (!hmp && g_get_prgname()) {
>          fprintf(stderr, "%s:", g_get_prgname());
>          sep = " ";
>      }
> @@ -197,20 +194,20 @@ static void print_loc(Monitor *cur)
>      case LOC_CMDLINE:
>          argp = cur_loc->ptr;
>          for (i = 0; i < cur_loc->num; i++) {
> -            error_printf_mon(cur, "%s%s", sep, argp[i]);
> +            error_printf_mon("%s%s", sep, argp[i]);
>              sep = " ";
>          }
> -        error_printf_mon(cur, ": ");
> +        error_printf_mon(": ");
>          break;
>      case LOC_FILE:
> -        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
> +        error_printf_mon("%s:", (const char *)cur_loc->ptr);
>          if (cur_loc->num) {
> -            error_printf_mon(cur, "%d:", cur_loc->num);
> +            error_printf_mon("%d:", cur_loc->num);
>          }
> -        error_printf_mon(cur, " ");
> +        error_printf_mon(" ");
>          break;
>      default:
> -        error_printf_mon(cur, "%s", sep);
> +        error_printf_mon("%s", sep);
>      }
>  }
>  
> @@ -233,45 +230,44 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>  {
>      /*
>       * When current monitor is QMP, messages must go to stderr
> -     * and have prefixes added, so we cast to HMP, leaving 'cur'
> +     * and have prefixes added, so we cast to HMP, leaving 'hmp'
>       * as NULL in QMP case
>       */

The comment talks about a cast hwich no longer exists here.

     /*
      * When current monitor is QMP, messages must go to stderr
      * and have prefixes added, so only need MonitorHMP here
      * not the parent Monitor.
      */

> -    Monitor *cur = MONITOR(
> -        object_dynamic_cast(OBJECT(monitor_cur()), TYPE_MONITOR_HMP));
> +    MonitorHMP *hmp = monitor_cur_hmp();
>      gchar *timestr;
>  
> -    if (!cur) {
> +    if (!hmp) {
>          qemu_flockfile(stderr);
>      }
>  
> -    if (message_with_timestamp && !cur) {
> +    if (message_with_timestamp && !hmp) {
>          timestr = real_time_iso8601();
>          fprintf(stderr, "%s ", timestr);
>          g_free(timestr);
>      }
>  
>      /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> -    if (error_with_guestname && error_guest_name && !cur) {
> +    if (error_with_guestname && error_guest_name && !hmp) {
>          fprintf(stderr, "%s ", error_guest_name);
>      }
>  
> -    print_loc(cur);
> +    print_loc(hmp);
>  
>      switch (type) {
>      case REPORT_TYPE_ERROR:
>          break;
>      case REPORT_TYPE_WARNING:
> -        error_printf_mon(cur, "warning: ");
> +        error_printf_mon("warning: ");
>          break;
>      case REPORT_TYPE_INFO:
> -        error_printf_mon(cur, "info: ");
> +        error_printf_mon("info: ");
>          break;
>      }
>  
> -    error_vprintf_mon(cur, fmt, ap);
> -    error_printf_mon(cur, "\n");
> +    error_vprintf_mon(fmt, ap);
> +    error_printf_mon("\n");
>  
> -    if (!cur) {
> +    if (!hmp) {
>          qemu_funlockfile(stderr);
>      }
>  }
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


