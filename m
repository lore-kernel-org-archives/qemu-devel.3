Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C33C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHLv-0008TL-E4; Fri, 08 Aug 2025 03:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKR-0006Jf-Ns
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKE-0007ED-Su
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsisoMUYyRrNcEb/+SWb07kdSRIAJIbvwaNSO04Xm/Q=;
 b=Y6ntGW2bmHj3lfGwgFdYhIxvvXGTbTnQOtafl55a3jH4fjwkKMrJJ+XR1m1O0G3LwFhmOb
 NhRWbQhexGD2hH3cLoKxUIwZfc78JlO/y0jelQVXUuOyiwyj/OYsbceCGG5rNLf2adCfQH
 ODvx7ZXoy2Zuk0wTIqADTyqzRlzOrnM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-AqHjYKEeMqCwOfGtZRDA7Q-1; Fri, 08 Aug 2025 03:15:34 -0400
X-MC-Unique: AqHjYKEeMqCwOfGtZRDA7Q-1
X-Mimecast-MFC-AGG-ID: AqHjYKEeMqCwOfGtZRDA7Q_1754637333
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2405fdb7c15so26408805ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637333; x=1755242133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsisoMUYyRrNcEb/+SWb07kdSRIAJIbvwaNSO04Xm/Q=;
 b=Y/+OZmLlg/zUX3YPkCGnBS8GAMxaUyA3RRL399lrAzBNDK82xZ1osPR7bzNYlXf6Ut
 MbN2XR2ZzCG605ZxBqFRDu0cgeFCYVG9TOu7+jXny0lC1gJCXOQ9gNFyPTbPsU+hO+fY
 jMmv/Zze9ak31KO+pert0iVNxkkjlUvb/K32zLzBI2kuwU37evNb7/PH4e77wyeyC3Hc
 A04j7x/XQyoSPw+J3TzGz2LKt3MsJYEn5S7q9mj4mhQnPFCPt4eKyJo0nZB4hwQpWljI
 4sE8fOSdw1X7WLQj+dWoV10hlbV5uxeo1xvwzMxFioGPNJGOOJ7/nwt0U+9vT3dwl99z
 tiDA==
X-Gm-Message-State: AOJu0YwYx7wjsoGLHhMS4BrGZhP5coWySFzZ+pTcxYhDP2y+FK7lww5g
 Dot8t5TXrs6nKUd6MGmgLaFqLJi78HL0gaSsuBFuCva1YKRkF/AYziVqwkGv4nZsFwyukyiK0kA
 NRHpVBpnzO1GrrdaJXDISpVyDo4evwQ9D1ZtmZ3SNf4mDJxptO5W/W+VzJ5+v/+0Q
X-Gm-Gg: ASbGncug4tv5qm+DJv61pqkvJVcP0mSjdLkfz4rZiJKpdPKaAClnkfEpS5TDgTF2Hfx
 ++u5AmHnLa8BVhEpCEUQMbF0uXzvFTCc8HRO8tOJ6fUu+mqQL7BhXb3N4drWMJA2BoeNNfP+19z
 /F+hqfpkUMNfpU48Umk1gTyx3F1H7E7IB3CjzMKWJuwky6zaWrMxAFrNix1lKrDgdUNT03UBTo5
 GrFC6CCcO8o9iTgbiu/xyM6O1BkS4UuK0l9w6zpwtV/FSYbP0fhgxfyhpueNNeqjnKTaYCD2kYS
 Kjj9m42DPmXN9HrSRFimVV4dgWQQxGGNWsk+ErOpPUPvlIXVYDHJ/w==
X-Received: by 2002:a17:902:ebc6:b0:238:120:134a with SMTP id
 d9443c01a7336-242c201056amr35014595ad.22.1754637333338; 
 Fri, 08 Aug 2025 00:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnhPr0wQ9L7Rgy46F24TtNuJD+/sys9TTZH+4SFdLmD03pU+jOnP5P7MHFs3/CH0ZsT45Faw==
X-Received: by 2002:a17:902:ebc6:b0:238:120:134a with SMTP id
 d9443c01a7336-242c201056amr35014215ad.22.1754637332951; 
 Fri, 08 Aug 2025 00:15:32 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:15:32 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:32 +0530
Subject: [PATCH v10 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-6-3e81a1d419b2@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=armenon@redhat.com;
 h=from:subject:message-id; bh=3mB2h+cFVTVgcyAHN6Q4MYhvAR65KG4PCQXNdhHx3jA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVfkvgvWidgc2pXgrC2yvunBr7fzT1duibzl+VLhw
 8Wms00XOkpZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExETpnhf/40KbOJXspSNy2L
 7q9QDhJgXb8t13Xe04kfiviSal26PRj+8B+T2mwdtCjnb7jklpknyx8c0k7e8u3j0ROhb5S1Vr2
 oYgMA
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ef0bc9e989d9de3aee066b16401ae0cf9f3ecbcf..adc4ca16ebc8deb4efe49ac2088cc20aaf795056 100644
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
@@ -2618,11 +2621,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


