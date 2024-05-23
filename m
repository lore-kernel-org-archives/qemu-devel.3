Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D83C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmO-00035o-7E; Thu, 23 May 2024 15:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlz-0002IT-NU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlw-0004Lj-Hq
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC0782040D;
 Thu, 23 May 2024 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcAnGN7Dn8Hx+2ymPsQ94bgP0wRUUi69NxEcC3s4Wwk=;
 b=ToCIBhb/Cm11PcvUFoUcWxAJgSCWw2/BiuDynvZK4sXWXXR/ccQzfkNakbKDS4SLHjm5Pz
 p+3cLr4rstwy3QNYXiTqDildILB1yN46QalpygzP6lzWF8b//aCYZobSTpPc5ZJdGLe9Ht
 il0+6UjCkgW+XHJYwxk6k5p98P9fRr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcAnGN7Dn8Hx+2ymPsQ94bgP0wRUUi69NxEcC3s4Wwk=;
 b=TobcceVeDKKeSygCTyPqV0TCtDkVvcQblVLzuf5tNY95HUpkpfUlHPi9Gpjg1+6g93Tmcd
 6kmEz0YxhAs0QsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcAnGN7Dn8Hx+2ymPsQ94bgP0wRUUi69NxEcC3s4Wwk=;
 b=ToCIBhb/Cm11PcvUFoUcWxAJgSCWw2/BiuDynvZK4sXWXXR/ccQzfkNakbKDS4SLHjm5Pz
 p+3cLr4rstwy3QNYXiTqDildILB1yN46QalpygzP6lzWF8b//aCYZobSTpPc5ZJdGLe9Ht
 il0+6UjCkgW+XHJYwxk6k5p98P9fRr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcAnGN7Dn8Hx+2ymPsQ94bgP0wRUUi69NxEcC3s4Wwk=;
 b=TobcceVeDKKeSygCTyPqV0TCtDkVvcQblVLzuf5tNY95HUpkpfUlHPi9Gpjg1+6g93Tmcd
 6kmEz0YxhAs0QsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5214C13A6B;
 Thu, 23 May 2024 19:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHObBryTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy file
 migration
Date: Thu, 23 May 2024 16:05:48 -0300
Message-Id: <20240523190548.23977-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

We've recently added support for direct-io with multifd, which brings
performance benefits, but creates a non-uniform user interface by
coupling direct-io with the multifd capability. This means that users
cannot keep the direct-io flag enabled while disabling multifd.

Libvirt in particular already has support for direct-io and parallel
migration separately from each other, so it would be a regression to
now require both options together. It's relatively simple for QEMU to
add support for direct-io migration without multifd, so let's do this
in order to keep both options decoupled.

We cannot simply enable the O_DIRECT flag, however, because not all IO
performed by the migration thread satisfies the alignment requirements
of O_DIRECT. There are many small read & writes that add headers and
synchronization flags to the stream, which at the moment are required
to always be present.

Fortunately, due to fixed-ram migration there is a discernible moment
where only RAM pages are written to the migration file. Enable
direct-io during that moment.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c              | 40 ++++++++++++++++++++++++++++--------
 tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ceea586b06..5183d1f97c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3131,6 +3131,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     int i;
     int64_t t0;
     int done = 0;
+    Error **errp = NULL;
 
     /*
      * We'll take this lock a little bit long, but it's okay for two reasons.
@@ -3154,6 +3155,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
                 goto out;
             }
 
+            if (!migration_direct_io_start(f, errp)) {
+                return -errno;
+            }
+
             t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
             i = 0;
             while ((ret = migration_rate_exceeded(f)) == 0 ||
@@ -3194,6 +3199,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
                 }
                 i++;
             }
+            if (!migration_direct_io_finish(f, errp)) {
+                return -errno;
+            }
         }
     }
 
@@ -3242,7 +3250,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 {
     RAMState **temp = opaque;
     RAMState *rs = *temp;
-    int ret = 0;
+    int ret = 0, pages;
+    Error **errp = NULL;
 
     rs->last_stage = !migration_in_colo_state();
 
@@ -3257,25 +3266,30 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             return ret;
         }
 
+        if (!migration_direct_io_start(f, errp)) {
+            return -errno;
+        }
+
         /* try transferring iterative blocks of memory */
 
         /* flush all remaining blocks regardless of rate limiting */
         qemu_mutex_lock(&rs->bitmap_mutex);
         while (true) {
-            int pages;
-
             pages = ram_find_and_save_block(rs);
-            /* no more blocks to sent */
-            if (pages == 0) {
+            if (pages <= 0) {
                 break;
             }
-            if (pages < 0) {
-                qemu_mutex_unlock(&rs->bitmap_mutex);
-                return pages;
-            }
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
+        if (!migration_direct_io_finish(f, errp)) {
+            return -errno;
+        }
+
+        if (pages < 0) {
+            return pages;
+        }
+
         ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -3920,6 +3934,10 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     void *host;
     size_t read, unread, size;
 
+    if (!migration_direct_io_start(f, errp)) {
+        return false;
+    }
+
     for (set_bit_idx = find_first_bit(bitmap, num_pages);
          set_bit_idx < num_pages;
          set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
@@ -3955,6 +3973,10 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         }
     }
 
+    if (!migration_direct_io_finish(f, errp)) {
+        return false;
+    }
+
     return true;
 
 err:
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5ced3b90c9..8c6a122c20 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2245,6 +2245,34 @@ static void test_multifd_file_mapped_ram_dio(void)
     test_file_common(&args, true);
 }
 
+static void *mapped_ram_dio_start(QTestState *from, QTestState *to)
+{
+    migrate_mapped_ram_start(from, to);
+
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void test_precopy_file_mapped_ram_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = mapped_ram_dio_start,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+
 #ifndef _WIN32
 static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
                                          void *opaque)
@@ -3735,6 +3763,8 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/multifd/file/mapped-ram/dio",
                        test_multifd_file_mapped_ram_dio);
+    migration_test_add("/migration/precopy/file/mapped-ram/dio",
+                       test_precopy_file_mapped_ram_dio);
 
 #ifndef _WIN32
     qtest_add_func("/migration/multifd/file/mapped-ram/fdset",
-- 
2.35.3


