Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EDBCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauJ-0005JN-DZ; Sun, 18 Jan 2026 17:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatw-0003bI-0G
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:40 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatu-0000uv-9l
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:39 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so23590635ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773937; x=1769378737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jt6epgzk+hjWVFj/7ojbUiaxuIhW/JGBZIUcf+FDUAw=;
 b=FHF3COC+pu6qJNTzL56J+0GKS59e9i0BuIClp0huZfrgNUuz7HNhOJCXDLIfkyO5XB
 QAYt69SFO9R5WbvM8Ibp4KEHLscV2vsYl4KXrY54uIvOLQxd0ExatvdjD/DKHHA3QJSk
 2iMliY4tOrG5x4MOPZyqqIaNH+FZSU7Fx42XVziMDAIdgvls4NQVCD9Qy+SUnp1ChdBD
 TgxQsEaMVKxIVx7vplaAP82E6kwRiJU9/M6hKPqnhev6HgMh2wQnCt/HkeKlBjVlO8Zd
 NY6qujbbsG5oRApHr5386BwItEjGljhkqWQDsa7qjUWG7/MsqiyrsA32w/N2agnkm00e
 n8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773937; x=1769378737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jt6epgzk+hjWVFj/7ojbUiaxuIhW/JGBZIUcf+FDUAw=;
 b=DsofQgP9QE955cHT0rsZSNHzKxrprNzXZLdVLcpgXLuO/SH/uK3sVD0Z9AlSg1Jfks
 NTGmfmhhkePaevOr0xegMeO64L3nYzu6G4bEPeZYBJF2sBMzi1h1MyX56j47xG2/ITU5
 A77DukQwyBnP+D+2YEiCaPXsbr4qIygmROqCPsa7j6g+oVDDrwjLdFneAW9RkMB9TMVg
 +BrZuJA/+RAM6O9RzCNH56wqhLIMylBye7SpDIerbQBcx+QvO4+8uDI1zld96UO2UfCO
 l6LqKvGo6uttKHf9KskIzE8i+VQMhb5fXF7wD02OOTYUvwdY9eyZn9aPXNyF+MSkGG6/
 Tf3g==
X-Gm-Message-State: AOJu0Yzp4NNEfXyUzppnssNPQ/PJ+JoS88sIXypCjtBhELi0fgOzI62S
 +IJ574KIqYeWeOXOdqSDM90T2yW/QwijFu7W3kYyDBpMrktVad6VjShhy2qF3vaW5MFKSAoaC2t
 Y8UT/+o/7UA==
X-Gm-Gg: AY/fxX7rQKlrIjVuNvQWe9BZ96RlPFVi8YmWRM9ckVwO8IEcgTYQeFMSrBMi/fq8//n
 iwIQlYA5B43akd0WKQoRZ8AgJcqxsAhSCEwMEg2LDCuYLvkX64HJlNo1ZvLUumqTytRwwKOj1Nr
 4JmGrITU48w1clD3bDEuntIrYJaZ1bthzXnWOB+5vIyjqrP10vcKAhrt3B0FxrdWLqjLFDlZ2+A
 ciJxA7xTjUfYr6jcMStED2boDKQ4HuDnOAfmiQYwmIiLOCmaIQU2ONviEzehvGLjobHXtlW0Pw0
 43eHkT0p7wRjBaJwjgBywcm/rGNYvxpaLGDi/3aKFmvpHCVJf9JV70xYp54wXi7AyYgpbE79oxA
 xpqeF6pdeW7Eu/Q+LfyGxOjSDfcr44j1t1glwg4HoT93+O1gR+oW+CllaQH7oxeCE/UzNCoNahh
 NlT3HPm854s0R/By4EoQ==
X-Received: by 2002:a17:902:db04:b0:2a1:5f23:7ddf with SMTP id
 d9443c01a7336-2a7174fa8a4mr89975835ad.6.1768773936709; 
 Sun, 18 Jan 2026 14:05:36 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 32/54] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
Date: Mon, 19 Jan 2026 09:03:52 +1100
Message-ID: <20260118220414.8177-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d6a12afe06..2cbfb5d5ca 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -54,31 +54,14 @@ static inline unsigned tcg_call_flags(TCGOp *op)
     return tcg_call_info(op)->flags;
 }
 
-#if TCG_TARGET_REG_BITS == 32
-static inline TCGv_i32 TCGV_LOW(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t) + HOST_BIG_ENDIAN);
-}
-static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
-{
-    return temp_tcgv_i32(tcgv_i64_temp(t) + !HOST_BIG_ENDIAN);
-}
-#else
-TCGv_i32 TCGV_LOW(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
-TCGv_i32 TCGV_HIGH(TCGv_i64) QEMU_ERROR("32-bit code path is reachable");
-#endif
-
 static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
 {
-    /* For 32-bit, offset by 2, which may then have TCGV_{LOW,HIGH} applied. */
-    int o = HOST_BIG_ENDIAN ? 64 / TCG_TARGET_REG_BITS : 0;
-    return temp_tcgv_i64(tcgv_i128_temp(t) + o);
+    return temp_tcgv_i64(tcgv_i128_temp(t) + HOST_BIG_ENDIAN);
 }
 
 static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 {
-    int o = HOST_BIG_ENDIAN ? 0 : 64 / TCG_TARGET_REG_BITS;
-    return temp_tcgv_i64(tcgv_i128_temp(t) + o);
+    return temp_tcgv_i64(tcgv_i128_temp(t) + !HOST_BIG_ENDIAN);
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop);
-- 
2.43.0


