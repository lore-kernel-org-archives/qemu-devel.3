Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1516C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxY-0000SI-DL; Sun, 18 Jan 2026 17:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxO-000065-J9
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxM-0001cT-Vc
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so24440875ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774152; x=1769378952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqHIEExBUi66KFxM/MRoC2fNgQMXmj+1KcwcA/FBGKk=;
 b=Rm5DwPuPnxV3rJhTjB+Ez/vhWyZZYEH15RghKMBkPRtPCC4/M1lqEaLbJ4R8cR6mRP
 YTRP6fueGgjB5d/hQPFnPe/XWhUj8bspvvf76GqeEWQ4U1gGA2+aYGZB5bZzNVPyhvY6
 TL4kTbC8xG5xn1bKBDXC63PA1LCT/Mys72V3IlHitmLc4Azb6DYhguM0vmD+Z91SalXK
 KW13MbyUSFxZR/Fo5FPY+RGi5iEhJF1K6bsyA3xLn6yZqpHqX6+/tA6yCsuJtJdOT4D4
 AXJ/nLubkQNaqhUVTXA/UxIAgEVSiCJlWb8DyUYlHdL6ARVfnQYFIVkv/rsdalF+2/03
 fe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774152; x=1769378952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RqHIEExBUi66KFxM/MRoC2fNgQMXmj+1KcwcA/FBGKk=;
 b=FeUDe46rKVKU3ahF211KDPcydAwh04xnnYcjgpeN+zBCe1CDab8ytv+5tdRCFlE5bJ
 jE8CGK60hxRziWiFpSbQJdGmv68qFG+FZJBx1X5KcOBIX9o3hdjq+dchhhpIBk2pR1sY
 +J0JIupKsMjU3H/iXnRnxCqq0voLPYX7FL0wVjIZW94cwfNFXP540wBbzJTScNcG8Nor
 ooXK9uvpadaO3exVRjgnzkjPoTnnMfWWRAMvoG5q5kbqkLSZYhm+TZiEre/JZTlp0UBR
 prfYFGV76ueEiooDpErPDW5IIdtQBwykknVFr0U0GiF+cGj5WdKaB1ZsCqOBF8tTB01P
 P0tQ==
X-Gm-Message-State: AOJu0YwWllv0hsV67wP1WtLRZ9SD7erwWo5j8SIBAgptGBaBSF5WA1iG
 b4ttD+FViA3vD6Nl1L/BflReuhyvJupEv0wV4AiFQZKRZ+2FnpyzAwLnl6I5hpTLDzk3SE4ssd0
 E1h86ZDwo5A==
X-Gm-Gg: AY/fxX4rrKH5R+wmLjKmnp7TQ5DAE4WkCAcbcG14Rlo0Zd8euRIYxojgSJJ0z0xnIUC
 TWTl1WRJBUWPxdjeVv4KIXKmLJB+AG0sMWvtrQPHzCRzO/PmX+Xg+PCWXyIrulstlg6/k35b0bq
 TlyKZkVo5kMRjB0Sr2eht89f2v5bxY4R2awHsr9KddrNMr9pdu/FLRamxQ8z+8bfGjiV2+Bpo+4
 wKoHg9SLBxr8SZ0DC+J5kwW8CG/2aFg/EQCMLvRTytnSOVlLT3bH3LhjlBTjdNrHDlZ9n1UDP15
 uHnglv+5lher/iQQfm5YfEcsHvx+FgRRzxiSHausC5HIdbQoDhcpcAC5LzFmb5voeiTSPNIOgfl
 VeiRWa87EVv9hICDZA8GDoRBasPVmvMkmxg+5cVAen/fulfUMgpcMRCcAkE3yTxz0WdkbnKI6+/
 EQQluJ37zk/2D6bgtZiw==
X-Received: by 2002:a17:903:2381:b0:2a0:b7d3:1bf4 with SMTP id
 d9443c01a7336-2a7175165ecmr93341115ad.5.1768774151544; 
 Sun, 18 Jan 2026 14:09:11 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 46/54] target/m68k: Drop CONFIG_ATOMIC64 tests
Date: Mon, 19 Jan 2026 09:04:06 +1100
Message-ID: <20260118220414.8177-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/op_helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index a27e2bcfbc..f7df83c850 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -816,14 +816,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
     uint32_t u2 = env->dregs[Du2];
     uint32_t l1, l2;
     uintptr_t ra = GETPC();
-#if defined(CONFIG_ATOMIC64)
     int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     MemOpIdx oi = make_memop_idx(MO_BEUQ, mmu_idx);
-#endif
 
     if (parallel) {
         /* We're executing in a parallel context -- must be atomic.  */
-#ifdef CONFIG_ATOMIC64
         uint64_t c, u, l;
         if ((a1 & 7) == 0 && a2 == a1 + 4) {
             c = deposit64(c2, 32, 32, c1);
@@ -837,9 +834,7 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
             l = cpu_atomic_cmpxchgq_be_mmu(env, a2, c, u, oi, ra);
             l2 = l >> 32;
             l1 = l;
-        } else
-#endif
-        {
+        } else {
             /* Tell the main loop we need to serialize this insn.  */
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
-- 
2.43.0


