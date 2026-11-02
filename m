Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C8606A781
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frOeljst
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr7o-00088G-DJ; Mon, 02 Nov 2026 07:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7m-00087d-Qc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7l-0001kf-BR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czC0djcfad1fwTSbct+0/IyDyBrjtTIk4lY2CdI2QRI=;
 b=frOeljstBeG6o4HswkQcoHSS51Bg69OJEfxtjUg2CbWrlwTm9h5JdJBQtIAL9d9sCq1jp7
 ev6NxYGyvs13IZeyRXGaUVMZxgH3uQlr2Lfo75v3+dC6t1dxb7aFekgYPq3WhU/c5sMzt7
 g/ndTeT1SIEo3PqCrtawxbuTDpzIMgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-x_NPKuq3Nqmm242z6uxa2Q-1; Mon,
 02 Nov 2026 07:26:51 -0500
X-MC-Unique: x_NPKuq3Nqmm242z6uxa2Q-1
X-Mimecast-MFC-AGG-ID: x_NPKuq3Nqmm242z6uxa2Q_1793622410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21B21195607D; Mon,  2 Nov 2026 12:26:50 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28EA51956087; Mon,  2 Nov 2026 12:26:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brad Smith <brad@comstyle.com>
Subject: [PULL 02/13] util/cutils: Use getexecpath() on OpenBSD for
 qemu_init_exec_dir()
Date: Mon,  2 Nov 2026 12:26:34 +0000
Message-ID: <20261102122645.3353402-3-berrange@redhat.com>
In-Reply-To: <20261102122645.3353402-1-berrange@redhat.com>
References: <20261102122645.3353402-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

From: Brad Smith <brad@comstyle.com>

util/cutils: Use getexecpath() on OpenBSD for qemu_init_exec_dir()

OpenBSD has introduced a function getexecpath() to be
able to retrieve the executable name and path.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build   | 8 ++++++++
 util/cutils.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index 71f135f0530..1b1523c5917 100644
--- a/meson.build
+++ b/meson.build
@@ -3040,6 +3040,14 @@ config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(osdep_prefix + '''
     return hwcap;
   }'''))
 
+config_host_data.set('CONFIG_GETEXECPATH', cc.links(osdep_prefix + '''
+  #include <limits.h>
+  #include <unistd.h>
+  int main(void) {
+    char buf[PATH_MAX];
+    getexecpath(buf, sizeof(buf));
+  }'''))
+
 config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
   #include <linux/usbdevice_fs.h>
 
diff --git a/util/cutils.c b/util/cutils.c
index d8a04ead5a4..2996baa677c 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1097,6 +1097,12 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__OpenBSD__) && defined(CONFIG_GETEXECPATH)
+    {
+        if (getexecpath(buf, sizeof(buf)) == 0) {
+            p = buf;
+        }
+    }
 #elif defined(__APPLE__)
     {
         char fpath[PATH_MAX];
-- 
2.56.0


