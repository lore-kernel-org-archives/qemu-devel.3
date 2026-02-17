Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C99E909CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNMC-0002Ka-W7; Tue, 17 Feb 2026 10:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx5-0003bn-Um
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx3-0005fs-Bm
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso59766745e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1771341923; x=1771946723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlHEsOq1lRlSlooXzt+pm7Wiy/G62pSLyPWrCWOS3Ss=;
 b=Zgo9xmHCbHyQf5Ac4xadpHtoeuCl8D4XBQR6Wad89JN6KW1p7pQLM6OKUp0S3vBt9K
 pFSJcvIb/OSahgC7/7yb0OJmXTCaF3syFr0BknxuIA7Z+gk5BZxsyjjuZV2TGH8ZlRIq
 qQjIBTur1Q9SikCC+E4c+n8FRGaXDMVT/pybM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341923; x=1771946723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlHEsOq1lRlSlooXzt+pm7Wiy/G62pSLyPWrCWOS3Ss=;
 b=UgzdNmSR9ZIXLciWC8MqPrcuyp6KIVKhqXZN43lEh1Ix/jqlLoavOC5l/ZY2MpbceZ
 hggxat0uPLs3yNjUhVk3coh4k+hnaNtgvEtgCSDO4+7a32IpdEV4b3ZUk/hwpRxOta+G
 Kv5aVRcZN7mqQabUz3/TxpRfoDCaeJQPzEfYXDpLT6uzklxmv/fdl1IHVsU6fNTeAUd0
 SjeMiUzQw6hNNtMrxHJTmDurMCPd53IJR8uDXPhGKrwyAJBEdfRQ2zBc1JsIUcWEk+JW
 ApTVTYAxPtCsp4VwQejKS9irLiZSm73Fb7NXBgPH7AFFR5lcFjJGaWLlE0uv9aRmyZCO
 5m1w==
X-Gm-Message-State: AOJu0Yz24rqNRDr/2lH8GTqufLH0XEfeL81HRpKJr7xE01waTbNpKrsC
 vZOOrCBhEKwoJfFcDvwpsa244QTD0/IfDd8w8+LVwvXtJS+5m0MkGQsOlPUR4B7/8/OBaOK2j5v
 elduz
X-Gm-Gg: AZuq6aK5k1wip9vWHx4oooi4Ha+pAwpG4onyiKdOsJc82zqiDeWb9LCoZZPGV4EJI98
 B3ilPg8kKwKdok0vfa3ELnK4KxSJ7KSZXEzpu898g22XVXkkcj26edw0HK/gYn0bMI9vPhkykWL
 y4onTg9/D5HIa6XiKZ1pTbUBhgWD4xjZYB1zhERo5fTukrNcgxNv5HR3GaM3rm5omtCf/nt/TRz
 +cmbI2dJLt6vrW5wdnVikkcruazex14Wg6Wb5pzOGvAzjYtvDdHNVnuDsKUzj68GWWeOYQWPNs+
 u1EdRDffgOV8vC4GNJOaW6Oz1K0AziPIIYuCMvldwdbXnmw0HrB8Rnj5gPvmDt2vHTDGKDJ6/4y
 gagQdLRolkC50uXPF8N6Dm23bfDr9+Jlx+erZEMluTyBNw4oJ/sj9pKNtKGM6QeyGTQGRntvaK8
 n+MNl9aGgpjQzWMcW5RwTWbF1h4cDCLE0Nj3RzGQ0hAmgSJaeUnk17T3Kq+kwCDek3WrwZNrQYv
 +iWdIuQv16K4MeOBnkTMlw=
X-Received: by 2002:a05:600c:6b6b:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-48378d62cb2mr146393345e9.8.1771341923213; 
 Tue, 17 Feb 2026 07:25:23 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf574bcf00ffb15ba913f79a3b.dip0.t-ipconnect.de.
 [2003:cf:574b:cf00:ffb1:5ba9:13f7:9a3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm519169015e9.14.2026.02.17.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:25:22 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 3/4] migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
Date: Tue, 17 Feb 2026 16:25:16 +0100
Message-ID: <20260217152517.271422-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217152517.271422-1-alexander@mihalicyn.com>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Feb 2026 10:51:21 -0500
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

Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC, which
helps to save/restore a dynamic array of pointers to
structures.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 include/migration/vmstate.h | 21 +++++++++
 migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20a..bc6495a7f67 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_ptrs_array_entry;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -537,6 +538,26 @@ extern const VMStateInfo vmstate_info_qlist;
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
+#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
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


