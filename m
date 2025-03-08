Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F0C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 17:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqyFG-0004Ad-Hg; Sat, 08 Mar 2025 12:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqyF8-00044E-G4
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqyF6-0004ED-R1
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741455943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OiSEtxsMXim8Bv5CT+c99VIk1OLmzMKlbF+t7ML2M4Q=;
 b=Wuyd7gJYRS3DVQe0bXNJbIFYGJJ3ey+Om8/R9vjVIJe+N4LGI7UHL5xx3Qcdyi/VdRyL/h
 5dQpmpjyo4yvBpjAO6MPax4NAVMJ/XO7DmayuXXAgNBVx7BCCTJHXq9oSJ9Z5RhR0yzfbl
 TjQVVM9wIAO+j5cTB/5n5AZTbh5mzz8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-7LCArr1zMEyxb0GVg3yioA-1; Sat, 08 Mar 2025 12:45:42 -0500
X-MC-Unique: 7LCArr1zMEyxb0GVg3yioA-1
X-Mimecast-MFC-AGG-ID: 7LCArr1zMEyxb0GVg3yioA_1741455941
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so1940255e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 09:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741455941; x=1742060741;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiSEtxsMXim8Bv5CT+c99VIk1OLmzMKlbF+t7ML2M4Q=;
 b=lOHYdiPca6Odd0Z7IpCr6XKc2uNQR4fBVS19+lINm4j1NDhswStU0eFeBQGK0BQqWb
 FCc8TPXM3XnIWjs70Dwu/H0dzkHVUaN8Xr3N2JFfFriHarN6tQiIKAqG6FI2Wt2U9l+S
 Zn7yRz8fAfNl5xl/WrZoyiy9LTV0JTYgFwsOlyM5I1heOOAeN5z0TQBKH3V2/4FOltyS
 OW4rJnxnS5itwIufFFhZU1dX7rofwcE6EmAGxi42A49K+znxwl1oe0Ej3w77fG2PDLNy
 C3jgr1XqMOHTrneDWR9SzWcZceK7d54S60hpMwE7Cvf6mwisLi208rzuZcsUZW5P3R5d
 zLlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnQaO6Ivse6wrfH4hfNNj/3NlyNc6LOmGVnNljFZVVMhX9cNybfMapSmwiAq9kInORtpYurtt10H/l@nongnu.org
X-Gm-Message-State: AOJu0YzNpyh5r0Z7+iP4SjHWmvOvBl/qzCpIGnO91ciRqQrVGH9fF1bx
 jKrVXsl0MXFA9iKhkWp3qQKvK9jTNFNRmvyNCa8Zh5+eqphHJWiwP8TsGhwFrK/dSy9fVOlO/vC
 FskRhisHz6XyOK7VZLpYyCx7Kqtg1ITa3UTzvEwpszLTdYeLC2Mxi
X-Gm-Gg: ASbGnctdjuYhu7mdgpuxhZ+zb1WfBbmT5fckbrmZJX+DcvtoEmStCqCQt2lqHifq/6D
 qHFXYbKVcTF2J7tmqpnVjFrpMwVhuyDWZyLzaB6E+zh113BT43YPf+mD/RLk6XjBozmny5Ze0Iu
 4tzknQA/mTQ80Ra0Jfrl20bETmBUzo838AI6elmKRsniCAnDe6Ag3BAq1c7lRoBEzUVP3gJdGvT
 +cBO71ZPOqy2LgLfr4g1U2gsWSxj0/uHOxAgpmd4vaDAk6cVtXk2aL6jFgPgQ5ZogrmCDI8EY0P
 rrGaqjydhgsvNGjTqenV2fovY6DTOJdINA6F9SzQO4+8rQX7kPTYQQ==
X-Received: by 2002:a05:600c:1c28:b0:43b:cd0a:970f with SMTP id
 5b1f17b1804b1-43c5a5e9848mr45574685e9.3.1741455940966; 
 Sat, 08 Mar 2025 09:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkbGyOJXk9qQT5agdoLRjf2IRXYK3n/XuLHUU+2F/UHAEJfpWT7nZRVhoi0OVhBCVGc0aDBQ==
X-Received: by 2002:a05:600c:1c28:b0:43b:cd0a:970f with SMTP id
 5b1f17b1804b1-43c5a5e9848mr45574495e9.3.1741455940549; 
 Sat, 08 Mar 2025 09:45:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c836sm119300235e9.37.2025.03.08.09.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 09:45:40 -0800 (PST)
Message-ID: <a887ae47-8b4b-48dd-b556-bbc1b601afdb@redhat.com>
Date: Sat, 8 Mar 2025 18:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/vfio: Compile iommufd.c once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-6-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250307180337.14811-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/7/25 19:03, Philippe Mathieu-Daudé wrote:
> Removing unused "exec/ram_addr.h" header allow to compile
> iommufd.c once for all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c   | 1 -
>   hw/vfio/meson.build | 6 +++---
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df61edffc08..42c8412bbf5 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,7 +25,6 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> -#include "exec/ram_addr.h"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 2972c6ff8de..fea6dbe88cd 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -4,9 +4,6 @@ vfio_ss.add(files(
>     'container.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
> -vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
> -  'iommufd.c',
> -))
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',
>     'pci-quirks.c',
> @@ -28,3 +25,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'migration-multifd.c',
>     'cpr.c',
>   ))
> +system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
> +  'iommufd.c',
> +))


