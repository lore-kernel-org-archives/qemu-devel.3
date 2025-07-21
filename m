Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623AAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udojg-00015z-9t; Mon, 21 Jul 2025 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoj2-0000F8-I2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoj0-0000uz-2R
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8Uq4lNa/kfE7XbxMaNa9vUXJTbd/267RfdEXBm2Bhk=;
 b=F8uHxgyFZr+0jxKZ+UMfMoRxFnhFFuwNoAiiBwMsS1sRv6w4CcAhn8ebfmiIgtZL80CD1p
 swo2zBN4m5hLE8MxrA44Dk3zGPOtAy2m21gzRlMZqbx2VRmAdXa2YQL+8ByLM0rKLB9kqU
 GRSRt2L2zHKEncmiaBTeIEHXK/TPF4I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-9c1BG8KzOCqUax1CYdaPBA-1; Mon, 21 Jul 2025 07:30:27 -0400
X-MC-Unique: 9c1BG8KzOCqUax1CYdaPBA-1
X-Mimecast-MFC-AGG-ID: 9c1BG8KzOCqUax1CYdaPBA_1753097426
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2363bb41664so33763385ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097423; x=1753702223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8Uq4lNa/kfE7XbxMaNa9vUXJTbd/267RfdEXBm2Bhk=;
 b=PMK2D+wh6VjlLnjlUBxQV5ooqc0FhQOSmxpIK7W7T/nKtSKGoixmTvGxYQk4m4q+cW
 uJWL7DEE0yG6tQzB5KJppsGvxcksiWG0bKIFdzuoJX3LEoB2W1glDi6I40cmYvH6OqD6
 U5FATiOgnAGljL0ApB6lzCHhvKSDAT4QbXQaWHaX1UIo+xRXsmnObw9/8KTNHVGuY+YT
 cpIEXZyCVb4wfLz2JUu+BmjuaOfD+pT10uTX0g2+gKp48JlpAIVokhhxv4E2y9M45a6x
 3byV4P0BFDj/xt6aAPoNTeQCX12MfXz/Du2frAEpRQ3kOUQ0bH5JFUT19RJ8TsX6ELnP
 /XRw==
X-Gm-Message-State: AOJu0YzvXJ8p1JWGZ8GvhYjoq8765Lvd5IX1rjB/Xwqvt98lLpKLKXcY
 8zffnfE3s/0LfX+F8AZONUM+tC8BnIU1miGDlkmIxBTFrQWmoJctfhf6cYbh2xZi6PRHH/NHSKN
 BfpfXHA+hgkJra5/Pn0jiF0dhqFUhOm4aykOW4hQHltH3Gd3wGxARdb8n
X-Gm-Gg: ASbGncsRmPaXpkM2MeeaXqcLOntJR+MPrjxlWUB3YypMhDsq6X6WErDO+dNqW7B86F7
 8vJN6k0CQm68ukg2v2lymGvqE/Mx2Gqfcep2klkvXDWkBKogWP8hj3EUlK8gWleTWab+18ZmQDW
 C3tmJbvbQ/ll63Ef0ZKTqDzVW5WiFUk1HSI60R8INrf0r2IsGMZBFl2H5qh+M7ww/wvOfM+cNJ6
 9YtaBdFD3csmBOa+XtJjuowCQfAnmzS6SC14sIpYKCDsfa3WFE40d8puRdqTBx346gCbah+oNtS
 vHOI5dS/nh+aAm6X7kOLKatGzMpWi8+sOCz7gluAy5t7i3c9RKce
X-Received: by 2002:a17:903:230c:b0:23f:75d1:3691 with SMTP id
 d9443c01a7336-23f75d13a76mr79780185ad.15.1753097423512; 
 Mon, 21 Jul 2025 04:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpXpmEREd0bwedVExDvrr/vB7pLEQfDU9XphAsk18yUQ750BkL4ZlboL3cq/tW22KH1kGfZA==
X-Received: by 2002:a17:903:230c:b0:23f:75d1:3691 with SMTP id
 d9443c01a7336-23f75d13a76mr79779795ad.15.1753097423041; 
 Mon, 21 Jul 2025 04:30:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:11 +0530
Subject: [PATCH v6 06/24] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-6-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733; i=armenon@redhat.com;
 h=from:subject:message-id; bh=SQt+x4YZaTW+4j70w5VMUsH0RvUUv0r7vHzZu4wzDws=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysQvD1rM5mjrVT90W/HivPS1HwdkE+91PWB/+UWjI
 P90j/7BjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNJvsbIMPHDAhle4dXuD3U5
 //8xuhuuuEtiz/Lq1fOUnZce2SGpz8XwVzwpmy1kwk6thczZP94EhTDbCm1bv8o4WVQl/Tb7/dh
 wZgA=
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 96c1a029953230586d4dd48097467d3fdc3e3d39..bef2236799945ed63124b3a41559ca4ab02e094e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2771,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
@@ -2783,8 +2783,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2795,7 +2794,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2803,10 +2802,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, NULL);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_prepend(errp, "error while loading state section id %d(%s) ",
+                      section_id, se->idstr);
         return ret;
     }
 
@@ -2817,6 +2816,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Check section footer error, section_id: '%d'",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3071,7 +3072,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
             if (ret < 0) {
                 goto out;
             }

-- 
2.50.0


