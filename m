Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F81BCD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB89-0003dj-Ts; Wed, 29 Apr 2026 16:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M7-0005I5-Nd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:47 -0400
Received: from a-painless.mh.aa.net.uk ([2001:8b0:0:30::51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M5-00057n-UD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=airwebreathe.org.uk; s=aaisp1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hTTlPltB87Jiy4ggwrXJ/CgZ7x1nyauhJv2LXZKrUW0=; b=k2RnfBXCo9otN1fWJiJvc4EIQ8
 wLqMiI6hNhRMcs8HmFLgmLtzrWd1AIaQekvIei1imdRtjj45ho1QmpFNzmjWyhz4UMrFThpHm3zAP
 cCCyCWavW8XJ5hJNnDPqkkeSqwGnKuaJe7yXatw9cYg4xQTctRhwlDtRHy0wna7atBRrQuGZMgOeN
 xfXonDsv5yMSFLmM977hc4gnjKxGX3dm+pOaFJTJI9Ng42WUbUfLK88NfP34R+Npv171z2WlzCGbM
 9Y397MQf/TE/PmY0KHn42UOIinWQTQYDdteKKoTFu6ZaYMI9VrtK3qYE5dl3b9epO2qJOlCIBvYF4
 ZAoaWMbw==;
Received: from thunderhill.nvidia.com ([216.228.112.22]
 helo=jholdsworth-sail.nvidia.com)
 by painless-a.thn.aa.net.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M3-00000003iOT-0qNL; Wed, 29 Apr 2026 18:05:43 +0100
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 1/2] target/or1k: fix gen_mulu using signed multiply for
 unsigned operation
Date: Wed, 29 Apr 2026 10:03:58 -0700
Message-ID: <20260429170519.2137725-2-joel@airwebreathe.org.uk>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:8b0:0:30::51;
 envelope-from=joel@airwebreathe.org.uk; helo=a-painless.mh.aa.net.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:01 -0400
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
Reply-to:  joel@airwebreathe.org.uk
From: joel--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joel Holdsworth <jholdsworth@nvidia.com>

gen_mulu() uses tcg_gen_muls2_i32 (signed widening multiply) but it
implements the l.mulu instruction which is an unsigned multiply.  The
low 32-bit result is the same either way, but the high word written to
cpu_sr_cy (used for carry/overflow detection) will be incorrect when
the sign bits of the operands differ.

Switch to tcg_gen_mulu2_i32 so the carry flag is computed correctly.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 target/or1k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index eb4485312f..1602e204fe 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -269,7 +269,7 @@ static void gen_mul(DisasContext *dc, TCGv_i32 dest,
 static void gen_mulu(DisasContext *dc, TCGv_i32 dest,
                      TCGv_i32 srca, TCGv_i32 srcb)
 {
-    tcg_gen_muls2_i32(dest, cpu_sr_cy, srca, srcb);
+    tcg_gen_mulu2_i32(dest, cpu_sr_cy, srca, srcb);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
 
     gen_ove_cy(dc);
-- 
2.51.2


