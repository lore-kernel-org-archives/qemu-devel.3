Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A15CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3Dz-0006S5-6H; Fri, 12 Jun 2026 10:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wY3Dt-0006Rc-RT
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wY3Dr-0008PK-1V
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781275861;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jqjLk29+ylgKafy2vZZGpLUZYRXAPBweaq2/Vw0ZvI=;
 b=YXlNw3epOVPfo7Kv4nCiKWsUTJUdHNuDPcf9G1M0XS1DelgYyKvCbknPr7WCmuL3NUULnz
 UwZYLcev0O46xJ987USQh9Gi9hyWZBVKhO2rQC160RAjCwkwOgxNWhmacZjkVQZSe8PISe
 algtF3Lnn/PAkPS1dWLBD21rzPuFNpc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-nsnfvkZKNY2-IK3PI7CakA-1; Fri, 12 Jun 2026 10:51:00 -0400
X-MC-Unique: nsnfvkZKNY2-IK3PI7CakA-1
X-Mimecast-MFC-AGG-ID: nsnfvkZKNY2-IK3PI7CakA_1781275859
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef0af9517so1033149f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 07:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781275859; x=1781880659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jqjLk29+ylgKafy2vZZGpLUZYRXAPBweaq2/Vw0ZvI=;
 b=Z8s9kSBAYh5OV8VwRUaAiZ2Q1en/iku1WdcO0yresTrXPly8uaEA+Fuf5wCIYrZfYE
 g7VeypjaJtW7f0y/68Z2NXa1zxCL70SVl1/CAxXxa/ci+SzFq1DzzO3PH1hjIFT7D6zJ
 wlcJvJFxDMBMiauIWt9NipnS5AVduZqHIuJvhet+DJM8RVlV+se7VW04WtjiSNYSXS0b
 iOPfRpowX32GGKe2i6jJewU3NErrATj4OUfmblDyq+KhR8Cq4yjZhI9eXL8nWqOmDrk+
 PHQPugANIu1X2uiOUHlQIq9uFMg0Qo/k6ZgyX5x19BYz4xbBY+I2euq+ssfE0/KdUA0z
 fLdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OCcghdx3TCEAnsYOG7/zd8QcgCSg8VMKlb9PkMECWiQ0eQlGAVXeVZOHlW2oleAmZ07eJaPPtAyiJ@nongnu.org
X-Gm-Message-State: AOJu0YzvXm3SZTdfJBY6vCecvzfReNs7pgTewN5228oVUTkh2RHcPLmq
 qRi0k2in7L/fKmlFt4rdg9M6MwDCLQSrrLTTJs1NoGmyE13flH4SQQkd//aACMkYKmDEEmeulUc
 i6haQvs7c/fmVLT5xPEFIUcwZMowblEpFfXSTmotb9Pjmc4tuI4FpLffL
X-Gm-Gg: Acq92OE4wSbR7dnXv8y/sxxXodmz201lquPrJ2YnJpH7qlIsVmf9Avavjf9GI0FLKCd
 LFsta8xYP6mc8N80LzOmv2VjlwXUip8oACs1EWKs3C85kD0FqHkbP/YITOA1wcEeCrvjp3lIoRJ
 acyCQLAKoopEvIYBmQmptofze1ugoLH/x9TwAoLSVG6beKdQWb3+Q2hVMrp+bpvB6p+NmJVgSV7
 MgiSbt8qd4j+0voLtWudm2KzpT9ma8nUpadkOcawV1kwA7NK/HbILPLhl6fE+qVaPAmu/vw8s2D
 v2LP+3oPh5LPW+CcYDCOtj0N1OlhM7oK1JhI4SelvzbKUJwsz6x5exYzrC4nX6ffS4JQuoVnC7P
 3+9tQD0VB1xvRifHc3juJe1yIKRnsv1ebXWkku7XUi9TlwTaNhjzBrxRFzGsKfXdUZw0jkg==
X-Received: by 2002:a05:600c:a0d:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490ec4e6ddfmr42693665e9.16.1781275858753; 
 Fri, 12 Jun 2026 07:50:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a0d:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490ec4e6ddfmr42693115e9.16.1781275858250; 
 Fri, 12 Jun 2026 07:50:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4921eeb69d7sm2668905e9.15.2026.06.12.07.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 07:50:57 -0700 (PDT)
Message-ID: <eb5f98a0-1fc4-4a5a-839f-8bc3afc44165@redhat.com>
Date: Fri, 12 Jun 2026 16:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/29] target/arm: Named CPU models for Arm64 on KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Sebastian Ott <sebott@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jinqian Yang <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260605083358.1320563-1-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 6/5/26 10:33 AM, Khushit Shah wrote:
> Hi All,
>
> This is the v2 RFC of the Named CPU models support for Arm64 in QEMU.
> v2 implements all of Planned items that were mentioned in v1.
> v1 link: https://lore.kernel.org/qemu-arm/20260513163356.3033159-1-shaju.abraham@nutanix.com/

