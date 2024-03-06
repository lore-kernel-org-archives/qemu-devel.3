Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B486C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsZz-0006k1-Q4; Wed, 06 Mar 2024 09:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZu-0006e9-Bx
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:08 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZq-0004MF-Ez
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:06 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so3737227f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736540; x=1710341340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J3ZwnAK+ALQL60EUhgyEtMB8C5fHpZxHXot9QnmFTw=;
 b=TF2nCDUlt7aeRNT3pGcuXBa6/sleXVq7XSPXbrLGP7I4Gwk7cF9fdMzXsdqXMV2/u+
 UXh7boYSVdLFJRL99MVH/tc5Buh2GXSW/LmcgNAq9jU+uNB5ujQ3Ht6/9Fgcr3vWnRKg
 420EzTxoJHwCE2cBXyTpBdjM7lVFIfGiP4/f8PYOZXKv7UNAg9BrMlOMgjswiSlgHqGf
 KKy90BWtPfF2cPpGFVdLxslft12/0EFJ/mwGPww3U63/HY0jB5V+/ack+84nvMRfMAuY
 cMyJj0Ggq64c+ylxVIfS3iQb3Q7beqJ+lz+I1DgkMniZYA9p8PWgl3G5XEh0EUSVfAcY
 /GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736540; x=1710341340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J3ZwnAK+ALQL60EUhgyEtMB8C5fHpZxHXot9QnmFTw=;
 b=shZh2bvjnmBRFNYpBdhNRtR7Slc1XRD72pgXL8Bo5Bk3PEDPohecKZEYCniq9niZnf
 jAz8z+VoYwLnKYoAObDTcIY074iZHJ7StOio5bLIs0eAtvfSXrkvRMsI9fkONlKtco5n
 Scwbs2U4kXjveSjjzvrIprBtzPZpqcnmoco2asclPtOiMaDamShI0vFIgeVEPyJjilWl
 hDaZ2DqpM08OEAcm6o9jzs+CJy+ubBsv6Fbxn/oehichVhP1+Kyp6eaguo5k/SAH4Lo1
 Cz19yDTstRZqvSR/KXXleThNIoysnleEBAg+dUPDXxMcMGbGePvwmU6HzQtc2i7oSZVs
 TVGA==
X-Gm-Message-State: AOJu0Yya+vivNDkO0lNycBm0LswSU/SS4ThzvqrORndl/nGhgjfwlESP
 /NMmEcM7DxlLV+sE6356onrZOkydZAsgMVSysT+HKeMubluPVjPmIuGpars4jQlTFFVdCCZV2NY
 U
X-Google-Smtp-Source: AGHT+IFey4MwKpp+UrR+vxXokP/QbnAq5N2iEXlOLcWGFIg/9c2BZA7GB/q/0Jr40Rf9Ygr/3HJNqw==
X-Received: by 2002:adf:a1d2:0:b0:33e:5da6:36c3 with SMTP id
 v18-20020adfa1d2000000b0033e5da636c3mr222208wrv.5.1709736539990; 
 Wed, 06 Mar 2024 06:48:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az23-20020adfe197000000b0033e4403c6a9sm7039586wrb.22.2024.03.06.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 132365F9FA;
 Wed,  6 Mar 2024 14:40:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 28/29] target/loongarch: honour show_opcodes when disassembling
Date: Wed,  6 Mar 2024 14:40:40 +0000
Message-Id: <20240306144041.3787188-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

This makes the output suitable when used for plugins.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-29-alex.bennee@linaro.org>

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2040f3e44db..63989a6282d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -120,10 +120,15 @@ static const char *get_csr_name(unsigned num)
            csr_names[num] : "Undefined CSR";
 }
 
-#define output(C, INSN, FMT, ...)                                   \
-{                                                                   \
-    (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT, \
-                            (C)->insn, INSN, ##__VA_ARGS__);        \
+#define output(C, INSN, FMT, ...)                                      \
+ {                                                                     \
+    if ((C)->info->show_opcodes) {                                     \
+        (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT,\
+                            (C)->insn, INSN, ##__VA_ARGS__);           \
+    } else {                                                           \
+        (C)->info->fprintf_func((C)->info->stream, "%-9s\t" FMT,       \
+                            INSN, ##__VA_ARGS__);                      \
+    }                                                                  \
 }
 
 #include "decode-insns.c.inc"
-- 
2.39.2


