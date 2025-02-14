Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCC0C021A7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwXO-0004LC-GK; Fri, 14 Feb 2025 09:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwX2-0004FU-Ey
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwWZ-00052x-9i
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739542714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxxpLyq7CL7if20tabnsJ+qLz4o4nTXOro7GFaFAl/w=;
 b=Gqi+xbyOXtOteZO5g9m0VyNKWFKnQh1z1bcQEB6+LI33lAAlkoUBAoFNkRty2MjXvdSFa1
 ppCRjOQj34JqM3pZ9VZNVwmRbAOHCf0rv37f+SqDwYOZHg5UCAngGuID3+rqcst29QDycD
 NprwZuCZRrRK28v7qYEPB3pKrxwIWVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-HcAQrLPSOle333WSkQLKug-1; Fri, 14 Feb 2025 09:18:32 -0500
X-MC-Unique: HcAQrLPSOle333WSkQLKug-1
X-Mimecast-MFC-AGG-ID: HcAQrLPSOle333WSkQLKug_1739542711
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so546980f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739542711; x=1740147511;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxxpLyq7CL7if20tabnsJ+qLz4o4nTXOro7GFaFAl/w=;
 b=tpocprI14tXRpmBo4tVkmjEZHd+7J5F1GJinN7XEycK0EFkMsw9NK1Mxe9bmkt/Xgp
 gEN0oV1VR0OmW5GVkOLmt/9v+gMGM6nG8+zKxFNN1Ft/R0GiSoeCZE5BJFiX/WIxCim2
 Gv9ip6IJc0oMAoJX00o0/yfb5JutgtfIqMbOHHg6kxxF70o/GqAcNmb3yuX8JRF+F3Js
 wmFREQ8wrWDYYzudn3hIF52bOznKbgU+5usnADZWyLCVJMJtD6C5yZKBW3RvUhdBVOHU
 tab4aVUCOfOIUGiu3GXdzFFQm+oF7L6zaVhcC+X37yv0Gr8g8TZzn+Ax6Mf3wT77QacN
 rxHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Hp7Wo51iDfRgAZJYdwikRi3M/whCE5wPcctjNmf+6+VOKASwqBXuK58DtDLLPy6+LA1nWLjfT6QD@nongnu.org
X-Gm-Message-State: AOJu0Yxr1nfCdly+7pZrxqF0YRNTfY+1cAd6cpOHQNNfLzu8qLxwb/0y
 puPIXF2JzMLSKPigMoGIvn3yA1TaVLGvd00vfA5CnjOEQ5QgpGwwpI10L2S0CEavibOSh9HjHzo
 VztAqan06q1+Fn5ty+ly4v4GUc90vGLMEa3SqHcEtgvnmHCH2dZusYxxSn6bNnV5txwj8cqy/oK
 J36gsAtrNRfx1JHfQ1PvxWzJumq+mbUXssHNo=
X-Gm-Gg: ASbGncu5AlZjNAWwULEAlGJVlODb3cDiwNHCjt0c3CUAgM+gJWPraYT8U6UXPMcJj+p
 p+CjUdQt+3jCDP5IkK1tOZNRWiW/DMsLjzfaMpD+8UiXAZ++kKIG0IrYby4bYKsUZn/9EvQpzIP
 1IMAAqQGNKbkHBfPSCO3tkTb8l1D8FM9LeHJo1mzj6RgQBHWfjrn6SUbUuhDm+FB0PXcq6GHrV4
 o8K5AuF4w6pdd2ZgyyWSGCffv6HQQl33bDkNzLVkRG1+zlaAzTEdjzn/u25CY0lnW4HPNf4lcl6
 FP2S6CAOuJmhQueo
X-Received: by 2002:a05:6000:1a8c:b0:38d:c6b8:9fe1 with SMTP id
 ffacd0b85a97d-38f24f95f5fmr8102649f8f.24.1739542710703; 
 Fri, 14 Feb 2025 06:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE36csMKDW7lScRmHDEKOTKIuMvBFdrlDK968XPRpDKqH3vxj7M0JyGILC6CDe7eVXYfy56Aw==
X-Received: by 2002:a05:6000:1a8c:b0:38d:c6b8:9fe1 with SMTP id
 ffacd0b85a97d-38f24f95f5fmr8102595f8f.24.1739542710276; 
 Fri, 14 Feb 2025 06:18:30 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7979sm4657753f8f.83.2025.02.14.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:18:29 -0800 (PST)
Date: Fri, 14 Feb 2025 15:18:27 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?=
 Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laine
 Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <20250214151827.745d04f2@elisabeth>
In-Reply-To: <Z69MOEAuE9WHjLjT@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <Z69MOEAuE9WHjLjT@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 14 Feb 2025 13:59:20 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Feb 14, 2025 at 11:18:55AM +0100, Laurent Vivier wrote:
> > On 14/02/2025 11:06, Markus Armbruster wrote: =20
> > > Laurent Vivier <lvivier@redhat.com> writes:
> > >  =20
> > > > The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> > > > the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> > > > when it is disconnected.
> > > >=20
> > > > The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> > > > (label, filename and frontend_open).
> > > >=20
> > > > This allows a system manager like libvirt to detect when the server
> > > > fails.
> > > >=20
> > > > For instance with passt:
> > > >=20
> > > > { 'execute': 'qmp_capabilities' }
> > > > { "return": { } }
> > > >=20
> > > > [killing passt here]
> > > >=20
> > > > { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
> > > >    "event": "NETDEV_VHOST_USER_DISCONNECTED",
> > > >    "data": { "netdev-id": "netdev0" } }
> > > >=20
> > > > [automatic reconnection with reconnect-ms]
> > > >=20
> > > > { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
> > > >    "event": "NETDEV_VHOST_USER_CONNECTED",
> > > >    "data": { "netdev-id": "netdev0",
> > > >              "info": { "frontend-open": true,
> > > >                        "filename": "unix:",
> > > >                        "label": "chr0" } } }
> > > >=20
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com> =20
> > >=20
> > > Standard question for events: if a management application misses an
> > > event, say because it restarts and reconnects, is there a way to obta=
in
> > > the missed information with a query command?
> > >  =20
> >=20
> > query-chardev could help but it doesn't provide the netdev id. =20
>=20
> It doesn't have to IMHO. The application that created the NIC should know
> what ID it assigned to both the netdev and chardev, and thus should be
> able to use query-chardev to identify the chardev it previously
> associated with the netdev.

It does (of course?), see processNetdevStreamDisconnectedEvent() in
libvirt, src/qemu/qemu_driver.c:

static void
processNetdevStreamDisconnectedEvent(virDomainObj *vm,
                                     const char *netdevId)
{

[...]

    const char *devAlias =3D STRSKIP(netdevId, "host");

    /* The event sends us the "netdev-id", but we don't store the
     * netdev-id in the NetDef and thus can't use it to find the
     * correct NetDef. We *do* keep the device alias in the NetDef,
     * and by convention the netdev-id is always "host" + devAlias, so
     * we just need to remove "host" from the front of netdev-id to
     * get the alias, which we can then use to find the proper NetDef.
     */

[...]

    if (virDomainDefFindDevice(vm->def, devAlias, &dev, true) < 0) {
        VIR_WARN("NETDEV_STREAM_DISCONNECTED event received for non-existen=
t device %s in domain %s",
                 devAlias, vm->def->name);
        goto endjob;
    }

[...]

--=20
Stefano


