Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576ACCD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYB-0004Uo-HD; Tue, 12 May 2026 02:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXO-0003CU-0A
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXJ-0005fC-I9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ad135063so40804465e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567046; x=1779171846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UtE3JjODAUnAvXPyKWXTcePiI07h8a8f95hnZQ+UixU=;
 b=nFJ+TFLC24aRIaIGcuiET55xdI29Ags/sf74l3NASlhqQkLF7RKIZQl67wbkZ+t+dn
 CnNvRiTFTyMXmo0UtMvDXCkvk8i8smOsPNdGXqKoH/y6dB5zUAFhMEY/oBunOkCFAmlI
 JMTnXq6siEKfyNbCsLgRxKZnBqs5gTvlAeQorV/bbor49Q8FF+7PBW+i4BZ5n3i/P61X
 3TvCM00IZt4EPkkds9bicw1HlPCtdzmrF5ypxJbSg3NWZ69mqM2/Qw/8V5E7Lzy7ltlQ
 fphZz9eQB7NNwsFjWGJMLlzIOZ2vp238YuEH+sWv0Mm5S49ARa8JjVw4dgGLXI/j6eQy
 JSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567046; x=1779171846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UtE3JjODAUnAvXPyKWXTcePiI07h8a8f95hnZQ+UixU=;
 b=TRo3BRM5N+DwDiet8al/cy3DlMGPXuP5XDcpcgpp0r9LjJV/Pn0lHW1XvLyRj6ZfOR
 2fIUsxGonae4m6B4IaCj6XtQ72+BIVa2dnAl3Wg3lyTbN1l3EOolB0tE9aeLjIWKjkmd
 3XuSYy87OxJp18kLLKNFzwqddbO3tQwmUAbxhZx5pKo82+hfevn8GuqcEfp4iUfuiIzy
 EcsnGDGRVpMG+cw2L1YMBA1r4zGXzCGT1rP7SBAIXvm1tJ3VF07R2IwncB0dCpkqQYn6
 XWO8nNX1nquRbFaYnbd6mIUGQMiD2B5P1b2Lkqko6bsB2AuADsJkO20YEQ5pacXVLGei
 aGnQ==
X-Gm-Message-State: AOJu0YxGQVt75rxX6kSWJWpidyFz/XFQ5J2gfaSoi4Q0GOUiUOboMinv
 N2dUcsNrTRt3D8xuwuha6BHjBII5Fi7ALnXXHLix+Tz5fIDHqbLnmpQuqL+8pH/0gglXKYavqg4
 rgRAoueE=
X-Gm-Gg: Acq92OGUWJUbqiLAcPE47VcGlSLJOKpgbwSoGmBNlMwhF0zq6VMsNbkw+jnZKAwJf1F
 SpZ1cq/MVz0gzfX2jIxPVqrNtEZLYMEiZxv5fW9GGJCb+WID4n6oVXcxUu5v934bP4aJo6s0OQ7
 rJLuSXPcT4i7Zk6NGVFUwwB4hJOPNJxTAy2VDNjMuS43KMQo6yn/zwE5iqnnr8qhv7Pl1BNwh0j
 Q13qO9KnTkFEWZlsPOR/HGsdnOOWKKm6eTKn9VJKZCisnlcG9EMZESRmRNzGvHtDCEd0mqzkxwK
 yPyuKV6vsPInVraYeeUWXU+rEw2wEthJLO2PRI8pwOe/kmn5xGq9To8MQ05ovytzgsv3G6hrhpV
 qTZ1jg+dcJq5WwKi6JNqH1xWIisVneVyfU/XzIWPCxQXjrrAwRJRRbajucStaRlguomFpchL9vi
 q7nuvtYXdj18Vx/9jE8iRrbv2gFDmOeaPyU0kNmosC3OFnCuBe4LYKQBA2XCL9sjyj3z07pPbOA
 0F7o7RNeks=
X-Received: by 2002:a05:600c:6290:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-48e51f3fd58mr472812605e9.20.1778567046105; 
 Mon, 11 May 2026 23:24:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90678268sm25100645e9.10.2026.05.11.23.24.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] hw/core: Update docs for get_phys_addr_{attrs_, }debug
Date: Tue, 12 May 2026 08:21:21 +0200
Message-ID: <20260512062142.67998-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Update the documentation for the get_phys_addr_{attrs_,}debug methods
and wrapper functions to state that they can handle non-page aligned
addresses and will return the corresponding exact physaddr for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-11-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-12-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h            | 16 +++++++++++-----
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 75e47768d43..e3436a1766f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -740,15 +740,18 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
  * cpu_get_phys_addr_attrs_debug:
- * @cpu: The CPU to obtain the physical page address for.
+ * @cpu: The CPU to use for the virtual-to-physical translation
  * @addr: The virtual address.
  * @attrs: Updated on return with the memory transaction attributes to use
  *         for this access.
  *
- * Obtains the physical page corresponding to a virtual one, together
+ * Obtains the physical address corresponding to a virtual one, together
  * with the corresponding memory transaction attributes to use for the access.
  * Use it only for debugging because no protection checks are done.
  *
+ * The address need not be page-aligned; the returned address will
+ * be the physical address corresponding to that virtual address.
+ *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
@@ -756,13 +759,16 @@ hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
 
 /**
  * cpu_get_phys_addr_debug:
- * @cpu: The CPU to obtain the physical page address for.
+ * @cpu: The CPU to use for the virtual-to-physical translation
  * @addr: The virtual address.
  *
- * Obtains the physical page corresponding to a virtual one.
+ * Obtains the physical address corresponding to a virtual one.
  * Use it only for debugging because no protection checks are done.
  *
- * Returns: Corresponding physical page address or -1 if no page found.
+ * The address need not be page-aligned; the returned address will
+ * be the physical address corresponding to that virtual address.
+ *
+ * Returns: Corresponding physical address, or -1 if no page found.
  */
 hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 1524d6f25bb..c0e9e726708 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -31,6 +31,8 @@ typedef struct SysemuCPUOps {
     bool (*get_paging_enabled)(const CPUState *cpu);
     /**
      * @get_phys_addr_debug: Callback for obtaining a physical address.
+     * This must be able to handle a non-page-aligned address, and will
+     * return the physical address corresponding to that address.
      */
     hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
     /**
@@ -39,6 +41,8 @@ typedef struct SysemuCPUOps {
      *       access.
      * CPUs which use memory transaction attributes should implement this
      * instead of get_phys_addr_debug.
+     * This must be able to handle a non-page-aligned address, and will
+     * return the physical address corresponding to that address.
      */
     hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
-- 
2.53.0


