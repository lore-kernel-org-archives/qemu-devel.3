Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K5nI6ki4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM39h-0001EG-0A; Wed, 28 Oct 2026 08:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xM39f-0001DW-75
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xM39d-0003MS-O8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:22 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c09f4.dip0.t-ipconnect.de
 [62.156.9.244])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6A8E720B7168;
 Wed, 28 Oct 2026 05:53:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A8E720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793191988;
 bh=VHZV6Y1ILH+FySY+U2WVfcUnldyMs55Rrz1vvnu181Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K5nI6ki418onpaVXqTnx1uT7cc6exj0dWG1zQHfG4CWQ4JOdPmM3nO0bmdA6eIHAf
 si7qjhFaYdS0rcnxLkdI5kRvSbBvaPhJAlCfpQUFM+MIqpo/N4RbxHs54jlWdjGl+2
 EiofPuDgL1pKNxsQ/rgM/4prREa115kx18TqLIl8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] accel/mshv: stop VM on vCPU execution errors
Date: Wed, 28 Oct 2026 13:53:06 +0100
Message-Id: <20261028125308.147630-3-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

Currently we abort the process immediately if the ioctl returns an
error, so the error handling routine outside the loop cannot be reached.
We also enumerate the enum variants explicitly to make it obvious how
every exit reason is being handled.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d820a67b95..7289c8d1c2 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -778,8 +778,8 @@ static int mshv_cpu_exec(CPUState *cpu)
 
         ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
         if (ret < 0) {
-            error_report("Failed to run on vcpu %d", cpu->cpu_index);
-            abort();
+            error_report("Failed to run on vCPU %d", cpu->cpu_index);
+            break;
         }
 
         switch (exit_reason) {
@@ -788,7 +788,8 @@ static int mshv_cpu_exec(CPUState *cpu)
         case MshvVmExitDebug:
             ret = EXCP_DEBUG;
             break;
-        default:
+        case MshvVmExitSpecial:
+        case MshvVmExitShutdown:
             ret = EXCP_INTERRUPT;
             break;
         }
-- 
2.34.1


