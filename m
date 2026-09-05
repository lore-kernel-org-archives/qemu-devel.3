Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C542C79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2eUA-0003vf-QF; Fri, 04 Sep 2026 20:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU8-0003vH-NY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1x2eU7-0000F2-3x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 20:42:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id CE11780796;
 Sat, 05 Sep 2026 03:42:16 +0300 (MSK)
Received: from i101646577.yandex-team.ru (unknown [2a02:6bf:8080:11b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 7g79b72ad0U0-x8InsZv8; Sat, 05 Sep 2026 03:42:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788568936;
 bh=Hx1+gsMbkV2GOHLR1F+fYKz6TYxQ6TxaJs0th/N9c94=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iClxAq0g15YPfCDMdbe27xpUz5TqL44MjEfyCe2HGOtMh8LSqTKDEouux4waYju8P
 eN4M6yjx9Aez43+2MaKKT+6sOsEJygqnZxE90vRoQoeUUfXvMxuzqFnpzMjZZhWjI5
 ukNtxe6U3LFDliGZlV6XS/XJpZlR5iGLJw9SRHo4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/2] target/i386: drop attempts to deliver an interrupt
 without a vector
Date: Sat,  5 Sep 2026 03:41:52 +0300
Message-ID: <20260905004153.836866-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
References: <20260905004153.836866-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

cpu_get_pic_interrupt() returns -1 when neither PIC nor APIC has
anything to deliver, and skipping this check produces a bogus #GP
inside the guest with an error code of 0xFFFFFFFA
(aka -1 * 8 | (1 << 1)) due to a failed IDT limit check in
do_interrupt_x86_hardirq().

The KVM path already drops such interrupts in kvm_arch_pre_run(), so
just do the same thing.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 target/i386/tcg/system/seg_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81..d1c626f120 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -204,6 +204,9 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0, 0);
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_VIRQ);
         intno = cpu_get_pic_interrupt(env);
+        if (intno < 0) {
+            break;
+        }
         qemu_log_mask(CPU_LOG_INT,
                       "Servicing hardware INT=0x%02x\n", intno);
         do_interrupt_x86_hardirq(env, intno, 1);
-- 
2.43.0


