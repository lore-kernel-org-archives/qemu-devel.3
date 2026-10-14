Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99900CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6xS-00008A-Db; Wed, 14 Oct 2026 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xM-00007K-BG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xJ-0005Jh-0W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:14 -0400
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CCF1A3F154
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792014970;
 bh=QsrujNT23KodeRhxy6ctEoCpVb2h+gJO/L6jtpjjrv0=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=kyDfX/YxVJnQ8mmdDHSfc26WmcVK0dS9SKCs2CL74K+nf7iRBTlyfEsImNOcfpRam
 QVpPIsA2K8M0/naw8YldgSYQ/vxRLvbX03q4FUNh29Psdp6aabxdCoBQ8/PJcsOK2B
 azn4koSXVEbefPUKu0DIKKwKKPNhUTmEPsd0clM6yQcQGZKgIrKjhEWJV+biEabxnr
 CHrE/ZucKYREDYtIW1F71AwmtoLDKfRBoK/8KBZxTOJpe/iAIIfllkTw2weWkRC4Oh
 GpGfLuGaa1W8TYG4ITA2BCwzsKWVW/9ioP4h1KRs4/38P6ePsyXhgJ1XB1C69O0+8U
 J7ER9YzCEh9HJLCfpYQgajBuuQ6iDmCyKyBJkYkXOOGNl2yxSj2nFY8nCvWApCLA27
 2I4ir+t7pgV+CpFkZm6meX1VXMoaikLIi6zNkqkGTLelOTzSlRT6c0pUFa2F2HQDND
 gfBn4lBk83sMhiva7I9/AwEu59ISOGhDknjPgNJJjqeW7xnSpcpRQARB5cu0ntekKI
 vWHai+1gLElvMaMV4E4NtILXnTKzYlKdVyootnaPYY4lkhq6ia8ksbcxjvL1+zJ7gX
 GVvzojzCbCupiXoqKCfYw413R98xdM+ODFH80jjMtuK3RQEAmSgkKZzoUWsAIeFpRe
 xDMhCcbqdCWagPBAA2yqHggA=
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-677c4ca2265so1925258d50.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792014970; x=1792619770;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QsrujNT23KodeRhxy6ctEoCpVb2h+gJO/L6jtpjjrv0=;
 b=kdd+TNw1trvJ4K/kLGbA+uMQnK7ITER0ymi52EYFFrG975KikD+pehH8dn8pGKAayB
 k8NtFUmVj5EzuAM6Hf6rK4iw1F3KoOhJlQmb69h6/Rm7gqMs0RgMPQOIhQMV7TepSS5N
 YSdLVGbNcf3OMq0TUoVWlKbUz5D3wi32v1Q1LRhAhX/KOoirHSbA8kyTXuG8lE1Toy/u
 HIpIhwtdnKY677Nw4QSnZDjGQHhfDfoCW/noZd29GypA/EJmqNbHDkPB7FsEjZnC9+lH
 8HT+DGjTP5JVlWrRbncQ/zfogvXYFbzkDNt0NXAmKpNcJGHkn3uBJQW7gfLAOUK439W5
 rzig==
X-Gm-Message-State: AFq9FYLAWlw29nVthSu0/xVIycPkr8MWAAdog8dUFxjzUQmPlx6pDMz3
 FD17IeBRkiImoqM0TZLaO9e8jGHVIsSWK5U7+rO411ASm3tLu07L2nU5SJuIcuvWAX1In4ecw3F
 6diYGdFFqbZtIRhmxSCCpN46/dHKayNSXlo92mEtFK5Pwj9lm584IwnjA5dn8Zshv6uw2C8ql
X-Gm-Gg: AYBFou2Za78sjbpMbOfnJmMPSwxYTHPXcJfauYcufXqsXkwsnWbgNz1FwCwgotfShNp
 emgc/W8qm9iHadRVx7esupioqo+Sv9vYh1HpwXVADwI6t/Wbpo7KqieCp6AdcRqXerVR5QPg8yk
 3n0zl9zuv6LqveqLhHu0+iIu6A+PgiFtP1JMrPPKj6GjDt+NyxkQf9RT9Bhbi6cBvYrD+8qIt2N
 4LSeSgYx6CEI0KBsdG22rJTQs/rIrt2/OW4np2Hhz3vQVBqWOTkr/JTndRuSBsAgajYv0D47+ZH
 8nCPIcLYBf/+Vz54Y/gJAEd4qzFpcF8OzjNM0KoUcfPZo+m3YxGGjSE0COE8T2XHhLKn0JAHss9
 kwp7MqVk0DTGjMV4hcTT3LqzASDTGg8iomHDiPQVd7fGZwiO3cONcvA==
X-Received: by 2002:a05:690e:d42:b0:677:c9c1:258c with SMTP id
 956f58d0204a3-67936067bd2mr4163279d50.71.1792014969652; 
 Wed, 14 Oct 2026 14:56:09 -0700 (PDT)
