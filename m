Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AA5C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqxu-0005g0-Gg; Tue, 11 Mar 2025 00:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvd-0003Qa-47
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvV-0006U7-QJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fec3176ef3so7270646a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666148; x=1742270948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsftdeZcZ0LsVJ43Vlgc1kB7SrUHDvnjwuIeYSteybs=;
 b=xCaQ89OFmb1SeBnhjTwZR6YZRV6CH4QIwtAwND9IPQZSF2qZEGjWde5uz5jlGwsEa2
 Lzg5BJzWveA1MD76S2iIMYA8RA3RqcYjWuonnclkRkgxRJWgyfV1xhoLiHkvDgN9stR/
 4/HOe7l9jKawRxiXdWARXnF+L/iX2s+J4/221wJTx6PYY2OlasfCabB/ZD9dPDxFVKfW
 /avHPfl/ZzFI9h4cIn4sTIAo0KZcw6QuWE0UHysj4bwlxhrRn5cQK2DjxCfX7IKnlOSY
 ILgkOhja1tiRu9bC3xN8nDv0yjkzuM/wX5kHws53cTat66HaPylZqJF7OvS96oMk3uku
 USoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666148; x=1742270948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsftdeZcZ0LsVJ43Vlgc1kB7SrUHDvnjwuIeYSteybs=;
 b=MxF239MMMPvffKeGoDzb6toxYI40lAuM9lklpHMfTeMl/Mn6S5ozbgA6OgCt63SmTi
 SgBGvLNeoxhXmlt+/Fy0qC54aKK4okJCefpPgGfuZ08135bUCrmx+IGqHK45ToGFPZMG
 gE29LCHeZagsF5T4bh7rysRtZe6LB8oonjNulMvyGCTgFKc5d3HDT5LmeY+wkBbUgqbQ
 xjFEXYwMfZAFEvojBGKZroLJlmwkLIQzip9INRri7QedqRaLhPN/6v74IfHgZ/IzZgmG
 4WuCjvwePhsVFk1kykSmnjrplwBn/UKAfYKj0OjzZNPwl98NEdl5VgTHKF6t2iYhppGN
 JhIw==
X-Gm-Message-State: AOJu0YybbDgHOKsDIPSgV8dWXJB9skB+mp+pAAf9TfDxmp0I19+cEqH2
 plDfPRn6YM1soiwcE3TP+IzPzCl+F5OyAb8C7MR6XuqFvZpo0ANXTjIymX01SGKZQnfvb2Uc99c
 SXVo=
X-Gm-Gg: ASbGnctJS8cLZ40zNBers7yF/nnayMP++1pGayPRO21Jp+aK4PHDzH6HCuUdvOJ85VK
 Y5vopOk+9+oaOi6/bQaU55rgLKa89lVBjf+X/jbW8o3NcD5Sa7jyeKiT7OGrmMeyKwLwuSdvU/T
 o/SFqNC/Kv44RW9LyF7AbYqGl3itlTyaHb54UU5jx2H0KCBUYzFe3BIghZmfqFZ6/B9TtcNSCSj
 NFxGIX5Z0F8e67gTlYEZ3AUUSYqTp03FqOCZLE4IBpv1/tEAdeADgkUTZDSVg5XywKFYoLip1vB
 tIKqkej/uddAbwvNGIyQfoK2wqFJNP8uGfaX7L7Faj7W
X-Google-Smtp-Source: AGHT+IHS2PJ+/kxwhPkSsqZSy1Lcoi2dOdo4gLmR9Sx1nH5mZxTPaitClYNterYld+kjauOZ34q9lw==
X-Received: by 2002:a05:6a21:164a:b0:1f5:60fb:8d9 with SMTP id
 adf61e73a8af0-1f560fb098fmr15311166637.33.1741666148378; 
 Mon, 10 Mar 2025 21:09:08 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/16] system/kvm: make kvm_flush_coalesced_mmio_buffer()
 accessible for common code
Date: Mon, 10 Mar 2025 21:08:32 -0700
Message-Id: <20250311040838.3937136-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This function is used by system/physmem.c will be turn into common code
in next commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a551..21da3b8b052 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -210,11 +210,11 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
-
 void kvm_flush_coalesced_mmio_buffer(void);
 
+#ifdef COMPILING_PER_TARGET
+#include "cpu.h"
+
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
-- 
2.39.5


