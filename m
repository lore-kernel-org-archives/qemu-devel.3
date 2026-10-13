Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58938CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4Q-00018Q-VB; Tue, 13 Oct 2026 04:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3U-0007ES-F7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3Q-0007qX-1Y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so15778405e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880810; x=1792485610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4fi3KaUQEy1+IJ+5cSEeFvIQP/QNmNxFWZjQRxfI9as=;
 b=KfHpZzP1LooLBUS7nCCXO7jW4UfzjU7Wp7nVYRxhTqVcBAHens6oK70Jv73XlS/+BE
 BLXnMHNG6k27NmVBcXeZNyS2Jgq4UQhB6HPfgIeCUspu/KcyE9ub1v9Du6pkJSptOjfT
 ZWyZFGt9/2uiKX9Z705xHVFoQLwOAlNFGzQs39cpMPP120JEuIN3FgAPwkfcEs44qXT8
 xm7VVNNX/RnYjPDWdEkiLwLybLTLanaY8q1b4jmeGLpNS0di1OoZDkSmXPey/wjBYcyS
 7s0NdFq2B7Y9zIzk9IMCS+oWUxi9qTYs3bL7bjOBeZ5eN8/1PqcqhNqtK9QbKW1NNxwM
 h+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880810; x=1792485610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4fi3KaUQEy1+IJ+5cSEeFvIQP/QNmNxFWZjQRxfI9as=;
 b=nHPktA786CIAAV83byeEHeWQ0/zz1UPdpWpDsgUtWi1fArhIaoRzyBRXz9Fog4yzwP
 kS/LPCUzGqeJnkp+mgmdHvLCNy9o47jtlWjIWRtmpHi6s1UwwN4rpPDwlQyUtTD/JwSJ
 CkDINPFnlC89FhNdh8n2+bNSFDz6hQNYgvHZeyZlewAfFr/GTX6+FR4lx24WgOc+1/Cp
 18a0mmyHsZ3np0J538QkJP6JFQztiq0MSYzYIjvcYEOzHrLLZTaJLHvBnIxnN3G/9oid
 kJw96HnS4wU2ePpBhSL+wkV206Tv7DlHCqjzb7zHWhnyjG63e16AA/n10blyJaHkHXC+
 Oyng==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+3hfErSa7Tb9hdnOlED2qm5/2bm1SVEtxY8kKUbBwrZOLAIS8HcMEyOSu4uzFR3/QWH5H5jAWUjxP@nongnu.org
X-Gm-Message-State: AFq9FYK0oZ7lj7K+bqwaCnLLqGxjIFeXWu8V5Dug5xa32nv2wGRag2YT
 wSUawvg/W3WTS+YKrZdiUPUU1tjr5sgAmzrsVP55LrvHxBTekPHPdG1VzpdHvQKsrPPnIWH1O/N
 kGTwgkCU=
X-Gm-Gg: AYBFou0useSjKrXF9UUvMY7qf3dDOFr3Zvk7vaQFwZWt3NadmLhFihlwQTg5yGZy0WK
 u7LTjxu3fN2mNB3zQlnxGe6JXG9dcEsH228sf8tqEyim8AgafOq6LiRJ5PCApOXKR0MsN5CMIsP
 Ywvn8mOR4ZEKth4hHxiCaMBjCx7w81HUSZ4eZCuoArzkrNkRiRUsKj8Ofofbnh5DXJRPdK8YypB
 uYoC3j0XHhHnq31P4BawJshmn2IfiRT5c/32t+gg5JlG5CIvvokA6+JFH1wvRkxBzKevYb4vwVv
 DkvmYnLg5+tqQNEci4KIXCFU9J7yEaRcYQTqE9yzYo9800NKnAeDG0Q71pjc8bGaHbLAQMFIOux
 XluKgO5LbFKtVGh1SrB/Xdvurcd0Rkvkr3mZ1RfAzhETBRnx7tHzFOnuYrvAqzJCIGZz0Egci5J
 0l2k+Vdc80XzOwm8xUjeMuHQPvbIoUBine4NqUx4x2q6HJBUn7uIPbOBxpSlslzDXDlt6Ru0rvu
 zdRoSsWS3RKqlt0IrcxMzkciMSkaQ12v8xMRTs5278QCRyq4lomq6vi971H5mAMpBESLWNNKu7b
 v6gK0PycNaWy0Q==
X-Received: by 2002:a05:600c:348d:b0:4a1:813f:2a63 with SMTP id
 5b1f17b1804b1-4a18e4aa26amr220023575e9.18.1791880810486; 
 Tue, 13 Oct 2026 01:40:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 25/86] target/arm: GICv5 cpuif: Implement ICV_PCR_EL1
Date: Tue, 13 Oct 2026 09:38:32 +0100
Message-ID: <20261013083933.1024405-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Implement the redirection of the ICC_PCR_EL1 encoding to the
hypervisor guest's view ICV_PCR_EL1. This contains only the
PRIORITY field, which is stored in ICH_VMCR_EL2.VMPR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 247cefd9e68..125dcd8cf4d 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -612,18 +612,32 @@ static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t gic_icc_pcr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    GICv5Domain domain = gicv5_logical_domain(env);
-    return env->gicv5_cpuif.icc_pcr[domain];
+    if (gicv5_icv_access(env)) {
+        return FIELD_EX64(env->gicv5_cpuif.ich_vmcr_el2,
+                          ICH_VMCR_EL2, VMPR);
+    } else {
+        GICv5Domain domain = gicv5_logical_domain(env);
+        return env->gicv5_cpuif.icc_pcr[domain];
+    }
 }
 
 static void gic_icc_pcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    GICv5Domain domain = gicv5_logical_domain(env);
+    if (gicv5_icv_access(env)) {
+        /* The PRIORITY field lives in ICH_VMCR_EL2.VMPR */
+        uint64_t vmcr = env->gicv5_cpuif.ich_vmcr_el2;
 
-    value &= R_ICC_PCR_PRIORITY_MASK;
-    env->gicv5_cpuif.icc_pcr[domain] = value;
-    gicv5_update_irq_fiq(env);
+        vmcr = FIELD_DP64(vmcr, ICH_VMCR_EL2, VMPR,
+                          FIELD_EX64(value, ICC_PCR, PRIORITY));
+        env->gicv5_cpuif.ich_vmcr_el2 = vmcr;
+    } else {
+        GICv5Domain domain = gicv5_logical_domain(env);
+
+        value &= R_ICC_PCR_PRIORITY_MASK;
+        env->gicv5_cpuif.icc_pcr[domain] = value;
+        gicv5_update_irq_fiq(env);
+    }
 }
 
 static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.43.0


