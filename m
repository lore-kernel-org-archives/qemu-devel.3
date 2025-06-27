Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A12EC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DD-0005FS-DM; Fri, 27 Jun 2025 07:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D3-00057i-1b
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cy-0007AC-R7
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so2055632f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023522; x=1751628322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgYISCMNkEKe+zFhK94dOEi+d176X9PjgGsBtgsVHM8=;
 b=scZdlMiorYjIKz8MMTTbGIsq5f9voyELCEQeKE7ibCqiFxaXvnWuCS0l1AScEzSX5s
 mYwYenSUMYU4e87gKs0sK6ykAP/PEaeCFkIUydhzBNPM3ja+B/XCGvBP3wduolUZcaau
 oiSQR/uoBBBDANSHROQAZI5mWDz2EgiUqxkk2v0FqOEi8ZCYk6hyJJxTb0m2f5Jzhwhr
 j+XzDw494FH8p8Ex9Uoqs2q3jmRytSihzGLqjOkYGRwZGvRDV3CAgkrqEoCFvrZ62tKH
 k5pU/KY5Uxs2RNQizecqds1SWZKf0m+OAkI2cnTTQ3uzutrRiJgfi/e0XRl4/OZpAzml
 6DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023522; x=1751628322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgYISCMNkEKe+zFhK94dOEi+d176X9PjgGsBtgsVHM8=;
 b=PKBv7ORnnnALtiuCG9Fbbu0pFdA+wlZi0u6r3yo5tX+Shzoypqg1pg/S2yrA9CLOBi
 c9tyAZ0VNmO3wPV+4tUdB/UKluMEVTvtJy8UIyRavmltPKmf0oghsLOkw3jKuLzBsFVQ
 /ULbft8JeD36vHffU358jiOYJcB9OioI3pzIZQSzv/0zs06LYEdlViyCLOyobWd9Gnx+
 iGVk1B/OWhl4qjGdtOqnhDY7oOegr935WmeZSf2hfMjFICdR1EQ7pj6BpiHNQDVTKsKQ
 3WEtqKVJOeeEiqPsM99um/S0W04Ou7i7/x9g6un/2+wy+RisJNMri7+AaghZbRS2OlVP
 4UVA==
X-Gm-Message-State: AOJu0YzX1eMFjZHdJF8SpUh3VNXXuUVCUdEToDM5CibDYoNU+qIeYYaM
 rraINQYR5kw5DpJSZC0nl9t8//eRg8kLBF/Qnnd+exU5UNQMm9GOQIWQSF83sMgVe2s=
X-Gm-Gg: ASbGncsgkaJuCPQDNajS2k2IQ5P3iqlpNMirfkF4xsgwHglGK1zHy4wMHIEEwINh+tT
 Epy7sFg2v4TncIDmuZrSjDQ9dz0RsEubYIl9buDB6r01jWXTHZNmRA1acUv6dcQ+b/d/HyGS+p+
 B6VLqavqGWJm2pVun1BB0dw1QcSmolEgIYr4N3e+jIvo//+av8LFiEWId5C3Mvs1YyZ8G3ufKhS
 VEwQs5J8tY+1GTyr5XllRTdxi7Rw6W3thX9EpIqPtILavcrnN426iZ/gIU7ZVnunbn8nVfbM9dT
 a0lFRSg8YmCaGoKSwVr4RVJNThj7X7MenaYaUhgbLna47pLQ5W7iKKSAa3jzLfw=
X-Google-Smtp-Source: AGHT+IG1Yuizh7/5aajRPTyMcg43l/o7mD/5p8sVsb0rISmy/JFghhmmKS1N4AcSorRkdKAEzcJhpw==
X-Received: by 2002:a05:6000:4411:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3a6f3152d16mr4125037f8f.20.1751023522420; 
 Fri, 27 Jun 2025 04:25:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7814sm2422975f8f.8.2025.06.27.04.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A21055F8B4;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH 05/15] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Fri, 27 Jun 2025 12:25:01 +0100
Message-ID: <20250627112512.1880708-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-2-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h | 14 ++++++++++++++
 gdbstub/gdbstub.c      |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
 
-- 
2.47.2


