Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B29DD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqZ-00042B-2Q; Sun, 03 Nov 2024 19:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqV-0003Z0-3m; Sun, 03 Nov 2024 19:21:27 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqT-0002gv-LG; Sun, 03 Nov 2024 19:21:26 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-723db2798caso65910b3a.0; 
 Sun, 03 Nov 2024 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679684; x=1731284484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5acwOP9v6mqTwgIgkzY3AX70LRjavmcEjrHnDYPLjA=;
 b=HkyK9lH1oqkY0NXSVPMa2hqyPeEzaZfzc/5P0wwbssGsmOLK1kBLys0ZXwHkDPGPTi
 6BZB829MHzyg9LkR91lq/5KGNNav6jxmQBnRWv+L0eZ46tXCjeddj+528e2WhfOBCmQC
 AuGlIENd71ARt2RaR6M0uAKINhD9elTGGsjgqgfh0Q3Dwmzwl+IaUHWsMOzylFWCfe/Q
 tH+QvAFYHonnymFm2cLAIiFNIKIWMIUZjTV5sdvhat6iP332kjuwjpb64ycVJZrY+H5V
 0DMS6sT3WA2UnxlIzOI+guqym99a8pExmLFWbOSbvKEphZyKFUD8SKo5dd5f3dTGv339
 C/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679684; x=1731284484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5acwOP9v6mqTwgIgkzY3AX70LRjavmcEjrHnDYPLjA=;
 b=aRf390+KyHOvSHWEQTQOZW+rEgYDzlxRMdu9IufMrB+bTV6OZnAOui/3YyBhF7DoDT
 I5UsVTW3Boukbs24DZAmp0cJUHM3wue7+IZy0lw9JzRJiG6B6bKAvrBUxTEJu/TtHIps
 s8KDipD7yJ4kCZrTwgD1a/TdjqOcgRqb/Spf0RrIPx4LH9Nvzro5rel5WjuRRYLDB4hG
 1afJzdkSMM3yCaf8MEQH0XeotvtRUOrHlYqSPTFbRVzigORdV5RTmSayU4+1sWw6XpJv
 0mKAl0MiHnWcDhmRO4lCNqfu3Xij6Y+Ve9e2QAmMzHfCwQhBS1jwPikYHf/xAELFhLP6
 wWxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7tJo6pZO/oLzR3EMKRG87wYnbZndPaEqIjYizwZbd+KVc5o71zVs7HIxRZnIddTdSyrz/U8pelQ==@nongnu.org
X-Gm-Message-State: AOJu0YyjOiwuGbhx5lwqO1QlbWASGTN2ioi7OtQHROQ1MOd5SCl7l1Cf
 o+/SEjFvwVLtmZcvOI9D2yCcmVYJYd4mqie+2x0sRQS+3tNA1pIGSnzMPA==
X-Google-Smtp-Source: AGHT+IFKr/EWg0gHaidpnCHmzxm7Rd3iuMQxTpy2lICcjT7z8nVQ0RnlCXk7gfP4XlT9Wq+q954v6w==
X-Received: by 2002:a05:6a21:6d93:b0:1db:ddde:33e2 with SMTP id
 adf61e73a8af0-1dbddde33eamr1773122637.29.1730679683729; 
 Sun, 03 Nov 2024 16:21:23 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 36/67] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Mon,  4 Nov 2024 10:18:25 +1000
Message-ID: <20241104001900.682660-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Cache env->spr[SPR_POWER_MMCR0] in a local variable as used in multiple
conditions to avoid multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index fe543ab3b8..7b23e5ef0e 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -83,15 +83,16 @@ static bool hreg_check_bhrb_enable(CPUPPCState *env)
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
-
 #if defined(TARGET_PPC64)
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC0) {
+    target_ulong mmcr0 = env->spr[SPR_POWER_MMCR0];
+
+    if (mmcr0 & MMCR0_PMCC0) {
         hflags |= 1 << HFLAGS_PMCC0;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCC1) {
+    if (mmcr0 & MMCR0_PMCC1) {
         hflags |= 1 << HFLAGS_PMCC1;
     }
-    if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
+    if (mmcr0 & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
     if (hreg_check_bhrb_enable(env)) {
-- 
2.45.2


