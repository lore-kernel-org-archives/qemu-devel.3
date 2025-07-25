Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE8C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPn-0004rq-7g; Fri, 25 Jul 2025 08:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHP8-0003st-Bk
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHP4-0008S4-1f
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JoeK4yTKfwZgURj4im/s748g50ka2gxF6YjSfo8g5a0=;
 b=Kd8UbuuMQcNZ0w3WDaIn+gjiCHuIZEF8Ckm4Na4Hj7yS+MJXulWfRfQ0MVO3z2kbZTPm38
 g/6Gd3NeQEJ1CGeK8ABqGgxvcGGMs50vsT5xu+j+go7b4tX6MWOXBshDryY2W0dI459GMO
 XYPxLfSzmB2cOFNHPPkt/R/E6SixZns=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-rJQbpMQ1N8eYxdLaOMxfkQ-1; Fri, 25 Jul 2025 08:19:56 -0400
X-MC-Unique: rJQbpMQ1N8eYxdLaOMxfkQ-1
X-Mimecast-MFC-AGG-ID: rJQbpMQ1N8eYxdLaOMxfkQ_1753445995
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-740774348f6so2086901b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445995; x=1754050795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoeK4yTKfwZgURj4im/s748g50ka2gxF6YjSfo8g5a0=;
 b=jtFjUAxqmuZGn8j5NzgWkn83eBWL5LFm997/ywkAmTIAAmdcxvmgp6B5fckgfHGvWs
 zbY+H0fG3Mw55RdJ9M45iRnt+ojXve3t0i7nRdfXHm39dC2h1BiYWScacm2dL+InFqck
 OJXFyNy2jjBwzdT9yYHF6/HOK85UrHbOUMiIPK5BUFtXfXRX2WIB3bMyEDT83VGKvA47
 DsrgkIoVy1kDWk9/FMMkUXtlujeLibve/kVwZPDwCASzoIqMQhE9wpCJzvBQ5w1R1t7D
 8J8wC1yRaUBU6WKn1mZnZcQI8ZuzqgFVQCiN6jjenGZvfArLh9G6YT9P52Htf2XqjxXM
 rLGw==
X-Gm-Message-State: AOJu0Yx3TP70FbfySJpTos9LNxpq0xD6uBcATpoUoEa7DsU1mX1Ma5pb
 Daw3oY0ylB9hnj0ZbwKkbPOlu1hM+XkU4YSxrBPd4CGNASSVWH2cr06Tl0g6xAsbAA8VCs6BrhJ
 bmjMpD8pIQMSM0gZaA3VPgsjpxnUANbA0AjlCYzAu31geeEbH2mQ7xxG/
X-Gm-Gg: ASbGncvfcXyJa00sUo1ngxMjU9aOj5kD4RoZP3RnOjlsnyeOJj/RFE5Uw6qumNlIGEu
 ScH7DImypAPBqHUjxHn21R5wegF8D6okaQGMQcxqV8npfw6WLv/PKyYNKQVYoGUZ/SzAV/KJD+v
 au3FlYj8F+qE952nlvirFZvfVwesxTNz7uwtYdv3HiHgUAS8CFLXwIs2ZJh9XuLq9eeWGawf/QB
 eUYPxyy2fXZ1ufmQocpy/UYSkA7PfYlamR9dAwZ2cKf/5P3KLeZvdyMCaPkmNJdw5cfTtw5ypLE
 d+V9prag8nRqQTEKG3nfhwccop5G40rpL4yKy0oINDw6hkEGT9t6fg==
X-Received: by 2002:a05:6a20:1584:b0:239:29ea:9c97 with SMTP id
 adf61e73a8af0-23d701519cemr2892965637.24.1753445994765; 
 Fri, 25 Jul 2025 05:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLvFFkChJnvFiX8RG6QSSkkFv8OVxtlhmYlXP3i8TPjFHpBJEeE4Sna6dAwPVGfNvnenU7vQ==
X-Received: by 2002:a05:6a20:1584:b0:239:29ea:9c97 with SMTP id
 adf61e73a8af0-23d701519cemr2892898637.24.1753445994345; 
 Fri, 25 Jul 2025 05:19:54 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:54 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:45 +0530
Subject: [PATCH v7 06/24] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-6-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=armenon@redhat.com;
 h=from:subject:message-id; bh=XyTiPZ0KSlv1Ah3T40Lnu3i41ckmHTTXG7oUapVUJSQ=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmfYv+51lZ/VY+oKScvu59osc1D621jXeVL54sbju7
 AWmDw53lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmIj3S4b/hZu6HFw520vOt3im
 2y9UMhWap9duPt9l/6lD748YiT23Yfinox13/d8JW7WjUULvj3B+XDXZj0t4ltNM0yuGXcpPlix
 nAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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
index 29d2947eed79432f7bd9224743549aad87d177b9..21899e6beee3d2661c9a694379039e82cefbee4f 100644
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
+        error_prepend(errp, "error while loading state section id %d(%s): ",
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
 
@@ -3073,7 +3074,7 @@ retry:
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


