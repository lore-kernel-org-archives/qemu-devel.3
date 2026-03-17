Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031ECFF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlO-0003y6-TF; Tue, 17 Mar 2026 19:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlN-0003xN-87
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlL-0006SZ-NI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3NlxwHq8kLfCc7uDMmSml3SsH2i/1WLYIAZ4DD4aAk=;
 b=Wbxm27KXFqhjzvet5A9YNKLELqmVL1xuEHIm3tQYsq4pb03C2OaJN3gTYqkIgYFZmbZz7p
 DD85wMZFIUkTLJ5UR2sau4BWXPXhcV53sdfALw8emxULi0bo3+8dW/FpsW+U3FJlPatkkf
 curHOOC9yO+4nbQ426KT4+d9EX2sO2w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-gacc5mPQMAaDX_LAJrz7yg-1; Tue, 17 Mar 2026 19:23:45 -0400
X-MC-Unique: gacc5mPQMAaDX_LAJrz7yg-1
X-Mimecast-MFC-AGG-ID: gacc5mPQMAaDX_LAJrz7yg_1773789825
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8950562d351so536721916d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789825; x=1774394625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3NlxwHq8kLfCc7uDMmSml3SsH2i/1WLYIAZ4DD4aAk=;
 b=Pm6cntEk/iAs1EZLVomG86xp1wqFLvT7XaJhyQysnlHoCzoV//6xS/h/OZ6IuJULma
 prfZswcOAPDKxCKD2DR3wpDUNxHSwK/QC2jlIcrTfahNmWa+6wazdxT+sfkgzsPqbvY9
 ksZd9o83JFCYMLwAdMtS32FqAPWnWn6EL24rjZDDi/YaUS0vuE5LJv8q2VNPOS5cilV/
 lrhoPX8zWA4lYaw/IVQUeODZ9m3fPRdZvFleJtq9ZWKrQNoreewdo/q358E7p9T0AYCY
 03pmSjhITZzRRxIbfI6pQUs7hrpBiZW2qwIZ+VDLX/I02Qlgo8Ug3WeXnjPHpNrm9Azi
 eFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789825; x=1774394625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3NlxwHq8kLfCc7uDMmSml3SsH2i/1WLYIAZ4DD4aAk=;
 b=oKjW8xhvgw1wqqcU3fDWqp9wJl6Ne2Urey0wmxnwxWfWpypeiQ/KnKXNjGcOV5Zct9
 Z4Tfqi5cLgnPs5Om4vXThjXG3Coe/brrQJY54gvGeBYdM0713SVSyq2l7nBlMzHKdgwn
 OAbyn9E0+V0xfDbMqhVPWDgR8v7KvQUOZHTulhDeD3TspneOpuav1j2vs9ow3cJTvK3K
 T1A989GMZJbfocXRUVWGxk1rPlM55/QHC6+4zxhMy0kx9FxNXmpHxtOH+ZLknFVULEOO
 QivryKQeuGz+R8YYBAattL+uWe0icWrMDkfn6cQP4i1Jt4JGHbnLNp/aBQloyyAGhMTu
 C5og==
X-Gm-Message-State: AOJu0Yyp09NyvYJUFfcSCc9ZUcRiwd8iJCYwbDH0TuBdXAm58WQS7wN9
 HnrQpsx+oLPFqhxYpjIIOEV94Mn5XxQFaXHm7CPMudgzDUwT7PtCNsSQlTep2l8HyjsJqL9bcX+
 +H5p128NsV2XWc9G6AgkU38kQeSgwd4k6jhQfZWbi0CcA/Alr3Jlt9RCOL9fb2cZFc0+Kr/xi/W
 F2+PeKc+JG2TJX8vDntma6IGl9XJcqeaiDJ95u0g==
X-Gm-Gg: ATEYQzwjEWlHZI0A97tAH3mHj89HLJMPpP1oZ82IEN/2stzHVH5M0K3Q9SZxKFwVHnw
 buffYmNVq04XtwgNxdCk5wuYcfnAZNpoa6qSAFFRmRzZPpLZ1haH19ffy6FbtQoemx0ZPOKggHQ
 yEYAjNf3cYl/HEeAvPZ6Q9Qt8h+D21kN7Q7/WD0eQPPN8Aq9CW6ibEI2TzgkU2TewPC+FTUAtVB
 t7Dpare3gIQ9zjJtLLwvTINq8zeRq+17CeGHEjO3hhDpLbvdstg8qzobEi+HEdZ5jlrOYkl41+S
 gf0eLA/+eAFof2UuS0NJsX8OVkL38WW2VY12PCZBz+5mwYiD3twzXh79076MsrKSZ47DEYEKwA/
 EmScB+Z+w5HAgqA==
X-Received: by 2002:a05:6214:319a:b0:899:f2ba:9d7e with SMTP id
 6a1803df08f44-89c6b595f87mr23211746d6.38.1773789824668; 
 Tue, 17 Mar 2026 16:23:44 -0700 (PDT)
X-Received: by 2002:a05:6214:319a:b0:899:f2ba:9d7e with SMTP id
 6a1803df08f44-89c6b595f87mr23211476d6.38.1773789824232; 
 Tue, 17 Mar 2026 16:23:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 06/10] vmstate: Introduce vmstate_save_field_with_vmdesc()
Date: Tue, 17 Mar 2026 19:23:28 -0400
Message-ID: <20260317232332.15209-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Introduce a helper to do both the JSON blob dump and vmstate dump.  This
further shrinks the function a bit.  More importantly, we'll need to dump
two fields in one loop very soon in the future with the JSON blob.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index caa7b50bce..5a6b352764 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -514,6 +514,30 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
+/*
+ * Dump a whole VMSD field, including its JSON blob separately when @vmdesc
+ * is specified.
+ */
+static inline bool
+vmstate_save_field_with_vmdesc(QEMUFile *f, void *pv, size_t size,
+                               const VMStateDescription *vmsd,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               int i, int max, Error **errp)
+{
+    uint64_t old_offset, written_bytes;
+    bool ok;
+
+    vmsd_desc_field_start(vmsd, vmdesc, field, i, max);
+
+    old_offset = qemu_file_transferred(f);
+    ok = vmstate_save_field(f, pv, size, field, vmdesc, errp);
+    written_bytes = qemu_file_transferred(f) - old_offset;
+
+    vmsd_desc_field_end(vmsd, vmdesc, field, written_bytes);
+
+    return ok;
+}
+
 static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -542,7 +566,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-            uint64_t old_offset, written_bytes;
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
 
@@ -558,7 +581,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 bool is_null;
                 int max_elems = n_elems - i;
 
-                old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -606,15 +628,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                     }
                 }
 
-                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
-                                      i, max_elems);
-
-                ok = vmstate_save_field(f, curr_elem, size, inner_field,
-                                        vmdesc_loop, errp);
-
-                written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
-                                    written_bytes);
+                ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
+                                                    inner_field, vmdesc_loop,
+                                                    i, max_elems, errp);
 
                 /* If we used a fake temp field.. free it now */
                 if (is_null) {
-- 
2.50.1


