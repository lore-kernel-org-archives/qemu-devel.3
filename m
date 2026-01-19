Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BA9D29C46
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsIA-000343-17; Mon, 19 Jan 2026 11:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhsI0-0002q1-4r
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vhsHt-0001rb-Fn
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768840771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Y+81BqXtnTt0WIPGkmFD9WCBbovx8aTEz4ne6LJY3k=;
 b=WOoyO49GreKVl0xaA1IM5JbaogFlCrbCjSrli3a+WwEPGSHHdUGQSVEG2gPoKVsWANLMME
 XKMLpKujD6OhpWKDv8D+8XqT9ep0AlPchWZdGBH+41bFsGh2AriJ6Z2Mfi8NZ15vLm46HU
 9KKmY4Dtv7DaY1/98mlGF7xFiFmk1T0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-_z8ZXiuFMrCa-Dqy_y9I0w-1; Mon, 19 Jan 2026 11:39:30 -0500
X-MC-Unique: _z8ZXiuFMrCa-Dqy_y9I0w-1
X-Mimecast-MFC-AGG-ID: _z8ZXiuFMrCa-Dqy_y9I0w_1768840769
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee9a53e8fso27584155e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 08:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768840769; x=1769445569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Y+81BqXtnTt0WIPGkmFD9WCBbovx8aTEz4ne6LJY3k=;
 b=C2QOXk5dLP2SNssDheil2wZhRaxUhhmsc1lpISCDFFxosPUcHMc1mz9MEIZSm9IWaw
 VC07/7y8cetvPZ+Yja06SeP8E7FxBYUJWxSbLQ+bz2yg9WRpkCFb6vacSgvDZ8sBkweg
 w7ghL+msiOIZshF5Oz7XvthjE0+OVpHD7RBzIX1l77f4Cx23I2LWbIC+KiMAHj9akFtJ
 GvECgjbWgSr7jlijP1zJUHpoeWA9ho492zx5NC7RmijW48OXEjaFEEPeqVmw4FmmObFu
 XDLgvZuSTBry/KHLrbaGdBwPRCIu1LcoZAcPeCL0O5XDGQDsemxlLjf2/NDiLTTHHGNF
 o+VA==
X-Gm-Message-State: AOJu0YwhkFqrdDKSQBxFkw+ds19Ez5cjAvdOJU9dSBNlu+OL+QrD9nTe
 NFoqjr+i9t4BfQa4ArrxGZIO9PpytEJfq9w5x/HDOAS70NXpFjwkxB6owxacZLj1758CRRmuNU2
 hhFcRtvWUjGY+blUIoneOF3pzhoHXugrPRW0PW3PoxOFZbO28Oa3I3fIC
X-Gm-Gg: AY/fxX5iTa/KhREvhwGgAvGmTzmzYP3miILY2w1Sso2otEMYk+RkhcjniQqworvT8PF
 hAVbXR8+aLKtOHH+RQAnzuIHK8zhq0WaELXQF2pM/9+FHGazlUT6mM04BaOjJkT7I78PhebdC5x
 qG3V9eIIqY66TYav+vjaLZW0FnjPVkHmVDkq5+iQ0rnQFgr5aHMQDWsujczs7ulgKU7UX/FR2QZ
 8wf+EaIFm5MpdSRC4GhtRLAAM5Ei7apQqja3nyV5cOYnu2mzXRMqAYvRCAfZhrvm6jIe3xAnJVl
 7OTQgvKO01Q7ySqYOovptrlu9LHWqUdOor+zs6WDnIvWJM/hWqjOvilTuelZfWOWFbYLGP8IWQw
 rOpYwIVkAb9qv33m4a8TgTBhtAKiz74XLij7kIbKMwYITz2MJteThzEs0lQ==
X-Received: by 2002:a05:600c:8886:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4802168de81mr113360445e9.36.1768840768919; 
 Mon, 19 Jan 2026 08:39:28 -0800 (PST)
