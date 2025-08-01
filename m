Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE8C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSs-00064j-Sh; Fri, 01 Aug 2025 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3L-00032F-GT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3J-0000zI-Ik
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-454f428038eso16240295e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063532; x=1754668332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWii0yPY0huQAno9LKhz1KUD4m589jyklRR5CQS9UWE=;
 b=MG48ncrhyDBdAa0E4jyYilWv0Kyou769ZzNa1cKHa4M76UXGyZ+bgdRSMwLHX8w/UN
 KYQ+YWvtPv2o60HwDc9bfxSv00Ix/TyKvQ+F4XeUtSlPjig2gUJprKzZNkqj4Zg9ehQ+
 PcsC65gd02cY8cfHXr9K9SWXvBbHzCn7TNJIOeQmezWGnka5IkxOd8NoSzmQRXfinxXv
 dEh66rd9P7jg9koFAYSoPDE/PNn0dSzflck1OBB28drjQcOK/D+DcTVzqoW4whMt9t1E
 GjgG+9sfPxKsxENVKxv4V7GL5GvU2pS+iNdLVK+m4qHd0YnQhFY4h0F4lwflasDDJ8qu
 t8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063532; x=1754668332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWii0yPY0huQAno9LKhz1KUD4m589jyklRR5CQS9UWE=;
 b=WJiwG3RaOD6XHvQ2v8lElEnmtF0zp6u3bZ/YDsGuC+957Su5OG7I3qefzyMcIBUr1S
 ao7v6H/ljFlucCcghFl5FYbMNuKging0njMJYEVSVH08ok8YCm/2755qNwX42U69SAxw
 Cn3bUE8Vp7LkrKow585bqSqTDZUQUKIvWlLXYr0evv/P3jwPplHuHSyrV6q7oKU/HuRB
 qxuJmzu60iQUsGLeNwbjDEkWrJSKRsOZcqa5P23olW0y/4bMhAHJcswd/2+x95of048/
 pvQnM5bKQnSyKzP+LzcMbBpKbOsHyvMoJRC/Q4cW/lQxG3aiLKIr+V/YG+/wESmAaWS0
 8Ofw==
X-Gm-Message-State: AOJu0YxgThgvxUObQK3ZTti4KxrRhHAcjUqXwlI6hRSI8w3AI+bRMXcu
 XEdVr2LwTpnEmGkTzGs3P2hU6BkPMq5mQUpPb5lnEOPV/X5WaqERX2PXV/aXMNjwV0ywO5T9oZQ
 URJab
X-Gm-Gg: ASbGncuZeaJRwYs9mczmyZWjLzAQQhdCwfnj0azmEHhUP2zhlV3cCeihadbgZckIOj8
 x1lUoWpfGnTXtVZBLOztRrnt9FIIjdzE6yYB9asZX+Hf2FgcJHopsV808mcWGcZg6Gf3YicMLU1
 EUbkQFEoUE8D69CaGxQFCuz0whPYpoZJwFizCnNoI5MOzU3Le7wzH7NWIpq4x8TW7kv2c3MjIWf
 G3V0zE6oOC6/cVd21N7fUziwfs8vsSMTHW1rAhDS9aMgEhzUk6tlr9n4ekfBPZ/jtzbOaJruUIl
 O0zDDIyU4viiN8zFoQ7eRPz23GpANwwLSBwX94aIYV1rH43w4Zu05tCAijf562XQ0s/mUmXHvyx
 JmQGUdK1Sdq8ojwNHvyxH2teUwhz0
X-Google-Smtp-Source: AGHT+IFNFjYx4BQXPe0yiDVfPUqgQVuxHNBB9Po8++yPvyPWJJ0qteUYenm3j3l3tsLol/ejnsRIxg==
X-Received: by 2002:a05:600c:35c8:b0:456:1dd9:943 with SMTP id
 5b1f17b1804b1-458aa31a884mr32099905e9.3.1754063531786; 
 Fri, 01 Aug 2025 08:52:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] target/arm: Fix handling of setting SVE registers from gdb
Date: Fri,  1 Aug 2025 16:51:58 +0100
Message-ID: <20250801155159.400947-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

The code to handle setting SVE registers via the gdbstub is broken:
 * it sets each pair of elements in the zregs[].d[] array in the
   wrong order for the most common (little endian) case: the least
   significant 64-bit value comes first
 * it makes no attempt to handle target_endian()
 * it does a simple copy out of the (target endian) gdbstub buffer
   into the (host endan) zregs data structure, which is wrong on
   big endian hosts

Fix all these problems:
 * use ldq_p() to read from the gdbstub buffer
 * check target_big_endian() to see if we need to handle the
   128-bit values the opposite way around

Cc: qemu-stable@nongnu.org
Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250722173736.2332529-3-vacha.bhavsar@oss.qualcomm.com
[PMM: adjusted commit message, fixed spacing]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gdbstub64.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 4fce58d895e..08e28585396 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -206,10 +206,17 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     case 0 ... 31:
     {
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq++) {
-            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
-            env->vfp.zregs[reg].d[vq * 2] = *p++;
+            if (target_big_endian()) {
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+            } else{
+                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
+                buf += 8;
+                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
+            }
+            buf += 8;
             len += 16;
         }
         return len;
@@ -224,9 +231,9 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     {
         int preg = reg - 34;
         int vq, len = 0;
-        uint64_t *p = (uint64_t *) buf;
         for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
-            env->vfp.pregs[preg].p[vq / 4] = *p++;
+            env->vfp.pregs[preg].p[vq / 4] = ldq_p(buf);
+            buf += 8;
             len += 8;
         }
         return len;
-- 
2.43.0


