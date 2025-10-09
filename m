Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A52CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vyu-0007x2-7E; Thu, 09 Oct 2025 15:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vyq-0007w6-TH
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:12 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vyn-0007Cp-IE
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:12 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-93ba2eb817aso122867539f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036827; x=1760641627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPccBe4J4ImkWHUK9hBvHGDR2n5jU3u9PYcasgGbuNg=;
 b=LkGBKgqlD/aBwc5PXbh60wzq82RcZ64cvLl7s2u9VGqRNgB9LjuUbwmQnbWkJT4Gej
 CwZOVMYuMilsrrZSxIKXEtC+55JbF6eprjxRbpYpsOh7vcME+BNFm5++BpqGzZ3DKQ52
 UQg7qtwY3nlmgCCob54ej7z3uiFzZTeOa9gw4hOwAQvPk9CM5KC5gHLJUwEGqc2Q+3l1
 iSKl+jz/ARHIvXTvIZP8BrBLLA7jZ1PIyIv3jGwgzwovsQziXpPEz6Rn27WmDiEgqDMV
 TpDWL4dMXzq0wKEq79FpRRrzHzabQsHLk7I0pmmIvgite0JKg/paYoIOuU/BlYML9nRH
 1oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036827; x=1760641627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPccBe4J4ImkWHUK9hBvHGDR2n5jU3u9PYcasgGbuNg=;
 b=ZDBIbbTKxe886rmt6TPN6mkphIJEKtboT5GIsefdtE0zbaZFSORhLYfzKlxBhvoGrK
 gzvdvrNO4J7bEt0Ild+7rL+S0v0v5SQMoVtz6LbLlINuAql16qiY6Ym1YSgn2it+zZvA
 kqjNlx1kP7dErt6EG4Xs168a23rQkcFfA7n2pBCOtHIlQaq8l4cx0cBohy4lV5tsVeod
 11QcxqTFZ7lwzPZy3pRtL7r9mhK2rnHFikQYj+jPIo8dQYE4qF3TzuSO4fwpt7XiU6Tz
 rJIjxGo1bl1srS4Zvu/qcCvvvg9/rJ1yEnei0CePC6a2zI4DLRF3uRfjvnrxUvO58kHM
 7EPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS5ESplDKeNHoPy7p6xtHVFL/ULvb7seG2DA8rWb5jP852iJv8ZgE0/pqtzljB979HcZkUqn3G6JVz@nongnu.org
X-Gm-Message-State: AOJu0Yya32/38pkdo3zODXIRzpg4zgsZuwxs0g4lsYRMW62OMUbUOvW4
 wu8OqsmE+A41i1LATs9z6QTch6TJ1VEKPadyZS+HjLRfyuUn8nKk/t8YyJWa0azoFlIWTlBzzcH
 jBLCo5KRmUntkm3xsOdGgZnaXwCWdv10=
X-Gm-Gg: ASbGncstzBwJnDDRv+W+GAN9Urj4X+V1YPgnsl7ZqRbzO4jfXr3YE0kZiM0nz7Fj8fi
 VYWjKeuKnOuhgFVPQHxsdS+hvJ+sORReM+qFuFpu0cRdBC3QqOKAw4j4Dls2/hd3qcsNUfDENUz
 gbAumfckjepgjNLT4j9ngP3fRIM5SA/x53rvmQb5O+K//7puOjQQzQQAxxkrUoRmN2HMEmjlRXv
 WBq/ju3U7giwoz+7lHVSxOlGS+liuF5qQ+7T9z9Iw==
X-Google-Smtp-Source: AGHT+IHG3FE1CsjiI17XQAd2uV5HblWOvUMxRzp8jH/WCUvREx9JCImHlamIq6WO8WUXtzEAaXxr+lAJM1BBRaMYItk=
X-Received: by 2002:a05:6602:1410:b0:884:1e28:904e with SMTP id
 ca18e2360f4ac-93bd19712b3mr906749439f.12.1760036827445; Thu, 09 Oct 2025
 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-20-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-20-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:06:56 -0400
X-Gm-Features: AS18NWB1ab3r-E9s2JSHdKKwkb5t52gmKpIJo3t8i9wYKh6uQZMqhinHMvxZQ_k
Message-ID: <CAFubqFvDAWborVr0BKff_CWM9gt5f3ZvNsPd6RroA=+yyL469g@mail.gmail.com>
Subject: Re: [PATCH 19/33] vhost: vhost_dev_init(): drop extra features
 variable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd34.google.com
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

Looks like this patch no longer applies cleanly but looks like the
same cleanup to drop the local array may be fine?

On Wed, Aug 13, 2025 at 12:51=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f9163ba895..e796ad347d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1596,7 +1596,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>                     VhostBackendType backend_type, uint32_t busyloop_time=
out,
>                     Error **errp)
>  {
> -    uint64_t features;
>      int i, r, n_initialized_vqs =3D 0;
>
>      hdev->vdev =3D NULL;
> @@ -1616,7 +1615,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          goto fail;
>      }
>
> -    r =3D hdev->vhost_ops->vhost_get_features(hdev, &features);
> +    r =3D hdev->vhost_ops->vhost_get_features(hdev, &hdev->_features);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "vhost_get_features failed");
>          goto fail;
> @@ -1631,8 +1630,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          }
>      }
>
> -    hdev->_features =3D features;
> -
>      hdev->memory_listener =3D (MemoryListener) {
>          .name =3D "vhost",
>          .begin =3D vhost_begin,
> --
> 2.48.1
>
>

