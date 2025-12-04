Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA48D216A5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBVN-0007Tp-5u; Thu, 04 Dec 2025 10:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vRBUs-0007EX-Ht
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vRBUq-0007T8-3a
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764863027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sg1r3xRBx5oTR6kdZwIpYMZxKh65OWms7QuFUHc3998=;
 b=IY+D5kEy23QrVDkodpuwJ65ehJsh9V/MsGq7glSgtcYqMgZdcDTAcbPJCOzrRXmlgjmYQV
 6LhOYQkTIq4wFdTGAjfkfLiVR9N/i/pKFFscsPOR16xacsmDGUaBPPr/wAoPCCQ8Yl7iZU
 nNgtxYaDTK8dP6BZb+sPOo1C8dTlsoA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-ctLJwcbHPxKyZASnuAIDnw-1; Thu, 04 Dec 2025 10:43:42 -0500
X-MC-Unique: ctLJwcbHPxKyZASnuAIDnw-1
X-Mimecast-MFC-AGG-ID: ctLJwcbHPxKyZASnuAIDnw_1764863020
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso13200425e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764863020; x=1765467820; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sg1r3xRBx5oTR6kdZwIpYMZxKh65OWms7QuFUHc3998=;
 b=Qx9QPo1/mb8Sk69VSeYqvwxwTlsHnrHM0Pz9NRLfdJafgJEHPVgj2UZbdblKHrEHfX
 0hi86AjREHT6MPRz5HX47OG1nn6pvWETrAQHvIOj3eBqwgdqlQmHhaOymondO1EYhTi9
 2X9Bf2iYekUnFp7zSjBAh5q7hH+GSQiKZceWxiOVboktO+YE0o0oM+v5dromuHTpH7oQ
 kmQovCir38gNKDO2mF52T5rcxAiJRePmW5Q/5zvaOPr4ny7JOmYPTL2+fd9NhwTBGml+
 q/A/mASgkch7UI4m8mIs+hup6uZI5xNlQWBcQaoj9ph3x2TidlnYkpEXWQezYaPsT9HV
 4EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764863020; x=1765467820;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg1r3xRBx5oTR6kdZwIpYMZxKh65OWms7QuFUHc3998=;
 b=cG9uKYmCq7UfIRvaD1jOjLQy2WpMN/mtQqm6nyBswQWctAarIaeyylbkwTqkIBtKPM
 wDwihXLYAoVDj/wGb4fEuaOgXFifB75toWQggPdIQGOsAuZZYOaOK7OQi1N7qx6gB/7a
 Eln7BRF5CCT9iC7FBoezhSekfJeWUtGOdMWng/vuG+wtialilzBx5ag53oiKMJxF3vkC
 DosgLyWjJ/0dET+LkdfSKMXB/9Cp0rEdRJ3m+RpE8oKRS+Wn0jDiR04RP91eESVWYhxM
 jb0gc8SzEzT5D9JTa1sHoVhQV0kCj6QO58tWxjUnkF8tjdhE+/Biy3ObmjG9Fcotjqg1
 vjQQ==
X-Gm-Message-State: AOJu0Yxbl+FJl+4dCcq4sVGEPf8jjSGOPuLidyHnQGiAnEOj7HEi7IFh
 hb1XKc4t08Tnt7Rfv3aIuijrXvQFAf7eLb0axao5AsmCT/ELN2qdNryjpcdf/615tTEUY6rjUW0
 Ra7cgffcxB1+B3H4QhW/1WHREi2VEqrnOoXrkx5tCgOLUFtKnh19TiEI1
X-Gm-Gg: ASbGnctbGxqqPZd2gc3JxiNQokJMy4bHM/TwieJSz1zL70pyeLBvZ4fev195oE20fQ0
 dFvUzd1NL2mVadzEOE3/NAgoGqFVHdtC4yGCM1jyhxEpht0E1dGEP5WIaPpz0u9RV2mc6VjFrfT
 VcmE6hmAfxldW064ih8XNuFNF4Tkna7OcFy61sr+AyZ/eCSLhTEjHCdpVqEvmJHWJYZgyTDr1kj
 gNsGMhK3t5iWAn1PAwVS0R/qYL08C/vOyKiQb+BBqu4BXhdvVoBvzVtRcmHs+9gp5PL9pCm1qIg
 9OhTXMlft8/M1hlynMGpA/owRMSjiJGYsQm7ZZ2mj0OVpFkG5HkspslifiCRYxrLBKCEWKjowBP
 JkIjaJ59EUoz4Hxdg4sxH/FMUZ5vyl1+ZXg==
X-Received: by 2002:a05:600c:c494:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-4792f3984femr28492075e9.33.1764863019745; 
 Thu, 04 Dec 2025 07:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXrLQXniIgcX0PcE+4SfO55HFW0PTcLP1Wg3bQnn6bSYe310bch3T3la+9cLz3dZGT6zcGLg==
X-Received: by 2002:a05:600c:c494:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-4792f3984femr28491705e9.33.1764863019150; 
 Thu, 04 Dec 2025 07:43:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311ed466sm33715175e9.13.2025.12.04.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 07:43:38 -0800 (PST)
Date: Thu, 4 Dec 2025 10:43:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, aesteve@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
Message-ID: <20251204104313-mutt-send-email-mst@kernel.org>
References: <20251204152607.259387-1-dbassey@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251204152607.259387-1-dbassey@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Dec 04, 2025 at 04:26:07PM +0100, Dorinda Bassey wrote:
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
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>


all the trailers should be adjacent with no empty lines
in between. thanks!

> ---
>  hw/display/virtio-dmabuf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 3dba4577ca..5e0395be77 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
>      if (resource_uuids == NULL) {
>          resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
>                                                 uuid_equal_func,
> -                                               NULL,
> +                                               g_free,
>                                                 g_free);
>      }
>      if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
> -        g_hash_table_insert(resource_uuids, uuid, value);
> +        g_hash_table_insert(resource_uuids,
> +                            g_memdup2(uuid, sizeof(*uuid)),
> +                            value);
>      } else {
>          result = false;
>      }
> -- 
> 2.51.0


