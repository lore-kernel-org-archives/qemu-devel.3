Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC50C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnwt-0004Xw-4v; Sun, 16 Feb 2025 18:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwY-00047n-E3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:00 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwW-0006RJ-JL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:58 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0e1so1624203a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748052; x=1740352852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLVTPuIhKyJGLJg0g4g6O/eA+lFZMtglqXcxP7e68KA=;
 b=JhOAcLoTyqIoaY8E+zqee64OM5yfdPD+zG8/cXatNVh0JBiEXi/M4t0o8yIE83qg9N
 Jx8PIEBF3mPJQ+XgfSkyFKMA8SCu2utNJtLRM0diqej6I91NrBkMtzyS8dWvtWsnPNbH
 s2PSnRiw7dHD6SftSVEQ65mxq59D0wxi0qJceFC7tJIiNmv11PHGKmwifV80IrqWSKTP
 CM3270BEFh0tFggiDkX2bamvTRm3f8W6EBI21EOsTBVmHohFVd/SkEvLe7kzO8B+xi0R
 WCpUgIh631HwzRsnARK30lgM/BYggW+uq3AXcal9JAb9pwNJuhViSU+mm8eX7ZpcjzoE
 hfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748052; x=1740352852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLVTPuIhKyJGLJg0g4g6O/eA+lFZMtglqXcxP7e68KA=;
 b=OJXBl/J6+ZoP9PaBDJH7lLr8egh1c7UD7oC4a1IAKGJQKodEPVRwLTLubHPzKDtJ1H
 2g4HyCbAsr6LSWVMgT+Y52SDCVPBHA7Qa1183TVJke0CUf5WfF8KTqi9qpjuhbATBgbX
 sbBrtOEh7xRVttnIZDAmhB53ypyODa+/7u41yyI7bjbWE/8DHmtVyj0RN8coCo1XXC3G
 rcPe3klIxHcx8HzfhyOy/HTmlzoAdoRZXcCWxfX+KDhcm8DaqLA+LFio/2+3D3jH+Mui
 iHWdbYsLn01U/JxMd6uhOc9un9EZVMpT1jlIAGNpXeEhm7qE1SB9ASUQ1wRQoPq7EKKL
 U7Zg==
X-Gm-Message-State: AOJu0YyUOHsa1gVgB395o6h6hE9UI83lWXcKvJtNAH0uFmulWcdgMncv
 x5C8BR8G22OZvP3m7z/ny/zeX9OMk8qjAjHQZxJFUA1PO0lG/22y+IJFArLAxG8xJVcG1NKsoJj
 3
X-Gm-Gg: ASbGncsvnr3bop0PvuU8GNbeurafr76gRdFqPKCesG1K2VURKVcfk+HH76P94W9kPeT
 h6jz2vngWIVP3q3ipkd2gw2hUJEHURTp0qx24Uu5NHJODEhgTF2tTnsawCjfCtgE7kLbpPDR2jr
 37dU5XDwo3Bs+TnUToM9FqRM9jdQeOfIRG3XhJIkrQN6Ay+Cxakg+bL92K3B9QKQFOYFRLcQBkW
 ydVGR7s1uRnhEysFggec2F+5CP1Wc64z1mx4MKrmbTbOhj5WkquWR8R7DWByhMwr8cOOPHZa796
 BDRtRjatJ9N5dIQkBmBsyjdsYcrByGyHwKR1aHL38/DecYM=
X-Google-Smtp-Source: AGHT+IGAbmnVf8dAoLV4bPP7COwBb5crB1kbtScK22fhgt0OD30yKSA0m+5tYxXzlYGh3L0wDnbTTA==
X-Received: by 2002:a17:90b:35d2:b0:2fa:2252:f436 with SMTP id
 98e67ed59e1d1-2fc406eb815mr11534421a91.3.1739748052338; 
 Sun, 16 Feb 2025 15:20:52 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 129/162] target/sh4: Use tcg_gen_addcio_i32 for addc
Date: Sun, 16 Feb 2025 15:09:38 -0800
Message-ID: <20250216231012.2808572-130-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 target/sh4/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 2ef48b1d17..e8029c0c7a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -694,14 +694,8 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_add_i32(REG(B11_8), REG(B11_8), REG(B7_4));
         return;
     case 0x300e: /* addc Rm,Rn */
-        {
-            TCGv t0, t1;
-            t0 = tcg_constant_tl(0);
-            t1 = tcg_temp_new();
-            tcg_gen_add2_i32(t1, cpu_sr_t, cpu_sr_t, t0, REG(B7_4), t0);
-            tcg_gen_add2_i32(REG(B11_8), cpu_sr_t,
-                             REG(B11_8), t0, t1, cpu_sr_t);
-        }
+        tcg_gen_addcio_i32(REG(B11_8), cpu_sr_t,
+                           REG(B11_8), REG(B7_4), cpu_sr_t);
         return;
     case 0x300f: /* addv Rm,Rn */
         {
-- 
2.43.0


