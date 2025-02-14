Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B5AC021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwgZ-0004qC-Fw; Fri, 14 Feb 2025 09:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwgQ-0004da-DM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwgN-0006Fn-NH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739543320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHhX0+jNuQbDb5f2riHGfPF2sCaJugZlwIPZVQFRcDQ=;
 b=Vg7nygb/YdJ6b9gAxosDhmwAK+Hiusq25n0tyBxKLE7HPWQdlcCP9QebtlXk+3DPPDsqO8
 HHCGpFLvPea6pYynjR6M3UYEehJDzp9Ehb89hCeYJJCJ9HFzRjd6+oDGRUSA2/Ix+PPRGm
 mQXtWDcbhKjftIUtKU6AOhT9tCbbUxY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4F__0E4BPPuIrTgVZ6sSMw-1; Fri, 14 Feb 2025 09:28:39 -0500
X-MC-Unique: 4F__0E4BPPuIrTgVZ6sSMw-1
X-Mimecast-MFC-AGG-ID: 4F__0E4BPPuIrTgVZ6sSMw_1739543318
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so14565145e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739543318; x=1740148118;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aHhX0+jNuQbDb5f2riHGfPF2sCaJugZlwIPZVQFRcDQ=;
 b=TS+X0LH7tGvWrtOdjKDvZNW93Av05Dj5kl6feV0QUCfOQ8ym8Sfvc2+OhooxYk1NFQ
 CBWRNgFwyCIIAL0yMHD93siO9gaUD9E8KVtgSIVGtmKNcl/FFkcyrDBYoQWrgXd+FgzO
 +6ONQb6YP0qqNewtgKTEVWLiqXO/Gce/YdghEa6AtoIrYhcFZ9N/9tLCSIs+FEwrI7GU
 2JIEWdC1/OhqNxvcnILe7a4XdfOileyYjo8A+59IjKL/o8O0kuL7GHNbTWfdH8T2NG/Y
 rhicfPQ6+9u5jQuTTR5cWG1OqqmHwi6iq5ZR8m3adyz/K6pUI6/kOGfgFq1zamqcs9IK
 AFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4yxX6RLNew46iDi6cuVYq+jxwpyEjLlD4tFThLXjMuGHzQYq1SstSRm4EwSbC6Ku0Ek+Cozup+2cG@nongnu.org
X-Gm-Message-State: AOJu0YzBekADabp3sbsAHdUKodQsl7LDj4NRkpL9Jc01OjVPEZ05ZxVI
 X5EOfiwTIfQzG6iAMHGTkAA2DrKBUhM4eGr8SycAqP3xIy1OpHNK3obM7FfkO8i8PA/Z7TrsL/c
 1JhqD5PFCPBLilItPvZqFD4vSY6GD/fhKksV1Ps/JNOc2AXvbLP5oSlSzIkGFEiNFY4L7W1Yj61
 JoSnmX+TD1O5ttbcK8kNYuCJ/fO1W9xLlaE4o=
X-Gm-Gg: ASbGncuEHA3r6NnVM6gm6ssGPj+8WVV52hWpuhufysVOc8PmcqYblGfb96XFBZUNjkF
 ULMYdV/7hdOyTYE/iczlLZ902lbuXDHCYt4Y0cSMIYo9CczHKEVapmk+jo6VLYhn/ulOoE5tn38
 6aKiCVzB64CYGeY9O53MryGwmnEadPv6yH6kFXOCNfQVoPN+ubNDdvrKNihHGaqdtIU9sZmogaV
 qv/BPa0j31dqyBhkUIlG/+l7vs7aS8Ndfr+ritjVGC2MY7w31aY3/fOKloMq0lIwBlbc0oP0d6t
 zkXnkmqhE8HemNCN6F1ezySM9cR8XtKqZg==
X-Received: by 2002:a05:600c:46ce:b0:439:55a9:1573 with SMTP id
 5b1f17b1804b1-439581cb0e1mr119125775e9.27.1739543317564; 
 Fri, 14 Feb 2025 06:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2LNt3DuqRFbTtYnx6tL1KsW5z3yZ7imB/I89cffNhUpy2duB1t9kQi7jHo0HR+5z/il+Orw==
X-Received: by 2002:a05:600c:46ce:b0:439:55a9:1573 with SMTP id
 5b1f17b1804b1-439581cb0e1mr119125425e9.27.1739543317177; 
 Fri, 14 Feb 2025 06:28:37 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617fc885sm45627425e9.9.2025.02.14.06.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:28:36 -0800 (PST)
Date: Fri, 14 Feb 2025 15:28:34 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?=
 Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laine
 Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <20250214152834.68f5c9df@elisabeth>
In-Reply-To: <Z69Q4bhElTS9bOO_@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <Z69MOEAuE9WHjLjT@redhat.com> <Z69Q4bhElTS9bOO_@redhat.com>
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

On Fri, 14 Feb 2025 14:19:13 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Feb 14, 2025 at 01:59:20PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Feb 14, 2025 at 11:18:55AM +0100, Laurent Vivier wrote: =20
> > > On 14/02/2025 11:06, Markus Armbruster wrote: =20
> > > > Laurent Vivier <lvivier@redhat.com> writes:
> > > >  =20
> > > > > The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> > > > > the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> > > > > when it is disconnected.
> > > > >=20
> > > > > The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> > > > > (label, filename and frontend_open).
> > > > >=20
> > > > > This allows a system manager like libvirt to detect when the serv=
er
> > > > > fails.
> > > > >=20
> > > > > For instance with passt:
> > > > >=20
> > > > > { 'execute': 'qmp_capabilities' }
> > > > > { "return": { } }
> > > > >=20
> > > > > [killing passt here]
> > > > >=20
> > > > > { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
> > > > >    "event": "NETDEV_VHOST_USER_DISCONNECTED",
> > > > >    "data": { "netdev-id": "netdev0" } }
> > > > >=20
> > > > > [automatic reconnection with reconnect-ms]
> > > > >=20
> > > > > { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
> > > > >    "event": "NETDEV_VHOST_USER_CONNECTED",
> > > > >    "data": { "netdev-id": "netdev0",
> > > > >              "info": { "frontend-open": true,
> > > > >                        "filename": "unix:",
> > > > >                        "label": "chr0" } } }
> > > > >=20
> > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com> =20
> > > >=20
> > > > Standard question for events: if a management application misses an
> > > > event, say because it restarts and reconnects, is there a way to ob=
tain
> > > > the missed information with a query command?
> > > >  =20
> > >=20
> > > query-chardev could help but it doesn't provide the netdev id. =20
> >=20
> > It doesn't have to IMHO. The application that created the NIC should kn=
ow
> > what ID it assigned to both the netdev and chardev, and thus should be
> > able to use query-chardev to identify the chardev it previously
> > associated with the netdev. =20
>=20
> That said I kind of wonder whether we should be adding events against
> the chardev directly, instead of against the netdev use of chardev.

What is the advantage? This already works and is consistent with the
existing non-vhost-user mechanism.

--=20
Stefano


