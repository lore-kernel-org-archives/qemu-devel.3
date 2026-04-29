Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B19FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4H-0003Ui-Fu; Wed, 29 Apr 2026 17:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4B-0003TZ-7O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC49-0003Cc-9t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEGhBdo4FIrkpLD+9d7/P2GvS/cJYUI8tGJGysFprBg=;
 b=KzSTebnFt2hweqyAZAkQuNN7Su4wFzrqiufX3Odfyy7pdzwG7y8l4fM2moNqNpqWoXP4T5
 S8NHfYjZanks4qX4zdnpmt8qqRF4GQcoxB5wJNLMhYuwouluO7h6dasS7tRL8jRZR9oto1
 cXHFj3s8M3BlwKgNuvi5tVSiVJQMKVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-bvst9hv-PSOd6ARi-Iug2g-1; Wed,
 29 Apr 2026 17:03:26 -0400
X-MC-Unique: bvst9hv-PSOd6ARi-Iug2g-1
X-Mimecast-MFC-AGG-ID: bvst9hv-PSOd6ARi-Iug2g_1777496605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C202519560A3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:03:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7441019560B6; Wed, 29 Apr 2026 21:03:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:35 +0400
Subject: [PATCH v3 02/26] char: error out if given unhandled size options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-2-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I4+LryVaXPKdaH8bJajB6Zo4PYtkb+nVwNduq5g7EEw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILYMDi4EBmkn27F8+IAKd9qhV7vxX4QSqty
 0hO+L3o6MaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5SjCD/wOzsjPXuVASot173e4hj7ZuEumW5idb3Rxx1nA8vVwMi/HhXT89OuUElliB0awSAj60to
 YMYy3JD55g2P9jKlP+kb2Pvn5cUjv3C/9kX2HRgLr54Fr20iM/7AFyKl9qzYAz2CcyNOwF3TN1l
 sI6g9LdSuqwJngXpv4Miy3ZWTnjNZezwbuZLahkttDXqtnS+zIS5BIso7Cd70vf2Z6j3cDGycYb
 /fkYew6OwX9GMFG/cfSuvIlKbrrbrYz33HXIkOmhaxgNL0IWrO33e+vY5zDRpV7Nmj1HvvrqWBG
 5PMRmYrEVzoqQdkfhXtmbJYI8y9NAzLeh+9dV2d+8tJfN3k7ZCaftuCApHd4cE8XdelAC7E3lgb
 Hkk7hxGjEfi5cznpCL7J+gVtZzpX4XJ5bw2ZisOMLlpfgkHGe8M2cVAP4W3C4PEr9UoGy814MWC
 zBegkPLSckN/WdCogpO8Ozpl2WIWR5y6HNeZsSOD3Hjzk6oyk0WnfCIdnGm523nj/WSaSXdbrTI
 z/u+9dcwseDqUn0V7Y07iLJAAqKTc4sYp2DmAjR7KknB7p/6KFzRQcO9MLQylLLwX2qwcY4QQru
 HO+tj16oxud37I4QK1ukQ3Ma2HU3mYJWUZ9lFAJPxhJTp2vep0P3kSykhOE1p0mFI8/3pmrlHLX
 iS78/hInZUPdidA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a small help, because in fact all combined chardev
options are accepted by qemu_chardev_opts[]. But given that a user may
legitimately want to use the size options with a VC backend, we can
report an error when we know the backend doesn't support it.

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


