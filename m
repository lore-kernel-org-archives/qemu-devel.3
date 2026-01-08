Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326BDD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdicr-00086V-0Z; Thu, 08 Jan 2026 00:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicG-0007o4-V8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:28 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicF-0005Tv-1j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:24 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so1381209a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850281; x=1768455081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IDSBq+h5586T4AWBNgU7jaX6pgnbIRhxB8J2QcVJ9c8=;
 b=e5djzzaHUevMKvQdU4MqC7YjrZ1yW5Zxtybu4NjBMaVxG0SiU/1wj7NF79pmAsuT1b
 YoEoW8ArxQrLU6fx0Gyu5Rn1MF4ohvJqL5ZRSllLDacztMZxhJkPvp0X+OxwW56oeMe1
 OdwFgx1THlDjOxFeWUC+gp40dzDlIqxATVMc1LUYBm0fpo+QCLOjO3nt8/8Zbw7ptlgm
 /xkMs96QwUgGSBO7b+vcSGNEAZeXq8VaYja6LHXOyLDS9GDutfd091dyFYYXzowvJvWw
 Q1Wrt0Pm6Ddg57QdlJyp1/fJSH8gSwwC8rCMoLZH15/yTYx78By4UX2LPnffvh7jSG1R
 LlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850281; x=1768455081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IDSBq+h5586T4AWBNgU7jaX6pgnbIRhxB8J2QcVJ9c8=;
 b=DaG+iru+DZ4EHDqQXpOb++sOXxyB9o+VFTdrGMv7Yd64QeP7vx+oTKLMOQll0eCh/i
 PAjpV5jvSABCNjdleCDsoU8/Z0D0EAWaz/plJfCxwmuZz5e5Ci6G7RdheIU6vhZ7qKNr
 BSzE4Cp5RgEBc3wPKPHBkdvAeJl+xgDHO3sxF3Xk6jfw+8jqPfOZuNbcwwvVkVZX+exu
 6JzmyYXDO1i+F9Wur/l89f+10izUmVq5J1aTQEQ7ucFJLpVCC+J1F/DMeGkIh+lCVpkz
 ymm+Y7IUHh0f/rI1kBGJEgq4wgA1nybuqYZRCT7ueF5gA+pv1i6irHMaGDyOPZfrskfm
 w/Uw==
X-Gm-Message-State: AOJu0Ywj1clLv969tGkzu1rUp7AWC5D9f1YHubsZecUUW2u6SBeAWEsm
 W0LVQraBP1T76Z+9EP3HobkRG4ghjybAjGtdpBRemEaIQABtHIx+BjEMf8K0Bwsjev6CGF3F7T0
 ZaUyJRbA=
X-Gm-Gg: AY/fxX5DPfdDUPpECGKlFyFB0sPBDNInTGSDqyLOVva5IHHG/MijRTyM6ugvzGRH+dw
 R3WvGnAioTiMD/9DFcOVrK3t0MW6qsAbW41H5Bhny0zR9R/hhj/fQFU3LhPWnXF1nM3iSH+XCk3
 rOR/F1cupVg6lG8cSWo8OyfR5fdFy6+b/S+1IcgV8wrKz9hLijb4pnjpjEXZlJds72VdS5kJSpL
 eUzgNcUWlCLPpF4FP2zsUrFBwmIH0oI+/E2c7q2U/neG+Oo4DvDgYhV6bb75q/Ubk/FKGe3GL7D
 V3vRP9HTLqbwaVY39HhPeFWMOxhZYRjHW0NUKb+8vdAzavqXYFGlG+yCujQyiz25mLugx851FRy
 oTEauaG8CRRfRpCkwD1zrJYezAIjbcBTk7ydx+yaqjO6jXrXSKcPv4/CcgQOzuKMSp9w31E97Ls
 aP3P+2VvXISdbMIbNbgB7YR1xj7goj
X-Google-Smtp-Source: AGHT+IFlgTQ4CsaiMhvuHDBMPqnkQSneAIG38URT9sRm/344tiwe5OUEvHZ+78vEWf5DIgIhMX3g2Q==
X-Received: by 2002:a05:6a20:7fa9:b0:359:62f0:574 with SMTP id
 adf61e73a8af0-3898f9cd3f3mr4759867637.41.1767850281375; 
 Wed, 07 Jan 2026 21:31:21 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
Date: Thu,  8 Jan 2026 16:29:57 +1100
Message-ID: <20260108053018.626690-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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


