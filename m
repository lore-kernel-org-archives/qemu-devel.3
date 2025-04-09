Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02E0C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Ono-0006se-FJ; Wed, 09 Apr 2025 02:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2Ong-0006pM-Id
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u2OnV-0006vZ-Dx
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744179620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijuQJVFzgUljKx/Pchk2V3Wtl7grq3hNTET/w/vYyps=;
 b=WSyzjXWnd3K8dqL4ynv6dUGhfzd9rdtRu8d7u89UGzTBognRGRtCQSn3bMu5TOHq2wsnZw
 m+laTti9lL4K3KGyKF7XncucYtE+mnBRc002D1Tp8O+3+FAjYQ3cH7f/scYSX+9KObtnd3
 +uAgFe7c/eUaD5XwiGus+tUK/2ujF8M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-MbzTWjfEPV-7MGq_oRIXOg-1; Wed, 09 Apr 2025 02:20:17 -0400
X-MC-Unique: MbzTWjfEPV-7MGq_oRIXOg-1
X-Mimecast-MFC-AGG-ID: MbzTWjfEPV-7MGq_oRIXOg_1744179616
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac2db121f95so488943966b.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 23:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744179616; x=1744784416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijuQJVFzgUljKx/Pchk2V3Wtl7grq3hNTET/w/vYyps=;
 b=mgaWUlYAP1Q/Tx+FtD6gf4HmM6TOzkIgukgDiM+SbXblI13unJZkxweuWYUUh7Q2Je
 t2VKsgw0Q1gjtfdWn4vtEGJhZF5hq10yv3kE0sZhy3pol2M5sQvKkwNM9mYhOVkby8mQ
 4MkFc2H3NB/PSzxwzrBWKshVoitK42lzUSvopjEeUoN7R/Mmd2Xhj+2gksiiv/Vbr9A+
 kEV/8zZIR9/khdqHGkzb5kifjdtZ0pEtw7vkJqd9KauV3w/9fvzeOSfTMW59hcnxq18y
 OHyBe0qwaLImYM1FXu3RtlARNIBTwpVhBh57df8Qk1nXgunjp9GtmnJAY3sHAXZc8aRk
 wcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxvbXLDNba/TXcMo5RJoWsCF/7I++lhwoPBxh1OcuwCVrcuivVd1sXlFirYKQpKQheAXU7IRETuNsL@nongnu.org
X-Gm-Message-State: AOJu0Yw2UiLEJMhKT5z/qAnAHkAMhsRY66tXOTjIfb3CKFNDVd5GJ1Q5
 sfMkcc+rtkvS42jLzG+aKmf4TZCH8YvYl2AMCgDUPT23nG6KNIzQkuoF4XQLWJpauZRTbMXtwwP
 DxJmABzZZ1oZ2nZDX3H6EI3Xh2nV7YLv5sYCLMWoBFsIoBc9/WwyLE3fgOcZd5n66hd0P0BsUOT
 X69KG4b7mjO61wzHL1/ayq2dd2Rkc=
X-Gm-Gg: ASbGnct9taBTqzmJ3f8wM2z+qije6TBqWCn9+YO5lPfPcpKaXTUYqiqoIlB+4iho/Fv
 UeptyHRiCIKJojHpvn8XwdOC/90kQZQE77BdVavFqdqNqye7HoOjI0PXA0UTsHU1bGPsQiQ==
X-Received: by 2002:a17:907:1b05:b0:ac7:150b:57b2 with SMTP id
 a640c23a62f3a-aca9b70e179mr184486766b.41.1744179616378; 
 Tue, 08 Apr 2025 23:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkcPFGHfyZcpZMAgTRp9GRmSnVLvTFR24IKwhjJC/K6Rk4rE5z6U3WWf/nlokUtn3rd5hU2P46HYY6rmKdaVo=
X-Received: by 2002:a17:907:1b05:b0:ac7:150b:57b2 with SMTP id
 a640c23a62f3a-aca9b70e179mr184484766b.41.1744179616050; Tue, 08 Apr 2025
 23:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-4-lulu@redhat.com>
 <CACGkMEsz0854tRH3_B8od0+Dak=EiRNf7B_uJOkLf5CZTvc3QQ@mail.gmail.com>
In-Reply-To: <CACGkMEsz0854tRH3_B8od0+Dak=EiRNf7B_uJOkLf5CZTvc3QQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 14:19:39 +0800
X-Gm-Features: ATxdqUEFNKgntBD5nSA3fNzKtgz2siEdvG3MY483-1FFnzUkthaAxU4zXTBoKpM
Message-ID: <CACLfguXCSSjw9qeyx9SCyn6DNCTT+7RMi_jF-8=f7FQWZd84bQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 8, 2025 at 2:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > For VDPA devices, Allow configurations where the hardware MAC address
> > is non-zero while the MAC address in the QEMU command line is zero.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 94ee21d1fc..45b63eb9de 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3769,6 +3769,20 @@ static bool virtio_net_check_vdpa_mac(NetClientS=
tate *nc, VirtIONet *n,
> >          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0=
)) {
> >              return true;
> >          }
> > +        /*
> > +         * 2. The hardware MAC address is NOT 0 and the MAC address in
> > +         *  the QEMU command line is 0.
> > +         *  In this situation, we use the hardware MAC address overwri=
te
> > +         *  the QEMU command line address saved in VirtIONet->mac[0].
> > +         *  In the following process, QEMU will use this MAC address
> > +         *  in VirtIONet to complete the initialization.
> > +         */
>
> Let's describe how this can interact with the trick done in
> virtio_net_get_config().
>
Sure, will do
Thanks
cindy
> > +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> > +            /* overwrite the mac address with hardware address */
> > +            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> > +            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> > +            return true;
> > +        }
> >      }
> >      error_setg(errp,
> >                 "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02=
x "
> > --
> > 2.45.0
> >
>
> Thanks
>


