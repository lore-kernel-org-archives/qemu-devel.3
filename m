Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88940F99C8E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wECCJ-00018Z-Ih; Sat, 18 Apr 2026 16:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rickgcn@gmail.com>) id 1wDyyN-0002tX-8Q
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 02:16:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rickgcn@gmail.com>) id 1wDyyL-0001TR-QC
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 02:16:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b2d3a9e149so12010655ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776492963; x=1777097763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ajR1xqWEaLrL3ki8wU6nIOV7OLs1umBACqGtV1J9hPY=;
 b=k+h30YKBm/kVefG2br5xfue6RLkrZqWQ95SrW8bLqcQvjLtdd61QK+uUEbTjNgyUGw
 PEasvS1ddT+fj46UTekPCtBNU816tC7ADJ40oPMuZBrS/zNFNwBnz1Ko+ABqopQgBxp+
 tYhfwR/AYjxJ9Bv+DbjGMOPaXtmG1kMH5ant189KVi1J8GIzZnaU40x2deTPr6X/kJa+
 uOBaFW7sHmd1Ajohca0iOIo4FplWymEVr+RU00fv0Ml3GG0KYFIib4oekhZfOaSTeZlh
 +u4yisiRIm78QdpOfekiZv0cY19oNdOs1i0AAew8dlghNHDr534nWXq1ACGdK+AFs8u5
 Kv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776492963; x=1777097763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajR1xqWEaLrL3ki8wU6nIOV7OLs1umBACqGtV1J9hPY=;
 b=mcMRqXj4pCowlZkrOsWRB/7VcUQvYT9DtLe9KgzZTH9FVa30kATkwWw+iMspJi/p99
 sL8W7EasEf/XVUogmRqcwfs04EYES0zhCqCfl6Sn8NNafTGYEny8VfJLMToXR03+CFBx
 E67GSSTRdfMOhdU+5s260G/hNMgB/1D5EAcJm2kcIsO19ycCMvsWAJhVPBuAPlW7sqWz
 INXkO8KVjWepRtx2+vaTezlbJ1eloe5pPPIdSXFA48w+RpjwOxS8NpymVzbqd4f+wgzT
 LA7LuWrQ9eSE+ebS7/WqEtKXfrTQbG5uaiz5emk9eRlYmPpqcdZRZlEHI3i6gBr+qW/n
 trZg==
X-Gm-Message-State: AOJu0YxCAotQybaG8x0IvlTgiJu241PfO7yAiZaMkMZZI9Aq5DfqCVTU
 yWW3UXJdjPqIbzNfkrcmBj4qjZZERrVXc5qetYJrlZdvp9M1ZzrWvhfSm5b7op6C3EmG9uXH
X-Gm-Gg: AeBDietrbveGf/62mqUDiIkPTceYirK1RCf7+Q5J8BmeXDy2HeAYxwqm/BZ5qS1UF2m
 nR5whqv3LPNrQs48plpXWInc49n6sSsAT/87PLDCQFO3TCXdMsYVVcfiydJL3uF+jHCM2xS5qo5
 ukqZA2rVwlqf6Bv2C4NG6cYgfmPdbJLMev/RXkVSqzgZiBDmGUFxFBl9AI88QQ5CZ8bpYnowRvL
 VCI9NkijcX/Rtsd5AI3BtioPPX+0+eetkKDk6qUVsXayhHrhuo8lO3/h3VxLly9bltHcR3PzeoP
 sI8rcuQLoIf+Vg94wX5nEAHwVE7wCn5NVcC+4V3nVZY+LIQIKsFwdK1yqzHlPfWTAopfmhE99o3
 V4qdih64Qae0auqHRWEV0GUm7PvV+escsrjCZs0iqDz/DtihWOxStXcDXi5zIAQ8A34ITDq7rtq
 02Ee3NuX/hmcFqG/kG4nmddc4e19IEPag144+9ag==
X-Received: by 2002:a17:903:380b:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2b5f9de2b9amr50330555ad.8.1776492962682; 
 Fri, 17 Apr 2026 23:16:02 -0700 (PDT)
Received: from Rick-Laptop ([2408:8240:b010:3de0:1069:22e2:7f2c:5c3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20c6asm34938995ad.58.2026.04.17.23.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:16:02 -0700 (PDT)
From: rickgcn <rickgcn@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, rickgcn <rickgcn@gmail.com>
Subject: [PATCH] hw: i386: vapic: restore IRQ polling for non-kernel irqchip
 backends
Date: Sat, 18 Apr 2026 14:14:29 +0800
Message-ID: <20260418061429.16898-1-rickgcn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=rickgcn@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 18 Apr 2026 16:23:22 -0400
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

69dfc078 extended vAPIC handling for WHPX with user-mode irqchip, but it
also changed vapic_write() case 4 in a way that excludes TCG from
apic_poll_irq().

Before that change, IRQ polling happened whenever no in-kernel irqchip
was active. After the change, it only happened for KVM or WHPX with a
user-mode irqchip. Under TCG, both kvm_enabled() and whpx_enabled() are
false, so the poll never happens.

This regresses 32-bit Windows XP guests on a Windows host with
-machine pc-i440fx-10.0,accel=tcg, causing a STOP 0x0000000A during boot.

Fix it by making the decision depend on whether KVM or WHPX is using an
in-kernel irqchip, instead of whether either accelerator is enabled.

Fixes: 69dfc078a6f0 ("hw: i386: vapic: enable on WHPX with user-mode irqchip")

Signed-off-by: rickgcn <rickgcn@gmail.com>
---
 hw/i386/vapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 41e5ca26df..1acb9f91b2 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -716,8 +716,7 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
-          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
+        if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.53.0


