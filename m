Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542A3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkGM-0007RN-W3; Thu, 15 May 2025 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkGH-0007Lk-JS
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkGF-0004Ze-Pe
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFN6EbzLznI5r0ul8FQYTlfcPrdUZ4e/Nv2w5yNt94c=;
 b=EkErxj/IHldKBKM4k67oCoUkvDgaGpGEC5pamFMDeXfaJdI3wqGI8YpP9abf7+fMLAQLez
 C0Dv9X3vp0fPq+DC1vpevEaFykg/jPSFeez8/rAcnFNAvqMpRfVKtLGARvkQxRQbJO3pHV
 rpxLNTu88XjnbRckEfETzmw0en24K6E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-NrTatSzSNuKo_4aLsrT9-A-1; Thu, 15 May 2025 21:53:16 -0400
X-MC-Unique: NrTatSzSNuKo_4aLsrT9-A-1
X-Mimecast-MFC-AGG-ID: NrTatSzSNuKo_4aLsrT9-A_1747360395
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30e48854445so1265148a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360395; x=1747965195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFN6EbzLznI5r0ul8FQYTlfcPrdUZ4e/Nv2w5yNt94c=;
 b=EcwcvdzlKiSmvv8FuxO3i4DnLPXxXIHE/JdyrIsB2EyFVLfU2rBuCJl8Fi8J2ieOiq
 q0BMCfG3TwPvvI2r2ObqKXQkdhSlkn/HAK0Xboc9Ro36M86kjLgP+Z+y9K3c5DFwqPHN
 H94i9d0+I22UTcX+QsowgsvGg8zEmTRRP6CxpgwD/ltHAD6fVHfBx1+EoeOxPNKnK3qD
 +9LdC6sqjo45Xlqv94cjClH+O8dY+x8QofWlx5OvT2xn/K/U0PsPMbm658yifo6PXtn3
 Bdlg64iS1RtkkT31hROQJeWt8d2YRHoecgvL/7cklo0P/CulUkVChApJDGTriWZjzrCL
 v4cA==
X-Gm-Message-State: AOJu0Yzk1H6QbDBVv8cxQV9hOv/QjS5zAXm6P4vxK91afFpdfrjKWd7C
 KhlulMwmMul198VljhUdc3UPAhYdgJhFlVTDbNCGxtczhwN7OXh+9vUDTpuyazgkKcwx8vLYHV/
 pzwwS3XI0t0ix/NcTRiP2UXOS0GifeFZch1W1Da8TFnELrP/X4d4ox+O6cjaREJK2MGpjxp+bNG
 K4tNAhKaRHgp+Qg923f40AuJPxv86Yzng=
X-Gm-Gg: ASbGncvWN79wwgWGzHKOQamzvLeS2h+1JpRur5VvjEr83Obb4HQjO0ZjPC+4aRMQiRy
 IHzSjOUnmwoctpsWVd28dBEeslsjmZL6eLyeH+6uGo16/3pi0swvger/LB5aXP39H5Pe55g==
X-Received: by 2002:a17:90a:e7c4:b0:30e:7b3b:b901 with SMTP id
 98e67ed59e1d1-30e8314dbe6mr1044781a91.18.1747360395119; 
 Thu, 15 May 2025 18:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbQ7l1HpnPnPDE/okf1RCXwkz1JZQryynlW3tsHFI9dXq6I+twvAxBXweq6LCYjYhzNsaJPBjCdnhh7CeAamc=
X-Received: by 2002:a17:90a:e7c4:b0:30e:7b3b:b901 with SMTP id
 98e67ed59e1d1-30e8314dbe6mr1044756a91.18.1747360394772; Thu, 15 May 2025
 18:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-3-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-3-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:53:03 +0800
X-Gm-Features: AX0GCFtFLuQYuRpqVz-Y5SpKcow5tRVFPDH8ckdLzRkr2SwIKyxvQyzZoaOq8dE
Message-ID: <CACGkMEvdKMF3CZRA3JmgqqQE=R2Dx0TRmZXFKx_gcNHzEpwFaQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] vdpa: reorder vhost_vdpa_set_backend_cap
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Thu, May 8, 2025 at 2:48=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> It will be used directly by vhost_vdpa_init.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


