Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E096C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2SEa-0006KG-16; Wed, 09 Apr 2025 06:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2SEG-0006Fl-UY
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u2SEF-0006ge-5v
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 06:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744192817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+8K25wJgJHHtlJtW5Yj3Pd1vYrtyjlDbeaG7EZHhLz0=;
 b=Raj9cPahFcsIdMY0m0nMe6AfCBzlV4x4ANHQCPfzaEF7R+dtzt7AgTtd8uq2lhk61jjPyG
 wDZOtgLOQuOZA0DVEY4UHN6Dcqx03TNt3vAE2l0VNewdhuN/JID+B4IpsHZtu4EW0mgD4/
 yLMtcbqP8sVMqoIf7/tmi2yPeikLrYg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-IA47JFFRPembAJ_pf45EXA-1; Wed, 09 Apr 2025 06:00:16 -0400
X-MC-Unique: IA47JFFRPembAJ_pf45EXA-1
X-Mimecast-MFC-AGG-ID: IA47JFFRPembAJ_pf45EXA_1744192815
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so310912f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 03:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744192815; x=1744797615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8K25wJgJHHtlJtW5Yj3Pd1vYrtyjlDbeaG7EZHhLz0=;
 b=BVQMGkGp6K2zupkrdDPgTyO+aJfbYvvbd0WQWRYmYB+9ZR0LN6rd0IYKVVq+uiiH38
 P1QozimkhaRCS1LBraEnX6G9mxHkHdT9Ar0jAkAdRQ9NZIfojqf3nMr/+wg32UcY+ukJ
 KQ3JkIyyoYntpZwUPVgKsgQeuBehy4XeG2eLcsY8WUGgsEEXiXJoVgcQgL0wnTcU+8D2
 mQqbluaOiSjYI+DdndNeaDVmnO8BWJikVTzDbETCB6liJ9e1QZnvhNCyq0VQ/e70j0Oq
 MJo3d64edgB/ZeOsdyhJu8ikDpEsB5ozRkxcjmMX6w8ab97hmX+CbJuTIDcmbdoC+9mD
 vEOw==
X-Gm-Message-State: AOJu0YydnTt2yTBTjGH9W4NqyuQcu30TX62V3U7BjcKzkWFyfFfg6Zeo
 WXb6rFLfAJ3IkA/Pqmq93yARXsQjMY+1J1iPlA9knDuAjm2ShGg0VS+JX1dNH+ywFdj98BDYIbw
 VyhJjunO+7tgUiFVrkZwXKRkKhV2bvC2CzA1X+MhjJt07o/YNtjNvjy8BN6zf
X-Gm-Gg: ASbGncu8J6+/LTpUB06to7YJTrWGGh7zZDL+G5xE6DjFalxFvnaqFQg1fNItQUsgvBm
 wqbglmJsq77HYkm+2W4GCRnLDTbeOg2Uh2cd/nrsWDCNQ5m+T1yYDKRCH2Kt1IMZxwnB3i5Oq6l
 l3OZVUggZScjnCPWRlhe0jhlCt82/H+z/88llFiUYAUGbYSa7R8Iu2YHaYZgb3GpyIpGrGqBKGp
 gl2ui50FAhfTBJ8CaxPa+sgYH+DoPLOnpIDdoyyxKvrCr1oyztXnPALo4XO4f/qB1nj/PRFDFXk
 w2j5Z3ptAQ+jPxQnxEAnlif9SqwC8wvlf0kTaBs0Nvcl8puOsA==
X-Received: by 2002:a05:6000:22c3:b0:39c:12ce:105c with SMTP id
 ffacd0b85a97d-39d87e84c05mr2034766f8f.6.1744192814827; 
 Wed, 09 Apr 2025 03:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGda+c82lPWrwI06EshfslAKrSXLiLZzqTMa9qvJhZjgE1XSdm3+/DPU/HftejJU3xjGcV9iw==
X-Received: by 2002:a05:6000:22c3:b0:39c:12ce:105c with SMTP id
 ffacd0b85a97d-39d87e84c05mr2034739f8f.6.1744192814478; 
 Wed, 09 Apr 2025 03:00:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893774aasm1181692f8f.30.2025.04.09.03.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:00:14 -0700 (PDT)
Message-ID: <ba6aeb84-b567-4536-bd4d-84e666b66160@redhat.com>
Date: Wed, 9 Apr 2025 12:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] vfio/spapr: Fix L2 crash with PCI device
 passthrough
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/8/25 14:40, Amit Machhiwal wrote:
> Hi,
> 
> This patch series addresses two aspects in vfio_spapr_create_window() that
> includes the enhancement in error handling in this function and also fixes an
> issue with KVM guests (L2) inside a pSeries logical partition (LPAR) with larger
> memory configurations and PCI device passthrough.
> 
> The structure of the patch series is as below:
> 
> 1. The first patch introduces structured error reporting in
>     `vfio_spapr_create_window()` by adding an `Error **` parameter. This allows
>     better propagation of failure details to the caller.
> 
> 2. The second patch fixes a crash observed when booting an L2 KVM guest inside a
>     pSeries LPAR with memory more than 128 GB and PCI device passthrough. The
>     crash occurs due a check in KVM preventing multi-level TCEs because of not
>     being supported by PowerVM hypervisor. This patch ensures that such
>     configurations are avoided by first checking the supported number of levels
>     returned by the `VFIO_IOMMU_SPAPR_TCE_GET_INFO` ioctl.
> 
> The fix has been tested with KVM guests on PowerVM and bare-metal enviroments
> with memory sizes up to 390 GB and 450 GB respectively.
> 
> Thanks,
> Amit
> 
> Changes in v3:
>    * Change vfio_spapr_create_window() to return bool
>    * Replace error_setg() with error_setg_errono() in vfio_spapr_create_window()
>    * Pass errp instead of local Error object in vfio_spapr_create_window()
>      while calling from vfio_spapr_add_section_window()
>    * Modified patch #2 subject
> 
> Changes in v2:
>    * Link: https://lore.kernel.org/all/20250407143119.1304513-1-amachhiw@linux.ibm.com/
>    * Added Error ** parameter in vfio_spapr_create_window() for enhanced error
>      handling with error_setg() and friends
> 
> v1: https://lore.kernel.org/all/20250404091721.2653539-1-amachhiw@linux.ibm.com/
> 
> Amit Machhiwal (2):
>    vfio/spapr: Enhance error handling in vfio_spapr_create_window()
>    vfio/spapr: Fix L2 crash with PCI device passthrough and memory > 128G
> 
>   hw/vfio/spapr.c | 69 ++++++++++++++++++++++++++++++-------------------
>   1 file changed, 43 insertions(+), 26 deletions(-)
> 
> 
> base-commit: dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed


Applied to vfio-next.

Thanks,

C.



