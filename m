Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D3ECD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3CM-0004e2-5W; Wed, 13 May 2026 02:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wN3C5-0004b1-SJ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:35:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wN3Bv-0004Hv-OI
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:35:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c80148ae949so2786289a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778654133; x=1779258933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LO8l2nTywjfi36vUZCrXryumu63gdJ85hphWar88O3w=;
 b=UzmKzHnPI2T4Fs8b2Yt76cgxkvmDmNugWUnNfTnTa79gGFOL8Cb3l6rq4BDsUKmQ4a
 22h8y8Yi7Xaml4kwLOKWvgaGyv3173nllY0S1wJnjw6AdXHP+kaoyPv+inzZUm9ISMLn
 RgTzVFTy9+Rfl0acOmRm9rT2M09mBLfntr42e/IzGOdWGA36v0KCVIyqeU4EAya6XHly
 sgHsOcvdIEPZS6FYpDm1RzuBawrRGl9oi3XgDr5FxAoHq1zm1jxdyv57PCWDKyAGzx3W
 HfqZ1s5ISTudVF9FVQomRHUX9jOGyS1O/SclNXt0iC7IGEmCs9bI0zoVJKfXlgNhH6sM
 ZbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778654133; x=1779258933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO8l2nTywjfi36vUZCrXryumu63gdJ85hphWar88O3w=;
 b=PugGflr8igH/ioVfH3VikaywDRTtX0cOL2MlUP2yI+yts7rWPx75XMUjR7Z1oTw0Cw
 hRPoBkpWkTt40DUzU9w25cSZ0sJBD0xp3I97linoVTXAAhsfltYoK9eok9BKw89/5N4c
 tC3GDdhytfhV5CIfRDDHWQ5/glon611q5hgtZNfg7ecxbNmVJMX/MFTJh4AjodciMbWh
 vLK/t41RO3C28SxQbepqJ9+LSEsMFJpdF9/GNC3fRm6si+tso5SaHT9ObaO9cAzti4QG
 JfdvqMKT/JKkiJjEmRhwjanDYvBfnmy+Gm3ndu7gdaQatP8WlPsddw4F1l3BH/wiwqcH
 r8iA==
X-Gm-Message-State: AOJu0Yz8Rj1nVWsBn6XejmGqlNJCYRwf8mmg+6jJcTffbtYvpPpBO3en
 O680dk0drtz09H+ZkEsggPl8rd2YUDB/zdUquc8rqLZxGuDbljDdGO1+bB4CUaNC
X-Gm-Gg: Acq92OFnd+GPzTBjkVDT+sS8DuVq1NvnTWexYd4Pgvtx7N+Vz/bS6A8JKwwRW6Xo2ot
 mDjBxRs2wZBqLmBCUN1Uhs8bODxdqEG0EkYnof7Imd1t4C1k4lwh0WT++S2PG/qvyXinEWDZGCG
 ILPsnCh0AgfdPn4zfKRRiK6Z5JjbKXeNkySbo5ZkqeckcHGHLEAc+j08mpqlUoqBTyFqSV6AKLo
 6pCIaRsXEVTW+7mE6ZIYpGzna2w4X8uvPZKp8l/IIfYbNKWeZzmpDG7Vq48F42TQAwl+j3d2Z0+
 A2xBR/jdbzzaoeYq+J1szKAF+4hoKTv5OEiRXhyJ/kBJB0W4aiHi7wg7PcSrnVZbs5bQkIHBtPO
 ORtFiD99BqT8kk2ZJIrd6tjExPqAJO6NkD3/dcUIUZX/TIHctmBwpzepF6LBPyyamtMzwGBV/zx
 aSL8fDUsr2xt6peZQEzHwl
X-Received: by 2002:a05:6a20:748f:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3af7f0713a0mr2102324637.15.1778654133051; 
 Tue, 12 May 2026 23:35:33 -0700 (PDT)
Received: from setun ([2405:201:502b:380f:df10:4bc8:ea8:8d6d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82675fb236sm14166844a12.0.2026.05.12.23.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 23:35:32 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v2] migration: Replace current_migration with
 migrate_get_current()
Date: Wed, 13 May 2026 12:05:13 +0530
Message-ID: <20260513063513.250911-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces the direct accesses to global variable `current_migration`
with `migrate_get_current()` to ensure consistency across systems.

Note: Following this only direct access to `current_migration` will be
* `migrate_get_current()` itself
* `migration_object_init()` initializes `current_migration`
* `migration_shutdown()` to pair up with initialization
* `migration_is_running()`, as there might be a case where this function
  is called by a thread before object initialization

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ecc69dc4d2..0e142ff6f2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1029,7 +1029,7 @@ bool migration_is_running(void)
 
 static bool migration_is_active(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
@@ -1634,7 +1634,7 @@ bool migration_in_bg_snapshot(void)
 
 bool migration_thread_is_self(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return qemu_thread_is_self(&s->thread);
 }
@@ -3062,7 +3062,7 @@ static MigThrError postcopy_pause(MigrationState *s)
 
 void migration_file_set_error(int ret, Error *err)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-- 
2.54.0


