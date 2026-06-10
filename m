Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B89CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYm-0003vi-Fl; Wed, 10 Jun 2026 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYi-0003h9-Ky
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYg-0006Zy-MM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so77046995e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108017; x=1781712817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jN+G7kW7HtjYl4CpSe9tEzemlao0jVQgi+tpXzHZFao=;
 b=radEHNFWjxCbrRHJz+ih6mz+nKJtF6rPMQfhvaKOpU2jyIa2uFXZYGgaiApMe+UJd4
 hXrDwFzOx16VcqXQh6kVjnD1ZHD2+lRuiX4s0tlqmFn8HkSsjHud6+Opi7JiZ9cDVWzT
 ToJhN4osbvgW2jh9fTqRg1NTPFkkCb4t5KuPndxWu6B+sTfqGDa+fDnTcOqYxhUnWeQ2
 ERctOoqll9ksuL5WevjgbE7K0ZOIcTkANcX6KTEVd63kMDgNzShn8CR6/dQJjU82JhOy
 6PZO3VtpcS7V0IIEQztZIwcn4v3Gvyz6YxPGf4mbqZUTsGmNgAqVzl2ah8A1D0XlFk1U
 FE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108017; x=1781712817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jN+G7kW7HtjYl4CpSe9tEzemlao0jVQgi+tpXzHZFao=;
 b=Ns6pIehkJEVqcnpUPdLexpSzgwPq0ve6OYQrzaDPjVb6qVcjKZHlyLUtCucF6nPnoY
 PxT96/s3mTeEQ03RVgND1YL8g/JpkkETmzEo2ny6Wlh/wsdcIMzGGjTREq3b2saDVAVE
 sDZ8HQnWqT30jGoCNS1H2GYnbcwVIKGCufqH2hpx6ir4U0q8v4RpzDyOpGNcIcl7EwKC
 aaiIsb8mVKvrDIKhxPp3TqH3enjikbfGue+xQkzhAkyQrjPnoTz9ZnWkWJxWsUcB+mHM
 vx0Y0UEgzFe6eO21i+ZeB03O+8J5Btvlvm9hDzkvho6o3jHtwzbePQP4cVmx/t7DbIig
 bkUA==
X-Gm-Message-State: AOJu0YxJcHMETttP5jCcnleZCirxTVTIyqB6mr+ASYGzRWyzZyI68FbX
 JnTn9jfcMyGWl+LEx1GwBsas00XsokFfsL4/E3YvuXUQJIUVB2kkfGuEKUqfUbGHewKNKGXvmF8
 9j7x1
X-Gm-Gg: Acq92OFxJYXRamASxgaQu1yLSKD6lhWv2yW7OTmtGSGdXYKtHhJW40qjcaECq5QxxU/
 TQsHsK4fnsgoz2q4SHQ3+VqtRvR4klBKxC7N7QpI7aPrymeEigJkyb6hm6kmUWfAhuqD40tjxQw
 kDf96kDcCYXP7MbSBQBVvsAZQ1pqWorBtnLZZkppMURK6kOo8mMLgr3Pi7ecCxC3MBg2HnkSr/i
 4aXJuVZEhPofxiCUPig/8RrA73P3+fwa7diFSG+uJQXG4QzqNA7TddMFRhuIHlpwKkzahNgwVvi
 eUrlNNgF9mVnQcCIq6f3e1SklyaoJjd7MbR/i5xK480rYQVhieAKfmxNDo6jmjRzaVUzdmkqwIE
 i2JVlCW1NuPw599Jou+E6AZv34f4yvXwCGGesNIK5c/PdjjkVIuT/bw8/QmlNzH3/OHMAjSv9tI
 JklBAtFpoWXo8Khur5DEXynAuX1G/32vPQac6Mb0FA6nf6mFhaph8rE4sY4hUmP+3FEqF2o/kjB
 1Q1lF6bT0lX2ySQ9Vm8BVbj/Qz2riBxtro0dbKhy2E=
X-Received: by 2002:a05:600c:5248:b0:490:cb90:3e00 with SMTP id
 5b1f17b1804b1-490cb903f1emr268505775e9.14.1781108017275; 
 Wed, 10 Jun 2026 09:13:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/71] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Wed, 10 Jun 2026 17:11:59 +0100
Message-ID: <20260610161202.2235298-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-43-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0bcd707fc1..56da6baed9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index d40e39169b..7864765ba0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -171,6 +171,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
+    GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 3d73977f1e..0f2ce592d1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1404,6 +1404,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
-- 
2.43.0


