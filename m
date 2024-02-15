Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E72C48BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV74-0002Ml-FB; Thu, 15 Feb 2024 01:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6t-0002Jb-UZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:40 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6s-0005TB-8t
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:39 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso398238a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978037; x=1708582837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/9ie+RjhRAxWQRFAoaHPcdtrZYsCMJBCi3SaKV1dlk=;
 b=kyE+u9nVvw+xMyRJ9BwM+rq86mWks7j+fwgHWUFj3SD1sFd6VTJPxTFkstVkmRNkgr
 Zz6Mn75ODKSZoBp+0mqRH+PKrLc3KZaHeoZ5z7gn89UIk4DSk/CrzoHKwsqJain9aIkD
 vF9oo/EgDlcDktVDzmJiFFaSjDAIaF6a1NVkec7qmXDyQB2R4O3VRN/ENQ561WAkFvuc
 +a+DaTfQD9mFiwmNDoGaJCmDIPXzCixUVceTx+7k0YMrEpiJKRQw8Puz99iiiSagYy9W
 0CLwC3ibMykqJap4HIbDTnWc6ppXDd1e74Umc4MRU7x8Sy9mFe2+g54ylarsURluR1ei
 9d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978037; x=1708582837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/9ie+RjhRAxWQRFAoaHPcdtrZYsCMJBCi3SaKV1dlk=;
 b=PnYJD4AWTRJVkkYhN4nR8DWVGsfMJAVfg8Y7ZyRLMyORxcudU7vzrKEc4Y0At9epjz
 copYxIxXydgWLt5BBIhI5glIsQigQ/45tVtPJ15vLqgXBDIG+6ofHhqfn+D/A7yAXRXZ
 UAcdfBTEktpQDb6XLmiW8HkLoaS72V4/Kr5zIRQxk7EU97rB+yZDTCgqrxyEZrsgd1Jz
 iWwFZq/3gjRiO2esHA80HaFo7/pa1NgMgZdDFr8+pnkwiVCGCvnlDiN3qXSGMzAMAk7K
 i5JPN3xkkRB6+cA9SDCK0Ig2nz9dIlRvc7+VpBtFSY80cZJjuHJjALab2U4bBowuL4jH
 8cfg==
X-Gm-Message-State: AOJu0YzhkeC0H+9jboERXC0GETQFSmGr0Axxny+WWuIC1XYkOUJZTVWq
 hlOYO0Ja3/Qaozp0MJGFl11cvRVZzrQ3RpIadgPHnY5xocsPH4i/uF6OCavg5xaCg9oOpxVCpPC
 s
X-Google-Smtp-Source: AGHT+IGwE7m9GInItJziaAaBXCCX8w+tWtIQk1sDDLvWFB7AKvfxgHUTnItrWaa0O6s/tOAD8U7yZw==
X-Received: by 2002:a05:6a21:1519:b0:19e:9aec:ba1d with SMTP id
 nq25-20020a056a21151900b0019e9aecba1dmr1442595pzb.47.1707978036792; 
 Wed, 14 Feb 2024 22:20:36 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 11/36] migration: Remove qemu_host_page_size
Date: Wed, 14 Feb 2024 20:19:53 -1000
Message-Id: <20240215062018.795056-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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


