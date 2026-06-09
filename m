Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD7CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D9-0007m4-4W; Tue, 09 Jun 2026 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cr-0007Xh-Fi
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cp-0001wH-1Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqrDCR+oRMqmtrsRDcLBvqMYTFGEeRtYsKQ4H1N/ZoA=;
 b=RhGfw11t6e+jWO69po1iwqjUXf40YivrKsJ0A2gyk+b1DKQXMsGjHQg6SBLW6PKC1wDPpU
 iK8YtUfIL8uqaJnJcpdibzIPKX2B3HGgF3Emzsjc1r6TaDTzwAyk0BhlSnUQrF2IvwHvId
 j4WJ6vSx6okvRXWEW5ni+byG7iOV5jk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Xf15pr7ENqi3i5rvGhTvdg-1; Tue, 09 Jun 2026 13:25:36 -0400
X-MC-Unique: Xf15pr7ENqi3i5rvGhTvdg-1
X-Mimecast-MFC-AGG-ID: Xf15pr7ENqi3i5rvGhTvdg_1781025935
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178fc89b1bso73796321cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025935; x=1781630735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqrDCR+oRMqmtrsRDcLBvqMYTFGEeRtYsKQ4H1N/ZoA=;
 b=WG/ZcHKowof8F6BfZVk97TZH8qQx42miRZg0/XwanERINb2tCZ8wqI7kz6Qyfn2eaK
 xK7oGUvvIQLeKf8hQ9JxTih493eJ8RWE4hf3ZZMVIwdOG4rtMth5YF0ggYcQeP2kZ7YB
 XYZLsUlSjCbh5B/zFHWZmBRHEJ/JGy/2Whuu3pc2V+RKKoVkixb6rgMiGx/Jj1l82/EU
 xceGtoKAvKTEaIdjGZo29zpuTHIsLUt40FZYdlVfRRSrOiTyiJQXCdKYRg+nuhh8Yuy/
 UEhHMWHmMvjXamrbrwUiafX8Ux9+rGw1F44UmLwKN1v6LHPl55JrmVWe8r/DmQn8bheP
 mmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025935; x=1781630735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqrDCR+oRMqmtrsRDcLBvqMYTFGEeRtYsKQ4H1N/ZoA=;
 b=R1SKpWPAbJPfy8xB6XGKoHES2ierLNXKndAaMWQzDdEmLs0FBmchYpewrpc2SuXJDi
 AU5ilOb0BKlniR4h98bpHqBwp9pVWd9X8z0IBe12QdotCGH703vbuxcuRvEUuvQH941I
 Pd/64WyShRbUPR7kTI3QvmHwvoSvTXRQXbLI0rhWaeMjJlFIe/nrvnvRYmYvKGz1Aq3I
 5bpTBWu8aFVdLtG1B/GshOQ0CT+LEn1n2eE2DLEKvqJ9xZz0/CuXHwjvb5fxAmbBLE9D
 ykxYunNOCtlFcIon5U5rhZDpUQgidfFng3er/mwqS1EMIVxK+GVgZZ6R29cjgLJYW+aB
 rghw==
X-Gm-Message-State: AOJu0Yy1ILEQWTzvFucZE1Aa1xlKfWiqTBs7dXd5CseDo+TOX/inLNvd
 /AAWaYbCmFodC30R2MhWRLfEXIulVvRcHoV2OixqHxhwkrGIqAJ2FQ+zUacATclK8ZTaUUwkq79
 GHfvsOiPouB64JUruWmyyBsh0TRdhoaFOw5mjUTCT9U0e1yMPP047Mizbp1lr7xmFKVmSM5QK+x
 KiCj0+ZfZsrYStwsGonve+8VG/dZsxwTDnEcnQrQ==
X-Gm-Gg: Acq92OFyi+5QQlI34mCPsae3tP0/CfbX9P5UVXhsXVDoO7cRiru6dT6CyWlb6nIDOlm
 eixnkIJarANLRVMlmc61PbcS9WHJXKWBq0GrgsbCOkMjfGba2cvxyiw98za3vVt1E7yd3DeEqiF
 PkAa2qhynn7ZmL4GYyx0Az4Y0c0uAt9BKNihwAZiezjAe+aACgoWy+rIaAAHckzvn5xkYXa8ke5
 3svOitMljupznm4VIlZBPVgbN1a2yyVKxGCisXSqLPDHr2My6vlWP8sggMoVxquqxFZyYdyo3Oj
 tVA20KlVWIGBKSAyhW8om+sRRmorFsXVYE47/H9qMWvNkTidXB6nbAqNzLMnK6fYm7CUmNCQzA1
 u4aHloHyfmTZaWNnEYZzYNyQ=
X-Received: by 2002:ac8:610f:0:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-51795c09df1mr301393091cf.46.1781025934920; 
 Tue, 09 Jun 2026 10:25:34 -0700 (PDT)
X-Received: by 2002:ac8:610f:0:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-51795c09df1mr301392161cf.46.1781025934194; 
 Tue, 09 Jun 2026 10:25:34 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:33 -0700 (PDT)
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
Subject: [PATCH v2 07/10] qom: Add object_property_add_size_ptr()
Date: Tue,  9 Jun 2026 13:25:11 -0400
Message-ID: <20260609172514.2037645-8-peterx@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a helper to set qom property via a size pointer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object-property-ptr.h | 16 +++++++++++++
 qom/object-property-ptr.c         | 40 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
index 9cd8600094..be467c64af 100644
--- a/include/qom/object-property-ptr.h
+++ b/include/qom/object-property-ptr.h
@@ -115,4 +115,20 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+/**
+ * object_property_add_size_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add a property of type 'size' to the object.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_size_ptr(Object *obj, const char *name,
+                             const uint64_t *v,
+                             ObjectPropertyFlags flags);
+
 #endif
diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
index 49f223da7b..21ceb2510d 100644
--- a/qom/object-property-ptr.c
+++ b/qom/object-property-ptr.c
@@ -107,6 +107,26 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
+static void property_get_size_ptr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    uint64_t value = *(uint64_t *)opaque;
+    visit_type_size(v, name, &value, errp);
+}
+
+static void property_set_size_ptr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    uint64_t *field = opaque;
+    uint64_t value;
+
+    if (!visit_type_size(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 ObjectProperty *
 object_property_add_bool_ptr(Object *obj, const char *name,
                              const bool *v, ObjectPropertyFlags flags)
@@ -285,3 +305,23 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
     return object_class_property_add(klass, name, "uint64",
                                      getter, setter, NULL, (void *)v);
 }
+
+ObjectProperty *
+object_property_add_size_ptr(Object *obj, const char *name,
+                             const uint64_t *v,
+                             ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_size_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_size_ptr;
+    }
+
+    return object_property_add(obj, name, "size",
+                               getter, setter, NULL, (void *)v);
+}
-- 
2.53.0


