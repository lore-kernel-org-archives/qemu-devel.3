Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FC0FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DE-0001P9-Jq; Fri, 24 Apr 2026 00:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Ck-0007zC-70
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:50 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Ci-0002zH-8P
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:49 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so4232594a34.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005107; x=1777609907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n7fQN+iJBwqx2ETIvTw92Xcf+8pXw422MS+4i6nNsM=;
 b=EkJa14i6pPUh2dl/Ka0LqHrkVMuN8yncHhPwRBqpm0sRccvpbS68HNgASK/GRKKt/a
 Z/UuZ+2oaH+4bJRad1a3sUFc6srbX3gmwg6DqCJBu2jUsJ5AT2vGovjZ99i6Y2cI8fAQ
 FK1v2qeW4uhqiSsOwj8GGMqowUC0jRNXAb9bl/QSS13DPx2dXubKp3UktgVSz13CIglt
 j2HOF2RmPjWYh6jotUqP8zfU4F5QScu2SWxVaFQRP04Tbcf0Pv7vIsiMwuNNoq+ew+WL
 S3k4KQBGI/sX+tR5+858FHaicvJetnWCkiNFql5SI4hw73wSGGuZBn+XUI7Z8rB5xExA
 MS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005107; x=1777609907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3n7fQN+iJBwqx2ETIvTw92Xcf+8pXw422MS+4i6nNsM=;
 b=h6n4jAigEd1MquDGRDfjJB96xksneXodIa9+ZA6n8h6Nf4lvpqog4PscnVHlSPs33W
 zdshFnnXvzVQ7mzCI7HNdSyJrUS8kW4dsAZ3RI7F4oYPzEkXoUa1zJ1dOlR+rdh+oUfs
 x34FomL3JN2GsnhIctR2qtZdOsrTb3NkyaEu46MGAgFGXvg9Own9An2AqzdZs3PyhGR5
 0zcD2xbOWf0aJhXlXhiiKFNCNl2eAG3qbbOjBqaDQOfUesF092jlIREkDoLKcY8aVUDE
 RGvMgEkj7WzpB5tghAMmocwnDHPmWQFqEw0Ik3PwpAomX5dtazz86zghB6mrXbxI+FJY
 29HA==
X-Gm-Message-State: AOJu0YxJeRIEsvxsfRrFOGxiVB2kenmrjon58HaLkSsTretRGzJGs+gP
 /nQXWAtKI3e3Fut+kSaHkw/csRWbdFJARz0IVGK3bUoNFwcWDAPlW/W4ATXsWfwamvbVYCLMJ0z
 tQRVu17M=
X-Gm-Gg: AeBDiesOyKpWOnXjtyTxQTgxFqVNAmocLtR9tQxgxHAKq64GfITpxfF1n0B3DVBfeEM
 21aC8aJ6fWGhreMtwTPn5g4M23D1JF6xxJKH1U+QnfMkZYU0QOvyY8JzmkG4QyXl0VO2UHWjqGQ
 r62my7ufSDQaFA7fDGT49Hkl1DEtjYNQlTfAWYP5ZHt5z2Q+dXuviIby+xN8vxWXul8K53Q8oMA
 ZD/wKcdTfNwpMA7YeXnuoW/ldtZGYUMNxALskPqisshNjZkBS8PWtawyV/6fkLP5cuwPnNAiDQV
 OI5D13Kz5tpBnhfAXuL4DgQw+9cu1kKXukBrTkiFAMITqtAHHIoLOhaq/PZpBt+pUzCUcSGvuu/
 oQHfJ37hxGDJFNaShn9QZA+JhcfRvHv0fq9ECs016zebFe9GnNiwSXqeZIKhbUKBJ8EBmm6v7wG
 HDWI4YJAilr5C5mkNP54EoUlhu/gTRTQQ54/Uv3XB3wxzV5ov7WpbkdxZfuaIFR2H3VbQM3wbJ
X-Received: by 2002:a05:6830:82cd:b0:7dc:d0e3:5bc1 with SMTP id
 46e09a7af769-7dcd0e371efmr10508695a34.13.1777005106722; 
 Thu, 23 Apr 2026 21:31:46 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 20/40] fpu: Add conversions between float16 and float8
 formats
Date: Fri, 24 Apr 2026 14:29:54 +1000
Message-ID: <20260424043014.46305-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
 include/fpu/softfloat.h |  8 +++++++-
 fpu/softfloat.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 6f86848b7e..70e25fa811 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -196,16 +196,22 @@ float128 uint128_to_float128(Int128, float_status *status);
 float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
 
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, int scale, float_status *status);
+float16 float8_e4m3_to_float16(float8_e4m3, int scale, float_status *status);
 float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, int scale,
                                     bool sat, float_status *status);
+float8_e4m3 float16_to_float8_e4m3(float16, int scale,
+                                   bool sat, float_status *status);
 float8_e4m3 float32_to_float8_e4m3(float32, int scale,
                                    bool sat, float_status *status);
 
 bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, int scale, float_status *status);
+float16 float8_e5m2_to_float16(float8_e5m2, int scale, float_status *status);
 float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, int scale,
                                     bool sat, float_status *status);
+float8_e5m2 float16_to_float8_e5m2(float16, int scale,
+                                   bool sat, float_status *status);
 float8_e5m2 float32_to_float8_e5m2(float32, int scale,
-                                    bool sat, float_status *status);
+                                   bool sat, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bcec7d38c8..013b6e1ee2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2958,6 +2958,15 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
 
+float16 float8_e4m3_to_float16(float8_e4m3 a, int scale, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e4m3_unpack_canonical(&p, a, s);
+    parts_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, int scale, float_status *s)
 {
     FloatParts64 p;
@@ -2967,6 +2976,15 @@ bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, int scale, float_status *s)
     return bfloat16_round_pack_canonical(&p, s);
 }
 
+float16 float8_e5m2_to_float16(float8_e5m2 a, int scale, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e5m2_unpack_canonical(&p, a, s);
+    parts_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
 bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, int scale, float_status *s)
 {
     FloatParts64 p;
@@ -2976,6 +2994,26 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, int scale, float_status *s)
     return bfloat16_round_pack_canonical(&p, s);
 }
 
+float8_e4m3 float16_to_float8_e4m3(float16 a, int scale,
+                                   bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float16_unpack_canonical(&p, a, s);
+    parts_scalbn(&p, scale, s);
+    return float8_e4m3_round_pack_canonical(&p, s, saturate);
+}
+
+float8_e5m2 float16_to_float8_e5m2(float16 a, int scale,
+                                   bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float16_unpack_canonical(&p, a, s);
+    parts_float_to_e5m2(&p, s, scale, saturate);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-- 
2.43.0


