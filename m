Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46067606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SUmqrcHt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUag-0001G9-4a; Mon, 09 Nov 2026 13:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUae-0001Fm-JD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUad-0006KT-3W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VufcRdivSFDOtCXyYchwGh9ii+BaoE0frA+jUSq792o=;
 b=SUmqrcHtS4SiDUIWjd1XH8LEpOqpmc1h8GtzUJ42laP2AB+XUgH9uuNhrP0fyoUyX3tSk0
 WXjcW0SaZy+29TxmnfUmVNSiD+kSFZqgt/jfOnnBJPVb863BHopEESYz8Kb69/07KENCHF
 AXlIdclV5GUBTZAzDBAwKQ92+KiA+1w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-lrIugugqNHC6N9MjxKk_Pg-1; Mon,
 09 Nov 2026 13:59:29 -0500
X-MC-Unique: lrIugugqNHC6N9MjxKk_Pg-1
X-Mimecast-MFC-AGG-ID: lrIugugqNHC6N9MjxKk_Pg_1794250767
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 435DB19560AE; Mon,  9 Nov 2026 18:59:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 086391956087; Mon,  9 Nov 2026 18:59:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, John Snow <jsnow@redhat.com>
Subject: [PATCH 4/7] debug/mem: name pthreads
Date: Mon,  9 Nov 2026 13:59:04 -0500
Message-ID: <20261109185907.3220584-5-jsnow@redhat.com>
In-Reply-To: <20261109185907.3220584-1-jsnow@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: John Snow <jsnow@redhat.com>
---
 meson.build              |  8 ++++++++
 util/qemu-thread-posix.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/meson.build b/meson.build
index d7bcb581c18..ef961df2f64 100644
--- a/meson.build
+++ b/meson.build
@@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_NP', cc.links(osdep_prefix + '''
     pthread_get_name_np(pthread_self(), buf, sizeof(buf));
     return 0;
   }''', dependencies: threads))
+config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_prefix + '''
+  #include <pthread.h>
 
+  int main(void)
+  {
+    pthread_attr_t attr;
+    pthread_getattr_np(pthread_self(), &attr);
+    return 0;
+  }''', dependencies: threads))
 config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 089606c93fb..353fc1a4be5 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,6 +17,7 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
+#include "qemu/mmap-vma.h"
 
 #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
@@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
 
 void qemu_thread_set_name(const char *name)
 {
+# if defined(CONFIG_PTHREAD_GETATTR_NP)
+    pthread_attr_t real_attr;
+    void *pthread_addr;
+    size_t stacksize;
+    size_t guardsize;
+# endif
+
     /*
      * Attempt to set the thread name; note that this is for debug, so
      * we're not going to fail if we can't set it.
@@ -373,6 +381,32 @@ void qemu_thread_set_name(const char *name)
 # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
     pthread_set_name_np(pthread_self(), name);
 # endif
+
+# if defined(CONFIG_PTHREAD_GETATTR_NP)
+    if (pthread_getattr_np(pthread_self(), &real_attr)) {
+        return;
+    }
+
+    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
+        goto cleanup;
+    }
+
+    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
+        goto cleanup;
+    }
+
+    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)) {
+        goto cleanup;
+    }
+
+    /* Though there's a guard page, it isn't actually marked RO, so
+     * just label the entire region */
+    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
+                  "pthread (%s)", name);
+
+ cleanup:
+    pthread_attr_destroy(&real_attr);
+# endif
 }
 
 typedef struct {
-- 
2.56.0


