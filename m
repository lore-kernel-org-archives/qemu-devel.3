Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C89CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTI-00062f-D1; Sat, 04 Oct 2025 03:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTG-0005xI-Mr
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTE-00051G-He
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so2597987f8f.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562057; x=1760166857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kLstcsUAWcmwVm902fKNilMlqxrP2+a1IypTs2HJsYo=;
 b=cswVf31HpyjMvEAvPfHIthoQvElY3ECX7ACl+I0PMEpcmjmUbkw6vRr1MNsxygTFyP
 zObNn6F/tkAzPfJSPwa7hwit2uitwMsTD2dASuBueLi6sxJvNFRst/646bFmZ4msb86b
 DSjSku7b481hTOI696ZamPDRpeS6ey0s3kwQpB3qqCOoQipp0j7yPIhulJ9SkeTaq3vU
 wdlM71Ti4eFldyKycBjjaRgnEfFz/ABQNky6OmLAr8U7tcPlZ1SuPVKmy7C/l/zEv4ok
 VZbaTl9bXT47I2FVaL8fhlIa7oLKmUaNFWvN19NVM2neFoQacyD0ws42QoIXGL7MH7PX
 jDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562057; x=1760166857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLstcsUAWcmwVm902fKNilMlqxrP2+a1IypTs2HJsYo=;
 b=i2fU2lF5S3SZEKDh/YjXJVRB8QKSCk2cM8NsXOgrpnlKM5z3IMbLKrnCjd3Apb2mfW
 H8frBcbxaIAriNktSEQy6S56VpKxjgUAEsplrcNAMZnY25nAtI5mA4vhF0begvTJH2oI
 Gy/KDl/Uf1YCdDonxeUXUCjWjduK61YRrexnU39e6Ba2wtHkI8Tl7N9Y2qGKre9jAr79
 sRqJYEmCPP23s5xYp7TdBgZ7nrvPQ8WmInVzPSnb3pOf6+HwPrcMAh19pQZ3O+2kY0e3
 XJwWGfvDvFUmoQ7qtM0dpjQj1TeQ62uLp711cTWcY8ZwxtARG2AB2qPS5INIHIXfg9ft
 tsQw==
X-Gm-Message-State: AOJu0YwtDOXgXadz2WiVXYaJkNO6du14YUfOeGSAThVbK/J0UKZVXxgK
 nXTFKuUOkZO/l9mRJ2Z+dlmLgL4Lwm5EYnOSHujG2fj/D4O8vIlzkkBEcgIN/AVBaNJsdx5b+mn
 zKHYLK1aGEQ==
X-Gm-Gg: ASbGnctUrKx++Y4QNvXQGL1LE0SfORVDiS6pOCVa13dscblppKFGpRIqwPESvFmE8nl
 X091Anx5eMFGSANDaA8gdF81UHNKzH3JevvZEYYoqx7cLCRJV4fQ3Z8LGrsUTzgrrpYpxTaU0vs
 Q7KP76zlN0k6Mu4v/oJNk/uVS1SXalaD/x6J2BMJfXhSkJYLtmXoyDtAo3GKv6jYP8BmM7HhbHk
 nw7lFEMbdmkJ5XFYg5N62UMAkvlzsiuGaZPVTYlAym1I1kzZ6HtYe5ooubA29YOGasqahj6It+B
 2lg1GDfGxCEURxXwfzbisxG0dmXtCgTYc2dG55jaJvlNwzdn6eysH5aJGLuRO4Puk9C1vuNPpDF
 0YpHBqt4bzcxKI5sfwJxJoBQWVn4M0bUKoWPsZjBiv6sy74qvv59EQNcINfiCfpEfsVkmFoUgnu
 4yXQ4UvGXuZjcGpJey5iPqignhbSJS3ouugdo=
X-Google-Smtp-Source: AGHT+IGBuYbUr2sD8DDeZ0CjYAlvdD5IEFckncdO6VgwUkHAUk/zf6txY4WDmGDev7K0lRchZs9zog==
X-Received: by 2002:a05:6000:2f83:b0:3da:37de:a3c2 with SMTP id
 ffacd0b85a97d-4256714b6b4mr3524428f8f.24.1759562057201; 
 Sat, 04 Oct 2025 00:14:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f45e9sm11394922f8f.51.2025.10.04.00.14.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] target/s390x/mmu: Replace [cpu_physical_memory ->
 address_space]_rw()
Date: Sat,  4 Oct 2025 09:12:40 +0200
Message-ID: <20251004071307.37521-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(), cpu->as
points to &address_space_memory.

We can then replace cpu_physical_memory_rw() by the semantically
equivalent address_space_rw() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-9-philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 00946e9c0fe..7bcf1810bca 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "kvm/kvm_s390x.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "system/memory.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
@@ -542,11 +543,13 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     if (ret) {
         trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
+        AddressSpace *as = CPU(cpu)->as;
+
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


