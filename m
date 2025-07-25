Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E95C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPD-000422-4T; Fri, 25 Jul 2025 08:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHP0-0003gK-5K
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOy-0008QJ-4o
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsEuW73zVohfNc8BqDHfawADf/ZZJt+lrLuu5ZeHKYM=;
 b=iR9u23bzHU49wI3ihssle7nXK0EEj+8eDLP4vzhKYC7Tnd56wXeq9Grj7eS/Z9vf7/VM6m
 L8UrcPNYpD5sKYOwWh1PT3QclAozasxCePUPZ0LJ2V3MM0pLhKqBWk1XzZKtgrPL7RUZ8j
 XEk4s3wiFmlGqZQE78rGn+zaw9BxMTY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-wfRjYfpPMdOgHGnrzQUdtw-1; Fri, 25 Jul 2025 08:19:47 -0400
X-MC-Unique: wfRjYfpPMdOgHGnrzQUdtw-1
X-Mimecast-MFC-AGG-ID: wfRjYfpPMdOgHGnrzQUdtw_1753445987
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23632fd6248so21521435ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445987; x=1754050787;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsEuW73zVohfNc8BqDHfawADf/ZZJt+lrLuu5ZeHKYM=;
 b=Rw1Vt+/bo9Zc1TpGsUl/VmKBMNR3lFK8eTiREQ/822yUxcSz+Xn2ZyEeWXqe5mCwqr
 kB/Z2dnSpaGdAMh72yEVTOo9nezDrCyLWodj0uxHNN7mHcwCsDXTHU2j7bWMY6LscfWg
 lhPCdV+/8IDbpW+oAMSS472BOhrfwyeG5v1Q8+z2ZbotAW58tDvLkKGQx7qpz13EAvDs
 DI56tuxRISYc+VSfZltbjLTaoLyhIjNSJJIce3NZ28rksmag6L803Kbelp1ZbRIh+Qut
 m9qePPCIxW7cl2pAc91bektlN+EjZE1wgk5wyVRXDOeA72M9suIQ8vNg9RkpFVv/8jLa
 a7/A==
X-Gm-Message-State: AOJu0YyoIyFUAWuj+35TbS66GfEtai8ARD9380JA3ipKWvCsWtjosTbI
 8x5tEXdSfzRbeNwoap8spv/kIH0VPIclSdCTSgmWH3uEamsLesBgU7bcbaWn3WmA/FtB0tiILYF
 /vxBniTeh+xRLhckNE0jk0gvaUD0IzMw3cd0Ra/7mCsEft5QVvcdLpi81
X-Gm-Gg: ASbGncs1YDgw6IyEKiP0Sh9MaL/ix9GEsXY3t/luGqbP2ElkVp8EBGdH84cN6IXTam6
 bYF+KGejruFmtlDWSrQBG2z1z2Nc+SUAzZhmAF47cWgbsu62xKfBA0NdaThIfEtE06ZFZ90+lFM
 U5RSPscj/57Kz2jNtHSQab56OLmAD/tDHMRYYcdW4vJd7I+lF3Sic6hsNM57gGSoOClPH1vNKqx
 87Pst/NNuL5wqh9Lkv6k1DJlZzNQ8y2CaYvh7032i3HfDF8S0Btr9/HW4+crAJOTUDlIlp+RXhf
 XGGIsEXDOeppazW/fTlkVP8pEu34GmohpJO+pIRKRWxO49I3SWMTzg==
X-Received: by 2002:a17:903:240d:b0:235:91a:2c with SMTP id
 d9443c01a7336-23fb30f2bd1mr25260595ad.42.1753445986494; 
 Fri, 25 Jul 2025 05:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHUSpjSLLT/8fDDI0w/yuUn0ZGCttdjzpKgHDv1khcXLxPkkTHZa2SLdMFew7lYMIvbEK86A==
X-Received: by 2002:a17:903:240d:b0:235:91a:2c with SMTP id
 d9443c01a7336-23fb30f2bd1mr25259775ad.42.1753445985921; 
 Fri, 25 Jul 2025 05:19:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:44 +0530
Subject: [PATCH v7 05/24] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-5-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4682; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Sy2lJgo11rDc7boispc7WTy/Vt3g+o+Uc3avHFYJy38=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmXa/9JecVRd5FnBFqO69dc9rS5WmuJ+8VEWLc66ic
 OCJSYc6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOSiD8M/S4EpalKv2Of8tYu8
 t99h+xUjCTmOJR6BclukZ7yMKDRgYPgf8ibynZN33wnXfpXLmjcjLtzh9HF/8X/1q9pjHsVBV6p
 4AQ==
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
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 736410be867a29efa24d749528c9bc203a3e8131..29d2947eed79432f7bd9224743549aad87d177b9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2690,7 +2690,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
@@ -2702,8 +2702,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2711,8 +2711,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2721,17 +2720,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2739,7 +2738,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2747,10 +2746,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
 
@@ -2761,6 +2761,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Reading footer section of instance "
+                   "0x%"PRIx32" of device '%s' for version_id:'%d' failed",
+                   instance_id, idstr, version_id);
         return -EINVAL;
     }
 
@@ -3063,7 +3066,7 @@ retry:
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


