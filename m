Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF4C5B56B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdy-0000FO-A9; Fri, 20 Feb 2026 16:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdv-0000DJ-1c
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:31 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdr-0002mh-BD
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 09779C0237;
 Sat, 21 Feb 2026 00:02:26 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-9PvrJzrw; Sat, 21 Feb 2026 00:02:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621345;
 bh=tPMogjNOxXw6cuC2fdlf4CLrnc3+0yAVhiEpTzkwTks=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=AGEH6T8bX38J/PwOh16Y64zaY2M/c+ygh/YnAjclJbOkSxGIz0bOGfrJux7oYS1J3
 O2jJ1d/MR8wW9a3Sz8GnAE6dSFtPsXQqpBiQ7laZlZMvlToGGaBlYsGMk5f3LuBwIv
 94cfd/2LyByJNiJ0M1L2BmYlTK2tVXUFrtLSO4o4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 16/16] migration/vmstate-types: move to new migration APIs
Date: Sat, 21 Feb 2026 00:02:14 +0300
Message-ID: <20260220210214.800050-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/trace-events    |  24 +-
 migration/vmstate-types.c | 637 +++++++++++++++++++-------------------
 2 files changed, 332 insertions(+), 329 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index e864d19c55..0d44b4c39a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -70,20 +70,20 @@ vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_field_exists(const char *vmsd, const char *name, int field_version, int version, int result) "%s:%s field_version %d version %d result %d"
 
 # vmstate-types.c
-get_qtailq(const char *name, int version_id) "%s v%d"
-get_qtailq_end(const char *name, const char *reason, int val) "%s %s/%d"
-put_qtailq(const char *name, int version_id) "%s v%d"
-put_qtailq_end(const char *name, const char *reason) "%s %s"
+load_qtailq(const char *name, int version_id) "%s v%d"
+load_qtailq_end(const char *name) "%s"
+save_qtailq(const char *name, int version_id) "%s v%d"
+save_qtailq_end(const char *name) "%s"
 
-get_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
-get_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
-put_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
-put_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
+load_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
+load_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name) "%s(%s/%s)"
+save_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
+save_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name) "%s(%s/%s)"
 
-get_qlist(const char *field_name, const char *vmsd_name, int version_id) "%s(%s v%d)"
-get_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
-put_qlist(const char *field_name, const char *vmsd_name, int version_id) "%s(%s v%d)"
-put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
+load_qlist(const char *field_name, const char *vmsd_name, int version_id) "%s(%s v%d)"
+load_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
+save_qlist(const char *field_name, const char *vmsd_name, int version_id) "%s(%s v%d)"
+save_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 
 # qemu-file.c
 qemu_file_fclose(void) ""
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb211472..502a3651b3 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -23,132 +23,138 @@
 
 /* bool */
 
-static int get_bool(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field)
+static bool load_bool(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, Error **errp)
 {
     bool *v = pv;
     *v = qemu_get_byte(f);
-    return 0;
+    return true;
 }
 
