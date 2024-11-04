Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A1D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koc-00076B-L2; Sun, 03 Nov 2024 19:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koa-00074z-Ea; Sun, 03 Nov 2024 19:19:28 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koY-0002F2-Gj; Sun, 03 Nov 2024 19:19:28 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so3171172b3a.3; 
 Sun, 03 Nov 2024 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679563; x=1731284363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqpqSjhDlR0KKOwKpuJzD0Sk7j1XMBWO2P6fYwp7tiY=;
 b=Be+oU7wYANy+A7XdBjU1USzy4P/GOUk8yaUqpcYcntE8TvpelzHAB3qdGzWUCWxyt8
 v3sGMP8Oda3XOVcu7iXXURQJUY46LP/ZsGZAx4sZtuPdGkR/Gib4MjjVywW31Xl9yrat
 EFbRXEceDhkhfXBZY+XbAg0rw6KGE22sHWTNRra38bibzxmWepw49ISSatAtEZeQVh91
 3l5xMkwTmU9L5wkJwcpKUEtl2eM2INtVsv1AnprBfkZizL2dct9QlRO+t0TjZrCPKJBu
 GkEKHl/WntCqxmV76nHAyuwY+WVnMP4VFjjNe81aVzToA6VhwTiZiht2oN+lgGC8Imux
 dDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679563; x=1731284363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqpqSjhDlR0KKOwKpuJzD0Sk7j1XMBWO2P6fYwp7tiY=;
 b=HK26RYsIrU5Hcl600NEY6+sXcsF4dht2Uce28ZAhgNUSBC/Qc9U22X77DyURbntn+d
 ni4p0N/hGK8IredOx/jHbONkXvSie2cOXTjSgIfA7IsEfYmo94+pdLQgrVei68RgZLUB
 Nx6f5n0MUOBlI67RYehBFNs8/ovhJfK4CL+AdnltbPzJwxhRoQ9a6+aeDyBfUvxqPBzl
 oEHSyZs2qUeT1H2/9Cv+5Xd+O9zQlRDylmswGUNSeVDSLpl0A3NkBjD0euLNZYlZdlkL
 ZRs2bNhDBiLrYHbWJrAoDO6jnZvUOIiSIINzOGRQTH/15/YqlKsijRG3cEnONF5N2AOc
 sApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiGKKrPHcpy0MCMEP+NRBYLMCNOhKmKmM5erleow/f56ADWL/QK17yo2Y4hUOANjuiS1o2w+6ycQRMfWQ=@nongnu.org,
 AJvYcCX97hg8vSthGqKq+fOjkx3dld8GKiJtRkF23qoFBUWeSI0FmBMkS+mnwxhDUHps8RV9JEsHonxBQQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw5JVDa18yy1lBnP1w8940aoh7R0jR2Qz75nLWdVuw/Kxlphbbe
 U+sOkycYrSdGSCe7hDj6FqRbqXkJidUwGkXy8nOgI+5JgyejFUFjohsJtg==
X-Google-Smtp-Source: AGHT+IGcGQYzgmsuMRDc2LVhOvirDpy9UtjXc4h4NdNmHRzW7i4XpkwRLUyJEqVzTLIp7n8398y6RQ==
X-Received: by 2002:a05:6a20:d493:b0:1d9:111f:4b46 with SMTP id
 adf61e73a8af0-1db91d86c41mr20656991637.12.1730679563177; 
 Sun, 03 Nov 2024 16:19:23 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/67] ppc/pnv: Fix LPC serirq routing calculation
Date: Mon,  4 Nov 2024 10:17:52 +1000
Message-ID: <20241104001900.682660-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The serirq routing table is split over two registers, the calculation
for the high irqs in the second register did not subtract the irq
offset. This was spotted by Coverity as a shift-by-negative. Fix this
and change the open-coded shifting and masking to use extract32()
function so it's less error-prone.

This went unnoticed because irqs >= 14 are not used in a standard
QEMU/OPAL boot, changing the first QEMU serial-isa irq to 14 to test
does demonstrate serial irqs aren't received, and that this change
fixes that.

Cc: qemu-stable@nongnu.org
Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558829 (partially)
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 10 ++++++++--
 target/ppc/cpu.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f8aad955b5..80b79dfbbc 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -435,13 +435,19 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
         return;
     }
 
+    /*
+     * Each of the ISA irqs is routed to one of the 4 SERIRQ irqs with 2
+     * bits, split across 2 OPB registers.
+     */
     for (irq = 0; irq <= 13; irq++) {
-        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route1,
+                                    PPC_BIT32_NR(5 + irq * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 
     for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
-        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route0,
+                               PPC_BIT32_NR(9 + (irq - 14) * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75..bd32a1a5f8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -40,6 +40,7 @@
 
 #define PPC_BIT_NR(bit)         (63 - (bit))
 #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32_NR(bit)       (31 - (bit))
 #define PPC_BIT32(bit)          (0x80000000 >> (bit))
 #define PPC_BIT8(bit)           (0x80 >> (bit))
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-- 
2.45.2


