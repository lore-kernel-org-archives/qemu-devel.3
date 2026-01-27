Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40DED2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoBY-0002sW-2X; Tue, 27 Jan 2026 13:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBT-0002nJ-MP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBR-0000fQ-I0
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z915HfiCgLhqURJikNpU2uE24hBu9+Px9ozkKqRlxGE=;
 b=CkerWnj1HLFPpkkeka+NvyxP9bF1rKaRVkZY9A4zU1bRbpWx+RLp3ptZ1CvOB8otCp3h9e
 z4dcjYCPxTsmdbk4UGd1oyoEDZO3RkaLpTJuij+c1eV5TaiyvLIDVspHgZN4fHKHJ9MaBc
 1Q3AgnAuny0VCfXmtUv14qu7CfK3fTI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-EPgAUSjaPH6JQiQrOUXGWg-1; Tue, 27 Jan 2026 13:52:59 -0500
X-MC-Unique: EPgAUSjaPH6JQiQrOUXGWg-1
X-Mimecast-MFC-AGG-ID: EPgAUSjaPH6JQiQrOUXGWg_1769539978
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-890587d4e87so226809686d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539978; x=1770144778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z915HfiCgLhqURJikNpU2uE24hBu9+Px9ozkKqRlxGE=;
 b=P6Xpv6pST5lDuY1dTxa0jHncK22/XAcnIlF9u9zcuG/DvkjGhXcO0LCQ4lJjDTfg3E
 SsyukO2UIh7eGdOBVR4whoFUA3tq1+okOEEuOfTHVV8He2v18rzDTPpkWoj6NyevaiN7
 Bq0d0W751vkZQWqtLD3n+04hTkGJKFWfQb2cGyCN6iP25TXARPpAB20Psa73f22Ia2/N
 urCtXzy5JwiNpj+Vtx4w7mnyNhqk0G6aNtJjZaenCIw0G11L/hx66H/ZaWr4l47p+uN7
 d92OLoyBly+lhIVHQdR9MAY8vB+mY5yC7aMEUTK+P361Z9cY3oXIG8YdhqTzDQinJT2M
 j0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539978; x=1770144778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z915HfiCgLhqURJikNpU2uE24hBu9+Px9ozkKqRlxGE=;
 b=GpNEE4spEzbI9JVhoY64CMe51OnUAtVA0Nhn52an+zKMf3q5UyWJDzlD8FxBu/tj2H
 wg6sH8yBfB2zuxvBRg8c4Az8rY0VzPt4WdYLq68pwDE11v161Mb3kFtjWy22yGYtnSdD
 RRDcLU7/ttNnf/4KzimXFdauA6sX+PuKCiGsgdFgM5DcgglrrCU0pLv7NGbFhUh8Vt3b
 k9M7F+bpUhiOTQWuqcfmLiyYBWt6MBPHAeLjRnFSyFNxK9DQaT9AykeQrrOmmPaHQweB
 fEwhgO9F082DTRhfgRLyFYhKi1I3gze7SJ4BOFo7VtLwEn1Ni44NQqXnnZAMw9JDQw2R
 XQLA==
X-Gm-Message-State: AOJu0Yzz+Q1Sdyhirprs/FcQb7tAJbKNEhr+TvYUYXY7oPWVy8/JcN+K
 R9Jm8NzlJfvfuYJpgTb7BiFFcRAyDwK+uWO8Nkuqs1+DHakrDw0zW+hbIkwNib+GBFlCYZG9wPZ
 0gPzZ0uzwNCep6x9QpiGJsqjgKhQSY5xJ+AqYWUOtDGom1WU4uvO2NhOfifNwGln0JYcvf+9scw
 sJIR3WSFrtDGFQ11Plushe4RuYy2oHqJZBEf3Mvg==
