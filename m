Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D045CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5RQ-0003Lt-5v; Mon, 15 Sep 2025 05:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uy5RO-0003Lf-8J
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uy5RD-0007OH-Mi
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757928227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuKMJMFGpHOUjgD++H49kWACmXGEqnoX/pKs+7Ky/gM=;
 b=AOF146KtWnzhrmzO790ow8W0fIfYfRpsTApOYdx/wElIF4E0mOayyzC232GlsiRanrV8CY
 O3ua/pTHuYJOxzhD1ZSNO3SsU9OqlxAfctFe3U0pmXJshtAmiONJvwTJHkHA3dbaioIqXo
 hGq3hx7j01GuwGKMO9O/nd+yQi2qmBc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-g5gcLQhjPqyKmSv9OYKdIQ-1; Mon, 15 Sep 2025 05:23:45 -0400
X-MC-Unique: g5gcLQhjPqyKmSv9OYKdIQ-1
X-Mimecast-MFC-AGG-ID: g5gcLQhjPqyKmSv9OYKdIQ_1757928224
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b521995d498so2923554a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 02:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757928224; x=1758533024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MuKMJMFGpHOUjgD++H49kWACmXGEqnoX/pKs+7Ky/gM=;
 b=ndq0OhkHkPcA0kL4mTPO28FdMUKDpfpErM1I3PoENQIA+sjIq9hhckIwgrveUEtDpd
 FwsWEA85m2BtIpsvk6ilH5p1V8tdIbSBup33UxdelzChYHMV6QzZHKMIvxjID4TPbu8w
 YSzh/dEcTFSyizyETwXs3vWOo6AMRJoz7LJz9aKsmsdgn8ig81FiyCSMY0Vmy9PuJjmz
 Y86uzkfIGPxooBoXPvJOG5UkvcgOLzR0p7fl3v9z7EhFwMdTm/TAEfR0p4q34Inv+aLL
 uRID9ZHSQaKAonvHRU+6+E4y4KQW69CBwotkra+Ydk9rPATqsGmtytUedyqsVrs+cQ23
 4LHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmLvwHSDCKnLxP3lWz6+wQIQavjONRPA9dBepe8RO5ProUB8WwOyreuNoJL4s91N+7R3xcXdaxVLBj@nongnu.org
X-Gm-Message-State: AOJu0Yxzt9T1yVDGBmZJoBu6yK7uZJ8mMd6AbOS9pfS4JCDIRcd4t3PO
 D8CqdyyrlxYeGnJ5J+ewwDnGmrfFcESv65fgZfSwPoQZy09Hh6K5i5uHRBYQBcSZRZnsjSYDmRq
 Lg2L0l0voQ3BVvrG3f5uuWpSVzgFYi8RiYfy9vIbWsg3flUybFsWZ1BSdGOyKHq6osoS3ueGjnq
 4d2KeIIkxdJqT0Z6D3zEMsI1j/zV/vyXA=
X-Gm-Gg: ASbGncveQORdHPFdbnc8I5Oop+EKEfxTqpN5EHjL9QkLYeStTXWTa4Y9H+rzqUhIU/3
 HC01x6N7aDYMOMfxi3oSIDnCvTjXcSsmQg0uUoZdLcRxJ2+zsNCIMmclanKg8Rt6fpXwKz/M1Fr
 7T5c+XO2hyrLuT5vRQ
X-Received: by 2002:a17:903:1b4c:b0:24c:b2a4:7089 with SMTP id
 d9443c01a7336-25d26077175mr149798775ad.31.1757928224377; 
 Mon, 15 Sep 2025 02:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXpN70DALWCcd5PgZX9lrLPSKZhplTMQnuSH0oUcJwtKfcGepxRnr4M9WGz1RT5WDKH0GrFyFHhMg4f7t+cCU=
X-Received: by 2002:a17:903:1b4c:b0:24c:b2a4:7089 with SMTP id
 d9443c01a7336-25d26077175mr149798525ad.31.1757928224031; Mon, 15 Sep 2025
 02:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241107180309.1713601-1-dbassey@redhat.com>
 <v5p6ztswg7wrooyg4fnenbvbnwf2svm6j6jg7dm4pavwocft3x@ub5mgg5e3dyo>
 <CACzuRyy5urdAzPqRQ__VOZ6R-43LKLFzqj1w_+hsZYs+ovHxtg@mail.gmail.com>
In-Reply-To: <CACzuRyy5urdAzPqRQ__VOZ6R-43LKLFzqj1w_+hsZYs+ovHxtg@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 15 Sep 2025 11:23:32 +0200
X-Gm-Features: AS18NWBFnB4k6OcDgjksYDxL0_U3MFPcc4gSUWa7jCqE95otsnZB1P0OA0CSBx0
Message-ID: <CADSE00LnkhQtTbnWgxMyOcMU+NsB_UnHTJyDWvXQf31Nwvr9Ow@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Dorinda Bassey <dbassey@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 11:16=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com=
> wrote:
>
> Hi Albert and Michael,
>
> seems this patch fell through the cracks, It was posted but never picked =
up. Could you help push it? thanks!

I do not remember this patch! Great that you checked, as this fixes a
legitimate issue. Hopefully will get integrated this time.

>
> BR,
> Dorinda.
>
> On Fri, Nov 8, 2024 at 10:29=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
>>
>> On Thu, Nov 07, 2024 at 07:00:31PM +0100, Dorinda Bassey wrote:
>> >In `virtio_add_resource` function, the UUID used as a key for
>> >`g_hash_table_insert` was temporary, which could lead to
>> >invalid lookups when accessed later. This patch ensures that
>> >the UUID remains valid by duplicating it into a newly allocated
>> >memory space. The value is then inserted into the hash table
>> >with this persistent UUID key to ensure that the key stored in
>> >the hash table remains valid as long as the hash table entry
>> >exists.
>> >
>> >Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
>> >
>> >Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>> >---
>> > hw/display/virtio-dmabuf.c | 6 ++++--
>> > 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

>>
>> >
>> >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>> >index 3dba4577ca7..5e0395be77c 100644
>> >--- a/hw/display/virtio-dmabuf.c
>> >+++ b/hw/display/virtio-dmabuf.c
>> >@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, Vir=
tioSharedObject *value)
>> >     if (resource_uuids =3D=3D NULL) {
>> >         resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
>> >                                                uuid_equal_func,
>> >-                                               NULL,
>> >+                                               g_free,
>> >                                                g_free);
>> >     }
>> >     if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
>> >-        g_hash_table_insert(resource_uuids, uuid, value);
>> >+        g_hash_table_insert(resource_uuids,
>> >+                            g_memdup2(uuid, sizeof(*uuid)),
>> >+                            value);
>> >     } else {
>> >         result =3D false;
>> >     }
>> >--
>> >2.47.0
>> >
>>


