Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EC9CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Op-0000oy-DS; Thu, 07 May 2026 19:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ol-0000k2-QR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:55 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ok-0001EE-1q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:55 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d55b97f358so999020a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197492; x=1778802292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=Dv3IdSY1k5/NR0ykl6Ia41r6byNzzT5aL0yGJHZSDx5jA9BGp6UI9hpmxQCPCYwybU
 rBE+1ZSbPvWzGa6+ec4qER2JhChjoDsutPY0RXotw9mcpWubKh2fh/D4zk8JF5LVrD26
 Pv/+uofnEPq4PpDuRsckYVvFL7jg+1ub4Xt7AJUlZjQFAZ1B/8T0Bv7ugFVdWWiddmK2
 AjTvl57bqF9d/iViItsvxT+kZS7PPGSKsvOhUDopMsZ50ORkDIHnej/5u+1ITcc/jI4h
 pa2CemODpu2BfjLwaoUzAIqTBy/C88gDj+iaLe/BLeP+9HpZw9lkfFkkcbLii4xaB9s5
 TKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197492; x=1778802292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=HZYN6Tj/Dy07Y8HldtUJVTJIY7KFl+c4LFWIcMjYrna3ppTKdEq4a5AtOLsBcgT3R9
 vfLn0ueyi6YRVGq4sozbIgc8xGsEUhlSX4nvHFpzeaSCE+mcvkYJI/S3M6UFlhjeo9G4
 Nyf+1FGs8GlzKpzLz5fwTx/kHSzTP/SeoMsdk9Ar7lfDL2kxJdDZFnaoxyXKjyKMUj6K
 /Sm0JQbgxl9U6ujmAo4cPbLl66OpPyinig6ZyOgnW61pv8JmMs7vB7ujCgoSlptbWEls
 s95NkbxyHz6Y+ws2rJPTVv7+ocQBNEZHmyno28hFEWcZyEv20MuG6ZSPZqQNDO9bWtUW
 6x/g==
X-Gm-Message-State: AOJu0Yz0l2pAo5qyLP22CcRTLyT7MPMLMGszx0rq1Ay839yQyo9LnYxz
 AX5Hn4pT4n+tqszywD4FUVtUJ9bGN2n8Hj6QKDkmZeyHvooYMbVy52V157d0SeNZfLqV0U8OuYI
 gyZXu
X-Gm-Gg: AeBDievBUf1J6thO1lT8j/bLhxEIKf9PgC8hADd7l7Onem0/s6gYaw0y2axVc8NK20o
 WwJbf4FdAzdZbZUtQCZh6uDMiBdyz0toyWg35a3DObvWr6Kda7EFKEMMfgQbv2xtOr46DKY1u/N
 BhrIzCzBebXp4wz1kLsfzXfWKsrxYeXnlgrdNNQQGUlPT0QBK/myCnuvFOe4ETRVNyOohYdXpSR
 z81P5gSeR3Il/xXek8R/NnxIhsZC+diH72DSiTPyjQt+iRJK2+BVzUGIF3zlXtiCUr3dDXSgOaV
 1PhOYfbaV5smJDrBVithC1CwHJ9xLVUfgEPP6nHl4TxL4mIHEttVPcVCidbVHF+NGeMpdM/4s8K
 a/cQzJccx2FoFhj+zQBW6hm/9DX2OXh+kFs+eKr7Ebr2ItnMNHk05opcHpZfOEum7CtWAsCsuEE
 8tDl5RfWNi2qAt/Lvo8Tqr8tWavS998oXVMLUUAHkFTtNvFQ==
X-Received: by 2002:a05:6830:82e5:b0:7dc:d951:9766 with SMTP id
 46e09a7af769-7e1df20c283mr7010220a34.28.1778197492434; 
 Thu, 07 May 2026 16:44:52 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 39/60] target/arm: Enable FEAT_FP8 for -cpu max
Date: Thu,  7 May 2026 18:43:52 -0500
Message-ID: <20260507234413.643512-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc866c5a67..8d0c057902 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1391,6 +1391,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cf8771d541..b6f0ca9351 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -74,6 +74,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


