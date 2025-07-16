Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01AC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzgu-0005p5-1j; Wed, 16 Jul 2025 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdP-000888-L9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdN-0000dg-UW
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujdVWy2rH2TqQ1lpfu7h+ecGhOShOixDP2mkaGNBTYI=;
 b=FwYaQmhu4ZGRO1LpK48G7hO9dJYfgtcTimJDgNL4Rst9dnLW3tXtLH7IhD9Pc/+5KhxFjb
 J03EDXkf4RUjBqE14MEoc+XQEHcxTbJ6BJec+R5BtjQ7ISyBgDZNKQK1SABbZE4WildX2G
 BcEU86j9oVOSfPDJku4X9ieYlG/c26c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Ij5GU4VTNHSDqB9dSZmbrw-1; Wed, 16 Jul 2025 06:45:02 -0400
X-MC-Unique: Ij5GU4VTNHSDqB9dSZmbrw-1
X-Mimecast-MFC-AGG-ID: Ij5GU4VTNHSDqB9dSZmbrw_1752662701
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235196dfc50so9178755ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662701; x=1753267501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujdVWy2rH2TqQ1lpfu7h+ecGhOShOixDP2mkaGNBTYI=;
 b=o3g+9VAK4hCGYEG56da4MxTGuWqwmtU1haELL2E+O04jUejYwFjqF8XCXD3v8FB9HW
 NZrewuXlAs8z+DH9fuwpcTUD1njBwTmpRMdYBSvvy5XGcLEZ8L2zq/2Z8+yjXFo7LAmC
 O2dslHMFpY9PwUFMqNCGWhY4Y8coRE0Ba/PIZ48LQ1e2c9ceUNY6aJ7qNj155GELamAr
 t/ZzL5uL0DV8LIIpRNuSOsx7b/oyNY7BCNEhnJG/sYl9t4ttKOKWeAlGM5zsR7zbJicH
 auncopyuB/5STmKNrYKggAeQh+Zi6T3VQbgvNE4EbNjJjP4Y6u9FQ/SlJroMRoBqbWTo
 no2Q==
X-Gm-Message-State: AOJu0YyYx7Fk3ntYC50J1m+9qffqhjrLHyN06Ej8K79mjUe6aQtx4qUx
 F6b7341VYTa6BSGok46ww8yJXYZ5qfNIJfynfupgjqD7wD9OTEFqpfqtIQSzidL3ua5Bqi4sQvK
 p1mOpsHUw98UFj/zt+kflHdwM7nqXdp/1OwG4LTAGkvELzYfAyLHSryT6
X-Gm-Gg: ASbGncu6MyCzqJ79E/bj7f4xt9mj8mWjuO6t18zOe6RYGPVcAnMY765AuJN4XTE7aRO
 SkNQHp79OpznRYxkAGcgQjBKfynaIa7q79+aOkQVaPqHu8quvWw/P/XYF+4Uj753uLoB0pbW8hG
 E7OzrxjRcfxhcJZta91DY5V5bc9tMFYH04AQT0Cypn3B7xKUYOKR6ZO9XNcBEETViDFCnTp3y84
 G/MqxLlESxPlXDtUV9FoXdcSngWTY2FKzvIPpInlaw8izQ0qMEmxATeB1Oey2mTa5F/6MLq2Jx3
 9OmBT85M1FbAPi8PF+SJkHidVvcQnKmkTzilEqgwB30zIvqxZQ==
X-Received: by 2002:a17:902:fc87:b0:234:8a4a:ad89 with SMTP id
 d9443c01a7336-23e24974631mr37402975ad.1.1752662701151; 
 Wed, 16 Jul 2025 03:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUe4iqvtmplnsUcYLdD01H5nNfgU6s+vcAvatZ1JwEW5DNfCHtkGmeDkMklEbPOLMdqRKu7w==
X-Received: by 2002:a17:902:fc87:b0:234:8a4a:ad89 with SMTP id
 d9443c01a7336-23e24974631mr37402485ad.1.1752662700723; 
 Wed, 16 Jul 2025 03:45:00 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:00 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:02 +0530
Subject: [PATCH v4 12/23] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-12-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=armenon@redhat.com;
 h=from:subject:message-id; bh=pqon81xf7UTxZs8IxbE32QWAv4e6Je0V1F218bYc+1Y=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5kz3j6ZWTWx5rGz1Zz+xj26m0v7uQfd8Fl4jNV9cU3
 dStPZDaUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCJBQowMf3aEHnk8/+EOMZa1
 XCu3b1nW/WLn+tCVZtksf8pTOdxDfjIyvF3x7Y5rAFucUFcb8xffOetLaqbmNPX8vrFiuV4R4xt
 9PgA=
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3ed399267af7ebc9746d81920ec58277485206dc..d1e596045fe9b90f1037e14f84c92cc649cf8008 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2265,13 +2265,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
 
@@ -2625,12 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.0


