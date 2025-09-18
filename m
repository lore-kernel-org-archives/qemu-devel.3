Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A2CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBRF-0004NW-IF; Thu, 18 Sep 2025 06:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzBRE-0004ND-5E
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzBRA-0006Lb-Nt
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758189620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7qI+Pqn27AP7k9zpYO+04mT0s/xjPvqnVBn0GC2K1kQ=;
 b=NGHPjJpBuUjWkWprc1Kj28OhAtJHeoSPesZqonYb3HZPvu45uyEwcBztCSfsCv6ophtH5B
 R8E28oihOlPwz/X8uIixstUY+VD4z1XvE1N+M4yGPk/q7oRW3tWFfuLMPgHO4/B5lAUZsG
 kVbnggsZSrsM8n8sujscf2YdJy2A39w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-zE85yjMwOyW6cRfq7baE_Q-1; Thu, 18 Sep 2025 06:00:18 -0400
X-MC-Unique: zE85yjMwOyW6cRfq7baE_Q-1
X-Mimecast-MFC-AGG-ID: zE85yjMwOyW6cRfq7baE_Q_1758189617
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece0cb7c9cso505720f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 03:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758189617; x=1758794417;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7qI+Pqn27AP7k9zpYO+04mT0s/xjPvqnVBn0GC2K1kQ=;
 b=Enx8bxm3zLb1ynaUhF1BXH5kb/iQrPmtmVw6YJDIkUtyHKdu9yRrBPqds7aqnUnXbf
 zdrveYW5sEVB9kPHjTHQDv8OlZhGp9/c5aThMqJQAI9SDxmArb9Oxbnc0iNhJURbujje
 PFWeAugGXSQ0g8+jb5Gorn0B0nF38qesUTkQfDAeGPCarxzASHR/UVzF9AbhqfEN/HnG
 9ME7ih/ygBcvbCJE185zcU8F8YDv2ZYSI3oPo0qTOftZ74kRqR8n+MXHjGgbXEep6xvZ
 eQrcSAuytYb3SvvCP7t8RoaY//IDuda5qEdebQ6reeWuyMzEmuXIvrdbHAJ1pYqXdbIg
 qyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZt9u/sLeFJTr6f/IUxy2SOGTqFU9Xw9aWTSDHBNFvK2yoLKvbvxrA3XJ0Hszo3QMnHIp7OBUZTQ2R@nongnu.org
X-Gm-Message-State: AOJu0Yy0DeguTN0R6J3DmJNiKqrPfJ27PqXB0KDUvYNuEzw25zlx3ViW
 BUwgBrRSlixZRq259uCHHSI1Fxf8zBGRurV71o1OChDbwe11QRfHqnYSfVOSYptmfhNJ5ok6/Sx
 JOU5b7B/VwuFkOdCDo6/AM5KR81baGXFaOYo7AbiAs24nM/jz5tgoqkkX
X-Gm-Gg: ASbGncutSoHaVE+iHgbuqymUqkd9uRnZTOTK5C6uF1lAAwcfQLJZfHpHFpoExCRHNJ6
 Oy/6lOToPmT3dNmw4jS/ZplNovAqDJKvasS81feCBqYSbCL7cJq/Nr8KDTro+EW43NQlotmAtM6
 wPhCcACmExZgapivoC52Il3qDtKlr59Yjmi0NDX+AK4hJFiTWLfMc+4quJmKnxgG6oszRQdyrJV
 Raj3io5D22cVfA5ZUI/TNsu/aZeM1CQz8FpmAzQWTpLloWnpJb//We8jZLnb8BmDuGmOZzxygLn
 v4fy873Q8NDgM9dboQeGGzeDppnfmtpX5xrVU80twbpe6tj7TIbeCcyFi9e5tTWTNxSrclBJkAk
 JbI4=
X-Received: by 2002:a05:6000:4021:b0:3dc:ca9d:e3d7 with SMTP id
 ffacd0b85a97d-3ecdf9b1750mr3696851f8f.8.1758189617228; 
 Thu, 18 Sep 2025 03:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvrnhE1rAfllvm+og4RnBD0Ix2TGkJR8X+GL6pawAxBQ6BvOqfaMW2D2L80o9sUyk9ha2yIg==
X-Received: by 2002:a05:6000:4021:b0:3dc:ca9d:e3d7 with SMTP id
 ffacd0b85a97d-3ecdf9b1750mr3696820f8f.8.1758189616721; 
 Thu, 18 Sep 2025 03:00:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7107sm3136339f8f.30.2025.09.18.03.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 03:00:16 -0700 (PDT)
Message-ID: <4302fa85-9cd1-4eee-9577-19eaa736c639@redhat.com>
Date: Thu, 18 Sep 2025 12:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/22] docs/devel: Add IOMMUFD nesting documentation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-23-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250918085803.796942-23-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Zhenzhong

On 9/18/25 10:58, Zhenzhong Duan wrote:
> Add documentation about using IOMMUFD backed VFIO device with intel_iommu with
> x-flts=on.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   docs/devel/vfio-iommufd.rst | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175..d9cb9e7f5e 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -164,3 +164,27 @@ RAM discarding for mdev.
>   
>   ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
>   devices are always mdev and RAM discarding is force enabled.
> +
> +Usage with intel_iommu with x-flts=on
> +-------------------------------------
> +
> +Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
> +with x-flts=on, for legacy container backed VFIO device, below error shows:
> +
> +.. code-block:: none
> +
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
> +
> +VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
> +or else below error shows:
> +
> +.. code-block:: none
> +
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device under PCI bridge is unsupported when x-flts=on
> +
> +If host IOMMU has ERRATA_772415_SPR17, kexec or reboot from "intel_iommu=on,sm_on"
> +to "intel_iommu=on,sm_off" in guest is also unsupported. Configure scalable mode
> +off as below if it's not needed by guest.
> +
> +.. code-block:: bash

an new line lacks after code-block.


Thanks,

C.



> +    -device intel-iommu,x-scalable-mode=off


