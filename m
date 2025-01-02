Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1EAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPkC-0008PW-Se; Thu, 02 Jan 2025 13:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPjt-0007Pl-TW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:16:12 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPjq-0006sf-Tj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:16:09 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2164b662090so138896465ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841764; x=1736446564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsTQ0M7Ew3tLGi+O218NnOIxDCbwYi5kOq0GHTv2YVY=;
 b=BXQNJYynvo6h6+z+zdfb4l87+Ee1AMdusC4vZDA4uwWAw/+rXRG+4aGUjtkdQwdClV
 VumDCWugl/5fayzw0h7QeAA8IR1KrtM0HBBL3akDJmavuOk9ilj5mnmsqewLPXSnr6sB
 +E71U77xfE/YJ0Hy/F0f+h/EyoQP9hyNW6pNsTU70XFxh3kzPswylhoQ2WNdgS4a1q/6
 4YxgNTafrDV2QXbX8GpD/uW1lxyaO6NnBoeV99UFavs30PsKxNeM0KhLhudkfWxeM7Dc
 oXypQQQ3Jx1Mn3752qKlnWuc8qcyl7/TIJXs2p4K618hh6yeFXqmKUC3ti6bHFKArHEb
 ITew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841764; x=1736446564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsTQ0M7Ew3tLGi+O218NnOIxDCbwYi5kOq0GHTv2YVY=;
 b=c89K9YgU5sM0zf4lee3H9kw4X8kJEM60xKn7nsfbQ9m4fBwo1OluugbFOqvYrlOGmL
 sW3pBvFWVAX8ajbBahMabdqv0w0UcNq0s61AID/6/4gBG6ViYHLKkoNlEaIEh5uPGSTJ
 oaEGv9uozfsA3NvvBqAOnwBHhVJkM1CH3n+S4Tq2/fJ+Sur/69iqxNzeP0fBSBspmeYh
 q6qhLjkGQEPdXMvGTkQQTmkkY4K5wk3+lzc3bQgad1v8eHi7e/QVYXX0Zky/mNMjl1Ht
 VaBjzn6Z6X1L2FIr+6TrSVmrJWg6U0owQxxwv1DmdWPHWtvt4lQCYMF2yIB7zPoW0lLr
 y4vw==
X-Gm-Message-State: AOJu0Yw3HF8lYw1CAgFtVtLXHOBZUGb7+Lh/HJc1Ubxe7bCizKQdCGG2
 BEv0qGPv39D/ZDqenTbby5U8jSWt36cj5iNPDGAdQJZVgp/FeLZbUSHEVw6m6HEiYJkxlHdg3Qn
 a
X-Gm-Gg: ASbGncvcRouBv7GfVHpKhm8Gq/pXECW0izldaWTjS/dgzRgVTPdc3SXsjXm5n3btri3
 bE1Qk0ppuI2tuJ9ssGYUz4b2VSBLJu4h75J1Xy+yC+pvpPzDcXskeSXYXMbz/3gK6fgsJFVsgMf
 5QlDYrZYtg7loCog4i/hz0JZvH+rbzdNFfJW0J33kylplCixJObjCdSufmOV/e9tx87R/kwzmY8
 QlL7pTUZE4N2esoRgE2EmMwFDBdZN8AleS5+Q0HRTZdyz9jFmRZAE1EdpgUoA==
X-Google-Smtp-Source: AGHT+IHB9y3/tACCwbOijgfWnUwLDPrz+f6EZINXD++wYeTpdbP3tNqLvdvV7WHTo78M6yIWuy1HYg==
X-Received: by 2002:a17:902:e945:b0:215:4a4e:9262 with SMTP id
 d9443c01a7336-219e6e8c58amr708525275ad.8.1735841764530; 
 Thu, 02 Jan 2025 10:16:04 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f68e4sm230148315ad.211.2025.01.02.10.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:16:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	palmer@dabbelt.com,
	Alistair.Francis@wdc.com
Subject: [PATCH 2/2] tcg/riscv: Use BEXTI for single-bit extractions
Date: Thu,  2 Jan 2025 10:16:01 -0800
Message-ID: <20250102181601.1421059-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102181601.1421059-1-richard.henderson@linaro.org>
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h |  8 +++++++-
 tcg/riscv/tcg-target.c.inc | 13 +++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 10e61edc45..ea38ee5cbb 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -64,7 +64,13 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
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
index 12c3cffcc0..83ec7cd980 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -162,6 +162,7 @@ typedef enum {
     OPC_ANDI = 0x7013,
     OPC_AUIPC = 0x17,
     OPC_BEQ = 0x63,
+    OPC_BEXTI = 0x48005013,
     OPC_BGE = 0x5063,
     OPC_BGEU = 0x7063,
     OPC_BLT = 0x4063,
@@ -2307,9 +2308,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             } else {
                 tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
             }
-        } else if (a2 == 0 && args[3] == 16) {
+            break;
+        }
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


