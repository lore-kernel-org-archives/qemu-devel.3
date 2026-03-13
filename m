Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036E2105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GF-0005Tr-CL; Fri, 13 Mar 2026 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fq-0005Q8-QY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006M2-RI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1757461f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411145; x=1774015945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vO92Zi9/ERTEc9krJOx/gmUGwLnlw9NS0k8O07O6ydg=;
 b=j23QRBDSOP1tAuaXE0Xjbjei2KVgV08lDtZhmsLbvvThgKoVbfsujUGmnMGkuDpMsC
 Bqm3mHwo8gVQZJdTdaJgHaGfOcjPm0bDb6TfPJnmTrLm6wVf5QVVkjpZc8lCVl1IhgDW
 ar/7RkEzLjNhMQujDUAHgEoZXVFSmPlbKCTBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411145; x=1774015945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vO92Zi9/ERTEc9krJOx/gmUGwLnlw9NS0k8O07O6ydg=;
 b=ezlYE1x3LZpzOwolvaDXAgqfO1GwSZDr4+YzUsDtEV0GjCnuGN7t7pltrfdiNrgFoH
 vRFtw8jC215r1qvusHRS1vQkpqKVveCeXbe8TkPrN1lc7PnHAV3BdgisbxxBIeazzktG
 k1D5ssMXB/x4Xemf8qBzdQSgin11U4YS2vqNuwMQ0iTPLZPypqHT3WdoSL63AHPQ/lNf
 iBrYHBdAJy1EoHpmyT0j5AJgs+DJjs9vifnd9fA09qzpuPDv8Wz4hOuxZjdMcoKulQDz
 UN1athn59BKGS/qbRWtamQ6J+Khqbk22As4M6GCSaPQ1+rJNv/tmrDb3gQCg1XZm0rDk
 ehiA==
X-Gm-Message-State: AOJu0YzDik6qxyKlDLLU+sW+95wpobIcUXNbbZgCqOe0XyCi77IxAT7b
 bWUx/4Ico3u3JZDQ5Y9xMXRLGCpN/wwAURjkt2o15r2sAnlHCFDMKrJw35jDZUFU3ow1NcFJOLa
 vqYf9uuQ=
X-Gm-Gg: ATEYQzwbCexE+nGZUqR16C1o6m+IVGviD3A9RAUKnMuSmDt8NXGv/S0ta2DfbOpxN03
 KtQI+VnthIKvM+kwCP/puQrV5/mqikuObBYK5HiLebiCk0JnQOub4c8X3hlDGMaKS/nBRpubKvM
 8uzAOGHawNN/fLse8AoAneCCDGnxWHQRf/R69jnfq+QvhjBvOe2AFPovgx7i5DABIUvi5nTeGe3
 /fMNvbLRVYpZfF0+l6E+g/7ePr0RszprkGYAIzDTrtmUZJqQjcvO3/WO6F4Fgl0ArdIbRFQwZWv
 0gBJwBk3UBWG6iqvGEioZpdNurqxztG0riBb7AmyVfroCJZwN18yHHsTDIQ7F5ObEtx2a8P0tH1
 NUO/QBDuijV0FPS+s4SEAWEXZExRtJyznPRL2HHjDAljtjW9Up3vPuovOLQMIzABUOyKtqVlG82
 yfmutt1rukWOBXAD+5WnoxqkQRtmfIKI+pjAot/aBpj2aORnOA4VNkKqQBDPilcOmbPP/ClB/2h
 80iYuWM3OGyiAzHNT6ovd0=
X-Received: by 2002:a05:6000:40de:b0:439:ca7b:f4b with SMTP id
 ffacd0b85a97d-43a04dcbebbmr6326109f8f.50.1773411145217; 
 Fri, 13 Mar 2026 07:12:25 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:24 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 1/8] migration/vmstate: introduce vmstate_{load,
 save}_field helpers
Date: Fri, 13 Mar 2026 15:12:14 +0100
Message-ID: <20260313141221.359503-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42c.google.com
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
Reply-to:  Alexander Mikhalitsyn <alexander@mihalicyn.com>
From:  Alexander Mikhalitsyn via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Let's introduce vmstate_{load,save}_field() helpers, they will
be used in next patches to support fully-dynamic arrays with NULLs.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 include/migration/vmstate.h |  4 ++
 migration/vmstate.c         | 84 +++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 62c2abd0c49..5d7dfe70643 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1240,8 +1240,12 @@ extern const VMStateInfo vmstate_info_qlist;
         .flags = VMS_END, \
     }
 
+int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp);
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
+int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7ba..8d192bcaa27 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -131,6 +131,32 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
+int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
+{
+    int ret = 0;
+
+    if (field->flags & VMS_STRUCT) {
+        ret = vmstate_load_state(f, field->vmsd, pv,
+                                 field->vmsd->version_id,
+                                 errp);
+    } else if (field->flags & VMS_VSTRUCT) {
+        ret = vmstate_load_state(f, field->vmsd, pv,
+                                 field->struct_version_id,
+                                 errp);
+    } else {
+        ret = field->info->get(f, pv, size, field);
+        if (ret < 0) {
+            error_setg(errp,
+                       "Failed to load element of type %s for %s: "
+                       "%d", field->info->name,
+                       field->name, ret);
+        }
+    }
+
+    return ret;
+}
+
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -203,24 +229,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     inner_field = field;
                 }
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id,
-                                             errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id,
-                                             errp);
-                } else {
-                    ret = inner_field->info->get(f, curr_elem, size,
-                                                 inner_field);
-                    if (ret < 0) {
-                        error_setg(errp,
-                                   "Failed to load element of type %s for %s: "
-                                   "%d", inner_field->info->name,
-                                   inner_field->name, ret);
-                    }
-                }
+                ret = vmstate_load_field(f, curr_elem, size, inner_field, errp);
 
                 /* If we used a fake temp field.. free it now */
                 if (inner_field != field) {
@@ -427,6 +436,29 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
+int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc, Error **errp)
+{
+    int ret = 0;
+
+    if (field->flags & VMS_STRUCT) {
+        ret = vmstate_save_state(f, field->vmsd, pv, vmdesc, errp);
+    } else if (field->flags & VMS_VSTRUCT) {
+        ret = vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
+                                   field->struct_version_id, errp);
+    } else {
+        ret = field->info->put(f, pv, size, field, vmdesc);
+        if (ret < 0) {
+            error_setg(errp,
+                       "Failed to save element of type %s for %s: "
+                       "%d", field->info->name,
+                       field->name, ret);
+        }
+    }
+
+    return ret;
+}
+
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
@@ -528,19 +560,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
                                       i, max_elems);
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop, errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, inner_field->vmsd,
-                                               curr_elem, vmdesc_loop,
-                                               inner_field->struct_version_id,
-                                               errp);
-                } else {
-                    ret = inner_field->info->put(f, curr_elem, size,
-                                                 inner_field, vmdesc_loop);
-                }
-
+                ret = vmstate_save_field(f, curr_elem, size, inner_field, vmdesc_loop, errp);
                 written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
                                     written_bytes);
@@ -551,7 +571,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (ret) {
-                    error_setg(errp, "Save of field %s/%s failed",
+                    error_prepend(errp, "Save of field %s/%s failed: ",
                                 vmsd->name, field->name);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
-- 
2.47.3


