Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC1CD98C7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D1-0007dr-UD; Tue, 09 Jun 2026 13:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cr-0007Xf-F6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cn-0001uN-3R
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwLp2AvTjapZW+/ErJH1EShXN1MPuQYDgyT1L5wHR6o=;
 b=iZNdObHyQZPrVYzuCJR+k9MtDo4r3GkAUCabumDH2zNw8jB7GbplAXjVwA0VbPIDKuVEAk
 qvBXTl443XmAhG439GZgz3T2D4baqsWOCKcR+SkQsKSKOnczxSCrYLwE0k6aobtT15uxMX
 w07k1xyl5nNiMvJoxzKpmmUjKmMs178=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-m9XVQS3JPBu5BhyWvEKSwA-1; Tue, 09 Jun 2026 13:25:34 -0400
X-MC-Unique: m9XVQS3JPBu5BhyWvEKSwA-1
X-Mimecast-MFC-AGG-ID: m9XVQS3JPBu5BhyWvEKSwA_1781025933
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cceb5a9686so70703076d6.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025933; x=1781630733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwLp2AvTjapZW+/ErJH1EShXN1MPuQYDgyT1L5wHR6o=;
 b=PlgwPHrnURK7QiaTwQwLu/kkNTvER11jsM7x3cHzd10vdl71CLv/+T6RoHLP7/1wde
 MlMMIBSzogBDXleJ3TKmRyC4bh9P1B4hXTnwcm+zHGQtI4NUBFz5DrofeNBuE3quknGQ
 T0gdypUDs0B6jpiN9z4duUPC8DxoHYlNYFE/B8t358gM9dyZ2EzYewWfXX3xBvj/UhnL
 UxYV2Cv/Qd8I8ifKqCMqPCP4npOjm/kIKBOT+8SWWeHZ+JZfziQC3QGdDhp+EAaJdtxC
 OCyE+DEFNqoh8PAmtJhIcX4Oav6qzKK/PytvbVya7qAdOhk4rCsZ4gwNiWzNAwl8BJmz
 eYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025933; x=1781630733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwLp2AvTjapZW+/ErJH1EShXN1MPuQYDgyT1L5wHR6o=;
 b=Md2CfvNcXw8A8iF+7Da+w+HiBp25EfKvWkJHyP4CSAoX9gj3sc65x/1tIssKYoUBLv
 5+BAMnzro1ZG7mwM6ldGrvMjt5mTLDsvQTjQFdA2wG8lv8TV85apMmtO0HSbxTOfQfxK
 LQ8lkjAWC0Bek/LCQSkO/slSAep7x+9y67ih2kXGHGy/HIUo8LaxSh/HQlC4xVQbE2QS
 M4YlvOYeRjPFl0BGKxsmIXmD1PTRaQgrQ2dKvrK5A0MWL08hNZutVgSoGO7H8ByA7HIy
 uEM8SSlYgJXwnSrhbGNA1Wt2ZFYiyzg2zBOErOBg1N/vVMZuC+QsZb2lYQg2FwtPp2ra
 gT0g==
X-Gm-Message-State: AOJu0Yzubw/X1emMmPjtZbpIvStr9k9CUQr92VFWsNO7oiqrIYXTZyox
 d033nZ7j/Cv9E59RlRBGShm7Zf/atqgyoIOd3AKyAWtH2HFPILEPU2zWaj0xWm1spIitqpp67aj
 /j0FmJ616VpBhfsFE8/42Z98iuOHnex/gtExbtG9p0IghjKY8hDI0aQPPWsBrd7odUjAUNyZPeD
 CKNPtJxSDTHTVkUqdv9wTOscPlRjS6ycQRST5bsA==
X-Gm-Gg: Acq92OFLVE6wJQQ3dZ9o7ICQ9vAH/L5k1zkf3Iqpf1iV64sgyFre2CSsFTxrczvczHl
 fyVd8zVUUi3vx2kcd5jlch/+dfpKy12kcFPw06Za3SEzCeC6lR9rvYcHvHE6OnanrMg7YrnBrz0
 83dp3WaXmzbc4Xx5VAdIi209AN3GKGw8uwlg2rxFpgpTPoQF06ZSTfaTlaErYQ/7SJo608lmcbv
 voCUeW2idc8FtIWhHqkuoY97SDxvyWLQKRX77mTf29eVwHE/3QySLUXkvCEYSIsRp11s7w0dTXX
 XCyvN05v6YCBPgPV5GvYkxvId8q1Wd9NwbTqI2M/7+Jd5rcNLpmBmeKNTE49RhRZBQdTHykL2pk
 fFi1p/wwyCOLW41W6RGZsae0=
X-Received: by 2002:a05:622a:460d:b0:517:a9ef:ce23 with SMTP id
 d75a77b69052e-517a9efd0c9mr162127391cf.16.1781025933335; 
 Tue, 09 Jun 2026 10:25:33 -0700 (PDT)
X-Received: by 2002:a05:622a:460d:b0:517:a9ef:ce23 with SMTP id
 d75a77b69052e-517a9efd0c9mr162126561cf.16.1781025932578; 
 Tue, 09 Jun 2026 10:25:32 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:27 -0700 (PDT)
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
Subject: [PATCH v2 06/10] qom: Add object_property_add_bool_ptr()
Date: Tue,  9 Jun 2026 13:25:10 -0400
Message-ID: <20260609172514.2037645-7-peterx@redhat.com>
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

Add a helper to set qom property via a bool pointer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object-property-ptr.h | 15 ++++++++++++
 qom/object-property-ptr.c         | 39 +++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
index 6066c377fb..9cd8600094 100644
--- a/include/qom/object-property-ptr.h
+++ b/include/qom/object-property-ptr.h
@@ -16,6 +16,21 @@ typedef enum {
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
 
+/**
+ * object_property_add_bool_ptr:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @v: pointer to value
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add a property of type 'bool' to the object.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_property_add_bool_ptr(Object *obj, const char *name, const bool *v,
+                             ObjectPropertyFlags flags);
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
index 02c01ed7f0..49f223da7b 100644
--- a/qom/object-property-ptr.c
+++ b/qom/object-property-ptr.c
@@ -7,6 +7,26 @@
 #include "qom/object.h"
 #include "qapi/visitor.h"
 
+static void property_get_bool_ptr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    bool value = *(bool *)opaque;
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void property_set_bool_ptr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    bool *field = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -87,6 +107,25 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
+ObjectProperty *
+object_property_add_bool_ptr(Object *obj, const char *name,
+                             const bool *v, ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_get_bool_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_set_bool_ptr;
+    }
+
+    return object_property_add(obj, name, "bool",
+                               getter, setter, NULL, (void *)v);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.53.0


