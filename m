Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B55C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2iN-0001Fa-Si; Tue, 24 Jun 2025 08:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2iE-0001EV-9b
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2i4-00024j-5t
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750767907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoc2stLSbgQCmRzc5fPnLLeyQg1hKs3E5ePRLF2ciVs=;
 b=eFs59hD9wo5N0XwnqpBeRNcRCI3J/c1YU+ueMaaHKIa0fDLQgY/Du8yIhE9essh49pzdff
 icpiiZEv2fy4GnNYwLxjncqdO1dd686KwfpRz54bR5ZhtepKPjMYakTRsm3FvoohPcBbT7
 JS78mIVy/7ZZu2DtnjKdCQIRddbC+pQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-xSZ9A43mPgyMw3a1VFddgg-1; Tue, 24 Jun 2025 08:23:57 -0400
X-MC-Unique: xSZ9A43mPgyMw3a1VFddgg-1
X-Mimecast-MFC-AGG-ID: xSZ9A43mPgyMw3a1VFddgg_1750767837
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-74928291bc3so368327b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 05:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750767837; x=1751372637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoc2stLSbgQCmRzc5fPnLLeyQg1hKs3E5ePRLF2ciVs=;
 b=B7Yo3xlQISPisxG1Wlhs2uA3aJx6sJZZTdoxQPiOBoKVLZng0LR5iLncL0vZtZ7dLK
 vsl/bOuWtlPeiC8mDsqtNdvXyR2pmVlqacPg2AzeIHL4Y4tPcowLiyMXEeCXZmcxm60t
 kzJjw5fAD/ANAXuw+GD2nbZZwk5bAuXNxTuKNuc7HQaAMmvNCgDtgicV2ZncAc537JRa
 g0JjvqONwoHFJoQyiyaZt2CjUW/PFav+qCCUSx+BHGb1qC5ra88bdzQK2HGVz0/375hb
 0L//BdcfB1qoAUZpkp8lENb/k86o7Lh9OxEU5qY3VMOOcdot5ZPmS7TlETjvqeNAEGho
 8HiA==
X-Gm-Message-State: AOJu0Ywo0Y7STBlgNaNkexxieao89eQZmLlYcp6+ke8Ie860sGTVVySl
 G7Y5+VHJXhBXJMQjvIWVjfqXKOSL7KGQ8d+wYNDf1Soz1YU/jDh2wOW42KJ65j8Gmut4JU/eFXE
 xCu09Cyi9+5qTJHQ2VHn5B+NBXzKTsPotWbJhaohJCdJH2KQwL3Kc3HQ7
X-Gm-Gg: ASbGncvebaJKJr4NngxKfNx+ZqM+QE9tZs/bnbS8FJ2uD3JMbrtnSO7XsGMYgzD4Hca
 SeapyeIukxbdp3ck3p/m34CwmWJ73oD/Jsf3Minb8e8i+32HwXmFzlVq4H9NSU28F1+NmP9PzPM
 5x0x8zGlIAovMe7cBjP78gEh89FNLrMWpxmFFyv+WeBQ7He+69sQusU9R2S2ymcSD13RkdPka3e
 ts9jTSpR2JjnlNCJEcd4fa+aa0DjmuZrM4KP+5/azZC2mcTlxYyUWKNeKqBF2Newi4rcZP92rTw
 0igzjsB8j4QHkhz8SqrePNaCJ9jICHatMKNE
X-Received: by 2002:a05:6a00:9286:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-7490d4e3682mr29561878b3a.3.1750767836611; 
 Tue, 24 Jun 2025 05:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPNFHFUhpcOXLawA2l46Tc2qAXpBXE+OQ9q5ueQCGthtKIbjmIicecIxH+ovfxGqpnw920Vw==
X-Received: by 2002:a05:6a00:9286:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-7490d4e3682mr29561841b3a.3.1750767836236; 
 Tue, 24 Jun 2025 05:23:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c882cc5fsm1772091b3a.73.2025.06.24.05.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 05:23:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 24 Jun 2025 17:53:06 +0530
Subject: [PATCH 3/3] backends/tpm: Propagate vTPM error on migration
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
In-Reply-To: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7179; i=armenon@redhat.com;
 h=from:subject:message-id; bh=YNrXSvCavElITFnWdq5E9/4r4fGkc3Vuvin2J1tR5nc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bUjH3TxCPXnPQSN7/69dx+prt3HxaXbWj2CVp2LmNaW
 lTSptxHHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACbSO5GR4fZcw6Q55rrv8n9a
 3z++zGbvw+nOq8M3Xzh3/se6f2rCk28z/C9asbL53nK7t7cbZKOz3vVcbnfRO300YTNbr6bNikt
 hJzkA
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

- Introduce a new post_load_with_error() hook that will
  take in the Error object as a parameter.
- This error object is set if the loading of state fails.
- The error can then be retrieved using QMP command
  {"execute" : "query-migrate"}

Buglink: https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
 include/migration/vmstate.h |  1 +
 migration/vmstate.c         |  4 +++-
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928d160595b17be810 100644
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
@@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
                              offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
-        error_report("tpm-emulator: could not set state blob type %d : %s",
-                     type, strerror(errno));
+        error_setg(errp, "tpm-emulator: could not set state blob type %d : %s",
+                   type, strerror(errno));
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
 
@@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
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
 
@@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
  *
  * Returns a negative errno code in case of error.
  */
-static int tpm_emulator_set_state_blobs(TPMBackend *tb)
+static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
@@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
 
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
 
@@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
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
@@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
     .name = "tpm-emulator",
     .version_id = 0,
     .pre_save = tpm_emulator_pre_save,
-    .post_load = tpm_emulator_post_load,
+    .post_load_with_error = tpm_emulator_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
         VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -207,6 +207,7 @@ struct VMStateDescription {
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
+    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 3f8c3d3c1dcfe14d70bab1f43b827244eb4bb385..c5dfffd9bad7285e819d4769e055d47157caab34 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -232,7 +232,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_with_error) {
+        ret = vmsd->post_load_with_error(opaque, version_id, errp);
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);

-- 
2.49.0


