Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF6CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzPI-0004NE-SB; Mon, 20 Oct 2025 19:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzPG-0004Mx-TX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:35:14 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzPF-000102-7O
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:35:14 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-430c97cbe0eso29682315ab.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761003312; x=1761608112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qp8th4bMseoZh9Xev43d+1FAiXTXTUM4YGnyjc2lfM4=;
 b=UT1pILrm7jlRJu5lxGVyCIm4+T/Cblx0N8A67N3Fsrfy/5pQH7qnyioDyacIOO/UC1
 J0LJR4gr8qH6Ps4zg93rIKxBjy+uT1LAfEG13MN0CWNBURILJuUsTu3lGhthsyf1pDUr
 FeK8AqvCjI1HDh+ID/1p1m8wwlTdQy1jdiJHuA5fwEUyHutUnJhz3KtY0JB2EQEgwiN+
 bFe0OqF5lLFGaBBTFMbRtjuNust8AJirsdU4qOEzWiVWqqrbkrIcy8RG0UOirH6C+UHX
 Lz5pBrGMHigCJfcAIfjrzyR+YyF7EjoSb0X/g+XDYDDnSfsjfEzRuEd+ygYkdqCyVFZA
 647A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003312; x=1761608112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qp8th4bMseoZh9Xev43d+1FAiXTXTUM4YGnyjc2lfM4=;
 b=MQN/cpfPEFkbeYw2cLY4WhRZzi9AO5cFRVufmK0uwmEe2H6SqxSmpNUjRc+Ht2IY8M
 0QSIVkk7z+wi3xWxg3UYvTcGfDC5G7T6PEHCEn/mU3BSnqWSh1me3R8KUpU4YRyZ71FV
 V5GW2+4M5JqPF0/KrwLnTgfIPpGcw20h48FNTrgVhUFBbJGoB/LmjffVvpZ6sYMc1oLL
 UziGrL68iDFC2ivyE14s3ojeGE+7KGooqU++6Abw/ZlC6G7MTB/dx6aySKiZ61geB1Qw
 rdiXmDeeqPB3X/zL7z2AudCEoPNKFQDS2MkK+FiMgB1aR90rHEeuErEhzHqd6LaqYQAm
 ovVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1k+eC76mUCETLO39UcdxSVVmSbQ8T1xKvI+id2wA2mayk/N9M1aVDDYzRJV0E8w00j06N5V0CqVGn@nongnu.org
X-Gm-Message-State: AOJu0YzalN2iQZ5+2taA/dHNVSouOZZRccgzRpeAFxlJPvlllmHuUeM0
 t5pxL9pxXH8qTG0gmLNdVD9sI/mBoWw3NFE2BPe5CS8HMKXjqgBzcg1XK3ZyXcgsnrgv8298dT3
 J21B8Zu7LvojQAJdJ35danwYzGEK4yak=
X-Gm-Gg: ASbGncvgdTx0okRuawZlhhfGz0ENJN0VTcS88QFMfIiOhwrSySpzGZOR6py/q4j6skM
 xsD11rMV3VfsSFi3KIM+EW9SSRB6yK6XPBjv5kBanAP47JXPChGB9iIHppJ2AUIAAsBYWimC6R4
 1LAxC6QHWZOgpM1HwJq/yPd43Vb8Yubj+inwV86yzEkCs91Jykg/jq/iFQ7s4FdJQHItbkCJX2o
 eC2a2lT9hutfsayATJF7dABye09nzDA5mZpPxySiB0VAtueWYQTHVTnXr5Nvi+/LyjBBhU=
X-Google-Smtp-Source: AGHT+IE6PShnI/CRClO5D7qa4+UJR/t4DLb5LjtRmoiSHFq5WUxY0bqCirxan9MtMGsDjG0ViuLHqFJ22muA6ZYVZQE=
X-Received: by 2002:a05:6e02:156c:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-430c524e127mr218120825ab.7.1761003311695; Mon, 20 Oct 2025
 16:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-13-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-13-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:35:00 -0400
X-Gm-Features: AS18NWDZ96Fid4x7kUBx0A9mf3pfa0csLq2Gp6ZAiN_KOiLxD8IkeU6hqjIX4s4
Message-ID: <CAFubqFsKOJwD8w_jNRCuyTVs=LytbYF+ZsKTP986g-An-6Pbdw@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] vhost-user-blk: move first vhost_user_blk_init()
 to _realize()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 7:48=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We'll need to postpone further connecting/reconnecting logic to the
> later point to support backend-transfer migration for vhost-user-blk.
> For now, move first call to vhost_user_blk_init() to _realize() (this
> call will not be postponed). To support this, we also have to move
> re-initialization to vhost_user_blk_realize_connect_loop().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 36e32229ad..af4a97b8e4 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -464,14 +464,12 @@ static int vhost_user_blk_realize_connect(VHostUser=
Blk *s, Error **errp)
>      DeviceState *dev =3D DEVICE(s);
>      int ret;
>
> -    s->connected =3D false;
> -
>      ret =3D qemu_chr_fe_wait_connected(&s->chardev, errp);
>      if (ret < 0) {
>          return ret;
>      }
>
> -    ret =3D vhost_user_blk_init(dev, true, errp);
> +    ret =3D vhost_user_blk_connect(dev, errp);
>      if (ret < 0) {
>          qemu_chr_fe_disconnect(&s->chardev);
>          return ret;
> @@ -501,7 +499,16 @@ static int vhost_user_blk_realize_connect_loop(VHost=
UserBlk *s, Error **errp)
>              error_prepend(errp, "Reconnecting after error: ");
>              error_report_err(*errp);
>              *errp =3D NULL;
> +
> +            s->connected =3D false;
> +
> +            ret =3D vhost_user_blk_init(dev, false, errp);
> +            if (ret < 0) {
> +                /* No reason to retry initialization */
> +                return ret;
> +            }
>          }
> +
>          ret =3D vhost_user_blk_realize_connect(s, errp);
>      } while (ret < 0 && retries--);
>
> @@ -566,6 +573,10 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>      s->inflight =3D g_new0(struct vhost_inflight, 1);
>      s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
>

Why call vhost_user_blk_init() here if we call it in
host_user_blk_realize_connect_loop()?

> +    if (vhost_user_blk_init(dev, false, errp) < 0) {
> +        goto fail;
> +    }
> +
>      if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
>          goto fail;
>      }
> --
> 2.48.1
>
>

