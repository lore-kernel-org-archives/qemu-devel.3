Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285CCC55173
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 16:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqCgN-0006TY-J0; Sat, 01 Aug 2026 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqCgM-0006TA-1H
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 12:35:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wqCgK-000704-1Q
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 12:35:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8485b358552so2284542b3a.2
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785602126; x=1786206926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kPldCZGbcZmVcaN2Dkp+QTsRTaWOwqsDnM4M2w5J35k=;
 b=MYoWXI2rdv/cKxHDsBPQ1enWvPaCgb7Drvpnwxn5pH0VY9AxH4Tw2dxOASjEpuT9lw
 icxA+Z0g+qLyeFzrZbQTXbqchnyJDphkznz/Tr89XnNGIcmj58kDd4ufwEK6Oji6ga8A
 +E3QUqj3ADjrFyojoslpQSUaq7051Q9nRD0OE5nm2kFmfKpTGTmZ0vLqG78mDkTSmSFh
 ftPOlxEc1etEa6YjOsRBkl5waYhspYPhzUobB/EsbiVCLKzAbBB7hA8G5HGhgwk8q/CN
 ODgVGz+BLbTDcCL6QTNR57ae0/HqwyxlxcHt63ZyaLv/INaFmtxilIsBv8ks+oUWMMNu
 XQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602126; x=1786206926;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPldCZGbcZmVcaN2Dkp+QTsRTaWOwqsDnM4M2w5J35k=;
 b=Ulpf3owL8O1TXc7CBRW2PaUDFxn5AIC/6ceXG1pwlUqJrcex7Rn6A5cjiMwQfLbAX4
 SSGrd9BKmABkEKZY2hNZyXBW8O5Jq5+WyIh2YO/c1t8neJWiliZAGJgvUtdDdURXdjol
 kmvCzy8CVjszT8Rgorm7sP/2l7UAN11V57pNsXsjttW8wySWglq6QqbpM+x+kockIp5W
 Cr77Is6qEb07K/4/c0YxyE6+4IrX2jD5r7VGXenBdfxtRC8bXJZuLS9atQ+6aOOyU5mi
 ZYqR60FniDwV07qrlKWfkn3jIpL9o0N6VZXUZm4ZKBdz08AlExIsKtHdUYQSk4bUNBp0
 dPjg==
X-Gm-Message-State: AOJu0YyfgWGGyXxIM7WDX39XQTcz7CIBiSRBxceoZkIvl2t6D9kFuVMB
 LDV22we3A0ZHBBPLqstonp4pM61AeCM6032x5t44LPu9VrXT1WKbGHb5+KnRpo401kVQ156yc/H
 YelqL
X-Gm-Gg: AR+sD12fNdIZmkxQvfIEvFvKc0+b6J0HQjI3H1SS7RDKg2iWKLFIXS04jbZ79zTyXzG
 M/jvrLf2Iqv0lgfRMsysZLosovpmELnJdPbe0uwbQPmFdd6d+3sZnKxG9xX1wZnXeGXEH9x0yyq
 2UIQjCzDA/fidzUz2G1GNpEXCFL7zOFzmfpkMogsu5gIdEReTWvcsfJ8Q/Udn1HbXk9WhJrN8sQ
 onSlcUo8zDoDdp7B81BHaDqCL/KjXOxNsddlkVwUNgwqODhmLVPJD16dSOsR5sQjeuj/mu25BsH
 tSTidiAr8B0jZN24e/r3QfGoRis3W3HzoyIuNr0uYZab1iy2kGZI6i+zeKD8Fw6Com8rpvQYdY7
 96mtGd7Ocp0YWkku28XEWti0RGD3y8FaLqfEqAwUiw8b6osx6Cn4EzetFtBifgljR53ZUW5rH8Z
 K2GrMuYdLFx7jl7tpqCA93r03NuAClUGaknzFyJ9hUp3z0kPJEE9jYvaJt+hMj19B7gZalwn4p3
 KTET+AVa0LD2wsmJn4U
X-Received: by 2002:a05:6a00:3012:b0:845:3fea:96c with SMTP id
 d2e1a72fcca58-84ee4800c6bmr3531776b3a.21.1785602125978; 
 Sat, 01 Aug 2026 09:35:25 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ee1b049e5sm1392819b3a.58.2026.08.01.09.35.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target/i386 patch queue
Date: Sat,  1 Aug 2026 09:35:23 -0700
Message-ID: <20260801163524.62111-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a80:

  Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu into staging (2026-07-31 16:19:04 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-i386-20260801

for you to fetch changes up to c25f69595ad052473463540f4d7944b9b73e94ec:

  target/i386: Update cc_op for SAHF (2026-08-01 09:33:18 -0700)

----------------------------------------------------------------
target/i386: Update cc_op for SAHF

----------------------------------------------------------------
Richard Henderson (1):
      target/i386: Update cc_op for SAHF

 target/i386/tcg/emit.c.inc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

