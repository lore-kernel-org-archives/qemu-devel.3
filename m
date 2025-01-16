Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63CEC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVF-0006XQ-HS; Thu, 16 Jan 2025 11:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTk-0003aw-Pm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTf-0004TD-8Y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4368a293339so11745275e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043933; x=1737648733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=Pc3/ma2Apvo4MIo7xCUs2rjDR+MBhM4s7bWKDDQDI7YAVtAJGr41x9EhBpqyL0O8J1
 yIt1192HFLoVvBpG/hlbPvgJTUQ05p8BDqSaLGTi9cXbSeU8kiflHfbVdHKCkY9Xly8k
 12Xc8qBwqGsLjNnrcuNA6kLqQ/2ox9/iCLV71uV9YvZfQnR/rEmMj0htvjnbMeKKYo67
 8vXHnVO3Upfhv4iDzsRhya7ZKba6MSEWcyALq0cx7GBsXlmxsDs6CgO4u9csdlOt5y1R
 I6UDqycKBUKB1e/0lqyIlJyswDdksy22PoO83UlNMJQ2v/xw9Zx810qb/oAjOiBrJa1V
 thKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043933; x=1737648733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2F/PrPslSIW6Y9g5K7Gs/QX6OA8vuL+PxeLCYDC6PuY=;
 b=oIGz2bFf6l7nDFesumM10SNQBzKJ+x0nPM/aDkKEKfmH/wxV8jgJXYchSfzimv8JQ9
 T7UmWHLWyZaaKtK74swXGVKTI288DyZVL3EJfnAxJOI7/7knBGbozUkEZcJvMexbDzq+
 9WHyVa8Hod4SVN3fRUR7ZvSSsUlye/kikYhre5sZG/RfAdI9Da4uL8VMQW+gX83NN17W
 PUef6vPpmdjG3U+kzds9jQ7oXEi3MGQI95Cow187ufV0nmvBAGjyG9bWvMNwpWN3oHPj
 O4enUFAoB2NguEx0ZtTlqddAo3l9FlSLeUxlDvjSk+NqewxDDutxohdvW5tUR5WQ39f6
 oVsQ==
X-Gm-Message-State: AOJu0Yyhf4abfaukrhta/x+W6sPBSvSCx70u5G+qJR2J+zNtXjkLIdNQ
 LeMq2JqQVPf5VJbi9ls5NLVfgD0bswqmX1p3SJhf8/beBlV0aAAcjgMQZspumEg=
X-Gm-Gg: ASbGncsvXGgXGN6wneKuALDeh3rMnvWdG/YK6qoaPv3mGAo7uzTk7HBEtEVqRQDpOO3
 enKBDazwKWiNbSY7sC7Q2ETklUgLAyBsUft7hESMeT6zc79HKJeeYYCo9U4Hw6eU6aPt4uA0Zqr
 V6itpPUPojm09AQzWR0uvSbq0+AkLJYmlVxEPVVdzsjpo5VJNZfB2xReV8kCsT8YkhiMqihPBid
 cOpliqAqR8ZOyiSLU/1oGnNLS66DWKXtZbFH2KxNwDeCWPBf8GbzsM=
X-Google-Smtp-Source: AGHT+IEtQj2jwaP35TM6na0Jb/o0gALfbWzWH3ofZp8IZxPASN4f6PydldzPs2YozR+RmsEvkX1F8A==
X-Received: by 2002:a5d:584f:0:b0:385:f638:c68a with SMTP id
 ffacd0b85a97d-38a8730b738mr29985496f8f.30.1737043933410; 
 Thu, 16 Jan 2025 08:12:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890408a66sm3915205e9.5.2025.01.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F85B608B4;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 17/37] contrib/plugins/hotblocks: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:46 +0000
Message-Id: <20250116160306.1709518-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


