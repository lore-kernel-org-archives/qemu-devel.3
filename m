Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538C0C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 09:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6nkB-0005Un-1P; Mon, 21 Apr 2025 05:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u6nk6-0005Pn-S9
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 05:47:11 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u6nk3-0000CP-Cn
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 05:47:09 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so2331447a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745228825; x=1745833625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nad+WAcJCv81mPXXpYfzqn0f7wf5xLa/T3oOAxCWsY=;
 b=jSVVjLgKh1will015R5TGGeApglLcnofKZKSwbwnesyQNa3TY1ovmfKVFsgciedz7b
 l31XaivtoTqJyfsMJjq9nT1vapDFSLScpmH92V1+V39u/Jp9CrpcJH8Jhq7/AyglOaOo
 QBvBatQ+eqFF9/x+KauVzG7xNG2REqpMI7MLA5+pZRePNGxYzZQSyCI3tv9tfN1Y+gDK
 HwYM5EBXavpiEvgjdYkaZ22N+RKoJq1vInFwXh/YvDanGwOFYjhZ9IhaWFs3oS/h4805
 kuu37KJQR7AiJfnnZLgT+owZ95HAx1H7U+6lmcqZYaXNFJCyUf5KLTMVBHy96hbuKGPQ
 sbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745228825; x=1745833625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Nad+WAcJCv81mPXXpYfzqn0f7wf5xLa/T3oOAxCWsY=;
 b=k7DNiZgQTDd6xsotwd5VG6YByv+IuPkTafnDgohgJSVUd8neYXioJVwTCeEywcW4LM
 lm8LrqCTd1iDqwhuISwXTJVxqmjIWoXLS3suqM8/WMVcH2GmQeGIBAIusw6qw2O21f9u
 9wex5WZ4PmVvg1FDaUzcq195/3AEGNchUIS92peARDkGU/tBkvXtVSxeaHEor4AQlUNN
 T/akxpasIrRrBjHA7YsaSIbSzxkQzQxjZ6gKqtjvqKQrBRUtOl+PkBJi9DxrWT5Q3RXC
 6QHZQupZ1+VWYNZqukUJuyWLcGhAY+Ao28xEcwTJPirHB+ngWDybREcRtdMUUa+vXUj3
 0xdQ==
X-Gm-Message-State: AOJu0YwWTmlTSKuYOBUAn1HhWlMH2Uk0ZUZYghCGWLpxFuH1TsGd6FQg
 0OpunMwpwcytMs91zeeWQSmS6VpaaIx5lY+4bYUBtNMO0+/4jbTdG/qbpjv+/A4JhbWyQGVye/C
 GuUy9SXGiIOsC1XGJCeipQ611OeuMGqFswaVPo0X8FNlbaT8CN3qufswNjCnydqlHj5lDtyBAb2
 jRc+VJpp/41aKYp841G7WRQiZxE+PcFTC47HjqGggJOA==
X-Gm-Gg: ASbGnct1mxMT8VWvgFzDARESs1KIcmfuvoe8lSLRyasitLSfuFz0pSD0hFWyhwX2uJM
 W4qUmBiiVoOGhtvgazCHy1QgSL6XjOasCbeTXF7IwNPyi/JXsMBLKvVVnQH9lDpXcs0yyGkC/fA
 +etNgR6lYnSHe1vwMfV6nLxKznHL2amj9tz384njvY9Ssj+t+iv3QkIF39xUkM2xXZmjp61cMxx
 pkslIZUDyvTNK4kQ7nnszMiDabwVhR+iVJvVDG15V8dN2xtpO+B48OCGnwaqprq7MG3TUx5dG/g
 OU6vwNiQptrJiKVEOcIPVaTXFukvTC2yc+FFFRBV96R3U1h66PUDSw1fDEPs7dPRTUHVzWKXEWd
 PtkyvLsXWERnBvqY=
X-Google-Smtp-Source: AGHT+IE65yt5yqbPlVvLzXxv9cE7sEYf57l1gkwWZKLACTxA/xl2IMR3SfrU+nhruAF+5KM5efk0Rg==
X-Received: by 2002:a17:90b:2dc6:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-3087bb39b13mr14801794a91.6.1745228824854; 
 Mon, 21 Apr 2025 02:47:04 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([147.161.192.170])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee330bsm6162137a91.3.2025.04.21.02.47.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Apr 2025 02:47:04 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH 0/2] Extend and configure PMP region count
Date: Mon, 21 Apr 2025 17:46:54 +0800
Message-ID: <20250421094656.48997-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The first patch extends the number of PMP regions supported up to 64,
following the RISC-V Privileged Specification (version >1.12), where
RV32 can have up to 64 PMP regions configured through 16 CSRs.

The second patch makes the PMP region count configurable via a new
CPU parameter `num-pmp-regions`. This allows platforms to adjust
the number of PMP regions without relying on a fixed default value.
If unspecified, the default remains 16 to preserve compatibility.

Jay Chang (2):
  target/riscv: Extend PMP region up to 64
  target/riscv: Make PMP region count configurable

 target/riscv/cpu.c      |  46 ++++++++++++++
 target/riscv/cpu.h      |   2 +-
 target/riscv/cpu_bits.h |  60 +++++++++++++++++++
 target/riscv/cpu_cfg.h  |   1 +
 target/riscv/csr.c      | 129 +++++++++++++++++++++++++++++++++++++++-
 target/riscv/machine.c  |   3 +-
 target/riscv/pmp.c      |  28 ++++++---
 7 files changed, 255 insertions(+), 14 deletions(-)

-- 
2.48.1


