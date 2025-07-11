Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5658C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDvB-0007bW-Cl; Fri, 11 Jul 2025 09:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu6-0004XF-AH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu4-0003KE-G7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso21794295e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240903; x=1752845703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hksHQb99/pB3ZFE24pZ19Vblf7IkY7OyO3TtExD2Tgs=;
 b=Ttqn/ykLeyKHn6WsmiKbiD1koNMqqs6rX13DcbGwmFujhR2kbUrXTU5Yfyq78p4tAP
 8zi5eWilXDTmAuYa12oXNcg4b54iwpMlcG4u5PNcsAsbtZxVlORgP/J5CNMm6Wm/SNJW
 YewtIsnLHgtpopNhzfYaLW066Pu9u9N/wxeENZ4Hksc2Jz7RPAMzH441KyzrVGJX2x+r
 ucOe6RYjZKmPPQ1tU0Gnb8huKd+QHaEa8ZYHgWU6m+j2G4gdVhstq7WsWkmHd8gVokAE
 czEQHFzCeoVqnk//EnvlRpiklNSWHH9/C/RcYAP2yRpnLburUvSeU37xIu1Nv6LQYtN4
 aAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240903; x=1752845703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hksHQb99/pB3ZFE24pZ19Vblf7IkY7OyO3TtExD2Tgs=;
 b=Px9FxdGEJLGhTu82TU4OBFm6f5DeliGxWBz9Jqmqy110aJY5C/t/5krA8tzNQbOOSz
 HDhEowg7OWDNLW48BXKjLnpcBB7WVGCMJcWcYm5rBDLG1xALYXrzPj3qLgCSzHGtgHKM
 Gn7OECPjCcbI5w+tbfZvmVKQKZlMxLj5s+Kti8HZBHP0xkWOrDV5aM1bw2vi7wDqrv3k
 u+lqMGSHAhyZupA+z1+bDRLuGMzkkRqu08lHCZvfofsO/erTh5qjlO0pK33ua2p9EXtp
 cRrAWbyD6OHge8wnh+ks8TLospjgqjAggiqhVJICrFsuj5Hs8+RZegetrigScMBl4hWt
 RP2w==
X-Gm-Message-State: AOJu0YzotgVPhaz6hqtnxYpfR03eq8DvZB1YEK8roTD/AxgqOa9L8hwc
 HYXsQZW+Oiz6lpBmP2U/3H/+zLeCmv09TWWXfIP5DOoGHmPjf7nUZ5X624n6IHodq1raSX1iaLY
 zO6Q6
X-Gm-Gg: ASbGncuc3Vl1CsXiuWSvlattAJ2XMMWxyZWEI0fRAnhbU84n/rjqdp0SR//WexN3bpl
 NGXVv59P6XH3Q//d0D1cgxd1COaGSZSllO27m6nEpNSjGNjlf9zhvbeWZodjNARu8INHRV1mlV/
 VxjmeGvP1m3IkqttKWhyeM3keJ1/2ZwjzW9+QKq+2RE9e9sRxoAr7k2XpDjoEpM2qQnXWd4KLUz
 ZbdfNHfTyTWUONzzjv4B3oJRKXg5FcXEWwG/xg2GRHlpgYh5O60FCz+OvikwmVCiqN+oQEBDaIo
 bKE/3f9ptb2MNCLjph17nKgPWX6lCgbnhEfPeCSwVjORtk5+PGzjjd5cpDOHZapgDDV820ZWd84
 mQZAcXFbtp0oTY1zvSGfZyjNjRv+y
X-Google-Smtp-Source: AGHT+IHmlOtG5Kw1ES7lLzQnuaXpmSsm5MQ7i15J/xVHEAJI4Eb1P13Yc+6YBr72oDW/nv5sqW5Z9w==
X-Received: by 2002:a05:600c:3d8b:b0:450:cf00:20f5 with SMTP id
 5b1f17b1804b1-454ec164bc7mr33558155e9.9.1752240902814; 
 Fri, 11 Jul 2025 06:35:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/36] hw/arm/arm_gicv3_kvm: Add a migration blocker with kvm
 nested virt
Date: Fri, 11 Jul 2025 14:34:23 +0100
Message-ID: <20250711133429.1423030-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

We may be miss some NV related GIC register save/restore. Until
we complete the study, let's add a migration blocker when the
maintenance IRQ is set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250707164129.1167837-5-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index b30aac7aee1..8ed88e74299 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -827,8 +827,16 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->maint_irq) {
+        Error *kvm_nv_migration_blocker = NULL;
         int ret;
 
+        error_setg(&kvm_nv_migration_blocker,
+                   "Live migration disabled because KVM nested virt is enabled");
+        if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
+            error_free(kvm_nv_migration_blocker);
+            return;
+        }
+
         ret = kvm_device_check_attr(s->dev_fd,
                                     KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0);
         if (!ret) {
-- 
2.43.0


