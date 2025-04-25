Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10065C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 20:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8PDr-0005m5-Ha; Fri, 25 Apr 2025 16:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDo-0005ig-VV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8PDn-0001pv-4P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 16:00:28 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af9925bbeb7so2061123a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745611225; x=1746216025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YuWdvgVMamdX2+8AotKKuDqAxzZpz0/A+gqMy806WWg=;
 b=qqDC8ZhhQ8RbbptA/hsgtovsqQ5UpJ8/At03dBUj/GMFbflRj4p3ReV+HpUFpA9n/F
 xMCDmodquZb1tsPh51WLfzn/dkLje8HKIFCwo/WHqpdieAWUmiVULnNSZxw1N4oB6KAD
 gauGM/SjtiGxqZfo8rhnzUyb5BzxSYoM8yEP7BbU5zizyVExaem4uAyIh8Ynf/VszrW5
 TJIR84lAITtUz0bkmdYzKiinB4wIhBzYpRil/0uR/An38aF2Mae1SaeggdKwULimIObv
 iWC6G/TNNqMyH0M6/UD44Kjqr1WRn8+L1C94zTCyWCYJrOOM1vPjYQYGHUOTjrcX6REC
 KQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745611225; x=1746216025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YuWdvgVMamdX2+8AotKKuDqAxzZpz0/A+gqMy806WWg=;
 b=VgdeaL4+qUvCiM3KsIohoHUDqRe1yw9cyeaX79VxPAGnTOw82hxifIEC3aq4PxPXfs
 BQMq6/pJ//x+GUa1u9etC4SbG/ZV5JROXSATGdrLJvKA2Up8CMkyYRRqZirnTEh8zleb
 2nvY1bNA4MTVijuMkBcSRLYkSjCgplPNUt16QBJP1IGFCleE8oJMaQPgXCAf5PRXB+Na
 698k3Y85nw0/xo4d1o7WKtPVOG1xJ8HiU0Dx8UIncbCCDfT6GyNAnRrB07uvjAMTZwkO
 JqdpHpqnGu54sTFrFeae4R5yWRhg0HJvpUn+qlAC0Gwlrt3FBZ77yw7PNm4xOw4eWwye
 7iNg==
X-Gm-Message-State: AOJu0YxHzCiumPChFr1kCnUsEykh/dM0sIt9EpADHWQYSs7YypfVz75o
 DQUjjxaj+tNi922JgAqNx3qxG3LKWPKIBWuJa7J0a+A/740C8yZQJxmDqdcTRKM8xJrunqZny6e
 E
X-Gm-Gg: ASbGncvF1NtridMewrHvsxC/YWORHD9b6mN8/AdyDiqMcgxSMW+vMyUrOT69DXn3ZPw
 N586di4DI56QgbbucdfULGJRqBZi1y2cakJi5AEVXEBCsuCMgsuOOTnFrZd8i/Y3/y9CQ447Cy4
 kIy1jFaJKj2izERo4eH464EFaG1f8ldKUf5QmrK+gPA2mKt/SjcRqUNDl8be5ad+cgTwVluOdsO
 I0yywliX/jclsDsRShU7q2GsEHGT5/3A4arCprneGqr8ZP9PvHSx9qHKkv5KIKMgBr27SpG6wqG
 ZXF2Uu9SY/YhZWstE8l9gOOAbZWTKE5EfD2rQlNOqzasvAfm2UTfX1F6xQgXW+nl4XiiprSe+Yw
 =
X-Google-Smtp-Source: AGHT+IEBy3iKY/djPyzesJ7vcJJ++UDQFT2h+BFbKI4NrQ+/R2e/Hzp9+kQ7SaAe/WjRrXRrn9nDNQ==
X-Received: by 2002:a05:6a20:6f9c:b0:1ee:e20f:f14e with SMTP id
 adf61e73a8af0-2046a6e0b54mr767073637.38.1745611225149; 
 Fri, 25 Apr 2025 13:00:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7702f70sm3315981a12.10.2025.04.25.13.00.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 13:00:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg/sparc64: Implement CTPOP
Date: Fri, 25 Apr 2025 13:00:22 -0700
Message-ID: <20250425200024.853260-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Based-on: 20250415192515.232910-1-richard.henderson@linaro.org
("[PATCH v4 000/163] tcg: Convert to TCGOutOp structures")

The POPC instruction is present in all but the earliest sparc64 cpus.
Not sure why this got missed once upon a time...


r~

Richard Henderson (2):
  tcg/sparc64: Unexport use_vis3_instructions
  tcg/sparc64: Implement CTPOP

 tcg/sparc64/tcg-target-has.h |  6 ------
 tcg/sparc64/tcg-target.c.inc | 33 ++++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.43.0


