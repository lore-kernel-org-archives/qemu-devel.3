Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF1D1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39iI-0006qq-Aq; Tue, 22 Oct 2024 03:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39iG-0006qd-KI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39iC-0004zZ-6R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729583630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhC7gfTTomtSbvTfQKreNvr/+USdEorK5Aa7JiSkJiM=;
 b=ESgeyON8JYTmtXOia5YQhgSz/6D7HdFzVUvTX2Ruwzn0fijgsBHNzfKo3dHxS3FWx8xTj5
 d5yj8QOt2lrkbLsFkvSxYAPHfEC26+ARwl/2tknp7yRwXjKCAHsokxgzKH2rTelLjpm90P
 KKqi9zgIbkEIqy5HuWedBCihsGPRi1Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-95vNInE1NPqTi_SM9e3iEQ-1; Tue,
 22 Oct 2024 03:53:46 -0400
X-MC-Unique: 95vNInE1NPqTi_SM9e3iEQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EFE11955F10; Tue, 22 Oct 2024 07:53:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39A1300018D; Tue, 22 Oct 2024 07:53:42 +0000 (UTC)
Date: Tue, 22 Oct 2024 08:53:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, ankeesler@google.com,
 mst@redhat.com, qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
Message-ID: <ZxdaAtp6QlpqRSDs@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Mon, Oct 21, 2024 at 03:14:39PM +0400, Marc-André Lureau wrote:
> Hi Roque
> 
> On Fri, Oct 18, 2024 at 1:53 AM Roque Arcudia Hernandez
> <roqueh@google.com> wrote:
> >
> > From: Andrew Keesler <ankeesler@google.com>
> >
> > Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identification
> > Data) is propagated by QEMU such that a virtual display presents legitimate
> > metadata (e.g., name, serial number, preferred resolutions, etc.) to its
> > connected guest.
> >
> > This change propagates an optional user-provided display name to
> > QemuConsole. Future changes will update downstream devices to leverage this
> > display name for various uses, the primary one being providing a custom EDID
> > name to guests. Future changes will also update other displays (e.g., spice)
> > with a similar option to propagate a display name to downstream devices.
> >
> > Currently, every virtio-gpu virtual display has the same name: "QEMU
> > Monitor". We hope to be able to inject the EDID name of virtual displays in
> > order to test guest behavior that is specific to display names. We provide the
> > ability to inject the display name from the display configuration as that most
> > closely resembles how real displays work (hardware displays contain static EDID
> > information that is provided to every connected host).
> >
> > It should also be noted that EDID names longer than 12 bytes will be truncated
> > per spec (I think?).
> >
> > Signed-off-by: Andrew Keesler <ankeesler@google.com>
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >  include/ui/console.h | 1 +
> >  ui/console-priv.h    | 1 +
> >  ui/console.c         | 8 ++++++++
> >  ui/vnc.c             | 8 +++++++-
> >  4 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 5832d52a8a..74ab03ed72 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
> >  uint32_t qemu_console_get_head(QemuConsole *con);
> >  int qemu_console_get_width(QemuConsole *con, int fallback);
> >  int qemu_console_get_height(QemuConsole *con, int fallback);
> > +void qemu_console_set_name(QemuConsole *con, const char *name);
> >  /* Return the low-level window id for the console */
> >  int qemu_console_get_window_id(QemuConsole *con);
> >  /* Set the low-level window id for the console */
> > diff --git a/ui/console-priv.h b/ui/console-priv.h
> > index 43ceb8122f..9f2769843f 100644
> > --- a/ui/console-priv.h
> > +++ b/ui/console-priv.h
> > @@ -18,6 +18,7 @@ struct QemuConsole {
> >      Object parent;
> >
> >      int index;
> > +    const char *name;
> >      DisplayState *ds;
> >      DisplaySurface *surface;
> >      DisplayScanout scanout;
> > diff --git a/ui/console.c b/ui/console.c
> > index 5165f17125..f377fd8417 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
> >      }
> >  }
> >
> > +void qemu_console_set_name(QemuConsole *con, const char *name)
> > +{
> > +    if (con == NULL) {
> > +        return;
> > +    }
> > +    con->name = name;
> > +}
> > +
> >  int qemu_invalidate_text_consoles(void)
> >  {
> >      QemuConsole *s;
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 93a8dbd253..7d6acc5c2e 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts = {
> >          },{
> >              .name = "power-control",
> >              .type = QEMU_OPT_BOOL,
> > +        },{
> > +            .name = "name",
> > +            .type = QEMU_OPT_STRING,
> >          },
> >          { /* end of list */ }
> >      },
> > @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **errp)
> >      QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
> >      g_autoptr(SocketAddressList) saddr_list = NULL;
> >      g_autoptr(SocketAddressList) wsaddr_list = NULL;
> > -    const char *share, *device_id;
> > +    const char *share, *device_id, *name;
> >      QemuConsole *con;
> >      bool password = false;
> >      bool reverse = false;
> > @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **errp)
> >      }
> >      qkbd_state_set_delay(vd->kbd, key_delay_ms);
> >
> > +    name = qemu_opt_get(opts, "name");
> > +    qemu_console_set_name(vd->dcl.con, name);
> 
> Why not expose a "head_name" property in QemuGraphicConsole?

QemuGraphicConsole isn't mapped to any CLI though, is it ?

In QAPI we have DisplayOptions union  for all the local displays,
and as a user I think I'd expect 'name' to be settable from
those.

For VNC/SPICE, we have not mapped to QAPI, but they do have their
own CLI options we can expose.

For runtime setting, we have a QMP  "display-update" command, that
currently just lets you change VNC listening address, but was intended
to allow for any runtime display changes.

> This way it should be possible to set the name with QMP qom-set.

qom-set isn't a particularly nice interface, as things you can set
from that are not introspectable and have no type information that
can be queried.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


