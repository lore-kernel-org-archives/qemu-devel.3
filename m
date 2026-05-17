Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DD2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPi-00087Y-Lt; Sat, 16 May 2026 20:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOf-0007Bd-LM
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOZ-0004u4-83
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso476864b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977812; x=1779582612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgEwye1A/H/zER4vq4nD2iWWcMLX2i9wMfampUnYlVM=;
 b=xkZRRbSvQg5w5OK9gcNyWrsF9wjLRkbYSjQcKvrphIP0r7pOQ+yqb47rFdVdpsO+Py
 hUF/UBKBaBCW8ZlQbJ1EvGB3DNTIWNsvQFC9n37If8OTVtneRVJcWtemTnIzwZql80v8
 ovkNHFbV9miu6tK7M7W4ni7N/F1l/NDHpmZK4YmBk9U5CHRoyW/MexJPxLRFLT5+lEMr
 DXBn4wUr5xbUU0V8pmPuyBpvPBbqq4N8+Q8XQQHXOr45+BuDBA/SIPoB+RS4LzwVaBHO
 2OmjhF21NGQirageRmCWBIUzAT1BNGPF8z9R00Y5YZmGRAEJ4C+ZQtI1llIMC5BTXQac
 AF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977812; x=1779582612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RgEwye1A/H/zER4vq4nD2iWWcMLX2i9wMfampUnYlVM=;
 b=f18SiUsC5kO8YH0krVaYE5PdhiNCRqZQd+sU7XcvVMY8uv4lurX/PJJmsw05XvlO0e
 R0z5R7R4QfoYVHRLBfVtRmLOKEZW2rD/93g/Vu+OLQ6WyRHjc5s3dCnqKJ47lZLuBqyw
 xgPY1ZYSjcQRUwqQl7nSTdQx1w9MdAylXbtueGGMhTvmHb4D0QiNr/9sJMgHJv0bWd0m
 Ef4aUIwZ4qokpprIRjDCNn51jn5N8qLnrYQItnFh72K6I4KcqiyreT9RNEc6NW60Vpvy
 cCM88Ul16IgOzDdqkQmB75DqeYGQLrLwySsjfFqNjDyz/aIMdKEur+20aWWQlCKLq26Q
 gcJA==
X-Gm-Message-State: AOJu0YxZZM0/FfuYbwFVYEu/3xvpWegUy9RasOWXYhN7GXcXcGtShPS8
 bl1MJbj7qL7k+LWqVHEM4RVzTxfZkxMRZ/HqPbQrmMWtDS/aNVFPuKpjcZdtnh4elye5LRdGPWN
 +14F8
X-Gm-Gg: Acq92OGkrVhOjUnEMkwPmufA4QO8D+TKt9zElYkNgfERIYaNABUToocWiSrM3SbcVn0
 gPbQpNX7xWEMAPo/FhsmxDJIdtNucEy9oerdJ9DboZ/XCzi7FaRzrcQpMyyPhRFm+trqHu8TQOD
 vs7cj7WuwM6y5wfxE3m+H9+LcXE5haNzfpGiLxQxe99EcSzuAoQGMQSM0jzGtYdHaQcqrh9y8sn
 vSTlKTy5YKIWWBl1Ltax+uZHLUZThahRRLM42uKAm/UR4jTh9jRjekGrILnJGMGp4A6Hg17ktrU
 UoXe8QqVQ6py3ABEwmprOy2z5H2GH7coMyqkXXJKBfw5+i/sMqIKVxsVeIVmEqPqLJF2d3/sk/k
 Oejzcwym1HNdDIXHCJVIvLibgdFs4nypdonDnEUX9iBT9JvK6XAG0FFRWGDij6V1KJ+Al2RQRDb
 IZamYVQllulvNMWBtHHolloAP1CZQA
X-Received: by 2002:a05:6a00:90a9:b0:837:e9cc:d470 with SMTP id
 d2e1a72fcca58-83f33c9ec67mr10243679b3a.20.1778977812207; 
 Sat, 16 May 2026 17:30:12 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 10/63] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Sat, 16 May 2026 17:29:09 -0700
Message-ID: <20260517003002.321430-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 498af7db08..c114510446 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1485,6 +1485,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


