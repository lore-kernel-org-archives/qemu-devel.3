Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A859AD690F7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbzV-0001xC-Sj; Thu, 28 Nov 2024 05:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzT-0001uR-FK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzQ-0000Qa-Bf
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:19 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382610c7116so502721f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790595; x=1733395395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOEO9KTfNfjM4NNmDftZ94Iu5DxbBvsjabJVOrSGkdQ=;
 b=v1Cj6jut/p2F0IxA6hJ4P4H1k+uEAx31OVT7VhUIKciDTgdnS26zbIjdACa2npQOVU
 /PJ5hwT+Q0VIQ3ZNAdOH9NLIDPHEV2HO0F61k69scqry5vBSRMPnFHUvrhz9jEeOSVt6
 qMU75wyGf/C2BTRNTiFCjD1AdLZg1RqAaHx2e2zO9QbmIxN2cThgfInXOYZEq4nudiDK
 zcVy5wyJFk2Z6kMvCaY9ZFjGd2jKECc9T6IlBbqrIwZr/PdN9GneG6djITjFYxvfA1sn
 xZGdklOiIZ9+Q2HAPrKtofSdM2+KiuYDhspHM/TrGxIYpwBnK2kZ2ZLjs93DXnFRtj3D
 PtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790595; x=1733395395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOEO9KTfNfjM4NNmDftZ94Iu5DxbBvsjabJVOrSGkdQ=;
 b=LujJpz3gygtPmHehzgnsDQP3t7q2SQ4NNLrStIQMbbxEoQQ1nkctJaeVFpeHkEiIuj
 rPzYyOAoW1wHWOsemjqKq7pJZDXNYxIA6pRH1FyHGP5X0ClwTh6Z+kNYwknWqmCX/T8T
 pxCV2bCeRbpudAgcIdGZEdc3Ct9lnZgT9LcW2fm8bAEDX9A8L8s6ZOpfm0plnVt0v/oO
 jh6ixRB7QGz80p2aasTEjf84GVGHqui6+61vjcIFkoa3f6Ehs5L3/C98UETXJMYT003h
 Wa4EvDCW+075gE07EpoQtQjVYEhDAdahkn1hCp27HUfBoeAtd11zlyn3xrWeVE3RwI1T
 JN0Q==
X-Gm-Message-State: AOJu0YzXTqDLuuxMYA+zj/+QwW4Z7is4nHwxJoO7Yf9ZeOcnQ0qr+XFA
 8S9entiAGgnDqWS1Yi5UaeeRKky3Nzane4PiX/XerxhYXrV48x2RUrAIMBoXexEatALHbyovO6G
 u
X-Gm-Gg: ASbGncttcZkAjyfXm3e9vmKr93dGPp0WD6zectQQHylCHHCaSwspHOK8nQq9rvOyhxw
 cmpSj7P0Er9V7Zc9I0BHegAAD4MtAgnu0NMqAxj5HUaYUrL4RodLvuMdN27IDrdNUYYs5EvjDl6
 OXpQyNcyHApEjgYJlApyxZ3yIdxQG7nFJnBTzd+SMX2b6d/OMWNuJi5f+7wOA1rrcRgLNiAwdOI
 JCBQufPDuB47Fx2G+cx/9SmNQL2+X8wFjq6fytg0VzNuHp6+We9IMA=
X-Google-Smtp-Source: AGHT+IEHV2k+O/xTAwFMT5IKBm3rjKsR1oFixoePTjRIgioOUVa39hCCEWN6/3kQ60QTDkyvzGk3rw==
X-Received: by 2002:a5d:5f86:0:b0:382:4a6c:fdd4 with SMTP id
 ffacd0b85a97d-385c6cca1edmr4753490f8f.9.1732790594521; 
 Thu, 28 Nov 2024 02:43:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 02/25] fpu: Check for default_nan_mode before calling
 pickNaNMulAdd
Date: Thu, 28 Nov 2024 10:42:47 +0000
Message-Id: <20241128104310.3452934-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

If the target sets default_nan_mode then we're always going to return
the default NaN, and pickNaNMulAdd() no longer has any side effects.
For consistency with pickNaN(), check for default_nan_mode before
calling pickNaNMulAdd().

When we convert pickNaNMulAdd() to allow runtime selection of the NaN
propagation rule, this means we won't have to make the targets which
use default_nan_mode also set a propagation rule.

Since RiscV always uses default_nan_mode, this allows us to remove
its ifdef case from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 8 ++++++--
 fpu/softfloat-specialize.c.inc | 9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d63cd957a19..aac1f9cd28c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -77,9 +77,13 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
 
-    which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    if (s->default_nan_mode) {
+        which = 3;
+    } else {
+        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, s);
+    }
 
-    if (s->default_nan_mode || which == 3) {
+    if (which == 3) {
         parts_default_nan(a, s);
         return a;
     }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c557c41b2af..81a67eb67b5 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,6 +475,13 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
+    /*
+     * We guarantee not to require the target to tell us how to
+     * pick a NaN if we're always returning the default NaN.
+     * But if we're not in default-NaN mode then the target must
+     * specify.
+     */
+    assert(!status->default_nan_mode);
 #if defined(TARGET_ARM)
     /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
      * the default NaN
@@ -578,8 +585,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     } else {
         return 1;
     }
-#elif defined(TARGET_RISCV)
-    return 3; /* default NaN */
 #elif defined(TARGET_S390X)
     if (infzero) {
         return 3;
-- 
2.34.1


