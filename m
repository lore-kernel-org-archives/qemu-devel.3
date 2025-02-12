Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C049C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGyp-0005yC-7u; Wed, 12 Feb 2025 12:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGym-0005u2-UM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGyl-0000TR-83
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739383013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rq+IJ9mMrbZWZxeyyd23M4uqOZiAmB/24b5/9uaNhQ=;
 b=f/Lriqz+zb0VuGDfZ6Aclb6eYm4jku623xiixCFobIRVC2V8FHpt+dtS/H6sogvLzW8wtL
 0qHbpL7Em0JaC5qiynt1/h5TYNG9tZQchJ3/cfTL9no+xz4q6EZkdna4xy74LR8jMfuana
 dxXzJpoSCMDFQm11JWnQsdFbE7BBv0A=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Q6CsjLbAMpeqNSjpmZ9bEQ-1; Wed, 12 Feb 2025 12:56:52 -0500
X-MC-Unique: Q6CsjLbAMpeqNSjpmZ9bEQ-1
X-Mimecast-MFC-AGG-ID: Q6CsjLbAMpeqNSjpmZ9bEQ
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2b840a047f6so65408fac.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383011; x=1739987811;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Rq+IJ9mMrbZWZxeyyd23M4uqOZiAmB/24b5/9uaNhQ=;
 b=Z9YsQw0mRS/NuwH9bCZ4xpDUSWs5AB72qBZToAbSmTOWTelzi+NhyHuvo0LIEPbqg+
 LZkG3aqLDE6hWJjNLyek6EoCjhNdIUF+uiRrkRoysWIbUn92rc7XjrU29bRGppwxTcwt
 jMPPJwNNzIBY+bN0mRaS0oHPBI0B7U4HT8wGNBoB6w2rje5FJ6c3ayL/I6PyOcsuVauL
 iCDHzR0L4eZft0bnluWmim7uFwvkF99D4VSNtWpzHXZcJnV0hSkJk/k4KVBQKsSBbpbC
 uZs5TgSuhKjHL+S74ZDKSaxnn1/z8AKrvfUt/HaZdmWBqxErwCOiJ7BNH2EzDVwk9kNw
 UN2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhteEvuenztX58yiK7IBusJ/2g3mHWfNAXasQMu+BS3XfB+i+l2JO7WNwhV9/bGVu2mOTeiguGlKdz@nongnu.org
X-Gm-Message-State: AOJu0YzlcIUpANxvsSaCbhBXsx2OJOY4TBreWvTUA2a4ZBYsXc/GjGCT
 X7XiuXN8n2rvAQAs3Uhj/Epi+0ka+4bNvhkgIntdhb82iQM9wt+B/xO057IbCEUEa24YlMh6sHt
 Cr1K05BmkuBF06rM5CA024ms9p+TbVKDZ5DjmVA3Q5YLrJXm743j1
X-Gm-Gg: ASbGnctn0WYO84fiMdfEsx4nci3rZh7nop1EhO0+N2YklFHeGlTEM6eqnMrgwNI/tEu
 qqIG5Q5iekRDGSrKxtGV7Fn84ABRK7ic+irYAlW2Yjbp+3sDk8YnNJka37zecXlZd4l9DKvRpPb
 wEmX4jz9NWxP3PZQSp2hrxKaHR+WCNFbFRRHDtE2cZoDtCE//L7YOW7h9HtZC39IuYdUlcUCAAk
 OLe003b/Q7zzqZ7gIaop2RS9f2NTTeKCqjA7CYRDCWZjEqq2r1f6SKnDYw=
X-Received: by 2002:a05:6870:5692:b0:2a3:be8a:eebb with SMTP id
 586e51a60fabf-2b8d68adce9mr2841749fac.35.1739383011637; 
 Wed, 12 Feb 2025 09:56:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiSj85wm44LDh949Y6lvvlHvqFfN4QhZjy1Qa3XSnWLZeJQeZLkpqM7nB39uDk9p7tfv6lTg==
X-Received: by 2002:a05:6870:5692:b0:2a3:be8a:eebb with SMTP id
 586e51a60fabf-2b8d68adce9mr2841679fac.35.1739383010145; 
 Wed, 12 Feb 2025 09:56:50 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b86ca870casm3850202fac.50.2025.02.12.09.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 09:56:49 -0800 (PST)
Date: Wed, 12 Feb 2025 12:56:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 11/14] os: add an ability to lock memory on_fault
Message-ID: <Z6zg3jr4IUiIdHKG@x1.local>
References: <20250212173823.214429-1-peterx@redhat.com>
 <20250212173823.214429-3-peterx@redhat.com>
 <Z6ze_muL8OkkuAFr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6ze_muL8OkkuAFr@redhat.com>
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

On Wed, Feb 12, 2025 at 05:48:46PM +0000, Daniel P. Berrangé wrote:
> On Wed, Feb 12, 2025 at 12:38:23PM -0500, Peter Xu wrote:
> > From: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > 
> > This will be used in the following commits to make it possible to only
> > lock memory on fault instead of right away.
> > 
> > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Link: https://lore.kernel.org/r/20250212143920.1269754-2-d-tatianin@yandex-team.ru
> > [peterx: fail os_mlock(on_fault=1) when not supported]
> > [peterx: use G_GNUC_UNUSED instead of "(void)on_fault", per Dan]
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  meson.build               |  6 ++++++
> >  include/system/os-posix.h |  2 +-
> >  include/system/os-win32.h |  2 +-
> >  migration/postcopy-ram.c  |  2 +-
> >  os-posix.c                | 15 +++++++++++++--
> >  system/vl.c               |  2 +-
> >  6 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/meson.build b/meson.build
> > index 18cf9e2913..59953cbe6b 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
> >      return mlockall(MCL_FUTURE);
> >    }'''))
> >  
> > +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
> > +  #include <sys/mman.h>
> > +  int main(void) {
> > +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
> > +  }'''))
> > +
> >  have_l2tpv3 = false
> >  if get_option('l2tpv3').allowed() and have_system
> >    have_l2tpv3 = cc.has_type('struct mmsghdr',
> > diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> > index b881ac6c6f..ce5b3bccf8 100644
> > --- a/include/system/os-posix.h
> > +++ b/include/system/os-posix.h
> > @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
> >  void os_set_chroot(const char *path);
> >  void os_setup_limits(void);
> >  void os_setup_post(void);
> > -int os_mlock(void);
> > +int os_mlock(bool on_fault);
> >  
> >  /**
> >   * qemu_alloc_stack:
> > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > index b82a5d3ad9..bc623061d8 100644
> > --- a/include/system/os-win32.h
> > +++ b/include/system/os-win32.h
> > @@ -123,7 +123,7 @@ static inline bool is_daemonized(void)
> >      return false;
> >  }
> >  
> > -static inline int os_mlock(void)
> > +static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
> 
> So did this actually generate a warning ? We don' even need
> G_GNUC_UNUSED unless we're actually seeing warnings about this.

I didn't try to hit a warning without it, as we can use different compilers
and I thought the results could be different, even if I try it and it
didn't raise a warning?

I do see though that we have plenty of such uses in the current tree,
though.  Does it mean it's a broader question to ask, rather than this
patch only?

Thanks,

-- 
Peter Xu


