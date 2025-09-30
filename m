Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EBBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rti-0008KY-UC; Tue, 30 Sep 2025 00:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rsq-0006bX-9j
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rsm-0003NX-0v
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbiVX6XszpadqjSIp9BBp948crfLAqYRM0Ul9e9yYZ0=;
 b=NvXQsBYRrCWOuP+ZMY1VwGYYoSEhp98QpY8pIJSY/a3f4ojL2gp7gt5ec3gcBZMg84irGy
 PsUpAZhlXOG94gExgdE17z/LmptywX6D0V6rSF3YOFOf7rhWTJ9ErcFnlvgZWXa7N7lu7b
 If0JFwCdwgnyQghU1YRR5zbAHGoSFKw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3ZQSR9k9PhS3umvZGDYXGA-1; Tue, 30 Sep 2025 00:22:20 -0400
X-MC-Unique: 3ZQSR9k9PhS3umvZGDYXGA-1
X-Mimecast-MFC-AGG-ID: 3ZQSR9k9PhS3umvZGDYXGA_1759206139
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-78108268ea3so4001580b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206139; x=1759810939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbiVX6XszpadqjSIp9BBp948crfLAqYRM0Ul9e9yYZ0=;
 b=su1hGVAoqXATSieV+9G86Y5FefILRd3AgnwX2WYizeVEKJ+mAElBA6ifgfkHLE1JQf
 SgJqIB2LtkjK7ymHhlG7bJ6L4LbqLgxdhcRhvD92l2KR3MsipVsvoeqOzY8096zPzeQT
 4KxceVaOy3rM8SGCO93AkmtwSy2G2lF0ojLI5oCrAH3kqTKuT59/H1lTssn8HLX8GO9j
 JMlw7p5HC8A/Rchz3/vyMpl/z7ij9kjYyl21h0FYBFkh701VBirzS4VjjbVtN4nUNah7
 P9rnCsYVFFyKteZQvyUVvph6Gls5IDc/4srn0xE+RSly0KEyzQ3b2GRrrBXtDWPe7d+s
 4j2g==
X-Gm-Message-State: AOJu0YzDblZfEunTvuYSOIfu/ZpWTCO7/b6K1WGO0xtplGoBINTQis92
 3Wo9a90pX0c7JxfLDAmWXc/b4+JummDu3PwRby4LjD99mP6M+elkB0himcRo6FZvYiDUsFNWVZT
 7K5XwNd0kqV/ZI5nplKJKH/GSTSz9VGLBt2EoQCmNpgT9GkqwdAdt7W39
X-Gm-Gg: ASbGncv25+i48/BYmm1DjFA7Mu9wVxqjqFp+NuuTyXikC7U5687cL2cEppxYu9/q45k
 9wUOfU3gckCG9FnoRpopFD4A4BZrNMSGyodA6gNeBOwpR15vgUUcEYB7Ag2LECzzBq453RXiqtd
 6WCm/55ro4Tyg0xFjZ5+FYcU9MXITgfwGIO56X0LW09pk9kUGxILh5f2czAiaD3P/JGD2I7reWk
 xFYHE3IUW130YWHO9xRqxRIcBWE2hBOJ8c2QPC3LMgU4ukxZ5chd6M+WqYHOXBdToX9Aq6ZOT/E
 PA3KsjBZG+i7z/FDKDy4eECrKNDIEWVRMluE6vIzIGZFGgjBfodbClXCGQ==
X-Received: by 2002:a05:6a21:648a:b0:2c0:7991:c00a with SMTP id
 adf61e73a8af0-317647b77a2mr3963900637.10.1759206139478; 
 Mon, 29 Sep 2025 21:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz77Gl5a5Q13gKWRJyBUfPLQd4uhec1Pwjs9UCtYkTtrR0pV11I8MNPTsXAEWSYsfB9G0Qeg==
X-Received: by 2002:a05:6a21:648a:b0:2c0:7991:c00a with SMTP id
 adf61e73a8af0-317647b77a2mr3963873637.10.1759206139109; 
 Mon, 29 Sep 2025 21:22:19 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:22:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:32 +0530
Subject: [PATCH v15 23/26] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-23-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=armenon@redhat.com;
 h=from:subject:message-id; bh=RtlEdtEskFUQ6B62eU0w5UESKT2iGafsHUF2NecJgfo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKKFy26Ua4Vy8V/ZKpVdfXrt1VYKIe4xG3a2F+v0RX
 JwHZ1Z0lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMhrLYZ/mm+fXg99v/hyxtS2
 OOMFu6XNOHu8pS9+bGS/beZTunPqHob/rg8OyOtk79kfyxri8Mt4Ve+B3QaHlzSJcpw7qutzNc+
 dFwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34b7a28d38dcc4293457a87b34dbeaf538d89de9..996673b679801de418fcd20966c906b50da4bb23 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.51.0


