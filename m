Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED3310AB829
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rto-00049d-LW; Thu, 26 Mar 2026 17:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtl-00048P-Dp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtj-00036m-Kw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OGxsDPDL98ip8EJwQP/tMCYj51Rwd5fV8vt/33jK2E=;
 b=RgPdVtFLTEa9C/mH4eo7ExHHYUWeETnQRwSm921degXGhB2FF+meTQTxetL1Bi2T5Xt4SX
 r8HKgSE/lboNWQoK7uH4zYYXpyVM18si0pLxazcg/dG9/G8QtxZUyLYlDmiceyv6ZxkUqF
 vhCKCd71ZBc2ZIFju0pXXnAfWfE0vzw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-WffzlzDkOZiRrVMkbTbjsA-1; Thu, 26 Mar 2026 17:05:45 -0400
X-MC-Unique: WffzlzDkOZiRrVMkbTbjsA-1
X-Mimecast-MFC-AGG-ID: WffzlzDkOZiRrVMkbTbjsA_1774559145
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfcebeb1f3so121921485a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559145; x=1775163945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OGxsDPDL98ip8EJwQP/tMCYj51Rwd5fV8vt/33jK2E=;
 b=dtLMV5R73wqbA7LIAIyKEs6DoLVUbsAwVaFe1V1VohNrTY/bzH8pTbehHV4DDH/YIZ
 LP+B3GKkZ75VXEsaf7G3Ov2/2w6Iz+UGkKNySU8jwa3+oOeK8U4hMY8uuoXFqj1lq/Ow
 YvlPhVU0/6k0Mdp2nr12DVbuvduRiXAbHAT24U4BccXRSy+hnxJj+3fBVb1jbtGkNAO3
 yzFzdj5fMcjODpVUqmJYGoi9vAG+cqFJisrEPFshl1TGY4hAGwusDzdSf8CYg1csQpRa
 H01noR7dZ6w2CP/3BzX/sUDRY+X+tSQO9zZE2mGLRWKXLqIg9la0og+GvW6q0826i3WS
 uUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559145; x=1775163945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OGxsDPDL98ip8EJwQP/tMCYj51Rwd5fV8vt/33jK2E=;
 b=aojBiP3jVwqVCh9HpRJrdW66ubdZ8Rl4dHiCiwz9uZPlBKuPF74wCuQwcCK55pa62u
 TOUFwpkgiOcJKXpW7/x+T6Pe85RzyBqhzaR1DZwfdsevy8C0TSsbNvEFnraesU72iClk
 0jQeTSBcFVN5DReUcffFek8XInA1llwgiIbWlAaRVWsmmGpqiFBLeDWXlNTDjfADgLlN
 zvbSv6Mza8YScDt7XBX565pHlqYuXoOqFjg9XyrEXYMJ7IDLi/lYZEaYp45YrxrVnK1W
 kpbqmvz1E0CCwwlC9dXQrkhAyvkb+EbSzCNs4uclHJZiV61D24Ja/n6ibHJAkwT49o6u
 Rc3Q==
X-Gm-Message-State: AOJu0YxDsZ3zqB5rTijPxOChG0AwZ8QQW5g53IYt4q7h72q7R6PN9YQc
 Rj3CHoiaryG8cy5cjVq+XL0LAEa1oWmHTGpusSWciFNNw3slv2zzyQBbrv+vqVC4SbqNhdq2QLX
 TTMacH9YmgbEbZVIrjaOrBs/5UrTIplnGm5y/wKzJsrBOIV2ADpd7yJb6YsMOV8pYp9XjT7b11N
 BxeLrGV/1QhOMVoeckV6yGJJPOZ6fpxB/Q0BDteA==
X-Gm-Gg: ATEYQzwCcO5I4NAkeWoPRRPo657U36qIaVvSY+dOyQYM4LdU81YIWW2mUNkzGPCIE6X
 KVPbtzGqDfPAj2oSIUkUeRIuFza7HJcsiUg8ssevM8OQpKYvbizzCMG48R2h1r4ccv0A/DIxno8
 cqcTG8w4Ov8HgpvKYymbkKDhFamY6I9HIR+IlQuKWO+970A7m5djbRx0tAoyMy9sLyUMq0pcqKk
 zRHO52PBjMNnL8NeJ+0ya/6Xml9GwhlJGidyEZ/b/4kQaPvridc8YWuvGjqs9USUJXAWKkRtgWX
 E4sMaFiE1gvotJ1Q64AJN4aRL5/3kOXLT8obVx2feYJy3PNnc2/+GA6/qXC+1ALrIqhm5+yKmcF
 imqijNJoOncE=
X-Received: by 2002:a05:620a:1a25:b0:8cd:8eb7:2c02 with SMTP id
 af79cd13be357-8d00107e6d6mr1258732385a.58.1774559144565; 
 Thu, 26 Mar 2026 14:05:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1a25:b0:8cd:8eb7:2c02 with SMTP id
 af79cd13be357-8d00107e6d6mr1258726285a.58.1774559143895; 
 Thu, 26 Mar 2026 14:05:43 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 06/11] vmstate: Introduce
 vmstate_save_field_with_vmdesc()
Date: Thu, 26 Mar 2026 17:05:27 -0400
Message-ID: <20260326210532.379027-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
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


