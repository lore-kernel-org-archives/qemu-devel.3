Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8839DD1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39y8-00043C-45; Tue, 22 Oct 2024 04:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39y6-000433-6p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39y2-000783-Tn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729584613;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDM2FlhfCKKSY9yCg4S9S7Ywe4XWSqZTJ/VX1RQNadQ=;
 b=DOv46NtZrs1pA7RhmqHGGaZp8AH8zgZvmgBVaXWqCKp81j0HV6lzbgp66z5lDGqG+DJfek
 xVmKB+tBXpWu71TW5NNHdZYuUeXnh0I5uB+3x8xYMDfDdIUEqDANOxmrrxAkrh0T7gfyoW
 Z57MZJuSWtwLlkIAv3eev7VnMd7BCi4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-3BHyw9v6ObKf_zDHZZiSjA-1; Tue,
 22 Oct 2024 04:10:09 -0400
X-MC-Unique: 3BHyw9v6ObKf_zDHZZiSjA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69E0A1955D5D; Tue, 22 Oct 2024 08:10:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF498195607C; Tue, 22 Oct 2024 08:10:05 +0000 (UTC)
Date: Tue, 22 Oct 2024 09:10:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, ankeesler@google.com,
 mst@redhat.com, qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
Message-ID: <Zxdd2UUtvSqBap9D@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <ZxdaAtp6QlpqRSDs@redhat.com>
 <CAJ+F1CL003+CBNQmnD_pwx+TyvNDR75GnL-j7o+dXzkHbxYOuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL003+CBNQmnD_pwx+TyvNDR75GnL-j7o+dXzkHbxYOuw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 22, 2024 at 12:04:29PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 22, 2024 at 11:54 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-André Lureau wrote:
