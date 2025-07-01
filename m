Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66222C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 03:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWREf-00009W-9E; Mon, 30 Jun 2025 23:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREd-00008q-AF
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uWREX-0003RU-Mp
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:00:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23636167b30so24531355ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751338831; x=1751943631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXt4Jrv087bIm45/0i+HVz4emArqdBrfNkEJHVcdbto=;
 b=Q3LuMaJZ6MSGBaPsuujHNLKV/yOjUmPDHR7Chr1fM7JX2HDBxpHWV/XQtUemPc/FVt
 TtQfwSLp3qHsms0E7PbxUcY5KzOtusdTbnPrFdX0blz3oO3L99AVSBIQlCDYr+gfAgHN
 /o3oyg40Q0EbbUdTvH6UwvuaqaXJ3csDsbSe5PkxX0NekX/+0MizrbQ25exxWDGUEOrw
 h2tP9rvnR8Xtdd4upHpJy7E9EoLrFDJdjlZhSFwTARn0jf+brRQmbNcNX/XpmUcQrUmA
 73v11VaOZvpiYWJ5V6IFX97zijVyOYP7H8zBRSp40RTSm213rvSHYhKonzFKZQVSgvs9
 mjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751338831; x=1751943631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXt4Jrv087bIm45/0i+HVz4emArqdBrfNkEJHVcdbto=;
 b=kzyfUNZfp032HYLovx8R1JodTPCtGO7cdJ/fLypY9qMNDcSvmdUe3HpsK9oNfHJtjj
 VSPWT+aqMOtrzGTUpN9x2h1tgzjepjqqLkvMQCW9t53qVek+q1lEK8S4L/pKzai77IJq
 J0/hSDBWhdHF74PEqoQrN3kz7f9sDqti1V8Jt4g/aAUx5w0jMY/dA3qj7BCokPac9cVb
 mv7ZDqwnm4d8VKcHVY5viEaRjPlP0/yfVQGGl8dzUjY4edfagcMLblsDMUBNE37fhzai
 1MWX0FPwvvvyVsEKtaDlgzAou+G46gYZtFfZ7YWWcthlnVZyH+zKsg1A5Zn9yd/MTBJQ
 yR0Q==
X-Gm-Message-State: AOJu0YxUglHdYSs8SOAOtnf3Roi+AqJSN15cwuJSzC1/exhgACHe66+F
 TC9vHf8C+AqFIjeNJXA990hCFAewv16CIFefDfe5ueBNs1p8AbKCMlFFAuhWLHzQIt6x54bWmEs
 ozYxr4GGI+AURb7Q9bO/4Gnls3X3ZU7FUWep8dlASdg5tHw9gECTvTsanNeS89o5VRtINnRsJ7g
 wfVzRjSwIVaTiYinZTzyEthSQ/C+qB1qfQmLq3xAp3jUw=
X-Gm-Gg: ASbGncu9NtfWhA9ilp0C0b6HcisvIBym+cP0l6E0NsMbYJGiFM/pHrSXWr/ROaN4yby
 GVauZGeK1Wg1NeAI1HbHc5XvJ1F3phe6jxMLxELz/0z5/KuOAphrvNUSW6MH2jbpVKc9rfuyiU3
 TJerp7SI4Dhkm8OV9XoOfXg09WUd3AZgUCMYjafO6ZDRaihEsn3W1XRyWnhRBQ0jGxfSqgKGYkq
 P0prIzLLQ7t1oepZBrVQ6zJRrF9Eb4KNuO7l+9fy4SATZhX+fMYxjX3Ye27NUnTqsRqvtZHNj66
 RQDjTqUui9E+cr0EAxZvqqY53QIUmrL5pgshBdMoKYZ+jCWZJ3nqvZO8/HSQpI3tYKhL23rEwO/
 e3uKTCu0a8myFsPbkEHAjCwiNnA==
X-Google-Smtp-Source: AGHT+IHgxBzRwXqaP1mYhaaxp7WMQkXDJ2L16++zC/XXQMfio9mq/cTkrgtVKTXPcw2oiDotHOkOIg==
X-Received: by 2002:a17:902:db07:b0:234:ef42:5d48 with SMTP id
 d9443c01a7336-23ac4634b8emr257547185ad.38.1751338830952; 
 Mon, 30 Jun 2025 20:00:30 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3bf1f6sm95966565ad.204.2025.06.30.20.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 20:00:30 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 1/2] target/riscv: Restrict mideleg/medeleg/medelegh access
 to S-mode harts
Date: Tue,  1 Jul 2025 11:00:20 +0800
Message-ID: <20250701030021.99218-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701030021.99218-1-jay.chang@sifive.com>
References: <20250701030021.99218-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62e.google.com
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

RISC-V Privileged Spec states:
"In harts with S-mode, the medeleg and mideleg registers must exist, and
setting a bit in medeleg or mideleg will delegate the corresponding trap
, when occurring in S-mode or U-mode, to the S-mode trap handler. In
harts without S-mode, the medeleg and mideleg registers should not
exist."

Add smode predicate to ensure these CSRs are only accessible when S-mode
is supported.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/csr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6296ecd1e1..0e0ad37654 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5862,8 +5862,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                           NULL,                read_mstatus_i128           },
     [CSR_MISA]        = { "misa",       any,   read_misa,    write_misa,
                           NULL,                read_misa_i128              },
-    [CSR_MIDELEG]     = { "mideleg",    any,   NULL, NULL,   rmw_mideleg   },
-    [CSR_MEDELEG]     = { "medeleg",    any,   read_medeleg, write_medeleg },
+    [CSR_MIDELEG]     = { "mideleg",    smode,   NULL, NULL,   rmw_mideleg   },
+    [CSR_MEDELEG]     = { "medeleg",    smode,   read_medeleg, write_medeleg },
     [CSR_MIE]         = { "mie",        any,   NULL, NULL,   rmw_mie       },
     [CSR_MTVEC]       = { "mtvec",      any,   read_mtvec,   write_mtvec   },
     [CSR_MCOUNTEREN]  = { "mcounteren", umode, read_mcounteren,
@@ -5871,7 +5871,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
-    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+    [CSR_MEDELEGH]    = { "medelegh",   smode32, read_zero, write_ignore,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
     [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
                           .min_priv_ver = PRIV_VERSION_1_13_0              },
-- 
2.48.1


