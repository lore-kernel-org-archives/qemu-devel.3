Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4015CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFq-0005BF-Qk; Tue, 14 Jan 2025 06:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFi-00057V-8x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:35 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFf-0005QT-Jm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso7797200a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854710; x=1737459510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=VqkFhMALgP58Nuydp6Z2aP9VzLtD88mUC4O2U+UmVRIdTNnutRo+szxDgsW0mzO+rb
 wBOksxD0PkyHEk3aRbziqeuTwGjESpmoJi6UQYfx2CbvXv260j9eCAAccaEyC50WZE3V
 TGSuix+YIZXuMW6y+DGySdYyjfcoXs7wfaHEm3MWirQ+5BbKvYOTMNcSAliXqeP0LAH4
 ytadk0c2xP5yB2YjD9Yj3ZMj3GruUFLz0e8JH1s3oC5S6ROdD4fwGiB35R68PA7DDWrC
 zIqc1A70g715vRZ66x7MNIc6xRze9v0GpE1gWcQAsTp/QLu1ALoDzMldpHLMxl+bDRKc
 qxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854710; x=1737459510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WxsgJL7chOGbG+/17n3vpjWqUAThC5sUhtSd92NFE0=;
 b=jpJt8VcA5LrU08m2DkMhdTWQuw+hqm9obrWobGdMW+xOXcADg+IqFj4tQc9vSENTph
 oOv1WynWRsHPT95s9TJfLdPA9DOsFjA7fMVlct5lSjGhR/7fueIRnG2h2aa59NHoAdKm
 uhMRZ6hnCNtaZOFWr7THkl2mJfcaqOLwlIA6Y1QDNxE1Jti+aXP8bR7v4gmHxpZSvbn+
 EZaBFAcNwr1S6aAMBPcRpGWefGYLymq7rNUGmm8y/Q1E9p1v/DuuWqayDUcJue9IKVbi
 So03MBiu0NentH/sST6eW17/HqcQwrFeKpsRT+w4A8zkLoo+Qy8nK4WxYAlTEw50BGLF
 zggw==
X-Gm-Message-State: AOJu0Yx0rRjrtYginajGYIL2/zQa/ilTyvRAm0DC/HQV3Hhadbzk1FGR
 es6ZLZW7K4qJ2HTvJRJtigJZVM4GTauEujOJGVK0eOX+ZdvT/BuoX4NF1/R4WdM=
X-Gm-Gg: ASbGnctwDuNwk/gXNyPeUop2vRiVacLmZkRPMpm4caCv5sAYINnO4DaJWbqC1TY8VU5
 +aw48U8YyT27WBXb7Mex7sWO2ubZyJ3keaaGHDXPCSfCzfeBZk9gC/ktW7lGGq5jOf0AY6nkXbw
 cY4UGVev4aW3jXRPA3Cp0oruPtabZ9FvonYF3/FJj6p9vwatSEfY9gwnNvd5Q5cv7nc8ICtvqM5
 3t9e+ZJmg4rSOXX7ybS/oHTXVYwrP+G9ixAG+WUMuAdbEMMNVHHOx0=
X-Google-Smtp-Source: AGHT+IGJAqpt2tEiJqlAItQL8jfzgMOqCspnBLLLDaDcQrsmhNwbm4CN5hvm5mIT1bfaV9ugoFl/Uw==
X-Received: by 2002:a17:907:3d9f:b0:aae:ef24:888d with SMTP id
 a640c23a62f3a-ab2abc92349mr2514136166b.55.1736854709927; 
 Tue, 14 Jan 2025 03:38:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b09b2sm624652966b.146.2025.01.14.03.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC4B05F9E9;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 12/37] contrib/plugins/howvec: ensure we don't regress if
 this plugin is extended
Date: Tue, 14 Jan 2025 11:37:56 +0000
Message-Id: <20250114113821.768750-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
---
 contrib/plugins/howvec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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


