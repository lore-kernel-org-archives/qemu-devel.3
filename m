Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFAAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uENEL-0004Cy-Ul; Mon, 12 May 2025 03:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uENEK-0004Cj-E8
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uENEH-000705-L9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747033536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1d7JChI2pPPZ+gdywjpNHjCkQQa21GdbvspepyPGSU=;
 b=COD5EPYqwVW0wGiqHImTAyn5F+1YtIt6DZhhq5KLamlTX5eSY8BFiknQumQudHIDwGVQmE
 5skJTN7SCpnUOxOAF2wML+cHpZOJjZvNDluh20qV2pSNAhCMjCofGdHj1sUUmTMTZ8QH56
 WscmO5jNvKa/oKKLEE9qfk1AEn9F3Ac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-tWK6cSRhM8S4sSP_MJwwAA-1; Mon, 12 May 2025 03:05:34 -0400
X-MC-Unique: tWK6cSRhM8S4sSP_MJwwAA-1
X-Mimecast-MFC-AGG-ID: tWK6cSRhM8S4sSP_MJwwAA_1747033533
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b6cb5606so1752222f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747033533; x=1747638333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1d7JChI2pPPZ+gdywjpNHjCkQQa21GdbvspepyPGSU=;
 b=Ij9POlxmQLgvnVhK1hZ5xrADkLOAkBuDdQMjL/mAoOm9ino4J0YSDk+rSombJjAXYU
 iJz5l8W3Y84M7HycD6zvVFuapUqZCquomAqTsBOdtwpQ8Bgzr0bR5uRf2JB0EsjTaJbo
 f2Cy+BJSIoX/kT2WSrdxHkL0vz1Z5YUcYHnwAh6+CBZqp8AF59hbKNgplCqxCIvPqrEr
 Dim3sJDmqvcunTRk7kZnoUKVb9/Bjg5yUd4cW6QoT4HXaZg1zAmysqgiy72+wyHSfy0B
 xL8j6nJHzrOGO9Oob/cZ51fpbgFqW+K2F/G16my6yw97NghDG27oaTqhBpDnn2l+APex
 d+bg==
X-Gm-Message-State: AOJu0YyiDCX3+Zk/LsJNyVfSZN8b7gEbwrH6iEeKBzT4Ts2Uiesm+j94
 3c1mjj/9m7HuvGGY/U8J/i02IUY1YcSu55ZTzn59Y4fb2t30qSbFbiph6Dq9ZFOXUJxBpwlnEcT
 vJDFPLXraq2JdoxqNevIyihlE3zDxtO8pfgfOOqRyGrZERnsAbk+g
X-Gm-Gg: ASbGnctlTewMzUFK80K7V8eTXrmE7zeplgG59dG6Hz7VGPxneoio+mdt5jHgEssxO9X
 bD1vDD/JAUaUddeSy/2AAemM3sXbZUb/sIazR5ZFzfl6rlAqcLUdxHWvWaHt42jwwCv3icC51W7
 IYuKUd7xqNZUukcn/fK7BBNOUfCXs/O0IbOA02mGrnHYqSx/kc65MRageMkrrVEOJiBi5607WgC
 KQ+e7PhpaedgL6AIVzV6LF+ZqX6pHrZtzS32D+TGQwfivzRttWQuzO2yKUkjJcNAE0iaB+iWK2Z
 rPX+jw==
X-Received: by 2002:a05:6000:40dc:b0:3a0:b23c:15b9 with SMTP id
 ffacd0b85a97d-3a1f6429883mr9234227f8f.4.1747033533249; 
 Mon, 12 May 2025 00:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA5vlWq6odiQTEh527hv/FMQ2GK0t9gZvDaJ0jS6MEWqGJAEPDpHXtBUoBSmYI5Wp846dWgw==
X-Received: by 2002:a05:6000:40dc:b0:3a0:b23c:15b9 with SMTP id
 ffacd0b85a97d-3a1f6429883mr9234204f8f.4.1747033532877; 
 Mon, 12 May 2025 00:05:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddd53sm11430536f8f.1.2025.05.12.00.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 00:05:32 -0700 (PDT)
Date: Mon, 12 May 2025 03:05:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH v2 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Message-ID: <20250512025534-mutt-send-email-mst@kernel.org>
References: <20250512040537.15557-1-sarunkod@amd.com>
 <20250512040651.15590-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512040651.15590-1-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 12, 2025 at 09:36:51AM +0530, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>

A bit of history is missing here. Something like:


Before commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks
on XTSup feature") amd_iommu.c used to call kvm_enable_x2apic() when
xtsup is on, to support x2apic mode.


> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().

calls

> But if vCPUs <= 255 then it won't call kvm_enable_x2apic().

it -> the common code

> Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
> broken as it fails to call kvm_enable_x2apic().

You mean
 "is now broken as kvm_enable_x2apic() is required for x2apic to work".



> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>      amdvi_init(s);
>  }
> -- 
> 2.34.1


