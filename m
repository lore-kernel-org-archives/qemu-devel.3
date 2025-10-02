Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ECCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuN-000709-3g; Thu, 02 Oct 2025 04:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuJ-0006zV-HS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eu3-0000w0-LH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso4470185e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394573; x=1759999373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2a+b3m6nNjsik0uExia3oDVD3UfHkSBuHgsktxpBbI=;
 b=yul8ztD9g4EVsDIxx8cq9y4JfyJyYwl936Xz/WcYutRftBYRkei9NAM8vPbreg+029
 /roZpZKZe5MrX7VLGVEUY8+Sl3ADAilR5FDjv/0Eic0wuuKkPhqX0QpvqOnUD90NvwSq
 wtn7V44R13lF9mYdga1H7syghtNiukOKIOFwlTf4MnrWNRSgnUCGWokYL0t9Fr26Dykf
 Vz1ie2VvvHM96ckK7A8NLVki92VfRxqYwcP+Sr/OcPYNImwm5HQp/WVA/+EBXdPw2aV0
 XzaIwxTV1RthCcX/zqR4LX3T6xhhEPC3f6Qliy4nhbZtyi4woV9Kk0d8QJvaJnLcdtQm
 aUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394573; x=1759999373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2a+b3m6nNjsik0uExia3oDVD3UfHkSBuHgsktxpBbI=;
 b=WNZMaPCb+6ZzT9ZyeJN8iIzRF3vyI4LIBdn9hcZ+BEDWvXdjyn0d6N5MNC3Rgmc3B1
 Le5kXrvSdzdBRU57YzE7bM8SaBrZ7k6yaABeIVOREXTXGbPFVngyGOX/WyLxPoyAZmNe
 XLrXbMKvweFeN7+mV452ElTmCXSUngDCrE9Jeq16326RsVJw8k7par3iURcWNgXfRC1P
 VbJkyAE32v4IcVeLaZ0NDbDjCGfp1VEBLVgBaMOp46/8a0V7A4e8gcKILHJug63867ek
 vunmFHlXKKCOmyt9FaC842aeIUILTQe3HhyGUkl5Ek3QjAu7CQEshTFTKIcJ7SlAVKrL
 Utbw==
X-Gm-Message-State: AOJu0Yw+y7UTBFG+ymhcSODz9h9TLV4rYwQB+Pcn+9KEm+vr5O0mRO7b
 k8VOhQ+ZVOgdbi0YY4iqJcAbBzY9qUdq3nKpLEtvXHc7lZIdszIYfmv+ncRCyRbczdltTt8bS2Q
 rfA2TnMFoGA==
X-Gm-Gg: ASbGncsoobxkI3eaD0A3j8x3ei3gPwSGaWuxOIqUz6kmA/yG/xP7+8Q0tv58bRM6iSx
 +CIMFGzsChAekalfs1w0DwSTVwBvmEWNvOyJdvSSJ04QcTgrYJlw9GvC960PBQJGXul139J1yi4
 4RbAy+wQnTUTrBTf+wHxrS+/zhLQt/7DELAJubu+b9fRPG3AmYEF7CBTB+uUMKcTEn90k3KTUrg
 IY5aOi5Y1K7IX7puuePyvFlCsjxtADChikHfKDLzNx55P8Oz11QrMbfShXknshBztpU4DGYrDJH
 sIUVOk49N5YzHmxJzP0Pss5hfI4JDrSfNL2XrOwY4KV0eBWVrtmKC081477zvDFoukvbimel9Xr
 2yCLg8qS7CEoDtrJMjXzE/GGHo8i8pfpLeyi3i8BwgEFChtfPxbM/nZa8vYPBhSx8v4uJpHvYAo
 J4b2bSk0XIy4WP3bLzjUJNvLrnXxT8XQ==
X-Google-Smtp-Source: AGHT+IESawsv8TF9fv7ok0vuTUFPZED2UOH0cc0J9xvSMsVxP3h1RuI1snQ8dRbG23dqFBECTN2WSg==
X-Received: by 2002:a05:6000:288a:b0:3fb:ddb3:f121 with SMTP id
 ffacd0b85a97d-425578191afmr4750845f8f.45.1759394573033; 
 Thu, 02 Oct 2025 01:42:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4ccesm2549112f8f.59.2025.10.02.01.42.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 10/17] target/i386/kvm: Replace legacy
 cpu_physical_memory_rw() call
Date: Thu,  2 Oct 2025 10:41:55 +0200
Message-ID: <20251002084203.63899-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


