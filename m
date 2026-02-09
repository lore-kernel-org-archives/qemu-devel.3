Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A927EF06FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGP3-0004WW-WE; Sun, 08 Feb 2026 20:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vpGOy-0004Vj-BY
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vpGOw-0001gS-CS
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770601760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14sw+gLnbsHiefhe3UX5Ly7725j/80iS7H2BfjOY6pE=;
 b=ArxORfwtEQ1wz6IGKaBXTMlz9HX2HvS2xFPzVZdqaS2DnJml7Gs7fpzakxymVALAagl2Wm
 8XG1XjKZlAu8bSfn0ogfMmAbUAcyOYLp6ga8bETR+h5TLFmHL4BUtWJYvjkxa9YeWP3P4U
 Yb8PDQ4ndcew5I/JEKFhHTOJTT/QabY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-XqCk56HJPY6uTZtaqQsNSA-1; Sun, 08 Feb 2026 20:49:18 -0500
X-MC-Unique: XqCk56HJPY6uTZtaqQsNSA-1
X-Mimecast-MFC-AGG-ID: XqCk56HJPY6uTZtaqQsNSA_1770601758
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aad5fc5b2fso11363725ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 17:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770601758; cv=none;
 d=google.com; s=arc-20240605;
 b=NdZouDTV0cz1dq4UzduXO+/3m8ULVCjiZcQfTnKNQ6H4GurZXSvlX4M14rMS9ZzEEz
 +cPe7WydNs5zjIYbph/68vkRwhLm8dVVcrk8JJ8SXxjvcNjhG9FJ1Bmo9H7YIbLrkz6u
 Q/Gy/BXgUfQtYwD+vzbOW4uuUeCehH6DlWyoChFfCLxAd+mA+s9K3azV5zPbx1zQESqh
 kFQVaXIJ5YtrwUP2Nx9nrlitg6uRZLl2IRTk1z0JLhZNYk/h2TKlqm1iJr60scr09Kwo
 l30+yYDjFhRDXoXXMKdQE0pgX1n08T9u13OoRAhfdMlOCR5o+tJGw9Oh08VMekgTLFvz
 WW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=14sw+gLnbsHiefhe3UX5Ly7725j/80iS7H2BfjOY6pE=;
 fh=TzlxEy2HuEtAvF+bWYq547L+o+OnXmfmR26ssWCq6Gw=;
 b=eBFIzonuHZhckwiDqUGY7iAQcQQL6ypxaJQZvpJpSeMCICGThCIUZQpFHW6KSu9Fj7
 2kLdKqIAawygQBcUiHjwiP5tQc0j1SFhX/Il+BAdt4WmqFP5D6LnkHVmvSqHg+Zt6fXX
 7imc3nTb5YmoZNItAnXTpVNr5iz+WElBZ6gKFjxWuMRAed1jLYBGvJbDFtR0TjIxwqqn
 mkE9xHM6fGEHwbdFaQXeYHOGMLALQCH5htJ3NolMCS/NSh4aTb3qcedLXHF3YFpiUnWq
 Sq0uooTUJg5zIyneNo0166LnxOcWFvn/tkHiAJ0rFog6sip/s43bESUp1DU7bn5Z9/vS
 hjIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770601758; x=1771206558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14sw+gLnbsHiefhe3UX5Ly7725j/80iS7H2BfjOY6pE=;
 b=N7uvlVCGbgyw7kgnqO6CHzYpiSEvGSVmmB1jyE/XTsZzHRlxtjBx2hgHc0r4z0W5uT
 eggFQr3LSUObxNMK8xeVvqpdPyQ+Heib4AGlU8GimFUdufMeSYjhrSyg3EIuP56H58Tj
 3NuABEYWVzPeJUwodxhWxTJK59DHVXbro1VfDtHtP+C1Mt+1tQyFHgRWtsga7RAOs8oU
 h/5vv5dJMuTEtB6/LB+6PzUSDPtG2PDbLqtXv1eswUF9wBrMv+DRQCYLJGreTzgLnZLn
 FuSVS3XyCQqsSvJLPqHNrg+md9xwFRPBOl4i70BePs36bQeE+28Qqs6EOWQepEf/sYRg
 TxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770601758; x=1771206558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=14sw+gLnbsHiefhe3UX5Ly7725j/80iS7H2BfjOY6pE=;
 b=f8gyPjutYLW0bsYcZMnGvc6ciNbWarGoPU561kXI2ptFo4lHTyGRDYRVbT4Ohxejlr
 0hOA2LBFkJm4Cet+MSX1UrtER5ZJ3+TDykyv/wOalll7kqHZv2nh/p8cUDQeKWG9dFlS
 4WmFRaSzmqAi544dE8dy0ENaylY6Z+4l4PJnniOOWXCCL4ev54yzRsuHdXEFKTR9L1w5
 It02joQIZnIm5tXHkQEPzRBxy3IZLgNGcvNmMZkBn218M++CVInVSQ1qP0IbpmARN+DQ
 zfbR9Ef7OyIo56UWYYAyeJzG2+ShgZc+BiZpkPaARhoJKzoUGo0IZW2tUrCwomGAJhjv
 gDKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX++/uOksI6jQyDe7Hp0GxjJNkXztTE9zKuJcfsc8RgQlfP/wAE5MMt+bD3TWscy9KCsUrszsCAt6Yz@nongnu.org
