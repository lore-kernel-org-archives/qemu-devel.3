Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A12C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpj-0000PU-IQ; Sun, 27 Sep 2026 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoE-0005M6-6O
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0007gc-9c
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:33 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df8818fe1eso6311655ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499867; x=1791104667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c1SFLe1YhpqN96gdaHmQXtfEYRdPenlxYcoWUhuO+qg=;
 b=KtU3+u3ixbJ6r1p7yaWlnDLcsdP9UGs9Wf3sY7UsCSJ0Iw/bBqhZogxj/kC59KoptF
 DZ3iaRH/zNFA8qWWyTX/DIJ9xXCNwrz8LaQOZ5xEeV7oFreHR9Nhu0U9DQkmVNIfwNGl
 75vK4ZSe+2dMgdl8pp7MAk/P7r3uwykPWFRvsyhoAUaqQvfBM06AoIHH0yDPZnXRI3CW
 M+d/PcLS/6Y3A601RTgzOL1SLVlYsTOi5gpk47HIq55VYnuT62zfUehpdDrFyTOOODhe
 VkqFLiLpCSm+opjkOcAR0d01JGyXoxbLZiOXQd1oKEftx6QJ+35HyxI3jQHIqqi0jKhw
 bxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499867; x=1791104667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c1SFLe1YhpqN96gdaHmQXtfEYRdPenlxYcoWUhuO+qg=;
 b=LNItXIOtDEB+2kRpQBe681N1zhCf8y2yTcXCemrAnWX/2XxjsQwxmGEtAMbWcq+/7q
 5yXGgKAIbtNqTjwC8C9sJdUlUG6usKTayWFg9nn4/8XN+8O0hsX3e//H+7tW6L833Qq5
 /PmtCY5kVn2H2C/c0oOK7qZPBd+PbQDdt+Rve6AaiLC8kfIDRZ1hJliMmIOO2HS+d3hD
 fV2ezpnHJz5eUk2CgwCASq6iOeRW8s1tCOweYRCbBac/M8FTzY2XthCbh99EGcJnT6lL
 LtOnCMZDTG0nemjR0jdLbME+W7vVTkcDt1cylAoobWUk7sWGLZ0PHiZGR2IDlAXVd9OX
 1K4A==
X-Gm-Message-State: AFq9FYLkY+0DuiD7BG82CD93P1hkrnqq4VKSeG1t9N2MCzyq1bFpf1NB
 mCwCBIuLATFhV6ckhJpZwrBt6/cMJnCUfF3imIXGH/cl+Oeg2rbrDPirzvWH+9kHqiA1Eang6Or
 6vnPI
X-Gm-Gg: AYBFou203SfvJRKQNBcn5J/m+TSaF5gzxDt3orubABXoF6S6InHUPf2LQdnLGYmKYgM
 GHrtXDaa3xTebSfO9qlAqY8hT6OYs9vtiAeltpAz4nXpttCTXFlOL47s37bC9c60X8DgsW/WsHH
 LYv1ruYDLy/Z/4CYjiWCQlE+iERK5dN6KvfzLo2MqAvTG7pBDkknaeoudM5bBZqZqojvikis587
 R2U0nZMlsQR/pPC3AOgixo6UaXoyKNHoil03H0EwhR4e4HL2KCn/CD+QpYwAr5NIR3yDnl5sRI2
 jKXKKdFaZKTXUJSGb+y63fKQxusgp2wr8Cho56vi0rgbyr8c4SUogBoN2ezVlC//oGLBlXDo7TD
 Idu4SQLXQ6ecbGpjFg3M0y4Ft4/zOwLFxdMgiGGzKRpdSQ5O4emKvz19yaaaCJWbI3wYnVKFyA8
 oFb02cM1Bq08rxUExQJkmIk1JBXh+ViarTwdXHaI2gRWWzJMyFBRBCMIqtdLSRzNniyWg16sW4F
 H1kZr7aaQAiClsFjNjZ9fT5iTYSVg==
X-Received: by 2002:a17:90b:4a05:b0:3a0:b61e:e321 with SMTP id
 98e67ed59e1d1-3a0b61eea8cmr4533113a91.26.1790499867060; 
 Sun, 27 Sep 2026 02:04:27 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 069/101] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Sun, 27 Sep 2026 01:59:39 -0700
Message-ID: <20260927090011.10724-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d8bd08ff1ec..2878701b105 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4c1fc9633c1..6208a51f536 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,6 +22,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c4ae16273fc..362eec23f76 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -615,6 +615,11 @@ void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 16);
 }
 
+void tcg_gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1181,11 +1186,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1477,11 +1477,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


