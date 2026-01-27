Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B3D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCr-00060u-Nv; Tue, 27 Jan 2026 13:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBq-0003Fa-GB
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBo-0000ol-Qd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11doODa03sbZjuwbDnglrajddNFqS0SpRI0bkxf3OKo=;
 b=jMhrF7KyObhJWHAdG9eVaCYsIfBTvY48jUZ2p4P3jEvmOI4tNF3OLynp1/t4YD8hsfyKVQ
 uumaFltdEqQ6M0wR+ybo49fcaRc6javBMAqut4k3HS0nzEZ6Q6u9uNoVQ8ygsRhSW6i41T
 W/lZlEg+FQCLrO9ItMwNTgR9tt1C5E4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-ZE5LovwNOQ-WVg5ZcDWwnQ-1; Tue, 27 Jan 2026 13:53:16 -0500
X-MC-Unique: ZE5LovwNOQ-WVg5ZcDWwnQ-1
X-Mimecast-MFC-AGG-ID: ZE5LovwNOQ-WVg5ZcDWwnQ_1769539996
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bb9f029f31so2158868385a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539995; x=1770144795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11doODa03sbZjuwbDnglrajddNFqS0SpRI0bkxf3OKo=;
 b=KI0Kqy3+G5+zbQJ3e+4U2gGHlGs8Zei2BW7UBMRaLOpJWHWWF+M+hcHL/Q1We+bop7
 /mz7m/GGz0N3nkxylTkUzVQ+SFIz5mzxaDbFSh3jShL/6Vsk2UBYvAatVoBibmq8fiwB
 bh8CZ0ImtjKFS6tI5kml0yFAZkkG9Ushz9HF9FXpK89zJMcvo+UA8S5AflSkUxQILj7T
 3AG6zFhI+qHglSjikuMKC0N6cOTSMzHGyHJLb68obQxCTUI/rFc89JIWV2Ikoecs7Nh5
 TBMmIwxbVvE3LpuW38AEDM11Emfb/5WrYPdRmRdYOhfZq0h0N2Bz5xov0tLALoYOr02Q
 wCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539995; x=1770144795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=11doODa03sbZjuwbDnglrajddNFqS0SpRI0bkxf3OKo=;
 b=qR7ZvMFYt30PGeahS1SKIGdOgn4fSaE0hz/YxMbMUrYjPfheHYl7W/AmGpfxIDrX4g
 SST70hJlaFCcLHVGSyoEME2ugEnontPElvaUmlrgE3C6lCiQmW1AFjUi1meCEsVohlMN
 wskhwWhl0Gn5c0s+4ceML8qZyH1SyIFM1zYsvM1aLaNiY0bJ6qchPp4E86Eh7wSxq5M6
 aiZiH2te9CV119VHHnIKOw7KUkJxSQB7CDGRymx5Mr8bcGYr0T2VKE6MZNAYC3fNG2l8
 A/hsOIW9EcpZY3Blrc2swGj/DVMy+vl6LTckcVzI9DvaehJugEV9WD7q9HDMne6NcHHc
 Z+AA==
X-Gm-Message-State: AOJu0Yy6hWasyFIyq5j8Yj/gHakrgY3buJfs2JfyB4XUYCWKlPVWFU22
 n9DTZ3wuVRhhdxrlIglvxCnJ01McMEP62JZj2NiifdM5WgblVfeSLlFSB6Wu6xayiYhGoy0QVV2
 4z/zsbnFqFoXsg5HNWfwLbw0tkrxmZt+yux/ErXrXmLdq3/uDxALEsAYWKwSMf3i/9jPVS5WUFf
 ZJh5tWkaJRi8hIEjpvz2efRsO137CJ7PmMMo6Dyg==
X-Gm-Gg: AZuq6aKE8Jnjt00zD6PrND9bFmvP5xdpRBg23LarmZ32JJgWDcgdrUblvfQxxHZc8A2
 T2kmF/zgKsfpjVflLiTa0aBzms9bLv4ZNq5T9djcK/z+4ODEhxtNkYvLMwAw0tO9gsrj58Q9gG+
 sB4YW3+hNT1+6gzn2O3fgXP0ghxjC4TaC7RpuEAis+Lk8eeDkcd8+WSpEUQFICquO514RtjcF5/
 e/2WJPz2V1oQ6GVFvMhQCYGV5JKwI3oO8kmRRUIzSI8oi4YkLy0LflJ1rczikpOKtADhlC3aRnI
 ZHfclK3QqVTgH6NkBA5SQU3ao5+PdW3eFw+6AB+EliAXWd1ZaTycIhcjkpeMgG4AcGa2QhRIEXc
 O
X-Received: by 2002:a05:620a:4091:b0:8c2:9ff4:a8bd with SMTP id
 af79cd13be357-8c70b84a289mr319096285a.15.1769539995206; 
 Tue, 27 Jan 2026 10:53:15 -0800 (PST)
X-Received: by 2002:a05:620a:4091:b0:8c2:9ff4:a8bd with SMTP id
 af79cd13be357-8c70b84a289mr319093185a.15.1769539994780; 
 Tue, 27 Jan 2026 10:53:14 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 16/24] migration: Split
 qemu_savevm_state_complete_precopy_non_iterable()
Date: Tue, 27 Jan 2026 13:52:46 -0500
Message-ID: <20260127185254.3954634-17-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Split the function, making itself to be the helper to dump all non-iterable
device states (early_vmsd excluded).  Move the precopy end logic out to the
two callers that need it.

With it, we can remove the in_postcopy parameter.  Meanwhile, renaming the
function to be qemu_savevm_state_non_iterable(): we don't need the keyword
"complete" because non-iterable doesn't iterate anyway, and we don't need
precopy because we moved precopy specialties out.

NOTE: this patch introduced one new migrate_get_current() user; will be
removed in follow up patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  3 +--
 migration/migration.c |  7 +++++--
 migration/savevm.c    | 12 ++++--------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index f957f851ef..57b96133d5 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -74,8 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
-int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-        bool in_postcopy);
+int qemu_savevm_state_non_iterable(QEMUFile *f);
 
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index e3f1cc7b2e..c6e54d2a3f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2545,7 +2545,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(fb, true);
+    ret = qemu_savevm_state_non_iterable(fb);
     if (ret) {
         error_setg(errp, "Postcopy save non-iterable device states failed");
         goto fail_closefb;
@@ -3678,9 +3678,12 @@ static void *bg_migration_thread(void *opaque)
         goto fail;
     }
 
-    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
+    if (qemu_savevm_state_non_iterable(fb)) {
         goto fail;
     }
+
+    qemu_savevm_state_end_precopy(s, fb);
+
     /*
      * Since we are going to get non-iterable state data directly
      * from s->bioc->data, explicit flush is needed here.
diff --git a/migration/savevm.c b/migration/savevm.c
index 41560b97a4..e1918d4f38 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1691,8 +1691,7 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-                                                    bool in_postcopy)
+int qemu_savevm_state_non_iterable(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
@@ -1724,11 +1723,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                     end_ts_each - start_ts_each);
     }
 
-    if (!in_postcopy) {
-        /* Postcopy stream will still be going */
-        qemu_savevm_state_end_precopy(ms, f);
-    }
-
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
     return 0;
@@ -1743,11 +1737,13 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
         return ret;
     }
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
+    ret = qemu_savevm_state_non_iterable(f);
     if (ret) {
         return ret;
     }
 
+    qemu_savevm_state_end_precopy(migrate_get_current(), f);
+
     return qemu_fflush(f);
 }
 
-- 
2.50.1


