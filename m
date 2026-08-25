Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56539C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6M-0000Oi-Gu; Tue, 25 Aug 2026 07:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6K-0000Nw-Sx; Tue, 25 Aug 2026 07:13:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6J-0008Cl-Fq; Tue, 25 Aug 2026 07:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656395; bh=Z//E65YoQwfg4ySQlk2exZtmSHQmLGsAwWqByd9Smbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n6iZXZklfdHHGZX+1ML4y/haROJGnbrppFpoforz9qrHxToK1mvlhfZw1FmxGtJFG
 Q06QmtvyTKUSDtj9adrJqOOIhGJyrkwajWdBa+sN698M1od5p7fP35wxnYghwAXB0u
 bN/6qUOfiThi0TqCyz+79jvcf3rDIjfw4VnWMlAbKmijd7JywZoF4zbPSD1GVyl7SK
 uInEh0A/760CrUniWUrymVwX/l1SGvT107xypdET+e2it0OrrLymjK/SG/R+G0cjR5
 zWZ3RzC04T7cLDFDZuXINU5AmyzPMHRLxR6oIaZ5uw23BPsQRjjdUne/mRTsCViWMu
 XO83jyumUtTug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E76911CE4A3;
 Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0AB8D41626F;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5FE2C32589; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 135/166] tcg/optimize: INDEX_op_mul is commutative
Date: Tue, 25 Aug 2026 14:11:31 +0300
Message-ID: <20260825111206.482723-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Cc: qemu-stable@nongnu.org
Fixes: 7a2f7084525 ("tcg/optimize: Sink commutative operand swapping into fold functions")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3181e53c13a1a68e2b54c94b1766f8e384c01b4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3ecc3fb5e3b..1b9553737e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2044,7 +2044,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) ||
+    if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 1)) {
         return true;
-- 
2.47.3


