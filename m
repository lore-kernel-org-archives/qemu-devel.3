Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CB0CF8877
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 09:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx0dn-0005ra-0J; Sat, 05 Oct 2024 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0dl-0005rD-6V
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:59:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0dj-0001bd-Mv
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:59:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b95359440so25731765ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728118790; x=1728723590;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJZ0NUSM88uXjU2awQ9CnfjgDBy9Vl6rWCzsSs8oysE=;
 b=gMP16S4aZ4phshDqHIkjw/eOaXt6s2rW6X/XX3FakXih04dNEkBmVccJKYc+a0hROi
 6Z6EZtGcsCwaUgMlcH4/24Nr3xinHRkLnPU+F+qYCS/CILjRmKVN2SbyhGM7GSeoN77t
 PqnQHjpBe3B1GoNHsVSVCDQwD/vs6Obh9C8hN2vLn72G38EtJvpSXmd4WhCBRtP2JMq8
 0tBqnzxWrUlx2D26f77SlNWQoKA09e/6XUiC4TzYJ3BiL0Ur+iJw1nngcDrs3PjzhNSI
 0zcQ+XOoSkzblGlVRHV5OBO0j60l0YLPOYYRUNE8+7d3DsSnt8lSF6qQSk3U4vFBR2Uw
 VGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728118790; x=1728723590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJZ0NUSM88uXjU2awQ9CnfjgDBy9Vl6rWCzsSs8oysE=;
 b=QhX3NbgtrJSGixruG5ZFkf892qK7fRXX4sX6VLUOQWjdT1ALJeMYc7HCgYj10j9CLH
 xYV0/YOIOWNp+lC7CAIz3QAQLkgy8j7GQzLqIptoGwXIBcpQ+sEBkcqOCTZfuvBVAA8f
 eV/bLfmqPyteiq0rXUnoi2BQ+ACJuLIWpHZyJftInIE+q0X/JSOg0rgn4Dwb6CYnt8Ca
 ONexJ+DE3rZbP6tvXVpSMb4lYcfbSrK1a14Sa7qxYPd94+9H5DHx1eAxXZXtUUjhyMYW
 jG6QvvPxi0/RDVUVpmsyrMFvSukLi5h2FocJPtqRUxWLxdw9xlCA3v5mwCkNK69ZE/UF
 vMBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5yrmZ9RRJJSl215iB/I7P/LwQVkUw7Rnubc82FaMiU0EepbiNV76Ql4OxbMACL1Ap2U1DpdJI11LX@nongnu.org
X-Gm-Message-State: AOJu0YyafBDw0zjIv0V8hVYkes7dJnmy3DJ4RYhHMKioKuDna0Dfsk3/
 x0QPfhAEqtjUCXwdnhmoAAc0kwTaor51N3lYCuuNnDqIz8K+UIzaM/9kzj3cWBs=
X-Google-Smtp-Source: AGHT+IGOON5UGBnpd6fm+0o58peCZQrSsxxzZycspu3hSdPznIgQxVyCBQryPD0bxWMEctGlXtJFaQ==
X-Received: by 2002:a17:903:18a:b0:20b:7d09:8c86 with SMTP id
 d9443c01a7336-20bfe49666fmr89054775ad.38.1728118789972; 
 Sat, 05 Oct 2024 01:59:49 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398d5acsm9633425ad.285.2024.10.05.01.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 01:59:49 -0700 (PDT)
