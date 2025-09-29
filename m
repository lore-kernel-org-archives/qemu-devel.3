Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B03CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GYI-0006UR-Ul; Mon, 29 Sep 2025 12:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GXu-0006K2-H9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GXn-0005yG-00
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759162551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pWXe0SqFOzCgzeHZv7VtcKVn224jjbTZLErGx/pkMYA=;
 b=ZeENdfpZ/9foDxe0eYYpLbGWJD4X27gKSach2v0XUnxxLUhiaFTc0jDDg/yvi1icnZwanW
 0HcqqaIry+2zyYlIWuRVsD6btNLMvqfugEazQDMiVJbNG7xoF2YFGIFfAWCIxmYQD02FWG
 mPaj2N2WhJhKUmPEyt0TzACEdSICUXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-pSvHRr92OHeTtVYZdUQY2w-1; Mon, 29 Sep 2025 12:15:49 -0400
X-MC-Unique: pSvHRr92OHeTtVYZdUQY2w-1
X-Mimecast-MFC-AGG-ID: pSvHRr92OHeTtVYZdUQY2w_1759162549
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so3266870f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162549; x=1759767349;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWXe0SqFOzCgzeHZv7VtcKVn224jjbTZLErGx/pkMYA=;
 b=kBL+Msu7rkGVphmQZ7ZjF9/DEALn1PSF3zSuwzv8cC87ejAi0A/NoNvFz012bYGZkK
 WhjTyp+rBMaMrUAemaXa0SV6yR8f+//t/PP/J+3DyBuHAhvbK1pvy+Tf8goHVcZBXzu3
 PYb/O0gJ2SsDi8cKDeKhCqztZQNZnXOlMs3B60TmUQzufwg+GHiHWD8rnxKCL88ze2oG
 sAHE6D9xmDkusBoMpGF7Fnsv3DE6AjiBf99KMeMy7UdH8AosVdoGTiZJxOEHPIjCdvCf
 /4TCBjaEh4jHNmifFxP5IVcAeJ7SBy21epUL9oXJ0vcnPiKGryl0EqplXr81aeCrYinJ
 hR4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXsxJOsE2Qvx7+FbItwqGPNKlzSbd5aJcAGxuadElpKqEJUori6Ys/0Iz24an7Q7LpFL4zgKw7NFCD@nongnu.org
X-Gm-Message-State: AOJu0YxV9MtvRuXnPH+XlTNRQ/D7v8bA+SFZwOWKl0sLonIX4bR9/IHO
 OybelDH4TBhZV57MOaA7zZPNT+LhZ+CA7/P73QJYAxqrz8q8be8voxmazANqycbdiy3oaj7gn9B
 4HYi6UcochRGJXvY5d1iu7d3Yy5S9nwCkadWnOXsbEuvajIuPZggqqu5o
X-Gm-Gg: ASbGncv80njXme0dJElZjlGHzqNYRQQDKS1Uw8DPxEQvFkMDsFg6Gm9vHWglIDNXTP+
 Y55ayjlgQxmpWmjht5bBd3tFI2OgLy94vTS8BhtZry2hNcr+Mo8xLUDp8bgEI5+Ts3zesfgLS6V
 LMiff8N8WQi1hPja9zIQSAloos9wI1J8TeL2W7C+Ek4d31kGvGTG1L6pDDftIP09d0tYVqcgXm4
 mGhtQpaV+xbxemajcHfhlaqpiSLUofCk7kQaR8F3WL31EG+MuYm4SqPnJZsYtw7COG+PJlKKVNN
 YbM0/iv54sY53WXeR0Gz3ul5zbCFyl2Tob16nj7i4HX+b6eEbpZjxIqjMSV/CJUPN06c+2Rmw/x
 MhyM=
X-Received: by 2002:a05:6000:2302:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-40e4bf00e3emr13950766f8f.47.1759162548762; 
 Mon, 29 Sep 2025 09:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHciTUncA/uRwGsN4stLKzMB9AIII6s3oCYtjhGUfWFylY+0PVErLvXdkyff9rZUBBfWQJ7vQ==
X-Received: by 2002:a05:6000:2302:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-40e4bf00e3emr13950749f8f.47.1759162548328; 
 Mon, 29 Sep 2025 09:15:48 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d?
 ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f77956sm19410365e9.20.2025.09.29.09.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 09:15:47 -0700 (PDT)
Message-ID: <b07cd69a-6ac9-4d68-ba1a-989780f01716@redhat.com>
Date: Mon, 29 Sep 2025 18:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] memory: New AS helper to serialize destroy+free
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <20250929144228.1994037-3-peter.maydell@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929144228.1994037-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29.09.25 16:42, Peter Maydell wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> If an AddressSpace has been created in its own allocated
> memory, cleaning it up requires first destroying the AS
> and then freeing the memory. Doing this doesn't work:
> 
>      address_space_destroy(as);
>      g_free_rcu(as, rcu);
> 
> because both address_space_destroy() and g_free_rcu()
> try to use the same 'rcu' node in the AddressSpace struct
> and the address_space_destroy hook gets overwritten.
> 
> Provide a new address_space_destroy_free() function which
> will destroy the AS and then free the memory it uses, all
> in one RCU callback.
> 
> (CC to stable because the next commit needs this function.)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [PMM: Expanded commit message with motivation, tweaked comment]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


