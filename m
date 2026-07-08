Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E96DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLWx-0001rX-HZ; Wed, 08 Jul 2026 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWm-0001n2-Ul
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:13:03 -0400
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whLWl-0005tg-3J
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:13:00 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783491177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=353VxZ9MzLkqwPCPkr6Wvy1knHKPDmxuC2cl5nDdP9A=;
 b=RviQb1VYf6Km+EZCUGuAc4tjx1K5DxQNyyzGEtAd9ElKfe3YvjCrMEOZ569JpklouBDnTM
 KEfdbmpBJwQy5E70dr+K763ynamG//vkjnSG1itZZ4i4ia8y/bwc26AMlBzoVKA9/nt4su
 9wngPEfYUmG4A7htJeFFRr8rB1qATCc=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 1/2] qapi: add KVM_VCPU_ERROR event
Date: Wed,  8 Jul 2026 14:12:19 +0800
Message-ID: <20260708061220.53507-2-cui.tao@linux.dev>
In-Reply-To: <20260708061220.53507-1-cui.tao@linux.dev>
References: <20260708061220.53507-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bb;
 envelope-from=cui.tao@linux.dev; helo=out-187.mta1.migadu.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Tao Cui <cuitao@kylinos.cn>

When a KVM vCPU exits with an unrecoverable error (KVM_EXIT_INTERNAL_ERROR,
KVM_EXIT_UNKNOWN, or a failed KVM_RUN ioctl), QEMU currently only logs to
stderr and stops the VM with run state "internal-error". The management
layer must infer what happened from the subsequent STOP event, with no
indication of which vCPU failed or why.

Add a KVM_VCPU_ERROR event, emitted before the VM is stopped, that carries
the failing vCPU (cpu-index, qom-path), an error category
(KvmVcpuErrorReason) and, for KVM_EXIT_INTERNAL_ERROR, the kernel suberror
and extra data words.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 qapi/run-state.json | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index a5771ad468..c9993ad9ac 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -732,6 +732,63 @@
   'data': { 'action-required': 'bool',
             'recursive': 'bool'} }
 
+##
+# @KvmVcpuErrorReason:
+#
+# Categorizes a KVM vCPU run error reported through @KVM_VCPU_ERROR.
+#
+# @ioctl-failed: the KVM_RUN ioctl failed; see stderr for the errno.
+#
+# @unknown: KVM_EXIT_UNKNOWN; the hardware exit reason is logged to
+#     stderr.
+#
+# @internal-error: KVM_EXIT_INTERNAL_ERROR; see @suberror and
+#     @exit-data for details.
+#
+# Since: 11.2
+##
+{ 'enum': 'KvmVcpuErrorReason',
+  'data': [ 'ioctl-failed', 'unknown', 'internal-error' ] }
+
+##
+# @KVM_VCPU_ERROR:
+#
+# Emitted when a KVM vCPU exits with an unrecoverable error, before
+# the VM is stopped with run state ``internal-error``.  Lets the
+# management layer learn which vCPU failed and why, instead of
+# inferring it from the subsequent STOP event.
+#
+# @cpu-index: index of the vCPU that failed.
+#
+# @qom-path: the QOM path of the vCPU that failed.
+#
+# @reason: error category.
+#
+# @suberror: KVM internal suberror.  Present only when @reason is
+#     @internal-error.
+#
+# @exit-data: extra KVM data words.  Present only when @reason is
+#     @internal-error and the kernel provided extra data.
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "KVM_VCPU_ERROR",
+#          "data": { "cpu-index": 0,
+#                    "qom-path": "/machine/unattached/device[0]",
+#                    "reason": "internal-error",
+#                    "suberror": 1,
+#                    "exit-data": [ 0 ] },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+##
+{ 'event': 'KVM_VCPU_ERROR',
+  'data': { 'cpu-index': 'int',
+            'qom-path': 'str',
+            'reason': 'KvmVcpuErrorReason',
+            '*suberror': 'int',
+            '*exit-data': ['uint64'] } }
+
 ##
 # @NotifyVmexitOption:
 #
-- 
2.43.0


