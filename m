Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26829CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzj-00075m-LC; Thu, 16 Oct 2025 08:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyB-0004xe-Br
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxx-0000ND-Ip
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so7182735e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617213; x=1761222013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dzo/3aKgRBERRKH9I+Ra/tkQh+obDG7u4Quf88Q5x0o=;
 b=WWe05z/nyE8IkKddSTxzE5UctIJGoRNjGKRjIRqCgYLLFEtkBCqC/ECFZnwb7WVXJ1
 DWUlBtyMDPPyQsPPP3I9SIjAQ3y4/54fH/iRLoAqgZUchS/QLKGpq6bORqAGiGsa/fX/
 +FLgz2uwotmHpibCIlQB2x8mG11PzQHE4yCjwE5ZmPK7MBCuUrBDII3I+fMZeimSbf8b
 RdrZsm4dAxaT7fFBYQGr0D5Yw8wnvSPOlRfFO2fbqlV5l9QjFKy/P6Ea2P2EfKlBhmdf
 JmqQimTDQU6HWz9iYogF1lBdkC24ecoj+SodMJ7Q6de3y9o4axKa+HWdsaAjCzOBYAl9
 hyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617213; x=1761222013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dzo/3aKgRBERRKH9I+Ra/tkQh+obDG7u4Quf88Q5x0o=;
 b=G6qYljGOedFABI77IBU61jY1jtoT0ysziIuKG0TwAxp5JZlNOorSkLAP9DIKgkFLIx
 nnHEzwTcIURt5RvD2G/hOuxQKCkA1aOH3LblBbQs9P9fSyS9P6ZK3Z6zHzciK6Y1HAjN
 tHYz8X5Hu0nxnz9ZrlqzBiRxeNDdOpBvi4PnusDI8qgsR7R3W/mzNBmxK2LrxY69ALUq
 DcwffhyKSgKjcuMQC93pDLqZ01jq47o2Y5rjbykv3uRToTl0evfJfB+La8dnZAj3+8uQ
 QY84c7P0S7RcdMTJbBxrT7UjMcnIc6gTrv15jIq3VRR3D3gpO5YOcvuVb7YwY6SRff/m
 Ckmw==
X-Gm-Message-State: AOJu0Yz1sIhRvEN97VwN8JrWFWfniZi2VtlQdw+7wk7dwOg1H7GfIkeE
 Q6/dWpeibUQE1D1MGEYxEk/2w/vbG5k05AF3eIFMKRiVoKIlDDC5ly9MwntHLzmnxBznfy0sXWF
 uLLQiG6M=
X-Gm-Gg: ASbGncv3JQbMuRAKIcG8hKMsGUcAS7PkqQmHQxGdBBMsp1YZUrJYoEj5d8m9TulQmYB
 BQF63O7nG/2/vc7oENzoe1ueJBj4PGQZ1oJc/kVppGRZhZQaC5szeHG7MmvnSwclPWVXmIfYlw/
 EH78lsN5KznLdFsPlgi9obDFGX5zOlSKZSigKZ+V2DN6Pv2HckjA98IgqmR4vF7dOJT+eLP7C3a
 WihGIhrPvleJ2pKOfThuQxP7WJfmHYQ1PydU3driAVdeNdWwBS7ggG4II8R5KNf7BNmLnGL+3vL
 X3Yfc06S1gVbxCM5ahikqCVbLBQ9JCuwQbEFT3zkdLoNoQJz0G9lcRgzNnUZ5v+6EI1WAZJM+c6
 KjwRcy986zmtZm8df/XQpI4/NEUiWXdw6sjXTt1DuDlO8+bYp+jm9NRAvyVdSt3Bb02RJiG5DkS
 8jSgpKj2JBVLYrp/w09kEYSUKXObONt306MSpzHKagKyeMqsfqjnklwVCID/6pI76tA7r4ITa2K
 L4=
X-Google-Smtp-Source: AGHT+IH/LIsyNyhMjoXaY2EvWdxqltywNH8Pu9O3qDjIZefVTOAP0KbsPFrJKWG5NBl2DvOBRtlgiA==
X-Received: by 2002:a05:600c:698c:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-46fb405319amr173020485e9.12.1760617212673; 
 Thu, 16 Oct 2025 05:20:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442932esm23687985e9.6.2025.10.16.05.20.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/75] target/tricore: Replace target_ulong -> vaddr with
 tlb_fill() callees
Date: Thu, 16 Oct 2025 14:15:16 +0200
Message-ID: <20251016121532.14042-61-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

tlb_fill() provides a vaddr type since commit 68d6eee73c
("target/tricore: Convert to CPUClass::tlb_fill").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-3-philmd@linaro.org>
---
 target/tricore/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index e4c53d453dd..7574111c87d 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -35,7 +35,7 @@ enum {
 };
 
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
-                                int *prot, target_ulong address,
+                                int *prot, vaddr address,
                                 MMUAccessType access_type, int mmu_idx)
 {
     int ret = TLBRET_MATCH;
@@ -61,7 +61,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 
 /* TODO: Add exception support */
-static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
+static void raise_mmu_exception(CPUTriCoreState *env, vaddr address,
                                 int rw, int tlb_error)
 {
 }
-- 
2.51.0


