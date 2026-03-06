Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA487FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiz-0008ER-H5; Fri, 06 Mar 2026 10:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWif-0007v5-AC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:04:03 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWid-0003Le-Hd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:04:01 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso4479694f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809437; x=1773414237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aa7YS8YRAQ8yRhQF9Whg1Qcoxr3p3yRf12L+u0hXtWc=;
 b=MU9H0/3cesldAQoj2jQodTuSmj7vCQcTq4wDe+RPIHvJ/R2nw0V1HHR3cL4WLq4nYy
 mxK9uIxwNlqXM+Flxx06hciNoLuX32LccBh1nNKFfmWEySG6M9ZNeLhsqztzMGSY2NFp
 MfBtm4nJOSygOTkg64gSj2GjM9uWLJg1vfmDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809437; x=1773414237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aa7YS8YRAQ8yRhQF9Whg1Qcoxr3p3yRf12L+u0hXtWc=;
 b=Ai7lsfd8f+NZUJbsJDY8eyw086npbhZhyCY8lxTszA08uwqDYAEdF9tG0AWFCXkxkx
 Aggt+ATFrNWPp6DIZtPxJOLBMG5AYbJGTNQOpvvTbKQCST+TCiv9sr2A2QS3CmwlFUDH
 DfUSOxu5Clzh5RC4kPN4Nai5a0GrXeoGMMMyv+b4e3lTK1ceYRKTcoIb0LY8IhK1R2+j
 Sm+lPnaGIiqeCEx9VkUH4uk7uYjkIwB8bRuR9wtHq9Cq7YC8+P5aMKj8kEXhQ+ix9Wrp
 zs/C2yNyiNWMjucuYe4YtW5Z7fYMsuuF/0HJNHHW2ud06M95V97rtot5YDjbIc/Tx/M1
 eFng==
X-Gm-Message-State: AOJu0YyRIu1c63u8LykGrrTArHPFMA98hidZawAJqBZv8cELzFbNH1e4
 5o35FNhXbdR7mWEnDQen3NezZ78437FsKNUSYgfkB3FvPy4c+o1bAotNxyJh59Pu4MGUzG0Do3K
 vLzYXgS0=
X-Gm-Gg: ATEYQzwjAPnyRnpOI8K6WBFtpZolSYxNvV5qlWM+retlD9uK9Ven8/iVRn+VmnrJWd0
 s90g7UHMI4gSW0j6xactjtw4A4IlF3jEI6UAZGngq/geXfOBERJs5xRDIxfkZJj0G1toQteve14
 dOMlO0ZTCCNj2GmmJ0kRizgs5Bhk9GatgDnCNjauwTwqWHP12y8K7Q0SgfzMOLUmJKIfLTqA3p+
 nuhzbBLfmTANTRCx6Xs/5++oXma9dhBJEe9Z/Tjda80gJj4w874czPdZx+qg7ZdHfVeCW5p0W/U
 nw5t8O5sogOlYCI8yy8gLdg2YAyaqXcfrAWZ502mu6w9k/i+vFHqO1B1/HmBgjgZS6h7cJ/y9nM
 AaTv7oKHkfX3xjs5w7HS9XY/dgXZ8cpBbbpgpXILvhp1Z9/1zNrUSMRPzjxBxh9FmXNZBDkotFM
 RkxI6YGf0JVQ1zp7toP+eo/rkbx4JW13aauWRm7Vpd3D0ae1rcDaPVeV7Tcc5uhC44wS7yrTWxN
 JSS0ziNVymTMTePo8MFU4E=
X-Received: by 2002:a05:6000:1acd:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-439da885f92mr3986014f8f.28.1772809425164; 
 Fri, 06 Mar 2026 07:03:45 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:44 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 1/6] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Date: Fri,  6 Mar 2026 16:03:37 +0100
Message-ID: <20260306150342.395923-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306150342.395923-1-alexander@mihalicyn.com>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC, which
helps to save/restore a dynamic array of pointers to
structures.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
v2:
- added VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC
---
 include/migration/vmstate.h | 33 ++++++++++++++
 migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20a..0bbe3317740 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ptrs_array_entry;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -537,6 +538,38 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+/*
+ * For migrating a dynamically allocated uint32-indexed array
+ * of pointers to structures (with NULL entries and with auto memory allocation).
+ *
+ * _type: type of structure pointed to
+ * _vmsd: VMSD for structure
+ * start: size of structure pointed to (for auto memory allocation)
+ */
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
+    .info       = &vmstate_info_ptrs_array_entry,                     \
+    .vmsd       = &(_vmsd),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_VARRAY_UINT8|VMS_POINTER,                      \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
+    .name       = (stringify(_field)),                                \
+    .version_id = (_version),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .info       = &vmstate_info_ptrs_array_entry,                     \
+    .vmsd       = &(_vmsd),                                           \
+    .start      = sizeof(_type),                                      \
+    .size       = sizeof(_type *),                                    \
+    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                      \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
+}
+
 #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
     .name       = (stringify(_field)),                                    \
     .version_id = (_version),                                             \
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb2114721..3335377cd07 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist = {
     .get  = get_qlist,
     .put  = put_qlist,
 };
+
+static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
+                                const VMStateField *field, JSONWriter *vmdesc)
+{
+    const VMStateDescription *vmsd = field->vmsd;
+    int ret;
+    Error *local_err = NULL;
+    void *pv;
+
+    /*
+     * (ppv) is an address of an i-th element of a dynamic array.
+     *
+     * (ppv) can not be NULL unless we have some regression/bug in
+     * vmstate_save_state_v(), because it is result of pointer arithemic like:
+     * first_elem + size * i.
+     */
+    if (ppv == NULL) {
+        error_report("vmstate: put_ptrs_array_entry must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /* get a pointer to a structure */
+    pv = *(void **)ppv;
+
+    if (pv == NULL) {
+        /* write a mark telling that there was a NULL pointer */
+        qemu_put_byte(f, false);
+        return 0;
+    }
+
+    /* if pointer is not NULL, dump the structure contents with help of vmsd */
+    qemu_put_byte(f, true);
+    ret = vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    return 0;
+}
+
+static int get_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
+                                const VMStateField *field)
+{
+    int ret = 0;
+    Error *local_err = NULL;
+    const VMStateDescription *vmsd = field->vmsd;
+    /* size of structure pointed to by elements of array */
+    size_t size = field->start;
+
+    if (ppv == NULL) {
+        error_report("vmstate: get_ptrs_array_entry must be called with ppv != NULL");
+        return -EINVAL;
+    }
+
+    /*
+     * We start from a clean array, all elements must be NULL, unless
+     * something we haven't prepared for has changed in vmstate_save_state_v().
+     * Let's check for this just in case.
+     */
+    if (*(void **)ppv != NULL) {
+        error_report("vmstate: get_ptrs_array_entry must be called with *ppv == NULL");
+        return -EINVAL;
+    }
+
+    if (qemu_get_byte(f)) {
+        void *pv;
+
+        /* allocate memory for structure */
+        pv = g_malloc0(size);
+        ret = vmstate_load_state(f, vmsd, pv, vmsd->version_id, &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            g_free(pv);
+            return ret;
+        }
+
+        *(void **)ppv = pv;
+    }
+
+    return ret;
+}
+
+const VMStateInfo vmstate_info_ptrs_array_entry = {
+    .name = "ptrs_array_entry",
+    .get  = get_ptrs_array_entry,
+    .put  = put_ptrs_array_entry,
+};
-- 
2.47.3


