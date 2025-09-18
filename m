Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EB1CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGV4-0003gz-2q; Thu, 18 Sep 2025 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGV2-0003gV-AT
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUz-0002is-KU
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfMeHNkHXITJfT3smIrT5NGNTBXHlf78w/tF67kcbe4=;
 b=iz4I0+lQjc/JZ3+0k+ILdd8eLCweEdMaxryP/XEtct0P6j1lIueenrE2b1F+JbMj6wz3Jk
 0OWlwkSxqU/fON4oUXX71rLZn5iJ9yHIJSplyWxMnxZEMf0gG+nVoSGA/c2dfWkwiJPZzE
 L+EKYzfBxPYjAmA1y5mWXObZMTYhsAg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-78s-dRHaMbCXK0h-QGG3eQ-1; Thu, 18 Sep 2025 11:24:39 -0400
X-MC-Unique: 78s-dRHaMbCXK0h-QGG3eQ-1
X-Mimecast-MFC-AGG-ID: 78s-dRHaMbCXK0h-QGG3eQ_1758209078
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32dd3e922fdso1607798a91.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209078; x=1758813878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfMeHNkHXITJfT3smIrT5NGNTBXHlf78w/tF67kcbe4=;
 b=rqx3BXp0n63dHn9ITqFAqoC0gOeQnqTxGkAxdOGWSyi5FRm0Cx4NhZWBtTIKdUnCw/
 GfDXALuhfuk2q/U6neBL1IbYwd/5M/OW4ZXzu5TZq/rkwcaB1DvfLr4N1FbIWliBV+FT
 mFnPe9GJtPmtkqQL2lbvMegwu5Ia9T92wG87aF+JTrUuV6AttXBin/+6ToWZaQNHXgPG
 GC+fHbusjGDMbOHmselonGEio2ApGeIgjY3FAkVa28dC+jp7oJbyz4QM7anjrN8alKTA
 JBm7XrkOXgneyRvuFqWL+5PmW1NqadqrAHL2C418WP84DAmiI3MCTnMlhm8cVEbPv4y1
 UJFA==
X-Gm-Message-State: AOJu0Yyjoa10ZRtKJ8Zu3GVdzxj7CmnKrydqPdr059SEL10XMWli6xNm
 SdqWpw9b13tac+4EN6MoM9D2Ugs8GiuwLDPdWi6LWdwv/JhfpqxJp65xVHHji1bYsGdMyu1Nl4W
 RvVCPRzqqhooReEGK9fUB0nKZ3GGPTgMq7FEPjHUk/gqQJEM2sPwwF7Wv
X-Gm-Gg: ASbGncu1VlBucOZgY2oY2+PDjWrAeDjQ760/n+kO+91XDQFujT8RkVz97pG1JIqoGyX
 OgK3dTJY6zEQBEuPb0nngX91cTgBVVNdWL2C0Ymurh5eTYJhdRytzoV0NS23jFdGPMGQUhUSWix
 qjlUa/0mlguCzVt79WDHphqTelqO0XuUJY22GIkj+tl+XIFnuZkBEazk4rOuxqOw7n9G0t8J9Tk
 2UpzTVSvThq8/LZjL+bi7VztGO2j/1UtI3lnYfEBjftpqaiZMnPoygNCPhUmJbx3J/OagUxjF6T
 3J/bVMLhO/tYAVUs5JkAB3ErfSKSIN0iVVR0E6yHLGRgz642ENi7+g==
X-Received: by 2002:a17:90b:4cc7:b0:32d:f4cb:7486 with SMTP id
 98e67ed59e1d1-32ee3f5d61emr9249782a91.19.1758209078202; 
 Thu, 18 Sep 2025 08:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHchsePdUAtT/bSNdlGCYJzS2Wc/PL0J09GzLGLkbB0fLQqtWjhtABACbxujfBEKLRMLBdihQ==
X-Received: by 2002:a17:90b:4cc7:b0:32d:f4cb:7486 with SMTP id
 98e67ed59e1d1-32ee3f5d61emr9249730a91.19.1758209077774; 
 Thu, 18 Sep 2025 08:24:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:23 +0530
Subject: [PATCH v14 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-6-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=armenon@redhat.com;
 h=from:subject:message-id; bh=EGno3AsWvaj5rUCkbXjfvd8MsWC3MPQGycacGbWUg0A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e9Wd17VpotteMXcvu72nQ0tAS0e/oJT80Xa9Q/K7
 5b18JzaUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCIP/zEyfOtrj1TsnMLm9W2z
 R90l/5r5+s+KL/kutjmmwCC7e4qWMiPDvCfln+IXq75/FGR+6senV3F5oSq97z5N0Pnx2CWlVGw
 6LwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 0e9935aea3e1a214cfa0ddd0e30fa5cf925373e3..de5671ffd1cd06e728227a3056c3f895d3a6e6f3 100644
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
2.51.0


