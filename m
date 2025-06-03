Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792D5C5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHtE-0001u1-LX; Mon, 02 Jun 2025 23:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uMHt8-0001tb-9B
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uMHt6-0006nj-QN
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748919627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrspXwX3ZGBRqwwGz7iVMX9veu7g0VR+eE3W/aNsESI=;
 b=VMJZiDO0ON7A9e7RTKP0MwwHxNneXOAyvGReUJ4qOykzi3odBOi5o8eS5xBZGKo4G8IOEt
 NMShElzS0xdMD3wd5+X3NM6aqFETScfjPerUujRIqaeOqv4PLtipkAPIW7HF3/7E9pENz/
 ohi3JfsgMhBjjkvgWAm0euzb1tFtn8s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-7L7FOdoUP7q8EjgYKmDcEw-1; Mon, 02 Jun 2025 23:00:24 -0400
X-MC-Unique: 7L7FOdoUP7q8EjgYKmDcEw-1
X-Mimecast-MFC-AGG-ID: 7L7FOdoUP7q8EjgYKmDcEw_1748919623
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311b6d25163so4652309a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 20:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748919623; x=1749524423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrspXwX3ZGBRqwwGz7iVMX9veu7g0VR+eE3W/aNsESI=;
 b=q38a+cAtJL3uAOkMedh1QCveVJaFCOjLSu8mHcKHu+3nH4ChTghGQ0XrJnMiIKZ031
 Azilmf9IyXPrWCbApKpY46JEBxXmJhuUt8nUvMInp1DoQtcivCyq8Cfd9XT94suRzZrS
 Vu1KHVzK8g0WmY1V2xNjSRWQXVD2rBtJDP/SZjDAbUtD8zJfJ6PO0pS4AsEjYAD+tc+R
 LXFZwl3YjkgeJHktJ70GtyC/4ORm0rzivJjCy0C/Rx9Qe9rViC5EscnATYVCj1Shji11
 Q9vsjw5wQA46Cp70tmif+g065b1m/QWpGrLgnexGa36cj2FnstSVGG9VObWAsR/RPO9D
 erXg==
X-Gm-Message-State: AOJu0YyIJ4PoYJzRx4Nps1BxF188syqqQfKZdF4GRPqIoIDvdAenMcgb
 XQ26nRllb5akKB2dbfo0xLzuBMwFhRb8B3j4PRYd0wwxxYmsVW+gm5uJ3XXde3hXJ5rFFRgS/Qc
 iSFQ7vFc3i+UiSq8ji+/7cFaGw4gJR9uTvcu4NkYp0kqiOIM/En9AlO92oyHgEr2QGTpR+00Bju
 oWx0F0TKQiijprzZYpfN25xTaQlTkc+rA=
X-Gm-Gg: ASbGnctRBI0KJKAndCJ6Dg5HmyWsA8Rauu3Ut7V8an1GeMSlAXRD801Voyjo90FbBA0
 whtcnMryrAmQfb1cWiL9tqkrh1ifd57RIKS5LYMoI4YPEKaFkwp3bp2AsQfvXi3EtH1l0rw==
X-Received: by 2002:a17:90b:4f4d:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3125034a47amr20171183a91.5.1748919623087; 
 Mon, 02 Jun 2025 20:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS5yIblH9srVRuJ3tETrP7EFQ/ZbAAaav6ULqQ8jsz9C6d5URqkgkZ3OBuliJWmqwScOMPk4XyP/ZA52PWTv4=
X-Received: by 2002:a17:90b:4f4d:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-3125034a47amr20171126a91.5.1748919622655; Mon, 02 Jun 2025
 20:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250530-n-v2-1-b1be546ca586@daynix.com>
In-Reply-To: <20250530-n-v2-1-b1be546ca586@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:00:10 +0800
X-Gm-Features: AX0GCFuqhE08SmlYik-7LgNpZvhXjK9tVUutPWWr1F2pWN0nXl9Zws2VhuJhSgA
Message-ID: <CACGkMEsX3HJKh_WsFaVg=5HPQBwGhLQytxvDHS-DQjeN-3zGJQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 30, 2025 at 1:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> VIRTIO_NET_F_MQ uses bit 22.
>
> Instead of inferring the required number of queues from
> vdev->guest_features, use the number loaded from the vm state. This
> change also has a nice side effect to remove a duplicate peer queue
> pair change by circumventing virtio_net_set_multiqueue().
>
> Also update the comment in include/hw/virtio/virtio.h to prevent an
> implementation of pre_load_queues() from refering to any fields being
> loaded during migration by accident in the future.
>
> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing"=
)
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Updated a documentation comment of pre_load_queues() for clarity.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250510-n-v1-1-19ee26ac=
3ca6@daynix.com

Queued.

Thanks


