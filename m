Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6895EC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPios-0004CO-HH; Thu, 12 Jun 2025 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uPiol-0004Bl-ER
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:22:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uPioi-0006dn-SW
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:22:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso671787f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1749738126; x=1750342926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIslzKkq6UesHTFMA7LpkyF3JPhLf32EhGcnJsfnIR0=;
 b=FttJj6GWOB5DeALhCdg7fIlybypiZ1qvB1WVsgTBRe6Z7yvVwXm3y7x1zDSO1uPCm7
 1pAKqBMb0B019eFRljEXl35eXcOGBSjffOL73oAtstoJGR7Dr0oHulbkA3J1lCYNm4c/
 ewU8ipBdhdHkIjKUVOhQwO0PfJXWpCYC/ooUWE2c/7nA2efawzDudwO26ff1S9YvoRkM
 H2brYD+wZTUljyGKFkeoF/LmQdATTC4Cj8oqqsyvx4Xhnqx8wbuMXKia0/RSTPI3WZ2r
 IV/06Mx0eH4A337OJZiwL00lGaPrmhTxpi4uBpyzjZZnxYv+qxYZ2r+ot3UOEBjIvw8p
 UFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749738126; x=1750342926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIslzKkq6UesHTFMA7LpkyF3JPhLf32EhGcnJsfnIR0=;
 b=HGMaJpFY+hpTrxCGe27/0E/gYllrGC3u71hKUjreCc5iXPTZciRzQ7NJDpAILf3dBG
 8qwgy+BUNjJG+XBVzuZEqds+V8Zf+7b3Q00XA29gXzYuCuDvXZbaJ6klTaBO2zxmsVjo
 s97X/9TyMhmNX4d8tXw3REYuVvqxXbbYcjG0iwbCZGIct5YyBZDwrJ5/araq5/9xwJyk
 Dm1niPiGydRlj6VU2/mvBOSBn/Iny76/m0U8nGa9csCm4EFfUw6LCFwayl9MQBuKiVEV
 xULMMz7prYp8iqqjyAVysBP34U8vmfhqJ1FGjWtphXoDPmTCcmMX98CxYrbvWAowJ0k0
 cjRQ==
X-Gm-Message-State: AOJu0Yx0FbHBLVBE32hq0ywRniL8KqG3Vcv8FfCEJNMYKlo6CYGbOsbQ
 IUYtJQoQ+0pU+KMFpmM6y3Q7g8oYdo4PYvgLRJviQBxp8AibUHR2LDU6TgBcOHLyGY0=
X-Gm-Gg: ASbGncunlfXt/m7XenclrLwiuUOGaDB+BLr7t9A5dd01SRs7ng5+iRg2p/RCwwBv8gM
 Kc/hnPKp4O6mGF7XIXrm0XdxHMb5yPVIhBU7IP1AdkkL5STy/xDYea29RIMknq593+NN/+npM0i
 jxP3dpOyfEDz7Gq+fwQiWEqpxNao7O2tw0JKKnotVT4HqQjjL4R4gXuDfp44smdGafe+3EhXete
 kcsSfj3gxTgVqMTOI00cOnAw1s3bJEzwqNschc7QEdb4omFrasEnhGzuN6BjsJ8XY8AoOUFxbmq
 dk4Lmisw/gK/GaADNezDa1L3ABtcqIFavKZyFHjIKEM+7dkQbH1nLCNT2Se29U7R7uSrbCkKUZF
 eXFTxxJd1zv24wOrG46RLVVo=
X-Google-Smtp-Source: AGHT+IFr7/M9h/PgtY/H4VqFUSja+Jh4iCKBLO0YPHTRlG2WFVTIw5DsL87jwWdS6BjnlOkPm7mh0g==
X-Received: by 2002:a05:6000:2409:b0:3a5:2cb5:63fa with SMTP id
 ffacd0b85a97d-3a558688b57mr6766249f8f.2.1749738125816; 
 Thu, 12 Jun 2025 07:22:05 -0700 (PDT)
Received: from bell.fritz.box (pd95ed419.dip0.t-ipconnect.de. [217.94.212.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a56198a3b4sm2112498f8f.21.2025.06.12.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:22:05 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] target/i386: Fix CR2 handling for non-canonical addresses
Date: Thu, 12 Jun 2025 16:21:55 +0200
Message-Id: <20250612142155.132175-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.097,
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

Commit 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
accidentally modified CR2 for non-canonical address exceptions while these
should lead to a #GP / #SS instead -- without changing CR2.

Fix that.

A KUT test for this was submitted as [1].

[1] https://lore.kernel.org/kvm/20250612141637.131314-1-minipli@grsecurity.net/

Fixes: 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 target/i386/tcg/system/excp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index c16262158774..5f1023937fa8 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -593,7 +593,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                 if (sext != 0 && sext != -1) {
                     *err = (TranslateFault){
                         .exception_index = EXCP0D_GPF,
-                        .cr2 = addr,
+                        /* non-canonical #GP doesn't change CR2 */
+                        .cr2 = env->cr[2],
                     };
                     return false;
                 }
-- 
2.30.2


