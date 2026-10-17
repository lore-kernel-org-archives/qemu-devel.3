Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C311CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2o-0001fo-EA; Sat, 17 Oct 2026 16:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2H-00088W-2e; Sat, 17 Oct 2026 16:29:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2F-00045V-Ed; Sat, 17 Oct 2026 16:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268857; bh=mpHODwz6+bwjv1g0zbMEYxQSTqZPXb1z90BducaUvS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kGoTxA1a9ugSIDa9mhu1SrMePeRGdIjYk+X9oR2eB9gqPfPBgYoyPykaBBMJ19Rkk
 W5hq7899Fn+GMaslHA+VlaPn2FSJjznbpeCqpxTVC0y1dv5peU/aNDjmCO4Qy3d/Mg
 O8IW5PpJ0OOj0RPAaUyCy8FI6PiYxZ2NHlV2+XPJj37JGWLNVVrPVPWi6jPayzz0i8
 B/DlqPhZ8Yh80l88ymr3cIIfW2LtMRhhemNSm7yQpT1fY+d8eAdmbzpq177HRv0fs1
 6/UPqPL/q7GZufWdGLvpub6HUkTzuDUrRQbNUCq2+jZkhe7Vwg7SGb9eQSVlkdMOp5
 WVHbSppDxpybQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E29021DE75E;
 Sat, 17 Oct 2026 23:27:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCA57443432;
 Sat, 17 Oct 2026 23:27:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yanfei Xu <yanfei.xu@bytedance.com>,
 Yuxuan Li <liyuxuan.darfux@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 32/73] target/i386: Migrate error code only with an
 exception
Date: Sat, 17 Oct 2026 23:25:50 +0300
Message-ID: <20261017202638.728621-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

An exception that carries an error code must retain it across migration.
Otherwise the destination reinjects it with error_code 0, which can make
the guest panic. Do not suppress this required state for old machine
types; an incompatible destination should abort migration instead.

The chance of stopping a vCPU while an exception is pending or injected
is extremely low, so the cpu/error_code subsection should rarely be
needed.

It is currently emitted much more often because KVM does not clear
has_error_code and error_code after completing exception injection.
Require a valid exception_nr before sending the subsection. This filters
stale KVM state while preserving the error code for a real exception.

Fixes: 1b80f1009d ("target/i386: add compat for migrating error code")
Cc: qemu-stable@nongnu.org
Reported-by: Yuxuan Li <liyuxuan.darfux@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Message-Id: <20260914113817.2212058-1-yanfei.xu@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit fb024800d6ddfbc1aea926fbbd43fed6b8676510)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e..862b4a45b4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -82,7 +82,6 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
-    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..2adc8c1b65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10819,7 +10819,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
-    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..04ab0c84a3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2367,7 +2367,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/target/i386/machine.c b/target/i386/machine.c
index df0e0c178e..b7d2103b6c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -465,7 +465,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
+    return cpu->env.exception_nr != -1 && cpu->env.has_error_code != 0;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.47.3


