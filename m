Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432E4E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzj-0004oG-NI; Thu, 09 Jan 2025 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvze-0004l3-Vs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:50 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzd-00072B-95
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:50 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso222923466b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442408; x=1737047208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=iriQPbttMtiUPNR7aL0ojXwpi9tYW/wZyZgXaG/hyZ6wLIkkT5fA318dcga0MeSDnV
 7s795eJiYjXFtGbPryTAvWK1Q4XLL67CYgzr3mu9AaY/6/blLWLNU+rfu3KMKdGcnBqJ
 9Qme2C+9IvuBlShBX2EBfCAPgolDKQCHLVf7WiQ4VoIYwHoyngd7Nhe3NeiZbxRcQFY1
 wNZmF/3YHefefArnLL9IJ3vd1mZNtnGebVL+cXUzyKkPvH9uo0tnTiILCx29AxS3kzfl
 9BNaaFTzjvDv0zDBnY9WHPt5B1lFeR4ANv2mky3tFXg/6kuJ7FWpVyNMdmWeWRhz3/nI
 Ty2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442408; x=1737047208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=WLJhgrqs9izeae8C8Oude4/7s2VHqWoaHKHBlvUxWTpq3v44Vdj865J6fqX3fPArNZ
 2kMSALSzV1Rq5CK1eQiHqmP9BNEgUaXngbl1JD12P/JU4BHsVQ624vFaDv+jNcBqpNAP
 Dowm4RjN1mrRZ2Thja+bKgCn3CYu6ZmK1J1v8nkmleY2vHnis3kpfeEJRNFVgsb6vvP2
 VCVNnmkRV2rnh0J+Q4CpDZ4ZNkldagcOJJy5mqUeeQJXP4Y1J1OypU8ClSWLqD2tJ8+X
 eqsZ2ysWMLTFyMIpzqU3Q4DzRocW5hsLLcdCPbB8n94R4jE9JretwlHODfmkLnyNnfbc
 GkPw==
X-Gm-Message-State: AOJu0YzgqedBRTwiGnZbnrtC0bSTYagV7LKAQ+addq3qU/wcqmKaGLsb
 acDd07WaL6RdJ7xFpC5b+EVAocPDCfY1rbIfXvr4+SUyaKR0yRhU+GkVQW/1xMw=
X-Gm-Gg: ASbGncs+Po41Ax9DEAzscGxIJvAecoMhmSsBFjH9wl9lAZjs1t4WMSYu+7QBTmLzHT4
 hqeF24bK07BCWWWZRucZ3dNZW4Ig0LgmeyDF7+vm04al6t650k1G4/kFS3t9RxsG2Ll2vt2rICl
 5q4U7JEta/2bIYGXbzD7Ap+2QN8AOtUxLN7C+E+HIjO16p49QiIuw2SC9awAkT2HwkbV34G9SJ9
 5vgOCKhlW0owmL3LyzePMd8a2r6e+1HyUcaCvATdZ15TZIGunOG7ww=
X-Google-Smtp-Source: AGHT+IGkG3Sqx03sunsXHrAdzcDJzDkhD2nSfC373aoX8cyj0bTKCNYibmF1Xjz0jeXeZdMvFCh/aw==
X-Received: by 2002:a17:907:9687:b0:aa6:912f:7ec1 with SMTP id
 a640c23a62f3a-ab2abc779dcmr717675866b.39.1736442407621; 
 Thu, 09 Jan 2025 09:06:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c96461dasm87969866b.168.2025.01.09.09.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 692BD606A6;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 17/22] contrib/plugins/hotblocks: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:14 +0000
Message-Id: <20250109170619.2271193-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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


