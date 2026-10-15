Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59659CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWR-0002CR-KR; Thu, 15 Oct 2026 07:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWP-00029G-FA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWN-00043x-UB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGCv+AfKMnU61s9G0ocGnKK177Rsaciih/XA+CS5lHg=;
 b=XChsOuamm44nXm6DHpPe/80ro66+eYIaMWaNWk26uTWGdt5qXr0u21zvNZT1tacdNmIlg1
 QQgrIMYr2kETLZIyLPrbhvgADy6KdklFi40PMyV/8fSOBEvlmkuVy1Kskxs0GHGp3wg+dy
 rxtqw8fyGRZ0da7EF/KSzrAz92bnQfM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-yUCRfPbLNoK9D_HpSsS9rQ-1; Thu,
 15 Oct 2026 11:21:11 +0000
X-MC-Unique: yUCRfPbLNoK9D_HpSsS9rQ-1
X-Mimecast-MFC-AGG-ID: yUCRfPbLNoK9D_HpSsS9rQ_1792063270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DDD81955EB9; Thu, 15 Oct 2026 11:21:10 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D9821800257; Thu, 15 Oct 2026 11:21:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 05/21] util: expand alternate signal stack to all threads
Date: Thu, 15 Oct 2026 12:20:28 +0100
Message-ID: <20261015112044.1999748-6-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The sigaltstack() function is per thread, so setting SA_ONSTACK has
no effect unless all threads have an alternate signal stack registered.

This adds overhead of SIGSTKSZ bytes per thread, which is OS-dependent,
but on Linux is 8kb.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-thread-posix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 089606c93fb..66858018057 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -381,12 +381,28 @@ typedef struct {
     char *name;
 } QemuThreadArgs;
 
+static void qemu_thread_sigstack_free(void *data)
+{
+    stack_t sigstack = {
+        .ss_sp = NULL,
+        .ss_size = 0,
+        .ss_flags = SS_DISABLE,
+    };
+    sigaltstack(&sigstack, NULL);
+    g_free(data);
+}
+
 static void *qemu_thread_start(void *args)
 {
     QemuThreadArgs *qemu_thread_args = args;
     void *(*start_routine)(void *) = qemu_thread_args->start_routine;
     void *arg = qemu_thread_args->arg;
     void *r;
+    stack_t sigstack = {
+        .ss_sp = g_new0(char, SIGSTKSZ),
+        .ss_size = SIGSTKSZ,
+        .ss_flags = 0,
+    };
 
     if (qemu_thread_args->name) {
         qemu_thread_set_name(qemu_thread_args->name);
@@ -395,6 +411,9 @@ static void *qemu_thread_start(void *args)
     g_free(qemu_thread_args->name);
     g_free(qemu_thread_args);
 
+    sigaltstack(&sigstack, NULL);
+    pthread_cleanup_push(qemu_thread_sigstack_free, sigstack.ss_sp);
+
     /*
      * GCC 11 with glibc 2.17 on PowerPC reports
      *
@@ -413,6 +432,7 @@ static void *qemu_thread_start(void *args)
     pthread_cleanup_push(qemu_thread_atexit_notify, NULL);
     r = start_routine(arg);
     pthread_cleanup_pop(1);
+    pthread_cleanup_pop(1);
 
 #pragma GCC diagnostic pop
 
-- 
2.56.0


