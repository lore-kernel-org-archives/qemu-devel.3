Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D677BC02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvGi-0000Oc-O4; Fri, 31 Jan 2025 12:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGg-0000O7-UY
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:26 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGf-0004Tr-Hg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:26 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso3887077a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738346244; x=1738951044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjKZ+am9qcsfWBWoHZp7I9LTEJOVk/eberiRYDxTa/I=;
 b=ZH+Ks9vP7oWOtWf+qGHhTMzdmhr9zMUqF+NWj/9cvPD0F6ZJRGtRBW2uc8lrrQ8NjW
 eaHSf6mW/AQGR5vhrXws4gF1mQqrZwqgpIp5iB48n+npPToUCL1kUF8e+Tff7AosinSZ
 ZgectYS245s8wJtC1AaxHqaNKJZe7u5JjRp7uiSSDiOFzCBYhm3vSosqewQh9/+mtjTZ
 tECbFdHVKQAK0Q/sBfJNIQV8+8bs4ZedjWd1XLRBLGpE/yBr7JjFCicm857ru/RHBwfP
 VHpILeS7UrixzSsky27Ov04QFkyoTdGnvMyCMIp6zzPfNOyDfgCFue8l0EWQK95XieLe
 +KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738346244; x=1738951044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjKZ+am9qcsfWBWoHZp7I9LTEJOVk/eberiRYDxTa/I=;
 b=XQnMsBqxr77gR32CFjnVB2ZmCa/2V0lkgIhqANkYqsWCcNpOyPvxXH9IeCKCmJqd6Y
 4EA6tcca8XjKGbKRgBoqzJIh38mzZD+FDAceILsjV/iJ/kWBEhLKBh6BX6nIGmmthyWq
 PuXr1XBvcfVqX4qgxq4tzVe5YADEy6HspYAReebz79QKD/Mbgy3bBP350pmD3wCLgNNj
 mtcwdKDAPOpXjBwDC7DOww68WPB5VAeUJBOwZnYH0ijV1lASuaJSOljFkBW6GFNHStcx
 CMYnodComp0NSCE+MQjdV2gc05LguMyH/5fUs/Qaq1NicTJ+1wnNk/+wbGvMP2O2DYx6
 AElQ==
X-Gm-Message-State: AOJu0YwJlsdLyjNS1yNJxw9+zGxSoxQz0eMl8jquVzdV2QPh2+35CyA9
 fpU84+33eDO6wWRjZKIeQJ5hK/Z+xaBoD6BRx/tnR9QB09oV8chjDu0B9A==
X-Gm-Gg: ASbGncuSl5frORKMgW3TIrrPXcqCmY9jy9QexZgXHSo4SPGfYZRkenc0oTw1ZZ+WSrT
 mQhPYdgKH81LFQ2sqcuA6GX26OenEycC4iXDoH6UU3njTNisqR7/stlD/0RRGzhkNRrgU3SKXt0
 QXW8LCZm4/11NTGwKUVqKbhhlIUDqHeh0bMlEHhnkv5Hi3qnY5jzUumWasKMW1OezHL3WotQ6RZ
 FAsS6l7DNe9oKohjcliItfKpoFgZZBipeGMCyBQJeoLIiKmoI3gyXniDPUw5Ci6Y+a43XOU4BfC
 09fp4fkclDk=
X-Google-Smtp-Source: AGHT+IEQ9HFdsQwt9F1SO8EGJogBmC+Nvr19K6G3JKTppyY3Zl4qgBSv8w+62w9g8tdnYkdQYDw7JQ==
X-Received: by 2002:a05:6402:5019:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5dc7fcdb6bemr4888278a12.2.1738346243734; 
 Fri, 31 Jan 2025 09:57:23 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723efc45sm3110074a12.32.2025.01.31.09.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:57:23 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <luke.craig@mit.edu>
Subject: [PATCH v2 3/3] plugins: extend insn test for new convenience functions
Date: Fri, 31 Jan 2025 12:57:16 -0500
Message-Id: <20250131175716.3218600-4-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131175716.3218600-1-lacraig3@gmail.com>
References: <20250131175716.3218600-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=lacraig3@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Luke Craig <luke.craig@mit.edu>

---
 tests/tcg/plugins/insn.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..5974e9d6e6 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -142,6 +142,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
+    size_t tb_size = 0;
+    struct qemu_plugin_insn *last;
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
@@ -156,6 +158,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
         if (do_size) {
             size_t sz = qemu_plugin_insn_size(insn);
+            tb_size += sz;
             if (sz > sizes->len) {
                 g_array_set_size(sizes, sz);
             }
@@ -188,6 +191,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             g_free(insn_disas);
         }
     }
+
+    last = qemu_plugin_tb_get_insn(tb, n - 1);
+    g_assert(qemu_plugin_tb_get_insn_by_vaddr(tb, qemu_plugin_insn_vaddr(last)) == last);
+
+    if (do_size){
+        g_assert(tb_size == qemu_plugin_tb_size(tb));
+    }
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
-- 
2.34.1


