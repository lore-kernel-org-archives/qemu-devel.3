Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D6C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMhX-0008P5-7i; Fri, 24 Jan 2025 11:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tbMgc-0006aO-2p
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:37:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tbMgT-0007KO-UG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737736643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kGUeyc6SbR140JHQdx4tNf9hGmwc1o9CCgwC7kVgEWY=;
 b=RWHNrLH7haSB5DQYMXuLCR2jespRcgbsSiefT3faKSwoeAi0mx1UqtT+ihVvZFlZz0YybX
 rYo2TM5EriIdMyjLuIfUO8jRg0z8BztW10lHJcvMLWLOhvMP6Des1dKIMa8eGsjfeZC5DK
 ZXfy/D4nyFM7IdxwFjJVKbEcsn1mymE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-utUTwDb-MKWg6OrrR-RDkg-1; Fri, 24 Jan 2025 11:31:48 -0500
X-MC-Unique: utUTwDb-MKWg6OrrR-RDkg-1
X-Mimecast-MFC-AGG-ID: utUTwDb-MKWg6OrrR-RDkg
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5da0ce0ee51so2219819a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736307; x=1738341107;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGUeyc6SbR140JHQdx4tNf9hGmwc1o9CCgwC7kVgEWY=;
 b=oNgaNK2Nf44RZ9R9UGKW6j+PNUOqrUYFNUFkWnDhb8ow1KSMZ/Du6l0BQRq6Qnq0KL
 b3GGFfqxx0Q41lE7z5tpHOmPCcX/N0hVhhriVTnD/CEQnmQSI3GO/BSVdWK8/Cj+vvug
 H5J5HInO8dsT26+zidtOYpMQhMMBaNfDr9gswNOeOMvHaGOhwtXAJ6IbdKwOu18qoJ1n
 feqLrBwd843x8pvomKflqYvS+9op//euMs9xgDPTs44yTL4T2cjfGN8M42CREBSzUHhZ
 k8FIGH+M52yrTzJHuS6MWfQ12OiQjvPwJVOc9raL6jWGot539vjDW3FbYZvRGueZJrQE
 SzDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDNbfm3CIDDhDZdEiGQNv2s12QQT/hHkg28izvWo7kQf1737vqEZzhi7+xPJQ5q0skJWAS0pU+t6GD@nongnu.org
X-Gm-Message-State: AOJu0YzaYoZlFmv+A5/bAQlPd4ZPmNgsTZu+aShsPa2Dg6zd+4RyrxhG
 q1eeB1BkCd8SLYzsYj0dLX39MHgq9py0yoTud5Zj2XLYcfr0qpqxur/2WEzul7/wUczVEDRqPVz
 m1H3NwFFKuDE9C+CKpRJDD2HK4EH71cKFtb0pI6wDvRubbLJWRReW
X-Gm-Gg: ASbGncs+YE7a4dhgRz/BPTtrZFv0q2ljFHE03Ysll4JKU1b51WtUmXagDKQ2Pl9n9nf
 Cjmm7B+DN2JtCMZO652pDqeF/5cU45Q4SrhveeDqkJk6znXKQMBIL3EquzvdNVmbSDmoJ6v8Zur
 DCure9ftp41sWjZY7jgk/Afr27FWcOa2+yls7sssssX7ig4Day+5hTtylJQHCBHXCxt4yzafOZE
 51PDe/BGECxbaXZ3wPrXlsISuZjID3vMxUx8sEXxnfXTs5+dz7LGKj/jrqJ2+wfnRCWy4am1opu
 p1rZLQ==
X-Received: by 2002:a05:600c:3593:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4389144eed4mr248507575e9.25.1737734610651; 
 Fri, 24 Jan 2025 08:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh8RBZDW6JWrVfbOFPcLEGc6pLkkEdTeWD7+gqFx3gqVnnx5V1kpHM/6RlkFtRTNItrgGfxw==
X-Received: by 2002:a05:600c:3593:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4389144eed4mr248506835e9.25.1737734610060; 
 Fri, 24 Jan 2025 08:03:30 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507e0csm30285245e9.20.2025.01.24.08.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:03:29 -0800 (PST)
