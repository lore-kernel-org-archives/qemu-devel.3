Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeE-0000dL-AK; Tue, 30 Sep 2025 04:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdw-0000NY-Rl
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vd9-000149-0a
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so3014681f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220549; x=1759825349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=i4tQgF7hYrGuZ60RQAURVSNyvx0BrFL2D6boTJfPkWQ1J27F2P0dDbb0amjvHG92l6
 cuqr3thBOuZsoUqT7COVg0+FwO/dYy+athglfxg8DLMdcA/RsO59DndYeTvTeeW5Xs5t
 3P7KT+jpvzgzcjJo5jLfNwoE0WJvn+1K2waINscKD9wFIiTkJQIJLU3jjylFgXTOgxwu
 zPbRXFrDrdYGhcWdFCVVVuMemgkg2wQ5ntYmDeRfOnXhwCErV8SaFF+G0g+Tn1dym8q+
 enjR4aLVaqq/wjlzRDSUrcF9tlnhvIafjN8AnOuOT//58bUbQCsO7jF/zBUzBip02JsG
 X3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220549; x=1759825349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=Z9o1MX0caoSpv2sSfHBcWfm1dmATeU07nsX4jt+VMO3k32KeEAg7OUkzUZ7qcHdUSN
 aG2TKLmuTphkSZxD43u/VF8/J07OmzDp9ECubeacBrb9j5TK6L46H0ZcNY7SutV9Jhkb
 SGJ2uo05QvC+oAAvKLTxGnpCsEQt6IC7YLSgyymi8vMCa0n9IamCiQPuk9QZRoq2o20o
 nkzRTmmWaG2L3hPWZo6NKlgzovup41z3Tq2J0W+CN21xgEWX/qC5U+EBrV5Vhq1pqGqf
 qZGXhbJNqcBF8vQOa5QgcmveB75dcxtfQXLzvBewx3Wgp5kV5kMIrdGp8/og3vOmpCxe
 S+JQ==
X-Gm-Message-State: AOJu0Yx8YS81yeGZJflNTFme9TitnX2dCYht2jgnLScRaPI044c2TxHR
 sA0W9plFfQfjM8S9DPfTyBtNw1F/LdvBrf+N6WOoq3kAuP7l7K7CLqK+Wx+ZGw/zgZXKgAs0ZZE
 fZ/uKiyQbBA==
X-Gm-Gg: ASbGncsqH+GyGg496RoFxeeb8S+4gxjnNozJW0IZFsLQiWUjJ4djDOEJCoLgVEuoXpi
 dxoxqLh/07MGfbVC0DvL8XtHQzIywgTJZ+DBwhXNauz8BOunVYOM1KFrNkyCYUJRBUOnB60t/iE
 omxlsjAS5oEnbUIHcF4WHoPgCwg6Ow+PMJfuiaX7NInCWcCxoDvcLQDjN09BdvGLfkz+Ze+4zrM
 anONEb3at1ST5OqRavJtoekjobU2nFQhVruv4c4R1MYcDCSPtV5fkAoMKV9Wd7DWYMjuaZs/y3T
 UA5YOr+LZZ1wGdhPXK+hdN8wWK19gO/cf6MB6q90Y0YsuqvRM4ulTWFtI40Pd/uZCRxhgu9uLj2
 P7FgqryuyfC56UEGnXufLpNyMoFi6sefRi/TkNhzZaIOYb9mDdcMhKKlpB+m1Bd+StPbUpPhCpK
 /00m0YFMVnuP0JJedhok1rMpiaiM+tBYY=
X-Google-Smtp-Source: AGHT+IGEB7zt4QY7wj3rTZFjv9pmOMXqLorCZDEnNJaXiQGRhxTkEhGFSRSSrKDdM5xt6JNSxZxslA==
X-Received: by 2002:a05:6000:18a7:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-40e437371acmr19690967f8f.23.1759220549024; 
 Tue, 30 Sep 2025 01:22:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e572683ccsm47008715e9.22.2025.09.30.01.22.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 11/18] target/i386/kvm: Replace legacy
 cpu_physical_memory_rw() call
Date: Tue, 30 Sep 2025 10:21:18 +0200
Message-ID: <20250930082126.28618-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/xen-emu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 284c5ef6f68..52de0198343 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -21,6 +21,7 @@
 #include "system/address-spaces.h"
 #include "xen-emu.h"
 #include "trace.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 
 #include "hw/pci/msi.h"
@@ -75,6 +76,7 @@ static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
 static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
                       bool is_write)
 {
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
     uint8_t *buf = (uint8_t *)_buf;
     uint64_t gpa;
     size_t len;
@@ -87,7 +89,7 @@ static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
             len = sz;
         }
 
-        cpu_physical_memory_rw(gpa, buf, len, is_write);
+        address_space_rw(as, gpa, MEMTXATTRS_UNSPECIFIED, buf, len, is_write);
 
         buf += len;
         sz -= len;
-- 
2.51.0


