Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8682606A698
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=pW6BD00f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsqK-0002of-3v; Tue, 24 Nov 2026 10:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xVsqI-0002nV-Du
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:02 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xVsqD-0008FE-EC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:01 -0500
Received: from laptop.localdomain (unknown [81.196.141.97])
 by linux.microsoft.com (Postfix) with ESMTPSA id 373F520B716E;
 Tue, 24 Nov 2026 07:53:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 373F520B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795535631;
 bh=joAb4LiJXrdjgZhxcI1agYDXaudoIZuZgU8L+bnoRks=;
 h=From:To:Cc:Subject:Date:From;
 b=pW6BD00f7mABI3rgyYLQeBa8mTMEtT88oejMl/hOOzO0tEdTE3deHvuXZThkv90FW
 nO8iFQgrfGuNaWfZ+BPNlTtWqMKAlhVRenXza7Dx6jYuOdqOmyqsDTUSZHbb0BPVPt
 Tr+S6ZGy1ebJKF0tSkNn/pfn/9+6drwZ16UoLhx0=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH v3 0/2] Add CPU topology extension support for mshv guests
Date: Tue, 24 Nov 2026 17:53:46 +0200
Message-ID: <20261124155348.165875-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1.vfs.0.0
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

1. mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache subleaves
2. target/i386/mshv: Initialize the extended CPUID limit for host/max CPUs

Previous to the first commit, `collect_cpuid_entries` treated `0x0b` and `0x1f`
like ordinary leaves and collected only sub-leaf zero. But these Intel topology
leaves contain one sub-leaf per topology level.
With this patch, now it repeatedly calls `cpu_x86_cpuid` and stores every
result until ECX[15:8] becomes zero (same as kvm does).
This fix correctly reports CPU topology and cache leaves when TOPOEXT is
enabled.

The second commit changes the minimum extended CPUID level to 0x8000_001E during
mshv instance initialization for host/max CPUs (the ones that have TOPOEXT
enabled).

Changes since V2:
- Drop the unconditional SMT support in the mshv partition. It will be submitted
  in a later patch
- Change how xlevel is set, from generic accelerator to mshv specific.
  Now, mshv follows kvm's approach of setting xlevel to the host's visible
  extended CPUID maximum for host/max CPUs.

Changes since V1:
- Enable SMT support in the mshv partition

Doru Blânzeanu (2):
  mshv/mshv-cpu.c: Collect all Intel topology subleaves and AMD cache
    subleaves
  target/i386/mshv: Initialize the extended CPUID limit for host/max
    CPUs

 target/i386/mshv/mshv-cpu.c | 48 ++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

-- 
2.48.1.vfs.0.0


