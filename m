Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A750C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Hgw-00052v-Rt; Mon, 28 Apr 2025 02:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u9Hgr-00051b-0L
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u9Hgo-0002OP-6d
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 02:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745820600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z4i+41zwqN4dV9AdZu/w/vurPApnrl88zS3GbUA73g=;
 b=U1Clu2eSthSc4F+TdDqofr6FxTS3KmnWg2KiKBcLaa42vd4EjY3ug3TV7DH/u/FZ3i0hcA
 QB35nQVfgV/o80YcajqjnCCzeTQmM7MJXzoiGRsMDlGus6X5vBS0VzVyyXNjTa9e3rw2a2
 yjxcItEOx2b5miYvYaKrWn4pLdIioGs=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-PkL0MYoWMxaqf6B2PKDynQ-1; Mon, 28 Apr 2025 02:09:57 -0400
X-MC-Unique: PkL0MYoWMxaqf6B2PKDynQ-1
X-Mimecast-MFC-AGG-ID: PkL0MYoWMxaqf6B2PKDynQ_1745820597
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-523c33cfea8so4752883e0c.1
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 23:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745820596; x=1746425396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+z4i+41zwqN4dV9AdZu/w/vurPApnrl88zS3GbUA73g=;
 b=hQczJdsbIdEVaHcUux3NPNCt2TRYRjwwIHO8isoTju5zFT98g4+XCZkJqvApgVdfm5
 HRKB5rO9lpWO4lQwh/LKZJ+ziB5ZUN1KyKXL7kI0/rBMYlEtOP4GOOqumkeqzVa9JfV1
 CN95XwtBci+nagwofaYcABDYrmaw59VRXGNWWSbL+juOqK0aQYHe2OCcbaytC8RkngY2
 3G1nP2PXwrBn9XZ23pB44e4LpaIJcLk1LV8tsxA+AHf0gttjHGvrsf/ybDz7dWOt4xki
 QnJjCkUvHAIw8CCsMLrbCt/B/wSXcYx4v9kLRGkEmfi9pTyHpECgFok2Uxvn20OGdhsI
 3cJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSsHudcmEBBqAjQs/Qfgpfzge3yfy2J/h2zB13uZ/2XbQrImh20hY8LSc+pEPI6ps1AUviXPjp3Xxg@nongnu.org
X-Gm-Message-State: AOJu0YxMxKdHkoje2MJK7lvWuBK3UAQTgvhQ+z+og4dus2rlIurYcliK
 BM+U+jXjE9Dc7oovIdBZIoVnrHb7yYbefwrhdTmH23Xd5iJ9gUWlukzfx+Lqql/UP7vC84Cpkfr
 lT5zUTTK4DQ3lntkmXwkBhFixUBFAW0fLTVhgtUiW59mXtW+EXpsIMzlinxgNbIwFzuW5h4VJRJ
 D7SqH2q+dE8oc2rJWRXff21rauWMXFh31Lcdp8+A==
X-Gm-Gg: ASbGnctjdzfFgf+3rp0vlfDeEW1eDbUjn7X/1RUJfn+1BIEKuNAQ5GQh4cknQOl+A3t
 qmPj9BSWpay2WfV/TjszU0lxs8sD4HRF7K5Xn7pZz85o86fHGsGMDH8uATZqhk2ip708ilg==
X-Received: by 2002:a05:6102:15a5:b0:4c1:90ee:f8c1 with SMTP id
 ada2fe7eead31-4d5433ef0c2mr6665164137.5.1745820596552; 
 Sun, 27 Apr 2025 23:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOYoEt4QEx8QIKtjVo4LYirnufWasrfZWzS48RbfPHHg+jNFITCvv6kieJGUDp5U+DtwTGJLz0wS578wMR3u8=
X-Received: by 2002:a05:6102:15a5:b0:4c1:90ee:f8c1 with SMTP id
 ada2fe7eead31-4d5433ef0c2mr6665161137.5.1745820596330; Sun, 27 Apr 2025
 23:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-4-lulu@redhat.com>
 <CACGkMEscXQxKSNN=3-0wuYJUxw7wGby1B-pD0yLLbSOHY9ez0w@mail.gmail.com>
In-Reply-To: <CACGkMEscXQxKSNN=3-0wuYJUxw7wGby1B-pD0yLLbSOHY9ez0w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 28 Apr 2025 14:09:20 +0800
X-Gm-Features: ATxdqUFmGLfq3p5Tuf-qvGl16v58zP88aYzlD_nuCBN9IDxZsnqEUtBPOQ-DhYQ
Message-ID: <CACLfguWLXgEcKyjOPC-2Uih5ARJA34_2gm3hebN+CC0OV4DbRA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
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

On Mon, Apr 21, 2025 at 11:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Apr 17, 2025 at 6:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > For VDPA devices, Allow configurations where the hardware MAC address
> > is non-zero while the MAC address in the QEMU command line is zero.
> > In this case, QEMU will use the hardware MAC address from the device.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 0b6a4e5634..808a2fe4d4 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3757,6 +3757,20 @@ static bool virtio_net_check_vdpa_mac(VirtIONet =
*n, uint8_t *hwmac,
> >          if ((memcmp(hwmac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0)) {
> >              return true;
> >          }
> > +        /*
> > +         * 2. The hardware MAC address is NOT 0 and the MAC address in
> > +         *  the QEMU command line is 0.
> > +         *  In this case,qemu will use the hardware MAC address overwr=
ite
> > +         *  the QEMU command line MAC address saved in VirtIONet->mac[=
0].
> > +         *  In the following process, QEMU will use this MAC address
> > +         *  to complete the initialization.
> > +         */
> > +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> > +            /* overwrite the mac address with hardware address */
> > +            memcpy(&n->mac[0], hwmac, sizeof(n->mac));
> > +            memcpy(&n->nic_conf.macaddr, hwmac, sizeof(n->mac));
>
> I'm not sure I get here, shouldn't we need to call get_config() here?
>
> Thanks
>
I made a small change to this function: get_config() is called in
virtio_net_device_realize() before check_mac(), so we don't need to
call it again.
Thanks
Cindy
> > +            return true;
> > +        }
> >      }
> >
> >      return false;
> > --
> > 2.45.0
> >
>


