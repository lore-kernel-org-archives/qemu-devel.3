Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622EFC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQal-00059Q-Ro; Tue, 18 Feb 2025 11:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkQaW-00056S-RC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkQaU-0002Cv-3v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739896603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6B3dpA5+FyAf3b1nXZlew/K+efL2wlMhh7BQM1SzDbY=;
 b=ViuRtQeizy18fP39m/jQcV4ZoO89yl5/016Vfs8EdkSu+reHVbe2AfbObBVJbIiz8d361T
 YP/niQm8lOh3KOsCG/jo2I38hUbtXoraLIMoAf8sgHP5UZ6X+ZIL3+j0vvNDRSc98CeSyh
 KnoYU43xN1DbgaclB3FWlk7ZKOKAF4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-MWvgu0Y6OFKBVLq39tlFJQ-1; Tue,
 18 Feb 2025 11:36:40 -0500
X-MC-Unique: MWvgu0Y6OFKBVLq39tlFJQ-1
X-Mimecast-MFC-AGG-ID: MWvgu0Y6OFKBVLq39tlFJQ_1739896599
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D188A19373DC; Tue, 18 Feb 2025 16:36:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9369819560AA; Tue, 18 Feb 2025 16:36:35 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:36:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 11/14] os: add an ability to lock memory on_fault
Message-ID: <Z7S3D_JYdayPhVVd@redhat.com>
References: <20250212173823.214429-1-peterx@redhat.com>
 <20250212173823.214429-3-peterx@redhat.com>
 <Z6ze_muL8OkkuAFr@redhat.com> <Z6zg3jr4IUiIdHKG@x1.local>
 <Z6zicnbD1RRYfC3R@redhat.com> <Z60TvzQZQW3j4tiY@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z60TvzQZQW3j4tiY@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 12, 2025 at 04:33:51PM -0500, Peter Xu wrote:
> On Wed, Feb 12, 2025 at 06:03:30PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Feb 12, 2025 at 12:56:46PM -0500, Peter Xu wrote:
> > > On Wed, Feb 12, 2025 at 05:48:46PM +0000, Daniel P. Berrangé wrote:
> > > > On Wed, Feb 12, 2025 at 12:38:23PM -0500, Peter Xu wrote:
> > > > > From: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > > > 
> > > > > This will be used in the following commits to make it possible to only
> > > > > lock memory on fault instead of right away.
> > > > > 
> > > > > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > Link: https://lore.kernel.org/r/20250212143920.1269754-2-d-tatianin@yandex-team.ru
> > > > > [peterx: fail os_mlock(on_fault=1) when not supported]
> > > > > [peterx: use G_GNUC_UNUSED instead of "(void)on_fault", per Dan]
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  meson.build               |  6 ++++++
> > > > >  include/system/os-posix.h |  2 +-
> > > > >  include/system/os-win32.h |  2 +-
> > > > >  migration/postcopy-ram.c  |  2 +-
> > > > >  os-posix.c                | 15 +++++++++++++--
> > > > >  system/vl.c               |  2 +-
> > > > >  6 files changed, 23 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/meson.build b/meson.build
> > > > > index 18cf9e2913..59953cbe6b 100644
> > > > > --- a/meson.build
> > > > > +++ b/meson.build
> > > > > @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
> > > > >      return mlockall(MCL_FUTURE);
> > > > >    }'''))
> > > > >  
> > > > > +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
> > > > > +  #include <sys/mman.h>
> > > > > +  int main(void) {
> > > > > +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
> > > > > +  }'''))
> > > > > +
> > > > >  have_l2tpv3 = false
> > > > >  if get_option('l2tpv3').allowed() and have_system
> > > > >    have_l2tpv3 = cc.has_type('struct mmsghdr',
> > > > > diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> > > > > index b881ac6c6f..ce5b3bccf8 100644
> > > > > --- a/include/system/os-posix.h
> > > > > +++ b/include/system/os-posix.h
> > > > > @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
> > > > >  void os_set_chroot(const char *path);
> > > > >  void os_setup_limits(void);
> > > > >  void os_setup_post(void);
> > > > > -int os_mlock(void);
> > > > > +int os_mlock(bool on_fault);
> > > > >  
> > > > >  /**
> > > > >   * qemu_alloc_stack:
> > > > > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > > > > index b82a5d3ad9..bc623061d8 100644
> > > > > --- a/include/system/os-win32.h
> > > > > +++ b/include/system/os-win32.h
> > > > > @@ -123,7 +123,7 @@ static inline bool is_daemonized(void)
> > > > >      return false;
> > > > >  }
> > > > >  
> > > > > -static inline int os_mlock(void)
> > > > > +static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
> > > > 
> > > > So did this actually generate a warning ? We don' even need
> > > > G_GNUC_UNUSED unless we're actually seeing warnings about this.
> > > 
> > > I didn't try to hit a warning without it, as we can use different compilers
> > > and I thought the results could be different, even if I try it and it
> > > didn't raise a warning?
> > 
> > We strictly only permit use of clang & gcc.
> 
> I meant I am also not sure whether the versions could matter.. Totally not
> expert on compilers.  Hence I chose to be safe with the attribute applied,
> because I know it'll always be safe when with it.
> 
> I tried to grep QEMU code base:
> 
> $ git grep unused-parameter
> $ git grep -w Wall
> pc-bios/optionrom/Makefile:override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
> pc-bios/s390-ccw/Makefile:EXTRA_CFLAGS += -Wall
> tests/multiboot/Makefile:CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
> tests/tcg/Makefile.target:CFLAGS+=-Wall -Werror -O0 -g -fno-strict-aliasing
> tests/tcg/mips/user/isa/r5900/Makefile:CFLAGS  = -Wall -mabi=32 -march=r5900 -static
> 
> We don't seem to have explicit requirement on that (as I grepped nothing
> for "unused-parameter"), meanwhile indeed we also seem to have zero usage
> at least in qemu root with enabling -Wall.  I'm not sure whether other
> compiler option could matter here.
> 
> Can this be justifed as we can safely drop G_GNUC_UNUSED in this patch?
> 
> OTOH:
> 
> $ git grep G_GNUC_UNUSED | wc -l
> 169
> 
> So we have 169 existing such use cases.  Does it also mean we could
> potentially drop all of them?

Yes, or actually turn on the warning about unused params and mark
the rest. It is initially noisey, but IME does end up flagging
real problems periodically. Anyway, given we're inconsistent already
there's no need to respin this series.

> 
> It'll definitely be easier for me (and hopefully Stefan too..) if this can
> be done later, but I'm OK respin v3.
> 
> Dan, do you have any preference / suggestion?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


