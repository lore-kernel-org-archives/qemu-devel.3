Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B61C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5e-0005qq-3v; Wed, 24 Apr 2024 19:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Z-0005or-GJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:47 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5X-0003SD-J4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:45 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a4df5d83c7so360599a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001502; x=1714606302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=klixi9bNxAQDyfNDVaZxjig2PNXDSzSH4KeZpVMjb1U=;
 b=WK6bif1ayj7dRP5XUu827SywcM4p1nIRhgW+WXWyFFmWfL/E87lXzZj27qGmEWtLIa
 MCjsLMmRlR0GeQFkd6q3DfaM7EITsD53v/JVOICjCp1AhY3/dN7R4UQPTaTzc5R57XFh
 9NmLPT6rVwPUQmuaek+ZHf//o7dRqPM8jj/2qP2xErOL/Jx1gtG42P3puO3fnRGpTPNx
 mUroH22h4Pq97CJp+TiUoXxM7d8X6pT6ZhBdrNinpJXMSVCDVAQScOCi73aG12kwqKMC
 hQrxJJdS1/eBoURm26PQhvxAe+Piceqa9QGKm1WOjO1KiIz5ue1ffm56fxpEzpMyhSld
 A8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001502; x=1714606302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klixi9bNxAQDyfNDVaZxjig2PNXDSzSH4KeZpVMjb1U=;
 b=wrw63k4y2TUNyAcCKRSKeJIaN4SPoU9LYNTFf6Z61B2BFwsdjeGXLLI//rReo7D1Yc
 X2eo1RXPDOp7heURXNVuVRot2wLM2Avzi0/vhIwjbv7QmhEWYxPkeYjSHSQNmmkVf7Ar
 d33KcU3Wuye7+u8vg/ae4N52ric49SPqK2bwPaPQ19bpGWd6brffDUN1S77RFDHdT+hQ
 FyXqppjtXPpBkGWB4btBlq6KLztaGQJJgHA7rXPHFmFr9pL0pWN5D9AwIY/n0OrPLZjs
 cy5eslEa5T2BXE5gEc9LesTaKkA0ft0EZDQbGYin8jxrqlrtWAj47WqIMEcXOR5DfYgf
 mQbw==
X-Gm-Message-State: AOJu0YyIXngZCLBNkiRh98ghUegMXAHxCl7H2sH2fUKHuNmszHa7cZRB
 aMm/UrZKl799hwkVtbnPCj/fnBD/F/HPUYbE8O0bsZ5bn+gDo8cQF1s2rpNW9f737A4QjiePQkN
 F
X-Google-Smtp-Source: AGHT+IHSUwZw45D8L1RTZMvi07N9o9Pbkid95WoJ64uV/EZlBCy5LHS/phaBy8hQDPKlYDCSzPFx6A==
X-Received: by 2002:a17:90b:3d02:b0:2af:9067:8097 with SMTP id
 pt2-20020a17090b3d0200b002af90678097mr2384707pjb.23.1714001501990; 
 Wed, 24 Apr 2024 16:31:41 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/33] accel/tcg: Implement translator_st
Date: Wed, 24 Apr 2024 16:31:08 -0700
Message-Id: <20240424233131.988727-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 23 ++++++++++++++++
 accel/tcg/translator.c    | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index e92dfba035..3c354a4310 100644
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
 #ifdef NEED_CPU_H
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 6863455ed9..7f63a8085d 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -353,6 +353,61 @@ static void record_save(DisasContextBase *db, vaddr pc,
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


