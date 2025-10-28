Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A76CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstk-00034m-Tc; Tue, 28 Oct 2025 19:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDsth-00033A-BZ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstO-00018N-5N
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:36 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A3AB68177B;
 Wed, 29 Oct 2025 02:14:05 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-z3lyrqwK; Wed, 29 Oct 2025 02:14:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693245;
 bh=NzlRVQ6wK9/3jkzrGEhWeF+eDOyfrMkHZSOrIRNGoLA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WPaezdIZawF0l4hLcvDxVs6FZ230xH65lcs2euROc8BYLQ0kuCBbPocAS6PwH7mi5
 4mNYL6GkP9ceEDtW1VIydebCrrqeZpMgbM4ZNtwYMiulfmSLQ21IQPBRA5PwU5LjFG
 HX1x843YAGhhdGOCQClFgU8HjbkZtDmi8pEIcoxg=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 19/22] migration/vmstate-types: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:43 +0300
Message-ID: <20251028231347.194844-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate-types.c | 584 ++++++++++++++++++--------------------
 1 file changed, 283 insertions(+), 301 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 4b01dc19c2..a06b7dd478 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -23,132 +23,136 @@
 
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
     int32_t *v = pv;
     int32_t v2;
     qemu_get_sbe32s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
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
@@ -156,359 +160,368 @@ static int get_int32_le(QEMUFile *f, void *pv, size_t size,
 
     if (loaded >= 0 && loaded <= *cur) {
         *cur = loaded;
-        return 0;
+        return true;
     }
-    error_report("Invalid value %" PRId32
-                 " expecting positive value <= %" PRId32,
-                 loaded, *cur);
-    return -EINVAL;
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
     uint32_t *v = pv;
     uint32_t v2;
     qemu_get_be32s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
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
     *v = qemu_file_get_fd(f);
-    return 0;
+    return true;
 }
 
-static int put_fd(QEMUFile *f, void *pv, size_t size,
-                  const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fd(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc,
+                    Error **errp)
 {
     int32_t *v = pv;
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         qemu_put_sbe32s(f, v);
-        return 0;
+        return true;
     }
-    return qemu_file_put_fd(f, *v);
+    return qemu_file_put_fd(f, *v) == 0;
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
     uint64_t *v = pv;
     uint64_t v2;
     qemu_get_be64s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%" PRIx64 " != %" PRIx64, *v, v2);
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
     uint8_t *v = pv;
     uint8_t v2;
     qemu_get_8s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%x != %x", *v, v2);
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
     uint16_t *v = pv;
     uint16_t v2;
     qemu_get_be16s(f, &v2);
 
     if (*v == v2) {
-        return 0;
+        return true;
     }
-    error_report("%x != %x", *v, v2);
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
@@ -518,11 +531,12 @@ static int get_unused_buffer(QEMUFile *f, void *pv, size_t size,
         size -= block_len;
         qemu_get_buffer(f, buf, block_len);
     }
-   return 0;
+   return true;
 }
 
-static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field, JSONWriter *vmdesc)
+static bool save_unused_buffer(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               Error **errp)
 {
     static const uint8_t buf[1024];
     int block_len;
@@ -533,13 +547,13 @@ static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
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
@@ -548,48 +562,34 @@ const VMStateInfo vmstate_info_unused_buffer = {
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
@@ -599,8 +599,8 @@ const VMStateInfo vmstate_info_tmp = {
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
@@ -611,11 +611,12 @@ static int get_bitmap(QEMUFile *f, void *pv, size_t size,
             bmp[idx++] = w >> 32;
         }
     }
-    return 0;
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
@@ -627,23 +628,21 @@ static int put_bitmap(QEMUFile *f, void *pv, size_t size,
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
@@ -654,78 +653,76 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
 
     trace_get_qtailq(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s %s",  vmsd->name, "too new");
+        error_setg(errp, "%s %s",  vmsd->name, "too new");
         trace_get_qtailq_end(vmsd->name, "too new", -EINVAL);
-
-        return -EINVAL;
+        return false;
     }
     if (version_id < vmsd->minimum_version_id) {
-        error_report("%s %s",  vmsd->name, "too old");
+        error_setg(errp, "%s %s",  vmsd->name, "too old");
         trace_get_qtailq_end(vmsd->name, "too old", -EINVAL);
-        return -EINVAL;
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
+    trace_get_qtailq_end(vmsd->name, "end", 0);
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
 
     trace_put_qtailq(vmsd->name, vmsd->version_id);
 
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
 
     trace_put_qtailq_end(vmsd->name, "end");
 
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
 
@@ -733,58 +730,55 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
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
 
     trace_put_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
     qemu_put_be32(f, nnodes);
-    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
+    g_tree_foreach(tree, save_gtree_elem, (gpointer)&capsule);
     qemu_put_byte(f, false);
-    ret = capsule.ret;
-    if (ret) {
-        error_report("%s : failed to save gtree (%d)", field->name, ret);
+    if (capsule.failed) {
+        trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, -1);
+        return false;
     }
-    trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
-    return ret;
+    trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, 0);
+    return true;
 }
 
-static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
-                     const VMStateField *field)
+static bool load_gtree(QEMUFile *f, void *pv, size_t unused_size,
+                       const VMStateField *field, Error **errp)
 {
     bool direct_key = (!field->start);
     const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[1];
@@ -798,24 +792,23 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
     GTree *tree = *pval;
     void *key, *val;
     int ret = 0;
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
@@ -830,24 +823,20 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
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
     trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
     return ret;
@@ -858,46 +847,41 @@ key_error:
         g_free(key);
     }
     trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
-    return ret;
+    return ret >= 0;
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
 
     trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
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
     trace_put_qlist_end(field->name, vmsd->name);
 
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
@@ -908,21 +892,19 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
 
     trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
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
@@ -933,11 +915,11 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
     }
     trace_get_qlist_end(field->name, vmsd->name);
 
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
2.48.1


