Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B63CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmb-0000TR-9K; Tue, 26 May 2026 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmP-0008Mw-Cb
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmN-0001FX-QS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ed9336049so489070f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805749; x=1780410549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gSN92snLUj0NdEQ5Y+ux0EflxKfxyApyrSCSbpPQV2o=;
 b=ZWcGSiZSOcXiP2QjBIa/DKTrfuLkBwVrMquv3dBB9mklXRuSBxc9sWe15W7QY0rYGB
 fuh/8taisLR6bxdm9LkBCgTFEzWJu47VWQP9MdpevK0eTKcS6KQ8y2pLi02HNhUuUBzf
 fcGEEsOiwEI87YQZk9Zvo5DperaVCI3qXYiE2XrspyDfezT1YpmIaGy0is7fDZ1znwz0
 LsEwPExtOb0StcvOOpSOcUiYQs2NdvB4EngAHkqY3D66hNDvsetV16eOdZEde8wzLFfQ
 YogGYszffBG+zk0Sq0EJUFiXysJsPTuJcJ+erDnveB0YTDOkD0QZKku/G3Tl7IgWjO/E
 aBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805749; x=1780410549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gSN92snLUj0NdEQ5Y+ux0EflxKfxyApyrSCSbpPQV2o=;
 b=sqXW4wim/357rx5Wr60GvNk6e3mu2AJwrbuwYgzNu055TQZvqDRLM8s7OdhbNptW2s
 2uPxTCR6mFWhhCxKcBv9zQWMsDCfUabR1vatD1/nSZDHfCH0a1B5Q3zQj77+XvpyYI+b
 ynDoYDmAHZfgKVJ0mlnb6NC41b958x+WSWYemfo8e/Li0Uhe1EnwN+Cg7RbzNHoVxM36
 AYxcV1XPcQyzvmWAyU7+7M7lhtJ9ptEnky5firhxvDWMKSg1wPzJwVujiJEJPM5PUpUz
 ccBAv9lerBmbkUZNHvEyAIK1EyGl5GYFdzU5LHJRIrHwDccNpj2ptIme3zsrVnk6xPZa
 SxtA==
X-Gm-Message-State: AOJu0YwbghVTqRfn8DBtAAYyv5PUH9D4KNcvrp0DvkS3Cc6kPEaj4wYs
 k9yamlqBwNXf0NCfnxFCWEcEWOujKlCDlxwJzIvh9PjbqRCSubD6lT13kR/NQYpVtogob1NBxdK
 +xteb
X-Gm-Gg: Acq92OHCqePvMZPL1mtXMJrZy1oB0TgAVd2XOL8QSdfRxlXL8BtiWGRIzGVW+FRFomK
 QbAi3VxzBIhtsFe5pIrdpQDicf3hV2H+nMsjBY6/RWYmcJI0DNztxTLrXSawOme969bOI6dcywM
 UgbYviSvmNnURQftq5R0SO8HQWQlWrkr6q+GFkrFbmJKm+yy8vpF2ZPg7F8hXzerOPIUUfUyO6m
 Rg4+sKxfiEN8Bpd6B8OTnFK2/a1xjVQmmcfeIT4nxkOC+m6OwyQZCzpkafAUqZ5Sqvgjh+e2K65
 tKhjR7rgBAXmfUtfYEYedQehSqdYnTkoYkJkKUKyCz5DYGEvOJ0GFdX0ynxMOh0lt9vgLZBDwwb
 405hLdE5AhIUpPSODtfKf5j6YnHV0qqhVEJqU/NrXp/4vq7kJ2mjEGza3d7GScPwlmA2NgMbsfg
 Ky6426YxSWIr2HNszcP42REaZddEOPEaUTUkWUXNzYcloShccitlXt4LxfNdStgW0bNFS6w9prs
 ntB8jgfE9dQTgVhYcYK2jk4unFAviI=
X-Received: by 2002:a05:6000:2003:b0:45e:b311:3d74 with SMTP id
 ffacd0b85a97d-45eb36acd1bmr31370479f8f.22.1779805749550; 
 Tue, 26 May 2026 07:29:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/54] target/arm/ptw: Flip sense of get_phys_addr_psmav5
 return value
Date: Tue, 26 May 2026 15:28:14 +0100
Message-ID: <20260526142850.2326589-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-6-peter.maydell@linaro.org
---
 target/arm/ptw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 53c2ed439e..94403e317e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2465,7 +2465,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         /* MPU disabled.  */
         result->f.phys_addr = address;
         result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        return false;
+        return true;
     }
 
     result->f.phys_addr = address;
@@ -2484,7 +2484,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     }
     if (n < 0) {
         fi->type = ARMFault_Background;
-        return true;
+        return false;
     }
 
     if (access_type == MMU_INST_FETCH) {
@@ -2497,12 +2497,12 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     case 0:
         fi->type = ARMFault_Permission;
         fi->level = 1;
-        return true;
+        return false;
     case 1:
         if (is_user) {
             fi->type = ARMFault_Permission;
             fi->level = 1;
-            return true;
+            return false;
         }
         result->f.prot = PAGE_READ | PAGE_WRITE;
         break;
@@ -2519,7 +2519,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         if (is_user) {
             fi->type = ARMFault_Permission;
             fi->level = 1;
-            return true;
+            return false;
         }
         result->f.prot = PAGE_READ;
         break;
@@ -2530,10 +2530,10 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
         /* Bad permission.  */
         fi->type = ARMFault_Permission;
         fi->level = 1;
-        return true;
+        return false;
     }
     result->f.prot |= PAGE_EXEC;
-    return false;
+    return true;
 }
 
 static void get_phys_addr_pmsav7_default(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -3763,7 +3763,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
+            ret = !get_phys_addr_pmsav5(env, ptw, address, access_type,
                                        result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
-- 
2.43.0


