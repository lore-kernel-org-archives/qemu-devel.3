Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD99D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggpz-0001oJ-JH; Fri, 16 Jan 2026 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vggpy-0001n5-2r
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vggpw-000456-62
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768558427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T7Tp1Ji8bYij+g9iPJ0T2ymSAbXWtpGYsR3E+iOBLcQ=;
 b=W/dYCEPgB5ObAx0g3Q9djcxVz1xl1MmrD51z6xUKm6ZFyeIM/wMire+U8kE3XHD29Fa2Gn
 I9CmG8G3wgaEqazKMyFDYOBeUKIZ5t3xVyxW6DiLuuvgMQ5RIWeeRpCPou0eY8fiRn4gbu
 3eDN+mSGf0y4VzJurprSkVYBblBBgBQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-NAhV7S2HOy-ejo20cBA54w-1; Fri, 16 Jan 2026 05:13:45 -0500
X-MC-Unique: NAhV7S2HOy-ejo20cBA54w-1
X-Mimecast-MFC-AGG-ID: NAhV7S2HOy-ejo20cBA54w_1768558425
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so15381955e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768558424; x=1769163224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T7Tp1Ji8bYij+g9iPJ0T2ymSAbXWtpGYsR3E+iOBLcQ=;
 b=jZV+tblaAQvf8bsoWr35Rgr6M5AdzXgwsN+Snv6eVY1iiQ43FZvn1dY4FrRs62fZJV
 6wMLH+vyUod0wzuqcGNEKnR3SiBS90zo7XRdLPB2/J038TgVKqClqc392k3aN3gxf3WV
 g0IrxhaB1vcVwz5hfS/Ztl3ZB0zNgbrReEbKnGDJHZlfj2RUWcBG+71fbUqpG+YpkzYG
 bPchiTV2VcquuLqJrEe7N/dNf0irNp97Z/J1aXWQDKnXltABAPojZYbonp0+CJpkwdd6
 IokPx9l7oTRs42fusuM6vEuyQI+ZtmPFvvKdaBrAHHzegZ2h6xvIcuLUya3I7QV3IWd2
 2mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558424; x=1769163224;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7Tp1Ji8bYij+g9iPJ0T2ymSAbXWtpGYsR3E+iOBLcQ=;
 b=tDwyrzLN/2URSuYSZSXGYpLJ1nJOyVg7+Rul0lJNRgIn3EnphDHuZdra72kCXQYX5r
 kFx/9e7phbu9wcLi1CAMzArHWRTDrtVaAzjfJ7Hs9sYXkyGIUW6DhlDvzWMH8bg6Z32i
 JfvcUv2DXIq7g4f6qblJ44rgwNjQsyXFociv5o5MUnsEwAeyIBj/CfeBjr20H6oLIPDl
 Wds2ODeECC4uaHUbkm9h1x5xuj0Ku2pr/imLXnqz7+yP6JcgqWrDhEh0CtmFUy53s45N
 iazi7HlUALL28/0SKIwJlOje5fy9Gt9jfBKP9B6lKOTmhIIpaeQ50/5Un8Qj7VDhlucU
 t6hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMeAGLuDLolSBVuc0cC7fQcD9VylOuNI9E9132gVWtDFpJF+yS6gYgkbEt/RDepziDYPz9TX0iX2Xc@nongnu.org
X-Gm-Message-State: AOJu0YxMpMDC+fhSWv1FvJ95zcjBAHVvMX643i5k2Det+FnTSSY9A7yR
 05tiHcv0zPXIwaVRiR6/yhaefk9CCQa1HVuu9r6S10WxFdFjzh7gvCe2rUIteuLriRgLqjXqyJV
 XubI76pLt3dBjtmmDcwtIqNvksOSkwAHA5t+yK6+NfgxWFGALJQgJC+2F
X-Gm-Gg: AY/fxX5E/3F7pz7jrQSG6wWKwDhutN2Atob+guEW7orfj95TRI+lO3I6YWQmBfRW6aK
 1IIxi/J9fe3V2Pptfxm/W7JWFgZLHwfwTS5Jzja4yNRAwchaEpTDYyaWXn+9QklG5oV4fa7p0Na
 zGI04leVACVDxH4Mm/g3KK40m/PfTx4sGN4+s0Py1tgtk1cPnHFj2T9XxYAxELK3BXJDV7ZVu7u
 YoW/tGr+THeR/IvfIIDyvX1ui6QPZcpU6e6tZF+E4TDwRq33MGbC89suJu1qmEMwHv9XFoZnDZf
 TmGpGhyoDuxi4jdPrRTbm1qrZ17azPol8TePaKlAkAdvVRUGpns01QmveACCAcQ26hdH/9sbnfp
 PhobMuwYUB1YZm1V88YfUXp2t7QU9rdCkXV4L0KxjaTnpb64m
X-Received: by 2002:a05:600c:8a1a:10b0:480:1f6b:d495 with SMTP id
 5b1f17b1804b1-4801f6bd602mr15372125e9.32.1768558424700; 
 Fri, 16 Jan 2026 02:13:44 -0800 (PST)
X-Received: by 2002:a05:600c:8a1a:10b0:480:1f6b:d495 with SMTP id
 5b1f17b1804b1-4801f6bd602mr15371865e9.32.1768558424353; 
 Fri, 16 Jan 2026 02:13:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm43056875e9.10.2026.01.16.02.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:13:43 -0800 (PST)
Message-ID: <27218bae-9174-48bc-bc28-a804ea3e6e47@redhat.com>
Date: Fri, 16 Jan 2026 11:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/vfio/region: Create dmabuf for PCI BAR per
 region
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
 <20260116092950.15796-5-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116092950.15796-5-skolothumtho@nvidia.com>
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

On 1/16/26 10:29, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
> the BAR correctly in the host IOMMU page table.
> 
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/vfio/region.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/trace-events |  1 +
>   2 files changed, 65 insertions(+), 1 deletion(-)
> 
Reviewed-by: Cédric Le Goater <clg@redhat.com>


Thanks,

C.


