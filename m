Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B10EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdh-0001cl-To; Fri, 17 Jan 2025 08:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0000zp-VH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002Dm-82
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5da135d3162so3483191a12.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121384; x=1737726184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7WoTOR0MdrCgpCyDuf9KKFcIa92OwQaEc+knkLDVrg=;
 b=O3IXrqWSOtFiGqaW7arbGmjO2Iik4lXM9SZYuaH4Hx2DBMRCZOfGoMxIYDkao5dGxZ
 d2ZN8NTYxv3d3JKZcTujsVqKTr6tGvQRkVHbRFgkNhTGWlJrf+aXc+gCZ8dEo36764pO
 9yOolJqCfAlNgbQJkWOx6e2p39YIjJ6uU76brIZnfc3Fiodf+e4kKuy546jZPl5hvRHY
 AzxJYL5juZQ/wyHaFXS5279Ht5Gh9aRNpcjEuAS3Lz7nZz7cQ5wOJHxutfaJJPxo5A4W
 mwc4QbUB0ZNlt6ZEu2MKnk22qQYLX7h7tpgpDNhwuwl5KrIwlNLduKWckq+2nCgRSc5n
 2ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121384; x=1737726184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7WoTOR0MdrCgpCyDuf9KKFcIa92OwQaEc+knkLDVrg=;
 b=QpWFjKUNiKQWv5IGhcfKnPDqGx2S87EpdlPz+5bIIQ0elLpXiTe6wdD278H1WIv1Ge
 GTEPk/GOJ11ehSVWP+CzJgKpZgjHIRIrxJW1l/wU8lgai6np9RG1r9sfYAzEWMslnkqb
 S43WTBx4HuY4NUDa3MTO1g4KRAKmahrkqVV1g1VsB+oTRxmm9i3lHqRHNVXNLAbym3nW
 IILIZDsqXBoLZ8GKSM3hEDMuViSPuHJbm/JzOwUCk0Hyq4vNaK1AE3hV/cb7IM63Plyw
 TQugh/I1gpUuME1ciTTy/f1pUZ5f96lFa0X7DQTgp9qiVw1Py8X7jgUbuFFsNj7N28Vq
 5NhQ==
X-Gm-Message-State: AOJu0Yz6s/ko32ryNJDDU/TpCmrpuyQr1nzmMiOQ+WcZXhgY8+sCdv/r
 /UGROkZTZsojOIAkOGiiasU5Q5xhoKLTCGbBZpxnVMMSGqnWb0eVjVkj5naRC5c=
X-Gm-Gg: ASbGncsOSk//ka1eY+wZEn1DVQuRF3JMPdQv8+avq9Sye6kIXIuA8wAsXD8GFUFk3sl
 ALPa6EFAOYPYpauh20HXipHIb5oZUOa8X+07SQNrqNhdm7uIEjSjzXlIDPSIjWYpBpBMl78wlOd
 1+Qae9xy3nsaUG9BnGcWPRlUB+hVl5Avb6XKnaOyQf6P6CLukX0acYlT5IrvkDHpXHkFE78MBm9
 +Z2lCLiOCZzDF6TD79N8Whn5E6QsRREAJEtqMj5+v+IQ5KRvIj8BP8=
X-Google-Smtp-Source: AGHT+IEoLtMQoq5IgYdb4IfLBUY7rRrWjshU6aAPF4O59CNT2YXwin4vNb4tnVS1qMAkA2Og6ZmdaA==
X-Received: by 2002:a17:907:7f9f:b0:aab:d8de:217e with SMTP id
 a640c23a62f3a-ab38b163550mr267921266b.26.1737121384191; 
 Fri, 17 Jan 2025 05:43:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcb262sm170003266b.169.2025.01.17.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EEF760890;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 12/37] contrib/plugins/howvec: ensure we don't regress if this
 plugin is extended
Date: Fri, 17 Jan 2025 13:42:31 +0000
Message-Id: <20250117134256.2079356-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-13-alex.bennee@linaro.org>

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 9be67f7453..2aa9029c3f 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -253,6 +253,8 @@ static struct qemu_plugin_scoreboard *find_counter(
     int i;
     uint64_t *cnt = NULL;
     uint32_t opcode = 0;
+    /* if opcode is greater than 32 bits, we should refactor insn hash table. */
+    G_STATIC_ASSERT(sizeof(opcode) == sizeof(uint32_t));
     InsnClassExecCount *class = NULL;
 
     /*
@@ -284,7 +286,7 @@ static struct qemu_plugin_scoreboard *find_counter(
 
         g_mutex_lock(&lock);
         icount = (InsnExecCount *) g_hash_table_lookup(insns,
-                                                       GUINT_TO_POINTER(opcode));
+                                                       (gpointer)(intptr_t) opcode);
 
         if (!icount) {
             icount = g_new0(InsnExecCount, 1);
@@ -295,8 +297,7 @@ static struct qemu_plugin_scoreboard *find_counter(
                 qemu_plugin_scoreboard_new(sizeof(uint64_t));
             icount->count = qemu_plugin_scoreboard_u64(score);
 
-            g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
-                                (gpointer) icount);
+            g_hash_table_insert(insns, (gpointer)(intptr_t) opcode, icount);
         }
         g_mutex_unlock(&lock);
 
-- 
2.39.5


