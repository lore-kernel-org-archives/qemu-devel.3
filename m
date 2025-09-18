Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2528CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGVT-0004GA-28; Thu, 18 Sep 2025 11:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVL-0004CP-N5
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVI-0002kb-GI
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaRoLgnvXipTQIwgmh18VwtQRJZMUjxN2HSv+RmjctM=;
 b=DwED5x9QARC9vqRxPo/g2OU78kNtyXT+nC0b6cpSzxa58uwGDpWNbKOGQtB/KnWu8by3GQ
 e4/tUvR8Wibe0i20qSRrosgvdjIL5e6biz0wIc7Z+rOqJNiaUL0QRMCrV7b5PJg5GR0lJy
 eN4blRSnCDTeO2QNkiYZFvWY/5bxlsk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-iQV_4UUROA2IpEK0TfQckQ-1; Thu, 18 Sep 2025 11:24:56 -0400
X-MC-Unique: iQV_4UUROA2IpEK0TfQckQ-1
X-Mimecast-MFC-AGG-ID: iQV_4UUROA2IpEK0TfQckQ_1758209095
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso1743444a91.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209095; x=1758813895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaRoLgnvXipTQIwgmh18VwtQRJZMUjxN2HSv+RmjctM=;
 b=hHCBbtZ8ItpEYIHAL1Ap47Vibth1JEg5c11VcB0fPHNjXx1mPnefBsjjczhGerWhuD
 RNAEUj+LK0ZQViXImcvW3Xe58CeocQPXx7tMvTZqNKZxW3HoYF390gzirpPGMJT/41vI
 yQZeci7Xoqm8EoBsgUm/NFENiWowBKcuPf/LZvsLqVuLkmW0mT46Zp96tGmsgvvB3kh4
 g5RteIY6EPtB6pU255Ka0nYt4B7iiHu4P3w8CaltJ/aDDoat5qWb3EA0cTNyW8UBjMbu
 B3eli3yiY3JKMhnrwaj9/kZQm3KcmEABZ08VwngPYSvgK/0qZM/Qze32lvg/47qBRYkQ
 MLOQ==
X-Gm-Message-State: AOJu0YyhpENN0QAjxyKhvZrEG1wjuBqaPnJ8wnAqUDHpffvNzlI8GmgC
 cSdJA8rtc4R1k82/WXEOHRTZLEE03dwj/ccbsAMBz3ISJUWpjIdcMGfj2OlNKR2QCRWNfgUVVHA
 7bMa9HDO0TcrxIYxTYbZwsg4rQDAI4DpPlfb6RbU3gxL3v2Sq/rhSedz0
X-Gm-Gg: ASbGncsJBpg83+rAsaITRzsBhFWBy/htujLJkEiLZ543MbgVyqwRVw8+feOKexI5bFt
 k/ZZwjmRnw7r6aB62g/PALxrzIGIi15U07yIcM3U7nzDbetAiMV9Z51GgadrJqYlf+qKXEQGObx
 rR8l5Znk9b/mP+9rumFe/SzaL8fmEjx/oPv3lOCrwYSvCNakv/ZxNtk/czozRKk81TWXPTvJFxE
 NxwNQwnNULJNHTQZvNdyiHRiqHcaWL+2oN4l1WWOKDOdabtmm4bWIDQBE5ahcvJTxn/nCG2ixBe
 k4irea4OymY8vvaXZ/N1QyF3cnYgWaj4+V3y61ZyywLDaBaXAp4rGQ==
X-Received: by 2002:a17:90b:3506:b0:32e:e3af:45f6 with SMTP id
 98e67ed59e1d1-32ee3ed2886mr7684575a91.10.1758209095273; 
 Thu, 18 Sep 2025 08:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjHG3cCwNOeKkfnp6fAQKs8/v1wo9X6e/zfcz2wtVlDVJvHdRqfI7BAAjltxwvL/MxXN8DFw==
X-Received: by 2002:a17:90b:3506:b0:32e:e3af:45f6 with SMTP id
 98e67ed59e1d1-32ee3ed2886mr7684512a91.10.1758209094808; 
 Thu, 18 Sep 2025 08:24:54 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:54 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:25 +0530
Subject: [PATCH v14 08/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-8-36f11a6fb9d3@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=armenon@redhat.com;
 h=from:subject:message-id; bh=UirhkFM9zKCc9fAhhyz10Rt0EBJQI4cJF89hFF4FZFs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e/R6vYTcoItb/cbLH187xTjvB/yW0xObtY6P+fOR
 t55lxYt7ihlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjCR8EsMfwVX/0mRfqlmZBvy
 RO34T77Dag6Hru4WLn9y62iKJfvBCfUM/2s8TT5M/qrvafOqVO7Uuo4Vz/p9tkTEpqqlvFnYdUf
 zOisA
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 3 +--
 migration/savevm.c | 4 ++--
 migration/savevm.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..2f524b19e6a79dcfe3861f1dfb768222f65a718a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,8 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 0087fca15ce108685667d3808350d80d37b807b1..5462eaff0dcec1fa207c08da6124fe91656201ac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3264,7 +3264,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
@@ -3272,7 +3272,7 @@ int qemu_load_device_state(QEMUFile *f)
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
2.51.0


