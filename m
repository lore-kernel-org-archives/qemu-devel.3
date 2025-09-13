Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D2CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNJ-0002KC-Ed; Sat, 13 Sep 2025 04:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMo-00019e-Un
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMm-0005G5-Lv
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f392cpvVrwHS/NTGEyT/MWK0tqiJzK81OigZJrwHYxo=;
 b=BmKHT2GJX9qlRq9s+RPxh6g+XImUjhGR98YPjYoslHPcRI+SQRJEv4gonuBjd4dlLNubjy
 lrbbjECZ0Ku5yAvKCgiYCk2WU47V74Ko/nitQdbu11mldj70WIihASteuduBwpPd4YFJTa
 X9bsf6hjvHergRPZZvFPJxoMBDYQZGI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-dXK4CBhANGmUcEJeuXFMGw-1; Sat, 13 Sep 2025 04:12:14 -0400
X-MC-Unique: dXK4CBhANGmUcEJeuXFMGw-1
X-Mimecast-MFC-AGG-ID: dXK4CBhANGmUcEJeuXFMGw_1757751133
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45cb4f23156so15626895e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751132; x=1758355932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f392cpvVrwHS/NTGEyT/MWK0tqiJzK81OigZJrwHYxo=;
 b=vzICEdOVCRvafTustfKNuhzxhqtVGU9yMYzQo2npFrTJKOTqAZ7wpiOj++2M79lPc9
 wpWdS9FPndOBAsK8hhjfI9B9VnJaJsdDh1V54QSY/yhlsApm+E8L1inunnBvTSiyDe58
 IOp2v6Ffv/cLnc1uCw93ORNinmap52L68zeedfK4EXWAIIUSQ2myQ9oAgtTJ4Wem0Adx
 bEZvagDvFMEGV94erDPeq0ZKhGrGJTB/lYcNXAPR5uba4GyZUTPKqxSfC8mBJHkU9hRi
 +M65O9cStYf99mv5hiFHzjCwnbsoGTNtL9uaHpVbDDT5miYDFQeEgqzlap7y/CAa42ti
 hFIQ==
X-Gm-Message-State: AOJu0YzPAZKCDIG9qjJXHFThsWQlZHXt81J3KSndnima1O+7cGm7CHj3
 y9Kwz0QFkbS69y36q4fpMu9lWdxRXKdv1ciwD+PEFIUVeW1TF0M1nUelw8cYwpsTH768dlW159k
 L/RabXwGA/qS1L6w7aGwUnKre47eN5CNusa00ibI9pma4QW22N/oyIuH4xr9pKd4UCBrehjmzL5
 gepp5hrTIKGk6QpaNMtdCxDFHtkN5zLKkk/y9nRkcd
X-Gm-Gg: ASbGncs6Ye8V3oA8KH1iKWGNRut7+VwRMKnumWLBJINlyyfwuhBPjAF4SeDESyu2piP
 O/IYEAaHxxrxKY3+eTbJ9vtS1zyzAl1RxysmFeeXubaZp8OVbQbQ5oAKhUW3CL+PsH5vL0rBCUV
 8FQJ5ffrQXhP7YVgguxE/gpGgrLMFyn7u7fMdRtYT2PnxUA4LfZVQ2Yv5zI3nqRV1XnP85QhkDr
 t3PIgUCDAts2k7GHQUsgFPp3oVrCRLrG9s5tDv3ZvuLLmg/PrX3pTJgyxZuWWBtKGJoMOsorACO
 11f22jmd3WjsqjT2TCcHXHIxJvKYqE5VJGTge7e1YqC/+6UpwYfkFaYGv3PUK9CvDHHwbs7alND
 xmGmK8IGSloz5KJnmdWzbphni16tdI5Ch4+UDLhIjOkE=
X-Received: by 2002:a05:600c:4f89:b0:45b:868e:7f80 with SMTP id
 5b1f17b1804b1-45f211c8388mr70627645e9.8.1757751132078; 
 Sat, 13 Sep 2025 01:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZol7l839qBTzqOA8Su51vMoD8LUf321sO0LeMCftH76zx202suAfgU2WQW7eTGaLrsHvNOg==
X-Received: by 2002:a05:600c:4f89:b0:45b:868e:7f80 with SMTP id
 5b1f17b1804b1-45f211c8388mr70627295e9.8.1757751131594; 
 Sat, 13 Sep 2025 01:12:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b2a32sm93123355e9.18.2025.09.13.01.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 53/61] hpet: guard IRQ handling with BQL
Date: Sat, 13 Sep 2025 10:09:34 +0200
Message-ID: <20250913080943.11710-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Commit [1] made qemu fail with abort:
  xen_evtchn_set_gsi: Assertion `bql_locked()' failed.
when running ./tests/functional/x86_64/test_kvm_xen.py tests.

To fix it make sure that BQL is held when manipulating IRQs.

Fixes: 7defb58baf (hpet: switch to fine-grained device locking)
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20250910142506.86274-1-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 789a31d0a08..1acba4fa9db 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -40,6 +40,7 @@
 #include "qom/object.h"
 #include "qemu/lockable.h"
 #include "qemu/seqlock.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -222,12 +223,15 @@ static void update_irq(struct HPETTimer *timer, int set)
                                  timer->fsb & 0xffffffff, MEMTXATTRS_UNSPECIFIED,
                                  NULL);
         } else if (timer->config & HPET_TN_TYPE_LEVEL) {
+            BQL_LOCK_GUARD();
             qemu_irq_raise(s->irqs[route]);
         } else {
+            BQL_LOCK_GUARD();
             qemu_irq_pulse(s->irqs[route]);
         }
     } else {
         if (!timer_fsb_route(timer)) {
+            BQL_LOCK_GUARD();
             qemu_irq_lower(s->irqs[route]);
         }
     }
@@ -534,10 +538,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                BQL_LOCK_GUARD();
                 qemu_set_irq(s->pit_enabled, 0);
                 qemu_irq_lower(s->irqs[0]);
                 qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
+                BQL_LOCK_GUARD();
                 qemu_irq_lower(s->irqs[0]);
                 qemu_set_irq(s->pit_enabled, 1);
                 qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
@@ -683,11 +689,13 @@ static void hpet_handle_legacy_irq(void *opaque, int n, int level)
 
     if (n == HPET_LEGACY_PIT_INT) {
         if (!hpet_in_legacy_mode(s)) {
+            BQL_LOCK_GUARD();
             qemu_set_irq(s->irqs[0], level);
         }
     } else {
         s->rtc_irq_level = level;
         if (!hpet_in_legacy_mode(s)) {
+            BQL_LOCK_GUARD();
             qemu_set_irq(s->irqs[RTC_ISA_IRQ], level);
         }
     }
-- 
2.51.0


