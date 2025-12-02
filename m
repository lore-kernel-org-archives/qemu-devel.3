Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A5D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQmh-0002PE-UW; Tue, 02 Dec 2025 08:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQQmg-0002P0-9F
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:51:14 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQQme-0001f4-RC
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:51:14 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b7277324054so788753366b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 05:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764683471; x=1765288271; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gPojMmcZRIrBGvsW3rxjNPbGmTP8vgzs7BYGkYuZ/M=;
 b=Oc/DbnyQflGCoK7En1nhKvF50rLwTuSqy3C/S1LxssFzeiLTKmoHhrnm/08ZgvILPB
 Bhu+dqO1rciZBKgclIgGgNnm3fRNaQE1ebLNHOIEY7y2n87DwZx7nBKQHP6ygjczGN7p
 3/p7Vv2eZDrnuiDd8le1hQYTby1E6yI3BzJn3jRXfl1MzQ+6dzOZzwMmm/27eUCw6eUJ
 m79lTIqUb1Z3oOz3XsaYFU8tz6qCwLuDfnNBkzxIivrQHAuEGgSyOJgiWwDCQARO+RAe
 ShIce7VxG9f0AeC/hEJcTm0xx6qtUWKaGyXZjlRdxI4AkwxN8bEZ3tXHEnT9StSH8O86
 7iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764683471; x=1765288271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/gPojMmcZRIrBGvsW3rxjNPbGmTP8vgzs7BYGkYuZ/M=;
 b=atBsKYroYReqrsLW7AlQrPBul4WQCOwrWkYmywvRs2bwwBoKhWbwUbNkagwWkKPrBx
 RMnJnWRWrajyn+rLDZEGernbvKsKIYT7LwuMHHTXYNhUCh3lovnlc6Rl71DifCb7UJyz
 /HI8NXYHgYXI42Pp/cD5GT+6X4hFbEm+sqGFM8TtanqRbsii+CJGpbeHn/itQ0RE5+fG
 hLYrbloQkV7E0B+vTdGyuoaBU7G+43UaXt1uy4VFv0+zalNomKYp+wiaWsHSb9HVgsGy
 7+eNsGDxTKRcPshzgjtnyUw777kbfdKlqxHwrWlhYRORtOzIjaCNunJaP0gZz0XTWSyl
 QFhg==
X-Gm-Message-State: AOJu0YyjV5HrnCgEgEegWLKdNwVf6mwPYl7EzD9OwZfk0m5nlcmSkjDi
 OOZjhgcByN38y1lJTDfPRuhaRZ8kM5jC2rlf+QdRodfIZiRzS7hP4NfwX6L5RV4FP7B7DXHNCW2
 dUkm+lql/xPYQOgbIxrVbW1dg+NLuw6g=
X-Gm-Gg: ASbGncu/V8cMpccE3iuRt8/mGFQaShQtdPaNA+339n+yDqgKM87TLjLxWsfpWjOozbz
 nY2XM4isoYypEox1V9dW5SkgUgios/Jy2rWWKsw1IFHoqMjhEhiZKm++ThHelhfomEZGpT+o30k
 d79HiHECQSApy4pBGcFz3FEyriG5JG82tSrEv9QNep/60v4BGo40Ak7R5APduK4z9KGYMRxDu3Q
 V1/UUat1SDGoHQ09x5wgSoblVU9QkAjS+FzwTnMs66SlHGlDMZsAXUt2+DLUejpKOC0uuZFDZ35
 2K+A6/KFRdOAl/USTMcIhQBhk/w=
X-Google-Smtp-Source: AGHT+IG6vuizZXRuoXJJjQg/UhffsGKWEkGOR2bDTj6pkmMfwdljup3et1sbsu/FMAgmV9U+DQil3H0QizvHnhLKjVs=
X-Received: by 2002:a17:907:c1a:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b76715e604bmr5212427766b.25.1764683470613; Tue, 02 Dec 2025
 05:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20241107180309.1713601-1-dbassey@redhat.com>
In-Reply-To: <20241107180309.1713601-1-dbassey@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Dec 2025 17:50:55 +0400
X-Gm-Features: AWmQ_bnQnUr9VR-dEKs91lhXLHpMJYwpt8-AzALIl4NYiS9EPk4fy8lH2XuGeW0
Message-ID: <CAJ+F1CLRkDKVojdk2DbNeSO3Z9Z4BHN7Ds8N1mwzf9qF9HmCsQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, sgarzare@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62f.google.com
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

Hi

On Thu, Nov 7, 2024 at 10:04=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> In `virtio_add_resource` function, the UUID used as a key for
> `g_hash_table_insert` was temporary, which could lead to
> invalid lookups when accessed later. This patch ensures that
> the UUID remains valid by duplicating it into a newly allocated
> memory space. The value is then inserted into the hash table
> with this persistent UUID key to ensure that the key stored in
> the hash table remains valid as long as the hash table entry
> exists.
>
> Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We missed this patch during the -rc period. Can it be included?

it fixes invalid memory access / use-after-free .

Note: I think the original intent was that the @uuid argument
ownership was passed:
virtio_add_dmabuf/virtio_add_vhost_device
 * @uuid: new resource's UUID

It could be clarified and be passed as const like getters to eventually hel=
p...

> ---
>  hw/display/virtio-dmabuf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 3dba4577ca7..5e0395be77c 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, Virti=
oSharedObject *value)
>      if (resource_uuids =3D=3D NULL) {
>          resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
>                                                 uuid_equal_func,
> -                                               NULL,
> +                                               g_free,
>                                                 g_free);
>      }
>      if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> -        g_hash_table_insert(resource_uuids, uuid, value);
> +        g_hash_table_insert(resource_uuids,
> +                            g_memdup2(uuid, sizeof(*uuid)),
> +                            value);
>      } else {
>          result =3D false;
>      }
> --
> 2.47.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

