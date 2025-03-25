Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4189AC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy9H-0005l5-1O; Tue, 25 Mar 2025 02:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8J-0004xb-CP; Tue, 25 Mar 2025 02:51:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8H-0001j9-A0; Tue, 25 Mar 2025 02:51:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24002107D6D;
 Tue, 25 Mar 2025 09:49:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BACF51D5E7A;
 Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B57FC5703C; Tue, 25 Mar 2025 09:50:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 45/51] target/loongarch: Fix vldi inst
Date: Tue, 25 Mar 2025 09:50:32 +0300
Message-Id: <20250325065038.3263786-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250325094857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>

Refer to the link below for a description of the vldi instructions:
https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88
Fixed errors in vldi instruction implementation.

Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
(cherry picked from commit 02ce6cea71be4f6774351f5e658d50044c5b53b2)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2865
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index ba5ca98a33..dff92772ad 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3480,7 +3480,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
         break;
     case 1:
         /* data: {2{16'0, imm[7:0], 8'0}} */
-        data = (t << 24) | (t << 8);
+        data = (t << 40) | (t << 8);
         break;
     case 2:
         /* data: {2{8'0, imm[7:0], 16'0}} */
-- 
2.39.5


