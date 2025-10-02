Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2662CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMa-0005qi-8N; Thu, 02 Oct 2025 05:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMS-0005pO-8a
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLw-0002Sm-LM
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so7614935e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396309; x=1760001109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0OOi5PWQwc+RAyjJdTkSiYcNQtHuqBBPJ63KqRE1kw=;
 b=vnqYG9uKAYY9I3shL8DBmgrG+70SLWWj4rz53t64CQGH8avt0TlAbYW13+d6C3iAEy
 CAWKcu+i7fNbfnX4HXrcQbO2G0pjYtJ2fp2zhP9az+TayonZcv8BzYgdLhx9xO1/XtVT
 6jFFjSvVPdWX3NeMGfqcmuPaxRwNo2xeXF26daRLGf4QjokRZKugdzUhJggIZYSSR5aG
 72/HQ1/IYYnwVqDWcbad/Tk31lSveSQOsbj0m4XpzEj3tBUsPsu5yfOo5s5GUP9xWWg9
 yTkpXhMOvDtZEzv07unPZaJRrk4REDRHXe9WdehK99OHUMku5Klet/rsPiwwBchRZ1BQ
 sh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396309; x=1760001109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0OOi5PWQwc+RAyjJdTkSiYcNQtHuqBBPJ63KqRE1kw=;
 b=rUG+9ud4n3IGuC62JLQ4dpmtKUMwMWIzrnksJMyAaQeGzsZ3/Net5rgx0Mzab8bhF2
 LZZ35IO0voMEli0ukB3x5oR1SsER7hqI9j8GNMJEqNFNs/RMqhAh/tqZquAP0zhIPv+i
 jjtmLFa5d+o97QISH6o8zhXJqkpAFlsQ59VmBanaJlHYUL/0Im6SSrBLruauvrm4mP+J
 HyuIBo2lZjOgY0ZlPMBLQ9vxaxmVuTLwyN8nwG4zzixGT8ilM3RSlid+m+0k7GLiGG6H
 vPwIk5IdVyhHYqM9J13KwZUpdFfnuNCwdBdnM0hOdJdiLIRdoS89kYTonY9ltcNPqKK/
 01Gw==
X-Gm-Message-State: AOJu0YxBzkxivlQfEGq0RenVX2813q48+MvWSdacSkzu+nHJsuIfsU2Y
 KyqeWB9dzYbIZRd9OhTgif562E93S0mNvTQSdsSARytgKZiMhDGAdzJSxYlRn+aDAacpxIFQd0q
 QBBTG/UH12Q==
X-Gm-Gg: ASbGncu6yIV6tdRWazuJI7CSdJHq5m7II+OKvnlSG6ZuExz1Q1aCDiJ4nZBFxfeAY4O
 RmUcf/gV7US42sfwqlCHw6gTrYPC2BEgrF0IxEiYvxUcx+vouSwFwmRQ2FInNOmk3aoUC2urGPf
 XMWETbFEwnTmnzMSut03AIek5pt8nBrTimPI8Hest6UJ1NzeH8+xUGRTPJI5JrdDq1gqA5C3XNR
 cAkbniU/9wI7nY147tcEFII8uEBQ8bSZ9jQlpvOzGc/V674dWCt0laUcQ/UfFN5jLDImdDzGAyA
 sATbUn+z8riJxRljp6DLs7N3DRWzCik4QPdkoSQmjh0xB+XTIyn2XmDEROPwTS3hU37LBuWKJe5
 SF/8P4svifh5yFrfkcVoaIeH2i8eUz1zxPVzsTalkMCMoVyOXI2XWYJIVpU8raPEWMaTKibapUj
 A3NzxXfdlyEmhPOR4o+t3ZllT7jgnkOg==
X-Google-Smtp-Source: AGHT+IHcvJj/gv2RYh5NmhDINjyudNsnJes9cDSftxEKKhBI4UmmAeoUYxna2qXg3W0vxZLHmRpHPg==
X-Received: by 2002:a05:6000:288a:b0:3cd:ef83:a9a1 with SMTP id
 ffacd0b85a97d-425577f1c50mr4875026f8f.20.1759396308960; 
 Thu, 02 Oct 2025 02:11:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm2723263f8f.41.2025.10.02.02.11.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu,  2 Oct 2025 11:11:26 +0200
Message-ID: <20251002091132.65703-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write() respectively.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/diag.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index c2fedc55213..737c3bbc5be 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -17,6 +17,7 @@
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
+#include "system/memory.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
@@ -82,11 +83,14 @@ static bool diag_iplb_read(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
         }
         s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
     } else {
-        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+        AddressSpace *as = CPU(cpu)->as;
+
+        address_space_read(as, addr, attrs, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             return false;
         }
-        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        address_space_read(as, addr, attrs, iplb, be32_to_cpu(iplb->len));
     }
     return true;
 }
@@ -98,7 +102,10 @@ static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr
     if (s390_is_pv()) {
         s390_cpu_pv_mem_write(cpu, 0, iplb, iplb_len);
     } else {
-        cpu_physical_memory_write(addr, iplb, iplb_len);
+        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+        AddressSpace *as = CPU(cpu)->as;
+
+        address_space_write(as, addr, attrs, iplb, iplb_len);
     }
 }
 
-- 
2.51.0