Date: Fri, 24 Jan 2025 17:03:27 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250124170327.448805ad@elisabeth>
In-Reply-To: <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[Cc'ed Thibaut as author of 3e866365e1eb ("vhost user: add rarp sending
after live migration for legacy guest")]

On Wed, 22 Jan 2025 17:51:07 +0100
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Wed, Jan 22, 2025 at 05:41:15PM +0100, Laurent Vivier wrote:
> >On 22/01/2025 17:20, Stefano Garzarella wrote: =20
> >>On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote: =20
> >>>On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote: =20
> >>>>On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote: =20
> >>>>> In vhost_user_receive() if vhost_net_notify_migration_done() reports
> >>>>> an error we display on the console:
> >>>>>
> >>>>>=C2=A0 Vhost user backend fails to broadcast fake RARP
> >>>>>
> >>>>> This message can be useful if there is a problem to execute
> >>>>> VHOST_USER_SEND_RARP but it is useless if the backend doesn't
> >>>>> support VHOST_USER_PROTOCOL_F_RARP.
> >>>>>
> >>>>> Don't report the error if vhost_net_notify_migration_done()
> >>>>> returns -ENOTSUP (from vhost_user_migration_done())
> >>>>>
> >>>>> Update vhost_net-stub.c to return -ENOTSUP too.
> >>>>>
> >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>>> ---
> >>>>> hw/net/vhost_net-stub.c | 2 +-
> >>>>> net/vhost-user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> >>>>> 2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> >>>>> index 72df6d757e4d..875cd6c2b9c8 100644
> >>>>> --- a/hw/net/vhost_net-stub.c
> >>>>> +++ b/hw/net/vhost_net-stub.c
> >>>>> @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState  =20
> >>>>*net, VirtIODevice *dev, bool mask) =20
> >>>>>
> >>>>> int vhost_net_notify_migration_done(struct vhost_net *net, char* ma=
c_addr)
> >>>>> {
> >>>>> -=C2=A0=C2=A0=C2=A0 return -1;
> >>>>> +=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
> >>>>> }
> >>>>>
> >>>>> VHostNetState *get_vhost_net(NetClientState *nc)
> >>>>> diff --git a/net/vhost-user.c b/net/vhost-user.c
> >>>>> index 12555518e838..636fff8a84a2 100644
> >>>>> --- a/net/vhost-user.c
> >>>>> +++ b/net/vhost-user.c
> >>>>> @@ -146,7 +146,7 @@ static ssize_t  =20
> >>>>vhost_user_receive(NetClientState *nc, const uint8_t *buf, =20
> >>>>>
> >>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D vhost_net_not=
ify_migration_done(s->vhost_net, mac_addr);
> >>>>>
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((r !=3D 0) && (disp=
lay_rarp_failure)) {
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((r !=3D 0) && (r !=
=3D -ENOTSUP) && (display_rarp_failure)) {
> >>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fprintf(stderr,
> >>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Vhost user backend =
fails to broadcast fake RARP\n");
> >>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fflush(stderr);
> >>>>> --
> >>>>> 2.47.1
> >>>>> =20
> >>>>
> >>>>IIUC the message was there since the introduction about 10 years ago
> >>>>from commit 3e866365e1 ("vhost user: add rarp sending after live
> >>>>migration for legacy guest"). IIUC -ENOTSUP is returned when both F_R=
ARP
> >>>>and F_GUEST_ANNOUNCE are not negotiated.
> >>>>
> >>>>That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is f=
or, =20
> >>>
> >>>rarp is to have destination host broadcast a message with VM address
> >>>to update the network. Guest announce is when it will instead
> >>>ask the guest to do this. =20
> >>
> >>Okay, thanks for explaining to me.
> >>So if both features are not negotiated, no one is going to broadcast
> >>the message, right?
> >>
> >>Could that be a valid reason to print an error message in QEMU?
> >>
> >>To me it might be reasonable because the user might experience some
> >>network problems, but I'm not a network guy :-) =20
> >
> >I'm working on adding vhost-user to passt[1], and in this case we=20
> >don't need to broadcast any message. =20
>=20
> Okay, so please can you add that to the commit description and also
> explaining why you don't need that?

By the way, we don't need that in passt because we don't need to update
any ARP table. Even if the guest changes its MAC address, with passt,
nobody is going to notice.

> >So I don't implement VHOST_USER_SEND_RARP and I don't want the error=20
> >message to spoil my console. =20
>=20
> Fair enough, but at that point, if it's valid to have both feature not
> negotiated, IMHO is better to return 0 in vhost_user_migration_done().
> Maybe adding also a comment to explain that in your scenario you don't
> need to do nothing (like if guest supports GUEST_ANNOUNCE).
>=20
> >-ENOTSUP is an error message for developer not for user. =20
>=20
> I was referring to the "Vhost user backend fails to broadcast fake RARP"
> error message we are skipping here.

By the way, I think that that message is inaccurate on a number of
other levels:

- if the back-end doesn't even try, it can't fail, and "fails"
  indicates... failure?

- RARP is an obsolete protocol, but there's no such thing as a fake
  protocol. It's not even a fake message, it's a simple RARP broadcast
  message, with the correct MAC address. It's "dummy", at most

- I read the whole thread but still I can't understand why we have a
  capability then: what does it (or its absence) mean?

Regardless of that, sure, let's go ahead and add the fake (that one
*is* fake) callback in passt, which Laurent just sent a patch for. We
need it anyway as a workaround for compatibility with current/older
versions of QEMU.

But I don't understand why we're leaving this as it is.

--=20
Stefano