Message-ID: <24a91b5d-89a3-4338-874c-78aaf22b93ac@daynix.com>
Date: Sat, 5 Oct 2024 17:59:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ui/surface: allocate shared memory on !win32
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-13-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241003112244.3340697-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
> Use qemu_memfd_alloc() to allocate the display surface memory, which
> will fallback on tmpfile/mmap() on systems without memfd, and allow to
> share the display with other processes.
> 
> This is similar to how display memory is allocated on win32 since commit
> 09b4c198 ("console/win32: allocate shareable display surface").
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/surface.h |  8 ++++++++
>   ui/console.c         | 30 ++++++++++++++++++++++++++++--
>   2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ui/surface.h b/include/ui/surface.h
> index 345b19169d..dacf12ffe2 100644
> --- a/include/ui/surface.h
> +++ b/include/ui/surface.h
> @@ -23,6 +23,10 @@ typedef struct DisplaySurface {
>       GLenum gltype;
>       GLuint texture;
>   #endif
> +#ifndef WIN32
> +    int shmfd;
> +    uint32_t shmfd_offset;
> +#endif
>   #ifdef WIN32
>       HANDLE handle;

What about defining a new struct that contains either of shmfd or 
handle? We can then have a unified set of functions that uses the struct 
to allocate/free a shared pixman image and to set one to DisplaySurface.

>       uint32_t handle_offset;
> @@ -37,6 +41,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
>   DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
>   DisplaySurface *qemu_create_placeholder_surface(int w, int h,
>                                                   const char *msg);
> +#ifndef WIN32
> +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
> +                                   int shmfd, uint32_t offset);
> +#endif
>   #ifdef WIN32
>   void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
>                                             HANDLE h, uint32_t offset);
> diff --git a/ui/console.c b/ui/console.c
> index fdd76c2be4..56f2462c3d 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -37,6 +37,7 @@
>   #include "trace.h"
>   #include "exec/memory.h"
>   #include "qom/object.h"
> +#include "qemu/memfd.h"
>   
>   #include "console-priv.h"
>   
> @@ -452,6 +453,17 @@ qemu_graphic_console_init(Object *obj)
>   {
>   }
>   
> +#ifndef WIN32
> +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
> +                                   int shmfd, uint32_t offset)
> +{
> +    assert(surface->shmfd == -1);
> +
> +    surface->shmfd = shmfd;
> +    surface->shmfd_offset = offset;
> +}
> +#endif
> +
>   #ifdef WIN32
>   void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
>                                             HANDLE h, uint32_t offset)
> @@ -469,12 +481,16 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
>       void *bits = NULL;
>   #ifdef WIN32
>       HANDLE handle = NULL;
> +#else
> +    int shmfd = -1;
>   #endif
>   
>       trace_displaysurface_create(width, height);
>   
>   #ifdef WIN32
>       bits = qemu_win32_map_alloc(width * height * 4, &handle, &error_abort);
> +#else
> +    bits = qemu_memfd_alloc("displaysurface", width * height * 4, 0, &shmfd, &error_abort);
>   #endif
>   
>       surface = qemu_create_displaysurface_from(
> @@ -486,9 +502,13 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
>   
>   #ifdef WIN32
>       qemu_displaysurface_win32_set_handle(surface, handle, 0);
> -    pixman_image_set_destroy_function(surface->image,
> -                                      qemu_pixman_shared_image_destroy, handle);
> +    void *data = handle;
> +#else
> +    qemu_displaysurface_set_shmfd(surface, shmfd, 0);
> +    void *data = GINT_TO_POINTER(shmfd);
>   #endif
> +    pixman_image_set_destroy_function(surface->image, qemu_pixman_shared_image_destroy, data);
> +
>       return surface;
>   }
>   
> @@ -499,6 +519,9 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
>       DisplaySurface *surface = g_new0(DisplaySurface, 1);
>   
>       trace_displaysurface_create_from(surface, width, height, format);
> +#ifndef WIN32
> +    surface->shmfd = -1;
> +#endif
>       surface->image = pixman_image_create_bits(format,
>                                                 width, height,
>                                                 (void *)data, linesize);
> @@ -512,6 +535,9 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
>       DisplaySurface *surface = g_new0(DisplaySurface, 1);
>   
>       trace_displaysurface_create_pixman(surface);
> +#ifndef WIN32
> +    surface->shmfd = -1;
> +#endif
>       surface->image = pixman_image_ref(image);
>   
>       return surface;


