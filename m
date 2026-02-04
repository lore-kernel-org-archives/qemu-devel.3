Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EB1EA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 21:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnkoI-0004VP-PC; Wed, 04 Feb 2026 16:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnkoG-0004V4-MF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnkoF-0000L9-7I
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:16 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so1595425e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770241993; x=1770846793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38cZJxx4iAxwoM6BUXXBGP1zDOBcP8UJ/s1RxdLm6XM=;
 b=CUHmYSMUFBJ23ngaBZU9KL/aNz+VaFxYn+uilwgXfo13fGmkFXm27QmBDzNHAnlKJW
 OXZplc9Tp/uho/VEFcGOmvmXV568PD4LEyF8QxyyCtv/0HkVWFADZYTQEBZuFqhsDqdm
 NdWkQk857ISQg2wgX6aWXjnZIkaoh9DU1yt2is4iXfwUTcZmdhquDPT3+hgV9VRcvTi/
 HfxPKwipfvDRTKkTt896UQoL/e3GbG+xgCDg8foPQ2HYcEGG+y1eajITaAbj+X7kf9aI
 bypHaLDRhgQsQHg0JwnPxQLVqNdH8OSelTn8SYWw4ML/rPS1CPRDEjxxPvlLYSugAiir
 p/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770241993; x=1770846793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38cZJxx4iAxwoM6BUXXBGP1zDOBcP8UJ/s1RxdLm6XM=;
 b=xNrgtuOxOVX1Ob3c+pogh8QGsVV183kHresB1NqCcsCKzcZtn8Rk6dJbWJ5UYdkMya
 RyEMbmGt+wIenRYYRlXoMThziK1RX1QuOFJIol8C0CjzkIiaCheO9q2LDLz5DnUfwyXq
 8NheCAHZBvj1SwIYt0HsjtL4LY1GpZ7k+1lgu37e2AVkDxkZI8he/XP9mvg3R96M3cUP
 BKtY2Zz4Kq8q5FOowwXQSmruG7Vm/O1zWJx2Cq/VllMrneGuEPLqvfwT7riaUfPHsaYq
 Z6abiWbrR0CHr36g09YVyc3Iz8vKXkyGJ1c3y8ugWwzMFvEPIZJR5U+RLuiiZJVxmnfA
 bjlw==
X-Gm-Message-State: AOJu0YyIq+d12CCWLLYHZHufe91loyBluV1bzL3oee8lNnF4sZbttbdk
 TlZY7BGcJj0zhuVU4fvKNklxM7IeUO/1h/ax7Mnl0yYmGQ19oqXN28wYxDFl5zI/a7zWClajlNw
 C8b8cvNk=
X-Gm-Gg: AZuq6aJWwQWwW9eP6SnE2LVJFVmHRxtIpc0SlnD52/sa0InwoUGQUhp8i6vlVqv5ccf
 mCD0CgZq6yJs2aMgPtMxUyCy8CKXxB6Zs+CeR6qZvuvAOD1Zwdv8yZjy7pFTrD2Rn7yt5WX4PaN
 4hc9e6t3fyZDr8be3xrRgjpqM/+XD+dD+xMsu+QCyBHK5URjFufqQ1oJJQZ9bu5LYa7FSaMTFx7
 LBwAwP49N41f0pD+v8ig47AsQS0pLdh50mkbiXF/olccVCNz38ZlPVJvfnyBplp1nfzQxALnJ+6
 t2wpKd9MCnQIe6h0VE0kebQ5f2V8Vl74pHrZpjcZJUCtaBHRdIndwDKtaWlmd7+Pq7N4yzBBabc
 tZUYkTlncE0T4Cx4JymALHzsWnWUhSlZWoE7/uI5sg8B4ml8mFi6X5wwfmBQIjbcZfdCja2QyUJ
 ORyZBiSafGhdJQudLhxlxMbpocsHcP3+YGgg7aadVu+944iyYyFrZ7K/cXvT3T
X-Received: by 2002:a05:600c:3b14:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-4830e93eb1dmr55618475e9.5.1770241993358; 
 Wed, 04 Feb 2026 13:53:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d20324sm9936085e9.3.2026.02.04.13.53.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 13:53:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/sparc: Replace legacy st_phys() ->
 address_space_st()
Date: Wed,  4 Feb 2026 22:53:03 +0100
Message-ID: <20260204215304.52757-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204215304.52757-1-philmd@linaro.org>
References: <20260204215304.52757-1-philmd@linaro.org>
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

get_physical_address() already accessed the PTE stored at
%pde_ptr and is going to update it. Assume the address space
is also writeable there. The SPARC v8 manual only mentions
faults (with error condition bits updated) in the READ path
but not on the WRITE (update) one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 5a58239d65e..a6f76a1ab76 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -190,7 +190,9 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_be_phys(cs->as, pde_ptr, pde);
+        address_space_stl_be(cs->as, pde_ptr, pde,
+                             MEMTXATTRS_UNSPECIFIED, &result);
+        assert(result == MEMTX_OK);
     }
 
     /* the page can be put in the TLB */
-- 
2.52.0


