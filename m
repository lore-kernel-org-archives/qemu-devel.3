Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E757CC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyHj-0005Pn-Vt; Mon, 02 Jun 2025 02:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3L-0001ht-Jc
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:50:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007Js-FY
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-234bfe37cccso50809205ad.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843359; x=1749448159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=BYvfUAgyLHhZCJfsEMnC8AfiyInpk2ZxX0ZYsbV95jiYftuf+piUIr7H4zCUBpv71a
 ZBXgNlcRlOnfAxy9UKn9UR26M32USJP6QUa89DiRzk3vhHc+Eef0ZItaHP2dt+mG75Ms
 zahp8WetEt0+Hj3iYRPML1WMOHHf/EK/TLjUgiBgPn2jZZCC0QIKRQZesPvkOT9Gxu89
 201prRz6Sk9EpFglgpNfCe+jdwzHIhmd0UHfI18PgmSY3ff87rd2nSCJK/I51VM4YN++
 OYl4SeNrZfeuh0B6GHjcL899tOgQrB7wvTvhYqkfE5uGvKnY+hCoYniVsNd0lVVRyA6M
 OWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843359; x=1749448159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE/rElsE+sxHsKrFd8ZdZIhXnJuddVorLW+oNsQpqho=;
 b=AblXy6mxfyK7C+6bWQisP2mkpWTZArZiEc20iHZLsrPhCoexjrCI3oUHQVcml7iUmI
 VYQkmv8wM6LpMz0dcNm6IkyzwHmaEuUUkdqMzkcmdlMGXM+bcbZjT+/oXcDHwHXxjyDp
 WuxBzBfolGJLOtqTC+PTDGiLzve6LQUpcB+adeF+Vi9B+wA2Y5/gVWL62lAi9zDjWL0p
 n5JYvqPn7FuZcyoe7YVdolYA037sjuehuV/54riHyae6bM8m2b5waaVXhsqZVaDyVAJs
 n45la5ef9ftcHodDWVlqSU4x36R3QFg1h4TadTSaLOn/w95bdw/bT8djUPnDEiZ5dAAw
 UfMg==
X-Gm-Message-State: AOJu0Yy9C8aNjhCF1nc3naVHVl1fQe0PFirieI5Rstp/aRxyG4uffCUo
 /blGQxIW//sCagSqd5Fu/ofii3Cou37slUMPAxcrqRI5SrixVxBJzZeYiBA2TtcAq3I=
X-Gm-Gg: ASbGncveIAs3R94WYwK5XEqlQ1Q8imnB2X495xyliSlfyNA95qKpebXqjnZ7UNcnGcD
 Ml4ngCI+0phnDwOf0GfG4x0lwJZ0WgQ7PI12jYpxvoTwIlnISeq/bF5m/unyEvHsB+yFOKnNRfQ
 WkphDgBfP3xx/fKva7OkmehK8qXUThYXTefU0PosMo3e4w+zTa2ygsXbc/YXAld6HUp1eIV3XoT
 ZTiqyz0Q6jX2CYkoEHvfFIfDxrd5aMRR3HOj9d0NYhAORq9XdjcKY7ssDj7Ky9gTWmXoA4pie9k
 pCxc0ZDyKbnuwgOhogW0eWHMYyVwgaHIp4RjTjbIWVxMmGRORLhjq/ubR4Bibg==
X-Google-Smtp-Source: AGHT+IF3OrWpc7OejIbVPtZtXX3Tazkp58+OYKEBr4C77IESsKlyzCZjxAI9cobLQgQsLSMOGxz2Dw==
X-Received: by 2002:a17:902:d550:b0:234:9fee:af99 with SMTP id
 d9443c01a7336-235395e2e4cmr164576335ad.35.1748843359148; 
 Sun, 01 Jun 2025 22:49:19 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:18 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v5 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Sun,  1 Jun 2025 22:49:08 -0700
Message-ID: <20250602054917.302638-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602054917.302638-1-rowanbhart@gmail.com>
References: <20250602054917.302638-1-rowanbhart@gmail.com>
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


