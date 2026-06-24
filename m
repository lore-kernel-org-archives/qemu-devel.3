Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4329FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRZk-00027A-7A; Wed, 24 Jun 2026 13:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZf-0001gQ-Fy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZd-0004ba-JI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qct9syha0Ea7OHzgDYRSm3VM3WvVH27KZLPe/ILOwPE=;
 b=H2oQsDSg6DKIwKNi6B2Ne+xbKya3n1rXBZFA51ZYZDTtkdkSo+q0phajly0/1hSMAswOGR
 jCdJBWslH5uvGaidE+aF3fp+ezUGUHc6Q3LobZ5RgiR9/YC8RIc+RjIxyqfUwFzEvhXfJ4
 LoO3h0506SxyNcnHHd/voKuy/mYwb04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-UzOxt4_TNuyq2NBaJpqcKw-1; Wed,
 24 Jun 2026 13:39:36 -0400
X-MC-Unique: UzOxt4_TNuyq2NBaJpqcKw-1
X-Mimecast-MFC-AGG-ID: UzOxt4_TNuyq2NBaJpqcKw_1782322775
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5873E180059D; Wed, 24 Jun 2026 17:39:35 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4064180028B; Wed, 24 Jun 2026 17:39:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v5 24/35] monitor: reject attempts to delete the current
 monitor
Date: Wed, 24 Jun 2026 18:37:40 +0100
Message-ID: <20260624173752.2928717-25-berrange@redhat.com>
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If an 'object_del' command for a QMP monitor arrives targetting the
current monitor, reject this request. If the current monitor is
deleted, it will be impossible to send any reply and the client won't
be able to remove the corresponding chardev backend.

Note, it is not possible to rely on checking monitor_cur() because
if 'object_del' is called via human-monitor-command, monitor_cur()
will reflect the temporary HMP, not the QMP target that needs to
be checked.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: extracted monitor tracking from larger commit; added logic
     to monitor_qmp_prepare_delete to reject request]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/qmp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 0e1c3eb52b..b0535dec68 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -72,6 +72,9 @@ typedef struct QMPRequest QMPRequest;
 
 QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
+/* Monitor being serviced by the dispatcher.  Protected by BQL. */
+static MonitorQMP *qmp_dispatcher_current_mon;
+
 OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
 
 static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
@@ -369,6 +372,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
 
         mon = req_obj->mon;
+        qmp_dispatcher_current_mon = mon;
 
         /*
          * We need to resume the monitor if handle_qmp_command()
@@ -429,6 +433,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         }
 
         qmp_request_free(req_obj);
+        qmp_dispatcher_current_mon = NULL;
     }
     qatomic_set(&qmp_dispatcher_co, NULL);
 }
@@ -573,6 +578,11 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static bool monitor_qmp_dispatcher_is_servicing(MonitorQMP *mon)
+{
+    return qmp_dispatcher_current_mon == mon;
+}
+
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
     MonitorQMP *mon = opaque;
@@ -646,6 +656,13 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 
 static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 {
+    MonitorQMP *qmp = MONITOR_QMP(uc);
+
+    if (monitor_qmp_dispatcher_is_servicing(qmp)) {
+        error_setg(errp, "Cannot delete the current QMP monitor");
+        return false;
+    }
+
     error_setg(errp, "Deleting QMP monitors is not supported");
     return false;
 }
-- 
2.54.0


