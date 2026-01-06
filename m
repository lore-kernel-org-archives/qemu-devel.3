Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489A5CEFD01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDkK-00085u-N2; Tue, 06 Jan 2026 15:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkF-00083F-AY
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkD-0006nQ-LM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767731612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tELp0ADOrzTvawx7SvZTi9dBis++lNC2L7IG7U3eZmM=;
 b=RlKyzzb0f7j3VWJgmzJbRsKUIbNHkNJlaFrau2xWnjNxnyb6LaM1v/BHdhPB7ekkPKg3me
 AC1EYKAN57wn+96RciKVgyj/nICly4IRHLgrbr30M2RzZ6QevlMYVnsFvyTGQFla0Bc58f
 S1Nik6wru98vjik1uvRJnzOJQW8A0EA=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-m8hH8dssNzuuwSSGJsetEA-1; Tue, 06 Jan 2026 15:33:31 -0500
X-MC-Unique: m8hH8dssNzuuwSSGJsetEA-1
X-Mimecast-MFC-AGG-ID: m8hH8dssNzuuwSSGJsetEA_1767731610
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae546fa935so3069370eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767731610; x=1768336410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tELp0ADOrzTvawx7SvZTi9dBis++lNC2L7IG7U3eZmM=;
 b=WkTScdouytaK7rmz0Bt4JbUuCn2Di8Q1+4eSgirZZezxTifjNsz33iUKXt9SQ9CMgr
 MxO03lkkkThEdIsLF8dGhB/NjdTSFWQOPswEFecb2a/diEQZqpJ4QC4Zx83NQkKAIYe5
 nCT2pbw2FY59/3mFTFp4iibCh4LzrJtKq3I7niz/bLBQqs+HRKOOIs4viqovWv9aiYtJ
 OmEV64o9qOWtdGldYlAikESLXLScHHRlljZLvVjZVQ0Udcae0OpwUQwI8FGGZMVchwiQ
 JUwLIAO8ybhNWz9PFVAOYacjc5xKfSBJX4hhD0CfXPHK5F7uGCKHq1A5OLWo6pugATpO
 wSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767731610; x=1768336410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tELp0ADOrzTvawx7SvZTi9dBis++lNC2L7IG7U3eZmM=;
 b=Ur5VaL3ZynxCa+iTe/0wP5FOD9jxMPHh5jmTBADasDIr+NIqLfx6ej7GTqzGCT8hxf
 ttKLCpO5fFaABjqhqTO3KDLgNrVrPvUzTBcE0dbQI5oSJmTqVkIT2eakGB5tjsunvv47
 3DIWfioaVU3vqQ9fpFU/2ICxXzkbdPw9nn+p5ztnaPI4KdwsNUyg2wMQP02beDSiJ9zX
 u86RszsU7+ZzudbfGmlnXV3h9k251925E4PfAPkiI0CmETjsWPgqadfFZKKgjqmVTITH
 GsljZsYUblGIVfUA5L29aB8HMXKJBBUVyZT7ZhlAgF1Nj/6R7KcfhO6d/Lzw2e7tKrXO
 Qdhg==
X-Gm-Message-State: AOJu0Yzai0egXx+x1JT8ah8Va7RNNZjyiLlLfil3yDYzL7MAxpmz9JVl
 k/isLLRKP4fEAMaubj3y30agDnPUMrtzOO8+0zzhYHGprsaBjOsf97RFILpIkW+1vq15UXpHtFZ
 /0738GERBCntZMge7N9DQ2Ge/866gDHbUiP9ENQ4fvKCpkcAGXXBMvBUqEKB7ac40fvhw/0RdKX
 hYwKQ7cxvDWv2BnDwskOmRX0HxGN0PTH0n9E0/Dg==
X-Gm-Gg: AY/fxX4N674DR+mP6LismD2glm8yWWp884t+GVPTrw2jhVeTAxNzPdeVzMs9tBP/QCV
 hnvuLzGJlVgTR391W1VnURM9ctREiiUtoLIRarQRXs/uawhzH56kbQnBFVqPrtWQL2oVuByHHO1
 ZpJrcCbD4y4zSJlP6LLAYj3kdwlU/gMtd5TYhuxqm2i2LR9vqS+CHpgEtO1kJWlxueb44CHvHPV
 NkY+8KP9/YebvHnhZu9FKjcmdNuqeX2ACt0WsE21sQPTkBQL7YYiOO3oEU0oNecDsOrhsh8N5+w
 bNUqE8JzRoOskZg1Ym7v6Y1s6ko7kIcj7HyiRkpJWDBhfTdK4SZnuk5g0SRJiXQ+FkQduj5rlXz
 W
X-Received: by 2002:a05:7300:d0f:b0:2b0:4902:c189 with SMTP id
 5a478bee46e88-2b17d30fc64mr120232eec.33.1767731609775; 
 Tue, 06 Jan 2026 12:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpJpL+jaxWStco/1f/gEL+0U/3wwo/KhucjJ17xsv30zUq5g4ij2pi7qZW+3/XEQ5Wu7Cn3w==
X-Received: by 2002:a05:7300:d0f:b0:2b0:4902:c189 with SMTP id
 5a478bee46e88-2b17d30fc64mr120212eec.33.1767731609193; 
 Tue, 06 Jan 2026 12:33:29 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17078dd84sm4819273eec.17.2026.01.06.12.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:33:28 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
Date: Tue,  6 Jan 2026 15:33:19 -0500
Message-ID: <20260106203320.2110372-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106203320.2110372-1-peterx@redhat.com>
References: <20260106203320.2110372-1-peterx@redhat.com>
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

Now postcopy is not the only user of start_hook / end_hook that will pass
in a opaque pointer.  It doesn't need to be defined in MigrateCommon as
part of the framework, as all other hook users can pass hook_data around.
Do it too for postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  1 -
 tests/qtest/migration/framework.c | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ed85ed502d..0d39bb0d3c 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -230,7 +230,6 @@ typedef struct {
     bool live;
 
     /* Postcopy specific fields */
-    void *postcopy_data;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e35839c95f..4f46cf8629 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -541,6 +541,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
+                                    void **hook_data,
                                     MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -554,7 +555,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     }
 
     if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from, to);
+        *hook_data = args->start_hook(from, to);
     }
 
     migrate_ensure_non_converge(from);
@@ -582,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 }
 
 static void migrate_postcopy_complete(QTestState *from, QTestState *to,
-                                      MigrateCommon *args)
+                                      void *hook_data, MigrateCommon *args)
 {
     MigrationTestEnv *env = migration_get_env();
 
@@ -601,8 +602,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     if (args->end_hook) {
-        args->end_hook(from, to, args->postcopy_data);
-        args->postcopy_data = NULL;
+        args->end_hook(from, to, hook_data);
     }
 
     migrate_end(from, to, true);
@@ -610,13 +610,14 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 
 void test_postcopy_common(MigrateCommon *args)
 {
+    void *hook_data = NULL;
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
     migrate_postcopy_start(from, to, &src_state);
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 static void wait_for_postcopy_status(QTestState *one, const char *status)
@@ -742,6 +743,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     g_autofree char *uri = NULL;
+    void *hook_data = NULL;
 
     /*
      * Always enable OOB QMP capability for recovery tests, migrate-recover is
@@ -752,7 +754,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
 
@@ -808,7 +810,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
 
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 int test_precopy_common(MigrateCommon *args)
-- 
2.50.1


