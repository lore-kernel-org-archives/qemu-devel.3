Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA8CCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNyS-0002mU-N9; Mon, 27 Oct 2025 10:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNyK-0002m8-EN
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNyD-0003NT-Hi
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761574387;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JY2I+CuSnEJGmFKCR1qlFkMIZYu3OX8adq9vemAvaic=;
 b=PZvUdav3UBL2W9uh4KRkgN6MBsBNOQ4inkwGQmsu6C8i2mtTC/neeri0gVVUIQBVH/skND
 mx3uIcPS4hEUSUk84Ew+nmqRmZoSuhmOgWxgB+gF31CES0mrqV9Rz5DBLXKUJA4yzmGUUK
 LhAt3doPwZiw6PHphHkLO3dCMGZt9rk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-vH5ICB6BOomtIRT8pMTuqQ-1; Mon, 27 Oct 2025 10:13:05 -0400
X-MC-Unique: vH5ICB6BOomtIRT8pMTuqQ-1
X-Mimecast-MFC-AGG-ID: vH5ICB6BOomtIRT8pMTuqQ_1761574384
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47113538d8cso21160845e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761574384; x=1762179184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JY2I+CuSnEJGmFKCR1qlFkMIZYu3OX8adq9vemAvaic=;
 b=l++sTP5o9eWBUe8cJQV07kGe7aQEY19myMc01HsMYy3jG9JL+DqBmnLS2H88HqmkRS
 uWLTu3pT+SSJdVPZjThRXxITxqPg+fpNztPplGAoY6nscWbmjabbf/zpicdvRLp23CQI
 udwdznUW7IJXvCV5P2D+dDzO+mrN4HIClglWtQMHUx4aWoLY8curRsIkVWloT0erDMJ9
 dG4JlMboNoy7pZz3fz7GUjz16qDy2MMAqOU3qOTJ8ZtogEg1Xrm8Bt78KOMMbf8IourA
 DlVHRpkWn/HaG94eddr7WAgNXaSRYobE8DqscABAMP0Re/e/jKqvEorhzj9ZwiG3i79w
 Xqrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgvtw9EE6yzsLJR8eHcZfysW5M2vVv0Vhq2GTXe6wIzmgJCuYBnMAuj64WtT8P2u8XU1S86CcSC3+6@nongnu.org
X-Gm-Message-State: AOJu0YwKqFgm7bc+AE6QvFgkcuCo6g2B/TlvKvZvDUNwThME06SQq9Sp
 5yF6iEH44ofueU8xDd6rtptLhWhJAjc1A2RLkJhVjrxvdFATYhiNrcaioYtiuvuGZvLutH1tf8e
 sf8PBMRsbQyBRnbkQre26F/TZ8bZNLQxlYn608g6fQjfoeqaP2bFNHq5y
X-Gm-Gg: ASbGncvT/m5Kv8JAeHsDkA3xC63yoG5CNiduk0/wHhql380D5915OX67L4gL5+DNGnn
 lzYaf3DcKXfiCVibbSX1PDleqNBHoSQxd3yBfzttL0V0O3IaN5Ky2h4WSCYh/zLFZfcRiLA8774
 aVqVFm0Xg+y0fN532Xwa/HvQKwu5wWwkfRcj9OltMoEh/TtkY/9U8xRRmgVWkCsxFk8s95nAJC+
 7xz5GUdD58SiOJgrC2CroR7/nRJxx9cR2ZRwiqTviDFNIu1lvjiB/dxxxbU6IvNVJdWniigA9Ay
 cRo5yQ4zrugQq82kSIykwd9mKXy8P/AXC7CFuver5kcViSSmSXKxQfCC+Kc+PGFZFb08IZ1e0Wk
 XwzPbFfPF0BEPF2mUAJFzPTHncejkOauOGHBxLABbsq2N3g==
X-Received: by 2002:a05:600d:8303:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-475d43c85bemr51478245e9.16.1761574384245; 
 Mon, 27 Oct 2025 07:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8s35WcDa8996lClXOIJimns/C0qJooJhanZdE2Z13csYyt58Lq0V9i+9uR7BnswBCFqquA==
X-Received: by 2002:a05:600d:8303:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-475d43c85bemr51478045e9.16.1761574383810; 
 Mon, 27 Oct 2025 07:13:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd02ce46sm165455955e9.3.2025.10.27.07.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:13:03 -0700 (PDT)
Message-ID: <c21641fd-1a35-4b47-a361-bfc2daf7dbd7@redhat.com>
Date: Mon, 27 Oct 2025 15:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, nicolinc@nvidia.com,
 ddutile@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 jonathan.cameron@huawei.com
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
 <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/27/25 12:27 PM, Peter Maydell wrote:
> On Fri, 24 Oct 2025 at 09:46, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>> The virt machine now supports creating multiple SMMUv3 instances, each
>> associated with a separate PCIe root complex.
>>
>> Update the documentation with an example.
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Thanks. I have some minor word-smithing tweaks, but I'll just
> apply them to this patch in target-arm.next if you're OK with
> that:
>
>
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -224,23 +224,24 @@ SMMU configuration
>  """"""""""""""""""
>
>  Machine-wide SMMUv3 IOMMU
> -  See the machine-specific ``iommu`` option above. This allows specifying
> -  a single, machine-wide SMMUv3 instance that applies to all devices in
> -  the PCIe topology.
> +  Setting the machine-specific option ``iommu=smmuv3`` causes QEMU to
> +  create a single, machine-wide SMMUv3 instance that applies to all
> +  devices in the PCIe topology.
>
>    For information about selectively bypassing devices, refer to
>    ``docs/bypass-iommu.txt``.
>
>  User-creatable SMMUv3 devices
> -  Allows creating multiple user-defined SMMUv3 devices, each associated
> -  with a separate PCIe root complex. This is only permitted if the
> -  machine-wide SMMUv3 (``iommu=smmuv3``) option is not used.
> +  You can use the ``-device arm-smmuv3`` option to create multiple
> +  user-defined SMMUv3 devices, each associated with a separate PCIe
> +  root complex. This is only permitted if the machine-wide SMMUv3
> +  (``iommu=smmuv3``) option is not used. Each ``arm-smmuv3`` device
> +  uses the ``primary-bus`` sub-option to specify which PCIe root
> +  complex it is associated with.
>
>    This model is useful when you want to mirror a host configuration where
>    each NUMA node typically has its own SMMU, allowing the VM topology to
> -  align more closely with the host’s hardware layout. Supporting multiple
> -  SMMUv3 instances is also a prerequisite for future accelerated SMMUv3
> -  support.
> +  align more closely with the host’s hardware layout.
>
>    Example::
>
>
>
>
> (I deleted the sentence about SMMU acceleration because that
> isn't upstream yet. When it lands then we can update the
> docs if the version of it that lands can't support acceleration
> of a single machine-wide accelerator.)
>
> thanks
> -- PMM
>
Looks good to me as well

Fell free to add my R-b

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric





