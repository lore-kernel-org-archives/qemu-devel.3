Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9317CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGVw-000577-Rc; Thu, 18 Sep 2025 11:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVq-0004nl-NW
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVo-0002zp-Pq
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPRRonDI7v9CULdkpTnX724+UFIBp/Jcli88m3ndHPQ=;
 b=hmMhxrGWQ3UiKSTuaoGtqd9FXW0K34iQfxXW6rKE+DCCEEf+FiPOXuKr+of8k3NZwg7XDD
 jtC/8QuiTda5F1g4HylU1H7cfJuTKkRW242YiISiJPRetERPBFjZ4VZXFcD629DFGUckL0
 hlxEbmIU/9cy33JDQo2izgwvthYbXrg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RgcaTYe1Pr29BaSpBgPx9A-1; Thu, 18 Sep 2025 11:25:31 -0400
X-MC-Unique: RgcaTYe1Pr29BaSpBgPx9A-1
X-Mimecast-MFC-AGG-ID: RgcaTYe1Pr29BaSpBgPx9A_1758209130
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77e13772b37so128527b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209130; x=1758813930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPRRonDI7v9CULdkpTnX724+UFIBp/Jcli88m3ndHPQ=;
 b=oW5bv6sfpkS2pQ8g3PNCfIL9J9VCH33wSIFOexiNQv0XU7o7DN8miVRZ3ULF8TmIen
 S+gVF0b81ZhEIyRtQeDS3xOOsKdwI0WbYeajCgbnyK4qVcmVgTvfgfJy6QFiTYh3Mumf
 oZVyhSKnuvhjI5szAvNQ0XfIdSR10us7R/ypaAQLP1jh5FntqHWyz+IJkb5cc+1Kvydh
 UIQ+5x9sqkX0zqLVlL7WPzMvHZee/E6w9409JA73Kfm9i4nlAgO0z5+ueKnA7pMlLecq
 RYK/bMbMUl4HeZ2yKv6a9NdLOO4KFb2GIWESEitp8uk4o/4t8xPg/K2vOlpZH5bjfh90
 23xA==
X-Gm-Message-State: AOJu0Ywe6AuNcVTY8ucLxXh3/dbV6JV77j01JhOpn6GG9I1YnWrhn3Yl
 SOL8ZeO+nRRiiS9o+ksqgO/16agFRq+bfCHbv+QAIMQ0jFSlUBgePAe91ykdkkVVOaBf+oo/4Ue
 Wqxe4u7rpCvOnvHR7ZngGKtSMq9qKxfdm7N1HeojX35wdBZISTFGzFG/1
X-Gm-Gg: ASbGncui1OVxgCyBeeDLvUE9qzDcUnXSbgjta0Ai0aB51BB4SxTV1wRSTv8WccskQHq
 pYLXsUizWDdqxkGdsIDmCCFFKx/kI+T7jo1KBkDPfhXf7HYHsTXWUZGJZraDPcxIp0OCUUQAaHh
 mtlJKhZNGxmymKPdp6i5qqt3+6+4bajRpYAeW+uR3b/rYzfN/NsgX7NfOOXePVrD3/5ivuT/IRM
 tR9B1COrKzVs1hmyW7/wpllucxKK7Uv6bRuTswEQFwSvJ1tTeFpcFgV3CLl+TtYiQCfmsE06RBx
 AxSnnhgeBy5Y0tuUPeNYVRsrI70oZZzljh8reHfITn6qF1XL1hK0+A==
X-Received: by 2002:a05:6a21:6d86:b0:263:71ee:51f7 with SMTP id
 adf61e73a8af0-27a9586ba4bmr8962429637.24.1758209129984; 
 Thu, 18 Sep 2025 08:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMuah6p8Lj4os8pSCNCMoJDCYCF+l4cBohev7TpDVWRdsoSXdbrjQ5xyeQbkS83C55eyWzwA==
X-Received: by 2002:a05:6a21:6d86:b0:263:71ee:51f7 with SMTP id
 adf61e73a8af0-27a9586ba4bmr8962380637.24.1758209129561; 
 Thu, 18 Sep 2025 08:25:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:25:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:29 +0530
Subject: [PATCH v14 12/27] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-12-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=armenon@redhat.com;
 h=from:subject:message-id; bh=RY2oIVqr3QDclIGMM+6BjCwpbbpRGE9+Nfi4t5ye/aI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R83zba1WYs8cf/tWXHgzbwnWSeT31ll1Jycey5bO
 e2i77HDHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACZy0ofhf/rpT28aPrO0CPCF
 W7N+ckhYECd99+Ihq98v5cKe/peKmcrIMJ+bcckWi+lL2H6sdL8uYSkdLrlWfl+al0n4vwVFl9x
 LWAA=
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 642d17487d92c0a9508e599ca3bf524e80b6fd46..07a32044b58541eb9bd7c5e63eb6ca598f8a8933 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -847,10 +847,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index fcf76cf73595c93e7616ee7341f2e02a598e4e3b..16250faed91781843a572fe1ad4d71a37a2847a4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2656,12 +2656,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2670,8 +2667,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4020,10 +4015,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081a4446442b544d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index c8234f2ef7f413b207aebae7192c82f1f4d6d91d..d54028b1be4d7a1e4615c2b05611535bd7478e2b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2588,10 +2588,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.51.0


