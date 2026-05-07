Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF05ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S6-0007mB-Gh; Thu, 07 May 2026 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rk-0007D8-BD
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:03 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rh-00025u-Db
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:47:58 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479e6bc357eso595526b6e.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197675; x=1778802475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOxj2Q+DoRg1m2qRsmYYEc+CXl7kO95lm+84NlFi+CY=;
 b=hj+PIk2PWHWAS3AAxghPMS+4goMnKRfiS1/7JZYKMDrY4QbaFl73fsJwT0huq3SN/C
 Zozp8LEIOr7E63JGdC3cVdd1MENZ64d7zpsOcQMHMtSoYeoSUryhhhc6l+1sGeieSf8p
 Vj0Z0jOSqN1MJOF0C7D+ZXAoL8DYSNmJSHVxGFkihhO9yNpxsRn8OncU2b1Km+g3AEmO
 LV+x/BxkzQBXvStxZCjwRGqy31DLOQYQhRwbuCs+s1CAmw+NjN1bM1m4smtXGwgF8A/e
 BBQu4fsxEX6UIRJH4rPfZTdV4IW4fieNLTXcJXV9Jc3RH8QO7LlyJk1joghKtGzdB4vW
 vxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197675; x=1778802475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VOxj2Q+DoRg1m2qRsmYYEc+CXl7kO95lm+84NlFi+CY=;
 b=rFXZum1981QMiBNYF/7L7QHSTPMSBCj+JTDBiD3CnlAvgUkwhVY8tcgT7YLzZKb4Jm
 yksH5KKSft4a7HIfbc10Q+UOirWadKt1owzsfSbJj6TOPg5p3NlgQO04an3jorI+NIoT
 uJPIZYLnodUH71sScQb4wB7beGeUCOdU54GR/e82LZ81QUKdcfPz642BVivlhNsvX3P9
 XNymHx2bpJCngPUPnPZRjXjp9yjTQFWjrwpbZZYKaBs0dJaEM+oJQ9eB48bXj9QfaYD7
 CWl4t9GEd/3f3xqdRTbMzg3npIDTo1F3dCQr1Pm5SPNhAM+jVJjysumfyD2DO0EaOoLk
 V5PQ==
X-Gm-Message-State: AOJu0Yxhno/92wU0ZJjQY1Am8H6stSxVqqyaUOXOTYrKfl7mjSmMi08g
 qIdjZmJF47GC3Uj6g2ZP+A7ymX4IdII6LkrpXDnXIDyRz34e1lZkpUwKOLbnEsm75gVYYi6j9R9
 8jxoq
X-Gm-Gg: AeBDievts/VBP5f9RTHqA/wunzgt/hWVKYFM+vVWEZrfwwgnAWANDZToDWrlmf0aiMm
 lol/M0ZYWlsu9SgKqS1bSkfRGhGG5u0828lqD4gOtfA1QqGUzPMYs/6Jty5iintmKZ9tg10oGbu
 geDfEJIRmHH9kIcYDi1tL2MoWG/cUZhpvFxjVdNe6gJ4Rrjg48PIPzp4ojDPlP6M9HAvdTMIN6i
 737wt88/2ORJ8FxBy7viJhIWVfyfI2FT/mCVEtjTQTb+ejj6cSF5n9nYKfMjMtPlco+grx48r0R
 PI082PDt7fwsFsMvBfrp2NiFKgdJtSbFvPhvUhbpZtkQDuugXSL5vFaj76wk79uE656OjjZ0Fm2
 g1VBB6yftFH6DUvwJNcYplFpGxhE4RC/ln0KS80qSBkRJp6+mDDdZFTkLnKTCa6V338Goyehv3a
 IDmsC1gLUWA8g8OHUOJD7VnIzeM7NrkkOWMQz/uVk1mGdHCQ==
X-Received: by 2002:a05:6808:e656:b0:467:2a6e:adad with SMTP id
 5614622812f47-4804220b8b9mr4568342b6e.11.1778197674667; 
 Thu, 07 May 2026 16:47:54 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:47:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 40/60] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Thu,  7 May 2026 18:43:53 -0500
Message-ID: <20260507234413.643512-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 47294eb807..684d635433 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -396,17 +396,28 @@ FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
+FIELD(ID_AA64SMFR0, SMOP4, 0, 1)
+FIELD(ID_AA64SMFR0, STMOP, 16, 1)
+FIELD(ID_AA64SMFR0, SFEXPA, 23, 1)
+FIELD(ID_AA64SMFR0, AES, 24, 1)
+FIELD(ID_AA64SMFR0, SBITPERM, 25, 1)
+FIELD(ID_AA64SMFR0, SF8DP2, 28, 1)
+FIELD(ID_AA64SMFR0, SF8DP4, 29, 1)
+FIELD(ID_AA64SMFR0, SF8FMA, 30, 1)
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
 FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F8F32, 40, 1)
+FIELD(ID_AA64SMFR0, F8F16, 41, 1)
 FIELD(ID_AA64SMFR0, F16F16, 42, 1)
 FIELD(ID_AA64SMFR0, B16B16, 43, 1)
 FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
+FIELD(ID_AA64SMFR0, LUTv2, 60, 1)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
 FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
-- 
2.43.0


