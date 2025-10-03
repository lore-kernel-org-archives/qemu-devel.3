Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8DACAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huL-00052f-VB; Fri, 03 Oct 2025 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htj-0004p7-Bt
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htO-0007d6-EA
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e55M3qfrnCltyYYe3kkoM/efMv0UNe4JoU52j7qwoag=;
 b=B2pGn4TJq3gjVM42tfuMbO4V/ivpKUlsWGs8A4/Q3yJlD6cIMSEV26iokgoKRbkOs28BAS
 eEYJZ1TDh03sP4Bv5elSNmZ68cki8+q2Y/xH3dNXoSmom7UjIxGwGTSroPgahxPS3lWjfh
 j0KIc4UK2hqhWXzCa7HqRGy0IlRi6SM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-jdG9w5VNN96teYUomh_N1A-1; Fri, 03 Oct 2025 11:40:14 -0400
X-MC-Unique: jdG9w5VNN96teYUomh_N1A-1
X-Mimecast-MFC-AGG-ID: jdG9w5VNN96teYUomh_N1A_1759506014
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e50889f83so64682636d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506014; x=1760110814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e55M3qfrnCltyYYe3kkoM/efMv0UNe4JoU52j7qwoag=;
 b=ErW4pjaOK7wVbRY6RgwhF38U97XTbPVfaiCegQgGkg48LpkjEFlqqTIGRR5F6Tag9G
 KaBCoQBcti6UJhJucG3ogNnw5QI/vDEwxieciKT65mWP3gItyhtMt74Wt18pYWTwdhKI
 6rhZ5eFELOHyREnouPPQUFiDrxN3rpjphgDoZJj/wiKnAv8OkSB9gykqr0CVwceaLWW3
 772QrmJ0zql+FILHzsFCTyvydRJ6scYKD5/355LDYGRwbWlvQRrIaup3UFdhjGAehxMW
 HIXpSM1dKUCaOCWujb0xFphcHgM4xJA2Y7JEqf1PiF6/kQ0o0YOu8Zu7APWsE9A5yylT
 V6MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNKGpF8c10vopTW4Wl91E0/8uR0x75W4AHjYN774rzyfeZ4aC6/VBUQ/ciHCx7YK5ukxRkbesXEoUS@nongnu.org
X-Gm-Message-State: AOJu0YwibD7lMRohPHVH5LWfyZWcgBoTqz71WCMQws9SKa5nieOHBYZH
 qSx00DxZh97LpVYn16qTUjCkfzPwsUg3laLVI7GMJlSXyOUTzL6aKCRFC8J5VDu2Rj+b4J/VcFO
 AlF/Bv5JG+vcSOgTzGOlDLMMFm7bl1z5ZP85oW+KLPHEFbXZl2RZFosTY
X-Gm-Gg: ASbGnctfOSh7wkzztmBryh4Qm9BWFRW/KGXKPtrtvUWYrV/cNfZK7rlAkL5zKIQHgn8
 S69XZOUT6lf4Ec/9suebyZTXsPGYJN4hVjXAulYdHomYPKGVid/ezQUSYqEEK7rDt/fT3JfVq7R
 on1iN7g0+N3Py5NY1llcjSuvl5PpodONCatazAucqvSlXiTOp9n/kBFOs/FuBSTTQIfCNcG9xNd
 t4JR7PNXoLYZaH8j5llN+AEBLQ8dmWnLfhxx5OZJrXoKFuoXBNTXbdJZhdUP+LUZJbCO5Gu/Usk
 WeY+xAJw+c8mTfR7oLFZf3x4kOQ274maGMPaKA==
X-Received: by 2002:ad4:5c65:0:b0:824:c08e:1840 with SMTP id
 6a1803df08f44-879dc7c3371mr55375476d6.21.1759506013798; 
 Fri, 03 Oct 2025 08:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoL/cVyjVGWhNsF3a4JyBCrx/4xhpuQfSFmDKBbvxFUtfc4bSJuPiSq3yL+A7w8v9fAScpew==
X-Received: by 2002:ad4:5c65:0:b0:824:c08e:1840 with SMTP id
 6a1803df08f44-879dc7c3371mr55374856d6.21.1759506013292; 
 Fri, 03 Oct 2025 08:40:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 14/45] migration: push Error **errp into
 ram_postcopy_incoming_init()
Date: Fri,  3 Oct 2025 11:39:17 -0400
Message-ID: <20251003153948.1304776-15-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that ram_postcopy_incoming_init() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-14-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.h | 2 +-
 migration/ram.h          | 2 +-
 migration/postcopy-ram.c | 9 ++++++---
 migration/ram.c          | 4 ++--
 migration/savevm.c       | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3852141d7e..ca19433b24 100644
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
diff --git a/migration/ram.h b/migration/ram.h
index 921c39a2c5..275709a991 100644
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
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0172172343..5471efb4f0 100644
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
diff --git a/migration/ram.c b/migration/ram.c
index 7208bc114f..6a0dcc04f4 100644
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
diff --git a/migration/savevm.c b/migration/savevm.c
index d145e7b1e5..338d1a9756 100644
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


