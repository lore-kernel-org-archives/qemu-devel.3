Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E305CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgX4-0002DA-UT; Tue, 12 May 2026 02:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgX1-0001wR-2M
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWy-0005D3-PK
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso52745475e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567025; x=1779171825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/8cQxTTYdLqX1Y5L01/6pF9zhPjm0KbJUDRCdlStpec=;
 b=FvMoXBcj51PoBexxr9SMWxEgp1Tg0FnQPs8ANUUFtVtorV0g0g7c39HtGzjtEJdU/V
 lGSiG6C2bSqLtAYS82+oxL5/0m42Xa899LZpzy/i81x8dScbHxX5IGw51bVcpSoNwF5l
 hrkp1GLY7oNVr6TAGhOPczMZiFUMzPi9gTJar6gO6f7dOXoGB24INaQ0ghLH90kA0pMJ
 6cLJTz4ugTaLq+yF66qL+rig34zsCG8iHqubxtjNQ737tjTH7M0sf4I4mCuXHcrcObsW
 EmSlIDcbBn38EDMu/JDnUJ6Qc50UVAsv1bvv61D1oUMa7DbvZrUmgFtxpVR25snP1cwl
 0Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567025; x=1779171825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/8cQxTTYdLqX1Y5L01/6pF9zhPjm0KbJUDRCdlStpec=;
 b=PfjHGchD3gBqBzgB5PJ1j5GESyLuKxQYPMwXs/hBpoUH551zlr8eRbsjna8KAomxtp
 SpIZsdcgNAEgwUFitLDZXViguGapJnik52OoceFVG6V/vBd0efX4T+yb3LVpp8Sll83E
 MdTT6amjl7W3ieBBxfWyI+I6cBZQJHvUb8CUFuBeB6R7Ay2d78emTHFyKv9T8ogtEfOh
 12nPbPTK4bsCh5M0i6ra8a16XqQwMEjlPIeiiMiuqeHuWS0SjWoB5IZZIHrEyaHKutH4
 PzvNRkBq2Gyj9QKEv1RGalOzi9kP2eQJcy0rAMaQsKMs36B+wh1VSODjaxZRktCh4AWG
 uSSQ==
X-Gm-Message-State: AOJu0YzQKs/k6L6dKFYGMujx8ziWqMOCbrG3PPEQKXunamSlgw2laJs+
 a9ilPPYSlYajJzvn28JKb/ZDuOdDMziWFYy7Ylr3iqNxhmR9aAUrcB4CoFY/IUo1e4AHIUFCVNP
 HHlni0yg=
X-Gm-Gg: Acq92OE63NmNy9anA/2+iJ8cJwfMIMrKUXHozia7TlH8sBejvh+HzhSrhn2igkTZwyo
 3dgec+5S3wN27DDuUMcjSrAZN3zWGwmw4o9I1RikokrEJiMOgC6rY7MIRN0uDjvuGagQeWxbSe0
 bsTNfYhgLNFWeQ13SCoPlgPusvFn79MiKHDb6bW8a2SU5RX4oMel4weJDp1xInIS2DfEfvsDeTp
 PCjp6S3otuej0Lk8MlnhJ9QKyTF8NkpPjqbjq8KjPM7X1mhUmjVRduU/WGGvzFcxHMVaNcgwcwY
 3JjuLvd1C3vMh09G8a45eWRep2pyUEpDuiwJiIR2GUyehK2AEL9/t17pW4vrb4ZsfQCf6vRGeYl
 eReaNLTyTBMumGfswzC+FKidQHJbyKnaD7MGNO2aLHd/mt7jgV1SeGUUdCzMhxUf09rBSJ3S7AG
 wCJQKLKtq33HyiONSUzacrlfZ1ti71NSPudPKp4cDbJDVSO5sH0VNSBTWd8WD5P8q0eXVtC4++7
 rkucRwjopE=
X-Received: by 2002:a05:600c:8b65:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48e51f4e5fdmr481920005e9.28.1778567024950; 
 Mon, 11 May 2026 23:23:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e5efe66sm12412745e9.3.2026.05.11.23.23.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] target/ppc: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:18 +0200
Message-ID: <20260512062142.67998-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The ppc_xlate() function can accept a non-page-aligned input but may
return a page-aligned output; we take the simple approach of ORing
the page offset back into the result address after calling it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-8-peter.maydell@linaro.org
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20260430093810.2762539-9-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 52d48615ac2..a1345df7160 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -863,7 +863,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
                   ppc_env_mmu_index(&cpu->env, false), false) ||
         ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
                   ppc_env_mmu_index(&cpu->env, true), false)) {
-        return raddr & TARGET_PAGE_MASK;
+        return raddr | (addr & ~TARGET_PAGE_MASK);
     }
     return -1;
 }
-- 
2.53.0


