Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B7FD3749
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDlp-0006z0-0p; Wed, 25 Feb 2026 07:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDll-0006yV-Gn
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:33 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDlj-0005V8-Qz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:33 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-897002b7576so89060156d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772021610; x=1772626410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSYA1Q4q/L6p22kNI5axX3mj2bIY09wz5eUmq35S9i8=;
 b=QnM5teLsRFPLNNb/6V8Xu8IGzMuoBRbIEp5OQn8EgpADp3DGs6ZzrJyzo7UAo8lCcQ
 indFSa+zW4POBrGjNvrTyLJiFaK5X8/qtmYbiEVqHVp9bfA3d8DKTz+V36MRGPg3sVMP
 A4OLeiF2VAVx9BGpqXmxkhc4bjG31RTBbX9QQhtSr+QpWScXlOFng+n1jJ9q6fOw0DB6
 9c48VMHgIjEbMN+zbVF7jVwcWj769d708f9/xcYkG5Dmy6lhZ3NznQFjmTqMze66khgj
 iOUiAclcGOQ1BKnsnyfVMcWBjWz4dGH1dZ2MdtJOqkW8Onezj6VRKJWrKE6S73rSaizZ
 UnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021610; x=1772626410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TSYA1Q4q/L6p22kNI5axX3mj2bIY09wz5eUmq35S9i8=;
 b=q/q8IvOWzCl02K+OgDBv0XrM/ZexkRyrIgCekcE6UWDFbClKLM2u5yNwxrP8HrNxLp
 phQANug5olcFcxG1HSYdQr9WLJXmyXpU6AYFj2JgkOrFCNC+M9ET7GjRs8MraiISdScO
 1k3zz48PTWat+U39Mz0HEq50QxxBV2gTgMJfhqMY9ftRAJuImbQwYtMlagiexTrMspZ0
 8lpNpE3H22ct4i/WZZB2Ig1PmkSxeJjJwEVRq8R6C2ovTX01ytK9b7IMq3nD6JEsdxXh
 br/ZWX0SomFZyXbHkWObG+tJELUGIJCj81yA+JHd8027B/Nv7LtlFYQ9ZhQB+56BE6uD
 ZC+A==
X-Gm-Message-State: AOJu0YzkvSFAaHgyAzRFqD9rfgazfpE/ujMKeY2q8bJAAWayanU6fdej
 Z4D862NO88UI1GsYCtQIDvFXHHyewKCm8Wn0stOpVigiIX6VDBWCQ/s3hpqJCA==
X-Gm-Gg: ATEYQzzFBB7wKqeKFGiG3WAy8paH0lO2qsDN+TJ9N7/cP9AQctea2eGI4Z7xtYWw4AM
 SOytiy+Lofd/XryPfWHPkbHOIcDXCzRrMX87prHCO1xQLtHdN5oLckEhMoDfVXf67I841eHDUBi
 CXrhSCLmhK3bn4Y1j+lTOYHO9a9owUaATAiKqczTvGpX02AJPwhQLSlX/P9x37yqKcva8mLtZYr
 ERXepWelzaZCFIhsTo74R+JbLy250C2IvgeG9U5ncqyKxqPcoWxdmJI+KSmLGHO0fDSyMUyEBmK
 zVfOhsvyZTYZCS/jhfycIQROLA14jKdj4q2xwE2z/wLkhsgq++EWiXISAqH/swt1CjsbUjilWwM
 UDsAWiGXRmIY0WA0ToiwPImcm004bTwuMrreC3bEYpTd8aZhmqaRPIrZCaBKruowrtViaaEJTW7
 ZS3N2jgjjrlmtOol8OjoPE8iQfhOu3on/nUcqwQRhvN34zK/HSLGQ=
X-Received: by 2002:a05:6214:5099:b0:899:befc:5eae with SMTP id
 6a1803df08f44-899befc6cedmr5927466d6.11.1772021610270; 
 Wed, 25 Feb 2026 04:13:30 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e77aedasm115830606d6.53.2026.02.25.04.13.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 04:13:30 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v2 1/2] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
Date: Wed, 25 Feb 2026 07:13:22 -0500
Message-ID: <20260225121323.5395-2-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225121323.5395-1-dahamilt0@gmail.com>
References: <20260225121323.5395-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=dahamilt0@gmail.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
ignored. Propagate the error to the caller via errp.

Also change setup_interrupt() to return bool to follow QEMU error
handling conventions, making error checks at call sites simpler.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index a3a43f53bd..c987eebb98 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -442,13 +442,14 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
     s->msi_vectors[vector].pdev = pdev;
 }
 
-static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
+static bool setup_interrupt(IVShmemState *s, int vector, Error **errp)
 {
     EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
     bool with_irqfd = kvm_msi_via_irqfd_enabled() &&
         ivshmem_has_feature(s, IVSHMEM_MSI);
     PCIDevice *pdev = PCI_DEVICE(s);
     Error *err = NULL;
+    int ret;
 
     IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
 
@@ -460,18 +461,22 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         ivshmem_add_kvm_msi_virq(s, vector, &err);
         if (err) {
             error_propagate(errp, err);
-            return;
+            return false;
         }
 
         if (!msix_is_masked(pdev, vector)) {
-            kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
+            ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
                                                s->msi_vectors[vector].virq);
-            /* TODO handle error */
+            if (ret < 0) {
+                error_setg(errp, "Failed to configure irqfd notifier");
+                return false;
+            }
         }
     } else {
         /* it will be delayed until msix is enabled, in write_config */
         IVSHMEM_DPRINTF("with irqfd, delayed until msix enabled\n");
     }
+    return true;
 }
 
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
-- 
2.50.1 (Apple Git-155)


