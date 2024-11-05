Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC0D1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbB-0004Rf-KG; Tue, 05 Nov 2024 06:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb9-0004RM-U1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-00075H-1p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso63303525e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805581; x=1731410381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ITym5U3J9cuAVSZN3O87UN4hyjdbTQKA+1cJNNI3AY=;
 b=jG1AbU135apmnC9jNo7x6hgjx4jHgOryrRhYZZU8J3JY44+PV5x7799mCSILrrH3Bx
 +pjiyLZVAaG5I5XFsYfh3FK/3QHER25MLfFbPUuBOXKES3ScWzkNOP06pBpbGuoALK3C
 /XqX3WCafrS4uxSigiXkJJjrKmg2qESZ46PgeE2Q/8JkC8v6clpMzUXoU0WBAXA6Svlx
 xyHVzDms6Lg8ouwc2PgU4PfgQcnlS0hS9VIm3z86s2BvdJLDcgY5HNMt3RhtAjtm5YGM
 Ys7hJvOXoi8AicYvDIUuJfJZKw8oFheXb/p/AwJiM/+z1mVpE1RoTJ8T6tYBGbE+WSQ6
 OOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805581; x=1731410381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ITym5U3J9cuAVSZN3O87UN4hyjdbTQKA+1cJNNI3AY=;
 b=nj21cBtpw0HTIpDiLXGAkEcMTvWFPwkFAH02zeOd5tJPp4bMRUTx5m5dPM0HEh8VZy
 tGGe0WQixX6n0Sx7mlDsw31Ec8NGVzd933yDr7pDPgUBwIIKX7F6epFf4Amg04S2qh0o
 5bidHio0FAHwuypjrzAhV1/4d4keyFjPmNMV0TNa2TSXTpEffqJlt3Zk6mijzQDIpnbg
 ISrYbz/rY6jeFVA9g8IfKMKSf1RE+T3nXzyxOeyPYmBXEGfMM8BLiJa270s82hGHjSX3
 kOjg95KTxsQG+SfYsag9cdIZwDR+oB6gjnM6zSfexcCiOfkcKm+0SPIvtbsM4uhtSwJC
 Cxmg==
X-Gm-Message-State: AOJu0YxeHdqAho5RG+T92hQFmbTKf+IX0J6PmEi0hpsL3iTxe1oq/kpp
 QuRKg4koGL2MJR9jaEa6zYyUcEiYU4EcBaehnfuUpzFAGMn6Grk2LR5ij9XJcbpmW09SRMvZdwB
 T
X-Google-Smtp-Source: AGHT+IEyWtuYGCcJmMHyDK6y4iMqyjX2LlXPkwkTB3/YbuwXCaXx+Ik6hVVqr/xMfNdQNRf6Kmh2vw==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43283296066mr165633785e9.34.1730805581139; 
 Tue, 05 Nov 2024 03:19:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/31] target/hppa: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:10 +0000
Message-Id: <20241105111935.2747034-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Set the 2-NaN propagation rule explicitly in env->fp_status.

Really we only need to do this at CPU reset (after reset has zeroed
out most of the CPU state struct, which typically includes fp_status
fields).  However target/hppa does not currently implement CPU reset
at all, so leave a TODO comment to note that this could be moved if
we ever do implement reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-7-peter.maydell@linaro.org
---
 target/hppa/fpu_helper.c       | 6 ++++++
 fpu/softfloat-specialize.c.inc | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index deaed2b65d1..0e44074ba82 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -49,6 +49,12 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     d = FIELD_EX32(shadow, FPSR, D);
     set_flush_to_zero(d, &env->fp_status);
     set_flush_inputs_to_zero(d, &env->fp_status);
+
+    /*
+     * TODO: we only need to do this at CPU reset, but currently
+     * HPPA does note implement a CPU reset method at all...
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index bbc3b70fa9d..4e51cf8d083 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -403,9 +403,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA)
         g_assert_not_reached();
-#elif defined(TARGET_HPPA) || defined(TARGET_S390X)
+#elif defined(TARGET_S390X)
         rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
-- 
2.34.1


