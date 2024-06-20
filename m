Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5566DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKKi0-0003Fg-8Y; Thu, 20 Jun 2024 12:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKKhx-0003FV-Ss
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:32:21 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKKhv-0004Ce-2z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:32:21 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d1012e52fso1218732a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718901136; x=1719505936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BETFTTWU9xVFhpYusm7c0IREOV0G6oO8cUsS5wkRjSk=;
 b=GKtnvsGhtBkn3rRQC4qx6bIBwHAILEFyXomr4R0Ah4zk+ksvjTolXa6pfyxqoyKro1
 RtNGxoomD3xS41fd5vgwnVq5PDJ0TVkWhYnpewmUgcrUiqRSKAda/hxVb0JVcOMrsk6c
 DAEBiTf0/HH2mEwBcrXKQ7jlmz2SNQ05CSDIRLpuCPTQsU6W2x1XeCFksTX+0HLFIa3V
 FIj+tVnYCbxuC1dcjqsumK6NNJhZN9j4Noql/x/4UvrH9DXQAEhXaeTNXj0xON3SnpCo
 qU8AkRXzLJgxaz5R3Rllo8FS2f0k2Sq/DBvIkz/U+5Uxh0txLppmoINBtAo/6Ozq+l1B
 Wucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718901136; x=1719505936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BETFTTWU9xVFhpYusm7c0IREOV0G6oO8cUsS5wkRjSk=;
 b=IuqF8j2i5TQPm7tJ0X7NCYNjiBng3ksCKTAiPToM9vc2Nvjq8LBY4jO7/XK5FdYrKk
 M4pzyQ3GIyOYJTEsDFcZ2eypkjOBu5hE5Y2EkPLMCwbXmtpHNcL+1/j1+XQNEC7R8vRl
 71IXSYFFLmCC0LxuH4v/fIxHdb1Jz8WrVUWy2qLznFAjfh5dutQKeSfCWbgiFqohrQqk
 6LIRJFemj8uFahCBADXovAL2V0uPt9IbqUD6jdSHI1LiZ43XEPcEvC8wW2x/M+az4cRS
 vu8PLSuG5+5S0GUbUf4GUH8Mi7Z/xgbYjFxewm1l5m03R0WwvlNZAFmoQA3q27Ef8M4n
 Q7XA==
X-Gm-Message-State: AOJu0YyTYNEoIz0QeBfWjjI6rmNGrJ4wKrCbieEZUFlySvCxMtneiccU
 L5Ppl6xHQSPk6lvmbdGkXdr3b2mOuPJnqib9OjRljzmkPaCuveId/+c1MhvQlXc=
X-Google-Smtp-Source: AGHT+IGjDUPllxGrta/5OsME+eNu18MwDmIOp0EbhhMq0IuTYsxv6FD6sA1HaiJnpiXEt9DNSyQGGA==
X-Received: by 2002:a50:ab52:0:b0:57d:50e:d76b with SMTP id
 4fb4d7f45d1cf-57d07e2c81amr3465198a12.7.1718901135916; 
 Thu, 20 Jun 2024 09:32:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e78fsm9927796a12.71.2024.06.20.09.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 09:32:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED5ED5F7B1;
 Thu, 20 Jun 2024 17:32:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH] hw/core/cpu.h: try and document CPU_FOREACH[_SAFE]
Date: Thu, 20 Jun 2024 17:32:04 +0100
Message-Id: <20240620163204.2213916-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There is some confusion about when you should use one over the other.
Lets try and address that by adding some kdoc comments.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..7122f742c1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -587,8 +587,25 @@ extern CPUTailQ cpus_queue;
 
 #define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
 #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
+
+/**
+ * CPU_FOREACH - Helper to iterate over all CPUs
+ *
+ * This macro iterates over all CPUs in the system. It must be used
+ * under an RCU read protection, e.g. WITH_RCU_READ_LOCK_GUARD(). If
+ * you don't want the CPU list to change while iterating use
+ * CPU_FOREACH_SAFE under the cpu_list_lock().
+ */
 #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
-#define CPU_FOREACH_SAFE(cpu, next_cpu) \
+
+/**
+ * CPU_FOREACH_SAFE - Helper to iterate over all CPUs, safe against CPU changes
+ *
+ * This macro iterates over all CPUs in the system, and is safe
+ * against CPU list changes. The target data structure must be
+ * protected by cpu_list_lock(), and does not need RCU.
+ */
+#define CPU_FOREACH_SAFE(cpu, next_cpu)                         \
     QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
 
 extern __thread CPUState *current_cpu;
-- 
2.39.2


