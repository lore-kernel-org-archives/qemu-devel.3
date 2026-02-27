Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0EDFEFB6E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1T0-0004Qf-Bb; Fri, 27 Feb 2026 12:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10Y-0004Ef-V3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:48:06 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10W-0004Ri-Lt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:48:06 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 38E4F1C00C2;
 Fri, 27 Feb 2026 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772210876; bh=csWXSgMvLLu/s4uO1TBWAsRV4yhoL8ER4BRpdpMb2aE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TVL79udivh+jEKI+yDRV472fISVdVWHDWL5+V3mK/whwVD01NONuL/B/uhL3VkbwO
 bLvNP0zOj6GSDiiVoOXylWvgMSCE+GuRcEn4norS0HEVFi1PASes5l/Dgq/ZaU4Aic
 lOL/mlRoz9XBF+FaWVBwuFMgYv2eas5djks5pshUKHK8Y+p/eAqhu+5dgIutBLCUSY
 U7d6HsYiIveDFRubFA2+1IZD5/eRyb4vDd9EIXJWflP4BhXxeQd8w6gi75xF8iyL64
 H6emzXC/NnRFYbqzfcEdvqBdyHPK9KwLTQLbfzqJcG0InF26JFFkr3AY87pODFcidu
 TvLqwgUCL6nLcZYwHVICspkmQK+w7bYXJySNHGBbBuQMyk0bmzCs6/xrnLqEtblAzR
 UWaLorNpF3itRr4q8xeeKSOaOm/Loo0yyxylZzzZLmkfM/heWSZL4xnuXFU5GPZy3Q
 o6nHFWmmFUv5ebnwu0XmmzT97pToGUZMubRIHPK8jKozK2GyWA0/tj/tkSpsdZ12gL
 9yQD4jJNzc/5rLjEejIcV/S3UJxw97BWxaZ2KqbpUB5+RZZYmX9eHPslBhNb0hVwJ1
 8DuzQPKUwDMjnA2kZ+OQTNU8MXEOXGUcJjfiRIa4F2m2FTr+Xfi8D9XiOYwTzJFCRJ
 ZxylYsgBUmrg8l0m3C8Rj7Rk=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id X3yltzk1xBL7; Fri, 27 Feb 2026 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Fri, 27 Feb 2026 16:47:50 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Date: Sat, 28 Feb 2026 00:46:33 +0800
Subject: [PATCH 4/4] tests/tcg/multiarch/test-mmap: Check mmaps beyond
 reserved_va
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-abyss-mmap-relocation-v1-4-c8ec0476894b@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
In-Reply-To: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=xtex@astrafall.org;
 h=from:subject:message-id; bh=Ch4YHmmE4DsC/m7FHP6NO4qOoidbitpNHb4YWm7olLM=;
 b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDJkLT0178499mvyh5r2GEW1VLb4FFv2RE78dzL/kvypyi
 jhrk8uzjoksDGJcDJZiiixFhg3erDrp/KLLymVh5rAygQyRFmlgYGBgYGHgy03MKzXSMdIz1TbU
 MzTUMdIxYuDiFICpNnJg+J//xNxe5O7uvjdLO4vZOx4/XqhmvECgo7curieaqTjXjYPhn2nkkQy
 ObRcfFyfEZU61iw+aEycUmHp8rtD0XzeCLRLW8gMA
X-Developer-Key: i=xtex@astrafall.org; a=openpgp;
 fpr=7231804B052C670F15A6771DB918086ED8045B91
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 12:17:26 -0500
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

From: Bingwu Zhang <xtex@astrafall.org>

Unfixed mmap calls where start > reserved_va or the max guest addr
should have a valid result.

Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
---
 tests/tcg/multiarch/test-mmap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 88f7a04101a3..2bfa52912704 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -497,6 +497,20 @@ void check_shrink_mmaps(void)
     fprintf(stdout, " passed\n");
 }
 
+void check_mmaps_beyond_addr_space(void)
+{
+    unsigned char *addr;
+    addr = mmap((void *)(-(unsigned long)pagesize * 10), pagesize * 2,
+                PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p errno=%d", __func__, (void *)addr, errno);
+    fail_unless(addr != MAP_FAILED);
+
+    memcpy(dummybuf, addr, 2 * pagesize);
+    munmap(addr, 2 * pagesize);
+
+    fprintf(stdout, " passed\n");
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -540,6 +554,7 @@ int main(int argc, char **argv)
 	check_file_unfixed_eof_mmaps();
 	check_invalid_mmaps();
     check_shrink_mmaps();
+    check_mmaps_beyond_addr_space();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */

-- 
2.52.0


