Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C03C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mJ6-0006km-M1; Tue, 15 Apr 2025 15:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mDO-0004oP-KD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:45:04 -0400
Received: from mail-oa1-f52.google.com ([209.85.160.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCS-0000In-FS
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:45:01 -0400
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso3822482fac.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746242; x=1745351042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5D1ooWpMQNpS4VfZLYdNBwbBFgDBM2YAK2voHTDWR/E=;
 b=YxepaEt5KKyugH//FnGDYAMcesuUVSaD5PnV1GSXD4nCiCGP0SoKsbD0CRRKzy90it
 FkU3GI6mC+FoSihCO3XVGpGNr6Lx0e0YPObKhMPzhGpkFzU6udhGjQQ4BXj+krYrcebH
 6aGJ4cGZXFdek+0srSiZzWSBnFOm96lE0KvhFdDUfUR3YQupzJlye/ENyP7OAgbZkrT7
 /zx6EZ0pUrr4Z7ZbMuGZNORTqTdiPrOwcOqPcCe4XOYeef+UeXuJ2HP91XaePLSYrsbT
 1dSCKGXCyOLfhO+Kxj5MMTXa+fu10TFU+ACUVvPTcAqCr+SSTYzQ3pG4XmM9yWl4m6Df
 8oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746242; x=1745351042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5D1ooWpMQNpS4VfZLYdNBwbBFgDBM2YAK2voHTDWR/E=;
 b=wQ9Z8dy3HF+VjtknTDa/C4CnkBgn3YU6i3PDR4EyQLi8JRAfpuAylm3YDe/p1bpyDl
 3TdSdPMwZWxwXeP43qzN27OF7jqvQvK0hl02UceasSFZdISsV7G1kz1O3bO4o4BzCjjA
 gRyR6z1of2KHBY6yLnoek5ogqD47GnDh8baJCPZlmbMYOJvU0zuDl/wWsmyq2+sIGHKm
 c7uIYLmV9lmTPQDQDgri37e5rPPWztDTwgDRVzV/mMYOLiaZ+CBjO52mAp53WHqia4FN
 04Ez2z/1bwTVX3Vo3b4+FRPYKScwVmXVO/GvPIF3Tqa8ff/2104C65R4nVjIStrq5Mq0
 RqXQ==
X-Gm-Message-State: AOJu0Yxt+LF3k/9sJNhNL6kSllGN9XMesDudVCYr/LWbMxsXKmyR2eOG
 nxCbJDifv1+/29Uq9mwBHNIm1ClaZItIzipj3FK3uZPKXFiugn4oZGWIjJASZOrdkq4F/mapyKh
 +
X-Gm-Gg: ASbGncvdiDoKt0wfkmu0fncrxv6vleUYnmiFHYJte2EZJFF2GWzke7pB6m2eUHr/6J9
 lzfynyOPryjS2Hz20IJs6fhAuAdmmyBTfnaYSBQHTNb4GhBT2wxe24rFmmV/+MM6aKu9KbGVzvY
 gS3bx5/WJIbpMcsqGYaMCp1VBhg9a0XHzIZfgulmtW75X4zz/PMLQO1QbIKOHaKy6X2pPxRpI1S
 le91rnrPeHznXnhVfdaD5vV8RTryrdU7pb9mrHwxayf1huT+gk61H5m79KI2pDElIE1r/AwsmS/
 /5Lzmk6j61ZNS7TcUKpK6R/TG8AJN4tRG/9b5RR27EkC7M2gcbd0yfnyx+Mf/4kNogEMNMLfSnE
 =
X-Google-Smtp-Source: AGHT+IEsErDdrQqCpAKjjOTgLSrd/TzrB4AbtXckHXNwEIj6jRz2OsksZELbGXej0kW67Ro7jloxjg==
X-Received: by 2002:a05:6a00:4c89:b0:736:ab21:6f37 with SMTP id
 d2e1a72fcca58-73c1f78cd31mr957221b3a.0.1744745767117; 
 Tue, 15 Apr 2025 12:36:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 132/163] target/tricore: Use tcg_gen_addcio_i32 for
 gen_addc_CC
Date: Tue, 15 Apr 2025 12:24:43 -0700
Message-ID: <20250415192515.232910-133-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.160.52;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-f52.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5ae685cc5b..2036ac2cd6 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -1345,15 +1345,11 @@ static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
 
 static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
-    TCGv carry = tcg_temp_new_i32();
-    TCGv t0    = tcg_temp_new_i32();
+    TCGv t0     = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, 0);
-    tcg_gen_setcondi_tl(TCG_COND_NE, carry, cpu_PSW_C, 0);
     /* Addition, carry and set C/V/SV bits */
-    tcg_gen_add2_i32(result, cpu_PSW_C, r1, t0, carry, t0);
-    tcg_gen_add2_i32(result, cpu_PSW_C, result, cpu_PSW_C, r2, t0);
+    tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
     /* calc V bit */
     tcg_gen_xor_tl(cpu_PSW_V, result, r1);
     tcg_gen_xor_tl(t0, r1, r2);
-- 
2.43.0


