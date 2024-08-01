Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC0C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQiC-0002yp-FW; Thu, 01 Aug 2024 03:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQiB-0002tq-7a
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:58:59 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQi9-00066j-Bb
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:58:58 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ab09739287so4032321a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722499136; x=1723103936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtOFpryN5p45NTecQPUgADSe7EdyZv6yuf4iUoGdYsY=;
 b=WaO8sY4mQk7hFRWdhdAdiVAC0EkdkJdXZtHhWn9gSYplNfe67GLe0E0iz5nFEtHV0w
 zZY6iWiQJxyNW5MhFxwKBJOHKMvoR9fhZBUZ2ynbHHTh9pEqvpRObkKhR+9ALawvQBM7
 7bStpH1DmrkuWJxDoiYIXOrKL9JH85h5DMBimidldCTpX9ZYtOibWrINaa+VmeILpeK8
 qmc0zprZnLAA/I+NayfK4ICDRFml40OX+zoG5VclGIS+J6byRpnWF6nYoCE/xAMkeiI8
 UpszWod2RByicONrkjCJHgKWsmjfBUrpm1lqD/cu1nfy7gSJlC10SkV7wwCJO4CMCGKE
 dy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722499136; x=1723103936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtOFpryN5p45NTecQPUgADSe7EdyZv6yuf4iUoGdYsY=;
 b=xVCEoQrpd/IuGnrWh2nhtXe2SJbefq0td+kHSCEw9SW4y8De/vemwuq2R5rxCfVM2I
 TdyPMa1s3yEiyi2k2caA71eFIQDFZWos56rjLL/tcZDau3d6Z1AUNcungGR/XN+SJ5Ji
 InI97dwnTc2Ku/gjertOdTBGrt08hes5emjtWFpPv4OB4ES1fPt2rrmeCg4j4GlAw4oc
 yURwPG1ywIQJOtHfVw0IjnTYnBIC2fPmgRHHLsIWXnk1STzBa5nC+sir7q+7MA5ixOIQ
 tI1hpIdxiSdvXPO3cjI4n87qlRG7P5tdLbdRhOZkmW7rYUr+3dfdJpkCJ1EeWre24njB
 1c3g==
X-Gm-Message-State: AOJu0Yz+7+akIz42Zvf2LJzW6Mq9+3Ax4pYTABpJv09UcAklyk8h9NHO
 W+p7IgJjB5r5Wk6hzayvniQ9kmM+ffTBhNAhhZFN2G5hjDPQr8EJ0ICwsnMBahHJbBtUir1SzuR
 DfW3W8Q==
X-Google-Smtp-Source: AGHT+IHEW0Wfepqox45QrZeYKkEpa9nifERVt7/0luIBoJNxBNlikXOU5p5nJH1l3YPR6kSVtXzYnQ==
X-Received: by 2002:a05:6a20:c70b:b0:1c4:a49b:403 with SMTP id
 adf61e73a8af0-1c68d23fc64mr2026758637.46.1722499135559; 
 Thu, 01 Aug 2024 00:58:55 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee148dsm132195755ad.144.2024.08.01.00.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 00:58:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 1/2] target/i386: Split out gen_prepare_val_nz
Date: Thu,  1 Aug 2024 17:58:44 +1000
Message-ID: <20240801075845.573075-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801075845.573075-1-richard.henderson@linaro.org>
References: <20240801075845.573075-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Split out the TCG_COND_TSTEQ logic from gen_prepare_eflags_z,
and use it for CC_OP_BMILG* as well.  Prepare for requiring
both zero and non-zero senses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 95bad55bf4..e62ffa2858 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -865,6 +865,18 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
     }
 }
 
+static CCPrepare gen_prepare_val_nz(TCGv src, MemOp size, bool eqz)
+{
+    if (size == MO_TL) {
+        return (CCPrepare) { .cond = eqz ? TCG_COND_EQ : TCG_COND_NE,
+                             .reg = src };
+    } else {
+        return (CCPrepare) { .cond = eqz ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
+                             .imm = MAKE_64BIT_MASK(0, 8 << size),
+                             .reg = src };
+    }
+}
+
 /* compute eflags.C, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
@@ -908,8 +920,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
+        return gen_prepare_val_nz(cpu_cc_src, size, true);
 
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
@@ -1006,12 +1017,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            if (size == MO_TL) {
-                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
-            } else {
-                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
-                                     .imm = (1ull << (8 << size)) - 1 };
-            }
+            return gen_prepare_val_nz(cpu_cc_dst, size, true);
         }
     }
 }
-- 
2.43.0


