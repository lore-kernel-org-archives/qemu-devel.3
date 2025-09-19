Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D35CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbBL-0002XN-RV; Fri, 19 Sep 2025 09:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbBJ-0002WP-5U
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzbBA-0001vN-Nx
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288570;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm12Bt1q93b+aYnp6CWK0gI7z8+VHd0QjAvjlijmfb0=;
 b=glSDzrV9istqJ/Tc3IAIofFCu4iKS2YLzm4DR0q3VEOIB8NgUWX9jeY0jo6DsQJEv0elfB
 9+WQBZE0jdeoP5gv2yzAt4dx/1KDoQ3rRdS33YBa87B5qAn4I0XyVN2iIquxU4Fgr8Xra7
 S0ce6rlaeGfimESDi5sAmknVTOP0sws=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-oeKRizvZNFmtRsk1QWVLGg-1; Fri,
 19 Sep 2025 09:29:25 -0400
X-MC-Unique: oeKRizvZNFmtRsk1QWVLGg-1
X-Mimecast-MFC-AGG-ID: oeKRizvZNFmtRsk1QWVLGg_1758288564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFFA195608B; Fri, 19 Sep 2025 13:29:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD2361956045; Fri, 19 Sep 2025 13:29:18 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:29:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
Message-ID: <aM1aq1HNV7qJdrqI@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
 <87zfaqwr2a.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfaqwr2a.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 19, 2025 at 02:43:41PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().
> 
> "A number of"?  I can see just one:
> 
>     int error_vprintf(const char *fmt, va_list ap)
>     {
>         Monitor *cur_mon = monitor_cur();
> 
>         if (cur_mon && !monitor_cur_is_qmp()) {
>             return monitor_vprintf(cur_mon, fmt, ap);
>         }
>         return vfprintf(stderr, fmt, ap);
>     }

Opps, that'll be referring to the other use of monitor_cur() in my
patches that I then removed when I re-ordered the series.

> 
> > This is undesirable because monitor_cur_is_qmp() will itself call
> > monitor_cur() again, and monitor_cur() must acquire locks and do
> > hash table lookups. Introducing a monitor_cur_hmp() helper will
> > combine the two operations into one reducing cost.
> 
> This made me expect the patch replaces the undesirable uses.  It does
> not; the new function remains unused for now.
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/monitor/monitor.h      |  1 +
> >  monitor/monitor.c              | 14 ++++++++++++++
> >  stubs/monitor-core.c           |  5 +++++
> >  tests/unit/test-util-sockets.c |  1 +
> >  4 files changed, 21 insertions(+)
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 296690e1f1..c3b79b960a 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -14,6 +14,7 @@ typedef struct MonitorOptions MonitorOptions;
> >  extern QemuOptsList qemu_mon_opts;
> >  
> >  Monitor *monitor_cur(void);
> > +Monitor *monitor_cur_hmp(void);
> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
> >  bool monitor_cur_is_qmp(void);
> >  
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index e1e5dbfcbe..cff502c53e 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -84,6 +84,20 @@ Monitor *monitor_cur(void)
> >      return mon;
> >  }
> >  
> > +Monitor *monitor_cur_hmp(void)
> > +{
> > +    Monitor *mon;
> > +
> > +    qemu_mutex_lock(&monitor_lock);
> > +    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> > +    if (mon && monitor_is_qmp(mon)) {
> > +        mon = NULL;
> > +    }
> > +    qemu_mutex_unlock(&monitor_lock);
> > +
> > +    return mon;
> > +}
> > +
> >  /**
> >   * Sets a new current monitor and returns the old one.
> >   *
> > diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> > index b498a0f1af..1e0b11ec29 100644
> > --- a/stubs/monitor-core.c
> > +++ b/stubs/monitor-core.c
> > @@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
> >      return NULL;
> >  }
> >  
> > +Monitor *monitor_cur_hmp(void)
> > +{
> > +    return NULL;
> > +}
> > +
> >  bool monitor_cur_is_qmp(void)
> >  {
> >      return false;
> > diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> > index bd48731ea2..d40813c682 100644
> > --- a/tests/unit/test-util-sockets.c
> > +++ b/tests/unit/test-util-sockets.c
> > @@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >   * otherwise we get duplicate syms at link time.
> >   */
> >  Monitor *monitor_cur(void) { return cur_mon; }
> > +Monitor *monitor_cur_hmp(void) { return cur_mon; }
> 
> @cur_mon is a fake here.  Why do you make this fake monitor HMP?  If we
> somehow call error_vprintf(), it'll call monitor_vprintf(), which will
> dereference the fake monitor.  Best possible outcome would be an
> immediate crash.

Current code has 'monitor_cur' return 'cur_mon', and 'monitor_cur_is_qmp'
(below)  return 'false'. IOW, the current behaviour of the stubs is that
'cur_mon' is HMP, so I just maintained those semantics.

We've stubbed monitor_vprintf() too so it'll abort() no matter what, as
we don't expect that code path to be triggered from this test suite.

> >  bool monitor_cur_is_qmp(void) { return false; }
> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> >  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


