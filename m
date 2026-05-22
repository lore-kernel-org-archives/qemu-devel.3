Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BD7CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxf-0007gg-Vq; Fri, 22 May 2026 18:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxd-0007eo-J1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxb-0007kN-K2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so7239967a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487394; x=1780092194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXKbBj9vfpMdfO5YBe22u+O5v1SBtZ+DB85h6LpJLhE=;
 b=Bl0J7k7q3pJJFc71ZuL4yfsoAfJz7o0U4RZICURsE14NUVn2uyNdMI5tG3DTXjMq8r
 RZ6Ukl4LSyTpkGrQD6neTJIkWFi9XIEL/y9Niu/ePiL1dv/n2IYADeUypKWlP4dSw7gF
 lkPO7m00aobImVQgeIvbr00X3KD/xj6CyYDmy0wxDdKv+QIYcILIRxAmn1RRqZqg/WN5
 DzOcTETLAIto/QaCU2AjuJ62WEjlefZwwa9eo6YDBh391BTKpND9Cd8aqn/8wHMFY+C6
 OplzGvBwHAhoDIND6SDYu5KWBajPuD4zUoVZV5MgVEcZjBPthQmeMIXe9BgeHFlen2ih
 UYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487394; x=1780092194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oXKbBj9vfpMdfO5YBe22u+O5v1SBtZ+DB85h6LpJLhE=;
 b=MQq54xfdP/zKvVU6LlfExqO9xX+R9dPhY0OWl2IGclfYZVdKBG1iY61G9T2HUP/R4Z
 Vb/u4iDEW6c/0fKkWtczoRdflEiHzrFXv4clQWfPEw2eli6Gikxpc0E1vzWML3vcwBXp
 nD5e/WCWgHzcALFSW3GkHvCXSlNFzA2kzhFiXWYhLCxG3Tx3Ra6DRelTW+H/3893WVFs
 4WmR/w1dmok1VtCnJ/XFzfd7FVNrw2YzrcQ9rStRdFfK/cPyzxLXr3CYKrCdMbvWZ2sK
 W62K0NEWdZ8laSqjypU7qs9SnwC3jYTV8RTyGmaCkF33kP1MIYdlT8pPkYoyCnDi2ABX
 nbXw==
X-Gm-Message-State: AOJu0Yy9sevhboJfJjt1pfPEARS970d+5lEcxvuL36dt7yDM3F8xRwV/
 8cKmdZsbgIPaCww2c8/R7Cbi6qmLlY7tEf5MqVQTdmwKB2tgNpmeExbZO5ciZBAeHxJ8kVkrs6B
 TE1V6
X-Gm-Gg: Acq92OFkdSvbqaKuDGWkhaZcHpgXB1XqHPbfoq4KR0jAzxA9KDKzX5eJiTRIPDeKNqe
 JXEd/NKEWBK0jlq7I4r3XuFASJh/JiAaT4t6Me+2iR6fj632cNWNP/TPMqgL8t22brWohYUNhDM
 npZDuNgrL40Fiub2sO/lVuroUph4uQh+ujMvzC56jIPcaeJq9MaqFeMZPrARJEHPiWt29Ni/dkZ
 K4F5W9ZtdMka0qWxaBvCsScAqeHcMI92bkVTlae/BZyrK/adS7sRV14XlUFnnEJV1Oa5gKXnV+C
 p+YTSlPiNAVOMQ9xXzbczA814zvDru9Phlaeq7cQ/aK+attUv64Wq9Eb7hfVa5Ye7izKTxWTsQl
 k8qhj6RhSLrdZK99AYfPso9KLFS2AsQlKFMMwDli5OCmEmbZgk7cFE8ULXoNz+w9tvyrXipUIhC
 1neE+MmqfHfqSyeNvm7pvKFBCd64QV
X-Received: by 2002:a17:90b:3ecc:b0:369:d7c6:450a with SMTP id
 98e67ed59e1d1-36a671e974emr5645988a91.0.1779487394101; 
 Fri, 22 May 2026 15:03:14 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 06/64] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Fri, 22 May 2026 15:02:08 -0700
Message-ID: <20260522220306.235200-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b9292..3c2bf476b2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1820,6 +1820,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_AIEN              (1ULL << 46)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
+#define SCR_ENFPM             (1ULL << 50)
+#define SCR_TMEA              (1ULL << 51)
+#define SCR_TWERR             (1ULL << 52)
+#define SCR_PFAREN            (1ULL << 53)
+#define SCR_SRMASKEN          (1ULL << 54)
+#define SCR_ENIDCP128         (1ULL << 55)
+#define SCR_DSE               (1ULL << 57)
+#define SCR_ENDSE             (1ULL << 58)
+#define SCR_FGTEN2            (1ULL << 59)
+#define SCR_HDBSSEN           (1ULL << 60)
+#define SCR_HACDBSEN          (1ULL << 61)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
-- 
2.43.0


