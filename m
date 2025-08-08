Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMU-0002L0-Vt; Fri, 08 Aug 2025 03:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHL1-0006xc-F2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKx-0007Kj-D1
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg0W39r2mo/rnzZlazUt1rPQcD3Ep4F8/ignnOJ6J8Q=;
 b=EA+PHlj4XmgADW+7qUnKsCf5XsCn/nMwuE+Y3C7MqvBe3ICK3YA9Wr6ssGzuzGEb89e78b
 6S2btuxj2O/SpJ71KJZgflRusTaYorEg4FQafZt4YiXIP2hCsCVuIa0I2F4ZFoHZLcqwSw
 0Nd0YDYCHm85KY33LzlDw0k8K1XT7WQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-6KO54gb1O8m5_mIzyQbj-Q-1; Fri, 08 Aug 2025 03:16:19 -0400
X-MC-Unique: 6KO54gb1O8m5_mIzyQbj-Q-1
X-Mimecast-MFC-AGG-ID: 6KO54gb1O8m5_mIzyQbj-Q_1754637378
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b38d8ee46a5so2021917a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637377; x=1755242177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qg0W39r2mo/rnzZlazUt1rPQcD3Ep4F8/ignnOJ6J8Q=;
 b=Sc7vuYMbvykezzot7gxTo9GPtL7bUg4coe4ZcELer7XFiymYT3e5+VMEswZojrJpsV
 eEs01FNTIJTHyDjPhlIHRLSle9ET8FgiMW2OuSUvY4bnqSRMsq551HR/yHFdMnz3Kp5+
 peKsXF97p3MGZxmXLBT86/OGofBb6Wa+6EFQNTnVhFCVx8MIs6EyGjWbrRNuljdLtLpL
 hNBBAagXQGvROAhL/u1HbfqrQ86nkwNKbQZcXLybXTz5xeS345cFmh6xrX6+E3eRhYHV
 SwkjeOkP/inmxXos/PbHqMk78Py5sJaOm49Fj/Yq7S6oljpc3/YPtmY3Tw8M4akW83z9
 ChIw==
X-Gm-Message-State: AOJu0Yzfld3euh164s5S5/ALfogdkcf2rXk9xBDkerqcH0B6uGsrtLJZ
 D9r49YcneQBV30IODTFTx4gFl0PrYoQ9MqG4w7RK4Q8aU9xrMaf2RTfw6QGjW4YHEKGahuElGvo
 N5GM+keQC3rF02VU1ZgDUV4og+FXHjkb7g6G/GfJEf2a89cwd6mRoNvqA
X-Gm-Gg: ASbGnctgXZQTTpTYzBmxWkObVMjO/g5rNs33M3JvnOWDCSM+hTNXXkyfdU4fuzIQVEo
 Vomn1R/AYO3vQiF6dl8w/z9TzsMFlYuthpiKpIoNDBcSFc0p3v+Ntk9GPcycFTVIVEO2zVkRk6+
 cu47GGeWU7xWCFIJyeoxKzosf6+5xWIln6OcsnVRgx39Yx5TdK7m1Ij5eqV7BLvaKNPq3PESUBn
 W33z2/xObmNlDHWfNURhA/lvi52kbvd7M/1BbNe8lNE07hSLiVTx0Rji1u1r5SbSVszGRbbJtyo
 45FVNCzhYLm/MJjNgFfr5+2TOFvmkADkhVSOtHPo9JewaH/CsYbfbw==
X-Received: by 2002:a17:902:e84c:b0:23f:ed0f:8dd4 with SMTP id
 d9443c01a7336-242b07940a6mr87643335ad.23.1754637377549; 
 Fri, 08 Aug 2025 00:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv2pd04n/jOnPh3Y7E/cm6lrPwEcyLp+TiuS54f19hvUK9BinNDLuu1SeGGE0CA7JleG2COw==
X-Received: by 2002:a17:902:e84c:b0:23f:ed0f:8dd4 with SMTP id
 d9443c01a7336-242b07940a6mr87642755ad.23.1754637377118; 
 Fri, 08 Aug 2025 00:16:17 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:16:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:37 +0530
Subject: [PATCH v10 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-11-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=armenon@redhat.com;
 h=from:subject:message-id; bh=D1WGxvbr0zI07Zh7yOUn/XDO1OJxdzpwKqlFCxErDts=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVdD95vcCZmy9nvH6tarPryqLK0lZ++8nK9auOXYN
 s/pm2bc6ihlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjCR8z6MDJc3bOD/9ftOdZXy
 xc/rPmT1d/Fm/la6KPfeWzt5vrXv/MWMDCu/5KS/+9H8eeUOKzeDy9fVq09smJI28dzCApOfX/5
 kl7MCAA==
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6302e1cdc3bca0c16f64dc0f35a17e4d9b7705ea..ff2e4f75e070d0f452414f28435905928b1480a7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2806,8 +2806,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
@@ -2818,8 +2819,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2830,7 +2830,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2838,10 +2838,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &error_warn);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_prepend(errp, "error while loading state section id %d(%s): ",
+                      section_id, se->idstr);
         return ret;
     }
 
@@ -2852,6 +2852,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Check section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3110,7 +3112,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3134,9 +3136,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */

-- 
2.50.1


