Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB4AC36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9o3-0002aq-Do; Thu, 20 Mar 2025 02:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tv9nz-0002Xw-MA
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tv9nx-0000u6-TN
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742453700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tiyJp1V3Lra5raAZE6j4uQP7WLaNyoWFdxglCDOg8fI=;
 b=WJk5eb/EmqrNpVK3gBWR7L+38CPZVe9rMJSaM78JUByyscdl2FA7J9fYlZYMCm6+20TUI/
 AYWV0Fkh+CHlzptLZYUyN5ihr7soiXVAJeWSg48zWhDVE4bwbE8WOiyPmfo8aRuvwP9sEM
 cETInCr4wMJOpjmPTzD+pyhxHaC/hP0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-tkkU-5EcO_GUlrjKVlnNew-1; Thu, 20 Mar 2025 02:54:57 -0400
X-MC-Unique: tkkU-5EcO_GUlrjKVlnNew-1
X-Mimecast-MFC-AGG-ID: tkkU-5EcO_GUlrjKVlnNew_1742453696
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2233b764fc8so6153875ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742453696; x=1743058496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiyJp1V3Lra5raAZE6j4uQP7WLaNyoWFdxglCDOg8fI=;
 b=jSbfHHetWGgz9CWoohNa+pJlJvDB3Ty7cZQOh9O7nsNtjsoBDwZjooqXiQ3osg5cZ8
 3qNhyDreCt+W7iLGA7dgsl7IaWQmYeP9EYTtpgOX4OdlLiAdMzC5Nl5ue/IKE9X4QjUp
 NCKrCx6Hl+yW/XLhH0DCuGYmOEHRi5B3bZC9IzP2e+Tks9RKTWYIt5Ll8m5bdLFcvmO1
 6v5eZLmgq/7+dFwVb0pGMXJJHPVrJpnlh6jje6JB9keb1yijsvVykzsvND3icC1iNk0Z
 OMttT/P/919TbZALwXY06LPZ5vT9g/OwWdWgMALRLD9/npwAVoDgg9ZDTcJFJ3BwrUj6
 AwLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgs/OT0e0LGmDswWr+rDXIv2GoqcpLXsp5MME5TR+6gSSF0ppguy6DcjvDYd1xF2Vli391cNm2HS5K@nongnu.org
X-Gm-Message-State: AOJu0YzNuZQ4bhzaS+RzNrKnMQSkfebdTVDy3e+o0+cvjYTGY790hztQ
 xfYNqCEX6GbecAx1QV4d2K8UnahF4ASQXp0kI1YLf2ioqDwsw/RTqVhww0Cf4+QgxVXHW/VYq2a
 GbsW/1K6MAO3tA1l8z4bAryEvn64aQbBb8t7dLqATI7EMjTRLi1pmIaBzGOYhV/PiM5wrOFLnSk
 Bwhkfjb4tzSrDqXNjpsVBIAJt63AM=
X-Gm-Gg: ASbGncv5xHsa1/AjQqaim6zfq9CBCU/Ct7VIryPFs3ImfEyi4CVBj1EJ3ufY2nmmHFl
 gj5tNQVcT4XNSJky+o8ihVNX0vfpOVHFcPBc1e9DDjUTMkOQxRZWDypI/Wr8B/DIrcWPgAyE=
X-Received: by 2002:a17:902:ea07:b0:223:66bb:8995 with SMTP id
 d9443c01a7336-22649925b8bmr79086045ad.20.1742453696611; 
 Wed, 19 Mar 2025 23:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG78+XxR5wIqEK3n8j0jym7QSYVQ5+JIevf44SZkhwf8CvWeeSHBA9Zpsu3TLcVxNlYtR5oSoBZbYSYepWUp+4=
X-Received: by 2002:a17:902:ea07:b0:223:66bb:8995 with SMTP id
 d9443c01a7336-22649925b8bmr79085935ad.20.1742453696356; Wed, 19 Mar 2025
 23:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
In-Reply-To: <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 20 Mar 2025 07:54:19 +0100
X-Gm-Features: AQ5f1Jo6Ml7CfI78vYcvaMEvN5kHoSuMsovVv9E4w841iG6b-_w9dwTM7N1f9zU
Message-ID: <CAJaqyWd2DspK5ALoPLxAZ-rK-7=ok7ZNkYo=xOubDLuXiq-Vbg@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Jason Wang <jasowang@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org,
 dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On Thu, Mar 20, 2025 at 1:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Adding Cindy and Eugenio
>
> On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.=
ibm.com> wrote:
> >
> > I=E2=80=99m observing a problem while testing VDPA with Nvidia ConnectX=
-6 (mlx5)
> > on s390.
> >
> > Upon start, virtio_net_device_realize() tries to set a new MAC address
> > by VHOST_VDPA_SET_CONFIG which doesn=E2=80=99t do anything.
> >
> > Later, the VM gets started and learns about the old address from
> > virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
> > returns, unless it's "6 zero bytes", in which case it instead returns
> > the desired new address (and the problem is avoided).
> >
> > Then QEMU again tries to set the new address from vhost_net_start(), no=
w
> > by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
> > VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
> > successfully programmed into the NIC, but the VM doesn't know about it.
>
> Have you enabled shadow virtqueue? If yes, does it work if you don't do t=
hat?
>

Either you're using SVQ or not, is cmdline nic mac address the same as
the provided with the vdpa command?

> >
> > As the result, the VM now sends packets with a source address on which
> > the NIC doesn=E2=80=99t listen.
> >
> > Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> > =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must =
be the right
> > method, but it=E2=80=99s apparently called too late.
>
> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> necessarily there.
> VIRTIO_NET_CTRL_MAC_ADDR_SET requires the shadow virtqueue as well as
> the CTRL_MAC_ADDR support.
>

Nit, VIRTIO_NET_CTRL_MAC_ADDR_SET does not require SVQ. You are not
able to migrate if SVQ cannot be enabled, for example, because it does
not support a given feature.

> Neither of them seems robust.
>
> > Or maybe
> > virtio_net_get_config() needs to always return the desired new address
> > and not the old one from VHOST_VDPA_GET_CONFIG?
> >
> > I=E2=80=99m looking for an opinion/direction from someone who knows thi=
s code.
> >
> > As it is, the only VDPA scenario that's working for me is:
> > 1) Avoid specifying the MAC address in the "vdpa dev add" command (whic=
h
> > will create the "6 zero bytes" condition on the first launch).
> > 2) Keep using the same MAC address for every subsequent VM launch on th=
e
> > same NIC "virtual function" (so that the old and new addresses are the
> > same).
>
> This is the way we currently use it. Is there any limitation of this?
>
> Thanks
>
> >
>


