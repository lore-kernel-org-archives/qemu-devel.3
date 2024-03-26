Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3419EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBSy-0007WV-ID; Tue, 26 Mar 2024 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rpBSt-0007Tk-Gc
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rpBSq-0000E4-V4
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711477440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MCE20NsapdGHc+noj28eyGhPEw7mK8MKvPed9Xq8uto=;
 b=GiwHwG+bNg5f6At8sVIygWHiXU1Wuy9faal/EgLJ1TD3jPTPD8VoXG+1RQNNUhD0mHR7S6
 6UO/H866LglfrjR8x3yYDo70GU+plzQcVkJuy5YlxPSQ2wfO1924qEbRRYSUVqauH+4zE4
 qXFoNmF7H4lNNUB2RX526vamXRFWhyI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-yAh4N1MMObSvuQpniwKEAw-1; Tue,
 26 Mar 2024 14:23:55 -0400
X-MC-Unique: yAh4N1MMObSvuQpniwKEAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80B5A3802285;
 Tue, 26 Mar 2024 18:23:54 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC5510E4B;
 Tue, 26 Mar 2024 18:23:51 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [RFC v3 0/5] ARM Nested Virt Support
Date: Tue, 26 Mar 2024 19:22:34 +0100
Message-ID: <20240326182345.326758-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series adds ARM Nested Virtualization support in KVM mode.
This is a respin of previous contributions from Miguel [1] and Haibo [2].

This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
L2 guests booted without EDK2. However it does not work yet with
EDK2 but it looks unrelated to this qemu integration (host hard lockups).

The host needs to be booted with "kvm-arm.mode=nested" option and
qemu needs to be invoked with :

-machine virt,virtualization=on

Known issues:
- Does not work on hosts supporting both SVE and NV2. KVM does not
  support both SVE and NV2 and the current qemu integration attempts to
  creates a scracth VM with both if those are exposed by the host.
- L2 guest featuring EDK2 does not work. This produces hard lockups on host
- Migration does not work. After ages one gets on the destination side:
qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
qemu-system-aarch64: Failed to put registers after init: Invalid argument

This series can be found at:
https://github.com/eauger/qemu/tree/v9.0-nv-rfcv3

Previous version from Miguel:
[1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
Previous version from Haibo:
[2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
[3] Based on Marc's kvm-arm64/nv-6.9-sr-enforcement branch
    [PATCH v11 00/43] KVM: arm64: Nested Virtualization support (FEAT_NV2 only)
    https://lore.kernel.org/linux-arm-kernel/20231120131027.854038-1-maz@kernel.org/T/
    available at: https://github.com/eauger/linux/tree/v6.8-rc1-nv2-sr-enforcement

---

v2 -> v3:
- KVM EL2 only is set if virtualization option is set
- fixes regression with virtualization=off
- Add checks against unsupported GIC configs until the kernel does

Haibo Xu (5):
  [Placeholder] headers: Partial headers update for NV2 enablement
  hw/arm: Allow setting KVM vGIC maintenance IRQ
  target/arm/kvm: Add helper to detect EL2 when using KVM
  target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
  hw/arm/virt: Allow virt extensions with KVM

 hw/arm/virt.c                      | 13 ++++++++++++-
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  1 +
 linux-headers/asm-arm64/kvm.h      |  1 +
 linux-headers/linux/kvm.h          |  1 +
 target/arm/kvm.c                   | 21 +++++++++++++++++++++
 target/arm/kvm_arm.h               | 12 ++++++++++++
 8 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.41.0


