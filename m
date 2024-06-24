Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35FCC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIj-000364-C7; Mon, 24 Jun 2024 01:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIg-00035d-0N
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:34 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIc-0004bZ-L1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:33 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25c9ef2701fso2265676fac.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207089; x=1719811889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwLPKvfEsT814DRwG9Ogl9FVhlLvakaUgV980nIKtT0=;
 b=AfX59Jd701xxW+ge9R0XjUco6SDbzzH1R4KWYTUP4iOMo04dA1iHQqdzIUM7MiAfdc
 ULP9BGQuWJHRFM6/l8KkSfVQD0HbX2UXhg6YBGmSphAXa6RIZzMI4tjmSoJxl/stiC4Z
 lbVmZzMDzjVg3pwSdpdH2LS0bp/N7Hn4SyToqxs8TGEezWL9SX3+lI57VipVuShc4mNK
 N6mUk9Ye4WTHHDbdM+mxktTQsQ8Gstszb9GPu+xGK+0b+6hAaL1PmaWmzqFdgrxpKW2Y
 h6nQIjUoImrxpqfo+JZxeAj9BGcxA6tq5bX5uTdLMt/U3kylVPbbD5aEGgGLH5UfGgsZ
 1NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207089; x=1719811889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwLPKvfEsT814DRwG9Ogl9FVhlLvakaUgV980nIKtT0=;
 b=Tru3FZm4Ax5u9S6OY2xYiY8BvqrCOCaSAymnJ/p6XJ0gh6nMAYvajcNhTQbBaXAq/P
 Hx/OEnlKzq9mFY01p0SXL96Akq15auI8mxP94EuRaJye4JUxG9i6voFU2rKoc+gf6M7R
 j78bIxrxH8quYSLqXTHEKEXVMAxb6eHiKky7NmQ7nyFCq5m8Laa4GnZG4dwkmZtqr1Id
 KtlVPfOZ5ZWeXgWjXP48U/Sf8ptaEepvzJkWShuzsjbKRa4uKK+57jcCWd3WUTiu624+
 9g5Bm83BEIf6+oEPOoTbYmrL068cgopJoe/sdgUe/wCr5uP7Lgl9ud6qXbw512zmcdye
 CzXw==
X-Gm-Message-State: AOJu0YxUUtdnNHOI1kVngSIlX76nmJrg4zqenFfW72grWVTihn/4ngw5
 6zEjf2JChQfU4gZ+mVJfsi9YbbUetkiivrVMKs3siAjrsat1jcyuJtc7RpkM3bOFjElPKD6NWPI
 ARH0=
X-Google-Smtp-Source: AGHT+IHM7X00u6LrPpO2ekyXzYUR5KnY16djB3xLOcyK7yN4lCNHbhKgKqZ2uIROukMIkvI4c/w/ow==
X-Received: by 2002:a05:6870:b528:b0:259:58b3:a44b with SMTP id
 586e51a60fabf-25d0690d791mr3625439fac.0.1719207088997; 
 Sun, 23 Jun 2024 22:31:28 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:28 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
Date: Mon, 24 Jun 2024 05:30:44 +0000
Message-Id: <20240624053046.221802-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x2c.google.com
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


