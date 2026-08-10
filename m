Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DDDC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUqY-0004fJ-G5; Mon, 10 Aug 2026 14:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUqX-0004f3-ML
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUqV-0006sN-RO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLh6+UZySxLSn3FD1C+D/ubewyRU2G7cecVPnpBcCbQ=;
 b=bz440R2JLE1lQ+WEuqlP/xt7GeFpambTkS1rFv6uG6oKxyZt/NvXw0MTLWt4JUk4N7Jtt/
 phgdhTX6wXF0FcPp8l9BISdyIKYEm/61TmdlP+gO5ct/MypoWehX0aRWGRKEpJin31LVph
 c2SjgbzvVjqa0UDmxmbck2/cqnFyxXg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-wX7L-L_LN0K2_ODXj-Z1Mg-1; Mon,
 10 Aug 2026 14:34:57 -0400
X-MC-Unique: wX7L-L_LN0K2_ODXj-Z1Mg-1
X-Mimecast-MFC-AGG-ID: wX7L-L_LN0K2_ODXj-Z1Mg_1786386896
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88A6B193E887; Mon, 10 Aug 2026 18:34:17 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27CBD180034F; Mon, 10 Aug 2026 18:34:15 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:34:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 31/39] util: guard monitor_vprintf callers with
 CONFIG_HMP
Message-ID: <anoZpbLdNBtcUYbr@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-31-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-31-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 26, 2026 at 01:19:32AM +0400, Marc-André Lureau wrote:
> Guard calls to monitor_vprintf in error-report and qemu-print so
> they compile without HMP. When CONFIG_HMP is not set,
> error_vprintf_mon falls back directly to stderr and qemu_vfprintf
> returns -1 for NULL streams.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/unit/test-util-sockets.c | 4 +++-
>  tools/qemu-vnc/stubs.c         | 2 ++
>  util/error-report.c            | 8 +++++---
>  util/qemu-print.c              | 6 ++++++
>  4 files changed, 16 insertions(+), 4 deletions(-)

This patch probably isn't required any more.

With the QOM classes for montior,  monitor_vprintf calls to a 'vprintf'
class virtual method, or returns -1.

So simply by virtue of HMP being compiled out, monitor_vprintf should
do the right thing.

> 
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index b9f2453e299..23ebe1e26b5 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -73,8 +73,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>   */
>  Monitor *monitor_cur(void) { return cur_mon; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
>  bool monitor_cur_is_qmp(void) { abort(); };
> +#ifdef CONFIG_HMP
> +int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> +#endif
>  
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)
> diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
> index a865ce85f04..f476dd6d956 100644
> --- a/tools/qemu-vnc/stubs.c
> +++ b/tools/qemu-vnc/stubs.c
> @@ -46,10 +46,12 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return NULL;
>  }
>  
> +#ifdef CONFIG_HMP
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>  {
>      return -1;
>  }
> +#endif
>  
>  /*
>   * Link-time stubs for VMState symbols referenced by VNC code.
> diff --git a/util/error-report.c b/util/error-report.c
> index f832ad9b6b6..e2e46281455 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -40,11 +40,13 @@ error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
>       * IOW this will only print if in HMP, otherwise we
>       * fallback to stderr for QMP / no-monitor scenarios.
>       */
> +#ifdef CONFIG_HMP
>      int ret = monitor_vprintf(cur_mon, fmt, ap);
> -    if (ret == -1) {
> -        ret = vfprintf(stderr, fmt, ap);
> +    if (ret != -1) {
> +        return ret;
>      }
> -    return ret;
> +#endif
> +    return vfprintf(stderr, fmt, ap);
>  }
>  
>  /*
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index 7b9591035e5..ee80000722b 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -20,10 +20,12 @@
>   */
>  int qemu_vprintf(const char *fmt, va_list ap)
>  {
> +#ifdef CONFIG_HMP
>      Monitor *cur_mon = monitor_cur();
>      if (cur_mon) {
>          return monitor_vprintf(cur_mon, fmt, ap);
>      }
> +#endif
>      return vprintf(fmt, ap);
>  }
>  
> @@ -52,7 +54,11 @@ int qemu_printf(const char *fmt, ...)
>  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>  {
>      if (!stream) {
> +#ifdef CONFIG_HMP
>          return monitor_vprintf(monitor_cur(), fmt, ap);
> +#else
> +        return -1;
> +#endif
>      }
>      return vfprintf(stream, fmt, ap);
>  }
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


