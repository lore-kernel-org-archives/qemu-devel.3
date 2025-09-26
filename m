Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19DFCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27VK-0007nP-4m; Fri, 26 Sep 2025 08:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v27VG-0007mw-E5
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v27V8-0001Af-10
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758889467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTT04tnhX0vjT598cFOtE9iEhlek+7246XVCj25YhEg=;
 b=eiKIYq93SQHwTu+c+w0MRv+FE9tnsbfAxCJxmwqye/NiWCPTW8MozIOxKoriNtq0Yf40+A
 NV8MmNeOFAhoyXEe4Kb4950v1B8iiU9PAECPMj7m5ujH3ZHvUus9VMSSpCyFlwXzuPhpZe
 +BFl08angi7e9AQswrMHoymXfkmUCLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-BpFSuYrnMfKG4aIRHmp_OQ-1; Fri, 26 Sep 2025 08:24:26 -0400
X-MC-Unique: BpFSuYrnMfKG4aIRHmp_OQ-1
X-Mimecast-MFC-AGG-ID: BpFSuYrnMfKG4aIRHmp_OQ_1758889465
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f3787688b0so1065998f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758889465; x=1759494265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTT04tnhX0vjT598cFOtE9iEhlek+7246XVCj25YhEg=;
 b=bUGurvFwoRcz3CNWqBdDIA9l0n9K5UBpRAjUCBT1fdD7oOwwzGrJUPf1nPpDVRaYEL
 CZGf4SBMA5Ff9A1YNDifJV4FgFGcWPjbRxhCE8PcNzKjqAp4dRs3cdCeEML+nF+1+ulW
 wVsCgrfRy/wiXud6gmbKxkEk5Zx58wdI8/AiGLMR2+nEfO8c+s9mZZnyHIcG4bS4cqvy
 BhpLhbeikCfquC1i7NBLN39Xe0sCdSxGxKCJTCFnhZSJIWUpAA5LoFX1s1g9WHxbYcNW
 5uiavyj5A3svdFzlnuk4Pjnx+l/DzHkGuiKHEoqRr3y2JAbiy2vvbRzDC7z08bXqgQqX
 yrCA==
X-Gm-Message-State: AOJu0YyXUmbfpy42P3YcT9PEk2pNzWKPwByQIqDGkWSMwSE8LlqKd/Ht
 joMhpSPYsSSw+hrN7FsNO1aPHcJysQxwajh6F8d11olKS7i5/ZTFn/rH65ZdHczesEThICk3XjB
 EsVuoi3ZvnheQ/Qt0H5SlxwGhFPFkea65QKNvY717IfILlgjMC9C1mT8g
X-Gm-Gg: ASbGncu3+wug3+e7CzURTHMwZg4Se/nFR0oo6SdvxaR6up+FyBPCxIkz29BMDYXZwQa
 7KZzDaJmCmhXW3YvgN5oEhdzS7Ufuvp1x+eC7bcTXGGlsXwYLtdlvW5d4gUF8QuY2ZZsSDtyk7W
 oEAAiXocPOCvvnmXmqjw24zU3QxZFfVRM+YV8vS+BQV3ufTsfhPA0EZwRwQ6PFU8zJETOZEfrRn
 MAwooeLHZsxZREwQw9uOILpPWMDqFQsf22VwoD/KgmK9s5TTJdB+WL4Wd60S4z5068AIw+OMZ79
 sZ8drpj4i1KaFwNRSjk8FPZ427wlFxb0F5uEfzj49fm3urdFtrg+Sm1yEnH5e4GdSb7XZvzH+Jg
 OubPzqpOmUBA=
X-Received: by 2002:a05:6000:240c:b0:3fe:efa8:7f1d with SMTP id
 ffacd0b85a97d-40e469db7admr6048929f8f.7.1758889464685; 
 Fri, 26 Sep 2025 05:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe97aTIX9xiJFvwXhKzSfem2JxbxEMWf9GpBriS5zYnxucPIhCHPBbq98jBD9+3gIzk53OgA==
X-Received: by 2002:a05:6000:240c:b0:3fe:efa8:7f1d with SMTP id
 ffacd0b85a97d-40e469db7admr6048906f8f.7.1758889464239; 
 Fri, 26 Sep 2025 05:24:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc86c5958sm6863235f8f.57.2025.09.26.05.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:24:23 -0700 (PDT)
