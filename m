Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C9E8782F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGyM-0002p1-TV; Tue, 03 Feb 2026 09:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnGyC-0002n2-ND
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnGyA-0005oA-Kv
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770127286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NCSaM+31p32Cdy51m20COP/47I/djCExLyJI22uoBvQ=;
 b=RlKFKpEnI9Kn3bXD1HlBRLhHhD+VstFMaB6Y32iaUkb2v6n1PazfVFZ+9Iiqj3O1KrLXoF
 RWjDJCWYybhWt0+OMPa4feziGezaPpusiFi0UUytX80nmHZKhp6gvOan0VlqUKt4nGxYWu
 LktWQLS2MgQ85N2t4zbT2dQQkiZvdOM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-kc3W8haiP_6UfVT2HNydQw-1; Tue, 03 Feb 2026 09:01:24 -0500
X-MC-Unique: kc3W8haiP_6UfVT2HNydQw-1
X-Mimecast-MFC-AGG-ID: kc3W8haiP_6UfVT2HNydQw_1770127283
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43065ad16a8so4187367f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770127282; x=1770732082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NCSaM+31p32Cdy51m20COP/47I/djCExLyJI22uoBvQ=;
 b=NANidd7CSDdA3UaCLWJO9qdjlv9d6cEl5/VON3Tw8tJJuMBh6s5tFHjtEt0YWGST+X
 8RhamuQS+1dv/UIWOE6l+Pv8k1QpT3eid3GwoFeRTn65WZvqLKP65Bm8bv/YDXHmn6D3
 l87ks0sM9b4UKO3qvPF2RsdIgLHY5QIR7fN6LIeoyzWmM+s1ehyODTVQUxEzeJGzuxEK
 pbl6IATBSKp6sADxy2uBlyQqY/7G5AVI81OSSUnCFMOjB5zAHLrzGLwx22vkhnQ2Ikrh
 WK00k2KGCaop/t2gV0ZbASLM3Nqo2+Rsa95SL4CzMObEMTrGZkFipOIbYR5b1DSriXaU
 JqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127282; x=1770732082;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCSaM+31p32Cdy51m20COP/47I/djCExLyJI22uoBvQ=;
 b=dUmjxcrrkj9qI5OwnXrd0twuqLakQ8GA6CqrJKYs9w2WeKNVldZtrjnQ8s4ES1rDDX
 9h1CN+dZEyRQ+vVLDgjZodT8q67pvQBUV+SnUYrLRKk8b109X28/viPr1pcNBUmC9SD3
 EcZfJ7jitT0Ue8EAm6+utAPeS1MHQI3G8fPideLlbBbxCHYpvEjcexft0fj3VThq8HHV
 K6+eJ7gZweRBxU7IQVBM4/Ozc/0GERHtH42GK+0w82Z1rU36TUHhQS5KetCYIHORgLnN
 x1MwrtBsaIi6TQYo69u1KfXHFRsab5n4eNIxrw6py1qEF4VBLejhL8OjFXpj03dbGP8Y
 ZvNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+PwBvn1xrAAeNWFQTi94GMRvqZqGk1wl0lbN6etf3/fZwGqmxXZh21nJdCHaSvGlASdj1V2ygmDf@nongnu.org
X-Gm-Message-State: AOJu0YyroTiYrG3X422iKbxVCuKKtyKrclQTpPJo2HIkKY8m8KyI3u6X
 SuPDNoc0ncb1kEHFmr1e3mvTMeeeJrZjaMU7nlR4gcfqyG9l+YVymXa28wL223TGyVp0YYRM2Iq
 PJQAfaJ5RJa3L/Qye1sLsws2QCNMy9l1uT3hN57rbFDTWbDk7vKABD/kx
X-Gm-Gg: AZuq6aL6AsF1/L+b1LNqQK/sswUWvOF8+nyXWhluB0ZRzlnwogqa5T3N0Iuvypfc0ZU
 7L4VhHg6vgrr2xrTwe+Ga6jDvuiPBBugw6Cy2PNmNZopZpk4fu/Yev3pNcToDW/IfYnhGSOSzji
 4bRvsYiJSpFkjQ8LjMR2NisdGT7oZ7RD9AAadYzHKubH1Ch71RU7yACiCbKzP9KDVPYh4NOR47O
 jLZaq97zSIILCgn3aUbN96p5LaIyCWKXjsdE9QNh1fx+UToeW3KYWBfCIb9qcQjPwii20zd6hRL
 IS8UAgiiK/YsywkMmrYPhR93EqPO7jQWulz0F/Nf4da56kiJh2WMwgIJn5BiTw3iVu9GfP5uetm
 aJwVgAH0o1k+W0qZYXEK7VMy1Q9z5kP6B+zL8Q7suwtd9k38l
