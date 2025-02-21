Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F804C021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 01:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHhB-0001kJ-Vw; Thu, 20 Feb 2025 20:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tlHhA-0001kB-P8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 20:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tlHh8-0000Ay-Hi
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 20:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740100747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4GP7Y4uTGPrBnJFz/eAOqJDSKLtplb/msigwmD5KgU=;
 b=P0A5Yuw4Or9bnAwAae1AwzCGznC9ml+SgtTvTPq38ij5h8ou8X4L5BSCj2wdulmMW0Bfl1
 tbL8vY/xQEV0EECdtEU4q2IfbNxtHlDM+B8fztXZIEV2laKcpLJ6y69DrnFnO/SCLM7XK9
 Ve0YZNLT9HYgqljP36pDqR/SN/a1dIc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-QvAqXN3MP_GZlAifihZYmA-1; Thu, 20 Feb 2025 20:19:04 -0500
X-MC-Unique: QvAqXN3MP_GZlAifihZYmA-1
X-Mimecast-MFC-AGG-ID: QvAqXN3MP_GZlAifihZYmA_1740100744
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc4dc34291so3180886a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 17:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740100744; x=1740705544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4GP7Y4uTGPrBnJFz/eAOqJDSKLtplb/msigwmD5KgU=;
 b=lAqGGppdsXxeGmWKY0ENSSrhj2E5aC4NtkT4ajtn1rhf6Y0lJgy6x4nYzPFwdi5CzI
 c5gy+JqDRP+Wt3QqSlpvM1fSN2/RjwspQq8KJRm+PWsVYI45yBOAdXKTRfyw4++D4nYi
 NnSA8kSvHXR/JEW+1GWxsQCzqjRYEyUuyJJx45linQib1g2Ekv9mPdKW4CdKUxHS27dV
 2yA3qpaoBdQ7mrcapCQmt5EaXzvDCKIgznVEFcuipCQHC5TkzR1pa1EsCBwXHtRSwM+r
 IMlKxSkVAb0yOQ+1ScSku6ZYDtlMwrgVe3gc5uDCGK+lxfe79ohVNCI+V1RKA9MhGggD
 zZnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNFL0Tu/YRAVzKn7GQu/REb994ZhDytH63Tl8V42H+X/L0NnbR/LVTe/AFki2H3UqIyMdnVl3Ht3qm@nongnu.org
X-Gm-Message-State: AOJu0YxGfjIRV/f1BHMK+YQwFZ10VshkQzFub7TK6VavdneJU43qcqlR
 eivDdTGGA/uj2X6BtbEMT5sbelONr1RDR11tLy/ydZ0nztgOOzHgOug9Ab7wSmoFrpShMq3hiC0
 k8lzsuGjtYGEeNJriixjGLRM7STqSFj+obw0jUO4onJOBwB1Onvu8mhKWMvL5tdgpJKfhlKWeDG
 FM8qKo6/3btI+UfqfW+aJ/ossAqqo=
X-Gm-Gg: ASbGncsQtykummZCVAxoHjY55gPsl+f9H3kF2P0FdQg4TV93Og1TvihnCBDgvBi/wxX
 HgeaEii9ihbmWS5pID0T7o8vxQ2eDtkeccIk+hMyqWeTLO1/ukd8JDEBgVEfesMY=
X-Received: by 2002:a17:90b:2d46:b0:2fc:3264:3667 with SMTP id
 98e67ed59e1d1-2fce76a2761mr1968664a91.1.1740100743800; 
 Thu, 20 Feb 2025 17:19:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPaohQptPKsiYDJ4jaDWNPRyLxCwzZg8PDBJbKpif0Fe2oz62YsGfAglSdLbQrnKmdEDY7mRIkvhd5vmmB5fw=
X-Received: by 2002:a17:90b:2d46:b0:2fc:3264:3667 with SMTP id
 98e67ed59e1d1-2fce76a2761mr1968625a91.1.1740100743352; Thu, 20 Feb 2025
 17:19:03 -0800 (PST)
