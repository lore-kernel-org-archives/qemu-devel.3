Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2D2C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdZ-0007MJ-En; Sun, 05 Jul 2026 00:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcA-0004ys-Ux
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbw-0004DI-4B
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c6b67d5fa1so18032105ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226262; x=1783831062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lg/N8LFKGp5ELLy+c1KbExFW/0dtEAJ/1CeA/sfoCRs=;
 b=WU7BNf08ZfTpHdBPBsBdcQPwEcjETlqwT7rVGw6//lNktny8KZoHKuoVfstlYwdeeW
 k8E9pLkztLunYP7EafrK2W9K29ojXVWqHwomxOI6QEXMDaWbxavcmzRCnOIZZUkWDOHy
 sMezzw7LNTETkZB9VSKyAu8Zw0Kzv/BrrJbSRzGX4JpaDyafubI3nJf8MKTZx2eaCji1
 6Tue4bmBsTDGRxArQHdJn65z/HHJG7Hb1vxGrNb6r5TgOJnh7ZIQKFi7ufGEWYrgLxEu
 Iu8E8GsVwWbPXk3ThgxSSbfyFnngg+lfLBKd7i+w+7V6IBkjt3RbOdp3FEtgw0CFgwWm
 0EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226262; x=1783831062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lg/N8LFKGp5ELLy+c1KbExFW/0dtEAJ/1CeA/sfoCRs=;
 b=qJCRG0mwmofvh7EE1eRrfTMQmpxxZORFLFTXSLxlTzvHjAPoHLgBg7f9sICUmiQxBi
 eVl0sQgaMwAyIZvWtjMwlW9jDKvhMJTix35bVAMMiWaw/S5D+HIYQJUDRP6zTKek7Omo
 skCz83rwkySpCnhVb2S9t7Rh++o34eMn8/zrdYcTrrkv6RxLHAySl8b1eEKQHTjQvkHU
 Rx1Cr1yONGir/A7Y+tO/u7WFA8wnEje8Eokl+T3mSMczwZI+tH+2peM62fSAe3I1MzcL
 vYxeJRJeiFz60eFaBlhOuchrT2rzshHTjAsz3WGovq6wH4sKsxb7d1zsUjdjfcOXDsco
 PLDw==
X-Gm-Message-State: AOJu0YySnr3E+V+AxxbIKOKgDxHVNVfpOdYzF/wA3tRAETrjGsm9uETj
 duch8OemGqLbnLNxgFD38g7jXlvwbSWPb/VaDZjs4C8nWOuq6GIRGM4xqB0Am4xEAmmsITOiEY3
 MLu9E
X-Gm-Gg: AfdE7cndXA38HuB7SVLNa89LZfohOAMwUeiJ5HRKVHID96KjIfwWv3PBhHP2IJkko3v
 DPoXFlR0YoK4kjvG9C2AsZbTYd5c5fk3p7rTKq1PF2/LqG6DgvFkYqNDQO4DMWtiveIe1jAyP1v
 4iWJj1OLJoKjb5wtUSsEtGbN9z8ZDeNxEcID3q7n33BosuHHpbINeYpRqS1zZ4JS2nZJVUqs/Lf
 FFiN8AeuP5X9dES3s7Xg+nnFLFdjRLQZX842KGhToQbNhYlqT1Xfd79FtRlfHVd5ACohulyz13k
 NEHb4jVAtqYuDBuKsyxXqK5phfPe6VeolKrivACRprDUhoKc/RXJeF46h1XG3GIqXQmB+K6npx/
 CIdgO2thBFOncdFDKF5NYE51zbPW9m30rwZKdp/QrCw07HPL5acYc3dRWfMfI04MXe7tm5HiTWQ
 rmBeVRnADvO48C7ciAXAvKcTxChgy0rmppoFjXAwoOdDh5nrs=
X-Received: by 2002:a17:903:3202:b0:2ca:d151:382d with SMTP id
 d9443c01a7336-2cbb9e38d1cmr56474895ad.14.1783226262210; 
 Sat, 04 Jul 2026 21:37:42 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 17/46] target/riscv: Use bp argument in
 riscv_cpu_debug_check_watchpoint
Date: Sat,  4 Jul 2026 21:36:56 -0700
Message-ID: <20260705043725.1373137-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use the ID of the watchpoint instead of a loop over all.

This fixes a bug in which addr was compared against wp->vaddr,
so that we never recognized watchpoints that didn't trigger at
the start of the region.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 55 +++-----------------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 511a69c28d..56ae1e6107 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -960,59 +960,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong ctrl;
-    target_ulong addr;
-    int trigger_type;
-    BreakpointFlags flags;
-    int i;
+    int i = wp->id;
+    trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    for (i = 0; i < env->num_triggers; i++) {
-        trigger_type = get_trigger_type(env, i);
-
-        if (!trigger_common_match(env, trigger_type, i)) {
-            continue;
-        }
-
-        switch (trigger_type) {
-        case TRIGGER_TYPE_AD_MATCH:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE2_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE2_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
-
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE6_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE6_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
-
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        default:
-            /* other trigger types are not supported */
-            break;
-        }
-    }
-
-    return false;
+    return trigger_common_match(env, trigger_type, i);
 }
 
 void riscv_trigger_realize(CPURISCVState *env)
-- 
2.43.0


