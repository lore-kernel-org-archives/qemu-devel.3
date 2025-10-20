Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A9BCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzEH-0007ou-BW; Mon, 20 Oct 2025 19:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzEF-0007ol-2B
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:23:51 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzED-0007vC-9l
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:23:50 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-430d78a15b1so18678935ab.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002628; x=1761607428; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJ+dJc5yM/b/W3h+TlZlZ1bgfEF08dwB9tQn1juSLso=;
 b=OxK1n38bzlOZ3kwwx37VZ/ni6atr8+cH4JBW121GCZ8w3MMJzxEzCsEWZkXVXRweSG
 1bxCxwrDCc/Tp2QZUi5xQ4Yno2ch8/Av+ZduCi9mHTuXamaWtZUglCNSpETD7NtPJX6q
 XcI+HwVwYOQ6gO5JTWMYEXLXPr1qdTQQ1WtXxG7d2VFn8/Xh9y29y71L+LGdq/LuP/Ro
 9hTgcKYVmj27PR/T7N9L5dD9N3RnfLBJjpdMyBMxrO6edf/0In0heAO7mHOyLriQBxDO
 40XqHWv6XfWD0ABIyxlgcOt1dLz12TZU9o6HCkZcmrystFGEm5wO/3yEpO7PGC4BSybV
 1hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002628; x=1761607428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ+dJc5yM/b/W3h+TlZlZ1bgfEF08dwB9tQn1juSLso=;
 b=d5K2FSsyjt1BnvAlgcEn40NKsWOeJt98Wvp15zc4hS0dwQWkdKWkhj2opryytO+YyL
 VtwoSCGqVLtmYgE6UMsIpSxAcS9tZ4+Ga9k31DHHXRm4yOGkuzd3OMBUZBzYcqr6FVD4
 wa+JRBafOh6zOkYyV8qnf4ZSYUz4QUxJPCFZtRXhPCc3iJ5WVPWCkzThlXago49Ki/DH
 x5MMBC+OgKYvL1Fn06F2a0SssnWRzBh6gVAHQqEmIjBwB5SPo4CSc3LF00M5yZukl/hg
 wlOFaBlhIPcCDSMcE7YwEx0OfkDVu7ABqE2XwIKx9iNvpQee68uMzvFMOqI2aUV4b6VR
 MneQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRjtt074h5LLCZ6VrLWkEXpuNaTC57dMoU+hQrRwThH3o504X29Rgk5m6JrmD+A5ohrCeNnpsHQrbr@nongnu.org
X-Gm-Message-State: AOJu0YyKqpmiVAg9HdQNdask1HgjZt6N4FsucTMRa2+5v4u9zJurAlkc
 m9Yg2pEW+2m9GPXU5HklEEpTH9v8SmQgiW7VViPUi8BWCbVxRNypR9anj41uN5k5/5pwBWAncHk
 R9t4sq8E6GXF3z6G7oDkLb/UNtogioZw=
X-Gm-Gg: ASbGncsSz2bk5cuEHa9ElRjz9WZ+u0BpgJgMd4oTJdPt8zA7uWPIAYxmFKMtuGrsAUq
 +fIwGO0vyNEwDcRumMXcNnOjWFpnjbiBR5buHtO6ahlK8RFnf4/zTQyrEDlUTU1rdCidZ7OFkD0
 1ERLmuZ/o7P3Sl7IDlQ4do822KIMBqLnqAjjSMMTlqVG7leGfyekmsXBlDqUwTOVMJzZEaSCEcn
 M1otMYysejCwO5zoVTqD3O03KmIzfrY9HOBtK4v3POeNG2IL5MQV+yBsrc+gCEUz5nwmgU=
X-Google-Smtp-Source: AGHT+IFv/k3DyQasGUHGOvNV9eXw9XScd7ywXY17sHBFtiPN4Q6QGq2aexkDCFAkUf35GN8EfmR6pQe3kcRvjp/47N0=
X-Received: by 2002:a05:6e02:2585:b0:430:ac72:f9f with SMTP id
 e9e14a558f8ab-430c5268eecmr192944775ab.20.1761002628010; Mon, 20 Oct 2025
 16:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-8-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-8-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:23:36 -0400
X-Gm-Features: AS18NWB1Nx4VByKpoCqNtV_J7v11BdzsbkhGhGSCmNZsxa6IeekQN1VH_jd1li8
Message-ID: <CAFubqFsRbdqv62A19GyQKv0WdHJHXnCXK69wn7OFZC21HaBCFA@mail.gmail.com>
Subject: Re: [PATCH v2 07/25] vhost-user-blk: vhost_user_blk_connect() move
 connected check to caller
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12c.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Thu, Oct 16, 2025 at 7:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> vhost_user_blk_connect() has two callers:
>
> - vhost_user_blk_realize_connect(), which directly set .connected =3D fal=
se
> before call
>
> - vhost_user_blk_event(), where we want this check
>
> Move the check to the only caller which needs it, to simplify further
> refactoring.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a92426f18c..57214a69cd 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -352,9 +352,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>
>      trace_vhost_user_blk_connect_in(vdev);
>
> -    if (s->connected) {
> -        return 0;
> -    }
> +    assert(!s->connected);
>
>      s->dev.num_queues =3D s->num_queues;
>      s->dev.nvqs =3D s->num_queues;
> @@ -411,10 +409,12 @@ static void vhost_user_blk_event(void *opaque, QEMU=
ChrEvent event)
>
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        if (vhost_user_blk_connect(dev, &local_err) < 0) {
> -            error_report_err(local_err);
> -            qemu_chr_fe_disconnect(&s->chardev);
> -            return;
> +        if (!s->connected) {
> +            if (vhost_user_blk_connect(dev, &local_err) < 0) {
> +                error_report_err(local_err);
> +                qemu_chr_fe_disconnect(&s->chardev);
> +                return;
> +            }
>          }
>          break;
>      case CHR_EVENT_CLOSED:
> --
> 2.48.1
>
>

