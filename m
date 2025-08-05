Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC3C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMWA-0007Ha-8T; Tue, 05 Aug 2025 14:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMUs-0002SN-Ip
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMRY-0004ez-Mn
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kGN9/eILY+hbq3FdeGQ/l7q4/1VhCx4p2FFdcgrlpL0=;
 b=GOi6cGyHqAbXjOSJVBxa+1Jg0jb/7/StDANcBip2wVQnOlNAh0UzDZSMxOOesPNRj6XjCI
 UyrThqpspJ3y/vWsZA2qi3uFeX0i9kvrSNwq3tdUwoFpkcSalkD8TtuEebz3X+qHifpXrY
 gSRtMRVoXFdSbmPsXvp0ieuou0rp+sc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-rRJ82bqVMQKDwhkxv8V6DA-1; Tue, 05 Aug 2025 14:31:21 -0400
X-MC-Unique: rRJ82bqVMQKDwhkxv8V6DA-1
X-Mimecast-MFC-AGG-ID: rRJ82bqVMQKDwhkxv8V6DA_1754418681
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b26e33ae9d5so7923308a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418681; x=1755023481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGN9/eILY+hbq3FdeGQ/l7q4/1VhCx4p2FFdcgrlpL0=;
 b=Lb3VlrrhDZgB88ac8oqgWHIy9hY6W+mwoQ54DG2sEQPeCqPXK+qdGmUnuE8uOnk0m7
 rvlkntYugAIWspnLW9YZiSvuL2BdBLOwghVmkNkfWEW8H6vTRCstekODYaPw2qOYYxm3
 ++V3qpTPz25uCK4aC2hiihsMO4OjCRSJoSMbpO5N8TOAf/8v2ge/3yMs7H87mm0P4Pe4
 XtVXW2B2s1mDYPHNP5SuwdDoizCIqj4FWTE9QbHZyAwj0Zhlku8Q0lnQi8+HTneIQMW+
 mK6evxYkn8V/rCp7u85Ssygy6MbQo5rzb3YZck988RP4iTAnyAvbWH/zhy902S/MfxBi
 Aj2w==
X-Gm-Message-State: AOJu0YznMkInVL0lPFLT27clGhx5i4NZruTu9G6P1ZPX6Eu0OVqtPIGF
 JbWpuO8T4v1Be3jvxJopmoE7xAvH/UtfJeDcYVYfoP5LvtHdf+OtG/6cYwEro0ikZMGtifXFwrb
 uiDb1jslDHgCqjHHxn5Dsjc59YIYiPnlufcPGdDm3DPpOQrfxvteq70B1
X-Gm-Gg: ASbGnct6cvv7hG5pa4SFe6AOUYp7YW772rkX7wtR+E7KryrpLHFis+IxurjgO4FnZ05
 dtExWZEVXlqHA0rAxlkCEMJ6ikaIU3IdBKqzve0W/BbIPXNtVumfeKMLKB+N7o8hvr5gGiuLovq
 PhXDalWcl6dwh/KwCNEGBT5zlWnGFATdjWwWmN+p3Q7oo90TtjZ5rRB45sxCmr6Id5xb3MxHfWm
 ErCzvGyc3KeJ5RWIyxvCbYRMjzYq1sJdIX/ZV2gkMAW36cSxW4zVU4bMlWw+2+gAtFUZSWS8kiJ
 zXd9OQlvevK1Tqs41hosEQqiUoo8/XxJiXaNN/qS4ed4I7Ycww==
X-Received: by 2002:a17:903:228c:b0:240:8cca:50fb with SMTP id
 d9443c01a7336-2429f4ae088mr1074765ad.37.1754418680616; 
 Tue, 05 Aug 2025 11:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8UJNdT/JCKNBBfqfSyf2wpEKcB3xK3uXEiBVvh+NMh+GNn7goFyoioHIxxJowKfnYE0SFgQ==
X-Received: by 2002:a17:903:228c:b0:240:8cca:50fb with SMTP id
 d9443c01a7336-2429f4ae088mr1074415ad.37.1754418680229; 
 Tue, 05 Aug 2025 11:31:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:31:19 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:30 +0530
Subject: [PATCH v9 23/27] migration: Refactor vmstate_save_state_v() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4475; i=armenon@redhat.com;
 h=from:subject:message-id; bh=c8kfvDk6lrJiSfsmBzhkJZ0RnyOClKC/mbMu3S27q9w=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX9mDncx6yzrOfLnhXyuXusnpTuJn7lX+N2LYpnF+T
 96z/tyFjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABPxzWRkmLb9a8a0lbkLFrs+
 z0vK7zHaPK0+OvaZZe5iVkY3r3apHoa/oucMVQTs5073Xv7op8gCp1OVyoGv1swT3PNJq/Wt1xk
 ZXgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The original vmstate_save_state_v() function combined multiple
responsibilities like calling pre-save hooks, saving the state of
the device, handling subsection saves and invoking post-save hooks.
This led to a lengthy and less readable function.

To address this, introduce wrapper functions for pre-save,
post-save and the device-state save functionalities.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 78 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 60ff38858cf54277992fa5eddeadb6f3d70edec3..fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -414,22 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
+static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
+                             Error **errp)
 {
     int ret = 0;
-    const VMStateField *field = vmsd->fields;
-
-    trace_vmstate_save_state_top(vmsd->name);
-
     if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
-            error_setg(errp, "pre-save failed: %s", vmsd->name);
-            return ret;
+            error_setg(errp, "pre-save for %s failed, ret: %d",
+                       vmsd->name, ret);
         }
     }
+    return ret;
+}
+
+static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
+                              Error **errp)
+{
+    int ret = 0;
+    if (vmsd->post_save) {
+        ret = vmsd->post_save(opaque);
+        error_setg(errp, "post-save for %s failed, ret: %d",
+                   vmsd->name, ret);
+    }
+    return ret;
+}
+
+static int vmstate_save_dispatch(QEMUFile *f,
+                                 const VMStateDescription *vmsd,
+                                 void *opaque, JSONWriter *vmdesc,
+                                 int version_id, Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+    int ps_ret = 0;
+    Error *local_err = NULL;
+    const VMStateField *field = vmsd->fields;
 
     if (vmdesc) {
         json_writer_str(vmdesc, "vmsd_name", vmsd->name);
@@ -532,9 +553,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
-                    }
+                    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
                     return ret;
                 }
 
@@ -557,16 +576,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     if (vmdesc) {
         json_writer_end_array(vmdesc);
     }
+    return ret;
+}
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
-        }
+int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                         void *opaque, JSONWriter *vmdesc, int version_id,
+                         Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+    Error *local_err = NULL;
+    int ps_ret = 0;
+
+    trace_vmstate_save_state_top(vmsd->name);
+
+    ret = pre_save_dispatch(vmsd, opaque, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vmstate_save_dispatch(f, vmsd, opaque, vmdesc,
+                                version_id, errp);
+    if (ret) {
+        return ret;
     }
+
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
+    if (!ret && ps_ret) {
+        ret = ps_ret;
+        error_setg(errp, "post-save failed: %s", vmsd->name);
+    }
+
     return ret;
 }
 

-- 
2.50.1


