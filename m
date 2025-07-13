Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFF1C83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 20:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub3gu-0004fO-H8; Sun, 13 Jul 2025 16:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ub3dX-0001nc-FS
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 16:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ub3dV-0004QW-MT
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 16:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752439764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8ZYzKLA7K4mesVMPsgbZnt6RT8hPUKxpOMn8d9UTUM=;
 b=aoRUxaV4tZfPPXscsS57e1cWkZdlv6uh6R9zl3y0eZqwYoE8yIlLhEriWBxZyRgnxwYb1c
 PW0YHdkq3OrGkAJ+Pc3CyrUlqnWtJqRogybfxEUy+oTEHZB6v9H39ES8jIZh51lI/swP8j
 0D4phQiFaijJgtNKCd8xYW2ToVaZgP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-J6HfCXvzOImZA4HWso_wNg-1; Sun, 13 Jul 2025 16:49:22 -0400
X-MC-Unique: J6HfCXvzOImZA4HWso_wNg-1
X-Mimecast-MFC-AGG-ID: J6HfCXvzOImZA4HWso_wNg_1752439761
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2314186f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 13:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752439761; x=1753044561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8ZYzKLA7K4mesVMPsgbZnt6RT8hPUKxpOMn8d9UTUM=;
 b=GDMOvcfVgvKMjdMgm7ayXRcjW9txBWM3PyaC1bd/SQ8C7nWY0EirphSEOxQvVIxXx/
 2+uM+0Ho4hK+z8cM9C7ngQLiCaGHo5y2+dMV+FND0dk1mDnMcCmbiN4vrB9hHcSiyw6L
 9ZXwpefhvxjMXOgytXWebGJGQmd9rjWC5YWJo4hnKIe0dBMImhtUVy5d4pjkmNCsXdOw
 zSx6hBueQj1LPn4cx06AMUWSHsysKlWzgL4ZJr4y3Qt2yV85/6TgN6MYm+ldk2w7gM6G
 ymKcC4odtTkgm+beZzwHeZRgZPvlXj8Ha4Ac04SCa4LDmkjol8tc8Oal4PoB0J2VK+0l
 pOpA==
X-Gm-Message-State: AOJu0Yzk2M7MboqoahzpeX8DcJ+WR/g1ijxoYDIZRk/0DO8hi139IS4L
 BRMwwHjb7ylzZa7QddbB76I6QlGLL5eyfaS808HkpD6VVewScF0HlGSx9OT/4RIc5To1RXHHpvB
 Dpl/qJ2z7WBcmkYtT2CDRqHCQCR7JYQsQykvcJ0Y9oM5N4sWqAD2aX9Qr
X-Gm-Gg: ASbGncuCPbjjDv2FYGfMJ9oAt9zOv20E3KaYkJPYjsSh2+li6iQY4sqpVK44uO355PJ
 GfkKVBMRnlYdw92hGHIfhLKyrZrJK38h9Qv0bNg5+39IVxK8lMzmryddb6DAuu8ZkIibM9t8ud5
 j/mmijm5/z8UIt8av6wScVdJotyurJxD/Oa2Gi9EIFR6APpahcUq6QAfNcz6rds8z67OiRg9xec
 EBlzVkBOboz4ZIrv+fEYKDAT1WjrGMss19X1hDUrtgferkE/j9hahnSf8ZN+wX15cdz9YSoJ/hh
 v1oBgILxSRLfxZRCTQM1x/fOeGJKwWcY
X-Received: by 2002:a05:6000:220e:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3b5f1e87183mr10396149f8f.14.1752439760983; 
 Sun, 13 Jul 2025 13:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEooS0pgd/SFPSqdOYasK98/5+jZcSs+HOxZvW5D+NWGTWEI1JwwIHwJTLPcRd7eVM9Eej8Ag==
X-Received: by 2002:a05:6000:220e:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3b5f1e87183mr10396138f8f.14.1752439760572; 
 Sun, 13 Jul 2025 13:49:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd15bfsm10788512f8f.19.2025.07.13.13.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jul 2025 13:49:20 -0700 (PDT)
Date: Sun, 13 Jul 2025 16:49:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rajesh Mudimadugula <rmudimadugul@marvell.com>
Cc: qemu-devel@nongnu.org, pizhenwei@bytedance.com,
	gmuthukrishn@marvell.com
Subject: Re: [PATCH] vhost-user: enable asym capabilities for user backend
Message-ID: <20250713164654-mutt-send-email-mst@kernel.org>
References: <20250626122451.908205-1-rmudimadugul@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626122451.908205-1-rmudimadugul@marvell.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 26, 2025 at 12:24:51PM +0000, Rajesh Mudimadugula wrote:
> This patch enables and advertises asym capabilties
> for backend user application.
> 
> Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>

You want to CC all maintainers really.
The commit log also should include motivation for each change,
not just repeat what the patch does.
As a nit, format it using an imperative mood:
"...enable and advertise..."

> ---
>  backends/cryptodev-vhost-user.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index cb04e68b02..f9dec14a4a 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -230,6 +230,9 @@ static void cryptodev_vhost_user_init(
>      backend->conf.max_size = UINT64_MAX;
>      backend->conf.max_cipher_key_len = VHOST_USER_MAX_CIPHER_KEY_LEN;
>      backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
> +    backend->conf.crypto_services |=
> +	    1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_AKCIPHER;
> +    backend->conf.akcipher_algo = 1u << VIRTIO_CRYPTO_AKCIPHER_RSA;
>  }
>  
>  static int64_t cryptodev_vhost_user_crypto_create_session(
> -- 
> 2.34.1


