Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45FDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXI95-0006eJ-VQ; Wed, 10 Jun 2026 08:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI95-0006eB-AU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI93-0001Wj-Se
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QlXWd0idklAxQC55HKQAScQyQi3Q9Tm1mu4SyMtg0Q=;
 b=b5+1u4CeRqUQGawM4Rg07A0fFApibkqzxSYMyf2ukKs11izoPFpEmULujfDRqmqqDN2xrO
 ZmSlxrHZfhlrO9fs0HpRmpqi9UL1+pM4FM86pV6+0r9pV68FMURmXSPWLfIvZWS8BxG4bV
 aJAbz9b4cRtimTZEZaWhiopWMlhzebQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354--_KC3HwqMfes-fhzgSj1OA-1; Wed,
 10 Jun 2026 08:34:55 -0400
X-MC-Unique: -_KC3HwqMfes-fhzgSj1OA-1
X-Mimecast-MFC-AGG-ID: -_KC3HwqMfes-fhzgSj1OA_1781094894
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B6061955EAC; Wed, 10 Jun 2026 12:34:54 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06B2431D2; Wed, 10 Jun 2026 12:34:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/35] monitor: add 'pretty' property to QMP Monitor class
Date: Wed, 10 Jun 2026 13:33:48 +0100
Message-ID: <20260610123415.2883603-9-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

This determines whether the QMP JSON responses are pretty printed
with newlines and indentation, or compact with no extra whitespace.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/qmp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 3a4e2ae0e7..ae6317b09d 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -77,8 +77,25 @@ static void monitor_qmp_finalize(Object *obj)
 {
 }
 
+static bool monitor_qmp_get_pretty(Object *obj, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    return mon->pretty;
+}
+
+static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    mon->pretty = val;
+}
+
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
+    object_class_property_add_bool(cls, "pretty",
+                                   monitor_qmp_get_pretty,
+                                   monitor_qmp_set_pretty);
 }
 
 static void monitor_qmp_init(Object *obj)
@@ -537,6 +554,7 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
                                         id,
                                         errp,
                                         "chardev", chardev_id,
+                                        "pretty", pretty ? "yes" : "no",
                                         NULL);
 
     if (!obj) {
@@ -557,8 +575,6 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
                       qemu_chr_has_feature(mon->parent_obj.chr.chr,
                                            QEMU_CHAR_FEATURE_GCONTEXT));
 
-    mon->pretty = pretty;
-
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests = g_queue_new();
 
-- 
2.54.0


