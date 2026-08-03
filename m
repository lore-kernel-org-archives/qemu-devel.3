Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E6C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0x9-0007yn-2s; Mon, 03 Aug 2026 18:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0x7-0007yb-2d
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wr0x5-0001q7-Kp
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 18:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785795366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5BdaKKK73o7lQfbuClw4Ua18U6kBfrqYC8+bDWrFpA=;
 b=SocIOd2EDWxDuKcyhkuklMTTgRYNWRB9fZBtaTImIeT/TzXuy/lRhlHnEhY/n/DyanEG2R
 /L7/yoD6Dz5lYrwpAwVz1Gkv3WgaqCaY7Z2l0t/4qV9yptbQLRC+LB5jxfy6INz3cLnFjM
 hSsmDsrfdpfj00d6y+cZhgXX8Kfg9z4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-u5H0PySKMa61Ybw5CXue5g-1; Mon, 03 Aug 2026 18:16:04 -0400
X-MC-Unique: u5H0PySKMa61Ybw5CXue5g-1
X-Mimecast-MFC-AGG-ID: u5H0PySKMa61Ybw5CXue5g_1785795364
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c16711b9473so364120266b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785795363; x=1786400163; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L5BdaKKK73o7lQfbuClw4Ua18U6kBfrqYC8+bDWrFpA=;
 b=iXm+lcwhpNEEee/uH4xGTcZnScr5/i4/F2lI1A+sXaVnsWQp+dgvXWejqwXBf3Tn97
 YV2WNNscmQw8xRtRaF2Fg/Fi9aWKddP56XHuGM1KQKWH7P4zX8lsnWBm1w7OTIPwB4Fv
 r9qR4NLJ73RIkDDp0rvDgJ4QA78tmxf4jhMj/GvIinUvRU03ptri5gYNIKd0IJup1e5c
 N5ji6ROYhW4Ki2XuZzQtEH7NHg2NeyTCK5i+vrpPtc0ZKzv+Ob8zaS78IJoY+9BfOgg9
 ylk+2x/DJ9u0ZI7nO+kVUgkbuFsqesDgXreLaRmn81EQ36KxYhDiTa2TJ9Lt3XM3d7Ee
 wyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785795363; x=1786400163;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5BdaKKK73o7lQfbuClw4Ua18U6kBfrqYC8+bDWrFpA=;
 b=sEJcwCwS79lSenN7F+3U/hhzZrWbuYs1eJYMVVRaeKKJGWx7Vdy0N5AkAote4P4bYv
 VlfCfPPqr35xMqBPr/KwWRpQBO0hebEz9E2MFCuEJtwf5U7Xt8tgensk58vh4ZfRHKNf
 VyfAT+xIvyW5lBG0nErgoCGUO4yR1xCDmIPzJFFVt91IDxhoJYpCVVaoQfpWkYZhuVjV
 nKyAE79Wo6yYiiVuEvPpfchJYmZ6eFEE61vKNWt46nRJjo9nO2WE1kpI0QbibokXY7p1
 JNaTH0RwosjETJcZAx4ZAwfK8xxqH1hYlqHI+t1vRYCrmoaPznJmLraAyH7gOqy4BwID
 gh5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH4vgy3Z8LoFQVzH7M7zQAj3wp33AomBOCLdP/oM0Y5fiVnD6uamCsYK50CQUEbI6FU6RkCy/7/ES9@nongnu.org
X-Gm-Message-State: AOJu0YyLyXjgjEujqQICoJCMZXaQCKMVgs+94bcKtMHiOcG/0cG7lhIY
 CnEDtyTbQsV2lFGzX+JIRyqm7Gzw6q0oggPPld2I7Z2EsW/ymM1xQKFfMmSJQk6OjTbJ6HH1yzX
 xiO0jQQkilT9HyINlqK+FTO2t8Fa+abangSajCOEEZEM6rCWdl/7O8fwm
X-Gm-Gg: AR+sD13zoSL7yONFisX0hbgK8AQaZbjrORxkKipCNY1hvVVp7LDDcQq5zT3UFFg6/RB
 Lz+twQb0/TaLb5HB1FDrxjaCE8U86cjgZD63wrvoe6/Wa2lUSrnpCDCyZPMqkJ6icapO3g3IYlf
 MzdhAZB7ZqI55xobTvocsECtCQB9pZXpe6/B4H7Jryih1slU8V8nfvwFRkC0WoAmhIpYabOHQBm
 +ykX7OK8ecBNOXJ27jpkDwdT8LnrTAWVr/xkn0t4ruycpU+fOfP6EUSUmLnFLNrkJMJJgVhzYr3
 f0uvkA9iuRr2rnc3LfqfvxAIo3b9hHoaX6ZN1S8tELrHIvQqJ5JLGviXXPniqFAQxwkU
X-Received: by 2002:a17:907:3e1a:b0:c16:5b32:32 with SMTP id
 a640c23a62f3a-c1fe8333f49mr959121966b.31.1785795363513; 
 Mon, 03 Aug 2026 15:16:03 -0700 (PDT)
X-Received: by 2002:a17:907:3e1a:b0:c16:5b32:32 with SMTP id
 a640c23a62f3a-c1fe8333f49mr959117566b.31.1785795362945; 
 Mon, 03 Aug 2026 15:16:02 -0700 (PDT)
Received: from redhat.com ([186.247.166.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd455f671sm559102366b.57.2026.08.03.15.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 15:16:02 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 2/8] amd_iommu: update PA, GVA and VA size macros
Message-ID: <20260803181045-mutt-send-email-mst@kernel.org>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-3-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123937.32743-3-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 06:09:31PM +0530, Sairaj Kodilkar wrote:
> Current implemenation supports upto 64 bit IOVA and upto 52 bit PA.
> Modify related macros so that guest can see right size.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  hw/i386/acpi-build.c | 2 +-
>  hw/i386/amd_iommu.c  | 2 +-
>  hw/i386/amd_iommu.h  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9446a9f862ca..e4ad01eec037 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1763,7 +1763,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>       */
>      build_append_int_noprefix(table_data,
>                               (1UL << 0) | /* EFRSup */
> -                             (40UL << 8), /* PASize */
> +                             AMDVI_PA_SIZE_52,
>                               4);
>      /* reserved */


If a macro repeats I'm fine with a define but you dropped
spec matching comment, not good. 

#define AMDVI_PA_SIZE_52        (52UL << 8) /* PASize */

Will help reader find it in the spec.

In fact:
/* PASize: 011_0100b = 52 bits */

would be even better.

Similarly, elsewhere.


>      build_append_int_noprefix(table_data, 0, 8);
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 789e09d6f2bc..7c52f9ade6e6 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2450,7 +2450,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
>                   0xff000000);
>      pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
>      pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
> -            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
> +            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
>  }
>  
>  static void amdvi_sysbus_reset(DeviceState *dev)
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca5121f..fe8f4a6cdc74 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -245,9 +245,9 @@
>  #define AMDVI_PAGE_SHIFT_4K 12
>  #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
>  
> -#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
> -#define AMDVI_MAX_PH_ADDR       (40UL << 8)
> -#define AMDVI_MAX_VA_ADDR       (48UL << 15)
> +#define AMDVI_GVA_SIZE_48       (2UL << 5)
> +#define AMDVI_PA_SIZE_52        (52UL << 8)
> +#define AMDVI_VA_SIZE_64        (64UL << 15)
>  
>  /* Completion Wait data size */
>  #define AMDVI_COMPLETION_DATA_SIZE    8
> -- 
> 2.34.1


