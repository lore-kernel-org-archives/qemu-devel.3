Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC6DFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLpv-0006Ep-UJ; Mon, 27 Apr 2026 09:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wHLp4-0005wU-UA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wHLp1-000109-Hu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 09:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777295781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qgJgokNbmLzK5pahh0q3Sv8be9K8ThZS2JxNCjUkRo=;
 b=iHN6z7Z90qdCIkQ2r5yAcpjvQAZAO2jpniBAqTLxjONZ4DlzN7lcTKVi4UrFQI1DWEsWTw
 8txd++vq8ejm2eQurmr2wcXKGHLNl7mhhj/2B4rEyeMqHLOuuDRQkO1cnYj14zzpKnRpvf
 Dx8bJ8Pi5p8TIIgyOsg25QNgRVuvpTA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-X999Pkn9MG2W_Z7sJPrbWQ-1; Mon, 27 Apr 2026 09:16:17 -0400
X-MC-Unique: X999Pkn9MG2W_Z7sJPrbWQ-1
X-Mimecast-MFC-AGG-ID: X999Pkn9MG2W_Z7sJPrbWQ_1777295777
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6165ec99d1dso6247413137.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777295777; x=1777900577; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+qgJgokNbmLzK5pahh0q3Sv8be9K8ThZS2JxNCjUkRo=;
 b=oE8bgH4SNkMRaXavfhPwHtrgN1eAuWoTOma4/CEd+SL2PVqEAKBJ/Th0HmWk/JE1MA
 R833wS9VSIyPCBWlyoQH5YotPleKvhcZ1kebOFIKZ4Cy98KRZ2+oULhnvrZaYm2f+/NS
 u0a/OIJVbAHBHUKYrbqDmd5yB1jfDQZIZrXOiaBV3vpJaR9GcSJT5IpV7Wg1ra8fwcTm
 E6cFo+ZZG/6D24EIdeRetM6rRKWJd8/Ak0/rpvK58QUwRpVFZvGeNVIIrmkBK0XuqGC1
 gNPLq/tFyhOaCY/sdibUhl6Ijo7tzCBTppNZehR2Y/IHg3d2bVb8bj0Ukdq3JOQNEVY1
 ITBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295777; x=1777900577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qgJgokNbmLzK5pahh0q3Sv8be9K8ThZS2JxNCjUkRo=;
 b=K1cbV1A1PTKeNLeVPNQDgJthYHERMtyG02TwCj6sI2PanoJHLzWdfLiuEH1GdOvhgh
 RaXWWviZin9iOSesZpOH+JGWQnYllZBupg4x8d4WRA6YtfUo3DPK9MGscVoDRcM7nrvP
 CH5QKxRrK0VGhsgDs95eTg8YC0LsNX4aZ4GiK9QvbbpHTo/nKKWFM28WC/nDnaxE1nOq
 fattipEHD3boEyJn9pfAZKkaefQ/6hVTmvYOGCt9VtTyEMb/4C7q5JAWZYnv6WWfN2ed
 A4RskAlYP3ZlSQJACrb4b3TKJ9xgu1N1H2xymBb/5fSB/TWktnH+I34ia8ZhKXRTWMjl
 AZqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EIlzPeERherSgRwJ3kGy5lU/UfBRYo0r5TQ3UZxtTBlg7N4z2jlXhbbd0ffdzCMlLqW/QbHZ0rE0/@nongnu.org
X-Gm-Message-State: AOJu0YxPHVD0ywlbvsRYd3OWGV47JSKVsIbV31cjPmt9AFn9oakgRFny
 Fo2gEjzNVaV1kkBYqjtvr8+b3JI4B36GZf8oiMapmOUc9PPIVx62aItxV62bHRCNXC/bc3Apu1o
 qbxdVfLeHdWxZDfCxqnHPVnsVCsrCOpOAN8RbKbeSqQ104X4gCLlPnYzB
