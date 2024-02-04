Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C61C4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRai-0006cZ-TO; Sat, 03 Feb 2024 20:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRah-0006cR-Dg
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:46:39 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRaf-0007cs-5g
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:46:38 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7c01af010bcso125614639f.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011196; x=1707615996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u1x7NcZDw2wjQiIjTfHekk0nD9MsCiKZAHFMpjfJzc=;
 b=LRm2I0nG/Nhwwzu4vCAwgB/0bAsuZxC6c60Cyn16Gkm8CVVaAqBv9vT+tdtNpw62l1
 ltNSX0TqCnHsLp6qfL5qRGznOahnmnVoQ46WcUF4R460sX/qoyq6MwMJbab8AJQh68mV
 i6te+BEaCRlkDEIaPcP9BvCZnta9cC8AzjTl61WmnWd4M50y5WAyWsSEEE6SWjahsqFq
 FJVInNZ7UGqYRaflrCE8m/r/kZt/Cm5uCh7WNSZoJIXB4e9QgZf10y7wmLuUHSZHi+c1
 /D+rg5hzmw8QtjeTGRtFaP+E/wxNhjtGDk9Nr/iuLeB5ecOryKug7UHVZuLfeEq4rfUM
 0Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011196; x=1707615996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6u1x7NcZDw2wjQiIjTfHekk0nD9MsCiKZAHFMpjfJzc=;
 b=EOxS2WCz3AEFtS986wlwk2coVBIzy/rbE8ITAF2bODMI53jDGWf0hH/SxJbdn3QGHT
 KmN2syuFenTRiwrdM1sCejemV0pby945O18tusuHffaHm/5cYH/QeVR441iY8SNU4Dn2
 d5S3ogjQKErqkr8TN+2jqKFCd17dmF0ISTSY0WYhXPRZwA+XQJZxy/eWE9Wpby52yn37
 DJiLEiGpaSMgO0Rr6N5T6VgvDwgwxIGBOv5pypKgh/o33i25QUwLJHXiMeJbixz502/u
 oFiJYFS1nnngvEr3zEF6QipUMTjoNdb1VLzWoB0+9M9vLMaWX1yem5tLfx9CU7wLPGdd
 xTWQ==
X-Gm-Message-State: AOJu0Yxr7nNxsHH8QuxCZRsqvHv0QFnRjF8XeukbqBZIyRLMzaROHT7k
 xHfriByoqD501OummCkTu5zfR5c9utL3thnOE1NND/dJeNchpAr0l30QRU3QlfcniWDV7Y7DGty
 d4IOYKuUPwhLT7lX/eOCxmAqNEsRExaYvb6bDRQ==
X-Google-Smtp-Source: AGHT+IFbU6m3Ci3M5HgLcUzAOM1D5ydN1pbua+INbD1jMLpoMmP8NT3jTjiJxJI3K2qm85Y4/VoRdIzWfyVIaCBhYWk=
X-Received: by 2002:a6b:7b0a:0:b0:7c3:4950:e2d with SMTP id
 l10-20020a6b7b0a000000b007c349500e2dmr1731650iop.17.1707011196170; Sat, 03
 Feb 2024 17:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-9-david@redhat.com>
In-Reply-To: <20240202215332.118728-9-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:46:25 -0500
Message-ID: <CAFubqFsjG6qKkB4u6bKwFa8QGv18hW9ycUztfMSs2-u8oOL25A@mail.gmail.com>
Subject: Re: [PATCH v1 08/15] libvhost-user: Don't zero out memory for memory
 regions
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 2, 2024 at 4:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> dev->nregions always covers only valid entries. Stop zeroing out other
> array elements that are unused.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index f99c888b48..e1a1b9df88 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -888,13 +888,9 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>
>              munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_of=
fset);
>
> -            /*
> -             * Shift all affected entries by 1 to close the hole at inde=
x i and
> -             * zero out the last entry.
> -             */
> +            /* Shift all affected entries by 1 to close the hole at inde=
x. */
>              memmove(dev->regions + i, dev->regions + i + 1,
>                      sizeof(VuDevRegion) * (dev->nregions - i - 1));
> -            memset(dev->regions + dev->nregions - 1, 0, sizeof(VuDevRegi=
on));
>              DPRINT("Successfully removed a region\n");
>              dev->nregions--;
>              i--;
> @@ -2119,7 +2115,6 @@ vu_init(VuDev *dev,
>          DPRINT("%s: failed to malloc mem regions\n", __func__);
>          return false;
>      }
> -    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regio=
ns[0]));
>
>      dev->vq =3D malloc(max_queues * sizeof(dev->vq[0]));
>      if (!dev->vq) {
> --
> 2.43.0
>
>

