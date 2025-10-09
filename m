Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48EBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsI-0005Lz-5P; Thu, 09 Oct 2025 04:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsF-0005IQ-OW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ls8-00087j-RN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso5309455e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997973; x=1760602773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhZWfVpm4QWSDcKrdKLi6DBczu6OyvEaZd0q8XcrWII=;
 b=VrFwSXBOEHUHDLKuh3x7I9GoW30XrU3fbY4z1XNS7VGyX08NFw+AJzgOLemXJOM9IL
 hzKVE4L9PPxhNNWf+J1rKL5kw+SZel9idcaEQX1uKoEFiz6Uj6sX3nz0kVHkGEyBoTSj
 afENoLKdsVLOpAkIHWChf2qowzfu9xx5JfEhKWVMjfI/oNTFLevki9m+50dxi8Z/b2dt
 6v+4enOHW311diWBeIbLPpcVNbO/4AU7YjvP42dwNE4Hv2N+GBoaYhpjDMfDzoDI0T35
 ygqSESBZY1zh5e1/SY2V6zXZAq4CDmOUESJ57lIGefWO8Clgu9nkXRbxBsjzY1UBANfd
 gEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997973; x=1760602773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhZWfVpm4QWSDcKrdKLi6DBczu6OyvEaZd0q8XcrWII=;
 b=eXCO7DXJyobg6tEpuRxwM7owpEoyFxfGxJJyuXImGmm/vsiiOeRsEAjfdY1LaEmdkh
 HvQhtwuv9+juyR6WiIMeaJ+mP+ZU+LI3oevt7daT+yQ4PPl0qeolvVSx02dfb+DT2IJK
 KCkL9N0ccj0Z0m890qwzbg8os/FJRKPKoQvwDLXzxlH7d/xrBJTOTlu4DTvRXdcBTPr3
 lqi9aTkw9OpqCvKkdgSQnudTu9GgrsmybkOIU312+Ztt5B1m3d0rzGQHpSVtR3cdOsjr
 PyCSbt+cG6qNIl6tgggUW8dda45SI8ZPsGLXSx23vwccluZk2ftntb5M6xw6u/gk2PyU
 mZ0w==
X-Gm-Message-State: AOJu0YydP+wU9oKS2//G5VJ/SCSG34FwDcihlDUTdSeDHctYcVRzokeC
 1LWdKltp74JCCpIUnYVG9j4T0cYCiXy8DEOhSGvOPzoFtpIJFTJqudVursD4VStKMcPB0lO5bmr
 hL5hQw3CbIg==
X-Gm-Gg: ASbGncvaLwk8+NF6W86E+HVRce187ZmaNpGR40NNeG3S/RfQkFwCeivZNWuxBH9iGlM
 3d+TsnuQAWEPXXxSBpY2M7vUhiFyjcqMTqFN6TbsWHEsHyR6z4iDMzdR16PcYQ1ndbzLL4+hj8g
 XBAOXtFPbZJBQub/pZ/WXUqKt299hc1Xa//KjYdveUCw2xRPLmeewKLtQ/TF+RA8wLZicezMbhx
 TPPL/T/sf6TTQ1aIlNFywW3oAOmNg5FqhQdinSO9spqNe43F+9tm0R6eR9LzvxYSkOcr0w7G7Xc
 uoRWqapINBzy/rbKsyfZ9FcjpXxroL1a3ztf9iRYaB1/Z5t08agGAu+FVdK58oL55lVz2qwXQte
 l7QTgmy6JhNmTU55ffP1OVcDoAsxneR4m8T9t9Ii5t0qgKSbzxyIEuJhDV4d6lovojvjWEL7zaH
 VJFOPHAy5GJrpWzWE1NK7CTPO6
X-Google-Smtp-Source: AGHT+IGJna3qB0i8Kz7MB/IBXsYxvZ/jH3bWFTqtDVexIniSQLge29/3MSeVWbN0jCgUzyaZniBEhA==
X-Received: by 2002:a05:600c:8115:b0:46e:711c:efe9 with SMTP id
 5b1f17b1804b1-46fa9ec7556mr47662245e9.13.1759997972900; 
 Thu, 09 Oct 2025 01:19:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d6fb41sm71845595e9.17.2025.10.09.01.19.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/10] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
Date: Thu,  9 Oct 2025 10:18:58 +0200
Message-ID: <20251009081903.13426-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index acea50c41eb..6fb3f6318a1 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -28,15 +28,14 @@
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
 
-static inline void get_phys_nommu(hwaddr *phys_addr, int *prot,
-                                  target_ulong address)
+static inline void get_phys_nommu(hwaddr *phys_addr, int *prot, vaddr address)
 {
     *phys_addr = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
 }
 
 static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
-                        target_ulong addr, int need, bool super)
+                        vaddr addr, int need, bool super)
 {
     int idx = (addr >> TARGET_PAGE_BITS) & TLB_MASK;
     uint32_t imr = cpu->env.tlb.itlb[idx].mr;
@@ -95,7 +94,7 @@ static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
     }
 }
 
-static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
+static void raise_mmu_exception(OpenRISCCPU *cpu, vaddr address,
                                 int exception)
 {
     CPUState *cs = CPU(cpu);
-- 
2.51.0


