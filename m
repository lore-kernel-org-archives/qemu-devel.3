Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33281CF8878
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 08:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx0Ur-0004pl-KS; Sat, 05 Oct 2024 04:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Uq-0004pH-C8
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:50:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Uo-0000mF-NO
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:50:40 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso1823351a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728118237; x=1728723037;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1pE2GTYCH7XDNQJ7t8rkK5rm+FK6Sm7EdZNiK/ahSA=;
 b=264a0A2VuV3TjFzEpmphPwETLqCgD20ZNfPGvCAI6a03lIFKbZuWRYrzqOGqdtsbOC
 EZqBaYYO9pAfq9IKPYq9XedbAHSHZVTX+xRNA5fljGCRIY0hJztIyQlnEbCo+RehwL9g
 teJTeLs9KPqwh8HOEt2j1A0qokefw7ttYXghwNiK+urS3VCGmF600Gbe1ofLvHsQBj8h
 8fAAnE859AI9RI0d3xzepr56TAP7PzYZhAmTysyRbP7lzH/B+ep+OYxkRLvF/Zdt7gX4
 1+pEluO13j7106EA7yEXXjdBpoWNuWqP+l6oX7Z1nVicfTalej8+VVNCG2p58nQjWpQd
 MGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728118237; x=1728723037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1pE2GTYCH7XDNQJ7t8rkK5rm+FK6Sm7EdZNiK/ahSA=;
 b=huV/o1pdlGE9k8/8fMDTh5TAcQ8g2NkLUErtQQOwOxjhe+E6pHcLhaqnvFmgiDw1PY
 HJ60qNyKjqzXfmPiot5t83EK0xkN3veSeFjbFF8EP9navEqy2CK0GFM0UaVK39JszFEo
 An7/0eYQRLv5trKojHs41Yi4pXxU/wLrm6wGdK4mAlqPWeyPU1Sgi3Fvl3psYsES3qYR
 oHj70OXQxF9TJXwkPtCePE33HZVQzdLFLD2Sbn4P1o/0jQzZ/AMXcd+epBdhrTP5JsCN
 DJWhKqkCQwXaQFO3h6co8TuvNjwS2WzGek5TMKvay16v12hmFP1sBaOsKbjPvL1fe7A8
 OU1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdDUlUnpzKitJzbv0fRa7J8Gu5+Pu7W2GX+sEbyKWbTaakxj8i+dtVyjCytoAKhySWM8QZb6RRVAqP@nongnu.org
X-Gm-Message-State: AOJu0YwokmBfQK0VhWcENqm2TIa4gabgN4/TMR0A/lZ2tXyFjhjwD0w6
 RPQs0KHZEGvIIAtHLy2N2ToHTjPFIeE2vPln5jBOsvXADXAq+Md8rPw0X75QxJ4=
X-Google-Smtp-Source: AGHT+IE4xdeb37ODRMd/n1OjHN8W+Uxz/XyU7BBFjroF8WYDuppCY6WJ/lEIeWkZ0DhOFlGbvvBZaw==
X-Received: by 2002:a05:6a21:3511:b0:1cf:4422:d18b with SMTP id
 adf61e73a8af0-1d6dfa3a6f5mr10125862637.14.1728118236980; 
 Sat, 05 Oct 2024 01:50:36 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821508sm1277822a12.31.2024.10.05.01.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 01:50:36 -0700 (PDT)
Message-ID: <e02d28c2-d192-49d9-9f83-d45204e63642@daynix.com>
Date: Sat, 5 Oct 2024 17:50:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] ui/pixman: generalize shared_image_destroy
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-10-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241003112244.3340697-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Learn to free memfd-allocated shared memory.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/qemu-pixman.h |  2 +-
>   hw/display/virtio-gpu.c  |  4 ++--
>   ui/console.c             |  2 +-
>   ui/qemu-pixman.c         | 20 ++++++++++++--------
>   4 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index e3dd72b9e3..a97f56d09a 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -97,7 +97,7 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
>   
>   void qemu_pixman_image_unref(pixman_image_t *image);
>   
> -void qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data);
> +void qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data);
>   
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
>   
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 017a0f170c..77f6e76f23 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -298,7 +298,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>               bits, c2d.height ? res->hostmem / c2d.height : 0);
>   #ifdef WIN32
>           if (res->image) {
> -            pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
> +            pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
>           }
>   #endif
>       }
> @@ -1317,7 +1317,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>               return -EINVAL;
>           }
>   #ifdef WIN32
> -        pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
> +        pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
>   #endif
>   
>           res->addrs = g_new(uint64_t, res->iov_cnt);
> diff --git a/ui/console.c b/ui/console.c
> index 8f416ff0b9..fdd76c2be4 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -487,7 +487,7 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
>   #ifdef WIN32
>       qemu_displaysurface_win32_set_handle(surface, handle, 0);
>       pixman_image_set_destroy_function(surface->image,
> -                                      qemu_pixman_win32_image_destroy, handle);
> +                                      qemu_pixman_shared_image_destroy, handle);
>   #endif
>       return surface;
>   }
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index 3870e1a215..43050ab7c5 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -6,6 +6,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "ui/console.h"
> +#include "qemu/memfd.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   #include "trace.h"
>   
> @@ -269,16 +270,19 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
>   }
>   #endif /* CONFIG_PIXMAN */
>   
> -#ifdef WIN32
>   void
> -qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data)
> +qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data)
>   {
> +    void *ptr = pixman_image_get_data(image);
> +
> +#ifndef WIN32

I think it is better to have #ifdef instead of #ifndef. It is a common 
pattern to have #ifdef and #elif defined() for the platform-specific 
code and follow them with #else that implements the generic code. This 
allows supporting multiple platform conditions.

> +    int shmfd = GPOINTER_TO_INT(data);
> +    size_t size = pixman_image_get_height(image) * pixman_image_get_stride(image);
> +
> +    qemu_memfd_free(ptr, size, shmfd);
> +#else
>       HANDLE handle = data;
>   
> -    qemu_win32_map_free(
> -        pixman_image_get_data(image),
> -        handle,
> -        &error_warn
> -    );
> -}
> +    qemu_win32_map_free(ptr, handle, &error_warn);
>   #endif
> +}


