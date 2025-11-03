Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44771CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lw-00014s-86; Mon, 03 Nov 2025 16:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ls-00013u-1e
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lf-0005Ot-CT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Dk1DITRQRzye86bCpuNco4jugI9gDovq529oeA29qI=;
 b=jJ1w/OEg0O1LgAU9bJWhnkTo9HBOTsQDk0nhgNa92e+ZXNz4gPjhQrgNRco1uU24MRezd4
 XLe3bSnCNqr24Bf2V7AjYXReDsuYhpEwsN5LCbZhtQZFPIA2xKO3lUQEpj0P+UaDfT7tPv
 RueVLf+LsRQewB7W+cYdyZxYuKTnp+o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-EKMU21vSOLSiEZ-UjE82pA-1; Mon, 03 Nov 2025 16:07:04 -0500
X-MC-Unique: EKMU21vSOLSiEZ-UjE82pA-1
X-Mimecast-MFC-AGG-ID: EKMU21vSOLSiEZ-UjE82pA_1762204024
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4eceefa36d0so135200701cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204024; x=1762808824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Dk1DITRQRzye86bCpuNco4jugI9gDovq529oeA29qI=;
 b=Vrn4WxRVX8YaXmRN79w0oNNbbK8fwmUsizUNNxKdYaeMt1awxxfy8VKWIm+aDXH/OB
 nk17aYHkTn2E67XXV/qc5JavjoEUWe1cBOEi6bYvvRWT6md9SQo8AckbF8liYmKsRciZ
 9HuhCUdixcGr9a7Q2MhTCJVEO2JYZAJkliOWj9tTrlTVH4CWNTsGd30jZdDEio2txrgS
 h/6UlBQShQJpqUXmkMUdYeDT5uuiClTAIVvmQVYDytLjpEBUe3bYAws105LhD4AhY1u+
 YZABYEkT5MyH+NN7Kn6++gaeS6/U+TRBBySBzSPLrqyOpTNL2KRyyiQh3x4or69SD7b0
 NXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204024; x=1762808824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Dk1DITRQRzye86bCpuNco4jugI9gDovq529oeA29qI=;
 b=objC1Dj4QPH0S+zo5sZUqvuGTC76SV0N9aWLJB8MwzSEr8/HOcykA/K0D5TeozHKCv
 KUUO12LdrY3NyZZarI+gpYLVm7cSMnTIHtVJHlCRpxOLukhv1g3TmG83ISavt2KcMjXL
 zSqET9Q4UU/dmRVcVlsvumPaIuRGNn3CM+xqx/Dg0TX6lqNzraRxLtImrj22djXmivz0
 xg+npgomS5/sGal1JfRlQSxFFcXN+03bMgb7pzskZCf4OSVgpQRqgDq0SR83aiw1fyV1
 X8063OwaBRyBHPKxdp26Vm8Aw47Cug6j/djYLUlC5r5OOGA5HOHeF2dKLhIauz7CVRVl
 0BFQ==
X-Gm-Message-State: AOJu0YzqRZ4J90DDLwz/T+oWJ6VXH2n15OXyFwHRNLbkAQONTeGuD1VA
 8piGvRMiZ6W5loz/cDaWqqrMgU0BIdb+zcv736CyTDX0sNdV7qhxOUAqLc0VQIuCJn0FZM3fFRt
 NnwUcwBCCxfnhNhG0MUmdKbop9WEESLObTYrTLUEUs61p5DHxKSbg9HH1D1fJyDJ4ODJLgeQwlY
 ibszsJ2Tuu1vtp4xP1WhTM6tvqUSrtCRevAwOOmA==
X-Gm-Gg: ASbGncuvFquywzxYHqnzVPlxNHXaeHVNvDmN+ScPFMdA74s+KoBye7QhhflpQAoDH4q
 irHp4zDA8UpYaksOOz/d/PQi2Uf5DQloBjaaM5prJ6l0xoCGtWZluBZSodqo0QmkPc1fAcL10Ov
 Ek+hxx+0Cipdkq+WRCRRs6MYQfEBEuRHh3WmpiiuL/HR8edESLsqugBKgTlbTvi3po5PJFqoN9s
 dT83XOLu6Wp66uq4vKLimtrI8m2N0ueeqVkSS/qgIf+MxhGmVuId6o0TyhN4bsjzAi3fV1l9cde
 J+CVS789CnnvJdN7j/kT2B5G3d2b0ydvrHJyVHmbUNlBqkii0DNM0BnrR6EPuY4a
