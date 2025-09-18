Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7879CAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGWS-0006fm-BZ; Thu, 18 Sep 2025 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGWP-0006Tp-C1
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGWN-00037F-O2
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za1NNvSl7uFr3wDIymXqGWcBuLkcyiqwtqIRxvI2IEk=;
 b=gODCPv3cu6V5lksGKVcpWX5YStFeVr+Ykmy7G35hJmKmpfKZsQhshGNusNhESSPeRCq3Jb
 u/69COIltIR2fZLN7pLRKaXo5Vy0c3KPLzWarHD7H4S5qzaDrCTmueuy3s0xDo9UdkOl9s
 zOb308G+T107a5RGRW4rzmNCI84k5NI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-2AC2GrSgPAmr2n-nctmKlw-1; Thu, 18 Sep 2025 11:26:05 -0400
X-MC-Unique: 2AC2GrSgPAmr2n-nctmKlw-1
X-Mimecast-MFC-AGG-ID: 2AC2GrSgPAmr2n-nctmKlw_1758209165
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7761dd1c845so1136285b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209164; x=1758813964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Za1NNvSl7uFr3wDIymXqGWcBuLkcyiqwtqIRxvI2IEk=;
 b=lYhNEc4jOlE2H9YOT9MLHYRFWA8hD9YygdzZqvvcAoJqcGi+0069Lx27sspVcdE71Q
 0QEls5xsKA+JWwnS0NkTI41FHy5ggNEQsIFgpNZRe6ArGdxsuf7zeC7fcfqGe6vOW1bV
 8vLwRdSl0p5/28VFOdiUjQzLoRJK2xHTEKEG5spltiXizPrzx0nj4840qmU+gDn+Gqa9
 tGpBm6LU/h65+Su67ec+HmGblo+qRnhXtIioRrdPQxt9izCltfDlP+kGfEuAn65bDcvl
 u+7j3tuaFpQKu0ivhsOLONrfnKpOU4remlZDFP+//9OdbjPHyCBNwiA4sUxYcUxhz69c
 9dTg==
X-Gm-Message-State: AOJu0Yx1NnrBo0VBZ18MKTONGOO+yfjniwbtyWXKzKw0oSIa3JBPcO3L
 00VL+9YDCH7C67B1M9kyGUcA6V4NVIiL2b+OGlFuTLgeeP55BWDVdnEDy+cblEKnd7ZmsEGm9v7
 QfghMXYLdmyLJ39i2cYhvbo3VuL9VDFvADqKMsbpXb2SKRqj+xTkg3BnA
X-Gm-Gg: ASbGncsyWEqmcFV2JC0AR+sg7G7Yd0xm5rjU2qMY1IYflhPRiGUnSgPfbD35lEDpHYa
 fzBCLQrIR7jcpd9RzsBPswffw/BYg4NhLGPFWEptvjhmynoFG5DEZgVTwWL3Q7nURLQ1Xoxd8+O
 JoGSDzJYDt0aZs+aC/80+9t1ywoQC0HfahNvsbPWg9WgF+llu+H6zorU0ItmojclehJlTn4Y6Mz
 4ahjgzPA6/u6lvIWFN/oY7TO3NdxtxKsyZc55UcwEsfMLKL6opUXKGZLDB9GXtcN8dVw5q3n5vF
 PahbhVb4GkNrPE4sQvptwiN8zDx39MMKpuwxsVnmyDJEcVoPlXZJpw==
X-Received: by 2002:a05:6a00:3c95:b0:770:343b:5457 with SMTP id
 d2e1a72fcca58-77bf926836cmr6875651b3a.16.1758209164507; 
 Thu, 18 Sep 2025 08:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ncZ9So2Y7vmCD4CO66kVw3lIrVIcv5pjax3rehicl/SDmqaYvXAE21WslU6uduuZjTgAbA==
X-Received: by 2002:a05:6a00:3c95:b0:770:343b:5457 with SMTP id
 d2e1a72fcca58-77bf926836cmr6875608b3a.16.1758209164127; 
 Thu, 18 Sep 2025 08:26:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:26:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:33 +0530
Subject: [PATCH v14 16/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-16-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BsaDnW57QysoXysSxJ9DH2reNuwbEbmWWZabpe2MJIE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R8PFbfyPLfkW1HwJv+mqcrXiXcCfSSXr2s39nTeX
 zvT88yijlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABP59YzhD89n9Qs2sgszLy7+
 9kVw+eF85dypCTsy5C+JPFWaU3C1wpiRYUvMY4uyhNePD219/aD43zqzCKGq04/OzL96pUVbrXh
 1DxsA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 680f6e1c4bbc979f779d9fde28ab71ae234b5891..c681d6d21af356a97645f2a0d36e7440e3bd95c6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2181,15 +2181,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
 }
 
 /* After this message we must be able to immediately receive postcopy data */
-static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
+                                         Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_listen("enter");
 
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
-        error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
         return -1;
     }
     if (ps == POSTCOPY_INCOMING_ADVISE) {
@@ -2212,14 +2213,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_incoming_setup(mis)) {
             postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
 
     trace_loadvm_postcopy_handle_listen("after uffd");
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
         return -1;
     }
 
@@ -2622,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        ret = loadvm_postcopy_handle_listen(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
         ret = loadvm_postcopy_handle_run(mis);

-- 
2.51.0


