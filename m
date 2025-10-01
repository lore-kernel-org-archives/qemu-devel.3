Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414V-0003Xh-Ho; Wed, 01 Oct 2025 13:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414T-0003WS-6E
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413m-0001Cg-3o
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so73628f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341367; x=1759946167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2zCZOMVxUlH3hD+UCvTWPhCwey1XYt9IvIHTWoVGcc=;
 b=flW7DW90M3AR5BsqiKpqTB1ReulObq4ueWJI+WJnEt+d/QQjPNYgSlUDehxsv6EZRk
 xL1mWOBxMyFx6wq4BXPaMH137f8Wwhv1YKDn/a9zhTmRH7OoAux020w3WBmWoC33ZZBq
 9A1SlP+DW5+WYXtABGHzBDwYoLn5M7r3V8Rwb1Vg+oMMBFD5p50Or1WC4q77J/in2g7K
 /rBoN9FWyxdWWx8K5sEWnOvlg0YTDmZ73qDH55FMzGwf3oCwXtQv1rRsbKUFk9hUivp6
 wSJcHEdyUAmmK49j/tU33zFmSo80Xy6k4XU6NIaLHvWrflop0VMAHVhsC8aL+EKeCFkm
 N2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341367; x=1759946167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2zCZOMVxUlH3hD+UCvTWPhCwey1XYt9IvIHTWoVGcc=;
 b=q0olIo5147snSeTzCHeK1RjbkA98tzfE5TfjQoz6js2t2Y550DaPtkND7RCT5soeMM
 ajSYriIJfV1lJQ7mOM2f02KxtjKJbuDlKSdUzbVk5LiirXNQIRzrVa8jH85qyfV/UkiE
 4MJbYOA9pyfjTJ90ILUSPR9UbvVWGX6270Y92zcVXLznQEWA2gLdflViRK8/xGGdXUHx
 UFpCmXGHkzVNgu0sdEPiivuWj3efKMemsl66MdP4S5apCK1VWvt+1bJ33WFXPqKNQbe7
 HNjSeqR5NYoal3uDv/h3GVRaO3CB20en/42BdRLKSG3HWQz8v2GCHrGMLNmWodB/iAOU
 xxfg==
X-Gm-Message-State: AOJu0Ywex6POCqgt3hZxxsDVOp5mSrbscDaK2xfC9PEri1zI7kEfS9E+
 2+K6VyDjDQiDQmeGPIbkQzl1Ryw3VirF/nuuEM592UOE6WMFQZth4leARuLMDA8inmoMt4XSVNr
 cHzvS+QMjZQ==
X-Gm-Gg: ASbGncuKIMrrDeflVzHjwjXimxoz5/dZKBPeqzkyDfLHCHTzMPxcplUU+0gm7n28ZeV
 pCNP7itUl+SNMECNZ5kM6dOgxO7xvqKhJR94bV0qqtCJBEj3JNSp7l4o6/7SOqx4JhAv1P53dqQ
 RUN1MN8CsyUjPY70VZnjfFjjkwm/waEweCa9lEHzURnBKwLiRtlvVHyBqfba+/gUrIJtsXXfcuw
 wBknFatnFoqVhnBCGr6RsGPnz/uOq0/PshU/Pwhl0rSAd/4PqeI6rpZuUgmHUn798ssvWA+0mwL
 6Maip+VZOpnbblTsPa57sfraPj4piJWyXaSV+RdHQLCj0Rsry4KENDDBAIXHiHFe9b+a0q9WaYL
 k/sO6938SSkBu4bdACDQGBr6nMiLg8hPa4nv+HAHCip7WnDukSeHPwGTWKpEIAYdxWs6yQ49/4a
 dGXH5ZLWvFTjrKw5EO/iCVZp403w==
X-Google-Smtp-Source: AGHT+IEZ4RdBmQpCq+iFSrKM7GSoqCz/Rs3gJ8kFxOIRv4Jyqw9xcJXS42HqR9BMfsO0xILWjGScAw==
X-Received: by 2002:a05:6000:1869:b0:40f:288e:996f with SMTP id
 ffacd0b85a97d-4255781ea71mr4021012f8f.63.1759341366824; 
 Wed, 01 Oct 2025 10:56:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm46954075e9.11.2025.10.01.10.56.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 14/18] system/physmem: Un-inline
 cpu_physical_memory_dirty_bits_cleared()
Date: Wed,  1 Oct 2025 19:54:43 +0200
Message-ID: <20251001175448.18933-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 10 +---------
 system/physmem.c          |  7 +++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 49e9a9c66d8..54b5f5ec167 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,8 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "system/tcg.h"
-#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
 #include "system/memory.h"
@@ -164,14 +162,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
                                                 ram_addr_t pages);
 
-static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
-                                                          ram_addr_t length)
-{
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
 
-}
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
diff --git a/system/physmem.c b/system/physmem.c
index e01b27ac252..0daadc185de 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -901,6 +901,13 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     }
 }
 
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+}
+
 static bool physical_memory_get_dirty(ram_addr_t start, ram_addr_t length,
                                       unsigned client)
 {
-- 
2.51.0


