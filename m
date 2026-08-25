Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3CDC61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylIJ-0004fP-8E; Tue, 25 Aug 2026 03:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylIH-0004cI-FL; Tue, 25 Aug 2026 03:10:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylIF-0006Qy-Qz; Tue, 25 Aug 2026 03:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=5sC7OgL8qzCzSR3n048Hwdg9q6zJUB3Z33roh6iO8jE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y0b/GoIsdKsJSVMcbLVc5xQsKMMB7WHVAQxSkqAQm/1zPBw5RUB8MD3LU9u1puTJB
 yuNqIs/1gdh15sBAV2YvnaGlJpPDzrj6V+K26njiAvTzxL/4siUAhq0ZYAIT5fcJun
 Bj6KRlRdB/cqpDqWEUXRCptwkf3sZ9xgsUVfYxzc6Y/1srUvrqJOf3izD+VmcIA07O
 aB7vXMGFlcqnCDDfC4eudELxLlNEUxt7XhbkjeX3h9WD884sytTr5TPdBwqZlS15bC
 4pUPPm6xPlkF2xIs+LaxC3JXD7ObG6UrfAL9JAfXAhYaxCrdWOkdnhbkGUVpMdGkO2
 3XI0MI/WlobRw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A6B11CE232;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5CA04415FAD;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CA70832444; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 77/91] disas/riscv: Use signed type for vector
 immediates
Date: Tue, 25 Aug 2026 10:05:49 +0300
Message-ID: <20260825070619.174584-35-mjt@tls.msk.ru>
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

operand_vimm() sign-extends the 5-bit vector immediate field in bits
19:15, but returns uint32_t. This sends negative immediates through an
unsigned type before they are assigned to rv_decode.imm.

Return int32_t to match the signed value extracted by the helper.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-3-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 7899d3c6bdb008dd301b474f3524bad5f37a411e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index fdf75a12ef0..967739bdbbf 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4487,7 +4487,7 @@ static uint32_t operand_cimmq(rv_inst inst)
         ((inst << 57) >> 62) << 6;
 }
 
-static uint32_t operand_vimm(rv_inst inst)
+static int32_t operand_vimm(rv_inst inst)
 {
     return (int64_t)(inst << 44) >> 59;
 }
-- 
2.47.3


