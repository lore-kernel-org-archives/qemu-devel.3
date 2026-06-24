Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F99CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrq-0004er-9z; Wed, 24 Jun 2026 01:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqh-0002yq-26; Wed, 24 Jun 2026 01:08:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqd-0005s2-5L; Wed, 24 Jun 2026 01:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=05mecBhi770Bw714u2LeCVMpB1SXvlZ2+VgwwDck+io=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eMn/e18HIAhdWO9B4dYBOhcJUGgenbALGlnGcgqH87ngG4Y5vdH0viTGPckAnie1M
 weXwzjoYGI1DCm9mGkhzdOKyryzn9/qNnMCIqt+VWZj5QT57TYrq0YMHLZX0wUqQ5F
 ZuyzoCnObwx9R0b168RH8IDqfRfbQAzIjpof+M8l7LvbIgjYeREvbpEfhxBMTDKKyC
 mCnHT4ikSYd0zK7WXM51WzjYH6rIj7owjK71/lYcVorWywbUVnUWztrs0PKJ6JPhVI
 G7S3rex96BEp8wXTzp72uOgHnQBR15gYvELM7jfPmL2vsHZ46XxYv11GbavWhrLSau
 d3cs1Ox3R05Pw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F411F1BA669;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE9733DDB06;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 75/95] target/riscv/csr.c: fix mstatus.UXL reserved
 value
Date: Wed, 24 Jun 2026 08:05:10 +0300
Message-ID: <20260624050541.395079-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

By the priv spec the value "3" is marked as 'Reserved' for mstatus.UXL.
Handle a mstatus.UXL = 3 write by writing the current 'xl' instead.

Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3367
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514194537.2416243-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit ddfd33f1965804fc4a718d8d46bc150525c2f9db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c6362677ba..6db48c67a7 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2028,7 +2028,17 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (xl != MXL_RV32 || env->debugger) {
         if ((val & MSTATUS64_UXL) != 0) {
+            uint64_t uxl = val & MSTATUS64_UXL >> 32;
             mask |= MSTATUS64_UXL;
+
+            /*
+             * uxl = 3 is reserved so write the current xl instead.
+             * In case xl = MXL_RV128 (3) write MXL_RV64.
+             */
+            if (uxl == 3) {
+                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+                val = deposit64(val, 32, 2, uxl);
+            }
         }
     }
 
-- 
2.47.3


