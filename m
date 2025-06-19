Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F69FC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHwQ-0001eY-US; Thu, 19 Jun 2025 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvk-0001Lw-3J
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHve-0003f4-2c
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:15:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so771484b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349750; x=1750954550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnnF1uBpsF7ta/mg2wqDkU618epFEeVBHaFGc0cQD7o=;
 b=QRN3uxCzweuiGqpBjnzPUv4cd3jCOVnBjUqqAJfWaAn1JovTn8hgOolPzxtXuHiV70
 UElhHYt7+4jHqDR7wrQK+b89mHGPsCtRyloaxnvMcsZfpHLykTkb1uwM7/9F+f9oMKDz
 1qrVZH1L6rOpF6f/g14uLdUN/OUo+JHBrnLdoQ0IvUmBJN5OWCCejWoZRnZz43QFTa7n
 lzhLIML83NdTMP3TWb9KdkrGdSUHs6ywpzIUuA6fDhtag/GWmjViIyOJOGFHsVmjn7j3
 7lPLy2h35MTYu5aFJeWsdhGlKKElalWEyQwhAVp0tmx3ZylTSi7PLHiRtVtI7otwVJlP
 R3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349750; x=1750954550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnnF1uBpsF7ta/mg2wqDkU618epFEeVBHaFGc0cQD7o=;
 b=hUvJxPABtXJpYnL5QuGztKOQE+eqLl53WfwotZsMRcJ0q57OhDe00meJSQpUFpJv3Q
 evpTitKM9uBs9w8qTgKBy/+MDgLxhZzRUn37RXINooclBNQbpZ4VKRLkpxNKwEfEB7Bs
 iE9vuxu5nNFODeP5BpAzITcaSjjpUuMtlRXBu+7X5KxsNonM1l3oV6gwkcZgboJyCKKC
 YcVADZC3E+kKkZD8dmSJ2I0Eaj5vdEAwfaalb3ZNjTuylhWxrrpmZZFFOqlzV1ArUtBB
 +lhHqsKPjOxeYh4MA0iTxh+1BPaYYjc2jkztGaQTRSpweZLGwprlsbMI6xlNfj9FvWh0
 LVlA==
X-Gm-Message-State: AOJu0Yx95sk710yZrQq2qZtP2WyOvHhNmQnBWyR1PsfxtUJb0SJHPXQN
 fGABZ+fHEiG44tfsRnYcBQhfkluP4m+4pkW+kabbpnMFkhwPRuANbQCA1LawLIw5
X-Gm-Gg: ASbGncvXAullPeFDfkuaWJ8y9bceHP778pZSgjh7QDEbE1R8E1HYvbzMqG+WleAHQew
 gpaXj73nxDZPUZbUmGBZ4y25CGBJyNnfylc36CCI0Ebtxjz6PdEH9wKrfslZbkvhIuxOAWDqfmN
 KOX8hPOZp34BPG7ReSzYy+ZiT3o0LR6Hhxre18P1IDOCxYikgpKMf/ooV9LfUdYv4TB+lWoNUDm
 GfOWinpzvKxfirXq9NlmA5CB/kgdbiO48TLOwsRbGeSCnbWMW7BIHqQ+gojIA558Bs9LsqVxGLu
 t6BVz+csgGulz/n9MYzI6ymW86eAYBPZBnYbVCO3aRrRkG+2WzZVv2xgZ2L84A==
X-Google-Smtp-Source: AGHT+IE/ZACCaeGyRq3zAtvfBllf80bmDiE4INglf/AYah9hB/4PoqjqSaKSUC9A/VDTajLrEc/lLA==
X-Received: by 2002:a05:6a00:10d2:b0:748:fd94:e62a with SMTP id
 d2e1a72fcca58-748fd94edb7mr3492345b3a.1.1750349750053; 
 Thu, 19 Jun 2025 09:15:50 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:49 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v13 1/7] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Thu, 19 Jun 2025 09:15:41 -0700
Message-ID: <20250619161547.1401448-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
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
index def0b7e877..dd5fb5667c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -535,7 +535,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
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


