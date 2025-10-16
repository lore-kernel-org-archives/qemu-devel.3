Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E009CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Myn-0005KH-KV; Thu, 16 Oct 2025 08:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxw-0004im-0m
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxc-00008l-T2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so5393345e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617194; x=1761221994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttW3NAm+cuw9cqcCBrkEALJfpqIvO5EpoHGRi1aZFeQ=;
 b=DKbQOtGoKzTm0hOUaqC58fT66ILbhLSAFVe1nimvSkx7pepPO7ros+JVTsblqFhIJH
 dm5VrqyxiEfs6c7LWAkFDC/wQRcpBLvDi4BTy7EuZ/bqAc64XQDYIyjKPNEYdPyFKZaX
 TchaNd5uAcgvBQVnkulY96GmIClFy34ldLUNhEHUeWDPDc0FHxbTcEZETpsbImNttxpJ
 aljUKLVHiionES0ry7bhk8ozLoW9Dqiehikh3bmM9sEd/q8QELclFN4jY4kXhSFqhOCJ
 YRrvL0vB8MOfBxD+l2PInzJ7/QtcDaJlyHUyFByXW0lsEySYcZtqQ8Sh7B2MrLFU/TYr
 uhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617194; x=1761221994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttW3NAm+cuw9cqcCBrkEALJfpqIvO5EpoHGRi1aZFeQ=;
 b=IDX1L3/x8rgZxEq4SCZ6bjdmky9OOb2UvWGNiA5uexS0hRLVB22c0kUTTzfUKZsM8k
 S6S2Id79H4Dr+GbSNrOgLz+wAdRdeYLzRit5BRvpyZtnTthZuXriZ3bp1kSwLv/EVD6U
 lRiAQzTmGA2AYbYwWIKsTpUnqbKGZsF30124tyYHCRu0JKhVRzHLNyzIHJAfSvTm3UUy
 VjD7MKqBZgA3hjyxBAzVJdwiCAP31FXSpUBxrTGGA/wKg9u6T6mUwLo8pzeoBLdG7wQL
 Fv+8DZq0dYZXtkbgSWR4PaifGQlx5xHe7dC2H1T3uUw5LLO9DaU90Yy4b9wf7jRsFUtg
 4scw==
X-Gm-Message-State: AOJu0YxptcLJ6quaB135+YmPfwA64Zx6Q7EfEdvRF55w5qCSQdJMUhbg
 FiLn0SOi6HEXGPMrAs98EriBwWe3u9ITWBQ8BfuUM+jCnybXIbFOdtyL0n4Xh+/tyAa8xZJ+i7q
 lNaDjews=
X-Gm-Gg: ASbGncsE61TjATnpYMGRnEcv+pbHuOrySi7vWTEHWGDJ1IJL7ro5qAqx8498Hhnsuoi
 mQvLVZDoAktsiKs2yCfn+mGHM29hHYLp610V73tCbz6Q1UsLcO0rtA20H9as6pNt3E7f1eYQpXc
 j4cocE5B7ckkENnP4v5Dk7bGDEFu7jgIzsR4TigZa5T3HC1szvmWNxt4jRZF2QusOiCHhjVL+Nt
 Kz33lv3YDdLddMoPyhqfj8DCz8eNYAhDaGQ8DqPYq4rmkaPNcO6Um6TnOhdyQWORhq5ofPmQZJf
 M9CNptBtG0dILBwXLDAyj66MsDJRQiwVOwpGyIer1/Op6YbfZXcu5MC89gcF9DEg6Uvis45n7Qn
 Ua0dD1oNNXyZUGH/oZRS8XFNiRrK0rr9ImQillRLUjBMDEmESqy3AJdqhef5iJRMCFg5TKxNO7s
 qYEvLsfcId0RP+aWvaFBUMB3Vzb+DzOxC/pNJJYHX5yRyXSQ/CaI5mWT7v18avnTfn
X-Google-Smtp-Source: AGHT+IGknoSMksfeBGVcWLeeD1K2XUkPzCAr2zV6I8tcpAnC0GCfZG2U6+qz3DIOgOJ4+r7IUFT+KQ==
X-Received: by 2002:a05:600c:34c4:b0:471:a96:d1b6 with SMTP id
 5b1f17b1804b1-4710a96d610mr24325745e9.7.1760617194276; 
 Thu, 16 Oct 2025 05:19:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426dac8691fsm25788347f8f.50.2025.10.16.05.19.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/75] target/sh4: Use vaddr type for TLB virtual addresses
Date: Thu, 16 Oct 2025 14:15:12 +0200
Message-ID: <20251016121532.14042-57-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

tlb_flush_page() expects a vaddr type since commit 732d548732e
("accel: Replace target_ulong in tlb_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-6-philmd@linaro.org>
---
 target/sh4/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index f5c37c2d80d..3b18a320b86 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -452,7 +452,7 @@ void cpu_load_tlb(CPUSH4State * env)
 
     if (entry->v) {
         /* Overwriting valid entry in utlb. */
-        target_ulong address = entry->vpn << 10;
+        vaddr address = entry->vpn << 10;
         tlb_flush_page(cs, address);
     }
 
@@ -528,7 +528,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
     tlb_t * entry = &s->itlb[index];
     if (entry->v) {
         /* Overwriting valid entry in itlb. */
-        target_ulong address = entry->vpn << 10;
+        vaddr address = entry->vpn << 10;
         tlb_flush_page(env_cpu(s), address);
     }
     entry->asid = asid;
@@ -570,7 +570,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, hwaddr addr,
         /* ITLB Data Array 1 */
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
@@ -665,7 +665,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
             CPUState *cs = env_cpu(s);
 
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(cs, address);
         }
         entry->asid = asid;
@@ -716,7 +716,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
         /* UTLB Data Array 1 */
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
-            target_ulong address = entry->vpn << 10;
+            vaddr address = entry->vpn << 10;
             tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
-- 
2.51.0


