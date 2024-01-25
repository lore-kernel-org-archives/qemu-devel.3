Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEFAC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 14:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT0p1-00062D-4E; Thu, 25 Jan 2024 09:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rT0oy-00060w-Qb
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 09:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rT0ow-0006Vf-Sc
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 09:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706193308;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6qf77vf4Whp7QoqqCS8zl/3FSO4WIkKe2N8YtJaa/cI=;
 b=FaZ1OI/Jtd64SiSAJ+kxTEHYuXJoIfne5jvVkjJPL4yjHCgl4XFiY4SBxHfgCR4+p5lMxj
 lL4IhGBZYcljsELpadwshgAn3CU3RVpU8asMGximd4thdvlZx5dnN+C7yy+RzffLW1PrFU
 Ksp065NTqEaKHJM/hG7h4MoBgNLNZ0E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-YCDWnPhNOIeRhhNbYkPy0A-1; Thu, 25 Jan 2024 09:35:05 -0500
X-MC-Unique: YCDWnPhNOIeRhhNbYkPy0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C87510726A2;
 Thu, 25 Jan 2024 14:35:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABB3751D5;
 Thu, 25 Jan 2024 14:35:04 +0000 (UTC)
Date: Thu, 25 Jan 2024 14:35:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>,
 "Maydell, Peter" <peter.maydell@linaro.org>
Subject: Re: Do we still need pre-meson compatibility hacks?
Message-ID: <ZbJxlgqwkRdmdYmB@redhat.com>
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

On Thu, Jan 25, 2024 at 08:54:09AM +0100, Paolo Bonzini wrote:
> Right now configure contains a couple hacks to preserve some of the
> semantics of the pre-meson build system:
> 
> 1) emulation of ./configure by creating a build directory and a forwarding
> GNUmakefile (requested by Kevin)
> 
> 2) creation of symlinks such as x86_64-softmmu/qemu-system-x86_64 and
> arm-linux-user/qemu-arm (requested by Peter)
> 
> Neither of these are a lot of code, but if people aren't relying on them we
> might as well delete them. Do they have any users still?

The latter feels redundant, but the former feels worthwhile as long as we
keep a wrapper cnofigure script around.

It seems like we're not far off being able to do a build with the normal
sequence of

  meson setup build
  meson compile -C build

The creation of the config-host.mak and config-host.h files looks like
the big one. I feel like config-host.mak ought not to even exist. Meson
only consumes a subset of values written into that AFAICT:

$ git grep 'config_host\b'
meson.build:config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
meson.build:target_dirs = config_host['TARGET_DIRS'].split()
meson.build:default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
meson.build:if config_host.has_key('GDB')
meson.build:  summary_info += {'gdb':             config_host['GDB']}
meson.build:summary_info += {'genisoimage':       config_host['GENISOIMAGE']}

and I would have thought meson could detect 'gdb' / 'genisoimage' itself,
and have a meson cli option for target_dirs / default_targets.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


