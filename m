Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGyL-0005BJ-L3; Wed, 29 May 2024 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGyB-00054V-CF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGy8-0003NB-6S
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGV5jSDaxeP4Lu/Tmb/dztGV+P7mIQAmemSK9AAsv5I=;
 b=hcm7jEgLt4Z7Gtt9KlWpinFvnPND2wvzwYWmhsruTDi1A0a/hwrh+KAIOq+fR5iuEv/IuC
 LbXB1ZLF1JsrnySjTlRbkVmLT6S4Uu+A4YEdMfyHvWYASzx6Y0pOiebdFsBVlsJInhUrMM
 Yeng2arl080uiDhUL3QA7EmCvzx++G0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-eRHqNa4kPUWeSLInASfyrA-1; Wed,
 29 May 2024 06:55:37 -0400
X-MC-Unique: eRHqNa4kPUWeSLInASfyrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F6B3C025B2;
 Wed, 29 May 2024 10:55:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9706105480A;
 Wed, 29 May 2024 10:55:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/22] lockable: Do not cast function pointers
Date: Wed, 29 May 2024 12:54:53 +0200
Message-ID: <20240529105454.1149225-22-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

-fsanitize=undefined complains if function pointers are casted. It
also prevents enabling the strict mode of CFI which is currently
disabled with -fsanitize-cfi-icall-generalize-pointers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2345
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240524-xkb-v4-2-2de564e5c859@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/lockable.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 62110d2eb7..66713bd429 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -43,15 +43,30 @@ qemu_null_lockable(void *x)
     return NULL;
 }
 
+#define QML_FUNC_(name)                                           \
+    static inline void qemu_lockable_ ## name ## _lock(void *x)   \
+    {                                                             \
+        qemu_ ## name ## _lock(x);                                \
+    }                                                             \
+    static inline void qemu_lockable_ ## name ## _unlock(void *x) \
+    {                                                             \
+        qemu_ ## name ## _unlock(x);                              \
+    }
+
+QML_FUNC_(mutex)
+QML_FUNC_(rec_mutex)
+QML_FUNC_(co_mutex)
+QML_FUNC_(spin)
+
 /*
  * In C, compound literals have the lifetime of an automatic variable.
  * In C++ it would be different, but then C++ wouldn't need QemuLockable
  * either...
  */
-#define QML_OBJ_(x, name) (&(QemuLockable) {                            \
-        .object = (x),                                                  \
-        .lock = (QemuLockUnlockFunc *) qemu_ ## name ## _lock,          \
-        .unlock = (QemuLockUnlockFunc *) qemu_ ## name ## _unlock       \
+#define QML_OBJ_(x, name) (&(QemuLockable) {        \
+        .object = (x),                              \
+        .lock = qemu_lockable_ ## name ## _lock,    \
+        .unlock = qemu_lockable_ ## name ## _unlock \
     })
 
 /**
-- 
2.45.1


