Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87EFFB5E97
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2JOY-0008KW-NB; Mon, 16 Mar 2026 21:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w2JOX-0008J5-9K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:38:53 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w2JOV-0000BZ-1f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:38:52 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-128d7db88b9so6235244c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773711528; x=1774316328; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1LPXUOZsBcyyQGuBLg62UJNhCB9cOIxxlEAOkzYam7w=;
 b=RdYoNntnvft2Cm7nhOKfDOKcIyGhaXExEWKZxiBW50Wl1n120mudhJqTLV5+Nkmw5P
 8juLN+GYoZTnNWu4H/sAW07HM7PgCKoNLbjX2b3Drc62sawf9cmwCtUYOQUoPZ/RC7LT
 RCN2CVHXY7wCRZRs6++3D6qyxjqtMKVgy0l1WCCEsPQ01BBE5ukLp2oU8L44l+Dy3C9C
 3qGfwj4ymxJYRmhPGJHO/6FOP+wb3diN+jNqRfaIlAjAzhKLXFcD55BHxlCpk3iGnuum
 x/O1qYVrzM3kLr7e5X9hCYwI0oesU9sQ2iHI4XCpSWEuQYJ0rR1mBHa9EK3bubWg0IWk
 b86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773711528; x=1774316328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LPXUOZsBcyyQGuBLg62UJNhCB9cOIxxlEAOkzYam7w=;
 b=mZmQmZfC14R/8Ur6zAqO9wWpM83UF0vI/z9bF83SgrDFm3VkODYik18TopE5IKJZzs
 h2HdlxGJzVFLX1uXcmnt3hvh5/Ze2++tYZBrQka7C/1Ta9IJ1/GxSeSL8vm6Gfef9u78
 q1BPmA/iv/1Bv3P3RM2GyJWqmLKrQWtX+vyVO54XgjryRsrqBHZhamcc6yiVshYrLWUc
 6eriPCNvRIieWOcJrgZkK+WP72F6u6HgAo/lfPJo3+2ic+i1waEA3KpsrnmypPe4utR9
 +H+mBRBN5lay3psW/1I4U+AF+5+MjmGGZ3L3Oun9tdToL2O8ckinDH9bxVSBr44zv6v1
 Gp2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp2bsjUfXa2VkEwoJYCYjigi7wYb2vGTlReN1z0n1Bxr20bYND6jdSCJ0jtAAUFrys2CEPjIntMDC2@nongnu.org
X-Gm-Message-State: AOJu0Yzmz9FCHC1llr+RgG2iGTnMDHFtyf0A8nHBW1QqsNOEL3fdChRe
 EYtfIJzSdmNEZu+NOQfiOIF9dYOsXkV+CZF1JRt5Uz5pLKZbkomS+RWP
X-Gm-Gg: ATEYQzxwlXsdI0rVHFkRFKKgDErh7IgVP8eQy7yBWS/Atl+rEUoHOqb4qhDydDyyBBS
 hnT9SFJPnHth4C+yXnKR2TK88naDaKw+n7MNl49robj5YJeHQ7WcbBWt+ogwB/fT7GvImvO9Dn4
 GxiPJpk3BOtdddrizWImAVIOcCrulom0v7eR6COc7cKValQX6PC11Aeli0T67bA64epyRcTFb5h
 u3J1sv9BvvGWxrb6WDFAmEoyJ4I90tx5d/lb1CVBBmey7RLS7MABiasn3vh+atPMAb4c1Cldt0h
 mmO+JDHanj36qGbEOidSvuhCjeCTKgRJGgsgaJbrytkl/pwOZVwkISnKlhsrSpmHgpXLrHZA7dI
 pV6XZPBJsubXEkztg1wXDZM48ttUa4eTgL72/BlfDLzHlozv47GDq0n+4LAUJb6b1rhoe2PzuGA
 pdOICzN3TObpQamPkqZSInMhhSJrfNbTnVSxhBS8ktymFuNXXL5gvlQ3Z7aj2izL23VWoHu6xwQ
 RHQJC4wzytD9F7oR2t4asNylHFwyuM=
X-Received: by 2002:a05:7300:e887:b0:2bd:cfce:4c4b with SMTP id
 5a478bee46e88-2bea5434677mr6792719eec.2.1773711528331; 
 Mon, 16 Mar 2026 18:38:48 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab526d61sm20276839eec.17.2026.03.16.18.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:38:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:38:37 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Fengyuan Yu <15fengyuan@gmail.com>
