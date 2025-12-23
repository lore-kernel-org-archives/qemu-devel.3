Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80CDE6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3P1-00013E-Gu; Tue, 23 Dec 2025 09:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Os-0000zu-C2
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oq-0003g7-Jn
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6hpb97ha9BDKzmXV2BV/SXg6Ol4/zd6/rmqQsh2gSY=;
 b=ccXm9zcm7JvRVKBLVnWaYbysQWRbMGM7uBLwk5mV7Znwfk4RO97vjapTWcQCpAZJYVvafH
 AYVyUIVl+e6QPTGrshiXRp4J8J+JVY8pWJZad2ZIyG603if7U+XkZLoI+2fMo8dAvt78WZ
 0VUDDinOTWawGRqMDoc0I6DfWRJhZpI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-ige9DswiNJ-j0qibMweIDg-1; Tue, 23 Dec 2025 09:30:06 -0500
X-MC-Unique: ige9DswiNJ-j0qibMweIDg-1
X-Mimecast-MFC-AGG-ID: ige9DswiNJ-j0qibMweIDg_1766500206
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e235d4d2so1801884785a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500206; x=1767105006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6hpb97ha9BDKzmXV2BV/SXg6Ol4/zd6/rmqQsh2gSY=;
 b=bHvLaNIrePeU47tlxfqam243hAgEde+VodImsyK4r0HISqRH77r9Uw7lGyQVz+Cfsy
 gcw+DMFigFvX7ExOE6lOkWk/FvhuIOaXxV01kIG55OsPyIGE1g8qMtD2sFCXeZ+9G+sF
 28DIFoq22HOzWEFHQDWbYC6FZd5S99DSJ2eeyZLQsu3Iv+7ST1tKWT4R8HUStvpybGT1
 Fe4dBVBGO33DCBg74fm/gDGGNutwU82WkkbNkaAwd0TtJjrg3jyRTHGedcMSvt0ViNU4
 1+NpmmIR8SJ2Z0o5DOdFRqLnvWOTOwn4/xJ8qymzhSSERUIfQpDjPhW6XxlZ/fJ4Du6H
 FovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500206; x=1767105006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6hpb97ha9BDKzmXV2BV/SXg6Ol4/zd6/rmqQsh2gSY=;
 b=QT1ZSKre5EGE6pQ7S2NKBX8S3TPMkiM0/rboSOGtAgwGtgiYKkRH+EHfYiZ8LH99Xw
 2+OzeRGwZBzF+cVC47yBjV0rV7jt1gjQO+6vt55D7fBN85e4xU9Hm84z5g0a2DCOGvEU
 OroEe83mur3qBltLfCKKxTBjfScEjrn9f98nafZ0YGP3i2T7vix8ev03jdoTUEdpdK0j
 iPlIgsDGBI+ykcn4eHB6msZHAwr/HxsUfuztMZKPVLyzbLEDxQvKvjexyY9TJH98Csc3
 UnjWVHmfAIpaZTZWDsw/WcXjChImIzOPRtRiRFu8DzHkeloLsDvS//CH4eAz0LDMs3r2
 XIig==
X-Gm-Message-State: AOJu0YyszYpl5r4pSvF49VdFQbwOCxdF2gDCRGKFW8eRowhhsW0NzLno
 VFTxXezWPGyCMwEK0Ff/nBE3ofozm3Ao2lUcSB16Wn3/CD3gxqL6FaBeIzZ4qqrSR44wchYhgtX
 0i7ziB/LhCxNDFtAS2M06qeFCSteXDpff/o7j0upJ1ofrdJ1aYNhvIIq8WAYrwEiPnDEhSRY3lg
 KDn93UCllcj18xmFbgEO29FzVTTMgVDaPu6MK1eg==
X-Gm-Gg: AY/fxX7d6hQ+6ZcypO/iUCb/MVlEVtQhWaKGLocWD0Z9TBFpHgcrMiKrioQcQfSfmRE
 NnIiWTNWbFaXTBhiJsGciiqQIY23HkHlLHrAA7/+KAXOS9WY3XbI99UMgpICQQxqMFTVzYwpeaJ
 CQasODZ6AkqqdjggPZcbBNQ/v+DeVz0/NEgh/fKOWMam5LGm9OnLesDmPVy3XHCOGF2pZpV7Qwf
 cRC0Hns9bz41Nhx8y87AYZ5tGKEf9LUsXns21DoJv2rFTL4vO6coXnL8pR2Bj0kaaQJ3URmrWjB
 OQasquID2QyL+VThsSCenWmgDSGqJokL6CUw17zVGlqsMJX1xMxz1r4DQWN8qtwS8ALdPGxtNyR
 N4iM=
