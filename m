Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF69C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 06:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3CI-0005O0-Eb; Mon, 16 Jun 2025 02:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uR3CB-0005LJ-97
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uR3C9-0003Ii-8b
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 02:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750054784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nnQoc+bXq1oHteOBFbA1Xjlf8RxAtYfQOG0McQImtQ=;
 b=VcsRaO1cL6/JNTexcfgPeEe6mUk3/kR6tBupzvq2XWgEOaSsGB3UOdVA9P/CWlce+Mxt6b
 c607URHHP9LCL+Uy5XADWL683+DlQLE1bsZRsQLKKzpfQlRWWIULkXnln0DPp03FgcHvnL
 XSKzC8liXYluXZ21Gbh5ZO7vK0oL8mE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-NoMSwS1PNme11FE_EtC_Og-1; Mon, 16 Jun 2025 02:19:43 -0400
X-MC-Unique: NoMSwS1PNme11FE_EtC_Og-1
X-Mimecast-MFC-AGG-ID: NoMSwS1PNme11FE_EtC_Og_1750054782
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311f4f2e761so4020852a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 23:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750054782; x=1750659582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nnQoc+bXq1oHteOBFbA1Xjlf8RxAtYfQOG0McQImtQ=;
 b=RoTJPqGLP055f5aMXh9IBgG1TBuj5ktwIu7TcsYbpJQk8Yp+M+pHdpiMbvA8UNy0i4
 I5UTlsETCrQYn9jPrgAd/gwQFjqa4t9W+ATTuqZ1mAxMy/3R1f77fLaVkeqpLmt10rh9
 OkWBhLGq6H2gLnsY55KvyrALCjedjx8VWC9saPO1kRpfZ4aov5CA2Yp57e4vTroQnbi2
 GsIlsuU8b+C4YXDmAjFL7b0xXRCW3SjHPJ7SkOrNfSjYUvu/QnVU1QvyGYb7C//JXpsQ
 f69UFqYcZCvfAONGPSMoGhUqX4H4vUeBpCj7T4y0LszG6wV5aWSEok+ALgijHl1l4Voo
 YtaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRILsym2ZZXHsnhJzJzncNbuNPbHYWX7RX57MhmW3XSjY/dsBRB09WrM2knbKYCVOTTzoTrUKw7VeW@nongnu.org
X-Gm-Message-State: AOJu0Yxe4LtOG1TTzw3uA7A001/ofPjRlYzM2lzm49mcHXEg3AKLR1Cf
 sM0ZhMRyIm0sei5d0mEvFiQuDUvtDbmmYKxmgijDFTs0xKidpxjqsjTjuCAg1IBA+f4hKqsZWXn
 XdfvBEk2VTxHodwiR0AlbroczVSDoFpdr47xWqEvxpD5W9apjFM+h67ey59r25UaW+fcq0cqTm3
 mOK3r5xLHjrKtSnEgaa4CV4RXOBxKWV1o=
X-Gm-Gg: ASbGncu78f3GZqDHDvIBmGR/XM/Mz0fBOM87y/p5/T+opC9G+Fk9RTXfYCfqbanWkr3
 X/uthHs0wRI07cWF37WpMsS08LyzMezAkkUfhMl4RN6shiwBzfi0WRiPnKiGy24gyQdgpWKCAUx
 r1Tg==
X-Received: by 2002:a17:90b:1d81:b0:313:352f:6620 with SMTP id
 98e67ed59e1d1-313f1be63ebmr11625623a91.4.1750054782026; 
 Sun, 15 Jun 2025 23:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDeKz0nlV/DT7Z8Ca+zwI9I4hmTHziDzjbUV38ZQlPP0vYBBQ9HEO9WUZOVly6h9IOzyQFZwYWr1EocZsBD/s=
X-Received: by 2002:a17:90b:1d81:b0:313:352f:6620 with SMTP id
 98e67ed59e1d1-313f1be63ebmr11625600a91.4.1750054781641; Sun, 15 Jun 2025
 23:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250614224422.1595301-1-kshk@linux.ibm.com>
In-Reply-To: <20250614224422.1595301-1-kshk@linux.ibm.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 16 Jun 2025 08:19:04 +0200
X-Gm-Features: AX0GCFu8JHjpVkd0MFHMXsbbhes1RZ64ZVWpvGrqdHAaPNLZYsA7uT_dsAImB4Q
Message-ID: <CAJaqyWcPHdEsQMLHUyZ6MYMtppwiPBgmJP9JzQrppL8k5rPnCA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Allow VDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: jasowang@redhat.com, akihiko.odaki@daynix.com, qemu-devel@nongnu.org, 
 mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jun 15, 2025 at 12:46=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> "unable to start vhost net: 5: falling back on userspace virtio", and
> VDPA became disabled.
>
> Convert the VLAN ID to LE before putting it into virtio queue.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Good catch! You should add the Fixes: tag though :). With that,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..99c9eb42b9 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1173,9 +1173,10 @@ static int vhost_vdpa_net_load_single_vlan(VhostVD=
PAState *s,
>                                             struct iovec *in_cursor,
>                                             uint16_t vid)
>  {
> +    __le16 vid_le =3D cpu_to_le16(vid);
>      const struct iovec data =3D {
> -        .iov_base =3D &vid,
> -        .iov_len =3D sizeof(vid),
> +        .iov_base =3D &vid_le,
> +        .iov_len =3D sizeof(vid_le),
>      };
>      ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>                                          VIRTIO_NET_CTRL_VLAN,
> --
> 2.34.1
>
>


