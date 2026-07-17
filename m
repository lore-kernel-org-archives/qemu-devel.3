Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2FFC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgu7-00005T-II; Fri, 17 Jul 2026 07:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkgtz-0008Vp-Ea
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkgtx-0001Jb-V8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784288325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHiY3e3S8za5oFuIwlEmTeSJBMcUXpN1gGwI4E9RFt8=;
 b=MoXh2/2nmWFsdOVZRkcVvst72SXPdiB7H2g3AIifa3DfAqHSYKm1iitBSou0BwIpjQKlTw
 kSeHmTzgK55cTgtRm7GIheHh5kwjisUUrvQvxD6UBNdNNVPO/uM+e+QNcTODEATKOfJRmG
 1DJBee0udWiM48DHZ5k5DToCPvpGjwo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-3yEyAFA1NMKy3kTgMhjy8A-1; Fri, 17 Jul 2026 07:38:41 -0400
X-MC-Unique: 3yEyAFA1NMKy3kTgMhjy8A-1
X-Mimecast-MFC-AGG-ID: 3yEyAFA1NMKy3kTgMhjy8A_1784288321
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-80ee3cb097eso222219797b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784288321; cv=none;
 d=google.com; s=arc-20260327;
 b=gP+tXPXKLJPGXkhWXC4ukY5+4YlSxjGSd6HtsgcT7RfNx1EpW5nHltfJ74C25WqJ22
 M5k9GMG4xzFE0lcLCPc7C4d+AXqxGm5JRKQns5r/NEC3B+lKJHld6eFBLFQP0O5h+RS1
 PREXrEOStU7GQpMy46JQHrV6BvMPgSwutHtStXeDZbbUaLR+j8vSLRSabyVAaUyJvD57
 +Lc6XJm7EaiVF+b+KJBIHmdHV2ky5k2heHbpG6EBcx2InOuC9xzZHTcIsW4VE+FMeYJX
 EeyYssIT8djsYOYb9JqpqCYSo2foSpzd0jmMSb9nCFWXkNGln5FDlWtrjebel7+0Qu7u
 Pbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cHiY3e3S8za5oFuIwlEmTeSJBMcUXpN1gGwI4E9RFt8=;
 fh=scobbx4Z3/DtfOtk4QFSadtpeR2080Ksudnd1sTI/uM=;
 b=EjoZm56ya+B/qpv52kBJeXIAchrcDopCHscLcQ6N7jqRhBbQf33Z3Cbe6S5BuEs2+e
 TwtbHoy27kWaw1qAeKyW0qTxdF8r60xH2CRBPksp9qkSv2bZc3jTu9yDL771wYjzhA9U
 f63uKJMkxkIvB//zhMpagDuPC6Xpa2ItZ5BGWUK7ELSj6dYKDUglfsLiE3XSCfPNHUTA
 u/dNcGbBGgifjaftnVNzEo2fjF47ahTaLG8zv9sYt+1XNj0CGuhCdjs0E3HSEKNYGfPG
 Yq6CQy0oWpX2tvA7ERm8ryrvANxsbWH6z5CbhpI7obYyGgnh3jrvwnUqtsr0KnEnwTex
 XZXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784288321; x=1784893121; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cHiY3e3S8za5oFuIwlEmTeSJBMcUXpN1gGwI4E9RFt8=;
 b=mkAHFzfj86D7EFYsyphYOwkyp2rgd70HG0Wfc7pxQihJNhfUClBdC3lnvQFsWIGkFn
 yVIaTHnxR7bsC2KlOr9rZ1dsekLHBSxnWveoSYaqmHVB20LTx2lYwVat4aC6O2LzYmdt
 X8pW1QKQCHnAMEGsSC2yU3LVxM8MUo8Pv8etQ2igGsmmUYtrl3BHCBfc0/VuyZXl5yRI
 7jWFD37nb2jEOB0DloMPkDXPTUAA5zNjL/X/9dJaWNnfO9aaXVq7mhLvO/pCkYayo70r
 coHddLpdB5uvV7/138Hh/ckzHJL8Demux8e8ZyMbnboitOJqobM3WgupOcJjWkDN8peM
 D8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784288321; x=1784893121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cHiY3e3S8za5oFuIwlEmTeSJBMcUXpN1gGwI4E9RFt8=;
 b=tR4w6/EH+tM3sWvAjc7Iqi8Iuy5233IyeyY6v2+dXLXn8sYLdlvR0YKcyXktKohon2
 YXuDiQrias4HtGKb+4BhBxNLyYVVtAB73wWzHucEoG5kWzQZerEEcPxS40+d/1JwyqH3
 LGoE3AS8UO0gHUdoc+HKDw00fbEFLV7ac/zPHi/ct9QIyaH6dcFQTY7Gf5kHyosqinxU
 0aRtFtJLmbvOjUauxif9BZoUw39te3y3mla7s7JIsZ27mkUSLGSTJGpl9jt/u0eCyA7M
 iGCUxELA2bseCdXfv8og4+sXETnJ2c7l9EhnzFhJC+Liw76pSneVhLx/ZzWU/g84XL0L
 r23A==
