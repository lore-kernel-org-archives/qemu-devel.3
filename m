Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E43C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsiJ-0004U7-3g; Mon, 05 May 2025 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsiG-0004TI-DU
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsiE-0006wL-UB
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xWTWf+tCbT/zui5GQMcCZb/aZOotwYbrPx5arEUaOXs=;
 b=VL90xQwQfzWlzg0gJDc6SJa2zzaaopIrspOvOBiPheLRC5e6j+ebxlymx1AeTtNDfVKnHs
 DLL6YjqqILD7M/8JMb4aXt+7jmGD47nlj4MJUrW8n/BvUzHnbeYiuFS4YyyTXPzvD3npwC
 GdmK8ydQF4Q76KnD5tE3O8BEB4cqoHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-3DJeESouNMiZEAoI4VBYbA-1; Mon, 05 May 2025 06:06:10 -0400
X-MC-Unique: 3DJeESouNMiZEAoI4VBYbA-1
X-Mimecast-MFC-AGG-ID: 3DJeESouNMiZEAoI4VBYbA_1746439569
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so22029765e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439569; x=1747044369;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWTWf+tCbT/zui5GQMcCZb/aZOotwYbrPx5arEUaOXs=;
 b=rGYvsz1btmlMDMLw6sGSYSrw3jiVwOFosoUDooXYCGG32RVPyHl74EvMaPzY7c+/uD
 RE+xznFPiqSEwYdNa/xGJb7i4QAsnoWsTWItMZfiOkeNMd8VfscHNG2WCQsTl2uF7hj+
 vt9hjSQNIJyVo1kRUTdyEr+Pc06IUtqO5aicOzWu+rXAEZlGpL3UtZcYZyZAXSnv8bGD
 D6Kv28UN8Jalj0P6ykpK/BAleg4L5f8Li2RPBGUNUymqjYY9QmQlCcNQkEYYhi9/la5L
 rnUVtQe6h3XfHQ1YQJST033i0OdGR7NtS7WMlBrncXwUwD19ZnarccQ9STcfWxY2ql42
 M+qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWll+jqXSqJ0R4cKOt+VXEtGt7ZfMkHnOfMtYL28SWubOO0+Tb7Ul/Wnkn13dc6rqDV/SW2pd2mULtj@nongnu.org
X-Gm-Message-State: AOJu0YyyW4BtIAIVnyzBuhZnVokFHMKnm5ptfJ0jpaDwgl34rBXnOsVM
 x7pS88f3IZiY0MwUBSHJPQYc7xKv3kMuJGl4LUC0L2tcrDf2mX68iwew9Cvn49IKPIYvWxylxYt
 L9pGLGnSEplEjhENv+rxCz/c71eP0nOz3j3/6hVn1LAfH1m1kcklA
X-Gm-Gg: ASbGncsqiR1/KW612r4ICX6mjYWDX2gYC9Mj8mhPe7iibM60l5X5eyTIEb7f0esPSRY
 mfWLxxpK3ZvMgxYJl7qMUHcMF1XxC8BA1z8+V5bMmrhKqi25vFRYWh63g+HZ3SOJiWPHGslfGH4
 46L5VoAT7rENG3uYjhKecGy5C0tGYzuWeDualI+s40jnKc7KFmA7OkaRtVwc2XWtR+DX+h0mIYD
 kqiCXgvLCjjJBbP38+y63jxTikihvvc4pNMEVRj1aKmP4e+XITUneb02h0L86jN65C9hhmarFHK
 VEXi4cHdhGHfeXOxMhsRXDBH7L9lhxHb2+IpqoxF
X-Received: by 2002:a05:600c:34c3:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-441c48b0347mr57794835e9.6.1746439569514; 
 Mon, 05 May 2025 03:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKW5pXFhFGO4RrBi3/zMtdBc6GI4MHJ6b0ktfqjQxLBPb7JQ5rn4bKSOr3cYl/DReaGxWa5A==
X-Received: by 2002:a05:600c:34c3:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-441c48b0347mr57794545e9.6.1746439569178; 
 Mon, 05 May 2025 03:06:09 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a70sm175429475e9.31.2025.05.05.03.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:06:08 -0700 (PDT)
Message-ID: <ef5938de-4893-4eee-a9e1-c208f7c6890f@redhat.com>
Date: Mon, 5 May 2025 12:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/machine: Fix indentation
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org
References: <20250504215639.54860-6-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250504215639.54860-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/05/2025 23.56, Gustavo Romero wrote:
> Fix indentation for some elements in the hardware compat arrays.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   hw/core/machine.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed01798d37..b8ae155dfa 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {};
>   const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>   
>   GlobalProperty hw_compat_9_2[] = {
> -    {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> +    { "arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
>       { "virtio-balloon-pci", "vectors", "0" },
>       { "virtio-balloon-pci-transitional", "vectors", "0" },
>       { "virtio-balloon-pci-non-transitional", "vectors", "0" },
> @@ -58,12 +58,12 @@ GlobalProperty hw_compat_9_1[] = {
>   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>   
>   GlobalProperty hw_compat_9_0[] = {
> -    {"arm-cpu", "backcompat-cntfrq", "true" },
> +    { "arm-cpu", "backcompat-cntfrq", "true" },
>       { "scsi-hd", "migrate-emulated-scsi-request", "false" },
>       { "scsi-cd", "migrate-emulated-scsi-request", "false" },
> -    {"vfio-pci", "skip-vsc-check", "false" },
> +    { "vfio-pci", "skip-vsc-check", "false" },
>       { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
> -    {"sd-card", "spec_version", "2" },
> +    { "sd-card", "spec_version", "2" },
>   };
>   const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


