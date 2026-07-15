Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCAFC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1qu-0007lC-Rg; Wed, 15 Jul 2026 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk1qs-0007kx-Ob
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk1qq-0004Ft-Vd
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784130527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jV+JzTInPZoKM+0vQRtxQWOrRLBypc376GzQOTYIQo=;
 b=QKqMtSeSYBgxOTvvu5T3Y453KHi7t9ThwzENhFDq13sT1sGXe7YktFficfZ45D8Sov0UVw
 Z/jA9iUnsNx9lgn1goqtAX5HI0aaVxx/W3m5eMP2m+LtZae9OWZjBjVsU9nBts46GZE/du
 OKY8wzKk3RMDKnr0zJr2FdlYnHDNVfI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-gK7HEb-oNlmiRRIV3JqXzw-1; Wed, 15 Jul 2026 11:48:46 -0400
X-MC-Unique: gK7HEb-oNlmiRRIV3JqXzw-1
X-Mimecast-MFC-AGG-ID: gK7HEb-oNlmiRRIV3JqXzw_1784130525
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475eba52438so1988482f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784130525; x=1784735325; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8jV+JzTInPZoKM+0vQRtxQWOrRLBypc376GzQOTYIQo=;
 b=kOU7JZKyzRLwre+1Au8M9C8c7jct9yWN643aAtbq2FiJ1jcEmx4i49NLMYMOfL4USX
 5OlOfas78wPNRxhe1IFE33zTox3QbptclQOTf8tWjjQwvyCAUpjCIQRognY4W+Kzc5vs
 IlcPkWwSCgNsnyy4d9jo+jiRYcAqo0tq3OZPquAlW/wQWxQQ8/Wid9EpDXnzddFuhVf2
 z1JEtwiuuKDi98dzgRxr6i9L0LPaIynO9iYUnWCFKCoocB3GvpM7/R/MCjBhmleUg7tr
 zouA1o0loKqmpluTgPFjWw51hsWYvf2qK5kM8NrgSZNaYo7aM/2QaIym3Mw9SSjZBU8o
 12Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130525; x=1784735325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8jV+JzTInPZoKM+0vQRtxQWOrRLBypc376GzQOTYIQo=;
 b=nW/9u1o4otKZ7vJJH9Wi/wddtW6HNhOAmapu79L4Ot7F1MuQXgzsYy6xypc84neuPY
 yGbh/6uOSVzIy4dmwTRhClw07b0yECxqXq1EgExawqdjgovF2TK6+t7lMNvQJpU67DvM
 YVNKCg9NJuBg9l0lX86e5YzZ0bIhU4ov4aE5t9x3bWH3WnKYgI/xYxONTlRnNJauTFG8
 zuFZisVG1bndxOgKEL0paTyI683uix5ygv5ub08XS5NDqkoP32pxrukcithdrrlCHX1M
 QTspa+aqanjQS4SV4cSmkm41wt/ywgttvS/GrI5kjUxLoLydBVbCCCnudTKAxUDbfewZ
 15Pw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEySiqSvSYhneEGnVjgO8Bf/jhvTbPCOB/RWdSSWN232U3NvMf3cmkLAYi0x7zQB9fwoclSBufk0Nl@nongnu.org
X-Gm-Message-State: AOJu0YzXzdnWc6W6jXJlR9EFL74gYXaK06BFjdsm0JSIMGlMWEp9Ng9m
 4XWVx7mB/+urMuOut/x5kM3baIfZ3mzSOPvdhzsT6j3W07k2/z3H2YABj20uD1xlmpf845Pf9Kd
 46H9JzGuso5N95Iupq5X4xNMRxvUgSoWCNmN3H+2FttN8wPXJNRHpSd6M
X-Gm-Gg: AfdE7clGuRzy2DWHJAmLza5FR5KWiTLJZBQlV/Sv/udt6jYsKFaLEl7DTRUhWSP8LNL
 0FkT9vUaVwzC+YsWTtJ76jBArEAmRXQAoUyxRuOk37OOLWeH4+PkZOrsdw7EUVrT80Og5VcJGVB
 DlRhfWZN0o9T9hoAhujrsETuj5+4XB5mzwjW70499zt46epKm+vuQvUxpbGFLYiX9JFD/ulx1MZ
 MlGSleo1FoNE312TfF5DguGcJ1OK/Lm8S2k0yjsCw68hiCKUtQ1yn/w6QtjcyjXQ5ErJmcUj81y
 nIbmCBX3/UmgPqs8+ScQ9xujnYEQ+FpisAZF8sGy34PmRLfbloKZCua3cmkBGyEQG2USHoHmrvt
 nTnSrmcabJ5fVLbqLKpVwKf+maM2SWn4eS8s=
X-Received: by 2002:a05:6000:3c6:b0:474:64bf:8fb6 with SMTP id
 ffacd0b85a97d-47f2dd26293mr24750280f8f.39.1784130524721; 
 Wed, 15 Jul 2026 08:48:44 -0700 (PDT)
X-Received: by 2002:a05:6000:3c6:b0:474:64bf:8fb6 with SMTP id
 ffacd0b85a97d-47f2dd26293mr24750200f8f.39.1784130524146; 
 Wed, 15 Jul 2026 08:48:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635082csm17490482f8f.7.2026.07.15.08.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:48:43 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:48:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260715114802-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> > 
> > Here is a migration for TAP net backend, including its properties and
> > open fds.
> > 
> > With this new feature, management software doesn't need to initialize
> > new TAP and do a switch to it. Nothing should be done around
> > virtio-net in local migration: it just migrates and continues to use
> > same TAP device. So we avoid extra logic in management software, extra
> > allocations in kernel (for new TAP), and corresponding extra delay in
> > migration downtime.
> 
> This is quite a big patch set, - is this really worth the effort to do
> all this just for *local* migration?  What's the possible use case for
> this in real, - am I right this is just about upgrading the host qemu?
> And with that in mind, isn't it sufficient to use what we already have
> (namely, create new tap, start new qemu instance, and migrate the usual
> way), and tolerate some very minor downtime while the networking code
> learns the new network topology (isn't it happening almost instantly
> anyway, and if not, the management can help by sending gratitious ARP)?
> 
> I wonder what's the use for this at yandex?
> 
> Thanks,
> 
> /mjt

Well just theoretically, imagine a big VM, reserving twice the amount
of memory just to migrate is not nice at all.


