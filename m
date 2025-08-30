Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9CCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNwR-0000fY-0j; Sat, 30 Aug 2025 11:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMJ-00063F-PJ
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMI-0004Ct-7m
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso2460127b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532557; x=1757137357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qdzdzmqkJ1XgfZtAa367u2Lrhe3gNI4FuUAtbTsqDg=;
 b=mr2VXj+PKSvypeunLdLvJuRQ3r/3dVPLSiZ/6IGqcEIG236kQswG4rygSlADP313Tf
 jRZOYp2Wnm4Tiei1z8ute7IdClaQKQegqT1LxSgGDoJTctqgyQTrERos/Hl6XvfOwoFr
 8g9uZt0Kx5BCk/zAiSa0YCrcYtxU11Igxi/GB575QkasOfOs1iwdKFGpYBAGvlL1qQ//
 goUR0EuqRRg36e9NwI74z4EaWQvTcANrHWIrSbDl75tnRqvDu0g9Ylt0rO5G9f/t7H0+
 aFl93s1a3qAQ4wrAuKXDXwbZUHOAqBDvbEnEiPMBGZ7LqUUeZeIkMXeV75eu2qxxdNUy
 8emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532557; x=1757137357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qdzdzmqkJ1XgfZtAa367u2Lrhe3gNI4FuUAtbTsqDg=;
 b=ii0Eua3cIjrLbBtSmbSacdUgErmG2ipMZo077D8JIhmpRVsuJP7EN2Gbr5+T6IAPDc
 GLWnFlKckR/bbiaj0Xw36HpsTAGLbizv+zZYTHyHqQke8eYYOfoE7xvKQ078bhU9rRAZ
 kKLGQ2xSn8mYoGF8Lrjwi7jzQ/OKkiQaZcKrOS2dmPkv3W+sY3d805mXVeISGktPKpn9
 BpRPZktrrzM0NeJOUu+AFnsIQsSBJM/4xNw4sU1nkF4VA6Yff3YrffFtzhIWq4pXHfOp
 ZIWsmv5Tvd8Dodw+gmYl0rBfDdSsP3AgWUFrj4JB1A2XMIwcPzoFC47PTPWlovDB9h3l
 /RDg==
X-Gm-Message-State: AOJu0Yyc6Ld9CdQ6qPo9UQWyiPIRGO6NccleT8JOH5dLRM99yrEBfisO
 I15ufGLiNMZFSEAb/ZqYL5e1LuiCeS/TM1xZ3Yr7/cmUFUNo+B4NJyqoZI2FUJKE64LO+Zat8ys
 75l3UvRc=
X-Gm-Gg: ASbGncto2+BMvjG3Yya9wwgWQafQRtex1zYvS3QpbjSct1OVPOQAltyx8a/VQ3wMaGL
 fAxh8PpqS/7/YuWW6EUeBNM/WzbnX6QKtbZ2dywHDwhnZz+saqbX63dtamTVhgr6V/8JYETGWQv
 N+7/tUdPgALF9iL6MSV0Or953z1DKfn/50pDekFlo8Vh6vhH21QXI14POSdeGYryfojat0AA8mS
 yiqc76GLLMaoGWE/PWiHqmAzQy0lv8TATgJf3zIyP7azv/C8q8XgIOlu2ieqGP54m7kwgLwiSgU
 9qabnMaYub1eMNBfHd9gd5qbuGKUc3Vei1Yp2nOh9kwvo2+lQf6V6YJTlUJzWZ7YVUjYWrNB/QG
 inDoyAdHP+n47/0rKx3eBhhv/a86hKG9Q9JM3XBZ1DjxmAFgAqteBUPX98bCNH3A0+zeYM4idRc
 OeMlel4A==
X-Google-Smtp-Source: AGHT+IH++p8QS+Cu88lU8VED/a6OpKEdFJx6DzNNKJ0jlW8z6UK5mDVhjCxwHaUp82twp17j/H7gfg==
X-Received: by 2002:a05:6a20:3d07:b0:243:b190:d139 with SMTP id
 adf61e73a8af0-243d6f1003cmr1642746637.39.1756532556633; 
 Fri, 29 Aug 2025 22:42:36 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 22/84] target/arm: Expand CPUARMState.exception.syndrome to
 64 bits
Date: Sat, 30 Aug 2025 15:40:26 +1000
Message-ID: <20250830054128.448363-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This will be used for storing the ISS2 portion of the
ESR_ELx registers in aarch64 state.  Re-order the fsr
member to eliminate two structure holes.

Drop the comment about "if we implement EL2" since we
have already done so.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 ++-----
 target/arm/helper.c | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9eeecd45a3..fff2195138 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -635,13 +635,10 @@ typedef struct CPUArchState {
      * entry process.
      */
     struct {
-        uint32_t syndrome; /* AArch64 format syndrome register */
-        uint32_t fsr; /* AArch32 format fault status register info */
+        uint64_t syndrome; /* AArch64 format syndrome register */
         uint64_t vaddress; /* virtual addr associated with exception, if any */
+        uint32_t fsr; /* AArch32 format fault status register info */
         uint32_t target_el; /* EL the exception should be targeted for */
-        /* If we implement EL2 we will also need to store information
-         * about the intermediate physical address for stage 2 faults.
-         */
     } exception;
 
     /* Information associated with an SError */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ab801e2704..fc95010727 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9332,7 +9332,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                   new_el);
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && !excp_is_internal(cs->exception_index)) {
-        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx32 "\n",
+        qemu_log_mask(CPU_LOG_INT, "...with ESR 0x%x/0x%" PRIx64 "\n",
                       syn_get_ec(env->exception.syndrome),
                       env->exception.syndrome);
     }
-- 
2.43.0