Please could you share a branch. This fails to apply on mainline due to
recent changes

Thanks

Eric
>
> Background:
> =============================================================
> Currently QEMU only support -cpu host/max for KVM on Arm64. This disables
> live migration of VMs between hosts that differ in CPU features.
>
> This RFC proposes hierarchical named models for Arm64 under KVM, this
> provides strict contract of CPU features that will be exposed to the guest
> for a given named model. Models can be customized further with feature
> properties (like feat_AES=off, pauth=on, sve=off, etc...). 
>
> The design has three layers: an ARM ID-register field table (single
> source of truth for fields, safe-rules, defaults, arch-defined values); a
> property layer on top (single-field, fractional, and composite properties);
> and a hierarchical named-model layer that picks values for those properties
> with parent-chain inheritance.
>
> The series also implements QMP commands that lets the management layer query
> which models a host can run, what each model resolves to, and which feature
> values the host supports.
>
> Relationship with "customizable host model" series:
> ============================================================
> This RFC overlaps with customizable host model series [1]. The two series
> solve different parts of the same problem: [1] provides the lower layer
> (per-field SYSREG_<REG>_<FIELD> u64 properties on -cpu host,
> writable-mask probing, ID-register writeback).
>
> This series adds the layers above that, like:
> hierarchical named CPU models, default-from-zero baselines, fractional and
> composite properties for named models (sve, pauth, expose-cache),
> property/value names, and QMP introspection (blockers via safe-rule
> validation, supported values, new query-arm-cpu-props-info). This series
> also fixes the host-supports-Nested-Virtualziation-while-qemu-booted-without-it
> writeback case [2] that surfaces once [1]'s writeback lands.
>
> Long term plan is to rebase this series on top of [1]. Few difficulties
> in that will be augmenting the ID regs fields table with safe rules and
> default values, which Eric correctly mentioned in [1] that it cannot
> be inferred from Registers.json.
>
> For property names and values we have no strong preference,
> <SYSREG>_<REG>_<FIELD> with uint64 values or "feat_*" properties with
> string values (SYSREG_ID_AA64ISAR0_AES=2/feat_AES="pmull").
>
> [1]: https://lore.kernel.org/qemu-arm/20260519132905.145643-1-eric.auger@redhat.com/
> [2]: See patch 29 of this series.
>
> TL;DR examples:
>   # Boot with Grace
>   qemu-system-aarch64 -cpu grace-v1 -machine virt,accel=kvm ...
>
>   # Grace with a feature disabled
>   qemu-system-aarch64 -cpu grace-v1,feat_SHA1=off ...
>
>   # Host passthrough with individual feature control
>   qemu-system-aarch64 -cpu host,feat_AES=aes ...
>
>   # named CPU model with composite properties
>   qemu-system-aarch64 -cpu grace-v1,pauth=off,sve=on ...
>
>   # QMP -cpu host query-cpu-model-expansion:
>         "model": {
>             "name": "host",
>             "props": {
>                 "cpu_partnum": 3407,
>                 "feat_SM4": "on",
>                 "feat_SM3": "on",
>                 ....
>             }
>         }
>
>     # QMP -cpu graviton3-v1 query-cpu-model-expansion:
>         "model": {
>             "name": "graviton3-v1",
>             "props": {
>                 "cpu_partnum": 3392,
>                 "feat_SM4": "on",
>                 "feat_SM3": "on",
>                 "feat_RNDR": "on",
>                 ....
>             }
>         }
>
>     # QMP query-cpu-definitions (on Grace host) (blockers for graviton3-v1):
>         {
>             "name": "grace-v1",
>             "typename": "grace-v1-arm-cpu",
>             "static": false,
>             "deprecated": false
>         },
>         {
>             "name": "graviton3-v1",
>             "typename": "graviton3-v1-arm-cpu",
>             "unavailable-features": [
>                 "hw_prop_TGRAN4_2",
>                 "hw_prop_TGRAN64_2",
>                 "hw_prop_TGRAN16_2",
>                 "hw_prop_APA",
>                 "feat_RNDR"
>             ],
>             "static": false,
>             "deprecated": false
>         },
>         ....
>
>     # new QMP query-arm-cpu-props-info (on Grace host):
>         {
>             "name": "feat_SHA1",
>             "type": "boolean",
>             "supported-values": [
>                 "on",
>                 "off"
>             ]
>         },
>         {
>             "name": "feat_AES",
>             "type": "string",
>             "supported-values": [
>                 "off",
>                 "aes",
>                 "pmull"
>             ]
>         },
>         ....
>
> Changes since v1:
>   - Added `query-cpu-definitions` and `query-cpu-model-expansion` QMP
>     support for named models and accompanying properties.
>   - Introduced `query-arm-cpu-props-info` QMP command that returns
>     list of all newly supported properties for -cpu host, and its supported
>     values.
>   - Add composite properties for named models which acts as master "on"/"off"
>     switches for features that compose of broader range of ID registers
>     fields like pauth and sve.
>   - Added `expose-cache` composite with other cache related properties to
>     allow named models to expose cache information to the guest.
>   - Cache the host isar view with and without EL2 support, and make
>     -cpu host with writeback work on host kernel that supports
>     virtualization.
>   - Validate the cpu->isar.idregs before writing back to KVM to catch early
>     errors.
>   - Properties and models are now defined in file rather than using .h.inc 
>     files.
>
> Tested on NVIDIA Grace and AWS Graviton3 hosts (6.18); booted grace-v1,
> graviton3-v1, neoverse-v2-v1, neoverse-v1-v1, and -cpu host with per-feature
> overrides.
>
> Plans for v3:
>   - Some documentation and unit tests.
>   - More properties based on what more the latest kernel supports.
>   - pmu composite property.
>   - Trying to rebase on top of [1].
>   - Splitting this huge series into 3-4 sub series.
>
> Warm Regards,
> Khushit, Shaju
>
> Khushit Shah (20):
>   target/arm: Introduce data-structures for the ARM property layer
>   target/arm: Add all ARM64 properties to host model
>   target/arm: Add Nvidia Grace named model
>   target/arm/kvm: enable writable implementation ID registers
>   target/aarm: Validate cpu->isar.idregs[] before writeback
>   target/arm/kvm: handle DCZID_EL0 specially
>   target/arm: skip GIC, COPDBG and PMU fields during KVM writeback
>   target/arm: Add composite property type to model definitions
>   target/arm: define pauth composite property
>   target/arm: define sve composite property
>   target/arm: Introduce stub files required for qmp support
>   target/arm/qmp: add named models and properties to cpu-model-expansion
>   target/arm/kvm: introduce kvm_arm_get_host_isar helper
>   target/arm/qmp: add query-arm-cpu-props-info
>   target/arm: Report "off" for ID fields gated by vCPU init flags
>   target/arm/qmp: hook blockers in query-cpu-definitions
>   target/arm: Support exposing cache information for named cpu models
>   target/arm: Provide default cache hierarchy
>   target/arm: supported-values and blockers for CCSIDR cache properties
>   target/arm/kvm: fix host model writeback when kernel supports EL2
>
> Shaju Abraham (9):
>   target/arm: named_cpu_model: define containers for ID registers and
>     fields
>   target/arm: Add ID Register field descriptions in cpu-idregs.h.inc
>   target/arm: Add MIDR, REVIDR, AIDR and extra ID regs to cpu-sysregs
>   target/arm: Generate ARM64 ID registers and field tables
>   target/arm: Replace FIELD() macros with IDREG_FIELD expansion
>   target/arm: Define ARM properties
>   target/arm: Add ID register field helper functions
>   target/arm: Add named cpu model infra + graviton3 named model
>   target/arm/kvm: Writeback modified ID registers to KVM
>
>  hw/arm/virt.c                    |   28 +-
>  qapi/misc-arm.json               |   41 +
>  stubs/qmp-arm-gic.c              |    6 +
>  target/arm/arm-cpu-models-stub.c |   18 +
>  target/arm/arm-cpu-models.c      |  620 ++++++++++
>  target/arm/arm-cpu-models.h      |   49 +
>  target/arm/arm-cpu-props-stub.c  |   36 +
>  target/arm/arm-cpu-props.c       | 1212 +++++++++++++++++++
>  target/arm/arm-cpu-props.h       |   70 ++
>  target/arm/arm-qmp-cmds.c        |  128 +-
>  target/arm/cpu-features.h        |  246 +---
>  target/arm/cpu-idregs.c          |  508 ++++++++
>  target/arm/cpu-idregs.h          |  119 ++
>  target/arm/cpu-idregs.h.inc      | 1898 ++++++++++++++++++++++++++++++
>  target/arm/cpu-sysregs.h.inc     |    5 +
>  target/arm/cpu.h                 |    3 +
>  target/arm/cpu64.c               |   31 +-
>  target/arm/kvm-stub.c            |    7 +-
>  target/arm/kvm.c                 |  356 +++++-
>  target/arm/kvm_arm.h             |    7 +-
>  target/arm/meson.build           |   11 +-
>  target/arm/trace-events          |    1 +
>  22 files changed, 5148 insertions(+), 252 deletions(-)
>  create mode 100644 target/arm/arm-cpu-models-stub.c
>  create mode 100644 target/arm/arm-cpu-models.c
>  create mode 100644 target/arm/arm-cpu-models.h
>  create mode 100644 target/arm/arm-cpu-props-stub.c
>  create mode 100644 target/arm/arm-cpu-props.c
>  create mode 100644 target/arm/arm-cpu-props.h
>  create mode 100644 target/arm/cpu-idregs.c
>  create mode 100644 target/arm/cpu-idregs.h
>  create mode 100644 target/arm/cpu-idregs.h.inc
>


