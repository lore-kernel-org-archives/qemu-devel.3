Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E04E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsofj-0003QN-MT; Wed, 18 Feb 2026 16:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsofC-0003MK-OS
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:01:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsofB-0001mo-3G
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:00:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so2542355e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771448447; x=1772053247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byzLFJAG0gfqLw9mZdAWAdg1jHv/y0bfDofgRWMGFaA=;
 b=Kx2dzMbobuujNuBs9BqXyyjpdyg3lvmDAed5nuTukMQIkXuwsOtK35xZS16EnYbN1Y
 WR1/1vGLlyeU4XlE1aiS9bnxbZHPe/Hz4Khw3I+TXYgwzSYoDvfei+ejot+ldCVPC/MP
 m1PuYeG7yZA7Xsl3EA281uXcuEQ1pLAcKHNCFIMNJQpS/d7OXzWEQLXluqum1vUq6VY3
 m9Hox1HcEDCWj7XNhayEmnGXLAjVYbZ7AbmT7Axp9nva1Y8FljQ5geTU0iu/WFxiqrEc
 is+YtnRdxsdsmIzhIVBikXez7Jn/croEc7lCUsJM5eqzj79+4ekFsJWFoiHa8TXgIOkt
 cU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771448447; x=1772053247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=byzLFJAG0gfqLw9mZdAWAdg1jHv/y0bfDofgRWMGFaA=;
 b=WoMMmgJ/O/FmEPMz+hERavjQ+ZojQck0qaiEyHxb2OrLmiw/wg4PVza7CWu11cY5el
 jMGLIc8HucGaKkAQrf6OEHAOE3bJf7WzPmhHLBR1dEvNnCp2QBJEnd61dn5ghTHF8oPt
 xuBD9hmciqbpT1LJqNP4qYGDEtMVUJsE+B/ZHeW5L+y3NC6sS0iHRhccRh2lH7zWCCEd
 IXPzQqWOf3xuOdYkYAiuQIY+p/DK/k7vUBOZQeMJLhKnYqlQ5bVW6yw66lO24CtQpbYc
 gKw3oxp+TZs6a4LFMQhiKDoMFjmj4gE3F30DKTH+2MigO/wGCzQmZuqchqFD1lUYfpDZ
 RHPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI0g3td+xL9vuSVIjw7zd+hOS0FXXb9nC8YYxNUzKHBN3dxSQSr8pMWGcCpIO5KzkFhdMqzDh0EKp2@nongnu.org
X-Gm-Message-State: AOJu0Yynd0O8Z7w3iu9fqpZefAH8GOfWMjLNyTkWfIzuqF5mCvMqohZP
 XvswJW+J6rwHPb6UZlRZYiqc5124bEytYVy/xShW9SxlP1lmlK7y7Q510G8rjIiwYbs=
X-Gm-Gg: AZuq6aK6Tig8c/vNjLJKlTNUeGzPa0VXn9+ggk1kid5z51cC9bAghV6H87IZBCw8ppO
 fefmS8dWOXwOt2wM6SgdKGnd5GIQ6D+HPWlPmNGn9aahnFHm4oUyLgaG39YatsBdPi/vMFhsXcH
 isTNsIGzF6Rb+2YH7OxUFk0jktIl6gi6d83Xy5I8plAOZvEiH1ZLGwroltzGWPiznSzqXht30VA
 q75x0iusm6TlOe/Hffi3EfrM6ViUAfExwYjkzVzevgXSF+itYRSAGTQBeCklY03BCwHrIE7pKJJ
 f7FXZXx+fSeMsUJr2tqaLAitjHjYk2SxC53Y1ev6BJQdwLOyDqnzcJx1thUEMzmOUfIupfia4tt
 sb6gzxgjD42t8ffu441pR2Hsc4uKiB6Q+UrT3NIv4YAbmMeRHGOiKLgO/l8FR/fmmkz24ALtSfr
 7mBKRP7n4tizFpQrnSL3ppzAOxRuR07uJsuv0dcExWQvTpvAz3AaL37ozuk3ew9AXJwQ==
X-Received: by 2002:a05:600c:83c6:b0:483:6f82:9719 with SMTP id
 5b1f17b1804b1-4839e6370d5mr5824175e9.2.1771448447292; 
 Wed, 18 Feb 2026 13:00:47 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm833014615e9.6.2026.02.18.13.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 13:00:46 -0800 (PST)
Message-ID: <02b667c5-da6a-4829-87f1-4b9ebc53d5a4@linaro.org>
Date: Wed, 18 Feb 2026 22:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212234602.338131-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 13/2/26 00:46, Pierrick Bouvier wrote:
> This simplifies code compared to having
> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h |  3 +--
>   include/hw/virtio/virtio.h        | 12 +++++++++++-
>   hw/net/virtio-net.c               |  2 +-
>   hw/virtio/vhost.c                 |  2 +-
>   hw/virtio/virtio-pci.c            |  2 +-
>   hw/virtio/virtio.c                | 16 ++++++++--------
>   6 files changed, 23 insertions(+), 14 deletions(-)


> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27cd98d2fe1..8f1e4323599 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -468,9 +468,19 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
>       return virtio_has_feature(vdev->host_features, fbit);
>   }
>   
> +static inline bool virtio_vdev_is_modern(const VirtIODevice *vdev)
> +{
> +    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
> +}
> +
> +static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
> +{
> +    return !virtio_vdev_is_modern(vdev);
> +}

With retrospective, mentioning 'modern' was a mistake IMHO. But I
understand it was simpler to add 'modern' code without updating the
'legacy' code base. Today I'd rather have 'legacy' explicit in function
names, everything else being the normal / current / modern version,
without having to clarify it.

Thus back to this series I'd rather not introduce virtio_vdev_is_modern
and use !virtio_vdev_is_legacy instead.

