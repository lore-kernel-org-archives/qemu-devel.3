Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC5C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJm-0004Yp-Bd; Wed, 16 Sep 2026 03:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJj-0004Wc-MY; Wed, 16 Sep 2026 03:44:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJi-0004xA-61; Wed, 16 Sep 2026 03:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=O7uvzl1j2rwcDtI6oY0RT4kLJrwWtasNHNozCBBEW18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A3CBRRZw27Hdra1Ul3wKPWfd4JNJFlMLS4vGQnY8JJwo6ViN2jpiOph37CaNdfTG3
 Ujstkg7WGwzBrqBxkIOsE/Tdjgv59LvF6PX2PCS0PKD1O/h59LQxmOnnRxc2EuFsxl
 4JU2p8cupriXgEXUChHRkJn9QHCAMV23Hkdk6ulHKKsFTnGBeF8mMnIa6RcCoH128E
 1ffEvQybd4Akn71jml5QAfY3nJTygb+5BpltUnrlbSAbo5ih6Y9kmfksifW6vjcE4h
 BTh/SDlFQVrKpCDlqRFakhsBTpaGTe1lMYSq+8gK015D25HJVf6IRj5SsPitRl9Lir
 hpfYK5klfApGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E3DB1D5597;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CFD23429B2C;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B0DD75A6D9; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 12/49] target/riscv: tt-ascalon: Enable Zkr extension
Date: Wed, 16 Sep 2026 10:42:30 +0300
Message-ID: <20260916074346.671467-12-mjt@tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-7-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 569aa6280d141129c705c361350705832b33cf88)
(Mjt: back-port to 10.0.x across v10.0.0-1083-g09ef7d97454a
 "target/riscv: convert TT Ascalon to RISCVCPUDef")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf4855ec02d..5e37cc3645d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -646,6 +646,7 @@ static void rv64_tt_ascalon_cpu_init(Object *obj)
     cpu->cfg.ext_zba = true;
     cpu->cfg.ext_zbb = true;
     cpu->cfg.ext_zbs = true;
+    cpu->cfg.ext_zkr = true;
     cpu->cfg.ext_zkt = true;
     cpu->cfg.ext_zvbb = true;
     cpu->cfg.ext_zvbc = true;
-- 
2.47.3


