Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShIr-0002Sy-Cd; Thu, 28 May 2026 16:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIb-0001xS-HC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIW-0005aS-Mi
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49041e84237so57400045e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999943; x=1780604743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WArSSnwpJ3pEKIFTnzyhQvXPduPtSS4giAKXBBATIio=;
 b=B3jRY7w9GsnnSistBecrUBHX+RHXqUtP3iSUxlGMQeRW4aQSVhVPQ6K7GzEqbnkLtF
 YNieDkj1/qkJxTSK+W6+SVcK5DlhzLQav9wYKXLL/JbTm0d3QP+NvP5a+nRB0JY7jx/y
 zJRbEmauYV7/Kr8BOdqrODFN0GI4eAMRZ00AVdq6RdC+2NQk4Uf741PvQmRZ5gcOJReB
 PdwoT1KJPjabNWhfqNItbz4rn/YJaeWYEVa/3j5aoLaGtbzH+qJ4diCW/k8RA0QDiv3I
 gR1tDjqkNqTY1qnTZQC2+kUhmwODS3i9VeKSGZZCaDVfUo1cdJWRSsXY1lVOzVF/wyIh
 7SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999943; x=1780604743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WArSSnwpJ3pEKIFTnzyhQvXPduPtSS4giAKXBBATIio=;
 b=MRGnlUF1D1Evyl+SCjbHX8rGDGAztouBu2XzAResJig2dKioxfripHWtMi9+Xct4f8
 nVBcVKQQW8SC34Mt9iGJF0WEJ6KlJXkfS1JIl0WReZLIxQNa2iX6uEKshJl32dJtI+Vy
 gaO7gwF3C5KIa0amlXLvdFqB7Z1soISyoneV779OcP7Pd8UR1HqJmMVrMQ7aIddMBms5
 /Yt1RyAN+rc2yx/J43avyg8FIMDFwGH8+AUyeyITTCe70svgsovGF1dWFZTp9qIscMfC
 fjRrG898zDlrRAZw8j2Ldsuj1I8j2jRv/w85aLCzM1zTVMAlyRRBN/x2CTfl8AgiX+q/
 ZQGA==
X-Gm-Message-State: AOJu0YyWR5qYzWeJDY6UzaHFMs20GQLmaaKHAmvFSzTd3JA7NRMYyW0v
 fR2mAWyFOZXEWfPNfUAJGxEPW9lnuUdOki9TWvJbPwG8OUDiIW1irB9eMd91Lzqzs4ZYTPMjihY
 uVEdUlOvH2w==
X-Gm-Gg: Acq92OEH9W0HhrRzpOOQehiXTMAz+hjzxXyrOvhhAK1RlGsNAzIt8xS8mH4vL6iJ0xU
 HSWdesEC3W6XV8oihzAcStyPlAvIQPqdkOWId+pcDOVLfVLij9/Q9vQio9PTLWTy+OxTLlcX1DW
 tmKoyYVLlHElcD0Dd/oLimOi8OCMivNFjRzW5iZAY4c+aGEx9gDxdkKJ428ljKw3fHV3bEn1ze6
 TtQfK28EGz3BKRH6DKwzsA3sd/KCIQNIp+9pnqz7OyfCmHwZY94Nl+7pCJDPyUxrQiwa1QqNdvB
 4WOCATJ4ZLv0VR/ZUhvIpPTNu0AWXdQeHiRGuNpt9m/bRr94NzWo74XimIBUL/2kq5FuXK+Ktyh
 +anYoR9NkKaSA33Ll9IdTvgFawKDBSS/6TndNs+famAGrdm4gayifyIn616qZ9kpn3kU+Mo67Sc
 Ob0wn5uiZ8SBww0yU2qBc8nTUqNnSLxCOL7zG6cg0DaENcwwWukZM4RzJX78i+XBcLnw==
X-Received: by 2002:a05:600c:3215:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-4909c087552mr390305e9.14.1779999943076; 
 Thu, 28 May 2026 13:25:43 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0b862dsm107005e9.15.2026.05.28.13.25.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/22] hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug
Date: Thu, 28 May 2026 22:22:52 +0200
Message-ID: <20260528202253.49122-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

No targets use the SysemuCPUOps::get_phys_addr_attrs_debug method
any more, so we can remove it, together with the handling of it
in cpu_translate_for_debug().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528161450.3564396-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 14 --------------
 hw/core/cpu-system.c             | 11 ++---------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 441901fae8e..8be6a84bd54 100644
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
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16f048c9565..14eb4ed87f8 100644
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
-- 
2.53.0


