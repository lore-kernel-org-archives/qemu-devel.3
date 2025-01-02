Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2863FE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbd-00076e-Vw; Thu, 02 Jan 2025 13:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbQ-000719-RF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-0005Bt-09
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so183414215ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841241; x=1736446041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l1vM2+C8Gayc85qHxxKp4nx71yi2z/biOUEU3UHw8H0=;
 b=lD+FVm9U729ZPAJ1CVOQnw/Ue+ZdtFXuA4Ck73uNyt8HgHKNLldeetcnba3pWTjcHj
 WvJrbFme2mYvYM6SZHh0fklmXjCqxRsRP8UGD5yRDU8Ylsl63iJDYp5QgM/PtDbjuFxz
 dlPLX059xvy19B9IhXWguv0VYsckZ4HimtgbhOW2UO9Ix1GWorrl4adW3saLhIsM4mQK
 kVTqIng4jX1bChGgsDp6rMaM3+oAu71FlH3nAY7hvjfabQf/FYb33lpUt/WYChznQ2Yp
 LMzUfxF1OLNcAinBPRKVGxYWp2lNkoSKeWvQida+v1HsNpx9jUi5QSZ75+0DM1y/1IzX
 5YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841241; x=1736446041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1vM2+C8Gayc85qHxxKp4nx71yi2z/biOUEU3UHw8H0=;
 b=PtMaHImFdgbmRe63zGEyB/iysxMSEzJ4nOVDSYZdufQXeeX7NLurn6AoTI9L+0iMJt
 VaLdw4Ntc9Qg0ecy0G87HNrzEBgYv4EFc018ZQcXxdQHTk4SUf/Dzt5VnvviCCKuzF0T
 Hll28rDx1gWCrd6RP+9RI1TH2h5Wcth4ScgrFZYjpcfmSD+oS1L88qG4gco+f9C14vNK
 fcF/i7TqG5tDEKt5LUk02gEtUUZQwu9TS4kWDvD/SJuZ9elYl24LMs2KB+iBPJMWxf3G
 ZY5NLtqMA/a7VRnmXSqFQYv6w9aX33maRmuLMtxUXityuliaTtzZyTpt5ZCoITSpwi3k
 dHhg==
X-Gm-Message-State: AOJu0Yz03y/KbggAW50H2z0x+VJBS4xhblToY3dAyCigU05ZBM9a1Q/5
 J/8O2LixdbvkWe/cYkQDhmwe77Y5FLYhFVbG2HUFWreekj/FyLnxGvOJxB2DFGeqtX98uCRK02j
 y
X-Gm-Gg: ASbGncv5GRYxwvp9DIiLLn1PPjxChb7RJen/T/av2zrWpwBdCvO8Uh8ch90xc1AFQ9X
 Av3AIEuj/eRlq7UDNIKl2HWh6rMeZbKSq2wQ7OaiOjbidNFPJEd7mOqL6LWfV9SUD5r4YV0HdgR
 4jf2lcHMWM+V1XFpmn8Q6i3+HccJNHQLocGKqrSn4Ry18ANh3aqA+bssseEFJQBsw6mSJptZIF3
 3ma83v2kkBbUN6MQSmyYgBJLlVbLL2/9ubB8Lc/MHYuI98+UqnAtOt5VjUpIA==
X-Google-Smtp-Source: AGHT+IE2fZoqIiIoT8mdpprdeIDAUq5fgVSkumFxlvZonBxHOkAQBc+xAnIrOpuyi2yIubmaG3c36Q==
X-Received: by 2002:a05:6a00:35ce:b0:725:eb85:f7ef with SMTP id
 d2e1a72fcca58-72abddcaf2fmr64927945b3a.14.1735841241066; 
 Thu, 02 Jan 2025 10:07:21 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/73] tcg/aarch64: Expand extract with offset 0 with andi
Date: Thu,  2 Jan 2025 10:06:13 -0800
Message-ID: <20250102180654.1420056-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

We're about to change canonicalization of masks as extract
instead of and.  Retain the andi expansion here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d77d305f30..828897ccd8 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2454,7 +2454,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_extract_i64:
     case INDEX_op_extract_i32:
-        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0) {
+            uint64_t mask = MAKE_64BIT_MASK(0, args[3]);
+            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, mask);
+        } else {
+            tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        }
         break;
 
     case INDEX_op_sextract_i64:
-- 
2.43.0


