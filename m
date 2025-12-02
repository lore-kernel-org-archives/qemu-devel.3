Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16402D116F5
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQws-0007Af-MW; Tue, 02 Dec 2025 09:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vQQwr-0007AU-KY
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vQQwo-0004yt-A3
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764684100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQRynqXWyji59LrbZeNLVD+MKN2shfPDl6qjcdravfI=;
 b=NUbMfc/1uXzRQFQl20IevSIsU6iGD4KC2BpFfZlIuDooVvkpXP+TFuTidRqdWeRA2ELevi
 wr4EfmIq5bbpEMHd8WcyM6MCqAWXx5TWW1GhA4HEk9fR8sn5SUUNzYfKHiT2o4Jc3rBLhf
 Ich9uaSKBiMdKqjW2vx9qwDdQy5mpjQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-iddUmz6LMumQQYJc4jyjqg-1; Tue, 02 Dec 2025 09:01:36 -0500
X-MC-Unique: iddUmz6LMumQQYJc4jyjqg-1
X-Mimecast-MFC-AGG-ID: iddUmz6LMumQQYJc4jyjqg_1764684095
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-340c07119bfso9107753a91.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764684095; x=1765288895; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQRynqXWyji59LrbZeNLVD+MKN2shfPDl6qjcdravfI=;
 b=KEQbfMu8OrEVfIBFDHyOwDgBUwEvJYJ+p80MOlFhdYbvrsZiA5gkTgUV2eNtazkGaX
 COO0Zwb5G3jTIhF/BX0eKZtdNJApmbZsua1J5uKUsmr9PQ3wGG26gVHc6p/UYOegv7t0
 oP2OQo1DaY8X8ivjFWryO8DFBrBN1hU/UmxgIFxrSp6UMuy/2Id4AEDKZOD5mcbdEseI
 rS5ps8KwAGYodYk97UPDQKv6fd21dBeA19wgKWoLJHQPnzbQdwgr2V956gESFcUk8WgE
 AqaQFBQs3wXFvNpAucHXPeNui27G7v7AMGGhFG4cnkvQldmU5MY4W8bbXlH8B7IS19og
 LuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764684095; x=1765288895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQRynqXWyji59LrbZeNLVD+MKN2shfPDl6qjcdravfI=;
 b=vx9krdYMOBppLdTRulPazKPh7pTQIN+99c13cSFEb9ZrpX9R3p2OTJRK48mlPqLpW4
 74WIUwLxGc3h2lg4YeB5JU+to+UL+R6+NgCQEt1yg5xGgbImieo9U1iVK2qjorPtynbx
 RoUO+C8/ZyltPMVEgRk+k38ulSr3uErS4E+txAY9c+mt1XC6d8UBe3yQcJrMKquQH5X2
 N4aVWV4lKNeJ8+dZS4M0D5IKzf9LfDMJqgBFAjPuY5Wul8Lxaj6KSS4yPUbfk/WcvgOf
 TjlBMs0LIq04y49LbmPk5fu1p5/F+7dVdwd5OtdkjOY3I1hM4k3sLcQ7JbPq44QvvpU+
 Fadw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMIEHh76YSB53bGYUNjO+/8JK2G0iycGSGetxf3J5BGd8k6wTc6vOkQSfObItbwg0W4eZTw0RljUiv@nongnu.org
X-Gm-Message-State: AOJu0Yy0fwg9sRdChqrTGtEzX5reT6xaEKXhRewce3KNSDyrYvfDV99w
 okXAS2GF+VN8/6g7+QZquQiLF4XLhDddSYBPvWb961Kh46/1sePdRJmngFBAhwkzpPpLBo8ItAv
 Kutv1fjMFf+mhYi+hDwWF19M35DXcM8klnKp5CEVIvbw9c4dSBwjGJ+3JNj+bjldLASLHtS+3hi
 of8XBxN/Kou5b/HNoyWvCzNYcHvSsHtxM=
