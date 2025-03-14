Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E5BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 11:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt3Li-0005iH-0g; Fri, 14 Mar 2025 07:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tt3Le-0005hx-U9
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tt3Lc-0006fY-In
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741952219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AurW4WT0royoOT44i+RfNGVUYotv9kLSIvw0zYX1oIg=;
 b=iEicCkwmeyc1C+HedzPPbOvq+FNydD1lzUT5opOHw3tgq/eNAxM0vlrA2i5+H+2O7cBvVl
 Wg/4W0faXwSjZps7NIQGMdYliyfg/F6b1KQm+Olnd6O9zSijzfflZoWg3eGJP8ufbvNkwT
 NdvMdT3oHgV1P9/q77C/Mwv2aoqfL1w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Csl1hLM0NoCockAUDjMf9A-1; Fri, 14 Mar 2025 07:36:58 -0400
X-MC-Unique: Csl1hLM0NoCockAUDjMf9A-1
X-Mimecast-MFC-AGG-ID: Csl1hLM0NoCockAUDjMf9A_1741952217
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso5534450a91.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 04:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741952217; x=1742557017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AurW4WT0royoOT44i+RfNGVUYotv9kLSIvw0zYX1oIg=;
 b=p372W7PKQTm69Qks97MGTuLc0FnJ7jlpmwn4rF/taM2SHfIVj5rs5+3iIDaEQIqwwh
 kWpTqsMCIdmqjBSMzVR+VOEtJrU6ei+MucA9kTzAlIDocHU2680ceARDx0fCkfGmpEFN
 ZSHu30G7/edowoQ4zEPsTm7gkcuSNMk1YdHntP6zsifSltI8aH81KRu/v/mgI+sSfFR+
 bMUcP84Nl+paKuUjNBXz64FKhSV8PlF/urLaLzUq/cqQJGqx0zEtYcyhxpwdQ98FtcFy
 4eDQiJjc2DgKJHRnnIw8LjjW08VeoXm4dsRdOJHkcxGXtJP08MHda+4BhsFAXg4RONLO
 pIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaYBzU7UoQGoZQ7lr+0M1y4XrVeV+06dk6/C0Tv8cZAyyxYQcA62n3VbxOGt2JezAZ+0+ag1tpPAwJ@nongnu.org
X-Gm-Message-State: AOJu0YxKj6qZeN7G2ENtzHH6FM+rO8w0yf12W4XvBevNMu1NVNt0UW3i
 jA9aVkLQEYYGXj8197LEc9/A9Z2pAvgcNIVjjkjH1Fe6SETwFiDDrBw7EBNUlODuWjjk5da4ngi
 P4QUglmpsbKYsZMga96iRsQ+tI4TyV9XgyuYh1wq9d3fvD5b/C2nKoE2MeMtfitsyHirgIV6YW5
 rJNDEdfUbmOA/z4stQ115vjxoaVNo=
X-Gm-Gg: ASbGncv9j45JrnFzjZAb5I2Emdt7Evenv1ofFvUTKAxSVmMscV3jy+Z+N3p/iKQtEX+
 lSxSJs8z4Mnyz7tiTLDeLlDNZ74KHoNMbJLuhPa2ogGoqFlQi3yBJpi0WL5dbdX25D6Th8/M=
X-Received: by 2002:a17:90b:568c:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-30151d65696mr2403175a91.34.1741952217260; 
 Fri, 14 Mar 2025 04:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExIPntVG4i3lBrYh6VNkBf4t3WKAwXjUX6CkmIWFS4phXGmEeZ9nP+hMs6QEwXT2ETBauEZXkbvbrrAIDKa08=
X-Received: by 2002:a17:90b:568c:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-30151d65696mr2403148a91.34.1741952216882; Fri, 14 Mar 2025
 04:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250221190733.490308-1-kshk@linux.ibm.com>
In-Reply-To: <20250221190733.490308-1-kshk@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 14 Mar 2025 12:36:20 +0100
X-Gm-Features: AQ5f1JqTKTq7YyP0jVDrnOEhVxFvt85nt8A_WCIMQRnn6bDmzNtWAaql4Pltw7c
Message-ID: <CAJaqyWdECrP0SzvtVDst2vOi65WEkAN5nwr8Yf5nKKbEhdObCg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 mjrosato@linux.ibm.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Feb 21, 2025 at 8:08=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> Add .set_vnet_le() function that always returns success, assuming that
> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA =
and
> outputs the message:
> "backend does not support LE vnet headers; falling back on userspace virt=
io"
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in V2: Add code comment.
>
>  net/vhost-vdpa.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 231b45246c..6e7cec4d45 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -270,6 +270,18 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>
>  }
>
> +/*
> + * FIXME: vhost_vdpa doesn't have an API to "set h/w endianness". But it=
's
> + * reasonable to assume that h/w is LE by default, because LE is what
> + * virtio 1.0 and later ask for. So, this function just says "yes, the h=
/w is
> + * LE". Otherwise, on a BE machine, higher-level code would mistakely th=
ink
> + * the h/w is BE and can't support VDPA for a virtio 1.0 client.
> + */
> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool enable)
> +{
> +    return 0;
> +}
> +
>  static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *=
oc,
>                                         Error **errp)
>  {
> @@ -437,6 +449,7 @@ static NetClientInfo net_vhost_vdpa_info =3D {
>          .cleanup =3D vhost_vdpa_cleanup,
>          .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
>          .has_ufo =3D vhost_vdpa_has_ufo,
> +        .set_vnet_le =3D vhost_vdpa_set_vnet_le,
>          .check_peer_type =3D vhost_vdpa_check_peer_type,
>          .set_steering_ebpf =3D vhost_vdpa_set_steering_ebpf,
>  };
> --
> 2.34.1
>


