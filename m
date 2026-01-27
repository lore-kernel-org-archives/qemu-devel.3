Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73979D2FEDD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCi-0004rr-IC; Tue, 27 Jan 2026 13:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBm-0003DP-0u
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBj-0000kp-Eq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1Qr5M0mON7SSJ+40/8rnC3mGubJewstthZcpwoPxcA=;
 b=iPjndw2qmOCaZdzjnfst08o1zL6umov65JsjKUfloa8GkHjj2299Ga/+8xANfhsyPnT1ko
 R8ZsFD7726TGTI5eGfFhnzidIZs9GolDKA9TCBW+oY1HmlZgIcLuIvv3mOsr604viBByQo
 nuGcppGGe/SU4if9X4YL23fewTLPQIc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Qw2sFSLJOoKGITrQFuwSmA-1; Tue, 27 Jan 2026 13:53:15 -0500
X-MC-Unique: Qw2sFSLJOoKGITrQFuwSmA-1
X-Mimecast-MFC-AGG-ID: Qw2sFSLJOoKGITrQFuwSmA_1769539995
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-502a13e3e55so241636291cf.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539994; x=1770144794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1Qr5M0mON7SSJ+40/8rnC3mGubJewstthZcpwoPxcA=;
 b=S+dgGA4Z/0nqZM3eBEbVTdMZXnJ9IZjArSwgnvnbfL9iTsf+XlGMcUyxU5Yxf2A1IF
 b4cE2god2BdZ0Fb3LVoxqHDzXhdB6jtoUQqkr4Zp5Bo9gQA0ojX3gxko5DdedzWLNZjK
 RCilrVbwhHgqZ6digPtiiQ4gF7kuv/Vz+wqpHYWJLlO+tzoyf41olp4cEsFqFQlKDvsR
 NIQ1Gvt4YTZMGWWMBdRQi8sM9QlQB16v3AGBpRbbYh00+REoSpf2fFId8UMesom++bSF
 WqqT+XFEfeJMgpWAAoonRlHwfMjtK4z3hA6vi4wrFmPyiZrbS6swJ/kaq5eHJUhNqyUF
 3DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539994; x=1770144794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1Qr5M0mON7SSJ+40/8rnC3mGubJewstthZcpwoPxcA=;
 b=DMtU3F3pCyntcdwPLjC9UP8rYwV9VbA8/P3mVmaZ/IWcNlelsVK9Ez3eG4suSO+/1w
 VPov88GhdPDZhrzzKYDCOimamyERXkA8GL03rK71Y2wYzgpPz6QDHebAnVZ2nVi6+SSd
 RQxM9S7Z3TjuPISfhvHo7yqbbebY4rTH2cQPJfCvVCVQp0WouNZICNMQ1fZeCh8Tzw1K
 EVJAqZ9XT04xJoAb7IVDO2zC/itSkzn9d/+GiM4etbvGpqxaKdpxVSS5OuzZEhwdhZCP
 NBJbWtF0k+ErojM2X+6xT59UNxVpLKmwTbK5ql/QBefF2E08nCZr8rKSz8sgqDjOOCTt
 7Rfg==
X-Gm-Message-State: AOJu0YxrJaXmNJW5dG+EmUe/b9BX1KD+KdRo1ZkZtDKYFpyEdvxMNdbC
 PZ1N4PckZeHt2LzceLwLnhoTRmFcusaJMkCRReCpjht1+EF3SXwRGH8uJ6ZTWcj5QIB1gdLo4tf
 tDaflsRX/bnTczAnT4mD7Nbp3F0GXAxo+WeXWwXsV3YoX84Zsmdx4vUnrgtJEgBIH/3xaBemx8M
 GpXsWuRm4Q+vbmgRVSQqgraqq3iPcJENUFrobTFQ==
X-Gm-Gg: AZuq6aLhKni/wzUFLJ9Posr3RfsFk5OA2+C6sjxZH326qHuPC+hU/sToxA61Sy3DuWW
 ApaGIxhZ8kWQgTvLD2VLQrroFn0/NSIgW5Ie8ikUvbADL1sJiic7NqAWgOJV5UqnDHmtLDmU9G4
 5p2a1HdELgJ4B897LWt64CJkXFVqSASiMemH8CB5BbJ4J3NCU0yPawDCqJlYNUxp3u7d9cJHaG5
 k2pCaRWZkVKC1v/N0CmwsMj5z9OCEpXKu7E7qWjtFbItE+yhVmEErCFloVbzu6rLcv7+4OHYZ1Q
 4OgMDSpDKv9jkS5elEMDs9m+KfvgjbdRmNEAJAclq6f9Nk/N98lGeoSEt1KT+Q55bXxWZ0MyzvA
 2
X-Received: by 2002:a05:622a:1b8c:b0:502:8fb9:530 with SMTP id
 d75a77b69052e-5032fe1a2f8mr33579961cf.79.1769539994320; 
 Tue, 27 Jan 2026 10:53:14 -0800 (PST)
X-Received: by 2002:a05:622a:1b8c:b0:502:8fb9:530 with SMTP id
 d75a77b69052e-5032fe1a2f8mr33579641cf.79.1769539993867; 
 Tue, 27 Jan 2026 10:53:13 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:13 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 15/24] migration: Provide helper for save vm description
Date: Tue, 27 Jan 2026 13:52:45 -0500
Message-ID: <20260127185254.3954634-16-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
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

Provide two smaller helpers to dump the vm desc.  Preparing to move it out
and generalize device state dump.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h |  1 +
 migration/savevm.c | 35 +++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index d0596d1d62..f957f851ef 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -50,6 +50,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
+void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/migration/savevm.c b/migration/savevm.c
index a787691352..41560b97a4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1669,13 +1669,34 @@ ret_fail_abort_threads:
     return -1;
 }
 
+static void qemu_savevm_state_vm_desc(MigrationState *s, QEMUFile *f)
+{
+    JSONWriter *vmdesc = s->vmdesc;
+    int vmdesc_len;
+
+    if (vmdesc) {
+        json_writer_end_array(vmdesc);
+        json_writer_end_object(vmdesc);
+        vmdesc_len = strlen(json_writer_get(vmdesc));
+
+        qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
+        qemu_put_be32(f, vmdesc_len);
+        qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
+    }
+}
+
+void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
+{
+    qemu_savevm_state_end(f);
+    qemu_savevm_state_vm_desc(s, f);
+}
+
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                                     bool in_postcopy)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
-    int vmdesc_len;
     SaveStateEntry *se;
     Error *local_err = NULL;
     int ret;
@@ -1705,17 +1726,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-        qemu_savevm_state_end(f);
-
-        if (vmdesc) {
-            json_writer_end_array(vmdesc);
-            json_writer_end_object(vmdesc);
-            vmdesc_len = strlen(json_writer_get(vmdesc));
-
-            qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
-            qemu_put_be32(f, vmdesc_len);
-            qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
-        }
+        qemu_savevm_state_end_precopy(ms, f);
     }
 
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
-- 
2.50.1


