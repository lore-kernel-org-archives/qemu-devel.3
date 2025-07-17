Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFCDC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCgO-0004Ci-Ix; Wed, 16 Jul 2025 20:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfE-0003RD-4I
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfB-0004gF-2B
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NaJ33VLcp+2puFTtiMY5RAuJghTMc3oNGQhBs/78XM=;
 b=O35Xm0XEsintjuAQkZaABDhDfMPMJUPkSrrtDn9Mj5UUjJig/zGmr3HIHLaJqdwLFM6bwP
 2nGnmVkdqzqTZRXGqq+/0eP5QgfG34IpPvTj4gKWejde1FUztaCw64Q9gUzMcC7jNKXCUm
 1rDTsmpb/SX9zpKcslkHNIoEYgL4r28=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-6jut5YLdMuScwaOojOJoNQ-1; Wed, 16 Jul 2025 20:39:51 -0400
X-MC-Unique: 6jut5YLdMuScwaOojOJoNQ-1
X-Mimecast-MFC-AGG-ID: 6jut5YLdMuScwaOojOJoNQ_1752712790
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311e7337f26so453244a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712790; x=1753317590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NaJ33VLcp+2puFTtiMY5RAuJghTMc3oNGQhBs/78XM=;
 b=RVMQBgS5hmV/bnkn7fBMDDETDOffhtf0pxYDsLqz4NIGflqwR5fMEdzCykmKIPgrgt
 dv/eYCTQ3pWDr5Z62TkI1xX/dqTOJrb5cH1OG2JtDpt41NhLqLXF/2FQ7fRHK3a81sAw
 AewZJOw3diJw9sDgnIgNLPMC/uQrhb561l4VBAPiD3ok6wLX4eqDo0mF9jU8DKGS8F+6
 fMfLToC/zvxj+nLfwWZbONCvh75p3SIL7VUry5+GZsf+394lGIB+4wAa0Eov45EnMvVT
 4PhD9Vu12qX5Km/PsQrqjdAKq5H3H6VfmpZPLBNObCelIg9T1p5QTDxqfcfpjhc76RH1
 QM5g==
X-Gm-Message-State: AOJu0YymHqiI4fMZKo4L8SAFZa760OKiVzTJcJ4sum+I6CS4BT5SqTDn
 4gujAB77m7gPDgT1n1hGnCGufDoNOu5fIMkVuGrzauuN61wX1OL+Fm1pWKDTXxtsXWCF4NPHSj3
 GKFM6Sd/WgWaHlGp+jdVLEi2bT03Ro26CcM1c8ARqtIKS9VGiGZQXeh8A
X-Gm-Gg: ASbGnctGjoU7SsXc1mdTX7UT69LLEO1c/XF1+nScbe0rAVUkMpRJfWjeQj35aEiMMno
 E1vUdBQ437tHZPFvigxWFrDgBNnmPg8AkYeF4OKV93u5hoqeC5rbjh+4lS2/8FTAQygetpEzIgy
 a3kS2U1/V1650xgSWvJJ9b33fuYLCTsAsT5pK6i/yP1Jhg/NNp13kCBAwV1RImQ4uUGMXST0vJ3
 /ITgSETaAgb5T5zx+/6cYzI5+0I0pE0hM8n6bX5/FyWyxGq8UBxRJ/EdFNtsPwA01as2YQd99EK
 LO++vUaHSIgrLUgznLNcyBotSy+3fmCCTilX2G5yki9Xnx4BAmrW
X-Received: by 2002:a17:90b:48c8:b0:315:b07a:ac12 with SMTP id
 98e67ed59e1d1-31c9e6f71b8mr7715906a91.14.1752712789893; 
 Wed, 16 Jul 2025 17:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoEyF41T8aG39oASZVyMvCw2f8fVxhrxNoyusDmX1XKS9OXdygY1+Sfg7zcuD3LTmedN083A==
X-Received: by 2002:a17:90b:48c8:b0:315:b07a:ac12 with SMTP id
 98e67ed59e1d1-31c9e6f71b8mr7715866a91.14.1752712789448; 
 Wed, 16 Jul 2025 17:39:49 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:28 +0530
Subject: [PATCH v5 05/23] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-5-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4582; i=armenon@redhat.com;
 h=from:subject:message-id; bh=b2NffNtUDOsgT4X2v0ZRj1V7prc7FqWxpiZP5MM8Nb4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm7xz3c/f79wmpqnuvu2QL3JFVG5bzkGWOTuiFwp/v
 LnEeIVoRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgImkizD8ldde1JPduIRVzf0d
 o1rUtWtqrR99xDl/fj4jcEH5SFR1GyPDtx+1d5Zd3j7rUrHljcC9Mr8OL2S55uve2qz/SVRXZ4o
 ePwA=
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
 migration/savevm.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1c1a46e4a01f812b559c451d278916426aa1cf40..63125971751394b72efc9bcaf7c4364715eef07f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2684,7 +2684,7 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
@@ -2696,8 +2696,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2705,8 +2705,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read instance/version ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2715,17 +2715,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2733,7 +2733,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2741,10 +2741,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, NULL);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
+        error_prepend(errp, "error while loading state for"
+                      " instance 0x%"PRIx32" of"
+                      " device '%s' ", instance_id, idstr);
         return ret;
     }
 
@@ -2755,6 +2756,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Reading footer section failed");
         return -EINVAL;
     }
 
@@ -3055,7 +3057,7 @@ retry:
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