Message-ID: <e439e75e-6d1c-4209-aa41-f3e9d5051462@redhat.com>
Date: Fri, 26 Sep 2025 14:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hw/arm/smmuv3: Add initial support for Secure
 State
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 9/25/25 6:26 PM, Tao Tang wrote:
> Hi all,
>
> This is the second version of the patch series to introduce initial
> support for Secure SMMUv3 emulation in QEMU.
>
> This version has been significantly restructured based on the excellent
> feedback received on the RFC.
>
> This version addresses the major points raised during the RFC review.
> Nearly all issues identified in v1 have been resolved. The most
> significant changes include:
>
>   - The entire series has been refactored to use a "banked register"
>   architecture. This new design serves as a solid base for all secure
>   functionality and significantly reduces code duplication.
>
>   - The large refactoring patch from v1 has been split into smaller, more
>   focused commits (e.g., STE parsing, page table handling, and TLB
>   management) to make the review process easier.
>
>   - Support for the complex SEL2 feature (Secure Stage 2) has been
>   deferred to a future series to reduce the scope of this RFC.
>
>   - The mechanism for propagating the security context now correctly uses
>   the ARMSecuritySpace attribute from the incoming transaction. This
>   ensures the SMMU's handling of security is aligned with the rest of the
>   QEMU ARM architecture.
>
>
> The series now begins with two preparatory patches that fix pre-existing
> bugs in the SMMUv3 model. The first of these, which corrects the CR0
> reserved mask, has already been reviewed by Eric.
>
>   - hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0 register
>   - hw/arm/smmuv3: Correct SMMUEN field name in CR0
>
> The subsequent patches implement the Secure SMMUv3 feature, refactored
> to address the feedback from the v1 RFC.

could you shared a branch? It does not seem to apply on master.

Thanks

Eric
>
>
> Changes from v1 RFC:
>
>   - The entire feature implementation has been refactored to use a "banked
>   register" approach. This significantly reduces code duplication.
>
>   - Support for the SEL2 feature (Secure Stage 2) has been deferred. As
>   Mostafa pointed out, a correct implementation is complex and depends on
>   FEAT_TTST. This will be addressed in a separate, future patch series.
>   As a result, this series now supports the following flows:
>
>     - Non-secure Stage 1, Stage 2, and nested translations.
>
>     - Secure Stage 1-only translations.
>
>     - Nested translations (Secure Stage 1 + Non-secure Stage 2), with a
>   fault generated if a Secure Stage 2 translation is required.
>
>   - Writability checks for various registers (both secure and non-secure)
>   have been hardened to ensure that enable bits are correctly checked.
>
> The series has been successfully validated with several test setups:
>
>   - An environment using OP-TEE, Hafnium, and a custom platform
>   device as V1 series described.
>
>   - A new, self-contained test device (smmu-testdev) built upon the
>   QTest framework, which will be submitted as a separate series as
>   discussed here:
>     https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg05365.html
>
>   - The existing non-secure functionality was regression-tested using
>   PCIe passthrough to a KVM guest running inside a TCG guest.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>
> Tao Tang (14):
>   hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0 register
>   hw/arm/smmuv3: Correct SMMUEN field name in CR0
>   hw/arm/smmuv3: Introduce secure registers and commands
>   refactor: Move ARMSecuritySpace to a common header
>   hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
>   hw/arm/smmuv3: Add separate address space for secure SMMU accesses
>   hw/arm/smmuv3: Make Configuration Cache security-state aware
>   hw/arm/smmuv3: Add security-state handling for page table walks
>   hw/arm/smmuv3: Add secure TLB entry management
>   hw/arm/smmuv3: Add banked support for queues and error handling
>   hw/arm/smmuv3: Harden security checks in MMIO handlers
>   hw/arm/smmuv3: Use iommu_index to represent the security context
>   hw/arm/smmuv3: Add property to enable Secure SMMU support
>   hw/arm/smmuv3: Optional Secure bank migration via subsections
>
>  hw/arm/smmu-common.c          |  151 ++++-
>  hw/arm/smmu-internal.h        |    7 +
>  hw/arm/smmuv3-internal.h      |  114 +++-
>  hw/arm/smmuv3.c               | 1130 +++++++++++++++++++++++++--------
>  hw/arm/trace-events           |    9 +-
>  hw/arm/virt.c                 |    5 +
>  include/hw/arm/arm-security.h |   54 ++
>  include/hw/arm/smmu-common.h  |   60 +-
>  include/hw/arm/smmuv3.h       |   35 +-
>  target/arm/cpu.h              |   25 +-
>  10 files changed, 1257 insertions(+), 333 deletions(-)
>  create mode 100644 include/hw/arm/arm-security.h
>
> --
> 2.34.1
>


