Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D96C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aGS-0004WG-Uw; Mon, 07 Sep 2026 10:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1x3aGS-0004W0-3Z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:24:04 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1x3aGQ-0006YX-Jw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:24:03 -0400
Received: from laptop.localdomain (unknown [81.196.141.93])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0C51820B710C;
 Mon,  7 Sep 2026 07:23:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C51820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788791000;
 bh=/YYFf2BX9WkWDNnE2+02mF1DrZ6NwJ5C7iA6z06U2oM=;
 h=From:To:Cc:Subject:Date:From;
 b=mrTSon0+Y9pWDomXpijVALwCOaWVCvmtYBqvh18iKlSw1khFadD/PNvaDevuNY1qT
 Msw2uLXEs533fDTs4Eq5srH2HA+8IxgSsWnaJ5yTpq4a9jYumZmCCgQykUOP/NEF5f
 G4VF1mL8ODz2gwhD7en+Mjss3Cxk8FF5yY3u1gik=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH 0/2] acce/mshv: size XSAVE buffers from the hypervisor
Date: Mon,  7 Sep 2026 17:23:53 +0300
Message-ID: <20260907142355.141033-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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

This patch series allows Qemu to dynamically size the xsave area from the
hypervisor by reading the property HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE.

Previously, the xsave area size was set to 4kB and as a consequence AMX Tiles
feature couldn't be enabled because it needs more than the 4kB allocated.
With this change, Qemu enables all the xsave features in the partition, and it
queries the hypervisor to retrieve the maximum size of xsave.
The size is cached in `MshvState` at vCPU arch initialization time to be used
later for MSHV_{GET/SET}_VP_XSAVE.

To correctly advertise AMX support, we remove the logic disabling the AMX at
CPUID and partition level.

Doru Blânzeanu (2):
  accel/mshv: size XSAVE buffers from the hypervisor
  accel/mshv: enable amx tiles support for guests

 accel/mshv/mshv-all.c       | 39 +++++++++++++++++++----------
 accel/mshv/trace-events     |  2 ++
 include/system/mshv_int.h   |  3 +++
 target/i386/mshv/mshv-cpu.c | 50 ++++++++++++++++++-------------------
 4 files changed, 56 insertions(+), 38 deletions(-)

-- 
2.53.0


