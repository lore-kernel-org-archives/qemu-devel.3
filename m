Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8722E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTG3-0007cO-8l; Fri, 06 Dec 2024 03:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTFz-0007Zf-Od
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTFx-0005mU-8E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:10 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21578cfad81so15683095ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733472008; x=1734076808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbpnqNrG3cFwIZii6c5MquwA7F8Z7zU8w7rRlBPru8Q=;
 b=Neio6lXThLR9aTLe64C/mILRkgk2ZBRjjWC/q/45D/DGv/A4L7EHL1MToCw/HVgwoy
 jZPuQKJjEfgBlm7haEx5j5g3um88zb8P48PUZFrXmjYFpMDsRfVkf2W8DV1zNRffbgg2
 6SnrcHOy8rIZwubIMYbKXgWC8WSWWq5RY5kzABVhxI+V1i6imJRTb2M3Kf+fnL54Y0re
 kKnM8O6q6wa2GufPORgZVMzT5b7l55oJmbrE5Gm3b1u1CDThI8BW5cbBgaVgICPjfqOz
 43vnN8i0u1YQ/8d/4OWiAHYgOV1wzh9fS2z+ysLNfOrZeOyn+qa9v5X5CQBbFB7ZlVF+
 fA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733472008; x=1734076808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbpnqNrG3cFwIZii6c5MquwA7F8Z7zU8w7rRlBPru8Q=;
 b=icfi/WreruOU/yUl5fCz+xlP5UhkWsLUdx68t8KjIKsMKaLtSStZdUn4plup51GdXH
 WJD4M0f2kYKtQ7+xj8IxP3itQimJi50941P+E7aBAq0eD+Q5Dw9q9AA57+Tlu7cUSFkk
 IPiWvt28yonWbnHuDyKISGpbPwIogPg59k2HyoymbFBYXWLrrG3eTf5HiUAcrmSLOXv5
 RcsO8Jcm2HKFaVgXBXO8otGzV4PnQbRY6GsyS3YmW5dGRswUptR0IcxnchBtMiaVCz00
 UzSBQuxjT+NZqBdOnqQwecqo6e2lMnsu28EuW8Ltsp5FV+wtzlmIiCrTl7PfFDOrpjvU
 xcCA==
X-Gm-Message-State: AOJu0YxMKbnMHrC3CzM5f9+pQPiQc++8lTequIn1tTpYETS43RGyLQfZ
 uVFyRx4wkcxzANFe5DEsRyOeyN50zHaeUfR4ROABkPqeLJa0yhlWJNRfYr+n5cc=
X-Gm-Gg: ASbGnctoXoCwiR2MsMJZLfQk3yEbljb9vjiGK/Ah7Vqnih7oOOIipOC5/V8JOaFF6dx
 NgYGN6fujsQfY/LYHnXS+QvfIjOtxNb4SiYlot4DRTgBLo1GgxEwuv17mqq/HpqST9tHJ/ANcCb
 i/L9ktUrFc3LKizAkkSNaoP5pzU3bp2wgEHR8bbQ2BpismHMIqhN36xNs//dvhapytbBd5+o6yt
 IWcI67DEBB2gLx6i+Y583lpE8zTYP+ToEhpQM4vYdfkhug=
X-Google-Smtp-Source: AGHT+IF7utfiKQxETiFuEh60TKq4dM09h8COR6VBwKGgpaTlTpbIrvkbNeCHmSm3Jhz32/nchyKJow==
X-Received: by 2002:a17:902:f545:b0:215:6e07:e0c9 with SMTP id
 d9443c01a7336-21614dba66bmr26641325ad.53.1733472007585; 
 Fri, 06 Dec 2024 00:00:07 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e5f601sm23527525ad.73.2024.12.06.00.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 00:00:07 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH 1/2] Expose gdb_write_register function to consumers of gdbstub
Date: Fri,  6 Dec 2024 00:00:03 -0800
Message-ID: <20241206080005.775275-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241206080005.775275-1-rowanbhart@gmail.com>
References: <20241206080005.775275-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62b.google.com
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

---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d..7d87a3324c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -536,7 +536,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d73f424f56..584ed73fc9 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -118,6 +118,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
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
2.46.1


