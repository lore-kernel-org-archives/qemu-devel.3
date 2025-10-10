Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C546CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpP-0006NB-Vf; Fri, 10 Oct 2025 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpF-0006HO-WB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coi-0003qX-SU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so760251f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101548; x=1760706348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xXmMqPnz22xb+g2HM6yf3gZM6LeywfZqHIoIxV6VTOY=;
 b=eiZV4gEwYIa5TH6AXGMqJMeC8qAZwyrSyJYjTJaxnPPQ0C98u7MTykjOJ1UzxCH95v
 aqhCP9UNe/Zc6MFM+iiBBQ1KsdicDC+qWExnohtlfj0KChsirot+J+vbZP5ZX+u1a/X1
 VQFTQTASh3jxFTUehjZ/JYWsCTor/AR5yiQdy6EDCjTVTl0Y8kOL6Sq23TVQPGop/vcX
 GNaAe5LYfPy3uLSDKC7YiGub5NgTcUNylq5NB0QltNaX5sjo0l8kLAx9oDNfthD6Ceuw
 Ah0MQujaH1cl/M9A1d1JAGeEfEuOgbbEguTsi+bawsnQWYliAVfNKuvdwJZhHBoeO1gk
 IzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101548; x=1760706348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXmMqPnz22xb+g2HM6yf3gZM6LeywfZqHIoIxV6VTOY=;
 b=pfIqePqauoJ8W1nX/HW0o+Tm8qur8eWrSQ2Mckxgbrl/AqPuwKUMD3uFPMxJwUlFCu
 2xMA37RcFLVdgbX1O4rEe7Y0GNRJk002dDDnTb0WGqSjcDiTVBvpalnBLE1M3qX9LwLF
 I8b2wHwR4Uo00/Bgpw4NfWvkvqMqAcir1rAj5DwRou7qhCVhkivxbvt5bpWCd9ut6z+T
 nNVAFRFoN/PneR8/9bubvBtujadGKvqWBMBvbKfQ+lxTtsjLMZsLQ1i20Y7Hqv1esKrx
 VEFlNca+cF6AwT+vY+1woX0lNx+C/gwxh0gCSGKw25A+AiQxgx8UZA/F97K1hbeNY+7H
 bHLg==
X-Gm-Message-State: AOJu0YyStMldq8BnmnR5j87C72iWLf2Rblxn6nR9qtHbT6Q7E2giPLEL
 GPmq00El44KuNRbHHhHKL7T/TCI/liOT08cAZxFp1R3RqEfoICmlyA2ieAgVzxGFfoRQJ6ZpgZu
 3eHm0
X-Gm-Gg: ASbGnct+4BRGoZ5GmMv/J+xrOR+iUyws6fix0Je/eiDDhVCoKU/RsvZISSdGFXAp0gZ
 BOqnj3XYb+qtLV8ttyBysBUlOrQgYuY7Tf6DRYgnZmsE6hq1fR/bUPyURO7XLoSngdnFbc4HvNc
 L39YhrONaHn/iD8o1NnAfnlUe+lzq9HmbwExgcots/MCL6KiXF4UTFe1h3bv1fP6TVhOFg57/5x
 lHUYgEU/ZIA6XnjOlE2QEJB/xFeHu6DbQzeoEmkt7N7SZEibptLhxl1deNfMjmDUs/fPcu0eDWG
 4FyVTg8xt+cfURai5eyFVmNBaq8XgzH0lTMDbXyFUJFocsmW4IG+DVj8zoMs+oIIM6lK1CmjSUo
 dY5l7z4rRFX1TEEXS/24MqJLyY7qRaqYQWpolLiH2Uxb/xeIzVVs=
X-Google-Smtp-Source: AGHT+IGiH+5wfuYkRDijkLeYtixQ47cn8zIxcGQUrP99iNh91lzDi00KNgbbjXlwflQ6FzmdahpTnA==
X-Received: by 2002:a05:6000:240f:b0:3fa:ebaf:4c2f with SMTP id
 ffacd0b85a97d-4266e8f70e7mr6577031f8f.30.1760101547839; 
 Fri, 10 Oct 2025 06:05:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/76] include/hw/core/cpu: Widen MMUIdxMap
Date: Fri, 10 Oct 2025 14:04:26 +0100
Message-ID: <20251010130527.3921602-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

From: Richard Henderson <richard.henderson@linaro.org>

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4f7026a1191..d175edb6f8a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7214d41cb5d..3010dd4f5df 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -90,9 +90,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0


