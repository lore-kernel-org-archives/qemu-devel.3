Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CC610FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BT-0004MF-CX; Wed, 01 Apr 2026 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BQ-0004K5-IK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BO-00038x-Nm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4SNb/+dNBoUUecfjmeqDkL3BXGCT5Hf5mgRlSOyVOQ=;
 b=HV20oK5Ohk+iW0gXyIZClyp0mPOfIN2k7GQY06e47cYNO3T4WS+k9UqeU2xuTh1GBCTtV8
 EmSc8tQU/wCZp9XJpIHRdYQv+l9UDoZPC2yMpyuBZWGqLmapUby4Sk+mdS9UvbeIOxFXhU
 uNDfPLoE0dbRbS36VmlXeWwuyl4zOC4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-7Iw-8tYtO8ykW3sjTHufqw-1; Wed, 01 Apr 2026 16:28:56 -0400
X-MC-Unique: 7Iw-8tYtO8ykW3sjTHufqw-1
X-Mimecast-MFC-AGG-ID: 7Iw-8tYtO8ykW3sjTHufqw_1775075336
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb6291d95aso87043485a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075335; x=1775680135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4SNb/+dNBoUUecfjmeqDkL3BXGCT5Hf5mgRlSOyVOQ=;
 b=HLNAUBqVUGvq+cNlyCt6ffTxd+0/jFkJc00gYz5J8UaPHFk3/AfwgfKBXV1ErYjH4o
 NjxNOggOqtIErw8bTvfFNBMuaikT8HrrlPfYY4uFiHN+hijXlymxFswO/28Zg5y4+2PT
 MA5HTF4x7yuZ+tvdlBOQRzx/ZzqnJo3JWt6DHR35Aks4M0GACCIu/jg+j6hMD+RQImjg
 R4hem7k1m9l8I7qqx5A0hGfmgGsvLdZHpb15T1/RM4mhOvmikvw95DCUzESA68GBnYz+
 aulMOklp3IHDUOnYfMTTLeh4h8JnbnWUwWjTPZMb1rah0q4hIzNjrSIK8a2V1fA/nhdb
 rQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075335; x=1775680135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m4SNb/+dNBoUUecfjmeqDkL3BXGCT5Hf5mgRlSOyVOQ=;
 b=LwFyqVQMvZtRlxLh/SeMPkgl9Fg9hca1XjalBN/UrOOmnn1fYdJwEkWqLFFNw5ZW3u
 1CIi6P+vKGsxSjTNyCYftnHdsRzCK04JnnkwPJqm36EBbNa2Jp/7DD1MI2Xfmp5SiYG1
 C9INZoaw/4NOXP0gEJ36vPzsEwDyfyRdrEUUdx259duXFPoKrydGGkaGgda8KFcdndsR
 rtOnECFCJiQZ/OCFb21JLhpFSeHORwWp7Mqn++uZO7GCD7tIzGt8R9GO7wMYd6aDKCEq
 Mi1z2+JAPbt3UxAYUtKQNP4fB8WD+UKFlJGnA1shCx1rvrQJkC2WNPzD1SSyTpV0kXiu
 WZ3Q==
X-Gm-Message-State: AOJu0Yw295ha5WkkNgr+/HU026UOQ/Zerj4ipMiwcB8gsnfHmOSu+0Gu
 H+b1gM3mmCwYpdnGoUhZvt3uU64U8DCXgczH4oGyEHMRy0UQl5PkWmMp2BBKX1KEq+ynMGk2uwz
 RLv9KcjrXrgxAIXxal5LkG1SfN7nWVxC6S+WlFtW32kKdohHDh8teD7fbxuvFU9XBWtjCtw0c3Z
 t/wVZzazPS/6G9uCSehEJMNG2L8nLzFYPWhrQaQQ==
X-Gm-Gg: ATEYQzwMR0xWnudQH0Ey054ay83cuICu35RnAiEgohipQtMs2kiqoH+BcGz+SBkP/iJ
 ChAJp2xhDbSJgzgaqH45Lbb1EsGQN6WpDdxZWw337OKUmmSTzHHWTEPlq6yX3I+wtn28TCrWJQg
 KUBavVxpLLWEuGCoFoifPocEfFImd0JgSv/cEhB/Q2UT+wa/uQsF2gTolMBkXmE+q20jzfhWHPv
 p99gnlcaIbN5c8NW4FL0S80Icpdni5piz14nwswC2Ut8U6tT+2w9MDrxFhACrY3+zzYYl6JNdro
 D2xo5wqlc5yMnU/wI4pNQrj6cRE3kWYMlkZTIMME8a/t5/D4TEBtOwqkOMgCLmlPH83qKaitVno
 6A+CggwZqioWkG/7N/YauzMWRb+reppEpEyjeG4HPqrI=
X-Received: by 2002:a05:620a:4441:b0:8cf:c75d:2a07 with SMTP id
 af79cd13be357-8d1b5ae65c1mr786478185a.16.1775075335414; 
 Wed, 01 Apr 2026 13:28:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:8cf:c75d:2a07 with SMTP id
 af79cd13be357-8d1b5ae65c1mr786473485a.16.1775075334738; 
 Wed, 01 Apr 2026 13:28:54 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 06/11] vmstate: Introduce vmstate_save_field_with_vmdesc()
Date: Wed,  1 Apr 2026 16:28:39 -0400
Message-ID: <20260401202844.673494-7-peterx@redhat.com>
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

Introduce a helper to do both the JSON blob generations and save vmstate.
This further shrinks the function a bit.  More importantly, we'll need to
save two fields in one loop very soon in the future with the JSON blob.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 05badef42f..b274204e66 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -514,6 +514,35 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
+/*
+ * Save a whole VMSD field, including its JSON blob separately when @vmdesc
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
+    if (!ok) {
+        error_prepend(errp, "Save of field %s/%s failed: ",
+                      vmsd->name, field->name);
+    }
+
+    return ok;
+}
+
 static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -542,7 +571,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
-            uint64_t old_offset, written_bytes;
             JSONWriter *vmdesc_loop = vmdesc;
             bool is_prev_null = false;
 
@@ -559,7 +587,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 /* maximum number of elements to compress in the JSON blob */
                 int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
 
-                old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -606,15 +633,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -622,8 +643,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (!ok) {
-                    error_prepend(errp, "Save of field %s/%s failed: ",
-                                  vmsd->name, field->name);
                     goto out;
                 }
 
-- 
2.50.1


