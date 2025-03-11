Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F6FC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqxK-0004w8-QO; Tue, 11 Mar 2025 00:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvd-0003QY-2B
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:19 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvW-0006VJ-Ta
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso60931745ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666149; x=1742270949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9PU2mUUZXceFgFF8NURkIZqXSTxuLUTW3yG3F37dHQ=;
 b=HplIzsYFheD7G2bIbHaHKjetAU4JyioxlWzenrbz2kE2GUDihxdPnRjFFmAZ4pdZd5
 ziXWXaTPSZKXSCVKU0+yb2YokCyzbQsEnXP14UbroY/hypYSSTjf4GAHmZKyliq/FLZf
 ZCyjyZgI8gjWom/pFle53hrbAWe+WNqXwZQYllToYT29ThYt7BhfKQ0KUz4edxypOdXq
 VmGr++FrgtV7hJsGeuMPmsr5Nzx7v0qxYmwtQEoPKVB3t6zuNFvvd2MLXTSW8eEzwzdE
 5PIUAfGSZPravGwnQnqmD2HgcmKdMMPVGwMHeYg9vAPRePDimGSq+bvwFqD9YWW7QSLk
 LQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666149; x=1742270949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9PU2mUUZXceFgFF8NURkIZqXSTxuLUTW3yG3F37dHQ=;
 b=LZ2qv9Zk0FhnApCt4b+PT42cC+XMgZVu0mW15e0j98UcywCV3TW5lXSFWk1it2hBn5
 Bb78hRguql22ZMqSwnL1W3v7aEArzX4BY1yTn6cn+IGCSL8DeTh5skgf3RtL/CISZHzX
 uEgzsQb7tJhWNK54uCPM2kbNsTCSR+DGE1ukCjSMbyLD5pljhxDNE+pt6cTwYjOYA7So
 mm4XIt5hLGhyPiytkLVVrCN1hRiqNrv9iERTVMvLpFM88F7Xn8MxWGP985dQfxut1Vm4
 Verai/7F0RYBpdXZGINZ2I3LagDf0OfnXVKjP/kqZ/Ys9IBNUiGl8AuXdC2+/O7Yqg42
 pXfQ==
X-Gm-Message-State: AOJu0YwnSdTbGyFyUENcq0fBkN6nA4EbH7WdomjYotdKrhL85yv1BH6R
 BWKcmx1TiZe1JTBM9frvEvtTIa8E3FaqEalXmvN7yApX7rj4aN0VfABqAjuOHmCcCrXJBuq1mA5
 6FEg=
X-Gm-Gg: ASbGncuXLZzvP5rJUgMupgQeM6/4hWA3hNSopwWltuCwZAEw4dFfKlbR4si37i1Is0f
 mr+Gza7WQWugdsjmgqbH5FEV2eMmFmWF5vS3MxIKJnn23UOTBMDnwdzPes1aRUhOrgf+p6YFsHC
 aBySaVQI0dBvGhwU+5pdc0p6TZnUnP67ZKiT6Nw96Gih06ff3z9Iuirl+aUYV1cAcb9lk5KL5cU
 UQN8vIgELGD41C7EZvF1CTNOwhaRdL2N23d458+9pqW1KxNLYp53+TboYvrc4qa24J9WZOWY7+U
 bmXnioO3R0tkWIRN+9Zq+6XpaiWz1LbY6e/0BJ+Edr76QoExl2hlYM4=
X-Google-Smtp-Source: AGHT+IFhjhUd2vTxqYR3Z5nzc5K52WwhbsgB0wgjWXiu+XeofP+aLrA4dkvuyGbgnmdnOjVQzIEANg==
X-Received: by 2002:a05:6a20:160c:b0:1f5:75a9:5257 with SMTP id
 adf61e73a8af0-1f58cb1ba63mr3462589637.13.1741666149439; 
 Mon, 10 Mar 2025 21:09:09 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:09 -0700 (PDT)
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
Subject: [PATCH v2 11/16] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Mon, 10 Mar 2025 21:08:33 -0700
Message-Id: <20250311040838.3937136-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7c011fadd11..098fccb5835 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -342,7 +342,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -418,7 +420,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
-- 
2.39.5