X-Received: by 2002:a05:6000:4308:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-435f3aaa9b8mr22816175f8f.33.1770127282387; 
 Tue, 03 Feb 2026 06:01:22 -0800 (PST)
X-Received: by 2002:a05:6000:4308:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-435f3aaa9b8mr22816082f8f.33.1770127281718; 
 Tue, 03 Feb 2026 06:01:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm54121186f8f.10.2026.02.03.06.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 06:01:20 -0800 (PST)
Message-ID: <60caad88-611b-4ccb-b591-e34c9c751a72@redhat.com>
Date: Tue, 3 Feb 2026 15:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-13-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260203073200.848183-13-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/3/26 08:30, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we invoke
> the vfio_device_create_dmabuf() API which identifies the right VFIO
> device and eventually creates a dmabuf fd.
> 
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> created for the dmabuf.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig             |  5 ++++
>   hw/display/virtio-gpu-dmabuf.c | 49 ++++++++++++++++++++++++++--------
>   2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1e95ab28ef..0d090f25f5 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>       depends on VIRTIO_PCI
>       select VGA
>   
> +config VIRTIO_GPU_VFIO_BLOB
> +    bool
> +    default y
> +    depends on VFIO
> +
>   config VHOST_USER_GPU
>       bool
>       default y
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 22e66fbb12..2e65f21dda 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -18,6 +18,7 @@
>   #include "ui/console.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "trace.h"
>   #include "system/ramblock.h"
>   #include "system/hostmem.h"
> @@ -27,6 +28,23 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static bool virtio_gpu_create_vfio_dmabuf(struct virtio_gpu_simple_resource *r,
> +                                          Error **errp)
> +{
> +    bool ret = false;
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    int fd;
> +
> +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd, errp)) {
> +        return false;
> +    }
> +
> +    ret = true;
> +    r->dmabuf_fd = fd;
> +#endif
> +    return ret;
> +}
> +
>   static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>                                         Error **errp)
>   {
> @@ -72,18 +90,25 @@ static bool virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
>   }
>   
>   static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
> -                                    Error **err1)
> +                                    Error **err1, Error **err2)

This looks wrong. Why do we need 2 errors ?

C.

>   {
> +    bool ret = true;
>       void *map;
>   
>       map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
>       if (map == MAP_FAILED) {
>           error_setg_errno(err1, errno, "dmabuf mmap failed");
> -        res->remapped = NULL;
> -        return false;
> +        map = NULL;
> +        ret = false;
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> +                                    res->blob_size, err2)) {
> +            ret = true;
> +        }
> +#endif
>       }
>       res->remapped = map;
> -    return true;
> +    return ret;
>   }
>   
>   static void virtio_gpu_destroy_dmabuf(struct virtio_gpu_simple_resource *res)
> @@ -137,7 +162,7 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    Error *err1 = NULL;
> +    Error *err1 = NULL, *err2 = NULL;
>       void *pdata = NULL;
>   
>       res->dmabuf_fd = -1;
> @@ -146,12 +171,16 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>           pdata = res->iov[0].iov_base;
>       } else {
>           if (!virtio_gpu_create_udmabuf(res, &err1)) {
> -            error_report_err(err1);
> -            return;
> +            if (!virtio_gpu_create_vfio_dmabuf(res, &err2)) {
> +                error_report_err(err1);
> +                error_report_err(err2);
> +                return;
> +            }
>           }
>   
> -        if (!virtio_gpu_remap_dmabuf(res, &err1)) {
> +        if (!virtio_gpu_remap_dmabuf(res, &err1, &err2)) {
>               error_report_err(err1);
> +            error_report_err(err2);
>               return;
>           }
>           pdata = res->remapped;
> @@ -162,9 +191,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   
>   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_dmabuf(res);
> -    }
> +    virtio_gpu_destroy_dmabuf(res);
>   }
>   
>   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


