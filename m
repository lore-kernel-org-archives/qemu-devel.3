Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB78D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifc-0004Q8-Fx; Thu, 08 Jan 2026 00:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifa-0004N7-A1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:50 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifY-0005wj-BX
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso31472735ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850486; x=1768455286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YCqXvzFIqjc08NCGDsf9z7Z2T4jUqc4uXckHUm5PTfs=;
 b=KndBtjRYCfUfvsiqi2Xeump1XC31l3vb2gL6ZAFb0qqzFU9GDofjqtFTGtn0xOwp25
 gnFIqUCpE6uJ3KFUZSrpUS6JiAPtCuhEEKui+tK3vN2yUUvOmmrTK8dYW+Usy78VKvtd
 2jRqH7sT+P+t1llMyvl/2eJ+D2AfoWEPrtgEoEEh6qchlKNGOZAnfSaPVryAi38H8Bm9
 pwaaitI54eCUwGWFYNW2C+2ixxDYV0dEeAmhDDyNy6DXKzX7+xHbR/kxTmpEzzenp3Dt
 xjWzBhbUlDDJyF8EJyQtDP1aITXSN9GQVvjQJJh8iybRsnrdeM02M0SaU9Hxwk3ZeXUO
 UY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850486; x=1768455286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YCqXvzFIqjc08NCGDsf9z7Z2T4jUqc4uXckHUm5PTfs=;
 b=qGHuB2n7kaXMqluWlKIYmtcVs+++r7MdRPhTfSM182nrH/jHzLuFthAGoPV7sMBTAa
 v0xoplHrKOef+j5raTYxzMG2QXMDem6Vg4ji+DAZLtehUlSqJOka3U1eeM4HUtj/567+
 DEAQcDqDifAhxnqC5IF2fd2pTq6dSuMmQrGPTftYiu98JYD/KH7OcVou9efyVhsZbiVj
 ofChMj61nuYuu+9ju6IfWq58syxOobMensxv+i6wtbJhDpsQxEdP3980dyVxP8aoQiRz
 GU1oL8vVSt//cdQNpe2jO233o0QJSAB5LNY7DpK6UjK9UbIM1t3vIH0zL0xZf9w1z7Gw
 xpXg==
X-Gm-Message-State: AOJu0YwUdbExTMTizVYh/eT6y4ydueWVaG8wJzr2HiXv4pOW+v+3yEG9
 bIyVzlJpSuSobwhf+TLB+b6xvDUh9Tg+dCcME6cYVVRpOhH+i2uwWTZqPsmVaO4TP/wqNuzkHzz
 ExxX3HJg=
X-Gm-Gg: AY/fxX4HL6hYKDqWYMc4mIre/SO2BPGYkDodGZlMuKpZOGGAUMZFfRKC5+xer2ZY7vt
 8FYd+FxEeE9C/iZi7hvKQ3gRsLz0If6MVOWeqFE07Q7omaWoaQMuOJa8eGZFzwSe1nfLaCM6iNh
 8mOUwijzm61vnUYWHUkpRUZhachOlZ3mq3RNiDoURDDYfcvZCFZxyJrcTkZu6H4Gi6/HRsG0OyK
 C9aXmBEQhdGxL0ni3vijN3ui2BDTqRGOokVpWES2A+XcVA2cSrVDSaMt8j/WgNZpMVNhYmLXOJ+
 exPBq8a6YaFeb8hggd40FjdaeaLvJ2AgFTI7Wyysp1oJI7XXmd4bkAXqKOZDwHsxO0D/23zCPp3
 YU1DE3R7NXJIwA0nxIY2ehX55hbj+TAmaXqT4Ak2mnkZUOPpY+Fr7L3pKL9Phv2AAsLXixNVDmI
 BIQm9f9UpXUVGW2athmi/LattaQtPy
X-Google-Smtp-Source: AGHT+IHCSITnsjTMZTWhm9D9e+os+zHXXrcJ6PalOcfXri8fwoDbHgNzERStrz11CGrh52v8Wj0R+Q==
X-Received: by 2002:a17:903:17cc:b0:2a0:d629:9035 with SMTP id
 d9443c01a7336-2a3ee42491dmr50131785ad.3.1767850486175; 
 Wed, 07 Jan 2026 21:34:46 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/50] target/arm: Drop CONFIG_ATOMIC64 tests
Date: Thu,  8 Jan 2026 16:30:09 +1100
Message-ID: <20260108053018.626690-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e6b149b2d..5b918aa359 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -759,20 +759,12 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
 
     if (likely(host)) {
         /* Page tables are in RAM, and we have the host address. */
-#ifdef CONFIG_ATOMIC64
-        data = qatomic_read__nocheck((uint64_t *)host);
+        data = qatomic_read((uint64_t *)host);
         if (ptw->out_be) {
             data = be64_to_cpu(data);
         } else {
             data = le64_to_cpu(data);
         }
-#else
-        if (ptw->out_be) {
-            data = ldq_be_p(host);
-        } else {
-            data = ldq_le_p(host);
-        }
-#endif
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
@@ -800,7 +792,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
+#ifdef CONFIG_TCG
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -905,17 +897,17 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     if (ptw->out_be) {
         old_val = cpu_to_be64(old_val);
         new_val = cpu_to_be64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = be64_to_cpu(cur_val);
     } else {
         old_val = cpu_to_le64(old_val);
         new_val = cpu_to_le64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = le64_to_cpu(cur_val);
     }
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
+    /* Non-TCG guests only use debug-mode. */
     g_assert_not_reached();
 #endif
 }
-- 
2.43.0


