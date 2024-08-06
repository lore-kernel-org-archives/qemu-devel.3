Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26383C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 03:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbAZ8-0005wC-Rw; Mon, 05 Aug 2024 23:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAZ7-0005q0-76
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbAZ5-0003zF-Ph
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 23:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722913726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZahXGGIMKH1beH7+gNcwUeGS8eD5eAMvriFjCErcp6g=;
 b=YzZHJDtCJWxh+N4wjrIAs1bxlKIejKYpBeiTSCMDDIZo/LzR9HWoUBg08ygc/XpipYz6zu
 7r15Dt08OIDt9/8j6snnwSzVi4MJSjzXWiVW0/i0MQXiaj5lAA4sQWMpC5kpg+xbuWMBX2
 9uoAatovPGjTdLmV19mZbwjFFTz2BzU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-furNH_biPkqCwBYSYHqSHg-1; Mon, 05 Aug 2024 23:08:45 -0400
X-MC-Unique: furNH_biPkqCwBYSYHqSHg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7a1914d0936so215319a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 20:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722913724; x=1723518524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZahXGGIMKH1beH7+gNcwUeGS8eD5eAMvriFjCErcp6g=;
 b=RIZrrV+zHnaXv/I8i7plNVNBtEOXICC6INo8ldzFMTMpRdPuQ+lGRqdqaeml7pWAOo
 p3d6doU+yDpteODLrd6IcLqEnOxSiDZg3ly9DMAUsBUF979OcUJVRb3fJdBNdtbSa915
 8wkkBZPeU4U26t3CztdM6p6ElVCkTJ6iqT2KdE0GDSq/jk11kuOVuHkA1Exf8WtLuupK
 8ezlXfWe4YP8Xpr9Wk6321tQ30zTcGUoIe/lHGVKFd8aWKvrm2T6uTV6P/pG0FOWNuyk
 9y0hDX9DXV6yDiwLFC7bUgDLqepjjd6vnL4/ZycokQX40GX2OkXc2kQu+6doXrvEuJ/G
 Ul3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCBiHOJtV0TZzho0l3gILcKTPTZsAt9ujcvFA2lFaVf1Dt/Mi+n8CiOiiOXG2UhN4LTjpACny1tpo8@nongnu.org
X-Gm-Message-State: AOJu0YxvjI/IyqWuuLI78qFqJwJgsGwJIeXiAaf5N9nizcMER+KlbRAB
 VqdBU+8tNTMC7mf+TZVrshrtGKHP044/ZUQQLwIB65p/jpwhE6HV/WYhROgn3f35hkhjEui3ANW
 N3iZjm+ZbPVCBR+WxxBEEnE/aUGeRVP50grrfUPrUGrlhjww5T2l701aDSzzvblt5mlrF5PXHHR
 sPzo92VsIm29yTOzhc9VcMXiVJ3KY=
X-Received: by 2002:a05:6a20:3d87:b0:1c3:b20e:8bbf with SMTP id
 adf61e73a8af0-1c69957003amr16096495637.14.1722913724416; 
 Mon, 05 Aug 2024 20:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERIFIiLju+N3dHgqw48/IWd8Fq1OcbphFMspcJdgkF8dKLSRpiLFI3QlV6XNOZ5aZrl+ud5IpNFF1Z05J7vX4=
X-Received: by 2002:a05:6a20:3d87:b0:1c3:b20e:8bbf with SMTP id
 adf61e73a8af0-1c69957003amr16096478637.14.1722913723851; Mon, 05 Aug 2024
 20:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <20240806005814.51651-2-lulu@redhat.com>
In-Reply-To: <20240806005814.51651-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 11:08:32 +0800
Message-ID: <CACGkMEvXE_8HzAtuNWS13Y12B9=10WCsAj490xCe4Up01=06tg@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtio_net: Add the check for vdpa mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, 
 Jonathon Jongsma <jjongsma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, this is another acceptable situations
> The hardware MAC address is not 0, and the MAC address in the QEMU comman=
d line is 0.
> This is also acceptable
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7f51bd0dd3..c144ae2e78 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3592,11 +3592,22 @@ static bool virtio_net_check_vdpa_mac(NetClientSt=
ate *nc, VirtIONet *n, MACAddr
>       * 1.The hardware MAC address is the same as the QEMU command line M=
AC
>       *   address, and both of them are not 0.
>       */
> -
> +       /*
> +     * 2.The hardware MAC address is not 0,
> +     *  and the MAC address in the QEMU command line is 0.
> +     *  In this situation, the hardware MAC address will overwrite
> +     *  the QEMU command line address.

This seems to break libvirt assumption?

Adding Jonathon.

> +     */
>         if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
>                 if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=
=3D 0)) {
>                         return true;
>                 }
> +               if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)=
 {
> +                       /* overwrite the mac address with hardware addres=
s*/
> +                       memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +                       memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n=
->mac));
> +                       return true;
> +               }
>         }
>         error_setg(errp, "vDPA device's mac !=3D the mac address from qem=
u cmdline"
>                          "Please check the the vdpa device's setting.");
> --
> 2.45.0
>

Thanks


