Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C946EC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwpq-0004gM-1t; Fri, 14 Feb 2025 09:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwpn-0004fp-EO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwpl-0000fQ-Fi
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739543904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkzE2c+qAVXPmCyAu0H+trYpMUewBsr9GkQeZruPd7E=;
 b=Nvi8qAOCQM2todz+iYgoUHZhppEmI1Y1pfSMSPUp2iHMXMy9fHnik4K8uWasXuAJaUGsDq
 g/jl+Gl4YCuoErLD5dm1vokJMEseZMcen1LjY/DSyrrezajD1Qt51/cI3k/dC6b3KFmeSC
 45VFF5byXWX+g54ehwaArqhqTKx/duU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-CrDEXXWgONSXIMgdAwjJQw-1; Fri, 14 Feb 2025 09:38:23 -0500
X-MC-Unique: CrDEXXWgONSXIMgdAwjJQw-1
X-Mimecast-MFC-AGG-ID: CrDEXXWgONSXIMgdAwjJQw_1739543902
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393ed818ccso19150205e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739543901; x=1740148701;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkzE2c+qAVXPmCyAu0H+trYpMUewBsr9GkQeZruPd7E=;
 b=cEfR553wKQF0IhJ1kpo7d1sTFC/1gXJgc8CtbobmLPUUGHIrQ6TXC/bkB+cWL1ASRH
 QgJcnsDhw5gXHTIk7xQFvxsVemtYtv2JA8xK7o/qPcO3ej/2YMF9n+SHejaFM0xnfR9m
 gb7hK9JqVp0fxXAhqBOeur7ZnwIg2ZHrAD/UsQ58hUMtU6YADlwF593ymPVbgymICzFa
 UJ8HRjzv4SFp80UhtrNeJAA93wlGqeCzRJJ+rWEcybjkv/usIQNnM4+ds9zBrryo43lL
 xvNT5lY+fqpUrGWEPz5SFybl41RwRAkhmdhX6jBXd0mpyh3rR/s4YdzBnUtgAoM5NmjP
 isHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhycU/CXWTZ09RW1AW7jKfO4yP2BJdnbzEdUsIIPkrfCcg+sLs4kRWN8qWjzDBxTkTdiVXEkvpsEFU@nongnu.org
X-Gm-Message-State: AOJu0YziABlb1W/0Pe4SMgm4YoqnPAACsTJu0XfSKwTqDERFozZSoCSK
 MpsVJiS2o/ZVXh2WPlUCOPmVkLfWhm0VxB1pq+XduWOoMiLBrDebxjhRBEb8V7GZ1+bJv65OUst
 85Vh6Cq1dHNUytj0N2ZDdZL7prrAbdXiGLPhvHenu3JFf/NpsfTJ6jhDQCCI4b7s6EnNjJrsvYR
 EsFbHC4CL9einEtWg96fC/9X2bzabg5TDQ5uY=
X-Gm-Gg: ASbGncu8uy4il3ZQYUyCc/Q5wXaTiQ+6LBX1T+oEyXw96pg13SG2U2brxAK8Z/GV/9H
 9x9cgKYdn1msCs1c1QqhN7UkOtM+OXZHvf0PG5nnQFEZvlvx0GshJ0v7wUbkAH+Fwbxnh2vLh3a
 +dRO2UHhro+tttjIn5YNLDR5XtpY50HJNC8PHz7StDEmMwepYGW0Tp73xIStWxUEFmpf3srp1Jc
 g/ITv4nASETt2CIeYCEglpQ5u04PAwyuQ3DJ+cxfXpQfB7qjvBkb3oTZhJa9z5g6qNUllfO9mh0
 cO+34GDdL84ktKcFWv3oUwNO7HOl+YpzDA==
X-Received: by 2002:a05:600c:1c91:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439581cab45mr142461985e9.31.1739543901226; 
 Fri, 14 Feb 2025 06:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcnexl+F4M/5JV9T/EKoashURzCI4xmNF7vNBYuMxohCOOX7o/TbCKXu3fQY5L1U8/cSbGuw==
