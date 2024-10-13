Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A49CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pv-0007F6-Ho; Sun, 13 Oct 2024 18:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pe-0007Be-QC
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pc-0000wj-OO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207115e3056so29568475ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857575; x=1729462375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I928rOfU7rFS4/uAexBKDkmn1Lv4VMSl/VKyNRV9wmg=;
 b=sAJxY6ZNM4Ozdw1YVLNeEQrzzzcHGt94LRSfcAiEKvCEA6UUre+i+eAcwXZpJbR3CJ
 DDjriQKTAI7rqL0cKfVJxdcANpTk46An4lvhuvvT6nazG14ygf6GyviJESLyZ+b9Yusd
 Th6Gi4dqHTw/nt2Dz0axLHqQ7sVLOfCA2tvObXdjxGh2lalTc91Y6ia7z+gXVxbyI769
 YXmDggeLfKI0SCI0vuztYcSVyKKnVSVnkYvRWzykO1AVC30cFbo0II5iTbFHCF0YQk+O
 b/VyXDF5AshVSv7iaeaVIAhOdNd/TwSrbCvu1F1EQrVRsJ01PqFL26xZWqmz8QCPdlA0
 iQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857575; x=1729462375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I928rOfU7rFS4/uAexBKDkmn1Lv4VMSl/VKyNRV9wmg=;
 b=U92dzsQeMYvu1XbstfJUjfXWv+PtzanEKjQhrDbjMgvUksi+yfgre73gofhuLaDlVz
 OK48jYHy4NymKcJg/hEGWSF7UvWuxAU8hhhsYL4muGB/E3tKoLAdiI/NNbCBuWtZJWAi
 0GYZJz8jVSR0k6tPX0Sp8XdY3lq6dcLjWqg0bbOwVAXZeBxUhopm1gFpyiDfEg3CPM47
 jS5FeVXfrX9DuWOR8s7xFWR3vWkhQ/UyR0Gr3tQhQnT2GpvqjvcNMhfpHSoGF7n1XtY5
 XfHrUx/9GIqwel6zFOD4/xwlLVMdCMqBt02ZPBqu+sclQaf5EPH1ab3UEQs1oHu/fL8j
 ohMw==
X-Gm-Message-State: AOJu0Yx9HX3V2pxd+m1JV8psoDEtBTRlFZTAlnzyRb+oGSfxKLKfuAiY
 0YwpqAh6i8kRqthvEmYgj31dEs9Hrthl2sfcjzArAbeTkfTLiBXVzlNDZWpGNg+vYhDF1QyEP0C
 U
X-Google-Smtp-Source: AGHT+IGgt+5Nm7Ydmbtk8c4xRMgLKq5oCb042saoIkUCoMAaAfocbfXnTbZomqCDDE6sj4mVYiSKjw==
X-Received: by 2002:a17:90b:4ad2:b0:2e2:e545:82c5 with SMTP id
 98e67ed59e1d1-2e2f0a4d6c5mr11663640a91.3.1728857575344; 
 Sun, 13 Oct 2024 15:12:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/27] target/arm: Pass MemOp to get_phys_addr_with_space_nogpc
Date: Sun, 13 Oct 2024 15:12:28 -0700
Message-ID: <20241013221235.1585193-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Zero is the safe do-nothing value for callers to use.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 3 ++-
 target/arm/helper.c    | 9 +++++----
 target/arm/ptw.c       | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2b16579fa5..a6088d551c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1461,6 +1461,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
+ * @memop: memory operation feeding this access, or 0 for none
  * @mmu_idx: MMU index indicating required translation regime
  * @space: security space for the access
  * @result: set on translation success.
@@ -1470,7 +1471,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * a Granule Protection Check on the resulting address.
  */
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f77b40734..0a731a38e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3599,11 +3599,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     GetPhysAddrResult res = {};
 
     /*
-     * I_MXTJT: Granule protection checks are not performed on the final address
-     * of a successful translation.
+     * I_MXTJT: Granule protection checks are not performed on the final
+     * address of a successful translation.  This is a translation not a
+     * memory reference, so "memop = none = 0".
      */
-    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
-                                         &res, &fi);
+    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
+                                         mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 373095a339..9af86da597 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3559,7 +3559,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
 }
 
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
-- 
2.43.0


