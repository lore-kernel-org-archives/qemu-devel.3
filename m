Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C8C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5y-0005jY-A6; Fri, 04 Sep 2026 16:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5q-0005Uz-Qb
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5o-0008NB-Vr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrBI6APmfni1eZ8vuc+OAu7+inaV3ylbVMAHuz3FiqY=;
 b=VjO5kRFLP0NVLnVxJCheOBHg9fhGHTp7iABs7X5MneWVglotKlPUNN/38Mkxm/PiBmgdgG
 V6la5XtZ6bIh0M9X+0cdjzLEerPcdasU6mOBE8iuG3BcHO3kaN98XCSS/BiJgntF8o9+v6
 bReNePuyeDbhUO2L6GEAfxPmPlJi7xM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-BQ5JC3NPMYOYgSZknX2pTA-1; Fri,
 04 Sep 2026 16:00:53 -0400
X-MC-Unique: BQ5JC3NPMYOYgSZknX2pTA-1
X-Mimecast-MFC-AGG-ID: BQ5JC3NPMYOYgSZknX2pTA_1788552051
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B236180A9F1; Fri,  4 Sep 2026 20:00:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DA081955F03; Fri,  4 Sep 2026 20:00:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:28 +0400
Subject: [PATCH v4 45/75] hw/misc/xlnx-versal-trng: add missing getter for
 fips-fault-events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-45-a985f168e938@redhat.com>
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
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tocXDybXXj46+RW2LpIpFFkqPlAIhRzMx+5fSJL7tHQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKwHyBxleYpQRo6JpL90MKfbJg9xX2c5yfI
 0wv/3E4RgCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5XTDEAC22BDZneg+yTMXi22ZAG3VgwRy8gIZLe+Ndpxl+BfE5o0oXgOuc2D/kQtPdNcttSPgZyB
 oF6WtpsFZ0ds4EEm0DMbQivfFfUBbf0xBHA/wBDff8SO11caJbxX35hcA4Mp5ztZWIJI9u6ljiN
 BGfNBUsQOQNYqPDsPW8UJL7u+W4Ve/fjNTXTRAML0437DUyWoHQsS9FDzW7sMU2NOfFVq70J9Te
 2f+QfzfXKU9T7XWSI9pJQO1DA444Xp/gnhps3X66kEDswxJ6J/+UU/z7cglYIPgAjSJMrUNbyEp
 VG3NMYw8m/5ZRkAB/jThG5bRH2pn1IPcOjlN9ZcfbMU6xbP2hXLLxDrXykM/5Nk3LhcXDp6lSc9
 V5TQvQGNzD5hvcDbvwQL4slZc1nfhGE4g837tq0uadL2Ir72GGtMze/KiGpzCNR77y/pQ2WLHhm
 dja66psytaEVZRYQb+eNKdn3i4kseUWp+120wmERH5a+orKfh1BfVe+lFn6X6Bfmq8uIUatBihj
 mqT9onf9Efear9q3vFIAxx6sgIExOvVc8HY7SDzHd/WH2pLSxg4mwiscnE3szhP+oy/CvfJ6s/K
 B+KMBUTgvXASn9GTEapvbLjEaZkoOBytDGMsjJfg0S2LfGvtzDprTlR7FToKt0/u9bR+eIQ570K
 pPvxU3rHEQCakDg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/xlnx-versal-trng.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index aa1d65de7b70..0584ee089e3c 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -650,10 +650,22 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
     trng_fault_event_set(XLNX_VERSAL_TRNG(obj), *events);
 }
 
+static void trng_prop_fault_event_get(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque,
+                                      Error **errp)
+{
+    const Property *prop = opaque;
+    uint32_t *events = object_field_prop_ptr(obj, prop);
+
+    visit_type_uint32(v, name, events, errp);
+}
+
 static const PropertyInfo trng_prop_fault_events = {
     .type = "uint32",
     .description = "Set to trigger TRNG fault events",
     .set = trng_prop_fault_event_set,
+    .get = trng_prop_fault_event_get,
     .realized_set_allowed = true,
 };
 

-- 
2.55.0.543.g5ebe2ebe4ea8


