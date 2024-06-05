Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06DC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmPF-00075r-Ka; Wed, 05 Jun 2024 04:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEmPE-00075E-7V
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEmPB-0003X8-Pm
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717577640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7o+AyQgR2MpRFU0rryvqeWe0qw66x3Zk2WuQ/OVTKE=;
 b=YG4Hkd9rGB/M59oH2DkLfMBO/SjPa/VdEsWbZQ7U/ryUXp48uSFKAI/jRUnFo+ed9PWlc+
 xfy9ZFVnzccTnFonJ98VVC468lQSyHd223FBVVGM5Cn8URLY0tzrtTVQmw2XbfdQ9dh2R+
 ByH0dsPyTRftoV8ZrTWu5xZMPSu6uQ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-eIZuSlZnMk-8hBB8PZb6Hw-1; Wed,
 05 Jun 2024 04:53:57 -0400
X-MC-Unique: eIZuSlZnMk-8hBB8PZb6Hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E96793C025B1;
 Wed,  5 Jun 2024 08:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0E4FF02;
 Wed,  5 Jun 2024 08:53:55 +0000 (UTC)
Date: Wed, 5 Jun 2024 09:53:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/20] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
Message-ID: <ZmAnoPgv53noaNmk@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-8-berrange@redhat.com>
 <CAJ+F1CLhfHTnivCcCfOSEYw2nNsTrcgqx+iALRsWf9DbKjhmEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLhfHTnivCcCfOSEYw2nNsTrcgqx+iALRsWf9DbKjhmEg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 05, 2024 at 12:47:39PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 4, 2024 at 5:50 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > Defining these at the meson level allows them to be used a conditional
> > tests in the QAPI schemas.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  meson.build           | 18 ++++++++++++++++++
> >  qga/commands-common.h |  9 ---------
> >  2 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 6386607144..356b2a4817 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2141,6 +2141,22 @@ have_virtfs_proxy_helper =
> > get_option('virtfs_proxy_helper') \
> >      .require(libcap_ng.found(), error_message: 'the virtfs proxy helper
> > requires libcap-ng') \
> >      .allowed()
> >
> > +qga_fsfreeze = false
> > +qga_fstrim = false
> > +if host_os == 'windows'
> > +    qga_fsfreeze = true
> > +    qga_fstrim = true
> >
> 
> The hook code in qga/main.c compiles for win32, but it is not used. Did you
> intentionally enabled that?

Oh whoops, yes, that is an oversight. I was initially thinking
that CONFIG_FSFREEZE was used in commands-win32.c, since it has
a freeze impl, but I forgot I later learnt it was unconditional.
So we don't need to set these for meson vars for windows.

> 
> +elif host_os == 'linux'
> > +    if cc.has_header_symbol('linux/fs.h', 'FIFREEZE')
> > +        qga_fsfreeze = true
> > +    endif
> > +    if cc.has_header_symbol('linux/fs.h', 'FITRIM')
> > +        qga_fstrim = true
> > +    endif
> > +elif host_os == 'freebsd' and cc.has_header_symbol('ufs/ffs/fs.h',
> > 'UFSSUSPEND')
> > +    qga_fsfreeze = true
> > +endif
> > +
> >  if get_option('block_drv_ro_whitelist') == ''
> >    config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
> >  else
> > @@ -2375,6 +2391,8 @@ config_host_data.set('CONFIG_DEBUG_TCG',
> > get_option('debug_tcg'))
> >  config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
> >  config_host_data.set('CONFIG_QOM_CAST_DEBUG',
> > get_option('qom_cast_debug'))
> >  config_host_data.set('CONFIG_REPLICATION',
> > get_option('replication').allowed())
> > +config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
> > +config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
> >
> >  # has_header
> >  config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
> > diff --git a/qga/commands-common.h b/qga/commands-common.h
> > index 8c1c56aac9..263e7c0525 100644
> > --- a/qga/commands-common.h
> > +++ b/qga/commands-common.h
> > @@ -15,19 +15,10 @@
> >
> >  #if defined(__linux__)
> >  #include <linux/fs.h>
> > -#ifdef FIFREEZE
> > -#define CONFIG_FSFREEZE
> > -#endif
> > -#ifdef FITRIM
> > -#define CONFIG_FSTRIM
> > -#endif
> >  #endif /* __linux__ */
> >
> >  #ifdef __FreeBSD__
> >  #include <ufs/ffs/fs.h>
> > -#ifdef UFSSUSPEND
> > -#define CONFIG_FSFREEZE
> > -#endif
> >  #endif /* __FreeBSD__ */
> >
> >  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
> > --
> > 2.45.1
> >
> >
> >
> 
> -- 
> Marc-André Lureau

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


