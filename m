Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C372C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 09:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um7k2-0004SS-C2; Wed, 13 Aug 2025 05:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1um7jy-0004MS-BG
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 05:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1um7jt-0000S1-35
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 05:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755077139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRV0xOrhfW4/pGvijbg+9s8wNbYI+wGLyPG/6ZZx4oc=;
 b=By3DZ3WzfnkhpG7Ad78QEKrW+9fkK2O+5oVUEdug4alo6dtpFhu6zoQOEi+wA2XhHonKW9
 b8/KlLmCIo6oqwP2l8W0IezSTMrU0JhqlJ4VI4MIO3gJLXVxfgCQuvP2SlkLpJK3cyLjtu
 DKx6ybXoboTdnQit5kAi0XtJANel0pI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-tfi7Qj2BMAGZbFWyEoUazg-1; Wed, 13 Aug 2025 05:25:37 -0400
X-MC-Unique: tfi7Qj2BMAGZbFWyEoUazg-1
X-Mimecast-MFC-AGG-ID: tfi7Qj2BMAGZbFWyEoUazg_1755077137
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2425364e0b2so74321655ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 02:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755077137; x=1755681937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRV0xOrhfW4/pGvijbg+9s8wNbYI+wGLyPG/6ZZx4oc=;
 b=C8U0ENb0LxNvWoDgTw2P3hJWpxOoO2uJMNhlBMXkS6Vsk+ibfcsoMyjxGmTMmXb0Je
 tC4R1pKFFRi+ZQ6hDZRdezV0xzG++/FCpNtRxshUNGfibGuBmhOm/nhWC6z4bIW3TT8w
 D2zc+869KGBb1Wto1DzzbubZ7H/4euc9C9/R8ZfIK/uTUQXtkzsI2HNPdLiI0AInBwZL
 Oovlny8BdsYQfdJqvbNgcLrIiIZ+6f8ppFaR//TJMEhA9URnNRmCk+BdWPaJNSWJiVGL
 K+d65W5P4wu+hv3L/5TEuLLw9lpehWmGN5SO8lNU3JBkcsxWMxq2dte1MKEtSR6ey8he
 6/Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoa2emom4lcnkbJIyKqTZ8RlytkYxamADDHyuricvfZcjNgMeyNKeBNlG5G1BpaCWD4viHG4JQ4Q0l@nongnu.org
X-Gm-Message-State: AOJu0Yy8l9gG41dgHDnc1d5XtvfnKmvFuz4hE22WgJ6Jy202sxFwjWoH
 KUnkT0LpNYQHEYnyti+E2gJfQtpjREpcTEEgkkd8KEL7qcV9m1JvdqVxKCGOfSN8fpX8ypgDjqh
 MxBdJVm4HFIhgrk/iykllTeRSEvf2oCwedy9fii6AEgPgX1nku8fsFhV1TJdvAz3GelSZm2Tfyz
 PmuwlRH1IhbLA9rKnNWIapaOxaiTDem10=
X-Gm-Gg: ASbGncsQpvgsvzhKcTgThpU+OYFN4e9LdQ81OpthhZ/KUQh/3z3z/ISpBkfaJ9vXA2w
 T24uOOkMXmHccFESG4Y89Bbb6PcNdzwg6v5NQNKt9VEqKT5rxpPeEoVUkmbDuUCubc1T3cHGXFR
 MnXQ4WbdkKzivX3AVwYQxg6pYvfeoTmsMSHRF/e/dUEo/R3cDPbEFeJ0Q=
X-Received: by 2002:a17:903:124e:b0:237:d734:5642 with SMTP id
 d9443c01a7336-2430d26ec95mr33124375ad.41.1755077136766; 
 Wed, 13 Aug 2025 02:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJHxy2+ELPRV2u1frzgzrSyzqIyrFVKk4w2ejulkmmasmh8wC+ctbInR3L9ay8X8gNKQZyH8PxNFc8IazZH5Q=
X-Received: by 2002:a17:903:124e:b0:237:d734:5642 with SMTP id
 d9443c01a7336-2430d26ec95mr33124045ad.41.1755077136381; Wed, 13 Aug 2025
 02:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com> <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com> <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com> <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com> <aJpm4-JfmevsI7Ei@x1.local>
In-Reply-To: <aJpm4-JfmevsI7Ei@x1.local>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 11:25:00 +0200
X-Gm-Features: Ac12FXwlLOQoxyIZqRy6CLxY5KmZ2k5PshqO27m8qA5tqsTgEHJJnj-S3Zsfv3Y
Message-ID: <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> > This effort was started to reduce the guest visible downtime by
> > virtio-net/vhost-net/vhost-vDPA during live migration, especially
> > vhost-vDPA.
> >
> > The downtime contributed by vhost-vDPA, for example, is not from having=
 to
> > migrate a lot of state but rather expensive backend control-plane laten=
cy
> > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, of=
fload
> > settings, MTU, etc.). Doing this requires kernel/HW NIC operations whic=
h
> > dominates its downtime.
> >
> > In other words, by migrating the state of virtio-net early (before the
> > stop-and-copy phase), we can also start staging backend configurations,
> > which is the main contributor of downtime when migrating a vhost-vDPA
> > device.
> >
> > I apologize if this series gives the impression that we're migrating a =
lot
> > of data here. It's more along the lines of moving control-plane latency=
 out
> > of the stop-and-copy phase.
>
> I see, thanks.
>
> Please add these into the cover letter of the next post.  IMHO it's
> extremely important information to explain the real goal of this work.  I
> bet it is not expected for most people when reading the current cover
> letter.
>
> Then it could have nothing to do with iterative phase, am I right?
>
> What are the data needed for the dest QEMU to start staging backend
> configurations to the HWs underneath?  Does dest QEMU already have them i=
n
> the cmdlines?
>
> Asking this because I want to know whether it can be done completely
> without src QEMU at all, e.g. when dest QEMU starts.
>
> If src QEMU's data is still needed, please also first consider providing
> such facility using an "early VMSD" if it is ever possible: feel free to
> refer to commit 3b95a71b22827d26178.
>

While it works for this series, it does not allow to resend the state
when the src device changes. For example, if the number of virtqueues
is modified.

> So the data to be transferred is still in VMSD form, aka, data are still
> described by VMSD macros, instead of hard-coded streamline protocols usin=
g
> e.g. qemufile APIs using save_setup()/load_setup().
>
> When things are described in VMSDs, it get the most benefit from the live
> migration framework, and it's much, much more flexible.  It's the most
> suggested way for device to cooperate with live migration, savevmhandlers
> are only the last resort because it's almost not in control of migration.=
.
>
> In short, please avoid using savevmhandlers as long as there can be any
> other way to achieve similar results.
>
> Thanks,
>
> --
> Peter Xu
>


