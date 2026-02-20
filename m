Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44BFC5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXds-0000BJ-6y; Fri, 20 Feb 2026 16:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdq-00009b-86
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:26 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdl-0002l6-R4
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C2F24C0236;
 Sat, 21 Feb 2026 00:02:19 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-gaLp2ZMZ; Sat, 21 Feb 2026 00:02:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621339;
 bh=8qbTV45JPMFsAAGyG7jc2Jx/AESxGUb7jRPDplodV0E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TRzCtkavBvPPUUStdtxl8VY89eoURqlsoTPdoW2MiU+MWZ9YNbZNDLH0Hm52AROU6
 A4fjFSHLOiCHlJPF26pvrycG6auli9jtR+bNz43JgiOHdIsRucMAA+Zi4Nia3zW9QP
 7yDYpUEz6BIK1n9S6h1Pn0qvrNNwtZPElc/6zVdQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 05/16] migration: vmstate_save/load_state(): stop tracing
 errors
Date: Sat, 21 Feb 2026 00:02:03 +0300
Message-ID: <20260220210214.800050-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We duplicate some of errors by trace points. That doesn't make
real sense: we report the error through errp, and stop migration,
no reason to duplicate the reported error by trace points, making
error path more complicated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/trace-events |  5 ++---
 migration/vmstate.c    | 14 ++++++--------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index 90629f828f..e864d19c55 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -55,15 +55,14 @@ postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
 
 # vmstate.c
-vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
-vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
+vmstate_load_state_end(const char *name) "%s"
 vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
 vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
 vmstate_subsection_load_good(const char *parent) "%s"
-vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
+vmstate_save_state_pre_save_done(const char *name) "%s"
 vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
 vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index dd7cd27993..b07bbdd366 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -144,7 +144,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
 
@@ -152,7 +151,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
-        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
 
@@ -245,7 +243,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    trace_vmstate_load_field_error(field->name, ret);
                     return ret;
                 }
             }
@@ -269,7 +266,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
-            ret = -EINVAL;
+            return -EINVAL;
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -279,12 +276,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        "minimum_version: %d, ret: %d",
                        vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
                        ret);
+            return ret;
         }
     }
 
-    trace_vmstate_load_state_end(vmsd->name, "end", ret);
+    trace_vmstate_load_state_end(vmsd->name);
 
-    return ret;
+    return 0;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -444,20 +442,20 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (vmsd->pre_save_errp) {
         ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
             return ret;
         }
     } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
             error_setg(errp, "pre-save failed: %s", vmsd->name);
             return ret;
         }
     }
 
+    trace_vmstate_save_state_pre_save_done(vmsd->name);
+
     if (vmdesc) {
         json_writer_str(vmdesc, "vmsd_name", vmsd->name);
         json_writer_int64(vmdesc, "version", version_id);
-- 
2.52.0


