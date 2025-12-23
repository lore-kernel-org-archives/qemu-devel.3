Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8AE6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pv-00029B-Ce; Tue, 23 Dec 2025 09:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PE-00018x-Fi
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PA-0003mK-7U
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OHM0sHmKXVcmlK09PwnR6A15OlmIPDNYfI+M1nhjB4=;
 b=QRnbZgf6FYyzu2qxEDLkQmpZahYiZICeS0wfypfjxrbnZNFe9wYD6IIO6cR7FHz5a1OFk/
 A+n58xYycYz1orOlu8DbHZs75i6aLpbXKB/D++kbjFyzSKvKeIsqXEPE77hB+IviuXPBrr
 641sx1GV1411tBbm4erB4642jjNPdI8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-vNRhiAspOpu1DEZvjJnXqw-1; Tue, 23 Dec 2025 09:30:24 -0500
X-MC-Unique: vNRhiAspOpu1DEZvjJnXqw-1
X-Mimecast-MFC-AGG-ID: vNRhiAspOpu1DEZvjJnXqw_1766500224
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b51db8ebd9so1571024185a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500224; x=1767105024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OHM0sHmKXVcmlK09PwnR6A15OlmIPDNYfI+M1nhjB4=;
 b=JRtF3mNA/MhtAxji8E8ef5oWVSHmYXHMlXxCI6f3Cv9qM4GS5Jh4jyzsGyda9tcGqZ
 VgRmf9c+jiqBociyPw3m6W8CqHgXNukKihzhYhPpbp8j+4x5/NFfPio4XnmD71aaT+/G
 x5pX4nuhqbNk+koAa8135a1uR25A+46SKq/K/KlB+CeaoRa/eJTuIYibkGKeTy75VDkq
 sGvrD5RUW9DqeERMXjYe0SLOTfLEt/g05TLeAUOLUxIBVAp5/nAKtaBeysRughIS2RNe
 ABGZxzFHVYhpQqdTh1yDi2otf2BnSawwXnFrCDMiOSKxAZsjJ79YVrIcmpLPXRJkB7hs
 PgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500224; x=1767105024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3OHM0sHmKXVcmlK09PwnR6A15OlmIPDNYfI+M1nhjB4=;
 b=lbCMpxgLKhP4DN0lOYVrCnCEb7iCuEm1nyf/w7pukogOxpq2btZQmjLLMVL2v5s2L8
 MhJyO/IJscrSmdzmdGZHmEJs1N4A5A7yK3u7LMv+uJFEJCnUVs3b/CRe8kIISqvh8G62
 NrShvFidLyo9IhH3JaBTzKDNIckd37Sq8BVzWiHfIovBZyHA7rVF1rZXQbJHfMlQT/F/
 fG48q+QmyV9v45ZgUW1qYQijqTvyDi/sZTjVBSRj5n9ur7f9m9pQ2bl2TlT2rlMKoGCb
 eQBDTjuaJKO/hhTfrOyE/Nr9LtgHPIf17p6RH+cF+xsHNKc/QFbfARhEVoguAjLNC1ZL
 BhJA==
X-Gm-Message-State: AOJu0YzCRaTkJVvkXQzJvyzorJpGrbrLaQqLF7jeN3N6FScbt5CSfA1e
 sUZEyjQ2NJt6i56WgNhwRgWwAKqMPbpv0Aqs5MJQNKgZNRQSwE9757xqh4yUsKDGJPDSENgNrPO
 Xiqa4gw+gY7So60tgxvchqNcjEDkRwzQUbKRwF2xvqTxLE8Uvxs/3uReOFp8LvqKn3+5Ud+HVgN
 mrYzhiPXND603pNXc7aIhMl1kQP6x90NqtYhyEIw==
X-Gm-Gg: AY/fxX4z9pgM/MzNkTtDrKxSMeXFvqv0q6AHtqK7yEstgzEi1zI7RSsGhqKVs1AVwO+
 B2IqQoPFl13b4Zj6Txw8qRUZhOl2eyyt7iWpOl1aTJ5RWP8z/LsXYfp/kQk8V3JNY9zpeesMo5x
 7JItRNHdn4LvROWsb8WWQ6V3JRzGo1nI4LhWFch40Gy8PXZ7Y+aDT9FWQamn3QqUhGRQa3GAZ7D
 WeEXr1ZUCUD8TLpCFeP3pRhWGtr+V9/T4KOvswMzFNiQ9AKkROAuf+CbK7OCj63FBV5nnvmf9X1
 Q5qEb1FmAeF4i6aalBaTXWmkInU7dc/jgg6Q/rRd2sTJHk0AX/6A0n/oDSF7CXnjzp0IklJS0mO
 TGbk=
