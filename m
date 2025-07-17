Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61BC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCj4-0000Yp-BJ; Wed, 16 Jul 2025 20:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgP-0004OK-6E
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgN-00058c-FE
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9K+eUMW8Z/qcW7yHAKiGqcj+tGq0Mu6JgX8ofdTzEs=;
 b=dn+WdUjAToslc+W/T8+cPWnIr6v16wuV4KT/jD33te5YlONk+dylANIq/kzh2fqIwW3Zb8
 o7+qNb8ctoUlBnqK/xT2A08krPU1/eQGQoJ5JIFPCnjwWIeLDUycNiqK2LnEJtbfb7cALW
 WMN03CdKaIiuhvr3Q5jhWpy6CwKm3ss=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-yw6uQShQP12AaVsA5loRFw-1; Wed, 16 Jul 2025 20:41:05 -0400
X-MC-Unique: yw6uQShQP12AaVsA5loRFw-1
X-Mimecast-MFC-AGG-ID: yw6uQShQP12AaVsA5loRFw_1752712864
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313c3915345so599583a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712864; x=1753317664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9K+eUMW8Z/qcW7yHAKiGqcj+tGq0Mu6JgX8ofdTzEs=;
 b=XMW78FXK51LpoWHr7VIKuELqkBXs/GW1zTPM0hM54uDXNieG/plwdwM7qmRRE8hzmq
 mH0HUKdJ6JSKOr93l2ITSGLFVWOlXjmLwDGnZUPh+mHOFc4gXT1P6s44AcWksvgFkuPw
 joBUF6Bpu1F7IP3EXDOG1GSPvqI5soV0tYbymIgN9YxtiP6nQAEedUGx1L3TW9i04t0l
 1W1PtGckQ+lN3a4A3YE/MmNr3KfEwB/7u5Y4uA5p2NHAegtWlRgT1klO2pXmBYv4C3iV
 +4qBisU6O5ZRZFOu57JhZK6KbGHpLSTmr+jt3LoVaZl2dhu0NTupKpG2p5aYoY+RxXH4
 LNvw==
X-Gm-Message-State: AOJu0Yyi/9ELEWMcb8J8Ou2AtWg7gFnjOsk3f581SCCUIdNFpj+sB/O3
 QzE7zUM4O+Kzyhn5Wp0kbXj7PWmWqFZP5S4WeUQoch+RxybgIsYC7pQg6pwJe7gHwV96HxziRv3
 HCivIzj+B3H7FYrkWwGCZY62eNfm8kw5yeqQOlRePPG2moXssE2i2zDOR
X-Gm-Gg: ASbGncs1MrASiez7vJMRyCFtzHqDZ9ptjFeOLBygkG6UCGojuVNdP6BHAW3Arxpk7dR
 tAkGQzTvnA3VQz8qf0MZXCYK9L9s894z0i9/+dWAaSvn5TBr5t5sSEQ+BEkJSahQyuc47PdYb8E
 dhKW+tIZsCZghLTXTrd0eq1G0HZ2MOXoCi5UBzjWpnBwZNVBRqxnEm3Uso7klGFFhn87QLd4ZI2
 vg4ZlaCZLkvBhK7W9r59IA1BTMnGkm9OOBLIeGgGEgCpR2v69UtxmoSvZ2Z4R9DeHsioC922pb1
 DSAV+7/6Y5qi9RpkiE7MKclO5rhQ5trjNuQD6QK4Jdo1Oa8LZL5v
X-Received: by 2002:a17:90b:1fc5:b0:313:f6fa:5bb3 with SMTP id
 98e67ed59e1d1-31caf8f0301mr1405494a91.26.1752712864203; 
 Wed, 16 Jul 2025 17:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkM8dTfpF2MGZgEmCDjuNe3x0w0IUTLOIz8GQ8eVtHl2j2WX64K0wJBYBwpxTo/nwQwV5V1g==
X-Received: by 2002:a17:90b:1fc5:b0:313:f6fa:5bb3 with SMTP id
 98e67ed59e1d1-31caf8f0301mr1405449a91.26.1752712863795; 
 Wed, 16 Jul 2025 17:41:03 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:37 +0530
Subject: [PATCH v5 14/23] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-14-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=armenon@redhat.com;
 h=from:subject:message-id; bh=/rjjjPmxInj+gIuoi4bwZ3v37E8vy00w8YIIPjAsuUk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm6JMd3iQ7y12HaHvR7R1tJ69rVEq/cY9Z+p7FsGHv
 Dk66t86SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATMTKkeGfrrZKl2LPlAdatjtY
 p26Z0herulKHVStu2kqeK7ybY64KMDL8PzvRfGewQVmnPuf8qANvfGY+r+FilDewS/zyatO0viQ
 +AA==
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6f181c381dc6ecd996a1f8dbc25cceead7ebe014..20dce4b43a181d2f47b6b22e7a15aa4fc45cac5c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2333,12 +2333,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
         error_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2390,8 +2390,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2633,12 +2631,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


