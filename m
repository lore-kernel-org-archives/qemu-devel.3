Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F8CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAU6-0000PX-Ku; Thu, 18 Jun 2026 07:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waATz-000090-9Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waATx-00035C-HU
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781780425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFRa6q4588q2duUPMM7iZlQA2mmDHScsKHYzc0PDDlE=;
 b=JbKLBAS9fNloGIUwjgenbzOV+DKzxuhRj1u31vQZOFOi4pgzXfwXkzR0qEplG/UKmJpbds
 aaOgXfNK5Ks1G+ViAbfOw97/GAMUjPC7/6Ri+w55hJwF/S1pHxWIpgD+7o4uhWeeensXxu
 hHFz1PyaEzBw8mLuIP9GmJ6Lvm8Sx7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-ANypxgjEPDmPiCAFdNb_dQ-1; Thu,
 18 Jun 2026 07:00:21 -0400
X-MC-Unique: ANypxgjEPDmPiCAFdNb_dQ-1
X-Mimecast-MFC-AGG-ID: ANypxgjEPDmPiCAFdNb_dQ_1781780419
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4B4180058F; Thu, 18 Jun 2026 11:00:19 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 969BD1956087; Thu, 18 Jun 2026 11:00:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 25/35] monitor: protect qemu_chr_fe_accept_input with
 monitor lock
Date: Thu, 18 Jun 2026 11:58:26 +0100
Message-ID: <20260618105836.991609-26-berrange@redhat.com>
In-Reply-To: <20260618105836.991609-1-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Christian Brauner <brauner@kernel.org>

The monitor_accept_input API is called from a bottom half, and will
invoke qemu_chr_fe_accept_input().

When a following patch introduces the ability to delete monitors, it
will be neccesary to delete the bottom half. Protecting the call to
qemu_chr_fe_accept_input with the monitor lock will allow for
synchronization with the deletion process.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: extracted from a larger commit and refactored to apply
     to the new monitor class structure]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c     | 2 ++
 monitor/monitor.c | 6 +-----
 monitor/qmp.c     | 9 +++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 2cd508f1ee..7b084c6ff8 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -116,9 +116,11 @@ static void monitor_hmp_accept_input(Monitor *mon)
         MonitorHMP *hmp = MONITOR_HMP(mon);
         assert(hmp->rs);
         readline_restart(hmp->rs);
+        qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
         readline_show_prompt(hmp->rs);
     } else {
+        qemu_chr_fe_accept_input(&mon->chr);
         qemu_mutex_unlock(&mon->mon_lock);
     }
 }
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 312e069bc5..0e1c623555 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -560,11 +560,7 @@ static void monitor_accept_input(void *opaque)
     Monitor *mon = opaque;
     MonitorClass *cls = MONITOR_GET_CLASS(mon);
 
-    if (cls->accept_input) {
-        cls->accept_input(mon);
-    }
-
-    qemu_chr_fe_accept_input(&mon->chr);
+    cls->accept_input(mon);
 }
 
 void monitor_resume(Monitor *mon)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index b0535dec68..2131be82c7 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -107,6 +107,7 @@ static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
 static bool monitor_qmp_requires_iothread(const Monitor *mon);
 static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
 static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp);
+static void monitor_qmp_accept_input(Monitor *mon);
 
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
@@ -119,6 +120,7 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
+    moncls->accept_input = monitor_qmp_accept_input;
 
     ucc->complete = monitor_qmp_complete;
     ucc->prepare_delete = monitor_qmp_prepare_delete;
@@ -666,3 +668,10 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     error_setg(errp, "Deleting QMP monitors is not supported");
     return false;
 }
+
+static void monitor_qmp_accept_input(Monitor *mon)
+{
+    WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
+        qemu_chr_fe_accept_input(&mon->chr);
+    }
+}
-- 
2.54.0


