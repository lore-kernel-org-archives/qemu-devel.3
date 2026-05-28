Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF9BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdNt-00076f-B8; Thu, 28 May 2026 12:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNr-000763-UP
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNq-0000nq-65
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso40388175e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779984896; x=1780589696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3/cuvRkmGmAvn0E1MPLgCn9/HG5ofkrNoReVzY2DtI=;
 b=VYR6cK27UR1CwQreaEfs9jVLvioQ4bko3nJeg6xhQA6+voRyeY/VrOIclR8UaYeZQV
 IZVNzyvsYGskFoJYtXj5WWcFC1hK/OgDvng8A3me+niTK+94+IbxVYFUKyEWo/pk5nT6
 3EiFD6WchReN7HL9MmbUpvSceBd7TDcuNuZ/s61nOnpUOIav3umZh6FBsYRujEYa4qCS
 tzWowRNpXXujvp04HnO3D0f8iGAig8152fS0TJiwoi8OoaGZWQp68sOP2QiYrg74SZLz
 EbYGVrygF5X3iSo8W79pX34JBOWAGUIxYgzVwYthlc17a5TKcKSmdsPsmM54EFBVSElz
 lVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984896; x=1780589696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3/cuvRkmGmAvn0E1MPLgCn9/HG5ofkrNoReVzY2DtI=;
 b=i8PdbWJvg8YG6AbnghhAvodZmtqGnsa6NDVKr5n1e9+K7cYFg5vycG1vur3KPDdBeJ
 gmvf2x5XSJm3DW6P3zIe4JWdGxuBf48zzAPcxUavJEIW8RWVY5/1QtkNW78NGc1Mx3hs
 iU8W08ec8DcY0NYndyJ8zPj/CMGqPl7QS4XdkdBLL9p54TA5OVNGIyQWW8x1i8ZfWMTL
 5xZjp8IQKpOA+4ovvhQHtyhqQpYwANqHGpPhCoqSYXMadY0ia9MkMSc58puAf6ijNsRO
 56ZwdaOIyOOdqe9EAQStbhHabAW9smCxPQsJyZhaEJyLRF8Y7O/2Gj8W8nHujNISHDwy
 TNVA==
X-Gm-Message-State: AOJu0Yz/v2i5du1FnH/hHakNs23QV84Jq93iRg8Cv3l7uiuSZUCuxzYl
 KhpT8w/rIEadtrGRBRkomwGqDQpnZuNNHxFqjp8EEL59iPsYPYf710tdIfrScDKWjghB7/qN5pG
 1yuT4
X-Gm-Gg: Acq92OFFeSc5Pqy/bFoSY335P3G+MD4Ocum3dcuN25Swhekb24P4mT6rKEmZunu+VKq
 fjZ3cYRHTwxNigKxiCGNL/hWSlQRzLzKcLXNX5XZ8+cjdkCiRm5xKZitSpGUqTJPQTdK+xxKV9M
 6mSjIh8KUP/sUp0d6mJlSYXEh8/jAyqqWgneltZIwoIkpp7HaTB5Fw21aAe+eHtHGDQU/MaklXL
 lN2DZ0KNs6lxTCfSdI4tWaJNNUOIGyeqoxjoObjWjmeiZ1R7J7Y2pfO9D+m3PYv9/g5B39LCLT9
 7jUkbgEaMePznRY1wRDgWUDNu3noQ7MdQPG58NzMXSPhgGV9UYXnW+8ggh2ja7thQ0pdafY1fJT
 fUdhvlldY+48j5KYiaSuPvfe2lyqdqbi4Cy8BrdD6kNv4Nh2XyiDzvqRbjUiJv+GTu7/s16ezQf
 Cb6PhQIzutJC9Sm7q9zYyhnUjz9lDG81D09S14YU60lllZ3C72Dytt/FKcjEbaHqHzYpJkc/8vp
 3XjEVbbLEDwq/UpxwPL+NYtRb4HUWlMWv+8JyLl5g==
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id
 5b1f17b1804b1-49044ebc2d5mr507788095e9.30.1779984896596; 
 Thu, 28 May 2026 09:14:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b5a618dsm19378805e9.8.2026.05.28.09.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:14:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 3/3] hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug
Date: Thu, 28 May 2026 17:14:50 +0100
Message-ID: <20260528161450.3564396-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528161450.3564396-1-peter.maydell@linaro.org>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

No targets use the SysemuCPUOps::get_phys_addr_attrs_debug method
any more, so we can remove it, together with the handling of it
in cpu_translate_for_debug().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-system.c             | 11 ++---------
 include/hw/core/sysemu-cpu-ops.h | 14 --------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16f048c956..14eb4ed87f 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -63,15 +63,8 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
         return cpu->cc->sysemu_ops->translate_for_debug(cpu, addr, result);
     } else {
         /* Fallbacks for CPUs which don't implement translate_for_debug */
-        if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
-            result->physaddr =
-                cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
-                                                               &result->attrs);
-        } else {
-            result->physaddr
-                = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
-            result->attrs = MEMTXATTRS_UNSPECIFIED;
-        }
+        result->physaddr = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
+        result->attrs = MEMTXATTRS_UNSPECIFIED;
         if (result->physaddr == -1) {
             return false;
         }
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 441901fae8..8be6a84bd5 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -39,20 +39,6 @@ typedef struct SysemuCPUOps {
      * for a complete target page or they use memory attributes).
      */
     hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
-    /**
-     * @get_phys_addr_attrs_debug: Callback for obtaining a physical address
-     *       and the associated memory transaction attributes to use for the
-     *       access.
-     *
-     * This must be able to handle a non-page-aligned address, and will
-     * return the physical address corresponding to that address.
-     *
-     * CPUs should prefer to implement translate_for_debug instead of
-     * this (and must do so if their translations are not always valid
-     * for a complete target page).
-     */
-    hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
     /**
      * @translate_for_debug: Callback for translating a virtual address into
      * a physical address for debug purposes.
-- 
2.43.0


