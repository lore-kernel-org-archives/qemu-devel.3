Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0FC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaDk-0007y9-Dx; Fri, 06 Jun 2025 12:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaDQ-00073K-Q3
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaDO-0003UX-Lv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so18926015e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228404; x=1749833204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7Q0I9KRKGwfpnxMkCGWptv5CW/tc1a4iSXRbv+1UdA=;
 b=L7lUVX3ZhJksjJsHmMc2UrRbMibCQBP3lWjrOAHTqvZnj/xTf5j82GfgW4NEbwEMUO
 QxkTbGaQ6sXOhtZ9tR7+NHSZyWuzx2R7e5shxWX+j9w7317IDi6uP6LE3+dV/Nz6hZRr
 SlfRDYpU0FdoY8dmQFizH1gmxFHZqX7pKffQIi0OAHKt1C5QdftsjPcaxiJ9eFx6pMxT
 NxGWK06wp2ueQwBz/34AEFu7Q6HRv7l4y7BkbzMOOUD5Bj/qykYCP3jmiVIxBchcaw7E
 kJk1J1NDYROJdoN1ta8DXAPvhSm6s6beexhaILXgTcYcyBCPpqEnuKY3xQR8BqghBfRF
 qvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228404; x=1749833204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7Q0I9KRKGwfpnxMkCGWptv5CW/tc1a4iSXRbv+1UdA=;
 b=LeKNqWTNWWp8D9Kmtc6K8TS4fbfq2GZ4XYvbP3pytkZbkwWpl2X/4SgGxgJKy8oyMp
 UmcJ1vJbxRY7vAd0UfxSgtoPgWxdiCHrpCidny7svZGCv4uC8hyE6XTEWTuPIUM7DRpa
 NvSEgss/nxwp7HV/2mTtQMmH6kyu7HsjbuYa6VW3XGZn9092Hm7dfnTj+iTTP8GOsCJq
 +JGlpDc/Gd8LYaH6aforR9JE/hjMepIzopDyT9VJ3iJJEY0Cru0yUS075IyNBevia/ky
 ObL3LmUl4DaqsUYEPtQFJgh1bD0MzNiDf/BBfJ0pWc9wGnZFNmWekB+PDYu/ahxsm9Bw
 3Z7Q==
X-Gm-Message-State: AOJu0YzuASd8e/VOCT62ANYUa8ADbDaW2E7TcZjPO7KaheM4bdoLzwdK
 RGz9pF17pGlrxU6YAr/wghUcBFA7o6V04UxuMsGczZRUKTidLPRG/ktZtLAk7CHgIhrn7+7evMF
 r+QZMtB/NjQ==
X-Gm-Gg: ASbGnculagMwedq3g6yAT3dgWnlgTBSbtnCMnaY/EqsMKKeo5XnvHN90OFMjJ6mLIYZ
 DO7Au4PjLRIz0RDbb05kwAmRWHJ8Ir7Bx4QqY7J9sibU1nlWm+vLYIHfrut7ZuMa915T9MoRzsv
 v0zSvfKoRzJFIWjhMAjjSWA8SoULMd9sANxFohR+EkbbB5ScQyO8tV0zhf1oQpFgweNnZUgpgJ6
 Gl6SHkD61I3hN0A1Uq3zVMtizeSATw5limLNwgr2LbpOL1Cc1QF2PeY2+EvWiMjLuPGWYd7+eUq
 iVxKYP6lgJqt8lQom+Rh3E5iRpdik9MYVH2Xqda+c2eJahuRzn1tT3Ifl7EjUWp3SB3Z3eHCdDY
 22XTgY476i+8XMIKHmCI3WmxaQHNSidsQo9IMd+ZrWInfcjpQ
X-Google-Smtp-Source: AGHT+IHcvLEM83tjXj8Ojh1eRgB4Rg2QAaXcIfoZDI2EebYgYFjcwFxCEgX0D0ygKk42dcS5KqmaWA==
X-Received: by 2002:a05:600c:4507:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-452014b56dbmr41284545e9.33.1749228403960; 
 Fri, 06 Jun 2025 09:46:43 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce5045sm29896375e9.16.2025.06.06.09.46.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 19/19] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:18 +0200
Message-ID: <20250606164418.98655-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index b8bebe403c9..c1b27d1b89d 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void whpx_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static void whpx_kick_vcpu_thread(CPUState *cpu)
 {
     if (!qemu_cpu_is_self(cpu)) {
@@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = whpx_start_vcpu_thread;
+    ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
 
-- 
2.49.0


