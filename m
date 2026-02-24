Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795BAF4BB8B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzsL-0002sW-M1; Tue, 24 Feb 2026 16:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeQ-00073m-6B
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:54 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vuxeO-0003KA-NE
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:00:53 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-506251815a3so56457871cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771959650; x=1772564450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7DCqEvyzrckcFdroWeW1cjCCZ2EZdMePnVfutEI11Y=;
 b=i3A6tm/QYySc18SVRm193mQRB5wBdha6BDQpUlbf8J8YPH59UrdsQldbSQlXoim8T0
 WErubc/cU8KwVNokhX9KmA4pna/4COM/9h9DRnu7MOej6G1e+3veQaDX7Tjy6gCB2GgX
 Fh6ji55yewn8P+O1ALVbMog/HIoWW8jYENu5m1oKQbAh7HEonOXNlltvlPVujoX5pkZy
 yWmjYEXqWW+4n+35TEW2HR3G5K6G/laKp75YoIQjq/O6gSDXhHTCw489lE8dDvAajg7S
 2RbVA0VqrbGNgxWTZNeXDSibG/WVGmnHlkj9rlctkPMxRdQlLMLD2RL7rv6DcsVYqfpl
 NdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771959650; x=1772564450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7DCqEvyzrckcFdroWeW1cjCCZ2EZdMePnVfutEI11Y=;
 b=IPMpuZkQqy1R0mHzhEf0eAAdmBSe0P/OoArtQulpvIfCL8mLMqOhK738NbyObAKGwR
 i+D4TQ2C8GMI5e4tX+GQhcmaBh+VR/7kCuadnou82EOsA4eZfOSVYfL4xefwC8OFkhw0
 vl9d3PRhYGCTGwswxfepTnD0PYMuUnihnwO/O5JcOrFAGrI/1Ev9J1GosqNkQ4cPpWXn
 7RnzXoxeLt4cryG+lpzxKTlrxQRNgcslM+9//ZkuoC4bfKg8lpiNfWOSoFd4a34Ht8Nx
 Jy3QhPByga7oqqo2lMs312tq6hupCP1U4bmyevUHN3oId/6XA+8QeniRcy1ZIDz/vSbF
 98UA==
X-Gm-Message-State: AOJu0YxrX0gBbPoRndvK7MOXc0MJlwHB/bJl9anscUZXuEeBh6qXBV+Z
 u+QkTrjMDOwP8PjqSw36CP2NJjvoVtwbb1VEpN1pgRmL3G6GySoIqYhmNuXACA==
X-Gm-Gg: AZuq6aKdviWfSuXhTbbb6syhaC/YcFIONm6guxe1mP8Alffmwtv6/vdKxRg90iQMvIg
 Qb+WZbwreo74ui56oy8mhT8ik2HfXTqHfbLv1eNRtZZmkAtg6KEmaBorGjpVdXrX4hMsoMu/1Gl
 h3rsqLRTeMxiQ3CpT3lqUZ1tEtjWs7Wmw5Gq5khkJjhbXhqNyVBwgak5J7va4vozmesNPMp1rLx
 GIf/dk8hbw9iaKqD+KL0Q5P02zOeWvw+3G+j6ZEOsec3mSQB/cmTXVfRyjhIc6AE80Je3o9M0/4
 LE859v3CpkHmzF980Ji4y74vUDkrCLoMh7QZu6AALhX0p+ihJFK91K80q0YVpKUFL5/dbPWJKaS
 XfyWMJP+sf+gpRzxJSzC+WfIHSOyv0rVuDA3QWaFb1nrM7IXTPjlwQxikPWLJ9+aAwPiW27Tfan
 +p3ZqhC6e+2/iHz7Z1LF8b0HI/VEci3qmEmy+K4ucb73icsoyUYIs=
X-Received: by 2002:ac8:5711:0:b0:502:a2c0:dc4e with SMTP id
 d75a77b69052e-5070bba253cmr189366581cf.15.1771959648825; 
 Tue, 24 Feb 2026 11:00:48 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d3a2dc8sm102616291cf.0.2026.02.24.11.00.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:00:48 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH 1/2] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
Date: Tue, 24 Feb 2026 14:00:03 -0500
Message-ID: <20260224190004.84187-2-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224190004.84187-1-dahamilt0@gmail.com>
References: <20260224190004.84187-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=dahamilt0@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:23:21 -0500
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

The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
ignored. Propagate the error to the caller via errp.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index a3a43f53bd..45b0e20363 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -449,6 +449,7 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         ivshmem_has_feature(s, IVSHMEM_MSI);
     PCIDevice *pdev = PCI_DEVICE(s);
     Error *err = NULL;
+    int ret;
 
     IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
 
@@ -464,9 +465,13 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         }
 
         if (!msix_is_masked(pdev, vector)) {
-            kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
+            ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
                                                s->msi_vectors[vector].virq);
-            /* TODO handle error */
+            if (ret < 0) {
+                error_setg(errp, "Failed to configure irqfd notifier"
+                            " for vector %d, vector");
+                return;
+            }
         }
     } else {
         /* it will be delayed until msix is enabled, in write_config */
-- 
2.50.1 (Apple Git-155)


