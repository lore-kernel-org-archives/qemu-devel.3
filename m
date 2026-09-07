Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE811C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3alV-0002MY-3x; Mon, 07 Sep 2026 10:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alS-0002Kx-9V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alQ-0001jL-NG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byc02jQgnzodcLWcw0brXg/Mw5sZdxLwNOR6+p78DhI=;
 b=FoUpyoQNnF9mjItroaGRRVeCo+wGBHjPKzombHrJvQHiShk6pPsbIx6NUP9uMTENPV5sdy
 Ls41QDFVoKywdODt7Joc13Ipj8Ew0tWRtbM03cKIjlvUt+9XxYa+trOVKpJMSNwJyClldJ
 9mpD4O5FXPzpmS6QXZiQyUXFRSohAIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-lqiKA-2aNXykzvr916nkEQ-1; Mon, 07 Sep 2026 10:56:02 -0400
X-MC-Unique: lqiKA-2aNXykzvr916nkEQ-1
X-Mimecast-MFC-AGG-ID: lqiKA-2aNXykzvr916nkEQ_1788792961
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so25472675e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792961; x=1789397761; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=byc02jQgnzodcLWcw0brXg/Mw5sZdxLwNOR6+p78DhI=;
 b=A1wrig+fE8JrJipOIwNiVerzBd9JCH9NY+Uxdri4t5sQMGCHN5R6xYK9Gy9X0xZ14H
 gWYPg+ZzH9AfPIosY6XvF1fFNgkvv1BYfggbl+dn9IdSlvZiqbhHcLhjy7g3dxBf2JN0
 tdlenrt14P+z14Gw+NGz0fqxytb18ilfOgisALMFfvo7QhXJdswkOz6vqOWZK/KIk4eI
 M+A4hpIaZXVrkOPBGk7wWmcLjMLn/zitAd1MAX042wEhsK9m8b9w7NsNN4Xb1kmkpuxR
 EmCQe/oyhipXC4N1HT/cLjFfJJLUJBCECjHHAxixbPmbhAvXourW3gg4Y6DkYHBg8PxM
 fD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792961; x=1789397761;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=byc02jQgnzodcLWcw0brXg/Mw5sZdxLwNOR6+p78DhI=;
 b=RPLaLSRdh9gU/DSEPbeRhvEO26W5kOTS3hNOe0a5ct1laXaPJ1JlCWov5IWWMQgSGH
 qMifpodFJayZAeuZubbDAW2kuQmrRbCJz4JHESNUFzS+fUlAD2pY6QIjaXG66yOLGk1W
 dHzknjx6KRl/2+GL3SEzsKS4/OIspadlB0d/QmpzgM0N1RDupQayPNCaIgCCLNZMRMSe
 9SNe525CsM9glwgbu4sNBr6c0EGXx4DCy2kVj/cImqu2sRnSmUXMj2z7lherzdUjjecP
 Z0bAmsBr82QEfOH5/ESgFzlD75rpUvcWd8feFOXivZaeM6QeA4WtFLyIZohWtp/NYNUm
 2+zQ==
X-Gm-Message-State: AFuF++m1UfKHbDIrIrb+QJRtiofpqsb3d+flxC1D7BNcLsABr0K7VCuz
 XNlhEqxswuRZ1dKVWrp1PMS/bdMNmLIlO42P/1raR/stXU8ME9+Ng+0F5quQfPXbRvGBybAlfAr
 u59efyuseS9IhclBmcv26Fm9tGZ0Pkt/i98R/Ly9bheleskUivHJNG6q/
X-Gm-Gg: AYBFou1Ak+tiVm46q/HQs+U6PmDd2B9+vI2Gfq573SNpscRrhrtt9mGWYaojOcN5NGm
 fK1W37+MG+217wVirm/UZZ8NjKgx80YBd4I5FracQ/EJiIPgdKVEopC6vSKyFzBJOrWHcg6jdc7
 y8sfucDYmGn4aGK+4vymt10CMX/cyt/VRGa9EtM3JDC7+XscTkYfJ2+F0+BPhWTozp8v3ztsHCV
 6Mjn2VEZKrio4Dhe6d8Q6DtYSo+oWBucYkqJJsRaV26e98xXKrLVjwO/m1mSiArTQdsis5HjQxf
 NNfOtmK0qALlCP0GAF2Y4gGV1jlkaS54HFv3uzXBLA5buCTXW/8QyLlom+swwDb1CjqBtRnMlC/
 u4BJv/hdxXT9lj9uLswpBhc9Zwvp27NRwO0hLAp0JkWeE6g==
X-Received: by 2002:a05:600c:358a:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49cf82070famr230937865e9.2.1788792961333; 
 Mon, 07 Sep 2026 07:56:01 -0700 (PDT)
X-Received: by 2002:a05:600c:358a:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49cf82070famr230937355e9.2.1788792960725; 
 Mon, 07 Sep 2026 07:56:00 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm844488945e9.0.2026.09.07.07.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:56:00 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:55:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 06/10] vhost: factor out vhost_dev_init_backend()
Message-ID: <ap7IRnRtqCMwB4p6@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-7-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-7-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Aug 20, 2026 at 02:39:51PM +0300, Andrey Drobyshev wrote:
>Split the first part of vhost_dev_init(): selecting the backend, calling
>its .vhost_init() and reading the supported features - into a new
>vhost_dev_init_backend() helper, and call it from vhost_dev_init().
>
>This is in preparation for CPR restore of vhost-vsock, which needs to learn
>the backend's features at realize time to negotiate them when loading the
>incoming virtio state, but also must defer taking ownership of the device
>to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.
>
>As a result VHOST_SET_OWNER now follows the feature query rather than
>precedes it.  This should be safe, as no backend requires ownership before
>VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
>for it, and vhost-user already does query features from its .vhost_init()
>before set_owner().
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
> include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
> 2 files changed, 45 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


