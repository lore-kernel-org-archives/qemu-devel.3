Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B76DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3HY-0003Wp-RP; Tue, 12 Mar 2024 10:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HT-0003W9-1k
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3HK-0007k3-Dm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:39:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29bf9bd1907so1663615a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254332; x=1710859132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+U6hRnnu1FyU4GsVaJb1EG0lBm+OsXguv63B7cAYsao=;
 b=TwKx0AFKsZ3v2ZvZvWI/sUGh4FlySEmwpNeWZLEHmROiaIBoVXEIpjzhLdRnqZQTgf
 y8LHMOSRJnQ6eOVzkdMeDF/GF8+fRi/xXYdgz1/uizXNIgZAM5nGOpEL/n9cXfV10dtc
 B5dX26tdPrppvayN+oI9L7wD+Bd7jdUx9TqojK0SysPeI4o+3nz2EV7lzGrbVTiB5R5K
 ww+/XtwW6L7XCtqdfAMNPL4LzmsB1bjOBN2P4gYICJC3ARyM8AxJA17NX9RPgduF/e8+
 CQ8lx6JNMEsnUJHxU0KcgfqsZ2jT75Mxldsn+eg1wtcO4JYdKT3C2G9Q1ZibjsAY9MJQ
 DZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254332; x=1710859132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U6hRnnu1FyU4GsVaJb1EG0lBm+OsXguv63B7cAYsao=;
 b=A4gY0uwNUzY6dSFpW6sTLavDNx4SbcV5NggrY0GXLSEo89Mt6fAgchlNXZLa5/DiFB
 rm8nTlOrwjmcpfGjvpaLYn8GqdK//x1bM4yTBWxWH4/H3PHeR0EnAku3ooxG8an4mj4O
 ntErhwRxy6iezfP0w4unwsZX9XTw7Tny/9FSkDAlOLfWWTyEmqyQGR1fSOMeTgmqOnIC
 a4XibAj/aT73+v1XHUpLtREMVQs0ADRVTlRVNuh42cBOBEQ8xS0Rrd/C/Fxmi6yH99gk
 OOselvSX31v3/kG3KoLeAmdw7sc9pkd/eC1Hz1wasCYHbeVJs/+0gQq08DQnnKIV1iZz
 kDZw==
X-Gm-Message-State: AOJu0Yyl8PwtcAcGarzYa5B5uYGFiNOH0nGD8bYFqdNEER1mfhw4Z4/t
 PuhHWjIOJwl71ec0fd9gg6zD25Px3bYYaFoGucZ7AAKn6rKa6e+teET+LsUNVD4MoTM/shuLQTb
 7
X-Google-Smtp-Source: AGHT+IHzn+c36MROMu7wMybNlQqmjmRkixnEtRkcngcluvCyIATvshm+YdoD4MGDHvjBOdfgO6UsxA==
X-Received: by 2002:a17:90a:d714:b0:29b:75b0:994d with SMTP id
 y20-20020a17090ad71400b0029b75b0994dmr590990pju.42.1710254332118; 
 Tue, 12 Mar 2024 07:38:52 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx15-20020a17090b46cf00b0029baa0b1a6csm7492214pjb.24.2024.03.12.07.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] tcg/arm: Do not accept immediate operand for andc
Date: Tue, 12 Mar 2024 04:38:30 -1000
Message-Id: <20240312143839.136408-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312143839.136408-1-richard.henderson@linaro.org>
References: <20240312143839.136408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The transformation of andc with immediate to and is now
done generically and need not be handled by the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 6a04c73c76..a0c5887579 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1869,8 +1869,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                         args[0], args[1], args[2], const_args[2]);
         break;
     case INDEX_op_andc_i32:
-        tcg_out_dat_rIK(s, COND_AL, ARITH_BIC, ARITH_AND,
-                        args[0], args[1], args[2], const_args[2]);
+        tcg_out_dat_reg(s, COND_AL, ARITH_BIC, args[0], args[1],
+                        args[2], SHIFT_IMM_LSL(0));
         break;
     case INDEX_op_or_i32:
         c = ARITH_ORR;
@@ -2152,11 +2152,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_and_i32:
-    case INDEX_op_andc_i32:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
 
+    case INDEX_op_andc_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
-- 
2.34.1


