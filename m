Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CEEC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHRM-00024I-EH; Fri, 25 Jul 2025 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQY-0008On-5W
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQV-0000VC-4k
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czeOJNePKU1ZKF4JXNbqGvrsqHLnGcs6vKF9Tfla9zQ=;
 b=S6HgesWpuoxD5ZXjgM5TzC0FLnHXmCWx1ymuvBdkfn0N+qEB0g2B7tXNls2iDA8nTb94bQ
 aocu+mYoMe7nVMn0xBmQtCEfP7L6oMtbCALo1vtesFtndZtgA5gYuhsXX7vGoetZDKvdIf
 KYcbmBf1Uwm1rMXfLjaXyRRHrUOdbq0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-bGJQjEu1OgS7h0TM396EDw-1; Fri, 25 Jul 2025 08:21:25 -0400
X-MC-Unique: bGJQjEu1OgS7h0TM396EDw-1
X-Mimecast-MFC-AGG-ID: bGJQjEu1OgS7h0TM396EDw_1753446084
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so1929900a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446084; x=1754050884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czeOJNePKU1ZKF4JXNbqGvrsqHLnGcs6vKF9Tfla9zQ=;
 b=PlEqfuSSTSl9ZE6kyx1maYNU7C9XEDVpUkDyPsP0pcVLYo1Me4GpBfLnVQ8dV7FPRA
 pUAU+GlIv1txw2NvIYhM+gLkX6xxS5l+zQdmTRey9Dhe3Z3EVk9yI1JWuRnB+gg/zCr1
 p7bnWlmOHB2ly63aaB9vx6goIbGpepSBlxc9C0Y26C1Uu0vq/Aeh76MCX57UmCnqRS9h
 N+hHGLL0+yxA6NC/w0KdFgbssBPJKkTbFSVT7RvuM/qkGqKkTalzEt9AAy0WtmkRmJ9I
 DN3+zO+p09N+q7uqkgA0AGmqyc+pM3SOEx7MQZ2G+Vol8Ks537l0ufT8MIiJL16Ho8ZQ
 6COA==
X-Gm-Message-State: AOJu0YwOxGrhK9fLvbahNAcM9Nrz4hnni+t9Evy2fwIHmQKu938q9XeF
 q5s9jdQYRGJ2D1gWEUynATqomfJEo+PKpP9nj+DXLfpGIqtPr2ITROijWT/9PcrO22461U551HU
 AD4iOjwa9URn/fVtQWVkEmK4QSD6Ms7fBdsZEaMaHem3KijqgITlQu4U5
X-Gm-Gg: ASbGncseZqPGOOnVBrqR2/NdhxpSTmSYSOuDykT+CQHWwBVQuiTK1DLQEEBTYkTeGV1
 IngyfFGuekxzokb/hx1VuvE+V4Yf0mmMqxNeISfEpV+oCrYvt/AIh8101ejkSLOHDGQiMOKP5an
 84KVEm40qlqudu8i626b8nLDkDjolurQW+KUCA3eb88I3CDZv8jyyrDHn+8BG8YNzsVWV64vRbi
 l/yEKtUMJ/3d9BwA9jNqd+nEgU7q+RndMdwZImX5JuZoqBbfsVvYOAliJ18rkzlLxwrn6sFn0DM
 Tet/bYvuiIfvdboAC2mV+LA/H+F71927qe694ymJCHDkkIsqu/ZlTw==
X-Received: by 2002:a17:90b:4f83:b0:313:d343:4e09 with SMTP id
 98e67ed59e1d1-31e7783b3cbmr2296783a91.3.1753446083902; 
 Fri, 25 Jul 2025 05:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcIqjNgGdwlSkTHrI4HxcMj7b07Gylavd7XQf0uWgPP27wLJeI4AOQUT8X4j7liqfoy0ai4w==
X-Received: by 2002:a17:90b:4f83:b0:313:d343:4e09 with SMTP id
 98e67ed59e1d1-31e7783b3cbmr2296751a91.3.1753446083434; 
 Fri, 25 Jul 2025 05:21:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:55 +0530
Subject: [PATCH v7 16/24] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-16-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WaU61dfVIcr4ptUcXa4gMHPxNl+bO78GCw5cfQgK1Hk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc5dqSth6vJz72vbb1HmFtDKrnHZvumpXnLlp/gcv
 Tsti8M7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATCR0PyPDDtmrCetYFk67l2CT
 rFcU3bP09UauLWdU17PcOqLlrn6AheF/ftV+nePnFr+xnT1pBxvb3Ouq7DssvM4LWkqoplQGaLz
 mAgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7ecaea90d245627c19722a234b78bc1383368bfd..68e62163f70e1c2abcff74b3a2f7a5d2ed546b22 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2479,32 +2479,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "failed to read block name: %s", block_name);
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "migration stream has error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "invalid payload length (%d)", len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "block '%s' not found", block_name);
         return -EINVAL;
     }
 
@@ -2640,11 +2643,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.0


