Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4226DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTKW-0002NE-Jm; Tue, 30 Jun 2026 03:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1weTKU-0002Mr-H3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:56:26 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1weTKT-000231-40
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:56:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FC94601C1;
 Tue, 30 Jun 2026 07:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54860C2BCC7;
 Tue, 30 Jun 2026 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782806177;
 bh=i+iwUHWRs5J2pQrc4bbbiul0j7v12ylyz4AlGwd2BaE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=g3WElN32L6BeEHRBsJAZq9Jpcdudh7NHXK6QB9uPet22szsUZRfrnD9qgXbc/Ohjl
 9W3+jANwsceEwVQSuMAQLQTrzJDiFFXgbKzyCrCQPKb6MsmKvwPXCwhtULZfXwi0er
 3BuLvd6Kp9w5WkYcJ02rKs8X7PrmlWu2fscULRddYRFlP2bV/h69My4Ed892m9aDlQ
 9N3wgg3NmZBuSnGICLXeFOVxnIXDCarvY76f1lbnDvm6cgei6xiHiTnuLsmxz31NLK
 fv+mhRJb1OsH3jK0rPAAwY7WnTPPIleuBYOh2cbHGzLemdYQe1bZD5k5HqpxdJ7fNH
 AEo/sjy8Hs5gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC72C43458;
 Tue, 30 Jun 2026 07:56:17 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 30 Jun 2026 15:56:04 +0800
Subject: [PATCH] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJN2Q2oC/x2MWwqAIBAArxL73YJpSXSV6MNys4XQUIgeePekz
 4GZeSFRZEowVC9EOjlx8AWauoJlM94Rsi0MUkgttBK4h+CdbvE08cbDFCE9KDtlyYqZ+r6Fkh6
 RVr7+7Tjl/AF/a21FZgAAAA==
X-Change-ID: 20260630-loong64-vary-page-sz-253ded0be884
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, b4-sent@kernel.org,
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=P2yWSCAzG7Ep94c0IDqmt6Vf+hrglM5091uNh3I1QpQ=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqQ3aXlgurCQL3nbFGIngXREWSBvfHmQxB0Q+Pf
 gtjb0rJ9wOJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakN2lwAKCRCwMePKe/7Z
 bkqfD/sHaIJAqHxhYzIrezK4G6ydiZlKdhf60zKPyUF1YM7PyeyFHvuA9cFWCn/eWtetTHzCIJy
 8TEFYK5NB8gEQ2tUsxiqgJb4S9DvuPjXvKGArIH/nPOvoKUkkDdQtQE99K7MjUqFtKbiokZ4hxw
 PN+FJWW6pqLC29iKuDKgACX/exz4CVqOEgLmnOuiM88sbHYo/wRyxQlEzpAtPlEDKvKRLnJIdz/
 0hNwfFCzek4yG3k/SacA2xCPq/e2J8sLfKemQJoJ1YRXMe7BUjGEH5kBg2D1q8QONiOQC0WFb3F
 u92aFFAPEhtQtnXql4vYTEwvIhNuMDJnL7Zbovzu+vW42TNjASs1zJ3R2LlkvEzInIJTUn7XqlV
 YrOOUC6B36w4BdvO7VIyrBNkmmOAFycjag59ZRxD1C+fVGjuo9ZpWOT8c4y6oSfgtLw3r8xMVDM
 +TYmZYvkxPkJtS4D7nRNINbez+IsyJb2LKKbpQpBS69bBov9wsVS8uXg63TsyJq53UEQi/vNcZ0
 uelK3IZGUm58Q3C7HJWRJpKKhgsYrFCoSgxliCm8f9nXvfbDaZRp4e2DqZtXK+FvNbjj4P0KgPM
 oNcixh95BUkPY2k1mqJbk5+dBs8DKGjhua+EyIXyKFuthdnxZ4i3v2gzYqYJhHdw5ASJB/TyEWb
 ySK0JD3XlnqJlVw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
working on hosts with 16K page size.

Fixes: 1d832c19db1e ("target/loongarch: Support 4K page size")
Fixes: qemu-project/qemu#3651

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/cpu-param.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 3bcf77b3755abdc302699c22c7aa99e2e8c3bbf3..6abe72ff5cab46e246fde4fa76bce05ba7c1cd20 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -10,6 +10,11 @@
 
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
-#define TARGET_PAGE_BITS 12
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif

---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260630-loong64-vary-page-sz-253ded0be884

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



