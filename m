Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DB7D35176
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7tGg-0000dS-8S; Wed, 01 Apr 2026 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7tGc-0000bb-Go
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7tGZ-0000jt-Kr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775041061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKNE/9nkvqSaXdvfBaYsAsLR/TWblE70MAZcQZyg8ys=;
 b=GiiOUG05DPYFB5aXiQk6wULu/lUYfbCMEWdEKCHEGbdIQgdVXYNJ/G+J7x0E5xsbhulJk/
 K5BuwoPJjhrbh59eVBs5h4gU32iBS1zB7GVZBX1hKLpFMSSGdUVYZwsIfwo8GRJQEB6Nnd
 Ev8H7Qkr2qwJt3JXb9nHBpDq3KUNj68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-DMcbFEasMwCmHngMcT5a2Q-1; Wed,
 01 Apr 2026 06:57:38 -0400
X-MC-Unique: DMcbFEasMwCmHngMcT5a2Q-1
X-Mimecast-MFC-AGG-ID: DMcbFEasMwCmHngMcT5a2Q_1775041056
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F6A119560B1; Wed,  1 Apr 2026 10:57:36 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 571A61954102; Wed,  1 Apr 2026 10:57:30 +0000 (UTC)
Date: Wed, 1 Apr 2026 11:57:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH v3 07/11] ui/dbus: run without Audio interface when audio
 is disabled
Message-ID: <acz6F3rMuvfISQva@redhat.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-8-heifetz@yandex-team.com>
 <87ms04cksj.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ms04cksj.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On Thu, Mar 19, 2026 at 08:58:52AM +0100, Markus Armbruster wrote:
> Sergei Heifetz <heifetz@yandex-team.com> writes:
> 
> > D-Bus display can be used even when QEMU is configured with
> > `--disable-audio`. In that case, audio interface will not be available
> > on `/org/qemu/Display1/Audio`.
> >
> > (The current handling of the situation when audio is enabled but
> > no D-Bus-compatible audio backend is available is different and
> > hasn’t been changed.)
> >
> > Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> > ---
> >  qapi/ui.json    | 2 +-
> >  qemu-options.hx | 4 ++++
> >  ui/dbus.c       | 8 ++++++++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index e3da77632a8..62eb05c6091 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -1385,7 +1385,7 @@
> >    'data'    : { '*rendernode' : 'str',
> >                  '*addr': 'str',
> >                  '*p2p': 'bool',
> > -                '*audiodev': 'str' } }
> > +                '*audiodev': { 'type': 'str', 'if': 'CONFIG_AUDIO' } } }
> 
> Is this a compatibility break?
> 
> DisplayDBus is only used in DisplayOptions, which is only used as return
> type of query-display-options in the QAPI schema.  However, vl.c also
> uses it to parse -display.
> 
> Removing parameter @audiodev from -display is technically a
> compatibility break.  However, we're removing an optional paramater that
> would always be rejected when present: it has no valid value, because
> there are no audiodevs.
> 
> Removal from query-display-options is similar: it could not be present.
> 
> Removal affects introspection, which could conceivably confuse client.
> I don't expect such trouble here, because @audiodev always existed, i.e.
> there's no real reason to look for it in introspection.
> 
> I think we're okay.  I'm cc'ing the libvirt list just in case.

Libvirt will almost always add -audiodev to all VMs, even if that
ends up being '-audiodev none'. For VNC it will always set the
audiodev property to resolve to this.  Essentially, given our
minimum QEMU version always supports -audiodev, libvirt assumes
it is always available.


> If it's not compiled in, then why document stuff that doesn't work?  How
> much of -audiodev still works then?  -audiodev none?  Anything else?

IMHO, we need -audiodev none to always works, and other parts of the
schema should continue to accept audiodev.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


