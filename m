Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E7AC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjJ-00016I-5A; Wed, 16 Jul 2025 20:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChd-0006FB-Pg
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCha-0005Ns-KF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VB7ywUEVqmA3oghObQBPFE3seKY/3Bw1DaxOoNhDBBY=;
 b=Q48hJrhfsqC1fcPTe0qIsVe2YwgPKzChvXrUycQBv/1xYFUvdUIotZmN5/K2UEc6jLRp7b
 Wld7XAljX6k7F+t6QRoe6CWSLie8N4NEpznG2aVQbJhTHHFHy3KrIaC1IYCod1f+I9XEz7
 KTpXMl05r3OSdqm8t5qSKSz47nuFc/o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-KWessoE2M-imOOAQgtA3jg-1; Wed, 16 Jul 2025 20:42:20 -0400
X-MC-Unique: KWessoE2M-imOOAQgtA3jg-1
X-Mimecast-MFC-AGG-ID: KWessoE2M-imOOAQgtA3jg_1752712939
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-312df02acf5so1484354a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712939; x=1753317739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VB7ywUEVqmA3oghObQBPFE3seKY/3Bw1DaxOoNhDBBY=;
 b=NdxX0keu1+pQznsGnD994QPt1r+zI7SRpJ1cV4jO+SouqzF8UKaDoQuPblsOHBihIG
 iPwK0NwqOjSfIrU9Um6As39HRpnn0iFPUYQtNA0pYwc/Xg6ePiQo5M21sRiwkLWFocR9
 zCTZ/i6cVC8ygYumQvfZGVsRPAxw+uf5zJCCR/w3pU3FdI5bPZeXdAHIAMih8R/g4gQV
 B8fJGI+sZ7exaVPM4wzkxVFdfqp6UMmoZHPHqL+S0UJEZlP1/MsnrkJFTy6D/v16GLSf
 ttQqxt7eHD+aMAqsvbN6U3QkiO4f0TiLISak7PqaM79UmOFAAHyT3RuuzWiMiWxS0gpu
 xd7g==
X-Gm-Message-State: AOJu0Yy4SW5g1/sX7gWCHbSPleZL2Q3nbbyMrEzvkqVE9my3bZn9EYkc
 ZaHQHd3jvxWTOhsO4qvqTtdB1KlAARgkCRyeUwbCbzsXv4VP6fzBBMTWc3AY/N+nri0lGBjN2T4
 rbGZ7Zv/z8YjwqA7DOPY/5Au1FjdgoOJ6FaGWh1kyH1JfFLxycTLWktuS
X-Gm-Gg: ASbGncs4iMOVpjfiEiq7uyemXqBLMvdPb5UYgp2VPvuQz+9NQsJ8cMF+tBUhADEHVES
 CbO+p6I3LMRBB5ItW74xasIMw0i/+MM+8Vr8/6lfB0Pqn7JNDEj/jgJhT56UqUGqJk//TmAj4Mk
 cMVralOEwlSK+yr5efDlmj0J1I65rFc4nwzat/yBk3tbDmQUWwwU+LJycJYggr41biHejXeEtRt
 wI8iTjgHdk4nddKDAL2SaeQZkYuLFXSVW/ItvvuKErhia48PMhvdPBimTmO5IZbC/vYRUoBm385
 pAA9gDm4BWFVwQBwfrmxC++AoLwMfKIPafK6EDrNYFTC35pIGipb
X-Received: by 2002:a17:90b:3f4b:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-31cae9730f0mr1913274a91.3.1752712938841; 
 Wed, 16 Jul 2025 17:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TNhsBLt9chwXzoKyo14UNr2QnhkN/YbcStFKqM2RoBmVQtYWkXJFkkUMTgTG652d0vqxig==
X-Received: by 2002:a17:90b:3f4b:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-31cae9730f0mr1913232a91.3.1752712938256; 
 Wed, 16 Jul 2025 17:42:18 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:42:17 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:46 +0530
Subject: [PATCH v5 23/23] backends/tpm: Propagate vTPM error on migration
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-23-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6614; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lhIHMpU0qkadz4azlKtjxrgPGcXYLFkklrIa1moEZ6E=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm/L5O+fLtpds9ty69n3KmQD3pa+0xQPmb6hhVT8x5
 //qPV/cOkpZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExklywjw3zdyvnX12xInf3G
 Tmfr+XV3nj1wfxL/ff861z0LWG/dWLyXkWH+yYqblx+XHryr3C61ZNa8lvXTLk/aq1Lwa9OqwgX
 HYztZAQ==
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..9bf5927e8e1542cf2e4f2275783d32853d5f1473 100644
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
+    .post_load_errp = tpm_emulator_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
         VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),

-- 
2.50.0