X-Received: by 2002:a05:600c:8886:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-4802168de81mr113360145e9.36.1768840768397; 
 Mon, 19 Jan 2026 08:39:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e93de40sm88755305e9.0.2026.01.19.08.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 08:39:27 -0800 (PST)
Message-ID: <fba5cd61-0748-4e16-a00f-a0d20878a40f@redhat.com>
Date: Mon, 19 Jan 2026 17:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 0/8] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 1/19/26 5:11 PM, Tao Tang wrote:
> Changes since v8:
> 1. Define new generic libqos helpers (qos-iommu-testdev) as Eric suggested. Some
>    common functions are removed into it so that future IOMMU implementations can
>    also reuse them.
> 2. iommu-testdev device enhancements:
>   - add GPA registers for direct GPA readback validation
>   - improved DMA semantics: "dma_pending" → "dma_armed" for clearer state machine
>   - also related doc updates in docs/specs/iommu-testdev.rst
> 3. Update some commits' Reviewed-by tags
>
> I also validated the series with Pierrick's qemu-ci workflow, and all jobs passed;
> the CI run is available at:
>
> https://github.com/hnusdr/qemu/actions/runs/21112869093
>
> Motivation
> ----------
>
> Currently, thoroughly testing IOMMU emulation (e.g., ARM SMMUv3) requires
> a significant software stack. We need to boot a full guest operating
> system (like Linux) with the appropriate drivers (e.g., IOMMUFD) and rely
> on firmware (e.g., ACPI with IORT tables or Hafnium) to correctly
> configure the IOMMU and orchestrate DMA from a peripheral device.
>
> This dependency on a complex software stack presents several challenges:
>
> * High Barrier to Entry: Writing targeted tests for specific IOMMU
>     features (like fault handling, specific translation regimes, etc.)
>     becomes cumbersome.
>
> * Difficult to Debug: It's hard to distinguish whether a bug originates
>     from the IOMMU emulation itself, the guest driver, the firmware
>     tables, or the guest kernel's configuration.
>
> * Slow Iteration: The need to boot a full guest OS slows down the
>     development and testing cycle.
>
> The primary goal of this work is to create a lightweight, self-contained
> testing environment that allows us to exercise the IOMMU's core logic
> directly at the qtest level, removing the need for any guest-side software.
>
> Our Approach: A Dedicated Test Framework
> -----------------------------------------
>
> To achieve this, we introduce three main components:
>
> * A minimal hardware device: iommu-testdev
> * Some reusable IOMMU helper libraries: libqos/qos-smmuv3 and qos-iommu-testdev
> * A comprehensive qtest suite: iommu-smmuv3-test
>
> The iommu-testdev is intentionally not a conformant, general-purpose PCIe
> or platform device. It is a purpose-built, highly simplified "DMA engine"
> designed to be analogous to a minimal PCIe Root Complex that bypasses the
> full, realistic topology (Host Bridges, Switches, Endpoints) to provide a
> direct, programmable path for a DMA request to reach the IOMMU. Its sole
> purpose is to trigger a DMA transaction when its registers are written to,
> making it perfectly suited for direct control from a test environment like
> qtest.
>
> The Qtest Framework
> -------------------
>
> The new qtest (iommu-smmuv3-test.c) serves as the "bare-metal driver"
> for both the IOMMU and the iommu-testdev. It leverages the libqos helper
> library to manually perform all the setup that would typically be handled
> by the guest kernel and firmware, but in a completely controlled and
> predictable manner:
>
> 1.  IOMMU Configuration: It directly initializes the SMMU's registers to a
>     known state using helper functions from qos-smmuv3 and qos-iommu-testdev.
>
> 2.  Translation Structure Setup: It uses the libqos library to construct
>     the necessary translation structures in memory, including Stream Table
>     Entries (STEs), Context Descriptors (CDs), and Page Tables (PTEs).
>
> 3.  DMA Trigger: It programs the iommu-testdev to initiate a DMA operation
>     targeting a specific IOVA with configurable attributes.
>
> 4.  Verification: It waits for the transaction to complete and verifies
>     that the memory was accessed correctly after address translation by
>     the IOMMU.
>
> This framework provides a solid and extensible foundation for validating
> the IOMMU's core translation paths. The current test suite covers:
>
> - Stage 1 only translation (VA -> PA via CD page tables)
> - Stage 2 only translation (IPA -> PA via STE S2 tables)
> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
>
> The infrastructure is designed to be extended to support additional
> security spaces and IOMMU features.
>
>
> Testing:
> --------
> QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
>   ./build/tests/qtest/iommu-smmuv3-test --tap -k
>
>
> If you want to check coverage report, please follow instructions below
> which are shared by Pierrick in previous review [1]
>
> # install gcovr if not already installed, `sudo apt install gcovr`
> # on ubuntu for example
> $ export CFLAGS="--coverage"
> $ ./configure --target-list=aarch64-softmmu
> $ ninja -C build
> $ QTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
>   ./build/tests/qtest/iommu-smmuv3-test
> $ rm -rf build/coverage_html
> $ mkdir build/coverage_html
> $ gcovr \
>       --gcov-ignore-parse-errors suspicious_hits.warn \
>       --gcov-ignore-parse-errors negative_hits.warn \
>       --merge-mode-functions=separate \
>       --html-details build/coverage_html/index.html \
>       --filter 'hw/arm/smmu*'
> # check the version of gcovr if meeting some unsupported options error.
> # Upgrading to 8.4 version may resolve the error.
> $ gcovr --version
> $ pip install --user --upgrade gcovr
> $ echo file://$(pwd)/build/coverage_html/index.html
> # open this in browser by clicking on your terminal
>
> [1] https://lore.kernel.org/qemu-devel/a361b46f-2173-4c98-a5d3-6b4d2ac004af@linaro.org/
>
> Major Changes from v8 to v9:
> -----------------------------
>   - Define new generic libqos helpers (qos-iommu-testdev) as Eric suggested.
>   - iommu-testdev device enhancements.
>   - This series is also saved in github repo [6]
> [6] https://github.com/hnusdr/qemu/tree/iommu-testdev-v9-community
>
> Major Changes from v7 to v8:
> -----------------------------
>   - Fix uint64_t formatting issue by using PRIx64 for portability
>   - Validate the series with Pierrick's qemu-ci workflow; all jobs passed
>   - This series is also saved in github repo [5]
> [5] https://github.com/hnusdr/qemu/tree/iommu-testdev-v8-community
>
>
> Major Changes from v6 to v7:
> -----------------------------
>   - Split the smmuv3-common.h work into smaller patches
>     (registerfields conversion, NSCFG bits, helper setters)
>   - Add MAINTAINERS entries for iommu-testdev and qos-smmuv3 helpers
>   - Tighten documentation wording and update the DMA test pattern value
>   - Simplify qtest PCI device discovery and rename QSMMU_IOVA constant
>   - This series is also saved in github repo [4]
>
> [4] https://github.com/hnusdr/qemu/tree/iommu-testdev-v7-community
>
>
> Major Changes from v5 to v6:
> -----------------------------
>   - Split batch testing into individual test cases per translation mode
>   - Removed cleanup functions and related codes or comments
>   - Improved error handling with explicit assertions
>   - Add coverage build and test instructions shared by Pierrick
>   - Keep Reviewed-by and Tested-by from Pierrick's review
>   - This series is also saved in github repo [2]
>
> [2] https://github.com/hnusdr/qemu/tree/iommu-testdev-v6-community
>
>
> Major Changes from v4 to v5:
> -----------------------------
>  - Remove a duplicated patch that was accidentally included in v4.
>
>
> Major Changes from v3 to v4:
> -----------------------------
>
> 1. Added shared smmuv3-common.h so both the device and libqos consume the same
>    STE/CD/register definitions as Alex suggested [3]
> 2. Slimmed iommu-testdev down to a pure DMA trigger with a tighter MMIO
>    contract (new doorbell helper, simplified attributes/errors).
> 3. Updated `qos-smmuv3` and the qtest so they include the common header,
>    honor per-test expected results, and rely solely on the streamlined device
>    interface.
> 4. Compacted changes of v2 to v3.
>
> [3] https://lore.kernel.org/qemu-devel/87zf8jk244.fsf@draig.linaro.org/
>
>
> Major Changes from v2 to v3:
> -----------------------------
>
> 1. Generalization/Renaming: rebranded `smmu-testdev` → `iommu-testdev` (code,
>    headers, docs) to reflect the broadened scope.
> 2. Separation of concerns: iommu-testdev is now a pure DMA trigger; all
>    SMMUv3-specific setup (STE/CD/page tables, multi-mode support, space offsets)
>    lives in `qos-smmuv3.{c,h}` and is consumed by the new qtest.
> 3. Improved modularity & coverage: the stacked design (device + helper + qtest)
>    made it straightforward to add S1/S2/Nested tests, a cleaner config system,
>    and clearer validation logic.
> 4. Code/documentation quality: added tracepoints, better error handling/naming,
>    and refreshed `docs/specs/iommu-testdev.rst` with the new layout.
>
> Future Work
> -----------
>
> The current implementation focuses on basic translation path validation
> in the Non-Secure address space. Future extensions could include:
>
> * Multi-space testing (Secure, Root, Realm) for SMMUv3
> * Support for other IOMMU types (Intel VT-d, AMD-Vi, RISC-V IOMMU)
>
> Tao Tang (8):
>   hw/arm/smmuv3: Extract common definitions to smmuv3-common.h
>   hw/arm/smmuv3-common: Define STE/CD fields via registerfields
>   hw/misc: Introduce iommu-testdev for bare-metal IOMMU testing
>   hw/arm/smmuv3-common: Add NSCFG bit definition for CD
>   hw/arm/smmuv3-common: Add STE/CD set helpers for repeated field setup
>   tests/qtest: Add libqos iommu-testdev helpers
>   tests/qtest/libqos: Add SMMUv3 helper library
>   tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev
>
>  MAINTAINERS                            |  13 +
>  docs/specs/index.rst                   |   1 +
>  docs/specs/iommu-testdev.rst           | 138 ++++++
>  hw/arm/smmuv3-internal.h               | 255 +---------
>  hw/misc/Kconfig                        |   5 +
>  hw/misc/iommu-testdev.c                | 318 +++++++++++++
>  hw/misc/meson.build                    |   1 +
>  hw/misc/trace-events                   |  10 +
>  include/hw/arm/smmuv3-common.h         | 423 +++++++++++++++++
>  include/hw/misc/iommu-testdev.h        |  87 ++++
>  tests/qtest/iommu-smmuv3-test.c        | 132 ++++++
>  tests/qtest/libqos/meson.build         |   4 +
>  tests/qtest/libqos/qos-iommu-testdev.c |  82 ++++
>  tests/qtest/libqos/qos-iommu-testdev.h |  43 ++
>  tests/qtest/libqos/qos-smmuv3.c        | 629 +++++++++++++++++++++++++
>  tests/qtest/libqos/qos-smmuv3.h        | 242 ++++++++++
>  tests/qtest/meson.build                |   3 +
>  17 files changed, 2132 insertions(+), 254 deletions(-)
>  create mode 100644 docs/specs/iommu-testdev.rst
>  create mode 100644 hw/misc/iommu-testdev.c
>  create mode 100644 include/hw/arm/smmuv3-common.h
>  create mode 100644 include/hw/misc/iommu-testdev.h
>  create mode 100644 tests/qtest/iommu-smmuv3-test.c
>  create mode 100644 tests/qtest/libqos/qos-iommu-testdev.c
>  create mode 100644 tests/qtest/libqos/qos-iommu-testdev.h
>  create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>  create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>
For the whole series:

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


