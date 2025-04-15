Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12F0C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mB0-0007sF-HJ; Tue, 15 Apr 2025 15:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1v-0003f9-Ek
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:33:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1f-0002vh-4s
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:33:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso69134265ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745566; x=1745350366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1RvvgZaKuSF9edcsX84Gnnmj3wiiQW6WmhJ/O+pUWs0=;
 b=nVgUJRIB+GIOxsJIoZ8jTWvCLQjDZV5utUNFwt8XBM+ZPwJlDNNQAJfHHXDbAGS9QS
 RseVfH8qfPX3ysvkImn01wGklJh+p0XfovCcxoG6iATv4ezQGnP5JmSNINrp6uLXiNsN
 cr6crS35SjZD4ysjzQU5qfmFdEbzSzqWZ2BsGUhcuA1SM4SOca81CkRXj9RP5Yo7VbNN
 uypBO3dMnQjLQEABqWT2dU4iWxXzmC8X7ZZLcfDLczSSFmN0ZUtbeu2n/TRAMiAVtLKq
 VAhrXnjmYA56LK1qyYvI/eFsOX1ay/DNeknc4DvK9WYSf0/ojRrTM8wJRwExNS1mbs26
 z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745566; x=1745350366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RvvgZaKuSF9edcsX84Gnnmj3wiiQW6WmhJ/O+pUWs0=;
 b=MjFcQAub/4vrS4cU8lkOHa2qXqwp+qGHFHXEwuPCiNeB2j25ICnrtquPrXpI6IZmKN
 U2sJdRIe0RLWhIEvLYMlZIEDFA8cmONUzYvIWqXbU8b1xxs0I+FhJv3VKXuWaxIV3FO0
 TJsvhyKrFRJfswrEvz4eTP0PUca31nCHj/d5IaESgWpEUx9NtNTD46mo4ParjvxyZWlJ
 yOuSj71zysFX6BfckgmOpRh6z/2c9S7we94Z6zGLRL9nfzHxpvUozELmi/8b3temt1DU
 1CRQzw2zLd7DJu/pUrJ2b0mOkzwwA0d8vitZvQav4B7ETxeqDfCvN+LVYuhJS2BD9IVC
 pdcQ==
X-Gm-Message-State: AOJu0Yy2xp/DzPzGnH8o+xzK0gAXG/ziPdoao/0m0+SK55ZWG+1aK5rW
 GNHbBX5syXio+QFOsQ0BoL9+Kx58Ql/0Dyxx8SogyWklLoJedgN0JuMDQRNTozPVbBJCzPndLq7
 d
X-Gm-Gg: ASbGnctaGs4JNxsz+qrEWp68OBSPeb+I4+DvoLY5hnknZqH9wvg6j9jpH35iyM0g1/x
 BkHCD7a4mV5W4QGsR+/RnfemTgUWAmL/OPjZM9rJW8U4I57Cu8OwxY/V1+vpzoVrSzzUtw/wZr+
 ZBy9a5u1QUJkunoUOWwRy7QQ4/O5a1EspdZEOgMrRZ/XzhLIjKX+h+w8NpOYEzB9/GQgj9JZUYj
 92QpKIJKdFMRPE/ZXbHPaBXn+YRHDz9vTVzh1PzJ3VIAx77/75OE0SR93DIRROY7zqNMptYUjUg
 OKW53HjuB8Wcc+UmCllL2I57R1c/zPyN4r1Q9U/CjQutw3+LAJmOhaWP0zyM1Ay6bdBcX3xRORk
 =
X-Google-Smtp-Source: AGHT+IEi3Wok0RG0jRjcs94RYigTHnZqxeX5w7cQc/GQPua+1WCImhGGiPfoV+HUIcXytY0Dfzuf+A==
X-Received: by 2002:a17:903:985:b0:220:c066:94eb with SMTP id
 d9443c01a7336-22c319fd8e3mr7212835ad.25.1744745566119; 
 Tue, 15 Apr 2025 12:32:46 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 106/163] tcg: Expand fallback add2 with 32-bit operations
Date: Tue, 15 Apr 2025 12:24:17 -0700
Message-ID: <20250415192515.232910-107-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

No need to expand to i64 to perform the add.
This may smaller on a loongarch64 host, e.g.

	bstrpick_d  r28, r27, 31, 0
	bstrpick_d  r29, r24, 31, 0
	add_d       r28, r28, r29
	addi_w      r29, r28, 0
	srai_d      r28, r28, 32
  ---
	add_w       r28, r27, r24
	sltu        r29, r28, r24

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index edbb214f7c..8b1356c526 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1105,14 +1105,15 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_add_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_add_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add_i32(rh, ah, bh);
+        tcg_gen_add_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


