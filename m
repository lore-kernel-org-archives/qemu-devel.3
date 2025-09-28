Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AE0CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uJr-000369-MZ; Sun, 28 Sep 2025 12:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJo-00035V-9U
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJg-0005xy-U2
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-78125ed4052so1789711b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077117; x=1759681917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w0XY9KSWG9rZfV1tYL0tGWSihRd8RTWjYxQ6oR/cY7w=;
 b=pKLNUSB/GW2xiq0dqhhhAV1yU5LSvHjR0ADa9ywz7e3vqC1N3AzOBpacZGPwY0rnAa
 Qn7XMs29ltwSYuMaxnexiyKqQJbbimxRwqnHsFRV9qmZbkHMNpCyPZOdgZqmGnug0JpJ
 qqQ/eHZDdd62gPMyi1w5kbLT7IiFEEuWFa9//wfoW7SDQIecAHYrXT926InD0NJvzGvr
 vAJ5ha3nav18HVJSvCkMuSZW29aOzqRdI08gnJOicRyQBnNCvFYoRNO/XnSDEUlVn+72
 aCiCeWCDp5Pua19FVzN5tSdP0n6on7UKpbMXsPPI3AxV5QN30VTKq6vKPX/YzFeehwx1
 U32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077117; x=1759681917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0XY9KSWG9rZfV1tYL0tGWSihRd8RTWjYxQ6oR/cY7w=;
 b=nHjp3d1nXYshxeBsUk09c7HXu9k/zhuxVo7XjvnFD/6QT7LXQlpWLsNcqXg0g5S7I4
 fl9qPt7Iq6hqG9+7GqrwsE+/Kew2DrxK3Nhsl2U/DW/dTbMoU1cKswAMUfAz/mvQsGj+
 oH9myJ4A7AmxEkhZrFqV5IdotJA6Zpsaap2Luta3qFN54jcxwWamoNvPkmuZ6nawtiF5
 5+OIQFhFuS4Zvc6Gt7qr/KmYkmOtDbn8RmGQBQECMfc6gZ1TdzCpyOtFXnxyVp1PlSPy
 xP+g+zfD82V+JMOEo0rbPZuanZ6VzQtucFc4N5B6j+YoyD9h49oNnVJnmEyC/cwph8e/
 aAzQ==
X-Gm-Message-State: AOJu0Yy3YbuyQXI2njbdZB+6XOW0uGlpiHUDmcf562sMX43sQl6YmdmQ
 58NSzcmx9Rm03V97rKp7EzEDNcFqykUrA11sQzVh1v/ID9jPrbXBK3Grl3AjL2lbAS1JJ4ilahN
 +PjucIlE=
X-Gm-Gg: ASbGncs6yjFkSpMVYqVJp0CeJSDNTAzkriznLlheb0XALl6apLTJxcBQR5phaCbtHHf
 7u3jbt6RXapN/54KtL4cs5/mYft2b/BBI8bbUZiBDDxwGkjX32oN7aqU/GFDGNCqyqoY4LdaTyY
 nFlDRNoNp9MBjlMWdclmpR3OKdSnFo+WOk4DJHKsrSzlxJbqyAKiMP/A5NREVRbNjLlepD+IYby
 3MBYuEPOAUS224UsUnqQwKMD7m76WtbQGVawaAvJS5qS062a4syTmWmmzW1hZV7Nx6wiu36X+4G
 pGr+KkargUD/sbn6bfK49U5o7Blx1dIDie1EfTLjn5THsweLPrIwja7jdB3ftJWrOYXKWBXoVZU
 za8ZFuHJ9i6SRNW1kpm29JmxXetbj
X-Google-Smtp-Source: AGHT+IGR3h09q8Aw5DyOYUR9r92d3zeA3dkSMr7jK0wfO2/edfkiKS5f6njwFyPY/qmZbQwSTHoquA==
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id
 d9443c01a7336-27ed49c7763mr157494395ad.12.1759077117436; 
 Sun, 28 Sep 2025 09:31:57 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] tcg: Simplify extract2 usage in tcg_gen_shifti_i64
Date: Sun, 28 Sep 2025 09:31:51 -0700
Message-ID: <20250928163155.1472914-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The else after the TCG_TARGET_HAS_extract2 test is exactly
the same as what tcg_gen_extract2_i32 would emit itself.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dfa5c38728..ab7b409be6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1818,30 +1818,16 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-            tcg_gen_extract2_i32(TCGV_LOW(ret),
-                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
-        } else {
-            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
-                                TCGV_HIGH(arg1), 32 - c, c);
-        }
+        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
+                             TCGV_HIGH(arg1), c);
         if (arith) {
             tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         } else {
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
-            tcg_gen_extract2_i32(TCGV_HIGH(ret),
-                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
-        } else {
-            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
-                                TCGV_HIGH(arg1), c, 32 - c);
-            tcg_temp_free_i32(t0);
-        }
+        tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
+                             TCGV_HIGH(arg1), 32 - c);
         tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
-- 
2.43.0


