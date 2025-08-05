Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A7C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMPy-0007wY-RP; Tue, 05 Aug 2025 14:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPZ-0007Zb-RF
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPT-00046K-JW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfDi0LWRLJYn6ZKTqcgSA+6qvy9VenMBsdYUplH95hk=;
 b=X41b+29sqCDaFng5m+JnnqxwQkYOdidRZbx21k6hSx2/7V7QZCyBGQvACWaEXpO+QGdCPW
 coX/M+r3kJx+j6zyPxU0kBeXWzwVPm8uetOXdk4elpQZ/7mbO0JR/Dkz8iZW16mD/z2J6K
 0zUDPh+rSs/GX7AoCr9l4C8PjlbG3q0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-VgWZGgq7M2ifdWpdqN0G2w-1; Tue, 05 Aug 2025 14:29:07 -0400
X-MC-Unique: VgWZGgq7M2ifdWpdqN0G2w-1
X-Mimecast-MFC-AGG-ID: VgWZGgq7M2ifdWpdqN0G2w_1754418546
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b0e0c573531so4492068a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418543; x=1755023343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfDi0LWRLJYn6ZKTqcgSA+6qvy9VenMBsdYUplH95hk=;
 b=xGoze9fo0lDCwdEzBXA8kCHMqSWEhp07sr9Nw34VIoIunzIHbYDCNRSrlbaWpbaENR
 /3FQzCzxLrCqMLizNZmElIMfPz7V1Bd7e9Nv/UhJLFKV54cZVpnk5PqfEMjYA8QUt3am
 AOt/4bR6/LPsa3j6pBLVtHauz/aiPIYdc5S49MFmBwxazGkU/TH5yPMoPfseFzRb/jKI
 DY8ao7f+qdBk8PBKpp92jHfiPQ5aFGjiP7shE41CJ3XMC7WBCKqNtYiacrb3qyEAx/a5
 JksDTBke55i9bFz8AonWjiI0/Kl4nzTGiMLMezXZcpDOmQWCIAQiAIpc4h1Ut69CDtgu
 D4yg==
X-Gm-Message-State: AOJu0YyVXG23GijPvKDwLak3Q4KWsZpNz4L3FNT28YcQGoW2JXkg4C5a
 eb1Ebx39m909M/CuSRE4qqva8fdAlbEbt1G7I/FC3Tj29meETPfY5mfskp1a2GgPxINrqBoTBnU
 GOPbyUn2bbu1+t/L3xf60RZjMmlo4EQ1ZKNGtvbxV+xCaTz1O48l6YcaP
X-Gm-Gg: ASbGncsFeValZlw4odkk0dY8c/bv4Qns2yvvNh5zVDDOqhhm3eRUjt1rpK5gzxYGOQ3
 DnCrUbRSwo5KXguxdpkyQ7jgpHeipxQtHbsbBiiJf7IfL9owUDulPFm1GKYwL1UVhOJGtFEKkxt
 fHV1qzgLgyjkEq66kpiSpj4lw/wDFjn5w1c5SwA8B9/hXKg0kuWAKVC/oXeFDOsrcbUspwFU07i
 QelCNS8C+dxqkfIUUrrWyOyCUDH0JeAd34g3GexXgGPQPDkab1LTi31sul+YGzxjG6kiLcyeqoW
 7HVuQYSuL3HV22pSWXRmDkxhJDPhOR07H2ToGxOoTrHFPbCsug==
X-Received: by 2002:a17:902:d4c5:b0:240:3f39:2c73 with SMTP id
 d9443c01a7336-2429ed75ef5mr2138595ad.0.1754418542547; 
 Tue, 05 Aug 2025 11:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZjMLwLkZFD2MdH0uZ2thibcFBh/3O2wCWHNa3LWKUvlVFlAUsobU5V/xjFBoQ+B4xow9WdA==
X-Received: by 2002:a17:902:d4c5:b0:240:3f39:2c73 with SMTP id
 d9443c01a7336-2429ed75ef5mr2138205ad.0.1754418542105; 
 Tue, 05 Aug 2025 11:29:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:15 +0530
Subject: [PATCH v9 08/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-8-123450810db7@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=armenon@redhat.com;
 h=from:subject:message-id; bh=7XhuvyQAFZYiJ2hf8Ip0zL5iR+8ddAVO1LkYs2U5Wpw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+n6tqnSi6XmnwtoYfPYbrptnu2HRU3GQVN/N89v3
 P8r7dvzjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABO5t56RYeUC+/Wnnn3+eF5/
 99eMf/dTyz7PDPmwfvajxV8Non6btC1m+Csea6h62qHS9f+lV1MC/p3+YNs9a+Kv4zIXbgmoNhj
 vYeMFAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index ca166ebd397ad80836ed2f9cb20a92f704fd4ed5..f3b91c8ae0eee6078406081f0bd7f686fed28601 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3253,15 +3253,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
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


