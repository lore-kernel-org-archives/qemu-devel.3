Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA69CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzQT-00051o-8r; Mon, 20 Oct 2025 19:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzQS-00051W-B9
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:36:28 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzQQ-00012s-O0
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:36:28 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-430cb80df33so15475535ab.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761003385; x=1761608185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llsahX1QQKQXxlSrxekZyeHmDlAgFPBZQHstRb1cKeg=;
 b=LnR3sMoCYyNz2hB9sq8SDJxgNV6vTaw6Ncrs9kn6YTkV1/N+lskXa1rVCv5eXx6rET
 72BV1r7IOrSpyHk4D1bkrnHar6XixVoFn9UsLrD2cRTF+TlRhSqYf5EHNUGPzV1rAanS
 dCZAglWGPE5iBTLHasMCsTB7qDU3RwoPDbHztbyWkjHyYYPJ97P9fwvJgHRDKpCGTLII
 tATrQ9DM2//TQNYj/3k1bp7iJdwWLzgzlzZv++dYbTYzb6OiH9pv+4w6o8TZ26rj5kBs
 a5cGB1OAvOAZRO6XbM9zX+jJ7L9HQQ1/dnUXZ559YSqSYl5pTi7Sfi6HWKxGnU5suNsp
 FyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003385; x=1761608185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llsahX1QQKQXxlSrxekZyeHmDlAgFPBZQHstRb1cKeg=;
 b=lbVsawzcOCS5mUIQBIR2+E/X/OB99OpOvavawx9urFQSFQV3VC/tBu4wm22PB5OCyN
 VYYcZviYGw1801SPYQf7xWBuNdDcGQR3B9T1h3DNVnN3IZxDFE5ozh/Mkg/M3WScl/ag
 8cBs2HsupMLfVXjMGOosD8uQ3qc5sCesX9NIwkKq6TWteSbl7RmndWgsryL9EIP3WiTw
 woeZgCgDuW8p1lzDXPPJQ+SAxsGA3vvOL8cSkvoiCaD7nj17/oa7oCUAEZxXd1lrkX/w
 UzPc31kHj3NzWtG0ArMQABWos5+gHSb/nE9ox4T24YQQvMrZX3arn7tk/2buDGmayAld
 mXOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXksCW+RUeZzezwpZeU5B6EA2S90VyBNUiONt9K+dgUP5JI74jME1gZINPd4du9ESeMB00UsSBjS191@nongnu.org
X-Gm-Message-State: AOJu0YyJqdOHkM+RAejEIpFStZfYdJ10taEEDx+FZNrsO31NkOjnupLc
 6KnmmctVTDGqqE2vkK1E7TXgRi3eIZvT0BS9KXHqoaPAPmH6jM7MPBgrMtnEzP3sbV497YkwdDY
 SUxZzTGK6dt2l6GWZfMQfIwdmyaATUiA=
X-Gm-Gg: ASbGncsCTxKKie+Fu4IGnOtIven+gJACAtlGTqoNG5zwsTOgljvtvMpJgY4u1bMV8cB
 lUO7JpjlxdvU2UNHhxacbsKT0Y7O/vfOMdeRxXw59xSMzMXkwfKjbup7GALED8iPNQ5hSCX9t1L
 lATa6kLteZbafjKU6O69l0nTz27wMWB4EhMLTMMkjLonl0cHPqkErym8RVs1cAmDK159DIEAGvO
 u1gaPBq/o3t9LiFQ+K83bNEgRtS4o4lyLzrcooPUZ7ZckJnYr7oIY+2Dlb5
X-Google-Smtp-Source: AGHT+IHV1iaqyEBL5ezlvIg/78EDO1LKs0u/7cF8UDErBUL0IvCeBKxCwqzlhbIzs7qyf0WX8xURBP25UK/vGDKKV6Q=
X-Received: by 2002:a05:6e02:3e06:b0:430:a025:8ac7 with SMTP id
 e9e14a558f8ab-430c5209542mr208174555ab.1.1761003385385; Mon, 20 Oct 2025
 16:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-14-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-14-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:36:14 -0400
X-Gm-Features: AS18NWBnn0rgFBMOpVZPTFPhNftySnraynoxmO0iChYDPSnm-BIauNXP8gkDbyk
Message-ID: <CAFubqFvVMWA1RKQqb-ZUBTeDBiOMwd8yi3F6u+sojA4WskCrJQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/25] vhost-user-blk: postpone connect to pre-incoming
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x131.google.com
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:46=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> That's a preparation for further backend-transfer migration for
> vhost-user-blk. At initialization time we don't know will
> user enable backent-transfer (by setting migration parameter) or
> not. At time of pre-incoming, we know all migration parameters and
> capabilities. So, now, let's postpone connecting up to pre-incoming
> for incoming migration.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index af4a97b8e4..ffdd600526 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -577,8 +577,10 @@ static void vhost_user_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>          goto fail;
>      }
>
> -    if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
> -        goto fail;
> +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
> +        if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
> +            goto fail;
> +        }
>      }
>
>      trace_vhost_user_blk_device_realize_out(vdev);
> @@ -636,10 +638,18 @@ static struct vhost_dev *vhost_user_blk_get_vhost(V=
irtIODevice *vdev)
>      return &s->dev;
>  }
>
> +static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
> +{
> +    VHostUserBlk *s =3D VHOST_USER_BLK(opaque);
> +
> +    return vhost_user_blk_realize_connect(s, errp) =3D=3D 0;
> +}
> +
>  static const VMStateDescription vmstate_vhost_user_blk =3D {
>      .name =3D "vhost-user-blk",
>      .minimum_version_id =3D 1,
>      .version_id =3D 1,
> +    .pre_incoming =3D vhost_user_blk_pre_incoming,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
> @@ -647,7 +657,7 @@ static const VMStateDescription vmstate_vhost_user_bl=
k =3D {
>  };
>
>  static const Property vhost_user_blk_properties[] =3D {
> -    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> +    DEFINE_PROP_CHR_NO_CONNECT("chardev", VHostUserBlk, chardev),
>      DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>                         VHOST_USER_BLK_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
> --
> 2.48.1
>
>

