Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10BC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YK5-0004sL-VT; Mon, 07 Sep 2026 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3YK4-0004rO-AU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3YK0-0007Xd-5G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788783575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilfipd0aoXXr9zUcbM5+kwImNY82EPEKtPSPFb2m4rE=;
 b=Rup+7bw0UIQMXnUWk8ETHvCxOTzrIljAlszpnKSZ1S2dy6aPbhcOA1ln84IyXaNYh5gAQc
 i1LaXOGXMdGLrPvJ4ZDI7TUn435BtJUvpXpjkmykreRHnKlre29z3Y7kgsvVHLsmKaLJ86
 TYgFVpD/5SydScY/esjrQztR96l5xEs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-d97VfovpPwe44XqEDHm3cw-1; Mon,
 07 Sep 2026 08:19:32 -0400
X-MC-Unique: d97VfovpPwe44XqEDHm3cw-1
X-Mimecast-MFC-AGG-ID: d97VfovpPwe44XqEDHm3cw_1788783570
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E85131801BF7; Mon,  7 Sep 2026 12:19:29 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40E5318005AA; Mon,  7 Sep 2026 12:19:24 +0000 (UTC)
Date: Mon, 7 Sep 2026 13:19:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 02/10] tests/functional: add skipUnlessConfig() helper
Message-ID: <ap6ryb0M-16t0_6o@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
 <20260907-nohmp-v2-2-6d952d972c21@redhat.com>
 <3f5f77fc-05c9-4b26-8290-28b16dfd3be4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f5f77fc-05c9-4b26-8290-28b16dfd3be4@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 07, 2026 at 02:02:29PM +0200, Thomas Huth wrote:
>  Hi!
> 
> On 07/09/2026 12.30, Marc-André Lureau wrote:
> > Read config-host.h and skip tests that rely on some CONFIG_*
> > values.
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   tests/functional/qemu_test/__init__.py   |  2 +-
> >   tests/functional/qemu_test/decorators.py | 25 +++++++++++++++++++++++++
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> > index 03e5c73d39dc..e21fa8279281 100644
> > --- a/tests/functional/qemu_test/__init__.py
> > +++ b/tests/functional/qemu_test/__init__.py
> > @@ -16,7 +16,7 @@
> >   from .decorators import skipIfMissingCommands, skipIfNotMachine, \
> >       skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
> >       skipIfMissingImports, skipIfOperatingSystem, skipUnlessOperatingSystem, \
> > -    skipLockedMemoryTest, skipIfMissingEnv
> > +    skipLockedMemoryTest, skipIfMissingEnv, skipUnlessConfig
> >   from .archive import archive_extract
> >   from .uncompress import uncompress
> >   from .gdb import GDB
> > diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> > index aa135acc7857..7a7d30503440 100644
> > --- a/tests/functional/qemu_test/decorators.py
> > +++ b/tests/functional/qemu_test/decorators.py
> > @@ -10,6 +10,7 @@
> >   from unittest import skipIf, skipUnless
> >   from .cmd import which
> > +from .config import BUILD_DIR
> >   def skipIfMissingEnv(*vars_):
> > @@ -162,6 +163,30 @@ def skipIfMissingImports(*args):
> >       return skipUnless(has_imports, 'required import(s) "%s" not installed' %
> >                                      ", ".join(args))
> > +def _read_config_host():
> > +    config = set()
> > +    with open(BUILD_DIR / "config-host.h", "r") as f:
> > +        for line in f:
> > +            if line.startswith("#define CONFIG_"):
> > +                name = line.split()[1].removeprefix("CONFIG_")
> > +                config.add(name)
> > +    return config
> > +
> > +_CONFIG_HOST = _read_config_host()
> 
> This always reads in config-host.h, also for tests that don't need the
> decorator ... could you change it so that the file is only read (once) if a
> test calls the skipUnlessConfig decorator?
> 
> Also I'm a little bit torn whether we really need a decorator for this or
> whether we should rather fence the tests in meson.build instead (similar to
> what we do in tests/qtest/meson.build with config_all_devices.has_key('...')
> already). What do others think about this?

QMP provides a way to query what functionality it exposes, so
it should be possible to query upfront when the "screenshot"
command is exposed or not. So IMHO reading config-host.h is a
a mistake - if it were needed, it would be a sign that QMP
was missing something, because the functional tests should
be thought of the same way as a mgmt application.

Personally I'd not bother trying to query the QMP schema though,
just keep the test written the way it already works, and catch
the QMP  error for "CommandNotFound" instead or parsing HMP
output.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


