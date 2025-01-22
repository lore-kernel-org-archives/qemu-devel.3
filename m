Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C729C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabGo-0003YT-CS; Wed, 22 Jan 2025 08:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tabGc-0003Vp-VG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tabGY-0004QW-1E
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737554369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIz6DHsHZHdFwPH//tfGVzWId4nWxzbmFy4X7m4czkg=;
 b=UwE+AdM6pWYJ9DtJcKWCY1K4BktRdNWx1iasat0QBKkNIjp4dqocwM2eGrYX2hJnh5mAmI
 q6yhW8/99QlUi1AhcaX7YY1D+4+Mi+4wWvhOp1wt0t6Ly5K1doP2QPQ50utQkIDCKhB314
 v/hfyVr6P0Es+s95U82jOJzmDphky5s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-3-JDJIO9P02Yni8tsy-J_g-1; Wed, 22 Jan 2025 08:59:27 -0500
X-MC-Unique: 3-JDJIO9P02Yni8tsy-J_g-1
X-Mimecast-MFC-AGG-ID: 3-JDJIO9P02Yni8tsy-J_g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bf5ef17b2so4321502f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 05:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737554366; x=1738159166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIz6DHsHZHdFwPH//tfGVzWId4nWxzbmFy4X7m4czkg=;
 b=bhCx6HXrlqOXZ0IYEuePPcAfO5WFgulkFZtipoAV7ojn/oTHH3mpebcxjAIdcdq9J8
 1OsnimIc2x5YYL/cyoxbAn2xjAl1pb0GBmcV9ypMqyzPvmlIEeMaonGmeWiOVKyX0dDW
 4HdGEKjvBv2m5Ac35N7NCYJlTfnxJoq7jbK6u7t8ZR+NhcZzsJaemHXd99C0zdXsNG3o
 qzlPRjtDCUWlKaOwAizgTzbmRvGu3SrAQd64jOpMFjo7bZn455QybDDcx7YN0xtN2K2k
 FOezttOJOSz519cr27B23y6ek+dySKJhWY77q1y7PikMuK1GgpbWCAIRdZB6bwIGjui3
 N9Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMbsrud80i6GN08a0NlNSc0zOmShtg4LM98x09GPNbDKTy59loD9RLTceQOqBxtHa3Ed0gRHnJbbem@nongnu.org
X-Gm-Message-State: AOJu0YyfM3tMM/G072vz+YotG5qxd7LUXgeD/AnRiwVckUGRbymlFl6V
 FbkjGn0JbZQWLhT2YuPYqFkUKiyELEiLjohDlK9cF3/OOE9iQ96dfpU9eagcwiw4lL8x+NLLk+2
 yBixI1qG01SlH0Z1mhgG+i415he0NJIL6Y7Ux4sXK20iQBcob4vqA
X-Gm-Gg: ASbGncvEl8hQ5et6CT/a7oHj1C6eCW1WKUcPaiFlf7s0WxeAUtAwJm2Eb7/JCd3l/nT
 yup+rMnisnrPLMH0EGC5CZ3KQ1yk96gLdAJL0UBkYqB/l2KKMnWBalToeUm+YYJdWlrJzqFAals
 3Szhm3WJSJG+Wsi/MZ+DtfaNX1NYAZpBjdlBgJKt/Kmw32n6fklUT2Yoeqi+GzkVJ9An67BiXor
 Yz1EVy0i3iEZ1SiQa/6hSAnOCGuSIwLlVfGasHjFcE5gCACg7wvEDBkJw8zVOp+
X-Received: by 2002:a5d:5f8c:0:b0:38a:873f:e31f with SMTP id
 ffacd0b85a97d-38bf5677ca4mr18019947f8f.1.1737554366639; 
 Wed, 22 Jan 2025 05:59:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQQo+T3D9WzEIEwmapOJ3MAZ9wejMedZkIpSHpQSkd524EOwdjCDTIqJ9F7GW00rxMLn+KzQ==
X-Received: by 2002:a5d:5f8c:0:b0:38a:873f:e31f with SMTP id
 ffacd0b85a97d-38bf5677ca4mr18019924f8f.1.1737554366317; 
 Wed, 22 Jan 2025 05:59:26 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ee:98b0:e487:57f1:2425:c846])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a73bsm16125576f8f.46.2025.01.22.05.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 05:59:25 -0800 (PST)
Date: Wed, 22 Jan 2025 08:59:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250122085828-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
> On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
> > In vhost_user_receive() if vhost_net_notify_migration_done() reports
> > an error we display on the console:
> > 
> >  Vhost user backend fails to broadcast fake RARP
> > 
> > This message can be useful if there is a problem to execute
> > VHOST_USER_SEND_RARP but it is useless if the backend doesn't
> > support VHOST_USER_PROTOCOL_F_RARP.
> > 
> > Don't report the error if vhost_net_notify_migration_done()
> > returns -ENOTSUP (from vhost_user_migration_done())
> > 
> > Update vhost_net-stub.c to return -ENOTSUP too.
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> > hw/net/vhost_net-stub.c | 2 +-
> > net/vhost-user.c        | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > index 72df6d757e4d..875cd6c2b9c8 100644
> > --- a/hw/net/vhost_net-stub.c
> > +++ b/hw/net/vhost_net-stub.c
> > @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
> > 
> > int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
> > {
> > -    return -1;
> > +    return -ENOTSUP;
> > }
> > 
> > VHostNetState *get_vhost_net(NetClientState *nc)
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index 12555518e838..636fff8a84a2 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
> > 
> >         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
> > 
> > -        if ((r != 0) && (display_rarp_failure)) {
> > +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
> >             fprintf(stderr,
> >                     "Vhost user backend fails to broadcast fake RARP\n");
> >             fflush(stderr);
> > -- 
> > 2.47.1
> > 
> 
> IIUC the message was there since the introduction about 10 years ago
> from commit 3e866365e1 ("vhost user: add rarp sending after live
> migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
> and F_GUEST_ANNOUNCE are not negotiated.
> 
> That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,

rarp is to have destination host broadcast a message with VM address
to update the network. Guest announce is when it will instead
ask the guest to do this.


> but my understanding is that the message was to notify that the
> migration was finished (reading that commit).
> 
> If neither feature is supported, could this be a problem for the user
> and that's why we were printing the message?
> 
> Thanks,
> Stefano


