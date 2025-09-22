Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4CBCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gd3-0000pS-5V; Mon, 22 Sep 2025 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gcz-0000mB-5l
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0gcw-00070t-8z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758547840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx0ugBXhJ6gLDEyp8p4H+RkZ6GZzEW4d6ubxPw5g3Gg=;
 b=Q9+OtII9ZWOdXxMulC3QA4yPWyej+IwStAp73HBAHQZksxY0QvGoPd1EGSI98NgTtm7M6k
 N84oOUqmCLBEJOI9VwJa5F63tZoKrVlAtJD+NDuoBFsT8x823lDP9nulhByK6mFeuKN/FT
 sQaA0xkF60FmApPXSAFqI+IpCAYjjV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-JpAILNi8Mhq1_r8tUX_J3Q-1; Mon, 22 Sep 2025 09:30:39 -0400
X-MC-Unique: JpAILNi8Mhq1_r8tUX_J3Q-1
X-Mimecast-MFC-AGG-ID: JpAILNi8Mhq1_r8tUX_J3Q_1758547837
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45df7e734e0so41857335e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547837; x=1759152637;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vx0ugBXhJ6gLDEyp8p4H+RkZ6GZzEW4d6ubxPw5g3Gg=;
 b=rdAeDK1MBzYGGRvEpnyAQReq5cThWIzVToTFb7CeuQXFf4SfnQwRGqRyWo5zvewOdZ
 9guUzSdHBJhhBrkQUJxlVQW05EKWWxwjsWmqBCa4amuj1N0jcXJo1ATkNki/U4p9YNu4
 8YCQ/XV8MML8GRgSGrNYaxR2Lw0+zmdCSp+m9UKy0vhhlz+KhxK3pcVu/ddL1oT2zb0y
 r7yFFyswbR0BGhY3zECgaxnA0PhkixN9Sy1gUnecAdB4gVdKc/tI0FIolkyCt/toyC13
 B0rVDnCTD6vNtUBZ+b9SoS0TItiWDPy3g0KoeXyJPseMzPp5AboO7wDMKOquLVC8RWbr
 Nv4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPWP0YLweQq2NEWXtgQE36tjCvJP3rtVQLtwu4UWCIi8oiwv+DzmNRJXRPoj3QP91pba0RXwnCUP+@nongnu.org
X-Gm-Message-State: AOJu0YwP1nVNZa84pnXu4Ecz4i4Ov5yxF2RbcUPOwrCO3FafBFiJ9wFp
 jv3/pM3c3CweeilI4AJGcb6jbvkThdW0S8mDpfpW1srY5xUPkzXHwXweKEaWtBD3sEyvO9fOwKL
 VVzFsY+Ny9yYMTePlmNKhIuoJxbUBfp0xWODSmfVdKJHOp3G+QKRXuMqV
X-Gm-Gg: ASbGncug0q87chI1M/tmoIkqNvF2Qk+LMjNF5uwkdNm5BYEF02ulZpzZID/0cuwzTI5
 0xf7gEA7SG+zjOgrdqb/GI3R4+ofr5jveEmyuYDz9zDblmGvAZ/BL2xvGtsUjlpjm6D4/K0X4E/
 RV+VEUtcG85ESLCWd4k1OMRyULCeoIUOvdOspLeDdqkcwZwdNfEwkrtHGAJB3N6mHIz4Dkbwmek
 r/wo+7E08cFBVYrouXtPRyqFdlg4/dEEOq+R5M+wMf4e/fGvLH+WcXM3DaiuLAUnu7MkFtZPWq1
 fYTJVJOIpTCVnKNoaM7OgnHGRupzC/5GAsk=
X-Received: by 2002:a05:600d:15a:10b0:45d:d197:fecf with SMTP id
 5b1f17b1804b1-4687aa75aecmr89794055e9.0.1758547836918; 
 Mon, 22 Sep 2025 06:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyekO//x8kDhk7im3HWfGe3UnFQ/SDfg+hlQXmiyT22C+SwZroTD9TmcPIdHYA4wROaRdXIw==
X-Received: by 2002:a05:600d:15a:10b0:45d:d197:fecf with SMTP id
 5b1f17b1804b1-4687aa75aecmr89793775e9.0.1758547836395; 
 Mon, 22 Sep 2025 06:30:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461383b7b9csm245253455e9.2.2025.09.22.06.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:30:35 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:30:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250922093013-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 03:26:23PM +0200, Christian Speich wrote:
> On Mon, Sep 22, 2025 at 09:08:47AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 22, 2025 at 01:49:55PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Sep 22, 2025 at 08:15:20AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 22, 2025 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > > > > This removes the change introduced in [1] that prevents the use of
> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > > > > 
> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > > > 
> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > > > > ---
> > > > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > > > > introduced.
> > > > > > > 
> > > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > > > > google for "vhost-user-device" I've seen no confused users.
> > > > > > > 
> > > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > > > > maintain our own QEMU packages, which is non-trivial.
> > > > > > > 
> > > > > > > So I want to propose lifting this restriction to make this feature
> > > > > > > usable without a custom QEMU.
> > > > > > > 
> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > > 
> > > > > > The confusion is after someone reuses the ID you are claiming without
> > > > > > telling anyone and then linux guests will start binding that driver to
> > > > > > your device.
> > > > > > 
> > > > > > 
> > > > > > We want people doing this kind of thing to *at a minimum*
> > > > > > go ahead and register a device id with the virtio TC,
> > > > > > but really to write and publish a spec.
> > > > > 
> > > > > Wanting people to register a device ID is a social problem and
> > > > > we're trying to apply a technical hammer to it, which is rarely
> > > > > an productive approach.
> > > > > 
> > > > > If we want to demonstrate that vhost-user-device is "risky", then
> > > > > how about we rename it to have an 'x-' prefix and thus disclaim
> > > > > any support for it, but none the less allow its use. Document it
> > > > > as an experimental device, and if it breaks, users get to keep
> > > > > both pieces.
> > > > 
> > > > Maybe with the insecure tag you are working on?
> > > 
> > > Sure.
> > > 
> > > > And disable in the default config?
> > > 
> > > Disabling in default config would retain the very problem that Christian
> > > is trying to solve - that no distro would have the functionality available
> > > for users.
> > 
> > I think his problem is that he has to patch qemu.
> 
> Yes I'm trying to avoid that. Patching qemu also involes providing updates
> (and security patches!) for it. This is a very high burden to turn this
> simple flag on.
> 
> > 
> > As described, this is a developer option not an end user one.
> 
> I don't really get the distintion between developer and end user here.
> 
> As a developer I'm an end user too, I'm concerned with the linux kernel
> and the additional host tooling for mac80211_hwsim support but QEMU
> I'm just using as an user.
> 
> Greetings,
> Christian

Are you ok with building qemu with an extra config flag?



> > 
> > 
> > I know Red Hat will disable it anyway - we support what we ship.
> > 
> > 
> > > With regards,
> > > Daniel
> > > -- 
> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> > 
> > 


