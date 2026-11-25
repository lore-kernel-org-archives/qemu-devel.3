Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A43606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=fNVp1lFb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWE2z-0001Bf-PG; Wed, 25 Nov 2026 09:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xWE2m-0001As-BX
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:32:21 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xWE2k-0003Zk-KK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:32:19 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.58])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0543220B7171;
 Wed, 25 Nov 2026 06:32:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0543220B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795617132;
 bh=9v7dwPy7aED1FAH5YuhkYFx9I3d9s1F0PYYkgMnZAR8=;
 h=From:To:Cc:Subject:Date:From;
 b=fNVp1lFbEx+ys+cL48NZYD5bA/myZ8eCNqyI1CT5y8+PMmNtd0YO1D+siOpScdsED
 g4CliJxkrb7pTqArgkvzHba6YlB4Nm6qZS00kHb4gBjQSLlDJZv1WDZYja8lcI01Bs
 45tI01pvnP3x+5E0fuDGWuWRMYFH8tVJi1ItYSOc=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH] target/i386/mshv: set hypercall MSR runtime-unsafe
Date: Wed, 25 Nov 2026 15:32:11 +0100
Message-Id: <20261125143211.51151-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

Windows locks HV_X64_REGISTER_HYPERCALL after configuring it, so writing
back even the same value will fail. Hence we mark it as not runtime safe,
so e.g. an "info registers" command will not fail to writeback the MSRs.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index a06844cc99..5696b7eb83 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -332,6 +332,8 @@ static bool msr_is_runtime_safe(uint32_t name)
      * while the guest's timer is not frozen.
      */
     case HV_X64_REGISTER_TSC:
+    /* Once locked, the hypercall MSR rejects writes even w/ the same value */
+    case HV_X64_REGISTER_HYPERCALL:
         return false;
     default:
         return true;
-- 
2.34.1


