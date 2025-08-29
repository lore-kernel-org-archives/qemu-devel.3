Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C4ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNI1-0001P1-7X; Sat, 30 Aug 2025 11:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryj6-0001Kw-9O
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryj1-0008VN-Gp
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfuI+eYyHqGdGwnOJuZfiUIJtJVwLpHcMFmDHYw07EI=;
 b=Io0cDZWsN5zH2eWXBMRJkQxkMk0mZSGxSPzolm8k9SZyYUGPvpzQr6pLfouCfvkjZQxmKj
 ivibW0qU/bzzeoPjC+cAvg/Ou/PH871tPm34/PhpMYKs5OPd1YNwEnCDgbOGiQWobg3ciN
 +LM48PKa3DAf5XoCD39ic02VCh7p38A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-zx8ndt44NGaDTHIVEQyq8A-1; Fri, 29 Aug 2025 09:01:00 -0400
X-MC-Unique: zx8ndt44NGaDTHIVEQyq8A-1
X-Mimecast-MFC-AGG-ID: zx8ndt44NGaDTHIVEQyq8A_1756472460
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3cf12498799so589173f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472459; x=1757077259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfuI+eYyHqGdGwnOJuZfiUIJtJVwLpHcMFmDHYw07EI=;
 b=CKrJUMTwYFp0VvqoZs/WnqlsCUx+3/Xc8Y6HXwHTKKcl1Nxqctfyo2dRy0ocdUBzxI
 Mq1q71i0536ZuMR3lUe4lM2vaC95Uti5026a/2OIGgZ2CU9MbhwY8PtG5OvBfXiwd+yH
 9KJCDDLSlYxxBvo75rSUtCwaEDhcUY0g6JobCt0CZXzOD706oJBoyDlvxQ5QeKEn0irF
 5QTyn00/h2R1OPcDV/c1+iYS/jsiM9SRcuhJ4cwxYJ4M8ehCJZcJT6i6Ocs2hjRTzvz3
 MJ/IHA5R6UMJGVKfln0Vv2ZJDDga/9TzIpG5rJFidlzOpR5ZcUt3Vm+HPaGOsbSjFGQn
 nQXw==
X-Gm-Message-State: AOJu0YyA9qEz6mq/yYBWK/8sht++yCyN0fCTwdm0dOvSB+y++Mgxq1No
 rFfhrqRCO8K+dMnERnPBUNjP3yJW/oTQzLkK6B8dK04mOMzkUl8cntJxJZ1bm1fz5BloIxEN5Yp
 HdIT33RS1L7oTA4ulQYRFzPNUuSi9segpp/C795JwkLWog14DsAIL5IyxagE3MYnyVdIodqF0rc
 wcPfKRzHUXuvOPwnxkSNf5ZoHN2ZJEsf+UEhRjzn27
X-Gm-Gg: ASbGncvd45igvulNq1CLY7frjaM251KmqLXtoNrwBxmztDQSbAg7GGbniMCUBV0dUyC
 vfwJL0ZqrAurp06A98xKCOThM4QTNu9QvJkDBkutjuqIwI+rRXKLEzB6RhsY6Gy5g5QhEpjf8Pz
 V4U8smYF/xuvLKc2UlCse/fzd3rFzAdAJDFh1L4l3yxO40n2R1Hg7w+SXwtfVRqg/De7+RzJbWL
 ovEH+ttDhVtJHV2I54W6vQTvs+Pe94f8CBE22tD9SN0obXVDhFmkwV9+jDvsjMGdYgmFAe4N5Di
 l00EpPa1ygNDmsgGGP/RusGbWmTM0ehNAU3V25lDXmQg/sjkm7GlP2MUq1yC9hrlwwe9WCycLJV
 U68yjf7K/lqvDObfLvYGZkPPfePjWJBJnW8Fmxq26XlI=
X-Received: by 2002:a5d:5887:0:b0:3b7:88f5:eaae with SMTP id
 ffacd0b85a97d-3c5dc542ac7mr20825061f8f.39.1756472459171; 
 Fri, 29 Aug 2025 06:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAjb7hyifQXIMNGh5s3fBnPMSLDF3TFTYmDsxKKRWgZuXq0AB1WHRhKxIW+o3MWszv4TWkQ==
X-Received: by 2002:a5d:5887:0:b0:3b7:88f5:eaae with SMTP id
 ffacd0b85a97d-3c5dc542ac7mr20824998f8f.39.1756472458477; 
 Fri, 29 Aug 2025 06:00:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a7691340sm2354126f8f.39.2025.08.29.06.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 24/28] hpet: switch to fine-grained device locking
Date: Fri, 29 Aug 2025 14:59:31 +0200
Message-ID: <20250829125935.1526984-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

as a step towards lock-less HPET counter read,
use per device locking instead of BQL.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-4-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index cb48cc151f1..ab5aa59ae4e 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -38,6 +38,7 @@
 #include "hw/timer/i8254.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
+#include "qemu/lockable.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -69,6 +70,7 @@ struct HPETState {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    QemuMutex lock;
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
@@ -428,6 +430,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
+    QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -482,6 +485,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     int len = MIN(size * 8, 64 - shift);
     uint64_t old_val, new_val, cleared;
 
+    QEMU_LOCK_GUARD(&s->lock);
     trace_hpet_ram_write(addr, value);
     addr &= ~4;
 
@@ -679,8 +683,10 @@ static void hpet_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     HPETState *s = HPET(obj);
 
+    qemu_mutex_init(&s->lock);
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
+    memory_region_enable_lockless_io(&s->iomem);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.51.0


