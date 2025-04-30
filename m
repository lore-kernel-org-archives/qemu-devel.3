Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8iX-00064P-MH; Wed, 30 Apr 2025 10:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uA8iS-00063s-Co
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uA8iP-0001IA-Rz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746024430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUTk+ERMPARq/iureHknKkf8CpfD61k0trQtzvJ4Ma0=;
 b=hcezXnnwrbPrP9utfwAMQL71FT/T/9dO0V8j3fi9a4du6Ypb4wJ7Yg8HRKcdv1F7o/tbHC
 W5KwAe/xMLJfw5j+3D3f8I6jcHGa4q1dqCuwkiD6SCQsA3uQU3w3wTuKFw8B6Z/C/UatwZ
 2ThgKL/RgeGy1eZlxMWoOppb1V9MT8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-EwmwurU1PYOcKGaefHDGtg-1; Wed, 30 Apr 2025 10:47:09 -0400
X-MC-Unique: EwmwurU1PYOcKGaefHDGtg-1
X-Mimecast-MFC-AGG-ID: EwmwurU1PYOcKGaefHDGtg_1746024428
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so32258295e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024428; x=1746629228;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUTk+ERMPARq/iureHknKkf8CpfD61k0trQtzvJ4Ma0=;
 b=MP/SfZeka6v6Dxzz9RFtJf3gfacbMJJao/ltvixkDXuXc4iUedF4rK19jQBzxXXUPv
 qblqT2jz8bVDLdIGVxwlK9qgpS2clJqCEDSsvamthy3r3JdThrA+CBnc93X6wdCZ8v64
 C12BCCUK0/ZBo0OlEfsgIDqAuK7iQ0PtTJMf1PTh0qwQgbP8JapVSzugeYZMRAWH/yxG
 hlMg+NipdfBMOSBlsCUv/SO9hLD0w8pYZHr/f4YF2mcTRe9TsVhkxdApDugj+3aNlGIq
 WuT97FCcoH2Fyu2pyPX/UC5YDH3zFxKWfmQfU/wmZAmBgQeWgMAZnIfB3KRD76q/Iqz9
 EIKQ==
X-Gm-Message-State: AOJu0Yx6RX2YRyDsILY4TW4o2pxYEipzm93hWpD7bslrSqs2kMhf4+v+
 6j+w5IFEdBvMISe5h5K0BPqwHQ1MOquRS/KPAev7YrPEpb6r3raepWyseHdAHYoBDw+EgNsMoh9
 noTehjco3/LaFAUjwT6xJOEz4vBV97h2uPlsQDrwEX7MJH+xUi9sH
X-Gm-Gg: ASbGnctH4WQtrXCadE65fNMpYBsR9E9SwTkcFwyW67+F+ZOf6d0FEI3rN+d+guCPMaU
 y/1W3bGOh6/EalcPQ7he8Mjsjn/9Li5xYj04DJDkd9mALnbdsWcitP/5ELQ4snFghZUBzPEWic8
 nyhys21vUdSa3QJVANwwiHKEr3XHvlrsLaSnekN1qbiNL8rWpx2XPIWOyBDBgVFT8Sr6K1cRCUG
 lRYKQvHKp1/64056TlRamgxiJs7Nr4TEGgs5XUJ8r4yKToi260ngt5jP6FPiJXfrZdz1RoSnRaP
X-Received: by 2002:a05:600c:450c:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-441b1f38a39mr36231215e9.15.1746024427990; 
 Wed, 30 Apr 2025 07:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFEB+HRz3HhS8URGxnnprod5vdZsVqUVm3cT+N/FFEqdK99Zxm0Ee6BY6mkuX++pUq9CM7KQ==
X-Received: by 2002:a05:600c:450c:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-441b1f38a39mr36231025e9.15.1746024427623; 
 Wed, 30 Apr 2025 07:47:07 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b9726fsm27983525e9.8.2025.04.30.07.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:47:07 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:47:05 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/5] utils/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Message-ID: <f6q7tvgnix6erzeego5tnwsbpeeaa3fq5czsng37xabysrkfzd@e747a4kw5gpj>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
 <20250408112508.1638722-6-jmarcin@redhat.com>
 <Z_kfFTiGkK0dC73f@redhat.com> <Z_k5-ShXToaRUAUO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_k5-ShXToaRUAUO@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Hi Daniel

On 2025-04-11 16:49, Daniel P. Berrangé wrote:
> On Fri, Apr 11, 2025 at 02:54:29PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Apr 08, 2025 at 01:25:04PM +0200, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > With the default TCP stack configuration, it could be even 2 hours
> > > before the connection times out due to the other side not being
> > > reachable. However, in some cases, the application needs to be aware of
> > > a connection issue much sooner.
> > > 
> > > This is the case, for example, for postcopy live migration. If there is
> > > no traffic from the migration destination guest (server-side) to the
> > > migration source guest (client-side), the destination keeps waiting for
> > > pages indefinitely and does not switch to the postcopy-paused state.
> > > This can happen, for example, if the destination QEMU instance is
> > > started with the '-S' command line option and the machine is not started
> > > yet, or if the machine is idle and produces no new page faults for
> > > not-yet-migrated pages.
> > > 
> > > This patch introduces new inet socket parameters that control count,
> > > idle period, and interval of TCP keep-alive packets before the
> > > connection is considered broken. These parameters are available on
> > > systems where the respective TCP socket options are defined
> > > (TCP_KEEPCNT, TCP_KEEPIDLE, TCP_KEEPINTVL).
> > > 
> > > The default value for all is 0, which means the system configuration is
> > > used.
> > > 
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > ---
> > >  meson.build         |  6 ++++
> > >  qapi/sockets.json   | 15 ++++++++
> > >  util/qemu-sockets.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 109 insertions(+)
> > > 
> > > diff --git a/meson.build b/meson.build
> > > index 41f68d3806..680f47cf42 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -2734,6 +2734,12 @@ if linux_io_uring.found()
> > >    config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
> > >                         cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
> > >  endif
> > > +config_host_data.set('HAVE_TCP_KEEPCNT',
> > > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCN'T))
> > > +config_host_data.set('HAVE_TCP_KEEPIDLE',
> > > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
> > > +config_host_data.set('HAVE_TCP_KEEPINTVL',
> > > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPINTVL'))
> > 
> > What platforms are you aware of that do NOT have these
> > settings available ? I'm wondering if we can just assume
> > they always exist.
> 
> macOS appears to have these, except that 'TCP_KEEPIDLE' is under a
> differnt name 'TCP_KEEPALIVE':
> 
>   https://github.com/apple/darwin-xnu/blob/xnu-4570.1.46/bsd/man/man4/tcp.4#L172
> 
> Likewise I see them available in mingw for Wndows builds, with both
> names
> 
> $ grep -r TCP_KEEP /usr/i686-w64-mingw32/sys-root/mingw/include/
> /usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPALIVE 3
> /usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPCNT 16
> /usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPIDLE TCP_KEEPALIVE
> /usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPINTVL 17
> 
> but your patch wouldn't enable it because it checks netinet/tcp.h
> 
> AFAICT, the only platform that matters to QEMU that seems to miss this
> is OpenBSD 
> 

Yes, I couldn't find them in the OpenBSD man-pages. Other BSD variants
support all of them. I will mention it explicitly in the QAPI docs, that
OpenBSD is not supported.

I will also fix it for Windows and Darwin, and submit an updated series.


Thank you!

Best regards,

Juraj Marcin

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


