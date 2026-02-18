Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48121E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslCk-0005V1-EG; Wed, 18 Feb 2026 12:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCP-0005Pc-Uu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:18:55 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCM-0005ao-8z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=l0HRAVma9ndkaSde+UB/ONObyP/1dQNd8nP9SB7nhk0=; b=DZAO9FzXzeXiaYn
 RWkoAuJPpQDrxTFs3EDX1vSQrokZo0Fmh77nyoxlw9Q57QSA4QtZRA4HuBn+n+wiNZnRW9eo53WaU
 7GybmtE8hZT+glEOriOAe5f9onMb6fRyvh55fZ4/eXWJoGWAtxJYeT2C6qmjUpoxYuTnBZnJ2MZOa
 k4=;
Date: Wed, 18 Feb 2026 18:21:28 +0100
Subject: [PATCH v6 2/7] hw/hppa: Use hppa_abs_to_phys_pa1x()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-phys_addr-v6-2-a603bf363218@rev.ng>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
In-Reply-To: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771435335; l=783;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=42KgcWQ/ftfrQLOF92oSXQz3WYbg/sVjiv4TZ+OpiWs=;
 b=xSxs5raGvuRZN1PA8+y+yoj0ZO1/4MNbkCbSTLmrAuKQveAI88xkyt4OP6Wn8v7ZsFLu6ECma
 4JFjgokY8IlCgnngEvVd4C/rMzicOvakusn3SsJ6I4tZAAQL1SWbDou
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Makes the physical address space conversion for 32 bit machines more
explicit, using the translation function defined in mem_helper.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c3680667ae..6b0f46c789 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -181,7 +181,7 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
 
 static uint64_t translate_pa10(void *dummy, uint64_t addr)
 {
-    return (uint32_t)addr;
+    return hppa_abs_to_phys_pa1x(addr);
 }
 
 static uint64_t translate_pa20(void *dummy, uint64_t addr)

-- 
2.52.0


