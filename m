Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DAAE77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3b-0008GO-1T; Mon, 16 Dec 2024 20:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3Y-0008F9-Lk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:24 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3X-0004xF-19
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21644e6140cso44505455ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397641; x=1735002441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kntzVB1MiyL7bevKjAuLTyrUWmHMkhYgMIBRD8JjWYI=;
 b=CpzI3AA9cQ4XB246Icho+c+lwPNhKHVvLda3u5kpJQKLJtWahN6446ZTm1QHYqoMFI
 uyw3IFBexQB2TZYXlk1i6r+M+bP+SZezASdCakQOCNdcNQfyaew47XG6pgkmbKFSxBuT
 eG3j9QtGy2laxOhgWNSGkCB6id0lOZ+5WDJn2DNvTN6KL25IXPGxuA4kBO0L6/o48qWm
 yk9s0Dfqudg6DhpOH4RfhbegfJUvK9lQGogEns1uOqYB8SGMXypjHN1X6ZJl3dZp6ZuI
 hGh3CFbv5wBvXHdLBP76aqtadoAWenJJ7jXTfeTymqwTnNms3S7hpHKMbkpXMgs7aIuo
 rKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397641; x=1735002441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kntzVB1MiyL7bevKjAuLTyrUWmHMkhYgMIBRD8JjWYI=;
 b=WItOxb6+hS67cWTquSIInYvtKPrKUwY1ouQhPQiF5RWNytyq6WXvjR+bMx/RQwRUCd
 dlv3fZRPG28KIuD9YTUY0/Yyn13NfZtLG7h8T6WricMx8qzDsEQZ/SdobTQef5mWuGsl
 /y9Fefaep8k1Kw5oVXJMPmXAEHHjLwl6/uIPhSzUOn5oQaxNIQxPpfpWcZsC/OzCh9wI
 iWIH3c9lp/68nNx2qOwTBOnsyMKKwQukBMtg1Wb89L3CylmqfZnOnNISgcIfRKULOjgY
 BkLKqWM2EFL4vNSBPaU9uJGIHm77GcwMlqxNW+aiOh+miqVyt8PVGLBMIT9r8lTffFot
 3Sqg==
X-Gm-Message-State: AOJu0Yws6lU83PaqZ2yQ6YvaZ3kzgnSFvP74FbUinOK3YFYu8ovhLJdu
 agFOJ61EfXW30aea8P9ybazIBWJ68flfxuDsATQRPm5J1ttg/oBIXGK9mxxwKT/60KFXr1vkJrP
 Hfi8=
X-Gm-Gg: ASbGncstmNolICb2RZnWQMtBist5xTOaRhXGynqOZropqWJnbVqgXdQ77TGOmPSkF9X
 Xg8wzFyYHHl+09Lw5IH7WVpRVYpO+H0ocup6ZkjjkQiz2N3FOiv1DppK2UHkYY2meTBP09LoTMP
 j5gtB9QhR7nMkFlG1Q296Lmuy2G2lw9KVmypTqnXpqUJwy4SqiI+OXkH7ZkDjbwj5fL0JC4Xtxb
 5lVGoFd737jHKjH/bk+aeCh7hzgo4xQ9zlbvmAj56VpqQINd6W97M9bvrVDO4wrNX6POyo5/LN3
 NwTiNsaWsLCVVVY=
X-Google-Smtp-Source: AGHT+IFRXVdNKNMxJlyTksiEPszX7f9vq64ae2N8gkxAsH3rW5VfVbXTSewSIMl+q96E6m17Brq0nA==
X-Received: by 2002:a17:902:eccf:b0:215:2f00:67b1 with SMTP id
 d9443c01a7336-218929f1fe1mr175448485ad.6.1734397641651; 
 Mon, 16 Dec 2024 17:07:21 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 04/13] contrib/plugins/howvec: ensure we don't regress if this
 plugin is extended
Date: Mon, 16 Dec 2024 17:06:58 -0800
Message-Id: <20241217010707.2557258-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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


