Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB22CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxi1-00062n-L7; Tue, 26 May 2026 15:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRxhv-00062A-4C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRxhr-0004hw-Qv
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779824689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=noBqfbBjgAxI+KyLu46NJ86hwalBWWMsc9ksY20M+1E=;
 b=dcZsL7IXDMuLUpGrL3v7jWRlYusgW1F+My+ZPiXj4DghLQMVjL+jkI8mlpI24jOS/4DjpG
 sMGiyJMxXzb0FPT2AQ1Hf9CkRSM6r/n0UfKiJznShghK0qpHcKpEE7FjFMsWpuJ/G+l2ab
 eB5SD5h1M6lLmTYUcv7q+Hpxz6GxkSI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97--ssFWNeINfqZDev0f_1dGQ-1; Tue, 26 May 2026 15:44:47 -0400
X-MC-Unique: -ssFWNeINfqZDev0f_1dGQ-1
X-Mimecast-MFC-AGG-ID: -ssFWNeINfqZDev0f_1dGQ_1779824687
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44b186b715aso6945307f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779824687; x=1780429487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=noBqfbBjgAxI+KyLu46NJ86hwalBWWMsc9ksY20M+1E=;
 b=IGXSkjyAXVj/SkjnPZu0YttuDUkHXhnL7+EMxhwfHBBa/j2F16oXrhy7K9E795oGEe
 2qqS3duEtnHq5PBlhiaLbw8McqiBblwIZr2CEU/MlXLJQ36ii7RO6r397j0syEj4/34e
 o0jAntT7ufH7YCZ36SMT35MbdGe3hLGM7Pk853eTWGuzffN+WTard/EjOZ8+65FLckME
 J++q6MkEFF1CyPyB3EwCN0RtDc2j0+6jFsRZUehnCjF6WCYF8jAkZob5N05wScGLCV2k
 0XsN8nmtJXa8JgDUxO9YmuVh36Pt9MTPUnRz/b7oAs+vXdZSy9sTckjwPY0Zp4oJdpGG
 n5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779824687; x=1780429487;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noBqfbBjgAxI+KyLu46NJ86hwalBWWMsc9ksY20M+1E=;
 b=dbYD3YSfdwCam8AQ8cj2fOBdkptrogOOmfhaO4H7WqsOI7hUhpc64efzzlP0XVtr4l
 E0hYZW6Oz7TPU43kmieTndD0pQ/+zTGc1cHni59T1/gYfRXLl0/EjGHipYDW43XQoWqm
 j+slYps9wJNZ6EoqwmQk/TIBdG/77aiMhrTlwBhiT62adLJkmzmKiKM6dPVP06JVw4kN
 PBNXO2uKnbnHiHGDouZvoKJ0mlP1k4PkvhuCphS2N0eByTLBwfD0w4dKY+lB7Us42+2l
 vs2pxeRzxJDfnOz4OjqksBhOe3bmDBcE1ry46XlXmx/sj5togsL+vKaKxVP6Sb2Lm6Wg
 OeCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rh/EM8M+sBO6EKSzliKqGp2SibEFEV1phGpMYtP4UUXWnqzfxzHCzpBabtH1aMtFU+kChrqdyaWu1@nongnu.org
X-Gm-Message-State: AOJu0YzlYfYVfpGrFfa6M/wysBYvS7Zri9r99qb20yfQrMemr0ZSq0RU
 BlaEOGlXTF7sxumT3z2wJKNpq1yRnkS5dOKS9xNRK42CFy4qoc2cnmAI9fRnqAu/IifNin9Rsi4
 KqpdPJmaAGl267o2z5Z4rcpB2WiDR4tEEHF7V1q86XZSnbzv4jWssQS9P
X-Gm-Gg: Acq92OEFeRA6qdZjErUhtDKCXDpXaivXDKI2NoLlXaxS5ta5zhhtA5gb8xQ0kkDCVIW
 DxDc+gq8UYpsjLZw/Z+MH3MkLN5IeM4Vd2vtCyXhjtSVPi4nRmV25wb/BLUPYUOklU2jNyibw6H
 0gqL5qdW8crRGaSbnzfAjzrVa+QuAaWWjf8HLkj50Ar+DyQVR4pcpbr44RucSnt45G4ZnJjgu/o
 92fs0RXzXTjaU7z4IwB6iblNyFsEr47vgDlXRNrQdgNE2czxdV7r8DeSpWOuOWc77/lQjBkI6AJ
 EVeec/XIRJQcR9lJJiWTTbvGJHC23FbgN6uCHvB7CiuYWECSW60RXyzmOCip68Dt/tFIfEqrC0e
 NFESlGtmWlMUxenGjKDWKdEAbHTl4/+hIHavJv+wAA6DhhhXfcb7elf1potRSsA9SiOQptaA=
X-Received: by 2002:a5d:5886:0:b0:45e:739b:3e3b with SMTP id
 ffacd0b85a97d-45eb366d448mr33887930f8f.0.1779824686685; 
 Tue, 26 May 2026 12:44:46 -0700 (PDT)
X-Received: by 2002:a5d:5886:0:b0:45e:739b:3e3b with SMTP id
 ffacd0b85a97d-45eb366d448mr33887896f8f.0.1779824686212; 
 Tue, 26 May 2026 12:44:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b19aasm423162f8f.25.2026.05.26.12.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 12:44:45 -0700 (PDT)
Message-ID: <03ca3a6a-5545-4410-9c0b-dbbc106bff98@redhat.com>
Date: Tue, 26 May 2026 21:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
To: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
References: <20260519055756.70575-1-chenyi.qiang@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260519055756.70575-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Chenyi,


On 5/19/26 07:57, Chenyi Qiang wrote:
> vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
> fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
> not correct for private file-backed RAM.
> 
> dma_map_file() resolves PFNs from the backing file, but private
> mappings can run on different PFNs than the file itself. As a result,
> using dma_map_file() on a private RAMBlock can program DMA against pages
> that do not back QEMU's actual guest memory.
> 
> This was observed with hugetlbfs-backed guest memory and iommufd/VFIO:
> share=on works, while share=off can fault because the file-backed PFNs
> can diverge from the PFNs backing QEMU's private mapping.
> 
> Fix this by using dma_map_file() only for shared RAMBlocks.
> 
> Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220776
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   hw/vfio/container.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 4c2816b574..c5a3c60a27 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -82,7 +82,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
>       RAMBlock *rb = mr->ram_block;
>       int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>   
> -    if (mfd >= 0 && vioc->dma_map_file) {
> +    if (mfd >= 0 && vioc->dma_map_file && qemu_ram_is_shared(rb)) {

I think we should introduce an helper to check that the conditions
for using the .dma_map_file() handler are met. Something like :

     if (vfio_container_can_dma_map_file(bcontainer, ...)) {
           RAMBlock *rb = mr->ram_block;
     

and

  /*
   * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
   *
   * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
   * 2) RAM device sub-regions (MMIO BARs)
   *
   * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
   * they are subject to copy-on-write (COW) anomalies, their
   * underlying PFNs can permanently diverge from the backing file
   */
   bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer, ...)
   {
      return ...
   }

How's that ?

Thanks,

C.





