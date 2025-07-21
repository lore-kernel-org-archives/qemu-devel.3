Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4FCC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udonk-0002O5-Ch; Mon, 21 Jul 2025 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoka-0002Io-Ib
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokJ-00016e-JH
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUM5772vsSX7ZjZ2vpHNCeAj3DyDYNqqKnzF3WiJt+E=;
 b=InBj11VdR3FIpvLsGiv4KjSu752xtbu69udd2Rj0TykNM2U6BwUuqQqE1ROWJLH2lOdrNe
 Qx9THQ2aymbQBytFNuJMlc2KxzmGQM6lgt6jD+KBeWnBeIwNFC1VqA0sHDlDH+w6EKjaFJ
 jNqan7vTk9oGRmtWruP6h4bz7CJWTeE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-YVf3gezyMGqpjhFT27rhew-1; Mon, 21 Jul 2025 07:31:49 -0400
X-MC-Unique: YVf3gezyMGqpjhFT27rhew-1
X-Mimecast-MFC-AGG-ID: YVf3gezyMGqpjhFT27rhew_1753097508
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b2c36d3f884so2842660a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097508; x=1753702308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUM5772vsSX7ZjZ2vpHNCeAj3DyDYNqqKnzF3WiJt+E=;
 b=kPuW4j5xjYj4w1dToOrhMyFRB6G4iQluWNFYMLNqjrH1CZHY4oas2wazetus2fdzPu
 ZGUZw0y3VO5KraaMY+DfQ5VRGG5/HaTJDjgVzrfBUaPGFZDkH9HKO6lJ5QjfbpZwSVJw
 xpfwubcl4alax+Rq+J55lsSMaGexqaD4v2Pr5/Go91qoEKxKVIKPP6HgHonzE+t5UVcZ
 1vneRB/bhae1qXF1vjsNNoQnRCWRrBo1g1r4eYU6Mqi/yQS1o4qSOu80VbBu9zgur5N5
 950nWSQZljYtUueAQoBdO4apvY1al3QzTU0z0THxW+qTW3Cd2Pcm4SUCY0ClIeOH3n71
 IGIw==
X-Gm-Message-State: AOJu0YyW1utRd3f7cZvjPTl/Tgg/M4Z9v1RshzF5AiBOFH33veKC6Jka
 CHu9mPRyzZksAAVqah8SA7ezRRaky72PvFxTguWr19PFbrg3c+oI5VpZ1rZsGqBoCGTWSqz9wtB
 +Vaz4OM3+/1q2ULGgDRZ9Ol5nA7oVelC1ozw6toYtqPoYK8H9GECyTytQ
X-Gm-Gg: ASbGncuiruMf5qgEdutaZZF0kEIQrFQk72NXorzi6MgI5H7yhLk9umX+5GJgLJk6PSf
 vEhHfGaC1ltKAGMQrexSIB06g54YFhZduYgDvsm50wnBL44mBGpvNgVeSZv8kI1EKsxRBuEfiSv
 mt/pR7rSI3ockJPZFxgCT+I8o8kgfTFoKhNqHz15cT92O/p9PzhrAc5SqjP9md7HnzzmlP+gHmj
 EU8oNwMQriqJ+yfByZBLUTxoqSBK4IvyUYqq3Vf7Y7uwmQMsUlMjF21bt62Zi0GMRPoMYarmX74
 6A/CUUFUnzCQrfx7niUSKJdmIK+cI0oOeRH98yTTDH7la3REy44i
X-Received: by 2002:a17:90b:1c07:b0:311:e8cc:4264 with SMTP id
 98e67ed59e1d1-31c9f3decd2mr29032432a91.12.1753097508198; 
 Mon, 21 Jul 2025 04:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96STyelzBY9GN63m0qhdEKzTf4w8TyLJDxbiQOU3O4q8y3Pqr2wHfv5huvIZRbpsEhlnWNg==
X-Received: by 2002:a17:90b:1c07:b0:311:e8cc:4264 with SMTP id
 98e67ed59e1d1-31c9f3decd2mr29032395a91.12.1753097507778; 
 Mon, 21 Jul 2025 04:31:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:21 +0530
Subject: [PATCH v6 16/24] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-16-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BrfP4AuOJ2araX/go8A+EVA+UVEeb9rKZaVrCGv3cus=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyiR+w7S6h+8rT3Iq3HCemM5i+vxMifC7DSpfGpfWN
 Wb+MwjuKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJFrXgz/FNzSnk6sXaam/YCn
 WGWiZwpL8ZT4Ns0yTr5wlRDveZknGBmabGOX9FY/sPC/0PyV4bknc2j+7afuGmKXVr4W3Bu6OJw
 ZAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 migration/savevm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6887877f2f8648f66e34bdb1cc3ca6dc7514f9df..011f4032d582e64b112313e783e0cbf98822292d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2477,32 +2477,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
 
@@ -2637,12 +2640,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