X-Gm-Gg: ASbGncv16HMd0UyvpVqZLG/6duPfuIi+dnpoZ8xghN6HDIq4cBe1LrYROFffN3jKtcq
 n9MzoPpj2WUu8Lu8/GIIjaVZ3P+Acfx/ZuUiZpCijJATWeoxAfJQi/MCSRwh3rbe8aclpgpamQ5
 H7IgYIRmUuFGkOv4sugGUax3qwXs6hrIpOERb6BSUeSm1DIojzmtexeUAq9GOAOofx
X-Received: by 2002:a17:90b:3c48:b0:340:48f2:5e2d with SMTP id
 98e67ed59e1d1-34733e7194bmr41689551a91.9.1764684094511; 
 Tue, 02 Dec 2025 06:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0jThMsdUQ7/tcFaH2k4hJq6JmV+wrFvOD98F2hI8b09+QQk7rc5eWw0WJzav50ShUBOrg8BQU1SisU+11vks=
X-Received: by 2002:a17:90b:3c48:b0:340:48f2:5e2d with SMTP id
 98e67ed59e1d1-34733e7194bmr41689388a91.9.1764684093195; Tue, 02 Dec 2025
 06:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20241107180309.1713601-1-dbassey@redhat.com>
 <CAJ+F1CLRkDKVojdk2DbNeSO3Z9Z4BHN7Ds8N1mwzf9qF9HmCsQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLRkDKVojdk2DbNeSO3Z9Z4BHN7Ds8N1mwzf9qF9HmCsQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 2 Dec 2025 15:01:21 +0100
X-Gm-Features: AWmQ_blh-7-Jmn5-kZjZlfgT3mqLFVA2xO4-5jdMRHxv8ZVA--SMcNfMXbMGjb8
Message-ID: <CAGxU2F6mZ=S0AFHzRsmswtsMkgiU_XCtbrtooHM_V2zu6p5r+g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org,
 aesteve@redhat.com, Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2 Dec 2025 at 14:51, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Nov 7, 2024 at 10:04=E2=80=AFPM Dorinda Bassey <dbassey@redhat.co=
m> wrote:
> >
> > In `virtio_add_resource` function, the UUID used as a key for
> > `g_hash_table_insert` was temporary, which could lead to
> > invalid lookups when accessed later. This patch ensures that
> > the UUID remains valid by duplicating it into a newly allocated
> > memory space. The value is then inserted into the hash table
> > with this persistent UUID key to ensure that the key stored in
> > the hash table remains valid as long as the hash table entry
> > exists.
> >
> > Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
> >
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> We missed this patch during the -rc period. Can it be included?

I guess we missed this in several releases since it was sent 1 year ago :-)

BTW I think the main issue here was not ccing Michael (now in CC):

$ ./scripts/get_maintainer.pl -f hw/display/virtio-dmabuf.c
Albert Esteve <aesteve@redhat.com> (supporter:virtio-dmabuf)
"Michael S. Tsirkin" <mst@redhat.com> (supporter:virtio)
qemu-devel@nongnu.org (open list:All patches CC here)

So, I'm not sure if it's better to rebase and resend (including the
R-b) with the right maintainers in CC.

Stefano

>
> it fixes invalid memory access / use-after-free .
>
> Note: I think the original intent was that the @uuid argument
> ownership was passed:
> virtio_add_dmabuf/virtio_add_vhost_device
>  * @uuid: new resource's UUID
>
> It could be clarified and be passed as const like getters to eventually h=
elp...
>
> > ---
> >  hw/display/virtio-dmabuf.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> > index 3dba4577ca7..5e0395be77c 100644
> > --- a/hw/display/virtio-dmabuf.c
> > +++ b/hw/display/virtio-dmabuf.c
> > @@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, Vir=
tioSharedObject *value)
> >      if (resource_uuids =3D=3D NULL) {
> >          resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
> >                                                 uuid_equal_func,
> > -                                               NULL,
> > +                                               g_free,
> >                                                 g_free);
> >      }
> >      if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> > -        g_hash_table_insert(resource_uuids, uuid, value);
> > +        g_hash_table_insert(resource_uuids,
> > +                            g_memdup2(uuid, sizeof(*uuid)),
> > +                            value);
> >      } else {
> >          result =3D false;
> >      }
> > --
> > 2.47.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>


