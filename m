Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B900C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZQP-0000kH-EH; Wed, 05 Aug 2026 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snambakam@linux.microsoft.com>)
 id 1wrZQM-0000il-7E
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:39 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <snambakam@linux.microsoft.com>) id 1wrZQI-0000AD-Sb
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:37 -0400
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id F403420B7169;
 Wed,  5 Aug 2026 04:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F403420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785927853;
 bh=mBopCGB9U0UQQPrdHpzVGND3qjL34aJmORw3g1OLW1w=;
 h=From:To:Cc:Subject:Date:From;
 b=mPHn30/Wp0dlRDuCM3epRYEhPWX+7eoxi4ijvSauJLHBLwB1rcsfIPH6Y2iwV/Cmx
 fn9T/i7UAYfcfkQQQZDqI1C9ECUhtcOcSVeOgzv9086mDz8dBk4k+c77pYPEqbCf3I
 ZuyZOYxTsPQyrjltD2TFFTXEautQinPZWvAkEF5s=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 0/5] VBS/VSM-on-KVM: QEMU support for the secure VM
 plane
Date: Wed,  5 Aug 2026 04:04:27 -0700
Message-ID: <20260805110432.25167-1-snambakam@linux.microsoft.com>
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

This RFC adds the QEMU support needed to run a Virtualization-Based
Security (VBS), or Hyper-V VSM-style, secure environment using KVM VM
Planes.  It is the QEMU counterpart to the Linux VBS/VSM-on-KVM series.

The five patches in this mail series are authored by me and add:

  - userspace handlers for VM Plane and VBS VTL-call exits from KVM;
  - the VBS VTL hypercall definitions from the Linux UAPI;
  - loading and running the secure-plane kernel in-kernel; and
  - plane configuration access through the QEMU address-space API.

This series depends on the QEMU VM Planes infrastructure from Joerg
Roedel and related prerequisite work.  Those patches are not duplicated
in this mail series.  The integrated QEMU branch linked below contains
the complete tree, including Joerg's patches and the other prerequisites,
used for development and testing.

The complete implementation is available in three repositories under the
safe-tee organization:

  QEMU support and complete integrated tree:
  https://github.com/safe-tee/qemu/tree/qemu-planes-v11.1.0-rc1

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/kvm-planes-v7.2-rc5

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs

Current build and run instructions are maintained in the lvbs repository:

  https://github.com/safe-tee/lvbs/blob/main/docs/how-to/how-to-build.md

This is prototype code and is not yet intended for production use.
Feedback on the QEMU integration, VTL-call handling, and division of
responsibility between QEMU and the in-kernel VM Plane implementation
would be appreciated.

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

Sriram Nambakam (5):
  kvm: add userspace handlers for VM planes and VBS VTL calls
  vm_planes: Add VBS VTL call handling and plane memory sealing
  linux-headers: sync kvm_para.h VBS VTL hypercalls
  target/i386/kvm: run the secure plane in-kernel (Option B)
  target/i386/kvm: read plane config via address_space API

 accel/kvm/kvm-all.c                       |  18 +
 include/standard-headers/linux/kvm_para.h |   7 +-
 include/system/kvm_int.h                  |  18 +
 linux-headers/linux/kvm.h                 |  16 +
 target/i386/kvm/kvm.c                     | 561 ++++++++++++++++++++++
 5 files changed, 619 insertions(+), 1 deletion(-)

-- 
2.55.0


