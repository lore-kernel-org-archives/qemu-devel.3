Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC2C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfA-00028B-O8; Wed, 16 Jul 2025 06:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcN-0006Ow-RP
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcL-0000GS-QK
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NaJ33VLcp+2puFTtiMY5RAuJghTMc3oNGQhBs/78XM=;
 b=I0UY20ZoBQHYaWd07E8ubgDXOWD6zL/UVRn3N5Hfgs/F6IiNp8Sr+vAgWnI8ceBmCYPnH8
 kO8ajqXAMxAgGYqcqe+CqxB9Ns6Y/k1TE2ML6MgQY7qf9/NQSxClRH0BhyROml0oZ1Lke0
 j5tgB0SLYtJxaMZkb+n94RdGJYiHcOQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Mzk2MY-2On23Z9F7GMzJag-1; Wed, 16 Jul 2025 06:44:03 -0400
X-MC-Unique: Mzk2MY-2On23Z9F7GMzJag-1
X-Mimecast-MFC-AGG-ID: Mzk2MY-2On23Z9F7GMzJag_1752662643
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234b133b428so52877065ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662643; x=1753267443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NaJ33VLcp+2puFTtiMY5RAuJghTMc3oNGQhBs/78XM=;
 b=KLNZwwJhTY30TBo6LLU1bmj84AK+olWCT1jMsnFg59eBL//GHJisuwbFOyRxWweOqG
 N+yuANK99NMi7P9VHdIR2ozMIQe9KYKq1WMl1zwe7g6r7bqkclT6OCYe85qcKB4/SaC7
 PjtdZ42yaa2PJfd/DP5GEv6pfugC6XpVrRpqP0FvBdDnxOP3nFYze22JFj04eh10sqc8
 BzFSAgWLwuWBebtmMWISdEVMvVkNbrBqRN7dzbeaj0pvj9XtJ7VkYyrAFYMcDogMkQ/1
 dbOGHUZCBgP5QBv7tuRVL7G280pv9GvU6xJ4qZGa839wejUZALuO/kbGZ7H0dEltcdnv
 6lTg==
X-Gm-Message-State: AOJu0YytB/7R/PxF3mxrcm5UKqfCRbSyKBqntO6+GL9sXIM/MyBZGuDQ
 O4vX/pGYcg+84Sa8iVKXOmtAe2+kbSMuv+VhRTujYXzy549M7PhRvu8v52PuwaJ5yEHi/YSxH+D
 nX5ga7KzC1Zy7QcB5t1Bi+OrrA0WRybiUVVCEeiUfGfljlgvL6rCLochf
X-Gm-Gg: ASbGncsmpElgdWtG2PnRlOdt0Lv0302NNUlk+xB4LSY5LkyW117hkbVhU5Uyi4Ycg34
 r23D+zL18dyZ7HJldAl9mLj/H+oolCqcUaRdBwDupVo3keW9z4H+0E7iuy+QkDFX7bDa0boyh0W
 iAwBS2roytvyq3//r3LhPICtvkcG/DKSH23/2xIfy407jLwVdIp2Qa/Zys563ywALUL6hCBzIs9
 UtuwstgXakN8cEE2YdnPaJBK6baSzArV6Yw6fXEG8AHy2tsbXnKqM/s7vR9Hf4Twh9nHQQdQ6pq
 xeJNXlh6YHDjX4438uiam6yhSe/PHwSeCZu3gO6maYw/J8/roA==
X-Received: by 2002:a17:902:f686:b0:235:ea0d:ae23 with SMTP id
 d9443c01a7336-23e24f366a9mr30574205ad.6.1752662642715; 
 Wed, 16 Jul 2025 03:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzrwIO4gM4nMTRoWC7ST9Crqh1pHa/6pFvIQyqixN7aI42wkCCEkG6gCVQ2oG6/z7nTN/4jw==
X-Received: by 2002:a17:902:f686:b0:235:ea0d:ae23 with SMTP id
 d9443c01a7336-23e24f366a9mr30573895ad.6.1752662642284; 
 Wed, 16 Jul 2025 03:44:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:55 +0530
Subject: [PATCH v4 05/23] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-5-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
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
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5kz3T9S0X63a5vX1xzDqmwIVdxvv1eTE+98t50ea9A
 r1qArs7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOSFJiPD+e796yY6qvQ96rt2
 RatN4cIGE82TN/bXcn58OzWz/YDTRYb/Pr0H566veGLKwMsoYBP56/V+br7FAseq5vrFi/vo8PW
 xAQA=
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


