Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6192C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWd-0007gX-5U; Mon, 06 Jul 2026 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWa-0007ek-61
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:40 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hg-L5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AEAE435F9;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D150C2BCF5;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=9HxzHKOVfC6LwhGTq7a0TLkV6OWHGgH78bnClOoowyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WO5+bIkPKEbkgKkpsK8p2P05WkgyYh73IAAmpQFxMhhF8LuTVZ6BuXCZNzutlpEtA
 4hOvCdcBqM3YwoMH+zJC7et+BYC96U4Od/WaNcZxSnxKy8TUW/AoQ555L/C3WzJq40
 QNyHcjGaQVowvuDrheVaTu0Hed/Ya/c69vbzWNiNMH6n+VeaznGHCbltaqV/IvANae
 tZj2PCQ5nMDzjmnflRdEcJ+ZR1jRi2ZANNvsDKIogcea9pTWPzTIqHvhvQKOWODI88
 tdXYRxhymM5EYvXUlWZsFmkw11rSZezIAC+Pli1xrXmENareYCwPNv9yzD/vk5Pg0v
 AtbRllOYCxgkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBFC44501;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:02 +0800
Subject: [PATCH v2 2/6] target/loongarch: Fix offset calculation in vector
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-loong64-be-v2-2-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=V/jhXbT74YZEsNz79vjrDNku8mR/iHXLwWV1UlDe90E=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnYggITlpKUwRmFxh1aB05ohhyyRzmGoL2M+
 CqtCJX5A46JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 bnmOEACnU5DLPMfDA5MFQ1iD4PapxQTzeGM5AH8+uDNVR6FyI2WMEp4xETs9/ks7vZF0xAZROdv
 tK6T8i04iGtK6skVP0YBw0aEEIWQ3aLb9EcCtDNB9vTHHF6oOs5OAEAd4Vv3noMSdUGwEOGHUzX
 dvW/isJeMnpOQjbKp+VKFiVecH5P88GnNawO1eNlnbuwcfRzbzckkTQ5LsjamjFgeqimhYRCD4F
 i7BaycWHd6PkJdoPEWWo6sTc631d8Ma/2saWcIp/A7GiGE+2D36am/fRyccW0dpAwAz8/7hLZlT
 qnJCnIbUFG9LJv1TnJ8dmOy/mtmOV424heF++hPA2tA/yShEt+gVLNKlP7su+16pYueRny/HtM9
 aW9/OVQyPGE9lZuXOPwRTgW1BnN9qe7xYIIsnTzOTzWHDpoz4uX2hiymRKQFFWQ6a0UwKp4ruSJ
 C05DNJ8znDMk3g2Rm38XSa7zMIJ7ygGptG3gzjNRaQyvQcauHxg3xxtIiu/9VpesUPL8ALP+Zvl
 Cdl/uIsp21eqhkLh3GBULw8sT7UIcrBMAjXtDOf/W220FK942HvOcFHprE0vylo0QXFnt66+VGF
 /bkpNBXXBw8G03IZNDVON67tEbgCoVFjZO1hvrjHeX6NjhxrvOu6FybiAVTjiTrz6J+0/IJk+K3
 jhv6e61ii03LbiA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
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

When vector registers are extended to 256 bits long, the expected layout
of the registers is storing two 128-bit integers in host endianness, as
indicated in vec.h. So when the registers are visited in the unit of
64-bit, the index should also be reversed.

Fixes: f5ce2c8f2c0a ("target/loongarch: Implement xvinsgr2vr xvpickve2gr")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce626954a85e5754de847ccba1796aebd8a6..ac4daadfdb5298a0850bdd0b1fce32407f1eeecc 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -41,11 +41,11 @@ static inline int vec_full_offset(int regno)
 
 static inline int vec_reg_offset(int regno, int index, MemOp mop)
 {
-    const uint8_t size = 1 << mop;
+    const unsigned int size = memop_size(mop);
     int offs = index * size;
 
-    if (HOST_BIG_ENDIAN && size < 8 ) {
-        offs ^= (8 - size);
+    if (HOST_BIG_ENDIAN && size < 16) {
+        offs ^= (16 - size);
     }
 
     return offs + vec_full_offset(regno);

-- 
2.49.0



