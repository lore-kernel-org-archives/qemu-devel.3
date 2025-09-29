Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E611ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ij8-0006zE-Tx; Mon, 29 Sep 2025 14:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhE-0005LZ-Lu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ih5-0003S7-HO
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so40586305e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170826; x=1759775626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=QeuTcix3phlBt223FGcTm1mzogI7NuT0Km4O4m+f+TYsZKJYAUMocM9NV+mr6xkr/q
 jloLgPvWiId0vgQF51URBXK9YSD5EDGKCf07aaQJRu2m1OtNT4TCcTulnSLrVd7SlM5Y
 N2MUawKqNiPRbc3C/2fBnGqZtImrysYc5jk/u3kIyg4UTADyPR8iEE2VRBBlCNpJGgxm
 Fb8KockpPYpwVjnDh8lQex1JMcCY4/FhCbc5WFK/VCHt+jdZ9k1LId3/7sv1Q5e0p50A
 nuo811PD2kYPEafPXEzwEr3LhXZ/nycylEBqrmMY5mdcQQggL/5N7LGtrMvMEIJJkeP5
 UIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170826; x=1759775626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onCfEhinWarPReSMP2g+nvBYz1NYywUR3fuXcFIYVYM=;
 b=MLDWz9lr9hR7/mMUt1k0/LfY84pB5FWfM/8UkxpmV9HSDYaDbjF2b6QNnKz3qFxfHT
 WPlXjUzoLknjuHqwVfiSDMj/vocM2Y1ui6ckl82kMyc+gemLJTrQs32L4wSKiZ75EKaq
 Edxh0q5NI62LaoZ4b6STIzFz9AMIfDGZsK/4y/gGAiRayiN7ytgzbh1zvIwDus0f8bkl
 tz7/ok9M2pHrqhh4+SPi6teEjto3yZw4CWWZWDliqoFjI2VkIOoD0oOlK6JQ0wGl2zmf
 DYDYQTlEk8F+nAYepzxms3s7tzKk8w7vsJKqAWChpRN5V1wxHgkEwg8tfah9CP0zF16i
 otDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6B95JmPDcdK7yehSebzl0ZQb3Pz+lZzbCmf4mB7g6Ad3QzzDpFsvaNOM5k+fVQFe2LjE/yjN7kEFa@nongnu.org
X-Gm-Message-State: AOJu0Yz1vfezMl8waejYm4GiefZhD9nxS1Ust20BH8QyF5KzzLtTAN6Q
 uQT8KfzAlij4AAbQLvmLLzz+kKwfBzU9P+qaNZMCm7ViRxXgQdWLzS/bh1Meuex1IXc=
X-Gm-Gg: ASbGnct59GCEcVMbK5/2p7Quh3XhCzIcgoKEFS/fVqgdkYCu2gW5c6+868YV/YyleWT
 DHstSyxPOP5us0XML8KgDxNqQIm0obMHXEczd9AM5Ratbphag/xV4gDK1ZCoeicGLURVICo1a9A
 Zg9dEoh2SDmWPMNZiAhf+TOKcYhjsLB939FMSa5RBh05QlPpBcb2dR+r1O/2r74jcetn6dVZm+N
 2r+j7GbcwmXlReZJ8VfvPHa2kEcNG3HakCxD3sblLknQqIDDHrldfw7dhXVnjG9jU7c02f8rIWE
 ajYfSNRL/Sl9BzLjm1fsWUdvb+jA288C6NFcqWADGuWMOsS4Voa5jSkPfR8xKUfSAoXYEinu5Uz
 zoC7yw/PioKj0ou3hSin2Rscc36uyFbllY7nsv3TrCtaoyXnfeglmsQggKQYbaIA9i2YvhaPP
X-Google-Smtp-Source: AGHT+IGY3Rr3VyTE3S7oem5ZxfcOaYJ6i/vEMLPbvgnpiGprZwacrZ9bUpREdcpvLgXehTAMtkJc6Q==
X-Received: by 2002:a05:600c:348f:b0:46e:447d:858e with SMTP id
 5b1f17b1804b1-46e447d8828mr94281545e9.28.1759170826202; 
 Mon, 29 Sep 2025 11:33:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab48c28sm234491505e9.18.2025.09.29.11.33.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 09/15] target/i386/kvm: Replace legacy
 cpu_physical_memory_rw() call
Date: Mon, 29 Sep 2025 20:32:48 +0200
Message-ID: <20250929183254.85478-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


