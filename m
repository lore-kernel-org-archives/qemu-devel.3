Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4E0C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKZ-0007Do-81; Mon, 09 Jun 2025 15:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKU-0007CA-RE
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKT-0004Cx-6y
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742caef5896so3874608b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497923; x=1750102723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=dnOI/VgJHQsi/iDeTvZlhtR8ZUE7ry/+2W+tHaqDHk4aDYVWwbT+wDajqJoWt7MkQe
 7f3ZVWVsSRr7cT75Fnig0krIfHR6RriiClBgWsmpxBsStZnfV8VsBYH2MjQOD/15Qwpw
 KYTeHgMZVo7UEci64iSMpE9/JLXRgn0ztqmiM/ru+6fu/T7cXoiAOLgKyt0X1wfhMkVL
 VbKmNrSRcWIhmxs3uHBER5OFO8Yh9AjZMgDqna1S/3aUk2k1mGz+oydtNf3rTMUL9tvW
 lzn0tyEyJrJyufPlXq6xJFxpJvDUckSb7akJAXwppruypmwGluADkqgDQAdMQPFKYWnJ
 VVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497923; x=1750102723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=Ea1nQgMbQaert4cvgj1BLEa0IlVv08Ox8SKOZ4RfqEa8fnvk5ogT0BKHMjBOtH+QW9
 zfepQQaZscMrizgDTYhEwaMEMZ0TKecA7SFRFPgEBnOJNUaYF6+5lmix6xoi9ka3d15y
 cni4yJpVQByeWAgEuhIBZulFwYDAA3Lw5jZ4HhLB3AR4SJt1+26IuAg3p025kF5z8cRZ
 3otxZHM7aW+nojyymJ9C+CIMjBp7vVbJnI2n0eq3gf88h8vDxikXkN3OaXLU6v9+Z/eJ
 CnUaDvdJJlSV3YB6c80H7jAQ56lg4r0a7oZkmQhyGpY6kxSpNTlfXTTwpcD5v8NR7EqK
 1TbQ==
X-Gm-Message-State: AOJu0YxNwSbawRRU8DfDCsjJKgUykG6tePaklC97jxz8hpWcAJTOX4VL
 b0nkHkGBQ4HORntQqVjb1sBIz566S/aOwz9icDreythA1VVI5Y81/77CEtS4URNJ
X-Gm-Gg: ASbGncuPZLooh7eE1DGndCL4MN4P6mUaEIZago+1N6xqKzAkqa1LqzPddf0mqiHPSQD
 4naeytFCBbKllNN6hny7rne/WfYUIaZoi2JMEnFQySRNfInR+ag1By1T7p0FI3MUD/+C+43xZuQ
 hqUYgKbreC8W3oTV4BpeG57G0vgnS6S3oIfe0V3UdNrIxKqmi8BnbysCctvsV4pzUjiK7K34384
 lO0LEJ5Vz1YiLGDEIhG7g5sBfYyKt+78XSMdEhzXmmWpzdNbKvYYDumCedSTgAfUeKjI0GxhoH7
 DDFyaHa9KgZHkXIr3ULwMR6ZhYQNmeA9Ej4LgyUEQA8oDbTbn1k=
X-Google-Smtp-Source: AGHT+IEu2vviCFSVWJZumGKQPmcucedY4J0g/Tj0dxm9S+iDdYQnSQEyZDo9yg4l/GXVT4Pz4nmshg==
X-Received: by 2002:a05:6a00:1991:b0:748:31ed:ba8a with SMTP id
 d2e1a72fcca58-74831edbda7mr14787060b3a.15.1749497923096; 
 Mon, 09 Jun 2025 12:38:43 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:42 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 novafacing <rowanbhart@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH v11 1/8] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Mon,  9 Jun 2025 12:38:34 -0700
Message-ID: <20250609193841.348076-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609193841.348076-1-rowanbhart@gmail.com>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..5846e481be 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -534,7 +534,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     GDBRegisterState *r;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..a16c0051ce 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
-- 
2.49.0


