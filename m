Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCD8CF2592
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 01:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0AEV-0004zg-A7; Sun, 13 Oct 2024 21:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t0AES-0004zA-Hm
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t0AEQ-0003yk-MB
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728870642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8V0ijPYgzbhI8y1AoggLJ1T6ePgHhO/lvwDhudiTfg=;
 b=hLLxyiX8u1oxwnf0yhI4O4nEbSMJATk+Lzzo/qi1N0taTW1+ylM0ltfAQHsAj6kzk+f2rq
 UhCUQ6Tec+cAH4leVKSgxUUK9bX12w6Av0wrileOjW8+I8pXWu+yzl6sBi2HAKCRqonhhQ
 gqMYxnS9vzhOAtMmmjWhm/RD8YYpkwU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-s6iixNiLPdmMdbFP8e_cwA-1; Sun, 13 Oct 2024 21:50:39 -0400
X-MC-Unique: s6iixNiLPdmMdbFP8e_cwA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a93d0b27d37so336689966b.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 18:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728870638; x=1729475438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8V0ijPYgzbhI8y1AoggLJ1T6ePgHhO/lvwDhudiTfg=;
 b=KjOgzbQx3GAWX8zHWGD5dLusq2qdVigYkRyBlwOx1O2sIgPuPHt6/osGi32xGdSFbo
 6p+4tnPxctYkS/s9uY22byY75uF7CVsSgv5+pRtub9j/baDYFayiazYrHo3/a0o7jVxu
 oDipdsFa4JhbWF0lv41ZiIsdrvZxSCaHHfACtS93Nbo4LWTGYvHFvM6pSxg3tD8ZTJKB
 YjvHq0Hrohfi12impOdDg0yo5+ehXUQTaoCZMZ+cVB6QbwVxowczQSuGP3GYi1Wbdv2i
 z+Z8UvLUYgeccuC852utwEHf7AP9xHqtQ3gGA7igCwhjv8AEwnHETgl9R8SWN3rjDXYM
 weiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8KuG0uZCLblRVd8FZaDmnGTmfJ/jEvCjxXOGyisS93IqO61gDWY9/m1eqwvV3Fuq4a0SUIaXPpQ5@nongnu.org
X-Gm-Message-State: AOJu0Yw8FXnLaRzHFAsUr4ZW/7Yf3hpit2UgbXxV0/7VP49IEqj8hBvV
 TDKtfCqgMRit0SitTrlVZbvpElu21cHshyWhKNm6tLT1hG7YD1B6Uj5Hf7G0AmJyOu0d818dcmx
 2CWIdXhXeAuPQaxPcdGgDtJ1TGxPiR1/k0i93FUtwY89PBfwKtFzWF1z6K+0zDyuMH8g4y/we7m
 OZHuYn0ajwiIYwCaSmcFr87tMeNRE=
X-Received: by 2002:a17:907:3f8a:b0:a99:f605:7f1b with SMTP id
 a640c23a62f3a-a99f6058003mr470444866b.60.1728870637787; 
 Sun, 13 Oct 2024 18:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBJ6db6h0Tm/BpQfbZHidi/4+8h1MzNlL+uyyJBgHfRXd29FMBG4foc0T4a6pZ6G1eAMgaijZStl/KOnHg1uw=
X-Received: by 2002:a17:907:3f8a:b0:a99:f605:7f1b with SMTP id
 a640c23a62f3a-a99f6058003mr470443966b.60.1728870637456; Sun, 13 Oct 2024
 18:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240929160045.2133423-1-lulu@redhat.com>
 <20240929160045.2133423-3-lulu@redhat.com>
 <CACGkMEttbUdfPweKghNuo7TJuxbTg3Zuh_HZPCX7ZoTrY4OqSg@mail.gmail.com>
In-Reply-To: <CACGkMEttbUdfPweKghNuo7TJuxbTg3Zuh_HZPCX7ZoTrY4OqSg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 09:50:00 +0800
Message-ID: <CACLfguVOHiyTRe29wQNQq9eZG06pMtkuYsCCOGjSg2JRVJihyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add the 2rd acceptable situation for
 Mac setup.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, 9 Oct 2024 at 16:30, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Sep 30, 2024 at 12:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > When using a VDPA device, the following situations are
> > also acceptable: the hardware MAC address is not 0,
> > and the MAC address in the QEMU command line is 0.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 7aa7308244..5c610d8078 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3607,6 +3607,18 @@ static bool virtio_net_check_vdpa_mac(NetClientS=
tate *nc, VirtIONet *n,
> >          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0=
)) {
> >              return true;
> >          }
> > +        /*
> > +         * 2.The hardware MAC address is not 0,
> > +         *  and the MAC address in the QEMU command line is 0.
> > +         *  In this situation, the hardware MAC address will overwrite
> > +         *  the QEMU command line address.
>
> Please explain how such overwrite works. For example, "Function X and
> Y will let the hardware mac address overwrite the cli mac"
>
sure, will add these
thanks
cindy
> Thanks
>
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
> >
>


