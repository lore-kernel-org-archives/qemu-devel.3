Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF5C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3u-0006rU-0I; Fri, 04 Sep 2026 15:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3r-0006Z8-MC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3p-0007tP-Og
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3oPXPM3fK4MsUH2z2qdPJuzr1xcfLEKwZWlP2JAH0E=;
 b=MqAzoJDtpouhVCsQC0KrESr3K2yx96GuD20NmmeSc4V0FY7Q0Vu9HRXjSZE7BFwy4ExY8g
 Z6ORDAG1f62fln7G8ekrC8hZuWyQ0eIuqXg2SKzdG//UnV2tYj9wia0eRzixQinv1QPaKV
 1BPJElTKAqZCCaxHBW2cBk2edd1ErVw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-mIcxohjQNUesAql44To7sQ-1; Fri,
 04 Sep 2026 15:58:48 -0400
X-MC-Unique: mIcxohjQNUesAql44To7sQ-1
X-Mimecast-MFC-AGG-ID: mIcxohjQNUesAql44To7sQ_1788551927
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1C6918F0F09; Fri,  4 Sep 2026 19:58:47 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E06DE1800641; Fri,  4 Sep 2026 19:58:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:54 +0400
Subject: [PATCH v4 11/75] qom: add object_property_set_default_enum()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-11-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLI05dgiND+29GaEr/Cf0ZcPCZkAmc7szP0l
 hAwo6ifxP2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5U5zEACapYGnE4/3tL3SPBOqFHV90k/GBVSai6GZHH5xqL8h2FVdzSPR+711zmc7Ur7YMolJc+B
 RSd1JfX7zLjR3UCaIxFcJskPAtXpn+F5lTI5xvMKjznv7cP5h03PXTY9JsrHd33BQdtL9FHp6lY
 tvJFtDVGj2YuAbNwBCYpUu7Jr9mFK5TwZJTmVz24nZrq2KkFDS0Q0DrryiP2xk5PyS4fEdNfuMp
 wjkV5lcwVYFKx00tC6nnePyNaG9kIUrCv9waEr5hdi2GpiCyFyOKmh2jeHLXhoJpju/mZxEsruk
 PhQhPYpq6wEaNRVKYMMbva9EhUAdwMvPDKS9XI/twRklabwuCcdun14vUe1QOgwmL/UH/dWjmkM
 7Gra+JkJ1TanXB95Kbr9gZ+7g73ri1ucJPwXtQs4EafYeGGxEpDXuK034pc2230y8iGHoMtRcbE
 FljXlWppm2lhkk5sYMgmstJNgJibS2+nS/TK6nS85YCHxk+wkSPFLG/njFao47/ETP5w5EHtvLW
 XOmRr9hxw5Tx/+amylsxnLmH+TdP1g5sfNZeyNbT8qz0d3UG5u3gmV7hc4B2E+oNM9Hhb+4Ul2H
 atHlLdzJH5aencr9T7p9UCpm5CGGEZ/06UpB4JrFFwpBDmNDuIE3KCj44X/GB5UnVsbptHumoUi
 fdQCvYb5q57ApLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


