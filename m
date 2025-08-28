Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4741CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau6-0003NQ-PC; Thu, 28 Aug 2025 07:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratw-0003FH-Gm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratt-0005eB-OR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b618e067eso13387775e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380880; x=1756985680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xhFp3A0M7NqYmjAgeESERQoIMPKzgUxo8xQ4836NcD4=;
 b=gyAAsLzbv485uv0C81jzbKs7t2PgQ4tWnmXFly1zw8PrYSePeG0d5PkuvI5B2tnBqd
 Th46gxFvxdkpT4kJiD5nJwROuYZNGLnwAWTfN1IekyfaYOoNdEtdK4coOh+Houmr/TNX
 sLTlKLGXFlzN7m8O5HXLYTQZB/iChlCem1v4lY/a/N0aVjpoiLuCtw+NHjCro9pxU8+L
 owosuKuPlQZA+D2hO405ebx79jfQPHzHl77ylNfW/0ipGptag6BDPpePjMDe+0EsJ72i
 oFRIqnyeEkFpmajDtnRPopp6tg2Q1lBaBVFXh9LyEuGxTzMwx2nSMQ/Ujhn3ThOT/rhW
 1TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380880; x=1756985680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhFp3A0M7NqYmjAgeESERQoIMPKzgUxo8xQ4836NcD4=;
 b=i+Wd7njt5khvok25A/r9yLVwD7CFJA6nYiuX3vjp4DiNw2Fk+lfvTffNvzH4/Kg4ii
 JLCn8eMJ2J6OSmlieGItRJWGHW6Fzp3dmk8A2y+5ZU9wKEWbRoPcfmRvFRUqHv0/hMhW
 +hA45T4lvP6oT5A2FPSSl5tBrBIiKQnv21+ihaTyE7Ruj479jMALPsGXvoaScln1xaXG
 2vXtfpDJT7y9C6PTIAQFBXPAUoepWzud7H0q0pI69kKw8S6AW2JEjdj+RqW0Uuav5HPF
 eXbTjrgGuDBmNWVGBMz8qDa5v8LZ9rQZ2B2fj2G0MHYatGQXQXo7RfSdRglUSGsGoaJ4
 59xw==
X-Gm-Message-State: AOJu0YzW9AG9rblVsnL320SH2mIHSuoselObJdC9m69NUhtiLivOKM7S
 OM9VdTUtZUw5bTfASlajB+fq71ek4sxigBOKtdi2kyRpwftLgvtQe77Tw3d7ZdQ8riQfjC0Ymnp
 EFNG4
X-Gm-Gg: ASbGncv+YT9ZzfIpx4poqjWunYCgKWkej1U7eyadh6Yp6vokyYx4cwnrsYgAcp8mQUu
 N6ELn3BspTHVooTsOlfCaOCERWXsx56LuFSk9n4rwDa9neVsw0m+XClucDcD8vPS0F9d9uUJLIR
 BKeEXzoufw9Tui0n6CeK8iGpgR7L1QW+wNmVIYrqy5KGtH+F/4GE6HaMapsHm48dVik/yQA437Z
 A9fImhJqmZxJyrzP9iIim0RWdIclQ9vBCYVx239eA3UX/XG5a9VqyDeFI+dj7Nr+MJ99DrMbxQI
 KKrx4RztQYvqjoK5OpcOO3RAibOGxZDqs4X3wJy9h5SBMxaXb69hKlAvBqVks0LTtRq4b3BVemr
 uApLucZRWVWRo1RveHqajU0cAZTBxuIxwzt3rleI=
X-Google-Smtp-Source: AGHT+IE+zQAdDMlrczfTqIG+WvesPJLS53lGoFS0Z5fiV/FLP4ybheUC2LX7jKez0L80Vuf9VMiklA==
X-Received: by 2002:a05:600d:114:b0:45b:7585:9f95 with SMTP id
 5b1f17b1804b1-45b7585a756mr19207265e9.3.1756380880108; 
 Thu, 28 Aug 2025 04:34:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
Date: Thu, 28 Aug 2025 12:34:03 +0100
Message-ID: <20250828113430.3214314-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Steve Sistare <steven.sistare@oracle.com>

Close a race condition that causes cpr-transfer to lose VFIO
interrupts on ARM.

CPR stops VCPUs but does not disable VFIO interrupts, which may continue
to arrive throughout the transition to new QEMU.

CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
future interrupts to the producer eventfd, where they are preserved.
Old QEMU then destroys the old KVM instance.  However, interrupts may
already be pending in KVM state.  To preserve them, call ioctl
KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
they will be picked up when the new KVM+VCPU instance is created.

Cc: qemu-stable@nongnu.org
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-id: 1754936384-278328-1-git-send-email-steven.sistare@oracle.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  3 +++
 hw/intc/arm_gicv3_kvm.c            | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c18503869f9..572d971d22c 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "qom/object.h"
+#include "qemu/notify.h"
 
 /*
  * Maximum number of possible interrupts, determined by the GIC architecture.
@@ -271,6 +272,8 @@ struct GICv3State {
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
+
+    NotifierWithReturn cpr_notifier;
 };
 
 #define GICV3_BITMAP_ACCESSORS(BMP)                                     \
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6166283cd1a..0cd14d78a75 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -31,6 +31,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -776,6 +777,17 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
+        return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
+                                 NULL, true, errp);
+    }
+    return 0;
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -917,6 +929,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
         qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+        migration_add_notifier_mode(&s->cpr_notifier,
+                                    kvm_arm_gicv3_notifier,
+                                    MIG_MODE_CPR_TRANSFER);
     }
 }
 
-- 
2.43.0


