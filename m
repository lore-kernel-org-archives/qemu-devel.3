Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4414A108E1E6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQL-0007hw-AI; Thu, 19 Mar 2026 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQ7-0007cq-Tm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQ5-000549-3T
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso7112155e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919202; x=1774524002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8yqnxF8hGCxxNwG0QPtk4/HBFqHIOCwK8FAKwORZgo=;
 b=m2SM2pSthHEVGi8yySnqsIXgZ5Ckdi3d7lzRJulcn6VH16Fudx1qbCAowd/xWIddK/
 X9CR27TFEJ97g7CtuRa8wbyQaCltqxKffcEe5/jA45kUcU/qFT4OoczWAbdBGeqEVuEu
 odFzfE9P+EyAnt5i6JVsF5UjS132hUyFwjX2tMKhomhwKWcbfidVOC5oMkuXvMaUo5U+
 Qgs+17SySj5XLm3XRcLR/mS0Zmpra09V9i2sKiVVvZMOBCQ03Z6jVXkp3VLMMCY/Geu+
 FqPg47w8uJEQptTqFltwkoMTJ7SnT7FxzqKcjLZ6igQbR6rFGTFKETxoj0NBgIvBrET8
 JdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919202; x=1774524002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f8yqnxF8hGCxxNwG0QPtk4/HBFqHIOCwK8FAKwORZgo=;
 b=BezgTpuf6RyBYZw1OvUnMnyFM2vfqAEhSuPkHOxun69enVVEjFiueNVFMFHuBdPaSL
 CCqsDwmDpE+diJhR7RuLPw3gy70esPX41O/rv/Pv5tj9tdW34GLq1wrAyGIikN1x/n8i
 xK6o/QYRkAETW4xShlOcq5LAyRM+Vrp0R+tkH7QX029vQzlgB/dDsvhXBn+3rvX8hvce
 Gep4xz3fXv6mU+KDvQkt5eIBUBThuwqXoG02S58lOzaxMr3UH7Cjqrtk84/HrMcZW63w
 VsYygS2h0w6fxMypzVxA3GpOVWSadp8aeYXCao6KtCOcAry7y4948A3ypq6vCN6Qlw/T
 FnQQ==
X-Gm-Message-State: AOJu0Yxr2sf4jXF7mcZXwDicqJ85835rZkxGTf6UYsMjtKOo4QYIDT9A
 LJZLxmAsRCi+TfuhjLAJ14X+SWc2TQbRmhb5hf+ZDzQCGQF+4QqaDb11jero1+EqeyANLXrCQ2E
 16rYMr1g=
X-Gm-Gg: ATEYQzxJiaS/5/KisPsH8Dcr0clinFg7XGSbCQTx1rSy4jg6wcJ6PJ2nhLkaM7u7qT8
 81KEf0vgBLS6CbaR7276LoiISo9I74ZMaXg2BtB84TAUmVcXt0QlvWW6cE+wyQU/5+MHzlS9365
 eRL0hTWeZvZjYqlhNomr3L8i50zNW9sk5H1Wzn1X2ObkoDNlAkhuB9HJBGTY3CfWVqQ4/s2Sji1
 sRvC0+2dN8+I2S9jP9QacwKMcS+QlBBzQJlRJI97RcRWumBg5S73bOM5gpenytdmcq2COhzJEWF
 /lCpurgPYRZszTss9RznDVG1BpPTaHb8iuSnLSWsZ9ZSNcsE50rrcKnma0YzL5nEPR0k/wUDTCb
 7XUClqJxFtDJ2VDE241omEGbuRKc4vm4pw6GEYe4h7/DxaoQr2Zfn4uerECRGvwJcrvdEgyi3FI
 glG/QUAkOJRtzjSB+H+8EyoG/v9MMMCxamo32bSVzCwvmmZRLS3RyyKULIZMru1BwtXd7hGStx7
 XeKfNtlhNc=
X-Received: by 2002:a05:600c:6612:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-486f8b47e70mr46838835e9.11.1773919202026; 
 Thu, 19 Mar 2026 04:20:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949a5sm56925475e9.11.2026.03.19.04.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/ppc/mmu: Remove unused hash32_store_hpte() helpers
Date: Thu, 19 Mar 2026 12:19:31 +0100
Message-ID: <20260319111936.68041-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The hash32_store_hpte() helpers are unused since commit
6e8a65abbbd ("ppc/hash32: Rework R and C bit updates"),
7 years ago. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 04c23ea75ed..5705f57935b 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -87,22 +87,6 @@ static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
     return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
 }
 
-static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte0)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
-}
-
-static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte1)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
-- 
2.53.0


