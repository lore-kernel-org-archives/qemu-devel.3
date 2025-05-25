Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539BFCD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnUl-0002KD-EW; Sun, 31 May 2026 17:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUj-0002K4-R3
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUi-00053x-9N
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490a7a34493so4338055e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262090; x=1780866890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vtLWEbn2cmB9xzpJaVbtuyH97w9SJ2eB9+kuZuVPiU=;
 b=KhRkzfWDDtkDgUq6G/lSj55K16LtmSefBLrS6K1XwWLQUV6AoikPYXbWUYjK3dyx84
 GTC6zm/i6AGcDriIGueZaoTaE3xe9PNP8W2ykzFIjAOPmf5lc8KHOE+JHwYjArHnOozi
 6UEFq9Teq4fCdruwnMMrzRP+7RHEjq4flwF4bK3Bu0srfJtlY0sq487p1VazyU3zIg4F
 IN0vU/zI/zHl7XMAB+IozK5itOQoCMwL7HxbHm+WGBKuSsEkfwlwjbxznVkmB2xsZbxu
 +WoquKnXLAn8/Vay0HKfOMxB7Z0HmRdCHyBvYn4gQnFdIkPwoswgv2Fkp4BaoNaT7x42
 YlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262090; x=1780866890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vtLWEbn2cmB9xzpJaVbtuyH97w9SJ2eB9+kuZuVPiU=;
 b=mYT/GHvbxrqW8M5y9T4Kpoe1z3YHQYoE9P/hQ1dwgX4k/tA7isSm9ZwQjM5WDWkCke
 FKS7FfrWuJiKmW4B3fk2is9qRlj9dmN2CxZkypn1GUUW2n5VI1yeVKG+7arVV6pIL4uS
 RTE0GXPYFuZK3xvIvWpR+/MFp3grcmAf/SbjU7JDcUIeJaRj1whmio+ExZ/CDCOpii4o
 Gntqx3niXwszIzGMk1qF9J1rrElQD3k4de8hONLhApgDHpzBVoe86PQACdq6e/dsvX6X
 r9i04vD818D3SSrVmk0R6cuCg1ZiEt4xdI3oXswTzeuQ8P8ex4i8ED0GGcyRN52Xoz5x
 njkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AnpHNLeHSydZpuUo257WQF1qG5zqW2x0dJLRTN5bLN3rp9Xi9hFMHBloIMGP2RszoqxvGe16jLwXz@nongnu.org
X-Gm-Message-State: AOJu0Yyc8Ib32rQUK2gW703t+vj1RzdWMQPEA2zcuMmv8po+nFhurD8R
 OvzfV4G3IWaIXRV+/b2J7mhh+K6y5e9jXpQtYFT3hX6p5LL+fa3PylVgQRTafxm336M=
X-Gm-Gg: Acq92OEruEXPhSx6ICERsbMmP/7x7FkI53g9g23FCbhPoEZGp8yZIMQtatURNIZ0HdO
 l2wu3GM148Jr536JvHcr7ABVmVd0oDcMxP6FCXHKhKcn3t3rAmSE2VUNL5ZWLx2p8IfyHan60J5
 bK9hZ59stPnd/mVgI+YYxU7bNuTf5AojACJ0zD4tJ6J2nXYVdMSWpF4hM8DM/j1JD3PvYJq0pGo
 vu1VV12dnP8WV1gL4HaMdIR7gCv1McxX4ztgW9BVSUqQ00J2mfTzxD3xxBjQpyRPCZUSmqzC6XG
 /+t8DZrOKTGuYI0hyfT4Oe3Rv0FBfqXMwoyUT8EaU6n4+c/sH+vI7vznkWooMXOz0TDdlSNOEm7
 JltntwpLVdTgO8mAQr7hyikkgg6a2vEsmzUubgXAG+t1iJdybbABUYdGTraVzdkj4Em3pFzIF8Z
 Rwaryht4kE50AUHKRc6wR01vdCLujoKmEVxefI13dbZy/xz8aGvs6RB81rKScwKHHto5Pqf5wJS
 spr
X-Received: by 2002:a05:600c:37c3:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-490a2a2713bmr109787675e9.7.1780262089990; 
 Sun, 31 May 2026 14:14:49 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0f74fasm87954635e9.4.2026.05.31.14.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:14:49 -0700 (PDT)
Message-ID: <d7b34b9d-6398-433b-8ffd-b9a7156b3eb0@linaro.org>
Date: Sun, 25 May 2025 17:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: pass MemoryRegion to DMA operations
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, steven.sistare@oracle.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250521215534.2688540-1-john.levon@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250521215534.2688540-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 21/5/25 22:55, John Levon wrote:
> Pass through the MemoryRegion to DMA operation handlers of vfio
> containers. The vfio-user container will need this later, to translate
> the vaddr into an offset for the dma map vfio-user message; CPR will
> also will need this.

"will ... will" typo.

> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>   hw/vfio/container-base.c              | 4 ++--
>   hw/vfio/container.c                   | 3 ++-
>   hw/vfio/iommufd.c                     | 3 ++-
>   hw/vfio/listener.c                    | 6 +++---
>   5 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index f9e561cb08..3feb773e5f 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>   
>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              hwaddr iova, ram_addr_t size,
> -                           void *vaddr, bool readonly);
> +                           void *vaddr, bool readonly, MemoryRegion *mr);
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb, bool unmap_all);
> @@ -151,20 +151,21 @@ struct VFIOIOMMUClass {
>       /**
>        * @dma_map
>        *
> -     * Map an address range into the container.
> +     * Map an address range into the container. Note that the memory region is
> +     * referenced within an RCU read lock region across this call.
>        *
>        * @bcontainer: #VFIOContainerBase to use
>        * @iova: start address to map
>        * @size: size of the range to map
>        * @vaddr: process virtual address of mapping
>        * @readonly: true if mapping should be readonly
> +     * @mr: the memory region for this mapping
>        *
>        * Returns 0 to indicate success and -errno otherwise.
>        */
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
> -                   void *vaddr, bool readonly);
> -
> +                   void *vaddr, bool readonly, MemoryRegion *mr);

Since the memory region shouldn't be altered, preferably
"const MemoryRegion *mr" (here and in vfio_container_dma_map).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


