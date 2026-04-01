Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D8D35154
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BT-0004MJ-Q7; Wed, 01 Apr 2026 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BR-0004Ko-Rt
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BQ-00039F-9R
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3KS3isoeM2A51oCNrcxhEcDD2YvjinIbubXfJ5TPfE=;
 b=jHNFcQ4SAJu5D9MQT2yt7izTZi/ChmS004etXE8Y6xDpIDVN9mh3geCaLuHm1JbxhdkAVL
 cHUOZz5PrGf51OfD4+SkX+RH8B9v3oLCUoLFL3qFowewxTqrfdF0l2xMRfDVAm7rJR4SZh
 NNWysXj4PrD9uOIB1ro5Bs4IITg4R8Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-cSyKGx1pMtalhM0garvwuA-1; Wed, 01 Apr 2026 16:28:58 -0400
X-MC-Unique: cSyKGx1pMtalhM0garvwuA-1
X-Mimecast-MFC-AGG-ID: cSyKGx1pMtalhM0garvwuA_1775075338
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb0595def4so55244785a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075337; x=1775680137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3KS3isoeM2A51oCNrcxhEcDD2YvjinIbubXfJ5TPfE=;
 b=Y74KgR+3IZMuByyNBlZ9UQxAYJUxNd3oxLOm/cQENZx/JZiRPaigGCY4+LPRdOW2sn
 Dk2yQaE1Dwf0CheUl4eCaiHTMn9O0OhFu1yuVULcfDWeWx/In4kPe0/K6DRTFz33wuTI
 DLR5JJ4jy0kVEU+KPn5pG++kCnHWCdd08HsW7kTTYmLU3JUlax42GwWmxlvx++ViIf+m
 F+pDz4ylB0iCcciG6BXp7wW0G6eJu26fWbi8BrnzWyHc8M9kmnrHBzzFGdJRlMLqIFAK
 EVuQKAHwMpsdIFfP/bDO8q96PLMyC7pNIFnN+P9jPICyYm3O2SHHL/Ikn5/WYgHEbYZM
 9gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075337; x=1775680137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3KS3isoeM2A51oCNrcxhEcDD2YvjinIbubXfJ5TPfE=;
 b=h3KEgPw7js2pjHdgge6Q7HRNJTw7m5xl2vijDUw4HX73v+ft6EQqQFN0tMmhUBwaeL
 Tvot8Wnujck0gGjEPvINR40n8AZ57KBpM1LRmb9IQLHusOk2sSSaI/kvPsI8Ft6b8GJ/
 mDWU7LSq1jZzo/CEs9Efr76QX0n2mKBKqh4AYgUYJzdhKLI0iCA0egHO26/WEoduTsmd
 4LdSUoiH7BsFtFJbxe/WG7zGCBJhvPDITfvv10pSqoDjnZ03ZzDQQbTMQr3FtjdFcD/4
 V4IkjQw6Z74cfS0PSbI8wyQ8EC69njdO++rlr9sMkuIpYsQYVsWQzZJ4FcK8v6RuXhs/
 oHxQ==
X-Gm-Message-State: AOJu0YzI2uZHlYB6Xz6mznWt2nBttNI87RNY71kxL3O9Ky9BdEKnqqcj
 tSm/xmas1zXKToJ7yugVVkI/iqYUXevxP+YMJ8GpmIjSELkrJ7RSNIazPG/ykK0I3k+Q7q9TNF/
 WYJHJ0Y1MM3P8M1M13r5BBDhW0LqL0hDIue+fQbLBlz12Xn8dLuaqxM2za4FRjnVk77kw9zdhAd
 k+CHSKPBPpmGbIhcbZeM+gcw6Vk1RHs2tQpzd23g==
