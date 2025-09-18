Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E09FCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGZR-0004Gt-JR; Thu, 18 Sep 2025 11:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGY6-0003Hb-QZ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGY1-0003RI-Qh
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFx1//LdCNq+XYf5MolNY5wtarm8we+wGLU/Uo30GXs=;
 b=FD64Slp1bVmFwRr7Q75MtsUKvXNVtpMqJehvOK/n5FW+fRg85K1PyUZYYGODmwBqFGDk0v
 +AiZnY1Br8ng001qxonhfRzqP8CUen0fVaKZFEG/1CgA8ACICuVweYLwaVMSCouOVcTVGo
 SR3OgXQ7tALFBSrOgcYryCRaSyLhzFU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-qIWJMCTsPM-3_hT6_LX4Hw-1; Thu, 18 Sep 2025 11:27:43 -0400
X-MC-Unique: qIWJMCTsPM-3_hT6_LX4Hw-1
X-Mimecast-MFC-AGG-ID: qIWJMCTsPM-3_hT6_LX4Hw_1758209262
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77429fb6ce4so1176808b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209262; x=1758814062;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFx1//LdCNq+XYf5MolNY5wtarm8we+wGLU/Uo30GXs=;
 b=Zac3jiPJslXqkoiqQ8vd+0AssOdOZP0oBu+xutKI33pUTwx4soqyFbwgC/M9BxSIJG
 37JAt6rZTkRM/OaKqJAdqu94gIwi3xoDDDEsoskZy9pnvkXlRAxlnER6FhYl+lSb6Wj0
 QD3apSIWtx67Dv9RyTV4PLkryFJ3CHbN9vE8iKFBTHzwIypOo7J0wDv37TQJHte4oxx+
 IfWkRdMYl4ycqHg3p5cr827W07lk0HzEaSEMKmOUN4u6KfRXYlbX8rLn5nTtkfAYuS0R
 /J1hNPI1kaYBa8JAMj3SScdnGHnQUC4b22716ETWsfMRknuMI9CoXF662yYjDLxJWj8y
 Ok6g==
X-Gm-Message-State: AOJu0YymRmPhf95rItezP3sNdSuyyJTlhh/lfLAUyL6izz1Ym5/vo/Wn
 RzXIZIBoflJvP4Bkrso7Tp5zYZXW/XgYqjF3EjpXAnJ0XD9C2326EjvBJvPqGFqgp7TadguoRUy
 Yitr8Wy+EVap+eY8JeUHyb8FV0eLkLB21JNnaxDWE6nISZ2V2+KWTO2ACpPQyAroBaMs=
X-Gm-Gg: ASbGnctsRlwIxLTQz8t6Pi/bjj52jdd0/E3llCvGojUhqd7l583WlNGvi4KjfRLrJql
 RZzhmqz6Ajc4kz8LoQ0Zy6gq5QccNkfSGrI0H9U6VXSAf0/t3FdFbECF5V44P9RUEZ7xkQPBFMG
 R12R+d2Us/u2l+qB0LRl7zqh14LRflWAb97kQXOu3GUeRRr9JlDXZ2/WxZt67YIyecsOZfhfCwY
 nMvsL3QzWu0Bn42Amne+NLR8D1nJhSrYin9AeuAo1UKoYLqa0KL0eLzzimdIzbbyG3Kor6WNAr/
 4yJ3MYMloeXhmB9xUO9vfGoas5fpEiYoX3pJ4mbrWbBrhgviFm7dMQ==
X-Received: by 2002:a05:6a00:c8a:b0:777:73a6:edb8 with SMTP id
 d2e1a72fcca58-77bf946a71fmr7729922b3a.28.1758209261631; 
 Thu, 18 Sep 2025 08:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPrewjkJEVcx0CmqaQ3CPnYY7zszhI34lUBw08Tj+e8d1e9KQBArDqPgWLUGcox1f3xefEIQ==
X-Received: by 2002:a05:6a00:c8a:b0:777:73a6:edb8 with SMTP id
 d2e1a72fcca58-77bf946a71fmr7729900b3a.28.1758209261227; 
 Thu, 18 Sep 2025 08:27:41 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:27:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:44 +0530
Subject: [PATCH v14 27/27] backends/tpm: Propagate vTPM error on migration
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-27-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6741; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xJOfJwiqBhYlRBnodOx/pfgX2IXLy1xjBTSVIQV4ib8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5Z9pssaZqldCs1l52E02LjuQfmjZn+qkwiW7uf3sF
 mjYMPJ1lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMizUIZ/th2c6Sne67SbOGQy
 auZ++nauTiWbPfsUh+s8dbvwZ18aGP67PJXavCju9cvjN7c6eup+mj39yoyv6WYTVjS3V4bP3C/
 ADgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

