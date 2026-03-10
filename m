Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF4BFD88C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d0-0001HP-Oe; Tue, 10 Mar 2026 18:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05ct-0001FI-CF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cq-00073Q-UU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 0edbaf9cc0e13b780024bba7d2a928a4ba01b0c13d564f83eca1b27de50cf5c3 with SMTP id
 69b09bf5cc25e8f3d6d42584; Tue, 10 Mar 2026 22:32:21 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181940;
 bh=jOTwEOxx3J85EsCtIuF3C89um9gRvPWJov9qXSb3+V4=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=ik2WodbuVdIG58IN7te5YJRxRkQ8jxorRmHIPPRwL6ziB8GxLaelrqrwLtssxyeij
 y3fkogX56+tCEQ65qmYLyfCnBODnLgHVPf3qm09Ex+zpuVF1jUH8K3AOqoVl2ON5X4
 +WZhNofNRMeDH2eDdmHn6QdOLHEps9mU0vGmvrZCsAz5XTFgBlAp2qLOCe8JFK3DcW
 im7xNZQQbxoTmNJ04X89duzM7qM/X69/XlQrFZ2v6FZlzeCZMga9zmvW+xS00yNJ7l
 fjakig6yLCSUR6vJ0U0D17Nuds4lAlCUIaA1xGA4T9y2hW86Xis25NVyoC0YiZdOub
 RYYDLzb2KI+5Q==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:44 -0500
Subject: [PATCH 04/15] hw/alpha/dp264: Use rom_add_blob_fixed() for initrd
 params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-4-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=n8jVLGmiaqb05aHZhkRRE5WV8rbQyrZXfrD5hWT7dy4=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP747QnfgmQD/xXpofwhuvPuxZmuYdqmseD4quktN
 zO55vJe6ChlYRDjYpAVU2S5fFbirEPu7q60lT/uw8xhZQIZwsDFKQATUa1i+J9TU/7ZRHySZ9TR
 hWvkfDTiOIvZ+60OONqe+l2yecG6HhNGhtYH294an4m8eFjxfYeRpzXzwzTDS77ayjc0dfabz5w
 3hRsA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace address_space_stq_le() invocations with rom_add_blob_fixed().
This will prove helpful when the Clipper becomes resettable, because
the params will be reloaded without the initrd file.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/dp264.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 87af919895..f036d72268 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -183,6 +183,7 @@ static void clipper_init(MachineState *machine)
         if (initrd_filename) {
             hwaddr initrd_base;
             int64_t initrd_size;
+            uint64_t initrd_info[2];
 
             initrd_size = get_image_size(initrd_filename, NULL);
             if (initrd_size < 0) {
@@ -204,11 +205,11 @@ static void clipper_init(MachineState *machine)
             load_image_targphys(initrd_filename, initrd_base,
                                 ram_size - initrd_base, NULL);
 
-            address_space_stq_le(&address_space_memory, param_offset + 0x100,
-                                 initrd_base + 0xfffffc0000000000ULL,
-                                 MEMTXATTRS_UNSPECIFIED, NULL);
-            address_space_stq_le(&address_space_memory, param_offset + 0x108,
-                                 initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
+            stq_le_p(&initrd_info[0], initrd_base + 0xfffffc0000000000ULL);
+            stq_le_p(&initrd_info[1], initrd_size);
+
+            rom_add_blob_fixed("initrd_info", initrd_info, sizeof(initrd_info),
+                               param_offset + 0x100);
         }
     }
 }

-- 
2.53.0


