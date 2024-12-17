Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B228E77186
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3h-0008I2-Lp; Mon, 16 Dec 2024 20:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3d-0008HV-4p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:29 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3b-0004yS-Hk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:28 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so3113031a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397646; x=1735002446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4yd/tBwPNPBRY/0J+B/Kg1jzHM613LeB/uGZ5OlcYk=;
 b=K2xmaP9Pw9PUacevACZWtRYiwodluRfZl2IVVNxG8lxLUbAVz1cWygBlkccjBUVO9n
 IA1FM5IuzD9AzUTKPQ1gZWext2UWeUjh5kJQK3JEK4DwmNHqLc7+GYrFYZqNTKIZHjd/
 yIKPSTUiZWOfXd0gQhW9n5zANhm86lmyXnt7JjrwLbHu01t4lfERtQCh8qOpXc5/UeZF
 MZdhLmMOT/el1VVNoLTxSyi1r085UOu9i++Z6KnvFM+HqP7t2b0NhFP9xjSR0GZpkBLm
 9DXUYMwrvDLiFM33yzm86x3UCdKP+n7gh5i1KG6DJTGBpMNXqaP5Qi9IxRG81eCaWIDZ
 bBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397646; x=1735002446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4yd/tBwPNPBRY/0J+B/Kg1jzHM613LeB/uGZ5OlcYk=;
 b=vjoaPGNmTM8+pDfYAu+7O0+QMGWdGWlmK4rPyd98GsJ8+Xc7YWnJYtQSE1HtKo8v0+
 zzmAroN8+zSXO9AV9GAUce/1NX0ehZZSW656AsZ7mmsLf5xfUO9x/g9hygIAyUUliKgf
 BJ6tMWnhlcdg6arwe858bVtQCEVBRAoHmO4fMcJReV86row57FMzqPOoFHIRV8nhEGDp
 1a/qeVLVGYrUlmAs4Xq+RCh7TroixljON4wAXZiimBIcdfqyjiWURdgIW/q8KoViF681
 DD/WuEPerYYEggO+B7g5sCh3g0GQKxpVxCUlGtdcMiDnYk+AMhQIebbuidmFURME8yKl
 aQ5Q==
X-Gm-Message-State: AOJu0Ywdwx+ZZjwwkySs2RGt2aHRslZp6kXSNUCApyCqXzF1x8Q18fkE
 YDREDq5cFwDsZyqA4s8Hoi4cKcmrqCyn04lH+3r2Sw4M15p4Vjo4qkHc8F+lgEt0ulLF/olMshp
 i2xY=
X-Gm-Gg: ASbGncteXVu8axb+EAGYR6FD5FQdU5FvX44HXNhpBA3eiUQJGcMLzZswJ1m06Se+6al
 xu68HgAe8jZ1J/zRPMe4olw872yuqbGbZce0UrjwjFvWxJ1W0mVHh4+0Ia121ISR99VKvqOQ35T
 B4zZQaDhW+OWw5AcqmrufZE9vbTd4wqXkr2HxeFwEpqdPHDD+sMAIM7H/jmypYMDVL88eiVbnWd
 cZNRzSdo5c/3fArejWLUwyfXtM2x6DIuPJuYh5Z9g9jUivIQuIl8G8YBL7BiYxgsbvmYfyCz3JE
 esMbmPrKFgYQb2w=
X-Google-Smtp-Source: AGHT+IHR6JZbza8aEyEMkScKl3yzbecxn8Y8NpROIDO5fbxiHeY88O1XMfa37Jm9qVNFctmO3lXkUw==
X-Received: by 2002:a17:90b:2fcd:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f28ffa7e4dmr18261917a91.28.1734397645981; 
 Mon, 16 Dec 2024 17:07:25 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 09/13] contrib/plugins/hotblocks: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:03 -0800
Message-Id: <20241217010707.2557258-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
 contrib/plugins/hotblocks.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bdd..09b0932275c 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -34,6 +34,7 @@ static guint64 limit = 20;
  */
 typedef struct {
     uint64_t start_addr;
+    uint64_t hash;
     struct qemu_plugin_scoreboard *exec_count;
     int trans_count;
     unsigned long insns;
@@ -91,7 +92,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
 static void plugin_init(void)
 {
-    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+    hotblocks = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
@@ -114,16 +115,17 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, &hash);
     if (cnt) {
         cnt->trans_count++;
     } else {
         cnt = g_new0(ExecCount, 1);
         cnt->start_addr = pc;
+        cnt->hash = hash;
         cnt->trans_count = 1;
         cnt->insns = insns;
         cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
-        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
+        g_hash_table_insert(hotblocks, &cnt->hash, cnt);
     }
 
     g_mutex_unlock(&lock);
-- 
2.39.5


