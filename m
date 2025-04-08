Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DA0C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22ke-0003Q8-SO; Tue, 08 Apr 2025 02:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22kc-0003Pp-VO
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22kb-0005zN-8n
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744094880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1izxeKhyZfGbHd2EedF0A+1+11Nxknbf6b5iqsvTx4=;
 b=HaVrRFHFZbA7HNDGfLZG7Wc4FNZ+zgZjDB25Ut9JupnszL8unh7lnIM2t+ks8Qk+lTHadW
 eNGMrFRDHRNxpVJ3Rt7YKySr0wZRleZJeABtTqUhdMbylG+8kxC1wJOR+Kc3uvosEZyAIr
 cDtCv7eMTd9LnIXQ+9T2wO58ogYCfio=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-dPnzAUCONGOqSFkncK4hhA-1; Tue, 08 Apr 2025 02:47:57 -0400
X-MC-Unique: dPnzAUCONGOqSFkncK4hhA-1
X-Mimecast-MFC-AGG-ID: dPnzAUCONGOqSFkncK4hhA_1744094876
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-523fa15384aso7086894e0c.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 23:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744094875; x=1744699675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1izxeKhyZfGbHd2EedF0A+1+11Nxknbf6b5iqsvTx4=;
 b=CaRnrUS/vKeYs3woBBO/d8kq0RB3qujZqnk4wBz2gI3JQPmH3UuwanIKFWFPSEaXan
 GcPDN6k4RFcN3SO9oXEldRzJ7viKHVvm/0Ut4hEgQUQJsLQBk9iO5VyUSA+D5MPcH/r/
 iQWAnxWLp+r9s2fDelWObTSruQD77bXX9AqDkjNzbU3tAcjEudjxwHEs9SzJQraahdJk
 Fo8gqBMQJbSVOGye+DFZUmvrBbdwgVt+QzlslgwxyhFzXq6yHQVocxQK63nSj3t5V+EA
 0Rtys0EAU6jRLF9cWbNiAEioodsS88FfcZZrSkntlNZllKyTfzDbBtJS2lsevfYsnmSR
 b/Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRmKMQhqiXjTKmzs9lg2/AR5HIbb85Gh9JIaYZibESwUs/Y9C3Au5aBAnZCe/Q/Fei2OyjZtASg4NP@nongnu.org
X-Gm-Message-State: AOJu0YzFkN/yQ+VA8ix6tejQwGEUwnvZBWJNLarBzSulnfoTypcyNM4L
 /tus/bPlD3Hq4FUrtOp0UjLFD+DmWHe+XGDQS0/2ABMEle+IHxlGh6ezDOJEWi0u5YexmVQqRXR
 aEMUavMGQo29YKamjSiZFGIs5skcNbSkv7kLJHyOWC/9rj+lT74AN4TXCCcyv3xmT7hJgsNBCVz
 T2PyW59aOhmmVY82PwZyMrEBcs2imofeSiUQGErz8L
X-Gm-Gg: ASbGncsGjtdrX5nSscK09DW/nLapVeZVDKy3DDZ98fS77guOFCdITUWMmRsKQXN9tWM
 jBu0LWrMF++ZbKqojA+Vev+3e/o4AkANQcAFQzDuGlAy3NClT+dr9FjRyuLc68pAHbwREut0G
X-Received: by 2002:a05:6102:5683:b0:4bb:e14a:9451 with SMTP id
 ada2fe7eead31-4c86377b6b2mr8074370137.20.1744094874733; 
 Mon, 07 Apr 2025 23:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaJ0PqxduSnZROuTAuFRV6qlhn4u36XT5XHOQ8jjlXqNIBnrSAfDxEczQbagz6v6Fmr8KSRrtqMeAhPR/7x70=
X-Received: by 2002:a05:6102:5683:b0:4bb:e14a:9451 with SMTP id
 ada2fe7eead31-4c86377b6b2mr8074361137.20.1744094874413; Mon, 07 Apr 2025
 23:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-4-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 14:47:41 +0800
X-Gm-Features: ATxdqUGR1K8cWMiUreHcAjMKkctpTzaVb5DCsHTqVbqbygQVdMCf8EfIDe2oOXA
Message-ID: <CACGkMEsz0854tRH3_B8od0+Dak=EiRNf7B_uJOkLf5CZTvc3QQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

On Tue, Apr 8, 2025 at 2:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> For VDPA devices, Allow configurations where the hardware MAC address
> is non-zero while the MAC address in the QEMU command line is zero.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 94ee21d1fc..45b63eb9de 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3769,6 +3769,20 @@ static bool virtio_net_check_vdpa_mac(NetClientSta=
te *nc, VirtIONet *n,
>          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0))=
 {
>              return true;
>          }
> +        /*
> +         * 2. The hardware MAC address is NOT 0 and the MAC address in
> +         *  the QEMU command line is 0.
> +         *  In this situation, we use the hardware MAC address overwrite
> +         *  the QEMU command line address saved in VirtIONet->mac[0].
> +         *  In the following process, QEMU will use this MAC address
> +         *  in VirtIONet to complete the initialization.
> +         */

Let's describe how this can interact with the trick done in
virtio_net_get_config().

> +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0) {
> +            /* overwrite the mac address with hardware address */
> +            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> +            return true;
> +        }
>      }
>      error_setg(errp,
>                 "vDPA device's MAC address %02x:%02x:%02x:%02x:%02x:%02x =
"
> --
> 2.45.0
>

Thanks


