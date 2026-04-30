Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5ABFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLA-0007tv-7y; Thu, 30 Apr 2026 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL8-0007rY-Iq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL7-00034y-2y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tWB5F0bYTaQowlCBeZFX4HdZMIoRt4fdHlhmAVL0Yw=;
 b=AK8owSDtGC4g9DuBE/I8VRe3c9NK4NeE+j//ZUuyJ2xzNYijTpdV/tL8KzCVMctTPhB4nN
 VvKoT2u4RI5W9A2YfAz4uTxpWUK83pV1B1CZ15SXJ7sERAyUzFzBilPc0fb2u5tXoh6RsB
 AeJLtwXojlKM7yUk39aHv1F2BadCzVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-FpNo07XaNcCWia-G0viNLQ-1; Thu, 30 Apr 2026 05:05:42 -0400
X-MC-Unique: FpNo07XaNcCWia-G0viNLQ-1
X-Mimecast-MFC-AGG-ID: FpNo07XaNcCWia-G0viNLQ_1777539941
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488c2cc0cbaso6460175e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539941; x=1778144741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8tWB5F0bYTaQowlCBeZFX4HdZMIoRt4fdHlhmAVL0Yw=;
 b=INyA56/hJ5+DszHIaBPcqlM0FiUhMM5H9u/Metyb74NGeKI9htH6PVzXNXhdNvX9Ub
 8+Idj2WjM3bFvR6FeiP21LgpHAgk06+IfU4XRtcne9TyUzFehRrUSZyL0K7LS8GiN0tn
 CPDaFC4Q1CTKli5XlLcgklDyORB4bFaXZt/ncNxWq0CXMrFphw9bmvZwClJYfk75q1l9
 n9ZEn6edr3IJdvierKakpCFyy41krCRuT78L1HEl6bbnMGm3z0bCv8Zu6u4CPUo17HWE
 O7+uS6o+C6DCYT5dzRL9sA9AJr3zU+R2VCt5iY67ntG7ATC7g0eYPnozOfecKT/gkVo+
 aS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539941; x=1778144741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8tWB5F0bYTaQowlCBeZFX4HdZMIoRt4fdHlhmAVL0Yw=;
 b=qgShhiOG+kKNlKXGwXNqCcK1xYWspEB0SD29KvtcthIrjMYMSzKWh3APe+ZBZ8ofF5
 WPeSy3I631dM/wdOqNOi7NKlQu1VIUuJXqDwyyDmZBYef9RWqHyuuynt6YbcFwfbC7/U
 ip6iBs2EHdx+7Is8FoijxaJxZ4lhnSF1OBoOJZkeefoJAwy/Lawbj/3qsZtUYer0GH75
 kBizAA4hkHZCuTGo85EENfnRbhgy0WbRSqwIp12NiVhbU5SaiV8UWp8/CNsnYw0MpZuH
 LfmFedBVivIQjKDPE3Ccas1rTv2H0fmweWl5C/sEsLrBBjrlaFF1WvKmi8Tz9u2+qb/q
 3mpg==
X-Gm-Message-State: AOJu0YxWmhNlJz2+CLW7JtDTo+K08mlvPXCqdUK3jI4I/AlfD4GroZD6
 fo0kFe8xPPAfP0aWkGEPtO4klYu7BUR7FwJV1ZTSQrV5DCA87nHSchE+d6kG/xotwy5RDCwVR5c
 foc0ODAW9aGCEL1112ZvwA81BafFwfyLVE575OQHh3fOzDD4Hfkq+Zf77zpKUXtPwYdiWwwztO4
 YJFRlBtvWpCg4q+JtJpcp2EYqFXLmGY69HMPrvN+wY
X-Gm-Gg: AeBDieuXiJQqOyVzujBIMUsAvRgsqVDljgtS1Iuc4UklHAbwXBmpJAFW5YyxTGG0JYO
 RVP17OVSDwolBJedaC3w2FgMSY5Dh4iCFj+9FE4pSkEE8tvhw4hb1+XpPTOzcO9CHJF2xp873hw
 DHXvYgQKdp5xEm00A++ic1xWb5Dzh4we38eX6j9jlysDDS7HURUKVQBwn/tDq36TEPPYfwCPKwI
 c4rYYTbjzoyjTIHIkRBnjhG7ggRikwX/LqluIQS+c0y9sqZHvN6WysitNEu8aRSMAAcNl88e9MT
 TKyrWEX8LuisfC7n8s+0dmUrIWcZU0oa0Hx3qpib1POxfYJjJaQpkzC4vjefqryZ4iLqgbaeMvl
 wJRr2HEzd+ZNRMXd0XRjEhRwQW1MD/x7Ssoms838d5kTPTTg6NqY34HdBUWlHS5WQSzJ03Gi4B+
 QmE87L0X5RInMDBeqXa0Bu0nPi6x41cyL4KLM=
X-Received: by 2002:a05:600c:8b0d:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48a8451d095mr33352475e9.13.1777539940575; 
 Thu, 30 Apr 2026 02:05:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48a8451d095mr33351615e9.13.1777539939824; 
 Thu, 30 Apr 2026 02:05:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca5fe6sm12051696f8f.32.2026.04.30.02.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/13] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
Date: Thu, 30 Apr 2026 11:05:23 +0200
Message-ID: <20260430090534.841894-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/Kconfig  | 8 --------
 hw/riscv/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index f4d49248c08..99bdf09219a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -135,14 +135,6 @@ config RISCV_MIPS_CPC
 config RISCV_MIPS_CPS
     bool
 
-config MIPS_BOSTON_AIA
-    bool
-    default y
-    depends on RISCV64
-    select RISCV_MIPS_CMGCR
-    select RISCV_MIPS_CPC
-    select RISCV_MIPS_CPS
-
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f878..2518b04175f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -132,5 +132,9 @@ config XIANGSHAN_KUNMINGHU
 config MIPS_BOSTON_AIA
     bool
     default y
+    depends on RISCV64
     select PCI_EXPRESS
     select PCI_EXPRESS_XILINX
+    select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
-- 
2.54.0


