Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A71C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgj4q-0003Ge-JW; Mon, 06 Jul 2026 09:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgj4p-0003GQ-33
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgj4n-0003qt-64
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783343371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vjwzrheiy1n//OiDbLCxDJ8iGBsIWiy6t6t79VlsNr4=;
 b=fF06IvfG+lNDIdsoWySWAw2Ju74ioZ+PJMk2YJTm3Ns6OVaH96xMQ4DmAnIm4jnhhlN7Am
 +o6iR86XXy4GxDo4OzxRQVQJxf+u6y7jd5X2c4g/U/lt0o1IMyb5PEEFdo9NbHMxSYJe0y
 SbwPVJ/sMWrOGbVivHY0a2X+tJezn8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-GFQUJMgDNQWKoh_JHOq41Q-1; Mon,
 06 Jul 2026 09:09:30 -0400
X-MC-Unique: GFQUJMgDNQWKoh_JHOq41Q-1
X-Mimecast-MFC-AGG-ID: GFQUJMgDNQWKoh_JHOq41Q_1783343368
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F1D81955F13; Mon,  6 Jul 2026 13:09:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67B3D36535; Mon,  6 Jul 2026 13:09:24 +0000 (UTC)
Date: Mon, 6 Jul 2026 14:09:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org
Subject: Re: [PATCH v6 05/34] monitor: minimal conversion of monitors to QOM
Message-ID: <akupAVHa227qQeXh@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-6-berrange@redhat.com>
 <87echkw86p.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87echkw86p.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 03, 2026 at 02:48:14PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This introduces a Monitor QOM object, with MonitorHMP and
> > MonitorQMP subclasses. This is the bare minimum conversion
> > of just the type declarations and replacing g_new/g_free
> > with object_new/object_unref. The Monitor base class is
> > abstract since only the HMP/QMP variants should ever be
> > created.
> >
> > When created through the existing QemuOpts interfaces, the
> > new internal QOM object will get assigned a dynamic ID with
> > the format "compat_monitorNNN" which is the historical
> > QemuOpts ID naming pattern.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  chardev/char.c             |  2 +-
> >  gdbstub/system.c           |  2 +-
> >  include/monitor/monitor.h  | 18 +++++++++++++++---
> >  monitor/hmp.c              | 31 ++++++++++++++++++++++++++++---
> >  monitor/monitor-internal.h | 18 ++++++++++++++++--
> >  monitor/monitor.c          | 31 +++++++++++++++++++++++++++----
> >  monitor/qmp-cmds.c         | 15 ++++++++-------
> >  monitor/qmp.c              | 31 ++++++++++++++++++++++++++++---
> >  stubs/monitor-internal.c   |  3 ++-
> >  system/vl.c                |  7 +++----
> >  10 files changed, 129 insertions(+), 29 deletions(-)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 813c04d953..c71ffa7963 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
> >  
> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
> >          assert(permit_mux_mon);
> > -        monitor_new_hmp(chr, true, &err);
> > +        monitor_new_hmp(NULL, chr, true, &err);
> 
> Yet another way to create a monitor, not covered by the commit message.
>
> We get here for legacy chardev syntax "mon:...", I think.  Where exactly
> in the external interface this is accepted I'm not sure.  It's
> documented for -serial.  See qemu-options.hx.

Yes, I confirmed this codepath hits for -serial (which means it will
apply to -parallel too, but no one cares about that )

> There is no "mon" QemuOpts.
> 
> You pass NULL to monitor_new_hmp(), which makes it create the object as
> /objects/compat_monitorNNN.

Yes.

> > diff --git a/gdbstub/system.c b/gdbstub/system.c
> > index 18f6a62b2e..fda8ef9352 100644
> > --- a/gdbstub/system.c
> > +++ b/gdbstub/system.c
> > @@ -389,7 +389,7 @@ bool gdbserver_start(const char *device, Error **errp)
> >          /* Initialize a monitor terminal for gdb */
> >          mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> >                                     NULL, NULL, &error_abort);
> > -        monitor_new_hmp(mon_chr, false, &error_abort);
> > +        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
> 
> And yet another, also no "mon" QemuOpts, and also
> /objects/compat_monitorNNN.

Yep, triggered with -gdbstub  arg


> > diff --git a/system/vl.c b/system/vl.c
> > index 6643242729..4737c03872 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1252,7 +1252,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> >  
> >  static void monitor_parse(const char *str, const char *mode, bool pretty)
> >  {
> > -    static int monitor_device_index = 0;
> >      QemuOpts *opts;
> >      const char *p;
> >      char label[32];
> > @@ -1260,8 +1259,9 @@ static void monitor_parse(const char *str, const char *mode, bool pretty)
> >      if (strstart(str, "chardev:", &p)) {
> >          snprintf(label, sizeof(label), "%s", p);
> >      } else {
> > -        snprintf(label, sizeof(label), "compat_monitor%d",
> > -                 monitor_device_index);
> > +        g_autofree char *id = monitor_compat_id();
> > +        assert(strlen(id) < sizeof(label));
> > +        memcpy(label, id, strlen(id) + 1);
> >          opts = qemu_chr_parse_compat(label, str, true);
> >          if (!opts) {
> >              error_report("parse error: %s", str);
> > @@ -1277,7 +1277,6 @@ static void monitor_parse(const char *str, const char *mode, bool pretty)
> >      } else {
> >          assert(pretty == false);
> >      }
> > -    monitor_device_index++;
> 
> Before the patch, we increment the NNN in "compat_monitorNNN" exactly
> here.
> 
> Afterwards, we increment it in monitor_compat_id(), which gets called
> from here and several additional places.
> 
> If any of the additional places execute before an execution of the
> original place, NNN change.
> 
> Feels tolerable, but needs a mention in the commit message.

Yes, will mention the change in NNN incrementing.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


