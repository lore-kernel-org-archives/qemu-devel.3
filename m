Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3416C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdM-0001Gy-Ap; Fri, 17 Jan 2025 08:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0000zm-Tg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002Dy-81
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:10 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso1065104a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121385; x=1737726185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp1WT9YSEVD+JiobR2XNVwHS259ESWVfvYJkMEpr24k=;
 b=tiMTOEcaNlqmjOTANFWEHUpKWBRw5+j2mIwQmF0WYgH4G4Sat5hI2qQ+E1j8gko/cw
 FL2c5c5Kt4qudVkPejUSN7VKQmhA7Gm45JejIwIm+qJIdmxxQfM43Z2W/o3lhTwqbmEE
 TXF8T22zTKoorXiQ9KB8CFSi7n/rzGlMyTAP3zIuqjqmVC5A0ZyMBKu9WQIi/WsBA5bM
 Dx9IEgN1pFtM95q8zkHcYIvosgVaeZlyJGdB1jarLRLPeidGqdkCPgE2YXKOHVz1yfT0
 O4PtubUE6oXNJUzv2wSpz3zR9hLzjyWQxSa7sUbsEArB4itiDyZTcI7ulinkf3jdtgZ/
 BdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121385; x=1737726185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp1WT9YSEVD+JiobR2XNVwHS259ESWVfvYJkMEpr24k=;
 b=Ocxpy5kc7jHVz7lcbsoh4gRqs3eZhoSRXn3SfI/TCnYEBJyEKE6QvQ6UBwDvp4+Rp8
 896S4+W7gHf5MltKDKS3T5Bth7+GO+8Fgzq9Cym506tziIH+5b5o1TwWTNl+dGsW+qQM
 v+uiYhI/sIGN8ngKBllej+rqmB97UFf+7+SLiy2IicUEcG8biuXg8XbYd1lD2RxpVJnV
 h5tU4eI7c/In5g1azm3dGEAkcMVxaZcxIYVMYl9TW3W3LSf8FL6wGz5iAKjGNn23wZFh
 uRZbUxFFEgI4GWABYFquIYcdEgPHA5ElpqsQ1u7fwhrhGa3m76TOBb6vhl7RknaciqVu
 tLsA==
X-Gm-Message-State: AOJu0Yz0vwlof1/yCgcm6iTFlSmudlbqpbgbcg6Y/MoAkFtE0zZlL6H0
 YcewtwrfoCLGBNLoZ58j9ZnfNKWaJeL0kbr4csf5cU09MZ7vNIXFghranakCgW0=
X-Gm-Gg: ASbGncuSTAqjiPkir8Sr/Lx8z8mGnlb3eAL+YgrSC7ndXc+V/eQYYQkg9/2ZgocsoFX
 eABxiI7V/ZZS7N/BHh1RrXYdc+XQz+n1cOTZ5ptKNUsDh/5Tsgnxn7UUr0hzFgn+Cxn4c539Ai/
 BrNXut1S5c3uN+mjtY+Aw0RyXXArvXiO//emutxvLuK3bxeR88NAqcC0Wa/ggqd6VjXCjSs5XU2
 49Ve8uJWOYzDn4XWUmHybBcPo5UVT30MTcmOg18xv45U91ZvdL4kWRcNuWoA5lKzw+R
X-Google-Smtp-Source: AGHT+IFqcSu33mVpmJKPtAo6h6+TUiVl3S1D8RpBxPkxNOKol8acRgxO0L291zqOrWJsLaGhx4hOHw==
X-Received: by 2002:a05:6402:5188:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5db7dd0c8f6mr2075132a12.15.1737121385256; 
 Fri, 17 Jan 2025 05:43:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642c1asm1487113a12.5.2025.01.17.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80FD3608B7;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 17/37] contrib/plugins/hotblocks: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:36 +0000
Message-Id: <20250117134256.2079356-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241217224306.2900490-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-18-alex.bennee@linaro.org>

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 02bc5078bd..f12bfb7a26 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -29,7 +29,7 @@ static guint64 limit = 20;
  *
  * The internals of the TCG are not exposed to plugins so we can only
  * get the starting PC for each block. We cheat this slightly by
- * xor'ing the number of instructions to the hash to help
+ * checking the number of instructions as well to help
  * differentiate.
  */
 typedef struct {
@@ -50,6 +50,20 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
     return count_a > count_b ? -1 : 1;
 }
 
+static guint exec_count_hash(gconstpointer v)
+{
+    const ExecCount *e = v;
+    return e->start_addr ^ e->insns;
+}
+
+static gboolean exec_count_equal(gconstpointer v1, gconstpointer v2)
+{
+    const ExecCount *ea = v1;
+    const ExecCount *eb = v2;
+    return (ea->start_addr == eb->start_addr) &&
+           (ea->insns == eb->insns);
+}
+
 static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 {
     ExecCount *cnt = value;
@@ -91,7 +105,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
 static void plugin_init(void)
 {
-    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+    hotblocks = g_hash_table_new(exec_count_hash, exec_count_equal);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
@@ -111,10 +125,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
     size_t insns = qemu_plugin_tb_n_insns(tb);
-    uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    {
+        ExecCount e;
+        e.start_addr = pc;
+        e.insns = insns;
+        cnt = (ExecCount *) g_hash_table_lookup(hotblocks, &e);
+    }
+
     if (cnt) {
         cnt->trans_count++;
     } else {
@@ -123,7 +142,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->trans_count = 1;
         cnt->insns = insns;
         cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
-        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
+        g_hash_table_insert(hotblocks, cnt, cnt);
     }
 
     g_mutex_unlock(&lock);
-- 
2.39.5


