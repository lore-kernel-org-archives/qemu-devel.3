Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC8C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjN-0001Nt-Px; Wed, 16 Jul 2025 20:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgX-0004Wv-NP
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgV-0005AF-NO
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEs+SYEqguJhCLdS7tcStaLYAZWgg+YbHnf/8bmXUUI=;
 b=jIz5oCm+SAuesjwgwqthTA1eNVUkBySgd6tMZXqxy9vL7lYqGoOzhdL0mZyG9l5TEuT87r
 gcTd8j1Dl3MyMvbZm/ylw1iRGANOR2uwHjaOsI6UpbqSZJDH0BjdPdDodLjO7EJrDJXzF8
 GVUgs84t8/O6HCAYaF4X+DFPiM48Y6g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-aw4Gwfa0MBSudX-6eIUzuA-1; Wed, 16 Jul 2025 20:41:13 -0400
X-MC-Unique: aw4Gwfa0MBSudX-6eIUzuA-1
X-Mimecast-MFC-AGG-ID: aw4Gwfa0MBSudX-6eIUzuA_1752712872
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so583917a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712872; x=1753317672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEs+SYEqguJhCLdS7tcStaLYAZWgg+YbHnf/8bmXUUI=;
 b=Hu2GI/kca5lj3j0C8vJ5iGNVvqJX/vxhzvVrMAyc37huvJ9WJ0xt9EQ/EytUMteLll
 F3nWNt0U0eE1CSe2oV5GVWeUQkE6h90ATuN3zCmKwvFVVoZpAaRmHE3jK4ujkl1dWnuV
 ZkM/xYdf7hDNL5Zjb+NCg1CVUAI6jLSl9jbzWNEb70FOOPOGLYhjyX1Etk8Z71UgLq/h
 BhwdWWgNM+F9fE97cV+9k2Cq90jwPITe6Po1X7AbDbcnsd7QHwPeu59PsBwrE3s+KDt+
 rHcDgZivUg3I5LvkU2reBHwoD7NgkJ/XBszzV/xNmBOJH+ewdkwb8r/3YDPJsoPFxPOB
 8s1A==
X-Gm-Message-State: AOJu0YwqkrBq0Amv3pEEwHkvDFhOjthFFoXQHoeK+wlZuKZ8UB0uoPvc
 HZYopko6v7ySyoeDixrP5gpsQJe+s7rwtSX+/rPaAF3ydNc/QrxUSrHfU+QSdSRjWhYWUpcKXGx
 BHIwVe1dDxcg+b2WMdbRIBZqSMMbZ/b0a6wp+k9VTQsUPmtgd+hLQOqQ7
X-Gm-Gg: ASbGnctKfPwAhPns6omGCDbjZchF4vmGgsVNsNEIm7E15dbheVzE7eFI2grTxNzV/gx
 IFK8EFVp4g7SfW9dokqeWnEPpxTiF12FPzoHkHeDZa0SvEaSbNP/2I597u+UkWs9KY0fR6qwIYo
 E6Vvb5pAWzu9NrxC/9nqyLGYZjUKwvp7os6ZmsIHHKAByYMxGXY5e0eFHXUNeNrGcEIODFGx4vH
 Eqq7gmZfGQnpb1IACwwncpmolwyJZPy4iYBbqXSMw0/r7OB1bN0V6RiOr0YV3zmJ8ZlN3u1LQS9
 sG43n+6JTHZLoapgUd6H2NCFZLVg8mg1ckCpTMYqGOTylfs405rP
X-Received: by 2002:a17:90b:224c:b0:31c:260e:55e9 with SMTP id
 98e67ed59e1d1-31c9f436cf9mr6313680a91.24.1752712872352; 
 Wed, 16 Jul 2025 17:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgUUIp3ZmguDOviQyWF8/f00ioJN9lGXgjxSNoA/VLA0y0puO6gVpdDTTyWBDfxZVLwYl2NQ==
X-Received: by 2002:a17:90b:224c:b0:31c:260e:55e9 with SMTP id
 98e67ed59e1d1-31c9f436cf9mr6313644a91.24.1752712871944; 
 Wed, 16 Jul 2025 17:41:11 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:38 +0530
Subject: [PATCH v5 15/23] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-15-1f406f88ee65@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=armenon@redhat.com;
 h=from:subject:message-id; bh=n0nXrr3xUpBRd2Vi52rb03R3CXPNiOL199BK7YzW3DE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm+LLRfUazW2Scw+envDowKszzeffhnK9DVYp/tz/9
 Yug8Z3tHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACZyJpfhv5vgzzw/kWrf+D2G
 jeYrp99g+LZWzYDzgkte3ySG6K1OaowMJ99+KnvD5nMihuXbXu8NiR5fG4omTTdea5C4q4nNXlC
 GHwA=
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 20dce4b43a181d2f47b6b22e7a15aa4fc45cac5c..1cbc44a5314043a403d983511066cf137681a18d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2471,32 +2471,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
+        error_setg(errp, "%s: failed to read block name", __func__);
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
+        error_setg(errp, "%s: invalid payload length (%d)", __func__, len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "%s: block '%s' not found", __func__, block_name);
         return -EINVAL;
     }
 
@@ -2635,12 +2638,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.0


