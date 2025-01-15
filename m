Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2910C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 11:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY1H2-0003rL-J8; Wed, 15 Jan 2025 06:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY1H1-0003qr-8T
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY1Gz-0000mp-F2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 06:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736939359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp3W/euv0r0qhGV6FGZjL/PZ+k8+BYGIfdPd25Fr7yw=;
 b=AiNQ9ucKaA8L1oFdglNZ91hTTMPBp4LSzBZ/zaxiAmZ5h3MNN8YGiul7L2cP40RLQtCAkZ
 aUWtCnhbT8rHFPtiaFcSaroyPTaItWkkRWJswWIJU4O8D7yt7kHpMfY/Wr4pkZTN16AbDO
 01nTbAFjrYdQYFvctfIBn98gs7sbHyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-RPQYJp1APN-dAPtojSTgiA-1; Wed, 15 Jan 2025 06:09:18 -0500
X-MC-Unique: RPQYJp1APN-dAPtojSTgiA-1
X-Mimecast-MFC-AGG-ID: RPQYJp1APN-dAPtojSTgiA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so2538587f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 03:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736939357; x=1737544157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp3W/euv0r0qhGV6FGZjL/PZ+k8+BYGIfdPd25Fr7yw=;
 b=NNtSclGv7319HsLRcBaVnoj69GUWqTNzd+iQ2pyKYangCd3fz1kVJ0NSAAcEcVTcFq
 I9IGqi4N4Eho5xGn0YQhYXYlJNX1+5c4KMd2B9ZiFTxSl92Y4FRKzixUsM1bUDuGiC0C
 Nhv6f0kFXw4JXPn9DZCv43WGXpHMF8xs9rTFdfMPan3DaoKWwQchlOEssQq1EIIbOyNL
 0khzlxzOR7i13trnarA7wdgLPrqPMEF84ZL54NFE96PbSE+s7JZ9w9iwqdLsnwNxNcDM
 o6BGZVV+6+Lh5jgulhhI5zHWGZnEYtgXbOP0PyMrDES0xyBiacs9lG9yHm4uXrnaZ79G
 RDog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDbdapY4ERE8r7Yd4ctL61zeYc8E2blt/4qzGE739LFhhXk6mkoPiLTcWkY8ascepD3fkZ5pm4lAp@nongnu.org
X-Gm-Message-State: AOJu0YxZ20vWPfYww2bu/hKBrYkmbspZXQ2IfNuexpzlPfum54u2JE2k
 3+g59STGkX3fK6gEyCx97KhMSB0Ib7fvz/+TC99oFcbsJdCm3XPoxcaa5L8Kcc0zzOxKC+xDjbQ
 E/FR4dBQb7PVOGgiAsoSAT5eZdVsbeMW5V3WXWmrIQF2cWsCXsEXN
X-Gm-Gg: ASbGncuMcDzqSD2+QzHEy0ZZf3SzT1rccNnS9fdllk2qLlbkP0vWm9Ua4btNAWQ/zfV
 XkTQWs68O7tbWJ+gCbMnyFacIorvdYJZ2OiBdw9Fkt9po+RcheZcNMsjC6W3BI9LOfMKUIXlniI
 e198C97CdQpCvhsnsbIzwOi6bH9xQzAGTRo1amUNJmMk1t8bCNubjYLDhthy6REFkS4CyIclUIZ
 LtjRwuDmH6Ct2+T3CU1T1bxmj11iT111CO2e5TB18vO/rzZVw==
X-Received: by 2002:a5d:6489:0:b0:38b:da32:4f40 with SMTP id
 ffacd0b85a97d-38bda325049mr10094360f8f.2.1736939357170; 
 Wed, 15 Jan 2025 03:09:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjBjZqwkDRHQGNQexbwma8Lf2w9a+i4uejIYX1kRhn6RIQ+2tRuMIzzsXS14AdA49ut5IGFQ==
X-Received: by 2002:a5d:6489:0:b0:38b:da32:4f40 with SMTP id
 ffacd0b85a97d-38bda325049mr10094332f8f.2.1736939356795; 
 Wed, 15 Jan 2025 03:09:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:8f43:2a76:9f8c:65e8:ce7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38be4222dcdsm3342117f8f.51.2025.01.15.03.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 03:09:16 -0800 (PST)
