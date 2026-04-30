Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C2FFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9S-0006Mn-Sf; Wed, 29 Apr 2026 20:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9Q-0006Ld-Pi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9P-0006BQ-2i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so333706b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508466; x=1778113266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/G6a8pFSVWZ7UbYRPC/FgRTYLt4qcDCTU3OgJbrV8A=;
 b=enrx8kAhVmRqf8pWcKAJYDl/cOTrNzGHS6xl0qMqmJ6uoRi7lUr1ldfYfVsxdlEDee
 NE90bkSQ19wjeNu33AmoiM3iH2VC2MJFvl3zsf5Sqe+GErowxuA2TNSglGByJ9ohFqAo
 7T9EtUasBpkc90FRKPgMXG1vQt4+oATeYNiwCn5/8c+QNZBUv2PzYUXj4+nvyjbKGVWP
 +tsTeRDhqQjocGECTzba16d8MUckvo4pMq8C7ThzLmFHFC6M6R06tH1uwp1PGnwFKdtn
 Vhni5GAFOLrhH85868ZgdciTeYNfMpP59cYtDrMoCqiu4/mOQ6rRWoik95dIvzynvaT6
 pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508466; x=1778113266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/G6a8pFSVWZ7UbYRPC/FgRTYLt4qcDCTU3OgJbrV8A=;
 b=gZ78AHUWXfdFCHqSntY4DCAwPT6m+6OQgFwyzEkfN/XkItrFV9+1TQG+pY0RVgzLMK
 4zSy3Q7cU/L61egYWeM7cCIXsBfswK1bfh5OT27d5fj51qeIg5N/uHo71OPJWK0vBXgL
 0rdMXBQNMd+IyOF0WxTjLW012ob1Kf4nmk2K9uBM3QujdgMU48ysJcCxT7NrxabkSZf9
 GpnTe9Bb5X/0N12KB9FRe2YfjH6w7KRkReI5FJy53ieLA98OK1YvYDSkGbzQHJDtm/zR
 967Dn3Dl394Li9zDxs4x1R+S+QNtkYgz8LpIU5x4JgrQaW9r1hFVjL292MvMxVJpQR+e
 vjRg==
X-Gm-Message-State: AOJu0Yzy93fM7hXjCnXr4h1rcO/U6oMS6rnEQfF30b23I37MHSh/ICL3
 OsaB6sIQhnwCjLTu3djGeVFOopSp+H9FES8RCKgV1nx/hzGNo/QgkYgaAAAIJ7dQW1iJdMB0YHE
 D//KYyGo=
X-Gm-Gg: AeBDievYQGYCekFPCP3rmxL22nSNIYhFJqcXVWY7zTR37ycsJr+bJe8VFso7ATD3kTA
 xsSPT2JS8bsult9u/tE4oDK4sp119zceRtRV5lfLYUV4RfBR32iJ97jVdWUe0jgvDmywBskHfah
 sWVgVURcaMRLBxXYm7a5xon++P4Duz0rQxJmqg2mNxKmML3r2FNEOX0RLtX+fYAtadRG8nTeo2V
 K7gPCVQrImTWL10X7tGmRLGC/ibTZI6ZmMjAZzRNuWCk9ISVh+hxToHG6tHEjuasNL411NUTQCQ
 X8YbgxcFafuS2ipnev/aD4E+dQUPrL3YsJd9KDGF0cSZTonc8VCHg2TPkaYjIiQxBj5wdRUiLIl
 kn2mD7H4zWtUI2/FgPFOEm4/dUoVLZBwy63jhmK9NbV31BEQLpJb9IYOboqItU3GDPdBSacdS6a
 x8zs3v+LTVi+vlH6TQCncsFEx6wIobjyEHnn2kuWu+Mdkcp/9KCKc=
X-Received: by 2002:a05:6a00:13a9:b0:834:e880:7a21 with SMTP id
 d2e1a72fcca58-834fdb4bc01mr887105b3a.18.1777508465629; 
 Wed, 29 Apr 2026 17:21:05 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 06/47] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Thu, 30 Apr 2026 10:20:05 +1000
Message-ID: <20260430002046.59739-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index be14a47c35..da1b7fde1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1796,6 +1796,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
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


