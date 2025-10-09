Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vqR-0007cD-Jh; Thu, 09 Oct 2025 14:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vqP-0007Wv-ML
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:29 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vqL-00069S-7e
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:29 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-92c4adc8bfeso125078839f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036301; x=1760641101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNSROoTkKSGyh8H9tL39Bk/Fhg3s48dpkntxdZa3rvs=;
 b=emBh/POFWPiM4FQC5twZQuLxwx4c4rTZ48sK/tPev8t6zEjFz8SIpNXl3V8xicVI07
 OaGdB8mh5StfbdAGdoZyzZL6AW5ZnAbYrJpIOGfZ55KsnX8PnAupiAC2lnfCl+Fk5Jws
 KAIirtMo+rZo/2Zbn3fDNnCVEYSbxcjszJobAncz7+pxLE8gDTpsoYpUsypqICCJrJ8J
 E+uwUhkZrpIN1bhf75B1kMLnSYfekY8rHt1vnkDJwoypMdoGBnTQjJ4+beSoMJVMWjTC
 /GNiOhtrcGmqHHrjTA+s0+s00qtcy87SciR3X5/AcTJBMzhBsUMfUKVktzejiOuJ1nwi
 YrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036301; x=1760641101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNSROoTkKSGyh8H9tL39Bk/Fhg3s48dpkntxdZa3rvs=;
 b=DQqr8EYRgJMdrhDro4bC1/kx2aXo8wBhQWClgc1PEDGNlfEg0zsfjIy3nMZn8IE3hV
 6JujTJpn7+LzAqMCbcUdvfsTBAezojgjC8FGWZaOcYtrZmjR+nJkHG6rTzfFrhxPbkgu
 uUpCg+VIY1hwofkkZ/L3q3i9H9ANvHNkUac3sMbq0AlURjWAngArR9C/PqWy/7HOQkTo
 D38w4XvsSHDPS2uYhUXykTwyxIEi0HP8+mMIireTrNDgSr3fJgenaj8RyZl7LgLtCfWs
 TieLYcLPPewBgPjtgZiddaRAd5uhgIILIvv9ExG8Uc70UibQx9lbeErhCPs2U/2fHiTH
 6NbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWimFnbQ3ax6IaykmCuEVR7tjpYexpqF75hXEYqkxwUbbcDgnHigmo/VgJmdyzpmgkZiQJc7/jKIldv@nongnu.org
X-Gm-Message-State: AOJu0YxsDK5EqVY9M8XBtydFYSsxCAcvg8zwB+K9WYReoeUqSA/2nP+n
 HuKdHOA4uXTpQGJrQYHqlhnfDxLB0hqninJy+gUSCJGPg1dOxZRALg09Ek2PDoww4K7bZTWVPa/
 4juL1fWe2BT87JKuczclo1j4lS6BpVnU=
X-Gm-Gg: ASbGnctKBrk6b0pqpCIHYj2uWQEBpUXQrFEyVYLmhwzll7yu4JxYVuF2Wbe7WxkbmOB
 qx6tRe53MkqZtT5TYL9XzdOuBITzyrY7rsYRvvE9F/nMgNPhN2rKUrdIY+KQ1r/G/MF6IHiwCvk
 9h9ANaUISJi46VleUlVA1dXnohnV8W/KiZPOcdC6CfScizbGcMCEl7Bl4acWvQq3kiMs/KDPrjn
 cNRIYDzqhUbeT9N3i55R4n2J2PHDyauaauHmtaTVA==
X-Google-Smtp-Source: AGHT+IHSFLOR4TYQF3LC8zXDINb1OYg+xW4oviYwypNBGCiosSUip+sSZHhWNXRgXNsJeV3hbgfo51pa0LmhL3oS6dU=
X-Received: by 2002:a05:6e02:2783:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-42f8736d251mr86137405ab.12.1760036301340; Thu, 09 Oct 2025
 11:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-6-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-6-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:58:10 -0400
X-Gm-Features: AS18NWBzs6LEidAsUUR-ZV0tIjOlnGUoOOI2pK8_MeofnWZTgSfnvOdMLhedNYs
Message-ID: <CAFubqFsbU+PTDX92=XCv2UZ2Y8hE33Nx9AJV_qsxypJH9xW9cQ@mail.gmail.com>
Subject: Re: [PATCH 05/33] vhost-user-gpu: drop code duplication
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 12:54=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Obviously, this duplicated fragment doesn't make any sense.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/display/vhost-user-gpu.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 9fc6bbcd2c..79ea64b12c 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -644,10 +644,6 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Err=
or **errp)
>          VIRTIO_GPU_F_RESOURCE_UUID)) {
>          g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID=
_ENABLED;
>      }
> -    if (virtio_has_feature(g->vhost->dev.features,
> -        VIRTIO_GPU_F_RESOURCE_UUID)) {
> -        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID=
_ENABLED;
> -    }
>
>      if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>          return;
> --
> 2.48.1
>
>

