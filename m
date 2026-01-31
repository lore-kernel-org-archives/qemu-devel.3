Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6DD61037
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 17:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmF5t-0006IV-0i; Sat, 31 Jan 2026 12:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmF5r-0006Hj-D8
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 12:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmF5m-0003mt-Qa
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 12:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769881745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXiEJmqj+BdVjsmYL30IRNxQpKL2+3UyvRbHtPD7rSM=;
 b=KiwqAI2wdaQWfGY6ODXi2qdpHxUzu9d7YHCXjlQ9KI31B+QpniHZhQtCMmuH2Zd5Pl2ZuK
 fCQI4t1NbJlsRTwq+aL28tQUt0Qg+l8CHQEYMk5DbPYcat86nK7ZDkyQYlqjD+zGd98sNW
 8j48AFhzwN4+uAf15qquN6ZVe+Dskjw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-wgAX3oCgOx-xPVYOWdgu9A-1; Sat, 31 Jan 2026 12:49:03 -0500
X-MC-Unique: wgAX3oCgOx-xPVYOWdgu9A-1
X-Mimecast-MFC-AGG-ID: wgAX3oCgOx-xPVYOWdgu9A_1769881742
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so23504145e9.0
 for <qemu-devel@nongnu.org>; Sat, 31 Jan 2026 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769881742; x=1770486542; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cXiEJmqj+BdVjsmYL30IRNxQpKL2+3UyvRbHtPD7rSM=;
 b=SIZ6g8LQ8jUSbLv6paxkRPYbRYpIBEL04bawiGmyKmeNvNLctdj81JO/XhqUbEZ3qL
 oRMRvMbLSSq4smLmZ/bspiGGre88PWb2IMP2BAMdXQi9/Rl5O5n1KoXzK6itmsMYUSHa
 ir5Av+OZ1KpVBfpb+woiB9eUtaE3S301O6eVfNUCix+U4fVNiiTo+wb/2+kVobXER4CP
 cIe/z3fHcuUbKaJPhPPaMnEzU87UOKTohCoM0FcxSSoQcW3AOgLoTJwAuz41sJV+Wb++
 zbS5HR+r37wFrJPjmD5Ex6OoBQBU4wsTHSJqiJ13pLJ4wY5cKXeJVmKYNE+B9DUCgUbl
 PN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769881742; x=1770486542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXiEJmqj+BdVjsmYL30IRNxQpKL2+3UyvRbHtPD7rSM=;
 b=BcaKeEG/JOzdogEjlnoUbfoCuRlNBjyXm4Es4Z9kTBh2ySowAxezn7cUg0FmXC9078
 1qPNWIsonkBY0UEwruLKa97+ULA6DRo9rKkeHSCR5WIXLhKn5o+QRiUhndc/LKDuM7v/
 IrGlJahUTWh62kUGAXpuB29SXWWM21tJKr2lx1xtZ+16VHHdOGrjtcUYTcXFIxcItl35
 ighxP3fUu3wyisJYe3fHkQrUHpJRQeXpbsseVFcO0DvL55Q98gG0Kw2azsu5A8OdxT6R
 DcHpt8KKenggdOaDOQDCCgtMaaUJ+5nWV7hAsZ+bBsLVGDmyfogEhqfJEJjGCmD9LF1+
 +6iw==
X-Gm-Message-State: AOJu0Yx0f7cNP/l+r3CBVQOVORmwPljH934nKkoeQ3FZtRM2904Xp3ws
 wHg9Z3PRVMS5KeMHoB2ra7yCvRT3YY8EuZGfaiC/fCw6lk9t253QKK3ef4NGcYhqHOXAsM4aB8k
 wBM/NlAMjqBKBQCFwtD5TjkAdjnaCyeMVXQ6OWpzvlevwTQ/ZiZFGjHBpUGnev9QK
X-Gm-Gg: AZuq6aJN72nsWIeakXyjVXHGhwfzbdX7IaPz8yrxz4VWK1tqt+XisqIP79aZKGXh6f4
 0RQR0747o/mQoelNpiP+m4urvpr8AiW9tEvSaHhqLCAssm5iO3j9cdDFffmP8IvKeMfrJnpVr3/
 PCXjehEHB43l2ahFecWbwdEZjKu18xcpBvCCBnvm+v/HxZGYCWYijvKHf7nlYEJqfDfljQ8DQ11
 lx7Y/oN+i2gi9m9ZAPe2cTjl749jYYKfENCNa3baPq8STfLaxOUvY9sOAMfwQSaq34o4lFBnKzN
 UP0+JVhpDVzJGENllVAY06BiHXW2tkZoc+msye2GIX8Fxg6K0CvV9iN6iQoNLbVoOsa1pZx/qFD
 QUqUNHw==
X-Received: by 2002:a05:600c:1e24:b0:480:46c6:bf4b with SMTP id
 5b1f17b1804b1-482db4488ddmr81220845e9.5.1769881741656; 
 Sat, 31 Jan 2026 09:49:01 -0800 (PST)
X-Received: by 2002:a05:600c:1e24:b0:480:46c6:bf4b with SMTP id
 5b1f17b1804b1-482db4488ddmr81220685e9.5.1769881741296; 
 Sat, 31 Jan 2026 09:49:01 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd21f5dsm57272335e9.8.2026.01.31.09.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 09:48:59 -0800 (PST)
Date: Sat, 31 Jan 2026 12:48:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Message-ID: <20260131124842-mutt-send-email-mst@kernel.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Performance impact?

the reason we have these is for performance ...

> ---
>  include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index cd17d0c87eb..51d9d725690 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -17,27 +17,27 @@
>  #define QEMU_VIRTIO_ACCESS_H
>  
>  #include "exec/hwaddr.h"
> +#include "qemu/target-info.h"
>  #include "system/memory_cached.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-bus.h"
>  
> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
> -#endif
> -
>  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>  {
> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> -    return virtio_is_big_endian(vdev);
> -#elif TARGET_BIG_ENDIAN
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> -        return false;
> +    if (target_ppc64() || target_base_arm()) {
> +        return virtio_is_big_endian(vdev);
>      }
> -    return true;
> -#else
> +
> +    if (target_big_endian()) {
> +        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +            return false;
> +        } else {
> +            return true;
> +        }
> +    }
> +
>      return false;
> -#endif
>  }
>  
>  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
> -- 
> 2.47.3


