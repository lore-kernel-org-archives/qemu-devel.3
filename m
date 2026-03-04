Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8F8EFCE47
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxtgy-0004oA-Gc; Wed, 04 Mar 2026 16:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgc-0004k7-Nh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgX-0003Rf-I3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 66134C01EB;
 Thu, 05 Mar 2026 00:23:10 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-whb1baJV; Thu, 05 Mar 2026 00:23:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659389;
 bh=SFZOucGRtXzagEF8NV4kKKFFi4CqOBo32QGjLx/LfI0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ys5oAZW43N+DiGOQ1YqS2omJH1L3CU6z75jzPniUalJc+S8ZNSAkRDaqIriQ468FN
 lgrx33nZcHXfbjt1OULmOLk6AtkHPSLkrf0PqNuk3/tLmnSRjxr819Elny31XMpCzR
 hoLM+zcDkGYPPWkTcqprj4Y/D8WKo5LJu2TBnZa4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 05/18] migration: vmstate_save/load_state(): refactor
 tracing errors
Date: Thu,  5 Mar 2026 00:22:49 +0300
Message-ID: <20260304212303.667141-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

To simplify further changes (convertion to bool+errp APIs),
let's rework some error paths:

- get rid of int ret in traces, as we are moving to bool+errp APIs
- split traces to _fail / _success (seems better than add boolean
  result to the message).
- prefer short error paths (return immediately on error)
- around trace_vmstate_load_field_error(), do not call
  qemu_file_set_error(), if the erroc comes from qemu_file_get_error()

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/trace-events |  6 ++++--
 migration/vmstate.c    | 25 +++++++++++++++----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index 90629f828f8..0b3f759ccc4 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -57,13 +57,15 @@ postcopy_page_req_sync(void *host_addr) "sync page req %p"
 # vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
-vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
+vmstate_load_state_fail(const char *name, const char *reason) "%s %s"
+vmstate_load_state_success(const char *name) "%s"
 vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
 vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
 vmstate_subsection_load_good(const char *parent) "%s"
-vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
+vmstate_save_state_pre_save_fail(const char *name) "%s"
+vmstate_save_state_pre_save_success(const char *name) "%s"
 vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
 vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index dd7cd279937..87e1f049592 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -144,7 +144,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
+        trace_vmstate_load_state_fail(vmsd->name, "too new");
         return -EINVAL;
     }
 
@@ -152,7 +152,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
+        trace_vmstate_load_state_fail(vmsd->name, "too old");
         return -EINVAL;
     }
 
@@ -240,10 +240,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                         error_setg(errp,
                                    "Failed to load %s state: stream error: %d",
                                    vmsd->name, ret);
+                        trace_vmstate_load_field_error(field->name, ret);
+                        return ret;
                     }
-                }
-
-                if (ret < 0) {
+                } else {
                     qemu_file_set_error(f, ret);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
@@ -269,7 +269,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
-            ret = -EINVAL;
+            trace_vmstate_load_state_fail(vmsd->name, "post-load");
+            return -EINVAL;
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -279,12 +280,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        "minimum_version: %d, ret: %d",
                        vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
                        ret);
+            trace_vmstate_load_state_fail(vmsd->name, "post-load");
+            return ret;
         }
     }
 
-    trace_vmstate_load_state_end(vmsd->name, "end", ret);
+    trace_vmstate_load_state_success(vmsd->name);
 
-    return ret;
+    return 0;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -444,20 +447,22 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (vmsd->pre_save_errp) {
         ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
+            trace_vmstate_save_state_pre_save_fail(vmsd->name);
             return ret;
         }
     } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
             error_setg(errp, "pre-save failed: %s", vmsd->name);
+            trace_vmstate_save_state_pre_save_fail(vmsd->name);
             return ret;
         }
     }
 
+    trace_vmstate_save_state_pre_save_success(vmsd->name);
+
     if (vmdesc) {
         json_writer_str(vmdesc, "vmsd_name", vmsd->name);
         json_writer_int64(vmdesc, "version", version_id);
-- 
2.52.0


