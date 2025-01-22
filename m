Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E174DC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadbX-0003zy-6t; Wed, 22 Jan 2025 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tadbV-0003zq-Cp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tadbT-0005LX-B8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737563355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7jVjhALPajlz5Af/7beSNlnd/Kuk8wKGy3udbTQAFE=;
 b=RHb2jF3ojkR0X3lGAZ4eDdhJHKj6HGKisy9kjw49Dbh/zi3wPn2ym/xwcYyppcvzOyeUUZ
 KpxyYuI/I8fGuZDoPAT6/v9YZXYf9DgEjMnV53HAkYXfV0pQHhBCjowQJaiYVB8uQOfhLy
 IrKXVpdSRscEfduGSNeOFPDcBy3sHSk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-ibJM4QFCOMektYMp37G-SA-1; Wed, 22 Jan 2025 11:29:14 -0500
X-MC-Unique: ibJM4QFCOMektYMp37G-SA-1
X-Mimecast-MFC-AGG-ID: ibJM4QFCOMektYMp37G-SA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385f0829430so4449324f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737563353; x=1738168153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7jVjhALPajlz5Af/7beSNlnd/Kuk8wKGy3udbTQAFE=;
 b=f94O/tMw9xYAwLLsn2+1hOS9/GkK7ZwO2FmC4drXu87ok75uQS9rNWseQcx1sZNcOT
 vd4BSPu75KtvPpqOfIRdv7HKzfRyqZR4DUCakfbvX2cFFOxfxLTnFtbafU1rViyDR5k/
 mYC8fYYnIMFulpPca2Jt6IUgMGplg049y2jIIU0fYcXv0LgFtdZzxgAsR+FZ+f9ZxREc
 mtyYt8lzQOy4g/NKXwwnxYVMVsvvKo+gQuQYa3P8GJFMxomvC71jSYYm18tllRfxAJpR
 McAMA2mYYDKdSu9fdofA5DGfaNxL/3sQEeo9dGf6YLyhsL9tF/rp/w/vtSjETTwA5dxW
 54ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQOfbtmde2jnZ2xL7olnrmeqpYNmWgWFMasNfAop4Cvl3QSTOn13b2OGHoP4z273UoeihdW6T+OpjJ@nongnu.org
X-Gm-Message-State: AOJu0YwwHbWnsyUIXCkD9YnpsuCFwNtkm5BMwJwozMt8QkaKCfLa4sXj
 ZWe4Iv4qwZirzYjwrhf9GbNfTBzklVqWk+IL28csIecSmLVjzf4AKvKLQAdXtQw76ydsMnsem0P
 INV8+rFOTYvn385pXMmWHLQmEv+D5Ybzr/gOKbJ8g78Qrj2LwjLPQ
X-Gm-Gg: ASbGnctENcA9wmHM1XEi8sFQFIONTPxs+2e/UEE/5LAMYTRC3sG+OwidlcVN+LhtbAo
 uv4bsZKA6Jh2pHkY1h9RFbL+WSih2HmDHbazDEluTFy6+7Ijdq4rLwWElVbjXm3kkdN1VkENppE
 WKrcQauwV5jt1TQ5XK2wb4bB8RrMejcxf3UPB5BiRHqKDngzRoO11A1T6LL2H2sHD3i5+z4C/Cc
 jrSziJqAB5RM2qaMsEP3TFSraH0QfBekpBKzMw9jLl7qAdENsi4g2rbAmURd3qY
X-Received: by 2002:a5d:58d1:0:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38bf5659cd5mr16455951f8f.18.1737563352789; 
 Wed, 22 Jan 2025 08:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR/5FMCTjSRmbJck6QKWypbS/RqyUI3w2NMKoEF2/l+Uk522gt1VALdlgGo8kvQN2YROBi9g==
X-Received: by 2002:a5d:58d1:0:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38bf5659cd5mr16455938f8f.18.1737563352389; 
 Wed, 22 Jan 2025 08:29:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ee:98b0:e487:57f1:2425:c846])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c176sm31976305e9.3.2025.01.22.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:29:11 -0800 (PST)
Date: Wed, 22 Jan 2025 11:29:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250122112849-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Wed, Jan 22, 2025 at 05:20:06PM +0100, Stefano Garzarella wrote:
> On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
> > > On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
> > > > In vhost_user_receive() if vhost_net_notify_migration_done() reports
> > > > an error we display on the console:
> > > >
> > > >  Vhost user backend fails to broadcast fake RARP
> > > >
> > > > This message can be useful if there is a problem to execute
> > > > VHOST_USER_SEND_RARP but it is useless if the backend doesn't
> > > > support VHOST_USER_PROTOCOL_F_RARP.
> > > >
> > > > Don't report the error if vhost_net_notify_migration_done()
> > > > returns -ENOTSUP (from vhost_user_migration_done())
> > > >
> > > > Update vhost_net-stub.c to return -ENOTSUP too.
> > > >
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > ---
> > > > hw/net/vhost_net-stub.c | 2 +-
> > > > net/vhost-user.c        | 2 +-
> > > > 2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> > > > index 72df6d757e4d..875cd6c2b9c8 100644
> > > > --- a/hw/net/vhost_net-stub.c
> > > > +++ b/hw/net/vhost_net-stub.c
> > > > @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
> > > >
> > > > int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
> > > > {
> > > > -    return -1;
> > > > +    return -ENOTSUP;
> > > > }
> > > >
> > > > VHostNetState *get_vhost_net(NetClientState *nc)
> > > > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > > > index 12555518e838..636fff8a84a2 100644
> > > > --- a/net/vhost-user.c
> > > > +++ b/net/vhost-user.c
> > > > @@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
> > > >
> > > >         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
> > > >
> > > > -        if ((r != 0) && (display_rarp_failure)) {
> > > > +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
> > > >             fprintf(stderr,
> > > >                     "Vhost user backend fails to broadcast fake RARP\n");
> > > >             fflush(stderr);
> > > > --
> > > > 2.47.1
> > > >
> > > 
> > > IIUC the message was there since the introduction about 10 years ago
> > > from commit 3e866365e1 ("vhost user: add rarp sending after live
> > > migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
> > > and F_GUEST_ANNOUNCE are not negotiated.
> > > 
> > > That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
> > 
> > rarp is to have destination host broadcast a message with VM address
> > to update the network. Guest announce is when it will instead
> > ask the guest to do this.
> 
> Okay, thanks for explaining to me.
> So if both features are not negotiated, no one is going to broadcast
> the message, right?
> 
> Could that be a valid reason to print an error message in QEMU?
> 
> To me it might be reasonable because the user might experience some
> network problems, but I'm not a network guy :-)
> 
> Thanks,
> Stefano

reasonable, yes.

> > 
> > 
> > > but my understanding is that the message was to notify that the
> > > migration was finished (reading that commit).
> > > 
> > > If neither feature is supported, could this be a problem for the user
> > > and that's why we were printing the message?
> > > 
> > > Thanks,
> > > Stefano
> > 


