Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3076CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0DP-0007xm-27; Tue, 09 Jun 2026 13:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ct-0007Yk-Ff
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cp-0001wQ-1k
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ho/BMxX8YnQ131yrIsVBM8rRwXj38KUVhIf57yJSr4U=;
 b=bg8GlfcNg+UjwN8AglCYLU3chZkPv6YbR9Lay57UGJAnRxPnNe+oDg85LS0+CjaaUknsP7
 GX/FYW/aScVbjAztQrRKTFnO6MBXTsKvU0aROVx8yjJMAUPoIoGeMYXn3CqV9a1O+9pV7d
 uwpvFw6jQSPTpdBZaFp8HL9etMEAYSE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-FWqkvaQFO-efcUz4EcTqNQ-1; Tue, 09 Jun 2026 13:25:37 -0400
X-MC-Unique: FWqkvaQFO-efcUz4EcTqNQ-1
X-Mimecast-MFC-AGG-ID: FWqkvaQFO-efcUz4EcTqNQ_1781025936
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5175a1e32e3so158592571cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025936; x=1781630736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho/BMxX8YnQ131yrIsVBM8rRwXj38KUVhIf57yJSr4U=;
 b=kKHFv8Byd8pcIHp+ujKMQNIjHTW0jlEiXtt6+SngpDTi/yUVWUQNx56U8RrjVpgX5v
 mP/mMC0kBCiK3vvbLGP+sY0ji5BGtbdOlZ5gOiUa4C0g9hEp9p8gtZZpXEyQo6QGvtr2
 D+46KbJwyaGjIa/CoLKjvO/xRY5rSRfqO9oLDMyAphat68AlzBPGODV+92AHC32AYG8N
 FWBVwfMTL7KUvEkSYfWyNxw5veXvwVx9EKTyrfrVMkZt1XQmrXFwjWlpngLaVPp8ThZC
 V5mwd6Xb6/a9CjVQuQTTRihFf3X64RyABRwBE+RmAwOtLW7jahIaMcQ4ip2AJ6OfvEnB
 20cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025936; x=1781630736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ho/BMxX8YnQ131yrIsVBM8rRwXj38KUVhIf57yJSr4U=;
 b=B1d1CfQsHV9t+j6EqkNlXCHyfnTzzUmu/FfCLZull/crBnHVVY4gyr/STSMrF4nm87
 I+mi3QVFquHfz8XDXL2ehxbash5r4YRdHOFAs/lM26qIUXLeWeQ+deCwJCh31sNdDmD4
 7IKIRW2bpVDeRzbzsoPzt4aBp+KMu/pfu3So+JwBTx4ttMdTV/jZ8rihN9ajK4zaeFyM
 UiBQ6Cy7oNzrQfT2ApA7dns+z1+O9rHJHg5IyZPcU0VmE/7hPlcMmi9vLs4xap/2Wgqt
 oF4Usnj9515wtkKO7Jnpi00NXvzZd5AhUofJ/wEHW43D8ge7/Vr9XJrdlGV/ZTNBEwQK
 EeVw==
X-Gm-Message-State: AOJu0YwqLZ4bZHE1S8m96DQvEk82QgWolMWz/wpk34tQzXOapshfRYhm
 cSBrFhpGml+LB2fmJIaoQVGIpKkbiVfn1Vv/DIgvVjZnOQbtaIO0JSAsQATwQxQzWebLCloT1Yh
 27r7heTZFnkCT5oNH9bUAS1xOlUbz3lOz3ETLyGiZFXqYPQyIGL/zg4EI6ciiJkZWKcxg13XJOs
 d3GZMhsCcSIywEXaBd4iBS2znaBNo4YWkOMwXB1g==
X-Gm-Gg: Acq92OFuzRlEmV603N32+o7ao4iN7eXVotp5+PiXWcqJ32RtGGTgtjP3rFy/Pts091F
 TbMbs6tW+e0gvqF3nWBc1sBRkSTHgxHnUYIqSW5Jc4k54DIZED92e4jxiKUC8PJHHZSrx9cORKo
 xUkmwEucG9gcw1QzY72HshFF9JuBUG6SKJL6sw+23XLFeVL6upok1GbmZKOxj9CZXKwmTgrqwTB
 vg0LUc3/BLJBfIMQ0qVfeO1VY54luDjjxkr25St2hbL7eYV6jtZ5aGauIGrFKdipi1gTkk2otJa
 rTPwSPa8Oda35FJsxTvgDb94ZPofVR1VTk+Rh+GUCQWtkFMjrrZDlpiYnR9lUl7QFu7/PNw2sDO
 victygV9lXqJ0cTmTHw1JDjw=
