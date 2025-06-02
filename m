Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E38AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLydN-0003GI-71; Mon, 02 Jun 2025 02:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLN-0006d8-9B
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLL-00025q-LV
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3107386b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844497; x=1749449297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=b5wcivWgSHrHPH5lCINBtrvgg1ApnqUPD9YwsfcWb/sLcuRMNUVHoT7sP6Bn5+wDLG
 lPijWbtSV73ieGtFjoNxGLKXAoadHWWVAfxC6s6M788CF7zjfxTO1evsBfRwZ9vxzdVx
 zul1LK6hM4vyBCskD+q26mPixU5WrJ/Qzqp5N0Xf6FBudMU1cuaoxlAf2tiuO2EB8Vp8
 GwMhzmmuTyLo/+PJyoIwadGuwE7JVDfrIQ/akdaZ0GAzzCSeEwu/auCK3Zqjo3DuGEpl
 m7AQguURecx2u1Qoh03xt7sgCq3BKh5880Qw6wWN68QoGZlRAThpPxEuFov1iIItcUxt
 Q2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844497; x=1749449297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=XBF+lk8+BaXQiAfqRO8JEhxEy7OWJ7zb9heMR/YNnglBoh+aLbSE6nqqNKV+T3si8d
 62a4v5th6/KFr/cPHyqZg9ENtNJD/gY8i0ofU6envxqfVaDc36Ji9gr+oUtrk+Lx/eXK
 gw4iYpFr5wknZRIWwiErZZj/rEk/0wLuYWRB6aQCB9mrDk0T+TPFlRTh2KUkc6XbxO5n
 bu8mejAHp9w+KA0HgoFxXSZtVG5ehItZGE+XFMtxAi80hfzR9jJ3slN+3h4GgIa1V7KI
 cDs4KJU8Y3fDQTy7UosME72xMDciCJU1/wYVunMQVLxumKkxgPzd3IdhjnlwF90U6vgv
 u9Cg==
X-Gm-Message-State: AOJu0YyOQN7NsoHAxwdgd9sorIFsNrVvYlqLPlr95fO8jjWbGruOruV4
 KtyzAu/CALYBAQLJEkhr4cXyhPSnA8yFx5BPZoyZAj/+dias/RmHg/Zy+pCShYrV59w=
X-Gm-Gg: ASbGncuSq8++c2VIQDr53KhwF3cbc30Zag8A8gE6W1MofZUAf+REkel6+EDe/hFTw2G
 PMOUC/x/aIYlEgOGKXtUN2TRDJsyBwK1+pneC6CjoaZuM+XU0Nj4MnhmERG2jXNlbC4jQ8UdLF0
 3NjiWdd7/ZzlxqqVqDmdsr1Pryp+QK1cjtqGUCsuVEM/ZcvI8ik2vc4GkLNXVyJZbuf966vgRaT
 G/9dG8DLmey+X/oUqv2z4quD+RQgupM1omDd5k2wwZowpC9Kg4tihiHWWigdIZU377SPWAq/Ah2
 EV0SxMQBjaAmFQP1AoDwUNtN0RMIv8OiNk9+e3YLmi34LrxKM6A=
X-Google-Smtp-Source: AGHT+IFoV5wBOLYrQGCZH3qUIjUOh17c57KxyQLGmAy90vKBAKT5VMvjjAw90JCFsufGApsVOSAkMQ==
X-Received: by 2002:a05:6a20:734e:b0:1f3:3ca3:8216 with SMTP id
 adf61e73a8af0-21ad9526852mr17218771637.5.1748844497562; 
 Sun, 01 Jun 2025 23:08:17 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:17 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v6 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Sun,  1 Jun 2025 23:08:07 -0700
Message-ID: <20250602060815.328261-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
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


