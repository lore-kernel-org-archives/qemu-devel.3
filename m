Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=X9hgED6b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnTS-00062Y-7x; Fri, 30 Oct 2026 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xMnTQ-00062N-Ts
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:52 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xMnTP-0003Fp-Dw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:52 -0400
Received: from laptop.localdomain (unknown [81.196.141.157])
 by linux.microsoft.com (Postfix) with ESMTPSA id 07D4D20B7179;
 Fri, 30 Oct 2026 07:20:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07D4D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793370037;
 bh=qMoWfAMYrAlxTuuGIAD7xyrYHldWeC0AqbZ5Al9A/Vc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X9hgED6bDCIa/P/jKIffrOPfr1N5km+BGAnzY/PqREQNuQc7ThTxMIrn6hztzmUR/
 L47qhgnAza38aol1CFLC8WXsnmsZhKn987hrOO/vyXq++qXXpidP1aNYsvk0fAC4aK
 Gs7S6xmm+XELpkR4QvCVS7KqIHWyJRbVtJUDnlHE=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [RFC PATCH 3/3] accel/mshv: use scrub_partition ioctl on init
Date: Fri, 30 Oct 2026 16:20:37 +0200
Message-ID: <20261030142037.267641-4-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030142037.267641-1-dblanzeanu@linux.microsoft.com>
References: <20261030142037.267641-1-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is relevant on soft resets, when the MSHV partition will have a
preinitialized state for guest enlightenments and LAPIC state.
Without invoking the ioctl, a rebooted guest will fail during boot
when attempting to init Hyper-V enlightenments or the APIC.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index a7b7017fb1..5e51d0f1fa 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -84,6 +84,17 @@ static int mshv_load_cleanup(void *opaque)
     return 0;
 }
 
+static int scrub_partition(int vm_fd)
+{
+    int ret = ioctl(vm_fd, MSHV_SCRUB_PARTITION);
+
+    if (ret < 0) {
+        error_report("Failed to scrub partition");
+        return -errno;
+    }
+
+    return 0;
+}
 
 static int get_host_partition_property(int mshv_fd, uint32_t property_code,
                                        uint64_t *value)
@@ -906,7 +917,19 @@ static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    int ret = mshv_arch_store_vcpu_state(cpu);
+    int ret;
+    bool is_bsp = (cpu == first_cpu);
+
+    if (is_bsp) {
+        ret = scrub_partition(mshv_state->vm);
+        if (ret < 0) {
+            error_report("Failed to scrub partition during reset: %s",
+                         strerror(-ret));
+            vm_stop(RUN_STATE_INTERNAL_ERROR);
+        }
+    }
+
+    ret = mshv_arch_store_vcpu_state(cpu);
     if (ret) {
         error_report("Failed to put registers after reset: %s",
                      strerror(-ret));
-- 
2.54.0


