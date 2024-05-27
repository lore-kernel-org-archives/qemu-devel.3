Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66385C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVgt-0000St-J3; Mon, 27 May 2024 04:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf8-0005NI-VT; Mon, 27 May 2024 04:25:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf7-0001Ep-Ey; Mon, 27 May 2024 04:24:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48B9D6A583;
 Mon, 27 May 2024 11:22:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 757E3D8520;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66468 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 38/44] target/loongarch/kvm: fpu save the vreg
 registers high 192bit
Date: Mon, 27 May 2024 11:21:29 +0300
Message-Id: <20240527082138.66217-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Song Gao <gaosong@loongson.cn>

On kvm side, get_fpu/set_fpu save the vreg registers high 192bits,
but QEMU missing.

Cc: qemu-stable@nongnu.org
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240514110752.989572-1-gaosong@loongson.cn>
(cherry picked from commit 07c0866103d4aa2dd83c7c3e7898843e28e3893a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d630cc39cb..e2dff2b795 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -436,6 +436,9 @@ static int kvm_loongarch_get_regs_fp(CPUState *cs)
     env->fcsr0 = fpu.fcsr;
     for (i = 0; i < 32; i++) {
         env->fpr[i].vreg.UD[0] = fpu.fpr[i].val64[0];
+        env->fpr[i].vreg.UD[1] = fpu.fpr[i].val64[1];
+        env->fpr[i].vreg.UD[2] = fpu.fpr[i].val64[2];
+        env->fpr[i].vreg.UD[3] = fpu.fpr[i].val64[3];
     }
     for (i = 0; i < 8; i++) {
         env->cf[i] = fpu.fcc & 0xFF;
@@ -455,6 +458,9 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
     fpu.fcc = 0;
     for (i = 0; i < 32; i++) {
         fpu.fpr[i].val64[0] = env->fpr[i].vreg.UD[0];
+        fpu.fpr[i].val64[1] = env->fpr[i].vreg.UD[1];
+        fpu.fpr[i].val64[2] = env->fpr[i].vreg.UD[2];
+        fpu.fpr[i].val64[3] = env->fpr[i].vreg.UD[3];
     }
 
     for (i = 0; i < 8; i++) {
-- 
2.39.2


