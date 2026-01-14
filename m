Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91223D29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0H1-0005lj-40; Wed, 14 Jan 2026 07:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0Gh-0005j5-NM
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:46:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0Gd-00028C-5D
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768394789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmdKhxQO5sJ7ePl8AF/0z76V997rSx7Gzmlf+EId7hg=;
 b=YBQ7auQvFYvA44XesS36F7MWusa/Ytp18V8X7Dk7aKxPPnF7aBWAcRZ9jbLku7z3MGLOSK
 A9p+tV6QQN8NpkTCR5WZO62gZeUNfrUmz8OfpvMMCiLqQfplKYK+vDwTmNgQWDxd98mPA1
 BFNQwyZIYCyFBe7TpqFhg+J0oEWx+w8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-MH967anxOui4sJRcFJgMJA-1; Wed,
 14 Jan 2026 07:46:26 -0500
X-MC-Unique: MH967anxOui4sJRcFJgMJA-1
X-Mimecast-MFC-AGG-ID: MH967anxOui4sJRcFJgMJA_1768394784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECC3F180057E; Wed, 14 Jan 2026 12:46:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B2471956048; Wed, 14 Jan 2026 12:46:17 +0000 (UTC)
Date: Wed, 14 Jan 2026 12:46:13 +0000
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
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 15/24] monitor: introduce monitor_cur_is_hmp() helper
Message-ID: <aWeQFT9r333oCtZT@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-16-berrange@redhat.com>
 <874iop8ssa.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iop8ssa.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 13, 2026 at 03:57:09PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Note that this is not simply the inverse of monitor_cur_is_qmp(),
> > as both helpers require that monitor_cur() is first non-NULL.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/monitor/monitor.h      |  1 +
> >  monitor/monitor.c              | 10 ++++++++++
> >  stubs/monitor-core.c           |  6 ++++++
> >  tests/unit/test-util-sockets.c |  1 +
> >  4 files changed, 18 insertions(+)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 296690e1f1..9c71e6cf3c 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -16,6 +16,7 @@ extern QemuOptsList qemu_mon_opts;
> >  Monitor *monitor_cur(void);
> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
> >  bool monitor_cur_is_qmp(void);
> > +bool monitor_cur_is_hmp(void);
> >  
> >  void monitor_init_globals(void);
> >  void monitor_init_globals_core(void);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 6dc5a7016d..b81cc7d2ed 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -116,6 +116,16 @@ bool monitor_cur_is_qmp(void)
> >      return cur_mon && monitor_is_qmp(cur_mon);
> >  }
> >  
> > +/**
> > + * Is the current monitor, if any, a HMP monitor?
> 
> "an HMP"?  Not a native speaker...

Not that I know the rules either really, but I think
it does sound better as "an" :-)

> > + */
> > +bool monitor_cur_is_hmp(void)
> > +{
> > +    Monitor *cur_mon = monitor_cur();
> > +
> > +    return cur_mon && !monitor_is_qmp(cur_mon);
> > +}
> > +
> 
> The only use at the end of this series looks like this:
> 
>     Monitor *cur = NULL;
> 
>     if (monitor_cur_is_hmp()) {
>         cur = monitor_cur();
>     } else {
>         // some stderr code
>     }
> 
> Meh.  Could do
> 
>     Monitor *cur = monitor_cur();
> 
>     if (monitor_cur_is_qmp(cur)) {
>         cur = NULL;
>         // some stderr code
>     }
> 
> Or with a helper returning the HMP monitor, we could have something like
> 
>     cur = monitor_cur_hmp();
> 
>     if (!cur) {
>         // some stderr code
>     }
> 
> Doesn't mirror monitor_cur_is_qmp() then.  But I just pointed out in
> reply to PATCH 11 that we don't actually need monitor_cur_is_qmp()>

I'll do the middle option here. It is pointless churn to delete
monitor_cur_is_qmp and then add monitor_cur_is_hmp or monitor_cur_hmp,
so i'll just use monitor_cur_is_qmp

> 
> Ideas, not demands.
> 
> >  /**
> >   * Is @mon is using readline?
> >   * Note: not all HMP monitors use readline, e.g., gdbserver has a
> > diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> > index a7c32297c9..674211f48f 100644
> > --- a/stubs/monitor-core.c
> > +++ b/stubs/monitor-core.c
> > @@ -7,6 +7,12 @@ Monitor *monitor_cur(void)
> >      return NULL;
> >  }
> >  
> > +bool monitor_cur_is_hmp(void)
> > +{
> > +    /* since monitor_cur() above returns NULL, this can't be true */
> 
> Maybe
> 
>        /* We can't have a monitor, let alone an HMP monitor */

Sure.


> > diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> > index ee66d727c3..4b7f408902 100644
> > --- a/tests/unit/test-util-sockets.c
> > +++ b/tests/unit/test-util-sockets.c
> > @@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >  Monitor *monitor_cur(void) { return cur_mon; }
> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> >  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> > +bool monitor_cur_is_hmp(void) { return false; }
> 
> Fine.  abort() would also be fine.  Matter of taste.

I tested abort is ok here .

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


