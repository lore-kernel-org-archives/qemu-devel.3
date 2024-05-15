Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7EAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rt-0004J1-J1; Wed, 15 May 2024 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0004Gg-FC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:14 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ra-0001ZV-5d
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:13 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e45c0a8360so67668981fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759576; x=1716364376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLGS6fJq+lOqJ3w5Tkv/jajaJfxbK2E7v4a67YW3xHU=;
 b=r+3VOZ2yLERwvK2MBqJLdgUlJlqAndMFnsL39I3vMAWJq5BHL8YL73Ty3mqDwuQkES
 0JgBc7aa4IfE4u1+IZAPfELdjhwsXrFfc0/4TXBfCg5cw4FIR5cSderVMt1B973hqycg
 guwksHBE7n6XuATRMFgQydmCLG4mQk9RPhSc++t1DC4HAQ0WBjbDXM3gHDsTbY6ryaEP
 h1YO94y4tn0rm9hOEq/XAjcd7i577TWEUkVoebim/NNn8GhIYia0AvaIjHn3kDGXV9aQ
 Wq8+sjgN3xQcJPVfXFlwBvkIRXRGXFq7GxTiwqu0WtMW8gJfLp5t0pNXvRr959VjW5xJ
 sNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759576; x=1716364376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLGS6fJq+lOqJ3w5Tkv/jajaJfxbK2E7v4a67YW3xHU=;
 b=k+S9YJvTP4jparah0xKOhEYY/LuUg6j+13kylkGmaNg/gA4vVLx7WpEy2oWHBykvIu
 HIerYmkPrNgNMFcjqPgVyO0ROcgAjyxKo9tEWOcWWXysbDvubdRMqcYSrhvmg+K/3oZr
 oVXGMHRGOK/6wnkdq+X7rdvskzrLeaI78zFgc1RDHM0wkw0SVTshIQ7rjgtmkKQtJ0OG
 xfRlBp8yTYz/+z6Swvle/6g8eqaWG5zCplBbTb6CQw53jzJOvo96lHUf+r5bNhPtUXQB
 NbRFvpr2G8bFaQjgkf8YoEldrVDNg/LITea/HL5l4dYzA+HaB1Linrm2bUYfdlfq4Pvr
 Xv7A==
X-Gm-Message-State: AOJu0YxHHHgylgiaunKScTug3ERmOLrFTE7Ce4BWS7FgFwgtteb1JC7R
 xL6ppVo6iVvSc5Rao21tw6j0Q3N7vOxZ/qkm7pgUlfkCP38brtu+YmDfQsYBzEr1G/XOHqUlBRJ
 M5VU=
X-Google-Smtp-Source: AGHT+IEKZISrQwJ9+8PtZGQiHX2bzC5dSs7cFrgeb/zG3tVJgOlRvl1wwK0Lp1L6FAIyuW1Ets59sQ==
X-Received: by 2002:a2e:a175:0:b0:2e3:3b4e:43e4 with SMTP id
 38308e7fff4ca-2e5204b2ed4mr99294941fa.32.1715759576376; 
 Wed, 15 May 2024 00:52:56 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/34] accel/tcg: Implement translator_st
Date: Wed, 15 May 2024 09:52:23 +0200
Message-Id: <20240515075247.68024-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

Copy data out of a completed translation.  This will be used
for both plugins and disassembly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 23 ++++++++++++++++
 accel/tcg/translator.c    | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 70cef2c0be..fff857a0cc 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -246,6 +246,29 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  */
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
 
+/**
+ * translator_st
+ * @db: disassembly context
+ * @dest: address to copy into
+ * @addr: virtual address within TB
+ * @len: length
+ *
+ * Copy @len bytes from @addr into @dest.
+ * All bytes must have been read during translation.
+ * Return true on success or false on failure.
+ */
+bool translator_st(const DisasContextBase *db, void *dest,
+                   vaddr addr, size_t len);
+
+/**
+ * translator_st_len
+ * @db: disassembly context
+ *
+ * Return the number of bytes available to copy from the
+ * current translation block with translator_st.
+ */
+size_t translator_st_len(const DisasContextBase *db);
+
 #ifdef COMPILING_PER_TARGET
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index aa9f36aaa0..01e1f0977b 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -354,6 +354,61 @@ static void record_save(DisasContextBase *db, vaddr pc,
     memcpy(db->record + (offset - db->record_start), from, size);
 }
 
+size_t translator_st_len(const DisasContextBase *db)
+{
+    return db->fake_insn ? db->record_len : db->tb->size;
+}
+
+bool translator_st(const DisasContextBase *db, void *dest,
+                   vaddr addr, size_t len)
+{
+    size_t offset, offset_end;
+
+    if (addr < db->pc_first) {
+        return false;
+    }
+    offset = addr - db->pc_first;
+    offset_end = offset + len;
+    if (offset_end > translator_st_len(db)) {
+        return false;
+    }
+
+    if (!db->fake_insn) {
+        size_t offset_page1 = -(db->pc_first | TARGET_PAGE_MASK);
+
+        /* Get all the bytes from the first page. */
+        if (db->host_addr[0]) {
+            if (offset_end <= offset_page1) {
+                memcpy(dest, db->host_addr[0] + offset, len);
+                return true;
+            }
+            if (offset < offset_page1) {
+                size_t len0 = offset_page1 - offset;
+                memcpy(dest, db->host_addr[0] + offset, len0);
+                offset += len0;
+                dest += len0;
+            }
+        }
+
+        /* Get any bytes from the second page. */
+        if (db->host_addr[1] && offset >= offset_page1) {
+            memcpy(dest, db->host_addr[1] + (offset - offset_page1),
+                   offset_end - offset);
+            return true;
+        }
+    }
+
+    /* Else get recorded bytes. */
+    if (db->record_len != 0 &&
+        offset >= db->record_start &&
+        offset_end <= db->record_start + db->record_len) {
+        memcpy(dest, db->record + (offset - db->record_start),
+               offset_end - offset);
+        return true;
+    }
+    return false;
+}
+
 static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 {
 #ifdef CONFIG_PLUGIN
-- 
2.34.1


