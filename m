Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B86C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtbhY-0002qD-BN; Mon, 10 Aug 2026 21:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snambakam@linux.microsoft.com>)
 id 1wtbhT-0002pO-Kg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:54:44 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <snambakam@linux.microsoft.com>) id 1wtbhQ-0002Ee-B5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 21:54:43 -0400
Received: from fedora (unknown [20.29.225.195])
 by linux.microsoft.com (Postfix) with ESMTPSA id CF08220B7167;
 Mon, 10 Aug 2026 18:54:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF08220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1786413252;
 bh=kOka5qlcuXusfVx+drGk+dXfjD1PnmcaiPUEK/CDTU0=;
 h=From:To:Cc:Subject:Date:From;
 b=cv0OZWjuqDqV7ZTuFlG8Chx8Qg0ObnI+FFQPKzDIS8rcukdwQOoYNE7Xqo7yQsJTb
 P68yU+Vzqm5Z+GMqpQRI4Lxd2f3NKWgpH85ycfF3nUbOshlJhFJqO1QrAenG8kIGrC
 P9fBeWe/zyvZyODhnuEWSka5ynUeLqcH/BS3m99c=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/1] qemu: KVM VM Planes host support for VBS
Date: Mon, 10 Aug 2026 18:54:26 -0700
Message-ID: <20260811015427.188876-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=snambakam@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

This RFC adds the QEMU support needed to run Virtualization-Based
Security (VBS) across KVM VM Planes.  It handles the guest's plane
configure and activate hypercalls in userspace: allocating and mapping
each plane's RAM, creating the plane and its sibling vCPUs, and
initialising them to enter the loaded plane kernel.

This is v2 of the series.  Based on feedback from maintainers, the KVM
host, guest, and QEMU changes are now being posted as three separate,
layered RFCs to make it easier to understand the context of these
changes as they pertain to the KVM host, guest, and QEMU.  This
patchset does not yet include memory protection between planes; that
will be added in a future version.

This series is based on the QEMU VM Planes prerequisite patchset obtained
from Joerg Roedel's tree (qemu-planes-linux-v7.1).

This is the userspace counterpart to the separately posted four-patch
KVM host RFC.  This remains prototype code and is not intended for
production use.

The implementation and integration tooling are available at:

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/vm-planes-layered

  QEMU support:
  https://github.com/safe-tee/qemu/tree/vm-planes-layered

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs

Acknowledgments
===============

This work stands on top of, and is indebted to, several prior efforts:

  - Joerg Roedel, whose QEMU and KVM VM Planes work provides the
    infrastructure that the VBS/VSM secure plane relies on.

  - Paolo Bonzini, whose "[RFC PATCH 00/29] KVM: VM planes" introduced
    the VM Plane concept to KVM as a common in-kernel model for AMD VMPLs,
    Intel TDX partitions, Hyper-V VTLs, and Arm CCA planes.
    https://lwn.net/Articles/1016113/

  - James Bottomley and James Morris, for their ongoing VSM-on-KVM work,
    which informed the design and direction of this series.

Feedback on the plane configuration/activation handling and the
memory/vCPU setup it performs is welcome.

Sriram Nambakam (1):
  kvm: handle VM-plane configure/activate hypercalls

 accel/kvm/kvm-all.c                       |  20 +
 include/standard-headers/linux/kvm_para.h |   2 +
 include/system/kvm_int.h                  |  20 +
 target/i386/kvm/kvm.c                     | 517 ++++++++++++++++++++++
 4 files changed, 559 insertions(+)


base-commit: e94b8abef8617a074fac3cfc2797c0c2359ceb8c
-- 
2.55.0


