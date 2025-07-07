Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3135C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYouj-0004ZG-24; Mon, 07 Jul 2025 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYoud-0004XI-0q
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYoua-0005wp-OR
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751906506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j3abTcWeTJI6w5yRxgG1Y3BRun00qav2IQy3v4fDNv4=;
 b=cYQT3rrPNmH+wbloRamr5BEmUmMSEyFAu+j0AH42DXNuEovVc+CbS7JL8u5u2X4yA/7cJi
 7y7QuH0pLZKUV4xGRlo5U8C0kYEzLyVWeNHNyJcG+y1omYqEl6cOjxFkWpM8pgc3Mg0tET
 5KM9HO0qqtzxEJJo/HHXKffjf/Wf7fQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-jDpYEqtRN1-6bYDb4M7OIg-1; Mon,
 07 Jul 2025 12:41:43 -0400
X-MC-Unique: jDpYEqtRN1-6bYDb4M7OIg-1
X-Mimecast-MFC-AGG-ID: jDpYEqtRN1-6bYDb4M7OIg_1751906501
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D753119560A2; Mon,  7 Jul 2025 16:41:40 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EEF81800288; Mon,  7 Jul 2025 16:41:36 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
Subject: [PATCH v9 0/5] ARM Nested Virt Support
Date: Mon,  7 Jul 2025 18:40:26 +0200
Message-ID: <20250707164129.1167837-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is candidate for 10.1.

For gaining virt functionality in KVM accelerated L1, The host needs to
be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
with: -machine virt,virtualization=on.

This series can be found at:
https://github.com/eauger/qemu/tree/v10.0.0-nv-v9
previous:
https://github.com/eauger/qemu/tree/v10.0.0-nv-v8

Original version from Miguel:
[1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
version from Haibo:
[2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/

History:
v8 -> v9:
- Move the migration blocker to the GIC code

v7 -> v8
- add migration blocker when virt is set along with kvm enabled
- test virt is not set with -cpu host,aarch64=off
- s/only is/is only

v6 -> v7:
- rebase on Peter's target-arm.next. as a result linux header update could be
  dropped. Faced a small conflict in hw/arm/virt: Allow virt extensions with KVM
  due to recently landed hw/arm/virt: Make EL2 accelerator check an accept-list.
  I dared to keep Richard's R-b though.

v5 -> v6:
- linux header update against v6.16-rc2

v4 -> v5:
- rebase on top of v10.0.0

v3 -> v4:
- fix: only set maint_irq if vms->virt

v2 -> v3:
- KVM EL2 only is set if virtualization option is set
- fixes regression with virtualization=off
- Add checks against unsupported GIC configs until the kernel does


Eric Auger (1):
  hw/arm/arm_gicv3_kvm: Add a migration blocker with kvm nested virt

Haibo Xu (4):
  hw/arm: Allow setting KVM vGIC maintenance IRQ
  target/arm/kvm: Add helper to detect EL2 when using KVM
  target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
  hw/arm/virt: Allow virt extensions with KVM

 include/hw/intc/arm_gicv3_common.h |  1 +
 target/arm/kvm_arm.h               |  7 +++++++
 hw/arm/virt.c                      | 17 ++++++++++++++++-
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_kvm.c            | 29 +++++++++++++++++++++++++++++
 target/arm/kvm-stub.c              |  5 +++++
 target/arm/kvm.c                   | 21 +++++++++++++++++++++
 7 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.49.0