X-Gm-Gg: AeBDiet8rrpSEGxQCRIAApu9QoFinpU4wOLBAuKqC81D/4XMdgD1KA3CC0CGsRl0u/M
 yTYuRaMxdKN7bZdAYG9jyhAiM2vkxN+XzYmC8zSNQ+7WNh1bRcWHqzrzHwBq3KVxmt1QQrBsLbp
 qWQU5r8fSn4DuIv54gtPWWwp6tRS+J5DNxLcOZ3wXHQRh8DwRIniL47FRY5M3aVRhTHOHgjcrBn
 qrr7iJpyM0OrBr8+oQbDbFc7m02vSYSnRDV5sflChaRvQ5kT6dTnzRCEnwLtV7ooz2z7IsCZMza
 0vaiqbRVQCwsaIq5/2kmjRZF4CEmSfy4NHp1q2PxnXZQUr/Ovh/XQDRp+qkAGDhx1gjKD05rHZf
 B2wB5Sh7HUfFPnP88TcPfi1XCmm/jq6wzr/PUXnVFl620lF1fJPMYw0fmeA==
X-Received: by 2002:a05:6102:2926:b0:610:76c6:b74a with SMTP id
 ada2fe7eead31-616f67c64fdmr21914917137.14.1777295776498; 
 Mon, 27 Apr 2026 06:16:16 -0700 (PDT)
X-Received: by 2002:a05:6102:2926:b0:610:76c6:b74a with SMTP id
 ada2fe7eead31-616f67c64fdmr21914859137.14.1777295775863; 
 Mon, 27 Apr 2026 06:16:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aebc0f8sm254408016d6.47.2026.04.27.06.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 06:16:15 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:16:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Junjie Cao <junjie.cao@intel.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 farosas@suse.de, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/3] migration: switch remaining positioned I/O to _all
 helpers
Message-ID: <ae9hnhsSivO_RfVf@x1.local>
References: <20260420201317.30199-1-junjie.cao@intel.com>
 <0954cec2-4c0d-4a97-96e6-b821c37e8a99@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0954cec2-4c0d-4a97-96e6-b821c37e8a99@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Apr 26, 2026 at 11:27:08AM +0300, Michael Tokarev wrote:
> On 20.04.2026 23:13, Junjie Cao wrote:
> > Follow-up to the pread/pwrite_all API series [1].
> > 
> > qemu_put_buffer_at(), qemu_get_buffer_at(), and file_write_ramblock_iov()
> > all use single-shot positioned I/O without retry.  They share the same
> > pattern as the bug fixed in multifd_file_recv_data() where a short
> > transfer would be mishandled.
> > 
> > Convert them to the _all helpers and clean up a pre-existing
> > const-correctness issue in qemu_get_buffer_at() along the way.
> > 
> > After this series no positioned I/O call site in migration/ uses raw
> > single-shot channel operations.
> > 
> > Depends-on: <20260413214549.926435-1-junjie.cao@intel.com>
> > ("io/channel: complete pread/pwrite_all API and fix
> > multifd_file_recv_data")
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260413214549.926435-1-junjie.cao@intel.com/
> > 
> > Junjie Cao (3):
> >    migration/qemu-file: switch buffer_at functions to positioned I/O _all
> >      helpers
> >    migration/file: switch file_write_ramblock_iov to pwritev_all
> >    migration/qemu-file: drop incorrect const from qemu_get_buffer_at buf
> > 
> >   migration/file.c      |  8 ++++----
> >   migration/qemu-file.c | 37 ++++---------------------------------
> >   migration/qemu-file.h |  2 +-
> >   3 files changed, 9 insertions(+), 38 deletions(-)
> 
> And just like the previous changes in this area, - should I pick these 3
> to the current qemu-stable series, or is it not needed?
> 
> Applies to 10.0.x series and passes tests, but I haven't done any more
> testing here.

My understanding is we don't yet have a real report / reproducer for the
partial-io issue fixed here. Considering the size of the patchsets
(especially the dependency series), maybe we can skip these two sets of
patches until we know a solid report from anyone.

Junjie, did you find & fix this problem due to a real bug, or it was
theoretical while you were reading the code?

Thanks,

-- 
Peter Xu


