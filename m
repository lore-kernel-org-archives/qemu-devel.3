Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63331C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkiH-0003At-Ie; Tue, 02 Jul 2024 17:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOki3-00034h-QW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOki2-0007tr-Ac
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719954401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIX6tWJ59X+n4k7MVT9QALRA2G5dp1pBVKAs5eFuyo8=;
 b=WCB/8AbNUrvcMEZnXdv9iQg8ANETENdLYjlRkgH4mwN8pMZK/AwoWR0PfpJPkAvOekeg5Y
 IAeIspGYJ9pSkvykyTZSRELxlNfiC7BrvqVZJvihMUy4C/DuwtgjGXCPp0QU1E2y2u7YcP
 G7Ti9zwpIR7cnkVyx3BpV1Fm573l1MQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-NJ1zyvENOECJYKD5k8kPZA-1; Tue, 02 Jul 2024 17:06:40 -0400
X-MC-Unique: NJ1zyvENOECJYKD5k8kPZA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52ce42bb0efso5535664e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719954398; x=1720559198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIX6tWJ59X+n4k7MVT9QALRA2G5dp1pBVKAs5eFuyo8=;
 b=pv3pxSd7gQbNWr40H0PZn8+StEMZ0duK3ElxTCM3fcK9Ooo0Dzpgk+62SLP288NS5j
 u5AlKgF8rHiAlm7vHHYx/Pb/4Kl0CDvfHrFYoNb6VxbwE/3ap2cV5XnGcy+XUD/+mNPr
 i6dIwkhsEE4CW/SrL8W6bG18qqzTA9T8Rbiq2jk20S3Phj7gTHwDn87kK6esbBmWYBUL
 Frskp3uCqC53ymgRtxQoHreXoYSmDRdCBHE+Pw6Ch9CWmrBqqcfxW0HLsZsCoQlJ8pZS
 49H7zHOR9IiUFs45qoMmmhOLHwsSKLUnRq5mncJ4R4gkekfHXhVYBwDtdCF4msS4KT9x
 8hKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2jQr9eNbb/mZvNZFy0lovpbKlQPDitY0C0TOJcfkaJCRYAMwcjUIrJm2xqlIGQqXH9armWuQkwuOkRbzZ/svEjCrJPuI=
X-Gm-Message-State: AOJu0Yx4jXUBzLfHV9iyy0UHXe4aHOPSTv4JpJdxbH/n5fNgpQH8N1FR
 +Iy+QRI/vsNWG9rG/fqXyBWJDoEwltIUHo7fF+JyP1FQX0axVooMBfQ1FWRlbF4es3NQL+iGtlh
 bP5xQdxF6IjjHd79CoaNAvbISbqIv1uXhkcnUq2VuSRu5YXSqHtBji9kX0JZw
X-Received: by 2002:a05:6512:3094:b0:52c:de76:109a with SMTP id
 2adb3069b0e04-52e82740e56mr5574443e87.67.1719954397909; 
 Tue, 02 Jul 2024 14:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi9cSw2xvR10EnLjeviC+xQTJK7VbdZjHkFe0aOuEC4B35F1kck49Rjt5oPbC1yC2xJ/6C4Q==
X-Received: by 2002:a05:6512:3094:b0:52c:de76:109a with SMTP id
 2adb3069b0e04-52e82740e56mr5574430e87.67.1719954397299; 
 Tue, 02 Jul 2024 14:06:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257a4d4cd1sm148672155e9.28.2024.07.02.14.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:06:36 -0700 (PDT)
Date: Tue, 2 Jul 2024 17:06:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Message-ID: <20240702170606-mutt-send-email-mst@kernel.org>
References: <20240702210519.3061098-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702210519.3061098-1-zheyuma97@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Tue, Jul 02, 2024 at 11:05:19PM +0200, Zheyu Ma wrote:
> The assignment of the op_code in the virtio_crypto_create_asym_session
> function was moved before its usage to ensure it is correctly set.
> Previously, if the function failed during the key_len check, the op_code
> did not have a proper value, causing virtio_crypto_free_create_session_req
> to not free the memory correctly, leading to a memory leak.
> 
> By setting the op_code before performing any checks, we ensure that
> virtio_crypto_free_create_session_req has the correct context to
> perform cleanup operations properly, thus preventing memory leaks.
> 
> ASAN log:
> ==3055068==ERROR: LeakSanitizer: detected memory leaks
> Direct leak of 512 byte(s) in 1 object(s) allocated from:
>     #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
>     #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
>     #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
>     #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
>     #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

see my comments on v1.

> ---
> Changes in v2:
> - Fix the whitespace in title
> ---
>  hw/virtio/virtio-crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index bbe8aa4b99..5034768bff 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>      int queue_index;
>      uint32_t algo, keytype, keylen;
>  
> +    sreq->info.op_code = opcode;
>      algo = ldl_le_p(&sess_req->para.algo);
>      keytype = ldl_le_p(&sess_req->para.keytype);
>      keylen = ldl_le_p(&sess_req->para.keylen);
> @@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>          iov_discard_front(&iov, &out_num, keylen);
>      }
>  
> -    sreq->info.op_code = opcode;
>      asym_info = &sreq->info.u.asym_sess_info;
>      asym_info->algo = algo;
>      asym_info->keytype = keytype;
> -- 
> 2.34.1


