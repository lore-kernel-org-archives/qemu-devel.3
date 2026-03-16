Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FD8F506D4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28NP-0003JS-Dn; Mon, 16 Mar 2026 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28N3-0002kB-4m; Mon, 16 Mar 2026 09:52:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w28Mw-0000Cx-Qk; Mon, 16 Mar 2026 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773669141; bh=j6qGctYJP0fHWz1THKGnGrPDS01WgvhF/QqNLBy7uoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f2mbhS8Fh+wYTEJ3Bgd/t+jOQ4vq2E36DYxMhNnYVJSzeGOFG1xjflYDmedaar5tq
 DBzeS/z3oCMKQCfAy7aXujf4zEDuI7gNwEX6Gi3nJmVKJyjvgx1PAFArjwK0TWftoB
 ODmgB+KmNBJFhv8JtnOHFR1uSUOaJFe+3H5/tvX3xbDKAYWJH50nMqR0EoPpS5Vlzc
 DwIUNV56InYRce1tXljTGREFevnwvsAHZ53QUYcmr6MswYhTk8B2+4xdc3QyVlYO6g
 7ajQUpS4gZj6kx8tkQtHXIKPpAHlk0n1fCrXH8jybtGYerPLfkBKSPGVwtMymeL0I2
 6SQQ3dJMujs1w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 89B6C193EF8;
 Mon, 16 Mar 2026 16:52:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1DA54380940;
 Mon, 16 Mar 2026 16:52:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 55/55] target/i386: add compat for migrating error code
Date: Mon, 16 Mar 2026 16:52:22 +0300
Message-ID: <20260316135225.120094-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260316164931@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260316164931@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

If cpu->env.has_error_code is true, backwards migration of a VM from
a QEMU binary with commit 27535e9cca to a QEMU binary without commit
27535e9cca will fail:

> kvm: error while loading state for instance 0x0 of device 'cpu'

In practice, wrongly setting the error code to 0 on the target is
often unproblematic, so additionally checking error_code != 0 in
cpu_errcode_needed() is not enough to mitigate the issue. Instead, add
proper machine version compat handling.

Cc: qemu-stable@nongnu.org
Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310154348.495332-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1b80f1009dcaf19b4a82a63ab4e52833374e31cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8b919cb6c..48e153c93f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
+    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..78308a82a0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10024,6 +10024,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
+    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1..ee3ed5ae6d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2211,6 +2211,7 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
+    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 45b7cea80a..21531f8ba2 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0;
+    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.47.3


