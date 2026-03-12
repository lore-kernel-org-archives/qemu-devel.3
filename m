Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361A6105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drO-00041M-Na; Thu, 12 Mar 2026 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr2-0003oQ-Cs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr0-0000VC-Fh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6/l3NwCL/vberP/dp8k2/b/iAR3SKecP1EdgBzid1Y=;
 b=VWVTO6i9l6yh148bHwEerDjvJoZwUTpT8b/aqjuVniWBbcQyYiQXPNE65A8h3+6K4PdmTd
 HZYI/IT8xFHL6ZePxlbqlsEGZ2WiCXgVKaaaFkvMDoKCxh4wRgZrs2R6SUS5FChtWJ75wm
 7PlzxwKc54IWfpFcci7gmOgCZP6bVU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-N0RYknUiMXG5AdF3BtEoGQ-1; Thu, 12 Mar 2026 07:05:19 -0400
X-MC-Unique: N0RYknUiMXG5AdF3BtEoGQ-1
X-Mimecast-MFC-AGG-ID: N0RYknUiMXG5AdF3BtEoGQ_1773313518
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so8267135e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313518; x=1773918318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6/l3NwCL/vberP/dp8k2/b/iAR3SKecP1EdgBzid1Y=;
 b=E3RkbIDzYW2i2TWQ6WmIAcXwip4rKb5OGiSpxg/Umk686NYPuKm/R/TnlXFlgQWKPq
 7HtMSkEJc4eTbT6qUXlPE846CH5OPYydOAB0XPkONgPM8qXF7uQfXcqYAnT6m2rgdum4
 wg/H4LzWwPm44a99t9x7PKS/ExW9GRQezJQQk8P1ZWfNrt+01k60rZiz0f0qS3nmBMaR
 WoZpCF4NCnHct7jj+Qq8OtIbByC7jGEycs+fNjgCoAADTUUiRpEmHbq3LulFf8sePpZk
 iSN22cZ3u/MRRju5KA70NzmpXSGFObEQVvjG11yt22Eo6AsDZdxpRP3Lq9eLdCCe5AIp
 Gpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313518; x=1773918318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w6/l3NwCL/vberP/dp8k2/b/iAR3SKecP1EdgBzid1Y=;
 b=B77bTSRY8nmExLtnyAVqq0CI9DGGvdFz54wVpxxFj42hQNC2PvQdyaJorWPOkdLoLo
 cey68/ywTSqLzk58ZZcIO5QsELDUJGRLRZLXT8/SFiuRMf4eTOSH4islOus9DHDrw+s4
 1xIWDiffAfkzM5FdLj4ssE3r7Vf84Xk89k0lhJMUg3IJtQMdUEY4UklgJaZwyg+3V5gw
 tKAls2qumoMF4GUvHwELuDA1uujzxvHaM7iSLqCU2PfpAfMBmeaSP9zPc3UEaTftqJxM
 dvCYcnENcGGajd58eE52pREeOqWRFizz1hjKIZonK/2AGz2iC3kuGzQgDKDmXlGdS+qO
 IacA==
X-Gm-Message-State: AOJu0YwxzBxFcESrGdBl+2mLARt3+I4OJkvLaHCjQfrsQiK4zXL4UUnl
 0P9N4Z/vbdakoQfrjqB/czJhMqYS31eBLnzkxe8VxmKYaN7AAvrz7BDmFhnk8HqVfq2/Xa/hate
 keZx6JFpXfjWgkB4ZQ9uj2VB/T6hKRH/V79osqit2tMAi7KIIh8bkS74L6nVktg2l/t8dDF4dpa
 e2yVlPe9O2zNdT8gJv3ipWCPdzZRQIDcPOv4eAY8t9
X-Gm-Gg: ATEYQzwER0UAQzC32ql4k6wun7urxGnWF0M8dMWAeujdGzQMmqJEDT00lCwAsVrWOq6
 APUghHdZmJaxayGdLA1s976chH+DuK0xWBuECBQQyz0jIesSuf1vK1MyXcCIrWEDErzfwtsqfGZ
 kga5IbAx/BLbWQsPQHpihsPaUSSnTJs7dFo+pAqfdeh37tWTd7RLXH3Islg/72tx8EdYshBEbZA
 rYSAe/XS/5nurUy7JSipaCHOD0C6KLcqsChJanqh/VkEo857D5lSvK8i0mxrrur7iyvme3JPGFv
 nMFi2StGYLLujddJqMGx+5l1WlKwg1k0uqeZ2G/4/YAYxtfX1xrIabM/OH4HwIK+JkQufu5H3sr
 JgeTEHGx1+4VEXzactYnJ7sPERkTBfo7TjB4hpq7F67bMZYb+62sd8YeSQWCaQ/8ayS/kbxkvsP
 9Lgm+T/cobmKJnjgMOM16eBBT7/9E=
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-4854b11694dmr86815865e9.25.1773313517568; 
 Thu, 12 Mar 2026 04:05:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-4854b11694dmr86814985e9.25.1773313516826; 
 Thu, 12 Mar 2026 04:05:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm211285225e9.1.2026.03.12.04.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 09/14] docs: remove 64-bit only mentions for accelerators
Date: Thu, 12 Mar 2026 12:04:41 +0100
Message-ID: <20260312110451.685161-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

QEMU itself no longer supports 32-bit systems.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260311102626.46546-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst | 4 ++--
 docs/system/introduction.rst   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index e95784cdb55..ae138ff0e02 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -43,7 +43,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - hvf (64 bit only), kvm (64 bit only), tcg, xen
+     - hvf, kvm, tcg, xen
    * - PPC
      - kvm, tcg
    * - RISC-V
@@ -53,7 +53,7 @@ Those hosts are officially supported, with various accelerators:
    * - SPARC
      - tcg
    * - x86
-     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
+     - hvf, mshv, kvm, nvmm, tcg, whpx, xen
 
 Other host architectures are not supported. It is possible to build QEMU system
 emulation on an unsupported host architecture using the configure
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 9c57523b6c2..2dfa371e0f9 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -19,7 +19,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - Host Architectures
   * - KVM
     - Linux
-    - Arm (64 bit only), MIPS, PPC, RISC-V, s390x, x86
+    - Arm, MIPS, PPC, RISC-V, s390x, x86
   * - Xen
     - Linux (as dom0)
     - Arm, x86
@@ -28,7 +28,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - x86
   * - Hypervisor Framework (hvf)
     - MacOS
-    - x86 (64 bit only), Arm (64 bit only)
+    - x86, Arm
   * - Windows Hypervisor Platform (whpx)
     - Windows
     - x86
-- 
2.53.0


