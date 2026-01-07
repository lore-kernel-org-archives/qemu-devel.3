Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86632CFD65B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdW9n-0006WF-8E; Wed, 07 Jan 2026 11:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9h-0006Gf-Hb
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9f-0005Jg-7C
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767802382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIu0NuT8xH1gLC7I9AJ6tXbflSuQTsSBe51EYgnpVd4=;
 b=JaGjsRpJgvYWiQzUXPmzJoLQPdEfAh0648oln7jnUELuNsofR39SsMXMb7vy+4PsYaz9/z
 f4NYKaFs82Lf+FLKNhFnOKhszGA+DMRjeiejckuoTHQEUDh6bCofIPWqEbiiAFwOUb27O0
 pM5AbnutgISUHRU5Nkgu2pZboJXWEdk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-lFBelQQOM4ubaAy5JAsEhg-1; Wed,
 07 Jan 2026 11:13:00 -0500
X-MC-Unique: lFBelQQOM4ubaAy5JAsEhg-1
X-Mimecast-MFC-AGG-ID: lFBelQQOM4ubaAy5JAsEhg_1767802379
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAA9C1954B14; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F06A18008FF; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F059D21E61A5; Wed, 07 Jan 2026 17:12:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/4] qdev: Fix "info qtree" to show links
Date: Wed,  7 Jan 2026 17:12:53 +0100
Message-ID: <20260107161256.1321694-2-armbru@redhat.com>
In-Reply-To: <20260107161256.1321694-1-armbru@redhat.com>
References: <20260107161256.1321694-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qdev_print_props() retrieves a property's value from its legacy
property if it exists.  A legacy property is created by
qdev_class_add_legacy_property() when the property has a print()
method or does not have a get() method.

If it has a print() method, the legacy property's value is obtained
from the property's print() method.  This is used to format PCI
addresses nicely, i.e. like 01.3 instead of 11.

Else, if doesn't have a get() method, the legacy property is
unreadable.  "info qtree" silently skips unreadable properties.

Link properties don't have a get() method, and are therefore skipped.
This is wrong, because the underlying QOM property *is* readable.

Change qdev_print_props() to simply use a print() method directly if
it exists, else get the value via QOM.

"info qtree" now shows links fine.  For instance, machine "pc" onboard
device "PIIX4_PM" property "bus" is now visible.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251022101420.36059-3-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qdev-monitor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 0bf514cb09..be18902bb2 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -762,19 +762,18 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
     for (int i = 0, n = dc->props_count_; i < n; ++i) {
         const Property *prop = &dc->props_[i];
         char *value;
-        char *legacy_name = g_strdup_printf("legacy-%s", prop->name);
 
-        if (object_property_get_type(OBJECT(dev), legacy_name, NULL)) {
-            value = object_property_get_str(OBJECT(dev), legacy_name, NULL);
+        if (prop->info->print) {
+            value = prop->info->print(OBJECT(dev), prop);
         } else {
             value = object_property_print(OBJECT(dev), prop->name, true,
                                           NULL);
         }
-        g_free(legacy_name);
 
         if (!value) {
             continue;
         }
+
         qdev_printf("%s = %s\n", prop->name,
                     *value ? value : "<null>");
         g_free(value);
-- 
2.52.0


