Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFA0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKN8-0004Ig-92; Wed, 12 Feb 2025 16:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiKMs-0003kN-Lh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiKMq-0000Xy-D5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739396037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AREvRFQppCvvoFA88vGRlr+OTPh8ETVP2GFuONyLjQ=;
 b=K7wVHTxoj2PFpCN0bB8cGVdN9nDjwYoGb6P4rehObp7Kcx6GiNZGVpayEQMng6IjX1V7f1
 VAOYapZvoLkrdjZEptua0XxqrGdbjSXn1oVEMBRIY0tQek+DISqYOd3oqRZxwBFvSeKJwP
 sHQRr4AcapTY/SGZ+X2RlsgWUgXKe0E=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-jS6hd0FFMVGZSlRlGsCKyQ-1; Wed, 12 Feb 2025 16:33:56 -0500
X-MC-Unique: jS6hd0FFMVGZSlRlGsCKyQ-1
X-Mimecast-MFC-AGG-ID: jS6hd0FFMVGZSlRlGsCKyQ
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2addd5053bfso169584fac.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396035; x=1740000835;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AREvRFQppCvvoFA88vGRlr+OTPh8ETVP2GFuONyLjQ=;
 b=KOjr51joE2XIpjmuBo2rvUVnYLqcgHhhZs6DyKUN+y1bgwfA84bTIHM2jAhqo5dTqC
 y/Qhk4fQwgDIyROc4uGRc9kztHYFso8C2dBKSJlnVlui8GBUuDJBt2SHt7zmZhEuxRJ4
 hEMC/Hus2Rw2UvPgeSB5NEWQjCFZ13WwvdwEXc7+HvxI3qdeDXW/lXczkx2RbnYdnyG2
 VI3r7x0Mw7x82KGcBLCGzM5VOXBvql6SqPUq+p3ID4M7UdvE2cg5W8RvvR81rhGVWApB
 aR31k1eJ/vZPD4hChPn5W9l0fgSPUS4qYvHrAfdW7UyBkaLyI2U5Cwq6l/aJBYOwuW73
 Hn7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU52CYnMxYT5u2R3gcLl0FWfsK0YNdztSEPoy5LhtcTttEBWTH27/WREFyTQgqh2w7I/fa10UuFnEL8@nongnu.org
X-Gm-Message-State: AOJu0YyYSV8CcrVD8NVCdWAh36vG6k8CYDxmKKKDW7AFStYY/ykbiBHf
 0lcWknBhbihhOQhxR+EMJWir/EI6adYhsfN/433C+JktWFJk/6CionMCPvI0BtLHw/1EUpKOQoe
 f+rH8BABFgQm3RaFt1b15S1NSKgwV4Um+QZ2w+eatrevgc8yOk/RI
X-Gm-Gg: ASbGncsaaEBTcpyh/rSooNZ38VaY3B1ctd+udISvVMau/0SEgtnV7uXqwIPI9mu8Vet
 Qh1pxId05BQVVJleEsQRkE8odmNJ3zGHz8XRZW1IxB0M1L5m44tDIkWoc0w8hHgWwRpczYyWfKp
 3snp2f//JN4ful7oS6uQpypmmPgczYyXGAYx6xRBwzAfyxdLHNgDZZ2UT7BLCy+3Xr+tmRSiyqK
 aZaPgDOOfxDtfeGfTMYdNbldPVDhVbyipVgHpdaHZ7ZtTmZLjnjTzuew8E=
X-Received: by 2002:a05:6871:e494:b0:29d:cc2e:8493 with SMTP id
 586e51a60fabf-2b8f8f3c2damr489283fac.26.1739396035662; 
 Wed, 12 Feb 2025 13:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5Xc3NMhZlEeEZ943pSAs3Ag7x4gwT5s4C7CVaN3aMBME3uXMLROxq72I72P5utuLfPnNOiw==
X-Received: by 2002:a05:6871:e494:b0:29d:cc2e:8493 with SMTP id
 586e51a60fabf-2b8f8f3c2damr489274fac.26.1739396035373; 
 Wed, 12 Feb 2025 13:33:55 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b89b6dee3asm3278884fac.47.2025.02.12.13.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 13:33:54 -0800 (PST)
Date: Wed, 12 Feb 2025 16:33:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 11/14] os: add an ability to lock memory on_fault
Message-ID: <Z60TvzQZQW3j4tiY@x1.local>
References: <20250212173823.214429-1-peterx@redhat.com>
 <20250212173823.214429-3-peterx@redhat.com>
 <Z6ze_muL8OkkuAFr@redhat.com> <Z6zg3jr4IUiIdHKG@x1.local>
 <Z6zicnbD1RRYfC3R@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6zicnbD1RRYfC3R@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 12, 2025 at 06:03:30PM +0000, Daniel P. Berrangé wrote:
