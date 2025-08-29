Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9F8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNIr-0001pq-LE; Sat, 30 Aug 2025 11:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjD-0001Ln-RJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjA-00006T-4C
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0orM1aVNWIA/N/a7VgzNhQDU3JWqnZ2top440RxQ0lE=;
 b=YRsLhGsVBxU5aOwKC+Az8wRoXLAS/63ey+TCuJ6bbPn91BDHB76tM5A9E1q8AVxR4OcIah
 FS+cP4kC5lEceE91DiGyauzuE0+pXG37l5xCcoSR0HKsZKDrYbLzRTCXH/Z4e2YwGKhdwT
 dYNJNenUE92iBV7gsQYqqp9X/eugK74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-f8fxBGJgMNik6soxjyscdw-1; Fri, 29 Aug 2025 09:01:10 -0400
X-MC-Unique: f8fxBGJgMNik6soxjyscdw-1
X-Mimecast-MFC-AGG-ID: f8fxBGJgMNik6soxjyscdw_1756472469
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0cc989so16485275e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472468; x=1757077268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0orM1aVNWIA/N/a7VgzNhQDU3JWqnZ2top440RxQ0lE=;
 b=M85lrdmOoIzuKRBqrqnhijTN/6PmUWu1iLf49y/pn1YEFJ8R9GxvLNM2Q20FvPwksC
 Ac6O91t5k+k44S32Blx+B20YdxHtwKoJFmo+WPoqkO/zahA5ez4af+dlaqffKTybQZ7X
 Kzl5JbE896kbJg7/2ELw5EMjB08J0F8nPnTETZonkX9/ouF5xFkjEnFfwAt2P0CEpfra
 hNwxKbWrbLoQ9BVWse11FJSMeoXYJCVQB9FXcg/0WgNtHTMt1p2xPICetL2fdVu1Q2Qo
 lEvN+9L+YoJ/EvTvZRWH7/hRr6mclLgSaBl5F/t26cnridnU23XufWPQyAfdcMUoidmm
 gDlw==
X-Gm-Message-State: AOJu0YygcpN6mlL3gPKRk3xzbWao1A5An6RLQQbZ/lsDZjI35HnAuh5e
 4LWNQVbjSgXw+rlFgWRdFEOWnK3qXrI29yy3/8qO7wOGYw92Jh4QwoPe/kWpEXktHC5MXDap9Pe
 885yA5CeynZXlVGmKRxoDiGjFSehPfOct/oDXF3067DI0NvPYE7F2bT/K468Kcv+CPFvn+vZyD/
 0ZgZfwlfeTHqdirgDwId7Oq+eILI2mNVs0uCy2gvxl
X-Gm-Gg: ASbGncunm5tCNMZCD9M1633zHCFVsld7/n7BWM96FM1pZj+RVH/UWHlljdL9F7HojgZ
 LYijscaKOO2IUs5wUEHnWHWGslZ00v4t4eDZapVfhpC0gvpplQsEPY0Kh/ZFaJSv+bzlJ1XOcvd
 k1GPcCezUbOcNHIBWAsVS0j917I5qdf9NMgYK8bduJzaJllq9ymh+pCRDoRLSCCmbyXG+AkWjFY
 XVrE1ZdzwfIAdrCTA5g2EEbnHLvBFBtMAZB018IVHgD0kE/auhBozF+gxWwvklAw3hsPlLbZYQD
 91o/6dBg6GFOoggzoqE39lJKexoVCtIWoq5Ak518ew2LdXbaap5wYFSjTqQ2VYxMP1T/IGgsjWO
 ykQv2TSpEJMRsgXMP8Rpu+8PBF2L+gqhGtLR4FQvVTn0=
X-Received: by 2002:a05:600c:4590:b0:45b:47e1:ef67 with SMTP id
 5b1f17b1804b1-45b517e8d46mr198626635e9.34.1756472467505; 
 Fri, 29 Aug 2025 06:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Yv6xglzILBEpowjUqr6BdN0rB6z6cY37+FPkiEMRwvy3C3MmejApndDCueeE0XWKUSgM8Q==
X-Received: by 2002:a05:600c:4590:b0:45b:47e1:ef67 with SMTP id
 5b1f17b1804b1-45b517e8d46mr198626105e9.34.1756472466806; 
 Fri, 29 Aug 2025 06:01:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add483sm3307321f8f.37.2025.08.29.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:01:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 26/28] hpet: make main counter read lock-less
Date: Fri, 29 Aug 2025 14:59:33 +0200
Message-ID: <20250829125935.1526984-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Make access to main HPET counter lock-less.

In unlikely event of an update in progress, readers will busy wait
untill update is finished.

As result micro benchmark of concurrent reading of HPET counter
with large number of vCPU shows over 80% better (less) latency.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-6-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index c776afc0f2d..789a31d0a08 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -39,6 +39,7 @@
 #include "system/address-spaces.h"
 #include "qom/object.h"
 #include "qemu/lockable.h"
+#include "qemu/seqlock.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -74,6 +75,7 @@ struct HPETState {
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
+    QemuSeqLock state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
     uint8_t rtc_irq_level;
@@ -430,17 +432,25 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
-    QEMU_LOCK_GUARD(&s->lock);
     if (addr == HPET_COUNTER) {
-        if (hpet_enabled(s)) {
-            cur_tick = hpet_get_ticks(s);
-        } else {
-            cur_tick = s->hpet_counter;
-        }
+        unsigned version;
+
+        /*
+         * Write update is rare, so busywait here is unlikely to happen
+         */
+        do {
+            version = seqlock_read_begin(&s->state_version);
+            if (unlikely(!hpet_enabled(s))) {
+                cur_tick = s->hpet_counter;
+            } else {
+                cur_tick = hpet_get_ticks(s);
+            }
+        } while (seqlock_read_retry(&s->state_version, version));
         trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
         return cur_tick >> shift;
     }
 
+    QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -500,6 +510,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             old_val = s->config;
             new_val = deposit64(old_val, shift, len, value);
             new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            seqlock_write_begin(&s->state_version);
             s->config = new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
@@ -518,6 +529,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                     hpet_del_timer(&s->timer[i]);
                 }
             }
+            seqlock_write_end(&s->state_version);
+
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
@@ -686,6 +699,7 @@ static void hpet_init(Object *obj)
     HPETState *s = HPET(obj);
 
     qemu_mutex_init(&s->lock);
+    seqlock_init(&s->state_version);
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
     memory_region_enable_lockless_io(&s->iomem);
-- 
2.51.0


