Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BD1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGKg-0000tx-6B; Mon, 14 Jul 2025 06:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGIR-0007pP-MI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGIP-0003Cg-3m
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752488424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E0azYcePAbakMh5QHAj2Mr2wTej/PKdxS+kiv/J/+DA=;
 b=QOwbY4kC9/LPLIR3wBsNJsrABKLapzDXjZG7HCRtF2Iv+YgYtDAHucFRh67DnfD+/tyCsF
 xbX+2/4sz9BkQsD3jO6ntXeU1wg2Ys8eZXTEr7+Tiw7FEVAbHUssPCSaKUeonf5BnxIK7R
 kqhlLLibxYdY30iz5VpEsMguuxKBqqI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-EJ182u2TMJa1ZDXZy5za1g-1; Mon, 14 Jul 2025 06:20:22 -0400
X-MC-Unique: EJ182u2TMJa1ZDXZy5za1g-1
X-Mimecast-MFC-AGG-ID: EJ182u2TMJa1ZDXZy5za1g_1752488422
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-711a46ce053so61878967b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488422; x=1753093222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E0azYcePAbakMh5QHAj2Mr2wTej/PKdxS+kiv/J/+DA=;
 b=WK72ezM5/rKt04agplHcBS5Vm8v+WFlz/0VSInmJ/77DtBRKinYDMsb+7mxZ13edOx
 Pq/5m92yhX1P9UQMWyffXbiitmSsif/Q0f71yRpANCkpYmykm4ifNELBMmSG9lbfDsl/
 WkTLZMuyY9VM8zlv1r57sCO/MXnATGjJpGer9pXacwWD+GJLWmXkTQA6HMqxuYvCzfs4
 tklYi8O2jslBwRRkW+NcQdJ5P9oY2FZ2lzWVgzrKbIIwbZ4dVpZmo8+GU4gVSHVFvvct
 0s0sFEJjdO5XepFdMrPM3cYMnPzCRsUzmkxrNWjCrs7KTbt4XiLKXeXpDXh2Uo5LJszx
 ZHPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0KvXJMHKtceIaTlDf16RVdnLuyNK2PxFogaRpJZsjZCX/QOLYhRZAftmfbtOYCabIsQHuyUvLq6gA@nongnu.org
X-Gm-Message-State: AOJu0Yxnb/OI1jteDzjZihvGoFy4/F0Nq0dB+WyAfh/Zr4SICI5HsoKH
 n6bsSvOPbi4A5hhSjMhz2jNRyP5t5xjHeEp0dv1RFpoV8i2K8LLI10I8w289+TZFdA+BmQ6czTo
 sTSUQ2ZpRFFsAOTFwjm6ZzifjiNXzejQ4E5/7BKKIf1QO7f3oYlLiuA6bOwXluS/tktOtfASLMN
 cFIa9RmNa4zwIWOvbjAqV9ayJk7FQ6vnE=
X-Gm-Gg: ASbGncs3o5Ib6gLL9By4yPDTW0Jpq9hBKZGACy4baXfEIkdHl5UgKO+ML6nN1INXzRH
 rpmr2Gz1qh7uykIGo9IGNB1vmsZqR0HnjdjqmvSNJqNaxbuBhkIVN4RYZkrndIpJunAIfXvUou5
 zsQtY3dUuXniRT2/2SJtFLbA==
X-Received: by 2002:a05:690c:46c8:b0:708:f6d:b79f with SMTP id
 00721157ae682-717d7a19ccamr166008937b3.29.1752488421613; 
 Mon, 14 Jul 2025 03:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBSIqPWmpi82MOz/Z57naw13N4H0Y5S5O4LpQmMH9gQMWFBW2QiMc+8p47FBUnCcLcW07yX8Rl5KBMBKJfOJY=
X-Received: by 2002:a05:690c:46c8:b0:708:f6d:b79f with SMTP id
 00721157ae682-717d7a19ccamr166008557b3.29.1752488421037; Mon, 14 Jul 2025
 03:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
 <20250710123945-mutt-send-email-mst@kernel.org>
 <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
In-Reply-To: <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 14 Jul 2025 12:20:09 +0200
X-Gm-Features: Ac12FXxQDkmD6qqKbeHGplaaL2CLFWfeIIqJ_jM_Kl9X03vuhPeUNAyHmQq9Gbs
Message-ID: <CAGxU2F5WV65ztZZUcrM2Vu_hsw7Pn8O9kRh+0TexBTy2UMS0hA@mail.gmail.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 14 Jul 2025 at 11:18, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Jul 10, 2025 at 12:40:43PM -0400, Michael S. Tsirkin wrote:
> >On Thu, Jul 10, 2025 at 04:46:34PM +0100, Peter Maydell wrote:
> >> Hi; Coverity complains about a potential filedescriptor leak in
> >> net/vhost-vdpa.c:net_init_vhost_vdpa(). This is CID 1490785.
> >>
> >> Specifically, in this function we do:
> >>     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
> >>                                                  &has_cvq, errp);
> >>     if (queue_pairs < 0) {
> >>         [exit with failure]
> >>     }
> >>     ...
> >>     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
> >>     for (i = 0; i < queue_pairs; i++) {
> >>        ...
> >>        ncs[i] = net_vhost_vdpa_init(..., vdpa_device_fd, ...)
> >>        ...
> >>     }
> >>     if (has_cvq) {
> >>        ...
> >>        nc = net_host_vdpa_init(..., vdpa_device_fd, ...)
> >>        ...
> >>     }
> >>
> >> So if queue_pairs is zero we will malloc(0) which seems dubious;
> >> and if queue_pairs is zero and has_cvq is false then the init
> >> function will exit success without ever calling net_vhost_vdpa_init()
> >> and it will leak the vdpa_device_fd.
> >>
> >> My guess is that queue_pairs == 0 should be an error, or possibly
> >> that (queue_pairs == 0 && !has_cvq) should be an error.
> >>
> >> Could somebody who knows more about this code tell me which, and
> >> perhaps produce a patch to make it handle that case?
> >
> >Historically queue_pairs == 0 was always same as 1, IIRC.
>
> Yep, also looking at vhost_vdpa_get_max_queue_pairs() it returns 1 if
> VIRTIO_NET_F_MQ is not negotiated, or what the device expose in the
> config space in the `max_virtqueue_pairs` field.
>
> In the spec we have:
>      The device MUST set max_virtqueue_pairs to between 1 and 0x8000
>      inclusive, if it offers VIRTIO_NET_F_MQ.
>
> So, IMHO we can just change the error check in this way:
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..8f39e5a983 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1813,7 +1813,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>
>       queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
>                                                    &has_cvq, errp);
> -    if (queue_pairs < 0) {
> +    if (queue_pairs <= 0) {
>           qemu_close(vdpa_device_fd);
>           return queue_pairs;
>       }
>
> I'll send a patch if no one complain.

Patch sent: https://lore.kernel.org/qemu-devel/20250714101156.30024-1-sgarzare@redhat.com

Thanks,
Stefano


