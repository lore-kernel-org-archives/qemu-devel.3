Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468A9C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9HYj-0002Jz-Va; Mon, 28 Apr 2025 02:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u9HYb-0002Bl-Lb
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u9HYZ-0001cu-Db
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745820086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DsXi5Kvh+l42bSkdTG9kUZjvqqHLUantxE5fbCkrE4=;
 b=dnowMzG6mnuvk3GCj9yjyuw6+hersIE5/BoKvFpJ/6/mFIuDZa0AhS5vfBGOOT+L1dFNrp
 zXX8hArw9B6aIcWcZ5c+LhJoJ34unsfXXWWqFkkPGMleYyW5MHZqRDABjTZqDCAANLdnNv
 ys6SeXlJTp3IRwlrUxqt0n5rZiE1zqU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-k84S5yIGPHGR75WEANsLog-1; Mon, 28 Apr 2025 02:01:24 -0400
X-MC-Unique: k84S5yIGPHGR75WEANsLog-1
X-Mimecast-MFC-AGG-ID: k84S5yIGPHGR75WEANsLog_1745820084
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-875b0acbb58so933456241.2
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 23:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745820084; x=1746424884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DsXi5Kvh+l42bSkdTG9kUZjvqqHLUantxE5fbCkrE4=;
 b=RH9/20aVr5fseEWr7i6yU+YokWoqH4L6WeC3xbIyn5IMos6DTUVbNcBceUxxF+z3ek
 9rDvfGA4IPP9I5lt66r1kgT7EkB2mLWjUhgNQR64c9Ji/8SyAumqhsLVkTltnpfkfstg
 7ypHy80cx/BmR1VXWB617CmmytoYjfUZFsf5d/tcB4xna97u3kSiTIp28eDHTYz8rWdB
 l7O1UvPC8N52C88ehPQXhXam5BxR4MQnjQa3Mh188AYdHtb8y97s7RgCApYh+vJ2myXq
 BWc0ze39MySVXvPFFW81RlHDDvVpjIEO8mDWH+7AZA9FLHHzgJ5Bmj0wTVnztBcB/ME6
 AgJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5xdB1WXZLntzEgYSnvMk0OStOL7r5XGtYWubUOPNaBPuNNFW5VnkqyoaW5gXLrExHVZ7ZxFsYpgTa@nongnu.org
X-Gm-Message-State: AOJu0Yyq9U78ZRzXBOm1LJ6lqaLBINrh04MedJzwMS+TeApPYGJ/SHxF
 Tk8kd4KdM0kX/oI7R16OgD4+Q2dswSWJ9ddMo5EuNFuEw1JDWG/Gi+FEg0jqTSLx9IV9yg4OGhg
 12uEoFuf2GGlAh/jZbynWmnMuoL32Fz9kpHg6bDbVxicxB3UaGyhfhNjB4IvxLY/CfusrE28R64
 H7E+lBrR4ingxulcFc3lyKg4aOPV3AhWINGiHeNQ==
X-Gm-Gg: ASbGnctkomd+sOQGQzqKXk1eBV8FiFi6ZqT+F/CDg3Q7RUbYklMxqV1hzkED3y2TRE4
 HvOgBqKoKlPv/cTFgyoPawpc6zivf2stgtjI4CiX4pBV65/fVcC+hssfYdcEl1An63YZhdA==
X-Received: by 2002:a05:6102:3a0b:b0:4cb:5d6e:e6c8 with SMTP id
 ada2fe7eead31-4d5439cbffbmr6421780137.9.1745820083286; 
 Sun, 27 Apr 2025 23:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEogQLJRec8DIsRozgxPs3dcC9XnyB5EjXTz73QxEyxH6rdVVOVSNiXxF5vFi6xhE6mpaw66s4V+7VcigBxKDM=
X-Received: by 2002:a05:6102:3a0b:b0:4cb:5d6e:e6c8 with SMTP id
 ada2fe7eead31-4d5439cbffbmr6421771137.9.1745820083012; Sun, 27 Apr 2025
 23:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-5-lulu@redhat.com>
 <CACGkMEsKmFZ_QaZZFohJvouQ9CWbPbOY56KJ27hBdfVFJiWORg@mail.gmail.com>
In-Reply-To: <CACGkMEsKmFZ_QaZZFohJvouQ9CWbPbOY56KJ27hBdfVFJiWORg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 28 Apr 2025 14:00:46 +0800
X-Gm-Features: ATxdqUHPm3Nur1Rxhe3j8Z4Mo7LWBG6FzRbIvE0EUNkWe7WSlYMKMlRN6TEp2sQ
Message-ID: <CACLfguU7rPGpR2NH2oCUN3KcsnLJfFe38+0keDgBXi+k1=NPLg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] virtio_net: Add third acceptable configuration for
 MAC setup.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 21, 2025 at 11:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Apr 17, 2025 at 6:26=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > For VDPA devices, Allow configurations where both the hardware MAC addr=
ess
> > and QEMU command line MAC address are zero.
> > In this case, QEMU will automatically generate a random MAC address and
> > assign it to the hardware, and the VM will use this random MAC address =
as
> > its MAC address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 808a2fe4d4..2d4ac20ee0 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3772,7 +3772,18 @@ static bool virtio_net_check_vdpa_mac(VirtIONet =
*n, uint8_t *hwmac,
> >              return true;
> >          }
> >      }
> > +    /*
> > +     * 3. The hardware MAC address is 0,
> > +     *  and the MAC address in the QEMU command line is also 0.
>
> Can this happen? I'd expect qemu should check for invalid mac addresses.
>
If the QEMU command line does not specify the MAC address, it passes a
value of 0 to this function. Therefore, we may not need to add a check
here, as this value will be replaced with a random MAC address in the
subsequent process.
thanks
Cindy

> > +     *  In this situation, QEMU generates a random MAC address and
> > +     *  uses CVQ/set_config to assign it to the device.
> > +     */
> > +    if ((memcmp(hwmac, &zero, sizeof(MACAddr)) =3D=3D 0) &&
> > +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> > +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >
> > +        return true;
> > +    }
> >      return false;
> >  }
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > --
> > 2.45.0
> >
>
> Thanks
>


