Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E38CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0xg-0006AS-L2; Thu, 21 Aug 2025 04:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vi-0002sG-AQ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vb-00013v-GM
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oe05QVd9wLOWkYMen7wvBHm3XADI471ei7MzyeIXcQE=;
 b=VinnDuIfWZIjL/zraZcicJM2qrcrtfwlWCIw6kZ7mbU5eH1V/w2Ok3XgcyNC6LTKYJWuVq
 S+9jss1cRTrjShiJQ/yMLsfKyiEGpK5wlGY1/ju/i8BieEhYIH6K5BXuA4RjLxBJznXmck
 voSSb1tuLuz7VvE9O3f+4j8mOzM7XGQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-jzL5BAdEOn-cqmk0xYsbAw-1; Thu, 21 Aug 2025 04:45:40 -0400
X-MC-Unique: jzL5BAdEOn-cqmk0xYsbAw-1
X-Mimecast-MFC-AGG-ID: jzL5BAdEOn-cqmk0xYsbAw_1755765939
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458027f67so17438815ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765939; x=1756370739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oe05QVd9wLOWkYMen7wvBHm3XADI471ei7MzyeIXcQE=;
 b=k8L5nIsFxjuLZHPuwztXzqwdLD2jdSyaFSy9FVWIobeQMz/9b4CAAZKf0CPwafey7E
 omk57t/tCoOXh9tbix9c6g95gcbD0AF8RIs8GtJKGVZnL636ymVRHk3pheWZ6HgL3eUz
 4/EExgsfM07/kkvQEkDj9+xfYt93PqBSwgA9nRe88fTD5uQNel5SgAlbyb0Cq64m0gOc
 fV3EsDndAV3xw6I/Aw/m+XSk4cpiuabjG9XMKvIYKxh+/KCXqN7WLZo2tCqav4/fqXY7
 77rL8KTtDPJ/V8xv0h31vZqEtCxSRMV6KJY02dImbW2p7lc3QB69WPxr+4txPtrx3Q7Y
 JBwA==
X-Gm-Message-State: AOJu0Yw6JZ+6h7kBmUAOLXa3bvK/B0ZqZ6955+LuVo+YZqP4Z2unx3uq
 w73Xy+hFN+KN/P1B73EtxmoP5p3wFVfDeQsgVyqZooffBpQg41ax+lmrgiuACQcJkHytmihusko
 MCLlu5o4/aAipywwQ5e8ecyf7h7Ug84xdKIFo+gDDbKZEi9mcXZMMTvU1
X-Gm-Gg: ASbGncvf1daQRhiceq8g/upyBVkeeSN+4PVtlEATGWtpU4W0yHLxFuVjH5UadVDPAya
 HSMyxzRrK7T+0UNFPEk+N6DJxMwzEiDmqBotTVjFpSdOPrZD1JYd4N51H6MRxIdNymR0kiXQSXm
 BwmdXDC3g5wEY32Uq4khGjrqeWFAMMPRmj3VL+MJEbWN608gHUutymsmVuCXRFvNQ0Akk0Xvz12
 sUOw4MqmWg8rDh6hVZs9J9RyYGNEEO/E26R4IYcJEcv5Y/1np/lKy1BawgflnbNj81tnv8JSsQ2
 HgJIXqWo643m9EvjbFkZ9254uLyv8NzLWMyGuidwQ7i+9zTxAp4E
X-Received: by 2002:a17:903:948:b0:245:f2c2:650c with SMTP id
 d9443c01a7336-245fec03a85mr21917415ad.18.1755765939207; 
 Thu, 21 Aug 2025 01:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyUQTx/2be8GmeRNqFpeKaQduNTP7qX37SVxNtNeYfIJvY2GJqAH6JETBmUuZNCuFfgxqxEQ==
X-Received: by 2002:a17:903:948:b0:245:f2c2:650c with SMTP id
 d9443c01a7336-245fec03a85mr21916925ad.18.1755765938780; 
 Thu, 21 Aug 2025 01:45:38 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:45:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:00 +0530
Subject: [PATCH v12 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-6-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=armenon@redhat.com;
 h=from:subject:message-id; bh=8qprCQR2ZCwCoDZxKfvIvlVguvZrXYTAe00HNuMTP6k=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8mdClILNvjdufilp8Ihcq5gcM7RHS23Zs10mfVyp
 vbV92u/dpSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZjIvTKGf7qOcRNY96bXNuyy
 5ymrZ1ewEQ50fdw2f0nR59qYm5YWYYwMu662zbNZEdF668D7gGzJaq8dV2Qn22rtr4ycGhKygWU
 eBwA=
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7575063ad3d421fccc041146891d9bd6f074e128..5793bbfdda593c984bd2230f4052c3e68808acf1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2405,7 +2405,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2415,7 +2415,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2426,8 +2426,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2457,6 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2620,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.1


