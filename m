Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD4606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=XU7kWn0S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQiaq-0003lE-5x; Tue, 10 Nov 2026 04:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xQiag-0003kG-Mf
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:36 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xQiae-0004oV-Qn
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:34 -0500
Received: from laptop.localdomain (unknown [81.196.141.39])
 by linux.microsoft.com (Postfix) with ESMTPSA id 57C2120B7168;
 Tue, 10 Nov 2026 01:56:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57C2120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794304589;
 bh=rrr8RbvuITbhw09njxgffz3pNdbpVDkTfNrQHasGHsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XU7kWn0SitVQmoATI9UipfB0Q26i5dSZ9hEzFSptqKNpvCMmpvclOWiJsePZbUiuQ
 RtoYBjtTa1qA9bTaB51aHPvI84Ff2NpynlGOCbg+o27MG8qai7iFVitCCvodZ/qOXJ
 vR3FlkkDqCPT5BWEEIO3gVB9sQW89W7iJLlHv39o=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v2 3/3] accel/mshv: Enable SMT support for the mshv partition
Date: Tue, 10 Nov 2026 11:56:17 +0200
Message-ID: <20261110095617.50713-4-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
References: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d820a67b95..2b854c1ebd 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -178,7 +178,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
     pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
                (1ULL << MSHV_PT_BIT_X2APIC) |
                (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
-               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
+               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES) |
+               (1ULL << MSHV_PT_BIT_SMT_ENABLED_GUEST);
 
     /* enable all */
     disabled_xsave_features.as_uint64 = 0;
-- 
2.54.0