X-Gm-Message-State: AOJu0YxmSa5bcsINl7jDGbO6utAu7UYQdsYIhcCDRgudjDcB/LIWkzU4
 XgvE/GFTJDyPQQjV6oulw1GyaqgRhV2uAhtHiX0hCQZwoIbPIkV8SGkjaT+HE+yjKfk0G0BUcH+
 sgTb8yYHR+xhXJOsdmUIhoMYy4FlSOqG5RiAJQzhujYzhYPPonvHxaNZR119CjSvuWKCCR5YuIc
 hr4nfuIH3YPkyFj/1Jh9ZyIIm6QxYW5SE=
X-Gm-Gg: AZuq6aIzEf6l+EKycxVkPJ/B5ngvFAynGhJ78o66MKQQBdiOOgmCAAly3mwqr6zHtAR
 86qQSNQBD/6F33WFYvfgf+bFczb2Kjlqixb8mjKDuqhWe7tjah9i9Qsau6epWLeLjFt/IyRBCUN
 reuV6QVLeY5TINtJA3mLvTNdMqZrL6l++B9531yqTkJj3FE8Bm7jCiFywA2LjncGgBdpQ=
X-Received: by 2002:a17:903:1d1:b0:2aa:e6c8:2c6e with SMTP id
 d9443c01a7336-2aae6c82f70mr19173115ad.56.1770601757676; 
 Sun, 08 Feb 2026 17:49:17 -0800 (PST)
X-Received: by 2002:a17:903:1d1:b0:2aa:e6c8:2c6e with SMTP id
 d9443c01a7336-2aae6c82f70mr19172905ad.56.1770601757235; Sun, 08 Feb 2026
 17:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20260207134728.1495932-1-lulu@redhat.com>
 <20260207134728.1495932-9-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Feb 2026 09:49:05 +0800
X-Gm-Features: AZwV_QjOGQB93LQH7OHP6iC-ObpXBqWfP57M0t0ZIdzpSIsLj3bZ6QvWKP5cEYs
Message-ID: <CACGkMEuP19cndgGqnmT8_CzvnduwCx7sOFRNMtoXQQWS8hyQ0w@mail.gmail.com>
Subject: Re: [PATCH 09/12] net/filter-mirror: treat redirector injections as
 raw frames
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 7, 2026 at 9:49=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Packets injected from the redirector chardev are raw Ethernet frames with=
out a
> vnet_hdr prefix.

This may not be true as it could be the traffic from a remote
redirector that is redirecting virtio-net traffic?

Thanks

> Mark them as RAW so downstream filters (e.g. dump) do not skip
> vnet_hdr_len bytes, and strip the vnet_hdr prefix only when vnet_hdr_supp=
ort is
> enabled and a valid prefix is present.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  net/filter-mirror.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index c1b9dabacd..de32028246 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -146,6 +146,7 @@ static int filter_send(MirrorState *s,
>  }
>
>  static void redirector_to_filter(NetFilterState *nf,
> +                                 unsigned flags,
>                                   const uint8_t *buf,
>                                   int len)
>  {
> @@ -156,13 +157,13 @@ static void redirector_to_filter(NetFilterState *nf=
,
>
>      if (nf->direction =3D=3D NET_FILTER_DIRECTION_ALL ||
>          nf->direction =3D=3D NET_FILTER_DIRECTION_TX) {
> -        qemu_netfilter_pass_to_next(nf->netdev, 0, &iov, 1, nf);
> +        qemu_netfilter_pass_to_next(nf->netdev, flags, &iov, 1, nf);
>      }
>
>      if (nf->direction =3D=3D NET_FILTER_DIRECTION_ALL ||
>          nf->direction =3D=3D NET_FILTER_DIRECTION_RX) {
> -        qemu_netfilter_pass_to_next(nf->netdev->peer, 0, &iov, 1, nf);
> -     }
> +        qemu_netfilter_pass_to_next(nf->netdev->peer, flags, &iov, 1, nf=
);
> +    }
>  }
>
>  static int redirector_chr_can_read(void *opaque)
> @@ -294,12 +295,31 @@ static void redirector_rs_finalize(SocketReadState =
*rs)
>  {
>      MirrorState *s =3D container_of(rs, MirrorState, rs);
>      NetFilterState *nf =3D NETFILTER(s);
> +    const uint8_t *buf =3D rs->buf;
> +    int len =3D rs->packet_len;
>
>      /* Update indev statistics */
>      s->indev_packets++;
> -    s->indev_bytes +=3D rs->packet_len;
> +    s->indev_bytes +=3D len;
> +
> +    /*
> +     * If the sender enables vnet_hdr_support, received data includes a
> +     * vnet_hdr prefix. Skip vnet_hdr_len bytes and pass the Ethernet fr=
ame.
> +     */
> +    if (s->vnet_hdr) {
> +        if (rs->vnet_hdr_len <=3D 0 || rs->vnet_hdr_len >=3D len) {
> +            return;
> +        }
> +        buf +=3D rs->vnet_hdr_len;
> +        len -=3D rs->vnet_hdr_len;
> +    }
>
> -    redirector_to_filter(nf, rs->buf, rs->packet_len);
> +    /*
> +     * Packets injected from the chardev are raw Ethernet frames without=
 a
> +     * vnet_hdr prefix. Mark them as RAW so downstream filters (e.g. dum=
p)
> +     * won't try to skip a vnet_hdr_len.
> +     */
> +    redirector_to_filter(nf, QEMU_NET_PACKET_FLAG_RAW, buf, len);
>  }
>
>  static void filter_redirector_vm_state_change(void *opaque, bool running=
,
> --
> 2.52.0
>


