Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32708CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPh-00085b-P7; Sat, 16 May 2026 20:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOb-0007AQ-Vv
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:19 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOX-0004op-C6
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c80227c9572so381123a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977810; x=1779582610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYsxgOkKZmN/D6H7dyuNYSLIwdX/Ih93Qf3lIcR+ofE=;
 b=lBZ3vjlfosNKoyEmQHAg4WFVZQE4OYnW61cHy2fBCnMU2wvai4fNgeFi+Y+OjMvMyL
 unFN5dsirqSUMs2JIfNmUFTJ3vjUH+M8njAxrvH1UxT81x4MJK4ZEPmf8FQTDfX8jSLk
 sGArC0l4k7edIRjrPID9/BjIE7kaYe/QxF4HhfjLodsa3Lm0/nqYLKbXPmb20B/XrIIG
 qwlx9rXmEHqsjTqP9l3vbEj623yMfHp76Y5MtIKACy3w0xzTjpYUFjy/tdnZwbE5Bolx
 dgN+TlCK55UwfGkGSGmhl0WyBTce6JFyokVHslIeOJRPndLj4AWPa8UFv6SFcOooVtiT
 RvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977810; x=1779582610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HYsxgOkKZmN/D6H7dyuNYSLIwdX/Ih93Qf3lIcR+ofE=;
 b=jPiOf3fHsL3sLfp0Rsv+ydtnOU/DioqTijeZzfz1DHeBo2gG/r4qlaobGG/H5YTpbe
 0/CGDNZzouE3x0rQT1f0ETL9shWq1AnfR7YIbeIy1Ae2BRI35y7DH5ZCP8Rla1BNBa3v
 pct338PePM7qV86QFwNPrB+ARF1alOmw6NEL41UStc3fcu4gPus2X4+o1pi8I0xmxO/c
 ablaiiYYYykGSQU+Om/+9pM8m59eC7EE1HQCjmpUb0mBpIwNTM8h98VTEHxGPIDcm3T6
 er73A62mJT+q/fXCaQDeXH+ZDdu1phFnkPlkIlIAY5Ug+8pRXBiE8fE4X36QvUpfjaYk
 eilA==
X-Gm-Message-State: AOJu0YzV++icRnyszd2b7SbDm8btw6hxH36t+Kd2Wvmhqw73Cfqu+APo
 quXxBbzrs2018TcilY7Nw6PEHOMwQA0XGTvuT16sq50Ob2KPg+0LflNL6xARijQgEUn0lpXB02U
 B3i1C
X-Gm-Gg: Acq92OFv2O4M11/4q8kiCsgR+BEF/QmX5JAbYkcXAR9c4wYDAhDmdg9/2Gi54gLglDX
 SmD7htozFuK2H5WFBjtxrtsANxuYKaaCwQMkewE1gJ8KRIZlkQAVT7F2KS9PmllAq7ZZaY3ee7/
 xg6DjWzajuM7TYMhIsFv29EPrYvsOaRxshK6Ml8nB4PZ/xjPpUH+KhI7eQQBMKJ8bsKKw6obDHO
 F2Xju6mcICqzB5AnQAnwhbH3/Hh15Sl0HmKvsvgM1z5GqS+9s+QZPFf8gvp4yV5C/6q6sdrM7ia
 WUDntf/4zXychtAlmzHcn8DukLGdlonw/KwA5em/rL0sqRVnSDuk+QdEvdhc5T8Ad/08xVo5iVJ
 46nr5RD6wHcM+R4tP2HtPeUR2dfGIq3eQgf5XhTcywVOOv7Cmtt4sHSHFVbVLizrgCdYBKWnln0
 qzJaCVLpDf/NvtHSN4RnoJO2smOzZf05X/AfsMmi0=
X-Received: by 2002:a05:6a00:2394:b0:82f:74dc:5f48 with SMTP id
 d2e1a72fcca58-83f33c5488bmr9867314b3a.2.1778977809933; 
 Sat, 16 May 2026 17:30:09 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 07/63] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Sat, 16 May 2026 17:29:06 -0700
Message-ID: <20260517003002.321430-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b9292..0a11dd9002 100644
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
+#define SCR_HACEBSEN          (1ULL << 61)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
-- 
2.43.0


