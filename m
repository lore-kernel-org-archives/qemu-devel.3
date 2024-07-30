Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A33DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLP-0003tG-Bh; Tue, 30 Jul 2024 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0003mI-Ec
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0000cK-53
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so2289766f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332429; x=1722937229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0t3dw23LYO7KaJ6voFBl2V9URgkrKmEjm+VodO24yXE=;
 b=G1DZrjxEx0hR/Re43a/s3hVE/4zF4zqBb9mujMooXCK2GqfBhjx2wKQBb8fRpcxr3m
 SNidaAUX3gzplGfLYtKp7rPqlFJlhF4qCQxyrxt+c5ASNQ6lKO3K0IlzUHXVql1zWsQG
 wBicXxx0X3Ssb8JJsDZpat9+LiVJryk/gefu1L0Eh1LYIuZxqJNszyNP6+5YgcrIliYj
 b+IfvUjOSyUX+Eqn3WHIyvaGtj2wIuO0gr/RVVF3n3A7fjXVZ37qp9tU9vCqclecN9U7
 vdPnXDCjp4ji6QAcK9avj9OZ5eAj2XJLS+3925RAdOrG07HiXHp6PWGZJAmmrvmDkBaC
 /f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332429; x=1722937229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0t3dw23LYO7KaJ6voFBl2V9URgkrKmEjm+VodO24yXE=;
 b=K3de6EuOEQGwLKlvsi9JPU+NAdtD8NV5a60kfqlc5a3jXSJi7cwgOAc8cj3QcyAep1
 FoH45bDCGq2Ks2odR6KIY6yrZx9iKjLgI2+mwGEIOOB2BvL7+6lbdF+i+v/1nL2pT8Vf
 HbCRGqF5G/+2tSKeh0DRXc881HpdlqraJIS0Q3/ERc3A8c0pUJyC0Ni7e6mlvvsW7u73
 3D0aRgxoSdnHJ29Nk2Y4D/IaQCOkY9b9EZ7LJUFls1NKNCynCwVL1Lq6PbkFkQXwsmD7
 Hft/uax5RtRW+X3X+aLb0K5QajQJjFhNP7AJQ2Cr7UMgIOljYoPqmlLFMJAOIYYD8Bdp
 Bf6w==
X-Gm-Message-State: AOJu0Yx3UQo1tgypQz1V3XtTbz1U61eIrTcuC9vZpjh/MMTcJ6HXfS8S
 dEEOH7NReVrV5C2UtjsshtL+j0GhTuXiAGEe6ojxHSp3i09j9Uhdv/ed/WvsDUfQMdWQsT7GLST
 Z
X-Google-Smtp-Source: AGHT+IEnztkOL3KTo7g9KVqtcd7YlezJS/MHpbqNnO5dcvJBMGLWE5IEZyDktzTr6LTM7hO0jpzkJA==
X-Received: by 2002:a5d:4c91:0:b0:367:96b9:760a with SMTP id
 ffacd0b85a97d-36b5d0ae662mr6825401f8f.41.1722332429644; 
 Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] target/arm: Fix UMOPA/UMOPS of 16-bit values
Date: Tue, 30 Jul 2024 10:40:12 +0100
Message-Id: <20240730094020.2758637-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THIS_AD=0.899 autolearn=no autolearn_force=no
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

The UMOPA/UMOPS instructions are supposed to multiply unsigned 8 or
16 bit elements and accumulate the products into a 64-bit element.
In the Arm ARM pseudocode, this is done with the usual
infinite-precision signed arithmetic.  However our implementation
doesn't quite get it right, because in the DEF_IMOP_64() macro we do:
  sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);

where NTYPE and MTYPE are uint16_t or int16_t.  In the uint16_t case,
the C usual arithmetic conversions mean the values are converted to
"int" type and the multiply is done as a 32-bit multiply.  This means
that if the inputs are, for example, 0xffff and 0xffff then the
result is 0xFFFE0001 as an int, which is then promoted to uint64_t
for the accumulation into sum; this promotion incorrectly sign
extends the multiply.

Avoid the incorrect sign extension by casting to int64_t before
the multiply, so we do the multiply as 64-bit signed arithmetic,
which is a type large enough that the multiply can never
overflow into the sign bit.

(The equivalent 8-bit operations in DEF_IMOP_32() are fine, because
the 8-bit multiplies can never overflow into the sign bit of a
32-bit integer.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2372
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-3-peter.maydell@linaro.org
---
 target/arm/tcg/sme_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 50bb088d048..3ba826a6ceb 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1162,10 +1162,10 @@ static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
     uint64_t sum = 0;                                                       \
     /* Apply P to N as a mask, making the inactive elements 0. */           \
     n &= expand_pred_h(p);                                                  \
-    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
-    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
-    sum += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                             \
-    sum += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                             \
+    sum += (int64_t)(NTYPE)(n >> 0) * (MTYPE)(m >> 0);                      \
+    sum += (int64_t)(NTYPE)(n >> 16) * (MTYPE)(m >> 16);                    \
+    sum += (int64_t)(NTYPE)(n >> 32) * (MTYPE)(m >> 32);                    \
+    sum += (int64_t)(NTYPE)(n >> 48) * (MTYPE)(m >> 48);                    \
     return neg ? a - sum : a + sum;                                         \
 }
 
-- 
2.34.1


