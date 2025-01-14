Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED85C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq11-0001t7-PE; Tue, 14 Jan 2025 18:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq10-0001rv-7l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0y-00043u-J6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZE4uhT0efoyzNOkHySdc0SxAsnss5S/fqug5y/Yd9+M=;
 b=Cc1sWjb/Y32Xo2TB+lbnPQ4lsnacyBUFlRcVLAXm3rVdqsXyjcH/aims3jjAdpyyGuJCHK
 ElR/5uuPjCg0rsBdrVq5k/EctyIdwdMohb53B3c5VOrqOxdc8u34Fb4N2p5UQaOnP0BP8k
 0+SNtzICeMP4RgReFINgQFfRogfUpts=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-1hkkFWGcPoyf7kr4d-McAA-1; Tue, 14 Jan 2025 18:08:01 -0500
X-MC-Unique: 1hkkFWGcPoyf7kr4d-McAA-1
X-Mimecast-MFC-AGG-ID: 1hkkFWGcPoyf7kr4d-McAA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d88d56beb7so58884066d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896080; x=1737500880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZE4uhT0efoyzNOkHySdc0SxAsnss5S/fqug5y/Yd9+M=;
 b=X3+v0YwWirFWjJYYw35KmrFkD5Kfg3Qys39qOKFD69nvnoP6Tzw1IsqW6HuInknuRQ
 OVWqJQM6roL+6paI1AcSKw53/u53lSEDJx1tGWNHQ/wuVOXPpM5AmG6PniIPiJ6Ei9ez
 WGuZwR5jLSSqKVSyZFpdddYFzQj5SNbGSv8Q3vcBAw4wZyomqgakchtKV9shc3mQ1QVq
 00uIMhHC3yytZExSCxYblUOh6w26RqGx68FrHGfTL6twqeRMohqwEBZVVTl0bpgIRq9k
 qYp292LaPgkFd4gdNpsCbR9KyrwVfqCkfGR4kUhlUaUAKrHVKJE/oJntbjDpiXbm2ZS+
 9f2g==
X-Gm-Message-State: AOJu0YwSoiTzgIuUQPDYMN8bKdvZZq3xzTcee8MaKaz4Ssjs/NXgR4dd
 ay9MLxuXfjamK8ecuQeePyqNBbWve5/rmGUrI4qCdTAwRObtA+HCYWUmTW+8T0t+Ig7IBhIWlR0
 NOb8Lckw3rvtiH43KLupM6DyMe3w1p6bJiwXabGMRY5KrJCXKnMVetvBgYa5YUSQ50OzQm+7KZa
 mCobRz/YYQjeJ74WBwFU1zqeVu7p14DgeIdw==
X-Gm-Gg: ASbGncsSN9GLw9wtwpRIvzUSIlyLUEwtRmkb3P6aV/HF7NcxTTiIUiDuvOQiAhDz8XN
 VOxIg4oyb6q4de+hOhRu8prENDKulMEzL8Zxw0KHPCYpKSoqBM8/OJAxUPmLpPTsTXkDqVq+Z0b
 JbylAZMwWepreAKaElQcIsEFFluUh/hkW5nBOepKoFHCB0pPle7EK+zjnwGlRnmMQC6ylVeXuOm
 ZgFu1IDiBOcfi4gu8lcCgbMXETzId3U5Ai3k5WQtubDeCeetBCIn8vM9ZwC2IhOY9Y01FssrnSN
 wkw6Fp1KrBCj0VPOQF3UX+kBcpxCqlpu
X-Received: by 2002:ac8:5f95:0:b0:46c:791f:bf56 with SMTP id
 d75a77b69052e-46c791fc14bmr389799471cf.1.1736896080376; 
 Tue, 14 Jan 2025 15:08:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFauVeM+N8uZ0sh3dY0onunMx9Qth92WECogV8bnz00fM6yi4AE6QY1h/UVQiWhIuuraCnIPg==
X-Received: by 2002:ac8:5f95:0:b0:46c:791f:bf56 with SMTP id
 d75a77b69052e-46c791fc14bmr389798831cf.1.1736896079803; 
 Tue, 14 Jan 2025 15:07:59 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 06/16] migration: Synchronize all CPU states only for
 non-iterable dump
Date: Tue, 14 Jan 2025 18:07:36 -0500
Message-ID: <20250114230746.3268797-7-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do one shot cpu sync at qemu_savevm_state_complete_precopy_non_iterable(),
instead of coding it separately in two places.

Note that in the context of qemu_savevm_state_complete_precopy(), this
patch is also an optimization for postcopy path, in that we can avoid sync
cpu twice during switchover: before this patch, postcopy_start() invokes
twice on qemu_savevm_state_complete_precopy(), each of them will try to
sync CPU info.  In reality, only one of them would be enough.

For background snapshot, there's no intended functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 +-----
 migration/savevm.c    | 5 +++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b33baab950..33c4824b68 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3622,11 +3622,7 @@ static void *bg_migration_thread(void *opaque)
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
         goto fail;
     }
-    /*
-     * Put vCPUs in sync with shadow context structures, then
-     * save their state to channel-buffer along with devices.
-     */
-    cpu_synchronize_all_states();
+
     if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
         goto fail;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 5e56a5d9fc..92e77ca92b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1531,6 +1531,9 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     Error *local_err = NULL;
     int ret;
 
+    /* Making sure cpu states are synchronized before saving non-iterable */
+    cpu_synchronize_all_states();
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             /* Already saved during qemu_savevm_state_setup(). */
@@ -1584,8 +1587,6 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 
     trace_savevm_state_complete_precopy();
 
-    cpu_synchronize_all_states();
-
     if (!in_postcopy || iterable_only) {
         ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
         if (ret) {
-- 
2.47.0


