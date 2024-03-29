Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7864CCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlO-0002dm-MX; Fri, 29 Mar 2024 18:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKlA-0002aX-Kn
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl8-0003YG-VU
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:40 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a07b092c4fso1847308a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751498; x=1712356298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3k8lclmQQ4F8nUAdVeP5eeR9f55SSu6v457WolvggHw=;
 b=MrPgI1jPVK2ZeMAkOVKZ++573BpCmNzciLfeHzow6CaENov8pQ2yBIP+sI4bOWa8+4
 JPIe2ZIvSABnXHLIHcJXM8sQOimtKNKuBogrUbF2ny7GOEFQ2bqCYIYQYNpBmkOja29i
 5E7S4grm1gHFp4UdC5yG/ke/2wIqAbqM3X8pAkL/2N/BB6Rnwa1Ly+rIHKdHKuZ0Tykk
 AOu/oGD/N5s67pie6p+NvAB6UTN5UCpTt5+wnMDDHeVoUyiawCcU2UmQqx6CAMStp7/v
 kK3YAPTx5srAQ5u6kNWPCwpJTAbLYWTykpip7HzhAFrgj0QeRp7qqc8huhU/9cS99w1q
 retA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751498; x=1712356298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3k8lclmQQ4F8nUAdVeP5eeR9f55SSu6v457WolvggHw=;
 b=ZnluM28aH/MbNwZzK1iNBAhPlMdJtACLFJIERtnJ6G0drmrlXsP9DZs6qu0LrKQVKg
 Mxj0T69xb9MsK1jm8Y5PPt0h+APDxkck0BsDl84M6LcBpUapt8z7yX06ixDy1k5oOlN1
 vEZEM+DBAsVQMSlNVYglKzEAyH4HcGw8kj61e3ySss3yQv68ISzwcZN/XbH/qXmPD03u
 sYUufTnA4pe3Ei2IbZ+EXbciQz4JplNWHJMhC0jYf1zIrTLnrpoh7eMbtrQ0AlNTtibB
 CmxCX+pvF9L8pMKxiDO+tFLxDZitVz9E58sb8xrpB2byYhruS10F4HdLrnIHesFCen7K
 tM8A==
X-Gm-Message-State: AOJu0YxXRLyvcJQUmiNFnPmOe0EPdC5zaBJYEIG3fDQyusAsaHJY9K5P
 eX3XeKJmp/14n8geWPqpmLHl6Yr4khz1yBofpGMy+dlgGluD0eFkJ9zcmiASJap18Y9mmvG5jfh
 O
X-Google-Smtp-Source: AGHT+IE3ci2n2Mg5c2xaHwqVC3dd+w5W5OXOR27L6HjVZWjaqW9+dQyk8g3kl1CLUQAkDjAHU8OS+w==
X-Received: by 2002:a17:902:ec8b:b0:1e2:2e93:10ef with SMTP id
 x11-20020a170902ec8b00b001e22e9310efmr3293580plg.52.1711751497666; 
 Fri, 29 Mar 2024 15:31:37 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 16/18] target/hppa: Move diag argument handling to decodetree
Date: Fri, 29 Mar 2024 12:31:09 -1000
Message-Id: <20240329223111.1735826-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Split trans_diag into per-operation functions.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  8 +++++++-
 target/hppa/translate.c  | 34 +++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6a74cf23cd..9f6ffd8e2c 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -634,4 +634,10 @@ fdiv_d          001110 ..... ..... 011 ..... ... .....  @f0e_d_3
 xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
 
 # diag
-diag            000101 i:26
+{
+  [
+    diag_btlb               000101 00 0000 0000 0000 0001 0000 0000
+    diag_cout               000101 00 0000 0000 0000 0001 0000 0001
+  ]
+  diag_unimp                000101 i:26
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 29e4a64e40..42dd3f2c8d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4572,23 +4572,31 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
     return nullify_end(ctx);
 }
 
-static bool trans_diag(DisasContext *ctx, arg_diag *a)
+/* Emulate PDC BTLB, called by SeaBIOS-hppa */
+static bool trans_diag_btlb(DisasContext *ctx, arg_diag_btlb *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    if (a->i == 0x100) {
-        /* emulate PDC BTLB, called by SeaBIOS-hppa */
-        nullify_over(ctx);
-        gen_helper_diag_btlb(tcg_env);
-        return nullify_end(ctx);
-    }
-    if (a->i == 0x101) {
-        /* print char in %r26 to first serial console, used by SeaBIOS-hppa */
-        nullify_over(ctx);
-        gen_helper_diag_console_output(tcg_env);
-        return nullify_end(ctx);
-    }
+    nullify_over(ctx);
+    gen_helper_diag_btlb(tcg_env);
+    return nullify_end(ctx);
 #endif
+}
+
+/* Print char in %r26 to first serial console, used by SeaBIOS-hppa */
+static bool trans_diag_cout(DisasContext *ctx, arg_diag_cout *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+    gen_helper_diag_console_output(tcg_env);
+    return nullify_end(ctx);
+#endif
+}
+
+static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
     qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
     return true;
 }
-- 
2.34.1


