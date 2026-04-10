Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F4F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI84-0002Pp-IN; Fri, 10 Apr 2026 16:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI7y-0002NS-7A
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:06:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI7w-0008LD-Nx
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:06:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso38799875e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851611; x=1776456411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19g4LL15pWkb4dv+bZpUKR/vfD5RSE9eqoLEwRvWI9c=;
 b=bUocy3HuX2YR9WFkCjkWgld77av6OP9/CXpJVyRmV7mqwIPOOE7EtaZDx//J4ws144
 Ospm5ccmJA3BkLyjuNvxOZKj0KskyjOG84fWP8vpOgvhWYX8yp+D46fB1qQpg173Nlm8
 MAObq5S/LGey33k+QcI6ZALBw958fsH9AdzeR5fvG7l5pcshD1BW5w2ePGmMPADhKfqE
 lVv3YiTNvnIUmgVEwFMCLDiC11UHDfJPlAMor9X5AtP8BEkwKdWyBNZMLKpd/FnCDiFH
 dIetP1tBirwZJj4+ZLfpVMOw9ClqQvtW91ekwTpGCEVM+KnHoU9q67kCLfo8oyJSpgMP
 go2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851611; x=1776456411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19g4LL15pWkb4dv+bZpUKR/vfD5RSE9eqoLEwRvWI9c=;
 b=LsaLkcvfWfURcM+bJPGywDfSlGpIr7DJnrWQgzAoEY1C1SA2Q0SHcLIQZnBnnQZHpF
 uVQHb88LO++u4L/DEKrswq2UKY590jeNqM/q5068ZAb3xjotBnlSUSd5X1+s28kfpsSn
 qQ27RoL/j5xZi51ZOmh0FKme2WSjozVADHWvZf0U8gDJqdFEjbZKy/O6AgYS8SeV81PJ
 sb8ZJ4UXfT6mGacNStENN5l5z2EaA9jtZHrNhu2g7xN+VS0vC3tl9bz29QNNb++6gJ3e
 /3t5gjJFm+BO3X+zRvxmEM2RmnR71k0sxlp7jB47/MVSD2rql3Grbfm9jpOYyEvrt3vp
 L+VA==
X-Gm-Message-State: AOJu0Yy9gYA93vaSf7eRKGPJrlEuFuOFGBAeQxDsTcFzJEIVyytgsCIL
 NwgOUPGRY7ceyHt8mS5sBYIGcBemOMi4dzoTl+ca7g0Szmn6ZShnpWGqtSWE0ar9/uQBKJ0MiWp
 9ePSJ9MM=
X-Gm-Gg: AeBDieufc4xqT8K8HcYFK/PMrhFWxj8GEBOIOnQ+/2awFqo93sP7Bp/gVCqMD4sikRH
 eaKB/fkjl431McDlSX9tpA2CdhO9UBGUCa8mp0AN9veQPA/55Kxz0lvY72LFsbBzdzD45fIaCKk
 vy8lc948QFRokM4kYL+kCVCIuspQqOnbLtmQ1GN6Q0LjnJ3c3mcTyFAasDDn/f5nF2Rc+tIaT3W
 ql057qtD0/DMddI+Ep+WjDopKqvZ64GmZYgF7CPiA/W9woNJIVy0nERXgEjJZDi7F73vNNv9Kjo
 wb+m3iL2fQkXp/n0Hvqp5koX3p7g1jDVlsmGXBeUo00KN3g6AkxqeKLgBFEvbrvEgUAlDsbOD79
 vppz7nNQ7fYCOOiIvjDyXslcRP/tsyaswKhIvpZeErzpx2qpAO4vXbt8XXU29CBtVxFFETvTYgn
 RaHHG5eBijMFwaerxg5eLuP5IIzHZv6rU3yilc2ebzCHzCNsWb+bfwYla9nUm66xsssR9r6+8B
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id
 5b1f17b1804b1-488d684331emr39617265e9.18.1775851610853; 
 Fri, 10 Apr 2026 13:06:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3c597sm92863755e9.12.2026.04.10.13.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:06:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/arm: Conceal MO_TE within mve_advance_vpt()
Date: Fri, 10 Apr 2026 22:06:22 +0200
Message-ID: <20260410200628.19378-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200628.19378-1-philmd@linaro.org>
References: <20260410200628.19378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/mve_helper.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index cc58e0502f5..fbb64889bf7 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -160,7 +160,8 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
          * beats so we don't care if we update part of the dest and     \
@@ -183,7 +184,8 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
+        MemOpIdx oi = make_memop_idx(MO_TE | MFLAG | MO_ALIGN,          \
+                                     mmu_idx);                          \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
                 cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
@@ -194,23 +196,23 @@ static void mve_advance_vpt(CPUARMState *env)
     }
 
 DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
-DO_VLDR(vldrh, MO_TE | MO_UW, 2, uint16_t, ldw, 2, uint16_t)
-DO_VLDR(vldrw, MO_TE | MO_UL, 4, uint32_t, ldl, 4, uint32_t)
+DO_VLDR(vldrh, MO_UW, 2, uint16_t, ldw, 2, uint16_t)
+DO_VLDR(vldrw, MO_UL, 4, uint32_t, ldl, 4, uint32_t)
 
 DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, MO_TE | MO_UW, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, MO_TE | MO_UL, 4, stl, 4, uint32_t)
+DO_VSTR(vstrh, MO_UW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_UL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
 DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
 DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
-DO_VLDR(vldrh_sw, MO_TE | MO_SW, 2, int16_t, ldw, 4, int32_t)
-DO_VLDR(vldrh_uw, MO_TE | MO_UW, 2, uint16_t, ldw, 4, uint32_t)
+DO_VLDR(vldrh_sw, MO_SW, 2, int16_t, ldw, 4, int32_t)
+DO_VLDR(vldrh_uw, MO_UW, 2, uint16_t, ldw, 4, uint32_t)
 
 DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, MO_TE | MO_UW, 2, stw, 4, int32_t)
+DO_VSTR(vstrh_w, MO_UW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
-- 
2.53.0


