Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FB7CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 01:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHAtj-0007tV-Pn; Thu, 06 Nov 2025 20:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHAti-0007qf-0h
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 20:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHAtf-0003Bn-LW
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 20:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762477445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBQ0NKoEqRwvdzDImx33izYXqMaADhT76/dwIJ29BkI=;
 b=VWEj8wThXXyQTmJoG7uv0rqhtQRloXK/FAA+oUx8Rx6LWnUJNH9Un9PjzXUp8afChRnUgy
 MUMvEEpG4k5I2XIGLdv6d+a6fdQjn+qX1bz+mrx9kZ+Fuh3/CaONcR2ne5b6ieSl+j3P4x
 CoIg7sQFom7pQRUUHEU5DHgbEFCQlPU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-snvA1QwnPIi3EGoNEP3FBQ-1; Thu, 06 Nov 2025 20:04:03 -0500
X-MC-Unique: snvA1QwnPIi3EGoNEP3FBQ-1
X-Mimecast-MFC-AGG-ID: snvA1QwnPIi3EGoNEP3FBQ_1762477442
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2958a134514so2855285ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 17:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762477442; x=1763082242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBQ0NKoEqRwvdzDImx33izYXqMaADhT76/dwIJ29BkI=;
 b=kpPSFJqzVDiiFLgFsCRFZTFMWJ5kJlGrEvW3lRQbRHf/QFcpqnCX/D5tw75kf7TC5N
 oQi9KmF4uZSd/ODrYPetCDyEiGUzd56FeH3Ejs/vjJc6z/mBZder8HgpYn0Ai3nDpIXH
 QjRFFQntBzoxpe4+moeT592p1BAhx7bw0aRfgH1GOX7xR1yDZwr5D1HOUzUwFFrGguQA
 QsCjjnG3v52nqYkdHV1wzJkELrXxtbas0wfNpjUsSBOwIXOO5dZLh3QW+YhwljyGnWju
 1ts8lHHKmx2Y8/wCyBdQsovsx5e4y1X0P+kVKQrPAGLFpak46Rljr6WYUBXjJueUHSRS
 C9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762477442; x=1763082242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fBQ0NKoEqRwvdzDImx33izYXqMaADhT76/dwIJ29BkI=;
 b=QyvlIkQIvY9bIHa3SwjlA2xpcyrrZ6LzUOlIDrM+XH5Ozu3OrahqN84rpw/rlzAS+i
 Be/2EFMdsVXLZGInTzx2d8zWYVdVEDuAWhZLE+0yLTo9Ut9B2QTdw8UMzAvqVGMvkmF0
 c9agmUrQnjKKNRxZmAWpUt7yThp93PE1Il0R2Rie071BuuqfP1oFrClEV31b024h8TKK
 ECqlQ/G0PJWYZy/DMMWk1vvcyNVGNDYdjgjpXq3inCJxldHpAmGihGfvHffxQ5k/vPsv
 /qa68L30fLofB7FKhDDgVlNvu47cyqBe9bzt4hemZjrQHahq9zrrDZTAtTlhaTHkO2rr
 ljQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfPvnEDUND0AwKWHSgf12h66hmNlTeMQtKfOPxl6j/zgtETZAufl77CgEJZd1DJNrDqocZpufebxfe@nongnu.org
X-Gm-Message-State: AOJu0YxU1ZbocrNcPyxXHrM7TmRhHVNyq6aKVbBgabaLY3dMrTkNlE/G
 J6wHd2n5WWRcG3djlpBvoMzKh6cwJkZW9Va70T5DxVuj7yq8zFpE4mYrPpUfhGpt3B5QXAWYfWN
 VctgGKcVQdkU9wx4kQ/QK6yXsFuYtyvvDMhIhq8cXTzT4DFT/mk7pE/1x+hIpg9BvuPypetZO0i
 AL5COBpq2OF3OSO0hGFE4pkqhsw6OsozQ=
