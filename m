Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C7EC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pg-0002Ka-LA; Wed, 19 Jun 2024 17:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pf-0002IZ-2s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pb-0000cU-GM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f7274a453bso1459225ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830809; x=1719435609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD1uieGP5nfh7Q2t/UD95u7CYAeGLPnjRZrpG6JzotI=;
 b=rwxirWeTs+xF0CzXhsGaHDS0Fg8oe7Ce+dHr6U4m+nose1vbjIfFaE9KpTeS3St2gA
 Y5upAm/ZJOJwZu3FtPBTpaaImZ4C+C0iEZw2awQHqfZVw42FdwzU0riSIU0bGXgc4jQ3
 5KJkkFh6LoauNKmCunMB4kPDQsSdM+S9/BHHzFqD5QpD4AEv9Px6LOIDy9YpjcB9a4qX
 A4+g7B6dXIIkm29LEx+lr+hlfCAWgOb6kIt4sa2Tl06WKd1I/SU5lpeMckrDzTbZAKLe
 Jy0XVHR/s8kQUf+ep6LURA7arzhyWREUYrqHh+92NXbPAPYCNIWFfgCxMmjj/Kls0ovv
 H2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830809; x=1719435609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD1uieGP5nfh7Q2t/UD95u7CYAeGLPnjRZrpG6JzotI=;
 b=W4yXEXX4pIyeX3sas9xKyPRwLKvB6JpSW5gynT2gHuM+JO1rA0+9oD9XaUy8nW4UVW
 S4pcrqOwCSVp/7nav6TeOEziqv1vBFn3dc+5X1b5vzZ17/DHwjnjt+a/1zWTtHD1U+8z
 +JreS9q+H+5tMEvetlS8K9X2cXnaA4hCqptWG3bNq1I5dDr7agt8ixhFnLdNe6RcmLsR
 3eSuvjHUisqEAR6E1Mf4NjthfaL0/oz2FTRRuRjmebv7LxqpMmWXI6ui6lb95VrRGTrO
 NcEsYSf7/GHWR85mL1Lj4FmCWGgodBVGjS8QiIh/unyedn/RdGBX1LYv5iKf9Z4EtWwu
 f1WQ==
X-Gm-Message-State: AOJu0Yx+s7PwEdZh4XT38BcJG1PvhmK1V89RWL1mTWl+PJHwFSSAvNHu
 dU/jxhpzuGP3cvPM1Z8cTKn8+Qqw1ikFELxeZ+RPzVefd54SIdfs5wagaXarhoLFng6Tfy/4/u0
 W
X-Google-Smtp-Source: AGHT+IETfsacfH1clD7sf274QG5WotLZd2yhxT1oDNp6n3Xy3lVwf//ELtx24g4ZeLTeb9PzPXoUfA==
X-Received: by 2002:a17:902:7449:b0:1f8:7359:bb66 with SMTP id
 d9443c01a7336-1f9aa474109mr27246045ad.46.1718830807487; 
 Wed, 19 Jun 2024 14:00:07 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 14/24] tcg/loongarch64: Support LASX in tcg_out_{mov,ld,st}
Date: Wed, 19 Jun 2024 13:59:42 -0700
Message-Id: <20240619205952.235946-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 8f5f38aa0a..4ead3bedef 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -325,6 +325,9 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
         break;
+    case TCG_TYPE_V256:
+        tcg_out_opc_xvori_b(s, ret, arg, 0);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -854,6 +857,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
             tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
         }
         break;
+    case TCG_TYPE_V256:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_xvld(s, dest, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_xvldx(s, dest, base, TCG_REG_TMP0);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -886,6 +897,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
             tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
         }
         break;
+    case TCG_TYPE_V256:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_xvst(s, src, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_xvstx(s, src, base, TCG_REG_TMP0);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


