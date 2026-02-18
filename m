Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3580EE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxg-0003Dy-VC; Wed, 18 Feb 2026 06:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxa-00038I-54
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxT-0007nk-1b
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=V8jLMq648UpzUNWWvdbtd+80c5GVNDPE6enDhV02k1cJsNJcpVlow4veB4f1BVqfWNWg8R
 PKRGe7IT0K8wtlcpx8Qm5tYkjy+GitGQKRf68lHD4oa0OjyySCxQu6eAxDQkuS6ZG/CdUY
 NtLCKblipWrN5yrzz9mrFwKkHb01Yx0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474--wgtqLMMNiCf2Y50H7wgXw-1; Wed, 18 Feb 2026 06:43:00 -0500
X-MC-Unique: -wgtqLMMNiCf2Y50H7wgXw-1
X-Mimecast-MFC-AGG-ID: -wgtqLMMNiCf2Y50H7wgXw_1771414979
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so66397675ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414979; x=1772019779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=r/Dnfs5EfEjH2ddnocklwwYXa4X0KpZSBFwLhSI9OflgHvqrf/iZlczyW0IxTonCIx
 yy/WPauuvKYog+Yeub3SP1mm7Bzq37Ry9GWBi/sV2S+eC/DWi37+ICioQT6Z3NyST6Jt
 HOWvsTA3MNjdFlwfVxtLZgAHD9uWMZxCj2pOhfoVgvqcXUJbkeSTbSnyudoQeN8rNYu4
 nSzh234mmDWTO463GMtERQVcdo3W3a+nG3q4gf2b9rpzWSQT/2YcctjV+G1SV13cgjlK
 JufSbJKjZrV5OVoQjzPQtfpDophuqtJ6P2bbi3gltuC4iPoIf7F+ziTuMSaO11G/eqly
 94LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414979; x=1772019779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=mGVOPkXcbTGdJMtrVIf/0XDUDcuAmF38XWDc1eAl3rGqRtSUe3s+FfyI7b//1r0dt4
 ZeI+eCstlKaGI8wGtYDhHCn9u967TNak9t84j1UaCyETZzHYEHz/0Kmzzkql1XiOZ7fV
 2CRXspqpV3GBAmLNXWUte2OxnFHXHBrTbs8EDc4ZJUA9fw8Ub+cW/KDtGHGxl6jIaHhd
 ySPTj2B79hJZo9u3qPHexyvWsWNzUbnaO8minhYZBeXQ/h46Pa01oEsLUUmghOxYNGaN
 GTyUHek80NA/t4QFoi2AWbEzoaiBQ7TaU1jNAyO26ZQelD0hjzTJMb/eDAlFRsPs5gYM
 7/hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUegrNe0oEInUleDtIZ/QkALB1jmlS7jbIzsfQU/dlZ0yqnGjbKRkwxb4fGcm6GQzzsPKOkGFPRlP2s@nongnu.org
X-Gm-Message-State: AOJu0Yz+65GIjwrjw/u9EASXUCXgH+Za92JGe3bdVb8IKuFjjMKsfy7h
 s2hL0r8BK/bsjz/7hOSyDKNCxRqpdiBZYv3jnObq/8y0QER1ypT66RQHrw54fAFcGJ47Tn5uLSv
 Dmfpcm45iE/Q4bVf/DsmD3GtSm9GwJSDYQgxhSp+0qo60q3JqSr6lCp1O5BwDY37G
X-Gm-Gg: AZuq6aJ5mqFJa1v/Dz+bqXMYIlKgH77ya+Pu+AHybRnHehKOG7vd+5Xg5iu5RdZjrb6
 7aiF8oID8iXtdHDbDVE5YoqYDKYOQFqzhqgN/Q09mKzXg4vwvTBLAkD8TEWYxkMSLWy+g8R9W/A
 UhtcvX6nm9qe1s1jR+E5OKJ2Ml3LUJJD95I1Xd9/btQ6tFKPo/u62U+1kq/mlA6JHPebHMWIpAK
 zDn2qhFMPFO8hPY+tiQY5gHzpitq1jKjMKm6sjMYaKfxIyH8v5kjjDO5X4Xb7riK0+7EtKHzKw/
 N/AF5YwPv0RaPJCRSugHI35rlbt8pK2i0g//JLezr6VF5h6ZqVPrRdSrNyIbTkTR6hRsrZvE3O2
 Ze9liFotKBBw6lWNCks877+icVxJxFL+FHWV7y95cF5sUq/bxTmGs
X-Received: by 2002:a17:903:2452:b0:2a1:3ee7:cc75 with SMTP id
 d9443c01a7336-2ab50560babmr177003755ad.19.1771414978764; 
 Wed, 18 Feb 2026 03:42:58 -0800 (PST)
X-Received: by 2002:a17:903:2452:b0:2a1:3ee7:cc75 with SMTP id
 d9443c01a7336-2ab50560babmr177003585ad.19.1771414978405; 
 Wed, 18 Feb 2026 03:42:58 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:42:58 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 04/34] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Wed, 18 Feb 2026 17:11:57 +0530
Message-ID: <20260218114233.266178-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


