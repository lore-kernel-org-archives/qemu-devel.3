Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B36E7718D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 16:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPlO3-00042y-Rr; Mon, 23 Dec 2024 11:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tPlO1-000420-M0
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tPlO0-0004uX-0t
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 11:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734971665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3kbamS6wCaCHUYWfWlFyiw8NWgUb9IKARVTOtgj+Ek=;
 b=FC4Cf+em6E7g3T7QiFZPTs/l8cXhpLY3r2intJej6SeLMKF7bxzWe+q7luYRbWe2vru8pF
 L1m14COcMB5wq7rC2WkuAWWitxGRPGE7EzREBmm3Y7xA5jSqyQrPeghAcWt5I5hWWQK+AV
 88SkZDPkyU1rHYgsd/ZQM6BtkI+rBCs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ooHBErhJMGqUOwx9mKR5cg-1; Mon, 23 Dec 2024 11:34:22 -0500
X-MC-Unique: ooHBErhJMGqUOwx9mKR5cg-1
X-Mimecast-MFC-AGG-ID: ooHBErhJMGqUOwx9mKR5cg
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e3c7d56aa74so5727036276.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 08:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734971662; x=1735576462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3kbamS6wCaCHUYWfWlFyiw8NWgUb9IKARVTOtgj+Ek=;
 b=RVKvNgM51LAdC5eULv1KUrAbBP+AMVexEefGl26L7kwbto5/28cVpykX4diDGI/Gom
 Cz1IZEqgFHCyHQABw/H0b6z5sXY5dVRkOT82cRSwbdsE66Y4du9ARW0YXXuIOMDYDlql
 FqWEV5DZgtl7Mw5LSM8/k8OyV09vUQ2dctcUYCXDQ53sY8YpUewqii4wK209DC0me8sa
 4qRBQMFIM/A/EW6UCVYtvusEeMN3AjqXbueuWxqeGigtPFKE6gKC71p/mJGieVFyLqNy
 NYfMTknbW3U+P1S8KG1PRqz+Lzv00UUr47/JDS8DnBLpC1Lbanj+KMbf5MHKx6u/e5Bn
 +l+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv7ZZ98LxepmhRpzd6DlAPFbUW7+0kQlcNIOgjss2yTAlQKtcoZSFgfqDdfHr9M5p400KdHnsLkdFK@nongnu.org
X-Gm-Message-State: AOJu0Yw6Avt/AbM5ltO5K0CtPsT5OA5I914Q66/fwIRktkLS38gU6oWC
 NK3cTmPseiOFFQzF7wWRQmZZWGE2dqbMfiu+HZks1XUQNu+PFO4+tuyqoueW1M6mfFASErTOY3M
 N3HDGJRJnlXJXfX2FZNPcaZUN7qWWoutw1fn5gTAZfF2DxK/etvHLPPbe5MCnBOrua8vnR6x6bJ
 G6CZex1ntbjR3mQD3Px2INQzn2NLA=
X-Gm-Gg: ASbGncs695QCt+bGFvLmAw/Fs3NVaesvo1g8vKcMBYLUQ1tKUQ3FCgFCvmBi7u4lxTB
 L0lsIuiGm99Sq5B9BPIXsH94DNVsTihbJPLJizA==
X-Received: by 2002:a05:6902:2607:b0:e38:8c71:1d7f with SMTP id
 3f1490d57ef6-e538c28e664mr9274891276.28.1734971662114; 
 Mon, 23 Dec 2024 08:34:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGngQA2879Y+HOQ3VKgFAEIZg2uBKVUClM5ql43qHF49b3Awu3CE+B3mDQQYgM8e8OQU3shi1I7jPBzRwpwk1o=
X-Received: by 2002:a05:6902:2607:b0:e38:8c71:1d7f with SMTP id
 3f1490d57ef6-e538c28e664mr9274873276.28.1734971661821; Mon, 23 Dec 2024
 08:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20240912165408.234447-1-eperezma@redhat.com>
 <7fa03d44-fc85-4732-b357-f5610460925f@tls.msk.ru>
In-Reply-To: <7fa03d44-fc85-4732-b357-f5610460925f@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Dec 2024 17:33:45 +0100
Message-ID: <CAJaqyWcgbFx=0LVLG-FFqGbYMrwa5qyWxhPhfqdYY0QAvsRe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Move net backend cleanup to NIC cleanup
To: Michael Tokarev <mjt@tls.msk.ru>, Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 dtatulea@nvidia.com, 
 mcoqueli@redhat.com, mst@redhat.com, si-wei.liu@oracle.com, 
 qemu-stable@nongnu.org, leiyang@redhat.com, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 20, 2024 at 10:02=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> 12.09.2024 19:54, Eugenio P=C3=A9rez wrote:
> > Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > structures if peer nic is present") effectively delayed the backend
> > cleanup, allowing the frontend or the guest to access it resources as
> > long as the frontend NIC is still visible to the guest.
> >
> > However it does not clean up the resources until the qemu process is
> > over.  This causes an effective leak if the device is deleted with
> > device_del, as there is no way to close the vdpa device.  This makes
> > impossible to re-add that device to this or other QEMU instances until
> > the first instance of QEMU is finished.
> >
> > Move the cleanup from qemu_cleanup to the NIC deletion.
> >
> > v2:
> > Remove NIC peer also at net_cleanup. vhost-user trust all the
> > backends are clean before qemu removes char devices.
> >
> > This is not a requisite introduced by this commit as
> > system/runstate.c:qemu_cleanup shows.
> >
> > Eugenio P=C3=A9rez (2):
> >    net: parameterize the removing client from nc list
> >    net: move backend cleanup to NIC cleanup
> >
> >   net/net.c        | 44 ++++++++++++++++++++++++++++++++++----------
> >   net/vhost-vdpa.c |  8 --------
> >   2 files changed, 34 insertions(+), 18 deletions(-)
> Hi!
>
> It looks like this series has been forgotten.  Is it still needed?
>
> In order for it to build, a single line in patch 2 needs to be
> changed (in net_cleanup()), from:
>
> +                for (int i =3D 0; i < queues; i++) {
> +                    NetClientState *nc =3D qemu_get_subqueue(nic, i);
> +                    qemu_cleanup_net_client(nc->peer, false);
> +                }
>
> to
>
> +                for (int i =3D 0; i < queues; i++) {
> +                    nc =3D qemu_get_subqueue(nic, i);
> +                    qemu_cleanup_net_client(nc->peer, false);
> +                }
>
> so there's no variable shadowing anymore.
>
> Should this series be resent (a v3), or can this be fixed at apply time?
>

I guess it is better to resend a v3, so we don't have a compiler
warning (or error). Jonah, maybe do you want to move this one forward?

Thanks!


