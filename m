Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E58C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglq-0007fv-Cr; Wed, 21 Jan 2026 17:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigln-0007ew-Ha
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigll-0003gn-6R
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xizELMYQfmmT5ObcTxByFl2OFqT3bjOAHOsRsg1TW1Y=;
 b=PzNY7RVWtzvWeXQBBgSE2lJ2iqgHFE9JmsHMHoPa6gEP3xYsLT/pTdO22LuobezcjvA7qP
 KJVb3PEU3wLTatbv9Xnc6Cy3kqTLQOtFMLwpuj8DGYl160UdmKaRJU2podZAE7RvcPoUY1
 cx4ALp1Iny53PHvAVnDaTPqhh30MLMc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-cbLtoMXSPNilzSYH8mp20A-1; Wed, 21 Jan 2026 17:33:42 -0500
X-MC-Unique: cbLtoMXSPNilzSYH8mp20A-1
X-Mimecast-MFC-AGG-ID: cbLtoMXSPNilzSYH8mp20A_1769034822
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c52c921886so42800985a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034821; x=1769639621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xizELMYQfmmT5ObcTxByFl2OFqT3bjOAHOsRsg1TW1Y=;
 b=a8aVECBeFpla21B/9/haTvAOOTGr0dHFwFeRAeR6PY8P6Ntu8YW7ydTkqNJFLmOGJP
 WlnddGn3rAP0D5Re26cnNQg2zgkIuw5/r6VMPOvt2iHm/v5jnUj8xUAlS2MASQ/sq8MH
 CwlDbRHEVtdWd6DSm5sospD1jltKNEk7AsEPtZWGAPYrb3wHtxcecdZQ2tRdJ/xQLx/J
 YtLwu4ch1dVTrAQ7HNveihluwmQWdiW+5SjjnEHMdgYss0O6p0n81W2taNVgATFyQcLL
 sZ8sQ+4XJgw8nP54v1LtsND6oJ/1tEXQ8iWgs1y0pQxYTKyIaOE/43QYXPacEx1AVulY
 ifgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034821; x=1769639621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xizELMYQfmmT5ObcTxByFl2OFqT3bjOAHOsRsg1TW1Y=;
 b=QVN5lmnPCtqm3R+OrsciO1EU8Iyelcom/PY6wl5e/bZ+OVjiT87PskvEkEkWUDf2dq
 MUUCqACwT08bm///6Yu0x58xkVQ5Py9cbWR0lwWJwrC7cvmQYMgVHkxtEz4hbHQL7ays
 Bd8T36Kepz9/EL48A/C87TEzBMyX5SddBGwX4AVHPdbr6qXh+efjYJE0MOxXwkYzIdX6
 ZdwZCr6DwYnpppyN/zAe1qpCvDU3X84o6i3Kxom9UbEy+PGnp9UhdLo0Ut6kpXDf+nvs
 6GfpHx0CuXFMMMlauCHco+GFeoXQ0Eoh/0hUKBAxKY4dGRuFFZlH5lnQKdP6NXSU+D9B
 x++w==
X-Gm-Message-State: AOJu0Yx0Azd9S/0DJeF31fwWWiJoffGo3dGJtAWwB/G0CqQSaqWDJvOx
 Jz+EGGNOeBZpcbfwRsVS/baRADKfaBUk/lgZzmwPt4kqrX3h4Ew5nIBDThrLrh4jEqcYTkN7SDC
 /F3mcbbc2gL5P3b3vMVoaitNt+o+GXjfh/bD8KqI3rc3ZUw/l3NENVE5IVOD6O3/ygUzYMUAC6F
 u237PV/aNsP+XEFLsehbXJUVCG/+y3r39zwG/5fw==
X-Gm-Gg: AZuq6aLGatb9LXZbAlzfBz7pFwgCnWw5x2Jt/2cml2kSLlUMldg8HgvrnajTypS7z52
 g9SRggXSMFY7WtPBInFnlV74ujsO/HxW4r4jmut6LmwxKtrnsjOAbbtNcY7SxyKYmcU30zkM49U
 7eCPB1pAVVFXYn2YFIuYlVWdFA+2TpXFr1ODZ2401dFDJnRR+D+3gO+OrNRkClt1pUVpqgMXror
 Ytewd8OVCv13Fa2YDSsd61tZCw2E/HPg/suMGoBgjxJ7CS7zModA1oFvM4imqrm6v4nF6UeRyL9
 ybSmCvghY6xnhb2EP1CU6O202Dwqfct7XNrr9aEdS5HbrII2ijXjgQMpYeKviHwCkHOb81XaM7i
 E
X-Received: by 2002:a05:620a:4492:b0:8b2:ea3f:2fa5 with SMTP id
 af79cd13be357-8c6ccf223aemr801828885a.69.1769034821344; 
 Wed, 21 Jan 2026 14:33:41 -0800 (PST)
X-Received: by 2002:a05:620a:4492:b0:8b2:ea3f:2fa5 with SMTP id
 af79cd13be357-8c6ccf223aemr801824985a.69.1769034820747; 
 Wed, 21 Jan 2026 14:33:40 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 01/10] migration: Introduce qemu_savevm_send_* helpers
Date: Wed, 21 Jan 2026 17:33:26 -0500
Message-ID: <20260121223336.3381912-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


