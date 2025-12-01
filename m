Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A7DD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9pu-0000mD-Cq; Mon, 01 Dec 2025 14:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pt-0000lV-9F
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pr-0005Hr-Qg
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ei5GzZtaaE49DgNpGQUcvBY5Y72imNtgDnIb0VB53hk=;
 b=ZymHLHSQIiJ0baD4cx1w+id4WYIBE2vf8/8RVfC2LP1UV3JiwpKWz5g2zhPqPiuqwVytvx
 8KUEKYssKQeuSk0ZpMLmGWyNOG58KbZh63UGevz1bqFnf1+J2N7/RauH56QMs2lUrVbRvi
 z+bgn4jO2MJEgRTlqeQaEGBieaHqZiA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-UXxaeNOpNrKMwVud99fTyg-1; Mon, 01 Dec 2025 14:45:21 -0500
X-MC-Unique: UXxaeNOpNrKMwVud99fTyg-1
X-Mimecast-MFC-AGG-ID: UXxaeNOpNrKMwVud99fTyg_1764618321
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8823c1345c0so48212636d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618321; x=1765223121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ei5GzZtaaE49DgNpGQUcvBY5Y72imNtgDnIb0VB53hk=;
 b=oTQeavfHueMGmy6ffCP/szC0DYsyS1CiyyWIHCx5/ZGK88QpPXAiuJj2AQV72bwZQO
 V27TZRInoPlK/nL2Ge5JlEG4L+3Urv5tFjo97qsb6zc35oWanPVm/x9nFw+fP6HGub1u
 38AdpREiW5bNDd0edVe1te0jSmLpNXqpoCvxieiV7i5kYrdDD9UZXh19OFvQ5LPEDXr1
 XyqBcnyl76IWyLN23g0sp/JmAaGjh0DXhAJENoiTEEezUuv4FW354N6IYb9T035XiKq3
 vhrHj35xTQ76xhEFP2of4BjGHsx2rPAWGsqg/mT6E9/BDSaIHbQMsz/1C8kyw0a7V1aG
 COOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618321; x=1765223121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ei5GzZtaaE49DgNpGQUcvBY5Y72imNtgDnIb0VB53hk=;
 b=TxQTmuPFo/wbf3aCRYCTgY/YLi1CAbyMY7iPzXynRTAMknQMeEMyhckBEGyg0yzR23
 kyBMu4MrF2pt191qLtPWI01wBgMFk/2EVNHTK40O7CX0OhTFL2eCo7ybwqQ3bLPDlEHD
 I7tEQcKfFLw2AcheX8KseYqp+6bzaAKOJIcFMvoFeED5JUxcMhazCIGbmr2NAGReUlv4
 bHIC8yOqQG5fg1MLriP00R83xAu0q1z6nPtWcvJGHneQrfiNXBmEkawy80Rx5M92HXME
 y9O06gpcAiYPTz4aHQALuDciow9gJ/5nCCzvZcz5u+xiJk89saYEHl2Bieit2xcc8hMY
 CeEw==
X-Gm-Message-State: AOJu0YzAxEEAqWu3ic1TGInFizgIzUtr/h5QeeBXfL6AbFvlJJ1VGdYt
 Bij8vwEIpTU8hYsM7zRShLeSsZzPaSf8ZP7vgdmi3Jm8oIc/5+Pz/Wrxno9FS8p0WH9ZmLbV8qE
 jklc5J/wAfKsRJscfVF2pR3cpo/aPWAdFkh2puRiFs4eS68oGkLXP0IJfAvFDYmsdZezcLPIcN5
 AuznBEqlWPGVgWsPDPkCvg+OlwzyAVFXRWnRmiSA==
X-Gm-Gg: ASbGncsiXkvXM4XaB0mNsEnltyxEo5PlhYiAvAAYkYL0N4ZWmZvKbbUBlRLLeN5nliT
 WcK2NvJ/nZd+DVOCRrEleLD6/yleWrTVMz6bw/+PRtnM6e30sD/r46L2Vn+WqFFWF1NqXpI4aku
 drt5Z9aDNNxFyoDpmhdMoIDgh/8p82t7izVO6Ee1CiE0WtjhE0HBvELyXVgeKA4ygGphOcOhABg
 LPF9NWUq1m4o3Ngl6vDKSoVSZ7EDQ4cD3hQJNni26Iu2ATHxdqEY5VNSdumUWpgjFN9kZX99vXI
 zzRWNbxf3i7YBaQInrAMV4jqP+nHmEGzVEfhUWL85NEZR6X/7i6cPUIfDjIRjUHMf538VP3c1wv
 b
X-Received: by 2002:a05:6214:4013:b0:879:6db9:148d with SMTP id
 6a1803df08f44-8863aebaebfmr402159456d6.27.1764618320841; 
 Mon, 01 Dec 2025 11:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaTMiMx6Qtj0uk/a5zOoT2P2XK+rMlGa4yQ2xsHqDzd9d4mjL06JJIy53MAICsPZCSYGiitg==
X-Received: by 2002:a05:6214:4013:b0:879:6db9:148d with SMTP id
 6a1803df08f44-8863aebaebfmr402158446d6.27.1764618320050; 
 Mon, 01 Dec 2025 11:45:20 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 4/7] migration: Make migration_connect_set_error()
 own the error
Date: Mon,  1 Dec 2025 14:45:07 -0500
Message-ID: <20251201194510.1121221-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Make migration_connect_set_error() take ownership of the error always.
Paving way for making migrate_set_error() to take ownership.

When at it, renaming it to migration_connect_error_propagate(), following
Error API, to imply the Error object ownership transition.

NOTE: this patch also makes migration_connect() to take ownership of the
Error passed in.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c   | 1 -
 migration/migration.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 462cc183e1..92435fa7f7 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -95,7 +95,6 @@ void migration_channel_connect(MigrationState *s,
         }
     }
     migration_connect(s, error);
-    error_free(error);
 }
 
 
diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab..0ff8b31a88 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migration_connect_set_error(MigrationState *s, const Error *error)
+static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next;
@@ -1602,6 +1602,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
 
     migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
+    error_free(error);
 }
 
 void migration_cancel(void)
@@ -2292,7 +2293,7 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        migration_connect_set_error(s, local_err);
+        migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
 }
@@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migration_connect_set_error(s, local_err);
+        migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -4039,7 +4040,7 @@ void migration_connect(MigrationState *s, Error *error_in)
 
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
-        migration_connect_set_error(s, error_in);
+        migration_connect_error_propagate(s, error_in);
         if (resume) {
             /*
              * Don't do cleanup for resume if channel is invalid, but only dump
-- 
2.50.1