Date: Wed, 15 Jan 2025 06:09:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/16] Prepare GHES driver to support error injection
Message-ID: <20250115060854-mutt-send-email-mst@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733561462.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

On Sat, Dec 07, 2024 at 09:54:06AM +0100, Mauro Carvalho Chehab wrote:
> Hi Michael,
> 
> Please ignore the patch series I sent yesterday:
> 	https://lore.kernel.org/qemu-devel/20241207093922.1efa02ec@foz.lan/T/#t
> 
> The git range was wrong, and it was supposed to be v6. This is the right one.
> It is based on the top of v9.2.0-rc3.
> 
> Could you please merge this series for ACPI stuff? All patches were already
> reviewed by Igor. The changes against v4 are just on some patch descriptions,
> plus the addition of Reviewed-by. No Code changes.
> 
> Thanks,
> Mauro


Still waiting for a version with minor nits fixed.

> -
> 
> During the development of a patch series meant to allow GHESv2 error injections,
> it was requested a change on how CPER offsets are calculated, by adding a new
> BIOS pointer and reworking the GHES logic. See:
> 
> https://lore.kernel.org/qemu-devel/cover.1726293808.git.mchehab+huawei@kernel.org/
> 
> Such change ended being a big patch, so several intermediate steps are needed,
> together with several cleanups and renames.
> 
> As agreed duing v10 review, I'll be splitting the big patch series into separate pull 
> requests, starting with the cleanup series. This is the first patch set, containing
> only such preparation patches.
> 
> The next series will contain the shift to use offsets from the location of the
> HEST table, together with a migration logic to make it compatible with 9.1.
> 
> ---
> 
> v5:
> - some changes at patches description and added some R-B;
> - no changes at the code.
> 
> v4:
> - merged a patch renaming the function which calculate offsets to:
>   get_hw_error_offsets(), to avoid the need of such change at the next
>   patch series;
> - removed a functional change at the logic which makes
>   the GHES record generation more generic;
> - a couple of trivial changes on patch descriptions and line break cleanups.
> 
> v3:
> - improved some patch descriptions;
> - some patches got reordered to better reflect the changes;
> - patch v2 08/15: acpi/ghes: Prepare to support multiple sources on ghes
>   was split on two patches. The first one is in this cleanup series:
>       acpi/ghes: Change ghes fill logic to work with only one source
>   contains just the simplification logic. The actual preparation will
>   be moved to this series:
>      https://lore.kernel.org/qemu-devel/cover.1727782588.git.mchehab+huawei@kernel.org/
> 
> v2: 
> - some indentation fixes;
> - some description improvements;
> - fixed a badly-solved merge conflict that ended renaming a parameter.
> 
> Mauro Carvalho Chehab (16):
>   acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
>   acpi/ghes: simplify acpi_ghes_record_errors() code
>   acpi/ghes: simplify the per-arch caller to build HEST table
>   acpi/ghes: better handle source_id and notification
>   acpi/ghes: Fix acpi_ghes_record_errors() argument
>   acpi/ghes: Remove a duplicated out of bounds check
>   acpi/ghes: Change the type for source_id
>   acpi/ghes: don't check if physical_address is not zero
>   acpi/ghes: make the GHES record generation more generic
>   acpi/ghes: better name GHES memory error function
>   acpi/ghes: don't crash QEMU if ghes GED is not found
>   acpi/ghes: rename etc/hardware_error file macros
>   acpi/ghes: better name the offset of the hardware error firmware
>   acpi/ghes: move offset calculus to a separate function
>   acpi/ghes: Change ghes fill logic to work with only one source
>   docs: acpi_hest_ghes: fix documentation for CPER size
> 
>  docs/specs/acpi_hest_ghes.rst  |   6 +-
>  hw/acpi/generic_event_device.c |   4 +-
>  hw/acpi/ghes-stub.c            |   2 +-
>  hw/acpi/ghes.c                 | 259 +++++++++++++++++++--------------
>  hw/arm/virt-acpi-build.c       |   5 +-
>  include/hw/acpi/ghes.h         |  16 +-
>  target/arm/kvm.c               |   2 +-
>  7 files changed, 169 insertions(+), 125 deletions(-)
> 
> -- 
> 2.47.1
> 


