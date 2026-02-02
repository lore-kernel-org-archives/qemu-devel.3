Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1A7E7C70B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmodK-0002B2-86; Mon, 02 Feb 2026 02:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmodJ-0002Ac-5g
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmodH-0004q1-Ls
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770018361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0T/AgcgChWWJfy4ozHLNB8e2fz1VpKw4ukP6G73GkVc=;
 b=YNvkrTasYXCbBXAdBst4MhiYIPtODZQXkpMp1DOQI5PIwGrYbk/JB3o27qJ/QLN8IzgTXE
 7sLLLZ51hhNZm3A959qZi5B9J6cCuPATk2O3dl3VH9RMcPXVr1gth/KiO7azI4mAjteMny
 kxQiWIcbfkoVrUNc7xB4Em/S0cRgT5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Q-LN93SPNhCghkQt_49vAQ-1; Mon, 02 Feb 2026 02:45:58 -0500
X-MC-Unique: Q-LN93SPNhCghkQt_49vAQ-1
X-Mimecast-MFC-AGG-ID: Q-LN93SPNhCghkQt_49vAQ_1770018357
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48071615686so31553985e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770018357; x=1770623157; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0T/AgcgChWWJfy4ozHLNB8e2fz1VpKw4ukP6G73GkVc=;
 b=qV7xuou7LeG0vZxqbt1v48VQQ4WTePc2lGGvV2UhzyESHsGzoqjxw1uXnQU76H3BVh
 SUdz1GekL0sLi3jA/KZQMYpE/WpRWGdClC3hu9D5KnZi6WZ/C4Q3Ms8uvt1bohEJKrfL
 H4I0NvrvktzfH3CqASWiYxiA6ILD7DN/KNuD0JiCAOjKUBrgo3ookLIVEzg9GH2uZtQU
 K5SfXCCYYKj06c5yeEBvD0hvMYO83p9tSA7tj9wPTL37LzDzWMta5z4MEZxJWUYvZQZV
 aaS0PZAwG7d8dZwlrMEPLv8WhEeiMfuJfac35q9O2jUntCam/vzvY0F0lbLRFTfLfwE2
 kD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018357; x=1770623157;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0T/AgcgChWWJfy4ozHLNB8e2fz1VpKw4ukP6G73GkVc=;
 b=O5pdHJYu/c4MWKhQgsYD0vAoOptkLpAeWyChD+BWFqG0Lq+WPittWY1BvWu7fFkK4+
 VpuA75Rh6Q6YOZd3NgtqEycq1oK8vRQaegmogRimDgHdRnhv+m4mGFpI6XgGO/2hUid/
 XJFi0qHe4WV3xyah8BoH+9UH+NVcHaoRaldj3nGKGVgX9Ks/6wJht/pRw2Ds+QIgRXZ8
 /6wucMWw5CRnr2aUTnPBBs4RzE+IUdFY5aTE7n0Y3aSTCKDrP3WYXPuncRQ838ZPWrjN
 1mF9QePvex+SS/J/Hp1yFT12JulLfYVIvVDkL9h+AUG6QzsV5S9f/mCZEcmMhBa4kP+r
 cuRg==
X-Gm-Message-State: AOJu0YzUtVmtxFr2ebELteC6gZf6x3RSvt1Z2IDRVAOEpBaFYCK7ygA7
 vJAbVlA4qyE+Ciq+1uzVIAwMDfYFtd61cBah9SdtMYT3F9Ra79Tp9l1kZ7HBtPGYLC9CiFsqpZO
 3yc6uQhgpu+fCJ3JkVlvPrHL7T8pOf8ROaOQIb2Iuh49pwio86q81/kdC
