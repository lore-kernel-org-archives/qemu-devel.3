Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDD5C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV2-0008AH-L7; Wed, 12 Aug 2026 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUn-0007cR-RO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:26 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUj-00019f-OY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:25 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so970697a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573940; x=1787178740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHer8DIe6wEvvzLdcgpQas8ESpr5nQRoXPSRUKFQ12s=;
 b=VwsgDUVLl7zYTXW/35qlWkW0Frky7E+j0+LD+PbtL9UBI8kaaE1pO9E9foUNpfudB8
 UyrSuNnwHSCKyLRpV8lk5owWRGAxQTwHPlloIQpr+1KceJGrLznIevI0wmm0dIA33ZVB
 dUUNXT9fu62v3XkV5O6K7jRNFlE9qUGUA4zf5akOJQeOj6fwz8ZEaR87rRt/loimC1YZ
 WUUUMH/WbYMmCmLxkL1kfSANTAI9oRoKBijhTp02BR21KZdwpClAY8TzpkepbXnpf0gb
 +3gOVw5BomTAaGtjN9bV9o+HZejbYg1+anFQ+iYgA1ANuLFHRDv8YHjvGckk76iQAnqp
 HmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573940; x=1787178740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BHer8DIe6wEvvzLdcgpQas8ESpr5nQRoXPSRUKFQ12s=;
 b=GHQjjAWA7BgjlT7HsUSJg+mhLiFZF82i1QshflLo+LcX6AlACVfIjy6XL14UVUvO3D
 F4dMpmwA1gQ2ynVY9kk7EGT2XGi59tE2nSWbbasQ1Au8cPCWSXrdEds8op0wNdk3Ov/m
 YCz2JoZvL6eEzNVWwjVzrCQr8poCGSpNh8kr+75wX6Q5PjTdDnB346HCB2i+HQD6otp2
 Rk7OFDr48HzRSSWOhRDpz+eVtB6EVMISQhedvnfyJG3YmMEt/YDL1bgSi/HkdYIIb0V8
 pjlG2Yb2IvcEgFL7+YWagQI6mw3yutvjUKQQqjSNJPaebdu/7oJzeidCRmtdGVPP45h1
 RjMA==
X-Gm-Message-State: AOJu0YzVj4Xkc6QFk/vpVQdFfb9wB0wx4pBGWuk+mMoTWy1juciQ2+Yr
 A7+hAdLLDVd1BC95Lndopo+ssPVSSGuVcuoCkOB7WbtpGfx/uGb/ZmRn4EYZdDtm2AFsIMt+fUs
 jX4+L
X-Gm-Gg: AR+sD13ySfqF2xitGzhAOaUPoo7lN2ha/WkGCiajSq9CqZnEYpNbPHdoouAjTRoJO53
 o0fhG+sxMtUPzC53ABN8jX4U2iLy95gCGlm6dNLhb8hvncl68JhiPHZ111I8J7KXs1XhbW/kzM1
 mwjnoqITIcaoLZeg2wiEzTubxoXmaB6yCOl/QwuBNBG8W9uGTM1qvgiy6+KZLrtoPNdPFhTgSzB
 OJc7FTEe7wW3bOSllQ5sP2/RBAqj3+aWXCE3FGHGBlnl2A8eDynPT2vkPyAG/vwDxLV/YzQonDf
 Bw0PBGgarkDtpN/VE3vJ38aCiODrHxA8KrkI3UAcoHJkhyghxleTF4b5AqF67N71Vzm0h/eLWW6
 agfu0qwIUIGIDrtjkepimzSXjrSvjk1VoQntxHqZ3CVZZ2htylkMJYYFW8Xd5u1O4IgzrjW1D7F
 HIxd3IDkSqjzPbK2ysWOJcylH8NdLe2LtRWPFIGNZwjb+LYqfKDPVqARPh/CpBnMkqkcHnuJcOy
 Locbs4K5bv3ykBzONpT
X-Received: by 2002:a05:6a21:1bc2:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cc54be42c7mr2221625637.0.1786573940163; 
 Wed, 12 Aug 2026 15:32:20 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 39/52] disas/riscv: Fix isa decoding of rev8
Date: Wed, 12 Aug 2026 15:31:29 -0700
Message-ID: <20260812223142.349142-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

The encoding of rev8 is different for rv32 and rv64.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 5624e7f60a..787340e811 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3292,8 +3292,16 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0b01100: op = rv_op_rori; break;
                 case 0b01101:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0011000: op = rv_op_rev8; break;
-                    case 0b0111000: op = rv_op_rev8; break;
+                    case 0b0011000:
+                        if (isa == rv32) {
+                            op = rv_op_rev8;
+                        }
+                        break;
+                    case 0b0111000:
+                        if (isa == rv64) {
+                            op = rv_op_rev8;
+                        }
+                        break;
                     case 0b0000111: op = rv_op_brev8; break;
                     }
                     break;
-- 
2.43.0


