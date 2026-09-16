Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8560BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kME-0000kE-Df; Wed, 16 Sep 2026 03:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kL9-0008Kt-VM; Wed, 16 Sep 2026 03:46:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kL3-0005Hk-0J; Wed, 16 Sep 2026 03:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544614; bh=7N0jd0jFL16W4G84h8L0ipzoPoATQkQs6WcUF3CIKPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Atx0+V2Jacs3Uhs90mMg4pfDL+FnpIfWI+YQ8DTgTnDgYJSOIfuxBcRzoW4JUmdFu
 1PQiPh0Hp6Q069SVb0uv630RA17O/XpCDjj+tXmTp4M71Ypd7kJfMTiJdZDmFQjUn1
 YgNsZUCDmJEi8rz3K0SOWSxTIfSgT6awE8HrKq5OhrEaQ/RIhNDXJkbYmAXJdXhaXH
 lQCjI4e+VknufXaB2GTQMkKFUvaAYLo0ONz+jdtM1CX54wFETuC2mvJMxnA1TSwhbw
 vI8AdRVffjlU7pIHJeh326m+a+P/vc2kOZVQlnKqhLy9uQqNjDFXbR49TOql/jwlJ9
 Sr56ipVFoEiVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D53A51D55A6;
 Wed, 16 Sep 2026 10:43:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6516F429B4D;
 Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 57DEB5A6F1; Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 24/49] target/arm: Correct reset value of SCTLR for
 arm926, arm1026
Date: Wed, 16 Sep 2026 10:42:42 +0300
Message-ID: <20260916074346.671467-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

For the arm926 CPU we reset the SCTLR to 0x00090078.  This is not the
value specified in the ARM926EJ-S TRM (ARM DDI 0198E), which states
that bits 16 and 18 are SBO, bit 17 is SBZ, and bits [31:19] are SBZ.
It's also not the value seen on real hardware.

Similarly, for the arm1026 we use the same SCTLR reset value but
the TRM says that bits 18 and 16 are the SBO ones.

This has been wrong in QEMU since 2007 when we first started actively
resetting the SCTLR to some fixed value rather than zero.

This wrong value didn't affect any of QEMU's behaviour, because we
don't implement any handling of the old pre-v6 meanings of these bits
(which were IMPDEF), and their v8 reuse is guarded by appropriate
version checks.

Correct the reset values to 0x00050078 (i.e set bit 18 and not 19).

Cc: qemu-stable@nongnu.org
Fixes: 610c3c8afd99f4f11 ("Reset ARM cp15.c1_sys to default values. Fix XScale cp15 accesses.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4202
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821114138.4068582-1-peter.maydell@linaro.org
(cherry picked from commit 59716ac3067d2f87550fa3a59bdbaf9180c06c7b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2c45b7eddda..42221383e22 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -134,7 +134,7 @@ static void arm926_initfn(Object *obj)
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
 
     /*
      * ARMv5 does not have the ID_ISAR registers, but we can still
@@ -175,7 +175,7 @@ static void arm1026_initfn(Object *obj)
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
     cpu->reset_auxcr = 1;
 
     /*
-- 
2.47.3


