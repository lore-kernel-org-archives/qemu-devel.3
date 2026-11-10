Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D37606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=nhg1AXb8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQiac-0003jQ-FA; Tue, 10 Nov 2026 04:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xQiaZ-0003iZ-CN
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:28 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xQiaX-0004mG-Ti
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:27 -0500
Received: from laptop.localdomain (unknown [81.196.141.39])
 by linux.microsoft.com (Postfix) with ESMTPSA id 951B720B7168;
 Tue, 10 Nov 2026 01:56:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 951B720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794304580;
 bh=ZZSV8rIr5ok/RETeedB7d/XBhvOCTa3iXOBS61QorCU=;
 h=From:To:Cc:Subject:Date:From;
 b=nhg1AXb8MLnX0AWevO5ITYbGl45dP/TwJmsOcSK3oYiccP/kVaRBNAKRM28eM/nhI
 9duYLwN9pV+OVE5BQTKLAj4sS5azNhOpeE7GqDjpS3VktJpN7H45Kgiae4d1/Rff2w
 zbRbRYs1lW9e1OFxPYiWrmz8J8cTuoWm+nOate7o=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v2 0/3] Add CPU topology extension support for mshv guests
Date: Tue, 10 Nov 2026 11:56:14 +0200
Message-ID: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch changes how MSHV constructs and registers the guest CPUID table.
It consists of three commits:

1. i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when TOPOEXT is enabled
2. mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache subleaves
3. accel/mshv: Enable SMT support for the mshv partition

The first commit changes the extended CPUID level to 0x8000_001E when the TOPOEXT
feature is enabled.
This fix correctly reports CPU topology and cache leaves when TOPOEXT is
enabled.

Previous to the second commit, `collect_cpuid_entries` treated `0x0b` and `0x1f`
like ordinary leaves and collected only sub-leaf zero. But these Intel topology
leaves contain one sub-leaf per topology level.
With this patch, now it repeatedly calls `cpu_x86_cpuid` and stores every
result until ECX[15:8] becomes zero (same as kvm does).

Changes since V1:
- Enable SMT support in the mshv partition

Doru Blânzeanu (3):
  i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when TOPOEXT is
    enabled
  mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache
    subleaves
  accel/mshv: Enable SMT support for the mshv partition

 accel/mshv/mshv-all.c       |  3 ++-
 target/i386/cpu.c           |  5 +++++
 target/i386/mshv/mshv-cpu.c | 41 +++++++++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.54.0


