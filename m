Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF11606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ZgZxP7xb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM39n-0001Gb-Rj; Wed, 28 Oct 2026 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xM39m-0001GF-L0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xM39l-0003NZ-2I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:30 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c09f4.dip0.t-ipconnect.de
 [62.156.9.244])
 by linux.microsoft.com (Postfix) with ESMTPSA id 439CD20B716A;
 Wed, 28 Oct 2026 05:53:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 439CD20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793191995;
 bh=LI/6qZq71tt5xJqVIMNONpxnKeLBczut589IV+eWx2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZgZxP7xbj6ARzGOmOvD9nbr2ABosQMukaS2CnvY21o5IDPXeyIoajrVdsp3i5Q2IL
 aqgcJr3xsW//BzwvbCUvToTqTqamr+gXajXETi4TAr8MRpMUBxzjiFRfyq68fJeJ/1
 yXyjjd93TlkJvEZT/pvtjOP6gZgO3+/F8k4WsBG8=
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
Subject: [PATCH 4/4] accel/mshv: do not coalesce vCPU kicks
Date: Wed, 28 Oct 2026 13:53:08 +0100
Message-Id: <20261028125308.147630-5-magnuskulke@linux.microsoft.com>
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

MSHV today lacks an immediate-exit API. QEMU tehre kicks a vCPU by
sending SIG_IPI to interrupt an active MSHV_VP_RUN ioctl invocation.

The generic kick path suppresses repeat signals using
CPUState::thread_kicked, which is cleared when we return to the the
outer vCPU loop (in mshv_vcpu_thread()). MSHV cannot guarantee that a
signal will cause sucha  return:  it may be handled between MSHV_VP_RUN
calls or MSHV_RUN_VP may return an unrelated intercept instead of EINTR.

Hence we install an MSHV-specific kick impl that sends SIG_IPI for every
requested vCPU kick.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 7289c8d1c2..0f733cac9d 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -888,6 +888,24 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
                        QEMU_THREAD_JOINABLE);
 }
 
+static void mshv_kick_vcpu_thread(CPUState *cpu)
+{
+    int err;
+
+    /* don't kick ourselves, we are already running */
+    if (qemu_cpu_is_self(cpu)) {
+        return;
+    }
+
+    err = pthread_kill(cpu->thread->thread, SIG_IPI);
+    /* in case the vcpu thread has been torn down we don't want to abort */
+    if (err && err != ESRCH) {
+        error_report("failed to kick MSHV vCPU %d: %s",
+                     cpu->cpu_index, strerror(err));
+        abort();
+    }
+}
+
 static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
@@ -996,6 +1014,7 @@ static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->kick_vcpu_thread = mshv_kick_vcpu_thread;
     ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
     ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
     ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
-- 
2.34.1


