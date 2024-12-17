Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F8E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHj-0004LJ-18; Tue, 17 Dec 2024 17:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHf-0004JG-8K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:19 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHa-00018u-De
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:19 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso5228161b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475392; x=1735080192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOzYfBh0zmSLp+iKqt+C5cDNqScuCpesF/tusP6QFbo=;
 b=rEWGNR369wdoc06ayRxkHSUnPdDE9NKxzf5Kivzx16yYZPMZSaStqaMJTKNMeVeZGZ
 jfDawKWGULon7JIXsAzEevh0LKshkStIbusreQ5ANzduQtp7LjBQlUlJ5+mPd+7sGkJV
 L/L1RGJfPiyj3FFWvDFePVTCyzNxKLfFV15XjTsJJqW/bkKNz1rmCG61zmvChtSmFgVn
 c/ZM32y3GyTB/08AAC2Z56GcQrQRHeQhhaeLXPNA5gMrApzQv1ZAGqjHelT8BwHLIEOg
 LSGOYWNrvzR4gW0eSw9P2etLExL8qa2X3keST39vey9GjEYbraRUC2aiPcgRSTF0N3uT
 UejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475392; x=1735080192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOzYfBh0zmSLp+iKqt+C5cDNqScuCpesF/tusP6QFbo=;
 b=hp91nQqv+pP2Zx59YmmyvRZfyaCG5RL4rlmkugwQ2L0a81ZQFVg72OhSBG5npg9Fj4
 jvRurS1OZjo4I5TKfGAOd6Unzwn+CHyzir8yQUKJe2aqH0drLmIEDGv0WZj56ZoxCnjg
 b+Dw9gqMLYQEda9P2FTeez7zwDfdAuOLemfHZVRixiIBGTUfsuit9kJZDwDlxhgquokq
 J6BLQTOcth2XpF4V/xbkd+rwjCVX3CUbGHDSvYh6ObiM0eRt5QwTu1b5/XxZtX78gzKK
 f+ob4rVJFHKUa74FIjzUiKV8KBaMkDIsYPO5C4YLQi1wXfn0Um4VBT0VSLa4a4wIQitu
 M8zg==
X-Gm-Message-State: AOJu0YxTC/V/h2+UrxrieZqfnSCytU9jJOfqUe0Rky5vcKqs/wpPT6Rv
 pujUCQEfGogzI8er0GYOsSr2+9yBQX+CAB7C8mn/E7xrDQYF9bBjoUTgb9Dp477gUbus+n7lkx8
 j/2M=
X-Gm-Gg: ASbGncsvZbz2mnwS1jNYTRkFgiG8mKpDwqCCMtsasIWzqx7FoZ9be3pwpHUxymumsqw
 CK+y8NWMGxZSJhXGIEebnOd7pxvb2c8+3kHpmfCG/aHjLMdIRzGREQW7BqFSJ2nVUYVR1MUqxQp
 Bai/sB9+CPhUMvcw7Udtq7gm02fahZ6TqyzRz1Nmbdwxq8gVxPWxUY+Zc5K/+0yYws64b3gUkN2
 fHxqkDH5s4g07GtleXonesZ6Z9WMSnl5yiQRE22Tf96IdLIppzaUF35
X-Google-Smtp-Source: AGHT+IEUxcPkbKMgJH8DF+rpWL0LnbAVVqUrC6NlUMoZ/OUexBFb6RJ9bcwqusG3AvdU7hFLKEfDCw==
X-Received: by 2002:a05:6a00:21c6:b0:728:eb32:356c with SMTP id
 d2e1a72fcca58-72a8d2611f2mr991827b3a.11.1734475392496; 
 Tue, 17 Dec 2024 14:43:12 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 02/11] contrib/plugins/howvec: ensure we don't regress if
 this plugin is extended
Date: Tue, 17 Dec 2024 14:42:57 -0800
Message-Id: <20241217224306.2900490-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/howvec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 9be67f74534..2aa9029c3f0 100644
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


