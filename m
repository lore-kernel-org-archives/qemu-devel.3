Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CF8C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 05:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0DPu-0001o2-3T; Thu, 03 Apr 2025 01:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DPa-0001mT-3t
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DPY-0008Eu-Eu
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743659200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wuBR7qKPLlt7/l8YpXVm/YhVQMaj2H1SyxMbRG8k/w=;
 b=GNpQZbLe9h/74KOBQrLBnd9zvXEyRDcnVl0yg67OWd9+34WPeIMaLh2wrT7cE3rwZDG0mn
 Wr1HKp1tiav5OBlm0BKlWTAmrgaHcu7r/6Vgj5yLJx90QApFFMaY9IXwFpHiusA/eL+UaS
 p1F5W1T0DGC0lscVHKAT+b87XlcM0Ns=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-mfWWb9KKMyavOHxTUDjO_Q-1; Thu, 03 Apr 2025 01:46:36 -0400
X-MC-Unique: mfWWb9KKMyavOHxTUDjO_Q-1
X-Mimecast-MFC-AGG-ID: mfWWb9KKMyavOHxTUDjO_Q_1743659195
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac31adc55e4so42328766b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 22:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743659195; x=1744263995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wuBR7qKPLlt7/l8YpXVm/YhVQMaj2H1SyxMbRG8k/w=;
 b=p58WiuT3pmsSGf5OvwwxhPyoZE3Mj1ZwGzfns7nxsKtBUoJulXHQ/OBxR3wRljyZ7k
 vq8VLDBRmZqGVMWN3uRSQcGBuu3CdUy7J4HDNrjs7eQOudrdI34GDFi5IepM9jFUkSuw
 KCLDkD/kW1AxRPCGNwADnmIBFGStDnM+0eRv88Muz9E+YfhXPNJCk26eRJ7UXt1y34m4
 ZgXYTPABbJFFLkG6Dd8pU2weVAbhKbmOJszNOKWsMqC+zx/66ga081H8JLtlxNeX94xP
 rEEzfusIekS86ArU338msT7LkTOelikXklZ3LY4/UXI5qaoe7q0tckBuyfdKjZaibi2/
 arag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnAHvOXe2f1qDovMB2Ct07UM8ldhaY4DHdd17M5ce65Q8Fs6EcsjyDbo1/9xlLG1oNYM5h6XYeJ9V9@nongnu.org
X-Gm-Message-State: AOJu0YzBOAbpAr4wC6iQCTCdOR4rAPo2HLi6UnYr8522nYkmZ9edEF0/
 uOpLeRjbhO3eF85b1X9MbOj7tM7qvmYtpqbeVwpDV0D7gFY5/DcgHgGwS5A7pBjzDC/2nZ1Txjz
 utVjH6xzXv1pCh2vO7zfSrNvq6HxXpnutug2TEQeGHwLH5sLrpMTs/MbC9k9Frpl8OlyeB+GcLp
 A6psYlin7SMB9yAos2KazeWXPiTVM=
X-Gm-Gg: ASbGncucppppxDsFx8ke3YQOl9rS4PF4cNocS49BbAw2X40esCT7wMng8/QRhuZMzJm
 jvpEGGgpXIfvwRrYae4ODTmvt79LyMUHry6l0pKKL01s/dBv4k8t+O6TYwraL0fmSVrQrCOkWiw
 ==
X-Received: by 2002:a17:907:d28:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac7c08a504dmr66858666b.6.1743659195436; 
 Wed, 02 Apr 2025 22:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYZNcd0Qro/bGSjaGI2A93dxmGn5eCuQVmFamudvdIx8NUgmxm/WFOdnQ6TqEI6NDIC2638Be/68aUchu0g8s=
X-Received: by 2002:a17:907:d28:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac7c08a504dmr66857066b.6.1743659195042; Wed, 02 Apr 2025
 22:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-4-lulu@redhat.com>
 <20250402123447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250402123447-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:45:57 +0800
X-Gm-Features: ATxdqUEd1wUKDDHOvtHVSPxxic_rSrLwBxUGXUXEqYgelZYv8bwh3QH23PUwskE
Message-ID: <CACLfguWA2RQC1WMeY4yMZc-NJgaha+8qpGSTaF-L+SphcC=4Dg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Thu, Apr 3, 2025 at 12:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 26, 2025 at 09:19:32PM +0800, Cindy Lu wrote:
> > For VDPA devices, Allow configurations where the hardware MAC address
> > is non-zero while the MAC address in the QEMU command line is zero.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index a3b431e000..1fd0403d5d 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3767,6 +3767,20 @@ static bool virtio_net_check_vdpa_mac(NetClientS=
tate *nc, VirtIONet *n,
> >          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0=
)) {
> >              return true;
> >          }
> > +        /*
> > +         * 2.The hardware MAC address is NOT 0,
>
> space after .
>
will fix this
> > +         *  and the MAC address in the QEMU command line is 0.
> > +         *  In this situation, Here we use the hardware MAC address ov=
erwrite
> > +         *  the QEMU command line address(is 0) in VirtIONet->mac[0].
>
> drop "here" and add punctiation. period before overwrite maybe?
> what is (is 0)?
>
Sure, will change this
Thanks
cindy
> > +         *  in the follwoing process, QEMU will use this mac in VirtIO=
Net and
> > +         *  finish the bring up
> > +         */
> > +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> > +            /* overwrite the mac address with hardware address*/
> > +            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> > +            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> > +            return true;
> > +        }
> >      }
> >
> >      error_setg(errp,
> > --
> > 2.45.0
>


