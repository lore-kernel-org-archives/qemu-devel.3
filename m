Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2BEC83F05
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Jul 2025 13:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYP24-00070I-5k; Sun, 06 Jul 2025 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacantron@gmail.com>)
 id 1uYJIM-0001Bo-LD; Sun, 06 Jul 2025 02:56:15 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vacantron@gmail.com>)
 id 1uYJIK-0003cp-Un; Sun, 06 Jul 2025 02:56:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso2070537a91.0; 
 Sat, 05 Jul 2025 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751784970; x=1752389770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s6ke95iJSuysac/p4mOP05Yo3reVZr/NakBmxO+eLKY=;
 b=PSlU8KijEnMSsU8WJOPfbh9sMZAbMeYuf7b5dXrPo8xHtQ51CRAuC/3bx0HYqTEI3/
 ft/2CLqIb9yyh/ppnQIzVE/0tCTg+nu/n82hbmSMbXWQhlMDh/rZyzmDZW8bNvlfPoka
 7Y+PQBZ38s0ESAUxeQll9G/pIDd5R1CIZ+Bq00tMsLK2FURwDcLsaNEbby5Xqfo2Tkz0
 DjWd6mXRQAHT1AbaD6puiNY4uBxRfOjcISMy2xAFtvqEx/+L0G8jjGZVw3FrqYbBoEXb
 k6igNeU52etteKGiHIC+6ArFtStNACm2TdFJh/MvOdIzRQ7KtEzO9wduPQ+kVUnvd0a1
 C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751784970; x=1752389770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s6ke95iJSuysac/p4mOP05Yo3reVZr/NakBmxO+eLKY=;
 b=qskL8GnHv12dqJC1SI+ctfp3+4iPt/LTwhvVu8jxBQ6wrhifmRAU1cGJmNwc9Gvmyo
 QCGnAyHTJG/kaJYTdKJUgZkxDnBVKzQRLQrElPujV+dCuCO6X3vWhYWe/Oir4d5/rkoh
 jkDlZ5vXQOhWcO0SUJDaNhu+t5z9pVjgjZk125DaZmMKuy7CAJ/ApaCkw+nK2icEEcGg
 q2k/hoIcoZfgm75DPkJmI/MQJ3jShqtvCADntyiieDVxjYp7jcwbJluPNPIsrXzIOu9B
 KNp+PnjPBOnTgn1dv2JP1pmGExbvwcH0YfQV5XFKFFnSx4jJ8jEmC5ruPHzo2M3bBqiE
 6Xjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUQPGJeHN5qHNXx/cwkrfJ4WPmgzDG8lX4DBmJ2kgzj/f5ABqq05ap3iEEwT4+vZNazVQ21vzhQuWm@nongnu.org
X-Gm-Message-State: AOJu0YzOXBBwc+Lq/rgAiiYaSBVvgIXbkGQ0eplnBX1mm4uHRnXY0CQg
 Im++yMYZ+QZZEh3uhcUYh5+3GNZLyqTeVS2AuYkEO8sna16pc2ezYw+yKKJJYLVFOh8=
X-Gm-Gg: ASbGnctqEVdRqAVRUhrFJ28wZ31w8o2kqYP3TGeDGvjYJOA2wP5gaCBuWdLNSYJJizM
 KNhd5p7qZ6HUxIbW4+KeJqU0bRa/vRRUIlAOEpFV9gNG0C5b7HKUNT9Dqj2VQ8sAeEABAXdXHJa
 gvGySvW+UOLC87rZJaXhT6dnsIYJSnAXqUecJeDak41bQXnAjpg0swHvYlMHGmSzFFiU6Vpagz7
 7IO/qQWxhATgtheVEZdO8hM8qlrLf1awfVC48DeuMUtpZg94mvmcnmD9fMcwAI5Wc7AgES+5ORR
 0kEs4LrmBGdA0TgWYcUY8D4eqWiIAs3Y2p7mO06pa3Q7XkdsUQT10xLEipY65nkmSl/GOAbczcG
 R8uGPEDre56wGf22I+D0Yxl6BFb0=
X-Google-Smtp-Source: AGHT+IE3PBp+BwOYjet2Vt2FdCGXfiVrTQsQd+8m0FvSXbBlhmIgEdZ7GgS/hZyjErOyvKPVJJNCQg==
X-Received: by 2002:a17:90b:3c52:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31aac4cd309mr12652746a91.28.1751784970114; 
 Sat, 05 Jul 2025 23:56:10 -0700 (PDT)
Received: from localhost (114-32-247-71.hinet-ip.hinet.net. [114.32.247.71])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31aaaf6fa19sm6280670a91.47.2025.07.05.23.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Jul 2025 23:56:09 -0700 (PDT)
From: Vac Chen <vacantron@gmail.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org
Subject: [PATCH] target/riscv: Fix pmp range wraparound on zero
Date: Sun,  6 Jul 2025 14:55:54 +0800
Message-ID: <20250706065554.42953-1-vacantron@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=vacantron@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 06 Jul 2025 09:03:46 -0400
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

pmp_is_in_range() prefers to match addresses within the interval
[start, end]. To archieve this, pmpaddrX is decremented during the end
address update.

In TOR mode, a rule is ignored if its start address is greater than or
equal to its end address.

However, if pmpaddrX is set to 0, this decrement operation causes the
calulated end address to wrap around to UINT_MAX. In this scenario, the
address guard for this PMP entry would become ineffective.

This patch addresses the issue by moving the guard check earlier,
preventing the problematic wraparound when pmpaddrX is zero.

Signed-off-by: Vac Chen <vacantron@gmail.com>
---
 target/riscv/pmp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3540327c9a..72f1372a49 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -211,11 +211,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_TOR:
-        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
-        ea = (this_addr << 2) - 1u;
-        if (sa > ea) {
+        if (prev_addr >= this_addr) {
             sa = ea = 0u;
+            break;
         }
+        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
+        ea = (this_addr << 2) - 1u;
         break;
 
     case PMP_AMATCH_NA4:
-- 
2.50.0


