Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEC4C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvXF-0006ng-JP; Mon, 17 Feb 2025 02:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvWv-0006mE-5O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:27:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvWs-0003kx-Jn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:27:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43932b9b09aso42844675e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739777216; x=1740382016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVbVeK9AKAsRavh71VAB7hZ4oZ4YjMZXGKKRgd33qIk=;
 b=RvnPrpSo1OpJAyXhVxfaKYdST0/JNvsDYk488nIWCWNXPoCb0mZgaBwvYmBey21/dP
 J34UqGBVnwuTH96K1dlQUyVBWtsE3ZczZ0g8IMUaoRrvNKTng2eal/WYnwTgkBPr/YYi
 1NOoo2Jsod8lUJOzlRzhdgJ6uIwGhnfLScyVJqU099AQ7VmaAEV3Lbd/Y+W+g3Vc9W9H
 r3D0mJfyqH/Y79H4yHkLvaxTgz3zPT6CLFuN18LGdhcxYy3ssfvYTDVKK6rsBU9Zs9cX
 KV77QU6vfmqUo/l4k3rSUE0kCMuhu3pylUdJjh+ChTzbFcppe7ny/H40cOXdjBZRKWeq
 4+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739777216; x=1740382016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVbVeK9AKAsRavh71VAB7hZ4oZ4YjMZXGKKRgd33qIk=;
 b=wDe/nYEahiuy7fo4tubtr3QkiNUiKxnNFGMtaFD9M8KsVBe6viLA/jLmUMH5ng8Jhi
 3azxgDXSOibZYyiB25KNY36n/ZaEfoX0O6i1HkvLJpYD9htnMQt9vEzVmae73TqGXMom
 Vm3nksEll8xpU3NFg1NWrLyv/WRcEHcZshs8Q2U5X2T9Gv+G6CKBImUrAslsP+i+Z4Rk
 x6nQKaApaq0UeF/TwMHMpx7iQ070tMOQfXYLgLMncH+eFosAZUugeYZbQjJc333zWkwV
 WcEd0o+luAlSmu6zG6pDoUKUUe74WlGkXle+QAOUKfyMTXn2Eb+6mKj1viuKdq5lKS9P
 ZJWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm9J+ko4fkC6ffQM3r6Onxg9hO/GN+Srfay/dg+QrXZIRTmD59daSFUUEIDzwIL022tVUV7L5GXAWu@nongnu.org
X-Gm-Message-State: AOJu0YxrQOVPZThdXUZd0nyV0o80N4iW5aXpwA+YzWNHaNytb4ceSASD
 GmtKuRLD3EAC77xD3mnHByANOK4n60sOWi0UlyrmUAhcVZsjOnpaphD21YjCfNM=
X-Gm-Gg: ASbGnct+kE1xPjiOId6Jajp12FqhFIKON9NUOnlTc1VKuPY/l3iGygsfLoMw2iBtP3w
 rnHi2PLC9Dya3lQ3rbbC/meWF265tUQuBGgcec+e7DPSnzZf2FLQ94w6MWpeINWJyx3b4Xw9oZq
 11iSakulELj7dUWg8C7gKOR/fPOSjgM8MPbkcCSVNOMC/wetIfS5fa2v55iSXx/FhDcMcqJb5YM
 okJFdUeMREuUfO1IGSAzWhN2CR3ZtkCoriV89afrJck8P3uF2IDs6Z/2d7QRXD1qhIAEZnqe/qL
 vXOj3x/RJQZp59AKTiEisDml3+HNP6a6UHc=
X-Google-Smtp-Source: AGHT+IHJjsl9QlulRLU+hpLQWuR81aH+BgzQ+Rkx+WD5jG2XkxS8WyeCZUh/znvJysyumABRmND+4w==
X-Received: by 2002:a05:6000:1f84:b0:38d:d9e4:9ba0 with SMTP id
 ffacd0b85a97d-38f33f308d9mr9275415f8f.25.1739777216433; 
 Sun, 16 Feb 2025 23:26:56 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccef7sm11672668f8f.31.2025.02.16.23.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:26:55 -0800 (PST)
Message-ID: <5a220564-313a-44e9-8ae9-a2faec14ebb5@linaro.org>
Date: Mon, 17 Feb 2025 08:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/amd_iommu: Don't leak memory in
 amdvi_update_iotlb()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240731170019.3590563-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731170019.3590563-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/7/24 19:00, Peter Maydell wrote:
> In amdvi_update_iotlb() we will only put a new entry in the hash
> table if to_cache.perm is not IOMMU_NONE.  However we allocate the
> memory for the new AMDVIIOTLBEntry and for the hash table key
> regardless.  This means that in the IOMMU_NONE case we will leak the
> memory we alloacted.
> 
> Move the allocations into the if() to the point where we know we're
> going to add the item to the hash table.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with 'make check' and 'make check-avocado' only, but the
> bug and fix seem straightforward...

Oh now I remembered:
https://lore.kernel.org/qemu-devel/CACGkMEtjmpX8G9HYZ0r3n5ErhAENKhQ81f4ocfCYrh=XoF=5hw@mail.gmail.com/

> ---
>   hw/i386/amd_iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 6d4fde72f9b..87643d28917 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -357,12 +357,12 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>                                  uint64_t gpa, IOMMUTLBEntry to_cache,
>                                  uint16_t domid)
>   {
> -    AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
> -    uint64_t *key = g_new(uint64_t, 1);
> -    uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
> -
>       /* don't cache erroneous translations */
>       if (to_cache.perm != IOMMU_NONE) {
> +        AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
> +        uint64_t *key = g_new(uint64_t, 1);
> +        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
> +
>           trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
>   


