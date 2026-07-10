Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC6BC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 00:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whzS9-0000A2-S9; Thu, 09 Jul 2026 20:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS8-00009o-9k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:52 -0400
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS4-0005dr-W8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783644646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSFFtc8Qs7YopIepyDIhuXWQE/SNoI3BvDv19mqrZl0=;
 b=A6rgKkRs4fgBxHAE5a7hTlueHxJVq4a225Jd9ZuWJjpUWkMCH4sBjh8eeCw7Wtk2R9SQap
 wIn8hG+IbDR6VHOs2HXHfOGUS+sDlC+rPN+OGLEj9bgiDfbfG3tv8hhepF1cuFCgBWzJRY
 ixTyoY0V+uQjjL6ITIdgd79R533+zNQ=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/3] target/loongarch: migrate pv_features in the vCPU
 VMState
Date: Fri, 10 Jul 2026 08:50:28 +0800
Message-ID: <20260710005029.345378-3-cui.tao@linux.dev>
In-Reply-To: <20260710005029.345378-1-cui.tao@linux.dev>
References: <20260710005029.345378-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ad;
 envelope-from=cui.tao@linux.dev; helo=out-173.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Tao Cui <cuitao@kylinos.cn>

pv_features holds the value of pseudo-register CPUCFG_KVM_FEATURE and is now
pushed per vCPU. Add it to the vCPU VMState as a subsection (sent when
non-zero) so it travels with the vCPU across migration between host kernel
versions.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/machine.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 931a5ca5ba..b8819bd44d 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -65,6 +65,24 @@ static const VMStateDescription vmstate_msgint = {
     },
 };
 
+static bool pv_features_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return cpu->env.pv_features != 0;
+}
+
+static const VMStateDescription vmstate_pv_features = {
+    .name = "cpu/pv_features",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pv_features_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.pv_features, LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_lsxh_reg = {
     .name = "lsxh_reg",
     .version_id = 1,
@@ -289,6 +307,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_lbt,
         &vmstate_msgint,
         &vmstate_pmu,
+        &vmstate_pv_features,
         NULL
     }
 };
-- 
2.43.0


