Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A616DC83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2b-00009H-Ek; Wed, 02 Jul 2025 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2W-0008Vy-ET
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2S-0002qj-9S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so4356955f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453402; x=1752058202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qecS0tIoe0ls7nw8T86Ife3RJh0yHDOjkyPB/fpRPNc=;
 b=CRgHTwLi1KyGrAlJeuj/7GeaLxpxGiaya/KTLik6QDyxEA2krQ4ywr62VllKd2UyO5
 yxXPnqRxcbs1CXp4UQsc8XgPXZv1wWwfNbNI96YMgcE9fkqxfmvLV5+lDMu5d95Qt5+2
 UwRMBp5pXBJWsKPeHa+0As1fEMMsyPSuPrNWqnl3E+m4HCvpTY7cLcZa3AbO4ez2ecn1
 hW0KYwZ0bKcHIhBR374GGMbROPMkUw+YdF+fycHqY/a77G+Wdw49sCxyJDaw8sYQHNi9
 UVspaCcGJxXiQkVkUViChpKsHa3RHSGzboc+N9wuV9/JahDvdU1BOaASN8bXm7RTCS7Q
 1egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453402; x=1752058202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qecS0tIoe0ls7nw8T86Ife3RJh0yHDOjkyPB/fpRPNc=;
 b=mEGqm3KSrdrxzdZbmgVPN8MSYZpBmmUYj6dEQ/2oKbAmm/gz1o8+zQHgXHj5CaA3Tf
 rNKduYTe8XtEdQojlv9jJDOigpveJeZiOYkD4ZfanZD/1x/sGpXbg0BO9dWvB+FdJ5TL
 zARVccuBCm1Zeb34te2S/RhOUjA65gMYUlGnrXSRrMgpft991PojJ8J6kz3qenpy267I
 d1wri2PdD71IuHyCrQK+hY4mZJkQ41ypFfBuc8WS8qE9xv4iEYTiMXRTMaeaLI11VpTt
 eiO15ddAI3YdOj0sBqZas9Y54bAKimPY6fW3l/+L6TM8rTqJQyXC8pvaU9CUBs6qYvxk
 InhQ==
X-Gm-Message-State: AOJu0YwgNnsn4Lo1EitjprqJdH7P2s2gyYK+ZK8d2R4nY8719VWLtlk5
 g5Oiv/t6EGPK1UH5sssQBFbaVOrRMtkoHqIokRnLjkV/lhQnX+whwUguKd1P5x6N3TM=
X-Gm-Gg: ASbGnctRrdwYX+uzBoodsUpQ0ImAMJzlK9Zb/i2SHWHBMZ+fKH4gktfl0euXIoxFui7
 e480XY4/7/XQbV3qlkiQyhL7FH3d6TTnsshZiVuEqzUwiWt/bf55YB83xV7jsSPbjAS8Yu12bAi
 lCuiQzT87v1jalMrmvr2km9sds8ydlV7FC0mrWIBPE56rpSE9SX18CxsMUxIznZaTKqJ56WZfsf
 k3gvL42J8fsLDUTXYSpmH7t3bZZcYUSqYO0uVgLBtCN/Ipz51yYDbceXJuavIlvijgPvkcVLjZN
 hDWS3fWOHithnU5cIhRzPjG95GXfMT6GmWyuLGpr6912nkojg/EzUh1FBM+ypTY=
X-Google-Smtp-Source: AGHT+IFL2PE2AJ+xQCUS2fVQcN1lbEsCtdeFS0mWYSdYW6d9/wuxiYjI4L3FmsLxYxqrArG2Fj9seQ==
X-Received: by 2002:a05:6000:25c8:b0:3a5:2f23:376f with SMTP id
 ffacd0b85a97d-3b1fe1e7861mr1690602f8f.13.1751453402426; 
 Wed, 02 Jul 2025 03:50:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7386sm15587399f8f.20.2025.07.02.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DECE5F8DB;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/15] gdbstub: Expose gdb_write_register function to consumers
 of gdbstub
Date: Wed,  2 Jul 2025 11:49:45 +0100
Message-ID: <20250702104955.3778269-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-ID: <20250627112512.1880708-6-alex.bennee@linaro.org>

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


