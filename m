Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB68E8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHN-0007Pp-Q7; Wed, 04 Feb 2026 00:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHL-0007Od-CG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:15 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHJ-0007sh-Na
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:15 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso148852a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182292; x=1770787092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+ljo4EBiqcI/xQh1EQ/nRta48pRai5ExjU9Hjf6JUQ=;
 b=kts4n6cxrqPtLqkROSvqgng4CTOf5YYM3dH4YRHGMJMKKxNhrKkndgXLtp4xlctolA
 ONh0dkdo+f5n4ae7h9MLHnRpazo460P4ckH224pCq1VJwPzEhAgnLcr3rX3BU2KT7EoB
 U6QyrTwswLJeKLsn9g7EDeo/l2K8YapvzbiD/aoxypo3ZYyMniCX2tVWyUwOSK1sYgkK
 fz5c0IQjnn/46KGDWE2+LOgpzGcgBkvIntgN6sLuuE1YB/8IDsyZeOtnpgH6/LRz78um
 u+rKjuX4PpiaRwREgsKMA/hJVffm32QHI+pa7Szq/ht5eCbxyJCzVXm1shhrSVFreCMg
 9V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182292; x=1770787092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+ljo4EBiqcI/xQh1EQ/nRta48pRai5ExjU9Hjf6JUQ=;
 b=ZTRBj3nON5alFf14ODivesFEisPFHf6HZQJsl4R/M/YADJiOAFmTq1g1e8z30oKdNC
 9HNxKxX9z+hBaRsMsToYXja+YwVFeEPT+3gUhoGvRazp/YBlWKV8RV25amuw+UQJGV1I
 dykjR9bOsvGCi9clQ50GbE/ehgjYrP3h7gQCw5772X/U1eKWZ2Cm/eMCcXBFF3nO5XhL
 PxzngN8k+y5TBnT0ZH03v6DfbFJiUvgNbq7f5WcOXH2U3Fxyhx9bpfz+MW+5xHg5OlFe
 elVzfIwOn1d9io2kgudYjZGNjzAY7hCV/kJqeuaflbRNHu9jnCfxfJoiim/Ds+ZRT9jX
 1/bA==
X-Gm-Message-State: AOJu0Yz5nHYKtC+UiU8RoHJ6IwEQIR7u9AZ/3QcJnyKbOibftzfVtTZU
 ynBiaLdFhez7/yQeiCJxbkhCTc59NyC5ssq7luwkeBJeR4fNHYRrWwASi5SafUIa4JnZrXc2rCK
 f2Rfz7FjPKqRd8GiFP2c6aiwPIkoh+4LCVPVl/33Ikd6HGZkrf8lD08oiocV3kM1EXpFTdL4KO5
 3oL5cpqDS5rOMXu6lRcwNpoVNgg7EJ2UBVNiMShtEtDvbp8SM=
X-Gm-Gg: AZuq6aLSegOIDec3iIZzEU9pAGEHqFqFofXnfe5U+6hQAL4jkf0Of+0oSCtD5y3DkBb
 6IvoBeQxUzk/G91LdFulQj3DhZyk1CBF8zjPCAOGpxdBPoh8eglhojIdwb9v+ONUj3xWcU0P8OX
 H8mRf10sCEERJTf9EIsKd/NEddPH0i8uOGewWJW22b4bJLbj+w26TG28GQll9ec/Gb/ynjVBjkh
 hst6EpysaKxd0a2j6WfsnvbMUK+QZnuXqy8svD6PCDTyP04Y+R4M99ywngTVBjDznHkPTKbo0SB
 G2VxNDSh6AU9YvqyqpDZDldW+GYX1/kiXBppeBAnerGR43ChgWjkUH8BL3ZBJUIYBlO7N40hV3I
 +CNg2yckEFQeMoyeELFCuVSsMMH4tIYnAgMNSng+I7XYTcMFr2JP0hTgj/fTp/+ROyuaGBB9vdu
 QtfDW0NG4hcu7BDxa/sl52P/iYt7Cf3fV2WyU9Gv9qgWtcLvRDtUDo+YkxQa7h43+58pdECqhxO
 YV2F5tNzoTF8q8e2Eq4cFDsJw==
X-Received: by 2002:a17:90b:57e8:b0:354:7d6b:1d70 with SMTP id
 98e67ed59e1d1-354871e45ffmr1468385a91.27.1770182292266; 
 Tue, 03 Feb 2026 21:18:12 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:11 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 03/19] fpu/softfloat: Refactor floatx80 format NaN
 classification to share code
Date: Wed,  4 Feb 2026 13:17:39 +0800
Message-ID: <20260204051756.667397-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x542.google.com
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

The floatx80_is_[quiet|signaling]_nan functions contain duplicated
logic that should be shared.
This commit introduces floatx80_nan_is_snan helper function that
determine if a NaN is signaling and change the return type of
floatx80_is_[signaling|quiet]_nan to bool.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-specialize.c.inc | 55 +++++++++++++---------------------
 include/fpu/softfloat.h        |  4 +--
 2 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 7d2515c1fa..9ed968c79b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -357,53 +357,38 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is a
-| quiet NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| Determine if a floatx80 NaN is signaling NaN.
+| The MSB of frac differs from the same function for other types as floatx80
+| has an explicit bit.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_quiet_nan(floatx80 a, float_status *status)
+static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return floatx80_is_any_nan(a);
-    } else {
-        if (snan_bit_is_one(status)) {
-            uint64_t aLow;
-
-            aLow = a.low & ~0x4000000000000000ULL;
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (aLow << 1)
-                && (a.low == aLow);
-        } else {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a.low >> 62) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
 | Returns 1 if the extended double-precision floating-point value `a' is a
-| signaling NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| quiet NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_signaling_nan(floatx80 a, float_status *status)
+bool floatx80_is_quiet_nan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        if (snan_bit_is_one(status)) {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && ((a.low << 1) >= 0x8000000000000000ULL);
-        } else {
-            uint64_t aLow;
-
-            aLow = a.low & ~UINT64_C(0x4000000000000000);
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (uint64_t)(aLow << 1)
-                && (a.low == aLow);
-        }
-    }
+    return floatx80_is_any_nan(a) && !floatx80_nan_is_snan(a, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the extended double-precision floating-point value `a' is a
+| signaling NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool floatx80_is_signaling_nan(floatx80 a, float_status *status)
+{
+    return floatx80_is_any_nan(a) && floatx80_nan_is_snan(a, status);
 }
 
 /*----------------------------------------------------------------------------
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c18ab2cb60..ac6a392375 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -978,8 +978,8 @@ floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
 FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
 FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *status);
-int floatx80_is_quiet_nan(floatx80, float_status *status);
-int floatx80_is_signaling_nan(floatx80, float_status *status);
+bool floatx80_is_quiet_nan(floatx80, float_status *status);
+bool floatx80_is_signaling_nan(floatx80, float_status *status);
 floatx80 floatx80_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_scalbn(floatx80, int, float_status *status);
 
-- 
2.52.0