Cc: Tao Tang <tangtao1634@phytium.com.cn>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, 
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
Message-ID: <abitWd_fz_tjNHfY@ZEVORN-PC.localdomain>
References: <cover.1773450180.git.15fengyuan@gmail.com>
 <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Fengyuan,
On Sat, Mar 14, 2026 at 09:11:36AM +0800, Fengyuan Yu wrote:
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
The commit message needs a body paragraph describing what
this helper library provides and why it's needed.

Something like the cover letter's "Motivation" section would work.

The subject alone doesn't tell a reader what translation
modes are covered or that this uses the iommu-testdev
framework.

> ---
>  MAINTAINERS                          |   6 +
>  tests/qtest/libqos/meson.build       |   3 +
>  tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
>  tests/qtest/libqos/qos-intel-iommu.h | 191 +++++++++++
>  4 files changed, 654 insertions(+)
>  create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>  create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 247799c817..876e00ff77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -151,6 +151,9 @@ F: target/i386/meson.build
>  F: tools/i386/
>  F: tests/functional/i386/
>  F: tests/functional/x86_64/
> +F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c
>  
This is wrong.

1) intel-iommu-test.c is already listed in the VT-d
section below. Adding it here creates a duplicate.

2) qos-intel-iommu* should go under the "QTest IOMMU
helpers" section (maintained by Tao Tang), following
the established pattern:

    QTest IOMMU helpers
    ...
    F: tests/qtest/libqos/qos-iommu*
    F: tests/qtest/libqos/qos-smmuv3*
    F: tests/qtest/libqos/qos-riscv-iommu*
  + F: tests/qtest/libqos/qos-intel-iommu*

3) iommu-intel-test.c is created in patch 2/2, so its
MAINTAINERS entry should be in that patch, not here.

The VT-d section additions below look correct for
iommu-intel-test.c, but drop the three lines here.

>  X86 VM file descriptor change on reset test
>  M: Ani Sinha <anisinha@redhat.com>
> @@ -4026,6 +4029,9 @@ F: hw/i386/intel_iommu_accel.*
>  F: include/hw/i386/intel_iommu.h
>  F: tests/functional/x86_64/test_intel_iommu.py
>  F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c

As noted above, only iommu-intel-test.c belongs in the
VT-d section (and should move to patch 2/2). The
qos-intel-iommu* glob belongs in "QTest IOMMU helpers".

[...]

> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QTEST_LIBQOS_INTEL_IOMMU_H
> +#define QTEST_LIBQOS_INTEL_IOMMU_H
> +
> +#include "hw/misc/iommu-testdev.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +
> +/*
> + * Intel IOMMU MMIO register base. This is the standard Q35 IOMMU address.
> + */
> +#define Q35_IOMMU_BASE            0xfed90000ULL
> +
This duplicates Q35_HOST_BRIDGE_IOMMU_ADDR from
include/hw/i386/intel_iommu.h, which is already
pulled in transitively via intel_iommu_internal.h.
Should just use Q35_HOST_BRIDGE_IOMMU_ADDR directly
to avoid the value going stale.

[...]

> +/*
> + * Translation modes supported by Intel IOMMU
> + */
> +typedef enum QVTDTransMode {
> +    QVTD_TM_LEGACY_PT,          /* Legacy pass-through mode */
> +    QVTD_TM_LEGACY_TRANS,       /* Legacy translated mode (4-level paging) */
> +    QVTD_TM_SCALABLE_PT,        /* Scalable pass-through mode */
> +    QVTD_TM_SCALABLE_SLT,       /* Scalable Second Level Translation */
> +    QVTD_TM_SCALABLE_FLT,       /* Scalable First Level Translation */
> +    QVTD_TM_SCALABLE_NESTED,    /* Scalable Nested Translation */
> +} QVTDTransMode;
> +
QVTD_TM_SCALABLE_NESTED is declared but never used in this series,
and qvtd_is_scalable() does not cover it. Either drop it or
include it in qvtd_is_scalable() with a comment that the test
case is not yet implemented.
is not yet implemented.

