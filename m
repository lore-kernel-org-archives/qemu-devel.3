Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6041ECA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNbH-0005cL-FK; Sat, 30 Aug 2025 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5JD-0004jz-Sc
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5JC-0004X5-17
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8x1fPRiLk+q98Zq/PxzJ1EQGy5pEsHLkUkWHdcN4ADk=;
 b=MqAzg+bnoj+cQFpDO8l7lhd5bjgSA2NJ+zA6FC77oJTn8jsSDZawDOMyyT/z7Qa1fkvt+H
 rptlKAKRImC5HgG0LsQS9F65jFIAMvP8EHU+88Kxjm5OCAXhAhgSn5vtlm56Tpq9GKIvBP
 VBWGA7siV4tFO7YfXGIwTzcV8Q/bSyc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-QQdiOrX6NOWLdHlHsVrEmg-1; Fri, 29 Aug 2025 16:02:47 -0400
X-MC-Unique: QQdiOrX6NOWLdHlHsVrEmg-1
X-Mimecast-MFC-AGG-ID: QQdiOrX6NOWLdHlHsVrEmg_1756497766
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-248abeb9242so23077385ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497766; x=1757102566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8x1fPRiLk+q98Zq/PxzJ1EQGy5pEsHLkUkWHdcN4ADk=;
 b=pDf6zFprMgoeJapkWV5zE63LaM3EAWfJkQ4t/Vz6pGKSnvUe5wP7AQBukYGmPhxiCH
 GBCtvW2b7CJUHsYHhgerBsygiv5rnZfeQBYxNX2NxGJiiCMJrxFVNp2WXcI4eWkodPFv
 QuinU5YTH2K3IYjvUv8IhxpSlCgosJnuDPGwFxxZJSx1rKbJIsn54uXf1tweNVjRn0JG
 EMDl602j8j5m8EKWDwfdqUSEahXdnZd4OZ+2w2cNW/S643gRdPxw6XrMsVQinoGQ4UcV
 anfMBoYDNo8ENz+TCx9DgkfbZEUIh3pyuIHkiN8Y4RpXOQWxBK1b6pPpNWuuvbaD67PC
 e7HA==
X-Gm-Message-State: AOJu0YxnmsBvZ0wnCwq59VNsttOmmFX5161H3l5xYnj0OfWk//t/wduR
 X4X0SWp4uEM8XValhtvcbxjDfXY4tdb7L9N8KIx0Ffk1zmCopqMy+mFv6JzZJqQuTqgLiUIwL3N
 vjBSIiY6AsEI0YdDzyYpFeUPeL9zppGOHU5haqZYmvU2fPliMtvBfyIhb
X-Gm-Gg: ASbGncvvM75TB41Q75RGKsGXjRh/YzllmMDlp4V1X9FfdOIL/xMMOIPlwFb95DGuZzT
 vgKejwqF/4Wb33/SFo1rNYeSc0xtGyMa05tWBjblG25tJ4LrHmJSKjX0Pe2sfzBFbxwYxgRYpIk
 flhT7AdxGO8RA/Aq5V09lwg0dH/rDoq4D7A9Brc9tnfqu1BFurQaNm+8RANjlXVtQZaIuTK4qxP
 OUnAqznqO2+QEnAkmVGbmRUxCRbEOFsosjXhqtt0rMtf/E0oMDINiqsAqFSBFXqnhVSev7hBHxA
 SlskEEvQyAZixS4bI8jMxN/vBfIa/bji63FpatktzBDK26Ir3Pnt/A==
X-Received: by 2002:a17:903:248:b0:248:7018:c739 with SMTP id
 d9443c01a7336-2487018c906mr209827405ad.28.1756497766260; 
 Fri, 29 Aug 2025 13:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNe5QOPLN1Yo6gm4lYifmN3xBc+lNgtzX73UgXZg0qiORH0O8SGsaZsJwVtwaVaxd90xxcLw==
X-Received: by 2002:a17:903:248:b0:248:7018:c739 with SMTP id
 d9443c01a7336-2487018c906mr209826865ad.28.1756497765759; 
 Fri, 29 Aug 2025 13:02:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:02:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:41 +0530
Subject: [PATCH v13 01/27] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-1-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3492; i=armenon@redhat.com;
 h=from:subject:message-id; bh=jjVnj4GpDkFjmsw4frYXnt3FkfLdgzOUkOtwV8FPcDs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdu+2d5N4f3Ux2Xl5yMqqbg7Q3nvLXKXpyB6x00r5c
 WKnt6h1lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMhML0aGe8l/Pxw4FfEhc/oa
 9o+c5T9mJ3wLfvFN+9e5ZLWt7xSOb2P4X+EZb9h/woJx9ZMHXeI2PRlalVJatoox7/k2Xr67/ek
 7FgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..08f2b562e3a5ec0e186336215ccfb378a7675f0c 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -136,6 +136,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
+    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
@@ -225,9 +226,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
+        error_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
@@ -566,7 +568,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +600,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +612,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp,
+                       "Loading VM subsection '%s' in '%s' failed: %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }

-- 
2.51.0


