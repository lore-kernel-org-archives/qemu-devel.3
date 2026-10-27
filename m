Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410B606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeVaJdYg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5h-0002x7-7U; Tue, 27 Oct 2026 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5g-0002wg-2j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:20 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5e-00007I-JH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87199401BE;
 Tue, 27 Oct 2026 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2002D1F01825;
 Tue, 27 Oct 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137937;
 bh=ncuZGiDq7qjELiRW4lF+A0ExaCCvEQiV272wfgrMbWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VeVaJdYgXvchzuSfZR+SUShnSHXqgh+/hYAyiUNOvF/70jLochNwFI+4X60ibYrnd
 IT7fLI9oP471f4W81197I2ZdE4yYLHnIHGqWOMK03U/5lNf2CKyncOOyHAGXLvts3D
 MSKNHRDjZP37/TqCb0rRETgD6je5QZvWZEHF6UCC3EHoTgDmapcE7+pTV/Het1lXSH
 /ml9IdQ7OzF0thg29+OUUtkps7mAydvylSKJyMxusptduxswrn2OZYgmJ2xhO1SBQZ
 3IyHYAGAlsBcr2hwwBDgGgCwyHV1UF3L/YLuCfB39BvoQ45tlbOLtQKywY4usWQG74
 /5Ts8wEjl53Gg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 3/8] target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
Date: Tue, 27 Oct 2026 22:52:04 +0100
Message-ID: <20261027215209.21150-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027215209.21150-1-deller@kernel.org>
References: <20261027215209.21150-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The physical PA100LC and PA7300LC CPUs implement 8 BTLB entries only.
HP-UX 9.05 seems to have problems if more are available, so reduce the
number to 8 entries to allow HP-UX 9.05 to boot.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c0ba787974..da48a78569 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -248,7 +248,7 @@ typedef struct CPUArchState {
      * ??? The number of entries isn't specified by the architecture.
      * BTLBs are not supported in 64-bit machines.
      */
-#define PA10_BTLB_FIXED         16
+#define PA10_BTLB_FIXED         8
 #define PA10_BTLB_VARIABLE      0
 #define HPPA_TLB_ENTRIES        256
 
-- 
2.54.0


