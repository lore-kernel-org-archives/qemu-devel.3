Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1D1C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiH5U-0001Rz-GS; Wed, 12 Feb 2025 13:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiH5P-0001R5-8j
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiH5N-0001cb-DQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739383424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ebDOWzZutWDYuZyIQcf/VBv7HHqdJRd+jDc0sscLL8=;
 b=Yz5Yj61/ZL5MC9IBsj3x9IZR19Jao0QvpYk6mvgd86I5ZZxcLdl+6YtSknHMjZNWXbdGsj
 ANYpANX6FzAT5tKfJoM4v/mXc2qBRtMFkbTzw0JXnN6ffWL7EMDrU5G0B8RfCPmH0zgl9s
 5856rFu6aEVHW+58pu+nL7gTYpzUR30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-kITGtQepPIiuReY-PStvCg-1; Wed,
 12 Feb 2025 13:03:40 -0500
X-MC-Unique: kITGtQepPIiuReY-PStvCg-1
X-Mimecast-MFC-AGG-ID: kITGtQepPIiuReY-PStvCg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A17B180087A; Wed, 12 Feb 2025 18:03:38 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B5319560A3; Wed, 12 Feb 2025 18:03:33 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:03:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 11/14] os: add an ability to lock memory on_fault
Message-ID: <Z6zicnbD1RRYfC3R@redhat.com>
References: <20250212173823.214429-1-peterx@redhat.com>
 <20250212173823.214429-3-peterx@redhat.com>
 <Z6ze_muL8OkkuAFr@redhat.com> <Z6zg3jr4IUiIdHKG@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6zg3jr4IUiIdHKG@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 12, 2025 at 12:56:46PM -0500, Peter Xu wrote:
> On Wed, Feb 12, 2025 at 05:48:46PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Feb 12, 2025 at 12:38:23PM -0500, Peter Xu wrote:
> > > From: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > 
> > > This will be used in the following commits to make it possible to only
> > > lock memory on fault instead of right away.
> > > 
> > > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > Link: https://lore.kernel.org/r/20250212143920.1269754-2-d-tatianin@yandex-team.ru
> > > [peterx: fail os_mlock(on_fault=1) when not supported]
> > > [peterx: use G_GNUC_UNUSED instead of "(void)on_fault", per Dan]
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  meson.build               |  6 ++++++
> > >  include/system/os-posix.h |  2 +-
> > >  include/system/os-win32.h |  2 +-
> > >  migration/postcopy-ram.c  |  2 +-
> > >  os-posix.c                | 15 +++++++++++++--
> > >  system/vl.c               |  2 +-
> > >  6 files changed, 23 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/meson.build b/meson.build
> > > index 18cf9e2913..59953cbe6b 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
> > >      return mlockall(MCL_FUTURE);
> > >    }'''))
> > >  
> > > +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
> > > +  #include <sys/mman.h>
> > > +  int main(void) {
> > > +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
> > > +  }'''))
> > > +
> > >  have_l2tpv3 = false
> > >  if get_option('l2tpv3').allowed() and have_system
> > >    have_l2tpv3 = cc.has_type('struct mmsghdr',
> > > diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> > > index b881ac6c6f..ce5b3bccf8 100644
> > > --- a/include/system/os-posix.h
> > > +++ b/include/system/os-posix.h
> > > @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
> > >  void os_set_chroot(const char *path);
> > >  void os_setup_limits(void);
> > >  void os_setup_post(void);
> > > -int os_mlock(void);
> > > +int os_mlock(bool on_fault);
> > >  
> > >  /**
> > >   * qemu_alloc_stack:
> > > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > > index b82a5d3ad9..bc623061d8 100644
> > > --- a/include/system/os-win32.h
> > > +++ b/include/system/os-win32.h
> > > @@ -123,7 +123,7 @@ static inline bool is_daemonized(void)
> > >      return false;
> > >  }
> > >  
> > > -static inline int os_mlock(void)
> > > +static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
> > 
> > So did this actually generate a warning ? We don' even need
> > G_GNUC_UNUSED unless we're actually seeing warnings about this.
> 
> I didn't try to hit a warning without it, as we can use different compilers
> and I thought the results could be different, even if I try it and it
> didn't raise a warning?

We strictly only permit use of clang & gcc.

> I do see though that we have plenty of such uses in the current tree,
> though.  Does it mean it's a broader question to ask, rather than this
> patch only?
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


