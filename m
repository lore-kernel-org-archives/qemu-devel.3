Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD7DE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNygB-0000Vj-9l; Wed, 18 Dec 2024 13:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyg6-0000Pe-SL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyg4-0001pA-7Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso73321125e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546102; x=1735150902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wByjU5ClK1ME+AZ2OTGYKkBeJBTU4EpbHV73WRFFne8=;
 b=MGyYA0X5iPFczs+R/0YE3fuxq8mCs8eDC22X3mXKzGrdAhL4MoiDgXwD+I+XtNlkbE
 vN0IxugRsQ49eFQeeDj0553MUwWjWEWCuXVQgUpgv1c5XW4CvabVMAaqamsEkuct5hZ9
 8apzjaXKNS0RRgoQbOZaQvQYxaV08ah1FBQbc8YlryIpjFspZLjnwsh8PdyYwirq8fNd
 HPlTIpJ4rVcvnyk+Oa05vjjzcCMyY40+TWhiCR6BlXud0wHi8ZvpcQBuIUz9zdjnpeX3
 MjrkQ8JOPBf7VrghVcFBSqIW3B2wCua1M+SE/bUjENPMGDSHCgwkgefiwn9dyZBeLA6t
 wvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546102; x=1735150902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wByjU5ClK1ME+AZ2OTGYKkBeJBTU4EpbHV73WRFFne8=;
 b=h7ChY1RMvOBzF7J/3aQJC5cmtj6Jux4S5KDkr2m9FpD6OezQeBpIhzjqGnOT+7sXH3
 LWAJLqzpm066US1uE8L9R/CrMY5sR4+o7Dp24ybmTAhOb0Wsb9t6+JxWpHWCyyg5KH0M
 Lo49LBDvxeVR7vcYOwTxqBbfV5l44tZMD1DuLlH5jNnSUEHfrckOQrqjFxU4XGpaSETB
 mvvu0c93yR9Gf6wN7IjqK3e+BhcUqVW+ZojXp/zcgDZXHSWnva//KoM2IOFlrdxyFKNp
 GvbiTNEVL3o87l9Lq8oveGv2fo6zFiiQ2TQFq7TlepfCzDLdGP72THkEyh0s2smhNwMF
 Uv5Q==
X-Gm-Message-State: AOJu0Yzu6438ph/QNXngQBH+dSTXPDx7gIPW/YOQ2SsJrZR2cF1TXZfB
 00djEeX4maEBAR+eJ+owx+Upj+pUVCI3vg+Jkk+2P79g7xjTsN7Fv81R88vuObvArslAZ3HrWa2
 1
X-Gm-Gg: ASbGncuhUdbhN6W4zqBb8MyzB1Rv0kBcs8oovGSdHYslGv8IYm2jHRNNAH9C5oencsh
 OG442JLklwImNC5O2xq17JDSn/NEyQk+8qg+njkUNBXJ3LjgsxO1v0hiilRtpw0zWnB8bU+fjG5
 LbOb8zNDa7ELLnx5oV52omieFPTDDPqRBmpDkMsj9qW0AyWRYLMbX+V3W6d/Nx7wQP0VU8Yrr6K
 ynTJmp9TvSaD8jgpp9IU8EtMlSgKz9vlTe3+qcSZJiC3qR8hs+k092/k0Bo9+nW3PcoGyNSaeCa
 Rout
X-Google-Smtp-Source: AGHT+IHcOA/mFH0pC3dk8ATzniYKNpM3Xw+8gIBr18L7eT2HqQkYzJMqWczacjPLwXSbyG3O4jfPww==
X-Received: by 2002:a7b:c392:0:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-4365aa5a397mr20136245e9.27.1734546102430; 
 Wed, 18 Dec 2024 10:21:42 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80120e8sm14927833f8f.6.2024.12.18.10.21.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 7/7] hw/ppc/epapr: Do not swap ePAPR magic value
Date: Wed, 18 Dec 2024 19:21:06 +0100
Message-ID: <20241218182106.78800-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218182106.78800-1-philmd@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The ePAPR magic value in $r6 doesn't need to be byte swapped.

See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
and the following mailing-list thread:
https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCxuLyKqYk6_FCBrAA@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/sam460ex.c     | 2 +-
 hw/ppc/virtex_ml507.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 78e2a46e753..db9c8f3fa6e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
 
         /* Create a mapping for the kernel.  */
         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
-        env->gpr[6] = tswap32(EPAPR_MAGIC);
+        env->gpr[6] = EPAPR_MAGIC;
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a90..6197d31d88f 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
     /* Create a mapping spanning the 32bit addr space. */
     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
-    env->gpr[6] = tswap32(EPAPR_MAGIC);
+    env->gpr[6] = EPAPR_MAGIC;
     env->gpr[7] = bi->ima_size;
 }
 
-- 
2.45.2


