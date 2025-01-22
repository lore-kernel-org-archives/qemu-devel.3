Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45313C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadSl-0002hV-Fm; Wed, 22 Jan 2025 11:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tadSj-0002hN-QS
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tadSh-0003Uj-Pa
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737562814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rsWVYly2G5y/1iTxgOSxgkPNRl/dBwlmYtOgGwHENIA=;
 b=ZYfr02Et6upRbnQK8GFXXct0seJoT3T8ejNkQc/tw46Ao+sJ8jAHlMZSWJEm+P3Io6XZio
 T9ogOxFYs0Hjsr9IDoCL0w/bKe4oU6K2UHFbrIr1tbWf2bK78BoX4w/lTBi7Oy6l5OyO5I
 anyDBqJy4EskQxc52Xa0sd7+34z8UyE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-lev2rCtyPtGcZaKjyXHdLg-1; Wed, 22 Jan 2025 11:20:12 -0500
X-MC-Unique: lev2rCtyPtGcZaKjyXHdLg-1
X-Mimecast-MFC-AGG-ID: lev2rCtyPtGcZaKjyXHdLg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6732a1af5so730475466b.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562811; x=1738167611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsWVYly2G5y/1iTxgOSxgkPNRl/dBwlmYtOgGwHENIA=;
 b=K9EWhzQY7F0utQxicxKD2vV/PgAGij+iAfnlagJVa15Ft7iLP2kl9LgHyFCCnSvaTC
 yql8RNBcCHDVPT8dGCtCawUHfayesYDGEKXi4VwD+ghtY4+yBxM/xuEDS9TLTOO4d5Wv
 009vJJ+mXq2gun5zPqxJQUWKsWYVt3eQr9XFaAKddE2FbCKqB6rGFImXWOHLBAGgVRPK
 Yq4OPK8CPf272rtGbVlBrbe/i/gPIwg3e1tM3A4ffWJ9khQesfgphU58Wtrac+eG8Phd
 xjR9zw2Ay683dSOHMl4XV6Ja9fgsZZDWAi+hHtDzvNTqunnREJFuXrPpGW6eE7hKOSg1
 /IiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYVHMq6foEKAbZuw5KEB5hu1rlHRFdAZFutUUn20CMliEk7iyZzZJt1T8HC6E838kVwJA+2XLRQSWb@nongnu.org
X-Gm-Message-State: AOJu0Yyn9qNwKGgh7tTWJA26t0A4Pt6q3XJsjAA7IJHo1F3MHxq9MkJo
 r810a5cgU0+EeH/WnZkPGsYsuIuENvZKAVEpDuvD0JOartBafFnVRdsIiVgH61xp6kYyNf4kRl6
 2o0THbukl1Bq/z6F+Y/SFLcWVd9N7l6kXNgbQ/UQLC4xoiRIp9PiL
X-Gm-Gg: ASbGncsB83AsMlab/5IgpMSZZBHtCTKXAHfMW9Rm4f2E0fDnHHxIKnKKSkr/Alz0lAp
 zCb5LqC7zgC6QqSNqBqkRRJoWmgKOt5Evo/dPDrgRfB+tbXwUbtV9/bUbs81rTk9E1mJ2GHbAUE
 2bbdLvUWKHHWfi7fD91I0JLO8Wr/kgej3ZCNV4HbkbdcSZU0vFzJ6QwY4XOfcFmkJKHcHL4lzHQ
 gIvE9sf+A260SC2wpkkUWpx3etVnQkOaVlI1lkfd/4dxGiVuh1wnv3Mb3ObQfFrBAqOL5tdruBa
 EhcRxgaNOQIgQXqFlDEPX4mr8RfXYW/MVlhrG11Qn89pHw==
X-Received: by 2002:a17:906:6147:b0:ab3:9a57:f4fd with SMTP id
 a640c23a62f3a-ab39a5802damr1467031866b.28.1737562811522; 
 Wed, 22 Jan 2025 08:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErFN0jXAlocLAJcY3OV3zAcduITxX8PuFO/N5RMEDGDW4Yp+fCCmjQlqB3RJRIKhajkWGfCw==
X-Received: by 2002:a17:906:6147:b0:ab3:9a57:f4fd with SMTP id
 a640c23a62f3a-ab39a5802damr1467028666b.28.1737562810824; 
 Wed, 22 Jan 2025 08:20:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it.
 [82.53.134.100]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab64998511esm227598166b.68.2025.01.22.08.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:20:10 -0800 (PST)
Date: Wed, 22 Jan 2025 17:20:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250122085828-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
>On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
>> On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
>> > In vhost_user_receive() if vhost_net_notify_migration_done() reports
>> > an error we display on the console:
>> >
>> >  Vhost user backend fails to broadcast fake RARP
>> >
>> > This message can be useful if there is a problem to execute
>> > VHOST_USER_SEND_RARP but it is useless if the backend doesn't
>> > support VHOST_USER_PROTOCOL_F_RARP.
>> >
>> > Don't report the error if vhost_net_notify_migration_done()
>> > returns -ENOTSUP (from vhost_user_migration_done())
>> >
>> > Update vhost_net-stub.c to return -ENOTSUP too.
>> >
>> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> > ---
>> > hw/net/vhost_net-stub.c | 2 +-
>> > net/vhost-user.c        | 2 +-
>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>> > index 72df6d757e4d..875cd6c2b9c8 100644
>> > --- a/hw/net/vhost_net-stub.c
>> > +++ b/hw/net/vhost_net-stub.c
>> > @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask)
>> >
>> > int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
>> > {
>> > -    return -1;
>> > +    return -ENOTSUP;
>> > }
>> >
>> > VHostNetState *get_vhost_net(NetClientState *nc)
>> > diff --git a/net/vhost-user.c b/net/vhost-user.c
>> > index 12555518e838..636fff8a84a2 100644
>> > --- a/net/vhost-user.c
>> > +++ b/net/vhost-user.c
>> > @@ -146,7 +146,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
>> >
>> >         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
>> >
>> > -        if ((r != 0) && (display_rarp_failure)) {
>> > +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
>> >             fprintf(stderr,
>> >                     "Vhost user backend fails to broadcast fake RARP\n");
>> >             fflush(stderr);
>> > --
>> > 2.47.1
>> >
>>
>> IIUC the message was there since the introduction about 10 years ago
>> from commit 3e866365e1 ("vhost user: add rarp sending after live
>> migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
>> and F_GUEST_ANNOUNCE are not negotiated.
>>
>> That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
>
>rarp is to have destination host broadcast a message with VM address
>to update the network. Guest announce is when it will instead
>ask the guest to do this.

Okay, thanks for explaining to me.
So if both features are not negotiated, no one is going to broadcast
the message, right?

Could that be a valid reason to print an error message in QEMU?

To me it might be reasonable because the user might experience some
network problems, but I'm not a network guy :-)

Thanks,
Stefano

>
>
>> but my understanding is that the message was to notify that the
>> migration was finished (reading that commit).
>>
>> If neither feature is supported, could this be a problem for the user
>> and that's why we were printing the message?
>>
>> Thanks,
>> Stefano
>