X-Gm-Gg: ASbGncvo6zFGkHNgygiM2lm9PMru/qDHWlw4O5x34JolG5NocNKzTlfqt+KYVSvCZmC
 Y9FeK7C2j4K0LXS6JZ9D3UfvZdGPs0I/5gANHthvAPwrIVGQoXZ8Hq8HeNgSuNyR4/UpOmSW5SA
 MTJ2EiFXgKpdHptUFMX1ikNPB4TxoKZlFpWjQmCMmg+t3l126/Y01SAff2
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id
 d9443c01a7336-297c040a72bmr17720035ad.25.1762477442285; 
 Thu, 06 Nov 2025 17:04:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQPnLNVEUET8tRcPU+UB0Vr+sisxfOHSrzHH9/2KwS3ZquRM+Ykz/y4HjTIuy8Iw570YOBxn7xjL9VM1N7xXU=
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id
 d9443c01a7336-297c040a72bmr17719635ad.25.1762477441832; Thu, 06 Nov 2025
 17:04:01 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
 <CACGkMEs4ES0a_Dzn7LmnthGuL=96XxOmncb5VDV195cxWTCChg@mail.gmail.com>
 <CAMGffEm+eh9jv_CUPb_WAmfJ+dQRRp_ecvSJm60uQSnvS63Acg@mail.gmail.com>
In-Reply-To: <CAMGffEm+eh9jv_CUPb_WAmfJ+dQRRp_ecvSJm60uQSnvS63Acg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 09:03:49 +0800
X-Gm-Features: AWmQ_bmTGTb1YR4vT7E1Ikrmv6nRKNEVOX_bx6gq13RsKpYP5jQtFiwgn8zRsLk
Message-ID: <CACGkMEucL27ukk1ayxuGewv=rk8_WrqhDSiESWX6USihTc-enw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 6, 2025 at 10:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> w=
rote:
>
> Hi Jason,
>
> On Thu, Nov 6, 2025 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > x
> >
> > On Thu, Nov 6, 2025 at 6:17=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > > > These are not present (or not supported) on QEMU 8.2.10, which =
causes
> > > > > > the migration state load to fail.
> > > > >
> > > > > Interesting, we've already done the compat work:
> > > > >
> > > > > GlobalProperty hw_compat_8_1[] =3D {
> > > > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" =
},
> > > > >     { "ramfb", "x-migrate", "off" },
> > > > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > > > >     { "igb", "x-pcie-flr-init", "off" },
> > > > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > > > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > > > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > > > };
> > > > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > > > Yeah, I noticed the same.
> > >
> > > AFAICT, this is a known issue..
> > >
> > > Thomas and I used to suggest we should not turn on USO* by default by
> > > probing kernel, but only allow user choosing it explicitly in a VM
> > > setup. IOW, dest qemu should stop booting at all when kernel is too o=
ld
> > > (when user chose the feature).
> > >
> > > See:
> > >
> > > https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
> > >
> > > Thanks,
> >
> > I see, so the reason is that the destination doesn't support USO in
> > the kernel. For those kinds of features that depend on the kernel, I
> > agree to disable them by default. But I'm not sure if it's too late or
> > maybe we can do strict peer feature check like this in
> > virtio_net_get_features():
> >
> >      if (!peer_has_uso(n)) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> > +        if (n->strict_peer_feature_check) {
> > +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO)=
 |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO=
4) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO=
6))
> > +                error_setg(errp, "virtio_net: peer doesn't support USO=
");
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4)=
;
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6)=
;
> > +        }
> >      }
> >
> is there any document to learn how the feature checking works,
> function like peer_has_uso, what is the peer exactly in this context,

It's the peer of virtio-net NIC which is the "backend". In your
context, it should be tap.

> is it the migration target or host kernel?

This aims to fail the qemu launch if the feature required is not
satisfied by the perr.

Let me post a formal RFC for this.

Thanks

> > So qemu would fail earlier than fail the migration.
> >
> > Thanks
>
> Thx!
> >
> >
> > >
> > > --
> > > Peter Xu
> > >
> >
>


