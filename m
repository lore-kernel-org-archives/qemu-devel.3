Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD08C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOi64-0007sh-M6; Mon, 09 Jun 2025 15:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi62-0007s8-5R
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi5y-0002Qu-FL
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:49 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-311e2cc157bso3389116a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497024; x=1750101824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=XAR4DZZXBWbaspo3RunzOrEQkXGwruo58jGK6UQzDvClJYLkX2iblINVZyA9iewwiX
 UT5jsM4O6Srskv5OHUyzjmAQ83Y8fKXEnmuBvNPws802zLVzS5pGP7xUA1g/aYmBAeVG
 pdVFvxau9tDqqFu83JnrQdV/4//YkKG9Op6EzH0+0ua5TwiZXDIVxFebhuuzHfl6VkRB
 t2GKwe2HdGW87wcKTuiSDXq2kX3pjHp0TRsW/3lopjVFrmfBRdW0KhKFmn8e0d5I2bJD
 /c5LGxq9HnwWPkW7/QH69HlGAsfaUa+yNfY56FZDZeWT+5LoJ/maxeYoxmGLUkImVVwZ
 xN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497024; x=1750101824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=D67Cf3rCmipeJqDM2R8fbNHaut3+aH+s4ADSPBZpuL8pHFAUg5Wgz9niLubgUgILBF
 MgSiPPJE1ci7yKz7+dozhlPrIplz11hH5YkJ1SbpX1OFLdHTStJTD/FEY75IdRdvQdVa
 WHhCYGG9iDBtHeky8Uwnc9A+HDgNXBrrJMD6792xqjains2EnQylNgk1EdUaGj7uyZUK
 xOkdN1v8Cv9lpnD12qAPLklV4HSDsNef7RN71i8fj8RSbIkaURIDoO73DxaR3YGFqnU7
 saw6tGTwFwPSptzxmLkCfPtwfVKCOf8lgB0w/rZo0grmbNwzxOj9hVFmzBHSWlwQ3FwK
 bPaQ==
X-Gm-Message-State: AOJu0YwA8tANK4A2Mjr26K+kZumwRFlnuoFehDIDPVTDK7RXR34Wg1sa
 VD4ZAa2xxCYj0kr+lcEQKQYUIauDuzkeuzLDJRsqRi6pySV2+ASrQ3F4ERUlEqlS
X-Gm-Gg: ASbGncszfF2E2ZBTG9LkzyEnvflyap7zw0x4IOTrkchw0Sntbcd44vZUHk0isy3bRsn
 seCpaH8qV5nk4k8ijHTmsFgp8d6oxng1kw1HHHWyJu/rZz5o6Uqmo0IlvaJaEqCjUHmwmkiCyfN
 STccsiV/QzZ3qIPWB9caePWZFd/qLFtlZx+GghW0dfhm7JWPYOrYhN/rfDKRlJWiBTOVZh+Vtf6
 at6ImziVltqy/1Ii4eL8ZYHyKNNqL1KKcntHqOfcZJBHYd7CcGWb6n+e9NdfQKwNMcrvhaXVx9F
 XyzxBBWSwcS/P8nxoUq27wpiMNMIBJ3lbzIQKi7R8xCMbXigVk8=
X-Google-Smtp-Source: AGHT+IGPHenvDzAFSS4Ezrgkwx/qzXH/dr5io5aeKoUtsDjYIsunK8DnnsClDUTpYsG2Wn6L9z/nFQ==
X-Received: by 2002:a17:90b:52ce:b0:311:a314:c2e0 with SMTP id
 98e67ed59e1d1-31346d4dd5bmr21107498a91.20.1749497024107; 
 Mon, 09 Jun 2025 12:23:44 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b044ef2sm6057658a91.3.2025.06.09.12.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:23:43 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 novafacing <rowanbhart@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH v10 1/8] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Mon,  9 Jun 2025 12:23:35 -0700
Message-ID: <20250609192342.316156-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609192342.316156-1-rowanbhart@gmail.com>
References: <20250609192342.316156-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102b.google.com
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


