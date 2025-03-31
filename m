Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833FC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzLA3-0005J7-CW; Mon, 31 Mar 2025 15:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9O-0004Yq-NS
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL9L-0003iq-Jl
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:50:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso31318665e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450621; x=1744055421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wI1i9qpwMZwJME1QE61gTcf1pbGJNg+cm1Z2vgD76Q=;
 b=at/lwAQuNeQijkZqMXxiqhZ78AeNh15PjqolIIqBFf0UiuKrleISX1h2R+AcWf/iOC
 J8R15JZdFehGcGK0WsC4WfyjSl9yu9thqCAaPWpD0LtIjMXPNasNgSCNbw1miUvNWVcP
 UNq2wQkcA+mUzUS/WOPAfZdvkMMy1QhPo/9+2cD7a6aD4PM/jSZn9LLnrOzKT+qf43cw
 8cAA5oZ5kBORN33jiivTGAJ582vQX+pUKA6RmNIrD1p8857LVZ06XXeOb8x0MJGCEB8q
 JGEPARW8rJRztC2jSVKhLrOMbD/dPhqaY/1CCyDRIQ9Elmo1wT8UmgjNJ/iJlvd2lUWV
 hT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450621; x=1744055421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wI1i9qpwMZwJME1QE61gTcf1pbGJNg+cm1Z2vgD76Q=;
 b=k6Elka3AhSmJHFHZWwHm9NLIhtyZjj6C2oezK+xg/zYop/3sNjgFgRkyollsZnuTZW
 hOHDtwrot5sz34amXZRkhreWUniyDbuYVnYhVn8i9vRGFTa9wzdjUxCrk9xNS/49AZaq
 DpCVGPOgnwtlRtQz1pPN+nZfXDUkdNuP4Rz78ydf4CaoIVzx7XYa0zIRgwhwEbcBK4wY
 1MmygioUBt2PxmnHCJv/RvP8Ip2mo//Q47hrkAdxnZKizrjcQNXBLns4vApph+n3bPjM
 OUnHQl+ep/Qsu/dwDc/x86Ittwi78SZbAcnB3BmTiU1fDaww4Ut2x5/3Dj3xm6T9Bjzh
 giZg==
X-Gm-Message-State: AOJu0Yyi2nTlIyaXkGSESmBjvcr/GAZmbxrYHOCE6NZtkWJ5HD0MMimf
 HIK3dWUlnf+Gf0WWdYseDGOTMfbqboHhHqgyf7hhS64XY9Er64B1jx+Zvcxc+uGbRBTZYu4otHY
 y
X-Gm-Gg: ASbGncujgDAUuOQESZchk/5Z4wRzfQFgn4OvCcdCAz1qrl13pYKEnNf5566FEST7zSd
 8Hhew9J1pppJh6MqgFgYw7vxPjpjWuibr6tQv5gfAXHi+7334D3mKfAjMvdXd6mrA9gpsWxHdWE
 k87ho/KM5K5WvDsH9SrJtrg36OpA8TUY+mXvKNp072YGXVRRtsV/QPJJ94rKicF1yErNu/XsUqz
 b9iPKc327sLoW8OIOIfv74N3FJQ4r0/t1L+63MNNiD0XTz8LwGIPJ7BUHvysAWXRvYfKw2OcSmC
 4clJjNr4rrktzYYCOnQsgKgQdbOwzbDPav1u0bmT1ZrdrooFeH0pKXZhH18LsDiZSkxwsKWjBs7
 QlQnZAU6iwWjyG34RGFs=
X-Google-Smtp-Source: AGHT+IH/6ioiQ+IBxm9F17dyjdEXlDooM3tvzLjD3PL1B46O1X0RV2C8cV4UalCDPQgAq89TQMvjkA==
X-Received: by 2002:a05:600c:c08:b0:439:8e95:796a with SMTP id
 5b1f17b1804b1-43db62bda6cmr82389415e9.13.1743450620791; 
 Mon, 31 Mar 2025 12:50:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dedd03sm174803455e9.3.2025.03.31.12.50.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:50:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 23/23] target/mips: Simplify and fix update_pagemask
Date: Mon, 31 Mar 2025 21:48:21 +0200
Message-ID: <20250331194822.77309-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

When update_pagemask was split from helper_mtc0_pagemask,
we failed to actually write to the new parameter but continue
to write to env->CP0_PageMask.  Thus the use within
page_table_walk_refill modifies cpu state and not the local
variable as expected.

Simplify by renaming to compute_pagemask and returning the
value directly.  No need for either env or pointer return.

Fixes: 074cfcb4dae ("target/mips: Implement hardware page table walker for MIPS32")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328175526.368121-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-stable@nongnu.org
---
 target/mips/tcg/tcg-internal.h      |  2 +-
 target/mips/tcg/system/cp0_helper.c | 10 +++++-----
 target/mips/tcg/system/tlb_helper.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 74fc1309a71..950e6afc3f2 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -47,7 +47,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
+uint32_t compute_pagemask(uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 5db8166d452..78e422b0caf 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -864,24 +864,24 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
+uint32_t compute_pagemask(uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    uint32_t mask = extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
     /* Ensure no more set bit after first zero, and maskbits even. */
     if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
-        env->CP0_PageMask = mask << CP0PM_MASK;
+        return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-        env->CP0_PageMask = 0;
+        return 0;
     }
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    update_pagemask(env, arg1, &env->CP0_PageMask);
+    env->CP0_PageMask = compute_pagemask(arg1);
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 123639fa18e..df80301a412 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -876,7 +876,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
+    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
-- 
2.47.1


