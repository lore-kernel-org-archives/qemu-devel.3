Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0207C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzD-0002cC-5t; Wed, 21 May 2025 05:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzB-0002bo-0I
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfz7-0001bP-Ig
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso2569622b3a.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820615; x=1748425415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsL+OiRjSHcs+rGSJPYZBhAIDimvy0y883YjsPcJU3c=;
 b=WkJGWtURlUDh3WZ3HeCYS/2LP+V8e8neQuJtAd2hd3c9nb5khBAy76qc32i3RzCwCJ
 8SRB/FveG3pAm+Zvm+4Jf5RYEIKEUaW6A/GA7ZsGuQfGs8KAvUVDrchi5v4oR5MjZWr3
 mJhd1Fo8ee0XgpqV6TGCK+0l7hTrGFhfG1vSKLtNZy/YkSEs8EXCVMzMgPAUWqTc/eL8
 Rqx4CGf0PhDciV59C9dg/2djcIvUwd7VlzsJIu4Z6ItR6y9eaGuKbe10wSYkKSw49WSJ
 8H0ZLp8fn70T7uYPFbQNhvJZDbR6FqPJA3gmwgzCmYYmxJl8ssvpdweRRY+5SJbbxkXy
 3A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820615; x=1748425415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsL+OiRjSHcs+rGSJPYZBhAIDimvy0y883YjsPcJU3c=;
 b=BmfyL1IBvp9d0zvvoKYL1R70iCDTBi1QA6whAFdMwSx7+7CmalWe3Eo8++EEYypiry
 W7e0WXftkHpvJFpaMfBB+WrECxr8N1HQ3BGlL4nXYUnq2S+JqiV9Nfu9wYYk/K6srQ1E
 /M9m00JKd4mMtqHD0hvipTK7GXlLuRAwqZRz02muynPVHmokI8Tn5cv9XE85OCYrf7lF
 DJ/wvu8gzkRflrozy+c9q2RvGvw9pRHs7CnoaYWYQtupgGHWr9Fjjpl772dtLyrN9y1B
 GaKJOLvJgPn/36f8QQPWxKmNuojRNDdjc+ihSpPbzvMi4Av6XTt2IAjoco5/4eAg2kPh
 DRBg==
X-Gm-Message-State: AOJu0Yw6ougUa921iH0AGgIXzZ9iwy8xAur3HmukXfdBqoVjSGM78tn7
 SSxil3ejWexypWgBm2GPSsO+advNQ3l0irYzzoVWP2zEO6xW/3hAYrL/7HNfwDjvg1U=
X-Gm-Gg: ASbGncu8RFGwC5i27VHlqOIYQP/O7rUpuInSeJREY8JuY3q5BdnOBemVD3qwz6U5jgA
 V6VxmXDMoGaeVLzE5YeVV536IM4ouXT8RtdP+MHIG1V9VH84CnzIC0VeRsEg/0Ok3+ntNQzT2TC
 srSGPKeiwTx7xUFWeLWgmmdIr9dE9+Fx/FIXr9NB741hC5FaxG+G/6FQN2iMmZJpQKVnBbTcjid
 49VA4BSL/rDxP/um0jenfJ+JCNVCAOQmupbOJl5pTXn2e7y0MUN69hOD5zt2c4jy2fOZgsnjjV3
 xECJEgImiE3AXix+C5ilmhcjHcAT19OhkoW/zfPRITiVbadmfyQ=
X-Google-Smtp-Source: AGHT+IHjVhTat9Lw9QCdKb+fY0D01nb4CDAX4nMXCk9pryB3mklRaA00mQC3LE78kQlvzplF+271JQ==
X-Received: by 2002:a05:6a00:3c96:b0:73e:30af:f479 with SMTP id
 d2e1a72fcca58-742a98ad9famr25092052b3a.19.1747820614766; 
 Wed, 21 May 2025 02:43:34 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:34 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v3 1/8] Expose gdb_write_register function to consumers of
 gdbstub
Date: Wed, 21 May 2025 02:43:25 -0700
Message-ID: <20250521094333.4075796-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521094333.4075796-1-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
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


