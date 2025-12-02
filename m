Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9590DD11712
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTQr-000106-ID; Tue, 02 Dec 2025 11:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQe-0000xo-EV
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:43 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQc-0002An-MN
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693638; x=1796229638;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BOun+Sp72zYjrToMaMpmKaY7e2ddR1tkuk9rWueIHxo=;
 b=DKqal6UtHl0dA4GvHTJlbJXhIAi5K52hXcIe2/X90euymA/Ul8+oWDbb
 FRAIxqoz1NlTqqydO9JLrHYNfKbfzNMTdfeGWeb9a4w6nNHMxryy0pJs+
 U1usLNgZKzIbF36v/4BP/al16PcRMxlqugDmiofpc2+ZRN2Lr1hw6Ucwv
 wTa58THGZxJHwQj42iFx2RqK40rOiw7cdVosYWDQLschaVlbnszjP7trn
 cI8oKa8oZdW+ku+j1EHr57AOdipHHi3lr5MgZrBQRTIBnnhIw86is71dC
 uv7FFs9ToPlw9qOb88oUWtFqsPq1PfdGTKouQXmCzr5qKVJHSxUY93sLE A==;
X-CSE-ConnectionGUID: 0jknPbSdSkWsJzDSOmcpmQ==
X-CSE-MsgGUID: 8LS7FJ44SXu0YSsuikBkbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555319"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:37 -0800
X-CSE-ConnectionGUID: USnf6YqQRWeHSGZ9FE1wAA==
X-CSE-MsgGUID: Dd0ER/bfSUevOgoPYLuQ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751249"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:34 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 03/10] qom: Check property deprecation flag for global property
Date: Wed,  3 Dec 2025 01:04:55 +0800
Message-Id: <20251202170502.3228625-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Global properties can be set up in these cases:
 1) external global properties:
    * -global command line option.
    * -cpu command line features.
    * suger properties from object_compat_props[2]

 2) internal global properties:
    * compat properties from object_compat_props[0,1].

In principle, when a compat property is marked as deprecated, it should
not be added to any object_compat_props[] as a compat "fix". Therefore,
internal compat "global" property use cases should also be considered.

All of these global cases are using object_property_parse() to parse and
set propertyies, ao add a object_property_parse_with_check() to enable
deprecation checks for global properties.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 20 ++++++++++++++++++++
 qom/object.c         | 13 ++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 8f4c2f44d835..bdeba113f40f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1555,6 +1555,26 @@ bool object_property_set_full(Object *obj, const char *name,
 bool object_property_parse(Object *obj, const char *name,
                            const char *string, Error **errp);
 
+/**
+ * object_property_parse_with_check:
+ *
+ * Same as object_property_parse() with extra check over property flags
+ * (ObjectPropertyFlags). This interface should be used to handle
+ * property settings for external users or internal legacy or compatibility
+ * cases.
+ *
+ * @obj: the object
+ * @name: the name of the property
+ * @string: the string that will be used to parse the property value.
+ * @errp: returns an error if this function fails
+ *
+ * Parses a string and writes the result into a property of an object.
+ *
+ * Returns: %true on success, %false on failure.
+ */
+bool object_property_parse_with_check(Object *obj, const char *name,
+                                      const char *string, Error **errp);
+
 /**
  * object_property_print:
  * @obj: the object
diff --git a/qom/object.c b/qom/object.c
index 184afc6730dd..2973d8876555 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -460,7 +460,8 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
             continue;
         }
         p->used = true;
-        if (!object_property_parse(obj, p->property, p->value, &err)) {
+        if (!object_property_parse_with_check(obj, p->property,
+                                              p->value, &err)) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
             /*
@@ -1745,6 +1746,16 @@ bool object_property_parse(Object *obj, const char *name,
     return ok;
 }
 
+bool object_property_parse_with_check(Object *obj, const char *name,
+                                      const char *string, Error **errp)
+{
+    Visitor *v = string_input_visitor_new(string);
+    bool ok = object_property_set_full(obj, name, v, true, errp);
+
+    visit_free(v);
+    return ok;
+}
+
 char *object_property_print(Object *obj, const char *name, bool human,
                             Error **errp)
 {
-- 
2.34.1


