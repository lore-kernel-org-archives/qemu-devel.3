Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6449DC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIL-0000x2-So; Fri, 07 Mar 2025 10:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIH-0000vM-8e
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIF-0008D3-I0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1697890f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360038; x=1741964838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSWu7SERkDl4TrKpc52a/rImNAR7H05Ny8NJ0H5vIQY=;
 b=uCABt+866vWW+CObqd+rU+h5jLeK34m7UnixvPcPSfrRkwo30yZ6OVIg42KCJEfRB/
 FJSrNcv70X/YDA0mICK1XF11NpTK+mH6x0LuGrUjh+FlZNC+ICGQwxHf+TTCUZB4OAKc
 6RNuhKALz3xR6lZJW4U4FvjE7e0+DIGG3qH7wp8zV03l0ydcHakph6Yr9+kOPgl7XG5s
 lFU7x/j1nwCafkjmkq9ol6jBt2O4k4UNekvYvDc2CcCSrKFPF10ED1oEiE25rklw4e4z
 KzU+mKGWpqcQ+3ibGIfhhtInUXViH//sH6NWon4Wy/qki0Jp8WinFIb8DjzKKs+VgKvu
 bAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360038; x=1741964838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSWu7SERkDl4TrKpc52a/rImNAR7H05Ny8NJ0H5vIQY=;
 b=E4VaY8DkhSA/HVU5oiHVpJzsLb1sfvk8zq23NJzuOEaKKJE+AhKrg64egjQGlCHBGy
 9yHWqsF9fT/GhrZBDp7v+lVYiJOnz+xKYSxaAg3FOWtWFOcjUz5PfC+vEIf5k4XwIeTZ
 KsuWVPXhhAI+h4QPKMXeXP5MFjO1aJjuqI0qnOVNZpSmNJs8pi5zgKhGw7sqzO9greOc
 Q+3/9b3qQmV6/9hLWpQ2QdUsiYRCbxVdahpc0JUme5kH8JrtJYT1tlKh7nLBxE4Sxj+m
 0ZmxJzYjyrLcLSGDBzv/zHTuqIHx1RS2OdjLasUC+YE9hQEUSAbrE3NQAoCHYc9hGz2b
 pl6g==
X-Gm-Message-State: AOJu0Yza7hz1cWjjK572Dre7K0ZmDpiLecRLsoMxm8v/Sh8JHhR2Jifc
 oeYbueDn6XfFLVRynOFp8OrlQkDX4If+P4ZBc/ctcwyyt1J2I/tFdYWDujHDrtdrFIN1yRXx7ef
 m
X-Gm-Gg: ASbGncsRRor+VY1Gg/r0rydGTevtLgycGaDPSQubSSlxXdAauRoETbEVC8FCdGTSmYw
 r7bZ1xyUz/KO5HZytYMWmlzEG+74VrTWtbP1dRFLCOb0Rf7K3+E7K7dbEiZ5jsIg9B01eGZbLGy
 fXdvduK/BVyiMJJyKNAl46t4P/xG94t8EHkRitQnzwesAA9o9b12QcSpux/877wMLqN35IyEYO0
 9deyLuztKkiTdMbYe4TmOEeHLtIqoe6cgnu3fkKZHGY/QKIVqKONx4j2EEOEFLarYnh8DXnQoQd
 7nC4A72JgDBf1+FZLRIXYWvqs6YMVyQWs3DPT4343pIDe/D/1UM=
X-Google-Smtp-Source: AGHT+IEjEya4lXF0/VdtEPqr400qAh/j7du9RnWoBz7wuoGOdMhUUBVusIlBb0R2DJe1kjY1RYXVBw==
X-Received: by 2002:a05:6000:1fa9:b0:391:2e31:c7e1 with SMTP id
 ffacd0b85a97d-39132d2b0ebmr2397201f8f.4.1741360036529; 
 Fri, 07 Mar 2025 07:07:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] target/arm: Apply correct timer offset when calculating
 deadlines
Date: Fri,  7 Mar 2025 15:06:51 +0000
Message-ID: <20250307150708.3222813-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When we are calculating timer deadlines, the correct definition of
whether or not to apply an offset to the physical count is described
in the Arm ARM DDI4087 rev L.a section D12.2.4.1.  This is different
from when the offset should be applied for a direct read of the
counter sysreg.

We got this right for the EL1 physical timer and for the EL1 virtual
timer, but got all the rest wrong: they should be using a zero offset
always.

Factor the offset calculation out into a function that has a comment
documenting exactly which offset it is calculating and which gets the
HYP, SEC, and HYPVIRT cases right.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71dead7241b..7f341d753cd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2460,6 +2460,32 @@ static uint64_t gt_phys_cnt_offset(CPUARMState *env)
     return gt_phys_raw_cnt_offset(env);
 }
 
+static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for indirect accesses to the timer.
+     * This is the Offset value as defined in D12.2.4.1 "Operation of the
+     * CompareValue views of the timers".
+     *
+     * The condition here is not always the same as the condition for
+     * whether to apply an offset register when doing a direct read of
+     * the counter sysreg; those conditions are described in the
+     * access pseudocode for each counter register.
+     */
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
+        return env->cp15.cntvoff_el2;
+    case GTIMER_HYP:
+    case GTIMER_SEC:
+    case GTIMER_HYPVIRT:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2469,8 +2495,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * Timer enabled: calculate and set current ISTATUS, irq, and
          * reset timer to when ISTATUS next has to change
          */
-        uint64_t offset = timeridx == GTIMER_VIRT ?
-            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
+        uint64_t offset = gt_indirect_access_timer_offset(&cpu->env, timeridx);
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
-- 
2.43.0


