Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70447C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigls-0007gY-0q; Wed, 21 Jan 2026 17:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglq-0007fy-Pg
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglp-0003hX-8t
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5Ii2DQrNf2yCfWhYk7gay4p6BIidDMzjtIYzEoVG08=;
 b=CAv8Oq+kcaci6ap3/NY4KAlSPy/n8utkECH5JVTACpapaTnY/B+oJJtPzT19sDmW2qelog
 QuLsTxqT9Z/ch/TqLjgJy9gz5nDYHVsOZrfQ2/v5zx8Y7u31w2Ei3vZEm/JyQhBWpw9sFM
 vmeeE2j0ZumarvctASZ+mUl4CD32Iew=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-M5mJ8D_nPmyEB724Eut8kQ-1; Wed, 21 Jan 2026 17:33:47 -0500
X-MC-Unique: M5mJ8D_nPmyEB724Eut8kQ-1
X-Mimecast-MFC-AGG-ID: M5mJ8D_nPmyEB724Eut8kQ_1769034827
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8947c4398c4so11219186d6.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034826; x=1769639626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5Ii2DQrNf2yCfWhYk7gay4p6BIidDMzjtIYzEoVG08=;
 b=UE0yakzMUnptftF4T3fCrQMH+e86xLaRRF+Cvj+g3zEbu+GwhdA+e7MzU1go8f9fNB
 zzyrSovoVKKODq2Tkloi4bW0DUSGl0/xhrh1rwVvxumOJnIqP0L2NdR/usJ0Q29Z8Nkt
 BbR1hA0T86F4kw2/m/JyEL9VMArcdEI7PIUBRXlq0LKlkZ3/k1pax8htupMLBz4GCqfc
 aB31hedpqdaCLY6ytvM3GlBX2SvL4ZJ0OEO9XD9YAJCHicQw3YYow6eH4i3RataI9h6d
 WsQOaL2AKVabzqDwurIZzp7mqRgev9R866AqQFDVzHRVAne4EglMAo0SC7yF1Kj4y6mE
 Exyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034826; x=1769639626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C5Ii2DQrNf2yCfWhYk7gay4p6BIidDMzjtIYzEoVG08=;
 b=nXMlfMYgu6hDyDjtpQxPLuEq2ByJJULdv265B8lxlfEv64VdOo/zB9t+6PJGpNe+Jg
 5hMTCNAlutEWbYUXykby0fPHxXegqawRYHmmzgvo1Q9Qvjasor+EzVMjsJs1hLjJAioG
 Ufj1pza+nDtJREEZTrU2o+/8p2Ib9JLm4jtIdH86e1TYoTARHtHGwBZpv9lKOtDdIY7H
 3Ymw1mQjZr7gAS+s3ciXFUjsj15hE74mu4gyq9i1Fl8D2ivMj1F1FdM94iROF925j80F
 1r3WpnuWl70liRWYqdDFuL9hc8xjvDSRfP/vOyLYsdN6qh0T+qzGYVgwcCDQPf5+xlYJ
 SKog==
X-Gm-Message-State: AOJu0YwNJ809QqM/+sD/G0w6rfK1CXRN/NuDuIcNEk4Hw0spolVOdaG8
 bnD3fThwXGaf1NMbpemayj3oOud68MxWRotFTVcs7ohPfMK0Z/WaQIYokhdmKd99qIoIubEjPgh
 wkzM3EquuoFHM3JERqRgqOYycpbaxFTP2bSqP1jAPIkmaypPDidvAxD7clN0kpGzJp/v735qgpg
 No1JQqFwauA7YaI9SEjdut+yNjPW0PCZ8y0YrcMg==
X-Gm-Gg: AZuq6aIVZnS5NduwZohu20nofDCKvE2r1XWxnpYp4PCPFy4a2kxZgrt45i9u2iSnk8c
 tj5mZXwkqEddtViapTuXudSHkBEvuXf/dVluW4fklUD79UueARAqGGs2MKRup+6+GVYoGtlB8EW
 N4fiKAMwsbqBCunshjlexR+ytQDWVQ9LiGzZbmy6xUq+xMJ/PdPf8aflqjfE/Qh56lLuC25vzlI
 WT+AjDR8oESW2E3SwlnkApPaJ/KLj1owKm7pYzxvAA7unFaWwCL4/SSL7gbhMTl8NUsm9UuaSwn
 /j0NWC/btl3I5NOpkWSFRue3QLQ0ddAhxarVlMA11ASon2McD4atY4ldlUsgbweVRydXTRb4MND
 r
X-Received: by 2002:a05:6214:20e3:b0:894:6c7f:335d with SMTP id
 6a1803df08f44-8946c7f366emr96276446d6.41.1769034826357; 
 Wed, 21 Jan 2026 14:33:46 -0800 (PST)
X-Received: by 2002:a05:6214:20e3:b0:894:6c7f:335d with SMTP id
 6a1803df08f44-8946c7f366emr96275976d6.41.1769034825715; 
 Wed, 21 Jan 2026 14:33:45 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:44 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 04/10] migration/savevm: Remove SaveStateEntry.is_ram
Date: Wed, 21 Jan 2026 17:33:29 -0500
Message-ID: <20260121223336.3381912-5-peterx@redhat.com>
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

It's neither accurate nor necessary.  Use a proper helper to detect if it's
an iterable savevm state entry instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 61e873d90c..f1cd8c913d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -249,7 +249,6 @@ typedef struct SaveStateEntry {
     const VMStateDescription *vmsd;
     void *opaque;
     CompatEntry *compat;
-    int is_ram;
 } SaveStateEntry;
 
 typedef struct SaveState {
@@ -816,10 +815,6 @@ int register_savevm_live(const char *idstr,
     se->ops = ops;
     se->opaque = opaque;
     se->vmsd = NULL;
-    /* if this is a live_savem then set is_ram */
-    if (ops->save_setup != NULL) {
-        se->is_ram = 1;
-    }
 
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
 
@@ -1866,6 +1861,12 @@ void qemu_savevm_live_state(QEMUFile *f)
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
+/* Is a save state entry iterable (e.g. RAM)? */
+static bool qemu_savevm_se_iterable(SaveStateEntry *se)
+{
+    return se->ops && se->ops->save_setup;
+}
+
 int qemu_save_device_state(QEMUFile *f)
 {
     Error *local_err = NULL;
@@ -1876,7 +1877,7 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
-        if (se->is_ram) {
+        if (qemu_savevm_se_iterable(se)) {
             continue;
         }
         ret = vmstate_save(f, se, NULL, &local_err);
@@ -2648,7 +2649,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
     se->load_section_id = section_id;
 
     /* Validate if it is a device's state */
-    if (xen_enabled() && se->is_ram) {
+    if (xen_enabled() && qemu_savevm_se_iterable(se)) {
         error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
-- 
2.50.1


