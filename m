Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE9AFD376C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHS4-00031R-87; Wed, 25 Feb 2026 11:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHRj-0002zd-Cr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHRh-0003DV-B2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772035743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtF3wnOKrNKjrSLx2Zjy3timJyFNsRqbX2wrHtdPLDM=;
 b=S4RIjC83eMsWIAa92hcfgTc6BwC5qV8HzfXbbNw2JRa9y9R+QuRsuCYrPUx/4/kmZH4av3
 4ebj5hEkfjNzzo5x8+9tc15kjtRCvHvgJpyVFcpvKhHxGHYz8xUM5kVHVWbgoPHeJPNlnP
 DiZcMDg7Yn80kDotuxxMp9kjPmyJfew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-lHhf81eSOy-cGj09rJ53HQ-1; Wed,
 25 Feb 2026 11:09:01 -0500
X-MC-Unique: lHhf81eSOy-cGj09rJ53HQ-1
X-Mimecast-MFC-AGG-ID: lHhf81eSOy-cGj09rJ53HQ_1772035739
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FD781855148; Wed, 25 Feb 2026 16:08:36 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A42AD19560B6; Wed, 25 Feb 2026 16:08:30 +0000 (UTC)
Date: Wed, 25 Feb 2026 16:08:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 14/27] ui: add proper error reporting for password
 changes
Message-ID: <aZ8ee8lb1NeD0GcT@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-15-berrange@redhat.com>
 <87seayckwu.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87seayckwu.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On Wed, Feb 18, 2026 at 01:10:09PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Neither the VNC or SPICE code for password changes provides error
> > reporting at source, leading the callers to report a largely useless
> > generic error message.
> >
> > Fixing this removes one of the two remaining needs for the undesirable
> > error_printf_unless_qmp() method.
> >
> > While fixing this the error message hint is improved to recommend the
> > 'password-secret' option which allows securely passing a password at
> > startup.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  include/ui/console.h                 |  2 +-
> >  include/ui/qemu-spice-module.h       |  3 ++-
> >  tests/functional/generic/test_vnc.py |  4 ++--
> >  ui/spice-core.c                      | 25 ++++++++++++++++++-------
> >  ui/spice-module.c                    |  7 ++++---
> >  ui/ui-qmp-cmds.c                     | 19 ++++++-------------
> >  ui/vnc-stubs.c                       |  6 +++---
> >  ui/vnc.c                             | 10 +++++++---
> >  8 files changed, 43 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 98feaa58bd..3677a9d334 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -457,7 +457,7 @@ void qemu_display_help(void);
> >  void vnc_display_init(const char *id, Error **errp);
> >  void vnc_display_open(const char *id, Error **errp);
> >  void vnc_display_add_client(const char *id, int csock, bool skipauth);
> > -int vnc_display_password(const char *id, const char *password);
> > +int vnc_display_password(const char *id, const char *password, Error **errp);
> >  int vnc_display_pw_expire(const char *id, time_t expires);
> >  void vnc_parse(const char *str);
> >  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
> > diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
> > index 1f22d557ea..072efa0c83 100644
> > --- a/include/ui/qemu-spice-module.h
> > +++ b/include/ui/qemu-spice-module.h
> > @@ -29,7 +29,8 @@ struct QemuSpiceOps {
> >      void (*display_init)(void);
> >      int (*migrate_info)(const char *h, int p, int t, const char *s);
> >      int (*set_passwd)(const char *passwd,
> > -                      bool fail_if_connected, bool disconnect_if_connected);
> > +                      bool fail_if_connected, bool disconnect_if_connected,
> > +                      Error **errp);
> >      int (*set_pw_expire)(time_t expires);
> >      int (*display_add_client)(int csock, int skipauth, int tls);
> >  #ifdef CONFIG_SPICE
> > diff --git a/tests/functional/generic/test_vnc.py b/tests/functional/generic/test_vnc.py
> > index f1dd1597cf..097f858ca1 100755
> > --- a/tests/functional/generic/test_vnc.py
> > +++ b/tests/functional/generic/test_vnc.py
> > @@ -48,7 +48,7 @@ def test_no_vnc_change_password(self):
> >          self.assertEqual(set_password_response['error']['class'],
> >                           'GenericError')
> >          self.assertEqual(set_password_response['error']['desc'],
> > -                         'Could not set password')
> > +                         'No VNC display is present');
> >  
> >      def launch_guarded(self):
> >          try:
> > @@ -73,7 +73,7 @@ def test_change_password_requires_a_password(self):
> >          self.assertEqual(set_password_response['error']['class'],
> >                           'GenericError')
> >          self.assertEqual(set_password_response['error']['desc'],
> > -                         'Could not set password')
> > +                         'VNC password authentication is disabled')
> >  
> >      def test_change_password(self):
> >          self.set_machine('none')
> > diff --git a/ui/spice-core.c b/ui/spice-core.c
> > index 8a6050f4ae..cdcec34f67 100644
> > --- a/ui/spice-core.c
> > +++ b/ui/spice-core.c
> > @@ -756,7 +756,7 @@ static void qemu_spice_init(void)
> >                               tls_ciphers);
> >      }
> >      if (password) {
> > -        qemu_spice.set_passwd(password, false, false);
> > +        qemu_spice.set_passwd(password, false, false, NULL);
> 
> qemu_spice.set_passwd is qemu_spice_set_passwd().  It's converted to
> Error below.  That conversion doesn't replace error reporting, it only
> adds.  Therefore, passing NULL does not lose error reporting here.
> Good.
> 
> However, why is ignoring errors okay here?  Not this patch's fault, of
> course.

IIUC There are two scenarios qemu_spice_set_passwd can fail

 * The password auth method is not enabled
     -> minor config bug, but we should report that error
 * The fail_if_conn is true and a client is connected
     -> impossible scenario during startup, fine to ignore



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


