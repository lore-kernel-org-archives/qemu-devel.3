Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB72D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqb-0004HM-95; Sun, 03 Nov 2024 19:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqY-0003wP-Ge; Sun, 03 Nov 2024 19:21:30 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqX-0002hH-0i; Sun, 03 Nov 2024 19:21:30 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso2512745b3a.3; 
 Sun, 03 Nov 2024 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679687; x=1731284487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tRnHn0imyDgzIBjiEWjpE9f1p8r45aL3qXvb+TAFyY=;
 b=hUxB8Oo0myL+52D5nNLtn/AWiH7W83P9DrW+Pbq4DGf7OGr/Ej4uZV2D+LxfLT+mtq
 tLij58Sl0oN4st8/kNy3JmbqaeWU7tJvfN1rOcSgFUiDJiQdrFMi1U1eRlJxa2V5LPSj
 bxwK6NoKt6s+KXAinWdqardSm6lt5l2jwcQHPrveplg12DH5AQwCgGHR0aQ5wR0Lzclf
 T526TeE2TXK0Pdw+UK0zcDX/qk2OOq2NceN27OhxeaXMHCCseC2eUjcXqScaf7hGFmgZ
 nbGL3H9i35n16qOhVunO4GkJS61Mz45SPpb6lg+zB53cr7MfEAL9KEZiIJ8blU1hkGl8
 eDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679687; x=1731284487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tRnHn0imyDgzIBjiEWjpE9f1p8r45aL3qXvb+TAFyY=;
 b=snBFRq3QTHtvogaVwy8NjwBhVDYuZYY8l/YMGZ98xgd9MbCW2GCvSOSDyB5/4vOVtf
 KptAxAQhkAxc/jWiazFAihMOQDF8BYiXisZVwo3x9ZWSBMob/P+cdR/A9grQyP4Lg87k
 MHRd+5i51A4Bmo/7kk/PvYQT1+cXP9sj8G7T9RrTX0gG7hkkayPkJe3GbKDIvqW4fVM3
 5M3XLhUMbSmkK0m+qgEIoxmMvZL2ycVYrLGcpX84TrYc3Og4pjtlWN5bFk8qyJaUl1zA
 9+7oX1a5ha14AC5MQLh98UQehE0Y3daz8iD1a5j2CovLKKeETNm9CJ8ZWdm2LoA26LJV
 Av0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcTIuivwwzX3pxLvdygebl5oRGOReYJBR9sL+BDuuAQw6bTYImp+nRKAFf/dFDojG2WJytamdIpA==@nongnu.org
X-Gm-Message-State: AOJu0Yy4wKkioLyk1PZQl3l0UL0wScM4zRy8kDJhOyG1+ROWMZ//64tu
 e+DQEL/iZJ8yBNyXV9GRgJJrrq9p5yqBBbxrmVT99B48OFw9+Oa5/Oy1Tw==
X-Google-Smtp-Source: AGHT+IFWApGiOfcYHz7vbNEMDbivSTmM0vv9xkOlR9XzcOoLYP+i6KY1cIDQoxmrJYGB/BDxqUpFYg==
X-Received: by 2002:a05:6a21:2d87:b0:1d8:fbf3:a9ac with SMTP id
 adf61e73a8af0-1d9a83a998cmr43381238637.2.1730679687155; 
 Sun, 03 Nov 2024 16:21:27 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 37/67] target/ppc: optimize hreg_compute_pmu_hflags_value
Date: Mon,  4 Nov 2024 10:18:26 +1000
Message-ID: <20241104001900.682660-38-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

The second if-condition can be true only if the first one above is true.
Enclose the latter into the former to avoid un-necessary check if first
condition fails.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7b23e5ef0e..42c681ca4a 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -102,9 +102,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
         hflags |= 1 << HFLAGS_INSN_CNT;
-    }
-    if (env->pmc_ins_cnt & 0x1e) {
-        hflags |= 1 << HFLAGS_PMC_OTHER;
+        if (env->pmc_ins_cnt & 0x1e) {
+            hflags |= 1 << HFLAGS_PMC_OTHER;
+        }
     }
 #endif
 #endif
-- 
2.45.2


