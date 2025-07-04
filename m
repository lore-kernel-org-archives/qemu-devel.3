Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D55AC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRh-0005yj-Bl; Fri, 04 Jul 2025 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRU-0005vq-N8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRR-00069P-P0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so555016f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624086; x=1752228886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+KDRndTqan82yvtPjat1lQGvdAKO/1zJZTpa0R1qcXc=;
 b=HhutvXcDjxKCBmr8M9N5mpf1/LgcFNst2A27YLoASs/oXmkl6qwFj3mf+VClVfg0xg
 GfMw7zNOaXHaWz8w6oSpsd1NQ73mqWgyTOgcEknP0+A9Q/3Cf3M2UjziVUYF6ovLCtVR
 85ZzENo+Zl/bG9t0cOklybp2hehC+g1CCrdajFJaCm+GlyIPru6Lo67/TOtXH82YEeGa
 v13bwhvk96C1u5kFIGN6iDJQB3txgF+GNXPQ78pGXjAtHLvbdnwDTrKIPFwYwcd65l6F
 PyRBmJqu9DVAuQJ26GEnktHUkkdCsnWD12EzdrhRUOk2eS7uhvjxgOSrz3vBa8OeyROb
 YnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624086; x=1752228886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KDRndTqan82yvtPjat1lQGvdAKO/1zJZTpa0R1qcXc=;
 b=IEfwnKBqcYCiY3tXrMWq0yKOhx4ZFHTkTnzl9PnwRJzVG2SFGHMkK+r5/5eWXKy4lN
 QC3Prlx+C8yjwQY81KQHAw67t9IlAKYfg1R388UPpxCCrSOdU067JwhrTA8XApWzRhlt
 XOlfILiSxnLAo8LlrWLe8fcxLiuTL21EPMkB8qkbm9KPX8zz3x4yt+gbv0zTrQEkqy5t
 5ZJW7+IVR1amrJuN0AA83pHY2KdvMUErfeturK+wtvxgGWi8233H0tCBaxNFS9Op+GLQ
 piN21yfI+AC16o+YOQToCgHqbRS7xCzmzPnVI6U/nVM13DI61vZ7CBDjQqzAuSUxKmJg
 cXKw==
X-Gm-Message-State: AOJu0YxZwQsOb6odmAr+VjDDZ+uHYjc+u4SmUaFET2c02QYh9Awc+fZY
 wSk0rLn2eZCptJNz4ocawqHXsvQbEbqdCgwhOAoOpbh6mpWggsNCrCVrnv/Y6BhldJOUyMRMg9u
 sLo6naEM=
X-Gm-Gg: ASbGncvnRR8QQi2gzXdZSrxHgQXr76wH+KCva3Fp9q2MyfHXl+Y7xtAvI7WYo5dfWQy
 m8uqblMIxj2zJ38p3e6vNrTXfYJV0hHSSxYvByDzhX/93LWGPG/H5mmDpQ0P79eXpAq5IUacN54
 23UxKk2JgqX9T5RxD/WWuUsdxghkV1dir0mst6wbiJGqFA/kwLbW4DhMb507TZb64hk56ZhKrDU
 9T667Wo58+PYl0ytcK1F/qWWL/+zzsRU+iIGhnzsTaNySCxqoCsjmFd31yAx8Pf4zZb/mzYr9wM
 76B4/ue78RiVBXvKEXe+J47p4N+oyjJNr3hxLSLgdgu0jNOkhAgMhbXs9Ax5fjseXzhbkWzLDNC
 8aUoLLfa3t8EHEDT6rIpzcGitWiHDJeN2mwy0
X-Google-Smtp-Source: AGHT+IGY0QB3lOftMHf25y7wGNZKvFN3HVVd5iYxOl5WiyNgQl4f2RJnaBTiJc8/FsJxQTz3vkxkbQ==
X-Received: by 2002:a05:6000:208a:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3b4964f3890mr1860473f8f.1.1751624085675; 
 Fri, 04 Jul 2025 03:14:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d085asm2081801f8f.25.2025.07.04.03.14.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/31] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Fri,  4 Jul 2025 12:14:03 +0200
Message-ID: <20250704101433.8813-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20250703173248.44995-6-philmd@linaro.org>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd7636f5f..b9b4427c919 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
     return 0;
 }
 
-void kvm_init_cpu_signals(CPUState *cpu)
-{
-    abort();
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return false;
-- 
2.49.0


