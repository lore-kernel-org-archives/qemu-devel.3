Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44043C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 02:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF2Df-0003pQ-6P; Tue, 13 May 2025 22:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uF2Db-0003lT-NF
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uF2Da-0001oG-1T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747191096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zN/+lU/jBzKzkoAs282f93FiHOE2f9+lilVoPHwFzbU=;
 b=gL7EXMXA4I2C57dSIFJf2ElcNc5OEDG5kHMCOlu/NO2jYjL4jK0t0Omi/qxjatjDc1EopA
 OfCkdRO+9xiOtSQJBpvUV3Fm6OxVzpmAPlVU4RgY+9xmbxkKHceg/LmKaDBbr9Ki5Vu2uw
 pcRdB19Vm2uzt9eadDBf+4BVqAo7TKU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-cSRnxBczMYSsM_7jktRFCw-1; Tue, 13 May 2025 22:51:34 -0400
X-MC-Unique: cSRnxBczMYSsM_7jktRFCw-1
X-Mimecast-MFC-AGG-ID: cSRnxBczMYSsM_7jktRFCw_1747191094
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30c54b40096so4666537a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 19:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747191093; x=1747795893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zN/+lU/jBzKzkoAs282f93FiHOE2f9+lilVoPHwFzbU=;
 b=oQICxXDntVmFD1UuCcKhtVFp6L487o6NSj7dz3702Zpip2c0UDFMYH8dZAzgZvKcHe
 1+n6+eQaIGXj+/MQ0zxjuoGRKbswJaf3t7yTj/zAAz1QLCM3DygxOGL43mNosCZaIPKJ
 SQXQQjoRwvmXn9f2nGM8rbW5Oxym9nRzaMxdaBGQd3sVSZcavXsHKQc6gq+RUAkwbtRv
 iVF8GB4ktVkkQdU4/1uasiJ5nLQbd88G8NJyGClRiFwy5X09BuBWlO2fFWAO2NLNHrMh
 ewiTP7bHb9gcIl0zSWak72fGRWc00BTF1kEtfpI0Pgutrm11ALH13kUjdbxO2492Ml5d
 BKZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdIS7bBpKajCDrCUoKIC66V0GzgjYp7Pt6HKQYS3nH4CQUlyv/qq63x8j+l1EHco9uLlOEGccLmugB@nongnu.org
X-Gm-Message-State: AOJu0YynfHzwsh+XDanraJKk6RpZ5fvBe/ubGjHAKQ3bR2QIjpmlqjQV
 WV3V0mUnLqHX3kvoy1mO/VkJXm6fwP2jiqzDC10gbs1AgK6Q3WBVkkjlP8anLDU4NJmMhHGKxBq
 q65AQve/wa6fOT9YwsXCZXb70ONBHaEEnUXgvYL+NEol8uwY5cf+SfkHGbE4cHLrYd5UCHhkRC5
 2S747ygsGe9IPJGhQnUoP6lxRIoxA=
X-Gm-Gg: ASbGnctD8WGjI2wDX6rc7hYv9iO4GddJMsoqHz3nmmYT3gNY90NUbnAmYQYVv05xOLk
 i8xEH1oIGVzWcDJqfuS4+QKCK8WHApoxLELJgT3bYHGNk8tw1/nC9PivKkDulXLHW4Hs3
X-Received: by 2002:a17:90b:5148:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30e2e642616mr3406361a91.33.1747191093607; 
 Tue, 13 May 2025 19:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Vnumb2av8E1DoKJ+g5yQsrHuwT4nMWW1HCD7v3uFLMoIgd4kh5lJiD4Go6157BjRfUYlnfVE9jojBwYbDoE=
X-Received: by 2002:a17:90b:5148:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30e2e642616mr3406319a91.33.1747191093105; Tue, 13 May 2025
 19:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
 <3fe33f8e-79c1-4757-8e06-f2aedd652222@tls.msk.ru>
In-Reply-To: <3fe33f8e-79c1-4757-8e06-f2aedd652222@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 May 2025 10:51:21 +0800
X-Gm-Features: AX0GCFtuqJ_UJ4b8oS86rU9Li_gWOl3GWXN4etDU6KbOL15NjkXbglxj7BWAexQ
Message-ID: <CACGkMEsN339U2xk21Z_OE0DLY9TRJOiPkrxRtBHg-BgDP_V6tw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Copy all for dhclient workaround
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 Antoine Damhet <adamhet@scaleway.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On Mon, May 12, 2025 at 6:11=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 05.04.2025 11:04, Akihiko Odaki wrote:
> > The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
> > buffer") was to remove the need to patch the (const) input buffer with =
a
> > recomputed UDP checksum by copying headers to a RW region and inject th=
e
> > checksum there. The patch computed the checksum only from the header
> > fields (missing the rest of the payload) producing an invalid one
> > and making guests fail to acquire a DHCP lease.
> >
> > Fix the issue by copying the entire packet instead of only copying the
> > headers.
> >
> > Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Ping?  Is this change still needed?

Yes, Michael asked for more details for the problem solved here. So
I'd expect there would be a respin here.

https://patchew.org/QEMU/20250424-reapply-v2-1-d0ba763ac782@daynix.com/

Thanks

>
> Thanks,
>
> /mjt
>


