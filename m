Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA81606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JURhhYBA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUad-0001Fj-UZ; Mon, 09 Nov 2026 13:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUab-0001FJ-Sc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUaa-0006I5-FI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeG2iVfFCj3eeKpRFunQ9Lno80LNeMsj8TqH/TijHYQ=;
 b=JURhhYBAi5AsiIcC/PvjGWk3MSIaUCYGjvyjo3oJo7sR/csHjGnoRbL24zA0Ca8z5p3SFu
 ZSAURiZx2iHfF2RC7+HOzLOIfPQudl1ZI467S+9eOB7DCno+2f9mQwme3OSIuYw81lsq1P
 p9s99apzJEBWCt1oE5h/ZGKOpsyF5Fw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-c7EJXxBqMOO7x5dAD2cMjQ-1; Mon,
 09 Nov 2026 13:59:25 -0500
X-MC-Unique: c7EJXxBqMOO7x5dAD2cMjQ-1
X-Mimecast-MFC-AGG-ID: c7EJXxBqMOO7x5dAD2cMjQ_1794250760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618871955E83; Mon,  9 Nov 2026 18:59:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A3391956087; Mon,  9 Nov 2026 18:59:16 +0000 (UTC)
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
Subject: [PATCH 2/7] debug/mem: add tracing to qemu_vname_vma()
Date: Mon,  9 Nov 2026 13:59:02 -0500
Message-ID: <20261109185907.3220584-3-jsnow@redhat.com>
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
 util/mmap-vma.c   | 6 +++++-
 util/trace-events | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 7dcef3b7455..93ca7f608d7 100644
--- a/util/mmap-vma.c
+++ b/util/mmap-vma.c
@@ -7,6 +7,7 @@
  */
 #include "qemu/mmap-vma.h"
 #include "qemu/osdep.h"
+#include "trace.h"
 
 #include <errno.h>
 #include <stddef.h>
@@ -36,6 +37,7 @@ static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
     int rc = 0;
 
 #if defined(PR_SET_VMA_ANON_NAME)
+    int err;
     char strbuf[VMA_MAXLEN];
 
     assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
@@ -49,8 +51,10 @@ static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
     }
 
     rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
+    err = errno;
+    trace_qemu_vname_vma(strbuf, ptr, sz, rc, err);
     if (rc) {
-        return -errno;
+        return -err;
     }
 #endif
 
diff --git a/util/trace-events b/util/trace-events
index df549646d12..5ffc6cd205c 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -117,3 +117,6 @@ module_lookup_object_type(const char *name) "name %s"
 
 # datadir.c
 load_file(const char *name, const char *path) "name %s location %s"
+
+# mmap-vma.c
+qemu_vname_vma(const char *name, void *addr, size_t sz, int rc, int err) "name %s addr %p size %zu: rc %i errno %i"
-- 
2.56.0


