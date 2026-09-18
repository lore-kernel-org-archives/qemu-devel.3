Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5DDC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Yqa-00020N-HP; Fri, 18 Sep 2026 09:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7YqY-000200-86
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7YqW-0002d9-Ca
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789738903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA+YtUCi0+i0hv6NQ/TTYdlAyqtE/zN8XZqq/DhWBp0=;
 b=drTdKTH0xRN5Sew06FAoEOEwM921o3pV5nvd5gb0O2ndIM+PwnkvXJlK0wxgrZoodjqe+r
 qMg3NAnzOSWjvzSuTm3+uv+2bTDg1c4v/RxXJxXe3+xke+9ERnzNM6gQ0ONCRms3Vq4gbk
 vXqg4Ea+Q2vEht9u42PP8p1qmDgA2z0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-J9rM3IC1M6mZBMg18RdtrA-1; Fri, 18 Sep 2026 09:41:41 -0400
X-MC-Unique: J9rM3IC1M6mZBMg18RdtrA-1
X-Mimecast-MFC-AGG-ID: J9rM3IC1M6mZBMg18RdtrA_1789738901
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso16168106d6.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789738901; x=1790343701; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fA+YtUCi0+i0hv6NQ/TTYdlAyqtE/zN8XZqq/DhWBp0=;
 b=T8NkxY1Ijd6jfWNRKvH8qdeIn8HJ0RAoQeqOa5nUWvnoSKDsIGRx53lznEt0T0lrzr
 s22TRMvknKOJxMw1/ihe4ygdCF+fttArOJpVrRr26v3xKT7cgE7qXelEaJtwi2WCEvna
 oYfp4PDfhVqP5k+UzuJvXUGhY+bnPuiaofk7ZYWqQiMGV0Zmv8CT+zhXOiPB8Z93/ZpA
 UuGe71t1IlwK81p+elWMuVtBiKyK8gtoavmKxz9zuygFzN/YLY7GbLK24P0RMVDASGAY
 PALjHEXDoX6leg2lCoyY86cRvwKWKeXSMlt32MDvNIg6i9OOG3dU0AmZOqk+cLvrT3Fh
 9qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789738901; x=1790343701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fA+YtUCi0+i0hv6NQ/TTYdlAyqtE/zN8XZqq/DhWBp0=;
 b=nqvq+NRLU4bj3jWtaNHfsLHPw7bOjttMcd5rtvMRX/FYyEhwznk93kvgopfgfDeIjk
 r4LY/DEKPh7OMdHoLZdLdL8/9lki+JSOebbONIqDHEUFLYHZELYhuJ7j/OrUZDmhfUw1
 7Hh2iGgxU+fPaT8JGZkCiNwCH1CmPppsHCuDreRZ5GZhUmkkTrCos/dlOVcAY6eP+mRt
 VJS6LakV7O0l2/3gzAOElHwEPD7rwre2SnMkq6DKyXLX81f6KKPRqxgmEKQwV2hbFjH3
 K7jlwc+5NS7ANUeyyoohz6vz0WXY1hxTQW88jlUmzWF32wIMI5fE/SwNa0jDrAXKtSwC
 xENA==
X-Gm-Message-State: AFuF++nn7JWZ/Pnq6Bu5cVmBGdos9kC5X+BEHrNkZBJChfrmI6WMioMr
 9Ok1RU2+s6Mq2ntwn9O/ovExYrdDT/1hM7rJgeXKltbGZMRdKKEkrVTWCFlaiRZpcBGrUwmygcb
 7fvYqsNVK3a6I+jOAY1Af8jLJEUBm0p4UHsAQsgtsM4nrrIn0Kt0UjFZv
