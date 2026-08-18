Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3721C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHu2-0003Q6-45; Tue, 18 Aug 2026 07:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHu0-0003Fd-Nn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHty-00078L-Uc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrBI6APmfni1eZ8vuc+OAu7+inaV3ylbVMAHuz3FiqY=;
 b=Q7k9g5brFKmetVUukaYhPATQO8A/WmL4GibfXy/9Dq5YS/fy7SqoqP1Da5h3nVUKAIrYi/
 D9dBfBqbzcf3SjbLgRhagHafqBDapUQV8muVFyezm+21JbtDSTePHkceRDKaKG7LCZpRd/
 k0I+P6cNIByZz7TLgjziJTBXn6OianI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-Pkk-yAHYPNWUPAqSvitp8g-1; Tue,
 18 Aug 2026 07:22:38 -0400
X-MC-Unique: Pkk-yAHYPNWUPAqSvitp8g-1
X-Mimecast-MFC-AGG-ID: Pkk-yAHYPNWUPAqSvitp8g_1787052156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DBFD1800747; Tue, 18 Aug 2026 11:22:36 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A10301800348; Tue, 18 Aug 2026 11:22:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:11 +0400
Subject: [PATCH v3 44/74] hw/misc/xlnx-versal-trng: add missing getter for
 fips-fault-events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-44-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tocXDybXXj46+RW2LpIpFFkqPlAIhRzMx+5fSJL7tHQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD27a94OtGLPXejqmTwHa0Su4TY2h4pHF9JdX
 aiUKqOKhZyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uwAKCRDa6OEJdZac
 5eoJD/9SLKJk6rETdOTcxpYX07josALCDZOHIJ9wHrJfSYa9lbsnXVqHi8FyEx7wG4aqt3SKzsk
 WzUJpJyXdqzZMg2hqIP3mS/Pob85Pu+mepobGt9F5gcvKZYw5C/HkuUHURSeZmkb65aEaNzDojf
 VLfCR1PgezqTG/ITTH2Lji2JQXxVsTkDIEoAKpkRPTZeck/tkdzRs28oeGZs9uFKVogAMopNGtU
 5hL/BSWtpgq4Wqe3axqQltdLSGn6vLXdacCHwYwUF6l00bz+NOw054P6D4vmtvyo0aBX3mN6s8K
 VG4cM5RvE+ThNRT0g8V9rd17jBRpU/AC8o2FiWSTma8bzMwab/8ZgXWGxbo5DJjcYQ7lyVU/pzU
 32E+JY8z+yNIUKvtqpu3XirTlE7FFLIL0G4CW+hGRRhb61kwtP9oOHNglH1GorkQFuaZL1Aagzs
 1WPTWqyuyku3zKvmWrVi3vunCQuX+EOU4t5FGOZ2yY729l5uB9ToqA4Bfn1BmLBDvkTMF05BGh8
 SSRqBcrq6xePBuSUdK5DLSIa3wxUkWxYXaSDLAbbwStXQPHvs7guyew0+8EQee5UbEj1rwDBU9x
 lZE5rteG0gATeEziwSMPrTLl6vcE9xXChNwn+bTy0OsNhn4pNxTG6MV1WiJMw/vVjjCS3m/ThcZ
 a7InWtfOgEIYujQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


