Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8680AC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr69-0007rj-L3; Fri, 17 Jan 2025 13:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5o-00063i-3M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:16 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5l-0000KO-HP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:15 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so4449007a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138552; x=1737743352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crcvNbjkly9KMWSjp1gKNNJHKJypn6AEpvxWtvO08G0=;
 b=imTuE0jfSTcBSVkl2So3TvmA8VJJtwYN0TVwv9FcJpnqyTi2ElD/tbTjenin84aCTY
 opYcamu9HphkRStRzknwd3xYnuqOF092EFKMwXBKJKQZKmzu4F4h5hfOnOU4Tb4dg/9g
 X0VFBriayBzNyzyETDmI5VGErHLTlxwzCKEZsyMmzzwtccGNUa8aCZcA0SvdzE5Azhmm
 ktoLzSY5KLuGbUFPBjyL5cuPj6J3d8VuTRd8P7TWAgrDHSkwY1Ztw3HRgaJUh8QZ5icB
 K26fWZYnAR1cMCZ/s8pYfupUMIMvMFR7wyHN/1YQoPb54omqQzxCH09MhHBnfn6Bt4h2
 mIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138552; x=1737743352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crcvNbjkly9KMWSjp1gKNNJHKJypn6AEpvxWtvO08G0=;
 b=mDqrVllPtWnuusXIE5i6Fqy0rrufSu6KL/Sv4kaWRfPe6/5WSHmyPwAMkPkuQBHBga
 NprTGWi9460iB0ItkNfqN7Ubir9koP7ZyaNLf22yDXJkkzYxDvkjP0hCpI6qDe0ZqmKB
 KTBLo9zUiWUVgvGMuduk9NGlvYfGTvpHnQkYIRxkxfGhRLMIY/CkFGFlNpgbNe4ElSNi
 hOvGxSRax9iau0JwjpF/8qDVv0URmhOgjPcqbkJ9VEYVn6nEnjgRSgf1QbRUi2odmyLP
 y7vL3o7BAnrlI6wyldLS2UCzs9BWOEClcIbBJjzC7vtLqUPaUUA+6NsSO8wqx5zGHf2f
 bUxw==
X-Gm-Message-State: AOJu0YzycEMp4ntmpsLVI0AUVhxep4HVyL1P5kezAeSH7reyi84+57F9
 WtCTOGVHb1bdf62L61ibUlQhPO9VSyeN2adbwedgCQo3D9q/lcYzum2lvvwPS8xh6QTTah3yCQK
 i
X-Gm-Gg: ASbGncu3ZMwSQAHPIp/uqBoILLgHm/z5UZEBWhV/5T9wgIhh/mSidaBgnjTPi5lElno
 ejKirFILFKyNwqzPJ5A9D+2+jeLcn7upfA16ByafuhabcE8QZrZaZbt2UUrBHUsI6ULvQDIcPum
 PoysxDSkeHAIKal68J7Q+n9XyJeLr4gkLD4qXPzPwAE+tAto4JE9+O8vLxm25JYLkU0Oh1lhaoz
 dy/7VhQaKDAqkWq401nvt1hvnq/HIy9G+mtMs4vt0ijjx3SStMzpuV89nkYPVbSABFdejUQ0+lR
 RshvX0VqRKUYKJc=
X-Google-Smtp-Source: AGHT+IGobSc1ogc729M22yYSxIeTzfplDAGRynHNJEk6wuxICMHszzpfCIPEutwWdkMkhE3ynvg5JA==
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id
 98e67ed59e1d1-2f782cbfa4cmr5914747a91.17.1737138551986; 
 Fri, 17 Jan 2025 10:29:11 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 64/68] tcg/riscv: Use BEXTI for single-bit extractions
Date: Fri, 17 Jan 2025 10:24:52 -0800
Message-ID: <20250117182456.2077110-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250102181601.1421059-3-richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h |  8 +++++++-
 tcg/riscv/tcg-target.c.inc | 11 +++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 0f9cc04f8c..f35f9b31f5 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -110,7 +110,13 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
         /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
         return ofs || (cpuinfo & CPUINFO_ZBA);
     }
-    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
+    switch (len) {
+    case 1:
+        return (cpuinfo & CPUINFO_ZBS) && ofs != 0;
+    case 16:
+        return (cpuinfo & CPUINFO_ZBB) && ofs == 0;
+    }
+    return false;
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4f6e18f59e..61dc310c1a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -163,6 +163,7 @@ typedef enum {
     OPC_ANDI = 0x7013,
     OPC_AUIPC = 0x17,
     OPC_BEQ = 0x63,
+    OPC_BEXTI = 0x48005013,
     OPC_BGE = 0x5063,
     OPC_BGEU = 0x7063,
     OPC_BLT = 0x4063,
@@ -2354,9 +2355,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         /* FALLTHRU */
     case INDEX_op_extract_i32:
-        if (a2 == 0 && args[3] == 16) {
+        switch (args[3]) {
+        case 1:
+            tcg_out_opc_imm(s, OPC_BEXTI, a0, a1, a2);
+            break;
+        case 16:
+            tcg_debug_assert(a2 == 0);
             tcg_out_ext16u(s, a0, a1);
-        } else {
+            break;
+        default:
             g_assert_not_reached();
         }
         break;
-- 
2.43.0


