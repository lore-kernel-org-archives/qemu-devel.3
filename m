Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF37606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vx+MqASA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMM4-0006oG-47; Thu, 29 Oct 2026 05:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMMM1-0006nw-Nt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMMM0-0005iy-6f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793265802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=A6LseDyxckBxdzamRBE1SEr1KtGqYJt1j6azdGf+HcI=;
 b=Vx+MqASA2Mq00RHMB1IP00uToBugDc3uTG8u8aIhOjoWF4fXRGugdirOW0GbO4VpumWW6c
 ssKo1sJSzqsPTKpcqt9K+68G3w4twsAteCShCGY82PXHFq4axJ/Q5YNtCk8coKyXvMafOn
 cM2Vc1whoVySXYO5SMV5Kc5IyTfK/tk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-UIT6MYjnPhag-iMMJZbhyg-1; Thu,
 29 Oct 2026 05:23:19 -0400
X-MC-Unique: UIT6MYjnPhag-iMMJZbhyg-1
X-Mimecast-MFC-AGG-ID: UIT6MYjnPhag-iMMJZbhyg_1793265797
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624AB1955DDA; Thu, 29 Oct 2026 09:23:16 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29C743000723; Thu, 29 Oct 2026 09:23:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH for-11.2 0/9] kvm/arm: Some refactoring for custom KVM host
 model
Date: Thu, 29 Oct 2026 10:20:12 +0100
Message-ID: <20261029092307.281287-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series contains some patches initially introduced in
"kvm/arm: Introduce a customizable aarch64 KVM host model" series

1-4,9 are already reviewed
5-6 deal with error handle passing, only impact target/arm
7 also deals with error handling but impacts more archs
8 is target/arm specific and is rather basic code refactoring
9 is also virt-arm specific and msotly highlighy an issue with
  CLIDR_EL1 and KVM mode

They are rather independent on the actual custom host model and can
be considered as a separate dependency. Would be nice to get some of them
in 11.2.

Eric Auger (9):
  target/arm/cpu-sysregs.h.inc: Sort by name alphabetical order
  target/arm: Move REVIDR into isar.idregs[] storage
  target/arm: Move MIDR into isar.idregs[] storage
  target/arm: Enforce MPIDR into isar.idregs[] storage
  target/arm/kvm: Pass an error handle to
    kvm_arm_create_scratch_host_vcpu
  target/arm/kvm: Pass an error handle to kvm_arm_init_cpreg_list
  target/kvm: Pass an Error handle to kvm_arch_init_vcpu
  target/arm/kvm: Introduce kvm_arm_vcpu_prepare_init_features helper
  hw/arm/virt: Make sure virt_get_caches() keeps on reading CLIDR_EL1 as
    0

 include/system/kvm.h         |  2 +-
 linux-user/arm/target_proc.h | 13 ++---
 target/arm/cpu.h             | 10 ++--
 target/arm/kvm_arm.h         |  3 +-
 target/arm/cpu-sysregs.h.inc | 49 ++++++++++---------
 accel/kvm/kvm-all.c          | 15 +++---
 hw/arm/virt.c                | 11 +++++
 hw/intc/armv7m_nvic.c        |  4 +-
 target/arm/cpu-max.c         |  4 +-
 target/arm/cpu.c             | 19 +++++++-
 target/arm/cpu64.c           |  4 +-
 target/arm/helper.c          | 29 ++++-------
 target/arm/hvf/hvf.c         |  6 +--
 target/arm/kvm.c             | 95 +++++++++++++++++++++++-------------
 target/arm/tcg/cpu-v7m.c     | 18 +++----
 target/arm/tcg/cpu32.c       | 37 +++++++-------
 target/arm/tcg/cpu64.c       | 42 ++++++++--------
 target/arm/whpx/whpx-all.c   |  6 +--
 target/i386/kvm/kvm.c        | 22 +++++----
 target/loongarch/kvm/kvm.c   | 27 ++++------
 target/ppc/kvm.c             | 10 ++--
 target/riscv/kvm/kvm-cpu.c   |  6 ++-
 target/s390x/kvm/kvm.c       |  2 +-
 23 files changed, 245 insertions(+), 189 deletions(-)

-- 
2.53.0


