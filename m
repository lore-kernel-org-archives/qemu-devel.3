Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60174C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 19:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMwJ-0002wB-Eu; Tue, 05 Aug 2025 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPj-0007gZ-B3
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPf-00049G-9m
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVu7q4OhZQGzIAC7cqmC50LWm5OBUvtT4nQ7i2IG+Zs=;
 b=asmrFKl3n/4Zlxd2CFQik9GFTMzwc9dXIDzuzFCaB5ACoP1K4l9IUgzR3Bbjw5KLk+i/rE
 kKW/ieTUhmbTQ7gE54Ip2BKSSIxH6KOZEVOh9B5BakUkvOexlNhU4ryP9712UIubwzjwPg
 /vpWsdF+bvuMIt94AJvR46PQ7crBljA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496--IodTq5aONqRdejfUVKMVg-1; Tue, 05 Aug 2025 14:29:25 -0400
X-MC-Unique: -IodTq5aONqRdejfUVKMVg-1
X-Mimecast-MFC-AGG-ID: -IodTq5aONqRdejfUVKMVg_1754418564
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b2c36d3f884so4094135a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418564; x=1755023364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVu7q4OhZQGzIAC7cqmC50LWm5OBUvtT4nQ7i2IG+Zs=;
 b=QL9Z1XQRHMRmFhbcYXzAHKMLB//Uj3TauykvvLKwikD6/Af8WLRD71h5bLPXVyfkU0
 ZyAHxdUO0caMJ4a48Xc4ZZ71ovKimqjH42VGFZQsbbN0mCbi0Z26zutaX6OwtamyM2iO
 m8VzhvxB7wBiwXJlU0kSNfJ0ZOPBzdfUecLD1hj4tzUI0oeRhk4N1xi4mTewHLDQABal
 q1sgyDxRRavoAjW13w20UMeCc+0s6KFoD8/vD2St2jP+nXVSdHcytB5ctC9M0qwJ4zkG
 lscUWLx6nvzesxm8PEmzEHxFE6PtP7nhFmNEW6pTnhMbOo3R+cE6ckS+fuZ+YBxLPPBB
 s1mg==
X-Gm-Message-State: AOJu0Yw7Kr/kuSTGWlDT6ktTsMIL0LTTSzuGiDFGSikibJjs8FbMMbgo
 0cX/LxVUmt9j9NPEhqQQq5obuLo0WwZzAGzdAYDAafBv8tB1tZP61wmChwbsU5zL9x5oT8PzTLe
 OICw9TwV8KrQsuixcne/+7FBxI7rz5w4Hhf6dhfj8XoXbtFFor8m3+jJP
X-Gm-Gg: ASbGncvfdJfDDg7qizwhQCX9xuQX/B9+72xhBu7GeiOd0aiWbjNS9Rzt5SEtrRVvr2/
 EJLDnivXbsUgs49m0lIza+z7jEBQGagvh3+jfwByR4ORP3IGgI/QryFlYT7ptxcB5kA7q1NjbAS
 LwE3JvS80ng2VrPNUyRsYAqk7oZFoyLbH6wmG1L8SK0OYrD21rdF7a/WOMg13NHr9VIhG8C7j4c
 Mc5rrMG+GVg/CtQtCgiUGDjjcOCa6Xd7w6he6k/6wzjAytsRNejYxFAb12Q1NLA/CN20exGD/5u
 KuRavsIV3Mmw/bvD/jw+ln/hxxiEpgaRnltcERlt/S8OMKON/Q==
X-Received: by 2002:a17:902:ccce:b0:240:3915:99ba with SMTP id
 d9443c01a7336-2429f520b5dmr922035ad.5.1754418563715; 
 Tue, 05 Aug 2025 11:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKgWnHu5ejRuyp56QDZ5GwowN/ib6X10wnQwAWpDaphUkIlLyOX0Tp8ezW0oiJazQ7h0RRkA==
X-Received: by 2002:a17:902:ccce:b0:240:3915:99ba with SMTP id
 d9443c01a7336-2429f520b5dmr921795ad.5.1754418563253; 
 Tue, 05 Aug 2025 11:29:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:23 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:17 +0530
Subject: [PATCH v9 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-10-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4734; i=armenon@redhat.com;
 h=from:subject:message-id; bh=vlX/kmbnbsPb1YFZ0DOsyTbnpSxV6PGLXKlTeV2yCp4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkXxl9TYd1QTNcvkRHOPm4r4iUOLfoolqB5F7h61VbQ
 gu67Y07SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATMSPi+F/HOtmDcfTtxmONu5p
 mryEbcrdkvUFP/R279B1UXp+himrluEXs+yRCzLNieL/L+uI/v733c49N37XRKPGc2Fqnh1vp63
 nBQA=
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
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ad3dd9b172afc541f104d2187a79bafa8e380466..e337e3c61e7627f09b853bf5e9b845c38cb5f082 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2722,8 +2722,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
@@ -2734,8 +2735,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2743,8 +2744,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2753,17 +2753,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2771,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2779,10 +2779,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
 
@@ -2793,6 +2794,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Reading footer section of instance "
+                   "0x%"PRIx32" of device '%s' for version_id: %d failed",
+                   instance_id, idstr, version_id);
         return -EINVAL;
     }
 
@@ -3097,7 +3101,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }

-- 
2.50.1


