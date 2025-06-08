Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500EEC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7q-0005rT-7a; Sun, 08 Jun 2025 19:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7o-0005qg-Bg
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7m-0004ax-PD
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so2424326a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424101; x=1750028901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=RcVMcAMS6UbBVHwaSZdJk9lo5EV1y2wCcILuiLnUKfMXmIKezBzmecXUIGawPh9qG7
 Affdrw+QasJVBnZ7PjPLomsYSn0qG2aNS9sPu6yHI4bpo+xHwbk7X70euynunmmgdZO2
 LRBlRoopRDi/tMGoEwk1XdBOt7b70JUSI4hyTlWOxiMKCl/bxvajAdJ2k0n/+Ya1j/D3
 1lkrJic4wc+z7MCLJx2YOPDeeq6e1PprNdceTMZOxTyLwj2m4WDv2q7k+lE6/sYCpcSK
 dvwQzCAJmzVMVG+j2RErbxjQnb6TqSefcaVPNrNtEhbWTrRb4ZGsvOix6y0CvtDPauUh
 aXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424101; x=1750028901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=dB4nwIzoQ2WM5JeRYuYKMbvkZIQeL2XKpDRmAuP94SwWJudidkK64vaOmVpeIZKoih
 jRMAJhfJFKuU2/zbEOdKjTDvkV0DoSgpNtoHWeVqJ1PCeafmu4igG/ljAPGwARwLoPUh
 xh7U+nJXGF+KR8A1N55YaeFHOEiThxGrciiIXsuXojR5wnkdrejgzUvXYSB5ujPra8N+
 8f5GplFgLiIpjOwOpcSH3wd3Ri2H2DJINZrJCEB7jLTPv99Z7fZmSSYWtlT2W+UIHapT
 oqIsguzWv2RLSJUJyC2CKzEFWmZPg3hFKvpatWAfrqZMI9eYYPHr1p++igGot93IPalF
 puvQ==
X-Gm-Message-State: AOJu0YyejkdlHTU722NRZqEOj4u3+6Hxad9lH83X2wI/HpWFQrZXYl/j
 A4PcqAVuAToItFx1c6INlvwb4ezHtsL4YoOJ33dWSGMlmzZkGYOftMJtcaG5X6+lmyM=
X-Gm-Gg: ASbGncvNVIjAnAWVM2otxB6rwP4WitFHv2gRWH/azyuHXMWZYLAIBIHDVVk9N+EgveU
 dGxmP2DFpKTxKfFfxadt/YPOpsSIe8CrII/2xOF5Vj7Zq4pDDffAA6bkoGlKlgayHtQbUirbHTV
 j5UNmu2I2e2Cxbd04pQxPVI7Mfo3dNsvVTBd8o6XDPE9Wa7TFJLXC3p8jUpo7QwolG7PfMWjgol
 niRWwQEXk1WObRcst38nl9PD7yJc0Y0Xf6gqTtkzqMujPl2R804eKcJNlTpGfdFkDGCIQbh+yJ3
 SOxNxT5eabxu/0U2Vjnonud0V5dJyKlGNEUsQy/TPDZfxQYM1eg=
X-Google-Smtp-Source: AGHT+IHuXdnufJhUxkoFLJfvjyvz/4VaHsE6ywv/WtarvPyAqoGgKMTZDDiOFd/FPnvezrG5b8ZXxQ==
X-Received: by 2002:a17:902:f548:b0:234:b41e:37a2 with SMTP id
 d9443c01a7336-23601cf0b4dmr159440715ad.11.1749424101290; 
 Sun, 08 Jun 2025 16:08:21 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:20 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, novafacing <rowanbhart@gmail.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v9 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Sun,  8 Jun 2025 16:08:11 -0700
Message-ID: <20250608230819.3382527-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x52b.google.com
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


