Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72053D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KED-0001hN-8P; Thu, 17 Oct 2024 02:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KEB-0001h2-Id
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KEA-0005HX-0i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2bd0e2c4fso470675a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147396; x=1729752196;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+ajNe5sP2rJbGsXRQh/6mYHUXwdnX8x9rsRLQEatk8=;
 b=oaG9FReK0D0OTywrTSFMbmQlsuO3RbCzqgy1JpNscEvSKGx3OoFBKYK3CRbygaTV8W
 xsgMPi1cz2qcQWsFVbNmBYK/0SItlyUltH6ocAnnmsuRMqJCS9HKHZrk+IXiIE6sDSzO
 pMnoGKG3XjM/CuAnm0TwrZIGTBPfKASKOfunbNGx/pS92XlAEC2Y0ZIcaSnlLsjrwe30
 d2YU8lfllw+efN+JwFMZr2VIjsXBrjRoO1bU3XFcuvTVMNUg+VtK29zOHZI1tvScqZdX
 mcs2fb/FhrTtNWqFTYM7Kjp+lXSxIPm4SnCFhsgCC2HryTXJx0QG6PkwjpUgze7Le0d/
 DU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147396; x=1729752196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+ajNe5sP2rJbGsXRQh/6mYHUXwdnX8x9rsRLQEatk8=;
 b=Ct/5MxbZL1TATjLJOTkmodIoU6c+/87Bbt8PeGxLqTDBI2IbjfPjcyVBqk9ylGIvyy
 eeJBion45tA7Q7uymKxxCY8+wXOa3EG707Z5AneDMX7ewxdMdmTKOEVKKPbmisoalflj
 ijGkiQB7srsSib+PUtbdx3qNf8g45vDA7Rf7pvTCm6uwtexDiWkAN/ZfZhLFMFCftyNT
 YuI7B05eRB/jhSwpeN+fDs4wZAsC9/HzC7VmxetziRRZljTDl1NgtDs5KntaQDgXlFGw
 V+MW3lC0/lKTEm30NTlUIBx+wm/6ZilhmrJYnfaleIZjfTvnS0efUy3Mt7/La1U8ppEY
 EeLQ==
X-Gm-Message-State: AOJu0YxoQKgBhW96fDhwvu6BPtZupxesZJfQrd+50uQbTCfkEZIa7BAg
 UN2Qkyg75mFx31yVuoYQBuhOhZSwN8PXRvdyJ/Vzx6p8wKJJEhlW2Ks1d1SZiWm6zEhtMmC/91Z
 PdcJ5Rw==
X-Google-Smtp-Source: AGHT+IHM/NxZwKeGkGKk+QRfXw/mZD5dY+1mZCe5iJEGNEO6JUt9a3tY6wEushZpFJIxzytxqnOoVg==
X-Received: by 2002:a17:90a:c708:b0:2e2:b64e:f501 with SMTP id
 98e67ed59e1d1-2e2f0d7f1fbmr23998858a91.30.1729147395727; 
 Wed, 16 Oct 2024 23:43:15 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:15 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 4/6] migration: Remove "rs" parameter in
 migration_bitmap_sync_precopy
Date: Thu, 17 Oct 2024 14:42:53 +0800
Message-Id: <283c335d61463bf477160da91b24da45cdaf3e43.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

The global static variable ram_state in fact is referred to by the
"rs" parameter in migration_bitmap_sync_precopy. For ease of calling
by the callees, use the global variable directly in
migration_bitmap_sync_precopy and remove "rs" parameter.

The migration_bitmap_sync_precopy will be exported in the next commit.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 54d352b152..9b5b350405 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1088,9 +1088,10 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     }
 }
 
-static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
+static void migration_bitmap_sync_precopy(bool last_stage)
 {
     Error *local_err = NULL;
+    assert(ram_state);
 
     /*
      * The current notifier usage is just an optimization to migration, so we
@@ -1101,7 +1102,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
         local_err = NULL;
     }
 
-    migration_bitmap_sync(rs, last_stage);
+    migration_bitmap_sync(ram_state, last_stage);
 
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2782,7 +2783,7 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
     }
 out_unlock:
@@ -3248,7 +3249,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(rs, true);
+            migration_bitmap_sync_precopy(true);
         }
 
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
@@ -3330,7 +3331,7 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
     if (!migration_in_postcopy()) {
         bql_lock();
         WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(rs, false);
+            migration_bitmap_sync_precopy(false);
         }
         bql_unlock();
     }
-- 
2.27.0