X-Received: by 2002:a05:622a:4c88:b0:4eb:a10c:de05 with SMTP id
 d75a77b69052e-4ed31005ebamr179689471cf.55.1762204023460; 
 Mon, 03 Nov 2025 13:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLkpKbIsVo2kSdk/N/t8wx1OQueKE/2tB7hVkyJQ7ZePFoV4G2zqmYFYMnDLTuTyc5rsINEw==
X-Received: by 2002:a05:622a:4c88:b0:4eb:a10c:de05 with SMTP id
 d75a77b69052e-4ed31005ebamr179688761cf.55.1762204022842; 
 Mon, 03 Nov 2025 13:07:02 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 24/36] tmp_emulator: improve and fix use of errp
Date: Mon,  3 Nov 2025 16:06:13 -0500
Message-ID: <20251103210625.3689448-25-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

tpm_emulator_post_load() and tpm_emulator_set_state_blobs() has
error paths, where they return negative value, but do not set
errp.

To fix that, we also have to convert several other functions to
set errp instead of error_reporting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251028130738.29037-3-vsementsov@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f32b67dac7..da9c1056ed 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -308,22 +308,22 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
     return 0;
 }
 
-static int tpm_emulator_stop_tpm(TPMBackend *tb)
+static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_res res;
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not stop TPM: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
+                   strerror(errno));
         return -1;
     }
 
     res = be32_to_cpu(res);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
-                     tpm_emulator_strerror(res));
+        error_setg(errp, "tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
+                   tpm_emulator_strerror(res));
         return -1;
     }
 
@@ -362,12 +362,13 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
 
 static int tpm_emulator_set_buffer_size(TPMBackend *tb,
                                         size_t wanted_size,
-                                        size_t *actual_size)
+                                        size_t *actual_size,
+                                        Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_setbuffersize psbs;
 
-    if (tpm_emulator_stop_tpm(tb) < 0) {
+    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         return -1;
     }
 
@@ -376,16 +377,17 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
                              sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
                              sizeof(psbs.u.resp)) < 0) {
-        error_report("tpm-emulator: Could not set buffer size: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
+                   strerror(errno));
         return -1;
     }
 
     psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
     if (psbs.u.resp.tpm_result != 0) {
-        error_report("tpm-emulator: TPM result for set buffer size : 0x%x %s",
-                     psbs.u.resp.tpm_result,
-                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
+        error_setg(errp,
+                   "tpm-emulator: TPM result for set buffer size : 0x%x %s",
+                   psbs.u.resp.tpm_result,
+                   tpm_emulator_strerror(psbs.u.resp.tpm_result));
         return -1;
     }
 
@@ -402,7 +404,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 }
 
 static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
-                                     bool is_resume)
+                                           bool is_resume, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_init init = {
@@ -413,7 +415,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     trace_tpm_emulator_startup_tpm_resume(is_resume, buffersize);
 
     if (buffersize != 0 &&
-        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
+        tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp) < 0) {
         goto err_exit;
     }
 
@@ -424,15 +426,15 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
-        error_report("tpm-emulator: could not send INIT: %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: could not send INIT: %s",
+                   strerror(errno));
         goto err_exit;
     }
 
     res = be32_to_cpu(init.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
-                     tpm_emulator_strerror(res));
+        error_setg(errp, "tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
+                   tpm_emulator_strerror(res));
         goto err_exit;
     }
     return 0;
@@ -441,18 +443,31 @@ err_exit:
     return -1;
 }
 
-static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+static int do_tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize,
+                                       Error **errp)
 {
     /* TPM startup will be done from post_load hook */
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         if (buffersize != 0) {
-            return tpm_emulator_set_buffer_size(tb, buffersize, NULL);
+            return tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp);
         }
 
         return 0;
     }
 
-    return tpm_emulator_startup_tpm_resume(tb, buffersize, false);
+    return tpm_emulator_startup_tpm_resume(tb, buffersize, false, errp);
+}
+
+static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
+{
+    Error *local_err = NULL;
+    int ret = do_tpm_emulator_startup_tpm(tb, buffersize, &local_err);
+
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
+    return ret;
 }
 
 static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
@@ -546,7 +561,7 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 {
     size_t actual_size;
 
-    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
+    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {
         return 4096;
     }
 
@@ -889,7 +904,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 
     trace_tpm_emulator_set_state_blobs();
 
-    if (tpm_emulator_stop_tpm(tb) < 0) {
+    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
         return -EIO;
     }
@@ -960,7 +975,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
         return ret;
     }
 
-    if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
+    if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {
         return -EIO;
     }
 
-- 
2.50.1


