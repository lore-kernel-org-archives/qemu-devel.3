Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DEACD6E57
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2Qb-0000OD-6n; Mon, 01 Jun 2026 09:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU2QY-0000Ny-Ji
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU2QV-0000LI-Al
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780319489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ECHPmOAKI6Nwk0NjCQ/5FeLRB8gynrXIGdywqExjSo=;
 b=DXY0TUM8dMkRy/Nfn/XdA9EkBV8VzqAa29c+BXaEbJogyWFuAK4TpY1fAyn8YTvs8B7NVQ
 GrV9mqz68lJciAfhKTwipPzyklF1rYvjQWooHulAV82/PwOGnw1to+f+2kFvu7vaBCmIQM
 s1SYKc37glx+cEduOILEV8EfzFznJs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-i_iA-PT-NKWXi2Ey4gtt8g-1; Mon, 01 Jun 2026 09:11:27 -0400
X-MC-Unique: i_iA-PT-NKWXi2Ey4gtt8g-1
X-Mimecast-MFC-AGG-ID: i_iA-PT-NKWXi2Ey4gtt8g_1780319486
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4600cf05f07so1073786f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780319486; x=1780924286; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ECHPmOAKI6Nwk0NjCQ/5FeLRB8gynrXIGdywqExjSo=;
 b=klW4tLVZdgvi/V8RP8VqRfx6tJMGR2WcFyZD7fxrPZKsCexOSojOl9I/Eoxy5yJLmy
 UuDRjlB0Dp2eyP3gZu3po6FmXcY93Ifk99elBlGy03CNOT/v7Qdg0qyQeKtgfLYj5OgJ
 yO0KrpU7owuk36M3m3fp+aGccc6uXDZErEI0aXmYaCdF44MRu9XTGDsbrpgWjcliwhYt
 sAmigNVXVYRWjxU3ZDztHm21Dcl/v8D2tuIhQc1oJnP0IWeUf+MvQ/loD9iMc00Xd0ly
 qwFHJYUHUP8bCjtAYhOQb4iaJwexFm4dv4oTlAfENbyRU2mGps2GyUjw1PeGwOEWAHM/
 KR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780319486; x=1780924286;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ECHPmOAKI6Nwk0NjCQ/5FeLRB8gynrXIGdywqExjSo=;
 b=rbCwjqw56wEq1cxv9RxcXc5bOtS7rbcExXgEhtBfhEXI+V2H8jQWUvqA9LQOB1dpWl
 R2MlVGz53ribLH+cHlHKHZWkad+x34Kct4xL0zrqZlw34PD2IVxNkK1cW1GXR0N+R/29
 q4fydggFB0cK/FEKVcS/Sq5GrHUTwegotqc8p+u4rtMMen4/n+NhgpRR+qPRSHd43uU/
 VIutw6M0tHplrjuGL//6XbfyKzel2GBfYI4N+crK+kIVk6xBD1Qr7UkZnmBTMa8SA2fx
 NQneXm5uamMwpQVWHd6iOUgXy+/o4Nyala+/lLfFzvLfQFxnIqlZGi50emaDlqZhmmzr
 31AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98W85FJHyljBJHMHdnUT3H83KoTGcYDCUyZkYwoBTtyrtcw+U6AYXPTidvFF8PcuFQfsauiAYJeLJ+@nongnu.org
X-Gm-Message-State: AOJu0YzKpAKfTNZMT/5wCNjDIMKDS+dDLNO7lvcMCM714ciYhE2BXXwr
 7rY8DG34laWaR5jVeCdmYVKy4pESZh6lzkilmEHBYrul6nhnQ1zg6Oc+BPEF8RelUiT0gRmgvMx
 kFUWkN2AqzjtvUHFzfd/mqHum6zvvkoDCZTVBzmGsToe9VvzhVFpinbJf
X-Gm-Gg: Acq92OGTKxHbwOyZ+jDbExftq796NYe7UQUVy1tzLtrB9L0N6jtoReW0FMmDHvOB5jk
 WXYu8pXovNPt0wxF/8/5SR9r0fb7Wehg0M3GGcPYs4HcIhSgj32bA7pc2YMeS5kY7WP/r8Y7y54
 BwHFX52TqjBW+Re6fBJFDlC1Ez3xdVMFopokx+Go5MDfQzz6gHasKiwbt0fb7LQEG9Oi7yy98v4
 u96mj/mqGnOCsqiOZQ6drwfeUNh1qrJGcMn/7tcCLgQIHd+CElFOUnEfld+bL8Bi7iL7F05vTqT
 zB2133FJgXFgQccmFvNLcw2Ch4phlivVU8tNaNKbMuvzRPYW8XHmmNrMAJ9/MIBZG+J+NTch1RT
 SPgsCoTwicliLelFb6df+KCWipLB0Z0FbfVAeYi6zE8G/E1vj9LuNyg==
X-Received: by 2002:a05:6000:4610:b0:45e:db3b:921d with SMTP id
 ffacd0b85a97d-45ef6b67882mr21226140f8f.31.1780319485960; 
 Mon, 01 Jun 2026 06:11:25 -0700 (PDT)
X-Received: by 2002:a05:6000:4610:b0:45e:db3b:921d with SMTP id
 ffacd0b85a97d-45ef6b67882mr21226068f8f.31.1780319485453; 
 Mon, 01 Jun 2026 06:11:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef32fabcasm24599676f8f.0.2026.06.01.06.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:11:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601090953-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> On Mon, Jun 1, 2026 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > >  But also because, in my opinion, separating
> > > the specification would improve development agility by decoupling
> > > specification development from QEMU's review and release cycles.
> >
> > Generally for QEMU this will be less agility, unless I misunderstand
> > what is proposed)
> >
> > Because presumably there will need to be spec releases then?
> >
> > So
> >         new feature -> spec tree -> spec release -> qemu implementation -> qemu release
> >
> > is surely longer that what we have now.
> 
> I see your point.
> 
> However, we do not really need to introduce a heavy release management
> layer. We could just operate it as a living document, where the main
> branch is the authoritative source of truth.
> 
> For the workflow, development doesn't have to be strictly sequential
> either. A contributor can propose the spec update while working on the
> implementation, much like we do for VirtIO updates. Actually, this way
> one update/change supports the other.
> 
> I guess my point is that a dedicated repository could lower the
> barrier for new changes AND keep QEMU's own development speed mostly
> unaffected.
> 
> BR,
> Albert

Something something submodule? Possibly. If you want to make progress
on this, pls think of the process, try it out.

> >
> > Whether there will be more agility for non qemu users will depend on
> > how often spec releases are cut.
> >
> >
> >
> > --
> > MST
> >


