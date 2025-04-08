Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36427C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28LA-0007wt-2K; Tue, 08 Apr 2025 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28L8-0007rW-1k; Tue, 08 Apr 2025 08:46:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28L6-0003sa-7v; Tue, 08 Apr 2025 08:46:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso45375225ad.3; 
 Tue, 08 Apr 2025 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744116361; x=1744721161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omUo3N09aR7ebQ4zzd5jlYrU+UHr97ohhPYiCfPwuPU=;
 b=f9VD9qupJfBgFjzJDmfIX/J7+5appgQcts7pi943nwc0JudKk85dDcO7D1K6AHudC0
 WPBV1oenWkfcr2HEi7Zf9dX8roaX4/u0X0gwOWijq7vteI7wlYgo3othybjSemiGUBvc
 jvpzhwml2ieyt1XJHFDVXN6B1G2tBvwzYWbJYWtk0AECaa6i/kZc+tznPuLN2ZTZak3v
 9dtT9RAh1aGhxvqVcfzh4yzCt/Dmni1++d61YKfl0eutQEQOSqxGZbhkOCWTfVH0WnxA
 hTuA/IXaqL+LnQ3zC/rH/zIT901ZfvRuOdLYcg5gMr0D+RHwfRVHgDMH9SH8GvbjKomp
 Q8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744116361; x=1744721161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omUo3N09aR7ebQ4zzd5jlYrU+UHr97ohhPYiCfPwuPU=;
 b=VRKYQCOxl7H8I+3xAFq5VmDeAtzxMbjo80n7z2xidZl4s3cFiBRSNhAjH5CvT493b5
 lae28P/ha1orH/YH5umk+8+VOes0GxXwW5n2xzC2Tn+ff9/ONejD4PIiE+zPpufD2t6R
 33ucWObs/ZVasDiRlHWfctyiBn+O6q0GOdA5c2t1QXtK1mckr168neOmICjeVIkPOQPY
 3t2rJic4JLiUgVXYjRGhW7njy8oLHI58nP/ZyM/u4zh+DVllrkeLl30NDkRu8QazxllC
 UZIduizRtttpp0hiTHJ6UEkIPjLJQjbjqJhqrWh1HfKM19DvzWG34VVxFpwljhd+mDcp
 xT7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVpxKn06wZRKM2/63MewgdAyBHbGOCxa1OR8gCQc4HLZGCwhb9xsfTDk52bKzuMY6PJVryfAWYJMapvvw=@nongnu.org,
 AJvYcCXYx202sy2oI5V7JrYbO6zY+aVyEwyjDRhsqn7Gq/Oi0sIoVYjTcYvx5iteUj2qQQmk3BVJ78L/aw==@nongnu.org
X-Gm-Message-State: AOJu0YzaU461qEiZWlPgV3OlhTYLX0lULIxRLBl8DmX3FgIxR+4h7SDb
 tSL2MxdNw4GQx1IYFRAe4zguPkHBXlg0VfA8CMO2vSIJWLv3qGPo2Ii0/+Px
X-Gm-Gg: ASbGncu+YLYavNzdiJWYQOdmKDuzbo4zYLk8yaEWNAYa1C6V37ALdmEwiXxZYxvRh6n
 uomVZlzrpsrUAlXLk2f3AuJ7Es9Z9bBQWvgUY3XOMqEuA05dvuJbAk++81A7Ikas66xSPXkHKG4
 v6ardoQZfWOQG0FSFoqxkbP7onh5xKZx8T1tPLlEaWug7mEFqYAp0qdcQUHM3XCbCvLQF5ezYCt
 INLzQKKI18UrqOFlC4R8Fgvp77kDi586ACoZeXCEmVeovBRjEEXD4GFlf/STmNqQvqwrRWNu561
 IrOQTftoReJ61mPyFjikUdpFdtreMbFxWEwXgA1EbT2KwHnt7Wj/1rpV65kuNDT3NpeYPdA=
X-Google-Smtp-Source: AGHT+IFHNIIlIDpXS1q38pOJ9XmLDdM98+IOpt72pmBqKoZ835nr4eGmYiTLwYbAiSg22eov+CXHnw==
X-Received: by 2002:a17:903:2282:b0:224:1157:6d26 with SMTP id
 d9443c01a7336-22a8a049f7emr247177725ad.4.1744116361482; 
 Tue, 08 Apr 2025 05:46:01 -0700 (PDT)
Received: from wheely.local0.net (27-32-255-92.tpgi.com.au. [27.32.255.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f07fsm11036235a91.6.2025.04.08.05.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 05:46:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 1/2] target/ppc: Big-core scratch register fix
Date: Tue,  8 Apr 2025 22:45:48 +1000
Message-ID: <20250408124550.40485-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408124550.40485-1-npiggin@gmail.com>
References: <20250408124550.40485-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

The per-core SCRATCH0-7 registers are shared between big cores, which
was missed in the big-core implementation. It is difficult to model
well with the big-core == 2xPnvCore scheme we moved to, this fix
uses the even PnvCore to store the scrach data.

Also remove a stray log message that came in with the same patch that
introduced patch.

Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regular cores")
Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 2d9512c116..46ae454afd 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -332,6 +332,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -368,6 +372,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
     int nr;
 
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
     switch (sprc & 0x3e0) {
     case 0: /* SCRATCH0-3 */
     case 1: /* SCRATCH4-7 */
@@ -378,7 +386,6 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
          * information. Could also dump these upon checkstop.
          */
         nr = (sprc >> 3) & 0x7;
-        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
         pc->scratch[nr] = val;
         break;
     default:
-- 
2.47.1


