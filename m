Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296BFCF042B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCh-0004XK-7K; Tue, 08 Oct 2024 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCd-0004Ue-8F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCX-0002vq-5V
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b49ee353cso58170815ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432312; x=1729037112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDNpltdoK5BIHBCpA0bLYhC/fVRvo8Z+4KE41wqkR3g=;
 b=U6kx0i/eMPIC2ohHI1uR+zInnQ6YCT0aSvcGPSlIYD9YEIkfMpaYWWSR8Gyykz71ir
 jifEUmELtNrusQ9AOgBphnL7ISec98s4KXKF/G5/vctoTVgIKCfWPM6On4zQMLMcOy75
 u7UHGTISRERk4N2e180b5eRCFzWT1nRVRQbbX683GkQz3mj/f0Q1eCDYMO5gMPCCe/G3
 0ma3zqQCfq3HQzyLViJCo8CqeXbeNTNrkcCz/jQ4VN0X6T1rp/RurpERW0LshjPSY/w+
 S5nS7uGD/NbfFcf5b46l/Gpym8JPiO+VLmfkrX6173aSyQHrl+V/Ndy5635n/EFE37Wl
 JcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432312; x=1729037112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDNpltdoK5BIHBCpA0bLYhC/fVRvo8Z+4KE41wqkR3g=;
 b=H3oTHY2d1kQV6jG5kwRfljIpDfh7PYPUsuP+vH/OJ0JUJup7bTvOqKJH4AzWYoys4w
 37KxRa5AcZp8M4FrXZBDomGFqpstGl94r7lSOppyGaZJR21q80zK2WhmUZ7n0f/2B+dT
 lb3mNkO7YoPHoo/2eyoe13B+RtSgwXzu9gs8U8CRpTBTUmteadHLUE13iEvEOTjhwXIn
 EvQW4dvhhPQ0IGMu3lXXULP5IaVofNAjlmG4OGk7nU3XGAigVN4bD1ltaJexxJ0kcV0E
 2rgAJk1dDh7XSjZ9vJJ4L3HWnjKzMlEvL461JIM7cup5xkuV2NcTek7j9JXU1hzko9sy
 LWHA==
X-Gm-Message-State: AOJu0Yzy9+oCtg7g7AHD5+F2c1IkM9ru/Ki+07x7YLiPNe0zv4tBP+5Z
 /FlpYdSFuppH65a+in/m0kInog4XVMV2/qiHkQyzDt9tAqjpcTp+sSb5o3XbS8ESHTmDKYfE3mJ
 I
X-Google-Smtp-Source: AGHT+IF4BglkotazCAHqUPofHInFIYYYoctu9w4tOUz92qreZT9FiKqKTEYHHdQjaQVFF8PF0y1lkg==
X-Received: by 2002:a17:902:da8d:b0:20b:c258:2a74 with SMTP id
 d9443c01a7336-20c6373ce07mr11388505ad.29.1728432311644; 
 Tue, 08 Oct 2024 17:05:11 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/20] target/arm: Pass MemOp to get_phys_addr_lpae
Date: Tue,  8 Oct 2024 17:04:50 -0700
Message-ID: <20241009000453.315652-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Pass the value through from get_phys_addr_nogpc.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1fca086a4..238b2c92a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1684,12 +1684,13 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
  * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @memop: memory operation feeding this access, or 0 for none
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type,
+                               MMUAccessType access_type, MemOp memop,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3534,7 +3535,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_lpae(env, ptw, address, access_type,
+                                  memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
-- 
2.43.0