X-Received: by 2002:a05:622a:400c:b0:517:7971:a234 with SMTP id
 d75a77b69052e-51795b729ffmr305681801cf.4.1781025936415; 
 Tue, 09 Jun 2026 10:25:36 -0700 (PDT)
X-Received: by 2002:a05:622a:400c:b0:517:7971:a234 with SMTP id
 d75a77b69052e-51795b729ffmr305680851cf.4.1781025935723; 
 Tue, 09 Jun 2026 10:25:35 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 08/10] qom: Add object_property_add_*_ptr_def()
Date: Tue,  9 Jun 2026 13:25:12 -0400
Message-ID: <20260609172514.2037645-9-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Add sister functions for existing pointer versions, to make it even easier
to use by:

- always make properties to be rw-able
- allowing to specify default values
- no retcode needed (assert on failure, always)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object-property-ptr.h | 28 +++++++++++++
 qom/object-property-ptr.c         | 67 +++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
index be467c64af..ecd6f7819b 100644
--- a/include/qom/object-property-ptr.h
+++ b/include/qom/object-property-ptr.h
@@ -131,4 +131,32 @@ object_property_add_size_ptr(Object *obj, const char *name,
                              const uint64_t *v,
                              ObjectPropertyFlags flags);
 
+/*
+ * Below are sister helpers of above, except that:
+ *
+ * (1) nothing is returned
+ * (2) always make the property to be both readable and writeable
+ * (3) allow setting default value
+ *
+ * Please refer to the sister functions for the documentation.
+ */
+void
+object_property_add_bool_ptr_def(Object *obj, const char *name,
+                                 const bool *v, bool def);
+void
+object_property_add_uint8_ptr_def(Object *obj, const char *name,
+                                  const uint8_t *v, uint8_t def);
+void
+object_property_add_uint16_ptr_def(Object *obj, const char *name,
+                                   const uint16_t *v, uint16_t def);
+void
+object_property_add_uint32_ptr_def(Object *obj, const char *name,
+                                   const uint32_t *v, uint32_t def);
+void
+object_property_add_uint64_ptr_def(Object *obj, const char *name,
+                                   const uint64_t *v, uint64_t def);
+void
+object_property_add_size_ptr_def(Object *obj, const char *name,
+                                 const uint64_t *v, uint64_t def);
+
 #endif
diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
index 21ceb2510d..ae9081d2d8 100644
--- a/qom/object-property-ptr.c
+++ b/qom/object-property-ptr.c
@@ -325,3 +325,70 @@ object_property_add_size_ptr(Object *obj, const char *name,
     return object_property_add(obj, name, "size",
                                getter, setter, NULL, (void *)v);
 }
+
+void
+object_property_add_bool_ptr_def(Object *obj, const char *name,
+                                 const bool *v, bool def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_bool_ptr(obj, name, v,
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_bool(prop, def);
+}
+
+
+void
+object_property_add_uint8_ptr_def(Object *obj, const char *name,
+                                  const uint8_t *v, uint8_t def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_uint8_ptr(obj, name, v,
+                                         OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_uint(prop, def);
+}
+
+void
+object_property_add_uint16_ptr_def(Object *obj, const char *name,
+                                   const uint16_t *v, uint16_t def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_uint16_ptr(obj, name, v,
+                                          OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_uint(prop, def);
+}
+
+void
+object_property_add_uint32_ptr_def(Object *obj, const char *name,
+                                   const uint32_t *v, uint32_t def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_uint32_ptr(obj, name, v,
+                                          OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_uint(prop, def);
+}
+
+void
+object_property_add_uint64_ptr_def(Object *obj, const char *name,
+                                   const uint64_t *v, uint64_t def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_uint64_ptr(obj, name, v,
+                                          OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_uint(prop, def);
+}
+
+void
+object_property_add_size_ptr_def(Object *obj, const char *name,
+                                 const uint64_t *v, uint64_t def)
+{
+    ObjectProperty *prop;
+
+    prop = object_property_add_size_ptr(obj, name, v,
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_property_set_default_uint(prop, def);
+}
-- 
2.53.0