> +static inline bool qvtd_is_scalable(QVTDTransMode mode)
> +{
> +    return mode == QVTD_TM_SCALABLE_PT ||
> +           mode == QVTD_TM_SCALABLE_SLT ||
> +           mode == QVTD_TM_SCALABLE_FLT;
> +}
> +
> +typedef struct QVTDTestConfig {
> +    QVTDTransMode trans_mode;     /* Translation mode */
> +    uint64_t dma_gpa;             /* GPA for readback validation */
> +    uint32_t dma_len;             /* DMA length for testing */
> +    uint32_t expected_result;     /* Expected DMA result */
> +} QVTDTestConfig;
> +
> +typedef struct QVTDTestContext {
> +    QTestState *qts;              /* QTest state handle */
> +    QPCIDevice *dev;              /* PCI device handle */
> +    QPCIBar bar;                  /* PCI BAR for MMIO access */
> +    QVTDTestConfig config;        /* Test configuration */
> +    uint64_t iommu_base;          /* Intel IOMMU base address */
> +    uint32_t trans_status;        /* Translation configuration status */
> +    uint32_t dma_result;          /* DMA operation result */
> +    uint16_t sid;                 /* Source ID (bus:devfn) */
> +} QVTDTestContext;
> +
> +/*
> + * qvtd_setup_and_enable_translation - Complete translation setup and enable
> + *
> + * @ctx: Test context containing configuration and device handles
> + *
> + * Returns: Translation status (0 = success, non-zero = error)
> + *
> + * This function performs the complete translation setup sequence:
> + * 1. Builds VT-d structures (root/context entry, page tables)
> + * 2. Programs IOMMU registers and enables translation
> + * 3. Returns configuration status
> + */
> +uint32_t qvtd_setup_and_enable_translation(QVTDTestContext *ctx);
> +
> +/*
> + * qvtd_build_translation - Build Intel IOMMU translation structures
> + *
> + * @qts: QTest state handle
> + * @mode: Translation mode (pass-through or translated)
> + * @sid: Source ID (bus:devfn)
> + *
> + * Returns: Build status (0 = success, non-zero = error)
> + *
> + * Constructs all necessary VT-d translation structures in guest memory:
> + * - Root Entry for the device's bus
> + * - Context Entry for the device
> + * - Complete 4-level page table hierarchy (if translated mode)
> + */
> +uint32_t qvtd_build_translation(QTestState *qts, QVTDTransMode mode,
> +                                uint16_t sid);
> +
> +/*
> + * qvtd_program_regs - Program Intel IOMMU registers and enable translation
> + *
> + * @qts: QTest state handle
> + * @iommu_base: IOMMU base address
> + * @mode: Translation mode (scalable modes set RTADDR SMT bit)
> + *
> + * Programs IOMMU registers with the following sequence:
> + * 1. Set root table pointer (SRTP), with SMT bit for scalable mode
> + * 2. Setup invalidation queue (QIE)
> + * 3. Configure fault event MSI
> + * 4. Enable translation (TE)
> + *
> + * Each step verifies completion via GSTS register read-back.
> + */
> +void qvtd_program_regs(QTestState *qts, uint64_t iommu_base,
> +                        QVTDTransMode mode);
Line break and align with the first parameter.

There are similar issues elsewhere; please
double-check the entire codebase.


Thanks,
Chao
> +
> +/*
> + * qvtd_setup_translation_tables - Setup complete VT-d page table hierarchy
> + *
> + * @qts: QTest state handle
> + * @iova: Input Virtual Address to translate
> + * @mode: Translation mode
> + *
> + * This builds the 4-level page table structure for translating
> + * the given IOVA to PA through Intel VT-d. The structure is:
> + * - PML4 (Level 4): IOVA bits [47:39]
> + * - PDPT (Level 3): IOVA bits [38:30]
> + * - PD (Level 2): IOVA bits [29:21]
> + * - PT (Level 1): IOVA bits [20:12]
> + * - Page offset: IOVA bits [11:0]
> + *
> + * The function writes all necessary Page Table Entries (PTEs) to guest
> + * memory using qtest_writeq(), setting up the complete translation path
> + * that the VT-d hardware will traverse during DMA operations.
> + */
> +void qvtd_setup_translation_tables(QTestState *qts, uint64_t iova,
> +                                   QVTDTransMode mode);
> +
> +/* Calculate expected DMA result */
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx);
> +
> +/* Build DMA attributes for Intel VT-d */
> +uint32_t qvtd_build_dma_attrs(void);
> +
> +/* High-level test execution helpers */
> +void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
> +                               QPCIBar bar, uint64_t iommu_base,
> +                               const QVTDTestConfig *cfg);
> +
> +#endif /* QTEST_LIBQOS_INTEL_IOMMU_H */
> -- 
> 2.39.5
> 

