Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA75C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjEk-0005nq-GG; Mon, 06 Jul 2026 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjEh-0005nB-HT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjEe-0006jS-EC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783343980;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3yuCGrdR8KJwKPA7Evi1/o5nynk0M3WzQOJycX3Vl4=;
 b=J7+77xWDZAuKzjIXp5hqymN3YeBqRZqXPqQcLyX+42fjfXSfiN91EcxOqk6x8EHqu310/f
 VeLEXNRMtr+8uw0dAZ3CTvoD9CV1xOOy/jQrjrQpylbdksZW6vEmVZllvDAj/g+xRB8+Vr
 6alP9vQlYqpBTAmi2TiUKRi/ceIEcwc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-pqi2ISgUO0yw4i6F7_ZaIA-1; Mon,
 06 Jul 2026 09:19:37 -0400
X-MC-Unique: pqi2ISgUO0yw4i6F7_ZaIA-1
X-Mimecast-MFC-AGG-ID: pqi2ISgUO0yw4i6F7_ZaIA_1783343975
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DC991955F1A; Mon,  6 Jul 2026 13:19:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84BAF3653A; Mon,  6 Jul 2026 13:19:31 +0000 (UTC)
Date: Mon, 6 Jul 2026 14:19:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v6 06/34] monitor: add 'chardev' property to Monitor base
 class
Message-ID: <akurYJQF6WPocUoX@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-7-berrange@redhat.com>
 <87zf08usa0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf08usa0.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jul 03, 2026 at 03:17:11PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This is associates both QMP and HMP monitors with a character
> > device backend.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Peter Krempa <pkrempa@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  chardev/char.c             |  3 ++-
> >  gdbstub/system.c           |  4 ++--
> >  include/monitor/monitor.h  |  4 ++--
> >  monitor/hmp.c              | 10 ++++++--
> >  monitor/monitor-internal.h |  2 ++
> >  monitor/monitor.c          | 47 ++++++++++++++++++++++++++++++--------
> >  monitor/qmp.c              | 18 ++++++++++-----
> >  stubs/monitor-internal.c   |  2 +-
> >  8 files changed, 67 insertions(+), 23 deletions(-)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index c71ffa7963..22e5bae388 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
> >      }
> >  
> >      if (qemu_opt_get_bool(opts, "mux", 0)) {
> > +        const char *chardev_id = qemu_opts_id(opts);
> >          assert(permit_mux_mon);
> > -        monitor_new_hmp(NULL, chr, true, &err);
> > +        monitor_new_hmp(NULL, chardev_id, true, &err);
> >          if (err) {
> >              error_report_err(err);
> >              object_unparent(OBJECT(chr));
> > diff --git a/gdbstub/system.c b/gdbstub/system.c
> > index fda8ef9352..d681476f5e 100644
> > --- a/gdbstub/system.c
> > +++ b/gdbstub/system.c
> > @@ -387,9 +387,9 @@ bool gdbserver_start(const char *device, Error **errp)
> >          qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
> >  
> >          /* Initialize a monitor terminal for gdb */
> > -        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
> > +        mon_chr = qemu_chardev_new("gdbchrdev0", TYPE_CHARDEV_GDB,
> >                                     NULL, NULL, &error_abort);
> 
> This chardev now gets ID "gdbchrdev0" instead of id_generate(ID_CHR).
> 
> If you truly need this, you have to mention it in the commit message.

Not required.

> 
> > -        monitor_new_hmp(NULL, mon_chr, false, &error_abort);
> > +        monitor_new_hmp(NULL, "gdbchrdev0", false, &error_abort);
> 
> If you don't, then passing mon_chr->label here should do the trick.

Yes.



> > @@ -1538,22 +1539,27 @@ static void monitor_readline_flush(void *opaque)
> >      monitor_flush(&mon->parent_obj);
> >  }
> >  
> > -void monitor_new_hmp(const char *id, Chardev *chr,
> > +void monitor_new_hmp(const char *id, const char *chardev_id,
> >                       bool use_readline, Error **errp)
> 
> You now pass a chardev ID instead of a Chardev *.
> 
> I *guess* that's possible because chardev_new() asserts it's passed an
> ID.
> 
> I should now check all callers of monitor_new_hmp() to make sure they
> pass the correct ID.  On a Friday afternoon.  I hoist the white flag.
> 
> Such refactorings should be mentioned in the commit message.  Even
> better would be a separate patch.

I'll switch to a separate commit for this.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


