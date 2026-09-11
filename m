Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF36C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54GK-0005co-6I; Fri, 11 Sep 2026 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54GD-0005Fl-TN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G4-000665-Kh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3oPXPM3fK4MsUH2z2qdPJuzr1xcfLEKwZWlP2JAH0E=;
 b=cSIBcDmf7jBqIbClD4XgruBLY0z71DmimBIIxZHozKZhEEqJE3cgKudaC8hm5+/lARw7to
 VfrmUzWVaaK9XgASnhjLu4e/u9SEv5yZZp5n9rMh/rvG+h5YDPhDclLIA90N+EMeOn0+PS
 Anfmq2pVzE5aHW3ITqVjnuv/+6lG0jc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-Qzk6UMgoOw28PGh0MJl6gg-1; Fri,
 11 Sep 2026 12:37:40 -0400
X-MC-Unique: Qzk6UMgoOw28PGh0MJl6gg-1
X-Mimecast-MFC-AGG-ID: Qzk6UMgoOw28PGh0MJl6gg_1789144658
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0DD518009C6; Fri, 11 Sep 2026 16:37:38 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5E531956095; Fri, 11 Sep 2026 16:37:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:45 +0400
Subject: [PATCH v5 11/62] qom: add object_property_set_default_enum()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-11-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J24jPq7GnTAmrNH7CcrVSdskD3xIJdz1fXAotCO/yMI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC23T8CbP0g1fUsDz2SL4ic1c/hF8vsVbBQGO
 XtCBHkexW2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttwAKCRDa6OEJdZac
 5Y1wD/0eEnUQ9fT9mtuiNxgHEifrhqL5XSgWOEpwMkGFhN0s2sTNtkN1DYiNKTpUa8Zzb/pKMRL
 lF7VsWA8ylou8jkFaLJyi220m7pDC/JgFZpXiwfMII7mEhoDLMuMGr16eAYxu8m5KO9XAngx72H
 EBJAfZshCTfQcNCUBKU+ifusMVYfCZ+t8RQV08BQhNtidu8bpS7sGqNkZNyge93oatOOyJPbJun
 /7kUe5qMQSX+71j7vIFA6WWd0IYyiU+2ttow6sJgQUywnqPJ26P1lM83c6HYe4PU46QsIBvxm2B
 AQrnzyDF4ZbaiRADfacs9GxXSgliJJr+gbB8IcPiPy5FgJ9U8bG/xuM+lp7XehNF0X0VFj+yMDF
 WuzKCFuV6h9mDpkNAu4gsPMm2V3ue+MZWxFWS3lRb77G5G11khmPBca7nDIBqo9Gl9qLuK/IxU2
 rkkJY7GFZdDTezqhjV9tC3kuSHHKq5x1Ps3S8ZXm864jobHs6WAmKn3n4Bxu02ilMbT32YzbhSq
 Ne/FM52STAQclSVxeVsSMW4yVz8n9xBKhYpmqdEVHooCt2qhTD3ADRiZZWWpZtxRHgq5NfGUD5I
 4DquPsoNRqIjZgFYMbirkODqo/NbkyAR2/v87gEBcz24ZdLO4qsOkxg7yYXK9bV7k7w5Rfi3N+4
 mtmdgtZ+sKte6mQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

A simple helper to set the default enum value from the integer value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 9 +++++++++
 qom/object.c         | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7c7e69a2a1bb..c9a5ea4a1bf8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1226,6 +1226,15 @@ void object_property_set_default_bool(ObjectProperty *prop, bool value);
  */
 void object_property_set_default_str(ObjectProperty *prop, const char *value);
 
+/**
+ * object_property_set_default_enum:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_enum(ObjectProperty *prop, int value);
+
 /**
  * object_property_set_default_list:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index f782e21f1a30..bf9664b53b78 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1709,6 +1709,15 @@ void object_property_set_default_str(ObjectProperty *prop, const char *value)
     object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
 }
 
+void object_property_set_default_enum(ObjectProperty *prop, int value)
+{
+    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
+
+    object_property_set_default(prop, QOBJECT(qstring_from_str(
+        qapi_enum_lookup(prop->qapi_type->lookup, value)
+    )));
+}
+
 void object_property_set_default_list(ObjectProperty *prop)
 {
     object_property_set_default(prop, QOBJECT(qlist_new()));

-- 
2.55.0.543.g5ebe2ebe4ea8


