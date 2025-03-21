Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647DBC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVig-0006Sz-JM; Fri, 21 Mar 2025 02:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1tvVie-0006SC-Kd
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1tvVic-0000kZ-FD
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742537936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qz2chVpcxbGPgEJPwxi8a+H5GTZAeWluocIaP9fnlJc=;
 b=QKuXOiGGMEB+wDst3JZfPiZXBeH0cF6zfFl1r0IQvBGnvJA/lWXzNgPybzygnJSd1albK3
 y1zTBZLgRsm4ohB0M8nIjC9gSeKxjuXA4507wiqqM1JMKoGjjl62h1VqU7c+XwfCiOivRv
 m9MD2EKTsxN6gM/cth4jufGjRUFlfYc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-PelTCGFAMgSigq60Xpdplw-1; Fri, 21 Mar 2025 02:18:52 -0400
X-MC-Unique: PelTCGFAMgSigq60Xpdplw-1
X-Mimecast-MFC-AGG-ID: PelTCGFAMgSigq60Xpdplw_1742537932
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so168391366b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 23:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742537931; x=1743142731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qz2chVpcxbGPgEJPwxi8a+H5GTZAeWluocIaP9fnlJc=;
 b=wDadyNmp6O3+vwxyQDJ9s/32u8uqDtUaDjOLvT74hlaNc8Gt/xEWEHY1mahMsCbIdw
 KDZZkLnU/O66TXFBhF4Ky8gHaOQVQE6KFiFbbG4Aaz66WWlOpj7nDbrAEYUMZyKzIQmC
 XdaZY2uBGNZdm3m7ohZYo4tSfD9wayNecBNOo/CTtCXb1VWDYsc2qvKlQTZdlChof894
 lDc6oP9OcZL180RJQyPTRIpPpd8H2kh+c5aOrbg17aYVkbQ5TXPkSuFCJOOORFEJtiiD
 0LpJk8ilWK9/77BZ9KBWnpw71GeJ0fpTasqtIbdkw/AsijEX/pqRD2XX1hnFnh8nZp5n
 wxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeuiGrOYM6AALrrc+4g+pTnYoamU+h/GR+vRkYh6TZ3ztE3pTakQmK7A9wPQROnw1PDUqWgdg9uJPG@nongnu.org
X-Gm-Message-State: AOJu0YwiXERf538oV2JoD/zyCF2L8R1GKl/vKl//dcrBOhXVrR/eP/XP
 F9YhAaWlNDnv97rqG8gzPChGNpb1m6g6jYaSULYOEPuq7cle1OGGsCSdY4Z+ikzSi7s+dSSBX4X
 GJoGpJVwWJQq9382VmA/Lg9i3vqNzNTC0Zmzhd50W6FaTdD3A9jJ4PMNsuezTf4gKTR2FePjUjc
 yLqHUB9WTwogmQ2oohzW70pUgDMBk=
X-Gm-Gg: ASbGncsmXLASUuexJ4vkV/x5vG+URL8mfYGhV5w4aqQWwmWyr4iZyN/wkUnO+ry0nHT
 s5Q5fDv3KPG8Q9LHbh02M7+85xKUsmUjL1dh74PUwhZeX2H5vScw3p+Smy9kAInEAZfcJ0MOH5Q
 ==
X-Received: by 2002:a17:906:c152:b0:ac3:c020:25e9 with SMTP id
 a640c23a62f3a-ac3f229c7c2mr237717866b.34.1742537931446; 
 Thu, 20 Mar 2025 23:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvuyY6oJsFV/zdyK5l0XhY+CVa/tEfUTIxpJEBBo5LseH52+xZoZAFiR3t5sea6jHHnvu3Kbk84emMki/p8I=
X-Received: by 2002:a17:906:c152:b0:ac3:c020:25e9 with SMTP id
 a640c23a62f3a-ac3f229c7c2mr237714366b.34.1742537930770; Thu, 20 Mar 2025
 23:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
 <CACGkMEsOx5bdpny3y9BfJsefNKbiXk2bG3+TPKtFyr7CWhz1FA@mail.gmail.com>
 <816c6468-9fb4-44d3-9bce-ecdc04f118be@linux.ibm.com>
