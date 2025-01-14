Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A5E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFs-0005Bw-32; Tue, 14 Jan 2025 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFk-00057r-Qh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:39 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFi-0005RB-1M
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:36 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso155155366b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854712; x=1737459512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=AnAWZm3/ZQ0KCgzdufvHJBAb7uSvEPMiKF0VQAYTHgwj/4O1RZCdN60fMItA7HPnkY
 Z7jIxIwvIKFFwx/uefWOwnGdxtPcnKQKbEDhsjlLvcvcc3N06iiUVKJVLPguEKlv3CHz
 XJFpFn4YmSVwR43mG/yYQ3wGMqslO1BZiwpwEBNuCcfPTnADv7LMMQryW2oGLsRCmzWs
 4bBgwkUgN2Otl9/oR2v3RnSvpCOovQwpov3GOvAGekNJ9AnXBu/D9y/fvWl/kSOhgGJf
 vpYrp0ygjLULB5cNU7s16VOLhxHLpEBC0AwwsQnzscXO+exrQUrNE1KV8qT8Jtvyy1C5
 XWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854712; x=1737459512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=CT8rjsiwudBdVOuNHI9cRJV0S2NJi/dZQLtjbtbXe69UzRemBoPQrj9P/atFiKt/TF
 R4A4YL4i9SPK+cwddS7AnC9IyKsqDgKPA9+4XXgJP1wbj00LlS6DoUShbDCXuvaueFsl
 flFppHHwFmJv3kZ3ooTPAa+95JnIz1O/AlVpBGP13zgk6T/IV0LCD9FtFGFBmqcTqXH6
 Y3XIXcysX8gsGO7SdNd1k5tbdKFUFx3qza/WCn1jMLiR7CGG1JrOGcG2XaYjqd2MGXBT
 SRFP9CioBFRCgsHPwbgbQq48g/sIXkbLYbIMWcriQMosbFJAFSYg3qbBu2zXrceo/TBJ
 RrUw==
X-Gm-Message-State: AOJu0YwBrR4Az1k1FvNBPFnu9Q+qH5XLqTpY4+6+t4i3AZ3iPjl0MacB
 1nyrdA00eYeiDAAjl3zpXCqkqDrQZWMlYzF6fKxcH42ip4ydEmWfIZVqT+cMsRc=
X-Gm-Gg: ASbGncvnAdxsIux+xaO86RGIRiNGTMNb+GA7YCYxv9fYxt5AaUGXGWLRST+UQ+/xuRc
 7j4s0+UxOl8/hv2Zod4PgbS6vOReeFPTpr0V690gdql7gI3s0B01rmBngi75YkahpRO9Bz20atE
 7viffvccgV8SzvYMFLRY1iCs/UkVXxjv+EyE2lv/vZTZniyEAv9pUTIDzJmG7xwxilP4OZHHWYe
 yiY8OxCd+BZGEg4SX85svAemIYsdZc1nPXUU6Gqdl66RxwZKNL21BM=
X-Google-Smtp-Source: AGHT+IEE090F+kRO/dX1MM9kx0czTqeWJx6LsrGdEWcGMUI8w1xabnY92ZlPr864YyKDIDnUGHdbGg==
X-Received: by 2002:a17:907:7b86:b0:aa6:8dcb:365b with SMTP id
 a640c23a62f3a-ab2c3c5c979mr1787868166b.5.1736854711979; 
 Tue, 14 Jan 2025 03:38:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95647absm615118466b.118.2025.01.14.03.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B34A5F89C;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
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
Subject: [PATCH v2 17/37] contrib/plugins/hotblocks: fix 32-bit build
Date: Tue, 14 Jan 2025 11:38:01 +0000
Message-Id: <20250114113821.768750-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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
---
 contrib/plugins/hotblocks.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

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