X-Gm-Gg: ATEYQzx5iQ0UbTMFKe+A9rMVwpt7Ab7sue+vT/bwOUvBiVYFBZpEwUQAHhMO0hdjT+V
 PzAlEWxkGKLyyNi5y4i4BX0oG655NDeKI/r4RQq73r5QD2Ohu3Spw2lHUfZpaL60sr2CJOf/uVF
 DMRuUE4qSOq4Y0BuOaSzJKjrKTgN7svf5BksXBmiNeTQ9/C9uhIjQrYPLX4AdAu/QjPdsdDWAe8
 9ns6eoFFY8xLh+XpXs4yQmRmixx/8Vm33wKjdhWbNQNMtqYXKrqD6835rIqMgsJcAZ2hVAH/DST
 BLBPTp3+W7Xl4+z2qytdRkND2Wv6mB9NRP0mYntanvABMpD4dLb/ruehWpW2uyFkCGQ17mv6d6I
 svA8k4Ag7hz/+WBi+XYPQQz4tn9/gHnO1bptb5Hiw4jM=
X-Received: by 2002:a05:620a:14bc:b0:8d1:b71e:10a0 with SMTP id
 af79cd13be357-8d1b71e2575mr436273685a.5.1775075337387; 
 Wed, 01 Apr 2026 13:28:57 -0700 (PDT)
X-Received: by 2002:a05:620a:14bc:b0:8d1:b71e:10a0 with SMTP id
 af79cd13be357-8d1b71e2575mr436270185a.5.1775075336819; 
 Wed, 01 Apr 2026 13:28:56 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 08/11] vmstate: Implement load of ptr marker in vmstate core
Date: Wed,  1 Apr 2026 16:28:41 -0400
Message-ID: <20260401202844.673494-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The loader side of ptr marker is pretty straightforward, instead of playing
the inner_field trick, just do the load manually assuming the marker layout
is a stable ABI (which it is true already).

This will remove some logic while loading VMSD, and hopefully it makes it
slightly easier to read.  Unfortunately, we still need to keep the sender
side because of the JSON blob we're maintaining..

This paves way for future processing of non-NULL markers as well.

When at it, not check "size" anymore for existing NULL markers, and move it
under the same VMS_ARRAY_OF_POINTER section because that's the only place
that NULL marker can happen (which guarantess size==host ptr size, which is
non-zero).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate-types.c | 12 ++++------
 migration/vmstate.c       | 46 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index b31689fc3c..ae465c5c2c 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
                             const VMStateField *field, Error **errp)
 
 {
-    int byte = qemu_get_byte(f);
-
-    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
-        /* TODO: process PTR_VALID case */
-        return true;
-    }
-
-    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
+    /*
+     * Load is done in vmstate core, see vmstate_ptr_marker_load().
+     */
+    g_assert_not_reached();
     return false;
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index b333aa1744..47812eb882 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
+static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
+                                    Error **errp)
+{
+    int byte = qemu_get_byte(f);
+
+    if (byte == VMS_MARKER_PTR_NULL) {
+        /* When it's a null ptr marker, do not continue the load */
+        *load_field = false;
+        return true;
+    }
+
+    error_setg(errp, "Unexpected ptr marker: %d", byte);
+    return false;
+}
+
 static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
                              Error **errp)
 {
@@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
-                bool ok;
+                /* If we will process the load of field? */
+                bool load_field = true;
+                bool ok = true;
                 void *curr_elem = first_elem + size * i;
-                const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
+                    if (!curr_elem) {
+                        /* Read the marker instead of VMSD itself */
+                        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+                            trace_vmstate_load_field_error(field->name,
+                                                           -EINVAL);
+                            return false;
+                        }
+                    }
                 }
 
-                if (!curr_elem && size) {
-                    /*
-                     * If null pointer found (which should only happen in
-                     * an array of pointers), use null placeholder and do
-                     * not follow.
-                     */
-                    inner_field = vmsd_create_ptr_marker_field(field);
-                } else {
-                    inner_field = field;
-                }
-
-                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
-
-                /* If we used a fake temp field.. free it now */
-                if (inner_field != field) {
-                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                if (load_field) {
+                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
                 }
 
                 if (ok) {
-- 
2.50.1