> > > Hi Roque
> > >
> > > On Fri, Oct 18, 2024 at 1:53 AM Roque Arcudia Hernandez
> > > <roqueh@google.com> wrote:
> > > >
> > > > From: Andrew Keesler <ankeesler@google.com>
> > > >
> > > > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
> > Identification
> > > > Data) is propagated by QEMU such that a virtual display presents
> > legitimate
> > > > metadata (e.g., name, serial number, preferred resolutions, etc.) to
> > its
> > > > connected guest.
> > > >
> > > > This change propagates an optional user-provided display name to
> > > > QemuConsole. Future changes will update downstream devices to leverage
> > this
> > > > display name for various uses, the primary one being providing a
> > custom EDID
> > > > name to guests. Future changes will also update other displays (e.g.,
> > spice)
> > > > with a similar option to propagate a display name to downstream
> > devices.
> > > >
> > > > Currently, every virtio-gpu virtual display has the same name: "QEMU
> > > > Monitor". We hope to be able to inject the EDID name of virtual
> > displays in
> > > > order to test guest behavior that is specific to display names. We
> > provide the
> > > > ability to inject the display name from the display configuration as
> > that most
> > > > closely resembles how real displays work (hardware displays contain
> > static EDID
> > > > information that is provided to every connected host).
> > > >
> > > > It should also be noted that EDID names longer than 12 bytes will be
> > truncated
> > > > per spec (I think?).
> > > >
> > > > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > > > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > > > ---
> > > >  include/ui/console.h | 1 +
> > > >  ui/console-priv.h    | 1 +
> > > >  ui/console.c         | 8 ++++++++
> > > >  ui/vnc.c             | 8 +++++++-
> > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/ui/console.h b/include/ui/console.h
> > > > index 5832d52a8a..74ab03ed72 100644
> > > > --- a/include/ui/console.h
> > > > +++ b/include/ui/console.h
> > > > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
> > > >  uint32_t qemu_console_get_head(QemuConsole *con);
> > > >  int qemu_console_get_width(QemuConsole *con, int fallback);
> > > >  int qemu_console_get_height(QemuConsole *con, int fallback);
> > > > +void qemu_console_set_name(QemuConsole *con, const char *name);
> > > >  /* Return the low-level window id for the console */
> > > >  int qemu_console_get_window_id(QemuConsole *con);
> > > >  /* Set the low-level window id for the console */
> > > > diff --git a/ui/console-priv.h b/ui/console-priv.h
> > > > index 43ceb8122f..9f2769843f 100644
> > > > --- a/ui/console-priv.h
> > > > +++ b/ui/console-priv.h
> > > > @@ -18,6 +18,7 @@ struct QemuConsole {
> > > >      Object parent;
> > > >
> > > >      int index;
> > > > +    const char *name;
> > > >      DisplayState *ds;
> > > >      DisplaySurface *surface;
> > > >      DisplayScanout scanout;
> > > > diff --git a/ui/console.c b/ui/console.c
> > > > index 5165f17125..f377fd8417 100644
> > > > --- a/ui/console.c
> > > > +++ b/ui/console.c
> > > > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con,
> > int fallback)
> > > >      }
> > > >  }
> > > >
> > > > +void qemu_console_set_name(QemuConsole *con, const char *name)
> > > > +{
> > > > +    if (con == NULL) {
> > > > +        return;
> > > > +    }
> > > > +    con->name = name;
> > > > +}
> > > > +
> > > >  int qemu_invalidate_text_consoles(void)
> > > >  {
> > > >      QemuConsole *s;
> > > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > > index 93a8dbd253..7d6acc5c2e 100644
> > > > --- a/ui/vnc.c
> > > > +++ b/ui/vnc.c
> > > > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts = {
> > > >          },{
> > > >              .name = "power-control",
> > > >              .type = QEMU_OPT_BOOL,
> > > > +        },{
> > > > +            .name = "name",
> > > > +            .type = QEMU_OPT_STRING,
> > > >          },
> > > >          { /* end of list */ }
> > > >      },
> > > > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error
> > **errp)
> > > >      QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
> > > >      g_autoptr(SocketAddressList) saddr_list = NULL;
> > > >      g_autoptr(SocketAddressList) wsaddr_list = NULL;
> > > > -    const char *share, *device_id;
> > > > +    const char *share, *device_id, *name;
> > > >      QemuConsole *con;
> > > >      bool password = false;
> > > >      bool reverse = false;
> > > > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error
> > **errp)
> > > >      }
> > > >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
> > > >
> > > > +    name = qemu_opt_get(opts, "name");
> > > > +    qemu_console_set_name(vd->dcl.con, name);
> > >
> > > Why not expose a "head_name" property in QemuGraphicConsole?
> >
> > QemuGraphicConsole isn't mapped to any CLI though, is it ?
> >
> >
> No, it would be a bit tedious to do so with multi-head -devices.
> 
> 
> > In QAPI we have DisplayOptions union  for all the local displays,
> > and as a user I think I'd expect 'name' to be settable from
> > those.
> >
> >
> DisplayOptions is meant for the UI display.. Here, the intent is really to
> set the HW EDID name field.

But it is also applicable to the backend, all of which have a
name for the display set in the window titlebar. We should
be looking at both sides IMHO.

> Also DisplayOptions doesn't map to a specific console.

It could be made to contain per-head information if we desired
though, and would be more useful than just the name. There were
some patches a while ago trying to express per-console placement
of windows onto host monitor outputs, for example.

> > own CLI options we can expose.
> >
> > For runtime setting, we have a QMP  "display-update" command, that
> > currently just lets you change VNC listening address, but was intended
> > to allow for any runtime display changes.
> >
> > > This way it should be possible to set the name with QMP qom-set.
> >
> > qom-set isn't a particularly nice interface, as things you can set
> > from that are not introspectable and have no type information that
> > can be queried.
> >
> 
> fwiw, it could be easily exposed to D-Bus, for ex:
> 
> busctl --user set-property org.qemu /org/qemu/Display1/Console_1
> org.qemu.Display1.Console HeadName s "First Monitor"

That could be mapped to whatever interface we expose on the QEMU side,
it doesn't have to be qom-set.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


