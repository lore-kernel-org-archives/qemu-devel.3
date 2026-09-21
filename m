Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F72C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jpx-0007HF-Fe; Mon, 21 Sep 2026 15:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x8jpv-0007Gx-LZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 15:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x8jpt-0008Lh-JW
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 15:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790019475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jNXGbvKedPIxcUWLCIVqyMOqx1m+MeTI5Ycu/BTyus=;
 b=D6VSt0/h1eBdqnitzTvTEdQPjR6ZdD4yQXaarTNxc+WNWskV+gjLRYaYamI0VS2MYLTTUz
 58oGIxd2wr12xjVtyG6AHvJzKfTkN5h8gLSXMr5lNsZ5g6qRnWpvmoiCQDXpdzyou4Hhn/
 DaXJCpsDNIbzl34souz0a6x9dH4eXtE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-jovSZdIDOyidjIVK9oK8nA-1; Mon, 21 Sep 2026 15:37:53 -0400
X-MC-Unique: jovSZdIDOyidjIVK9oK8nA-1
X-Mimecast-MFC-AGG-ID: jovSZdIDOyidjIVK9oK8nA_1790019473
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso29396935e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790019472; x=1790624272; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4jNXGbvKedPIxcUWLCIVqyMOqx1m+MeTI5Ycu/BTyus=;
 b=OmwoHLlpg4VqdGRbUipjBmDlm1YAsnCb+euhr1zYbFCBGsau3r3WWi4aaZKQ+Z0PsB
 PBtfDvOxzAINHYJy7TnWOLSue6xagDUlpuudBYCqay92AkvVZis4mcU6+SU6sYfTKNph
 YHmdlFEYs3whAYLxGkEczNcChDR44rms2KnXP+WSDnxyMRy5FMUWY3p6gvDMrtNz8czs
 pTKcdIKL0e3vTU/p5Jy92kGUxjySBdWiotIKzqMZYW71aLYd31XVpaKulT5wwEu+6vp0
 q/NTivf7Ro/5364m9Eq9jb9V0wXZqT9hMgofg662TUYEpDxjnxw1d/awdvryC1qpwIPH
 LV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790019472; x=1790624272;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4jNXGbvKedPIxcUWLCIVqyMOqx1m+MeTI5Ycu/BTyus=;
 b=p50EiG0Ap8nHcqC5b4kITcNSoxZpCxJnxjYrtsmN4vu7ce7iCG5KdesmfLzaHh+fJt
 VEvz6BuGtXFAU9k+ZFHqLzkekbynPAzZhGhpMvQf98CV4KLIvYMB6ubGsPTU5EYQ/yRE
 hFO6PR+3Wzu0b0D7V3CWETpt6ewer27fQIx1kQarEiHQ4wjgkKtCtRizaGD6svr2t7vd
 8QCLHdkWIQgiKRKl6hd/dVD1eRJgXBU/djNaq9oXcjYYFjdYz61kAZ0pKCU6kAGd363a
 9y4VnA7Qe0PrM5FeUjbXpZqf4vRAjlSTilVpIYOguKrX1LU+wMPp62j61rIkyvqIP/Ig
 McqQ==
X-Gm-Message-State: AFuF++ng8IG4TN5v/kYBBAdqoOQ9xCOa19BHclti4dOwU3YydJfzzE4n
 nwzcdV+IgpRJUKT/KsyiYEHr34wqON5x7gouxje/aPKxvYfxtJ0rAIjdyqKXTPepYmnCbbK1A56
 38Pid59DpZEjCJqHPRkJ/u+yljoFMC+VVjrhIAxqKg1pJcxtkCDUR67D0
X-Gm-Gg: AYBFou0gjlBLwVfgKEBQeYZMgvoNaAg7lGBNyotnlvgeCmATJ+kXay/EKe/QQTDFDin
 jOjv4N5jOv8kaPn5qsu2kRgIdL9hlHfOcpelhxcVfIH6Hr4yd7VNUbPzc44cYvsaAdMBCHra05q
 nAU5NCbtaTtlPekwGvyq+GCrKjwRNr6H3TiSbe2DWxnDdrKIFC3+W6I+jF6OxA6yzRkKiBGzrPC
 abHsJ/0JTaGRFEbzUIUeN7Bwc7kvRjXU+xPghxRn3xgSJe2Hrwia4zMv9F07NT0nd0OP91Rpxn3
 6REVgvvAkzw548vLWCQiudlTOe8xTd6z9C+JjL6nmx1XKoh5i5jorxOD919nBf55znFKGOQ9KV3
 EpdYRh8y6RgI+w8iWCBpPEUs=
X-Received: by 2002:a05:600c:4712:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-49fc573621emr162362435e9.20.1790019472540; 
 Mon, 21 Sep 2026 12:37:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-49fc573621emr162362115e9.20.1790019472070; 
 Mon, 21 Sep 2026 12:37:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cc05e9sm13766475e9.5.2026.09.21.12.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:37:51 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:37:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] vhost-user-bridge: Fix stdbuf and ASAN interaction
Message-ID: <20260921153713-mutt-send-email-mst@kernel.org>
References: <20260914165250.88382-1-yodel.eldar@yodel.dev>
 <42c74a3c-5ac7-4af6-b06e-e3d8669f82ee@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42c74a3c-5ac7-4af6-b06e-e3d8669f82ee@yodel.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 21, 2026 at 12:57:30PM -0500, Yodel Eldar wrote:
> Hi,
> 
> On 14/09/2026 11:52, Yodel Eldar wrote:
> > From: Yodel Eldar <yodel.eldar@yodel.dev>
> > 
> > Hi,
> > 
> > As reported by Marc-André in (1), the functional test of
> > vhost-user-bridge (vubr) encounters a runtime error when
> > vubr is built with ASAN, because the "ASan runtime does
> > not come first in initial library list."
> > 
> > Upon Michael's suggestion, this series converts the DPRINT
> > debug output macro in vubr to use stderr instead of stdout
> > for output. With that change, the functional test no longer
> > needs to invoke stdbuf, so it is removed.
> > 
> > Thanks,
> > Yodel
> > 
> > (1) https://lore.kernel.org/qemu-devel/20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com/
> > 
> > Yodel Eldar (2):
> >    contrib/vhost-user-bridge: Use stderr for debug output
> >    tests/functional/x86_64/test_vhost_user_bridge: Eliminate stdbuf usage
> > 
> >   contrib/vhost-user-bridge/vhost-user-bridge.c     | 2 +-
> >   tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
> >   2 files changed, 1 insertion(+), 7 deletions(-)
> > 
> 
> Ping?
> 
> Note: Series is fully reviewed (thanks Marc-André).
> 
> Link:
> https://lore.kernel.org/qemu-devel/20260914165250.88382-1-yodel.eldar@yodel.dev/
> 
> Thanks,
> Yodel

Hi!
Review delayed due to lots of holidays. I'll get back on the
treadmill beginning of Oct. Sorry.