X-Received: by 2002:a05:690e:d42:b0:677:c9c1:258c with SMTP id
 956f58d0204a3-67936067bd2mr4163265d50.71.1792014969164; 
 Wed, 14 Oct 2026 14:56:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:7d2b:a0a2:5b86:60e4])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6799df67495sm201283d50.0.2026.10.14.14.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:56:08 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Wed, 14 Oct 2026 16:55:46 -0500
Subject: [PATCH v4 2/2] util/coroutine: Reduce default idle pool max size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-set-default-pool-size-v4-2-a3aff89b94f0@canonical.com>
References: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
In-Reply-To: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=sMbtxlft+39dMA70DKT774McU6FK2M/8TFC/fsKqQ1Y=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqz/p1AUEjp2kT+hdU9ObaPnUBN3YclglUXoji4
 TyjL2CB3VaJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas/6dQAKCRD5KICs4jod
 udpXC/4uKx/rtqGNSLXjQKEbq2Fdg2IRVEYteEqeLy/tJfHZMP2vWJia3OGLBuecfXj2Wgbc9dI
 ym8+NCAubGE5OTnlR0g4PFxWfev56r3TOIZKDbIV/JMSD4UaDmGY4dgHrP78zxm+SjI+2Biw7Hd
 X7AbOs4YUnE+hlCE36obs/WSJJu7531U9joNPiyYfk52fv+1HygNymxov7j+QCzjkX43RB6v53/
 9dqRdn0tUUilf6FDnDKRr8nHdYg6c9lPoxMYIbCtmBlxNYTWdv8ylLKkKWUiVm/TAL0jDx1fjKU
 ByZ1Lc5d8lNq1ws+PwjpTO802whH2K2ixaHXvPRSSXS4oMHAt5iEpUPioRKBXmzL8jTgvAsUBj5
 SfZHGZvYYt7o0Ss2OJMfF8+eRLgD4eV4JppHyqaI5I6IMbk5s07gWE8lcLAF2W+M/3tsm0elEeS
 vGElDgs6gI5Zo0Pz9vyGx9nNC9HlVTPx6yOE9XNpg/gOpYtdY2ABflTxuBFp+UMhEjocc=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

If g_file_get_contents fails (AppArmor, etc), use a more conservative
default max size for the idle coroutine pool.

This avoids any possibility of the failure described in 86a637e48104
unless the host kernel is configured with a lower-than-default
vm.max_map_count.

This change is motivated by a discussion of backport risk:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 73 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 5af61995437..b3312f7bf99 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -361,42 +361,61 @@ void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
     global_pool_max_size -= removing_pool_size;
 }
 
-static unsigned int get_global_pool_hard_max_size(void)
-{
 #ifdef __linux__
-    g_autofree char *contents = NULL;
-    int max_map_count;
+/*
+ * include/linux/mm.h
+ */
+#define DEFAULT_MAX_MAP_COUNT 65530
 
-    /*
-     * Linux processes can have up to max_map_count virtual memory areas
-     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
-     * must limit the coroutine pool to a safe size to avoid running out of
-     * VMAs.
-     */
-    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL)) {
+static unsigned int get_max_map_count(void)
+{
+    g_autofree char *contents = NULL;
+    int max_map_count = 0;
+    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
+                            NULL, NULL)) {
         /* contents has trailing newline, remove it before conversion */
         g_strchomp(contents);
-        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
-            return UINT_MAX;
-        }
-        /*
-         * This is an upper bound that avoids exceeding max_map_count. Leave a
-         * fixed amount for non-coroutine users like library dependencies,
-         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
-         * remaining amount.
-         */
-        if (max_map_count > 5000) {
-            return (max_map_count - 5000) / 2;
-        } else {
-            /* Disable the global pool but threads still have local pools */
-            return 0;
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+            return max_map_count;
         }
     }
-#endif
 
+    /*
+     * Read from /proc might fail due to mandatory access control (AppArmor,
+     * SELinux, etc). Use the kernel's default in that case.
+     */
+    return DEFAULT_MAX_MAP_COUNT;
+}
+
+/*
+ * Linux processes can have up to max_map_count virtual memory areas
+ * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
+ * must limit the coroutine pool to a safe size to avoid running out of
+ * VMAs.
+ */
+static unsigned int get_global_pool_hard_max_size(void)
+{
+    int max_map_count = get_max_map_count();
+
+    /*
+     * This is an upper bound that avoids exceeding max_map_count. Leave a
+     * fixed amount for non-coroutine users like library dependencies,
+     * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
+     * remaining amount.
+     */
+    if (max_map_count > 5000) {
+        return (max_map_count - 5000) / 2;
+    } else {
+        /* Disable the global pool but threads still have local pools */
+        return 0;
+    }
+}
+#else
+static unsigned int get_global_pool_hard_max_size(void)
+{
     return UINT_MAX;
 }
+#endif
 
 static void __attribute__((constructor)) qemu_coroutine_init(void)
 {

-- 
2.53.0