X-Received: by 2002:a05:600c:1c91:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439581cab45mr142461455e9.31.1739543900742; 
 Fri, 14 Feb 2025 06:38:20 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b83a3sm76632215e9.33.2025.02.14.06.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:38:20 -0800 (PST)
Date: Fri, 14 Feb 2025 15:38:19 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?=
 Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laine
 Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <20250214153819.286365e4@elisabeth>
In-Reply-To: <Z69TxVIQS16yDiS2@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <Z69MOEAuE9WHjLjT@redhat.com> <Z69Q4bhElTS9bOO_@redhat.com>
 <20250214152834.68f5c9df@elisabeth> <Z69TxVIQS16yDiS2@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 14 Feb 2025 14:31:33 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Feb 14, 2025 at 03:28:34PM +0100, Stefano Brivio wrote:
> > On Fri, 14 Feb 2025 14:19:13 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Feb 14, 2025 at 01:59:20PM +0000, Daniel P. Berrang=C3=A9 wro=
te: =20
> > > > On Fri, Feb 14, 2025 at 11:18:55AM +0100, Laurent Vivier wrote:   =
=20
> > > > > On 14/02/2025 11:06, Markus Armbruster wrote:   =20
> > > > > > Laurent Vivier <lvivier@redhat.com> writes:
> > > > > >    =20
> > > > > > > The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> > > > > > > the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> > > > > > > when it is disconnected.
> > > > > > >=20
> > > > > > > The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> > > > > > > (label, filename and frontend_open).
> > > > > > >=20
> > > > > > > This allows a system manager like libvirt to detect when the =
server
> > > > > > > fails.
> > > > > > >=20
> > > > > > > For instance with passt:
> > > > > > >=20
> > > > > > > { 'execute': 'qmp_capabilities' }
> > > > > > > { "return": { } }
> > > > > > >=20
> > > > > > > [killing passt here]
> > > > > > >=20
> > > > > > > { "timestamp": { "seconds": 1739517243, "microseconds": 11508=
1 },
> > > > > > >    "event": "NETDEV_VHOST_USER_DISCONNECTED",
> > > > > > >    "data": { "netdev-id": "netdev0" } }
> > > > > > >=20
> > > > > > > [automatic reconnection with reconnect-ms]
> > > > > > >=20
> > > > > > > { "timestamp": { "seconds": 1739517290, "microseconds": 34377=
7 },
> > > > > > >    "event": "NETDEV_VHOST_USER_CONNECTED",
> > > > > > >    "data": { "netdev-id": "netdev0",
> > > > > > >              "info": { "frontend-open": true,
> > > > > > >                        "filename": "unix:",
> > > > > > >                        "label": "chr0" } } }
> > > > > > >=20
> > > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>   =20
> > > > > >=20
> > > > > > Standard question for events: if a management application misse=
s an
> > > > > > event, say because it restarts and reconnects, is there a way t=
o obtain
> > > > > > the missed information with a query command?
> > > > > >    =20
> > > > >=20
> > > > > query-chardev could help but it doesn't provide the netdev id.   =
=20
> > > >=20
> > > > It doesn't have to IMHO. The application that created the NIC shoul=
d know
> > > > what ID it assigned to both the netdev and chardev, and thus should=
 be
> > > > able to use query-chardev to identify the chardev it previously
> > > > associated with the netdev.   =20
> > >=20
> > > That said I kind of wonder whether we should be adding events against
> > > the chardev directly, instead of against the netdev use of chardev. =
=20
> >=20
> > What is the advantage? This already works and is consistent with the
> > existing non-vhost-user mechanism. =20
>=20
> The advantage is that chardevs are used in many places across QEMU, so
> emitting the events against the chardev is more broadly useful to
> consumers of QEMU, than doing a special case that only benefit vhostuser
> NICS.

It's not so much of a special case because it would be perfectly in
line with the NETDEV_STREAM_DISCONNECTED event and its usage in
applications (the only current user being libvirt).

That's a proven approach and the matching implementation for passt is
trivial because of that.

--=20
Stefano