X-Gm-Gg: AYBFou12yyHnkaDAIt5rJXKE/tcHnkb1eVcbAmfolxBPBAVl3Z4DOlZg4M2H0vkUo7h
 oB6JZoBCItZCk7DxX8UZb2kCC0sgid7UVzC6yOHAfWVLoktNTvJ6E1/DSAqhGfp9RVumRje4C6+
 VSpeVGRfL7gNpusvTrfNnKyBoiyu4j8I3/7VbmyumbODpvqlyEO+CMS6xSvnRjqXQkrSWOfup/B
 3qqC3tda6ye8iYV3drmsg+NSZC6ocRUxQZiPNKtHS3qKITBDjYreoU0fekaV+/dvFiqEl23lCtR
 1wlye/FMhibSc9GSMVC54nKjeJyHYgsR8TPj8GtnqP+zGJFonKaPKDmw/JzkjSGHD/bZqEk=
X-Received: by 2002:a05:620a:44d4:b0:939:a45b:76ee with SMTP id
 af79cd13be357-93bdc70bf55mr372481785a.23.1789738900959; 
 Fri, 18 Sep 2026 06:41:40 -0700 (PDT)
X-Received: by 2002:a05:620a:44d4:b0:939:a45b:76ee with SMTP id
 af79cd13be357-93bdc70bf55mr372473185a.23.1789738900043; 
 Fri, 18 Sep 2026 06:41:40 -0700 (PDT)
Received: from localhost ([2605:8d80:6cca:5143:ebc:a1f4:364f:cf43])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93be0efd37bsm141509485a.38.2026.09.18.06.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:41:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:41:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PULL 04/11] xen-mapcache: Remove 32bit support
Message-ID: <aq0_kJXNWJv_rjzh@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918113926.831204-1-peterx@redhat.com>
 <20260918113926.831204-5-peterx@redhat.com>
 <0bf76f4f-8762-4e28-9964-479400e8ec76@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bf76f4f-8762-4e28-9964-479400e8ec76@citrix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 18, 2026 at 02:14:26PM +0100, Ross Lagerwall wrote:
> On 9/18/26 12:39 PM, Peter Xu wrote:
> > QEMU has switched to 64bit-only hosts for all system emulations.
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Link: https://lore.kernel.org/r/20260818172012.3052821-5-peterx@redhat.com
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony PERARD <anthony@xenproject.org>
> > Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> > Cc: xen-devel@lists.xenproject.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   hw/xen/xen-mapcache.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index 85cf0cf359..e30c07c2ee 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -26,11 +26,7 @@
> >   #include <xenevtchn.h>
> >   #include <xengnttab.h>
> > -#if HOST_LONG_BITS == 32
> > -#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
> > -#else
> > -#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
> > -#endif
> > +#define MCACHE_MAX_SIZE     (1UL << 35) /* 32GB Cap */
> >   /* This is the size of the virtual address space reserve to QEMU that will not
> >    * be use by MapCache.
> > @@ -151,11 +147,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
> >           exit(EXIT_FAILURE);
> >       }
> > -    if (HOST_LONG_BITS == 32) {
> > -        bucket_shift = 16;
> > -    } else {
> > -        bucket_shift = 20;
> > -    }
> > +    bucket_shift = 20;
> >       if (geteuid() == 0) {
> >           rlimit_as.rlim_cur = RLIM_INFINITY;
> 
> Using a local variable here to store a constant is a bit weird and its only use
> is to be stored as MapCache.bucket_shift and MapCache.bucket_size which are
> effectively constant. Not sure why this isn't just a couple of #defines at the
> top and used everywhere bucket_shift and bucket_size is needed. Perhaps that is
> further cleanup to be done separately...

True..

It's my bad not noticing that relevant people were not properly copied when
sending the patches; I thought each patch will have its own set of CC from
get_maintainers.pl, but it didn't actually work and I didn't notice.  I
only notice it when I was just to send a pull, hence added Cc: explicitly
at least in the pull sent, feeling that these changes are mostly cosmotic
and safe.

It'll be great if this can be done separately, makes me easier.  If there's
any strong feeling on any of the changes, please speak and then I'll redo
the work.

Thanks,

-- 
Peter Xu


