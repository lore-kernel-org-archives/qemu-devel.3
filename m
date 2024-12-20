Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E4E7718D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkbT-0005t5-3V; Fri, 20 Dec 2024 16:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkax-00052K-Gp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkav-00076r-Hl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43626213fffso21636925e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730295; x=1735335095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZhntQKj+2np0onfD6fTX3Bv/LcXZGFrE8GH8VrgUt8=;
 b=HXhuzy9po3Ob7mpGjGnypMbqH1ej1FR33bDcjlHH2qpQJeyEnAfuKpP/zc14QQC3Bf
 pAXgg+lh3oM2XAW/dOiQL7Hkt3cVyDEt2N6y1nX+PiPFSqG7FFJVlLRiHXSPdBlE/FRL
 DQpXkQATEWyXLMFhzZLjHki6slV7h+Ank3mLwtBmbeD4W+DY7CJxBo7oy+qwFzpRXFX9
 yaWSFPT5dKdAOQngh+VxPeDHWQZhV+gwtBxzoe7IY8uxURot70qVeNF8AUX1KSGT6gS/
 mdSz4CRXZS+YX8iVILQ+xh5IRyQBVQxgH/Etdr9mzymJ/3LgTGSYoFosRcrwTuJs6E5V
 3Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730295; x=1735335095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZhntQKj+2np0onfD6fTX3Bv/LcXZGFrE8GH8VrgUt8=;
 b=NlJQ3pyIAZOvAcfEPieKv0/Ii301l5AFO5KxkfBiaDzSPGqzrPs+NJVnkF830xHEy9
 ArDEWhiweZ1JVPDjn4zQ38CHoeFz/PcDUo3NzShpK3YShfioafHb4iNpdZgcn9xbdihZ
 EHifSC8rzsbVit5Qz8VZW30lQkl4yOOgWDMBBLGPbdmiVM7jQv00KUhq0Qr41nPkHK0r
 FXIIxqibJMH3IJjPkQaPxdJT/B5aNJvKEbX3HU/RuqCgZDv+ihv586qELS+hvbJ17fRH
 8R/B2H+EwztsozVVJm91eRFi5c0pJz7pRSY1URwmXdraB6y8Eiu8zGwPT3QCwbbt5A0r
 8U8w==
X-Gm-Message-State: AOJu0YwwzqvrkzZWj7SpPv1yvGA6CVdo9AjpU4QjxOzA2T9FfPUYYG9m
 tWX+envS/hEs6rz8UmqFnVTqPy5p8GQCGe0K0U7nXtLSPxAlkAw/l8ybJDx/vHfySl8SvSyxKXk
 D
X-Gm-Gg: ASbGncs2ezJSPIkDUWM9rzlj1/vOy5oA83uxZYz/GQG6SvuSf6jsn0LXFuNVXtl40/N
 v6PhXcW2/L+I+/j+otBlQIMaRXvU2LzpA1EeggQNrVOt0kSD5/4pxZh+riWHw0mI9E6FZKAlOd4
 IyTcZTLyxNm8fXgrWyl6d5nDJgpE6O2KULewBi4JpzZ28+DQnZleQKChERcxHnI3dMH8ImjWfu5
 L+Y5zSTdDXjW3EwOak9yRFJnn65ZXl4KVQ69HgVN85zJTk0TGbyfGHAL2mThExRirT9u4bz1qU=
X-Google-Smtp-Source: AGHT+IEawfv1eDKEtcfbktjs2UsUWawD1Ka1LOi05Oo6TrO5ZY4shNl1aExzD8czo2IbsqtVfIVMHg==
X-Received: by 2002:a05:600c:5850:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-436699ffa24mr36251915e9.9.1734730294794; 
 Fri, 20 Dec 2024 13:31:34 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm5048149f8f.81.2024.12.20.13.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 6/6] hw/ppc/epapr: Do not swap ePAPR magic value
Date: Fri, 20 Dec 2024 22:31:03 +0100
Message-ID: <20241220213103.6314-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ePAPR magic value in $r6 doesn't need to be byte swapped.

See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
and the following mailing-list threads:
https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCxuLyKqYk6_FCBrAA@mail.gmail.com/
https://lore.kernel.org/qemu-devel/D6F93NM6OW2L.2FDO88L38PABR@gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/sam460ex.c     | 2 +-
 hw/ppc/virtex_ml507.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 78e2a46e753..db9c8f3fa6e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
 
         /* Create a mapping for the kernel.  */
         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
-        env->gpr[6] = tswap32(EPAPR_MAGIC);
+        env->gpr[6] = EPAPR_MAGIC;
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a90..6197d31d88f 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
     /* Create a mapping spanning the 32bit addr space. */
     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
-    env->gpr[6] = tswap32(EPAPR_MAGIC);
+    env->gpr[6] = EPAPR_MAGIC;
     env->gpr[7] = bi->ima_size;
 }
 
-- 
2.47.1


