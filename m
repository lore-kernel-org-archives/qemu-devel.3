Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA5CC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU20-00066U-9e; Thu, 31 Jul 2025 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTF8-0004oB-Oy
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTF5-00089u-UU
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlHrG8oxZCrSy622JJbRcSdZ7eDi1KQ0TwRagoGzXjQ=;
 b=QStaCZh/ptXUB7oo4r/wLD1Zfai6ZGVLJFoZaotOHfstJuCnbAEjdBRw5Pq81Wf3vXXd1U
 KRrxYJJqQh4iR8RyP4iOsNz+yWN067W3rTql0sZGmuK0Ibgt4THvr7bsXITbBYg7Yeofzf
 NMJh233ocM/w4avfeVYAVTBf3a+ty2o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-GqHtgLj6NhKXrwzYtlBhqg-1; Thu, 31 Jul 2025 09:22:41 -0400
X-MC-Unique: GqHtgLj6NhKXrwzYtlBhqg-1
X-Mimecast-MFC-AGG-ID: GqHtgLj6NhKXrwzYtlBhqg_1753968160
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3139c0001b5so531423a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968160; x=1754572960;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlHrG8oxZCrSy622JJbRcSdZ7eDi1KQ0TwRagoGzXjQ=;
 b=pHhMdLTb+ugHeL9LApCI/L1rmpbi/b/D9Nq6c1RfrrgiGXocbkGJAC778tErTmMPjH
 S7W8/dF4SsoQGbnMsKWqH3DuwQkyHeLFHd4XO2huuz3LR6L+bCtoEHbZO93ZE4hUrSuA
 RO0Sb4Xu6ehDRIwD9yuRhzIMO7jzSzH4p8Xs3a8Y2/UmsX1dAz/ydHbYCwEbAJX9MnpK
 PUyLD0BNhle0jfINWaMsevHaJYTLxEeOfqRr/pizdRApoWkKNS+qRGnl8BgZPwxjgqxs
 gFZ6D8WOJPv9tc+0P26RCjDHsc3LkhRnSRcwI0qlfcpbgMsTjVLwoTYa0d7KkOerHrlp
 K/0A==
X-Gm-Message-State: AOJu0YzGuM+Ba6qvGnhhIkAox7XqlWguoOCW6gHZiCBxp9urfUTbKs+Y
 4+r5bIMr9AyyBGglFFBbLRB3iSpCB1zjuxX4fbXqnD0OjdURstgF968yYKUAvYJ1dGgaNGACE+G
 fuCtXs0HUMPKFMgiDvuOpnmXYh9HFAA4DmdSrfUTAze9hHeq7ZcvAvJ3GFld9zKwv2+R4x/AYdG
 +Ww4CjQG4suk9QHbbyJG13Wp13hOljd+QY/P3tIHDqxQ==
X-Gm-Gg: ASbGncuxMlsM7Z8yPl8zvf/pIztOlfAaEG90UowDLIW6iW+o+7b4EyVOSLy3EvjRnHw
 YKtYJ3F+nbfZoaEBABk+JlNyhclyTs4BNHPBpEK0V8OobWw7E7Jbq0u+H7iKrLvt/npX9SgEv5G
 hP+6H8ApjQsV7KTbepPytR3FfxzLmqpGMO6FhjD3UPKIjeoAhAbCeRYn7I2Y+oXsrQFX2MO/xoO
 gZlgflNU05ogW5U9Ycq40IYrUH2RsnzajjyOkTswJ/NPhQtidrzmkcyG5xshv4LMdCRIqCx8bSE
 rn53vBe0r4EfeE0ZjpR+Oa3YE0/9eG9kWADQ5v9w8V1uwa0Ca/u2
X-Received: by 2002:a17:90a:d40f:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-31f5ea4ca16mr11467579a91.27.1753968160039; 
 Thu, 31 Jul 2025 06:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOididryM+uykRBaOc3BpoyDnjn3fRrR7JT6YxNKAi2/Lv+3iT2wY+bmM0OHGi6Cva4FigQ==
X-Received: by 2002:a17:90a:d40f:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-31f5ea4ca16mr11467504a91.27.1753968159472; 
 Thu, 31 Jul 2025 06:22:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:22:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:45 +0530
Subject: [PATCH v8 05/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-5-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4735; i=armenon@redhat.com;
 h=from:subject:message-id; bh=AkqPKFSHbirygOBveuuipoo1wuWUoKioEwj4RyL290c=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37lPmlXyubm/zLjh9Pc9/uuPo1J9/ztrkvPq9/Xlh4
 NwdPssVOkpZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExEy5Hhn7kk7/YF4d/aNM5d
 23ZBW8/dL2Ny6py73WpG27b+Nmy7l8bwPyPzL+s//btRkT8iS6LjX7nveW0c5rI5KLp2Nleb8af
 N3AA=
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 736410be867a29efa24d749528c9bc203a3e8131..59751677c1bb7c893b4ba61cbfe1f55ade6ad598 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2690,8 +2690,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
@@ -2702,8 +2703,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2711,8 +2712,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2721,17 +2721,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2739,7 +2739,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2747,10 +2747,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, NULL);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
+        error_prepend(errp,
+                      "error while loading state for instance 0x%"PRIx32" of"
+                      " device '%s': ", instance_id, idstr);
         return ret;
     }
 
@@ -2761,6 +2762,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Reading footer section of instance "
+                   "0x%"PRIx32" of device '%s' for version_id:'%d' failed",
+                   instance_id, idstr, version_id);
         return -EINVAL;
     }
 
@@ -3063,7 +3067,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
             if (ret < 0) {
                 goto out;
             }

-- 
2.50.0


