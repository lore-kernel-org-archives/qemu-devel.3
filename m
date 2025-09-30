Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C0DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rr4-0004a4-TM; Tue, 30 Sep 2025 00:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rqv-0004QH-Ap
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rqn-0002jQ-4y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6G3SrN0pZ8UoHUDlqNVP5h6JRKIWOY94Cyi09HxXC+w=;
 b=UZ79jCSS3x7BzD4I0RqCHGRNtu0Yi7qT2JaCdRbtpFaUQOL3R25413mf/WYbWmAOPsd5lX
 96xM9qsHW9gjzmQ3/pILMWRmqawrqistWp3TH2DNvB4iEzOKZG/xklwbeJRNS5uozs6IuA
 o+RT7bgaD1aGAsxEwwQJg7C4O4JB1jI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-E4PodJ2jOTaLwatEMjyoug-1; Tue, 30 Sep 2025 00:19:54 -0400
X-MC-Unique: E4PodJ2jOTaLwatEMjyoug-1
X-Mimecast-MFC-AGG-ID: E4PodJ2jOTaLwatEMjyoug_1759205993
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-334b0876195so5539373a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205993; x=1759810793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6G3SrN0pZ8UoHUDlqNVP5h6JRKIWOY94Cyi09HxXC+w=;
 b=uRVfUgtdQIpMmrIRgps4I/GX0ck58D4c3lDjDtBZfnofpnPUOR4uKyAxiJ0sa3Cs9E
 JGEEc4KoTf0tI4cDGezQDDn0jVLZQ64TcV7wZsdvXcHDjYUa7CtfVLm7bxnmQzVEKy63
 DS3LbEji6VcoKI7TtcB+2HzjcZfGnH3U7Xl5zeWPF2bDB7zn+PvHtgAxXFQ5Xmjn/h2U
 QtNvCAcIKvhXvLDqxEdTQUE6wX9hPdseDMtvVprP2IT11PMRm4a9RTHdvHEeef8tGJfh
 y2eKKGZMgAetDS8t2j93AUmEvOjO1IG9C+E51+tCHQ92ecmU9n5D5hjM4W8VO4CNrqS8
 uA8w==
X-Gm-Message-State: AOJu0Yz/fkD9X9CzW9CzClBhvRqyI/K/fLLAIa0S4GwM7mvTSk+WhySu
 7j24siHXex2J4Y05Ec7hTJLsUOFV2/3dV7LG/5ShpOUQyrQchc8lstfIa7XGumg8Hyx/bYBzPXv
 3VDEmTxLTWj22qmxfZxY2yWwgNs1+O4ep26p2qRSJC8G3UpO9BJmcuyC/
X-Gm-Gg: ASbGnctpjL42mJiy5qkwlX9AqUgfaqkrXleN2gO5HBRkcqqzocoWPL905nGwHPUn/5M
 pPdrpp1AGUGTovgM8lzJtWYy0eSh3JO8KBzhvkzot+4P1tKAAHRFaEHNryvBMI/cJi17bRq0Fck
 V8INSjmtUhhQCSMlmNW4vkgA2A3/t2GZKx/U7E21iNiXThcawf/YsITpZduJDdtHk666rgdGgT4
 BaUpY5NizT3GC2P6NJtwceUvDzpgn3zTdTIJEMzmW5ZPABOCXpvTdoA1PIZz8LvI2LByUEzjYU/
 +KpJ64n4019pKPRSYdgbYwnyICCxz1QK0H0Tdb4PZTn1cI1jKTMDeh8pqQ==
X-Received: by 2002:a17:90b:4983:b0:334:3286:8fe2 with SMTP id
 98e67ed59e1d1-33432869004mr21836667a91.10.1759205992981; 
 Mon, 29 Sep 2025 21:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPgPQDcueHEM9p7em4E4pJ2Dm0YxC0nvEZK0tyFvPh0FIJycBmc38GWmSPqQusbQDMhR5DVA==
X-Received: by 2002:a17:90b:4983:b0:334:3286:8fe2 with SMTP id
 98e67ed59e1d1-33432869004mr21836623a91.10.1759205992551; 
 Mon, 29 Sep 2025 21:19:52 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:19:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:17 +0530
Subject: [PATCH v15 08/26] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-8-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2800; i=armenon@redhat.com;
 h=from:subject:message-id; bh=aAtWgri0JtZvm7ozV9PyXTNhz41wAlyIboBcEWP5JG8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMGzDkpa90wM+pf7rb+qIjD/QfDZ7LvfC+XuHTafw
 bKMQfhERykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIkcnMbIsKJks8hpg713L96L
 k2s4YCT9ZXP41F8cxVwvt69Z5TYh9RvDL+atl3pDustTT10J+N6RuvYZ51J5MZbfC6uFlL+5LV+
 pwwMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 3 +--
 migration/savevm.c | 4 ++--
 migration/savevm.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index cf4d71d9edfa2a8a30e30e23ccbb3f72f402b6ae..a426ec5b60b8e929afe281c89be4e934fef40143 100644
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
index 88116ed278ae0e5c9b0dd055828ede69b0b876c9..9e30718995ec9a6dddcfb3dd9e9e1dc2d9d17aed 100644
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


