Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B05C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCgo-0004nI-Tx; Wed, 16 Jul 2025 20:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfP-0003U2-Do
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfK-0004in-Dv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXyKWduRgwVa8XbT/qLAwYBsiWC6CVCjxuy5mMo3YOk=;
 b=VpDmuwg3NUZ3P77lSMa2jvrOK7iN11jehW5MWrIotNnv0NklVy8L8MYvXgOiTJ+iWaZqfE
 sYWaitjlAkncwTN3E2lzW+sddPMX4alnCnthepokCWfRFTcJepmP0QlWgzfAcf/vYEW6x4
 bbzqoMIQLY91+gUtb89yQhWubyVpjDs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-VB7Rn0QmOjerfu9n5sMy6w-1; Wed, 16 Jul 2025 20:39:59 -0400
X-MC-Unique: VB7Rn0QmOjerfu9n5sMy6w-1
X-Mimecast-MFC-AGG-ID: VB7Rn0QmOjerfu9n5sMy6w_1752712798
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b3bde4d4d5cso252679a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712798; x=1753317598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXyKWduRgwVa8XbT/qLAwYBsiWC6CVCjxuy5mMo3YOk=;
 b=gqp18jNvbNGipxadkrVGDHNcagRR6l3R01cVOflcAmsEENQoxnIjc6YyxyKGgRw7Qg
 LV13jP/hwzc2WskuK9he+pA17og3W63NTcVpUXh6+pgWG2bElx7ys+cl58C7ipFYf8KS
 CQIz2XZ8UafD4stWE1SEsxX1QoFU7cDKFbNKuc6kPNxzam6bfK35JPhJrU+o1nXw0XMY
 wjzpct8HmSMJ9Sfcbraa3oEfLPIdhtOeSG5nBJ9DeXSfOpt94H1vR3iPyfHc1iAEMKNb
 ac0ifbit2VinyLG0BJ7d7PeashLi4401YmgXP2iDM4EDWW5bMT/t5VjewEF9eY8LjcV/
 PPQA==
X-Gm-Message-State: AOJu0YyeSxSoagKkzIbCLedC14RWxQIFoHltmoUdtgdfBN88LQ8+YF7I
 4REWsuorKQsep9bb9Dr/LKzSeTrnmSsaU+afKZpRUgM8RzXzoEECGcVm5myi4aFZE9erk+aUXhq
 T6lPzPdrTaToSlrpWaJrQHVR/KkFMd3ZZQQ1uUarprFCHyJrYsmBKKk8T
X-Gm-Gg: ASbGncvrqJwqIw2MJQ0nGfckkNCN1L9q6yTTxLPUNpyXwP/lAh8P6EqJRfgEmx7hDNA
 3dpBbZbyY5Enr7diuR21TQY4XnBw2G+szrFv6L7bPP4x9OgiaTR7wecrq1NocmgibHeVJV6TSxS
 4j/muMt43S6hTvVxy39X1O50Mao4G+YSAlsl3jSaZlfBYsfhEw34F1OIs3ujxuO4zQcm8uagbvm
 rDCu4fK9x4K3vuEzQ5f/bYH56PybQ5bfIm4v5qrCGBuiIbUhXB3GVi0pp2iZpievNn3E1TXWRHi
 aXGULg3FgU5LwrsnIHwQBzjMuJi4lETHpO/w11BZZduTqacapjpq
X-Received: by 2002:a17:90b:48c8:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31c9f4a8027mr5196923a91.22.1752712798207; 
 Wed, 16 Jul 2025 17:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLfVcg3K6SzlV7xG/sHJf14l6vAlss+ivfbkipbuORdb2xvP/AWSe71A6KIF9qyaQiM+k6Wg==
X-Received: by 2002:a17:90b:48c8:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31c9f4a8027mr5196892a91.22.1752712797725; 
 Wed, 16 Jul 2025 17:39:57 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:57 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:29 +0530
Subject: [PATCH v5 06/23] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-6-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=armenon@redhat.com;
 h=from:subject:message-id; bh=01RE6fGMhW2A4jjBTwYMGRdHLILhIBLbCwfmSRWE0rE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm3z4rkMn7qx93rXo3slFIvr3zzr4G6VKhORxc0zsb
 zrZIriho5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESuVDIyNB9vbkpdcSx3n9aj
 Scs+Wmv4sG6c3NTKMmWLmkPr1to4WYb/3l5er83Wz/t3syc+4Efni7Im3+zG4uMBVeq2HiWfJm7
 jAQA=
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
index 63125971751394b72efc9bcaf7c4364715eef07f..22d73999595384519c755c9416b74ba1263a8bb9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2764,7 +2764,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
@@ -2776,8 +2776,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read section ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2788,7 +2788,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2796,10 +2796,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
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
 
@@ -2810,6 +2810,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Check section footer error");
         return -EINVAL;
     }
 
@@ -3064,7 +3065,7 @@ retry:
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


