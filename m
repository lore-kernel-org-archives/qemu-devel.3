Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2010DC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgX8-0006di-Ey; Thu, 27 Jun 2024 00:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWk-0006Hw-GZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:34 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWh-0000Ar-N0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:30 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d5666a4860so256457b6e.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719461666; x=1720066466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwLPKvfEsT814DRwG9Ogl9FVhlLvakaUgV980nIKtT0=;
 b=ocsoLMF7j8VQ/pmW7TPqjKhSB97y2LOq4teJDgJxBfaqcaJTAYBHCuz5rZDlO6tcLc
 zGLyFFPSisi5TYxTtbSbaEthYbYkynKg9BFausanBTYt4EEaE1Y51nF6wblud7JXKlND
 HocKsGs+9CwUU0n1oiNO/KmgoqP2xeBvvRhCunajpFuGgxsE0+DsEP8Htq8IimdCHBfc
 UFheA7pI5ltPMduLv1ITMjM9gDK3t0orhTlR1HriCPuDc3ickPaHB87N/PS4E4fwbIYg
 XJxvlD+53U5V2s8JedHDosHy/BlbczdNKZrHP+rSrUKA2BQcrGciv8ty37/uid/RJrI2
 gkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719461666; x=1720066466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwLPKvfEsT814DRwG9Ogl9FVhlLvakaUgV980nIKtT0=;
 b=SaKsz217AYP4kMzYuvpVWiEHR0ekrWtxYM1eQvRZU5I/5BzvZAsndWRsZ1Kp2EUpNb
 9YwhKRx/5mIdttyNib52sNRO4baVt7jR4LyLUTrKUuqoesxUdpfUiWeKI5WyRUS702Xd
 3aSPdlQD6USCKjpomDE6he/6mFoOB0JvcufSH2L1RmDK8ov/LZQ34sWnBtzGKP3+mRv4
 fm00RVrqbSL6GIcsGsa8/QqnB9t29F4j8M/F+ufc2o8ytIIBVz2S/RqhxotV0EratTgF
 EQDXMrSvjr4/Gp9RhxjnytcuLvnTTImIJbNVqA+ph2zsXGfkwJG3FkRxlbXIfZztK2yK
 WK1g==
X-Gm-Message-State: AOJu0Yy+dAw4mBWxfZanw5WocRSXOFk4FC4bEeW7yczNpqslWT0Kz6By
 dM7mRAx2JaS0lp01U6nh4QO7kohTuuAzOfx3CGapR9d9SLZczD57plXHYRtM4mDIBVwiZYm0/G0
 8TrQ=
X-Google-Smtp-Source: AGHT+IHXBJ+VgI3egCZYhCfuNTI7h77pRRSf1bGcGvfnK/Wd96ySDKQaBIzmWimjsfzM6YDN59x24w==
X-Received: by 2002:a05:6808:114f:b0:3d5:658b:be39 with SMTP id
 5614622812f47-3d5658bc079mr2930892b6e.38.1719461665890; 
 Wed, 26 Jun 2024 21:14:25 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72748e8539fsm273045a12.66.2024.06.26.21.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 21:14:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
Date: Thu, 27 Jun 2024 04:13:47 +0000
Message-Id: <20240627041349.356704-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627041349.356704-1-gustavo.romero@linaro.org>
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x230.google.com
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

Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
are not confined to use only in gdbstub.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/internals.h        | 2 --
 include/exec/gdbstub.h     | 5 +++++
 include/gdbstub/commands.h | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 34121dc61a..81875abf5f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -107,7 +107,6 @@ static inline int tohex(int v)
 
 void gdb_put_strbuf(void);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
-void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
 void gdb_memtox(GString *buf, const char *mem, int len);
 void gdb_read_byte(uint8_t ch);
@@ -130,7 +129,6 @@ bool gdb_got_immediate_ack(void);
 /* utility helpers */
 GDBProcess *gdb_get_process(uint32_t pid);
 CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);
-CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 1bd2c4ec2a..77e5ec9a5b 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
+/**
+ * Return the first attached CPU
+ */
+CPUState *gdb_first_attached_cpu(void);
+
 #endif /* GDBSTUB_H */
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 2204c3ddbe..914b6d7313 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -93,4 +93,10 @@ void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
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
2.34.1


