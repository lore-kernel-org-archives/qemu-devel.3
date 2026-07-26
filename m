Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56714C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5iR-00082P-Gh; Sun, 26 Jul 2026 16:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iP-00081h-Me
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iO-0004AY-2Q
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NwVZZIn/w654birzBXvL0uPjZxjge0gQHrGZXU1O00=;
 b=XJgo9zGcDWbyVnmXVzo9I7qIw3EIo0sRTiSN7/Tt9+tiqkH9WRXPYi8V9O9SFLUQLlwhpa
 hNIOaj99Zyij4LVgjlh+VQVZrsJtbABFJGbR9cC3fqdTfEfMYu01t/REeXrTO8nAFwhyAy
 vl+bV46xz2n47sbGuncmntkYWpMAPRM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-R1SXSgAwOairw3KAFZQkNQ-1; Sun,
 26 Jul 2026 16:44:47 -0400
X-MC-Unique: R1SXSgAwOairw3KAFZQkNQ-1
X-Mimecast-MFC-AGG-ID: R1SXSgAwOairw3KAFZQkNQ_1785098685
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 186C71955F7A; Sun, 26 Jul 2026 20:44:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8E3C18001E6; Sun, 26 Jul 2026 20:44:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:03 +0400
Subject: [PATCH v2 04/12] include/qemu: adjust LOCK_GUARD macros to avoid
 potential warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-4-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3805;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+bBGCP3R5q2tbR+800PYqErga8FAlOuwLp/htqBMock=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXn0QZUp3tUC6uaoSvmdKBBdFYKE02mVjoO
 2ZIpqOSh7eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5VrTD/936zW3B3vsx6iLSY5/yTBjfYS6nC4mWSx/8jgv6Z6ar3VOnXtTrYoH/sPvGwaWVfT40z0
 h22sW8LZap6GS5pbCTGrbcZmQzJBKk+FggAzmYwdWCxADQxP347wEAw2hjFIujgQ64HyZdePCSg
 uvUOaC07KnRSAMSLWzdIzqXvJtgG5xfLSen7sHNqbOkSrlsgAHh/4RJEh6eeEWD6vu32lWl/PKo
 YOBjM0vbk67HUxlmpaz/qMDgga855xSU8Pz11Da77ozqHMRuirU1K/yChWUAPqzaPiKfmzJkauZ
 cJyvLW6/aIVm6XaSZNLJOTCNYZ3uEgN5qQakflYR9U+5UqtwcIBvdTCbTUxNwJfUltPVPgmS2A7
 RkusJCo1eiLg4RgOw1gsBI9dEt1jIHNLD8MZMFNLnegxsJtCekzhSW1nihRdu35q5Y2pfGuHEWj
 khiAjKwn1FrkJyEM+M0YqHoC/+Dqk9NjgpUp43vvl1B1QHi2kEZbpc9P2kE4Ep+xraR9u3T8uY4
 6q0aHEhAGxEh9vYbOUq1iZ+Q2HfMexVQF6ONt7La8U+1mSDHTM/GIIHeQGDA0jN2VAFoc6nVCEN
 GJFeC39Cj1hBX84i+Hl9HF9I5Cn9H2sKVxUAyBtqvC5EkoXOGtaCOPyNY4uWtlJF35ObRtT5+L5
 MyQM4d7JhXUKyww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use the same trick used by Linux (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fcc22ac5baf06dd17193de44b60dbcee):
use the compound statement expression with "goto" jumping past the
"loop", effectively leaving only the subscope part of the loop
semantics.

The old loop had to handle auto_unlock to set the var to NULL, but now
it can rely on autoptr.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/lockable.h | 19 ++++++++++++-------
 include/qemu/rcu.h      | 17 +++++++++++------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 66713bd42921..2704a1ec077d 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -130,11 +130,15 @@ static inline void qemu_lockable_auto_unlock(QemuLockable *x)
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
 
-#define WITH_QEMU_LOCK_GUARD_(x, var) \
-    for (g_autoptr(QemuLockable) var = \
-                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
-         var; \
-         qemu_lockable_auto_unlock(var), var = NULL)
+#define WITH_QEMU_LOCK_GUARD_(x, var, label)                        \
+    for (g_autoptr(QemuLockable) var =                              \
+            qemu_lockable_auto_lock(                                \
+                QEMU_MAKE_LOCKABLE_NONNULL((x)));                   \
+         ; ({ goto label; }))                                       \
+        if (0) {                                                    \
+        label:                                                      \
+            break;                                                  \
+        } else
 
 /**
  * WITH_QEMU_LOCK_GUARD - Lock a lock object for scope
@@ -158,8 +162,9 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
  *       ...
  *   }
  */
-#define WITH_QEMU_LOCK_GUARD(x) \
-    WITH_QEMU_LOCK_GUARD_((x), glue(qemu_lockable_auto, __COUNTER__))
+#define WITH_QEMU_LOCK_GUARD(x)                                     \
+    WITH_QEMU_LOCK_GUARD_((x), glue(qemu_lockable_auto, __COUNTER__), \
+                           glue(qemu_lockable_label_, __COUNTER__))
 
 /**
  * QEMU_LOCK_GUARD - Lock an object until the end of the scope
diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 020dbe4d8b77..41d02255ceae 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -178,12 +178,17 @@ static inline void rcu_read_auto_unlock(RCUReadAuto *r)
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
 
-#define WITH_RCU_READ_LOCK_GUARD() \
-    WITH_RCU_READ_LOCK_GUARD_(glue(_rcu_read_auto, __COUNTER__))
-
-#define WITH_RCU_READ_LOCK_GUARD_(var) \
-    for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock(); \
-        (var); rcu_read_auto_unlock(var), (var) = NULL)
+#define WITH_RCU_READ_LOCK_GUARD()                                  \
+    WITH_RCU_READ_LOCK_GUARD_(glue(_rcu_read_auto, __COUNTER__),    \
+                              glue(_rcu_read_label_, __COUNTER__))
+
+#define WITH_RCU_READ_LOCK_GUARD_(var, label)                       \
+    for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock();         \
+         ; ({ goto label; }))                                       \
+        if (0) {                                                    \
+        label:                                                      \
+            break;                                                  \
+        } else
 
 #define RCU_READ_LOCK_GUARD() \
     g_autoptr(RCUReadAuto) _rcu_read_auto __attribute__((unused)) = rcu_read_auto_lock()

-- 
2.55.0


