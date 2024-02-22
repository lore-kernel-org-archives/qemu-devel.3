Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB35C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFv9-0007HX-Nk; Thu, 22 Feb 2024 15:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv5-0007Cb-W0
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:53 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv3-0002fO-3H
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:50 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d73066880eso2072135ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634627; x=1709239427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/9ie+RjhRAxWQRFAoaHPcdtrZYsCMJBCi3SaKV1dlk=;
 b=g9JkkC78kXu590aZzhZDQGh3vXufgZDGk/pLXVSNopNrqAow5tDlZitYpxgnT0+rbb
 9nfupNRA/SApjE/uPonO1p1D/38Pi4NjyCLqk3RmZ7W3ekbWnOMC958TWzTjUaT7cdl/
 hY4op/O3Rv+jrya4IRLxNDpda9oruJK582TYebSkb2WHN5+wtIFIukQbFKpbu/H+K9Wc
 +S8lQc0Aek6OfcfWU4mLeixWT2kOOJqTrc6+3IztWj60BDSTCUq/dZ3u+sPSgbetg1PR
 3DskF6gxZe7XI8Km4l6z5/826fpFU5Jb9iIi9fuiu4xZrdPeJ4Um9Aa5rkj+2s9Kb6Qa
 nEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634627; x=1709239427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/9ie+RjhRAxWQRFAoaHPcdtrZYsCMJBCi3SaKV1dlk=;
 b=khm1Nyo94WCwBtoXHdm13jrKika9TgQfiHk8qcGGyFUDJDUisk7YImq0ypw+ZEY5UA
 SH9+u4ex1CPBLQOxepE2OpFOyweyF6rX+6ufTon8B6O+/CdD5v8AinoInR5+neN2q9Zf
 KjIUR1aytKvgDF8jG2dhNvG9JCXpihH/twSxpq7lNvFGu1ckkw8Hp7veNXVBlZDXPx0G
 Q+3/CYA56HjtFyC8rt6U2K69WUU/dbbpylD1H7zWAAPTik0SrxRgn8VCJz8dMJ/S1CA3
 M21EckiutgiTls3XcfJF/DsAIredUiBKGZdZm6izRRQd1sHmrGpjKruXVqfDxcsWEIxK
 iYBw==
X-Gm-Message-State: AOJu0Ywkl726fbF/idHn8+Q4Kp1faOytkqbkwWz2Wps3caZLfEy2Ch6r
 yOqPJvst8Yy9AKwmmLfUtx9uXdXZYxFdTNL9uR/Tahl43Nw3riUCT4NJ4lqMqzwRQ2kYVI+qtMg
 p
X-Google-Smtp-Source: AGHT+IGqMMl87NciX6E9cvagZpZTphc4TxdGyPnytQaCAzhuUuBo680g5GPhi/pDhdcbUkqWIO1odw==
X-Received: by 2002:a17:902:6e0f:b0:1d9:167b:8e6c with SMTP id
 u15-20020a1709026e0f00b001d9167b8e6cmr20193636plk.46.1708634627595; 
 Thu, 22 Feb 2024 12:43:47 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 14/39] migration: Remove qemu_host_page_size
Date: Thu, 22 Feb 2024 10:42:58 -1000
Message-Id: <20240222204323.268539-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace with the maximum of the real host page size
and the target page size.  This is an exact replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-12-richard.henderson@linaro.org>
---
 migration/ram.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4649a81204..61c1488352 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2935,7 +2935,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
-    int ret;
+    int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
         return -1;
@@ -2950,6 +2950,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel = f;
 
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     WITH_RCU_READ_LOCK_GUARD() {
         qemu_put_be64(f, ram_bytes_total_with_ignored()
                          | RAM_SAVE_FLAG_MEM_SIZE);
@@ -2958,8 +2964,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
             qemu_put_be64(f, block->used_length);
-            if (migrate_postcopy_ram() && block->page_size !=
-                                          qemu_host_page_size) {
+            if (migrate_postcopy_ram() &&
+                block->page_size != max_hg_page_size) {
                 qemu_put_be64(f, block->page_size);
             }
             if (migrate_ignore_shared()) {
@@ -3792,6 +3798,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     int ret = 0;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = migration_incoming_postcopy_advised();
+    int max_hg_page_size;
 
     assert(block);
 
@@ -3809,9 +3816,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             return ret;
         }
     }
+
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     /* For postcopy we need to check hugepage sizes match */
     if (postcopy_advised && migrate_postcopy_ram() &&
-        block->page_size != qemu_host_page_size) {
+        block->page_size != max_hg_page_size) {
         uint64_t remote_page_size = qemu_get_be64(f);
         if (remote_page_size != block->page_size) {
             error_report("Mismatched RAM page size %s "
-- 
2.34.1