X-Gm-Gg: AZuq6aI+qBKN0Kk1uj6gQNJOxBA2Zqcd6OUgcX4f/hEUD6PLH1JzprYbblBl8VqXYWc
 HYrY9ZDTv+bHMpWbRUTN3EvDuBGnjkQRROyrUdXXZD3ltMpDgH28QfP7wzGXZRu1iqlAIRPyZz9
 a8Aor3ub2KOjsVyLsRhER1F4jHtIJ75eCllFqzJ4aGvzFMqFgsYlnrElsZrhk0vBlx2AWlbHZAf
 DTC2vnR+aPwoogAQ+NiZ3KlDrjkcRhFztmKtEJTfEonvSHYWN9pi8onHSAlU4Xmm25ESu9/1fXg
 nHfaESjUVwxskD8i4+ZawMfolhXXCAB6TtbkrazBVP8KobFpRauIzCGy7PrSsgDbVQ650GRWYm/
 4
X-Received: by 2002:ad4:5bc8:0:b0:894:662d:dad2 with SMTP id
 6a1803df08f44-894cc7b96e2mr37523566d6.11.1769539977857; 
 Tue, 27 Jan 2026 10:52:57 -0800 (PST)
X-Received: by 2002:ad4:5bc8:0:b0:894:662d:dad2 with SMTP id
 6a1803df08f44-894cc7b96e2mr37523256d6.11.1769539977433; 
 Tue, 27 Jan 2026 10:52:57 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:52:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 01/24] migration: Introduce qemu_savevm_send_* helpers
Date: Tue, 27 Jan 2026 13:52:31 -0500
Message-ID: <20260127185254.3954634-2-peterx@redhat.com>
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

Split qemu_savevm_state_header() into two parts.   This paves way for a
reuse elsewhere.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h |  1 +
 migration/savevm.c | 58 +++++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 125a2507b7..5d815af742 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -37,6 +37,7 @@ int qemu_savevm_state_prepare(Error **errp);
 int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
+void qemu_savevm_send_header(QEMUFile *f);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bb..e26656cca3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1282,38 +1282,48 @@ void qemu_savevm_non_migratable_list(strList **reasons)
     }
 }
 
-void qemu_savevm_state_header(QEMUFile *f)
+void qemu_savevm_send_header(QEMUFile *f)
 {
-    MigrationState *s = migrate_get_current();
-    JSONWriter *vmdesc = s->vmdesc;
-    Error *local_err = NULL;
-
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+}
 
-    if (s->send_configuration) {
-        qemu_put_byte(f, QEMU_VM_CONFIGURATION);
+static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
+{
+    JSONWriter *vmdesc = s->vmdesc;
+    Error *local_err = NULL;
 
-        if (vmdesc) {
-            /*
-             * This starts the main json object and is paired with the
-             * json_writer_end_object in
-             * qemu_savevm_state_complete_precopy_non_iterable
-             */
-            json_writer_start_object(vmdesc, NULL);
-            json_writer_start_object(vmdesc, "configuration");
-        }
+    qemu_put_byte(f, QEMU_VM_CONFIGURATION);
 
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
-                           vmdesc, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
+    if (vmdesc) {
+        /*
+         * This starts the main json object and is paired with the
+         * json_writer_end_object in
+         * qemu_savevm_state_complete_precopy_non_iterable
+         */
+        json_writer_start_object(vmdesc, NULL);
+        json_writer_start_object(vmdesc, "configuration");
+    }
 
-        if (vmdesc) {
-            json_writer_end_object(vmdesc);
-        }
+    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
+                       vmdesc, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    if (vmdesc) {
+        json_writer_end_object(vmdesc);
+    }
+}
+
+void qemu_savevm_state_header(QEMUFile *f)
+{
+    MigrationState *s = migrate_get_current();
+
+    qemu_savevm_send_header(f);
+    if (s->send_configuration) {
+        qemu_savevm_send_configuration(s, f);
     }
 }
 
-- 
2.50.1


