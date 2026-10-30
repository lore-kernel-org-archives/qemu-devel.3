Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hHh8+KHY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmRE-0008Ea-3F; Fri, 30 Oct 2026 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmR8-0008Dr-Ou
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmR5-00056f-FA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793366061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BvBvQUwDonXwx9ouc9veUbIUWuv8/WcglfbA6Vo7nYQ=;
 b=hHh8+KHYU47MR7y3/tyBa8brznZf+I9+JGIAX1hwg6qDhP8tpkqwdyk2s6Bgx0ZK3ZbUmc
 GIbchltRTivXDaQ9wEGpXne4Ym0e7OWxPlBwr+PEP3BXQOnpYAntbArfPBgq6zPNBnxcai
 xVYclNgKGlmvMEH88JsdFaClXhe/UpU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-OEFRtfXYP3iruh4MrPX7YA-1; Fri,
 30 Oct 2026 09:14:18 -0400
X-MC-Unique: OEFRtfXYP3iruh4MrPX7YA-1
X-Mimecast-MFC-AGG-ID: OEFRtfXYP3iruh4MrPX7YA_1793366055
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33519195604E; Fri, 30 Oct 2026 13:14:15 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C829195608A; Fri, 30 Oct 2026 13:14:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v4 for-11.2 00/10] kvm/arm: Some refactoring for custom KVM
 host model
Date: Fri, 30 Oct 2026 14:13:08 +0100
Message-ID: <20261030131406.461599-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series contains some patches initially introduced in
"kvm/arm: Introduce a customizable aarch64 KVM host model" series

They are rather independent on the actual custom host model and can
be considered as a separate dependency. Would be nice to get some of them
in 11.2.

Can be found at:
https://github.com/eauger/qemu/tree/arm-cpu-model-v11-prereq-v4

History:
v3 -> v4: addressed all comments from Peter
- remove static local variable and keep on relying on TARGET_NONE check
- add error_free on finalize
- dont error_append_hint anymore
- store the probe error in ARMHostCPUFeatures
- add doc comment kvm_arm_get_host_cpu_features to emphasize that on
  failure TARGET_NONE is set and an error is set

v2 -> v3:
- added target/arm: Directly store cpu probe failure error (Peter)
- target/arm/kvm: Pass an error handle to kvm_arm_create_scratch_host_vcpu

v1 -> v2:
- Fixed comma in target/ppc/kvm.c
- Improved commit description and comment in last patch
- collected R-b's (thanks!)

Eric Auger (10):
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm: Move REVIDR into isar.idregs[] storage
  target/arm: Move MIDR into isar.idregs[] storage
  target/arm: Enforce MPIDR into isar.idregs[] storage
  target/arm/kvm: Pass an error handle to kvm_arm_init_cpreg_list
  target/kvm: Pass an Error handle to kvm_arch_init_vcpu
  target/arm/kvm: Introduce kvm_arm_vcpu_prepare_init_features helper
  hw/arm/virt: Make sure virt_get_caches() keeps on reading CLIDR_EL1 as
    0
  target/arm: Directly store cpu probe failure error
  target/arm/kvm: Improve error handling on scratch vcpu probe

 include/system/kvm.h         |   2 +-
 linux-user/arm/target_proc.h |  13 ++--
 target/arm/cpu.h             |  15 +++--
 target/arm/kvm_arm.h         |   3 +-
 target/arm/cpu-sysregs.h.inc |  49 ++++++++-------
 accel/kvm/kvm-all.c          |  15 +++--
 hw/arm/virt.c                |  15 +++++
 hw/intc/armv7m_nvic.c        |   4 +-
 target/arm/cpu-max.c         |   4 +-
 target/arm/cpu.c             |  29 ++++++++-
 target/arm/cpu64.c           |   4 +-
 target/arm/helper.c          |  29 +++------
 target/arm/hvf/hvf.c         |   9 +--
 target/arm/kvm.c             | 119 +++++++++++++++++++++++------------
 target/arm/tcg/cpu-v7m.c     |  18 +++---
 target/arm/tcg/cpu32.c       |  37 +++++------
 target/arm/tcg/cpu64.c       |  42 ++++++-------
 target/arm/whpx/whpx-all.c   |   9 +--
 target/i386/kvm/kvm.c        |  22 ++++---
 target/loongarch/kvm/kvm.c   |  27 +++-----
 target/ppc/kvm.c             |  10 ++-
 target/riscv/kvm/kvm-cpu.c   |   6 +-
 target/s390x/kvm/kvm.c       |   2 +-
 23 files changed, 280 insertions(+), 203 deletions(-)

-- 
2.53.0


