Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D6D29FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfziA-0003Xc-73; Wed, 14 Jan 2026 07:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfzhY-0003Db-1e
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfzhU-0002Mc-5W
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768392611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3YNHk9Zjz+Oiqki5hI1dInqIc3oUUoBBmb2nxa6dWM=;
 b=MsxEPRe0NsyBgIwSHO+wWgNmT1ZOFxiZZOiJ7PoDl2ZpgkJ2EtuH1JgC8ZEODC6ovwGtcK
 mro2Dkski9OlSMFqcjz2GY5q+Z5gWJAMB/nVuAeV10P0v7CqVRocWklIw/s9t33/OS/eXp
 AOKT+X0GWcZbEa5NT9i2h55SQY1AT8w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-XMA8uAawM2OBKME9vkROtg-1; Wed,
 14 Jan 2026 07:10:07 -0500
X-MC-Unique: XMA8uAawM2OBKME9vkROtg-1
X-Mimecast-MFC-AGG-ID: XMA8uAawM2OBKME9vkROtg_1768392606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A51A01956094; Wed, 14 Jan 2026 12:10:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E12A30001A2; Wed, 14 Jan 2026 12:10:01 +0000 (UTC)
Date: Wed, 14 Jan 2026 12:09:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org,
 qemu-rust@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 14/24] monitor: move error_vprintf back to
 error-report.c
Message-ID: <aWeHlpz7m4hpPQCA@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-15-berrange@redhat.com>
 <87jyxl8wfo.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyxl8wfo.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 02:38:19PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The current unit tests rely on monitor.o not being linked, such
