Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FBCC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrmy-0004lv-8T; Mon, 19 May 2025 00:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrml-0004kE-WF
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmk-00047Q-8J
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2322dc5c989so4517725ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627648; x=1748232448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6w4QEmVsDfk2xWldFPm61oyaPQk8pJz+xLAC04XqHF8=;
 b=ZNiOe/vJoQUVqe4d7D3XehD//F+ET21cVFlWcm+05Rc6AZv16zhaYkEBKbN5xisSwZ
 rZhOYlD8Rt1hWW5e+w3L3vEHqS6Q+ezDFDe/qdFR5aNqPVWmwos4x+Co6xLZxFNWLU78
 01Xr/oUEw4YrflR6nCnmecqC0cY9M7SKwxRBDjUFfmx0y40/wPlLCXAOoZXw8TebNtI0
 rb/j+HQ3THTi96OhHm3SC5oTR7oMSJLqmgFfXEtRHdvJg16frzP5EN3B06ivqB0JYB94
 fLxvufMKxY5GkdRCo4KNLPHGxdEJVrJm9Z9H+sGnT/Lq2/zGjah+oxE5hZMHcQdXJgaJ
 dJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627648; x=1748232448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6w4QEmVsDfk2xWldFPm61oyaPQk8pJz+xLAC04XqHF8=;
 b=lbXvthsAg/2npZVoV82MWnRGS+uXUfzOqenEklDNsVxMJXzapBQkQDkzSvS7+SLSiH
 UNYWGa1fWvBwiSl+84i8nTM7TPBj2MfmBpxWD8fOFcoHpB9zpghWO7apRAPe7yCqw0uD
 ovF5rI98oZm0H4t1yZ+cfzuhq21BFo4h6feJR9/dh8g/t6wchvWxvlzbGF6GAQzMEst8
 ht3HjtIPHbBnBwqTE64C7cPKNwjfKt/k8+ZS05wyFFoPX4Rf+WSuw/yV/wQK98Xn+VcD
 JmQyEFFKHJ4A+39qDWlrE60qBN5FEKFuJQMiMafqIa0nQVQSsBS04FVz5CAVgdljqSVv
 BfTA==
X-Gm-Message-State: AOJu0YzJ/U3PbrZJRrekpbGoyKrJhPx72IF4wpOayDJm1NVzQic7XHJ4
 DHy1hycZSwOR5DofbUKSWWzdydHdNh25Z1GLLNI/b1OEk10nyfyJCtvj9GofLg==
X-Gm-Gg: ASbGncuwlhwk0ibLkLSQaUQkw/g/2T/zVluTrGy0o/fNiCFM36qss40RQDzfRiYVJ/N
 yyy+3GOa6AAv5CBPlKeJusF+6f/y7vIjjZ33tRw9XejsySxry5YJ4Gsm6xlOmDw1tQCtZRmjCbK
 VpQps4evc2kyAe7DqOsjjpLCoMiqrsxCZTq4YDfdd27EkooWHRCRuYlwBMaWvCYTvQW/HtanW1B
 EVuqhKmQIR2/Bm9VOghu0eiWMkZIGd5EXwhpjexZVWe7L4tkXQx9ProEvBAoy2zpsMPq8IWeFz0
 30OMZZC2E7orvL09v1n+elany3CkB1s37VSBIIo84sSimCI2PEOU20Bvv6yr7XxAl7ErFHuHG7C
 bhd5a6c4YhocKm+7jvU9KRXjE9t5016kB8dVB0TLTVCjevFFNTjxI0LCU
X-Google-Smtp-Source: AGHT+IG6g54EThRXihL1Hlm2HbvKSN1wl9sH9ce7T6nz+Y3ubn0Hg+N6UXbFqH2NQKjCFsmZLb/SiQ==
X-Received: by 2002:a17:903:1a68:b0:22f:c568:e691 with SMTP id
 d9443c01a7336-231de3149ddmr162049745ad.21.1747627647995; 
 Sun, 18 May 2025 21:07:27 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 07/56] target/riscv: pmp: remove redundant check in
 pmp_is_locked
Date: Mon, 19 May 2025 14:05:04 +1000
Message-ID: <20250519040555.3797167-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Loïc Lefort <loic@rivosinc.com>

Remove useless check in pmp_is_locked, the function will return 0 in either
case.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-6-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 4070e21ea3..5af295e410 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -59,11 +59,6 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
         return 1;
     }
 
-    /* Top PMP has no 'next' to check */
-    if ((pmp_index + 1u) >= MAX_RISCV_PMPS) {
-        return 0;
-    }
-
     return 0;
 }
 
-- 
2.49.0


