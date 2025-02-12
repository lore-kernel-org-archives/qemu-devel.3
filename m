Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA05C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCxK-0003WO-9H; Wed, 12 Feb 2025 08:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiCxI-0003W2-5u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tiCxG-0000TX-00
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739367543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdLaNioDh0pUHvx+UbYLOs4unrOn/mwwooq+9gy9+Wk=;
 b=XPn1mzY68hogRDRXn9n8nx+oSK8e0gRlf9V9I/84PahwjsWIRDwsI9e+6MYugEBC18/FQP
 mstVCuP7nQweXVtTLL/oCMCgOIrbYmuJOk5QBn20u7sdpS4u8ZaWiP+43LHvnWYL9J2t7W
 vATu+55nMJxmbtICPJovVDLwUjDtC2Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-hMSV38Q0PhqVxP_2OGMzyA-1; Wed, 12 Feb 2025 08:39:01 -0500
X-MC-Unique: hMSV38Q0PhqVxP_2OGMzyA-1
X-Mimecast-MFC-AGG-ID: hMSV38Q0PhqVxP_2OGMzyA_1739367541
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fa166cf693so19812416a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739367541; x=1739972341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdLaNioDh0pUHvx+UbYLOs4unrOn/mwwooq+9gy9+Wk=;
 b=pXBTlclA7FkHpuTeC0kgzjPxhbnprMlRulExKO9SJt/KR31Nn09hJsbMpwIUPDdLzD
 HQU2oEXroEsAhTXuelWJ0IUPMB2J1hNTzG6DzvZCpxm77h00emXxIHDeHStvmWV24s3o
 W56W+EVlEMapHM8TObD1R7khk/5JrtB49XlNd5x7IEiyaJWvon4ruBmOrnSz2AhpS0lA
 UA4XQSQ2Z0XGDjgvyvBe9dZh0llEq5Ze4m8U0smpIuB5vvTJr/v0RDQE9lHXrUGBvveL
 gwXbqSAdqV7Mf6d3cj6C+nDrBj9DAB3PcZK5lE4o5Heh6HHO4u+AX4RhDf/x9TbuKPyL
 2krA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh5tYX9bpEa0eRJKc7fTILoPmxBP84/N3Eqb/LUL8DMXR/g0cZfFakCaWdII2QyUwoEnvHhvs4UdgU@nongnu.org
X-Gm-Message-State: AOJu0YzpkDMDLBKwZeyTIvQoN5/aKEuClNQbTmx15FI4I95NKThXvM2B
 AcAjBK/TSOw7y3dOhhzSr9+0ChTvWj1GW5W9nXg4NocxIQ2Vlaa/57e6NT+IcTENdbrZ97ELHIi
 IzrZEsc0NcsydxlvmKD3bdEM7GUGNPvfFbqfjW24gVKHAGBY7eK1yr1Tj/X0jQJ0qBJKvfiJ+pB
 q+Fm7aYpnqawpI3xY6GjSm/WF8RwY=
X-Gm-Gg: ASbGncuRWlb6G7vPWX3C3MGMdEkL8AbArkeA/iAhNk++mnwFjWnvF7QyZER0fsKDeOB
 J9xq1ln9DTCaMcoTG0vWu3jNHxhVSM7qoEkgdbxlqPorPyQSsy8Yw6GnT9VXz
X-Received: by 2002:a17:90b:518d:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2fbf5c69ff1mr4976501a91.30.1739367540839; 
 Wed, 12 Feb 2025 05:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnwnF47S4/Ii6/WxEYuDMBMhIUE+uUoCwfVfSoi96BYl9KLpPStZ17s1YEDTiLKnylBZ07OuKDRupqRGM0m6E=
X-Received: by 2002:a17:90b:518d:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2fbf5c69ff1mr4976461a91.30.1739367540463; Wed, 12 Feb 2025
 05:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
In-Reply-To: <20250211161923.1477960-1-kshk@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 12 Feb 2025 14:38:23 +0100
X-Gm-Features: AWEUYZkG1h5hsRXDgtb-3uIUU5YBoCeAcUb4p-aDl0RpAWG-RL8jE9wGr4Ofyww
Message-ID: <CAJaqyWfxaCXUqQG9rXGLjxNbs2zLoRBkW3bJA3huAzqOCDvcBQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On Tue, Feb 11, 2025 at 5:20=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> Add .set_vnet_le() function that always returns success, assuming that
> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA =
and
> outputs the message:
> "backend does not support LE vnet headers; falling back on userspace virt=
io"
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

I guess this patch should be merged after
https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg02290.html
? Actually, it is better to make it a series of patches, isn't it?

> ---
>  net/vhost-vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 231b45246c..7219aa2eee 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>
>  }
>
> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
> +{
> +    return 0;
> +}
> +
>  static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *=
oc,
>                                         Error **errp)
>  {
> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info =3D {
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


