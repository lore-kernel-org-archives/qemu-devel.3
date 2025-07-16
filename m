Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308DC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfP-0002kC-U7; Wed, 16 Jul 2025 06:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcW-0006aj-2F
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcU-0000IJ-C7
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXyKWduRgwVa8XbT/qLAwYBsiWC6CVCjxuy5mMo3YOk=;
 b=GXbtNhun/eMdMxw+MxXJYsgbYEqhxeBu86GYxIqUqxZMl5Tyds1UoY3CRlE1Psq85R3A8k
 piJd3AdeOCsthmMRiHg6wKC+/Xudzq7w1TWnj4kaKdSl0m4ImzraCceHKZrjoPVSMytBj4
 pweV/yYu+QStC8ZKTxNGXJ3sidOQ7bY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-nicvzgbtOUq1PZl0WFRGTg-1; Wed, 16 Jul 2025 06:44:12 -0400
X-MC-Unique: nicvzgbtOUq1PZl0WFRGTg-1
X-Mimecast-MFC-AGG-ID: nicvzgbtOUq1PZl0WFRGTg_1752662651
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2355651d204so63867235ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662651; x=1753267451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXyKWduRgwVa8XbT/qLAwYBsiWC6CVCjxuy5mMo3YOk=;
 b=IHUHhb8Bax5CP1MWCArGNL6+2mvqTkBzPOfXX4+5wAWdZppcJlCiBXkdaFqNR3GZs/
 sC41JZRMH/Q0BPgfdz3u1MeMROmpL4L0E0GFjM2EDyEkOdrMwKRf5/6SIOdO/8Zp0c0P
 DhNmsaRbTlc5HGLjk2tfx7nAA/beMIqDPRNcgiIxsrfuc1XCli3eV/U5iyhjezoSuzhm
 OOKIZE/jyaCAzvfVzP0EgSmzjGZWvoltf5k1oQRypRd29UQbL9+yPjblwupHPL13h4D8
 YbIGKUGXMwnS9TAAumY+nbFdEPbeBWkOQy3KFycbPGJQaKvDxNktHtbkRdrKyGi+qidN
 Qr8w==
X-Gm-Message-State: AOJu0Yxdb7nxJct8CAv3XAGIzadqnvu7+a8y4O4DxfJcgi7/fIGdXNjl
 XaH5f1+ToqEBC1SAcPZEiO3/L1Q84fFIaetCJO5x23tPP3oJE4iQynN32UuuDBbp+tEp1DxmZTu
 E9iIolgOjx40KVfTHPYY6QzU9W9n1iQRUp3CyTSQa6h3YnaRZ7tdMNZME
X-Gm-Gg: ASbGncv6HD+JyiswegU0dZCfc7NL0U/SvQ8ZGYE+G0VVtDnPAfNu9lhIRTFkxwfHOkk
 JxR4CCSqVPTmQiaJuGlraCWcHR0wfDwxMOGBRTo1C4jK2tNzeXDOFuZsCzEs1N8tPfapDbHgcp6
 axImv/j0hLUZcD6CJWGIX30rukRM+efRggvFEq3ip1N902XskC87V8/vtonMjOE5ofUFXyWo4k2
 JTaptPhhfbpOcQjwGH6Wo7a3Pkfe+6LPxy4+ynmFjRRlD2oKOm+YRYhvleI38tKhszuSDltvUsI
 q8w2ZH9OogS0wrjwxLW1LwZNSycUJg6gR0zdzxBmV8Kx5GJdFQ==
X-Received: by 2002:a17:902:ef02:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-23e24f4ae0emr38276895ad.32.1752662651041; 
 Wed, 16 Jul 2025 03:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmmmGIyFtA8nmr/wAJcagSTotYflHnuxMsZKKXcNRItmOwO/AZOjMvCKQ/KL4sRaMZqIVG+g==
X-Received: by 2002:a17:902:ef02:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-23e24f4ae0emr38276615ad.32.1752662650647; 
 Wed, 16 Jul 2025 03:44:10 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:10 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:56 +0530
Subject: [PATCH v4 06/23] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-6-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=armenon@redhat.com;
 h=from:subject:message-id; bh=01RE6fGMhW2A4jjBTwYMGRdHLILhIBLbCwfmSRWE0rE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k/2G05NmuH9Vuy1yLpvzgVBkckbFg+sJSmXqJ3SeH
 cnecudZRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIn4+DD8r9Tk/Jj6weJ7k8fE
 bkU2sZOKG0xjZjCemZ5bsHvCbyY9E4b/rhZny72mOHSvnPvU/cFSOc4JO97PlDiwoW/h3KA9qnG
 LeAE=
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


