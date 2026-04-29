Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9B2FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMO-0003UQ-HM; Wed, 29 Apr 2026 18:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMN-0003N6-AT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:23 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDML-0005Jp-Mj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:23 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so132104a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501580; x=1778106380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ooM4YOoPsN++vQGnPI3dfYk4TOv337raCoMBlIHrQM=;
 b=x8FaUl9Lov6mSIof7IqE1gCtFRXS+eKnI4ZwjIXS3YQuIR1+WRMEPpPobMDwHOX7rp
 zzgJZ4qFGbI0QFOWuQi2FpQfEe4cxdLuiGXpqRymQnst+Obv9v91Thioaif4dcad+vu0
 XaOW6kNaW4OoQyoWJbd7+kLERIfi7/umzon7jMs3u0jwuq9j353sAhCQryuRqloYCfcy
 HyOUlA4GMpUJAdv4tTxmwMJ/r/IbMNF6LDnA12d0GiaA8OcpMtd1b/LNAb2IleVSAPL5
 iF74ibRQ7EijiooOe0DUmXFvVYYj12F33uIwTgdEMIU6Jek0Pm4ESsA5L1AGn0/7TdOh
 8zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501580; x=1778106380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ooM4YOoPsN++vQGnPI3dfYk4TOv337raCoMBlIHrQM=;
 b=L5ivIAkKJS05ST+H+vWzu0/vgfpINjsgfPLwIdBlkxasrHppgDdvWgctfjatrHd9S4
 rC8C/D+jCqMQ4At0A+YJ59vri5ZcczcvEE2ZYpOOZVjD0mEeJPviVGGSDLN6HnvxWgFS
 9f4diB+oXlRpzlT1zom6Y8PUSa+HvwYEpilPHOKPE6cTA0JDXVjTiV4nxzG498hEm0MC
 qkYx+Sm7LE/sdgRGX6DPn4eyeRVsL9JuCmlxU37XzhXHUZaUTN0b9Fnq4hPP8uF7WaiD
 fyLVfa11y+Zd6ZsvVB/OWwF0x5mU01+7xHU8gBS4TbcinmYt1eEV7K2jsaBSrGIV779g
 oKpg==
X-Gm-Message-State: AOJu0Yx7rj3RnXkn+zHlG4hLf0hKK4JgrAAhXB8rxhjCjeYomjYMjA4q
 V2oqOYr9M4J1TcEMDO/uDb4OdqRDO2DjCeYRYb5exz0HUMJF11YnNhwBrLCCxYZhCcx/6yfVGiv
 OsU9EZe4=
X-Gm-Gg: AeBDievx5sLE81lXA5cJhqgG1ujh7MJ0cVF/CUXXAcdBrlUl0Dkx9p0t0rEQTCVfW4c
 bS41/j8XTFh/jCi79LgirB3mUe7Z9EAuHqy0hBsSPSArq4uwIkz7mY6QJVWjTlXebXIx7BusyqP
 AW38arQ3ZFrCYycm2GrtujqBYWZHaqa0i2zTA2WoIumSCWl9o+ikRBHsuZ407ZkIOEPWZ3SlcG+
 1oswGYAIioFIYHB2ydGRBN5X2GpgROPyzw1SRcHYdlxraFSL074Hanxl1o0yvksb073jEEvaBL8
 9yAofzKD3kRPgnId6OUdFG0veXbvDCdNySVOVKwMG0F8HhHgdHAkGGxrsFavn2YuitwoTOg7Lxx
 8xNQEXiKZI/CXLVt44ZK0dKeXX8XZRn1yw5Q8FdijuRWLBwx8Ij6z7to6hUBFmaF5/m3ljc4Lqv
 nbIIUxCquErKUQMyFlmfS2nTecA2c/4B4pZ3WB0s7+
X-Received: by 2002:a17:90b:54cb:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-364c2fcaca8mr177796a91.7.1777501580396; 
 Wed, 29 Apr 2026 15:26:20 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/48] fpu: Return struct from float8_e5m2_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:32 +1000
Message-ID: <20260429222445.26301-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Inline float8_e5m2_unpack_raw at the same time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c1b03f30ab..bc6450954e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
-{
-    *p = unpack_raw64(&float8_e5m2_params, f);
-}
-
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     *p = unpack_raw64(&float16_params, f);
@@ -1477,11 +1472,11 @@ static FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
     return p;
 }
 
-static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
-                                         float_status *s)
+static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
 {
-    float8_e5m2_unpack_raw(p, f);
-    parts64_canonicalize(p, s, &float8_e5m2_params);
+    FloatParts64 p = unpack_raw64(&float8_e5m2_params, f);
+    parts64_canonicalize(&p, s, &float8_e5m2_params);
+    return p;
 }
 
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
@@ -2703,9 +2698,7 @@ bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 
 bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
 {
-    FloatParts64 p;
-
-    float8_e5m2_unpack_canonical(&p, a, s);
+    FloatParts64 p = float8_e5m2_unpack_canonical(a, s);
     parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
-- 
2.43.0


