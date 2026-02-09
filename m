Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80EDEF06E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJgr-0006fw-Pe; Mon, 09 Feb 2026 00:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJgf-0006dt-GI
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:19:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJgb-0001gg-5c
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:19:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a91215c158so26436895ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770614387; x=1771219187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3mSN19ZaVx+IggAFIzCn7W7MOwxjNXqB9OYJGrrCgKA=;
 b=olNj82lshiBiR47j/xZQGEB6+/ekP3VspwCKfm1meiiYBe5zSGDJOuTq6su9VzQNPi
 b+mdEpnvGLACD1YrkLEK+GzGgilcYHAVAkLGdH1flUurOp5V+agiXIAEOLXdtZg5G24T
 ikZF1vJqqPm6havziGkYqur8RYdkrK8b0uzGGsDOrVdc+CDz0S7SAaVoj95BOYjA1gkn
 7nuN3dSnmtjUW083Oz6ZkPrQbFCBlZMkma1S0gB/JEsRKG/Tp1lsU0lFNlLvXHoUJFjX
 Cjmb6vUfiXjYY1XjWs02G+RAmlJCSxGspQBToi1hu0iBZ2QX0oDpgpk/59PkQrGrWOHz
 6yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770614387; x=1771219187;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mSN19ZaVx+IggAFIzCn7W7MOwxjNXqB9OYJGrrCgKA=;
 b=jyiL2fAtsWppciKgvb8WsN9E+lBsTvDVp2BKQwwrQLoHsFerRCxpUEaeyXda+Qk5T9
 I+sHIHSAyvPfVXH6gqwB9xl0PnQ4eMU/LQ/7zw/QCat/yf2N4+5BeNRTLkWc+2vDF0ia
 9uMBLsMlDX1im1CmNZc61NIPmprI3C1wol/Eu4MxkKgVPZFY1DSgaB5vnb66oYj18k6j
 5Y2Pw5z6XyYKPbeGqAcYDZ7WTYtK03Mu2B8c+0BnaCQfZbUwgii7mUeSsFLY2XEiwyYV
 1PpyHDE5JW/K6RQXuZ9wrd8AdCQdJ+N+pEiw/9tdSGbZe0mMw6zqDsU7DNe9gEXLJp0Y
 BlDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZhHe0HgLUW7Y2QJkw6YE8s4v+AbgQTmTzVOUz0G4SAyDhTJMUG+8KzBkfC4lsCcgqr/5RfQe5oUo8@nongnu.org
X-Gm-Message-State: AOJu0YywRWUpYhKWsBBFGy4umOtVcsVVoOX5gzsP3LCver8SLs8jFOsh
 N3+ipdyTZC24/NpX1DIIHEqrIOtyleAvEM82CVXPgzMwxpDLxeHXvRUaLkf27B+8AJQ=
X-Gm-Gg: AZuq6aLjCOijJ7OIbfMJ6o1x7v4azAOOSel4gJLHsnWGFpJ+qXt90wT+ByP+ScgQuO4
 R2yLuZttKrChWy65LIgR6WRR5Cv4Lv1qHFiLa1j2Z8AhBMggyTnMB6GxZ6KiV5kEO/NRnC+lh9J
 Kalb7H5QBeYOqAlrg8sUwBVpdGd71FACDo04dv95o7fStSvWJBgwTZLstu9e3AjCEeQQUYEjtzi
 SavlZSj55ybOGmfdTuJGZrKMGZNeuSvAf8AL3v9QyoyIPE6fBqt3NCcRzvWSlX44fWJN+cLEw8E
 T7NtvRqoiSrJRTColQyqWWP6RAcc5D7VJEY47Se743KOz4wU3te7ZquN1d7REBhkNvrjWcckUUQ
 2ue8rRnGzoVqIiw9nFESNECPl3DAKeBcfcXCOkCoAmMv+Ws5E09bbsqwyuFgLK4q4KLZiNXSz1c
 4eoKduHlAY0NXULnFK2yn0tXHk5HW0RLnwwk3HcrlfG3A5+jQmEOlC5PZqLubHVp7qges8AZb3K
 g==
X-Received: by 2002:a17:902:f687:b0:2a7:d5c0:c659 with SMTP id
 d9443c01a7336-2a95160bfa3mr107464835ad.5.1770614387426; 
 Sun, 08 Feb 2026 21:19:47 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951a64ebesm94353265ad.2.2026.02.08.21.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:19:46 -0800 (PST)
Message-ID: <31906e49-62b2-47a3-9cda-cd90d5e29f4a@linaro.org>
Date: Mon, 9 Feb 2026 15:19:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] include/hw/virtio/virtio-access.h: simplify
 virtio_access_is_big_endian
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> virtio_is_big_endian already checks for VIRTIO_F_VERSION_1 feature, so
> this is redundant with big_endian_code.
> Also, clarify why we explicitly check for ppc64 and arm arch.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index 1bea3445979..9aed3d1da4f 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -22,21 +22,16 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-bus.h"
>   
> +static inline bool legacy_virtio_is_biendian(void)
> +{
> +    return target_ppc64() || target_base_arm();
> +}
> +
>   static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>   {
> -    if (target_ppc64() || target_base_arm()) {
> +    if (target_big_endian() || legacy_virtio_is_biendian()) {
>           return virtio_is_big_endian(vdev);
>       }

This now calls the hook for all big-endian, not just bi-endian.
I don't think you need to change anything here...

> -
> -    if (target_big_endian()) {
> -        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> -            return false;
> -        } else {
> -            return true;
> -        }
> -    }
> -

... just remove this.
That also clearly answers my question re v1.0 from before.

r~


