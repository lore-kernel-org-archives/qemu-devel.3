Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6ADC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEB-0008Rw-Sg; Fri, 04 Jul 2025 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEB-0008Rm-6y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE9-0006Ah-Dl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so632941f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646328; x=1752251128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HNTx2jUTtiz41AJHeGve8gVUecgpPInN9pSYsT5KM9g=;
 b=fi3QLrK+5OzjTZeXkZJRATP4WBmmmtUqVR+pLEQ7D+Fr+DHL36BeUqa8YD6JWBqRfM
 Q4aQde8U8Va/C8vnGuRUfsd7RpJXsbhyNSkF/TRl7h8fw+kQ6G5hzjyYgYLPf9L1g95g
 x4O2Lf/GqXZPxMiXVA8Jl7tLKfyqvERBJ135WpkJM2ltiLibsZHxxKrzeEfYYtGevJdu
 jKvOiAne0hcXqL934ElutfaHD54LwjMpW+BSTU+AX8l1sg3L0MtMZGi4KsMx6K9+ck2d
 gHcq0ZBfS0qYRSc5iI4Wenod3aJQ572uZFCBba8TPOWPDAHBYjU9y2eqJzSkc4F85X9u
 OgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646328; x=1752251128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNTx2jUTtiz41AJHeGve8gVUecgpPInN9pSYsT5KM9g=;
 b=ZIYvJj3hXANTMzw5vkn9FA4TmIyZianUpMWdXf7lx6XsX3gyHM9g2BtefW/4bZHDF9
 EX4WHPMIBfmxJPVe/7aCOmo5ddHNxfdF+eTeR08I6drbNEVmPu3dsurSnO8sUNaGbcdX
 42H3M9q1+qcaMwcCT7Ch5FzjmCBEH7irdDlajEoMVOZ8boHlHMzEAc+iitD/us3/OrDy
 AnfUTklw2ozZz4H2uE++JxKB92Mfv9gdx1Han+6duF/tmnkGUKzbRIuHBvWxwhT76oEY
 xnDZOWJpmFWHjBs2qiENkeq4JaIC0ImaCw8sV5JiXLYCCxSCx9r8TLXRLkyO1O3vao8W
 YJJA==
X-Gm-Message-State: AOJu0YxHKb3Tyv3P4Df0vOKIOTWh5HwZ0k4TIijHYM0gGOE3xQCIP/za
 N2xL9/hM1lSaRfkUCgnmlaqQ8uYXKxs6joDBS0PGCP0X6B6y61trA1ArCkVeADInw/Mq71H14Wi
 f03xU
X-Gm-Gg: ASbGncttrjopITgzkIX66jqJQ7chvj31jOMgLult1DzvqiST/YAfJV0yssgj4vV/tTg
 P7+ncbdTZDP/2q6Ikf3UGlSBPZ3OB4HjM4vn/jn2+50SY+7U8/tm78qJ2Nz5W+ZgpHjpUMHIWwD
 9O1fOHHodVK/sCQ0VP4M9mwULZ2nIGMLy55t4udmJvaEKqCPXhfEYTRkcuPcDSdBxd023T4fkZO
 9tvMOYKZTTpwcISjqFSbc53+QIfhKGW3EhnyrZhz0Dx3eJ1gFPFskpTOvJHtSzyRS/d1lU0I6QZ
 0iG20afbJx03lsIhD0pfAakvkRwk+Rfk/QkXhE+dMD2JE+/6G1RVNq1SsBOGCLjAAHUe
X-Google-Smtp-Source: AGHT+IEPnC3Y02ydmyZoj0cBvEhdKJ1TPz+UidnRra3pIrDh5tqxZD2CYEAGkoSKtLj059JHkOAIhg==
X-Received: by 2002:a05:600c:4f49:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-454b8b37c22mr12947105e9.0.1751646327896; 
 Fri, 04 Jul 2025 09:25:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 027/119] target/arm: Add ZT0
Date: Fri,  4 Jul 2025 17:23:27 +0100
Message-ID: <20250704162501.249138-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This is a 512-bit array introduced with SME2.
Save it only when ZA is in use.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 target/arm/machine.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6041a93578..cbc20434836 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -716,6 +716,9 @@ typedef struct CPUArchState {
     uint64_t scxtnum_el[4];
 
     struct {
+        /* SME2 ZT0 -- 512 bit array, with data ordered like ARMVectorReg. */
+        uint64_t zt0[512 / 64] QEMU_ALIGNED(16);
+
         /*
          * SME ZA storage -- 256 x 256 byte array, with bytes in host
          * word order, as we do with vfp.zregs[].  This corresponds to
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6e73368ef97..6986915bee8 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -321,6 +321,25 @@ static const VMStateDescription vmstate_za = {
     }
 };
 
+static bool zt0_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    return za_needed(cpu) && cpu_isar_feature(aa64_sme2, cpu);
+}
+
+static const VMStateDescription vmstate_zt0 = {
+    .name = "cpu/zt0",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = zt0_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
+                             ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool serror_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -1096,6 +1115,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m_security,
         &vmstate_sve,
         &vmstate_za,
+        &vmstate_zt0,
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.43.0


