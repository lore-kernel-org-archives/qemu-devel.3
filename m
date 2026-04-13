Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E548EBFD1C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDA4-00027o-KG; Mon, 13 Apr 2026 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCDA3-00027g-Ds
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCDA1-00044K-GO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776070846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
 b=O6F+Ma0NUUc8WVMleajvQVD+Vd/mZ/ZXYUBlssaZdT0ja/QUKZzhSpzQgc3dk4BOBORKgE
 czlSdy138qEcPmNzwl6p4HVJwBOzZGg4E8hemt2KT2ylKaRG+6VfQ/EquVqdHMUSL8owmh
 f4rLke3CvLjsI5BR6pb2vOLoq0/ohkw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-LcRD21PIOtmgB1s2Opz-eg-1; Mon, 13 Apr 2026 05:00:45 -0400
X-MC-Unique: LcRD21PIOtmgB1s2Opz-eg-1
X-Mimecast-MFC-AGG-ID: LcRD21PIOtmgB1s2Opz-eg_1776070844
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso8756499a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776070844; x=1776675644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
 b=hQQjrb6a8mvhl3czjgHN1hBV2IbOseKK6Vy8G4Em9houEEQP6DliD1tieIXq8MsYvp
 Vy7xZIlqVZpKweJzpKGnl4d2JEdUwIFUBH7x2zB+E81LhLjWPjbg2IrmW0nm7bWSypd8
 YotWKUGiiQ7DO4VSgdSiIo3XO3nJ5sOLL3iaLRAp0L8Vpy809Juf+r7+9Ny/xiN6fQJQ
 6LKBMQq3Ss9AWq7HKpqGmRJQzEhdBIwjjn2swPBkQcTAE3gyJf//B87nQQAZjExU389d
 PSyMvC01nMH10hRUfpDmc2HgsKXtmh62P5Al6zIUpx1+YaL99NOf77lUyEf8CO22OacS
 TUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776070844; x=1776675644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
 b=GRLmyrclj2WNa7TcYz4MX/0fcvGL+Bok6Lq5ogR8hudl1L3mwf0TLejlPREeywwRiY
 GEkrbYCvTjVPcWGzp1gLEtHltPlvXu44nK6frMjbj5QEQCp/wWDI/urbPGflCoHyaucI
 XKPypHTBe50wZSUtpEDndYoBWbNSB13mdEYMx+86FUW47Xbs88vDG1K9NCjwr6IEUEf/
 HnIg3uacxmeiIzAv2dMsJrVrwUk/Z+UaQSjnLiLpUkPsE4N39KAw1QDvhVNnV0Cm+MmX
 mtYGTu+5xHa6tvCOBssKeVru9vkVzzLimMwzGheK1UXXGxaU/8wwWI4KqT/SMP9Wwtqy
 YEgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lCa9gMQ1CQQmN6uC7O0YB6kF80RAU2ZBgSwOxj0znMy+GQHo6UJkomYRfvEBKNu6ShrjaqVMZu+bG@nongnu.org
X-Gm-Message-State: AOJu0YzQ5VMRbL/wxHCt26OEOXp/LVtcO3YAIJe0gZyiM1ELOdbziNwS
 57h6ayQTg3p1JbzHRdCPyhM4ytTeX5vWPY/470AvK2tht3CtY85otExvbHIBjNe+KwSKew51MTl
 /oiqODvqNflXjnyNpUxvMeEGzL2Qmb0NXoME34K7R/rGd3G1dRhtdZKFI
X-Gm-Gg: AeBDietORy788CIG1g87DZoRKRuecEIKU3eCoWTsN3JrkyVHPn2zMtRf9yaG6I9iJ4H
 F88XBGmHVhnS2U448BeIpYpzb+2NfuRfFzNlP9BSP/7PtTg39/9rfpGiHMj2UCAM3dc01Lp0A8Y
 g+JurkWRo9dhOk6T+m/i8mhWYFi8KMKuoIn/Mfj4RA1JvMU1UjHOEpfJ5q8n2i7ceaNpiaGI0qo
 CApN53wcLkTHtmMi40s5dGaQoXYr/3505XCdmNilH5A+ineiyrwNZpQzsysOZ2/6af74KMQWeYc
 7I3QZAe9q+AQ8SLCgUQ8HJhzDCGadN5OQ7VGGeP/e/oGQIr0qTgAasYpz+9vxISttug2DSE0f2e
 WMQHyj4BUiiZuzmsB9aq80O6dXoA9EKs76+oL5Xbiw6ALDOqKAfysBmY2veninte9wyWwib4uJK
 qTiZJi6Q==
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id
 98e67ed59e1d1-35e428cda1bmr13170965a91.27.1776070844343; 
 Mon, 13 Apr 2026 02:00:44 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id
 98e67ed59e1d1-35e428cda1bmr13170663a91.27.1776070839003; 
 Mon, 13 Apr 2026 02:00:39 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb38eb48bsm3560588a91.2.2026.04.13.02.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:00:38 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create if
 kvm does not support irqchip
Date: Mon, 13 Apr 2026 14:30:10 +0530
Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

During refactoring of kvm_irqchip_create(), the refactored code was returning
early from do_kvm_irqchip_create() function if the required capabilities were
not present in KVM. This was not translating to an early return from
kvm_irqchip_create() as was the case before refactoring. This is because,
do_kvm_irqchip_create() did not have a means to notify the caller of the lack
of kvm capabilities. Fix this by making do_notify_irqchip_create() return
EOPNOTSUPP error when required capabilities are absent and then the caller
can check the return code and return early.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..92af42503b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void do_kvm_irqchip_create(KVMState *s)
+static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
@@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
             exit(1);
         }
     } else {
-        return;
+        return -EOPNOTSUPP;
     }
 
     if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
@@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+
+    return 0;
 }
 
 static void kvm_irqchip_create(KVMState *s)
 {
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    do_kvm_irqchip_create(s);
+    if (do_kvm_irqchip_create(s) < 0) {
+        return;
+    }
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
+        /* ignore return from this function */
         do_kvm_irqchip_create(s);
     }
 
-- 
2.49.0


