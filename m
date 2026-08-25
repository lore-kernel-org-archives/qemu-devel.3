Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5657C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGV-00087K-MV; Tue, 25 Aug 2026 03:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGN-0007o9-TO; Tue, 25 Aug 2026 03:08:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGK-00065A-1O; Tue, 25 Aug 2026 03:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=yHrG77sfZzykqdg7S5TyFA/LZdBQ3h8clje9ze1KiLU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DG9st5+F9QsWiv/XP7UueKfe9E2pRLVBH4oIHOTrFBp71uYZ6BZaJf+CcIhS9xcYO
 qbc6ih4Jtrd77KRPop4fRIq3KHQgbZFx4qKVNP6ZIC86esyYDx2GHwN28+93rwM34B
 ZJVAzQQC6VjDaJyuorcS0kuYrQ4rCYF2NW0zIUb/vV/7GHx7odZwvRxQYaHX1Z6QK5
 9oQlqjpBI/TB7mYuBGcHsE6uUMkuG80CwTEuIA41TOqGI4DgsH5dImanhwfa3rnP8k
 9qDmGWqL85NkeTHOUl3D0ZvkB5NzyFknj+hVo8YTAWQYf6dCUWXsgWAGJrNfWq/Zcu
 ze4yNo6KHckEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 318EF1CE21E;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9636415F99;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8E22D3241C; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 57/91] hw/intc: Fix arm kvm gicv3 selection
Date: Tue, 25 Aug 2026 10:05:29 +0300
Message-ID: <20260825070619.174584-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:

  $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
  ...
  qemu-system-aarch64: unknown type 'kvm-arm-gicv3'

That patch did remove a test for TARGET_AARCH64, which is fine because
it has been a long time since we supported KVM for AArch32.

Cc: qemu-stable@nongnu.org
Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812200308.289238-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d05febdd32cc6d6a0700994d25ae3ffccdc97e76)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 377de78bb41..f6c7f08ccee 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -48,7 +48,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
 stub_ss.add(files('arm_gicv3_hvf_stub.c'))
-specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
-- 
2.47.3


