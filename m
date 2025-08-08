Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEECBC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMb-0002ta-6Q; Fri, 08 Aug 2025 03:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLR-0007Au-8g
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLN-0007O7-MR
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRhybXxEqTNSGknAGEpHdFP2njDEP5BIaNiXDB4HopY=;
 b=dbiW18SqJ8UYK1ra7lOYDtHLXmtcb+3jMiRvvqGfbJEa+8IWyA+vtLoFXk6iuyAg543G0a
 hLTxGs7Zk0YtXjbxdkwQdFyk6WjhMp8vbwX+Fe/erKAgeuyHOeF2tQLBoNrXWMDlLwXonm
 PIHW8wEmWg7xrUfBna0vERJ6IVajrh0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-v6DPOzMUM5m_ozum-uU1ag-1; Fri, 08 Aug 2025 03:16:46 -0400
X-MC-Unique: v6DPOzMUM5m_ozum-uU1ag-1
X-Mimecast-MFC-AGG-ID: v6DPOzMUM5m_ozum-uU1ag_1754637406
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23fd8f85dd2so16761445ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637406; x=1755242206;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRhybXxEqTNSGknAGEpHdFP2njDEP5BIaNiXDB4HopY=;
 b=dtynhb+uDxsE6fOcE8jkEamAJY3Ovk4nKJTNN/zSMY9l5z2UjWuL+jpbhEKSP0udQm
 FypOuNaAkPYBJp3Ebw4K3MC2s4QuRPRKJnsEJa6FrWrO9qemg4X7SutYwuJ6u/L/8siV
 LrQBy1hcXED/e9+5d3TvHQ9A/pAC/aZIs7T76vYEusErjok+2u07OXs4T/AFSxhxk88H
 hLP5XuEIAI9XJJZcGsCKzy4EXvJ/x1ZyUJ5cs522DT3X3VuKDVSPLRLZ7xEKdimbuX6U
 466dBR0NNvgSTXCStKurA+Oo2QBEznwhtxCApK6Yy3wpDnFczrbCN5KoX64wUISAi15s
 efqg==
X-Gm-Message-State: AOJu0Ywd5uqmD3/PssHu7TKYOptItUS3EPZRxCad/UY5Qsj9U2u+HETc
 jrQP1n2HHIx3LW5MHU7rcFZ23G1ZTVrw7coBxTzgjY7a1Y7hVQPv4flUpAtLVl6QSlkYTN7y/FR
 O0knFxmZrRgJuQ5kjzZ70qvHQWqfidYl+JjgkCbKE3sr0HeInkWhq63l8
X-Gm-Gg: ASbGncuS9QUvkcP3ScC7R/SJFCSptIonsoi5Jk4aSOxOsSvw11PpI5adNTQ3dzppJvN
 Lm75fQPliwpPGygZrnDG5FkZwX5OFehfBNDp26eYePXGlpFD5Zz89ARxVHGC5zAO1fkRlmdn16V
 3xGy7T/mn8Nx0b0KVSyZnItBrGazUAgFXlXOuY78tAJsfvRN5kDauuT4rWp0Lut+C+msIZgwkH6
 /KM4HqhNcsdrinmI2ve81feqUhl5tfMsKPpwmAhf+TFqTm1fYVbFwHlat4bThsZ8eWWBgGqDaxC
 jexc2LRalQnWifphwya7C0uaGk5HYYAq85KiAAsN4msORw9Mjwutng==
X-Received: by 2002:a17:902:ebc9:b0:240:725d:c396 with SMTP id
 d9443c01a7336-242c21e05a1mr32390255ad.34.1754637405757; 
 Fri, 08 Aug 2025 00:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLOOBpjDoreP0dpbddEaI9CzViqDCnoE442ya1v4t76/Oms4vfMFSorxmi9/JXWFzJ9Qj1dQ==
X-Received: by 2002:a17:902:ebc9:b0:240:725d:c396 with SMTP id
 d9443c01a7336-242c21e05a1mr32389665ad.34.1754637405300; 
 Fri, 08 Aug 2025 00:16:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:16:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:40 +0530
Subject: [PATCH v10 14/27] migration: push Error **errp into
 ram_postcopy_incoming_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-14-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4760; i=armenon@redhat.com;
 h=from:subject:message-id; bh=HJd1s9ppefA7shhe6hHIGrJaOm2mh/5lDOnqNO64hYM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVfztjRMu7xT9siiW4YiJsn27RveHVHu/Hjk4lpmm
 z+LSvS/d5SyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZjImw+MDI+Yr3nOtxSXV9MQ
 /+piuEnLt569eMOXkMn2Aud/PZTM/8rIsKFKdaqbaUjshv3xE+5+4Zq4W/bQG6VVute98u7ODjn
 7lRUA
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that ram_postcopy_incoming_init() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/postcopy-ram.c | 9 ++++++---
 migration/postcopy-ram.h | 2 +-
 migration/ram.c          | 4 ++--
 migration/ram.h          | 2 +-
 migration/savevm.c       | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -681,6 +681,7 @@ out:
  */
 static int init_range(RAMBlock *rb, void *opaque)
 {
+    Error **errp = opaque;
     const char *block_name = qemu_ram_get_idstr(rb);
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t offset = qemu_ram_get_offset(rb);
@@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
      * (Precopy will just overwrite this data, so doesn't need the discard)
      */
     if (ram_discard_range(block_name, 0, length)) {
+        error_setg(errp, "failed to discard RAM block %s len=%zu",
+                   block_name, length);
         return -1;
     }
 
@@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
  * postcopy later; must be called prior to any precopy.
  * called from arch_init's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    if (foreach_not_ignored_block(init_range, NULL)) {
+    if (foreach_not_ignored_block(init_range, errp)) {
         return -1;
     }
 
@@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
     return false;
 }
 
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
     error_report("postcopy_ram_incoming_init: No OS support");
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
  * postcopy later; must be called prior to any precopy.
  * called from ram.c's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis);
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
 
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114fb5c366740db380ee6956a91b3871a0..6a0dcc04f436524a37672c41c38f201f06773374 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
  * postcopy-ram. postcopy-ram's similarly names
  * postcopy_ram_incoming_init does the work.
  */
-int ram_postcopy_incoming_init(MigrationIncomingState *mis)
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)
 {
-    return postcopy_ram_incoming_init(mis);
+    return postcopy_ram_incoming_init(mis, errp);
 }
 
 /**
diff --git a/migration/ram.h b/migration/ram.h
index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281ec268ba0db 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
 int ram_load_postcopy(QEMUFile *f, int channel);
 
 void ram_handle_zero(void *host, uint64_t size);
diff --git a/migration/savevm.c b/migration/savevm.c
index 41e9533f985b0b9d69fb704d957938e2dae4781f..1f502f1cb15c951a0845dd27a4dee34fcea3f753 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1989,7 +1989,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis)) {
+    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
         return -1;
     }
 

-- 
2.50.1


