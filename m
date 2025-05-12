Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594E0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJaR-0007nh-Q6; Sun, 11 May 2025 23:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaH-0007dv-IQ; Sun, 11 May 2025 23:12:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaF-0006ns-JN; Sun, 11 May 2025 23:12:05 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso1283380b3a.2; 
 Sun, 11 May 2025 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019521; x=1747624321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpUeuD6OZJyDM2Hop6bgrOWtiuxzrKMfUFO7sH3Yte0=;
 b=nSiu+U4+VxRIFDkLBuaWQoMwcZVK1X2oKoxoBa9baL40OKJqyAWyQpDauG8dzS1etJ
 LDJeHk9T4yubmsmRtWBNF1sWRz8tBaeCi4x+SnFNT6JztXIm/Raeeo0NxHBm6E32lXGa
 4KKzQw6CUYs2ui17PD2nXjbQeiWw69CZOU4Adpi+dHLTetCyO0AllLLTggOmWH0/g4jG
 b4ziz0/eNhWFUnc5SVCvUf4jPiNrmbWA6qidOiSzPY8nJgtdAK0QuulYMiTXHe7/CeQy
 d6XrVWe5VUtlO1gYsItD3IkQBOeN+EFLCtdPb+UyZ5xisqH2ew7r41WnHg0x/v93mDbF
 BBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019521; x=1747624321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpUeuD6OZJyDM2Hop6bgrOWtiuxzrKMfUFO7sH3Yte0=;
 b=YXp1qUgxy+O9U7X0pW9EJwF1EpVJnKQWyKqFEE8eWnWpNVXremMVxkVBbLu5AisiB3
 4My8FDOIeUUV+VoSEWvxhcWqP1MpfUoBos1IuHc+ybFp5pCJAxeFJBboaZF74CbRdyPF
 KIt3DTx6B6UoTDymN9N69AmpEroTi+H2Ppm/tMyf27JFjZAVxzSl17yBDT9AajAFGXsJ
 r2WxDIVYZcHSADzB/5fxJDO7cQr6/EtOF56LidKJJJGxkBmAqGPi+ZwF/8wwM/3Mrm/6
 2wtyc5s67z1NAe+0t+TePUI/chPQadawS5pKlZKH/efLOGBD2yzfLOcdHv29r0DXmK2b
 ewMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2F0lKeP3WdfjLzFIy1Z1n0EpJxIp96rvToQxJ30R7PDwmlL2IrKwfEl0obmjDRGizWoVJaaXqWGDF@nongnu.org
X-Gm-Message-State: AOJu0YyrGSB5hr99GFOXLrwlmMrhG+FvIxAa7IqaXy1JRX//Pyn1pwI1
 n8HcEPBHu5SXZQ0p0sxV6PvHHyzCNqmnb6DIY/0MgzMfPLz83Ces/HNuNQ==
X-Gm-Gg: ASbGnctIu07sTHDb31M+crU17dNDISYpc/SOdk3lLl+9u2EpMZ2iZZ4i/oGQFGvKOji
 gslKEoha2oJ7QHSjXirecpGyHR7y9HqmbiaTh94vjynopgISyUygL/JZzw0RLEXsV23aVVAh/dF
 vxOd9ByMU9dZXUolqsubaaH12QM8/+TIcqfMgQolx8h4JnZS2DIpAloTEgS5voDzT8i614xPCrX
 e71UrNNf4IG6guN2+mtoasstmuYj3n7SdlWwZNlbW50nWpwEJqY4roNet/65710+1lurXLT3nK1
 fHhMXuxsfmSQ/HAcRDmMsLfmnzbqb4oEryDqKuFpf/2MCeMc/07mSZCq3A==
X-Google-Smtp-Source: AGHT+IE7qISLIY922r1lnkm+xRCwbR9jUTetmW1Xi7PtUFg3AcBtMVujD2G6uRnsSSm5B7QV0FFLZw==
X-Received: by 2002:a05:6a21:8dc8:b0:1f5:6c94:2cc1 with SMTP id
 adf61e73a8af0-215abb3a04dmr16669396637.21.1747019520943; 
 Sun, 11 May 2025 20:12:00 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 14/50] ppc/xive: Explicitly zero NSR after accepting
Date: Mon, 12 May 2025 13:10:23 +1000
Message-ID: <20250512031100.439842-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Have xive_tctx_accept clear NSR in one shot rather than masking out bits
as they are tested, which makes it clear it's reset to 0, and does not
have a partial NSR value in the register.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6293ea4361..bb40a69c5b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -68,13 +68,11 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
          * If the interrupt was for a specific VP, reset the pending
          * buffer bit, otherwise clear the logical server indicator
          */
-        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
-            regs[TM_NSR] &= ~TM_NSR_GRP_LVL;
-        } else {
+        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
             alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
         }
 
-        /* Drop the exception bit and any group/crowd */
+        /* Clear the exception from NSR */
         regs[TM_NSR] = 0;
 
         trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
-- 
2.47.1