- When migration of a VM with encrypted vTPM fails on the
  destination host, (e.g., due to a mismatch in secret values),
  the error message displayed on the source host is generic and unhelpful.
- For example, a typical error looks like this:
  "operation failed: job 'migration out' failed: Sibling indicated error 1.
  operation failed: job 'migration in' failed: load of migration failed:
  Input/output error"
- Such generic errors are logged using error_report(), which prints to
  the console/monitor but does not make the detailed error accessible via
  the QMP query-migrate command.
- This change, along with the set of changes of passing errp Error object
  to the VM state loading functions, help in addressing the issue.
  We use the post_load_errp hook of VMStateDescription to propagate errors
  by setting Error **errp objects in case of failure in the TPM backend.
- It can then be retrieved using QMP command:
  {"execute" : "query-migrate"}

Buglink: https://issues.redhat.com/browse/RHEL-82826

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 backends/tpm/tpm_emulator.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..dacfca5ab7eb0445ddc1ced97513068501b468bf 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
 static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
                                        uint32_t type,
                                        TPMSizedBuffer *tsb,
-                                       uint32_t flags)
+                                       uint32_t flags,
+                                       Error **errp)
 {
     ssize_t n;
     ptm_setstate pss;
@@ -838,17 +839,18 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
                              offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
-        error_report("tpm-emulator: could not set state blob type %d : %s",
-                     type, strerror(errno));
+        error_setg_errno(errp, errno,
+                         "tpm-emulator: could not set state blob type %d",
+                         type);
         return -1;
     }
 
     /* now the body */
     n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->size);
     if (n != tsb->size) {
-        error_report("tpm-emulator: Writing the stateblob (type %d) "
-                     "failed; could not write %u bytes, but only %zd",
-                     type, tsb->size, n);
+        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) "
+                   "failed; could not write %u bytes, but only %zd",
+                   type, tsb->size, n);
         return -1;
     }
 
@@ -856,17 +858,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
                              (uint8_t *)&pss, sizeof(pss.u.resp));
     if (n != sizeof(pss.u.resp)) {
-        error_report("tpm-emulator: Reading response from writing stateblob "
-                     "(type %d) failed; expected %zu bytes, got %zd", type,
-                     sizeof(pss.u.resp), n);
+        error_setg(errp, "tpm-emulator: Reading response from writing "
+                   "stateblob (type %d) failed; expected %zu bytes, "
+                   "got %zd", type, sizeof(pss.u.resp), n);
         return -1;
     }
 
     tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
     if (tpm_result != 0) {
-        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
-                     "with a TPM error 0x%x %s", type, tpm_result,
-                     tpm_emulator_strerror(tpm_result));
+        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) "
+                   "failed with a TPM error 0x%x %s", type, tpm_result,
+                   tpm_emulator_strerror(tpm_result));
         return -1;
     }
 
@@ -880,7 +882,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
  *
  * Returns a negative errno code in case of error.
  */
-static int tpm_emulator_set_state_blobs(TPMBackend *tb)
+static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
@@ -894,13 +896,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
 
     if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
                                     &state_blobs->permanent,
-                                    state_blobs->permanent_flags) < 0 ||
+                                    state_blobs->permanent_flags, errp) < 0 ||
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
                                     &state_blobs->volatil,
-                                    state_blobs->volatil_flags) < 0 ||
+                                    state_blobs->volatil_flags, errp) < 0 ||
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
                                     &state_blobs->savestate,
-                                    state_blobs->savestate_flags) < 0) {
+                                    state_blobs->savestate_flags, errp) < 0) {
         return -EIO;
     }
 
@@ -948,12 +950,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
  *
  * Returns negative errno codes in case of error.
  */
-static int tpm_emulator_post_load(void *opaque, int version_id)
+static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
 {
     TPMBackend *tb = opaque;
     int ret;
 
-    ret = tpm_emulator_set_state_blobs(tb);
+    ret = tpm_emulator_set_state_blobs(tb, errp);
     if (ret < 0) {
         return ret;
     }
@@ -969,7 +971,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
     .name = "tpm-emulator",
     .version_id = 0,
     .pre_save = tpm_emulator_pre_save,
-    .post_load = tpm_emulator_post_load,
+    .post_load_errp = tpm_emulator_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
         VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),

-- 
2.51.0


