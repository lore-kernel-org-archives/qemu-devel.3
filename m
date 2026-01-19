Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917A2CA6003
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkKy-00063K-MJ; Mon, 19 Jan 2026 03:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhkKo-0005x2-W9
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhkKm-00005C-Lg
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768810197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2JObDdSAddyg/9vMXuIQDuy7I+a/1x5Fh40EN9toK8=;
 b=cJQYl4p3Lwy8nPxhy4ohrgOn+EW9p3moMcLsWnROSiH4PPVg3STtZ4cAmeLF83hMwnScUy
 Gg3C2Ogg3Qd9FWU4GQcgKqpiNr4H3peIvRcHcVdxzoJcMfolk2R7o0YQaN8IO+FIwM8XBv
 5oBskcUhmpalVT0VCY9C5PcIjYy3/8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-rlyw3urdPRyDZ8aKDJ1HGg-1; Mon,
 19 Jan 2026 03:09:54 -0500
X-MC-Unique: rlyw3urdPRyDZ8aKDJ1HGg-1
X-Mimecast-MFC-AGG-ID: rlyw3urdPRyDZ8aKDJ1HGg_1768810192
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADB5719560A2; Mon, 19 Jan 2026 08:09:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0CA31955F22; Mon, 19 Jan 2026 08:09:49 +0000 (UTC)
Date: Mon, 19 Jan 2026 08:09:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/11] plugins: factorize plugin dependencies and
 library details
Message-ID: <aW3myeSBKTZLUA3o@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-3-pierrick.bouvier@linaro.org>
 <aWotkyT7pmw3RKh8@redhat.com>
 <fa736dbe-6a3b-4e17-87bc-39cae8d8e475@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa736dbe-6a3b-4e17-87bc-39cae8d8e475@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, Jan 16, 2026 at 04:02:50PM -0800, Pierrick Bouvier wrote:
> On 1/16/26 4:22 AM, Daniel P. Berrangé wrote:
> > On Fri, Jan 02, 2026 at 01:47:15PM -0800, Pierrick Bouvier wrote:
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >   meson.build                   |  2 +-
> > >   contrib/plugins/meson.build   | 13 ++-----------
> > >   plugins/meson.build           | 15 ++++++++++++++-
> > >   tests/tcg/plugins/meson.build | 13 ++-----------
> > >   4 files changed, 19 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/meson.build b/meson.build
> > > index db87358d62d..3d6c6c702d0 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -4499,7 +4499,7 @@ if get_option('plugins')
> > >     if host_os == 'windows'
> > >       # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
> > >       # so that plugin authors can compile against it.
> > > -    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
> > > +    install_data(win32_qemu_plugin_api, install_dir: 'lib')
> > >     endif
> > >   endif
> > > diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> > > index 6f72b2ce0c9..8f9f0257ee5 100644
> > > --- a/contrib/plugins/meson.build
> > > +++ b/contrib/plugins/meson.build
> > > @@ -9,17 +9,8 @@ endif
> > >   t = []
> > >   if get_option('plugins')
> > >     foreach i : contrib_plugins
> > > -    if host_os == 'windows'
> > > -      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
> > > -                        include_directories: '../../include/qemu',
> > > -                        link_depends: [win32_qemu_plugin_api_lib],
> > > -                        link_args: win32_qemu_plugin_api_link_flags,
> > > -                        dependencies: glib)
> > > -    else
> > > -      t += shared_module(i, files(i + '.c'),
> > > -                        include_directories: '../../include/qemu',
> > > -                        dependencies: glib)
> > > -    endif
> > > +    t += shared_module(i, files(i + '.c'),
> > > +                      dependencies: plugins_deps)
> > 
> > Nit-pick - under-indented by 1 space. The orignal code had the
> > same bug, but lets not preserve it.
> > 
> > 
> > > diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> > > index a6e78438510..c58f2e382ae 100644
> > > --- a/tests/tcg/plugins/meson.build
> > > +++ b/tests/tcg/plugins/meson.build
> > > @@ -1,17 +1,8 @@
> > >   t = []
> > >   if get_option('plugins')
> > >     foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
> > > -    if host_os == 'windows'
> > > -      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
> > > -                        include_directories: '../../../include/qemu',
> > > -                        link_depends: [win32_qemu_plugin_api_lib],
> > > -                        link_args: win32_qemu_plugin_api_link_flags,
> > > -                        dependencies: glib)
> > > -    else
> > > -      t += shared_module(i, files(i + '.c'),
> > > -                        include_directories: '../../../include/qemu',
> > > -                        dependencies: glib)
> > > -    endif
> > > +    t += shared_module(i, files(i + '.c'),
> > > +                      dependencies: plugins_deps)
> > 
> > Same under-indent by 1.
> > 
> > With the indents fixed:
> > 
> >    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> 
> Patch 3 already fixes the indent.

Please fix the problem in this patch since that is where it is first
present in this series. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


