Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8425C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udolI-0003lk-2L; Mon, 21 Jul 2025 07:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojZ-0001IZ-JL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojU-000103-Fw
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9bw0kHEksjvUKEizwGfefuPp0i5EtS03tpg6W+kBZs=;
 b=L+O0yKFzK4UC1YWbTc5u9Vr6H/oNeQ7lC494S9re+VqxtHSiKAzuW/unqYuou/yb4cbkx+
 hHcNEU4UBtNInRYvsf+l7JQOWylB66VlKOsKJhIfIERYosboUkBjjG90YcaIfcSiyKXw2Z
 4TRQG4w7G2qgRj1/UUrn3E3XTbQ4plc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-5A3UW9w-PmaNR_DIsPtVlw-1; Mon, 21 Jul 2025 07:30:58 -0400
X-MC-Unique: 5A3UW9w-PmaNR_DIsPtVlw-1
X-Mimecast-MFC-AGG-ID: 5A3UW9w-PmaNR_DIsPtVlw_1753097457
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2382607509fso28890975ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097457; x=1753702257;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9bw0kHEksjvUKEizwGfefuPp0i5EtS03tpg6W+kBZs=;
 b=W0TNwSm+TrcpFfXDqmveJA1ymmHwNhVSk+D3GhQh19amLVSlvSReR0SXNwfGN8d2Gv
 BsKooRJfhv2p/FJUpm4Tqt7HWpV2kKE92rqSbeAWgGwG4acwOV5fHqdqRhN3rYKLsbG3
 MsZfsPZ1tq31Hxq7kRiYUwefIotmFkxom2T7SXLy19I8DVR2245+Kv2hg3Xbov/CBxvi
 sGywJcosKg6yacxpAr2+M7PdADd0H9f7yudZMM1BZjZtEGErSYVT9XluhpdZPH7XOsyc
 qycTjB3UypGGwuMF2pLqUBVkgYzPisdYSzU5z7eu/mC11Pwy5iMSaoibGl26Rmyvyauk
 KQoQ==
X-Gm-Message-State: AOJu0YwBXaFloNRdFE0nMpQ+8XmF8ahyR8LwwvhrIVE04+DrX88cfJgo
 HMHJmU2DPqpDkF5kxKzgS5ZN6QOYpyEMPI02quWvs3k8qEKZNzusJK5db3xG6Fy2xSTA/bn+8Ih
 XVjxLX/n3Cc58uqF8ivjuXrm+AlX8MHjZ2YkNeuu1ZtCNK6FD+yAHYVta
X-Gm-Gg: ASbGncsIW53h2yFY43y0ABbkCS5MKqGVvQ6SL9MsuOS+HFUCYKU3iAZ6UvbLURkOhUj
 eAK8EyGPw7fh++/4bZx4Ih2zOJUV6aIadAjWROhXlwMICDXhoCPs/D3DN5Xm2WvFHjyUjmLJTun
 tC+M1bJrtpJQow81MkFJAflWOvMaNRDTuv6t+NUyqhflWKpJPUIJtaS7guwYpFEkBBs8IX2k8sa
 1QuoxSU0fGbs/ZWDD3h5ZdEi8RfBXFV3xa6taSxw8GGqrU6kT22tRlavsA1+RdhOVXlfi0Qm5tZ
 HpxjdjEB/MVcQZChbb8WnNUGbw8JmiAJzyzkmJDgaaeHxK9wPbLS
X-Received: by 2002:a17:902:f745:b0:22e:421b:49b1 with SMTP id
 d9443c01a7336-23e24f9477dmr307309825ad.48.1753097457013; 
 Mon, 21 Jul 2025 04:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE5saP/qEGzcx0AVMVXkTRk+x3GRZFNSg6ywpeC8KCb30Lx3OlhKt2ScUOUmmxr8EO3+bnfw==
X-Received: by 2002:a17:902:f745:b0:22e:421b:49b1 with SMTP id
 d9443c01a7336-23e24f9477dmr307309375ad.48.1753097456571; 
 Mon, 21 Jul 2025 04:30:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:15 +0530
Subject: [PATCH v6 10/24] migration: push Error **errp into
 ram_postcopy_incoming_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-10-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5016; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lEaVRGiTD2JzH/Z+bJIrdIkUc6ResF6vLucMSdCaXvM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysR7K5lkDDtf+ckz+l7NaVEJ4H6YyztPY5t7BqdFU
 n5JMnNHKQuDGBeDrJgiS8PXANmmgMKISNuX12HmsDKBDGHg4hSAifTuZfhfIv1MrKBt5dnVTJ4f
 0pyNJm702rPlZOTjX7v6PDr85pSkMDLsvMPEVvk9oJ3b/aBLjoPKRac7q6azSZd++KR8/clRt4e
 MAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/postcopy-ram.c | 9 ++++++---
 migration/postcopy-ram.h | 2 +-
 migration/ram.c          | 6 +++---
 migration/ram.h          | 2 +-
 migration/savevm.c       | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

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
index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
 /**
  * ram_postcopy_incoming_init: allocate postcopy data structures
  *
- * Returns 0 for success and negative if there was one error
+ * Returns 0 for success and -1 if there was one error
  *
  * @mis: current migration incoming state
  *
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
index 3ade91d2f757f94bc6c0242a38c6e750a9252f96..6b8c78bfb9bde2a8e7500b0342cd386b0d12db97 100644
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
2.50.0


