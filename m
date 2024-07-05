Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D01C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl09-0002h6-DD; Fri, 05 Jul 2024 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzy-0002cO-Js
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:22 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzw-0001IW-Va
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:22 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77cc73d35fso130563566b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193839; x=1720798639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcblXcJm1xF5LxPcrc6RNUAzD4wW3iGRX/uV+phD6V0=;
 b=LYl7hFAque1r8d9B93ePkItkHP0yvn4oi7GgmfPKnr90xEfGPF0n7jrFZeAVNQU3oT
 OGnESmOsYBnsqRPOd7wH3xLA4JGftWt5GIewBWPlfm7zid6BXPdgnahoOCTtTsk6CJ63
 VN4OV7lSKJxWcqBBOVxSSMi6Bs78V3G/fBDbbGLlm6Ilgmu0qjYv+p8Ias6SXro/uFsD
 e7mWP4TzXMPp4dkVAGfKTI7tWPHTAZ6nNSASyCN7ci44qrweV2pAC8cMcyhghrO+DkAx
 lEAKtYmWJw7WUKinT4bUE+IEQRQ0hPUP4Mu4xnw1c4V4K8tiO9Xq+kIryaBssYwvaSJa
 oThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193839; x=1720798639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcblXcJm1xF5LxPcrc6RNUAzD4wW3iGRX/uV+phD6V0=;
 b=aFV3UtBRYNYPzbuEO+9DhMMFT5ioG26aFlewKCpfVCNJK9PwlVB9Ra7visDjeE9PmP
 o/HuMUK5FSCSuCl8zWg/61O3QhBOZHkBuCyqT1M7/sid93vXH09ZKuh+V0DPFWlm28Ao
 enqBNNUXpoqt1WJ3AuQYuZ5HHg8SAFiDKuGf2bjlZzYCR5qfAD9XBW4QxSFMt2j8117e
 6xoR4nQNsAiUQW46TRP00fM55YrKMrPe9L+Hdq2dwbI3Gmp3DxYP6dswzzf/PrB4/D6u
 N3VfcKFH/HLK6YMVsvEAEMQRFR7gKnG/tP12qpydnnhTHcx7xK8GInSSO+Q5KyP5oH5D
 jiFw==
X-Gm-Message-State: AOJu0YwbJy4JimxQNNBxAqJXP10UN26SPRLgfqPiyfjwM3AVEkOpWSJc
 lJ+Mnt0NoqoKdcy7apXx/q2DP2E7gtumwGAzZcNbTf28FDFwfkIZXJRjPQQT9SA=
X-Google-Smtp-Source: AGHT+IHP5vAOBmjMJaXra2aiwjJhGqJHotB4VfhfRqcWkzIhyw0Vuk1bxsrne9XAORZTgUdlXO0zoA==
X-Received: by 2002:a17:906:d1d2:b0:a77:cfe9:8ed5 with SMTP id
 a640c23a62f3a-a77cfe98f21mr157190366b.30.1720193839427; 
 Fri, 05 Jul 2024 08:37:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c3ef218bsm103433166b.71.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7384B62176;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/40] gdbstub: Make hex conversion function non-internal
Date: Fri,  5 Jul 2024 16:30:48 +0100
Message-Id: <20240705153052.1219696-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Make gdb_hextomem non-internal so it's not confined to use only in
gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240628050850.536447-8-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-37-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 34121dc61a..bf5a5c6302 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -107,7 +107,6 @@ static inline int tohex(int v)
 
 void gdb_put_strbuf(void);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
-void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
 void gdb_memtox(GString *buf, const char *mem, int len);
 void gdb_read_byte(uint8_t ch);
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 306dfdef97..e51f276b40 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -91,4 +91,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
  */
 void gdb_extend_qsupported_features(char *qsupported_features);
 
+/**
+ * Convert a hex string to bytes. Conversion is done per byte, so 2 hex digits
+ * are converted to 1 byte. Invalid hex digits are treated as 0 digits.
+ */
+void gdb_hextomem(GByteArray *mem, const char *buf, int len);
+
 #endif /* GDBSTUB_COMMANDS_H */
-- 
2.39.2


