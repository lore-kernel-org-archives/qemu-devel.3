Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8BC10AB829
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rts-0004Aa-BR; Thu, 26 Mar 2026 17:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtn-000490-11
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtl-00037d-CP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lTxzlXPcIkLTIzQtm5snIna0fiWyl7m583Ny0gqjgk=;
 b=LyFyV8KqgbbbUPTTq0Pgd6Ui4K1RD6JtqOGRY5UE0HQgilq+W9V9DIEzTXQaGRV1WdFcPA
 QJchM2bzR398MbzmFDMhiFA/aGetFC/cQR7fPawkA8oVg/tpFyUoLFLnuyOfpERHLYoJxm
 anUisCAtyzUnSnax0KiHe1SbMsKWlRU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-KLeZFTGQP2CF_jLzXtMaSQ-1; Thu, 26 Mar 2026 17:05:47 -0400
X-MC-Unique: KLeZFTGQP2CF_jLzXtMaSQ-1
X-Mimecast-MFC-AGG-ID: KLeZFTGQP2CF_jLzXtMaSQ_1774559147
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfc5294894so464506285a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559146; x=1775163946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lTxzlXPcIkLTIzQtm5snIna0fiWyl7m583Ny0gqjgk=;
 b=I9hgHL0QdibFZn5aR9wt0C6CI0J2vsSzVx10RNVMNMNE70bI4G44qKdp/HSiOQJ+mV
 f/g/PEWpvBxPB/aUnfzCvm30JXEZ8EQgQ13YocjaGcdvqOXumf0CTbIOIbmGJKfoU6Qi
 jAmu/2ECtefXrRo7dwEBXyUaq2D95QVfkt4NEomgpVhju0iFVIVLGGeIRoPdMmbxw5pG
 nPQl6QN/0GEAn4FLeOfzdRVyezzLWmC6Cnt/KleWI2Tfhok5ZY4AjKSRzjsykmU2Kgtm
 b6qf3i5puE4BLOMlRku2zjcGEdMNuW2Kn45yECny40NKP3lR1dFQD9mqjO/gRxFDxzO9
 icZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559146; x=1775163946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1lTxzlXPcIkLTIzQtm5snIna0fiWyl7m583Ny0gqjgk=;
 b=gFAPduvGlMcZ87agwbtJnbEMMjg/sEjlVo+MRF3v54arTHei3gXMj/7TDSf5AksWpW
 /JFUCec6vlsuxV318EO1fctF7HtD2NZOSsXwHmEVo3YrDmR+PTYszF1kistE6zALP2Cx
 RrdhYoUu61ylbn8FgaW/mFCtZFcVFX5RkqE04D8Ct1ToZJGg+Fu6LV1mY8fPqcg06bGx
 efo/mcoVmNP2cIpspvzvcx1O6a+w04S7ll7FvPN3s7Q2A9natW5WUfJ2ztmY9XkwXYrV
 XMhhQFpfrfgdmQmFkeAhwBubTDOnWpWdSOmd5UML4/JjLJP80amOPV+GT0eWH5dyBjmJ
 pHkg==
X-Gm-Message-State: AOJu0YwDfJEbHaFWTCdAfc8iH8LgFr9/jRQpayam4MqKpKMvCw6UHBwH
 9RSs6GG2WvFsTyZdhRW/jMvPbyvZbicsaYSC0SFTGI2hXQn4xjuGqFqL+k/Lwe9LzaxrwkxFXYP
 9KcnjOESt2cSGFok8uhiPewNkTbjYX8VkxtTImqtDd/1Cz0hcd+Kna0YdEdh9sf17FgsdkC7b5H
 Z0mWep/QR57+FCplQEOEHWsrJnlgDbfcgGagSCKw==
X-Gm-Gg: ATEYQzw6Hrw9i0ftephe5WPgaCgxfFMeWkljOWhSR6YnltANsDtXFPeODN6TGD7YSbm
 YzXGdAtINFyX03e/X1sPdl4laUL1vLNIC5L0q4xR52eHf0Ss/7KSD1Ik2bqMQz2wSgAYncyWrvH
 HAEIHCKgHe54vfnYO5RJbsi435LUJezFscIw6fxjbx2+JO2+YnGMWNrh3+W5rVsRcBQ6W+ge0d5
 o6GyvQhcGxlcseCFfdUOTyLmXDP5mhTJdHAFOaCzNfVCGSwRxnW3t++FEalFKKgLbWeJpeFNP37
 KvWJyd7KVktLXTovnF1bWNSuhHaom6oKLmRoUglfnKmDxwMy9BZbF0eV55rJEDdmvzfkz1LvehA
 Mn/tsTPjAUfE=
X-Received: by 2002:a05:620a:1a22:b0:8cd:8ddd:2699 with SMTP id
 af79cd13be357-8d000f5cd3amr1239516885a.24.1774559146311; 
 Thu, 26 Mar 2026 14:05:46 -0700 (PDT)
X-Received: by 2002:a05:620a:1a22:b0:8cd:8ddd:2699 with SMTP id
 af79cd13be357-8d000f5cd3amr1239511985a.24.1774559145805; 
 Thu, 26 Mar 2026 14:05:45 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 08/11] vmstate: Implement load of ptr marker in vmstate
 core
Date: Thu, 26 Mar 2026 17:05:29 -0400
Message-ID: <20260326210532.379027-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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


