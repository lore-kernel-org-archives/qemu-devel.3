Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A000C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5R-0003FS-Ed; Fri, 04 Sep 2026 16:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5B-0002nw-Pg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5A-0008G2-2d
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogne/0neUK9BGYyUWymCXs7DWfYh5TdP1DDM15iGuPg=;
 b=Gt/s1sF+qtFqf7TAEf0sD4+KZWgSGzdVuYjLAF7eZkA0W8cWnzG9AUujGQMCjBK74t1g5d
 35JYcbS0yG5G0uWilPHaFoQdRvlWx3Bm1pQpX9Xj9Kw2ozwmBvzuuUH9rFi+Odl5h3/Pnd
 yHtP0OC+GKfr7ZLTaSkXVSXXzLQhQBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-8eebFb9PPQi4wvdJq-FylA-1; Fri,
 04 Sep 2026 16:00:11 -0400
X-MC-Unique: 8eebFb9PPQi4wvdJq-FylA-1
X-Mimecast-MFC-AGG-ID: 8eebFb9PPQi4wvdJq-FylA_1788552009
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8903118E9B37; Fri,  4 Sep 2026 20:00:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB933423; Fri,  4 Sep 2026 20:00:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:16 +0400
Subject: [PATCH v4 33/75] backends/hostmem-file: fix "align" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-33-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KfzAE91Swi71PaZDmkuwKzLsZE6ZgjX9d19Y8iilkmk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKWJdIV0akNU9HwQpeACgNNDximEqUsyMnT
 MrYs4HYqSaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5V8kD/0WzWG/RBo/q35B3gWpbXryOMBaeV4ZETHWgGNUqbcWOVMnn2odYfMeNfyUdHRqgsGX838
 JW23OCpanmdefIppUYV1kuzSXUXc6c7984O32+ZJ1Jh+oNtg5oS1qtXJywaPCbYNd5SP2Rkgm6h
 Wk2Vx24dwipjenDiUsmefB6PZJ10BXj5WVDasdVJwr+86CfxsWHtLPist5ocPLbWktqZXS/WrIt
 M36Z3ittEQKAI8g5G2HzWe8AVquvxUg+Xg5aDdaIWCD0+XrhYOzHFitjvvbr9H/lCmz36Uc4rZg
 6BuAjiwBQiBtn+6RJDFJgXMsK4LaLSBvIKlMWAZOAmqZzBAMZKHaFJVSfagj+QrGDx+gNKBHopU
 0hgWoP0npVrnO57nQ1i6kCrC2095SnzOqRK5B/76LveqZaEcVGqgu9c5/qOtjKZ55LebMUUibOg
 nPjXgZXtEGKa2XN/FwLPtbB4qLPhvx/4BVgwMGdQuDmqbgx77xx3yCWpyltCyCDunaTJYu3by+l
 btfsXYb5and0yWtCoumxsgVvhVNB9cZwx3PpBfXz8nNbiuMgRV8S0bOzvlfXNdHFBfmeOnZEvsr
 aab//5WcVS6fpRsmGcJrrncverJE3GidrdAtcUYKA2EC2+vesW0/pQEJXR8o3r2SYqQnlHNrvkO
 X/kHf3DZsJJRF8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_size, not visit_type_int.
Since the underlying type is uint64, change it to that.

Fixes: 983768431676 ("hostmem-file: add "align" option")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 52b62f715334..9c7e0183d480 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -134,7 +134,7 @@ static void file_memory_backend_get_align(Object *o, Visitor *v,
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
     uint64_t val = fb->align;
 
-    visit_type_size(v, name, &val, errp);
+    visit_type_uint64(v, name, &val, errp);
 }
 
 static void file_memory_backend_set_align(Object *o, Visitor *v,
@@ -151,7 +151,7 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
         return;
     }
 
-    if (!visit_type_size(v, name, &val, errp)) {
+    if (!visit_type_uint64(v, name, &val, errp)) {
         return;
     }
     fb->align = val;
@@ -275,7 +275,7 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "int",
+    object_class_property_add(oc, "align", "uint64",
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