X-Received: by 2002:a05:620a:19a2:b0:8b2:74e5:b3e with SMTP id
 af79cd13be357-8c08f6823f7mr2028395985a.36.1766500223677; 
 Tue, 23 Dec 2025 06:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE60+XZG6f2WaNYTxmF8n456GYv4g0/c9WwBmfNJ8sDIYR+WNQ7HRGOsdIlKoVwxFwSXcsJDg==
X-Received: by 2002:a05:620a:19a2:b0:8b2:74e5:b3e with SMTP id
 af79cd13be357-8c08f6823f7mr2028385885a.36.1766500222918; 
 Tue, 23 Dec 2025 06:30:22 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 17/31] migration: Add a qdev property for StrOrNull
Date: Tue, 23 Dec 2025 09:29:45 -0500
Message-ID: <20251223142959.1460293-18-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
was done about eight years ago so the migration code could make use of
qdev properties to define the defaults for the migration parameters
and to be able to expose migration knobs for debugging via the
'-global migration' command line option.

Due to unrelated historical reasons, three of the migration parameters
(TLS options) received different types when used via the
query-migrate-parameters QMP command than with the
migrate-set-parameters command. This has created a lot of duplication
in the migration code and in the QAPI documentation because the whole
of MigrationParameters had to be duplicated as well.

The migration code is now being fixed to remove the duplication and
for that to happen the offending fields need to be reconciled into a
single type. The StrOrNull type is going to be used.

To keep the command line compatibility, the parameters need to
continue being exposed via qdev properties accessible from the command
line. Introduce a qdev property StrOrNull just for that.

Note that this code is being kept in migration/options.c as this
version of StrOrNull doesn't need to handle QNULL because it was never
a valid option in the previous command line, which took a string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251215220041.12657-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index ea19b2c7cd..d55f3104be 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -83,6 +83,11 @@
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
+const PropertyInfo qdev_prop_StrOrNull;
+#define DEFINE_PROP_STR_OR_NULL(_name, _state, _field)                  \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_StrOrNull, StrOrNull *, \
+                .set_default = true)
+
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
@@ -208,6 +213,68 @@ const Property migration_properties[] = {
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
+static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull *str_or_null = *ptr;
+
+    if (!str_or_null) {
+        str_or_null = g_new0(StrOrNull, 1);
+        str_or_null->type = QTYPE_QSTRING;
+        str_or_null->u.s = g_strdup("");
+    } else {
+        /* the setter doesn't allow QNULL */
+        assert(str_or_null->type != QTYPE_QNULL);
+    }
+    visit_type_str(v, name, &str_or_null->u.s, errp);
+}
+
+static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    const Property *prop = opaque;
+    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
+    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
+
+    /*
+     * Only str to keep compatibility, QNULL was never used via
+     * command line.
+     */
+    str_or_null->type = QTYPE_QSTRING;
+    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
+        return;
+    }
+
+    qapi_free_StrOrNull(*ptr);
+    *ptr = str_or_null;
+}
+
+static void release_StrOrNull(Object *obj, const char *name, void *opaque)
+{
+    const Property *prop = opaque;
+    qapi_free_StrOrNull(*(StrOrNull **)object_field_prop_ptr(obj, prop));
+}
+
+static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op, "");
+}
+
+/*
+ * String property like qdev_prop_string, except it's backed by a
+ * StrOrNull instead of a char *.  This is intended for
+ * TYPE_MIGRATION's TLS options.
+ */
+const PropertyInfo qdev_prop_StrOrNull = {
+    .type  = "StrOrNull",
+    .get = get_StrOrNull,
+    .set = set_StrOrNull,
+    .release = release_StrOrNull,
+    .set_default_value = set_default_value_tls_opt,
+};
+
 bool migrate_auto_converge(void)
 {
     MigrationState *s = migrate_get_current();
-- 
2.50.1