MIME-Version: 1.0
References: <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
 <20250220102724-mutt-send-email-mst@kernel.org>
 <20250220175910.25688823@elisabeth>
 <20250220131932-mutt-send-email-mst@kernel.org>
 <20250220210004.1501dd86@elisabeth>
 <20250220154353-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220154353-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:18:52 +0800
X-Gm-Features: AWEUYZkTCZNm3Oaqwy21BExVmq52BF4WtMJuEU8IhwKFW1srp5Ac_JBOxFwfuZU
Message-ID: <CACGkMEu8W+cvXMtSgr-AitpGweciPv=HXTbxZ8ApvHjinbHseg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported VHOST_USER_PROTOCOL_F_RARP
 error
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 Thibaut Collet <thibaut.collet@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 21, 2025 at 4:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Feb 20, 2025 at 09:00:04PM +0100, Stefano Brivio wrote:
> > On Thu, 20 Feb 2025 13:21:33 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > > On Thu, Feb 20, 2025 at 05:59:10PM +0100, Stefano Brivio wrote:
> > > > On Thu, 20 Feb 2025 10:28:20 -0500
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > > > On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:
> > > > > > But I don't understand why we're leaving this as it is.
> > > > >
> > > > > So that people notice if there's some backend problem and
> > > > > announcements are not going out. should help debug migration
> > > > > issues. which we had, so we added this :)
> > > >
> > > > The message mentions that the back-end fails to do something it did=
n't
> > > > and can't even do, that's (one reason) why it's wrong (and confusin=
g)
> > > > and this patch is obviously correct.
> > > >
> > > > Perhaps the commit title isn't entirely accurate (it should say "wh=
en
> > > > unsupported", I guess) but it's somewhat expected to sacrifice deta=
il
> > > > in the name of brevity, there. A glimpse at the message is enough.
> > > >
> > > > Laurent now added a workaround in passt to pretend that we support
> > > > VHOST_USER_PROTOCOL_F_RARP by doing nothing in the callback, report
> > > > success, and silence the warning:
> > > >
> > > >   https://passt.top/passt/commit/?id=3Ddd6a6854c73a09c4091c1776ee7f=
349d1e1f966c
> > > >
> > > > but having to do this kind of stuff is a bit unexpected while
> > > > interacting with another opensource project.
> > > >
> > > > --
> > > > Stefano
> > >
> > >
> > > let me explain. historically backends did not support migration.
> > > then migration was added. as it was assumed RARP is required,
> > > we did not add a feature flag for "supports migration" and
> > > instead just assumed that VHOST_USER_PROTOCOL_F_RARP is that.
> > >
> > > If you silence the warning you silence it for old backends
> > > with no migration support.
> >
> > Thanks for the explanation. I'm struggling to grasp this. So if a
> > back-end doesn't support migration, because VHOST_USER_PROTOCOL_F_RARP
> > is not present in the features flag, migration is done anyway, but then
> > this is printed:
> >
> >   Vhost user backend fails to broadcast fake RARP
> >
> > with the meaning of:
> >
> >   We did migration even if the back-end doesn't support it, whoops
> >
> > ?
> >
> > Note that the message is printed *after* the migration and the flag is
> > *not* checked before.
> >
> > > If you want a new flag "migration with no RARP", be my
> > > guest and add it.
> >
> > That would actually make more sense than the existing situation I
> > think. VHOST_USER_PROTOCOL_F_NO_RARP?
> >
> > I didn't understand, yet, what the exact meaning would be, though.
> >
> > > Or if you want to add documentation explaining the meaning
> > > better and clarifying the message.
> >
> > I'm still in the phase where I'm trying to understand the role of the
> > message :) ...I have to say this is fairly different now from what was
> > mentioned on the thread so far.
>
> I'm going by memory. We made it a warning on the assumption that hey,
> maybe someone has a way to migrate without a RARP, let them work.

Migration still works, it might just increase the time spent on
recovering the networking topology by switching if the guest doesn't
send anything.

Or I've heard from the upper layer team that the control/management
plane may be in charge of the network recovery after migration so RARP
is not a must.

> Exactly what happened, we just did not think it through completely :)

Thanks

>
>
> --
> MST
>


