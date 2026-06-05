Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D019CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVzi-0003FO-FZ; Fri, 05 Jun 2026 10:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVz7-0002Qp-En
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVz5-0005WH-BC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMZTgq+W3oaOEY/UcLBDVwkqAOLsLQfr+h1MNjhpmg8=;
 b=AOgYTjr06GgXEvbZtmhPHUzjQIhQhsAmPg6DMlY6o7qNpxCwMiYrVfNXmPciPrXdK6ludR
 C7xNGDfUPvWri3DAMaxD43Y6XCNrT/4go9ce6w1veVyao5mpEJuKekJ/1hyd8NlpU0l8r+
 0+4UI5ybnDjZPo3+jSTmQENs5oEllV4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Mq9ssvv9MYOjvJWwMknkeQ-1; Fri,
 05 Jun 2026 10:57:12 -0400
X-MC-Unique: Mq9ssvv9MYOjvJWwMknkeQ-1
X-Mimecast-MFC-AGG-ID: Mq9ssvv9MYOjvJWwMknkeQ_1780671431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79CEA19560A5; Fri,  5 Jun 2026 14:57:11 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A1DD180049F; Fri,  5 Jun 2026 14:57:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 7/7] buildsys: Stop checking for ESA/390 host
Date: Fri,  5 Jun 2026 16:56:47 +0200
Message-ID: <20260605145647.272621-8-cohuck@redhat.com>
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We still build QEMU tools on 32-bit hosts (see commit
cf634dfcd8f), however no OS supported by QEMU still runs
on ESA/390 (Linux dropped support in release 4.1 in 2015).

Remove the configure check, directly checking for the 64-bit
z/Architecture.

Also per commit 3704993f545 from 2020:

  "we don't support s390, only 64-bit s390x hosts".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260519171240.97420-4-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 block/file-posix.c        |  2 +-
 configure                 | 12 ++----------
 disas/disas-host.c        |  2 +-
 include/qemu/cacheflush.h |  2 +-
 include/qemu/timer.h      |  2 +-
 util/cacheflush.c         |  2 +-
 6 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e49b13d6abb5..5019ddade9b5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -79,7 +79,7 @@
 #include <linux/hdreg.h>
 #include <linux/magic.h>
 #include <scsi/sg.h>
-#ifdef __s390__
+#ifdef __s390x__
 #include <asm/dasd.h>
 #endif
 #ifndef FS_NOCOW_FL
diff --git a/configure b/configure
index 1ceb4d7ecc42..d786d3a7c9b4 100755
--- a/configure
+++ b/configure
@@ -399,12 +399,8 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __s390__ ; then
-  if check_define __s390x__ ; then
-    cpu="s390x"
-  else
-    cpu="s390"
-  fi
+elif check_define __s390x__ ; then
+  cpu="s390x"
 elif check_define __riscv && check_define _LP64 ; then
   cpu="riscv64"
 elif check_define __aarch64__ ; then
@@ -461,10 +457,6 @@ case "$cpu" in
     linux_arch=riscv
     ;;
 
-  s390)
-    linux_arch=s390
-    CPU_CFLAGS="-m31"
-    ;;
   s390x)
     host_arch=s390x
     linux_arch=s390
diff --git a/disas/disas-host.c b/disas/disas-host.c
index 7cf432938e0b..d41235250a0a 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.print_insn = print_insn_little_mips;
 #elif defined(__m68k__)
     s->info.print_insn = print_insn_m68k;
-#elif defined(__s390__)
+#elif defined(__s390x__)
     s->info.cap_arch = CS_ARCH_SYSZ;
     s->info.cap_insn_unit = 2;
     s->info.cap_insn_split = 6;
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index 8c64b8781458..0618966ddde0 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -19,7 +19,7 @@
  * mappings of the same physical page(s).
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index ec03635dd34c..9a62ac8cded1 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)
     return val;
 }
 
-#elif defined(__s390__)
+#elif defined(__s390x__)
 
 static inline int64_t cpu_get_host_ticks(void)
 {
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 247c4ce29803..a44fb136f7e0 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -223,7 +223,7 @@ static void __attribute__((constructor)) init_cache_info(void)
  * Architecture (+ OS) specific cache flushing mechanisms.
  */
 
-#if defined(__x86_64__) || defined(__s390__)
+#if defined(__x86_64__) || defined(__s390x__)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
-- 
2.54.0


