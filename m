Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2018C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 05:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSSG-00048d-6d; Wed, 23 Jul 2025 01:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSS9-000467-Th
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSS8-0004oZ-3M
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753250141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfT2ixur2F+G8Mjf/H6rffvvtGU7ZQKVvqnVVnpVwXM=;
 b=bppe+UKoJu+DRIYJMhDLZ/u+CUzePpnLG/4zIz5PEts0YJF0JgnRlDVnmrWbCWN909ZGNV
 10sdb4JcvV4I06e6NWpbn6NAvzMcctT1AqjvF2s8QiMP4zo/wJ2ZH5HWNmct0azZwV17uO
 iy39LqtGQpZ9GOjgcC2R0T/o/Od3IMs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-EiV8t6s0P_Kx0_sTWQKZlg-1; Wed, 23 Jul 2025 01:55:39 -0400
X-MC-Unique: EiV8t6s0P_Kx0_sTWQKZlg-1
X-Mimecast-MFC-AGG-ID: EiV8t6s0P_Kx0_sTWQKZlg_1753250138
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-313f702d37fso6854037a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 22:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753250138; x=1753854938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfT2ixur2F+G8Mjf/H6rffvvtGU7ZQKVvqnVVnpVwXM=;
 b=SF0336/qHWHtV3qFfYee4q8cl2wn/mvVQeGwfnXFsp//5Uf7XuWekHO9GwAJUcaO2y
 91Ea1mN+QcCN4KNTzkR6kKDfOnIohfo65pLh9ZxQlgxYePJavwQUKhsi5wTDboA6M1+W
 eYw9Ui5V3NMlwoyZG0Wfl3Jt/cpfBcikbFDNXztrgLaTnkCtSrfmtuG7jnosGT322sEV
 XM2GCO/3h9BMQqlSY1w1aWADkK/XAU4pRSXWNXP5iEuY9Gb/dTEjuk2US1rqu0DAcpQS
 EgWKeR2bw90gUfbTaqUrOURQ0EId+gPmkVufTdeVu5G18qeAaTNQ97g/JsQFTPtv6O3B
 viHQ==
X-Gm-Message-State: AOJu0YyQJZfSToL3Sg8+wBC0Zll1czPPWjtykyTqVOFUaEMtqPsOc85C
 At0Rnys34QRgzYc1x9j35MAoOLhg8bZPS3B9m83A1Tjn/sKzapZG37dBZRX08kP6VCYUxrBVib9
 RqeWc8tcURDLhH8LGmlp65azskZ7hqY6z5sxcsVQFQcZa6GtJyTh+mqCCbNPtOEvfxMiL5PfAqY
 6N05TDd5jPhl5lZqGSSqeEjoy4ai3pczQ3nwZFuvKZXQ==
X-Gm-Gg: ASbGncuVtrdOyiMf+2JlTPtXl5u4Ra5gzFXkRj8s8pJzDWuGhtVKAAqYkEaXkeIqJTZ
 PiLNVmBYj53BW9VQa2FL5Y71YDfDivLWGdZxRVn3lApkwOisB2qkx1/oJN92gCbR1wMMK5g1ZhV
 W2Xz9ZIrhFhVgne5cK3Qc=
X-Received: by 2002:a17:90a:ec83:b0:31e:3b27:98e5 with SMTP id
 98e67ed59e1d1-31e5082cb45mr2289918a91.25.1753250137731; 
 Tue, 22 Jul 2025 22:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1TAFL9LcBFRJWHFDyIojswiF6NOjIBSLQQv9KV1nlaHWRyVbQD0VAU7h5wxURiQnakVDWEsGuzYvKLZei3mc=
X-Received: by 2002:a17:90a:ec83:b0:31e:3b27:98e5 with SMTP id
 98e67ed59e1d1-31e5082cb45mr2289896a91.25.1753250137350; Tue, 22 Jul 2025
 22:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250721150208.2409779-1-jonah.palmer@oracle.com>
In-Reply-To: <20250721150208.2409779-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:55:26 +0800
X-Gm-Features: Ac12FXwkQbI2AaQR68n7Pk-6_tv-K_x_ufZBQ_AtkAE9kOCyUFzcdf1y0QeIGOc
Message-ID: <CACGkMEvZVME7xzuhsgd_SxR=8YqXvKWrMR1GG+Q2p50rd5C=ug@mail.gmail.com>
Subject: Re: [PATCH] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, terrynini38514@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 21, 2025 at 11:02=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
> Commit b44135daa372 introduced virtqueue_ordered_fill for
> VIRTIO_F_IN_ORDER support but had a few issues:
>
> * Conditional while loop used 'steps <=3D max_steps' but should've been
>   'steps < max_steps' since reaching steps =3D=3D max_steps would indicat=
e
>   that we didn't find an element, which is an error. Without this
>   change, the code would attempt to read invalid data at an index
>   outside of our search range.
>
> * Incremented 'steps' using the next chain's ndescs instead of the
>   current one.
>
> This patch corrects the loop bounds and synchronizes 'steps' and index
> increments.
>
> We also add a defensive sanity check against malicious or invalid
> descriptor counts to avoid a potential infinite loop and DoS.
>
> Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER =
support")
> Reported-by: terrynini <terrynini38514@gmail.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


