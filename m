Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFF9C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFb-0003D7-Hc; Sun, 04 Feb 2024 16:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFW-0002wW-EW
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:03 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFU-0003bK-OU
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:02 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d746856d85so27600855ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082919; x=1707687719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7nkcnvR7yCW819cN0Z1TIqZ24aA0LLfk5m6dHETDfI=;
 b=RTiER2irWsuhsKh09aV9v3BPpwroJiR/cdyd0RhiVNMxeE4ELCf6lqz8h+y2ONOKLL
 MlxA/ilCbD5KGP0uxvVMFIE/mscik+PR/sdCjxqWoHCX0DbDhlSZzKVHgbO2fC8m0ujd
 zxffEkOfz7Db44+yQUR6u0Gh6d6Zbhe1AhVICefbaVeGvZz2cMVdGYcuLEV9hujC+c1w
 O8a4CaQhCJw2PA/la6FO157EU3jmcuZgnHLOiSGlb2taDk3u9NTlpX8MnzcCzahivrXs
 ScDxmyXRtDexj+46Q0nhiW6dp4zHSdK5GvGh7M+T74WEISkayl9gpeg8WjKHXpoY0g3C
 /Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082919; x=1707687719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7nkcnvR7yCW819cN0Z1TIqZ24aA0LLfk5m6dHETDfI=;
 b=BGSWreQTR8fflKUIgJgPLS7OFOf64/WKgu0sZxda/I5EHMDjNdXNr7GVO9PgcYApL/
 q5jcRYWPkUXDgRRAiFAsCPPdY6OzMM4d1XdUUD6kKOcOmAhhdw7plKRqkEX57D8YTVyb
 U4j0nFJYrOfMOYwTqG7FRJxnyEcO/q1emczsjF1oc+DxW6QIemFFRTZtmVlclr7lhhys
 17c55MPb4MZLAG8I13l0dxdU+BjeZrSSasJ8cYXYWVO+I3/tHofyzZpU5M5gMvdELXAR
 xI2dktX7G4oREo3id1B+KM1qDIl9q113IvhXdqpZ/SG528Sgkwxux7gyUu+QeYqb2NtY
 fWEQ==
X-Gm-Message-State: AOJu0YxKeG7bUdPWxDayIMy9fG1v0Bd4v+oCENF/Mbd/1+Odu7Npilax
 VvR/+wuzNYfp7HXl5Epxp0cIx2BHkdcjRhiINPORl34Ek3Z9g+nvaAwYIk5LdBoGmhW4U9lTxe6
 su5U=
X-Google-Smtp-Source: AGHT+IEL6BmOrQn35iN3Zfq337j5mdhjK5choXgUll1YXzOGAcY1E5F3pyH6phPsgu+9N1Vy50SrDw==
X-Received: by 2002:a17:903:11d2:b0:1d9:451e:4365 with SMTP id
 q18-20020a17090311d200b001d9451e4365mr9577996plh.48.1707082919369; 
 Sun, 04 Feb 2024 13:41:59 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/39] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:43 +1000
Message-Id: <20240204214052.5639-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.h     |  2 +-
 tcg/sparc64/tcg-target.c.inc | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index ae2910c4ee..a18906a14e 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -149,7 +149,7 @@ extern bool use_vis3_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 #define TCG_AREG0 TCG_REG_I0
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 10fb8a1a0d..176c98740b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -607,9 +607,11 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
                    uns ? ARITH_UDIV : ARITH_SDIV);
 }
 
-static const uint8_t tcg_cond_to_bcond[] = {
+static const uint8_t tcg_cond_to_bcond[16] = {
     [TCG_COND_EQ] = COND_E,
     [TCG_COND_NE] = COND_NE,
+    [TCG_COND_TSTEQ] = COND_E,
+    [TCG_COND_TSTNE] = COND_NE,
     [TCG_COND_LT] = COND_L,
     [TCG_COND_GE] = COND_GE,
     [TCG_COND_LE] = COND_LE,
@@ -649,7 +651,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
-    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
+    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const,
+                   is_tst_cond(cond) ? ARITH_ANDCC : ARITH_SUBCC);
 }
 
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -744,6 +747,15 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         cond = (cond == TCG_COND_EQ ? TCG_COND_GEU : TCG_COND_LTU);
 	break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Transform to inequality vs zero.  */
+        tcg_out_arithc(s, TCG_REG_T1, c1, c2, c2const, ARITH_AND);
+        c1 = TCG_REG_G0;
+        c2 = TCG_REG_T1, c2const = 0;
+        cond = (cond == TCG_COND_TSTEQ ? TCG_COND_GEU : TCG_COND_LTU);
+	break;
+
     case TCG_COND_GTU:
     case TCG_COND_LEU:
         /* If we don't need to load a constant into a register, we can
-- 
2.34.1


