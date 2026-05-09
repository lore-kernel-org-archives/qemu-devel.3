Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A03CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcFX-0005EQ-Hj; Sat, 09 May 2026 03:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFW-0005Do-7i
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFU-0006xW-N8
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yhQ8bi1pXmggnmlXkH2JFNSXv4d8Zosy9pQKAaMwIQ=;
 b=HVUlwgUMxlTvQ7NGdxqOFocNd4SaXCq1DGf0nJvbYAst6G8yQCtfCJPyWvhbOoPTkXToPB
 t7LiA7Ek0W6SVei8jT692VEZpxwUomYn7bvM6F6ozODg6jOcS9JAKHB9kIaIULCVOdKV0+
 euBmtFktWs/ZVWfqe45jdAvKKfnX9HE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-iPAPBOiAPre7tBbRRP5rVA-1; Sat,
 09 May 2026 03:37:18 -0400
X-MC-Unique: iPAPBOiAPre7tBbRRP5rVA-1
X-Mimecast-MFC-AGG-ID: iPAPBOiAPre7tBbRRP5rVA_1778312237
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4927B18002C8; Sat,  9 May 2026 07:37:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 817663002D31; Sat,  9 May 2026 07:37:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 09/32] char: error out if given unhandled size options
Date: Sat,  9 May 2026 11:35:55 +0400
Message-ID: <20260509073621.1011778-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This is a small help, because in fact all combined chardev
options are accepted by qemu_chardev_opts[]. But given that a user may
legitimately want to use the size options with a VC backend, we can
report an error when we know the backend doesn't support it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char.h |  1 +
 include/qemu/option.h  |  1 +
 chardev/char.c         | 12 ++++++++++++
 ui/console-vc.c        |  1 +
 util/qemu-option.c     | 13 +++++++++++++
 5 files changed, 28 insertions(+)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index c2c42e4b7a3..51995f06a82 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -254,6 +254,7 @@ struct ChardevClass {
 
     bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
     bool supports_yank;
+    bool supports_size_opts;
 
     /* parse command line options and populate QAPI @backend */
     void (*chr_parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 01e673ae03f..9a00ac0a356 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -73,6 +73,7 @@ struct QemuOptsList {
 
 const char *qemu_opt_get(QemuOpts *opts, const char *name);
 char *qemu_opt_get_del(QemuOpts *opts, const char *name);
+bool qemu_opt_has_any(QemuOpts *opts, const char * const *names);
 /**
  * qemu_opt_has_help_opt:
  * @opts: options to search for a help request
diff --git a/chardev/char.c b/chardev/char.c
index 48b326d57b9..55dce9725e8 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -639,6 +639,18 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    if (!cc->supports_size_opts) {
+        const char * const invalid_opts[] = {
+            "width", "height", "cols", "rows", NULL
+        };
+
+        if (qemu_opt_has_any(opts, invalid_opts)) {
+            error_setg(errp, "chardev '%s' does not support size options",
+                       qemu_opts_id(opts));
+            return NULL;
+        }
+    }
+
     backend = g_new0(ChardevBackend, 1);
     backend->type = CHARDEV_BACKEND_KIND_NULL;
 
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 6163e21d2c6..62a5e3caf57 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1251,6 +1251,7 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_write = vc_chr_write;
     cc->chr_accept_input = vc_chr_accept_input;
     cc->chr_set_echo = vc_chr_set_echo;
+    cc->supports_size_opts = true;
 }
 
 static const TypeInfo char_vc_type_info = {
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 770300dff12..9fbf425f86e 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -271,6 +271,19 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
     return opt->str;
 }
 
+bool qemu_opt_has_any(QemuOpts *opts, const char * const *names)
+{
+    int it;
+
+    for (it = 0; names[it]; it++) {
+        if (qemu_opt_get(opts, names[it])) {
+            return true;
+        }
+    }
+    return false;
+}
+
+
 void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name)
 {
     iter->opts = opts;
-- 
2.54.0