-static int put_bool(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_bool(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc,
+                      Error **errp)
 {
     bool *v = pv;
     qemu_put_byte(f, *v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_bool = {
     .name = "bool",
-    .get  = get_bool,
-    .put  = put_bool,
+    .load = load_bool,
+    .save = save_bool,
 };
 
 /* 8 bit int */
 
-static int get_int8(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field)
+static bool load_int8(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, Error **errp)
 {
     int8_t *v = pv;
     qemu_get_s8s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_int8(QEMUFile *f, void *pv, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_int8(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc,
+                      Error **errp)
 {
     int8_t *v = pv;
     qemu_put_s8s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_int8 = {
     .name = "int8",
-    .get  = get_int8,
-    .put  = put_int8,
+    .load = load_int8,
+    .save = save_int8,
 };
 
 /* 16 bit int */
 
-static int get_int16(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool load_int16(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
 {
     int16_t *v = pv;
     qemu_get_sbe16s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_int16(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_int16(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     int16_t *v = pv;
     qemu_put_sbe16s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_int16 = {
     .name = "int16",
-    .get  = get_int16,
-    .put  = put_int16,
+    .load = load_int16,
+    .save = save_int16,
 };
 
 /* 32 bit int */
 
-static int get_int32(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool load_int32(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
 {
     int32_t *v = pv;
     qemu_get_sbe32s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_int32(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_int32(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     int32_t *v = pv;
     qemu_put_sbe32s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_int32 = {
     .name = "int32",
-    .get  = get_int32,
-    .put  = put_int32,
+    .load = load_int32,
+    .save = save_int32,
 };
 
 /* 32 bit int. See that the received value is the same than the one
    in the field */
 
-static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field)
+static bool load_int32_equal(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     int32_t *v = pv;
     int32_t v2;
     qemu_get_sbe32s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
+
+    error_setg(errp, "%" PRIx32 " != %" PRIx32, *v, v2);
     if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
+        error_append_hint(errp, "%s\n", field->err_hint);
     }
-    return -EINVAL;
+    return false;
 }
 
 const VMStateInfo vmstate_info_int32_equal = {
     .name = "int32 equal",
-    .get  = get_int32_equal,
-    .put  = put_int32,
+    .load = load_int32_equal,
+    .save = save_int32,
 };
 
 /* 32 bit int. Check that the received value is non-negative
  * and less than or equal to the one in the field.
  */
 
-static int get_int32_le(QEMUFile *f, void *pv, size_t size,
-                        const VMStateField *field)
+static bool load_int32_le(QEMUFile *f, void *pv, size_t size,
+                          const VMStateField *field, Error **errp)
 {
     int32_t *cur = pv;
     int32_t loaded;
@@ -156,360 +162,385 @@ static int get_int32_le(QEMUFile *f, void *pv, size_t size,
 
     if (loaded >= 0 && loaded <= *cur) {
         *cur = loaded;
-        return 0;
+        return true;
     }
-    error_report("Invalid value %" PRId32
-                 " expecting positive value <= %" PRId32,
-                 loaded, *cur);
-    return -EINVAL;
+
+    error_setg(errp, "Invalid value %" PRId32
+               " expecting positive value <= %" PRId32,
+               loaded, *cur);
+    return false;
 }
 
 const VMStateInfo vmstate_info_int32_le = {
     .name = "int32 le",
-    .get  = get_int32_le,
-    .put  = put_int32,
+    .load = load_int32_le,
+    .save = save_int32,
 };
 
 /* 64 bit int */
 
-static int get_int64(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool load_int64(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
 {
     int64_t *v = pv;
     qemu_get_sbe64s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_int64(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_int64(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     int64_t *v = pv;
     qemu_put_sbe64s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_int64 = {
     .name = "int64",
-    .get  = get_int64,
-    .put  = put_int64,
+    .load = load_int64,
+    .save = save_int64,
 };
 
 /* 8 bit unsigned int */
 
-static int get_uint8(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool load_uint8(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
 {
     uint8_t *v = pv;
     qemu_get_8s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_uint8(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_uint8(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     uint8_t *v = pv;
     qemu_put_8s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_uint8 = {
     .name = "uint8",
-    .get  = get_uint8,
-    .put  = put_uint8,
+    .load = load_uint8,
+    .save = save_uint8,
 };
 
 /* 16 bit unsigned int */
 
-static int get_uint16(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_uint16(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     uint16_t *v = pv;
     qemu_get_be16s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_uint16(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_uint16(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     uint16_t *v = pv;
     qemu_put_be16s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_uint16 = {
     .name = "uint16",
-    .get  = get_uint16,
-    .put  = put_uint16,
+    .load = load_uint16,
+    .save = save_uint16,
 };
 
 /* 32 bit unsigned int */
 
-static int get_uint32(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_uint32(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     uint32_t *v = pv;
     qemu_get_be32s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_uint32(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_uint32(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     uint32_t *v = pv;
     qemu_put_be32s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_uint32 = {
     .name = "uint32",
-    .get  = get_uint32,
-    .put  = put_uint32,
+    .load = load_uint32,
+    .save = save_uint32,
 };
 
 /* 32 bit uint. See that the received value is the same than the one
    in the field */
 
-static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
+static bool load_uint32_equal(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     uint32_t *v = pv;
     uint32_t v2;
     qemu_get_be32s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
+
+    error_setg(errp, "%" PRIx32 " != %" PRIx32, *v, v2);
     if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
+        error_append_hint(errp, "%s\n", field->err_hint);
     }
-    return -EINVAL;
+    return false;
 }
 
 const VMStateInfo vmstate_info_uint32_equal = {
     .name = "uint32 equal",
-    .get  = get_uint32_equal,
-    .put  = put_uint32,
+    .load = load_uint32_equal,
+    .save = save_uint32,
 };
 
 /* 64 bit unsigned int */
 
-static int get_uint64(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_uint64(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     uint64_t *v = pv;
     qemu_get_be64s(f, v);
-    return 0;
+    return true;
 }
 
-static int put_uint64(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_uint64(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     uint64_t *v = pv;
     qemu_put_be64s(f, v);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_uint64 = {
     .name = "uint64",
-    .get  = get_uint64,
-    .put  = put_uint64,
+    .load = load_uint64,
+    .save = save_uint64,
 };
 
 /* File descriptor communicated via SCM_RIGHTS */
 
-static int get_fd(QEMUFile *f, void *pv, size_t size,
-                  const VMStateField *field)
+static bool load_fd(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, Error **errp)
 {
     int32_t *v = pv;
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         qemu_get_sbe32s(f, v);
-        return 0;
+        return true;
     }
 
-    return qemu_file_get_fd(f, v);
+    return qemu_file_get_fd(f, v) >= 0;
 }
 
-static int put_fd(QEMUFile *f, void *pv, size_t size,
-                  const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fd(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc,
+                    Error **errp)
 {
     int32_t *v = pv;
+
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         qemu_put_sbe32s(f, v);
-        return 0;
+        return true;
     }
-    return qemu_file_put_fd(f, *v);
+
+    return qemu_file_put_fd(f, *v) >= 0;
 }
 
 const VMStateInfo vmstate_info_fd = {
     .name = "fd",
-    .get  = get_fd,
-    .put  = put_fd,
+    .load = load_fd,
+    .save = save_fd,
 };
 
-static int get_nullptr(QEMUFile *f, void *pv, size_t size,
-                       const VMStateField *field)
+static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
+                         const VMStateField *field, Error **errp)
 
 {
     if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
-        return  0;
+        return true;
     }
-    error_report("vmstate: get_nullptr expected VMS_NULLPTR_MARKER");
-    return -EINVAL;
+
+    error_setg(errp, "vmstate: load_nullptr expected VMS_NULLPTR_MARKER");
+    return false;
 }
 
-static int put_nullptr(QEMUFile *f, void *pv, size_t size,
-                        const VMStateField *field, JSONWriter *vmdesc)
+static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
+                         const VMStateField *field, JSONWriter *vmdesc,
+                         Error **errp)
 
 {
     if (pv == NULL) {
         qemu_put_byte(f, VMS_NULLPTR_MARKER);
-        return 0;
+        return true;
     }
-    error_report("vmstate: put_nullptr must be called with pv == NULL");
-    return -EINVAL;
+
+    error_setg(errp, "vmstate: save_nullptr must be called with pv == NULL");
+    return false;
 }
 
 const VMStateInfo vmstate_info_nullptr = {
     .name = "nullptr",
-    .get  = get_nullptr,
-    .put  = put_nullptr,
+    .load = load_nullptr,
+    .save = save_nullptr,
 };
 
 /* 64 bit unsigned int. See that the received value is the same than the one
    in the field */
 
-static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
+static bool load_uint64_equal(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t *v = pv;
     uint64_t v2;
+
     qemu_get_be64s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx64 " != %" PRIx64, *v, v2);
+
+    error_setg(errp, "%" PRIx64 " != %" PRIx64, *v, v2);
     if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
+        error_append_hint(errp, "%s\n", field->err_hint);
     }
-    return -EINVAL;
+    return false;
 }
 
 const VMStateInfo vmstate_info_uint64_equal = {
     .name = "int64 equal",
-    .get  = get_uint64_equal,
-    .put  = put_uint64,
+    .load = load_uint64_equal,
+    .save = save_uint64,
 };
 
 /* 8 bit int. See that the received value is the same than the one
    in the field */
 
-static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field)
+static bool load_uint8_equal(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     uint8_t *v = pv;
     uint8_t v2;
+
     qemu_get_8s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%x != %x", *v, v2);
+
+    error_setg(errp, "%x != %x", *v, v2);
     if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
+        error_append_hint(errp, "%s\n", field->err_hint);
     }
-    return -EINVAL;
+    return false;
 }
 
 const VMStateInfo vmstate_info_uint8_equal = {
     .name = "uint8 equal",
-    .get  = get_uint8_equal,
-    .put  = put_uint8,
+    .load = load_uint8_equal,
+    .save = save_uint8,
 };
 
 /* 16 bit unsigned int int. See that the received value is the same than the one
    in the field */
 
-static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
+static bool load_uint16_equal(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     uint16_t *v = pv;
     uint16_t v2;
+
     qemu_get_be16s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%x != %x", *v, v2);
+
+    error_setg(errp, "%x != %x", *v, v2);
     if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
+        error_append_hint(errp, "%s\n", field->err_hint);
     }
-    return -EINVAL;
+    return false;
 }
 
 const VMStateInfo vmstate_info_uint16_equal = {
     .name = "uint16 equal",
-    .get  = get_uint16_equal,
-    .put  = put_uint16,
+    .load = load_uint16_equal,
+    .save = save_uint16,
 };
 
 /* CPU_DoubleU type */
 
-static int get_cpudouble(QEMUFile *f, void *pv, size_t size,
-                         const VMStateField *field)
+static bool load_cpudouble(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, Error **errp)
 {
     CPU_DoubleU *v = pv;
     qemu_get_be32s(f, &v->l.upper);
     qemu_get_be32s(f, &v->l.lower);
-    return 0;
+    return true;
 }
 
-static int put_cpudouble(QEMUFile *f, void *pv, size_t size,
-                         const VMStateField *field, JSONWriter *vmdesc)
+static bool save_cpudouble(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, JSONWriter *vmdesc,
+                           Error **errp)
 {
     CPU_DoubleU *v = pv;
     qemu_put_be32s(f, &v->l.upper);
     qemu_put_be32s(f, &v->l.lower);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_cpudouble = {
     .name = "CPU_Double_U",
-    .get  = get_cpudouble,
-    .put  = put_cpudouble,
+    .load = load_cpudouble,
+    .save = save_cpudouble,
 };
 
 /* uint8_t buffers */
 
-static int get_buffer(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_buffer(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     uint8_t *v = pv;
     qemu_get_buffer(f, v, size);
-    return 0;
+    return true;
 }
 
-static int put_buffer(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_buffer(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     uint8_t *v = pv;
     qemu_put_buffer(f, v, size);
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_buffer = {
     .name = "buffer",
-    .get  = get_buffer,
-    .put  = put_buffer,
+    .load = load_buffer,
+    .save = save_buffer,
 };
 
 /* unused buffers: space that was used for some fields that are
    not useful anymore */
 
-static int get_unused_buffer(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field)
+static bool load_unused_buffer(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, Error **errp)
 {
     uint8_t buf[1024];
     int block_len;
@@ -519,11 +550,13 @@ static int get_unused_buffer(QEMUFile *f, void *pv, size_t size,
         size -= block_len;
         qemu_get_buffer(f, buf, block_len);
     }
-   return 0;
+
+    return true;
 }
 
-static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field, JSONWriter *vmdesc)
+static bool save_unused_buffer(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               Error **errp)
 {
     static const uint8_t buf[1024];
     int block_len;
@@ -534,13 +567,13 @@ static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
         qemu_put_buffer(f, buf, block_len);
     }
 
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_unused_buffer = {
     .name = "unused_buffer",
-    .get  = get_unused_buffer,
-    .put  = put_unused_buffer,
+    .load = load_unused_buffer,
+    .save = save_unused_buffer,
 };
 
 /* vmstate_info_tmp, see VMSTATE_WITH_TMP, the idea is that we allocate
@@ -549,48 +582,34 @@ const VMStateInfo vmstate_info_unused_buffer = {
  * in fields that don't really exist in the parent but need to be in the
  * stream.
  */
-static int get_tmp(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_tmp(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, Error **errp)
 {
-    int ret;
-    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     int version_id = field->version_id;
-    void *tmp = g_malloc(size);
+    g_autofree void *tmp = g_malloc(size);
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-    g_free(tmp);
-    return ret;
+    return vmstate_load_vmsd(f, vmsd, tmp, version_id, errp);
 }
 
-static int put_tmp(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_tmp(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, JSONWriter *vmdesc,
+                     Error **errp)
 {
     const VMStateDescription *vmsd = field->vmsd;
-    void *tmp = g_malloc(size);
-    int ret;
-    Error *local_err = NULL;
+    g_autofree void *tmp = g_malloc(size);
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_save_state(f, vmsd, tmp, vmdesc, &local_err);
-    if (ret) {
-        error_report_err(local_err);
-    }
-    g_free(tmp);
-
-    return ret;
+    return vmstate_save_vmsd(f, vmsd, tmp, vmdesc, errp);
 }
 
 const VMStateInfo vmstate_info_tmp = {
     .name = "tmp",
-    .get = get_tmp,
-    .put = put_tmp,
+    .load = load_tmp,
+    .save = save_tmp,
 };
 
 /* bitmaps (as defined by bitmap.h). Note that size here is the size
@@ -600,11 +619,12 @@ const VMStateInfo vmstate_info_tmp = {
  */
 /* This is the number of 64 bit words sent over the wire */
 #define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
-static int get_bitmap(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field)
+static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     unsigned long *bmp = pv;
     int i, idx = 0;
+
     for (i = 0; i < BITS_TO_U64S(size); i++) {
         uint64_t w = qemu_get_be64(f);
         bmp[idx++] = w;
@@ -612,14 +632,17 @@ static int get_bitmap(QEMUFile *f, void *pv, size_t size,
             bmp[idx++] = w >> 32;
         }
     }
-    return 0;
+
+    return true;
 }
 
-static int put_bitmap(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool save_bitmap(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     unsigned long *bmp = pv;
     int i, idx = 0;
+
     for (i = 0; i < BITS_TO_U64S(size); i++) {
         uint64_t w = bmp[idx++];
         if (sizeof(unsigned long) == 4 && idx < BITS_TO_LONGS(size)) {
@@ -628,23 +651,21 @@ static int put_bitmap(QEMUFile *f, void *pv, size_t size,
         qemu_put_be64(f, w);
     }
 
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_bitmap = {
     .name = "bitmap",
-    .get = get_bitmap,
-    .put = put_bitmap,
+    .load = load_bitmap,
+    .save = save_bitmap,
 };
 
 /* get for QTAILQ
  * meta data about the QTAILQ is encoded in a VMStateField structure
  */
-static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
-                      const VMStateField *field)
+static bool load_qtailq(QEMUFile *f, void *pv, size_t unused_size,
+                        const VMStateField *field, Error **errp)
 {
-    int ret = 0;
-    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QTAILQ element */
     size_t size = field->size;
@@ -653,80 +674,76 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
     int version_id = field->version_id;
     void *elm;
 
-    trace_get_qtailq(vmsd->name, version_id);
+    trace_load_qtailq(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s %s",  vmsd->name, "too new");
-        trace_get_qtailq_end(vmsd->name, "too new", -EINVAL);
-
-        return -EINVAL;
+        error_setg(errp, "%s %s",  vmsd->name, "too new");
+        return false;
     }
     if (version_id < vmsd->minimum_version_id) {
-        error_report("%s %s",  vmsd->name, "too old");
-        trace_get_qtailq_end(vmsd->name, "too old", -EINVAL);
-        return -EINVAL;
+        error_setg(errp, "%s %s",  vmsd->name, "too old");
+        return false;
     }
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
+        if (!vmstate_load_vmsd(f, vmsd, elm, version_id, errp)) {
+            g_free(elm);
+            return false;
         }
         QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
     }
 
-    trace_get_qtailq_end(vmsd->name, "end", ret);
-    return ret;
+    trace_load_qtailq_end(vmsd->name);
+    return true;
 }
 
-/* put for QTAILQ */
-static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+/* save for QTAILQ */
+static bool save_qtailq(QEMUFile *f, void *pv, size_t unused_size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     const VMStateDescription *vmsd = field->vmsd;
     /* offset of the QTAILQ entry in a QTAILQ element*/
     size_t entry_offset = field->start;
     void *elm;
-    int ret;
-    Error *local_err = NULL;
 
-    trace_put_qtailq(vmsd->name, vmsd->version_id);
+    trace_save_qtailq(vmsd->name, vmsd->version_id);
 
     QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
+        if (!vmstate_save_vmsd(f, vmsd, elm, vmdesc, errp)) {
+            return false;
         }
     }
     qemu_put_byte(f, false);
 
-    trace_put_qtailq_end(vmsd->name, "end");
+    trace_save_qtailq_end(vmsd->name);
 
-    return 0;
+    return true;
 }
 const VMStateInfo vmstate_info_qtailq = {
     .name = "qtailq",
-    .get  = get_qtailq,
-    .put  = put_qtailq,
+    .load = load_qtailq,
+    .save = save_qtailq,
 };
 
-struct put_gtree_data {
+struct save_gtree_data {
     QEMUFile *f;
     const VMStateDescription *key_vmsd;
     const VMStateDescription *val_vmsd;
     JSONWriter *vmdesc;
-    int ret;
+    Error **errp;
+    bool failed;
 };
 
-static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
+/*
+ * save_gtree_elem - func for g_tree_foreach, return true to stop
+ * iteration.
+ */
+static gboolean save_gtree_elem(gpointer key, gpointer value, gpointer data)
 {
-    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
+    struct save_gtree_data *capsule = (struct save_gtree_data *)data;
     QEMUFile *f = capsule->f;
-    int ret;
-    Error *local_err = NULL;
 
     qemu_put_byte(f, true);
 
@@ -734,58 +751,56 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     if (!capsule->key_vmsd) {
         qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
     } else {
-        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc,
-                                 &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            capsule->ret = ret;
+        if (!vmstate_save_vmsd(f, capsule->key_vmsd, key, capsule->vmdesc,
+                               capsule->errp)) {
+            capsule->failed = true;
             return true;
         }
     }
 
     /* put the data */
-    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc,
-                             &local_err);
-    if (ret) {
-        error_report_err(local_err);
-        capsule->ret = ret;
+    if (!vmstate_save_vmsd(f, capsule->val_vmsd, value, capsule->vmdesc,
+                           capsule->errp)) {
+        capsule->failed = true;
         return true;
     }
     return false;
 }
 
-static int put_gtree(QEMUFile *f, void *pv, size_t unused_size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_gtree(QEMUFile *f, void *pv, size_t unused_size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     bool direct_key = (!field->start);
     const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[1];
     const VMStateDescription *val_vmsd = &field->vmsd[0];
     const char *key_vmsd_name = direct_key ? "direct" : key_vmsd->name;
-    struct put_gtree_data capsule = {
+    struct save_gtree_data capsule = {
         .f = f,
         .key_vmsd = key_vmsd,
         .val_vmsd = val_vmsd,
         .vmdesc = vmdesc,
-        .ret = 0};
+        .errp = errp,
+        .failed = false};
     GTree **pval = pv;
     GTree *tree = *pval;
     uint32_t nnodes = g_tree_nnodes(tree);
-    int ret;
 
-    trace_put_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
+    trace_save_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
     qemu_put_be32(f, nnodes);
-    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
+    g_tree_foreach(tree, save_gtree_elem, (gpointer)&capsule);
     qemu_put_byte(f, false);
-    ret = capsule.ret;
-    if (ret) {
-        error_report("%s : failed to save gtree (%d)", field->name, ret);
+    if (capsule.failed) {
+        trace_save_gtree_end(field->name, key_vmsd_name, val_vmsd->name);
+        return false;
     }
-    trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
-    return ret;
+
+    trace_save_gtree_end(field->name, key_vmsd_name, val_vmsd->name);
+    return true;
 }
 
-static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
-                     const VMStateField *field)
+static bool load_gtree(QEMUFile *f, void *pv, size_t unused_size,
+                       const VMStateField *field, Error **errp)
 {
     bool direct_key = (!field->start);
     const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[1];
@@ -798,107 +813,97 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
     GTree **pval = pv;
     GTree *tree = *pval;
     void *key, *val;
-    int ret = 0;
-    Error *local_err = NULL;
 
     /* in case of direct key, the key vmsd can be {}, ie. check fields */
     if (!direct_key && version_id > key_vmsd->version_id) {
-        error_report("%s %s",  key_vmsd->name, "too new");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  key_vmsd->name, "too new");
+        return false;
     }
     if (!direct_key && version_id < key_vmsd->minimum_version_id) {
-        error_report("%s %s",  key_vmsd->name, "too old");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  key_vmsd->name, "too old");
+        return false;
     }
     if (version_id > val_vmsd->version_id) {
-        error_report("%s %s",  val_vmsd->name, "too new");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  val_vmsd->name, "too new");
+        return false;
     }
     if (version_id < val_vmsd->minimum_version_id) {
-        error_report("%s %s",  val_vmsd->name, "too old");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  val_vmsd->name, "too old");
+        return false;
     }
 
     nnodes = qemu_get_be32(f);
-    trace_get_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
+    trace_load_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
 
     while (qemu_get_byte(f)) {
         if ((++count) > nnodes) {
-            ret = -EINVAL;
             break;
         }
         if (direct_key) {
             key = (void *)(uintptr_t)qemu_get_be64(f);
         } else {
             key = g_malloc0(key_size);
-            ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
-            if (ret) {
-                error_report_err(local_err);
+            if (!vmstate_load_vmsd(f, key_vmsd, key, version_id, errp)) {
                 goto key_error;
             }
         }
         val = g_malloc0(val_size);
-        ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
-        if (ret) {
-            error_report_err(local_err);
+        if (!vmstate_load_vmsd(f, val_vmsd, val, version_id, errp)) {
             goto val_error;
         }
         g_tree_insert(tree, key, val);
     }
     if (count != nnodes) {
-        error_report("%s inconsistent stream when loading the gtree",
-                     field->name);
-        return -EINVAL;
+        error_setg(errp, "%s inconsistent stream when loading the gtree",
+                   field->name);
+        return false;
     }
-    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
-    return ret;
+
+    trace_load_gtree_end(field->name, key_vmsd_name, val_vmsd->name);
+    return true;
+
 val_error:
     g_free(val);
+
 key_error:
     if (!direct_key) {
         g_free(key);
     }
-    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
-    return ret;
+    return false;
 }
 
 
 const VMStateInfo vmstate_info_gtree = {
     .name = "gtree",
-    .get  = get_gtree,
-    .put  = put_gtree,
+    .load = load_gtree,
+    .save = save_gtree,
 };
 
-static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_qlist(QEMUFile *f, void *pv, size_t unused_size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     const VMStateDescription *vmsd = field->vmsd;
     /* offset of the QTAILQ entry in a QTAILQ element*/
     size_t entry_offset = field->start;
     void *elm;
-    int ret;
-    Error *local_err = NULL;
 
-    trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
+    trace_save_qlist(field->name, vmsd->name, vmsd->version_id);
     QLIST_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
+        if (!vmstate_save_vmsd(f, vmsd, elm, vmdesc, errp)) {
+            return false;
         }
     }
     qemu_put_byte(f, false);
-    trace_put_qlist_end(field->name, vmsd->name);
+    trace_save_qlist_end(field->name, vmsd->name);
 
-    return 0;
+    return true;
 }
 
-static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
-                     const VMStateField *field)
+static bool load_qlist(QEMUFile *f, void *pv, size_t unused_size,
+                       const VMStateField *field, Error **errp)
 {
-    int ret = 0;
-    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QLIST element */
     size_t size = field->size;
@@ -907,23 +912,21 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
     int version_id = field->version_id;
     void *elm, *prev = NULL;
 
-    trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
+    trace_load_qlist(field->name, vmsd->name, vmsd->version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s %s",  vmsd->name, "too new");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  vmsd->name, "too new");
+        return false;
     }
     if (version_id < vmsd->minimum_version_id) {
-        error_report("%s %s",  vmsd->name, "too old");
-        return -EINVAL;
+        error_setg(errp, "%s %s",  vmsd->name, "too old");
+        return false;
     }
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
-        if (ret) {
-            error_report_err(local_err);
+        if (!vmstate_load_vmsd(f, vmsd, elm, version_id, errp)) {
             g_free(elm);
-            return ret;
+            return false;
         }
         if (!prev) {
             QLIST_RAW_INSERT_HEAD(pv, elm, entry_offset);
@@ -932,13 +935,13 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
         }
         prev = elm;
     }
-    trace_get_qlist_end(field->name, vmsd->name);
+    trace_load_qlist_end(field->name, vmsd->name);
 
-    return ret;
+    return true;
 }
 
 const VMStateInfo vmstate_info_qlist = {
     .name = "qlist",
-    .get  = get_qlist,
-    .put  = put_qlist,
+    .load = load_qlist,
+    .save = save_qlist,
 };
-- 
2.52.0


