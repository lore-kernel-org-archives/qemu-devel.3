Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBC7CA9EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGICv-00072Z-HT; Mon, 12 Oct 2026 11:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xGICr-000723-HJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:54 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xGICo-0004ab-JB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:51 -0400
Received: from laptop.localdomain (unknown [81.196.141.65])
 by linux.microsoft.com (Postfix) with ESMTPSA id 203AD20B7168;
 Mon, 12 Oct 2026 08:44:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 203AD20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791819885;
 bh=13K1se4bqn0DyJ1HRzZGaSm0ZfeG5b4yDYnXEq4capI=;
 h=From:To:Cc:Subject:Date:From;
 b=OqqXsV2gz2yrE82FB3bzb6QIjj9TGlkvBvjj8NxlZPQ3moanM5ZPCLNcfQCuV6X2U
 lL+ZMWNIFRpQ8SfpBmMQGl5qKV7rzEFcDR36nVdZYH11AgfsMizNgxhmGGmum11Ami
 OWBW7sbxeiVVFkxgtneKp5Wl3ePUQuIooxGKyolM=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH 0/2] Add CPU topology extension support for mshv guests
Date: Mon, 12 Oct 2026 18:44:40 +0300
Message-ID: <20261012154442.306511-1-dblanzeanu@linux.microsoft.com>
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

This patch changes how MSHV constructs and registers the guest CPUID table.
It consists of two commits:

1. i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when TOPOEXT is enabled
2. mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache subleaves

The first commit changes the extended CPUID level to 0x8000_001E when the TOPOEXT
feature is enabled.
This fix correctly reports CPU topology and cache leaves when TOPOEXT is
enabled.

Previous to the second commit, `collect_cpuid_entries` treated `0x0b` and `0x1f`
like ordinary leaves and collected only sub-leaf zero. But these Intel topology
leaves contain one sub-leaf per topology level.
With this patch, now it repeatedly calls `cpu_x86_cpuid` and stores every
result until ECX[15:8] becomes zero (same as kvm does).

Doru Blânzeanu (2):
  i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when TOPOEXT is
    enabled
  mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache
    subleaves

 target/i386/cpu.c           |  5 +++++
 target/i386/mshv/mshv-cpu.c | 41 +++++++++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.53.0