In-Reply-To: <816c6468-9fb4-44d3-9bce-ecdc04f118be@linux.ibm.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 21 Mar 2025 14:18:12 +0800
X-Gm-Features: AQ5f1JqNMcMQH8nVYBp5UfjLMFtaqXdVxXU0B8Z8IufbMBWUHXb-NozrVz3ZlT8
Message-ID: <CACLfguUoDaOPy3nxVGaUhkCO8KnZHqqGjn3CqriuvL6NnqF00w@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 dtatulea@nvidia.com, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Fri, Mar 21, 2025 at 12:29=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 3/20/2025 20:22, Jason Wang wrote:
> > On Fri, Mar 21, 2025 at 12:45=E2=80=AFAM Konstantin Shkolnyy <kshk@linu=
x.ibm.com> wrote:
> >>
> >> On 3/19/2025 19:58, Jason Wang wrote:
> >>> On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@li=
nux.ibm.com> wrote:
> >>>> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> >>>> =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET mu=
st be the right
> >>>> method, but it=E2=80=99s apparently called too late.
> >>>
> >>> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> >>> necessarily there.
> >>
> >> The mlx5 driver doesn't do anything for VHOST_VDPA_SET_CONFIG. Intel's
> >> driver, however, apparently stores the configuration. So, it appears,
> >> Intel will avoid the problem... Perhaps mlx5 could do the same so that
> >> QEMU can set the address before it starts the VM (QEMU doesn't have to
> >> later let the VM change the config).
> >
> > The problem is that config space is not allowed to be written, that is
> > why mlx5 doesn't implement the write method.
> >
> >> Conceptually, setting the address
> >> by QEMU cmdline doesn't look different from setting it by "vdpa dev ad=
d".
> >
> > It's kind of different.
> >
> > E.g the device may not even have VIRTIO_NET_F_MAC feature etc.
>
> I'm not sure I understand... This is the MAC address returned by
> VHOST_VDPA_GET_CONFIG. If mlx5 allows it to be set by "vdpa dev add",
> shouldn't it also allow it to be set by VHOST_VDPA_SET_CONFIG called by
> virtio_net_device_realize(), before the VM exists.
>
> When VM starts running, it queries this MAC address and QEMU fetches it
> by VHOST_VDPA_GET_CONFIG. But, because VHOST_VDPA_SET_CONFIG hasn't
> stored it, it fetches a wrong stale address.
>
Hi Konstantin
This buggy process is functioning in the MLX driver as follow steps

0: kernel creates VDPA device [MLX: if the mac was not set  while
creating, the mac is 0 in hardware]

1. Get Mac from the cmd line.if the cmdline is 0, qemu will create a
random mac address, save it in VirtIONet->mac and
VirtIONet->nic_conf.macaddr

3. qemu called virtio_net_device_realize()
in this function, the mac address in VirtIONet->mac will set to kernel
while calling vhost_net_set_config() [ MLX not supported  ]

4. qemu boot called vhost_net_get_config, get the hardware mac address
and saved in VirtIONet->nic_conf.macaddr
this will read the mac from the kernel and change the mac address to
kernel's mac [ for MLX, if the hardware mac is 0, using the cmdline
mac(or random mac )  ]
NOTE the information in VirtIONet->mac was not change

5, the qemu will call vhost_vdpa_net_cvq_load(). Even if the cvq/svq
not enabled in qemu cmdline
this function will set the mac in VirtIONet->mac to the kernel.[mlx support=
]

This will result in QEMU's MAC address differing from the hardware's
MAC address.
So our fix is
1. Add a tool for users to set the MAC address before QEMU loads.
2. Include a parameter in QEMU to check the MAC address before
booting; QEMU will fail to load the system if the MAC addresses do not
match.

Thanks

Cindy


