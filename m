Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE2EC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 06:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUJAX-0007DR-P3; Wed, 25 Jun 2025 01:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUJAM-0007Av-42
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 01:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUJAJ-0001YX-QD
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 01:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750831161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XbkmOkMsbv8lOi0emli4piw/7N76GEx2NnuCRcjolkk=;
 b=VT0W/LFypnVPiOp/dKUwn7CstcW6oB9JGUHxYx1AwB2dRFwiFN0s4fLHN7/AKNIJKpl08s
 tWAv6aJTo6onsDWtB/WMJKOTpimUDl93rC1sLMgeUEzsndTbjlfQuj7f8hd8QWzBF6ndu6
 v7MZ/qDj5JqdJXBrGbcJQVoUZEwiGh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-lNJAnLLuMBug6EPR-KTZyQ-1; Wed, 25 Jun 2025 01:59:19 -0400
X-MC-Unique: lNJAnLLuMBug6EPR-KTZyQ-1
X-Mimecast-MFC-AGG-ID: lNJAnLLuMBug6EPR-KTZyQ_1750831158
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a56b3dee17so239308f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 22:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750831158; x=1751435958;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbkmOkMsbv8lOi0emli4piw/7N76GEx2NnuCRcjolkk=;
 b=TPJXGW3wRV0mCmwivxAkj/em5JK/sDoBayuQ0gp02PT6Tt1QaODkjVN09g0RYCR6ZK
 x4F0I/RA1m/MWhIBkLz3M2R/VkCemZHN1zz8SwSgfp7QmVMCe1zxfsPn6M0+9lcY6B1r
 TH3oYSvUvoh7Pm4tsfwZyJWbmBKH9l/8Ua7BqYInAJu8lHsX5GGVS9LSPD//KKa6FwnO
 aKuSmyYJoiHzwSFn7EeN9sRpFddJtnaeXBU9PzWwdqXczvUXgSg+hXQrUIbh2B+dVAjj
 EvTwSdQLMGWCDHLYAVGcbbr/gP+A4hhVPr5UDbDwMf5D2JPmiWp0F3NVruUC+MW642gV
 +mCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYjucor/kORHqmMj3e/vjxMUGZhZXE+evOAbuJoxsTWjI/tOsag0Z+UlzIEjAoc6qU0k5F8OeCmXUQ@nongnu.org
X-Gm-Message-State: AOJu0YwjtUe1+GStqu3A/QkIuztO/7CcOvQX8Cg6t0gd5+fwoYjHe0iq
 eccnsICL1CpCYfsqBxo1nErW2CIsChbRNe1f1MagIVkR5LnLo+MCuPrTuWk9GHD3+3NnvUoXhBv
 ARrX6vrebxeZT7OOSTYuYeOy9t0dVDbfFkJoBKANVO0iBrb+pxjzy28e/
X-Gm-Gg: ASbGncszQ/2mFUEDQfsV/01Yhl5mK2BD7Hqr1k/+fRrLpbJAGPcoCJMNpHGdyZd6bcS
 bJj3GD0qY8hOXIWtmwS03kwj72RGN/ZaThM0kEt0Cw5mAjXZtmmtdCKSoYM9jGg8tQjs/Oh/o1t
 Q7tNc0mNjfQhRqkOyok1KHsOvcFxsOcWFgr7NoCGdZmN0EhTbYMld3nvv0YEgTHP6bbbCDCtKPP
 Vy61qK1BnS146q+BjqzYJilf2CNbTRF4rPuecdWJBi7DM+jSI58OPxbBLNwWAuF4M6bCrEpy2y7
 c6ukCjnbE1GVf1V9UlSpJI0p4QrBM8jo8P3pxrl6U/HKfcZSnMB/5Pj0lFcx
X-Received: by 2002:a05:6000:2c11:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3a6e71c5b3dmr5288729f8f.8.1750831158337; 
 Tue, 24 Jun 2025 22:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4zrtzj/OgcUXznUX4+4lyYQmZpzZmMinagYY816AxOfOQcWx0omHEZh4kRckI4rERvtg4zQ==
X-Received: by 2002:a05:6000:2c11:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3a6e71c5b3dmr5288717f8f.8.1750831157966; 
 Tue, 24 Jun 2025 22:59:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811039csm3551646f8f.89.2025.06.24.22.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 22:59:16 -0700 (PDT)
Message-ID: <d1f54aa6-7da8-4656-9ba5-e2ecd14c5834@redhat.com>
Date: Wed, 25 Jun 2025 07:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i386/tdx: Don't build TDX for 32bit target
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250625034903.2770272-1-xiaoyao.li@intel.com>
 <20250625034903.2770272-3-xiaoyao.li@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250625034903.2770272-3-xiaoyao.li@intel.com>
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

On 6/25/25 05:49, Xiaoyao Li wrote:
> TDX cannot work on 32-bit host. It's also not worth supported TDX with
> 32-bit QEMU.
> 
> Thus, make TDX depends on !I386.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   hw/i386/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 6fc353930985..c58802462a45 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -13,7 +13,7 @@ config SGX
>   config TDX
>       bool
>       select X86_FW_OVMF
> -    depends on KVM
> +    depends on KVM && !I386
>   
>   config PC
>       bool

Both patches look OK.

Out of curiosity, would the change below work as well (without patch 1) ?

Thanks,

C.




@@ -13,7 +13,7 @@ config SGX
  config TDX
      bool
      select X86_FW_OVMF
-    depends on KVM
+    depends on KVM && X86_64
  
  config PC
      bool