X-Gm-Message-State: AOJu0YxEuScfQDYaVZE9hb8192apvvnjmOo2ohsmYb/RjPqCIAEQ3gvG
 rfRhBwNiR0qJXdVsP/AuGegvAzzV01KJqO7KKflCCl7WcE0tDSIxZ1fkfgRrRuwOVc9WdGRQCfG
 oKisgG/sV7bvrRVLxd5XvCt/V0COuNlO4l/2s8z2BEb2LDFiFo6Pnx+bMaWt3PmZg4bB5PWDiVM
 /T4vPjwnTEXNwuTYhDbbwC+gnuzDjzRkc=
X-Gm-Gg: AfdE7cmfStkS7dkgdWThz41A1DaU5OB/UuNR98UhKhmD58PL04pMvElgXG+G3hBBZ68
 27m7yssU/b/BGie28v+e1HNSCaTVjBUwtLVDkSRiQ6EZSUeaQCsYhTy/FIF6kACyr3HjYYEIwgh
 jp5r4sqIbvmbO8Ri65A6nDET/IWIVI9KY+TzPYb+czaa6N3z/sG3KQxlUY
X-Received: by 2002:a05:690c:d95:b0:81c:ef47:2dd0 with SMTP id
 00721157ae682-81ef283fce3mr6260417b3.49.1784288321075; 
 Fri, 17 Jul 2026 04:38:41 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:81c:ef47:2dd0 with SMTP id
 00721157ae682-81ef283fce3mr6260297b3.49.1784288320680; Fri, 17 Jul 2026
 04:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-3-dbassey@redhat.com>
In-Reply-To: <20260717103301.228974-3-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 13:38:29 +0200
X-Gm-Features: AUfX_mw9EKEzkNZ6sGGmAGbBaVDjC8iMvjiGHuolMmgMESfqYHQxzhuCZ5lrDQo
Message-ID: <CADSE00KihJqK1kvKiLe1EEDszbrV44yiQ-WMnkykhfnOsYGkXg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vhost-user-gpu: Add shared memory region support
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 17, 2026 at 12:33=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com=
> wrote:
>
> From: Matej Hrica <mhrica@redhat.com>
>
> Add a 'hostmem' property to the vhost-user-gpu which enables the shared
> memory in the parent object.
>
> Register a container MR in the shmem_list for SHMEM_MAP/UNMAP
> operations. A container MR is used so that SHMEM_MAP FD-backed
> subregions each get their own KVM memory slot with the correct
> backing fd.
>
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Matej Hrica <mhrica@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks!

> ---
>  hw/display/vhost-user-gpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 57360898ca0..dbba80c7783 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -649,6 +649,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Err=
or **errp)
>      }
>
>      g->vhost_gpu_fd =3D -1;
> +
> +    /*
> +     * If shared memory is enabled, register the hostmem region for
> +     * SHMEM_MAP/UNMAP operations.
> +     */
> +    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +        VirtioSharedMemory *shmem =3D virtio_new_shmem_region(
> +            vdev, VIRTIO_GPU_SHM_ID_HOST_VISIBLE, g->parent_obj.conf.hos=
tmem);
> +        memory_region_add_subregion(&g->parent_obj.hostmem, 0, &shmem->m=
r);
> +    }
>  }
>
>  static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
> @@ -659,6 +669,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(Vir=
tIODevice *vdev)
>
>  static const Property vhost_user_gpu_properties[] =3D {
>      VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
> +    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0=
),
>  };
>
>  static void
> --
> 2.52.0
>


