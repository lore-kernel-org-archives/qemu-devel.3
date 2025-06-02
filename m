Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B3BC5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHf-0004Mo-3A; Mon, 02 Jun 2025 15:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHV-0004JE-F7
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHS-0004qY-1S
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-747abb3cd0bso3599731b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894228; x=1749499028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVvH7mjNJ3NtMc9BvSrVErbUcCZjCRkUKH2WhWYnTDQ=;
 b=hSAN3D063lA0PnJVPfmjBinvtovL+Q1Pu3CmkMO/5dT9SDvNFYdgW9RaJH0TTkKcbX
 H34+Fkw4kcUUzoMVdMUMQJYjkSU2chjiI5TTk17MzRVCBfQt0mDwF1VvUqZ1EntYaKeo
 fwDzRrikxrxjCo/Ez8/8bea18JcirFnX4SDm+x3jC+cBG9lm0VkJKJhtFNWzKh1jhyBf
 vb9pDm+QbcdRcJxL/GzVDd70UpKonrwGCPU0wS3TBsrVlPDI7KKAT3MnO7V7bmUvV6hh
 CPIr40lbyiK3es6wXbEzmB+hSQwocx7X3BstFLDkNPZA/PPze6AnkPXikQ/MPdCP9avI
 chfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894228; x=1749499028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVvH7mjNJ3NtMc9BvSrVErbUcCZjCRkUKH2WhWYnTDQ=;
 b=HnLQcq08t9gAD9v43u7pwah+t38jlx0+/6qyWHBnenkZpsmwjqrEn5LydH3jgEhJlA
 bJjoJYzV8us9631ESn1dcRt4IITSKVUCHMaTFLMEyTYMg7Qn9mbs+qmNc23JFm/WTxry
 nB5pbpQgJ6C4+CcPA7ZjMPx3rIOcpnUa7WmyNwmA64E27saEx8hKKQd35JVVREM/I8d3
 qc78MxsLAYo6nhZJevKgI6UjNsVoL4AybvXCoA02DMlOP9v40yfuGCSLYHYeNGnPSRAg
 sdS+r0HTWilnWb4s5cu0v5MSfcW3DL2DDB5soIpMna2WR/RgAhb0xj3lgnL46b8t7LS6
 QEWA==
X-Gm-Message-State: AOJu0YykF8vuMl+mDsA9ZQmqOEvCu4Q5ARb9SzplTM8paNe7LtI8EuVN
 uawsKUNICSr4D7rOxb1yP7vLbCKAfs2UIcJYb0yKOZYmAHY8fRYZMne7/Z28KetwufA=
X-Gm-Gg: ASbGnctQku5wHhqEXLfhCJpX53S6ha9+cFCxQtaQdW5EELyrvY/hrVHTfbpDWHAavXC
 ymkcXA/CzHgRpGx83S/0InqH7sgXems150g/YMIMNN2i3ixSzkZUA2xs94rpZZ+FyGWy5gFUNFg
 sfXMIq9VuCQqVsZ/7UQKg8PaB6rqoJpfNCbsyRxAENBq0FzwWG5BvqCOmK92b97YKkm5lE8RSav
 p5nwgYGifleFnEMGuIy9VGcXHxSvCOY47t+BliZr3qLW8fHKQHmyPSswRHUugBn2W8AVyK7fn6S
 NoSg999cDwtxCRNBd0FrdW1rAEwftYDxcaoItXOSqWXjWQwV1SMO3Zhf/zsTWQ==
X-Google-Smtp-Source: AGHT+IEI2Rc6lGqCYAtsD5tkvLgLmjZJccyP6PGS8MDCjEMLvXpWfjkkevZx2RMYZKK51PWDQpFK8Q==
X-Received: by 2002:a05:6a20:3ca3:b0:1f3:31fe:c1da with SMTP id
 adf61e73a8af0-21d0a06943dmr901515637.11.1748894228457; 
 Mon, 02 Jun 2025 12:57:08 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:07 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, novafacing <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Ben=C3=A9e?= <alex.benee@linaro.org>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v7 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Mon,  2 Jun 2025 12:56:58 -0700
Message-ID: <20250602195706.1043662-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602195706.1043662-1-rowanbhart@gmail.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x436.google.com
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
Reviewed-by: Alex Benée <alex.benee@linaro.org>
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