X-Gm-Gg: AZuq6aJgBu8PesMZCKW6irSTVzT8Dq48PZm3PNbknlyQlNxOlOf4NWKFj6tHw4IFufg
 FAoWd6qnW3AVDZjRQYOzclBDe8zR0nQdqLTdMYTN0hi0m4iIPxhJLi5UuE7+xv29pZKTS1GnHba
 Mn4fN8TOsdLZKvaQzkNUItsaPcG7kxnGuoyh+FxJT4Ufc04tNKl5uE0+xi5uOp1o6Hc0rEF5FXg
 Wm0ZjoYM5/SlxGDvuXHCtjiYo1eBYONiELrRoCUnLLN+pqVjn2hDcawkHRu2PrHubjJ5IWNzIA2
 RTfYGLYbt7hFYSvld1diCPDxlkJ43U8g478WlIHUGgNAIzLYop3/vJD1N+h5yuQ1pqjMEhxhLJY
 6c0KXv0BEfMRxmpFFpc25iGhJUQHs+5s87g==
X-Received: by 2002:a05:600c:474f:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-482db452587mr133681275e9.9.1770018356905; 
 Sun, 01 Feb 2026 23:45:56 -0800 (PST)
X-Received: by 2002:a05:600c:474f:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-482db452587mr133681055e9.9.1770018356522; 
 Sun, 01 Feb 2026 23:45:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm362669885e9.11.2026.02.01.23.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:45:55 -0800 (PST)
Date: Mon, 2 Feb 2026 02:45:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Message-ID: <20260202024316-mutt-send-email-mst@kernel.org>
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201232924.93399-5-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Mon, Feb 02, 2026 at 12:29:16AM +0100, Philippe Mathieu-Daudé wrote:
> Endianness access is constant between device resets.
> Use the field instead of calling the same function.

yes but the function was inlined and often a NOP. worth mentioning.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>  hw/virtio/virtio.c                |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index cd17d0c87eb..f3b4d0075b5 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -42,7 +42,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>  
>  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          stw_be_p(ptr, v);
>      } else {
>          stw_le_p(ptr, v);


So this is the main extra cost: on an LE host, we now have this branch on every
access where previously it was all optimized out.

Is it measureable? It is worth testing.



> @@ -51,7 +51,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
>  
>  static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          stl_be_p(ptr, v);
>      } else {
>          stl_le_p(ptr, v);
> @@ -60,7 +60,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
>  
>  static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          stq_be_p(ptr, v);
>      } else {
>          stq_le_p(ptr, v);
> @@ -69,7 +69,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
>  
>  static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          return lduw_be_p(ptr);
>      } else {
>          return lduw_le_p(ptr);

and this one.


> @@ -78,7 +78,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
>  
>  static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          return ldl_be_p(ptr);
>      } else {
>          return ldl_le_p(ptr);
> @@ -87,7 +87,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
>  
>  static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          return ldq_be_p(ptr);
>      } else {
>          return ldq_le_p(ptr);
> @@ -97,9 +97,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
>  static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
>  {
>  #if HOST_BIG_ENDIAN
> -    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
> +    return vdev->access_is_big_endian ? s : bswap16(s);
>  #else
> -    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
> +    return vdev->access_is_big_endian ? bswap16(s) : s;
>  #endif
>  }
>  
> @@ -111,9 +111,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
>  static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t s)
>  {
>  #if HOST_BIG_ENDIAN
> -    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
> +    return vdev->access_is_big_endian ? s : bswap32(s);
>  #else
> -    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
> +    return vdev->access_is_big_endian ? bswap32(s) : s;
>  #endif
>  }
>  
> @@ -125,9 +125,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
>  static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t s)
>  {
>  #if HOST_BIG_ENDIAN
> -    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
> +    return vdev->access_is_big_endian ? s : bswap64(s);
>  #else
> -    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
> +    return vdev->access_is_big_endian ? bswap64(s) : s;
>  #endif
>  }
>  
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 242c207a591..1dc60d37cb4 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -220,7 +220,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
>                                                 MemoryRegionCache *cache,
>                                                 hwaddr pa)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          return lduw_be_phys_cached(cache, pa);
>      }
>      return lduw_le_phys_cached(cache, pa);
> @@ -230,7 +230,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
>                                            MemoryRegionCache *cache,
>                                            hwaddr pa, uint16_t value)
>  {
> -    if (virtio_access_is_big_endian(vdev)) {
> +    if (vdev->access_is_big_endian) {
>          stw_be_phys_cached(cache, pa, value);
>      } else {
>          stw_le_phys_cached(cache, pa, value);
> -- 
> 2.52.0


