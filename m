Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1771AC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMW7-0007CV-61; Tue, 05 Aug 2025 14:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMUv-0002SN-9x
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMRS-0004eI-Po
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmQB8vYEVOkmPdKDquv+cokl0fPVJk/XYuTDWxkgQnc=;
 b=Kkr9ORhyDiL5WNE5X/VBvbApmB0GMpH+D/VQY0OQ2m9O5b9nECHbjR5ox3iW/UDg4CPayO
 3JMYdpuSX1/lfzOqMJAvvSx73pNz4M7X4Wd89po0MNyicF+sNBcX6CXLRWWSQ0HBduJB+l
 54XaZWyvpMBmDslRnOaCvg2/vAopB0k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-EWFvo1i3MYSeuLrGFyo9Zw-1; Tue, 05 Aug 2025 14:31:13 -0400
X-MC-Unique: EWFvo1i3MYSeuLrGFyo9Zw-1
X-Mimecast-MFC-AGG-ID: EWFvo1i3MYSeuLrGFyo9Zw_1754418672
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b115fb801bcso8048861a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418672; x=1755023472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmQB8vYEVOkmPdKDquv+cokl0fPVJk/XYuTDWxkgQnc=;
 b=S2xuxhfAdYV6fNV4r8FUVTeqSSQSlTRZI6J6JXHaC3NUBHfI8e4TAFyrMyW6diimQk
 gB7rv3rV8LKBySuPUiGgAbbLXupDyOyh82tp6vjea86a7EqI7nckVVPkuRPTUdHX/IE9
 kc4DBZku4qJpCLilYDh97V9WfhBilDkNAeMpqOeqpuNfT6ZCKKOQ3fIwL6o0j6Jc0+MM
 PBmdumxdd0Yc1UqGMSPNJ/eqtDwHPVBcmyfnAKS7cJGIzBNCzi8aX6f19AGELJkAyuB1
 GNl3Fly2wW9xDEicKCPj9a+UKYA31BNT0i41+lJjPhPbSMvia1X9MfzBF2g9uSC3YI87
 88jg==
X-Gm-Message-State: AOJu0YxrxuLcuwUY3oaumvDKmassybEG5h/4RNP3qoGZ0uZWBBaBEgZr
 IqYN5dBXqGus81PSqH3022ldO0ONqMAFAyVRUAbzHhhZmTe/cQ40vm5H7DgY7nResf/ed+DtJMG
 iwhJ5nAJ9loAOOgzFmFbpj5Z6iTD7m0w9qTOSAGVbBlwsdEVQjNC8rDL8
X-Gm-Gg: ASbGncvnGxH+cyP0Svx3s6kTjvwJsEeHVIefStwj8x3qjqCQb2AayR1MNuHLYzTFdUY
 wcJgJ7bT55sk3nyir84WdubuE34CcFxIiNb1fOASVBKb1w5teH0g1WdlIXdNZhSS3FrSn17OhMO
 adbkOzYxrJHMgA4ILwhguhSUAd5YMzibkeS4ac7vPDqv1TeS2Kyl+7f+2K0AT3dJfY6D356Np10
 jX/80o9XvQCNGkPZEyVsnvfnvtu1AgA9WCxP+/UURFDSjS0zMmt3YNOY88rcKgsMbcVuhG45Sdk
 so96chP1P5czjEWYrK3U7s5zW7wlhefkoU9aOLcrhy92TxmiXA==
X-Received: by 2002:a17:902:ccce:b0:240:96c1:e860 with SMTP id
 d9443c01a7336-2429f5338famr859925ad.28.1754418672433; 
 Tue, 05 Aug 2025 11:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqRwOl9bEMJNDVPJOB6NsECsF8EhshXzXmcu2VDMWoiIvXyBZgloaGF+QWMvfomONQBINCHQ==
X-Received: by 2002:a17:902:ccce:b0:240:96c1:e860 with SMTP id
 d9443c01a7336-2429f5338famr859385ad.28.1754418671978; 
 Tue, 05 Aug 2025 11:31:11 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:31:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:29 +0530
Subject: [PATCH v9 22/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-22-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=armenon@redhat.com;
 h=from:subject:message-id; bh=mI1Y6oyruXcKKhKtHng8gWdORKFI0mPETPs3UZirwjg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX1nNNhX7Z7dvqmev4BcQ6K9suJ+wQrj2h/2CO+wfW
 ZZ9adrUUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCJ9tgz/XXVOVf5hqbfu2sTM
 b/elOXiF22KZo/EFmtVGj3v/T+BMYGRYt1Da6nCaZpGaolWib13dtJMfnx/+xmzlK27k2e7Ld5c
 fAA==
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c89fa59161fd1c4f20d0c3f8f14e86f014223dd6..4df50fb5c674e56c0173c357c1e23367373e2114 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err,
+                              "loadvm failed during postcopy: %d: ", load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.1


