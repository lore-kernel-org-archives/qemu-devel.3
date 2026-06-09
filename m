Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F843CD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D8-0007iF-A5; Tue, 09 Jun 2026 13:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cv-0007ZP-CH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ct-0001yj-38
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxoWieFRl5alZGyqHw8uY/Fy15O9Y6SOJg0ST4pPYm0=;
 b=cucbWn18pUEaVc7fwvtGmK6JqJmivvtLxxP+el0UwOLOx2/UylnpbX0FeDNkiR/QrcNsT8
 jJ6syunYE8K5UFg5h0f+oME/6w8SBUN08TzwIyQHK4WQr2aOgxkLJ4DZB7x0VzIoO2p3f3
 oW9lmUXzsHHb5MxngJ6S8JWy6E9uiHo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-hyrcOKY3MKCWbyGYTtj19Q-1; Tue, 09 Jun 2026 13:25:38 -0400
X-MC-Unique: hyrcOKY3MKCWbyGYTtj19Q-1
X-Mimecast-MFC-AGG-ID: hyrcOKY3MKCWbyGYTtj19Q_1781025938
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177f07eb05so113541161cf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025938; x=1781630738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxoWieFRl5alZGyqHw8uY/Fy15O9Y6SOJg0ST4pPYm0=;
 b=hGNt6yeXzhv4EDj1Wnv0gVzHkNMMq8wGvUjcEVqIeIR7f2jxdFZk4/lDnuPZDzcBjH
 UByHjBXQqVzc0HHI/5//xL1663UpZyY4Ks3vmXvkz3FdaN5KRQ3rkqS/hGWG9GKlAlY1
 7IkQY8b2LhVOo+mwQwT3aF69JeEz3x4P09t6GPNvamUT0NDtGqkbTIKOQMVGZQ/MLoUt
 JfrTaNnt96y2cQDV3PpAW3TZG9ZBTv4NyKb3c8zB74dVdOEAQqySYvT31CzC6Q3bDuES
 pKkwiSjPHaPcwgXTw9Ljkuo6crov+8DC9LvTUG/p6T0BNtSQOdtFT9ECGaJVPjyxOOzf
 GSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025938; x=1781630738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxoWieFRl5alZGyqHw8uY/Fy15O9Y6SOJg0ST4pPYm0=;
 b=iv9G+n0sk9xY7nNs2gFYB8Lj3tfAhU4xHeNUTvxNrGbEJ3mzN8MZArzpyEdXn7fV0D
 BR59IiD86HIdE8cSug71o3XHGORCbGY3nXS9HvOxcZ5K1jPQe+7RdWTGwnDIgnqVEB5o
 ZcU2L8dG3GYpcoxq1pK+am02wfHFOy0uLgqida4DRvKDjwNeUFCibMy9tB4+075CgogZ
 pQNc94CkJQJLmc6l+smrSTzrHcpcnFLPEkJFwolvjhFyv2J/mp8VMDDUsmjSJwHe5l/n
 0S2NvwbGZkdRP10FMoTjl5EFJKo0ES8BAjsXpJ1DYX23dLw53HfNh7v6POLm9NNhTd1E
 WyIA==
X-Gm-Message-State: AOJu0YwRDd8tJlbiD7rxLyK6qs/9f9JkhKwW6HwS2zpx0a2lyOQVT4H9
 vdtDqdjLVFwpr8WBS5Tc3ks6iz+aAV6mQ2FJT/QhJGwPtBVpbA+PZLMzhqHfKF1MooWJ9qz2Js4
 RauxCpgF0ZsuwG6OwKoH5kHBfqhSdJmIhziKh75WSLLrwcymDOlZhHG4toCi+0QiqC9II7B4oI3
 uECGcr9wH+hp/Sqgqamwuy64ykVzPsyi+E40N5fA==
X-Gm-Gg: Acq92OGsogyH61WRh3kswPymo44EJDxVn5DVQpgTQs1x99EIolsJUFopvQV0jCZ+s6w
 HhvYSs3Nvk6isMc0hlP2LNdjdvqlLzbWwAjrYcuaN2GlDyJVGg0Nb0R+MbuScad8XyxafBJQ5pM
 N0sfzay3rsceliPbMjsOOFCyyoyGqu56m/N/ZedEr1BR0D04YCkUpkO8RIX/mlVtLBOKTg222to
 z7vsqaTGWMpPcrq5KM9k3+umWYDji8mfcyOB1kHyYyBDhRVOAuA0bgF9dgW29L/FA3jXuc1qcba
 QjLFF32Q4KDzRJ5TgiSrBgvtdjus/Z3xO+oeT//96WVJV553tU8kMM/VW5sUfxVcBE1VCEr24PV
 f9zLSiIGXGaBMp190TfmwUzM=
X-Received: by 2002:ac8:1342:0:b0:517:6339:41d0 with SMTP id
 d75a77b69052e-51795bbf6c2mr213878621cf.29.1781025937892; 
 Tue, 09 Jun 2026 10:25:37 -0700 (PDT)
X-Received: by 2002:ac8:1342:0:b0:517:6339:41d0 with SMTP id
 d75a77b69052e-51795bbf6c2mr213877991cf.29.1781025937264; 
 Tue, 09 Jun 2026 10:25:37 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:36 -0700 (PDT)
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
Subject: [PATCH v2 09/10] qom: Allow default values for instance properties
Date: Tue,  9 Jun 2026 13:25:13 -0400
Message-ID: <20260609172514.2037645-10-peterx@redhat.com>
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

ObjectProperty allows default value settings via proper setup of
prop->init() and prop->defval.  It currently is only supported in class
properties, not instance properties.

However, since QOM allows class and instance properties, it should also
allow instance to add properties during instance_init() and allow the
default values to be applied properly for this instance only.

Add the logic.  It will be useful for all kinds of pointer based properties
because pointers are normally not accessble in a class but only when an
instance is available.  This will be able to achieve similar function as
what qdev properties have (which works by remembering offsets within a
structure instead).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qom/object.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index fc738549dc..eaef615924 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -487,6 +487,20 @@ static void object_class_property_init_all(Object *obj)
     }
 }
 
+static void object_property_init_all(Object *obj)
+{
+    GHashTableIter iter;
+    gpointer key, val;
+
+    g_hash_table_iter_init(&iter, obj->properties);
+    while (g_hash_table_iter_next(&iter, &key, &val)) {
+        ObjectProperty *prop = val;
+        if (prop->init) {
+            prop->init(obj, prop);
+        }
+    }
+}
+
 static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
 {
     type_initialize(type);
@@ -498,10 +512,22 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
     object_ref(obj);
+    /*
+     * A few steps to initialize properties for the objects:
+     *
+     * (1) apply default values from class properties when available
+     * (2) invoke instance_init(), which may add per-instance properties,
+     *     which may further contain default values
+     * (3) apply default values from instance properties when available
+     *
+     * instance_post_init() should happen at last, after the instance is
+     * fully initialized.
+     */
     object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
     object_init_with_type(obj, type);
+    object_property_init_all(obj);
     object_post_init_with_type(obj, type);
 }
 
-- 
2.53.0


