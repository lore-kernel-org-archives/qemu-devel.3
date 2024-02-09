Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC5C4829D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTJK-00012y-Cc; Fri, 09 Feb 2024 11:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rYTJF-000127-Up
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rYTJ6-00064G-I2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707494451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2j1cv9GE/cSVQNx82treSczXBYP5IBlUz2FWE4zgQFE=;
 b=PmtPAzX0YkTQmDaUqx/LWw//disDC2oYVB0/lf+ZQF9LRLuIkslNJVigJa9VZZjMqGKUZw
 368qOyalDAdilG/4AJ4sVUiYToOCIY6g9ZuAinUTTNrv27EgTrFw9om6+GI+smRFIWUz2B
 K4YI8Pw8GB+xigerHIbYXgJpDGc+cgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-dZj9QjKKM4mT5zHmXPRRwA-1; Fri, 09 Feb 2024 11:00:45 -0500
X-MC-Unique: dZj9QjKKM4mT5zHmXPRRwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DF0985A597;
 Fri,  9 Feb 2024 16:00:44 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE2B492BC6;
 Fri,  9 Feb 2024 16:00:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, haibo.xu@linaro.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com
Subject: [RFC v2 0/5] ARM Nested Virt Support
Date: Fri,  9 Feb 2024 16:59:12 +0100
Message-ID: <20240209160039.677865-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series adds ARM Nested Virtualization support in KVM mode.
This is a respin of previous contributions from Miguel [1] and Haibo [2].

This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
L2 guests booted without EDK2. However it does not work yet with
EDK2 but it looks unrelated to this qemu integration (host hard lockups).

The host needs to be booted with "kvm-arm.mode=nested" option and
qemu needs to be invoked with :

-machine virt,virtualization=on

There is a known issue with hosts supporting SVE. Kernel does not support both
SVE and NV2 and the current qemu integration has an issue with the
scratch_host_vcpu startup because both are enabled if exposed by the kernel.
This is independent on whether sve is disabled on the command line. Unfortunately
I lost access to the HW that expose that issue so I couldn't fix it in this
version.

This series can be found at:
https://github.com/eauger/qemu/tree/v8.2-nv-rfcv2

Previous version from Miguel:
[1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
Previous version from Haibo:
[2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
[3] Marc's kernel v11 series:
    [PATCH v11 00/43] KVM: arm64: Nested Virtualization support (FEAT_NV2 only)
    https://lore.kernel.org/linux-arm-kernel/20231120131027.854038-1-maz@kernel.org/T/
    available at: https://github.com/eauger/linux/tree/nv-6.8-nv2-v11

Haibo Xu (5):
  [Placeholder] headers: Partial headers update for NV2 enablement
  hw/arm: Allow setting KVM vGIC maintenance IRQ
  target/arm/kvm: Add helper to detect EL2 when using KVM
  target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
  hw/arm/virt: Allow virt extensions with KVM

 hw/arm/virt.c                      |  6 +++++-
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  1 +
 linux-headers/asm-arm64/kvm.h      |  1 +
 linux-headers/linux/kvm.h          |  1 +
 target/arm/kvm.c                   | 21 +++++++++++++++++++++
 target/arm/kvm_arm.h               | 12 ++++++++++++
 8 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.41.0


