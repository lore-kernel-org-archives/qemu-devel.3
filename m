Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F447C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udojG-0000kz-Nk; Mon, 21 Jul 2025 07:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udois-0008Pb-9P
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoio-0000tm-EY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saH+YViY3d6QaMKDQ8yljLjqT2FlFiAeOvlbv5ESJL4=;
 b=GgNMwkUdLClbUUmzMzImFAvIuK3N6CHdLQG1+i2VpxQ49kq2hMwC2xwFHBCvIXJi8JROgx
 zcN4iM5kMgXnGt/q2PHIUTVl2JlPbI/rJ/C+nggZBEiwnWPsdNB7wbwX0HtjKJDeptFGjj
 zzvkqCF1DhdD2D1jdpz+Dvw254Cjy8s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ibVOmcOFOpyIMk7dNUEMEw-1; Mon, 21 Jul 2025 07:30:16 -0400
X-MC-Unique: ibVOmcOFOpyIMk7dNUEMEw-1
X-Mimecast-MFC-AGG-ID: ibVOmcOFOpyIMk7dNUEMEw_1753097415
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so33056225ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097415; x=1753702215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saH+YViY3d6QaMKDQ8yljLjqT2FlFiAeOvlbv5ESJL4=;
 b=GUgzWgE5oTjePKN0TioSXKM1/n+jIvh2J/9kN+Q9KKKiGYsWfH6JL45myYKLTEjrYq
 C9XylAbm90hFTQfUZY8cY3j40yJZbrq8lYxxySjLqgGDIiyezImHJ36Ytt6tZTGApMMa
 4yqyIfKcCcF99plaglypBAZ1X+Q+H/hDM+HwY5YIQxipN/9SObDsDf1mJIYcbVhGhXb1
 VPwHNTXMymSp5DN4mqtSTATHf+5WPTPCnnY0poON3KnabI7dfNHO7VgaFoq9HZp34iAE
 g9ur2LHqvp/p4cDvEvOwAipY97cDqTJpHJfREyo8H/MPZknUKRhJ+Q49s0t0XTu8wmGc
 KL9Q==
X-Gm-Message-State: AOJu0Yyf1n31kVioIiB4MeF66/tQJOI43HD0MDdcsK67nud07TOhh6Os
 U11vPdtK5bn0mpILPd1+m2HjBAEyPraI4pxTCGZVVNjJL7oH6WUcBL08NjDMVqdE2Mh7QIKmY/f
 h+TB6SXT6CztNZxYA4+QPhFgp0/bBFP8lq2zzcENlFBMTY9u5mpCMnch9
X-Gm-Gg: ASbGncux0VbgTSZ4GMe0Ceu5Cjl7dMFPnZYoxGLOAfoQ0goaDBAqyiIw43oWZ6m7IKX
 t+rA+uZo/kp7gqaIN+QNXuQMO+o6+2cjH71lg2nkpmSlmjac0eS0ESlR3TYU0c8Qc81+EfPYFJ8
 1nLZmXo8tBRIpNKzsQy9bxVQL6DhKbyrP9RpAmCEeAMynnTbY5dXp2tAcoyV6qIY2L+z4xYsqAF
 GbYgeGf/8zQZMAIjfw3nLe5NwcQqxZUDg/dmSasnRctSXoTQegG0/ITn9itVAVWpSu/Nmfcrgw9
 ogU63cKpxWGwzy5HsKG2aaYr58/goa/2n/k7mXP2q4aKJOsj33jt
X-Received: by 2002:a17:902:cf11:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23e24f3648dmr232049895ad.4.1753097415127; 
 Mon, 21 Jul 2025 04:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpF9oTmUdIjpuCW9iLl1c/OU2ZHEyvIISStX0HMWj87Nfvx3FkUBc48OZIJ0A8uWdovQ0s0w==
X-Received: by 2002:a17:902:cf11:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23e24f3648dmr232049415ad.4.1753097414744; 
 Mon, 21 Jul 2025 04:30:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:10 +0530
Subject: [PATCH v6 05/24] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-5-fef740e15e17@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4684; i=armenon@redhat.com;
 h=from:subject:message-id; bh=kPXyFT1MVEZdJl1Sq33H6moMxx89stup3d2zseBts2Q=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adykThOXtc7U4uWOk/Of7j5xtBD7pmyEt/jbIz6D7OE
 mD5lU2yo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESKXBl+MnZsnpBa97QiyN9w
 UVu633SXWTGsQRHzJXZpzyuc4xbkx8iwX+DVd6vzUwwuCsssNpwi5BSvf5L13XVttktL93eu28X
 IAwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
 migration/savevm.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5fe896545a5407393b1bc5126ee977f11b1fc626..96c1a029953230586d4dd48097467d3fdc3e3d39 100644
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
+        error_prepend(errp, "error while loading state for"
+                      " instance 0x%"PRIx32" of"
+                      " device '%s' ", instance_id, idstr);
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
 
@@ -3061,7 +3064,7 @@ retry:
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


