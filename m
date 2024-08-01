Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33529C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZR8y-0005jo-Bw; Thu, 01 Aug 2024 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZR8q-0005F1-QS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZR8p-0000sp-75
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722500789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhZ6QMQB3142AyvmbG2JjrA9Ti0/Hp7zJ/w803wTJzE=;
 b=ewOJfa6xbTlYIIev6bkO7YVoA+cAcWl/DhxRI1hqwz5xWn6dxvGFqLKbP5DWas82zB3xBU
 INcPqPCq6H2IlKael6u6LrHVwgxKrdk8MRVHAEyrEwHZf1rXAksd81TkK5VrPXTCINOXmc
 uS002SeGaHOq8/w8bYg4X0TBGCVus8o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-M59pHjDKNR2bLj5oEFQ3hg-1; Thu, 01 Aug 2024 04:26:28 -0400
X-MC-Unique: M59pHjDKNR2bLj5oEFQ3hg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a8b0832defso2897068a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 01:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722500787; x=1723105587;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhZ6QMQB3142AyvmbG2JjrA9Ti0/Hp7zJ/w803wTJzE=;
 b=lOOJmD4c0lAn9p3+KNb4bx2tFZxgDeA/JbcNMIVTZqch0KmXwtHDY1tW3D/cRwnt8d
 i4K1G5M4N5th8d6Lkm4b2bo8M00vQZ6qQTn+t2XiF02HnsoMtg218iHrdPzf+9M5r90Q
 3Vw+SuxwBVfTnfvaSqDhhGWGvBXiUHHRf1tw16uAZPmH4rMb6buZKvGjQdKnwuApWlv4
 1jbyMv3/v9R6wvPrM3/AZPs+vH7iJ5BmLohv+82/khlG2iEyyCt4LIekeELKRxLhDF70
 g0oYvLBj5ifU7821xCBVPQgxy+o+Gg8iiY7f1aUbMfbBy9L83bl0/bHsTdFiipqLHvNt
 wlfA==
X-Gm-Message-State: AOJu0YykiYQTH7+RKwXG7ANUe4OaDjfJMsQeGp6FVw0OQObildGVw9Yu
 Kxa9NVMTrtUPJHDHhuXx/inMFvA9iGaCL3ZLXpUuAiapihmcLgz2g14C72xMy34/ixmqjKYQRDG
 udvEJqeOIRdUqZph9gXAEHWMiMF5q28bU2KEaWHWbSWorBG6dll2O2htcOrZw
X-Received: by 2002:a05:6402:b1c:b0:57c:b82e:884b with SMTP id
 4fb4d7f45d1cf-5b77d476c87mr475542a12.19.1722500786992; 
 Thu, 01 Aug 2024 01:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpGdRh25n1ZQD31NClMBUwI7PQZnOCxPbbiTly6N9X01N16TdE/fN1E7QkKG9+AnULD7eoLA==
X-Received: by 2002:a05:6402:b1c:b0:57c:b82e:884b with SMTP id
 4fb4d7f45d1cf-5b77d476c87mr475516a12.19.1722500786297; 
 Thu, 01 Aug 2024 01:26:26 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590d29sm9730818a12.21.2024.08.01.01.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 01:26:23 -0700 (PDT)
Date: Thu, 1 Aug 2024 04:26:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240801042507-mutt-send-email-mst@kernel.org>
References: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
 <20240720145819-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.0ff73b39.722e.4462.b426.f477adef04f2@feishu.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jul 21, 2024 at 11:20:56AM +0800, BillXiang wrote:
> 
> > From: "Michael S. Tsirkin"<mst@redhat.com>
> > Date:  Sun, Jul 21, 2024, 03:01
> > Subject:  Re: [PATCH v2] vhsot-user: Do not wait for replay for not sent VHOST_USER_SET_LOG_BASE
> > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > Cc: <qemu-devel@nongnu.org>
> > typos in subject do not inspire confidence.
> 
> Sorry
> 
> > 
> > On Thu, Jul 18, 2024 at 04:31:03PM +0800, BillXiang wrote:
> > > From: BillXiang <xiangwencheng@dayudpu.com>
> > > 
> > > We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
> > > in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.html
> > 
> > Pls put commit here not ML link:
> > commit ABCDEFGHIKLM ("subject")
> > 
> > > and will send this message only for vq 0.
> > 
> > you mean "should send"?
> > 
> 
> What I mean is the commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests") 
> will cause VHOST_USER_SET_LOG_BASE to be sent only when 'vq_index == 0' in vhost_user_write, 
> so that we can not use vhost_user_read to get reply when 'vq_index != 0'


do we try to do it now? in which configurations?


> > 
> > > 
> > > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> > > ---
> > > V1[1] -> V2:
> > >  - Refrain from appending flags to messages that could 
> > > precipitate validation failures upon execution of the 
> > > `vhost_user_read_header` function. 
> > > 
> > > [1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.html
> > > ---
> > >  hw/virtio/vhost-user.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 00561daa06..fd12992d15 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
> > >          return ret;
> > >      }
> > >  
> > > -    if (shmfd) {
> > > +    if (shmfd && (dev->vq_index == 0)) {
> > 
> > extra () not needed here.
> > 
> > >          msg.hdr.size = 0;
> > >          ret = vhost_user_read(dev, &msg);
> > >          if (ret < 0) {
> > > -- 
> > > 2.30.0


