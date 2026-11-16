Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CC606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M2IdfHx2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzv8-0007pE-8G; Mon, 16 Nov 2026 11:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xSzug-0007bR-FQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xSzuc-0007di-NL
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794847825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekrPifKeZKSKlAlu0PgB8G/oDkp8oZ++mIkvY8WR1Xw=;
 b=M2IdfHx24yd4U/vC6+0D/JXg+jPbKogLeQEMZdqs2Vqp82Ss1x+/cC4X8SdBLrZ1ejwzHs
 ngCv+HaORtMEIpeCUjfp4YGvF0HRHWYyMQM5b4rA5lzYCCIEdHMoE/FX6QPXkk6p0FHJcF
 pKoFTJ6dnPAjbhdT1LitxG6awkuI3ec=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-8lYezrWfP5qJWvLzQ-03nA-1; Mon,
 16 Nov 2026 11:50:22 -0500
X-MC-Unique: 8lYezrWfP5qJWvLzQ-03nA-1
X-Mimecast-MFC-AGG-ID: 8lYezrWfP5qJWvLzQ-03nA_1794847818
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96FF919560B9; Mon, 16 Nov 2026 16:50:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7C59195B3C9; Mon, 16 Nov 2026 16:50:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 2/7] debug/mem: add tracing to qemu_vname_vma()
Date: Mon, 16 Nov 2026 11:49:57 -0500
Message-ID: <20261116165002.30939-3-jsnow@redhat.com>
In-Reply-To: <20261116165002.30939-1-jsnow@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/mmap-vma.c   | 6 +++++-
 util/trace-events | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/mmap-vma.c b/util/mmap-vma.c
index 7a50965d496..46ea98f1134 100644
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
2.56.1


