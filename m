Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EDECCD1AB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBxc-0006kl-7n; Tue, 21 Oct 2025 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vBBxR-0006bC-Ou
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vBBxO-0000J0-AP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761051555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZlBmsKZDJiBIJDciru70bUgASgD726oQk2/quELiaU=;
 b=fggk7vR4rtLZDQlbYdfwUTdeG7Sc/uKyPbguNnZAtpWck3hb5w0uq82M+Y9UCIYt37P41l
 +HMeduiQru9arnd3JWBCXYYF31laGYeS6NCu+kJWE2lA1EZOn9EsFdZCwzPk/NYu4/yh16
 zH46abKQzCU6pgqKJxdPzzqQOWRfras=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-oOx4FkCUPHW1TSJFu6uwhA-1; Tue, 21 Oct 2025 08:59:13 -0400
X-MC-Unique: oOx4FkCUPHW1TSJFu6uwhA-1
X-Mimecast-MFC-AGG-ID: oOx4FkCUPHW1TSJFu6uwhA_1761051552
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso29678765e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 05:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051552; x=1761656352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZlBmsKZDJiBIJDciru70bUgASgD726oQk2/quELiaU=;
 b=MCJYzMWVrEcFwV9GXrpa2cqYzwCYjemHLqgI1QEZXReTCs5ysDtxgcvgClOmhLb0b1
 mDOL9zMO9W7fWp5LlEWWsnwv5HZAL9NuxS+CTFHp6aRqEoaioDDTrrAdU5WQg12+5vLp
 5qYWDc5gAZjjTdRaluRLjZE9I+7qlJF1NOrvvOCr8Vgwo5jSWPG8hwMdaf9tqP3EHfbG
 QeucWqsxx+St9j9eGM/g5CsmwGSr9VBS1ra6+9RpCFPuU1+raZ9FZjhuGeBRE7NXfhjX
 T3yfVC5Q8VmpbyEuqF6PJedIk2Mj8Oq3klbMPKo1Y3jLbsOdUpIdOzaDySl1fT9JyJlv
 NQ3g==
X-Gm-Message-State: AOJu0Yyl8jRm3RWYOI4vsc7L9rAQzeea5VtlKFVoxLLtfWX2McJfKhc4
 u/Yc1E972vbKqsrtk/hMhuqsgAkNOHv4xvzAuxsiaHlYKJFJSliqKvud+rukJPx+6zlB6Y1DFtu
 YPJMoZdpZhJgl+k9jgGWdC0GG3T8+fanWiJxWuWZlK+Gkh6T4DRMlDun6+O8NtEBw
X-Gm-Gg: ASbGnctgXNsgBrGKuQOPbHOAqKHLqGL4yl0BDvp8OzCFdoOZoidTvgK5RxJ6DukD7Kx
 mpEj7llQYvHTbCTmkNYxD8wAs6II+P7kA46qaQelRyS8GMc7Kt+a03J2A07vja1HmkQHG4c0zE/
 NaWd560jwYmVAg4hDZoy4NSoiqU1wh5tj8lGOoT3/kpPhig7nKOx2fHrqTxCYo3JN/6sdnkbG7p
 lyb043JWfIsBYPkQ6YZdM/uO9m0KxYmo6FwNcUKq5EAJX/UOfoCy33sndN588I5WpSsmSctBNI1
 6AetHQzL+7MZOMmDLAoYvmjl+866enEpSOL9M5H/3f0rUMMR5NM3AhxXB+cjaUivbNsE
X-Received: by 2002:a05:600c:8183:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4711724e5bcmr123916925e9.7.1761051551823; 
 Tue, 21 Oct 2025 05:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsAmkL5knBOk8a/0pqwNAcziPaakN/ECFuDYC//qeQ4e7YoJMlWByzC4JpXMSSmwDPE44hYw==
X-Received: by 2002:a05:600c:8183:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4711724e5bcmr123916725e9.7.1761051551320; 
 Tue, 21 Oct 2025 05:59:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47154d382d8sm199479565e9.12.2025.10.21.05.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 05:59:10 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:59:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: qemu-devel@nongnu.org, yu.zhang@ionos.com
Subject: Re: [PATCH] qmp: Fix a typo for a USO feature
Message-ID: <20251021085833-mutt-send-email-mst@kernel.org>
References: <20251021053309.208957-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021053309.208957-1-jinpu.wang@ionos.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 21, 2025 at 07:33:09AM +0200, Jack Wang wrote:
> There is a copy & paste error, USO6 should be there.
> 
> Fixes: 58f81689789f ("qmp: update virtio feature maps, vhost-user-gpio introspection")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Can the FEATURE_ENTRY macro be updated to include the
string in there automatically, please?
It's really pointless to repeat it.


> ---
>  hw/virtio/virtio-qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index b338344c6cca..968299fda0c9 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -299,7 +299,7 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
>              "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
> -            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
> +            "VIRTIO_NET_F_GUEST_USO6: Driver can receive USOv6"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
>              "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
> -- 
> 2.43.0


