Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358C5F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5uv-0007Hj-Vl; Tue, 24 Feb 2026 22:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5ut-0007HK-QU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5us-00086H-Ax
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=ASIO6TYoTUccriCHbTEsdeccK1IVCW7lB1TrsZ9+kb5nRMZiUVoZEJX58zdUq46gjCyhq/
 DA0ZLLK9Ba3dL1JALeg+y3M2NFNCJwmg4nOHG17qmi7MfcFsGDQtd/FrTs0ybytGoPNzhd
 /Cbs0++Y2HlZr0QoAbSVyV87Fn5LSyY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-8PKVqGK2MzuFCVGp3SsHHg-1; Tue, 24 Feb 2026 22:50:24 -0500
X-MC-Unique: 8PKVqGK2MzuFCVGp3SsHHg-1
X-Mimecast-MFC-AGG-ID: 8PKVqGK2MzuFCVGp3SsHHg_1771991423
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70eb4d56fcso44396a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991423; x=1772596223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=EU2CLn6v7e1ffVJr0IMeigTDk3YeuT5nhSimaaf5/ixfWJhulW8/jxUvUs/BmTaJeh
 E9lR/Uod5K4F3HzZGtfMXBEWC0C7sW25VyKVF6569D7TtLpVmQNgeYqOa9PFPG2XNYH6
 Eb4tJBkbXefzvQYIeL55kCJV6n5Hhch2xjA54dKrqKdRiP0w6AvIew6NRVoXjfk6BrJs
 YPokwSx39JcOmWia79i8hDuqkXj8ntkNa2nK33cylGj57zEEy7b331NVz8DgDc/HNFQg
 ZecWPZdW4NeGPvdpr6dRceG45l08+UFtWKsEWIHAOKWUm/wW/SpV6pKCX8NaYMT2rIK9
 Ht8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991423; x=1772596223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=dirCWc29Sy3tEHyi8wt3wbpBs0qTeRuWoOExrha4vlSAdc/abCH1TnoPM7HbiGXuPk
 0BF5xuURUpMZ5lrZn2qaDWc+fYL3ftXfffh6E25y/gIwgdJ6JHxM+oJRsjBHcRajMpea
 5ZyfWz9zQqMRTMf8QL3WIhX8eK73csw5UeMTbr+eLDgeUOtoGcjYy3IxOpchb292Ocre
 4ErueGMdXFImKHenFGyElG8aX/2zJTLeirM9yIrzluUqcOJlT0MoQtpFhh0Cc6z54Tu0
 8Fsj/orPt+MUE+33RPNYFB+bEP2nGSMNmbGfD4KA1rBiazck5RBpCCjug5h8hVfsHG/7
 P1jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLGSgZpMV+Nf7K1D2Jl6JBgXdcqAAm7rG6gA7jNu3j/MPIu5HaLR5OsfvrsUBnqJRUWXnjy6bTILEQ@nongnu.org
X-Gm-Message-State: AOJu0YzSRyxniND0kd8hcn4rdPZYpMU8/CsLXs9z90hRF2Uy9cw1Mgen
 M1+wDIZMYDDZEAaueYG/uKYWTQNow4LmZqypYuYuZinHvyTarb1nc9qWjafQZ5rl3EANYX1+/PW
 tMbI+OEpurDh55FDD4IJfUl+Ai+HhRraJ7ffv9exE7sZBGcMkSPYMSWoY
X-Gm-Gg: ATEYQzza1IYzYfmb5XXxVaXVJjoEsgD8wHtyCayLWtLDW5Z+sB3h+RqAhqV8hjnhhKB
 1sOIFEVVg6nLBJR3d+isulggD1+VQZu2OSwtx4FHw7bKy5RwAcQTFbT/LbALkb2s2V6hw5gAPV9
 aLvNEycRhyLHO31buWk9UmxGB9yUF8/zTiswrRRZdpNb2/qi/KrSUPHY8gesiNcxGQ6gtJrG2Ht
 nHEGuxn4t9E8eEdHSZVGaeiBdkqmBOCg2LhH8RgPmn3hdn91bTMz7wuMt25srGV7D4Nog8A++Qj
 lP2kHQAbuPkhJob8yq7FtFPWpeP8qP21l0qJuadQQVTlweoiIVaSJl6kgtlet1n6ji6meP+YAuR
 JoPMW0Pt7QKlFRVDNUQGn0AidCqXB1BQLjHnx5OIVvikXAsTFh4598FQ=
X-Received: by 2002:a05:6a21:7118:b0:395:1225:db0e with SMTP id
 adf61e73a8af0-3959f272bc5mr939527637.9.1771991422746; 
 Tue, 24 Feb 2026 19:50:22 -0800 (PST)
X-Received: by 2002:a05:6a21:7118:b0:395:1225:db0e with SMTP id
 adf61e73a8af0-3959f272bc5mr939504637.9.1771991422333; 
 Tue, 24 Feb 2026 19:50:22 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 04/35] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Wed, 25 Feb 2026 09:19:09 +0530
Message-ID: <20260225035000.385950-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

After the guest KVM file descriptor has changed as a part of the process of
confidential guest reset mechanism, existing memory needs to be reattached to
the new file descriptor. This change adds a helper function ram_block_rebind()
for this purpose. The next patch will make use of this function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/physmem.h |  1 +
 system/physmem.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 7bb7d3e154..da91b77bd9 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -51,5 +51,6 @@ physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
 bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t start,
                                         ram_addr_t length);
+int ram_block_rebind(Error **errp);
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93..e5ff26acec 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2826,6 +2826,34 @@ found:
     return block;
 }
 
+/*
+ * Creates new guest memfd for the ramblocks and closes the
+ * existing memfd.
+ */
+int ram_block_rebind(Error **errp)
+{
+    RAMBlock *block;
+
+    qemu_mutex_lock_ramlist();
+
+    RAMBLOCK_FOREACH(block) {
+        if (block->flags & RAM_GUEST_MEMFD) {
+            if (block->guest_memfd >= 0) {
+                close(block->guest_memfd);
+            }
+            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
+                                                        0, errp);
+            if (block->guest_memfd < 0) {
+                qemu_mutex_unlock_ramlist();
+                return -1;
+            }
+
+        }
+    }
+    qemu_mutex_unlock_ramlist();
+    return 0;
+}
+
 /*
  * Finds the named RAMBlock
  *
-- 
2.42.0


