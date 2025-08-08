Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD290C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHM5-0000Sq-IP; Fri, 08 Aug 2025 03:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKt-0006oc-OQ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKg-0007Gx-B8
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=674/Cf6toA/OKPIbAxIkqVYnsPnsPyHvnVzOFE9af/o=;
 b=hsi2OxKBywL13HvJB7M0TxKpSfddkapmiLuwW7dwktCLvVGJ4rCONeszfsxFdv32Z207CU
 5R/AOSDjvaUeVR/msK8h0/i1BqRpzrhzABxWnJtJNQo0ROQMMhJ3jvvsGN9u/x89c9OACa
 Y/yNDjFACiz4M2TGnOQUWVWckkUKs1w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gFkLwmp4MGiVWF1fhfrOfQ-1; Fri, 08 Aug 2025 03:15:52 -0400
X-MC-Unique: gFkLwmp4MGiVWF1fhfrOfQ-1
X-Mimecast-MFC-AGG-ID: gFkLwmp4MGiVWF1fhfrOfQ_1754637352
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-242aa2e4887so41483605ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637352; x=1755242152;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=674/Cf6toA/OKPIbAxIkqVYnsPnsPyHvnVzOFE9af/o=;
 b=FhnEspDliRoQGj98+a3rn9hFciCB0TXKVoCLEIQKH7NjUZaFmrWDM5EFJead7ocd9u
 Yv/Bk4aIpUGJLn28vjge9VeNyGHyAiGTEW/vhNQKADR/5819SkQxEp15vqt0erwNWnGl
 pKJHCp0oVZCIsoNAI9b7MJVmGFwlsAkK42u9tE/nUhA4S7GA26f1wqmVKRDt8AUDQT92
 3d0M87TL4VVvEM0wK+SkIfZvAqIkz5hZdn0jCndCwRDHMcBe6Ek6WX1PiE28LwQ4WxUp
 M8PY4+B3UFfm+z3jmfPwcjS/BrKLSdKXdbwGFZ/qoPRHUr3XQQraCH+XcsQDlW7cLQFP
 H3JQ==
X-Gm-Message-State: AOJu0YwjWJuc9786iJs0n4AmqyZYI4ivEtL28S2CwD9159gHNzdKq7op
 L8y5B4IEsnsQ8E8Cs9k8iZIcysw8+7m8BxMOPhuIntHqix8CWOzmcBT1UvV7yVvjQvE3NtmUhhN
 7MpwhUodxU3odeE62AH3jPJYSsLH5t66deoye40qirvRbptwNXbq4iH2G
X-Gm-Gg: ASbGncvPPstK6SstjUCLUEG0b7mshwygeZ6yZ5BN4CSIaxE66qxiwk+hCwiIyiH6Dop
 19He+c9AgkWJpKmlW/vdJTnt08/ZkSeuzZQKPnf8NUrks69BGP1xr96IkCuxBZ7AkITgmotFCnY
 APr6ALGXVY9esnnQHa0ZXlE5kmBbEG+GKUVqzVKuUsl+yGm2QLMUJ3xbaM9jOJEeyUtUpshMttZ
 9OzFFYU1pvaL85Vqt418D7JYyVfYIq5ijhYGAs3vg7FR1cudVYcBkF3eyXe/KQGlRmoSySLT8Zz
 fuklfdp88zo2Uxbr1Tf9LYTyw4TZ+tbwxWCy5cGbvq48xsj+YLU04g==
X-Received: by 2002:a17:903:1106:b0:240:3f4d:b9b1 with SMTP id
 d9443c01a7336-242c21fe5e9mr29386755ad.29.1754637351676; 
 Fri, 08 Aug 2025 00:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzaXDhUkp8uaAIKJYAIHTJ7m/BlrYP3t6Ym5xHEMHtCt98P77XwcBU5znFqIPSWAGq4YPElw==
X-Received: by 2002:a17:903:1106:b0:240:3f4d:b9b1 with SMTP id
 d9443c01a7336-242c21fe5e9mr29386375ad.29.1754637351236; 
 Fri, 08 Aug 2025 00:15:51 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:15:50 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:34 +0530
Subject: [PATCH v10 08/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-8-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=armenon@redhat.com;
 h=from:subject:message-id; bh=FTU2QK1xtHVGrbgg6clW9lVV6renoihKHbOJ3mkz6GY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVd1+iwnseUpTpuwOFHyZeGrqTmSzDl+Ico8elE8g
 ezdP3I7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATGTnRUaG44GTf7w/9/pJcN4G
 /TqL5UujfOQfCnw4u/WPY+7iacvvNjH8034x09BmR3SdvCdDUFCFWBr7w//Vi3c+WDDZ1/3LzP4
 X3AA=
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 4 ++--
 migration/savevm.c | 5 +++--
 migration/savevm.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..0ba22ee76a13e313793f653f43a728e3c433bbc1 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_prepend(errp, "COLO: load device state failed: ");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 8c107fb5b89dea4d1b9a27466247c5d7c6b63bec..8557cef35eaf834166ed05ef8b39d79ead47b78f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3255,15 +3255,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
     ret = qemu_loadvm_state_main(f, mis);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_setg(errp, "Failed to load device state: %d", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e45215d99c13a224b19f 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);

-- 
2.50.1