> > that the monitor stubs get linked instead. Since error_vprintf
> > is in monitor.o this allows a stub error_vprintf impl to be used
> > that calls g_test_message.
> >
> > This takes a different approach, with error_vprintf moving
> > back to error-report.c such that it is always linked into the
> > tests. The monitor_vprintf() stub is then changed to use
> > g_test_message if QTEST_SILENT_ERRORS is set, otherwise it will
> > return -1 and trigger error_vprintf to call vfprintf.
> >
> > The end result is functionally equivalent for the purposes of
> > the unit tests.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  monitor/monitor.c    | 15 ---------------
> >  stubs/error-printf.c | 18 ------------------
> >  stubs/meson.build    |  1 -
> >  stubs/monitor-core.c | 14 +++++++++++++-
> >  util/error-report.c  | 15 +++++++++++++++
> >  5 files changed, 28 insertions(+), 35 deletions(-)
> >  delete mode 100644 stubs/error-printf.c
> >
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 627a59b23e..6dc5a7016d 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -268,21 +268,6 @@ void monitor_printc(Monitor *mon, int c)
> >      monitor_printf(mon, "'");
> >  }
> >  
> > -int error_vprintf(const char *fmt, va_list ap)
> > -{
> > -    Monitor *cur_mon = monitor_cur();
> > -    /*
> > -     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> > -     * IOW this will only print if in HMP, otherwise we
> > -     * fallback to stderr for QMP / no-monitor scenarios.
> > -     */
> > -    int ret = monitor_vprintf(cur_mon, fmt, ap);
> > -    if (ret == -1) {
> > -        ret = vfprintf(stderr, fmt, ap);
> > -    }
> > -    return ret;
> > -}
> > -
> >  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> >      /* Limit guest-triggerable events to 1 per second */
> >      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> > diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> > deleted file mode 100644
> > index 1afa0f62ca..0000000000
> > --- a/stubs/error-printf.c
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -#include "qemu/osdep.h"
> > -#include "qemu/error-report.h"
> > -#include "monitor/monitor.h"
> > -
> > -int error_vprintf(const char *fmt, va_list ap)
> > -{
> > -    int ret;
> > -
> > -    if (g_test_initialized() && !g_test_subprocess() &&
> > -        getenv("QTEST_SILENT_ERRORS")) {
> > -        char *msg = g_strdup_vprintf(fmt, ap);
> > -        g_test_message("%s", msg);
> > -        ret = strlen(msg);
> > -        g_free(msg);
> > -        return ret;
> > -    }
> > -    return vfprintf(stderr, fmt, ap);
> > -}
> > diff --git a/stubs/meson.build b/stubs/meson.build
> > index 0b2778c568..3d77458a3f 100644
> > --- a/stubs/meson.build
> > +++ b/stubs/meson.build
> > @@ -3,7 +3,6 @@
> >  # below, so that it is clear who needs the stubbed functionality.
> >  
> >  stub_ss.add(files('cpu-get-clock.c'))
> > -stub_ss.add(files('error-printf.c'))
> >  stub_ss.add(files('fdset.c'))
> >  stub_ss.add(files('iothread-lock.c'))
> >  stub_ss.add(files('is-daemonized.c'))
> > diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> > index 1894cdfe1f..a7c32297c9 100644
> > --- a/stubs/monitor-core.c
> > +++ b/stubs/monitor-core.c
> > @@ -18,5 +18,17 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
> >  
> >  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> >  {
> > -    abort();
> > +    /*
> > +     * Pretend 'g_test_message' is our monitor console to
> > +     * stop the caller sending messages to stderr
> > +     */
> > +    if (g_test_initialized() && !g_test_subprocess() &&
> > +        getenv("QTEST_SILENT_ERRORS")) {
> > +        char *msg = g_strdup_vprintf(fmt, ap);
> > +        g_test_message("%s", msg);
> > +        size_t ret = strlen(msg);
> > +        g_free(msg);
> > +        return ret;
> > +    }
> > +    return -1;
> >  }
> > diff --git a/util/error-report.c b/util/error-report.c
> > index 1b17c11de1..b262ad01cb 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -29,6 +29,21 @@ bool message_with_timestamp;
> >  bool error_with_guestname;
> >  const char *error_guest_name;
> >  
> > +int error_vprintf(const char *fmt, va_list ap)
> > +{
> > +    Monitor *cur_mon = monitor_cur();
> > +    /*
> > +     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> > +     * IOW this will only print if in HMP, otherwise we
> > +     * fallback to stderr for QMP / no-monitor scenarios.
> > +     */
> > +    int ret = monitor_vprintf(cur_mon, fmt, ap);
> > +    if (ret == -1) {
> > +        ret = vfprintf(stderr, fmt, ap);
> > +    }
> > +    return ret;
> > +}
> > +
> >  int error_printf(const char *fmt, ...)
> >  {
> >      va_list ap;
> 
> Without stubs, no change in behavior.
> 
> With both stubs, before the patch:
> 
>     monitor_vprintf() is not supposed to run, and aborts
> 
>     error_vprintf() calls g_test_message() for tests, else vfprintf()
> 
> afterwards:
> 
>     monitor_vprintf() calls g_test_message() and succeeds in tests, else
>     fails
> 
>     error_vprintf() calls monitor_printf(), and when it fails falls back
>     to vfprintf().
> 
> Alright, error_vprintf() behaves the same as before.
> 
> monitor_vprintf() no longer aborts.  Hmm.  What if we somehow acquire
> calls?  In tests, they'll go to g_test_message(), which is fine, I
> guess.  Outside tests, they'll fail.  So does the non-stub version
> unless the current monitor is HMP.  Also fine, I guess.
> 
> Is it possible to link just one of the stubs?

There is only 1 stub after this patch - for monitor_vprintf().
error_vprintf() is never stubbed anymore.

The interesting scenario outside there tests is the non-system emulator
binaries.

Those will not have the monitor code, so will get the monitor_vprintf
stub. That will report g_test_initialized() == false, and so the stub
will return -1.  error_vprintf() will see this -1 return value and
thus call to vfprintf().

So the behaviour is again the same as before this patch AFAICT for all
linkage scenarios.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


