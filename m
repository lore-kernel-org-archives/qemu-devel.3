Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE05C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78T-0002tv-Du; Sun, 30 Jun 2024 22:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78R-0002s8-I1
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:19 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78P-0008Va-VX
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7066a3229f4so1371936b3a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802277; x=1720407077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WnwSoeUV3cwlH1+3n2f06XV+qKm4+k7po4qjUIY9IEI=;
 b=GU6aJmSfjO5OPAnmZRKAvdkp1XHKINbasEPBG8zvq1kx/zWBNKvJ0c8x+2s++XK7xC
 9/VHiY1i6wFKbIjyc+mwwtkDUTcSEijjBlbwCt80WeYCWszregz3haI+idlxtOeWfeLN
 Ol7tpLnuDe7X2F2lVI4G1f4l4ZD/ZbjN+t1J6mTzyf/bIcBUcV77GEzYF9muzHxo36EZ
 /kTai/xQ9Id2V2ZVbS0RtGl0L5TUEurFDM1J9mdfpDPrFZufsM+wB4U3bs/DGUf4c0g1
 5jioqk4i0CJuzRmpKK31Tll9/wL0XgQYFAAdTfhtQDYG7FQAu6Fje5OOPNHdGrxzvAG5
 2zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802277; x=1720407077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnwSoeUV3cwlH1+3n2f06XV+qKm4+k7po4qjUIY9IEI=;
 b=im8NpAEhp+/ylIX2IR7YBbJ14qQgVQJwWjVbtb3OiL1DfCW+uWg5XCiAmPBOqhOjcS
 8mw72uUpr36NVwckTm5l+n+YkEHfjlUY0ItTJN9px8imhIsqefvfOyCFYeFiWaOdJ93X
 u51k1pssloAp2aM+kCuYULnpZy7lbWYEqUBUQFxtVr0zrTCsTqLGNjJeH2DbwNVcss98
 x8s7iIVmbv6NmtlFCZUMI9QzQWvhQ+r5ba26qmUdWVD6RKCUFZ8pk3XdniqAJN3w2sdj
 wZQbvoTmVxd128EcytABu0bWrY7m/m0yDZUny6qVkTQrd2Raurge2J2Nt9RQDwi+UTZC
 oKqw==
X-Gm-Message-State: AOJu0Yy3Vi3wEWKOWz+PCquuTJMAbgs3AmkHKoLKuoLBXMC+P4Xnx/y1
 xpXC0IGGb/4/6IxSy2lVFplSPiQ5CAnnpnXUghI6cUYzIyfX28O+oF1eq8lGuCb2IqKvlGuW1yP
 S
X-Google-Smtp-Source: AGHT+IFjJ37anIm7yAEdIEqQi+d2Fp76TRr/IW9BRyUDOntV6ZD+eiHwbDhz3r05ZdSboCJWbneG9w==
X-Received: by 2002:a05:6a20:ce4d:b0:1be:c65c:1e32 with SMTP id
 adf61e73a8af0-1bef621edadmr3134198637.51.1719802276453; 
 Sun, 30 Jun 2024 19:51:16 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 0/5] target/i386: CCOp cleanups
Date: Sun, 30 Jun 2024 19:51:10 -0700
Message-Id: <20240701025115.1265117-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

While debugging #2413, I spent quite a bit of time trying to work
out if the CCOp value was incorrect.  I think the following is a
worthwhile cleanup, isolating potential problems to asserts.


r~


Richard Henderson (5):
  target/i386: Tidy cc_op_str usage
  target/i386: Convert cc_op_live to a function
  target/i386: Rearrange CCOp
  target/i386: Remove default in cc_op_live
  target/i386: Introduce cc_op_size

 target/i386/cpu.h                | 44 +++++++++--------
 target/i386/cpu-dump.c           | 17 ++++---
 target/i386/tcg/translate.c      | 84 +++++++++++++++++++-------------
 target/i386/tcg/decode-new.c.inc |  2 +-
 target/i386/tcg/emit.c.inc       |  9 ++--
 5 files changed, 93 insertions(+), 63 deletions(-)

-- 
2.34.1