> On Wed, Feb 12, 2025 at 12:56:46PM -0500, Peter Xu wrote:
> > On Wed, Feb 12, 2025 at 05:48:46PM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Feb 12, 2025 at 12:38:23PM -0500, Peter Xu wrote:
> > > > From: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > > 
> > > > This will be used in the following commits to make it possible to only
> > > > lock memory on fault instead of right away.
> > > > 
> > > > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > Link: https://lore.kernel.org/r/20250212143920.1269754-2-d-tatianin@yandex-team.ru
> > > > [peterx: fail os_mlock(on_fault=1) when not supported]
> > > > [peterx: use G_GNUC_UNUSED instead of "(void)on_fault", per Dan]
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  meson.build               |  6 ++++++
> > > >  include/system/os-posix.h |  2 +-
> > > >  include/system/os-win32.h |  2 +-
> > > >  migration/postcopy-ram.c  |  2 +-
> > > >  os-posix.c                | 15 +++++++++++++--
> > > >  system/vl.c               |  2 +-
> > > >  6 files changed, 23 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/meson.build b/meson.build
> > > > index 18cf9e2913..59953cbe6b 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
> > > >      return mlockall(MCL_FUTURE);
> > > >    }'''))
> > > >  
> > > > +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
> > > > +  #include <sys/mman.h>
> > > > +  int main(void) {
> > > > +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
> > > > +  }'''))
> > > > +
> > > >  have_l2tpv3 = false
> > > >  if get_option('l2tpv3').allowed() and have_system
> > > >    have_l2tpv3 = cc.has_type('struct mmsghdr',
> > > > diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> > > > index b881ac6c6f..ce5b3bccf8 100644
> > > > --- a/include/system/os-posix.h
> > > > +++ b/include/system/os-posix.h
> > > > @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
> > > >  void os_set_chroot(const char *path);
> > > >  void os_setup_limits(void);
> > > >  void os_setup_post(void);
> > > > -int os_mlock(void);
> > > > +int os_mlock(bool on_fault);
> > > >  
> > > >  /**
> > > >   * qemu_alloc_stack:
> > > > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > > > index b82a5d3ad9..bc623061d8 100644
> > > > --- a/include/system/os-win32.h
> > > > +++ b/include/system/os-win32.h
> > > > @@ -123,7 +123,7 @@ static inline bool is_daemonized(void)
> > > >      return false;
> > > >  }
> > > >  
> > > > -static inline int os_mlock(void)
> > > > +static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
> > > 
> > > So did this actually generate a warning ? We don' even need
> > > G_GNUC_UNUSED unless we're actually seeing warnings about this.
> > 
> > I didn't try to hit a warning without it, as we can use different compilers
> > and I thought the results could be different, even if I try it and it
> > didn't raise a warning?
> 
> We strictly only permit use of clang & gcc.

I meant I am also not sure whether the versions could matter.. Totally not
expert on compilers.  Hence I chose to be safe with the attribute applied,
because I know it'll always be safe when with it.

I tried to grep QEMU code base:

$ git grep unused-parameter
$ git grep -w Wall
pc-bios/optionrom/Makefile:override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
pc-bios/s390-ccw/Makefile:EXTRA_CFLAGS += -Wall
tests/multiboot/Makefile:CCFLAGS=-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc -fno-builtin
tests/tcg/Makefile.target:CFLAGS+=-Wall -Werror -O0 -g -fno-strict-aliasing
tests/tcg/mips/user/isa/r5900/Makefile:CFLAGS  = -Wall -mabi=32 -march=r5900 -static

We don't seem to have explicit requirement on that (as I grepped nothing
for "unused-parameter"), meanwhile indeed we also seem to have zero usage
at least in qemu root with enabling -Wall.  I'm not sure whether other
compiler option could matter here.

Can this be justifed as we can safely drop G_GNUC_UNUSED in this patch?

OTOH:

$ git grep G_GNUC_UNUSED | wc -l
169

So we have 169 existing such use cases.  Does it also mean we could
potentially drop all of them?

It'll definitely be easier for me (and hopefully Stefan too..) if this can
be done later, but I'm OK respin v3.

Dan, do you have any preference / suggestion?

Thanks,

-- 
Peter Xu


