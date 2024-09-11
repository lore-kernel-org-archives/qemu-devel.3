Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CACEEE57D7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 22:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soVq2-0000W2-Rw; Wed, 11 Sep 2024 18:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1soOJO-00076T-DM; Wed, 11 Sep 2024 10:27:19 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1soOJL-0003Gn-Re; Wed, 11 Sep 2024 10:27:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com F2050C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726060773;
 bh=Y7u+ZYWkETAKlOCWN/jUACcmbj4sINmDqk7xJHoZJoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=P/TrnvxvHblvXz3+bReMoZr4E4IN6/vy8OCbDb9r+lhaf2QvE+BvHLIvyJ8KHngmR
 1ywla6wZdwMiIj5S21eF1P/v68H7am5qiaUiQ7wJcjPdy0fp9OcBnGn6aZBUfLVfXR
 KG3XOkie1bSdE81c4iTKs+z4eQfyeL/0F5CTUat5g5oiIxidSl+dnFppeLmKr8nYAF
 T/9UsmIgfSM0AOdHydG8teG+MnBHWMEAgfFpav7Kw4pWzIjZpXAQjjMwGErQLLcY6K
 VlT4PrFD5rSy70AtG2JeFGyefDkcd6R8NYaQiPW8P1LJLEYdCmidJXr0ExFemQXRiW
 yISNqqxP0v/Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726060773;
 bh=Y7u+ZYWkETAKlOCWN/jUACcmbj4sINmDqk7xJHoZJoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=J24XvOOboKNbhib58AlLfDDocaUocxF8D6gr9EUn7SjElOlDC9ou3Rai/B6pvPFPk
 kmM8XgJR6OOAwGOPzRScq6T+94A3K86f9NQKIM+eRR+C3VsrHlKCfhJuiRpB9Xrmc+
 zvzBEdWMXOOwPaOlD+S8/zi7PdPYW5+6pDkevOhgVW1oPmUjYjD6L/qiw3zm6VPZ1u
 VX3H/JqBv3xnuAYJkEWvvtChWruyYD9r2PcTVkcKlGKLsFsVxpHTv+vVYdScTFXTKX
 9BYyHt2fSfdEgu7eP4AbjPVCNw7n15qZtxZPBRmGzlWx7AcdGXimAk0sjMMvkg2h4o
 8VvBtWNOWs0ug==
From: Sergey Makarov <s.makarov@syntacore.com>
To: <Alistar.Francis@wdc.com>
CC: <s.makarov@syntacore.com>, <bmeng@gmail.com>, <palmer@dabbelt.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] hw/intc: Don't clear pending bits on IRQ lowering
Date: Wed, 11 Sep 2024 16:19:00 +0300
Message-ID: <20240911131900.179648-3-s.makarov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911131900.179648-1-s.makarov@syntacore.com>
References: <20240911131900.179648-1-s.makarov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=s.makarov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Sep 2024 18:29:03 -0400
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

According to PLIC specification (chapter 5), there
is only one case, when interrupt is claimed. Fix
PLIC controller to match this behavior.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
---
 hw/intc/sifive_plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 3f3ee96ebc..deec162630 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -354,8 +354,10 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
 
-    sifive_plic_set_pending(s, irq, level > 0);
-    sifive_plic_update(s);
+    if (level > 0) {
+        sifive_plic_set_pending(s, irq, true);
+        sifive_plic_update(s);
+    }
 }
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
-- 
2.34.1


