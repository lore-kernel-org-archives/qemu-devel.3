Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF53F9D0D6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg68-0004AD-2r; Tue, 14 Apr 2026 11:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wCg66-0004A0-V0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:54:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wCg65-0000D9-9j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:54:42 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6BFC120B6F01;
 Tue, 14 Apr 2026 08:54:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BFC120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776182079;
 bh=lIPPzyrl6JxMQVf94O6Y2eckUBAystmbLuQP3CteQ7s=;
 h=From:To:Cc:Subject:Date:From;
 b=WDSBcvTeOIpQ3RJTfdbZ1lnhGW61Li03VAHMsOMetToGlxeEzgF8KE//SdS4Ix4NX
 YMFloC56PSm8DLLn7WzIgcFUO6++RIMB5Rycnd3TWSluxkz7E+zlQTZdmND+Ws4RTZ
 aQVQXwnxc75UaEXAJCCbwRxAnX1Y+0ehvWB1QA2M=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/9] Support QEMU cpu models in MSHV accelerator
Date: Tue, 14 Apr 2026 17:54:24 +0200
Message-Id: <20260414155433.483186-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hey all,

In the current MSHV accelerator code passing CPU features via the -cpu
flag doesn't work as intended yet. When using the MSHV hypervisor we
either silently discard the specified model/features and leave it up
to the hypervisor to provide a sensible set of features or if the user
selects -cpu host, the hypervisor might refuse to create a partition.

This changeset introduces a more comprehensive support for passing
desired guest cpu features to the hypervisor. It's also a prerequisite
for Live Migration support.

Changes since v3:

- Rebased onto current master

Changes since v2:

- move disabling of la57 to arch specific code
- assert MSHV_NUM_CPU_FEATURES_BANKS == 2
- dropped QEMU_PACKED changes to hv headers (address in individal patch)

Changes since v1:

- query hypervisor for supported processor features instead of the host OS
- disable la57 (5 level page tables)

best,

magnus

Magnus Kulke (9):
  accel/mshv: use mshv_create_partition_v2 payload
  target/i386/mshv: fix cpuid propagation bug
  target/i386/mshv: fix various cpuid traversal bugs
  target/i386/mshv: change cpuid mask to UINT32_MAX
  target/i386/mshv: set cpu model name on -cpu host
  target/i386: query mshv accel for supported cpuids
  target/i386/mshv: populate xsave area offsets
  target/i386/mshv: filter out CET bits in cpuid
  accel/mshv: disable la57 (5lvl paging)

 accel/mshv/mshv-all.c          |  78 ++++++++++-
 include/hw/hyperv/hvgdk_mini.h |   2 +
 include/hw/hyperv/hvhdk.h      | 195 +++++++++++++++++++++++++++
 include/system/mshv.h          |   3 +
 include/system/mshv_int.h      |   2 +
 target/i386/cpu.c              |   8 ++
 target/i386/mshv/mshv-cpu.c    | 233 +++++++++++++++++++++++++++------
 7 files changed, 472 insertions(+), 49 deletions(-)

-- 
2.34.1


