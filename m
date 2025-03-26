Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD2EC3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPXM-0001Yf-Sh; Wed, 26 Mar 2025 08:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPXF-0001Wq-V3
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPXE-0003Gj-7Y
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742990822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKO7svhiiFuiWdq9nJfoUvqXf/uyiePTF3/IcalZGUQ=;
 b=XiXZKFgtry7XUfqqg+yISCctQHiMZTtGS6ODwPcjHL/NySTUiqqP0lZvSxn0aooDz2QtWu
 k2nfBrTB+Vh3C4hsvZojrotEr3DeitQBMvlqlwFzt53Ozid1w5foTzTxhtEGng0xb7UWDQ
 AnviMQi32ScDzPxjd7Y53i6f6EpvZBE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-lBU8PETwN0KU_0tLSXy79Q-1; Wed, 26 Mar 2025 08:07:01 -0400
X-MC-Unique: lBU8PETwN0KU_0tLSXy79Q-1
X-Mimecast-MFC-AGG-ID: lBU8PETwN0KU_0tLSXy79Q_1742990820
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so1746363a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742990820; x=1743595620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKO7svhiiFuiWdq9nJfoUvqXf/uyiePTF3/IcalZGUQ=;
 b=hURHa0mG6OpncZ9vun5bTkuPhwf4EAbC5VrN1GD4Ts6qSDXfDkHZPfvepLVj9VYwpj
 dc9otr4TxVeyZBXucxoZc9YbFuWaS8gFJZFFAxdz7Bed2feOztWaDrw1DuYx9DAZi4mo
 Oykl4p3r7TcBWyaX58DmvB9mrvQByL76p6T3eSiKmHIdDlRuNWI6BZDLJalSlHx02bkK
 7Wq7M8CV5/9W0z4eg8KmbYJ2H/pDAML6R0y3Jk/w9zgcblcg5+trU7aplzerup6hPvXb
 nP44MzNv8dImw+a+Q5jhg7Z/Ei94ZCX+pwKeSgYYSzMFOXsAx0bb1sb8pFfHhWWUvc8R
 UP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW73Dhb2gQ+DeqWZ/xawJp5mOja1ZU92wIyrMPZgisx6VHXqgu0kJu0m7lMh/1YJTa5emkowoZgnS1M@nongnu.org
X-Gm-Message-State: AOJu0YxfQ2wB0fdBGJXihDVJ6Fx6uxk0OoY/BTciJSnh47oWbkE9B8Mq
 V8QXfIPdrxXxnAl3ZZemBXnT/G7qL/J3FaO2DZS00MmhPLVJQ/rBjrp4TACvIQFu3HHt1r6SwJx
 yj/V40rE9tcEfQZgsfhKpjP0CxM+yzawgkr/vzhwHnSlMo4j3vWD4BC4hT0eqI8TyuBR/gGHKhG
 Ttrw6wFIIbfXXG59sXh2DisSRO+JA=
X-Gm-Gg: ASbGnctLOP4PH9fF7SklwyAKwpfeweu/+IPhjTH6FU9bysseMlcY79brloM19M0v3L2
 W1NtaapcBn31jnDId4StdkQdXpycviOvtBjmxMQ2Htq5ooOIbuQgfJ+lia8dKB6nv+IyjiPI=
X-Received: by 2002:a17:90b:1d49:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30378956f56mr5510146a91.12.1742990820022; 
 Wed, 26 Mar 2025 05:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRsTa1AvulmwKcj7XGMzoDyh1rxFgGubztjgtM1D9uS+vRfoQayvshX3/jxoJt+dwllVcqqMZHV5Vdne8IoEg=
X-Received: by 2002:a17:90b:1d49:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30378956f56mr5510114a91.12.1742990819602; Wed, 26 Mar 2025
 05:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-7-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-7-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:06:23 +0100
X-Gm-Features: AQ5f1Jrh5zeVre2IjD26PkgvyIEeFyoNi4XouZCBEabdEYDSenAizt6PXAEvoQ4
Message-ID: <CAJaqyWecV3X9PmRHikjkGYT1jbN_ygyKYqvi5AuMtb_aE9oZ0g@mail.gmail.com>
Subject: Re: [RFC v5 6/7] vhost: Validate transport device features for packed
 vqs
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Validate transport device features required for utilizing packed SVQ
> that both guests can use with the SVQ and SVQs can use with vdpa.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v4 -> v5:
> - Split from commit #2 in v4.
>
>  hw/virtio/vhost-shadow-virtqueue.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 8430b3c94a..035ab1e66f 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error =
**errp)
>           ++b) {
>          switch (b) {
>          case VIRTIO_F_ANY_LAYOUT:
> +        case VIRTIO_F_RING_PACKED:
> +        case VIRTIO_F_RING_RESET:
> +        case VIRTIO_RING_F_INDIRECT_DESC:

This should only enable _F_RING_PACKED, there is no code supporting
either reset or indirect descriptors.

>          case VIRTIO_RING_F_EVENT_IDX:
>              continue;
>
> --
> 2.48.1
>


