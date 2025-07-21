Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE39C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udon6-0008TG-SI; Mon, 21 Jul 2025 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoka-0002I3-Er
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokC-00015d-A1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7VGnOwoyFn98Un1Ij+29GHLk64B6WUjjj3kHRHHzyQ=;
 b=U3mfZkLRfYvUjr9BpVn97sqDSE22gDxxpMDim9p+MXVuqkvdRCMgxBbrVZOGhCSB7H9s9m
 ZQS2uMYZsQCTUIl5Ebm2boZRiVspNL/VniGP5XqeRqV6dThzU+xen89Xw73LWtai3q9SsQ
 ziDie3CoH3eRvnhcQ9GQk7PTP7woMhI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-l6csU5TiMfuxlXhCPnRmfA-1; Mon, 21 Jul 2025 07:31:40 -0400
X-MC-Unique: l6csU5TiMfuxlXhCPnRmfA-1
X-Mimecast-MFC-AGG-ID: l6csU5TiMfuxlXhCPnRmfA_1753097500
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b31c38d4063so2968238a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097500; x=1753702300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7VGnOwoyFn98Un1Ij+29GHLk64B6WUjjj3kHRHHzyQ=;
 b=SzWRGtE8bKR7tpkrwSnHD+Fb+PsypY+6GVqH7yxt9KUxvEo4IFO8JzLsjZw4h6/7Qd
 r+uhYNYKCQNi8YJKlLK475ArLvGfsJZxB6V7spuPnDuky4ZCqFwEmNTMCyRmwGCNyw62
 7yAgVoICPlrALHeud8aTSvywfBB/8pohHtUMKMl818kuQbrnWA+xx0zsA0lYCxrMSaRx
 NORb6rAC8JLLQ85DpnPFK43NmhUsExRhzOVipqAbXtnR4KF2Qh463f695Ovm8wTD9Eza
 cEgLkwWx1mQ0e06nLX2eYcvCAf+WpicnXSsN1CxjdMD/BmpGsvE9ZOWhrRHPGWUuSzWe
 Rgwg==
X-Gm-Message-State: AOJu0YyXtgvh8Mg8Bl4BairVyM7uCHejMFsD3fjwqIA/tUqKT0t1y+OX
 ZaktMLM+NWSvCWxp315WpTd4tR5xpTkBZZQr1i8Xoh/k8BXga5WaRsrIF7A89dCbwUi+m1arrg/
 6gs3gdfpKz5GVlGafseOtHmR+72P+W1MA2LX6nilWUpirGIC2eiretNzM
X-Gm-Gg: ASbGncsyASfHTRVR4fjAkwSKqb6tDZu+OMQzjBGR+tet4J/olJK+gzNlaZNHkxQMqPe
 KMzAs24nqWBPB0YpD/0ISPGmb/vUOodpKqbQDWYcbwMLeQNe0DFCDyRLXfsKNkhzug59cxme5bW
 dDc7+YkzrId/U0mWLlK610ke6u+qa8dKry51S7vi8/LopUHlWuGPT8LBGwQEO1afWN2jRvvnsZd
 p1TzWr+P0hLxWxXRs786dA7a47qDchD3Q8PGeAS90LZvPuj0UOcKUHe/sD7WrySObq0pSPGngRC
 OYxdGsVJSTyZIoP6iHhLSlBk/1trJ5ojhQDzKe3s6plfg6qv32OU
X-Received: by 2002:a17:903:2445:b0:235:737:7ba with SMTP id
 d9443c01a7336-23e2576c4f6mr284712995ad.44.1753097499683; 
 Mon, 21 Jul 2025 04:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy0SP0IPtWt7rG2CJ22+EOG3rH9Em2wLiPcQAus+iR9qnfli/f/Z0PcqZLFOIX0YI2Gf6t4w==
X-Received: by 2002:a17:903:2445:b0:235:737:7ba with SMTP id
 d9443c01a7336-23e2576c4f6mr284712315ad.44.1753097499213; 
 Mon, 21 Jul 2025 04:31:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:20 +0530
Subject: [PATCH v6 15/24] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-15-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=armenon@redhat.com;
 h=from:subject:message-id; bh=h1O+tXSFamRYzpOUqPME/GZKWYiLv8KlGKDDwk+ohfo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqRJGQ/XfBaflut0UOtR5yvHTZoz2KIX8TClaK/Ti
 tqkepmno5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwETqZjH8FWytqVOZ4S8y7cff
 BT0nap7Ls/Q780nl796a625w55t5OsN/P98Fmy1Z/2+W1Vl2Sc355MR/6Y76OgsYzdVe/7Zn6m7
 kAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e472f79d5d5c4fb4410a28cbf43c298be028f4b4..6887877f2f8648f66e34bdb1cc3ca6dc7514f9df 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2339,12 +2339,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: illegal resume received", __func__);
+        warn_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2396,8 +2396,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2635,12 +2633,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
-        ret = loadvm_postcopy_handle_resume(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);

-- 
2.50.0


