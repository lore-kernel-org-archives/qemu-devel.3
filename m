Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15387C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 23:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUnp-0007Y2-70; Wed, 11 Jun 2025 19:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnn-0007XT-7m
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnl-0001jG-LF
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234b440afa7so3713035ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749684252; x=1750289052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnnF1uBpsF7ta/mg2wqDkU618epFEeVBHaFGc0cQD7o=;
 b=b4YkKyJ7IVXe3U+rCAhfpLUEUPAiag8wA+Uf1DKJAGAgUdPbZ+mR1aLn/7ylZccDNM
 olN/eZH+xAOLWMn+H5HiaWcmqh+HW/g8YREqVZF979havCJg2e5JN9Hf+uVx5bo8Dfed
 hDW/Yx8OqvIp72vfeGnQ3yd7uo76m8vkFuJS5lLdzn6mHRMtDdnXzrrJd8kHcp457Xyf
 P2cnjQyb4hfXkDX2+gTBrK8D/vFUCV8TFtNpznXMpIehz4WR1LVNF2ZZlW7fbRUyBPzT
 zpRUvROcH6mFvJlHzCcxQeWtpPIey/5SDYL7J0T7lZgI7BQVQw9W2sd3VZM6SY8g1U6M
 x83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749684252; x=1750289052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnnF1uBpsF7ta/mg2wqDkU618epFEeVBHaFGc0cQD7o=;
 b=ARXSLq5Hqm412VO5LVBwTRnshldPxvrwGYVUbCgeaOSG+CtT/XOhwHbarM96sN4Xoe
 YrhGgcBTwK/AoIzx2ZxcY1ZvcI/XihIQeevos7IblVtXvlT6Clb+C9Sx7tLUblY8oR1t
 2jjfEFrlX8y+NA4hhg9LTZ4SR9cwJBs402WMxbXVnpRS6esKd9V0VBGfuMFToWfJDTgP
 HFzGa8OSzTfThL3SIQ4yQ5/cvITW0CrfK58X0Aai/wqYUMbTwBk/vfNoYAn5pmW36xBP
 cbEh+vb2hm2X5pGmfqpUVSra1ujIaU1kB/7YSMbw4IxBVW1JDcYlfzawGRnZmVrf9Y3u
 9GzQ==
X-Gm-Message-State: AOJu0YxNGXnQve1T48Go15zmw4BLKKu6Ocq+jvVkJ6WZ5f68cZfwI8U3
 PEnM5i10lDZgL0cuqxD2h6T2NkkvLJIXEwN+Hxx6GLxopXKSpuRHggjBd2mxYtC4
X-Gm-Gg: ASbGnctM0kVQlW0lub6zjCRMFRiylKbOizuuMA/c9j234Ko8ox9vHmlR+bkR0HF2MAi
 jEWyfnHqpYdU8jbUXUwepAwjiL4zm0CK4PkjlnyDynHKj3h3ssz7B8I6e3xgEwH2rtWqBgwY6Nb
 taHanE2WKbhnfYEN+MfH7BWRMZLza/Pr619kb0lzFn9cGKyVNSnAL2oHdI2CYU/6SPJqPuRBr6q
 Ws4PFgDzHpnWtorqbrZQo21JMxKAF8HXh5L2423p7PKtgI3c2jsLT4gZsMh4DblVvGHfXP6xW8o
 GU9emyzS5knO+/daJYrvLyYNEcfEasV83LoVQyoYnArs4e+rSS5JH9F5nTXxQA==
X-Google-Smtp-Source: AGHT+IHH9bpX4nTtU5aCb3zvFk67mw313PVjNadTEys4t0+A+kZ0xmH0OMX3IPQpfLaM8cFe/V3Esg==
X-Received: by 2002:a17:902:ea0d:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-23641b19781mr78078035ad.32.1749684251833; 
 Wed, 11 Jun 2025 16:24:11 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6d9c86sm1220295ad.101.2025.06.11.16.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 16:24:11 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, novafacing <rowanbhart@gmail.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v12 1/7] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Wed, 11 Jun 2025 16:24:03 -0700
Message-ID: <20250611232409.2936521-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x634.google.com
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