X-Received: by 2002:a05:620a:44d1:b0:8b4:ebbe:ae04 with SMTP id
 af79cd13be357-8c08f68238emr2309097485a.35.1766500205662; 
 Tue, 23 Dec 2025 06:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1gyPA+Dqwxf1Sx8Ygw0cLwU0/W0AG5oyAxN+ibQHFwcJF8x0oRhXtvsHvurC761SYGg3x9Q==
X-Received: by 2002:a05:620a:44d1:b0:8b4:ebbe:ae04 with SMTP id
 af79cd13be357-8c08f68238emr2309092885a.35.1766500204977; 
 Tue, 23 Dec 2025 06:30:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Pawel Zmarzly <pzmarzly0@gmail.com>
Subject: [PULL 02/31] migration: Fix writing mapped_ram + ignore_shared
 snapshots
Date: Tue, 23 Dec 2025 09:29:30 -0500
Message-ID: <20251223142959.1460293-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
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

From: Pawel Zmarzly <pzmarzly0@gmail.com>

Currently if you set these flags and have any shared memory object, saving
a snapshot will fail with:

    Failed to write bitmap to file: Unable to write to file: Bad address

We need to skip writing RAMBlocks that are backed by shared objects.

Also, we should mark these RAMBlocks as skipped, so the snapshot format stays
readable to tools that later don't know QEMU's command line (for example
scripts/analyze-migration.py). I used bitmap_offset=0 pages_offset=0 for this.

This minor change to snapshot format should be safe, as offset=0 should not
have ever been possible.

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
Link: https://lore.kernel.org/r/20251126154734.940066-1-pzmarzly0@gmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 53 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7d024b88b5..117957da91 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3042,28 +3042,37 @@ static void mapped_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
     header = g_new0(MappedRamHeader, 1);
     header_size = sizeof(MappedRamHeader);
 
-    num_pages = block->used_length >> TARGET_PAGE_BITS;
-    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
-
-    /*
-     * Save the file offsets of where the bitmap and the pages should
-     * go as they are written at the end of migration and during the
-     * iterative phase, respectively.
-     */
-    block->bitmap_offset = qemu_get_offset(file) + header_size;
-    block->pages_offset = ROUND_UP(block->bitmap_offset +
-                                   bitmap_size,
-                                   MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
-
     header->version = cpu_to_be32(MAPPED_RAM_HDR_VERSION);
     header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
-    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
-    header->pages_offset = cpu_to_be64(block->pages_offset);
+
+    if (migrate_ram_is_ignored(block)) {
+        header->bitmap_offset = 0;
+        header->pages_offset = 0;
+    } else {
+        num_pages = block->used_length >> TARGET_PAGE_BITS;
+        bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+        /*
+         * Save the file offsets of where the bitmap and the pages should
+         * go as they are written at the end of migration and during the
+         * iterative phase, respectively.
+         */
+        block->bitmap_offset = qemu_get_offset(file) + header_size;
+        block->pages_offset = ROUND_UP(block->bitmap_offset +
+                                       bitmap_size,
+                                       MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
+
+        header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
+        header->pages_offset = cpu_to_be64(block->pages_offset);
+    }
 
     qemu_put_buffer(file, (uint8_t *) header, header_size);
 
-    /* prepare offset for next ramblock */
-    qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
+    if (!migrate_ram_is_ignored(block)) {
+        /* leave space for block data */
+        qemu_set_offset(file, block->pages_offset + block->used_length,
+                        SEEK_SET);
+    }
 }
 
 static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
@@ -3146,7 +3155,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
             if (migrate_ignore_shared()) {
                 qemu_put_be64(f, block->mr->addr);
             }
-
             if (migrate_mapped_ram()) {
                 mapped_ram_setup_ramblock(f, block);
             }
@@ -3217,6 +3225,10 @@ static void ram_save_file_bmap(QEMUFile *f)
     RAMBlock *block;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (migrate_ram_is_ignored(block)) {
+            continue;
+        }
+
         long num_pages = block->used_length >> TARGET_PAGE_BITS;
         long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
@@ -4162,6 +4174,11 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         return;
     }
 
+    if (migrate_ignore_shared() &&
+        header.bitmap_offset == 0 && header.pages_offset == 0) {
+        return;
+    }
+
     block->pages_offset = header.pages_offset;
 
     /*
-- 
2.50.1


