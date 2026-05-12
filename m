Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E62CD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgX3-00027c-AB; Tue, 12 May 2026 02:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWd-0001hf-7w
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWX-0004uc-LW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso33221255e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566997; x=1779171797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GTGCKRRgQLGFleE2ce9wrYCRvh3X4bSQQgWStacujR8=;
 b=fPFaUYKl6EY2NlkxMlE46ki8+WCvcytO50NpmApqK4GQX4uDu13XyQgIpZUYfkW04t
 zxqATJ1FnQcCLtQ0stsSO0Is1TrHftPRETMgNPPbxd8+qTkk8m0/E4S3nxeSU/vIrKdH
 GEHUNLiqLUPNHYACNEWLgOeRvt7FSSfhBMNhuScG5GtQIHV5HVVMmhmJceOxDMowKbmg
 JupIJgbc2PbTGie3/Er9ZYRiIJ7sivR7xXvJqxOgGiS7dzCD0LsmBxy+47cxIMi4QAVS
 oOHelF5xK0ThyHGaaG0p7TZL/xQOrAKE9qEhl8Ws49V6on8JeL9iKL7edSkMD151s9kw
 nH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566997; x=1779171797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GTGCKRRgQLGFleE2ce9wrYCRvh3X4bSQQgWStacujR8=;
 b=Mxa8jt6snE8P4U6lk6cKcd24QWHL2CLLH7001Fhl438tyBrKLpzLihtPwPl+lvnMgM
 rpXB2eIaG8sPOo7y8y/EdH+egTGaw4T8Eae4RW44YvNkAzSd57wsOgJMHlTjJ8j0Kgya
 cXY0Bypg9+fb4ej/C90zgtCFi9m/8y0uj6uE6WZAkc9EmPUGBndeVxH6BLn+1X1pmkFQ
 a5PAULeuqRVyBHPXUjtfXkyNbrW0AqqzqaTs5/AkIIJ6eTtNecInetFOkT9G0fpBTDIZ
 bM4PIC6Xqo0eopQIUyAYYrOMExk6ppMkxQ7Ovryk3ceU20WJ8J8M0aLvQ2uBU+THTytv
 SNXQ==
X-Gm-Message-State: AOJu0YwO6m06vneMtVHvwipQ7nfx6+SNSpXkomN9hSL8loAsCjJSoHsR
 fJMRPZ3ZA2PmVOtlix7esubLKBVBrIEzXc7h7tKHNpU2zenpI2DDfMrNTjuitcQJ9oZai4Rbenf
 lTscdFNI=
X-Gm-Gg: Acq92OGtIIQWP4iW+B3DBwvJ9ccx0dq966+nEiUHdOsJwD5x6moGJaUHrbuL7KzoLwC
 ro2nbaDoryg67+6rPxiXQANeZ5D7hiwfJFbl0k/s6Q5k10wn4mC41qrNEw+kTeHG628vx5A7VyF
 E8LImrtYuWBmzkPRLlGABR8CFfqG1QGhItViQ3BKD28EM8L/gZ+vSI6rbNRrYvfXrE0tIqmVJc0
 QKCzDw1UD84r4ZUIBmvucZ7C79D1EvvQ8bR4mDNNtBhFW8/FLX2PX/HcwsW6cvpqMyjMneEwn6x
 KYiB9n9WOc4krfQZJnilAqhA/HAKHor748bYba7wWWaMykOivsVswobg+1Qw4odLYXE/+zPV2PZ
 K7Ql1hWl0Q7IT9MvXK3K3SR6bTsBF/v24X10ulkI0W+LzxT5GgnKrcOJ3Rn+VGAp5DJ8yFdM4UA
 iyn/kaRBurU8eauV6uJvInzyrEh/Y0ykYXT8WKhbbGX1mdYE2O+z+pynecYewt+DugARlgEjRu
X-Received: by 2002:a05:600c:a30d:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-48e6db3ffdfmr147634745e9.16.1778566996646; 
 Mon, 11 May 2026 23:23:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f42a845sm10039855e9.20.2026.05.11.23.23.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] target/microblaze: Make get_phys_page_attrs_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:14 +0200
Message-ID: <20260512062142.67998-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For microblaze, we just need to remove the explicit rounding down to
the page boundary that we were doing in
mb_cpu_get_phys_page_attrs_debug() when calculating the output
physaddr from the results of the MMU lookup.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-4-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a1857b72172..da8abe063e7 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -284,7 +284,6 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    vaddr vaddr;
     hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
@@ -297,12 +296,12 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
-            vaddr = addr & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
+            paddr = lu.paddr + addr - lu.vaddr;
         } else
             paddr = 0; /* ???.  */
-    } else
-        paddr = addr & TARGET_PAGE_MASK;
+    } else {
+        paddr = addr;
+    }
 
     return paddr;
 }
-- 
2.53.0


